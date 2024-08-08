Return-Path: <linux-fsdevel+bounces-25468-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CEB94C54A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 21:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11810B250DE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 19:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73AB15EFBC;
	Thu,  8 Aug 2024 19:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="VI/YI4c6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C73156864
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Aug 2024 19:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723145317; cv=none; b=o9VOloJ5cYnu2FNssXbd5Ci6T/r75cH88sdeUPWKiF7y2TpkdXSeriTTZJ2eP0GB9AK5IG+KNFIAjAfCe9MaRfS1LEAV7XI/UH+WcmJr0R3COH6HpYe/itqUq37vaWyzKkVDqLWeI+2QRny7v15j1I0/s+Z0w1ygYYLeHzbWJq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723145317; c=relaxed/simple;
	bh=qFTMKWIL/yGnaEo4ST947CpdEdpSPVdDj9nlHMZ5dyM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jo1vzKEkYJrJdv/i8bpTuNOEj2Q5wNDYdeg3rc8MS71CMZE/WfxlVs/qDfeHWqbUtalBwFZTuw1JbnhL0oz/+c67DlPaLwAiY+eK57tQJq+HJHQzkF/timNBgEve8V9Vwl+0r9i4GRXCzh1xZpkTx2LtZ/HxSdG/9f5jUIH5ysU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=VI/YI4c6; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a1d3e93cceso223727485a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Aug 2024 12:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723145315; x=1723750115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7CNYL3NI8L4DrPragHH0rXidYBkqgWEZukxmJe1amgo=;
        b=VI/YI4c6ripGhuKHMF8RqdxVDQmEZQzIPpz+nW4Wcq9A6qqSvC3s57O4jYDBCdz53l
         wwzG+5vtDfkVTDjezxwkf5FTxtyULOY7POiaDoXgJA2lNEtyrI8UYe5QnIM13tI5ZtDd
         d1ma3BpNtF4iS2W1cAyj54vCM2VyXnClScKMBKOKkn1g51JXPyTuhW27jmrRn1Y0MKZT
         PGYvsljHAxOhdn7UoDt0q00Nxspvlc2eENOmLYe7y2QIhsyo/MI0g/vj2B0TkBZW/hYz
         jxZ9GhLCMXzQDRn237dX/E1ppI7669jMmPgV537IS9lRqA+MPNUAfG/GDwKq7MzxrBBn
         0L/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723145315; x=1723750115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7CNYL3NI8L4DrPragHH0rXidYBkqgWEZukxmJe1amgo=;
        b=LZXd9PtCNSWOCm4cFcnRxW5dDejIpLHtSrAOtyWKAzppyPDJZY++wS3rZLbv2cN3sx
         XYUeqw2INtD6m6A8cnWSgkclV8KiSJdjDio/IRG/Hgct/hxXwTX36vpo9ceAf91pzAVA
         N0S3d0AD9GPYuWTZVkBIEBnOXsXg9xzrVU/9ChWtE4YgycHeGaiMhUtsfxh57dy/7OI4
         by9F2D0/WCX0vLQbg9/h05ucVCQ4J1fT2Axo64u/nWr3EPVNTppghr9kUDDoV3lMkvKI
         q9NGzi1OS/AxxqAffverJ7tEyUmVcYU/U/XXhNx6CnSELdIXWr6zy2UNr//EjyPrTK+o
         e+Ow==
X-Forwarded-Encrypted: i=1; AJvYcCVptBpVHz6PoIsOkqsvG1epKmMVqPJQiceDVo6hx4UENPRIgIEGxafGwUckKSaeZA4W0uZxPZmaqUwCrcRCyW4vZ3AkLL8fQHi/44VxeQ==
X-Gm-Message-State: AOJu0Yy98gA/8dyPrxqLs5RLwkX1MnIN74YK7AexyL1ipoItzqyPTyCO
	gHUErIp8MM2Xr1FT68B3DVAB7GC/5mWkgUDz/ApW4nxC76fQG7zX1l92+MkDe+Q=
X-Google-Smtp-Source: AGHT+IELzedQB6qkhz/0uMlxd5H8eyyS/8cuLteD4Tx6/D3Ehd4NvybXJW2wN9ROVLZVzC4b0efbpg==
X-Received: by 2002:a05:620a:1aa0:b0:7a1:62d3:b9a3 with SMTP id af79cd13be357-7a382498ec0mr519333185a.17.1723145315534;
        Thu, 08 Aug 2024 12:28:35 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3785f18fesm187453785a.60.2024.08.08.12.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 12:28:35 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-bcachefs@vger.kernel.org
Subject: [PATCH v2 15/16] gfs2: add pre-content fsnotify hook to fault
Date: Thu,  8 Aug 2024 15:27:17 -0400
Message-ID: <5d4babb06516f5288a999eefb1a4dec09e775195.1723144881.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1723144881.git.josef@toxicpanda.com>
References: <cover.1723144881.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gfs2 takes the glock before calling into filemap fault, so add the
fsnotify hook for ->fault before we take the glock in order to avoid any
possible deadlock with the HSM.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/gfs2/file.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 08982937b5df..b841b1720b5c 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -553,9 +553,22 @@ static vm_fault_t gfs2_fault(struct vm_fault *vmf)
 	struct inode *inode = file_inode(vmf->vma->vm_file);
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_holder gh;
+	struct file *fpin = NULL;
 	vm_fault_t ret;
 	int err;
 
+	ret = filemap_maybe_emit_fsnotify_event(vmf, &fpin);
+	if (unlikely(ret)) {
+		if (fpin) {
+			fput(fpin);
+			ret |= VM_FAULT_RETRY;
+		}
+		return ret;
+	} else if (fpin) {
+		fput(fpin);
+		return VM_FAULT_RETRY;
+	}
+
 	gfs2_holder_init(ip->i_gl, LM_ST_SHARED, 0, &gh);
 	err = gfs2_glock_nq(&gh);
 	if (err) {
-- 
2.43.0


