Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A15F03316B6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Mar 2021 19:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhCHSym (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Mar 2021 13:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbhCHSyL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Mar 2021 13:54:11 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C23C06175F;
        Mon,  8 Mar 2021 10:54:11 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id B366F35BD; Mon,  8 Mar 2021 13:54:10 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org B366F35BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1615229650;
        bh=xDgC7LlBmjqCSWF7ziP8dFyfWdwiA7a0Sh7MAb3vsSg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ij/YmN4ZebdMPqxxrBDuGYwtre8S0qs40MfCHLhqodetYSoxXMe9aE04WgC/4Q1DR
         20zcySXbv0GKk83IdR8F8zJJRdgLSvUXs5DXB8A6ipkmjqtANNIA8X5KWjQ7wad9Xl
         DoQOtJQEB0D4j4ThsTeLw2m/ax39UkOlyflJq14o=
Date:   Mon, 8 Mar 2021 13:54:10 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-cachefs@redhat.com,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <dchinner@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-afs@lists.infradead.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: fscache: Redesigning the on-disk cache
Message-ID: <20210308185410.GE7284@fieldses.org>
References: <CAOQ4uxhxwKHLT559f8v5aFTheKgPUndzGufg0E58rkEqa9oQ3Q@mail.gmail.com>
 <2653261.1614813611@warthog.procyon.org.uk>
 <517184.1615194835@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <517184.1615194835@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 08, 2021 at 09:13:55AM +0000, David Howells wrote:
> Amir Goldstein <amir73il@gmail.com> wrote:
> > With ->fiemap() you can at least make the distinction between a non existing
> > and an UNWRITTEN extent.
> 
> I can't use that for XFS, Ext4 or btrfs, I suspect.  Christoph and Dave's
> assertion is that the cache can't rely on the backing filesystem's metadata
> because these can arbitrarily insert or remove blocks of zeros to bridge or
> split extents.

Could you instead make some sort of explicit contract with the
filesystem?  Maybe you'd flag it at mkfs time and query for it before
allowing a filesystem to be used for fscache.  You don't need every
filesystem to support fscache, right, just one acceptable one?

--b.
