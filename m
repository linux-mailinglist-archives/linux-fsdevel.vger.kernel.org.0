Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B964F1DD2F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 May 2020 18:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgEUQTB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 May 2020 12:19:01 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:34998 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728339AbgEUQTB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 May 2020 12:19:01 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 6E47D2E15C3;
        Thu, 21 May 2020 19:18:51 +0300 (MSK)
Received: from iva8-88b7aa9dc799.qloud-c.yandex.net (iva8-88b7aa9dc799.qloud-c.yandex.net [2a02:6b8:c0c:77a0:0:640:88b7:aa9d])
        by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id kh9qBvqkCl-Io2mAhta;
        Thu, 21 May 2020 19:18:51 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1590077931; bh=3/fXS1yZELVqHOjMWUYQF7xXfk0B8q3bTrAmKQd4YFk=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=c64liwodnEQMeDtV3WXaCeBiL8yQO99nQ5c9AraJ2u5oAvVI9M0txxWOxxHAnyqJD
         4qgIQ+LRuRTpnnaBHBSzBZzORBi5c9Y/daq7fLfCj/6utwRoXua/D+VAu6hT9LYIMG
         3C05/e7NNhL5iIeJd7tSLbGBc0j7/RYi8xjHy3JE=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b080:8116::1:9])
        by iva8-88b7aa9dc799.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id F13RJleyjN-InX8CdkF;
        Thu, 21 May 2020 19:18:50 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH] vfs, afs, ext4: Make the inode hash table RCU searchable
To:     David Howells <dhowells@redhat.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-afs@lists.infradead.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <195849.1590075556@warthog.procyon.org.uk>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <8ac18259-ad47-5617-fa01-fba88349b82d@yandex-team.ru>
Date:   Thu, 21 May 2020 19:18:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <195849.1590075556@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 21/05/2020 18.39, David Howells wrote:
> Hi Ted, Andreas, Konstantin,
> 
> Is this something that would be of interest to Ext4?

For now, I've plugged this issue with try-lock in ext4 lazy time update.
This solution is much better.

I guess next step is rcu-protected fast-path in iget_locked()?
(for scalable open_by_handle_at and nfs exports)

