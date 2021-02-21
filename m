Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C45A8320D6E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Feb 2021 21:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhBUULH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Feb 2021 15:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbhBUULF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Feb 2021 15:11:05 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EFEC06178B;
        Sun, 21 Feb 2021 12:10:25 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 07C0028E5; Sun, 21 Feb 2021 15:10:24 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 07C0028E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1613938224;
        bh=7ZYHvlz2PyOH+1LBos+UH4lABWNPQ4hE/eJx23H2AVM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kdABrIaGwL/eI3jBD++XWajauPoawwiH8JbrZft3T7k7FePF3rPxit/zoYPW4uf2h
         YuMiE/3N0vVZ8FPaSCS8oeetn9bXRnhBEMjIXkzteBypIY/tCbsG6nT9guQeyZ1/08
         m987d5kdmNjfkDNQmrWTE6pBJmPrPkZP+RGSrQpQ=
Date:   Sun, 21 Feb 2021 15:10:24 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Luo Longjun <luolongjun@huawei.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        sangyan@huawei.com, luchunhua@huawei.com
Subject: Re: [PATCH] fs/locks: print full locks information
Message-ID: <20210221201024.GB15975@fieldses.org>
References: <20210220063250.742164-1-luolongjun@huawei.com>
 <YDKP0XdT1TVOaGnj@zeniv-ca.linux.org.uk>
 <b76672d52ffe498259181688eaf54ec75be449e8.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b76672d52ffe498259181688eaf54ec75be449e8.camel@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Feb 21, 2021 at 01:43:03PM -0500, Jeff Layton wrote:
> On Sun, 2021-02-21 at 16:52 +0000, Al Viro wrote:
> > On Sat, Feb 20, 2021 at 01:32:50AM -0500, Luo Longjun wrote:
> > > +	list_for_each_entry(bfl, &fl->fl_blocked_requests, fl_blocked_member)
> > > +		__locks_show(f, bfl, level + 1);
> > 
> > Er...  What's the maximal depth, again?  Kernel stack is very much finite...
> 
> Ooof, good point. I don't think there is a maximal depth on the tree
> itself. If you do want to do something like this, then you'd need to
> impose a hard limit on the recursion somehow.

I think all you need to do is something like: follow the first entry of
fl_blocked_requests, printing as you go, until you get down to lock with
empty fl_blocked_requests (a leaf of the tree).  When you get to a leaf,
print, then follow fl_blocker back up and look for your parent's next
sibling on its fl_blocked_requests list.  If there are no more siblings,
continue up to your grandparent, etc.

It's the traverse-a-maze-by-always-turning-left algorithm applied to a
tree.  I think we do it elsewhere in the VFS.

You also need an integer that keeps track of your current indent depth.
But you don't need a stack.

?

--b.
