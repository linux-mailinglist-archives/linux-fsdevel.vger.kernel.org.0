Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D581D1E97C8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 May 2020 15:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgEaNJh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 31 May 2020 09:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgEaNJf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 31 May 2020 09:09:35 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8EFC061A0E;
        Sun, 31 May 2020 06:09:34 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jfNiO-000uIq-Qk; Sun, 31 May 2020 13:09:24 +0000
Date:   Sun, 31 May 2020 14:09:24 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/27] vfs, afs, ext4: Make the inode hash table RCU
 searchable
Message-ID: <20200531130924.GY23230@ZenIV.linux.org.uk>
References: <159078959973.679399.15496997680826127470.stgit@warthog.procyon.org.uk>
 <159078960778.679399.5682252853189947919.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159078960778.679399.5682252853189947919.stgit@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 29, 2020 at 11:00:07PM +0100, David Howells wrote:

> @@ -1245,15 +1282,9 @@ static int test_inode_iunique(struct super_block *sb, unsigned long ino)
>  	struct inode *inode;
>  
>  	spin_lock(&inode_hash_lock);
> -	hlist_for_each_entry(inode, b, i_hash) {
> -		if (inode->i_ino == ino && inode->i_sb == sb) {
> -			spin_unlock(&inode_hash_lock);
> -			return 0;
> -		}
> -	}
> +	inode = __find_inode_by_ino_rcu(sb, b, ino);
>  	spin_unlock(&inode_hash_lock);
> -
> -	return 1;
> +	return inode ? 0 : 1;
>  }

Nit: that's really return !inode

> +/**
> + * find_inode_rcu - find an inode in the inode cache
> + * @sb:		Super block of file system to search
> + * @hashval:	Key to hash
> + * @test:	Function to test match on an inode
> + * @data:	Data for test function
> + *
> + * Search for the inode specified by @hashval and @data in the inode cache,
> + * where the helper function @test will return 0 if the inode does not match
> + * and 1 if it does.  The @test function must be responsible for taking the
> + * i_lock spin_lock and checking i_state for an inode being freed or being
> + * initialized.
> + *
> + * If successful, this will return the inode for which the @test function
> + * returned 1 and NULL otherwise.
> + *
> + * The @test function is not permitted to take a ref on any inode presented
> + * unless the caller is holding the inode hashtable lock.  It is also not
> + * permitted to sleep, since it may be called with the RCU read lock held.
> + *
> + * The caller must hold either the RCU read lock or the inode hashtable lock.

Just how could that caller be holding inode_hash_lock?  It's static and IMO
should remain such - it's too low-level detail of fs/inode.c for having the
code outside play with it.

Require the caller to hold rcu_read_lock() and make "not permitted to take
a ref or sleep" unconditional.

> +struct inode *find_inode_rcu(struct super_block *sb, unsigned long hashval,
> +			     int (*test)(struct inode *, void *), void *data)
> +{
> +	struct hlist_head *head = inode_hashtable + hash(sb, hashval);
> +	struct inode *inode;
> +
> +	RCU_LOCKDEP_WARN(!lockdep_is_held(&inode_hash_lock) && !rcu_read_lock_held(),
> +			 "suspicious find_inode_by_ino_rcu() usage");

... and modify that RCU_LOCKDEP_WARN (including the function name, preferably ;-)

> +
> +	hlist_for_each_entry_rcu(inode, head, i_hash) {
> +		if (inode->i_sb == sb &&
> +		    !(READ_ONCE(inode->i_state) & (I_FREEING | I_WILL_FREE)) &&
> +		    test(inode, data))
> +			return inode;
> +	}
> +	return NULL;
> +}
> +EXPORT_SYMBOL(find_inode_rcu);
> +
> +/**
> + * find_inode_by_rcu - Find an inode in the inode cache
> + * @sb:		Super block of file system to search
> + * @ino:	The inode number to match
> + *
> + * Search for the inode specified by @hashval and @data in the inode cache,
> + * where the helper function @test will return 0 if the inode does not match
> + * and 1 if it does.  The @test function must be responsible for taking the
> + * i_lock spin_lock and checking i_state for an inode being freed or being
> + * initialized.
> + *
> + * If successful, this will return the inode for which the @test function
> + * returned 1 and NULL otherwise.
> + *
> + * The @test function is not permitted to take a ref on any inode presented
> + * unless the caller is holding the inode hashtable lock.  It is also not
> + * permitted to sleep, since it may be called with the RCU read lock held.
> + *
> + * The caller must hold either the RCU read lock or the inode hashtable lock.
> + */

Ditto.

> +struct inode *find_inode_by_ino_rcu(struct super_block *sb,
> +				    unsigned long ino)
> +{
> +	struct hlist_head *head = inode_hashtable + hash(sb, ino);
> +	struct inode *inode;
> +
> +	RCU_LOCKDEP_WARN(!lockdep_is_held(&inode_hash_lock) && !rcu_read_lock_held(),
> +			 "suspicious find_inode_by_ino_rcu() usage");
> +
> +	hlist_for_each_entry_rcu(inode, head, i_hash) {
> +		if (inode->i_ino == ino &&
> +		    inode->i_sb == sb &&
> +		    !(READ_ONCE(inode->i_state) & (I_FREEING | I_WILL_FREE)))
> +		    return inode;
> +	}
> +	return NULL;
> +}
> +EXPORT_SYMBOL(find_inode_by_ino_rcu);

> @@ -1540,6 +1652,7 @@ static void iput_final(struct inode *inode)
>  {
>  	struct super_block *sb = inode->i_sb;
>  	const struct super_operations *op = inode->i_sb->s_op;
> +	unsigned long state;
>  	int drop;
>  
>  	WARN_ON(inode->i_state & I_NEW);
> @@ -1555,16 +1668,20 @@ static void iput_final(struct inode *inode)
>  		return;
>  	}
>  
> +	state = READ_ONCE(inode->i_state);
>  	if (!drop) {
> -		inode->i_state |= I_WILL_FREE;
> +		WRITE_ONCE(inode->i_state, state | I_WILL_FREE);
>  		spin_unlock(&inode->i_lock);
> +
>  		write_inode_now(inode, 1);
> +
>  		spin_lock(&inode->i_lock);
> -		WARN_ON(inode->i_state & I_NEW);
> -		inode->i_state &= ~I_WILL_FREE;
> +		state = READ_ONCE(inode->i_state);
> +		WARN_ON(state & I_NEW);
> +		state &= ~I_WILL_FREE;
>  	}
>  
> -	inode->i_state |= I_FREEING;
> +	WRITE_ONCE(inode->i_state, state | I_FREEING);
>  	if (!list_empty(&inode->i_lru))
>  		inode_lru_list_del(inode);
>  	spin_unlock(&inode->i_lock);

Umm..  I see the point of those WRITE_ONCE, but what's READ_ONCE for?
