Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 430CE5B2AB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 03:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfGABIu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jun 2019 21:08:50 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:52076 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfGABIu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jun 2019 21:08:50 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hhkoK-0006TJ-1u; Mon, 01 Jul 2019 01:08:48 +0000
Date:   Mon, 1 Jul 2019 02:08:48 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] vfs: move_mount: reject moving kernel internal mounts
Message-ID: <20190701010847.GA23778@ZenIV.linux.org.uk>
References: <CACT4Y+ZN8CZq7L1GQANr25extEqPASRERGVh+sD4-55cvWPOSg@mail.gmail.com>
 <20190629202744.12396-1-ebiggers@kernel.org>
 <20190629203916.GV17978@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190629203916.GV17978@ZenIV.linux.org.uk>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 29, 2019 at 09:39:16PM +0100, Al Viro wrote:
> On Sat, Jun 29, 2019 at 01:27:44PM -0700, Eric Biggers wrote:
> 
> > @@ -2600,7 +2600,7 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
> >  	if (attached && !check_mnt(old))
> >  		goto out;
> >  
> > -	if (!attached && !(ns && is_anon_ns(ns)))
> > +	if (!attached && !(ns && ns != MNT_NS_INTERNAL && is_anon_ns(ns)))
> >  		goto out;
> >  
> >  	if (old->mnt.mnt_flags & MNT_LOCKED)
> 
> *UGH*
> 
> Applied, but that code is getting really ugly ;-/

FWIW, it's too ugly and confusing.  Look:
        /* The mountpoint must be in our namespace. */
        if (!check_mnt(p))
                goto out;

        /* The thing moved should be either ours or completely unattached. */
        if (attached && !check_mnt(old))
                goto out;

        if (!attached && !(ns && ns != MNT_NS_INTERNAL && is_anon_ns(ns)))
                goto out;

OK, the first check is sane and understandable.  But let's look at what's
coming after it.  We have two cases:
	1) attached.  IOW, old->mnt_parent != old.  In that case we
require old->mnt_ns == current mnt_ns.  Anything else is rejected.
	2) !attached.  old->mnt_parent == old.  In that case we
require old->mnt_ns to be an anon namespace.

Let's reorder that a bit:
        /* The mountpoint must be in our namespace. */
        if (!check_mnt(p))
                goto out;

	/* The thing moved must be mounted... */
	if (!is_mounted(old_path->mnt))
		goto out;

        /* ... and either ours or the root of anon namespace */
	if (!(attached ? check_mnt(old) : is_anon_ns(ns)))
		goto out;

IMO that looks saner and all it costs us is a redundant check
in attached case.  Objections?
