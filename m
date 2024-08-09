Return-Path: <linux-fsdevel+bounces-25571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D13B94D6A2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 20:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 207091F2321C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 18:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBD816B3A6;
	Fri,  9 Aug 2024 18:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="k182i0B1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1301416132B
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Aug 2024 18:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723229112; cv=none; b=njFjvMViFCHcbjTCWe3PPodDWAU27HNUWScMDBlpsTjOnyw26dLndJ802BkUzh+T2TeduNHaZt+GWvVP6g2BQSLAEaPIxnB7wvoFJ8i0/ElSbj06ApdO05UNMqTS5LcPgUBdo9D48tFw2mupCQep6XCieu3qAqeNqh1wMVs1Xdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723229112; c=relaxed/simple;
	bh=/ZdKHR4pHjntJYSoUdVRDKcFzv/LrElzLuY8Xsnn2js=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LRk2+nxG/oirBe5wxrw9D8Ytyd5BaOWgE/MKSEFXGyxd0Ofp9s041+Bkik+HtZ+LYGWWe0N5+9v8fTwDIR0cuk0Lvl2xswUNpV5v92GbSdlUf+TVPm+Ypg8QJKA7GsjM2UVgLPti+6H3rOG4GtRPNnu5l+brXP/oVlY0a5iHwjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=k182i0B1; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7a1df0a93eeso126627685a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Aug 2024 11:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723229110; x=1723833910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AN6bShe37d+I+GAe4SQfQZex9z+pcNLPbf8dU2iG5Y0=;
        b=k182i0B1lft3a2VbsmTWma9o5Iy/fcPHWhwmw6eZL0+I0AdZcvRfBOSW7Aofc4ba57
         TvhC83SsWoa5JGEa1CCe3pkGvY3Dm22ZKGiM9W23ECcAgdRibn5ACq3kgK/M6PqHcb1Z
         qBrpaSiGeK+glwZhLjJly5dj41GawvA5crtp/ck6LVV1IP9E169BJIuWIqZTaSs/q+c3
         FM9UpF5O/nJQVcftKuFPOVhwXeCYdiUQ4rNvo87gqIZyWvkMjzQ9pVMV5LAvvj3liymK
         RiSAdSYmetyZhHDspKFOaSolG6aV3qzppyqAoUun79jmRpMAV+xGubJxILFlM9TWBEAc
         1ujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723229110; x=1723833910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AN6bShe37d+I+GAe4SQfQZex9z+pcNLPbf8dU2iG5Y0=;
        b=nkJFkh5YSRFrJeZtpfA+OK8kis2QoAwypI3KQ5+T+QXHkBYBreYFM3g9FPjVNbwNqT
         IeUE5d7YW7/5LAo5u8VT0e9rz5OdUGpsoyyTsI571jepN6cvLp7mEMUbZVPb7glENRYG
         y/ivpKjmMyMTsXvWOuKqRWXEnUvdvC+z427pTsZrUrC2QHudzIdSDtfeGSsbWPfhHsUG
         71ds4Lxp2+JBSXLrT6eXfIaQCfjvEIX5MVrRWdIkVYDPQFLlBGbbScQNLn5Tykdd/47r
         SemtlxbVBEIcHrC8NVe/sJwsAAMHIS7N+X9BUjt2TBOUhC1WPQcqgqe+3jH+iAFPE4Y9
         MzzA==
X-Forwarded-Encrypted: i=1; AJvYcCX0YyVtNDgpNdgAunA9EoG95UVxoVRtQkNNDSJdXZ4Vw0lQuEHn4xufxBQzlMpuIZ5ycK+kOVZ25O/NSUiO7ifC4EhGcR2Q/LKqK65Fdw==
X-Gm-Message-State: AOJu0YzO7qHPTKfD/ieLCJVPsltz/05SD6uE63SMU1CAIWirrOj30LIB
	o50HC19FhbNIaUdQoJo/3zHGJzYeBxJKRyrF0NVOAy00IJevWx3D4mAU9dBsjx4=
X-Google-Smtp-Source: AGHT+IGkk+5fyo6NCGpzPleO9dzoJzviklkx5ZKaFGvNslWQvN9ZFJWRDyezozrA8VyzG3HLheVY+A==
X-Received: by 2002:a05:620a:29d0:b0:79f:dc6:e611 with SMTP id af79cd13be357-7a4c182c4bdmr273891485a.53.1723229110136;
        Fri, 09 Aug 2024 11:45:10 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7d8b0fasm4267685a.64.2024.08.09.11.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 11:45:09 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-bcachefs@vger.kernel.org
Subject: [PATCH v3 14/16] bcachefs: add pre-content fsnotify hook to fault
Date: Fri,  9 Aug 2024 14:44:22 -0400
Message-ID: <b3fc6d63e23626033ff2764a82d3e20a059ac8a4.1723228772.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1723228772.git.josef@toxicpanda.com>
References: <cover.1723228772.git.josef@toxicpanda.com>
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


