Return-Path: <linux-fsdevel+bounces-54397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA89FAFF472
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 00:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B97F81C47525
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 22:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CAA24888C;
	Wed,  9 Jul 2025 22:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0nDT+nP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEDE246772
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Jul 2025 22:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752099065; cv=none; b=HJJfmgDFG7BV+ZCdBYY5OtW94W+jQsJ/wMFKVpxOrewXwBvnljTSSkaCkhCzQwd6FVbekQZ3Wzr/GweAKxO0D8D45HZ/gDfAzJK5tsda4yFrvyi0V2CXXTb59xqJel6HMmE3eMO6CZ7FuDR/SVcO0YlzMQIInahAFmEtMi99zEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752099065; c=relaxed/simple;
	bh=XQdSchB9/JzO30t/zNt5aJcdl5F015EOrZOF2Ax/VxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jTCn/d92p0w3QuI62Ft4RsFuHwnGk/qNxflTO0D2eifK0X+uQRcmk+XQgotq1pe8b2OC6NH7ew/0LnIh2Cbs/A/AasCWLyBPw2Z/TaIwBW8RqCchWI1eSsfClOhcM2jmjxyfjC910s/Gd+v9HzT4zNDl79giwUTQ7mALE0d0Ot0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0nDT+nP; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-748e81d37a7so284334b3a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Jul 2025 15:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752099063; x=1752703863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z7ScIKlzoCS+2L+IGvGBwiJNRRNNJPRrRpaoSYGo6SQ=;
        b=C0nDT+nPk2dJ13+R0GiBvO63uhqqgOXeusFGYP+BxOkN0QIN9s/xlZR9R6Zc0BFDYO
         29/IccHRk4/5JjSDLE5CkWZPzYFLp9rNdhZ23HJQ0GMhk1SEhuA6XO+giq6js1yffzXg
         /Y/xZMo8TN2Hpnv6UmBYrDBuvjv4JpedvdsPzbd5s2CR4Gq9RlrRkX2yR9vvchGvtor1
         5FGpQ+Q1zQL/Ac5LIdiTBbVbr9HLKCA0ga2jSkj8vl2mGY9tZaxNUp2IlrsQgLrWD3pr
         i09cGuy4PGl2Xv3qpfTqxE/hFcumfj8mDcvqQ4ktpvxCTwW4ItU3QnnZM700ozq2FnQF
         yPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752099063; x=1752703863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z7ScIKlzoCS+2L+IGvGBwiJNRRNNJPRrRpaoSYGo6SQ=;
        b=Fpw1tJWW+uDwq0ODc+8iASjXm7kKEW+f5XoGwwdEDkoPS+UXDU5ifqnlMSku6mt069
         DOFa9hyM6dLBSLHruFoRjakb/3WQhIfbmbncx3C4+zTZPlMChalHMXMXztjLv942jeCw
         tvl0JaGlfIkkhtw6CtFyg1fXRqpJnOADhOhTtI//cCQ3Rvfk31xvYuSWrOiso/NxWd5S
         CVi6ELstjjNlpTJrZRy4P/B2hE6xLHLj1ihAiqUK77ktbBu8uEQSeMQSEOPpvQaF9s3/
         bGn7tJsslGtfr+YPTzNdHd5wPSlv/84unvH+lUysKopQFtHMld/DDRwrCw5vazC+7til
         sraQ==
X-Gm-Message-State: AOJu0Yy5ufXofLiGht68gfASmVm2FeJ9Ceyl2A226TjehqRgp07JNwDb
	n4+gpxErss49imu3Ux9wJ4XH4mBBi2D931/5MvDzYASBymYyVC8g9GQXrYh0bA==
X-Gm-Gg: ASbGncvmrqULcy91sCQCLalYF9VyUiHOpFX/k4D6MClmC7boXf3ya4O5BrkOOu/IVUp
	DPpEsKAbsGxIjXq2a8S38KBESwXcO2F5V7hhZluPVuhcGBg44RAj9zFr0dQzeYoyd/0OOqprX+j
	IbteyZ40CjshKdNzzBX9eyyLKkKzI/AnxQHeeYK1ubQHJipiPrhVP2j7g6vaE8OquSRHnNNu/qq
	XrjT7dptAposVp0kgTJ7t9l6N7nf4smVPNem7aroxJA3QL2cVYC5ivGO4W2c803DPlssX5c4B1N
	JwsSFmFUqSc4gioUyVFf/0YEGnvkV7/J2NoForVlFL9ilsZg1tQxqNsTi6AC
