Return-Path: <linux-fsdevel+bounces-22875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC7191E0F0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 15:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C2851C216C3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 13:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4402815ECE1;
	Mon,  1 Jul 2024 13:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="vepUUsOS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2359015E5BC
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jul 2024 13:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719841104; cv=none; b=OY9/kIQinyVjOc67mf4NBpwnKIzByfBfbif2lx2Cox851R/2jpUMn6Ktdr01by/R0xX7+k8ZldWtx+leRFeL36tfltDiGb96mbzOpFbL2gWq99Wwmsex2XYMDo99mpImLbFgDREbnJl7zCCrn8DiONFqScrmXDJVbdzhNG5aVJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719841104; c=relaxed/simple;
	bh=orcW3KV1wue2Wlfs2605HFmKhCkgqvHEBbRYehnsBj8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Py2SwTRrHEIakBdXqx3cey7HC9QkJRtPIRsPV/ssWiQe2SPOj4DobCV4le9poDlE6WANdnGijf6iEl3FwuFpHWCvZZXOj6+u0X/xY5Sl3pVqOQjmuxQ45S0+Wee7Q7WzJelNGIqtzLvq+nSqTEtiQ26k2YAWPl3Y8G/nFXOM27Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=vepUUsOS; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6adc63c2ee0so8374366d6.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jul 2024 06:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1719841101; x=1720445901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4qdIhdrRTGj9K7W9JuO6yWHm/C5DDCvWRrbrdYiRH3M=;
        b=vepUUsOS9yst1KRDgsZT8r7fGtpYeGVNseAE6QWU+553V91KE9YNxWV+z2/l3uKfnY
         0xkYzAkxvaHErJJJ9N5oN6DRbj/s79Xu66dMt93fhTObIn5cpvFKgy6RHD+yo3HkJ1qm
         BOZrAKI50ZtinpLcl++EEqSBpU5G4Zor2EtveL/g9XhNgk62MTaNlotHbPrMysBya94Z
         ARltVv2YCjQKa5f0bVrz4IVAjvZ41WXCqQlRxP66vWNJVdnVZVr2SSph2gWZMPIRLu2l
         LsRudRTm6TUZL/6bUP/Uc51SX/5Ri/sKm3ZMc5rDQKN2V7wEUCSXvnJDR1nh0lGuhzJQ
         Drnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719841101; x=1720445901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4qdIhdrRTGj9K7W9JuO6yWHm/C5DDCvWRrbrdYiRH3M=;
        b=wbUDJudOVqW6EL1bZajd+HOh7U/ehtZGbWCUh8DEKEOjwfVf7qNPTbqfYgthMwE6zH
         bWssmLLvLoD8C7yqq49Fw6anCiRdidW6AjdfBCYj17xeqDouvBw+/R1tKOLBaxO42S3X
         feJN5gBD7BVLHyKNrf/Jwkyvt2qu0/6GiQRSHvW9EuFVQ/cidlXA3nFLoPk6Xv/+AO/4
         pP6pRAWhFNBD/eXzawOYxmmREzlxC/RvPoxSFYpuMuXxkMsXIVLtpgnkpHNw1P1D4cNT
         jeS16zzEmQK8phLXZqfjy4rrxLX5PsLNXZD6/mEshj3F79zdYAWluZAMssqJ3UwA1cF7
         sJnA==
X-Forwarded-Encrypted: i=1; AJvYcCVNskhxYIttyfLCQp08Bq3Hovt/Ny+xHV/I71U7DYcT9oG6lVK6K0kRQEOk5CNRCLkDqQ3Lity8gbr0uqvJHTCP3GaFkNHq9ZOaoS3mNQ==
X-Gm-Message-State: AOJu0YygV9QSRF/jEe+9UD+9VKUMA8ZsxTLVaZUet8ZoGfvtQKTTSp9o
	4XtJ3p3foKZG21WDLmweyE+r3bbxqjlq9jh7NC0wrM25ucEpYxbm4E7wuj642pw=
X-Google-Smtp-Source: AGHT+IH9NWsJCNec1szrhVDTv5U1qMMlsOJkpGMOYvilPLv2Ak7AHFr/z/ZWuIff5kMTdoDa+80l9g==
X-Received: by 2002:ad4:5aae:0:b0:6b4:fc6f:17ba with SMTP id 6a1803df08f44-6b5b70c725cmr63130786d6.33.1719841100965;
        Mon, 01 Jul 2024 06:38:20 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e737d61sm33087126d6.136.2024.07.01.06.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 06:38:20 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: alx@kernel.org,
	linux-man@vger.kernel.org,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	mszeredi@redhat.com,
	kernel-team@fb.com
Subject: [PATCH v4 0/2] man-pages: add documentation for statmount/listmount
Date: Mon,  1 Jul 2024 09:37:52 -0400
Message-ID: <cover.1719840964.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

V3: https://lore.kernel.org/linux-fsdevel/cover.1719425922.git.josef@toxicpanda.com/
V2: https://lore.kernel.org/linux-fsdevel/cover.1719417184.git.josef@toxicpanda.com/
V1: https://lore.kernel.org/linux-fsdevel/cover.1719341580.git.josef@toxicpanda.com/

v3->v4:
- Addressed review comments.

v2->v3:
- Removed a spurious \t comment in listmount.2 (took me a while to figure out
  why it was needed in statmount.2 but not listmount.2, it's because it lets you
  know that there's a TS in the manpage).
- Fixed some unbalanced " in both pages
- Removed a EE in the nf section which is apparently not needed

v1->v2:
- Dropped the statx patch as Alejandro already took it (thanks!)
- Reworked everything to use semantic newlines
- Addressed all of the comments on the statmount.2 man page

Managed to get more of the build system running so hopefully this is all
formatted properly now.  Thanks,

Josef

Josef Bacik (2):
  statmount.2: New page describing the statmount syscall
  listmount.2: New page describing the listmount syscall

 man/man2/listmount.2 | 111 +++++++++++++++++
 man/man2/statmount.2 | 288 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 399 insertions(+)
 create mode 100644 man/man2/listmount.2
 create mode 100644 man/man2/statmount.2

-- 
2.43.0


