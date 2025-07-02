Return-Path: <linux-fsdevel+bounces-53724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E7BAF63D0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 23:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E5A11C4377B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 21:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D523323A997;
	Wed,  2 Jul 2025 21:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="IN+Yd19C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFE7264A89;
	Wed,  2 Jul 2025 21:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751490914; cv=none; b=V45YNd6NUvQSZYSyldOozKz1PRyX23CD6SFDT8c7t0fwQ9vRj8eq8pWBe7MpMMFQ8psdZC59mDML5EsUCWBK8obPxX2fZbGCP2U06VMCmwqjgo1mbZicdyzyTUIJhY0PNhsXJ+a8zzDVlY4eMqMfsAHLcoMbQKv31Ur/a1X6p7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751490914; c=relaxed/simple;
	bh=pXbIGt9AdpARCGxDHTJcCyjIJt/dHLR0oRy4cVSbSLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GFP/DWgnriqk/xOgq5GGFDKTrqYBXYDIMuI6fyIl2/wLMPoD3ROCSpg+RPgRvjD1josuOJkDSFfC9PX1xnsMmmrPxyRRCv1CERflBI4nok/pWysf63vUt68Bj7JzmdAkhGKymHe8K89dXodzpQGUMjRvxQ+2LeUx5Gck58SByhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=IN+Yd19C; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=p7czweD6C0ka7ng/WkdftOkrikb1edQF1j9EUnZwpSQ=; b=IN+Yd19C4+MEc3kgY38/8JwnYb
	RokVr2+y3jj+8hqk+35nDTry2AhU33nLIHcerTTiVQNMY3oV76oSrXi2Xx09G9l5fRiutL2V8HewG
	VA/iqi/lZ3rt8wq70tryP7C7WtU6RRaOcDIyRe/QbEbyWH2G+EhCe3NHwauWBGmGMgwBxWwqYuLDi
	v9SGDzTwVa5aWaYXNaPkJGz26C/78UvvWE40dkX3rcRPUku1DUvrECzRJTR24PDwUFSU04IcVjjFL
	T5PBljtMXM6CJ74AKd3ICNoSHK63M7ivcwOeM9teqPRU206tZeBM0nKJS9cd6sjgTQbAfi8ms+WTk
	lDN+UjMQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uX4nM-0000000EJB5-44Hm;
	Wed, 02 Jul 2025 21:15:09 +0000
Date: Wed, 2 Jul 2025 22:15:08 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: [PATCH 02/11] hfi1: get rid of redundant debugfs_file_{get,put}()
Message-ID: <20250702211508.GB3406663@ZenIV>
References: <20250702211305.GE1880847@ZenIV>
 <20250702211408.GA3406663@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702211408.GA3406663@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

All files in question are created via debugfs_create_file(), so
exclusion with removals is provided by debugfs wrappers; as the matter
of fact, hfi1-private wrappers had been redundant at least since 2017...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/infiniband/hw/hfi1/debugfs.c | 28 ----------------------------
 drivers/infiniband/hw/hfi1/debugfs.h |  9 ++-------
 drivers/infiniband/hw/hfi1/fault.c   |  9 ---------
 3 files changed, 2 insertions(+), 44 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/debugfs.c b/drivers/infiniband/hw/hfi1/debugfs.c
index a1e01b447265..ac37ab7f8995 100644
--- a/drivers/infiniband/hw/hfi1/debugfs.c
+++ b/drivers/infiniband/hw/hfi1/debugfs.c
@@ -22,34 +22,6 @@
 
 static struct dentry *hfi1_dbg_root;
 
-/* wrappers to enforce srcu in seq file */
-ssize_t hfi1_seq_read(struct file *file, char __user *buf, size_t size,
-		      loff_t *ppos)
-{
-	struct dentry *d = file->f_path.dentry;
-	ssize_t r;
-
-	r = debugfs_file_get(d);
-	if (unlikely(r))
-		return r;
-	r = seq_read(file, buf, size, ppos);
-	debugfs_file_put(d);
-	return r;
-}
-
-loff_t hfi1_seq_lseek(struct file *file, loff_t offset, int whence)
-{
-	struct dentry *d = file->f_path.dentry;
-	loff_t r;
-
-	r = debugfs_file_get(d);
-	if (unlikely(r))
-		return r;
-	r = seq_lseek(file, offset, whence);
-	debugfs_file_put(d);
-	return r;
-}
-
 #define private2dd(file) (file_inode(file)->i_private)
 #define private2ppd(file) (file_inode(file)->i_private)
 
diff --git a/drivers/infiniband/hw/hfi1/debugfs.h b/drivers/infiniband/hw/hfi1/debugfs.h
index 54d952a4016c..65b48839abc6 100644
--- a/drivers/infiniband/hw/hfi1/debugfs.h
+++ b/drivers/infiniband/hw/hfi1/debugfs.h
@@ -33,16 +33,11 @@ static int _##name##_open(struct inode *inode, struct file *s) \
 static const struct file_operations _##name##_file_ops = { \
 	.owner   = THIS_MODULE, \
 	.open    = _##name##_open, \
-	.read    = hfi1_seq_read, \
-	.llseek  = hfi1_seq_lseek, \
+	.read    = seq_read, \
+	.llseek  = seq_lseek, \
 	.release = seq_release \
 }
 
-
-ssize_t hfi1_seq_read(struct file *file, char __user *buf, size_t size,
-		      loff_t *ppos);
-loff_t hfi1_seq_lseek(struct file *file, loff_t offset, int whence);
-
 #ifdef CONFIG_DEBUG_FS
 void hfi1_dbg_ibdev_init(struct hfi1_ibdev *ibd);
 void hfi1_dbg_ibdev_exit(struct hfi1_ibdev *ibd);
diff --git a/drivers/infiniband/hw/hfi1/fault.c b/drivers/infiniband/hw/hfi1/fault.c
index ec9ee59fcf0c..a45cbffd52c7 100644
--- a/drivers/infiniband/hw/hfi1/fault.c
+++ b/drivers/infiniband/hw/hfi1/fault.c
@@ -104,9 +104,6 @@ static ssize_t fault_opcodes_write(struct file *file, const char __user *buf,
 		goto free_data;
 	}
 
-	ret = debugfs_file_get(file->f_path.dentry);
-	if (unlikely(ret))
-		goto free_data;
 	ptr = data;
 	token = ptr;
 	for (ptr = data; *ptr; ptr = end + 1, token = ptr) {
@@ -154,7 +151,6 @@ static ssize_t fault_opcodes_write(struct file *file, const char __user *buf,
 	}
 	ret = len;
 
-	debugfs_file_put(file->f_path.dentry);
 free_data:
 	kfree(data);
 	return ret;
@@ -173,9 +169,6 @@ static ssize_t fault_opcodes_read(struct file *file, char __user *buf,
 	data = kcalloc(datalen, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
-	ret = debugfs_file_get(file->f_path.dentry);
-	if (unlikely(ret))
-		goto free_data;
 	bit = find_first_bit(fault->opcodes, bitsize);
 	while (bit < bitsize) {
 		zero = find_next_zero_bit(fault->opcodes, bitsize, bit);
@@ -189,11 +182,9 @@ static ssize_t fault_opcodes_read(struct file *file, char __user *buf,
 					 bit);
 		bit = find_next_bit(fault->opcodes, bitsize, zero);
 	}
-	debugfs_file_put(file->f_path.dentry);
 	data[size - 1] = '\n';
 	data[size] = '\0';
 	ret = simple_read_from_buffer(buf, len, pos, data, size);
-free_data:
 	kfree(data);
 	return ret;
 }
-- 
2.39.5


