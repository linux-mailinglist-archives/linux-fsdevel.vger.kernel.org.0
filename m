Return-Path: <linux-fsdevel+bounces-50899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FDAAD0C00
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 10:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED6D91893198
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 08:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1CD205ABF;
	Sat,  7 Jun 2025 08:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUlejLI8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19181C5D44;
	Sat,  7 Jun 2025 08:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749284955; cv=none; b=IZ8epuQlSwUiroNGh75oTccJD2TzDqbDKsMozElhAy4icib6M/yrIUMMhPBATCSADJyVuYp2rdDxbu/NYbdgQsHSXCbUqTA1DekYsP2EJdBZqkMLEjSIHernyjEkZkhv16n540gix46OyCuIJTlwzwSs6OGH033UW144DSmRM6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749284955; c=relaxed/simple;
	bh=guoGByzLTf+4QpA3Zq9Oc6Ba9GkWALSBOTskGKrijdM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WFphJ10euNhcbw26i1ZK2xU0T9SvDLUsmUWtyCR9AtoLPH0Q6wvFH1FrXxFOW36lyjvX5AZIn8NLwWhCrhNUg1JLY7dYJl/nz5QTE7N7SwNGTys31htPc0LoJ0RwStwki7d/pvMttyID1NDjWMWQ2UGQIgPEqTkR8TT74uhwTkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUlejLI8; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so2344343b3a.0;
        Sat, 07 Jun 2025 01:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749284953; x=1749889753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gqrQNrZhDEaoDoYGNSTeR9PK55978s8pQW2q+WWm76Q=;
        b=WUlejLI8WZ5Ql9aQvPt3ZpDUuAaQDD5wxKxevvqN8EuxE2ca2WI/cq/3TZvpLTj06N
         MoGPOk84spw9vEq5BIkl4Y/k/rUqTkjSUAapzRSMyQKRgdXtcNThNRD0ZhdH/kTZ4kJc
         2VGMi1tOBkTGi+u2MKZDBuSp0ghEhhsC0NJ/zIxrc1UfPcZtsiJ3jZkZVpYRVUUd6Tng
         t1tGlrzcHaaprNYzltPY7QZ6ckUnfA2xLQSXrRwrgG+bqxGE4RTPYuYkVOygqodEzBvB
         e9NCYa/VH259e3lwFWGNz6VgXF9Z814uPqhkWPy5AKkcPFE82iQPA3U9xlOU4UNy4/df
         7VrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749284953; x=1749889753;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gqrQNrZhDEaoDoYGNSTeR9PK55978s8pQW2q+WWm76Q=;
        b=unLOUoItKVadFqlWTYkIF/Be7s0G5PJ3pANGYLagBLqi1i0pP3Djy6HshE1CUSF6mG
         Gy8AVMICwXbas0T6TIL2QWjxxiQbWn++mgVzaq5t4vxCxgjjBmi2WMHGUZKV2Q1pvFjK
         1lyvyDuFhkfualUE3Bi8+hNeCpV5TZwdymVYfidBJQOS0XlSAo6uLpdlyFfORn1S6pR5
         eSDWAaoZCummPv3I2LUApbZMWscLQzF75Q/OtTXI3qFa7J9wQY6/kiTYwBcFGHf9OE4f
         iRsOIZWYSKbYzqWo5Lnp06oXiz5Vcy7Ln3DX4/9s/2RoM1DKe2Y7wRVwlS0lkMTGIo97
         n0rw==
X-Forwarded-Encrypted: i=1; AJvYcCUxzbqerwphBMyHH6MN2kbfuyJq26eUOix9omoIUU70VKEXpwNlPTx0jHif2ZItPOQOwwtfWnUYKFHn/z4=@vger.kernel.org
X-Gm-Message-State: AOJu0YznvkTC+vCE6CWabOspMvXlKkr81WI9e8hr4RfR6zDAYuXMZq9V
	Kl+X70NKpi3T6ZJgOsWb2hP3NrDOLB12Ea0f/uI2ubF+/uJzFdydSQY+VzxUBJaP
X-Gm-Gg: ASbGncvf1YDBz+pmP3rrZUsxKrOQnlJrXud4QzcFbOAd/HHrVOsZX6+SSoTg3R4PlCJ
	UDUOQg4KRdb1csF+P0U+7qlSZD9rEoUNzKkjeInEzcXedMKfysJPRb7ew+3tfhKTfL10CBYFAd/
	msxtL4WkG9rT5JjxOlnstLo7cnGo7FdYMIkqdA9yXVVcegdMs8sSC5ew25q0gmXE8J3VjvoO1Rx
	kcHiEcpyAN3ZYKYJh6csoCJrPmtG8R7PVyuXOuaSINnTzrG2BIAvxCylwW4VpDSPf9oCpLmrX5d
	02Df5ni5BowRvLA2yR8P1jKyzztLsGYVEnweNq8tZYX9mFGHo152g89tDOzaMKBXjsDCqTuMIaC
	wWT0s4Q==
X-Google-Smtp-Source: AGHT+IE9aCBOMW8jOB8EK9bPb1ZC5O8NIYvfw46IhJ0zE1a/ZNZp97aFpovU0yXogxp864rkRJ3vng==
X-Received: by 2002:a05:6a00:4f8b:b0:746:cc71:cc0d with SMTP id d2e1a72fcca58-74827ff5446mr8425921b3a.12.1749284953096;
        Sat, 07 Jun 2025 01:29:13 -0700 (PDT)
Received: from manjaro.domain.name ([2401:4900:1c66:bf5b:2e56:6e66:c9ef:ed1b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b083908sm2332354b3a.76.2025.06.07.01.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jun 2025 01:29:12 -0700 (PDT)
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	kees@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	Pranav Tyagi <pranav.tyagi03@gmail.com>
Subject: [PATCH] binfmt_elf: use check_mul_overflow() for size calc
Date: Sat,  7 Jun 2025 13:58:44 +0530
Message-ID: <20250607082844.8779-1-pranav.tyagi03@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use check_mul_overflow() to safely compute the total size of ELF program
headers instead of relying on direct multiplication.

Directly multiplying sizeof(struct elf_phdr) with e_phnum risks integer
overflow, especially on 32-bit systems or with malformed ELF binaries
crafted to trigger wrap-around. If an overflow occurs, kmalloc() could
allocate insufficient memory, potentially leading to out-of-bound
accesses, memory corruption or security vulnerabilities.

Using check_mul_overflow() ensures the multiplication is performed
safely and detects overflows before memory allocation. This change makes
the function more robust when handling untrusted or corrupted binaries.

Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
Link: https://github.com/KSPP/linux/issues/92
---
 fs/binfmt_elf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index a43363d593e5..774e705798b8 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -518,7 +518,10 @@ static struct elf_phdr *load_elf_phdrs(const struct elfhdr *elf_ex,
 
 	/* Sanity check the number of program headers... */
 	/* ...and their total size. */
-	size = sizeof(struct elf_phdr) * elf_ex->e_phnum;
+	
+	if (check_mul_overflow(sizeof(struct elf_phdr), elf_ex->e_phnum, &size))
+		goto out;
+
 	if (size == 0 || size > 65536 || size > ELF_MIN_ALIGN)
 		goto out;
 
-- 
2.49.0


