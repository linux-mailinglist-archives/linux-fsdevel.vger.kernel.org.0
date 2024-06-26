Return-Path: <linux-fsdevel+bounces-22500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07065918138
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 14:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 394B21C2166E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 12:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6421181CE4;
	Wed, 26 Jun 2024 12:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="ssLres26";
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="YDpUXkqs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD0518413A;
	Wed, 26 Jun 2024 12:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719405803; cv=none; b=uKfk3k4M6mtQUHMNJVN9N2VgT7F1CGGWH8Jgm1b6A9SsXT5QlRkYr1YFYkEVcWewpgtZJhm7QnIjKxPrt3D57qqpZ6AUjkzJJUmxUnEutu577Ci9TUSkZNQM3mF3/918XbQTQUwRo57Zffr0WcG4Bx1sUwl9AJqdqE5sBomNDv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719405803; c=relaxed/simple;
	bh=0KBbkZOkU/9DKXGBBEBZhNyYUL0qU5jUJhKA8n7xAWI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IJf/oOTlq+mq5gn+q4yZCMKOB0sU2mxVlV4prILF5W54+/5EHw+WQbfPjt1YmovllXHwDIzHLcBVTPLxPXqjA4VHbZIxifrM2koT0V7o3VqLppslsFY+sJ8yQxG+OIlRdXDsXn95x3edsqkPSxBXLIYKDFmsbpONJCBTadQiFVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=ssLres26; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=YDpUXkqs; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 39C3E2185;
	Wed, 26 Jun 2024 12:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1719405316;
	bh=kJUQ7iYRZ0hXJu2JAR0JVDSRh8+wY9bi+JC0teWagU0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ssLres26dc8x978AzoD9GPtHcKjtqJi6ptkFhurDgaeoLaPJZHhUe691ePpXRobA1
	 cWqPCcDHji3/5ebKDv5YyS9xyBHSjGDug9uQndlBBeICsg+OY1+0KbVoDl3OvZu0RI
	 ueBQOl9g9h9dfEIRt+V6+rIv26NRdpw3eF1o5lwE=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 63B323E3;
	Wed, 26 Jun 2024 12:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1719405799;
	bh=kJUQ7iYRZ0hXJu2JAR0JVDSRh8+wY9bi+JC0teWagU0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=YDpUXkqsrXXPUByp3RL3b2GOyBDSXICKDsDFgW78hldXokBpuAvDMl+KeX379PDKx
	 5FXin4olU59+Ml31WFa0FOXBFMST7DNCwYNIFNT52yynE03nCTCso4re783e5k9dDl
	 awPMPEWFWDehwYXTh5kjo1uIdW5KOGhCuarQa7dY=
Received: from ntfs3vm.paragon-software.com (192.168.211.129) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 26 Jun 2024 15:43:18 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 08/11] fs/ntfs3: Use function file_inode to get inode from file
Date: Wed, 26 Jun 2024 15:42:55 +0300
Message-ID: <20240626124258.7264-9-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626124258.7264-1-almaz.alexandrovich@paragon-software.com>
References: <20240626124258.7264-1-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/file.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 35ca0f201cb8..2ceb762dc679 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -253,8 +253,7 @@ static int ntfs_zero_range(struct inode *inode, u64 vbo, u64 vbo_to)
  */
 static int ntfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	struct address_space *mapping = file->f_mapping;
-	struct inode *inode = mapping->host;
+	struct inode *inode = file_inode(file);
 	struct ntfs_inode *ni = ntfs_i(inode);
 	u64 from = ((u64)vma->vm_pgoff << PAGE_SHIFT);
 	bool rw = vma->vm_flags & VM_WRITE;
@@ -428,7 +427,7 @@ static int ntfs_truncate(struct inode *inode, loff_t new_size)
  */
 static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
 {
-	struct inode *inode = file->f_mapping->host;
+	struct inode *inode = file_inode(file);
 	struct address_space *mapping = inode->i_mapping;
 	struct super_block *sb = inode->i_sb;
 	struct ntfs_sb_info *sbi = sb->s_fs_info;
@@ -741,7 +740,7 @@ int ntfs3_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 static ssize_t ntfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct file *file = iocb->ki_filp;
-	struct inode *inode = file->f_mapping->host;
+	struct inode *inode = file_inode(file);
 	struct ntfs_inode *ni = ntfs_i(inode);
 
 	if (unlikely(ntfs3_forced_shutdown(inode->i_sb)))
@@ -778,7 +777,7 @@ static ssize_t ntfs_file_splice_read(struct file *in, loff_t *ppos,
 				     struct pipe_inode_info *pipe, size_t len,
 				     unsigned int flags)
 {
-	struct inode *inode = in->f_mapping->host;
+	struct inode *inode = file_inode(in);
 	struct ntfs_inode *ni = ntfs_i(inode);
 
 	if (unlikely(ntfs3_forced_shutdown(inode->i_sb)))
@@ -1073,8 +1072,7 @@ static ssize_t ntfs_compress_write(struct kiocb *iocb, struct iov_iter *from)
 static ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
-	struct address_space *mapping = file->f_mapping;
-	struct inode *inode = mapping->host;
+	struct inode *inode = file_inode(file);
 	ssize_t ret;
 	int err;
 	struct ntfs_inode *ni = ntfs_i(inode);
-- 
2.34.1


