Return-Path: <linux-fsdevel+bounces-26101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A419544E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 10:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D23DD284B99
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 08:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76C813B58E;
	Fri, 16 Aug 2024 08:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QHUKlY4l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046A053804
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2024 08:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723798483; cv=none; b=SinAG6w+iWigyzpw2DxyGjPPWbpTwPtaFYtP79086aV7P7SSZxxP3rKfOor8XUn62ptYhpcLR0M0gsJCoDPpzrZpt5wm5THbv7XEE3VrzezctVePYCEmIPazJy73gWWrC3yWbOHPw0lBwItpKt1x3Ax5T2Q2Aexu8OaS44lWYUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723798483; c=relaxed/simple;
	bh=vKSW5PdHT4hr7siIYL3wBxOTe7f28OQbllzxM6TF3DE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fi97NT5ZwmeBo/3SLByZ25Lr4kgReOD/cxL1uyvTK7OaHI3m7v4Pv4EOQ0hcirx1mIiyXmt35kyH9nfeUe2NHxxW1Q87fFJRwicnucxDhcSq44OHDtOdXA774nRxUEe8kONIS0ZhrlYK8mtBizbHZAmSqba2qSRqd2ZCZKWxXDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QHUKlY4l; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42816ca782dso12933805e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2024 01:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723798479; x=1724403279; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3pIkvRgkwngFukvaEgo0ZxKmEDBfWbk9DOS9YQMsLN0=;
        b=QHUKlY4l4raXe94KhJJgYAtRQ7yew5EDyIUbJz6RRWAGJGVOY0VYcVE3h5vWNx8RQu
         3SwazR82Byv5v+SxwvpYbg8GR5NN1RSe3l15VUqABE2Z8LwW3zys2CxTLYpNTKlPfoGX
         cwzFJuOqnZsk5ZJ7KmoqfEZZjlYxfpDrCK0teNKLJGW5uD69rKiyzwqitRJ1hd9+Hsa5
         IjQWfpDhyFhr2xDOod4bYl8FDdUwkmplYwqIeORkFQzL+CNY0aitQkSAVovestMl2wQu
         ZJBW/gm60l4INyOEMlESd+9PuFZ8x+eset1oIPT9iz6kCtDo/qwDOAXGJKj9mJua00O4
         XdfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723798479; x=1724403279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3pIkvRgkwngFukvaEgo0ZxKmEDBfWbk9DOS9YQMsLN0=;
        b=AMCGM2icsj8NzUf9iXYNOSHlDYcjxRDaapBWK+/e3OL+aJl+4Ta0vGAb+IMLaMlTmH
         BN2eY7qqkwMmvJ2qtQbQ3l+xYXzNZ65Pq9bLk45bzHtLk6fkEv8vIo/MqJF6F/QQWfwe
         k9Xt+3wedNGr+vItrYHSZXmaKpJnXH0JZ6fYItrk2Wj0sqnRQTE62gIRQDZ1CkT3Ul3J
         ripNK+e2XdSga0jcaVToa5WpuUJ+gsGJrKKpi8CYGpiKjzkbiBO2E9xZSNfrq7U9S4bO
         hFG9+esti1FYexWYRE7Z0Lq9Yp71/M+LYuoUQuF8Us0ngDj48GMTliDOY8sWiCdzLcb9
         /gpg==
X-Forwarded-Encrypted: i=1; AJvYcCWTnUMZw1vrXS0ueoYD+DskwBQHM1b7Sceqf9RweFzfeacz4nfb97dZA7Jc+RRz61kp4aLOMBAct9NbWQXlt0KLsY4cEuwXu1dmH8AYPg==
X-Gm-Message-State: AOJu0YwHx+UMOpxWvJlbjN5cKHp6KrGdbkkUjlBK0nrMjOGgEny4y3B6
	6e++3PEgf+s11DcoeQ7QztR3efZ2yKeG5wF2jKs7pstfLCvMP0CEAWiecc4T65E=
X-Google-Smtp-Source: AGHT+IHFi3KoFe2Nw7CAeOaBuufog4mitm27hUgU2VeSa6AqOuxlI8alCK6Rl3A58UW0OSu7uY9gmw==
X-Received: by 2002:a05:600c:4e8a:b0:426:623f:34ae with SMTP id 5b1f17b1804b1-429ed794d8amr12813275e9.16.1723798478880;
        Fri, 16 Aug 2024 01:54:38 -0700 (PDT)
