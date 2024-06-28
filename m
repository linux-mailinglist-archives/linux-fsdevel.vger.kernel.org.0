Return-Path: <linux-fsdevel+bounces-22730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C57991B71D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 08:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F6FAB20C50
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 06:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA307768EC;
	Fri, 28 Jun 2024 06:31:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E13B6F06D;
	Fri, 28 Jun 2024 06:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719556267; cv=none; b=qlTOlPH6XIWoRytFGdudIgN9FXr2u1rrF/HHQrBYY7yauFNi72/dPzcygZfSxjYaW2iCaweGvM25m9Z4G/+q5kWV7UjDzd+WGPB8rjuK3Hw0ozAqyFkNvkXODsuV4n0kw6c5jNQcvj4OLR64nZ1fgQFunJB3Sgv2GyptakhnQtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719556267; c=relaxed/simple;
	bh=VMyV4O0kbUPDmFWXi2NzOSJgaqPpQCNhuZ8xYy4fK68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LV9XqqTr9keyQHm8WSPTRgXfqHXHgeDQKu1gLdvxozu1sJ6nHstbQYQQVRUBqSgDaFeHA9v5SFBXy3Zml91TaWoD0Orkk4yLnnl/PymO4VFMK18KCuJpRMHmPQHEj+01HjHRRWgOfiR2/mO4KZA1dBUgbwTlRWocaaTqKdoLc9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4W9QYR3Zlxz4f3jrd;
	Fri, 28 Jun 2024 14:30:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 6C96F1A058E;
	Fri, 28 Jun 2024 14:31:02 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP2 (Coremail) with SMTP id Syh0CgBXwIWfWH5mZZVAAg--.52859S8;
	Fri, 28 Jun 2024 14:31:02 +0800 (CST)
From: libaokun@huaweicloud.com
To: netfs@lists.linux.dev,
	dhowells@redhat.com,
	jlayton@kernel.org
Cc: hsiangkao@linux.alibaba.com,
	jefflexu@linux.alibaba.com,
	zhujia.zj@bytedance.com,
	linux-erofs@lists.ozlabs.org,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	libaokun@huaweicloud.com,
	yangerkun@huawei.com,
	houtao1@huawei.com,
	yukuai3@huawei.com,
	wozizhi@huawei.com,
	Baokun Li <libaokun1@huawei.com>
Subject: [PATCH v3 4/9] cachefiles: propagate errors from vfs_getxattr() to avoid infinite loop
Date: Fri, 28 Jun 2024 14:29:25 +0800
Message-Id: <20240628062930.2467993-5-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240628062930.2467993-1-libaokun@huaweicloud.com>
References: <20240628062930.2467993-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBXwIWfWH5mZZVAAg--.52859S8
X-Coremail-Antispam: 1UD129KBjvJXoW7tFWrCw4xuryruryfCFykKrg_yoW8ZrWkpF
	Wa9F18Ary8ur48Gr1kAFs8Jw1F934UJ3Wqvw1UW34Ivw1kX34rXry3tr1YvF1UCrW8twsr
	ta15CFy3try5A3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6r
	xdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7M4kE6xkIj40Ew7xC0wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8
	JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1V
	AFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
	8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73
	UjIFyTuYvjfUYGYpUUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAIBV1jkH-xJQAAsJ

From: Baokun Li <libaokun1@huawei.com>

In cachefiles_check_volume_xattr(), the error returned by vfs_getxattr()
is not passed to ret, so it ends up returning -ESTALE, which leads to an
endless loop as follows:

cachefiles_acquire_volume
retry:
  ret = cachefiles_check_volume_xattr
    ret = -ESTALE
    xlen = vfs_getxattr // return -EIO
    // The ret is not updated when xlen < 0, so -ESTALE is returned.
    return ret
  // Supposed to jump out of the loop at this judgement.
  if (ret != -ESTALE)
      goto error_dir;
  cachefiles_bury_object
    //  EIO causes rename failure
  goto retry;

Hence propagate the error returned by vfs_getxattr() to avoid the above
issue. Do the same in cachefiles_check_auxdata().

Fixes: 32e150037dce ("fscache, cachefiles: Store the volume coherency data")
Fixes: 72b957856b0c ("cachefiles: Implement metadata/coherency data storage in xattrs")
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/cachefiles/xattr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
index bcb6173943ee..4dd8a993c60a 100644
--- a/fs/cachefiles/xattr.c
+++ b/fs/cachefiles/xattr.c
@@ -110,9 +110,11 @@ int cachefiles_check_auxdata(struct cachefiles_object *object, struct file *file
 	if (xlen == 0)
 		xlen = vfs_getxattr(&nop_mnt_idmap, dentry, cachefiles_xattr_cache, buf, tlen);
 	if (xlen != tlen) {
-		if (xlen < 0)
+		if (xlen < 0) {
+			ret = xlen;
 			trace_cachefiles_vfs_error(object, file_inode(file), xlen,
 						   cachefiles_trace_getxattr_error);
+		}
 		if (xlen == -EIO)
 			cachefiles_io_error_obj(
 				object,
@@ -252,6 +254,7 @@ int cachefiles_check_volume_xattr(struct cachefiles_volume *volume)
 		xlen = vfs_getxattr(&nop_mnt_idmap, dentry, cachefiles_xattr_cache, buf, len);
 	if (xlen != len) {
 		if (xlen < 0) {
+			ret = xlen;
 			trace_cachefiles_vfs_error(NULL, d_inode(dentry), xlen,
 						   cachefiles_trace_getxattr_error);
 			if (xlen == -EIO)
-- 
2.39.2


