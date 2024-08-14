Return-Path: <linux-fsdevel+bounces-26007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 908999524C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 23:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 471EB281E49
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 21:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2655E1D27BD;
	Wed, 14 Aug 2024 21:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="yKYxjzMI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05831C8FB3
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 21:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723670784; cv=none; b=Z4iNMNK1guYIb9SzxIsF8ocYCVVLygOJrzpEIT72Q2N6ttWoWUMpuG5szfhnKumPKHqQGPehiFwEaAlo8wQ1IGha211/IDyHo12HL+As7c24v/2VIOF9s1ytWVJ+Q1eCPkEOIb2kCfXMxn3/GjKe6QQhyTcNEFsNIMUmTqhq3Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723670784; c=relaxed/simple;
	bh=S0mezk7lokrHR+8fcU6LAupASbj5zKj9YDRU//oGrc4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mGBEXz83uR+l2ywnN6Ap63lcSPFYn1bWlq7j3JOP9TPJU4w6UbOLKRzK6uHKx2xHawM+Xd8/x9K5xSJDzyCNVin2T+gQur1XUI3WuZIw6HV3hrMiym6tESERH8EotDYdA8o1eCENH8mEBfm81ItGGpQhS9nQomQi0o4+1dxoBO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=yKYxjzMI; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a1d7bc07b7so21122285a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 14:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723670781; x=1724275581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/g0betjFPlSWGNNLN2rg+et8Qa/vCpguwAUALfab+wk=;
        b=yKYxjzMIHOKVD7hCfqqDbQ3M9MRTo7yLBD72u9lQJ+mFdhbDV088MXtG8urZrAPysj
         ybweUtaUr1xYRQjBHW3DQNwKBR6ilAPSyNAAgy4azinX3OB/tADp5lcp+O2Ao76NSl5W
         s3+SUN7NHq4J3Q3nBYeySTQ3XDRRkzuYWgokHzhhzEyFsSMOrU6fHRmzrADK2UmaS+sw
         sD5zjeXI7O0VSwDIQ8mbQfa/R0kBM46kV9F1c3m3bkfJgpk3+6b8oinyn11+cihhjfSq
         p80SBcXJJR6YPvjyS2+u5jPAGMxJqc5jGBkFwGpGNotkYebUJM1fS8IVHF/EZt02H1GS
         ngOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723670781; x=1724275581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/g0betjFPlSWGNNLN2rg+et8Qa/vCpguwAUALfab+wk=;
        b=wwfO3xBcY6xNbcr4DdCT9Ob5MPqiwmLdRLCsbtb+uQsvSrsiR0HHKbgcc+4unEj4mr
         cJHrXEGhKBV2IBj5jq3465bk1RK44cYGjGoea0yiP70g/tzxyZsi5mUnDl84WAdhbRvI
         QKamUaa8r1sJOEET8wgD2fVoIr5po55fNKemof+Zg0rUucFk1V5D3P8xSJzrGVeGnJu8
         ukwO837whSDcNgcl+Y+DiIQElWETll1MmpjpfZCSrDfSyN/LhmE98vhK3PBIZukf5HV7
         ICPuluzkHz1nJR2Xub10NzjuorpFKp9FUvZXXWWBSVv0Jvh21xZwRoteMY4IiQjPIDjn
         A3kA==
X-Forwarded-Encrypted: i=1; AJvYcCXwLXzOCmbEGNg8QgrWreaXhMFeUlkorGpsvc3unCXRynbAxvoThryKkpy4GUcqZTq2f4XB/LRofUPfKSajGPFSMh6K9COz1QN61eB9sw==
X-Gm-Message-State: AOJu0YzjGXjnOxWL3ltDG6+tlKzGCNeZKItl1INMUY9vVOM2ntBQqBX2
	yr8A8ZKCstD/OIY5raWu5mYTuWmXrKkc1yy7OJ//yO2ubtBbacSWFtJF1jGDMPE=
X-Google-Smtp-Source: AGHT+IEwLYSHYYTuAZJvUuE3hfd+/zuyGZIMkGIICNZLTcaMoU6Cqa81XGFABSQNoiEu298KSeXnZA==
X-Received: by 2002:a05:620a:288a:b0:79f:17d9:d86b with SMTP id af79cd13be357-7a4ee318773mr448400785a.12.1723670781667;
        Wed, 14 Aug 2024 14:26:21 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4536a072683sm480751cf.85.2024.08.14.14.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 14:26:21 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-bcachefs@vger.kernel.org
Subject: [PATCH v4 16/16] xfs: add pre-content fsnotify hook for write faults
Date: Wed, 14 Aug 2024 17:25:34 -0400
Message-ID: <631039816bbac737db351e3067520e85a8774ba1.1723670362.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1723670362.git.josef@toxicpanda.com>
References: <cover.1723670362.git.josef@toxicpanda.com>
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
index 4cdc54dc9686..e61c4c389d7d 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1283,6 +1283,10 @@ xfs_write_fault(
 	unsigned int		lock_mode = XFS_MMAPLOCK_SHARED;
 	vm_fault_t		ret;
 
+	ret = filemap_maybe_emit_fsnotify_event(vmf);
+	if (unlikely(ret))
+		return ret;
+
 	sb_start_pagefault(inode->i_sb);
 	file_update_time(vmf->vma->vm_file);
 
-- 
2.43.0