X-Google-Smtp-Source: AGHT+IGI/voCEthVJxSdiNj6gLD1V8BLPZ2ZjXuorAJHW5xalQB4pbIivms3U5WHwH7OB7gyDwcZlg==
X-Received: by 2002:a05:6a21:998c:b0:21c:fa68:c33a with SMTP id adf61e73a8af0-22fb5af82dbmr1994012637.23.1752099062887;
        Wed, 09 Jul 2025 15:11:02 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe5baf70sm228370a12.32.2025.07.09.15.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 15:11:02 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: hch@lst.de,
	miklos@szeredi.hu,
	brauner@kernel.org,
	djwong@kernel.org,
	anuj20.g@samsung.com,
	kernel-team@meta.com
Subject: [PATCH v4 3/5] fuse: use iomap for folio laundering
Date: Wed,  9 Jul 2025 15:10:21 -0700
Message-ID: <20250709221023.2252033-4-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250709221023.2252033-1-joannelkoong@gmail.com>
References: <20250709221023.2252033-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use iomap for folio laundering, which will do granular dirty
writeback when laundering a large folio.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/file.c | 52 ++++++++++++--------------------------------------
 1 file changed, 12 insertions(+), 40 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 70bbc8f26459..d7ee03fdccee 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2057,45 +2057,6 @@ static struct fuse_writepage_args *fuse_writepage_args_setup(struct folio *folio
 	return wpa;
 }
 
-static int fuse_writepage_locked(struct folio *folio)
-{
-	struct address_space *mapping = folio->mapping;
-	struct inode *inode = mapping->host;
-	struct fuse_inode *fi = get_fuse_inode(inode);
-	struct fuse_writepage_args *wpa;
-	struct fuse_args_pages *ap;
-	struct fuse_file *ff;
-	int error = -EIO;
-
-	ff = fuse_write_file_get(fi);
-	if (!ff)
-		goto err;
-
-	wpa = fuse_writepage_args_setup(folio, 0, ff);
-	error = -ENOMEM;
-	if (!wpa)
-		goto err_writepage_args;
-
-	ap = &wpa->ia.ap;
-	ap->num_folios = 1;
-
-	folio_start_writeback(folio);
-	fuse_writepage_args_page_fill(wpa, folio, 0, 0, folio_size(folio));
-
-	spin_lock(&fi->lock);
-	list_add_tail(&wpa->queue_entry, &fi->queued_writes);
-	fuse_flush_writepages(inode);
-	spin_unlock(&fi->lock);
-
-	return 0;
-
-err_writepage_args:
-	fuse_file_put(ff, false);
-err:
-	mapping_set_error(folio->mapping, error);
-	return error;
-}
-
 struct fuse_fill_wb_data {
 	struct fuse_writepage_args *wpa;
 	struct fuse_file *ff;
@@ -2275,8 +2236,19 @@ static int fuse_writepages(struct address_space *mapping,
 static int fuse_launder_folio(struct folio *folio)
 {
 	int err = 0;
+	struct fuse_fill_wb_data data = {
+		.inode = folio->mapping->host,
+	};
+	struct iomap_writepage_ctx wpc = {
+		.inode = folio->mapping->host,
+		.iomap.type = IOMAP_MAPPED,
+		.ops = &fuse_writeback_ops,
+		.wb_ctx	= &data,
+	};
+
 	if (folio_clear_dirty_for_io(folio)) {
-		err = fuse_writepage_locked(folio);
+		err = iomap_writeback_folio(&wpc, folio);
+		err = fuse_iomap_writeback_submit(&wpc, err);
 		if (!err)
 			folio_wait_writeback(folio);
 	}
-- 
2.47.1


