Return-Path: <linux-fsdevel+bounces-25572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 300CF94D6A5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 20:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C70991F2329B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 18:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E19216B747;
	Fri,  9 Aug 2024 18:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="TVfv+QB2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3887D169AE6
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Aug 2024 18:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723229113; cv=none; b=U7GGyseXB3FQKXK0c4zF2OUeyiknHtJvjYXSjyqGwydXes/RJCcgU8PCw9r8FiNnVNksyrs/xrhUIHZSa7w1FExj9kir4tSsaiSeqcNR+2E6Kl2i6j4oYW7mtJ2rtm+CDvXaWas4ZcGmXzyof7O+xFU3c6SXjqiTmno0E0eNflM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723229113; c=relaxed/simple;
	bh=NSHxxZRLFbsIgAXbtW5uSuQCtRZde7l6XJ/+Bc0hmhU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NT1wDEBhyCgv/zt+CxflmtVSlOTTvvYovdwASZ0AK0UGgDdSyTTswcJdaceV0A0eNhc4p1TByc/UTIqTh5b8o9RMKtmub9JQXGSrKP/98UIq/vNRhiFoJPxYcirIROpT8Q7D6E0UdO2o/2qq91W0reF8WoydFhOHNCjS2ZOT6hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=TVfv+QB2; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a1e0ff6871so139013385a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Aug 2024 11:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723229111; x=1723833911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nOXg5Kh3dRzVUCha6XNrLJPIFEv9dDgQMOq3uyVXRLk=;
        b=TVfv+QB2INzZZ+2lnzFgdMg7rmfF5rn3WEYUOAPPm1+tfmjCkXLhIlRUtopKWgE9xt
         DnmrshiCJKbeH+Z4vawUKs5Rku9xTKqRnEsBVbrMiX9Ymmlj/Ix6QDVeC+v4je+Wqjs2
         IEqySJZolqmAPurVlvI30KuHvrJAXca4i8xwofQcY7XWUv16DRO2e4szO9m1WNBvrpwy
         NTCvdblih+whXp/s3CJqqzhWvUNULXeTDkq4HxhQDn4t8f5uqtfHPF/Bnq0XwNvo1Nr6
         KwFjs1IuFta0ctWw9Q22wVB4eB9gLMN7ZISnQBD94Q8nJXbEpEc2Fcg0IDRWFq4rF/PH
         sVKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723229111; x=1723833911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nOXg5Kh3dRzVUCha6XNrLJPIFEv9dDgQMOq3uyVXRLk=;
        b=vQeK7JyFzNNSyOAAxWG/uqDJFbT01NDlhlIKwin0+jmFGapt9m4R19LZ/SZHr8ghkc
         rcTeYRZel5/LvHJuCJ0yCY8WdXEHJjYR1PA8tsUSrY86SnhoYannUp+7lRZX2SY0KGo8
         MNvufZoteU21E9tfl+JsBy7x4+Q1LDPtcMgG7Ao/oT9fHc9X7pTSJrxVp73/d5fdE7d4
         CljKzrEZL/4W/F1T7/voFNbQVWjEmCBvscSpdnASBVO3Ap5pikMxh+wWg6ART9TtEvPB
         SQj/Yp6QIf2dh2XzetiJ4+lqpHGrm3p/osfOftRh8+8Z/Z9cRKIVqt5XJC+RxhTVXNOg
         CfOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgXEPvF1GAFAW4SEwYAevqfOWAn2VFwnH7sAxcmGy7V04AKkHeP+dRHp4c1kKcIkJo3sqjMBiNiURN8H6c@vger.kernel.org
X-Gm-Message-State: AOJu0YzYyi/KPaSSjZPuO/rmQ9U9jyqLKY1ZymelOT4ADKAYzvknE4qq
	qKncjCiSg2eJZf5Dkkf91cRcjxqMIx46PQRlALcDjMETreF/42MZ3nBN8P6HAC0=
X-Google-Smtp-Source: AGHT+IFUlaCnTLIlVacmXjgmOXF1HYhqS4K6PRCpr55qRtWTp+PAc8BlcRL5nok82sjjl/gCBuRfmw==
X-Received: by 2002:a05:620a:bcb:b0:79f:b21:cfb2 with SMTP id af79cd13be357-7a4c17edf2dmr278139085a.40.1723229111208;
        Fri, 09 Aug 2024 11:45:11 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7ded208sm3899685a.89.2024.08.09.11.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 11:45:10 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-bcachefs@vger.kernel.org
Subject: [PATCH v3 15/16] gfs2: add pre-content fsnotify hook to fault
Date: Fri,  9 Aug 2024 14:44:23 -0400
Message-ID: <71aa4357e168f298d18910495da7467eec5fb79c.1723228772.git.josef@toxicpanda.com>
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

gfs2 takes the glock before calling into filemap fault, so add the
fsnotify hook for ->fault before we take the glock in order to avoid any
possible deadlock with the HSM.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/gfs2/file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 08982937b5df..d4af70d765e0 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -556,6 +556,10 @@ static vm_fault_t gfs2_fault(struct vm_fault *vmf)
 	vm_fault_t ret;
 	int err;
 
+	ret = filemap_maybe_emit_fsnotify_event(vmf);
+	if (unlikely(ret))
+		return ret;
+
 	gfs2_holder_init(ip->i_gl, LM_ST_SHARED, 0, &gh);
 	err = gfs2_glock_nq(&gh);
 	if (err) {
-- 
2.43.0


