Return-Path: <linux-fsdevel+bounces-7187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30212822DA5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 13:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4EFF283BD9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 12:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23E01A27E;
	Wed,  3 Jan 2024 12:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwfRSoXP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3556319BCA;
	Wed,  3 Jan 2024 12:55:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74B90C433C9;
	Wed,  3 Jan 2024 12:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704286541;
	bh=HdL7l0XFXtIix3/XTatQNJYZC7y762IMtLbRHvdEu3o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PwfRSoXPlt7OsW5sEPSWtsrqEKk/kCP4b+b2pr6oDyWGoNOgNQddrueE5nXJNfxxY
	 RMm/pye5ZyU0xxdCvGQUXdqqFm1fsCgQTzwtL8mR5MHLw9Q3/rtiF7oPFLFkU1okB4
	 ixga5pg+3HiutqEzb+6gEmi0h7ZaXuT8INTqmTIXM6hpEwuyUwwuihsNyPQDuAEOUf
	 D8USJvq6FTbSEgKlqmCy8q5fF8xucqNoZKZ9mPTgRJqRTC217f5tVR+iuSGJ2hsCT7
	 zu7DWvx/8q/+955c8zZGLPfHqtnDhiLSXmGRoYwP5litviMol3vmzaYs12DKUcrALm
	 1CZowBlIn36HA==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 03 Jan 2024 13:55:04 +0100
Subject: [PATCH RFC 06/34] power: port block device access to file
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240103-vfs-bdev-file-v1-6-6c8ee55fb6ef@kernel.org>
References: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
In-Reply-To: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=2841; i=brauner@kernel.org;
 h=from:subject:message-id; bh=HdL7l0XFXtIix3/XTatQNJYZC7y762IMtLbRHvdEu3o=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaROjbTZ2ZMzqYwxKkNh32rd0OXhj5QnuKV8nXSz81xG/
 9xfWwI3dZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzErZaR4e/Wv5sfFyZuYXTW
 E0q1Psr/QXrGOsNZHxe+v/H4uFpkRScjwwK1HYd2vPPt5p5xI+nJqQOuHDV8DdypD+dU5f/Qz1V
 J5wQA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/power/swap.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index a2cb0babb5ec..e363c80d6259 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -222,7 +222,7 @@ int swsusp_swap_in_use(void)
  */
 
 static unsigned short root_swap = 0xffff;
-static struct bdev_handle *hib_resume_bdev_handle;
+static struct file *hib_resume_f_bdev;
 
 struct hib_bio_batch {
 	atomic_t		count;
@@ -276,7 +276,7 @@ static int hib_submit_io(blk_opf_t opf, pgoff_t page_off, void *addr,
 	struct bio *bio;
 	int error = 0;
 
-	bio = bio_alloc(hib_resume_bdev_handle->bdev, 1, opf,
+	bio = bio_alloc(F_BDEV(hib_resume_f_bdev), 1, opf,
 			GFP_NOIO | __GFP_HIGH);
 	bio->bi_iter.bi_sector = page_off * (PAGE_SIZE >> 9);
 
@@ -357,14 +357,14 @@ static int swsusp_swap_check(void)
 		return res;
 	root_swap = res;
 
-	hib_resume_bdev_handle = bdev_open_by_dev(swsusp_resume_device,
+	hib_resume_f_bdev = bdev_file_open_by_dev(swsusp_resume_device,
 			BLK_OPEN_WRITE, NULL, NULL);
-	if (IS_ERR(hib_resume_bdev_handle))
-		return PTR_ERR(hib_resume_bdev_handle);
+	if (IS_ERR(hib_resume_f_bdev))
+		return PTR_ERR(hib_resume_f_bdev);
 
-	res = set_blocksize(hib_resume_bdev_handle->bdev, PAGE_SIZE);
+	res = set_blocksize(F_BDEV(hib_resume_f_bdev), PAGE_SIZE);
 	if (res < 0)
-		bdev_release(hib_resume_bdev_handle);
+		fput(hib_resume_f_bdev);
 
 	return res;
 }
@@ -1523,10 +1523,10 @@ int swsusp_check(bool exclusive)
 	void *holder = exclusive ? &swsusp_holder : NULL;
 	int error;
 
-	hib_resume_bdev_handle = bdev_open_by_dev(swsusp_resume_device,
+	hib_resume_f_bdev = bdev_file_open_by_dev(swsusp_resume_device,
 				BLK_OPEN_READ, holder, NULL);
-	if (!IS_ERR(hib_resume_bdev_handle)) {
-		set_blocksize(hib_resume_bdev_handle->bdev, PAGE_SIZE);
+	if (!IS_ERR(hib_resume_f_bdev)) {
+		set_blocksize(F_BDEV(hib_resume_f_bdev), PAGE_SIZE);
 		clear_page(swsusp_header);
 		error = hib_submit_io(REQ_OP_READ, swsusp_resume_block,
 					swsusp_header, NULL);
@@ -1551,11 +1551,11 @@ int swsusp_check(bool exclusive)
 
 put:
 		if (error)
-			bdev_release(hib_resume_bdev_handle);
+			fput(hib_resume_f_bdev);
 		else
 			pr_debug("Image signature found, resuming\n");
 	} else {
-		error = PTR_ERR(hib_resume_bdev_handle);
+		error = PTR_ERR(hib_resume_f_bdev);
 	}
 
 	if (error)
@@ -1571,12 +1571,12 @@ int swsusp_check(bool exclusive)
 
 void swsusp_close(void)
 {
-	if (IS_ERR(hib_resume_bdev_handle)) {
+	if (IS_ERR(hib_resume_f_bdev)) {
 		pr_debug("Image device not initialised\n");
 		return;
 	}
 
-	bdev_release(hib_resume_bdev_handle);
+	fput(hib_resume_f_bdev);
 }
 
 /**

-- 
2.42.0


