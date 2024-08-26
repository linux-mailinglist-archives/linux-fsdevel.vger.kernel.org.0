Return-Path: <linux-fsdevel+bounces-27084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA88895E748
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 05:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF9851C21249
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 03:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC3633CE8;
	Mon, 26 Aug 2024 03:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PV0IOXcX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3536A2562E;
	Mon, 26 Aug 2024 03:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724642890; cv=none; b=oVlbenSnuFrlEi6gS/UL1oSVdm80DQJeI9w26d+YRWjlZ7avug8CB1cSbLQBqGxJ6mcW7/LsGyeLapdgjgVRaQSH2gDv3C9mWjZTmOg0tiut/3dVC6Dlk1PNRd5bPeVGBhXnLFgxPl1R+AIafxf04hvA5DJEtmNxxzXZF7gIZ1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724642890; c=relaxed/simple;
	bh=FAb/bQ58v74hR4PP/GEip1j8DSjK5iEhOzd3an52oEk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C2IXdFguNHTJnJIm5WO7CHSJA8TXZrrIrgE2lrfn6BIWeYQF6zFtcCtx0i1kXSbCai6zHzS5kd9aRsUsP1C3vrBPow84tjrIp/Wa3YjRv9D9/O15hw2ogVVIAa/PA31ubuFtGIIKsyg2ll1O+wyE58J9+w1tKUiPwN38m/1NXo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PV0IOXcX; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7cda0453766so1135797a12.2;
        Sun, 25 Aug 2024 20:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724642888; x=1725247688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ANf/hClzWrqHd4P6Q3XPUC1mPVi6EquIud7d7KHM0gY=;
        b=PV0IOXcXr2HSvp/JRC9qNsxMNA71UivFgvfowiMKvb3bVEAxwK8tOcCfPnHYcgGVBI
         2tD/o8nu5XpLWReIkXVuejcoXaiNnEN6A+iWJoNlVhLGuHbxnFpnYTTiu1Oyheco7oHy
         YeJd0pgSMPpeWhH4yVP+iHvWD05yIqN2GNcx1nxyBndfQJBFU/L/r/rwFqM92/3nq5u+
         o+lF2pQTBCFnOuGARsCFndCM9uux91PcObvofgzzYhEEtm+sRP1oCmpC6c0wLKnZvRqq
         mQWgjP/HcvRc6e6SMXJHjG9AMEtBJEkFRVq2V7Bhe+1Ic739B2ESrues1QeeEZZCLIa7
         7toQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724642888; x=1725247688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ANf/hClzWrqHd4P6Q3XPUC1mPVi6EquIud7d7KHM0gY=;
        b=oL+cf8Gi2eg0o8w38d7gHmPgJeVZn2a6moDXizaO+Qd4W7iXOekZ7DX4EvDewAzUay
         ZNaXnD0g7sS/ng0ERUE3tSYm7bssUjzZOaseCi2v4S7qrLAXbkL8r4j62jafwR6n3knC
         1likRYK3dl8dAHVcWWlufHRnXzcREEt3PcW0QfoGPU22Co2tJi4lqIKxSMgqj4iHuxUc
         huA1hKmq7Sr9829hlN/iqHPckFPoDymPDY4ZDsayguowYYKhTQAq3xVQrZUEekgzmkI2
         F3UVwYmVfkEj6rnhPpSEy3kyw3+cAOSvnRAs35d8eo14H1xt0sCfwQ9Oy3EWIBGLlWT5
         Tq9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVTkY7IXOeU0ZzkgW95TAmyZb9ZqK5UqVicAiJcTKSRi3gDwT1kfsJadJGIsQUoyGDfprazqOPWeCab5lKF@vger.kernel.org, AJvYcCVqniLVddzRiMeGkt1sCokkg6a5DFCfTU9KQukyV636JgC64mzwGKo7YE1/iC/F7/SR5N0+cy1K@vger.kernel.org, AJvYcCXCf5iNY0dIuZLucXcDRlatjCBQpgfe9CG/2k7UVskKF/29NRcTu3j+o5zoGPw60JLW5rOMdyTHQhpWE6Oj@vger.kernel.org
X-Gm-Message-State: AOJu0YxqUiEFiBfrv8ttZ+uZ08ITbl5HetE/8sF+RDVU9x6T/u9SZ2yk
	a8YOlQRfm7VQ6NtSuAVHs8V7olvo1gvSfvDFvgaC0eDcW73L4nll
X-Google-Smtp-Source: AGHT+IFxBdq2RNdI+6yOhYiEnov1LOzlBT22h9WwHslCdt/ew1B/PxB6w9GmQTx2/TU/Ruqd7jCoVw==
X-Received: by 2002:a05:6a20:d492:b0:1c4:a7a0:a7d4 with SMTP id adf61e73a8af0-1cc89d15ec2mr11857864637.7.1724642888345;
        Sun, 25 Aug 2024 20:28:08 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:646:a200:bbd0:3283:bf27:b1b2:b224])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5eba2353csm10875610a91.26.2024.08.25.20.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 20:28:07 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: Greg Ungerer <gregungerer@westnet.com.au>,
	linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Max Filippov <jcmvbkbc@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] binfmt_elf_fdpic: fix AUXV size calculation when ELF_HWCAP2 is defined
Date: Sun, 25 Aug 2024 20:27:45 -0700
Message-Id: <20240826032745.3423812-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

create_elf_fdpic_tables() does not correctly account the space for the
AUX vector when an architecture has ELF_HWCAP2 defined. Prior to the
commit 10e29251be0e ("binfmt_elf_fdpic: fix /proc/<pid>/auxv") it
resulted in the last entry of the AUX vector being set to zero, but with
that change it results in a kernel BUG.

Fix that by adding one to the number of AUXV entries (nitems) when
ELF_HWCAP2 is defined.

Fixes: 10e29251be0e ("binfmt_elf_fdpic: fix /proc/<pid>/auxv")
Cc: stable@vger.kernel.org
Reported-by: Greg Ungerer <gregungerer@westnet.com.au>
Closes: https://lore.kernel.org/lkml/5b51975f-6d0b-413c-8b38-39a6a45e8821@westnet.com.au/
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 fs/binfmt_elf_fdpic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index c11289e1301b..a5cb45cb30c8 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -594,6 +594,9 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
 
 	if (bprm->have_execfd)
 		nitems++;
+#ifdef ELF_HWCAP2
+	nitems++;
+#endif
 
 	csp = sp;
 	sp -= nitems * 2 * sizeof(unsigned long);
-- 
2.39.2


