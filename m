Return-Path: <linux-fsdevel+bounces-8551-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADB1838FF1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 14:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0AD71F21B72
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 13:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093FF5FDC8;
	Tue, 23 Jan 2024 13:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLSlpnws"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EA25F56D;
	Tue, 23 Jan 2024 13:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706016434; cv=none; b=NYK3N+FcKnWKv6aIIPGQxS0W33FHRecAZ12BO6SjfznRB3+HjT3Pt1RnWonRfKtfNeS214RCQpWDOraZSNFZZc1gr8kIA5/CbQaTfE2kbzQSyXG6Bt2OLfNuZ/B/Kxe03f7YDMz2GqIpdNefCI6vVhfE1Af1ZWZ9gPzDZUpU35g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706016434; c=relaxed/simple;
	bh=aoRa6WoG5i+Di7okNdGjfo3o4ssD1CbKdiTk98mMKuY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tt57sakkzr0owPTgbQip9rCLRBKys6GSbfS4njeM7kZQ6IHT4s388hSA767lBmLer2IE2Tt5YrFpNkvc+j0DKlr915EptsacOGLxL5InpHBymP2z3TlZu3V/sTIMRe16UMLSHOfjXQkfW+ziCpdaHKhpSS7CrlpPziIZ8/HrymA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLSlpnws; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FBD5C43390;
	Tue, 23 Jan 2024 13:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706016434;
	bh=aoRa6WoG5i+Di7okNdGjfo3o4ssD1CbKdiTk98mMKuY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CLSlpnws1wvTPqbDXDurgI11mO/yi0kEQJjEUwa4tYlJnKhrpWPYjDJLs6NL1xDak
	 iaM/LzmZWNiWB+0elzw3iNQObPMD9aE3rZmQ0FbVf675BqJZxMshsVr/Y1kg8BhmrQ
	 sy3ZLOxmw3kWb7ET0/CiQ4X3uNxEHFTXYOC7ABp2CAuopVJn2jOyUvGPbdmA2eYXBD
	 41MF9nKQ2g/Gi19CJ5Iup0TCf8LPfLBHAylaNgbfBJngwtVDkIp1Ntee0hQHOcgmIl
	 xdAXaqkYp84xuIrnEHizEbajA0/1+JwKSoklkfNLXW4HIWov0hWw+pNKhuJyt8gDW1
	 pGxR/P7ELb8og==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 23 Jan 2024 14:26:23 +0100
Subject: [PATCH v2 06/34] power: port block device access to file
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-vfs-bdev-file-v2-6-adbd023e19cc@kernel.org>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
In-Reply-To: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=2892; i=brauner@kernel.org;
 h=from:subject:message-id; bh=aoRa6WoG5i+Di7okNdGjfo3o4ssD1CbKdiTk98mMKuY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSu3zdP9Peb4/E5303t1W/WNRhOvHldWGvSme21c34ra
 JxKn8bk0FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARbU5Ghp1dfSut9fYcmabs
 cDviooN5qq+GwPcZx/uEdv06pu1obc7IMH/hQY5afY/468fWTHz32PTjV3nH492+e7a+DNDJ3On
 Uww4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/power/swap.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 6053ddddaf65..692f12fe60c1 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -222,7 +222,7 @@ int swsusp_swap_in_use(void)
  */
 
 static unsigned short root_swap = 0xffff;
-static struct bdev_handle *hib_resume_bdev_handle;
+static struct file *hib_resume_bdev_file;
 
 struct hib_bio_batch {
 	atomic_t		count;
@@ -276,7 +276,7 @@ static int hib_submit_io(blk_opf_t opf, pgoff_t page_off, void *addr,
 	struct bio *bio;
 	int error = 0;
 
-	bio = bio_alloc(hib_resume_bdev_handle->bdev, 1, opf,
+	bio = bio_alloc(file_bdev(hib_resume_bdev_file), 1, opf,
 			GFP_NOIO | __GFP_HIGH);
 	bio->bi_iter.bi_sector = page_off * (PAGE_SIZE >> 9);
 
@@ -357,14 +357,14 @@ static int swsusp_swap_check(void)
 		return res;
 	root_swap = res;
 
-	hib_resume_bdev_handle = bdev_open_by_dev(swsusp_resume_device,
+	hib_resume_bdev_file = bdev_file_open_by_dev(swsusp_resume_device,
 			BLK_OPEN_WRITE, NULL, NULL);
-	if (IS_ERR(hib_resume_bdev_handle))
-		return PTR_ERR(hib_resume_bdev_handle);
+	if (IS_ERR(hib_resume_bdev_file))
+		return PTR_ERR(hib_resume_bdev_file);
 
-	res = set_blocksize(hib_resume_bdev_handle->bdev, PAGE_SIZE);
+	res = set_blocksize(file_bdev(hib_resume_bdev_file), PAGE_SIZE);
 	if (res < 0)
-		bdev_release(hib_resume_bdev_handle);
+		fput(hib_resume_bdev_file);
 
 	return res;
 }
@@ -1523,10 +1523,10 @@ int swsusp_check(bool exclusive)
 	void *holder = exclusive ? &swsusp_holder : NULL;
 	int error;
 
-	hib_resume_bdev_handle = bdev_open_by_dev(swsusp_resume_device,
+	hib_resume_bdev_file = bdev_file_open_by_dev(swsusp_resume_device,
 				BLK_OPEN_READ, holder, NULL);
-	if (!IS_ERR(hib_resume_bdev_handle)) {
-		set_blocksize(hib_resume_bdev_handle->bdev, PAGE_SIZE);
+	if (!IS_ERR(hib_resume_bdev_file)) {
+		set_blocksize(file_bdev(hib_resume_bdev_file), PAGE_SIZE);
 		clear_page(swsusp_header);
 		error = hib_submit_io(REQ_OP_READ, swsusp_resume_block,
 					swsusp_header, NULL);
@@ -1551,11 +1551,11 @@ int swsusp_check(bool exclusive)
 
 put:
 		if (error)
-			bdev_release(hib_resume_bdev_handle);
+			fput(hib_resume_bdev_file);
 		else
 			pr_debug("Image signature found, resuming\n");
 	} else {
-		error = PTR_ERR(hib_resume_bdev_handle);
+		error = PTR_ERR(hib_resume_bdev_file);
 	}
 
 	if (error)
@@ -1570,12 +1570,12 @@ int swsusp_check(bool exclusive)
 
 void swsusp_close(void)
 {
-	if (IS_ERR(hib_resume_bdev_handle)) {
+	if (IS_ERR(hib_resume_bdev_file)) {
 		pr_debug("Image device not initialised\n");
 		return;
 	}
 
-	bdev_release(hib_resume_bdev_handle);
+	fput(hib_resume_bdev_file);
 }
 
 /**

-- 
2.43.0


