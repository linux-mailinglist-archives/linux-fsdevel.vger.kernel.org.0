Return-Path: <linux-fsdevel+bounces-50382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0685ACBB6F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 21:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 120531659E1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 19:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191C5229B0F;
	Mon,  2 Jun 2025 19:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aFlY5ySW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAF2B660
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Jun 2025 19:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748891891; cv=none; b=qXWb9NsmAoLxz2eKBYST4sPTtWooBfi7vb0J/v+D8Mt74bx4c2mvdyylc0jvwku2SSmzAHPxMswQ4w0s3Th0XRRcu3BJqSTOzatItucRUMll/rZKWwy1R/pwp4hMA07k1XsD3uhhzG1WeE5IpC0UrhGpKX9XjEgelyXQjP0Gw5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748891891; c=relaxed/simple;
	bh=Kk4G9OjSA5hI8BLupzEnDWGdQPbbgM19H/mBxXD+AwQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Nm5rKBM/+dJdqJxOGPFJkaud2B604ZYX4TuJRndhEv7Dh+WPAjPLF9R6mUW7DJJoxuHij11fZx+U1tY1dZBPPAJ9Ya7sj5QjJqTwKNPdsgYNjbhA+ouBCbR5smYfXPkZclsAPFK/R6cGMRpFIbm5lhDnJT33KAtgNkdZ1jpY1Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aFlY5ySW; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7370e73f690so5435382b3a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Jun 2025 12:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748891889; x=1749496689; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gC27xGN+OZxYxd8x3HPELSRtz95EF1fMjoET+WlkV5U=;
        b=aFlY5ySWQyoPc1s+gut3HKnEuw19gZOGXVjHcUk4OtxVfu5h2RXuh99Ya/653K2xwS
         283iF8bBznmq/1nG3BbT6JDnJaHkHKqWB7Dbd4NusV5hPo2ZhsiTzjegg9HwN0KE9AkZ
         KVOUznD0Sh+0PsMNjbjG+XC9J0fQN6S7L203WTYXBr0caJH05ZohV3Hxf0ptPH6pidtO
         /2CNTSIUGYwv3jqHvY7D5xhOif/tuSsWWdYlPnf8FCcIftZJRcI6gW8Q+6BaRr++eDqV
         W7aaZ2SL3qo32lgZr5jgujxGKvCeu4+JUzhR/QhyR1Jhv1gbHa6dRW0bFqlG+lVglRNL
         akcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748891889; x=1749496689;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gC27xGN+OZxYxd8x3HPELSRtz95EF1fMjoET+WlkV5U=;
        b=sgY47wtM4duce7l8PrDhsWUq/AWZRmeUVCZAPekxGsQPAEbDtBVA+KTTlLqMmiqcUy
         vFzJKCbWQ+7lx4D37Wc8YiSJGur3umxWYBWEFdVY+p01tVbgygK6wXoV5TlJU9nXORCT
         BPHBh5Cx0nWZNNeNXavYIMyNZ60R6m0mhWiN5Di0MvUHXNABxSPnghh/eccs0v0msL79
         T8CCY3/LKFtuzR34Yq329kstTOGDHlVoTh+GHTOS4atjg3Mu9HSHLcYjNzct8TtKbEaK
         33ikms5HiJavmA53Ct1h/MGpiHYF7yZ5zx+Mv7Goa8kZ2KBVGTk0J6x3rl33K5lv9y+i
         4s5w==
X-Forwarded-Encrypted: i=1; AJvYcCWtCXUxFvA2Aoon3EOmn4qqqdwIl/WEXrY6PPapAAeLX1DCyndQh4fbAT6+LY2xC+oOkiYPrb09iQtWdrQd@vger.kernel.org
X-Gm-Message-State: AOJu0YyhXOxRErltPEW0sVsa5TjmUgWX7SSAtVE8wtySW81rTxRTJRAC
	8CFxnxywvLgjWgJQaEdqHACVa5Xgp4IyVN9Uju8Qe/dKrfL/5xF+Na2nfDOCMWXK+cnl2k3/mTd
	jt88y0B/so6Ote3NbiKpimFx2vA==
X-Google-Smtp-Source: AGHT+IEZUo9EMXuhRCwoaNc5hwobX/60MfpH4lGs/P6VHbaKIkRHWpm212b2a7KnBe+VwVfAYZRtTQUZPJL+sgEDqQ==
X-Received: from pfblu7.prod.google.com ([2002:a05:6a00:7487:b0:747:a97f:513f])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3cc5:b0:740:595a:f9bf with SMTP id d2e1a72fcca58-747bd9510fbmr21737179b3a.3.1748891888859;
 Mon, 02 Jun 2025 12:18:08 -0700 (PDT)