> 
> David
> ---
> vfs, afs, ext4: Make the inode hash table RCU searchable
> 
> Make the inode hash table RCU searchable so that searches that want to
> access or modify an inode without taking a ref on that inode can do so
> without taking the inode hash table lock.
> 
> The main thing this requires is some RCU annotation on the list
> manipulation operations.  Inodes are already freed by RCU in most cases.
> 
> Users of this interface must take care as the inode may be still under
> construction or may be being torn down around them.
> 
> There are at least two instances where this can be of use:
> 
>   (1) Ext4 date stamp updating.
> 
>   (2) AFS callback breaking.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> cc: linux-ext4@vger.kernel.org
> ---
>   fs/afs/callback.c  |   12 ++-
>   fs/ext4/inode.c    |   44 ++++++-------
>   fs/inode.c         |  173 ++++++++++++++++++++++++++++++++++++++++++++---------
>   include/linux/fs.h |    3
>   4 files changed, 179 insertions(+), 53 deletions(-)
> 
> diff --git a/fs/afs/callback.c b/fs/afs/callback.c
> index 2dca8df1a18d..0dcbd40732d1 100644
> --- a/fs/afs/callback.c
> +++ b/fs/afs/callback.c
> @@ -252,6 +252,7 @@ static void afs_break_one_callback(struct afs_server *server,
>   	struct afs_vnode *vnode;
>   	struct inode *inode;
>   
> +	rcu_read_lock();
>   	read_lock(&server->cb_break_lock);
>   	hlist_for_each_entry(vi, &server->cb_volumes, srv_link) {
>   		if (vi->vid < fid->vid)
> @@ -287,12 +288,16 @@ static void afs_break_one_callback(struct afs_server *server,
>   		} else {
>   			data.volume = NULL;
>   			data.fid = *fid;
> -			inode = ilookup5_nowait(cbi->sb, fid->vnode,
> -						afs_iget5_test, &data);
> +
> +			/* See if we can find a matching inode - even an I_NEW
> +			 * inode needs to be marked as it can have its callback
> +			 * broken before we finish setting up the local inode.
> +			 */
> +			inode = find_inode_rcu(cbi->sb, fid->vnode,
> +					       afs_iget5_test, &data);
>   			if (inode) {
>   				vnode = AFS_FS_I(inode);
>   				afs_break_callback(vnode, afs_cb_break_for_callback);
> -				iput(inode);
>   			} else {
>   				trace_afs_cb_miss(fid, afs_cb_break_for_callback);
>   			}
> @@ -301,6 +306,7 @@ static void afs_break_one_callback(struct afs_server *server,
>   
>   out:
>   	read_unlock(&server->cb_break_lock);
> +	rcu_read_unlock();
>   }
>   
>   /*
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 2a4aae6acdcb..2bbb55d05bb7 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4860,21 +4860,22 @@ static int ext4_inode_blocks_set(handle_t *handle,
>   	return 0;
>   }
>   
> -struct other_inode {
> -	unsigned long		orig_ino;
> -	struct ext4_inode	*raw_inode;
> -};
> -
> -static int other_inode_match(struct inode * inode, unsigned long ino,
> -			     void *data)
> +static void __ext4_update_other_inode_time(struct super_block *sb,
> +					   unsigned long orig_ino,
> +					   unsigned long ino,
> +					   struct ext4_inode *raw_inode)
>   {
> -	struct other_inode *oi = (struct other_inode *) data;
> +	struct inode *inode;
> +
> +	inode = find_inode_by_ino_rcu(sb, ino);
> +	if (!inode)
> +		return;
>   
> -	if ((inode->i_ino != ino) ||
> -	    (inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW |
> +	if ((inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW |
>   			       I_DIRTY_INODE)) ||
>   	    ((inode->i_state & I_DIRTY_TIME) == 0))
> -		return 0;
> +		return;
> +
>   	spin_lock(&inode->i_lock);
>   	if (((inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW |
>   				I_DIRTY_INODE)) == 0) &&
> @@ -4885,16 +4886,15 @@ static int other_inode_match(struct inode * inode, unsigned long ino,
>   		spin_unlock(&inode->i_lock);
>   
>   		spin_lock(&ei->i_raw_lock);
> -		EXT4_INODE_SET_XTIME(i_ctime, inode, oi->raw_inode);
> -		EXT4_INODE_SET_XTIME(i_mtime, inode, oi->raw_inode);
> -		EXT4_INODE_SET_XTIME(i_atime, inode, oi->raw_inode);
> -		ext4_inode_csum_set(inode, oi->raw_inode, ei);
> +		EXT4_INODE_SET_XTIME(i_ctime, inode, raw_inode);
> +		EXT4_INODE_SET_XTIME(i_mtime, inode, raw_inode);
> +		EXT4_INODE_SET_XTIME(i_atime, inode, raw_inode);
> +		ext4_inode_csum_set(inode, raw_inode, ei);
>   		spin_unlock(&ei->i_raw_lock);
> -		trace_ext4_other_inode_update_time(inode, oi->orig_ino);
> -		return -1;
> +		trace_ext4_other_inode_update_time(inode, orig_ino);
> +		return;
>   	}
>   	spin_unlock(&inode->i_lock);
> -	return -1;
>   }
>   
>   /*
> @@ -4904,24 +4904,24 @@ static int other_inode_match(struct inode * inode, unsigned long ino,
>   static void ext4_update_other_inodes_time(struct super_block *sb,
>   					  unsigned long orig_ino, char *buf)
>   {
> -	struct other_inode oi;
>   	unsigned long ino;
>   	int i, inodes_per_block = EXT4_SB(sb)->s_inodes_per_block;
>   	int inode_size = EXT4_INODE_SIZE(sb);
>   
> -	oi.orig_ino = orig_ino;
>   	/*
>   	 * Calculate the first inode in the inode table block.  Inode
>   	 * numbers are one-based.  That is, the first inode in a block
>   	 * (assuming 4k blocks and 256 byte inodes) is (n*16 + 1).
>   	 */
>   	ino = ((orig_ino - 1) & ~(inodes_per_block - 1)) + 1;
> +	rcu_read_lock();
>   	for (i = 0; i < inodes_per_block; i++, ino++, buf += inode_size) {
>   		if (ino == orig_ino)
>   			continue;
> -		oi.raw_inode = (struct ext4_inode *) buf;
> -		(void) find_inode_nowait(sb, ino, other_inode_match, &oi);
> +		__ext4_update_other_inode_time(sb, orig_ino, ino,
> +					       (struct ext4_inode *)buf);
>   	}
> +	rcu_read_unlock();
>   }
>   
>   /*
> diff --git a/fs/inode.c b/fs/inode.c
> index 93d9252a00ab..a9ae3a405a1f 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -497,7 +497,7 @@ void __insert_inode_hash(struct inode *inode, unsigned long hashval)
>   
>   	spin_lock(&inode_hash_lock);
>   	spin_lock(&inode->i_lock);
> -	hlist_add_head(&inode->i_hash, b);
> +	hlist_add_head_rcu(&inode->i_hash, b);
>   	spin_unlock(&inode->i_lock);
>   	spin_unlock(&inode_hash_lock);
>   }
> @@ -513,7 +513,7 @@ void __remove_inode_hash(struct inode *inode)
>   {
>   	spin_lock(&inode_hash_lock);
>   	spin_lock(&inode->i_lock);
> -	hlist_del_init(&inode->i_hash);
> +	hlist_del_init_rcu(&inode->i_hash);
>   	spin_unlock(&inode->i_lock);
>   	spin_unlock(&inode_hash_lock);
>   }
> @@ -808,8 +808,31 @@ long prune_icache_sb(struct super_block *sb, struct shrink_control *sc)
>   }
>   
>   static void __wait_on_freeing_inode(struct inode *inode);
> +
>   /*
> - * Called with the inode lock held.
> + * Find an inode.  Can be called with either the RCU read lock or the
> + * inode cache lock held.  No check is made as to the validity of the
> + * inode found.
> + */
> +static struct inode *__find_inode_rcu(struct super_block *sb,
> +				      struct hlist_head *head,
> +				      int (*test)(struct inode *, void *),
> +				      void *data)
> +{
> +	struct inode *inode;
> +
> +	hlist_for_each_entry_rcu(inode, head, i_hash) {
> +		if (inode->i_sb == sb &&
> +		    test(inode, data))
> +			return inode;
> +	}
> +
> +	return NULL;
> +}
> +
> +/*
> + * Called with the inode hash lock held.  Waits until dying inodes are freed,
> + * dropping the inode hash lock temporarily to do so.
>    */
>   static struct inode *find_inode(struct super_block *sb,
>   				struct hlist_head *head,
> @@ -819,11 +842,8 @@ static struct inode *find_inode(struct super_block *sb,
>   	struct inode *inode = NULL;
>   
>   repeat:
> -	hlist_for_each_entry(inode, head, i_hash) {
> -		if (inode->i_sb != sb)
> -			continue;
> -		if (!test(inode, data))
> -			continue;
> +	inode = __find_inode_rcu(sb, head, test, data);
> +	if (inode) {
>   		spin_lock(&inode->i_lock);
>   		if (inode->i_state & (I_FREEING|I_WILL_FREE)) {
>   			__wait_on_freeing_inode(inode);
> @@ -840,6 +860,26 @@ static struct inode *find_inode(struct super_block *sb,
>   	return NULL;
>   }
>   
> +/*
> + * Find an inode by inode number.  Can be called with either the RCU
> + * read lock or the inode cache lock held.  No check is made as to the
> + * validity of the inode found.
> + */
> +static struct inode *__find_inode_by_ino_rcu(struct super_block *sb,
> +					     struct hlist_head *head,
> +					     unsigned long ino)
> +{
> +	struct inode *inode;
> +
> +	hlist_for_each_entry_rcu(inode, head, i_hash) {
> +		if (inode->i_ino == ino &&
> +		    inode->i_sb == sb)
> +			return inode;
> +	}
> +
> +	return NULL;
> +}
> +
>   /*
>    * find_inode_fast is the fast path version of find_inode, see the comment at
>    * iget_locked for details.
> @@ -850,11 +890,8 @@ static struct inode *find_inode_fast(struct super_block *sb,
>   	struct inode *inode = NULL;
>   
>   repeat:
> -	hlist_for_each_entry(inode, head, i_hash) {
> -		if (inode->i_ino != ino)
> -			continue;
> -		if (inode->i_sb != sb)
> -			continue;
> +	inode = __find_inode_by_ino_rcu(sb, head, ino);
> +	if (inode) {
>   		spin_lock(&inode->i_lock);
>   		if (inode->i_state & (I_FREEING|I_WILL_FREE)) {
>   			__wait_on_freeing_inode(inode);
> @@ -1107,7 +1144,7 @@ struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
>   	 */
>   	spin_lock(&inode->i_lock);
>   	inode->i_state |= I_NEW;
> -	hlist_add_head(&inode->i_hash, head);
> +	hlist_add_head_rcu(&inode->i_hash, head);
>   	spin_unlock(&inode->i_lock);
>   	if (!creating)
>   		inode_sb_list_add(inode);
> @@ -1201,7 +1238,7 @@ struct inode *iget_locked(struct super_block *sb, unsigned long ino)
>   			inode->i_ino = ino;
>   			spin_lock(&inode->i_lock);
>   			inode->i_state = I_NEW;
> -			hlist_add_head(&inode->i_hash, head);
> +			hlist_add_head_rcu(&inode->i_hash, head);
>   			spin_unlock(&inode->i_lock);
>   			inode_sb_list_add(inode);
>   			spin_unlock(&inode_hash_lock);
> @@ -1245,15 +1282,9 @@ static int test_inode_iunique(struct super_block *sb, unsigned long ino)
>   	struct inode *inode;
>   
>   	spin_lock(&inode_hash_lock);
> -	hlist_for_each_entry(inode, b, i_hash) {
> -		if (inode->i_ino == ino && inode->i_sb == sb) {
> -			spin_unlock(&inode_hash_lock);
> -			return 0;
> -		}
> -	}
> +	inode = __find_inode_by_ino_rcu(sb, b, ino);
>   	spin_unlock(&inode_hash_lock);
> -
> -	return 1;
> +	return inode ? 0 : 1;
>   }
>   
>   /**
> @@ -1325,6 +1356,7 @@ EXPORT_SYMBOL(igrab);
>    *
>    * Note: I_NEW is not waited upon so you have to be very careful what you do
>    * with the returned inode.  You probably should be using ilookup5() instead.
> + * It may still sleep waiting for I_FREE and I_WILL_FREE, however.
>    *
>    * Note2: @test is called with the inode_hash_lock held, so can't sleep.
>    */
> @@ -1456,6 +1488,86 @@ struct inode *find_inode_nowait(struct super_block *sb,
>   }
>   EXPORT_SYMBOL(find_inode_nowait);
>   
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
> + */
> +struct inode *find_inode_rcu(struct super_block *sb, unsigned long hashval,
> +			     int (*test)(struct inode *, void *), void *data)
> +{
> +	struct hlist_head *head = inode_hashtable + hash(sb, hashval);
> +	struct inode *inode;
> +
> +	RCU_LOCKDEP_WARN(!lockdep_is_held(&inode_hash_lock) && !rcu_read_lock_held(),
> +			 "suspicious find_inode_by_ino_rcu() usage");
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
> +
>   int insert_inode_locked(struct inode *inode)
>   {
>   	struct super_block *sb = inode->i_sb;
> @@ -1480,7 +1592,7 @@ int insert_inode_locked(struct inode *inode)
>   		if (likely(!old)) {
>   			spin_lock(&inode->i_lock);
>   			inode->i_state |= I_NEW | I_CREATING;
> -			hlist_add_head(&inode->i_hash, head);
> +			hlist_add_head_rcu(&inode->i_hash, head);
>   			spin_unlock(&inode->i_lock);
>   			spin_unlock(&inode_hash_lock);
>   			return 0;
> @@ -1540,6 +1652,7 @@ static void iput_final(struct inode *inode)
>   {
>   	struct super_block *sb = inode->i_sb;
>   	const struct super_operations *op = inode->i_sb->s_op;
> +	unsigned long state;
>   	int drop;
>   
>   	WARN_ON(inode->i_state & I_NEW);
> @@ -1555,16 +1668,20 @@ static void iput_final(struct inode *inode)
>   		return;
>   	}
>   
> +	state = READ_ONCE(inode->i_state);
>   	if (!drop) {
> -		inode->i_state |= I_WILL_FREE;
> +		WRITE_ONCE(inode->i_state, state | I_WILL_FREE);
>   		spin_unlock(&inode->i_lock);
> +
>   		write_inode_now(inode, 1);
> +
>   		spin_lock(&inode->i_lock);
> -		WARN_ON(inode->i_state & I_NEW);
> -		inode->i_state &= ~I_WILL_FREE;
> +		state = READ_ONCE(inode->i_state);
> +		WARN_ON(state & I_NEW);
> +		state &= ~I_WILL_FREE;
>   	}
>   
> -	inode->i_state |= I_FREEING;
> +	WRITE_ONCE(inode->i_state, state | I_FREEING);
>   	if (!list_empty(&inode->i_lru))
>   		inode_lru_list_del(inode);
>   	spin_unlock(&inode->i_lock);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 45cc10cdf6dd..5f9b2bb4b44f 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3070,6 +3070,9 @@ extern struct inode *find_inode_nowait(struct super_block *,
>   				       int (*match)(struct inode *,
>   						    unsigned long, void *),
>   				       void *data);
> +extern struct inode *find_inode_rcu(struct super_block *, unsigned long,
> +				    int (*)(struct inode *, void *), void *);
> +extern struct inode *find_inode_by_ino_rcu(struct super_block *, unsigned long);
>   extern int insert_inode_locked4(struct inode *, unsigned long, int (*test)(struct inode *, void *), void *);
>   extern int insert_inode_locked(struct inode *);
>   #ifdef CONFIG_DEBUG_LOCK_ALLOC
> 
