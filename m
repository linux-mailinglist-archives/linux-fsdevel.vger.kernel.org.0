Return-Path: <linux-fsdevel+bounces-42159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1468EA3D5EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 11:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17A8E3B3275
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 10:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3BD1F0E36;
	Thu, 20 Feb 2025 10:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YVWLK81k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52DF1DF992
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2025 10:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740045786; cv=none; b=jSAFSI0S6xRc+m6JpuTZ2hQE2ZYIDAQT2ru+Whj4DDE6SUMKctAVizj4kYQ75fyxLM2lT5H8E+9mkRDpm/DxHTwxyZgNWF34X8/Vh5KeibRkt0nEQtY+CkpYJkLdgfZYeEyArkra1bkXEWph7pbrDe4FAQbPFw4RXoeGpKeKPic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740045786; c=relaxed/simple;
	bh=7Aa6YbpJV/pKr4kxG/ZXxIrbU1omEZhw54M+CwpbMlg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UkoiTO/J4iOsspxjeW128Uwr1NKo3I6/AEQU+n5RVah/EZiJYkba1I5PJWWfVOPJDTpGVbSApFlJE/AbYbd4au4a1GBhaCkdc96lVFM2SlzadhqQsJKsIbrC4qUxlSYULFbrEyKcIgeypNrpgnOeUk/ahT1Kng8cwF2bvaPq0Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YVWLK81k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740045783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Tq0hZ4lEIrdvA6GwChX28vUIODXEG+xntzHlIRKfzUc=;
	b=YVWLK81kCXUD8nLIXtDCs4Ztq6MKCgA+ILSZjuxgE7URpDC7RvgyX0EbDAsQ93sL7+p5JS
	g5sEv5FMz5fGIay7ApYJXKLFxc3T68WUimx8WwThlL6ZdY7JX0gLbBC5sFqyyuZQOFzATb
	IByfaSfWCShr//q8QlpwhJzefK7xljQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-gGU0YgxbPsiR7w5cQScryQ-1; Thu, 20 Feb 2025 05:03:02 -0500
X-MC-Unique: gGU0YgxbPsiR7w5cQScryQ-1
X-Mimecast-MFC-AGG-ID: gGU0YgxbPsiR7w5cQScryQ_1740045781
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-abbaa560224so78891766b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2025 02:03:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740045781; x=1740650581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tq0hZ4lEIrdvA6GwChX28vUIODXEG+xntzHlIRKfzUc=;
        b=E+Qorzo225oTuj+MzI289NnObbwWxe32MsN0joMYbbWAWiBy18E99YN4Y9ftNqDnxc
         uLKbFFU/mBVIoVcy7DWXiFb2XgczzFMemS9wmR1AqgrO2G2mVjhUf6FlX+zJNg25btl5
         ipclQrNVB6TGn1P7WnpoTJgh9S28Ui35KgH3Uidg0g1U4NQ+/hLvwyeGAsgxOuqsic8B
         PGJgBMHS2g0Y/bTpGnf4x0Rz3+M2Zp28utffsMDV521616Kxt6Usz25vHyYlurFFyH5r
         6aAD7kPGoGatuOvjLwP/8qO3TbkqTI2YQo8hz76dyTyoIkAUCd1DAHWEVfUvDu+PCoV+
         OE7w==
X-Gm-Message-State: AOJu0YxQjQ+OBizqMpjNxXgvcIA5AX7lTqJ/o94dxyEKI/BX3Y59KMoZ
	X0pnNw3qhVxCQWxV/XeWABezg4Uzb0p8Bgx5n8q3VIg+rtoLtKVxYsi3v7BtawE398WN3G2GY7h
	qe3aB8nCRmTCOzkG9D2H/Wy0wGS9q3oajFZvQE5d13K2ztzmnBlRl0Tbogrno9tWe1/DYJgn921
	is1sLxx5lZB/3W2zd0Y2B4ibSEv/V6BJYsOrz/FQfLaRzH6/4few==
X-Gm-Gg: ASbGnct6t0Cn3xehr9c7pRbvVFJo9vTvxhQ6tezjbSgspy7atzhXKHSicvqwg4CUXTK
	CWJ2Ww1pmiL38kSAgyIn8y+Xps/dXlLT/g4WBo9dHcZa1kaAQHVzNBqGS1YwBILg6Ft889p24rO
	gos7zH78e1kwErlKtc0Ejgd1ZRhgzdlAMcMMiFtUdt4PMdp6DYIipikv5+TWWrJn7qQya/2Soia
	wSimyW2z4ZqB4mhsT2LvJh2I/UmiyQzeJYkzCiMEYZsYzP2y9ViFUYl2tdyO/OWnovSCZ2l83V/
	zUbfucbsNtxnT5GfU5SJMYspGMiMLSN5rgqUgD1TtzzJePvm+LkB1t0N
