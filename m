Return-Path: <linux-fsdevel+bounces-60957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 060C7B53769
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 17:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AFD57B8A16
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 15:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40443570C3;
	Thu, 11 Sep 2025 15:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJxmD03/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB63369327;
	Thu, 11 Sep 2025 15:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757603761; cv=none; b=Cg93ju21T9TXDOJGI59gYObI4numKu2H2UEKOwmcr2GRHKcDxdmjBLTNn14KXNUQ+kXO11KbFVVKqNe4Yuj7RjS/8JgVObzQ4lORbk89E3ovef/GcIIQbJtXe6Vjl2zT+8pZa/+Q8W8Xn8Du95zuuwJAthv3brZPsP3bB6g0UwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757603761; c=relaxed/simple;
	bh=hNLDfMeuBPoPYzsUzYLN/cJRYAooo5sjV68bKl/RUPs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Iyt2wKJW2gdvyJuO/NQQiiIpawfBPhqWcCJI9TuVe6niwfs/PIpZS87OA3BV+JQH3GB3oa4+aPAXetbljkd/jryAUneHo3PH2Lon8qHENI5wUV9csKaJ68KJKBVkZGZu4E0pKEWVcNSletHFN+jAMUKtWQCBF5aKE/+aUXyWICw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJxmD03/; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45deccb2c1eso6723535e9.1;
        Thu, 11 Sep 2025 08:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757603757; x=1758208557; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+kSQgeyXNErbEiMbYm90Cp8n5GIHwFnPoCAdpOTaHz4=;
        b=nJxmD03/gPxwDsQvsvajh32B9kNd7DXNvPpFFzDIC6Il0voE4IIzbKuY+i1fmxqLG3
         uyZI6kKfVAEj2v1QqWYZt/6mbtIKWBKynryuQhWnrqEZfqR/c8oijUdi5xMvgqqiza7P
         cXpqoOpNPzWOoOlTg5XeMnwJuaqBpGevN0rZXv+bHoPy7+B0nIKMMqXO+DRvGkpZGeES
         iaxPlRXGvVcVfb0V+YizA0baHsXDz26b/41NOwzKnokFwX7eKlc17v8/augkIsXSalr2
         xwTeEFgZMDM2Vqayq4V7Z01/38cC/a97jJzw8HBqxuQ0ypDVFwLXfeTRXvPv4ekuqGta
         FGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757603757; x=1758208557;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+kSQgeyXNErbEiMbYm90Cp8n5GIHwFnPoCAdpOTaHz4=;
        b=ulT7RSZgDLCnOV9rdBOahYiBIilojDvzSNU852z7iejSe2VxUL6Smj/bTpmO5Kx4O8
         Shu7qRrE9WTjrJR2tu+Q3ITtDHA8YWtgmgY4shys+w8qNwvEHHy1JjkV6GpYf+DAUjoJ
         tQr6FWuC49xnYjCZsdaDVnavaZcdfzVGPwd0ESHu7hpvSE8w8x/Flj//gcL+R0iojH99
         22eqlBh830wrmmgsfLcUYtczoUjLRocElj5KjTaDDFrHmmBT1kT7iZBDBZqdQBDvlczs
         e0zKipjkTcSPzfRoTA/1IJO9y3Kq3l7AL4XZhKjjbtN4krleHXUpM7ZkYQcHF2zdz5sD
         zFcA==
X-Forwarded-Encrypted: i=1; AJvYcCW/arrhu1pYDgF5Sq12GO+wLZYJHpkxxPJjx2bwIr+husAD1mrDOXBUSV3N4IQzJATjIJDFFk3FkNf2PYTo@vger.kernel.org, AJvYcCXewc1tilC3p279MTdeomN3kfHsUgZVZr3B2jrU8wpCI10q8kUpn0axxSOgz6CJ0q3yxf+dlOMeL2YSHuo2@vger.kernel.org
X-Gm-Message-State: AOJu0YzI7HGq19fPZbgVbwc++DZQ5phfsGzabkBC6ce9CBQmfa7g5N7V
	C1NML8rArmUtuWRYk8tn/irxGOiOrPKlNacK91prn3yYnIfFyA+TO9PR
