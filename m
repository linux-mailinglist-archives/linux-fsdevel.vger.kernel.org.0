Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11E0E17D435
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Mar 2020 15:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgCHOch (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Mar 2020 10:32:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:51088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbgCHOcg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Mar 2020 10:32:36 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52CF720848;
        Sun,  8 Mar 2020 14:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583677956;
        bh=tSJSpSnJtqOKsizi3MhYYRytrtTLb6EioI5Eke+POK0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=P69927BQ2i9zgjdGUH3dzPYoejOXJMHbK43Z5k3uvlrfDNevEbvqg+brPT3CAn7Cj
         ZEwn9Y/8B1amn+V6gW1AkSCeq4fB/YTi7HlDtVOw+KPe5tLpsTKF+8jrlJ0mqXeWFQ
         UVLG9AcfQ+Z/n4B3KCujs2AP7vXyjn0bXy/VswBw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 213F535226BD; Sun,  8 Mar 2020 07:32:36 -0700 (PDT)
Date:   Sun, 8 Mar 2020 07:32:36 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     David Howells <dhowells@redhat.com>, mszeredi@redhat.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: How to abuse RCU to scan the children of a mount?
Message-ID: <20200308143236.GB2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <3173159.1583343916@warthog.procyon.org.uk>
 <20200304192816.GI2935@paulmck-ThinkPad-P72>
 <20200304194451.GS23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304194451.GS23230@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 04, 2020 at 07:44:51PM +0000, Al Viro wrote:
> On Wed, Mar 04, 2020 at 11:28:16AM -0800, Paul E. McKenney wrote:
> 
> > Huh.  The mount structure isn't suffering from a shortage of list_head
> > structures, is it?
> > 
> > So the following can happen, then?
> > 
> > o	The __attach_mnt() function adds a struct mount to its parent
> > 	list, but in a non-RCU manner.	Unless there is some other
> > 	safeguard, the list_add_tail() in this function needs to be
> > 	list_add_tail_rcu().
> > 
> > o	I am assuming that the various non-RCU traversals that I see,
> > 	for example, next_mnt(), are protected by lock_mount_hash().
> > 	Especially skip_mnt_tree(), which uses mnt_mounts.prev.  (I didn't
> > 	find any exceptions, but I don't claim an exhaustive search.)
> > 
> > o	The umount_tree() function's use of list_del_init() looks like
> > 	it could trap an RCU reader in the newly singular list formed
> > 	by the removal.  It appears that there are other functions that
> > 	use list_del_init() on this list, though I cannot claim any sort
> > 	of familiarity with this code.
> > 
> > 	So, do you need to add a check for child->mnt_child being in this
> > 	self-referential state within fsinfo_generic_mount_children()?
> > 
> > 	Plus list_del_init() doesn't mark its stores, though
> > 	some would argue that unmarked stores are OK in this situation.
> > 
> > o	There might be other operations in need of RCU-ification.
> > 
> > 	Maybe the list_add_tail() in umount_tree(), but it is not
> > 	immediately clear that this is adding a new element instead of
> > 	re-inserting an element already exposed to readers.
> 
> IMO all of that is a good argument *against* trying to pull any kind of RCU
> games here.  Access to these lists is assumed to be serialized on
> mount_lock spinlock component held exclusive and unless there is a very
> good reason to go for something trickier, let's not.
> 
> Hash chains are supposed to be walked under rcu_read_lock(), requiring
> to recheck the mount_lock seqcount *AND* with use of legitimize_mnt()
> if you are to try and get a reference out of that.  ->mnt_parent chains
> also can be walked in the same conditions (subject to the same
> requirements).  The policy with everything else is
> 	* get mount_lock spinlock exclusive or
> 	* get namespace_sem or
> 	* just fucking don't do it.

I have no idea what David's performance requirements are.  But yes,
of course, if locking suffices, use locking, be happy, and get on with
your life.

It looks like David would otherwise have been gathering information
while holding some sort of lock (as you say above), then releasing that
lock before actually using the gathered information.  Therefore, should
it turns out that locking is to slow does not suffice for David's use
case, and if the issues I identified above disqualify RCU (which would
be unsurprising, especially given that the above is unlikely to be an
exhaustive list), then another option is to maintain a separate data
structure that keeps the needed information.  When the mounts change,
the next lookup would grab the needed locks and regenerate this separate
data structure.  Otherwise, just do lookup in the separate data structure.

But again, if just locking and traversing the main data structure
suffices, agreed, just do that, be happy, and get on with life.

							Thanx, Paul
