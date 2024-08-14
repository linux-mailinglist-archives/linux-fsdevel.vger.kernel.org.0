Return-Path: <linux-fsdevel+bounces-26005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3489524C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 23:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BA9028549B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 21:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042D71CB339;
	Wed, 14 Aug 2024 21:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="XJsENMnb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966931D172A
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 21:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723670782; cv=none; b=egDC1cpcnHN1Cfg6pdxnsmmMAs4NTmuasB3KSSl4AtGfq5iwbG4fPvc1O3AiQDY0PxZQzUeU2xO8j5i8LteZOXcnL+ZooNyPSVdUqEqNL+ygQV0t9yuIld3ljoOJYDRYB06nS/QlrtG+0R0nM3js8VBql3MdDQD8mjEYG3QFFSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723670782; c=relaxed/simple;
	bh=/ZdKHR4pHjntJYSoUdVRDKcFzv/LrElzLuY8Xsnn2js=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RLvkig9Lg8nntcTS/3piKoaO4NKI9Gz19jYc7AV1sCKqltp3XQ8T3R97TUJAo/IFYzmseCMOdqvSiZh8eX0BjzPidlHxH9AR0jTdC+u1ivXPoHeO1ty1+AgC9vjyNGX6srptTxxyFgtWgvNd8sTkLt8Q06jgbGuFAXIXmMVp0+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=XJsENMnb; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a1d42da3e9so17763485a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 14:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723670779; x=1724275579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AN6bShe37d+I+GAe4SQfQZex9z+pcNLPbf8dU2iG5Y0=;
        b=XJsENMnbwhH3Pwzq9pD/aXXais5rsjHl9cQJ781xKJ/Va8J//Sv9tEerVBsx3Eud4y
         8jO4iJRTVS8qigq9ZBhNoT1x0RXtuYEJTcYoINjeGnZVSyLu88MugguCPXVd+q/xLizN
         cSM8+nIXlbK4rb3zXbtjSieepmtd2q18kUV/Kl2x71j4PvwDTTVtuFiS4MEQz3E+as8p
         2aNCxCLWADe3IkNtmPhAtiXbuR49yWxKHLVSKmzGhlsVW72qh3K3UFQre8Ck8PDmgbZN
         jr4OaZ5qjNqiZbmcLLTWA8uhTs1WEqhraa/X/128IQSgz7ZoNVAGrvRE/P6h0C4588fF
         a3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723670779; x=1724275579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AN6bShe37d+I+GAe4SQfQZex9z+pcNLPbf8dU2iG5Y0=;
        b=ax2vsHF1GK24ANtLFC5DZi4IbiNEL411bqGuCkbOe781Tw9iDd/EFZ3TrTyghWnNCq
         RI9DueIbDc8quSpTE5uMcU/FPhysE+oyjgSHMGYhCZT6lBq6mEDxaPo20DKfXhkd8tb5
         y4OTBv7NyLJ61fAUwl6aPIPxFIubjm837OltsL00+jK1cVG78qmNjTMGJhGfvwZ2tQkW
         +q1J/3RrdeXnDZIBHpqg1QcnvWSygdZdpUT9Ezpnw/BYLnKf3+ybVCT1C/3unbw3UwYh
         ZPxiBhRcsy0Ko1AKypA7zPwieHQ/QqMouRjRDi7zSohfeVdoi5HO9ApUNolzqqkK6VMn
         o7GA==
X-Forwarded-Encrypted: i=1; AJvYcCX/ph8ZO9GegfX4vACn28O889TWfF3nFDtovrN7LqpRdslXyylixJdwrRrWLsOb6p5gJwjhvbb3TVpziRJ/FWXd6+DQw5oK5vgsvHxV2Q==
X-Gm-Message-State: AOJu0Yw0sG25mg2DoBDilfPZ3r8bP5KD7b8oLVIMQHx1et9o7scgRfkj
	cctE5WQGFEJGjgg1Cznw4zPqvCvCprdTxEEeTPwsr24aB+KXYFQA0oMk6CcVsAs=
X-Google-Smtp-Source: AGHT+IFQOOdc7hk322ZC4VYavDskQmkGcpA4gUJL30TWlxeg1xLDQtxnIo9ze+bETsdddSmDQjnk1g==
X-Received: by 2002:a05:620a:c47:b0:79f:1cf:551e with SMTP id af79cd13be357-7a4ee323d9emr460557185a.5.1723670779329;
        Wed, 14 Aug 2024 14:26:19 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff120085sm7708485a.131.2024.08.14.14.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 14:26:19 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-bcachefs@vger.kernel.org
Subject: [PATCH v4 14/16] bcachefs: add pre-content fsnotify hook to fault
Date: Wed, 14 Aug 2024 17:25:32 -0400
Message-ID: <9627e80117638745c2f4341eb8ac94f63ea9acee.1723670362.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1723670362.git.josef@toxicpanda.com>
References: <cover.1723670362.git.josef@toxicpanda.com>
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

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/bcachefs/fs-io-pagecache.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/bcachefs/fs-io-pagecache.c b/fs/bcachefs/fs-io-pagecache.c
index a9cc5cad9cc9..1fa1f1ac48c8 100644
--- a/fs/bcachefs/fs-io-pagecache.c
+++ b/fs/bcachefs/fs-io-pagecache.c
@@ -570,6 +570,10 @@ vm_fault_t bch2_page_fault(struct vm_fault *vmf)
 	if (fdm == mapping)
 		return VM_FAULT_SIGBUS;
 
+	ret = filemap_maybe_emit_fsnotify_event(vmf);
+	if (unlikely(ret))
+		return ret;
+
 	/* Lock ordering: */
 	if (fdm > mapping) {
 		struct bch_inode_info *fdm_host = to_bch_ei(fdm->host);
-- 
2.43.0


