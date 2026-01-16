Return-Path: <linux-fsdevel+bounces-74261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B3665D38A16
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jan 2026 00:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 805EC301F7B1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 23:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644D832572A;
	Fri, 16 Jan 2026 23:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcIUq5k3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7DF322B90
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 23:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768606287; cv=none; b=W/CMxkAGD05TM0m02MgbHi+M0gjrgEryHMAlD760p8envNFk+dTtYQpYIAPyZ7/FXOh2f+b0ktDv4iR5c/6DMKvxVGjjj3HHIrFjbLKC83NhSd7Eh8xvTHdFMvMUXMqX2HkKSRTKa/adfpH1s+L6sDWaarVlxpymnQQdihkikrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768606287; c=relaxed/simple;
	bh=GD1NmkO9aHCzuWcuPVG5FvbcnOb3CTOFaXwrWf1dVoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QD0S+CNku9UymfC33Kzr+6fFSdsSe7v9GjXprsEsr8L88nYifFMv1Uk7M6BavdiyAh/UzK0j2ajDa2tsyoX94FX/TwjA03baXSFXJxJtsuCz0mYApFfgsiVv+sNvF3eHMikG7/N5efVSPRkT1RnkfhLLJQeXwzr0fPUiWUJ0wZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcIUq5k3; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a0d0788adaso17231645ad.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 15:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768606285; x=1769211085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ADA4qsOfE/Betp6Q2noLvGrlEIPGsl/nrHF+qqwaMQ=;
        b=mcIUq5k3SadkLjdYfRzCWzcubRMSr8TyYsykyra9QN8jP2wG+FPsVncxM7FVfwbLAj
         5aDb7BriiJ4d1u3fIx/hOso0v+gQD+XJSq54VRwiHV48sNEDbmsf7dzcVCPshr+A0hlc
         BfHmLC8Cr5mCq5WpfWp+15neWwQDX1olN7Pf/HIpAQurk9yuXpvei3jzflB6Y7Pb4JO6
         WzoUt8+cDT8DiXrZyxziUvPyypbbwXuMqr2Bnpi0cHH3Tx67enhvhVl6YSmrDwwfkMWy
         6UeHFfpzxufnFmcuqfNkPjXdwwlicZBL9SYanCYC8aCcnUTbPnaiesD6PBXNUSElJpKi
         L1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768606285; x=1769211085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6ADA4qsOfE/Betp6Q2noLvGrlEIPGsl/nrHF+qqwaMQ=;
        b=HTrbXitgD32RGnILMy0gFR9DcsjcLJAuHamfuEykgbfQlkxSO3BohBJL926DAgZaA5
         uGVHKS4q3KlJaxMs4WIegr/rg/GH0RfqWlbkJdLnQOfRgYEvlqE0H2r/91Bq5Nrrq4rw
         IRoepYhUSDldRMlOydxQaa3uNOLgXMVGrVr2fAY3N/yhu5E3jnzUOyw3NcFTRA1HurNw
         GaKksGoQQXE6A6Z42+SdPySAJ8iw/Dyulhdzm+BmQ8oVcXDifWXVNeODUCX3o2Iw9985
         eiCyQCY18AjIWpu41K98aC7L/o8h5xFhk6z5CR+W3TSX2NpLa5/tsjzOle3lYqpIJy6Z
         SDww==
X-Forwarded-Encrypted: i=1; AJvYcCUANggN4nyE77ruTe5OpxMwz7ss4EnxdeerIcdfDds3rCJotmSEm4CefoP2I5RNSlmsyfIpM1qY/vrOImQU@vger.kernel.org
X-Gm-Message-State: AOJu0YxwFrOaRiZ8J9iJ91gGadXWqcherH0bsyRh1fE7iymnxNkVd816
	P40ZLKB+/BFUkIBJFfJ8BVIcRm8g+Tx6UnjLUkZXEUHqpWesDRPMCUja
X-Gm-Gg: AY/fxX4vj/QpI87wTzI8Ah26+DRK4Qb9vZRsPLHhb9L3kW9zLo3Zw4fKMRS7E9AZ3I1
	tlaC4NqK+ms+tiinivxG2l6qnHRJOhvq7qEeXAgSxC6oYt8HpIV95hAGTEWk0VMv+exNLqmPM1n
	P3Ra+w4oZ6fV/ZmxdJbGW0xxnZk4AxFvi9i7EP253v8TtzFBU9MnAnkuqd70scZ0HnjBn4lXoeG
	lGte0plAhHLppyOB330McuRnPg/S9oMRO1x9bQLTXT+zoY+Zo65nUPpXPaZUjFM/HidXvhDQfkm
	dv66RRIyK8u9g9qsFJWgUNNBEHPyl0IXbHYYEGV3AKOUSw/SubKQvsaVXxQFmYrjYvwHQ4e7Rlm
	45cIeQ1nWrZ3RbVl5QIZCBCTdOZrwe5ATtAdE3k9IYbjP6UD1yitCL9ePYwJq2BvBfuTAo7iH7X
	RwE6/4JQ==
X-Received: by 2002:a17:903:3bc8:b0:298:4ee3:c21a with SMTP id d9443c01a7336-2a71752aab2mr51276715ad.2.1768606285341;
        Fri, 16 Jan 2026 15:31:25 -0800 (PST)
Received: from localhost ([2a03:2880:ff:54::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a71941e3cdsm30129075ad.100.2026.01.16.15.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 15:31:25 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: axboe@kernel.dk,
	miklos@szeredi.hu
Cc: bschubert@ddn.com,
	csander@purestorage.com,
	krisman@suse.de,
	io-uring@vger.kernel.org,
	asml.silence@gmail.com,
	xiaobing.li@samsung.com,
	safinaskar@gmail.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 12/25] io_uring/cmd: set selected buffer index in __io_uring_cmd_done()
Date: Fri, 16 Jan 2026 15:30:31 -0800
Message-ID: <20260116233044.1532965-13-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260116233044.1532965-1-joannelkoong@gmail.com>
References: <20260116233044.1532965-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When uring_cmd operations select a buffer, the completion queue entry
should indicate which buffer was selected.

Set IORING_CQE_F_BUFFER on the completed entry and encode the buffer
index if a buffer was selected.

This will be needed for fuse, which needs to relay to userspace which
selected buffer contains the data.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 io_uring/uring_cmd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index 197474911f04..8eaea40231ff 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -142,6 +142,7 @@ void __io_uring_cmd_done(struct io_uring_cmd *ioucmd, s32 ret, u64 res2,
 		       unsigned issue_flags, bool is_cqe32)
 {
 	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
+	u32 cflags = 0;
 
 	if (WARN_ON_ONCE(req->flags & REQ_F_APOLL_MULTISHOT))
 		return;
@@ -151,7 +152,10 @@ void __io_uring_cmd_done(struct io_uring_cmd *ioucmd, s32 ret, u64 res2,
 	if (ret < 0)
 		req_set_fail(req);
 
-	io_req_set_res(req, ret, 0);
+	if (req->flags & (REQ_F_BUFFER_SELECTED | REQ_F_BUFFER_RING))
+		cflags |= IORING_CQE_F_BUFFER |
+			(req->buf_index << IORING_CQE_BUFFER_SHIFT);
+	io_req_set_res(req, ret, cflags);
 	if (is_cqe32) {
 		if (req->ctx->flags & IORING_SETUP_CQE_MIXED)
 			req->cqe.flags |= IORING_CQE_F_32;
-- 
2.47.3