Received: from localhost (109-81-92-77.rct.o2.cz. [109.81.92.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429dec83d2asm71008715e9.0.2024.08.16.01.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 01:54:38 -0700 (PDT)
Date: Fri, 16 Aug 2024 10:54:37 +0200
From: Michal Hocko <mhocko@suse.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Yafang Shao <laoar.shao@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, david@fromorbit.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH] mm: document risk of PF_MEMALLOC_NORECLAIM
Message-ID: <Zr8TzTJc-0lDOIWF@tiehlicka>
References: <CALOAHbBd2oCVKsMwcH_YGUWT5LGLWmNSUAZzRPp8j7bBaqc1PQ@mail.gmail.com>
 <Zrxfy-F1ZkvQdhNR@tiehlicka>
 <CALOAHbCLPLpi39-HVVJvUj=qVcNFcQz=3cd95wFpKZzUntCtdw@mail.gmail.com>
 <ZrymePQHzTHaUIch@tiehlicka>
 <CALOAHbDw5_hFGsQGYpmaW2KPXi8TxnxPQg4z7G3GCyuJWWywpQ@mail.gmail.com>
 <Zr2eiFOT--CV5YsR@tiehlicka>
 <CALOAHbCnWDPnErCDOWaPo6vc__G56wzmX-j=bGrwAx6J26DgJg@mail.gmail.com>
 <Zr2liCOFDqPiNk6_@tiehlicka>
 <Zr8LMv89fkfpmBlO@tiehlicka>
 <Zr8MTWiz6ULsZ-tD@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zr8MTWiz6ULsZ-tD@infradead.org>

On Fri 16-08-24 01:22:37, Christoph Hellwig wrote:
> On Fri, Aug 16, 2024 at 10:17:54AM +0200, Michal Hocko wrote:
> > Andrew, could you merge the following before PF_MEMALLOC_NORECLAIM can
> > be removed from the tree altogether please? For the full context the 
> > email thread starts here: https://lore.kernel.org/all/20240812090525.80299-1-laoar.shao@gmail.com/T/#u
> 
> I don't think that's enough.  We just need to kill it given that it was
> added without ACKs and despite explicit earlier objections to the API.

Yes, I think we should kill it before it spreads even more but I would
not like to make the existing user just broken. I have zero visibility
and understanding of the bcachefs code but from a quick look at __bch2_new_inode
it shouldn't be really terribly hard to push GFP_NOWAIT flag there
directly. It would require inode_init_always_gfp variant as well (to not
touch all existing callers that do not have any locking requirements but
I do not see any other nested allocations.

So a very quick and untested change would look as follows:
---
diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index 15fc41e63b6c..7a55167b9133 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -231,9 +231,9 @@ static struct inode *bch2_alloc_inode(struct super_block *sb)
 	BUG();
 }
 
-static struct bch_inode_info *__bch2_new_inode(struct bch_fs *c)
+static struct bch_inode_info *__bch2_new_inode(struct bch_fs *c, gfp_t gfp)
 {
-	struct bch_inode_info *inode = kmem_cache_alloc(bch2_inode_cache, GFP_NOFS);
+	struct bch_inode_info *inode = kmem_cache_alloc(bch2_inode_cache, gfp);
 	if (!inode)
 		return NULL;
 
@@ -245,7 +245,7 @@ static struct bch_inode_info *__bch2_new_inode(struct bch_fs *c)
 	mutex_init(&inode->ei_quota_lock);
 	memset(&inode->ei_devs_need_flush, 0, sizeof(inode->ei_devs_need_flush));
 
-	if (unlikely(inode_init_always(c->vfs_sb, &inode->v))) {
+	if (unlikely(inode_init_always_gfp(c->vfs_sb, &inode->v), gfp)) {
 		kmem_cache_free(bch2_inode_cache, inode);
 		return NULL;
 	}
@@ -258,12 +258,10 @@ static struct bch_inode_info *__bch2_new_inode(struct bch_fs *c)
  */
 static struct bch_inode_info *bch2_new_inode(struct btree_trans *trans)
 {
-	struct bch_inode_info *inode =
-		memalloc_flags_do(PF_MEMALLOC_NORECLAIM|PF_MEMALLOC_NOWARN,
-				  __bch2_new_inode(trans->c));
+	struct bch_inode_info *inode = __bch2_new_inode(trans->c, GFP_NOWARN | GFP_NOWAIT);
 
 	if (unlikely(!inode)) {
-		int ret = drop_locks_do(trans, (inode = __bch2_new_inode(trans->c)) ? 0 : -ENOMEM);
+		int ret = drop_locks_do(trans, (inode = __bch2_new_inode(trans->c, GFP_NOFS)) ? 0 : -ENOMEM);
 		if (ret && inode) {
 			__destroy_inode(&inode->v);
 			kmem_cache_free(bch2_inode_cache, inode);
@@ -328,7 +326,7 @@ __bch2_create(struct mnt_idmap *idmap,
 	if (ret)
 		return ERR_PTR(ret);
 #endif
-	inode = __bch2_new_inode(c);
+	inode = __bch2_new_inode(c, GFP_NOFS);
 	if (unlikely(!inode)) {
 		inode = ERR_PTR(-ENOMEM);
 		goto err;
diff --git a/fs/inode.c b/fs/inode.c
index 86670941884b..95fd67a6cac3 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -153,7 +153,7 @@ static int no_open(struct inode *inode, struct file *file)
  * These are initializations that need to be done on every inode
  * allocation as the fields are not initialised by slab allocation.
  */
-int inode_init_always(struct super_block *sb, struct inode *inode)
+int inode_init_always(struct super_block *sb, struct inode *inode, gfp_t gfp)
 {
 	static const struct inode_operations empty_iops;
 	static const struct file_operations no_open_fops = {.open = no_open};
@@ -230,14 +230,14 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
 #endif
 	inode->i_flctx = NULL;
 
-	if (unlikely(security_inode_alloc(inode)))
+	if (unlikely(security_inode_alloc(inode, gfp)))
 		return -ENOMEM;
 
 	this_cpu_inc(nr_inodes);
 
 	return 0;
 }
-EXPORT_SYMBOL(inode_init_always);
+EXPORT_SYMBOL(inode_init_always_gfp);
 
 void free_inode_nonrcu(struct inode *inode)
 {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index fd34b5755c0b..5c613a89718b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3027,7 +3027,12 @@ extern loff_t default_llseek(struct file *file, loff_t offset, int whence);
 
 extern loff_t vfs_llseek(struct file *file, loff_t offset, int whence);
 
-extern int inode_init_always(struct super_block *, struct inode *);
+extern int inode_init_always(struct super_block *, struct inode *, gfp_t);
+static inline int inode_init_always(struct super_block *, struct inode *)
+{
+	return inode_init_always_gfp(GFP_NOFS);
+}
+
 extern void inode_init_once(struct inode *);
 extern void address_space_init_once(struct address_space *mapping);
 extern struct inode * igrab(struct inode *);
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index a2ade0ffe9e7..b08472d64765 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -150,6 +150,6 @@ extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
 		__used __section(".early_lsm_info.init")		\
 		__aligned(sizeof(unsigned long))
 
-extern int lsm_inode_alloc(struct inode *inode);
+extern int lsm_inode_alloc(struct inode *inode, gfp_t gfp);
 
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/include/linux/security.h b/include/linux/security.h
index 1390f1efb4f0..7c6b9b038a0d 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -336,7 +336,7 @@ int security_dentry_create_files_as(struct dentry *dentry, int mode,
 					struct cred *new);
 int security_path_notify(const struct path *path, u64 mask,
 					unsigned int obj_type);
-int security_inode_alloc(struct inode *inode);
+int security_inode_alloc(struct inode *inode, gfp_t gfp);
 void security_inode_free(struct inode *inode);
 int security_inode_init_security(struct inode *inode, struct inode *dir,
 				 const struct qstr *qstr,
@@ -769,7 +769,7 @@ static inline int security_path_notify(const struct path *path, u64 mask,
 	return 0;
 }
 
-static inline int security_inode_alloc(struct inode *inode)
+static inline int security_inode_alloc(struct inode *inode, gfp_t gfp)
 {
 	return 0;
 }
diff --git a/security/security.c b/security/security.c
index 8cee5b6c6e6d..8634d3bee56f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -660,14 +660,14 @@ static int lsm_file_alloc(struct file *file)
  *
  * Returns 0, or -ENOMEM if memory can't be allocated.
  */
-int lsm_inode_alloc(struct inode *inode)
+int lsm_inode_alloc(struct inode *inode, gfp)
 {
 	if (!lsm_inode_cache) {
 		inode->i_security = NULL;
 		return 0;
 	}
 
-	inode->i_security = kmem_cache_zalloc(lsm_inode_cache, GFP_NOFS);
+	inode->i_security = kmem_cache_zalloc(lsm_inode_cache, gfp);
 	if (inode->i_security == NULL)
 		return -ENOMEM;
 	return 0;
@@ -1582,9 +1582,9 @@ int security_path_notify(const struct path *path, u64 mask,
  *
  * Return: Return 0 if operation was successful.
  */
-int security_inode_alloc(struct inode *inode)
+int security_inode_alloc(struct inode *inode, gfp_t gfp)
 {
-	int rc = lsm_inode_alloc(inode);
+	int rc = lsm_inode_alloc(inode, gfp);
 
 	if (unlikely(rc))
 		return rc;
-- 
Michal Hocko
SUSE Labs