X-Gm-Gg: ASbGncsM1lh0//MLnnaC51jb2jO5n2zrqGlSUE7Nm9NgH3SarIT0I4XIfh5Dxu1zQDn
	8f1F2iPQWgyhZopwBR8/OzCqDkPaVjgu04814DXPdWWOE8SUlApflLg+PPZyrSY1mG8ZtMIVnhx
	ZDa9O+ROLhdJ9T+2rkpfBdst3R7eCG9a6AsZ1y4D6PP0NeqxnyqmS4BJTfCVUtI0k36rbOWFiZk
	jN+lXpPU0/gdRDeRokjv1XQzpv35ToaItmuzwQXMeAR/6zammt35LP1D5ESqay7yDqt10EcDTGg
	6pMzsjWai2Qoc9FBoCmVwmfpwgHTKV6sz3cEwOSDca9lL3LBn5poEhGVwnYNYJ3MBhRIIHBFo18
	21sbquQUi+4yyXALC2x/+CfQSerhnbGHKuizNq1FdahfErqs1
X-Google-Smtp-Source: AGHT+IEcROfkg5rCzoOVrVgraVaQTsespGTGiPDzFcdURnbnqY3KxBGgnlK8ozrGTvLYi2J45FN9FQ==
X-Received: by 2002:a05:6000:26c6:b0:3e7:4701:d1a3 with SMTP id ffacd0b85a97d-3e74701d5bamr15012175f8f.38.1757603757111;
        Thu, 11 Sep 2025 08:15:57 -0700 (PDT)
Received: from f (cst-prg-67-222.cust.vodafone.cz. [46.135.67.222])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037c4490sm26922615e9.19.2025.09.11.08.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 08:15:56 -0700 (PDT)
Date: Thu, 11 Sep 2025 17:15:47 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: viro@zeniv.linux.org.uk
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: buggered I_CREATING implementation?
Message-ID: <lsqpkeiqraemymog6l5msgx3x4nczbyxg55ffelntnzp43grop@bdk6ezmz5wg5>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

I'm looking at sanitizing the I_* flags and the current implementation
of I_CREATING reads like a bug.

It showed up in this patchset:
https://lore.kernel.org/all/20180729220453.13431-2-viro@ZenIV.linux.org.uk/

The relevant commit:
commit c2b6d621c4ffe9936adf7a55c8b1c769672c306f
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Thu Jun 28 15:53:17 2018 -0400

    new primitive: discard_new_inode()

            We don't want open-by-handle picking half-set-up in-core
    struct inode from e.g. mkdir() having failed halfway through.
[snip]
            Solution: new flag (I_CREATING) set by insert_inode_locked() and
    removed by unlock_new_inode() and a new primitive (discard_new_inode())
    to be used by such halfway-through-setup failure exits instead of
    unlock_new_inode() / iput() combinations.  That primitive unlocks new
    inode, but leaves I_CREATING in place.

            iget_locked() treats finding an I_CREATING inode as failure
    (-ESTALE, once we sort out the error propagation).
            insert_inode_locked() treats the same as instant -EBUSY.
            ilookup() treats those as icache miss.

So as far as I understand the intent was to make it so that discarded
inodes can be tested for with:
	(inode->i_state & (I_NEW | I_CREATING) == I_CREATING)

But that's not what the patch is doing.

In insert_inode_locked() every inserted inode gets both flags:
                if (likely(!old)) {
                        spin_lock(&inode->i_lock);
                        inode->i_state |= I_NEW | I_CREATING;
                        hlist_add_head_rcu(&inode->i_hash, head);
                        spin_unlock(&inode->i_lock);
                        spin_unlock(&inode_hash_lock);
                        return 0;
                }

This means another call for the same inode will find it and:

                if (unlikely(old->i_state & I_CREATING)) {
                        spin_unlock(&old->i_lock);
                        spin_unlock(&inode_hash_lock);
                        return -EBUSY;
                }

... return with -EBUSY instead of waiting to check what will happen with it.

The call to wait_on_inode() which can be found later:
                __iget(old);
                spin_unlock(&old->i_lock);
                spin_unlock(&inode_hash_lock);
                wait_on_inode(old);
                if (unlikely(!inode_unhashed(old))) {
                        iput(old);
                        return -EBUSY;
                }

