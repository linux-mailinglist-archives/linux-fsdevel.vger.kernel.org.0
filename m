Return-Path: <linux-fsdevel+bounces-28019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E038966157
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 14:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C524BB26BFC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 12:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A67E199952;
	Fri, 30 Aug 2024 12:07:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B57192D79
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2024 12:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725019625; cv=none; b=X/VYCyqkRQIB+xRJoKh8oheDhAQri3PS76KNm2rBC89m0ZOcnKrEpDKRICZJDuDWcy1bbFNVg9MHQWq/DSuS90yJ9XOgb58emUcMN8D5Rgg9xDd5ui3lnuBviBbhnYOV3BpZ/MLD/4X5nEtpvFbJDQ5kGuS6CL4cdYMnV2ej44U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725019625; c=relaxed/simple;
	bh=LphwCCDqq7AwNuPkXtZ7UjIFdQ6jygV+LRUjh4pHiVM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C/anFulvHL4dtPi6vmB4q6dukBQYbWDUZklEt0fTNOqZnEeMJfh/KBqOizh793QS+lY+Xs/z4s1TPULB6ZP7lUhf+uqpaWhkkubeGb6e7ye2nsr9G4nFV/xLUsDYBCaVFkGbpCOorCFjgMbns0Z+omRvl6skWEAOGla46vdMMEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WwH1t64H2z4f3n6h
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2024 20:06:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6F1731A1620
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2024 20:06:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBXzILdtdFmf3ORDA--.22708S4;
	Fri, 30 Aug 2024 20:06:58 +0800 (CST)
From: Yang Erkun <yangerkun@huaweicloud.com>
To: miklos@szeredi.hu,
	brauner@kernel.org,
	jack@suse.cz,
	amir73il@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	yangerkun@huawei.com,
	yangerkun@huaweicloud.com
Subject: [RFC PATCH] fuse: enable writeback cgroup to limit dirty page cache
Date: Fri, 30 Aug 2024 20:05:40 +0800
Message-Id: <20240830120540.2446680-1-yangerkun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXzILdtdFmf3ORDA--.22708S4
X-Coremail-Antispam: 1UD129KBjvJXoWxCFWxZF13Jr4fKry8Gr48JFb_yoW7JF18pF
	17Ka9xAr4fXrW7Wr92va1Dur13ta4xA3y09ryfGa1SvFnrtryY9asY93WUAr1FyrWkJrsF
	qr4jkryxWr1UKwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUBVbkUUU
	UU=
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

From: Yang Erkun <yangerkun@huawei.com>

Commit 3be5a52b30aa("fuse: support writable mmap") give a strict limit
for about 1% max dirty ratio for fuse to protect that fuse won't slow
down the hole system by hogging lots of dirty memory. It works well for
system without memcg. But now for system with memcg, since fuse does
not support writeback cgroup, this max dirty ratio won't work for the
memcg's max bytes.

So it seems reasonable to enable writeback cgroup for fuse. Same commit
as above shows why we manage wb's count within fuse itself. In order to
support writeback cgroup, we need inode_to_wb to find the right wb,
and this needs some locks to pretect it. We now choose
inode->i_mapping->i_pages.xa_lock to do this.