X-Received: by 2002:a17:906:adce:b0:abb:b422:a487 with SMTP id a640c23a62f3a-abbb422a5a5mr819899166b.19.1740045780701;
        Thu, 20 Feb 2025 02:03:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEThA6I6Fle1ztM2p7nj++dOpIO5TOZL+Riutbyg1szwRyIvsnL33P6Ta7bXAadO6aAnWuJhg==
X-Received: by 2002:a17:906:adce:b0:abb:b422:a487 with SMTP id a640c23a62f3a-abbb422a5a5mr819896966b.19.1740045780225;
        Thu, 20 Feb 2025 02:03:00 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (84-236-99-89.pool.digikabel.hu. [84.236.99.89])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb7200144fsm1034570166b.184.2025.02.20.02.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 02:02:59 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Bernd Schubert <bernd.schubert@fastmail.fm>,
	Laura Promberger <laura.promberger@cern.ch>,
	Sam Lewis <samclewis@google.com>
Subject: [PATCH] fuse: don't truncate cached, mutated symlink
Date: Thu, 20 Feb 2025 11:02:58 +0100
Message-ID: <20250220100258.793363-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fuse allows the value of a symlink to change and this property is exploited
by some filesystems (e.g. CVMFS).

It has been observed, that sometimes after changing the symlink contents,
the value is truncated to the old size.

This is caused by fuse_getattr() racing with fuse_reverse_inval_inode().
fuse_reverse_inval_inode() updates the fuse_inode's attr_version, which
results in fuse_change_attributes() exiting before updating the cached
attributes

This is okay, as the cached attributes remain invalid and the next call to
fuse_change_attributes() will likely update the inode with the correct
values.

The reason this causes problems is that cached symlinks will be
returned through page_get_link(), which truncates the symlink to
inode->i_size.  This is correct for filesystems that don't mutate
symlinks, but in this case it causes bad behavior.

The solution is to just remove this truncation.  This can cause a
regression in a filesystem that relies on supplying a symlink larger than
the file size, but this is unlikely.  If that happens we'd need to make
this behavior conditional.

Reported-by: Laura Promberger <laura.promberger@cern.ch>
Tested-by: Sam Lewis <samclewis@google.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dir.c      |  2 +-
 fs/namei.c         | 24 +++++++++++++++++++-----
 include/linux/fs.h |  2 ++
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 589e88822368..83c56ce6ad20 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1645,7 +1645,7 @@ static const char *fuse_get_link(struct dentry *dentry, struct inode *inode,
 		goto out_err;
 
 	if (fc->cache_symlinks)
-		return page_get_link(dentry, inode, callback);
+		return page_get_link_raw(dentry, inode, callback);
 
 	err = -ECHILD;
 	if (!dentry)
diff --git a/fs/namei.c b/fs/namei.c
index 3ab9440c5b93..ecb7b95c2ca3 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -5356,10 +5356,9 @@ const char *vfs_get_link(struct dentry *dentry, struct delayed_call *done)
 EXPORT_SYMBOL(vfs_get_link);
 
 /* get the link contents into pagecache */
-const char *page_get_link(struct dentry *dentry, struct inode *inode,
-			  struct delayed_call *callback)
+static char *__page_get_link(struct dentry *dentry, struct inode *inode,
+			     struct delayed_call *callback)
 {
-	char *kaddr;
 	struct page *page;
 	struct address_space *mapping = inode->i_mapping;
 
@@ -5378,8 +5377,23 @@ const char *page_get_link(struct dentry *dentry, struct inode *inode,
 	}
 	set_delayed_call(callback, page_put_link, page);
 	BUG_ON(mapping_gfp_mask(mapping) & __GFP_HIGHMEM);
-	kaddr = page_address(page);
-	nd_terminate_link(kaddr, inode->i_size, PAGE_SIZE - 1);
+	return page_address(page);
+}
+
+const char *page_get_link_raw(struct dentry *dentry, struct inode *inode,
+			      struct delayed_call *callback)
+{
+	return __page_get_link(dentry, inode, callback);
+}
+EXPORT_SYMBOL_GPL(page_get_link_raw);
+
+const char *page_get_link(struct dentry *dentry, struct inode *inode,
+					struct delayed_call *callback)
+{
+	char *kaddr = __page_get_link(dentry, inode, callback);
+
+	if (!IS_ERR(kaddr))
+		nd_terminate_link(kaddr, inode->i_size, PAGE_SIZE - 1);
 	return kaddr;
 }
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2c3b2f8a621f..9346adf28f7b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3452,6 +3452,8 @@ extern const struct file_operations generic_ro_fops;
 
 extern int readlink_copy(char __user *, int, const char *, int);
 extern int page_readlink(struct dentry *, char __user *, int);
+extern const char *page_get_link_raw(struct dentry *, struct inode *,
+				     struct delayed_call *);
 extern const char *page_get_link(struct dentry *, struct inode *,
 				 struct delayed_call *);
 extern void page_put_link(void *);
-- 
2.48.1