Date: Mon,  2 Jun 2025 12:17:54 -0700
In-Reply-To: <cover.1748890962.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1748890962.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <c03fbe18c3ae90fb3fa7c71dc0ee164e6cc12103.1748890962.git.ackerleytng@google.com>
Subject: [PATCH 1/2] fs: Provide function that allocates a secure anonymous inode
From: Ackerley Tng <ackerleytng@google.com>
To: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, linux-fsdevel@vger.kernel.org
Cc: ackerleytng@google.com, aik@amd.com, ajones@ventanamicro.com, 
	akpm@linux-foundation.org, amoorthy@google.com, anthony.yznaga@oracle.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, bfoster@redhat.com, 
	binbin.wu@linux.intel.com, brauner@kernel.org, catalin.marinas@arm.com, 
	chao.p.peng@intel.com, chenhuacai@kernel.org, dave.hansen@intel.com, 
	david@redhat.com, dmatlack@google.com, dwmw@amazon.co.uk, 
	erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, graf@amazon.com, 
	haibo1.xu@intel.com, hch@infradead.org, hughd@google.com, ira.weiny@intel.com, 
	isaku.yamahata@intel.com, jack@suse.cz, james.morse@arm.com, 
	jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, jhubbard@nvidia.com, 
	jroedel@suse.de, jthoughton@google.com, jun.miao@intel.com, 
	kai.huang@intel.com, keirf@google.com, kent.overstreet@linux.dev, 
	kirill.shutemov@intel.com, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, maz@kernel.org, 
	mic@digikod.net, michael.roth@amd.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, pdurrant@amazon.co.uk, 
	peterx@redhat.com, pgonda@google.com, pvorel@suse.cz, qperret@google.com, 
	quic_cvanscha@quicinc.com, quic_eberman@quicinc.com, 
	quic_mnalajal@quicinc.com, quic_pderrin@quicinc.com, quic_pheragu@quicinc.com, 
	quic_svaddagi@quicinc.com, quic_tsoni@quicinc.com, richard.weiyang@gmail.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, roypat@amazon.co.uk, 
	rppt@kernel.org, seanjc@google.com, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	thomas.lendacky@amd.com, vannapurve@google.com, vbabka@suse.cz, 
	viro@zeniv.linux.org.uk, vkuznets@redhat.com, wei.w.wang@intel.com, 
	will@kernel.org, willy@infradead.org, xiaoyao.li@intel.com, 
	yan.y.zhao@intel.com, yilun.xu@intel.com, yuzenghui@huawei.com, 
	zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

The new function, alloc_anon_secure_inode(), returns an inode after
running checks in security_inode_init_security_anon().

Also refactor secretmem's file creation process to use the new
function.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 fs/anon_inodes.c   | 22 ++++++++++++++++------
 include/linux/fs.h |  1 +
 mm/secretmem.c     |  9 +--------
 3 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
index 583ac81669c2..4c3110378647 100644
--- a/fs/anon_inodes.c
+++ b/fs/anon_inodes.c
@@ -55,17 +55,20 @@ static struct file_system_type anon_inode_fs_type = {
 	.kill_sb	= kill_anon_super,
 };

-static struct inode *anon_inode_make_secure_inode(
-	const char *name,
-	const struct inode *context_inode)
+static struct inode *anon_inode_make_secure_inode(struct super_block *s,
+		const char *name, const struct inode *context_inode,
+		bool fs_internal)
 {
 	struct inode *inode;
 	int error;

-	inode = alloc_anon_inode(anon_inode_mnt->mnt_sb);
+	inode = alloc_anon_inode(s);
 	if (IS_ERR(inode))
 		return inode;
-	inode->i_flags &= ~S_PRIVATE;
+
+	if (!fs_internal)
+		inode->i_flags &= ~S_PRIVATE;
+
 	error =	security_inode_init_security_anon(inode, &QSTR(name),
 						  context_inode);
 	if (error) {
@@ -75,6 +78,12 @@ static struct inode *anon_inode_make_secure_inode(
 	return inode;
 }

+struct inode *alloc_anon_secure_inode(struct super_block *s, const char *name)
+{
+	return anon_inode_make_secure_inode(s, name, NULL, true);
+}
+EXPORT_SYMBOL_GPL(alloc_anon_secure_inode);
+
 static struct file *__anon_inode_getfile(const char *name,
 					 const struct file_operations *fops,
 					 void *priv, int flags,
@@ -88,7 +97,8 @@ static struct file *__anon_inode_getfile(const char *name,
 		return ERR_PTR(-ENOENT);

 	if (make_inode) {
-		inode =	anon_inode_make_secure_inode(name, context_inode);
+		inode = anon_inode_make_secure_inode(anon_inode_mnt->mnt_sb,
+						     name, context_inode, false);
 		if (IS_ERR(inode)) {
 			file = ERR_CAST(inode);
 			goto err;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 016b0fe1536e..0fded2e3c661 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3550,6 +3550,7 @@ extern int simple_write_begin(struct file *file, struct address_space *mapping,
 extern const struct address_space_operations ram_aops;
 extern int always_delete_dentry(const struct dentry *);
 extern struct inode *alloc_anon_inode(struct super_block *);
+extern struct inode *alloc_anon_secure_inode(struct super_block *, const char *);
 extern int simple_nosetlease(struct file *, int, struct file_lease **, void **);
 extern const struct dentry_operations simple_dentry_operations;

diff --git a/mm/secretmem.c b/mm/secretmem.c
index 1b0a214ee558..c0e459e58cb6 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -195,18 +195,11 @@ static struct file *secretmem_file_create(unsigned long flags)
 	struct file *file;
 	struct inode *inode;
 	const char *anon_name = "[secretmem]";
-	int err;

-	inode = alloc_anon_inode(secretmem_mnt->mnt_sb);
+	inode = alloc_anon_secure_inode(secretmem_mnt->mnt_sb, anon_name);
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);

-	err = security_inode_init_security_anon(inode, &QSTR(anon_name), NULL);
-	if (err) {
-		file = ERR_PTR(err);
-		goto err_free_inode;
-	}
-
 	file = alloc_file_pseudo(inode, secretmem_mnt, "secretmem",
 				 O_RDWR, &secretmem_fops);
 	if (IS_ERR(file))
--
2.49.0.1204.g71687c7c1d-goog

