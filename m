Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E7D492139
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 09:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344562AbiARI3U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 03:29:20 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:46398 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344364AbiARI3R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 03:29:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17D16613F9;
        Tue, 18 Jan 2022 08:29:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46AF6C340E4;
        Tue, 18 Jan 2022 08:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642494556;
        bh=RAQ8U6MFEu51ITZP1wP47dn7g6hCRWOKwdwVbfE6DKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cNXthNkVcBk1bNhH1Xj0Fzri4j4JnM6FdfS61Eg79P6SNmA+esMC0Y4ygPJTzCP2/
         uyaj/rLV21w4LJL6hF1NXC31+dnd9Llb29CoDSNWOyLXjg9Ezuvmh2WtxUhrN+n2pK
         ALkPL2Ha6xE49ouHZkI5H5tIhvlr/nqRpR6/kGb24fg47K3GZ+NYJSohMIiySlMLGL
         wsDEY5n2NxvUWzj70P2B1X8viAujg7n6LeyzTSrZ8V0Xez2x/hbSUP4M91Sfxt85wM
         FxvHOKRZx4jJrbbxRE/SSPx765FPbM9WeHqxI4IVsxDJHoe6Z4A9PCpWkrnWSo7lEl
         RrNKW57V+r43A==
Date:   Tue, 18 Jan 2022 09:29:11 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Brian Foster <bfoster@redhat.com>, Ian Kent <raven@themaw.net>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] vfs: check dentry is still valid in get_link()
Message-ID: <20220118082911.rsmv5m2pjeyt6wpg@wittgenstein>
References: <164180589176.86426.501271559065590169.stgit@mickey.themaw.net>
 <YeJr7/E+9stwEb3t@zeniv-ca.linux.org.uk>
 <275358741c4ee64b5e4e008d514876ed4ec1071c.camel@themaw.net>
 <YeV+zseKGNqnSuKR@bfoster>
 <YeWZRL88KPtLWlkI@zeniv-ca.linux.org.uk>
 <YeWxHPDbdSfBDtyX@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YeWxHPDbdSfBDtyX@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 17, 2022 at 06:10:36PM +0000, Al Viro wrote:
> On Mon, Jan 17, 2022 at 04:28:52PM +0000, Al Viro wrote:
> 
> > IOW, ->free_inode() is RCU-delayed part of ->destroy_inode().  If both
> > are present, ->destroy_inode() will be called synchronously, followed
> > by ->free_inode() from RCU callback, so you can have both - moving just
> > the "finally mark for reuse" part into ->free_inode() would be OK.
> > Any blocking stuff (if any) can be left in ->destroy_inode()...
> 
> BTW, we *do* have a problem with ext4 fast symlinks.  Pathwalk assumes that
> strings it parses are not changing under it.  There are rather delicate
> dances in dcache lookups re possibility of ->d_name contents changing under
> it, but the search key is assumed to be stable.
> 
> What's more, there's a correctness issue even if we do not oops.  Currently
> we do not recheck ->d_seq of symlink dentry when we dismiss the symlink from
> the stack.  After all, we'd just finished traversing what used to be the
> contents of a symlink that used to be in the right place.  It might have been
> unlinked while we'd been traversing it, but that's not a correctness issue.
> 
> But that critically depends upon the contents not getting mangled.  If it
> *can* be screwed by such unlink, we risk successful lookup leading to the

Out of curiosity: whether or not it can get mangled depends on the
filesystem and how it implements fast symlinks or do fast symlinks
currently guarantee that contents are mangled?
