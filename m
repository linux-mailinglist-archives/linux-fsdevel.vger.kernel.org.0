Return-Path: <linux-fsdevel+bounces-57798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC554B256A5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 00:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBA5C5C037C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 22:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CD62D59E3;
	Wed, 13 Aug 2025 22:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftxMHVi3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E51302756
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Aug 2025 22:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755124534; cv=none; b=dnC8xfwRB/Oqk+hTeuK9qw8/61Bex/hIEiR2K9Sh/2TA43zHoDHRKQsADhwcHnriBM0sdiYN4TSAHIRVGqZRBeJ3kIlszxWvTHWAn6nNxhXUzx9A1qSFSQpNKlXzRgP30+J0uFTaEuugO03SOE/AyA8Wki7SEyS2W9UgEk2qpYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755124534; c=relaxed/simple;
	bh=nkvQGTWRwUskOFZz4CwekR9h99QXCNIha1A0Yb7by+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zhhwueyq1DYGiVORiSY3m6tcgxhi4d5l5Sbvu+IcC92kXh1TQZgHE69Ft9RH7xM1B61PPZqED/gS5SyVLHh0jjv2htjF5KJlI+DeptT/RUTtjcaGx7p4ssEkcXsKmo+c9abaWR9Zv3M6++2A0YxVbMbmdvN7oGi9F+imowH6/qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ftxMHVi3; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76e2e8bb2e5so625218b3a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Aug 2025 15:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755124532; x=1755729332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jZN/w1FNt+qUGY5NxXr0lRDjIVO+IG0vU2CLapu/8Qg=;
        b=ftxMHVi3hZ9uTgE+HJQEiKbX7SrL1uNkDwvV6AHbdwzmR2UimgVLQftVkTtjnLgvNM
         aK5dihsuXyxNKq7dsN7m9w3pgyaRWjHlxEqjBVtxXpVNaRgSRtQUPUJoRAUddHBQX0hJ
         CNRV0jvJdXp5ktdfuY5c9gjDrKG2PSto7QqLqb/h8SZarpk0FHaV7P9pQA6PUjxxXXML
         RYuH+3xBxkC8PUwLfWhtoY471sKo3fuU8Dig/MVeg7+Jx5Ow7ft03+GiAzeiu0O6qbWA
         GK7ViXy8hajTT1PdDQO5g4Yt9qLrvToAanSxM0/QO/grkDQQAYy7/nNqWoILIp2fvRvG
         b8UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755124532; x=1755729332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jZN/w1FNt+qUGY5NxXr0lRDjIVO+IG0vU2CLapu/8Qg=;
        b=QM0R3rjW0YoUeOpPANpQQ7EOTexvT4voFoRFXncdSW9e9KoCIFK7Gg/8qCc2vXxXFd
         +mMIlQOBDW9t3q0FXnZunau6PIPQP4HG9r3hSCrcAyQku5H2QuC97vgEAm/smoO3XJ8O
         wZ5uKwEub26x3NI7fTJeVC6s5XZ7RwL6W6u/zFY38S+EyP5992IYKVXtlkyCKV0PQGLs
         CEHMwpfrR/xB6aS1aqSfqdU4H9yPnsWMJBIsoN4FL1oSsGMBMvaq09c/ZAqivcj/PWfk
         GM1Mm+Vocs0fBv4nCeHWw0myqxUmyGtZ+Szx+sN8r0NBBOII811bwvXalkT8pVKd78cw
         HUeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJIAtmvKlOnXA9jvXlXDqSgP4LpyrHGOR6dMAUqWk1DpirDy6WnwDvwfWBu5qfcQ5iisyMifKfWiHfWuoh@vger.kernel.org
X-Gm-Message-State: AOJu0YwhhDw3zrtKgQliQzFFYOMFBRJFMgsNvC7Ia3dx/W87JWgFYGU/
	qmKgpRz/YUU0jGmKmWDCraRdcxlsD/Pklp2hG99e3o/KqtoSuK5VF8rr
X-Gm-Gg: ASbGncu5QBwEx45Ckz8ZID//QWkQ4huUZDvHxZ34U7Qm4NwJDXvXQ31WxSPMO2Geps0
	N9iwJc6rXGlo4LvQrDq20/sqguzqER2a6Hf7ejnNXEdATqqOzLZK7i9AsuVvXX2/La23WX17DVf
	WoQyR8yIGHn871SnuSTsRVVmF9jyzhH1B3sjj2ovqWwstDmzR6FEEO5EtDTGYYfSdr/+stNZR8L
	s6vGDeesqtJy/jF3ns7oTcFlLmwHNDMjFoC5IZb3wqXezTDcrMl6R6ub91Q7IwqGg1Sfgnk4MdV
	RLKoLCR1tmGAk8H8SazsFiypEZWYCEp9Cw1mgsSdqVjNCWMDEErBHARTrMY0lqgUYLAiXOa932L
	uu8vkTdDoQZoPK2xM
X-Google-Smtp-Source: AGHT+IGP+kCubrOpWikf/ShFhyfFEB7bmzuBT3Lpi37epoLA/8YfFLVXs7d2PUaB+u108kcVwkrG8A==
X-Received: by 2002:a05:6a00:2d9d:b0:76b:ca98:faae with SMTP id d2e1a72fcca58-76e2fc290b2mr1518091b3a.8.1755124532344;
        Wed, 13 Aug 2025 15:35:32 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:6::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c5de39e24sm12647813b3a.122.2025.08.13.15.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 15:35:32 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: miklos@szeredi.hu,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 0/2] fuse: inode blocksize fixes for iomap integration 
Date: Wed, 13 Aug 2025 15:35:19 -0700
Message-ID: <20250813223521.734817-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These 2 patches are fixes for inode blocksize usage in fuse.

The first is neededed to maintain current stat() behavior for clients in the
case where fuse uses cached values for stat, and the second is needed for
fuseblk filesystems as a workaround until fuse implements iomap for reads.
(A previous version of the 2nd patch was submitted earlier [1], which this
current verison supersedes). These two patches are submitted together since
the 2nd patch updates code changed in the 1st patch.

These patches are on top of Christian's vfs.fixes tree.

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/20250812014623.2408476-1-joannelkoong@gmail.com/T/#u

Changelog
v1: https://lore.kernel.org/linux-fsdevel/20250812214614.2674485-1-joannelkoong@gmail.com/
v1 -> v2:
- fix spacing to avoid overly long line
- add ctx->blksize check

Joanne Koong (2):
  fuse: reflect cached blocksize if blocksize was changed
  fuse: fix fuseblk i_blkbits for iomap partial writes

 fs/fuse/dir.c    |  3 ++-
 fs/fuse/fuse_i.h | 14 ++++++++++++++
 fs/fuse/inode.c  | 16 ++++++++++++++++
 3 files changed, 32 insertions(+), 1 deletion(-)

-- 
2.47.3


