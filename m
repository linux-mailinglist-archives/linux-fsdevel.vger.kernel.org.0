Return-Path: <linux-fsdevel+bounces-43772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B489AA5D76C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 08:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F93D17794D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 07:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06E81F4C98;
	Wed, 12 Mar 2025 07:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEFonwmE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEDE1F460D
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 07:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741765147; cv=none; b=NBDpzKjZAcMLQ98e7zg1WZ+uAUIgLzI+cdXH+e/ZS6OKHoFCjNSjxtJ8f7PXEcKRQ4MEVBBxOHZe4uqzhrzT5pDfMqyP5UxgR3324PxDpgSCt2lpQgOv+/hcZ5pJsuy+ZD1bBYgsUvEi0r0iacehGeLYwKd+XYCmTWxQrFTAdOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741765147; c=relaxed/simple;
	bh=bTK3jtftynOv/WlNZDvT/yF/UXzCPiJWj2Qcmbp1dbk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X9fSHSd3AZH6VZYJ3OtVP1bkNBdquKeYMIgFqWwFWPqgLg5O83qP8fgVFq2N05+qLMaTxLF6Df5thgAmKfFgHcGT2sviI6B0ESETx9NZ0ceJv0VTb0tHUl8VGPydb/heR2CNr6i6yuPyPSIgo5mPB3ehtax4mlIqT1lsn6FJGTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HEFonwmE; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac2af2f15d1so356757366b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 00:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741765144; x=1742369944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2DQBQeFfgio6scrhS9JiQpooi7cpDMvH51E4N2rfb4=;
        b=HEFonwmEqj1QaDYCaqiLCYYWjagXJNDUxcmYmALYVH+JTEYVqbp5vctKUYhpkVsA1e
         BDmP1RIFm+M7KA5WorF5HS8KG2Y+JD5PPcIPEgPSqKY/yez1KZmpIwNyz6aQNwZ1dKTy
         olgYMea220vhUjNI0g5HQ30WGIs9dVonx6RhdrBj/FkHxH5SIKRaIMt3sOxhzI6/lk2s
         fgZoYRqaJFl7FEiOW4Q0oSVav/misFkRIJ9rCq/IL8GiMeXCbDTIpbD+azIdcQ1pXvCZ
         M/t8bSb124KLkPySb3sgnPysS53wlaP4ZJDwCCZRnguaDic5IQitDRYgxIssftSgZdTE
         0Pcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741765144; x=1742369944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N2DQBQeFfgio6scrhS9JiQpooi7cpDMvH51E4N2rfb4=;
        b=rA2SFiAAZh0PvfTKQxc5fVggSbspLig9K5n5oDJg1uMRJ7MYrApQiu9QhrLxfFdKDK
         id21blC2+ouIxUxT3+KqhAmPyokIiswI6ECk1NSzcZNzQfNjbPCsB2lOnJxxqS/dE0T+
         51AeJR/nkWgTgkxxPg2oI+q9oTVQoR/xw4oB4+B+dwy2lDTLSMmQhD6CGbCee1qTjQg2
         NJrIG5m4zy5/EFe90MIvVoLiaktbpls/jo0YBMKXugnTwdtlGKuc5GcNB+IGv0yPHqPc
         frL+vRvLxxLmMY9YKqlCzkbnjASSN7FCldM3ET3H91XZucareDLLkN6tkQ49jC0zWdDY
         /XVw==
X-Forwarded-Encrypted: i=1; AJvYcCXuAPHsiUz7o9gKgk6hyByJTh1uxTgOY+63bScrK/3oo2i7edE4qQVdNj9qPA/EDVZKAcoETkOjgGramVA+@vger.kernel.org
X-Gm-Message-State: AOJu0YxVXr/1XsDqK/dE2v/BCHVDsoTG44c/aD/AmH1Ovj/f37lGnWtz
	p1Iwn1tqq9ms9Jn+1aEL3zRoeu6FtSt2yYDflr2mNDZaAt/FVhj/b4OLdqxr
X-Gm-Gg: ASbGncsOO5TdwQg5/rBNXpEBRd9ITijgb9H+7nkN8xF4zzylN82aBC3qBJ6mASGH9PN
	GzFpWW4jg0+bJ3AZwMawbnWbjXVghfpM5R/cjc0FDBLaDMH2/JLPCsKm5xv1kECl2VXgJjmlMFO
	kr7mAxtJPRlJh/QiAMDgFOu/ejdvL/I5Jb0WII1eSOG7EM1WiiBVRNaK8nTU+dTvC4Q/a5zErru
	0WT4YCKAGhj7U0+iYcxUKtehWQVIa5GsuZtRFGMz7fgUxo+IJxysPVq+r2bcjU8PtOyaP5ACERO
	Zasq/QG0nvVSxIp+dFhqLWYsrG5DWycaHG7BfpUhRTOO1hdn2if1OZT2pBVeSuIgWmWDZmv/OjE
	g10EdY+NQLpE/5u7IyY5XJzI70NeNZpB6+sWAvJYf2Q==
X-Google-Smtp-Source: AGHT+IHp+6imqaRdqahtNJSC0y4twKiAMajeOL008N2BmoKne5vBXzxLbY6tsDEGRYCVj53AMPaesQ==
X-Received: by 2002:a17:907:c99a:b0:ac2:b684:541d with SMTP id a640c23a62f3a-ac2b9ee9204mr755158866b.54.1741765143665;
        Wed, 12 Mar 2025 00:39:03 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac282c69e89sm624740666b.167.2025.03.12.00.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 00:39:02 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 3/6] Revert "xfs: add pre-content fsnotify hook for DAX faults"
Date: Wed, 12 Mar 2025 08:38:49 +0100
Message-Id: <20250312073852.2123409-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250312073852.2123409-1-amir73il@gmail.com>
References: <20250312073852.2123409-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 7f4796a46571ced5d3d5b0942e1bfea1eedaaecd.
---
 fs/xfs/xfs_file.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index f7a7d89c345ec..9a435b1ff2647 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1451,9 +1451,6 @@ xfs_dax_read_fault(
 
 	trace_xfs_read_fault(ip, order);
 
-	ret = filemap_fsnotify_fault(vmf);
-	if (unlikely(ret))
-		return ret;
 	xfs_ilock(ip, XFS_MMAPLOCK_SHARED);
 	ret = xfs_dax_fault_locked(vmf, order, false);
 	xfs_iunlock(ip, XFS_MMAPLOCK_SHARED);
@@ -1482,16 +1479,6 @@ xfs_write_fault(
 	vm_fault_t		ret;
 
 	trace_xfs_write_fault(ip, order);
-	/*
-	 * Usually we get here from ->page_mkwrite callback but in case of DAX
-	 * we will get here also for ordinary write fault. Handle HSM
-	 * notifications for that case.
-	 */
-	if (IS_DAX(inode)) {
-		ret = filemap_fsnotify_fault(vmf);
-		if (unlikely(ret))
-			return ret;
-	}
 
 	sb_start_pagefault(inode->i_sb);
 	file_update_time(vmf->vma->vm_file);
-- 
2.34.1