... only ever gets to execute if the inode is fully constructed *or* it
was added to the hash with a routine which does not set I_CREATING,
which does not add up.

So if I understand correctly what was the intended behavior, my
counterproposal is to retire I_CREATING and instead add I_DISCARDED
which would be set by discard_new_inode().

Then insert_inode_locked() and others can do things like:
                if (unlikely(old->i_state & I_DISCARDED)) {
                        spin_unlock(&old->i_lock);
                        spin_unlock(&inode_hash_lock);
                        return -EBUSY;
                }
	[snip]
                wait_on_inode(old);
                if (unlikely(old->i_state & I_DISCARDED || !inode_unhashed(old))) {
                        iput(old);
                        return -EBUSY;
                }

The flag thing aside, there is weird bug in this routine in inode traversal:
               hlist_for_each_entry(old, head, i_hash) {
                        if (old->i_ino != ino)
                                continue;
                        if (old->i_sb != sb)
                                continue;
                        spin_lock(&old->i_lock);
                        if (old->i_state & (I_FREEING|I_WILL_FREE)) {
                                spin_unlock(&old->i_lock);
                                continue;
                        }
                        break;
                }

This will intentionally skip I_FREEING|I_WILL_FREE instead of waiting on
it to leave the hash. I verified this is the only place in the file
doing this, others call __wait_on_freeing_inode(). It reads like a bug
to me because it allows the caller looking for this inode to insert
their own copy and progress outside of the routine.

The current inode_unhashed checks after wait_on_inode could be replaced
with something like:

bool inode_can_use() {
	if (inode->i_state & I_DISCARDED)
		return false;
	if (inode_unhashed(inode))
		return false;
	return true;
}

or maybe wait_on_inode could grow a return value and do the work inside.

I also noticed wait_on_inode is defined in include/linux/writeback.h,
but the only users are fs/gfs2 and fs/inode.c, so it will probably want
a different home.

Comments?

Below is a non-operational WIP diff to replace the flag, it does not add the
aforementioned checks after wait_on_inode yet or do any cleanups:

diff --git a/fs/dcache.c b/fs/dcache.c
index 60046ae23d51..c1188ff2fbd1 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1981,7 +1981,7 @@ void d_instantiate_new(struct dentry *entry, struct inode *inode)
 	spin_lock(&inode->i_lock);
 	__d_instantiate(entry, inode);
 	WARN_ON(!(inode->i_state & I_NEW));
