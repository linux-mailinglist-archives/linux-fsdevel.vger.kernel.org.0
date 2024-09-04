Return-Path: <linux-fsdevel+bounces-28648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4864196C88A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 22:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E799F1F27ED9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 20:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA65C1E8B84;
	Wed,  4 Sep 2024 20:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="xozlLTnA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEABC1E8B74
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 20:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725481782; cv=none; b=E1cGj0EbRMeRf5+83x4e/V8yHrsUEB9bNYAyrYVNqo1KaQad4ymD/v2h3tExA2OTKpIs7nP/UjpWijkAaaQluw1Her2jMvLu/rHB7R04Xj+yQSrGpEmK+U/kQxDKncm+Al/y+9Ewgq2qO8ZlNsqFnP/FvU2ozUtunNTYy01daS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725481782; c=relaxed/simple;
	bh=v+fnUlVkBveqAbvI7nBD4gzaysdb8UjtocYcN6UQfDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q7MdXFYDaYW+5zloqr3qUDVI1GgvcInUJL0y0qHq81CGE2esDZ29CUvB4kJy2DPXs6fHHqwNF6hBilSdfAqxueQqmX+eayHm8xHVO/yQan8QffHjdYY/G/lDfJcE04HOQYnU6r6S6klzei4vNrqBvNcoHNvMTyED0JTxk1V2O1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=xozlLTnA; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6c35a23b378so42106d6.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Sep 2024 13:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1725481779; x=1726086579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RWEHhx5O7UFZKYepru/YJGo3B9Ht5vMlNzII31DWFDk=;
        b=xozlLTnAjOeOnOKBTmkEKY5eiNLyE1DduiUA6ApFLdwrnnvNFW1nGyubeZi+xjwymX
         C4qovljpGP7v9hCBKEe66utga9gbgkPNgls1hAucRI3DGMQ7wVf7ZdfWfxm2EeRwxTK/
         rb7w/8gMh+e2Bt9XBgFDDrnL9tBGOY6cMgHQpFe4J0KMtRQ6uGZY2qUErkA1aEJyYnAE
         sr+0/XNRKG0Lc7tSg9WV5aLIxBSWkjf1zmsxeFXP0E6T+evTvA4VVTQuMyIrrnAXQOUf
         L2820uYw7Y06pf5Gq01lZqyjnNAuT9oKF4B6CUJIU0mkG49qIM3OkLJsjM+bLOrNSAOi
         3twg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725481779; x=1726086579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RWEHhx5O7UFZKYepru/YJGo3B9Ht5vMlNzII31DWFDk=;
        b=Getj7Y24HOYr4hyL6CUgXjDHgHjUdT3Ts+S/pk9tzARpfXgJsz5efUaSxrbGwBRrUo
         76xpbAPT8mF3YIjN+xn0RuUtiUBHAQBe1i5kM0vzI7VA8jcwErwNCLckEanmW1eblNDK
         ncuAJ8PmGbnrxoi1LFsS53WkJjdSsqc2b2FDCrbIJ1k6ot1ntYIpmuqcrdszorI5C5Te
         UuaLaglFjNidt5yzP+4yhNyzxd5cN/ij+2SXT0DwP2aTwUzxApJnsu5z8jYgSVUID1WD
         4WUC55M5tY6vFMe06EGInDVXs01HY0r40uZJ21awgwmdIix5O+WPehABnM/NkI/j5hLh
         Mycw==
X-Forwarded-Encrypted: i=1; AJvYcCX47meU0kbTOnfCLBFqryAfxhtv5KLREaTKQwN63YZynemlMkGJc9oKTgs8jbUGQ6yxrtaeu6SEni+gfxal@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz5dBnPSZmZS3Q2SZ77NCHOQF7uiB1c6XqIwH5bYDzugO4W7Ml
	d+IgobeUH4mW5e62lyY/JZieEbq+npgTotaRNpOoWAym+pwVwRLLu/IyMq2/ogE=
X-Google-Smtp-Source: AGHT+IGNwdiKO4Frv0IpCUzBFB05rGHrErtdGiSxtnVsPoIgc9Az5OOPtCc2jc4JjLzRxF9YRhdyFw==
X-Received: by 2002:a05:6214:498b:b0:6c3:5c0e:2bbd with SMTP id 6a1803df08f44-6c35c0e3262mr134228936d6.50.1725481779673;
        Wed, 04 Sep 2024 13:29:39 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c52041874asm1535256d6.113.2024.09.04.13.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 13:29:39 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH v5 15/18] bcachefs: add pre-content fsnotify hook to fault
Date: Wed,  4 Sep 2024 16:28:05 -0400
Message-ID: <89d4bd31a6faa634b9de4cb486498601f042bd7b.1725481503.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1725481503.git.josef@toxicpanda.com>
References: <cover.1725481503.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bcachefs has its own locking around filemap_fault, so we have to make
sure we do the fsnotify hook before the locking.  Add the check to emit
the event before the locking and return VM_FAULT_RETRY to retrigger the
fault once the event has been emitted.

Acked-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/bcachefs/fs-io-pagecache.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/bcachefs/fs-io-pagecache.c b/fs/bcachefs/fs-io-pagecache.c
index a9cc5cad9cc9..ce7968e4fd2f 100644
--- a/fs/bcachefs/fs-io-pagecache.c
+++ b/fs/bcachefs/fs-io-pagecache.c
@@ -570,6 +570,10 @@ vm_fault_t bch2_page_fault(struct vm_fault *vmf)
 	if (fdm == mapping)
 		return VM_FAULT_SIGBUS;
 
+	ret = filemap_fsnotify_fault(vmf);
+	if (unlikely(ret))
+		return ret;
+
 	/* Lock ordering: */
 	if (fdm > mapping) {
 		struct bch_inode_info *fdm_host = to_bch_ei(fdm->host);
-- 
2.43.0


