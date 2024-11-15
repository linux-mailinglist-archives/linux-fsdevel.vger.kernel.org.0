Return-Path: <linux-fsdevel+bounces-34944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6369CF03A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 16:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 737DC28A534
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 15:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C0E1F473C;
	Fri, 15 Nov 2024 15:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="eC0cYIic"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976E31F26FF
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 15:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684718; cv=none; b=kLl35xfmTUJgS/G376LFeO7CflCPCnzas/hWthwdK1VoFpiWeconqcyw7/Y08nRy0ZyNZXqFYpUFDqacQsJzZ/mSv9La3whHh3H0fb6HScZMgmI3Nnv6iX2u48rfzrxqcPHLYBG+1p7oM9rpO2H3wgzxO43Kp7d6P1VCilDB3uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684718; c=relaxed/simple;
	bh=2N0bizMEg0czxuSX0Hl7S5FVpQVRVn9Mf1MRV8yCr7o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LaMRvAgtZc4wA9fh2UBNG1gvLQI2MBQG8QC48tq0/bsreu0QGVhJgZn1mwRveWMnOrEFJFtjtzwHnAUXSLUmkhLBgh+7k7+kz8TBff/t/u4m9GB1jQZBFEIzD85fMgZXP4RaNmfttl7hJX8Fp/J/6nnawRlb5REgziyrlaGovl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=eC0cYIic; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6e3cdbc25a0so21877047b3.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 07:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731684716; x=1732289516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3nbIBZPU5mMiQBH7fH9PUjd6pvpSRIo6Q0oL6vGrX38=;
        b=eC0cYIicdKHGAKWmNkEFoUITofha1lNixX70BShTKVQVY9e3K9rBoMn6DWQp3kqlbP
         dpkBv0NLvDUbcG+MRDBxbLVklABB9YUa5oPLnk5u9szWMwn8QUspmsNqUXyV+dYrt0At
         8l7cdttDXn/lVGSGvJJN+neqoBkH2ADhP4Qz9mT1Gt2O1Yra10BV7mMLn4nsJYZgTl+Y
         vTWtQKV0Zx30w4Q6jiXGwljA8/HQD9dqxYQLHjZA9L7BVVXbccbrvS8lQW/DWtOkNuMi
         kT979D0Y3YYxjZORHK16QThmQlQt/dkuaw5g9nx/3jFdQt4BmpBHv8/j6R6Y1Ia8P2Ro
         7U/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731684716; x=1732289516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3nbIBZPU5mMiQBH7fH9PUjd6pvpSRIo6Q0oL6vGrX38=;
        b=tw31jHKdEYpk2p7nxLZlHfISCXWv6BU3mCzfBHWrEFQe3O8P5PpEyWTsPNfkiXzE9i
         CUaybqcc92F3NPXKZPX4EpnjUpnbPM/c51WsInHYoaDNbHSkbRalKIySmK6uK6MFyu6x
         X6PR9UI/9XkMZGTbYu8pfP5RXPnneYWNDb70YQ4rJNiWgkc5oZ4ormYPsWkmBGF4L0Yq
         CtTl2wFmco2a0YbjzgHacpZf5iBeKgDSiWmdanjJU1QDpU98Q+yFcm5seZ/4uUhGBQZU
         AmY1Fx3HYItF7WW50Y6tpjnNjwHuIabTmFSNe/fnSUZ0BXhQzy0aEhaOZgdLVO7juy4K
         Y9mQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8c/6fhqwQpRuUVlKaqKnEa1IXneFJ8godLn5Q92gSc5jVsK1fgvcPI/Afjcl99lUjYjp05yaIjsL7HsOW@vger.kernel.org
X-Gm-Message-State: AOJu0YxOhSf4dCJ1BxPpFFtraxsNFftXjoss0EhlkFmTUn5GPgs/hlhM
	8F8Ty/cRPt0EHKEWLQZwLL60WvD5A0QiSX/OBjbpKtKGI86JSir0LMDTrzFDbx8=
X-Google-Smtp-Source: AGHT+IF2kfSK7avJhhme8jmNEknNmwYth/OIHi/JSJVRuMCWaSMr+rN1yucoeC0+W4HJkwXlrHqqNQ==
X-Received: by 2002:a05:690c:688a:b0:6ea:7c46:8c23 with SMTP id 00721157ae682-6ee55ef8021mr42068567b3.35.1731684715691;
        Fri, 15 Nov 2024 07:31:55 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee440709dbsm7729117b3.54.2024.11.15.07.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:31:55 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH v8 17/19] xfs: add pre-content fsnotify hook for write faults
Date: Fri, 15 Nov 2024 10:30:30 -0500
Message-ID: <9eccdf59a65b72f0a1a5e2f2b9bff8eda2d4f2d9.1731684329.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1731684329.git.josef@toxicpanda.com>
References: <cover.1731684329.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xfs has it's own handling for write faults, so we need to add the
pre-content fsnotify hook for this case.  Reads go through filemap_fault
so they're handled properly there.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/xfs/xfs_file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index ca47cae5a40a..4fe89770ecb5 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1458,6 +1458,10 @@ xfs_write_fault(
 	unsigned int		lock_mode = XFS_MMAPLOCK_SHARED;
 	vm_fault_t		ret;
 
+	ret = filemap_fsnotify_fault(vmf);
+	if (unlikely(ret))
+		return ret;
+
 	sb_start_pagefault(inode->i_sb);
 	file_update_time(vmf->vma->vm_file);
 
-- 
2.43.0


