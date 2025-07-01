Return-Path: <linux-fsdevel+bounces-53527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 968D8AEFD04
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 16:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CC701653F0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 14:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89DB277C84;
	Tue,  1 Jul 2025 14:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGQ4grDt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0997727381D;
	Tue,  1 Jul 2025 14:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751381334; cv=none; b=DFd045yAZnZp9K+3axJjbLP5GUCC2KBtwlNi/HWksHJaJJg55WSAAfwNPC1fbsG5+UYFo570RbMu+mVmGH61CwMPdyOZdcsRdAHcxx0HWHL4tXTuvgOuZhoriWdIa78GiP+kx1wmMl5hlQTUy29X3Q4FeZodmv5vb9ZfECPif2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751381334; c=relaxed/simple;
	bh=9nGHm81l9vaSVC+koQDf3/Tk1BxpMihn75VMt6eGlEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uVRlnt5x16fk5kc0d4S7oxzW3nFBtCeMoEXAuo1TYoSbBRF5SJWHeJd9xI4/pV2lub6spbwll6ZIjjPrx2Q58KO235UwG9H0sF01xWg7oNjA4clEtjnIHgFrlKRNP2KkVAGV+so/9DhQG3HtUIPZeZsmPixX1+zhoDhlJiBC++0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGQ4grDt; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7490cb9a892so4071250b3a.0;
        Tue, 01 Jul 2025 07:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751381332; x=1751986132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V4iNujaHcx/laONpT27iJzlNXWf8XtGDRFAhj+zfXDo=;
        b=YGQ4grDt+8fCNniX9Q4Kex8pDuAQKEsk3uTD2r7qD3LT71WdRKdYnqwZIiZnH+BhKm
         MULL4czXts1vbRJ6gT381Dq+L90BxX0Y+OH+Y4Agv31cyBlqlcm21vl9xl1sLj4Nz/BP
         tVv4q6qpZGjkpqMaoNksa530cKyIeJOwvpOgPZUzltK9HBQ2/j+gHkopTbTNnyFmwCIp
         0/xK4aUzLTRwNA3fyiGEXIcrXfwOLalY0z06dZjQjskhbE67uj5vJinLwo71P3xybdDo
         4g1JRBOQJVv8piaOqnJ9yGf664pLzIQ8cfVWIjtaVqWEF1Q8DzkpQ3fSIdeetzbkWv05
         M94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751381332; x=1751986132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V4iNujaHcx/laONpT27iJzlNXWf8XtGDRFAhj+zfXDo=;
        b=rtEiKO+7bsJp4TBvbNbE0QWJ20KOsJDLGw2auTCh9z6YPW0o2xghPaDRY4dLSfNtw1
         0rsGjQCuSLaWURqkV2Vx8GC2OJSzxGPt2ClOQEy0wacRVEYnUWMcVS3uz33HKnm9EkZF
         l+54up8/6ecfyOyPUCHF2tbjV0g2vpR5d2MGUQrYS8GVs4tEUdFbxe/9ID0/QmTYtD/i
         iLZcpXD9uhp1sGuWh1TBn7JG02kGeBSHKKGU4ZNhAKsQ26ZF7GiA6B0xQjAgUJ2NbiDX
         DjrcZosI652k5mRXLKBr8hcGp3ljCSOjGPKBoZOzPliSg5/o7e+/wTyYELzbTjWYFZOQ
         Tq9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVXQ2AL4wGmgUymsaGRRMpOt/trf0IGArj9puZztSWB5kQeV0BwxUV+M0zfr0hlq5Xkase7H+nP3obWjik4@vger.kernel.org, AJvYcCW+WJTYg8eWk0NpUgHenWF9Q/+4+5OXhToU8L2VCsnEo/Q4SHzF9ySFVKmJVg3TDrXhay0S5DjS/r0/uuC0@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/2RDu/CbsSEE/iiMAIJP79q3ZpXGo7KiWDZWQ5EVCqIAk2S6/
	6faEPhHag64drdhoNB1hTdOMjXkm9aDV9qMd2NSTo5jpP5yUVFwWD29H
X-Gm-Gg: ASbGncuReM5vN8HOV5OeprjN8Z8q4gNuAONX5bNp2OiOE9WWvVlMJPqOoFM/Gc2JKr9
	lCHURoq0Ob9hK8NKyTElRaVGb/57S9QqJzOeEc6wzZobSTFzQDc51HO5Dk4cQ9Qoq7hTIsCAnUl
	np8e1FWRJyGsNBUs8Q6PeQZvYcM9Z0w1wo08R3QLuyEXkZY+QlBKJ1wn4GzZ1TVXjO9qa1u81/v
	S7ptvzDiqY6BkygagaMsCXqmkeiHAbFW/3bm8x3Zflsh0Kd8Pmixlt4K+afKl+Gks19DQj99oxJ
	Lnvh8O+OsqclPgpNhcpvJUwpP5e/9SgB0UaBSoGTOW7WAaRaHdvPp1GE3/H12GAwHqypo5dFqz4
	=
X-Google-Smtp-Source: AGHT+IEbIAWmEjLrkdhnHtI22nqx6M907yfd8jIyUszMxmItcwo5fcrVXs/7K86li3sS/CX7AO/2xg==
X-Received: by 2002:a05:6a00:18a7:b0:732:2484:e0ce with SMTP id d2e1a72fcca58-74af6f2f67fmr22103881b3a.17.1751381332145;
        Tue, 01 Jul 2025 07:48:52 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af5409a58sm11476913b3a.6.2025.07.01.07.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 07:48:51 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: brauner@kernel.org,
	djwong@kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH] iomap: avoid unnecessary ifs_set_range_uptodate() with locks
Date: Tue,  1 Jul 2025 22:48:47 +0800
Message-ID: <20250701144847.12752-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jinliang Zheng <alexjlzheng@tencent.com>

In the buffer write path, iomap_set_range_uptodate() is called every
time iomap_end_write() is called. But if folio_test_uptodate() holds, we
know that all blocks in this folio are already in the uptodate state, so
there is no need to go deep into the critical section of state_lock to
execute bitmap_set().

Although state_lock may not have significant lock contention due to
folio lock, this patch at least reduces the number of instructions.

Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
---
 fs/iomap/buffered-io.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 3729391a18f3..fb4519158f3a 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -71,6 +71,9 @@ static void iomap_set_range_uptodate(struct folio *folio, size_t off,
 	unsigned long flags;
 	bool uptodate = true;
 
+	if (folio_test_uptodate(folio))
+		return;
+
 	if (ifs) {
 		spin_lock_irqsave(&ifs->state_lock, flags);
 		uptodate = ifs_set_range_uptodate(folio, ifs, off, len);
-- 
2.49.0


