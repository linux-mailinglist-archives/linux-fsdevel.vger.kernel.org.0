Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D69D179927
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 20:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbgCDToz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 14:44:55 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:33884 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728614AbgCDToz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 14:44:55 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9Zwp-005Lwh-P2; Wed, 04 Mar 2020 19:44:51 +0000
Date:   Wed, 4 Mar 2020 19:44:51 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     David Howells <dhowells@redhat.com>, mszeredi@redhat.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: How to abuse RCU to scan the children of a mount?
Message-ID: <20200304194451.GS23230@ZenIV.linux.org.uk>
References: <3173159.1583343916@warthog.procyon.org.uk>
 <20200304192816.GI2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304192816.GI2935@paulmck-ThinkPad-P72>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 04, 2020 at 11:28:16AM -0800, Paul E. McKenney wrote:

> Huh.  The mount structure isn't suffering from a shortage of list_head
> structures, is it?
> 
> So the following can happen, then?
> 
> o	The __attach_mnt() function adds a struct mount to its parent
> 	list, but in a non-RCU manner.	Unless there is some other
> 	safeguard, the list_add_tail() in this function needs to be
> 	list_add_tail_rcu().
> 
> o	I am assuming that the various non-RCU traversals that I see,
> 	for example, next_mnt(), are protected by lock_mount_hash().
> 	Especially skip_mnt_tree(), which uses mnt_mounts.prev.  (I didn't
> 	find any exceptions, but I don't claim an exhaustive search.)
> 
> o	The umount_tree() function's use of list_del_init() looks like
> 	it could trap an RCU reader in the newly singular list formed
> 	by the removal.  It appears that there are other functions that
> 	use list_del_init() on this list, though I cannot claim any sort
> 	of familiarity with this code.
> 
> 	So, do you need to add a check for child->mnt_child being in this
> 	self-referential state within fsinfo_generic_mount_children()?
> 
> 	Plus list_del_init() doesn't mark its stores, though
> 	some would argue that unmarked stores are OK in this situation.
> 
> o	There might be other operations in need of RCU-ification.
> 
> 	Maybe the list_add_tail() in umount_tree(), but it is not
> 	immediately clear that this is adding a new element instead of
> 	re-inserting an element already exposed to readers.

IMO all of that is a good argument *against* trying to pull any kind of RCU
games here.  Access to these lists is assumed to be serialized on
mount_lock spinlock component held exclusive and unless there is a very
good reason to go for something trickier, let's not.

Hash chains are supposed to be walked under rcu_read_lock(), requiring
to recheck the mount_lock seqcount *AND* with use of legitimize_mnt()
if you are to try and get a reference out of that.  ->mnt_parent chains
also can be walked in the same conditions (subject to the same
requirements).  The policy with everything else is
	* get mount_lock spinlock exclusive or
	* get namespace_sem or
	* just fucking don't do it.