-	inode->i_state &= ~I_NEW & ~I_CREATING;
+	inode->i_state &= ~I_NEW;
 	/*
 	 * Pairs with the barrier in prepare_to_wait_event() to make sure
 	 * ___wait_var_event() either sees the bit cleared or
diff --git a/fs/inode.c b/fs/inode.c
index 95fada5c45ea..9b6d5a644cf5 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1029,7 +1029,7 @@ static struct inode *find_inode(struct super_block *sb,
 			__wait_on_freeing_inode(inode, is_inode_hash_locked);
 			goto repeat;
 		}
-		if (unlikely(inode->i_state & I_CREATING)) {
+		if (unlikely(inode->i_state & I_DISCARDED)) {
 			spin_unlock(&inode->i_lock);
 			rcu_read_unlock();
 			return ERR_PTR(-ESTALE);
@@ -1070,7 +1070,7 @@ static struct inode *find_inode_fast(struct super_block *sb,
 			__wait_on_freeing_inode(inode, is_inode_hash_locked);
 			goto repeat;
 		}
-		if (unlikely(inode->i_state & I_CREATING)) {
+		if (unlikely(inode->i_state & I_DISCARDED)) {
 			spin_unlock(&inode->i_lock);
 			rcu_read_unlock();
 			return ERR_PTR(-ESTALE);
@@ -1181,7 +1181,7 @@ void unlock_new_inode(struct inode *inode)
 	lockdep_annotate_inode_mutex_key(inode);
 	spin_lock(&inode->i_lock);
 	WARN_ON(!(inode->i_state & I_NEW));
-	inode->i_state &= ~I_NEW & ~I_CREATING;
+	inode->i_state &= ~I_NEW;
 	/*
 	 * Pairs with the barrier in prepare_to_wait_event() to make sure
 	 * ___wait_var_event() either sees the bit cleared or
@@ -1195,10 +1195,14 @@ EXPORT_SYMBOL(unlock_new_inode);
 
 void discard_new_inode(struct inode *inode)
 {
+	u32 state;
 	lockdep_annotate_inode_mutex_key(inode);
 	spin_lock(&inode->i_lock);
-	WARN_ON(!(inode->i_state & I_NEW));
-	inode->i_state &= ~I_NEW;
+	state = inode->i_state;
+	WARN_ON(!(state & I_NEW));
+	state &= ~I_NEW;
+	state |= I_DISCARDED;
+	WRITE_ONCE(inode->i_state, state);
 	/*
 	 * Pairs with the barrier in prepare_to_wait_event() to make sure
 	 * ___wait_var_event() either sees the bit cleared or
@@ -1783,6 +1787,7 @@ int insert_inode_locked(struct inode *inode)
 	while (1) {
 		struct inode *old = NULL;
 		spin_lock(&inode_hash_lock);
+repeat:
 		hlist_for_each_entry(old, head, i_hash) {
 			if (old->i_ino != ino)
 				continue;
@@ -1790,20 +1795,21 @@ int insert_inode_locked(struct inode *inode)
 				continue;
 			spin_lock(&old->i_lock);
 			if (old->i_state & (I_FREEING|I_WILL_FREE)) {
-				spin_unlock(&old->i_lock);
-				continue;
+				__wait_on_freeing_inode(inode, true);
+				old = NULL;
+				goto repeat;
 			}
 			break;
 		}
 		if (likely(!old)) {
 			spin_lock(&inode->i_lock);
-			inode->i_state |= I_NEW | I_CREATING;
+			inode->i_state |= I_NEW;
 			hlist_add_head_rcu(&inode->i_hash, head);
 			spin_unlock(&inode->i_lock);
 			spin_unlock(&inode_hash_lock);
 			return 0;
 		}
-		if (unlikely(old->i_state & I_CREATING)) {
+		if (unlikely(old->i_state & I_DISCARDED)) {
 			spin_unlock(&old->i_lock);
 			spin_unlock(&inode_hash_lock);
 			return -EBUSY;
@@ -1826,7 +1832,6 @@ int insert_inode_locked4(struct inode *inode, unsigned long hashval,
 {
 	struct inode *old;
 
-	inode->i_state |= I_CREATING;
 	old = inode_insert5(inode, hashval, test, NULL, data);
 
 	if (old != inode) {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 601d036a6c78..1928ffc55f09 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2559,7 +2559,7 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
  * I_OVL_INUSE		Used by overlayfs to get exclusive ownership on upper
  *			and work dirs among overlayfs mounts.
  *
- * I_CREATING		New object's inode in the middle of setting up.
+ * I_DISCARDED		Inode creation failed.
  *
  * I_DONTCACHE		Evict inode as soon as it is not used anymore.
  *
@@ -2595,7 +2595,7 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
 #define I_DIRTY_TIME		(1 << 11)
 #define I_WB_SWITCH		(1 << 12)
 #define I_OVL_INUSE		(1 << 13)
-#define I_CREATING		(1 << 14)
+#define I_DISCARDED		(1 << 14)
 #define I_DONTCACHE		(1 << 15)
 #define I_SYNC_QUEUED		(1 << 16)
 #define I_PINNING_NETFS_WB	(1 << 17)
diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 1e23919c0da9..cda77ca84bad 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -24,7 +24,7 @@
 		{I_LINKABLE,		"I_LINKABLE"},		\
 		{I_WB_SWITCH,		"I_WB_SWITCH"},		\
 		{I_OVL_INUSE,		"I_OVL_INUSE"},		\
-		{I_CREATING,		"I_CREATING"},		\
+		{I_DISCARDED,		"I_DISCARDED"},		\
 		{I_DONTCACHE,		"I_DONTCACHE"},		\
 		{I_SYNC_QUEUED,		"I_SYNC_QUEUED"},	\
 		{I_PINNING_NETFS_WB,	"I_PINNING_NETFS_WB"},	\