Signed-off-by: Yang Erkun <yangerkun@huawei.com>
---
 fs/fuse/file.c  | 33 ++++++++++++++++++++++++---------
 fs/fuse/inode.c |  3 ++-
 2 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index f39456c65ed7..4248eaf46c39 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1774,15 +1774,20 @@ static void fuse_writepage_finish(struct fuse_mount *fm,
 {
 	struct fuse_args_pages *ap = &wpa->ia.ap;
 	struct inode *inode = wpa->inode;
+	struct address_space *mapping = inode->i_mapping;
 	struct fuse_inode *fi = get_fuse_inode(inode);
-	struct backing_dev_info *bdi = inode_to_bdi(inode);
+	struct bdi_writeback *wb;
+	unsigned long flags;
 	int i;
 
+	xa_lock_irqsave(&mapping->i_pages, flags);
+	wb = inode_to_wb(inode);
 	for (i = 0; i < ap->num_pages; i++) {
-		dec_wb_stat(&bdi->wb, WB_WRITEBACK);
+		dec_wb_stat(wb, WB_WRITEBACK);
 		dec_node_page_state(ap->pages[i], NR_WRITEBACK_TEMP);
-		wb_writeout_inc(&bdi->wb);
+		wb_writeout_inc(wb);
 	}
+	xa_unlock_irqrestore(&mapping->i_pages, flags);
 	wake_up(&fi->page_waitq);
 }
 
@@ -2084,8 +2089,10 @@ static int fuse_writepage_locked(struct folio *folio)
 	ap->args.end = fuse_writepage_end;
 	wpa->inode = inode;
 
-	inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
+	xa_lock(&mapping->i_pages);
+	inc_wb_stat(inode_to_wb(inode), WB_WRITEBACK);
 	node_stat_add_folio(tmp_folio, NR_WRITEBACK_TEMP);
+	xa_unlock(&mapping->i_pages);
 
 	spin_lock(&fi->lock);
 	tree_insert(&fi->writepages, wpa);
@@ -2169,7 +2176,8 @@ static void fuse_writepages_send(struct fuse_fill_wb_data *data)
 static bool fuse_writepage_add(struct fuse_writepage_args *new_wpa,
 			       struct page *page)
 {
-	struct fuse_inode *fi = get_fuse_inode(new_wpa->inode);
+	struct inode *inode = new_wpa->inode;
+	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_writepage_args *tmp;
 	struct fuse_writepage_args *old_wpa;
 	struct fuse_args_pages *new_ap = &new_wpa->ia.ap;
@@ -2204,11 +2212,15 @@ static bool fuse_writepage_add(struct fuse_writepage_args *new_wpa,
 	spin_unlock(&fi->lock);
 
 	if (tmp) {
-		struct backing_dev_info *bdi = inode_to_bdi(new_wpa->inode);
+		struct address_space *mapping = inode->i_mapping;
+		struct bdi_writeback *wb;
 
-		dec_wb_stat(&bdi->wb, WB_WRITEBACK);
+		xa_lock(&mapping->i_pages);
+		wb = inode_to_wb(new_wpa->inode);
+		dec_wb_stat(wb, WB_WRITEBACK);
 		dec_node_page_state(new_ap->pages[0], NR_WRITEBACK_TEMP);
-		wb_writeout_inc(&bdi->wb);
+		wb_writeout_inc(wb);
+		xa_unlock(&mapping->i_pages);
 		fuse_writepage_free(new_wpa);
 	}
 
@@ -2256,6 +2268,7 @@ static int fuse_writepages_fill(struct folio *folio,
 	struct fuse_writepage_args *wpa = data->wpa;
 	struct fuse_args_pages *ap = &wpa->ia.ap;
 	struct inode *inode = data->inode;
+	struct address_space *mapping = inode->i_mapping;
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	struct page *tmp_page;
@@ -2319,8 +2332,10 @@ static int fuse_writepages_fill(struct folio *folio,
 	ap->descs[ap->num_pages].length = PAGE_SIZE;
 	data->orig_pages[ap->num_pages] = &folio->page;
 
-	inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
+	xa_lock(&mapping->i_pages);
+	inc_wb_stat(inode_to_wb(inode), WB_WRITEBACK);
 	inc_node_page_state(tmp_page, NR_WRITEBACK_TEMP);
+	xa_unlock(&mapping->i_pages);
 
 	err = 0;
 	if (data->wpa) {
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index d8ab4e93916f..71d08f0a8514 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1566,7 +1566,8 @@ static void fuse_sb_defaults(struct super_block *sb)
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
 	sb->s_time_gran = 1;
 	sb->s_export_op = &fuse_export_operations;
-	sb->s_iflags |= SB_I_IMA_UNVERIFIABLE_SIGNATURE;
+	sb->s_iflags |= SB_I_IMA_UNVERIFIABLE_SIGNATURE |
+			SB_I_CGROUPWB;
 	if (sb->s_user_ns != &init_user_ns)
 		sb->s_iflags |= SB_I_UNTRUSTED_MOUNTER;
 	sb->s_flags &= ~(SB_NOSEC | SB_I_VERSION);
-- 
2.39.2


