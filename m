Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB102439C44
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 19:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbhJYRC1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 13:02:27 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:49504 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234223AbhJYRCV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 13:02:21 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 8FA941D0D;
        Mon, 25 Oct 2021 19:59:57 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1635181197;
        bh=MYUlt7o4yRFISIcaO8HcKahOikdAwW2jwE0135lqIck=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=fyji/GhNjVvTFpjF8h9s8F5Na7JPgr03RPn5+Y4S1CtyBBczaH1n/GyaINEmypZpk
         71/ZDC2aBMNnl6vXp+VtvRGhP22qk/MWPj0QHA2l9z+3CCPl7jCZbgnBbi1vRWna5e
         fEUVevV7GnpUj3ggSA19xrZNJvkWsJ8UHulVLQXE=
Received: from [192.168.211.155] (192.168.211.155) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 25 Oct 2021 19:59:57 +0300
Message-ID: <600c92df-35e9-2686-52f3-5129ccf30e5e@paragon-software.com>
Date:   Mon, 25 Oct 2021 19:59:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: [PATCH 4/4] fs/ntfs3: Update valid size if -EIOCBQUEUED
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <25b9a1b5-7738-7b36-7ead-c8faa7cacc87@paragon-software.com>
In-Reply-To: <25b9a1b5-7738-7b36-7ead-c8faa7cacc87@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.155]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Update valid size if write is still in I/O queue.
Fixes xfstest generic/240
Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/inode.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 859951d785cb..c211c64e6b17 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -757,6 +757,7 @@ static ssize_t ntfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	loff_t vbo = iocb->ki_pos;
 	loff_t end;
 	int wr = iov_iter_rw(iter) & WRITE;
+	size_t iter_count = iov_iter_count(iter);
 	loff_t valid;
 	ssize_t ret;
 
@@ -770,10 +771,14 @@ static ssize_t ntfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 				 wr ? ntfs_get_block_direct_IO_W
 				    : ntfs_get_block_direct_IO_R);
 
-	if (ret <= 0)
+	if (ret > 0)
+		end = vbo + ret;
+	else if (wr && -EIOCBQUEUED == ret)
+		end = vbo + iter_count;
+	else {
 		goto out;
+	}
 
-	end = vbo + ret;
 	valid = ni->i_valid;
 	if (wr) {
 		if (end > valid && !S_ISBLK(inode->i_mode)) {
-- 
2.33.0


