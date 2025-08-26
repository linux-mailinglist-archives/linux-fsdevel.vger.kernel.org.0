Return-Path: <linux-fsdevel+bounces-59236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C75B36E05
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 17:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A0B91BA8214
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB69A2FD1D6;
	Tue, 26 Aug 2025 15:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="rhBrX+W6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAE02D192B
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 15:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222856; cv=none; b=ktJzQlN6EHXAw0QS3/j1dd6K75eMirFZ83qEisI4v5MDX4xYomfOjcPdReVkc/3jV90nVEZ7pEcb/IaZIQ8dmRWjdhAUNcBK4xqyib4xjhZGWcQ1vBTKLXyvAqBhXnygmXDctSr5jwMv+u5jbVuvr5SwDcDltWi8JqmgvVqwDbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222856; c=relaxed/simple;
	bh=824s3eeNyPtqfPMcWFvG6qpWsh9sKBrHSzpVhkI4CHA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wjg3QeyaLoqgWqj8Yqd23vYTRKflmVawV3Pt4xsjibE8X09BB8EcwWVYJAYjcj+XNgdgAQUb55MeErNHLVnFbXujsFinqWaC1PD5tdSV3vMypLT+osH5OYfBpTxXe/1GJTj3GRieBM8h0jA4YOfH1kzpJE8Y/IQ508CRd0uUMlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=rhBrX+W6; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e95246bd5e8so3615654276.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 08:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222852; x=1756827652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FOHH5GxgumXNSgv4ws5caQ9qUmUz2v1LLekhwJWPqgQ=;
        b=rhBrX+W6C4K3I41wVrVmf+OKGbkRdx93AtalnWNvKaLxZXReAQ4OrZpiKdSStqEkPR
         kZzZH4pwl4rN4JkwMqPfs6N5OqC3f/10yGV9GoOw0SVJDabs+Fl9IbFl6TEllQTShOI5
         LNER1Bs+N1CbpV0HBKxX1OGmQUJc7YnsemktnS39ZrZ0+PtCeawlx2fIbOezIF+zUV3N
         J8oe22situQdTmTiobPiNW3U6i+GzrutZjm1AgCJwRqVBPEYqEKTCTNyfGvbDDcPgKlO
         zAv8wphWs2apXQnkyzwkl7EWE+6yyR6S+AJyPqlzs5K9Fmi2qUUXJnBvtTpKVnLeuNwy
         iATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222852; x=1756827652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FOHH5GxgumXNSgv4ws5caQ9qUmUz2v1LLekhwJWPqgQ=;
        b=WvS/VU4XLe1SSo28FeMjpBcUrL++y1+ACXliIFozyLJppJxCFy9FCh1eHsblENVC6p
         zRqxprsNYTjqTrhldb3kg0LtuXaFury4fqrWMXDPljDLkbTeWJX20MDUEhW3FMMskGhX
         EU96absynzsH+utQfrC+5jOniS40ADtC/nwMXCndIpK93t4yH2McnGDsTXtCdabH4Kjs
         cciaLsDKGhHG464vgt8xJU0RuPSTJixT+ej9JgeGwhU4nc08sgzaZVb50XMRDDAjF/VM
         YSY1/lkofeqSZBPoVTRg6wScxTMSKD0zLLM7xxlzhFbTE7bRVKMnCibuS2xEugW2bqYb
         LSrw==
X-Gm-Message-State: AOJu0Yzj0l9AaQb4Xtvju3sKRwmuQEoUiX9X0Dc5pIQM4wv8lrMdFX/m
	1kGfgLRLi9Hb85Y6D/LaiNaQ2mlm4gXQ72v9t26DjV8szxCydQ+FOR/2iwcyq7cA7AcLgkInwwX
	ok0sJ
X-Gm-Gg: ASbGnctPHmsDwT6QugznLs6LNuFFn0cBaAbSdg2cB46aEAE1Qk6zW3rpuONomxE/I14
	bJMRSfXRLzEISdPWDT9yzxwSmziXR0um7lcE5FzvZlfvKMm670GhD8IRpY3dXVWpjC3KQWyBgbv
	APbRuIvj1spVPiwUMPvVyFRHk5n82bXb5z1qlSdx1XI0C1TohcddXOTAjN1L3qWE1rZhbjf4jTv
	3JpqFMQjWdpUBxIqKilHw8EFyrgrZ9msi0GKTK0cc5Ck31CACK/O3qI8dReLbuuuYw/1NFyv35k
	DmAvfnQiJbBoldCxKXn8VjhCFzXXQSBSFXWlL1Rzd0B35MoSnbPITWGa1JSqbe8n4KydLj6CMbk
	5vx0bbav41KUwMywVTcdM5B2fbr9z/jjkhu3j9tuj9jZnNIIo6L4r/HBhi3t1BW5mdhFMdG5OCO
	AQnfJk
X-Google-Smtp-Source: AGHT+IHCkFxTVHekKtVIMKKoKBA/v/EmSAFjwci1Wt4iPVt6NciQDsFy301ND2wdcONLCbcSXMgElg==
X-Received: by 2002:a05:6902:2b03:b0:e95:1945:8672 with SMTP id 3f1490d57ef6-e951c2ce819mr17137482276.10.1756222852464;
        Tue, 26 Aug 2025 08:40:52 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e952c37715dsm3292356276.36.2025.08.26.08.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:40:51 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 03/54] fs: rework iput logic
Date: Tue, 26 Aug 2025 11:39:03 -0400
Message-ID: <be208b89bdb650202e712ce2bcfc407ac7044c7a.1756222464.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1756222464.git.josef@toxicpanda.com>
References: <cover.1756222464.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, if we are the last iput, and we have the I_DIRTY_TIME bit
set, we will grab a reference on the inode again and then mark it dirty
and then redo the put.  This is to make sure we delay the time update
for as long as possible.

We can rework this logic to simply dec i_count if it is not 1, and if it
is do the time update while still holding the i_count reference.

Then we can replace the atomic_dec_and_lock with locking the ->i_lock
and doing atomic_dec_and_test, since we did the atomic_add_unless above.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index a3673e1ed157..13e80b434323 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1911,16 +1911,21 @@ void iput(struct inode *inode)
 	if (!inode)
 		return;
 	BUG_ON(inode->i_state & I_CLEAR);
-retry:
-	if (atomic_dec_and_lock(&inode->i_count, &inode->i_lock)) {
-		if (inode->i_nlink && (inode->i_state & I_DIRTY_TIME)) {
-			atomic_inc(&inode->i_count);
-			spin_unlock(&inode->i_lock);
-			trace_writeback_lazytime_iput(inode);
-			mark_inode_dirty_sync(inode);
-			goto retry;
-		}
+
+	if (atomic_add_unless(&inode->i_count, -1, 1))
+		return;
+
+	if (inode->i_nlink && (inode->i_state & I_DIRTY_TIME)) {
+		trace_writeback_lazytime_iput(inode);
+		mark_inode_dirty_sync(inode);
+	}
+
+	spin_lock(&inode->i_lock);
+	if (atomic_dec_and_test(&inode->i_count)) {
+		/* iput_final() drops i_lock */
 		iput_final(inode);
+	} else {
+		spin_unlock(&inode->i_lock);
 	}
 }
 EXPORT_SYMBOL(iput);
-- 
2.49.0


