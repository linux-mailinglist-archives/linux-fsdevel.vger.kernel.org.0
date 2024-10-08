Return-Path: <linux-fsdevel+bounces-31302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D44899449A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 11:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ACE21C24BA0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 09:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DEB18133F;
	Tue,  8 Oct 2024 09:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEDYVtfT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CB6185B58;
	Tue,  8 Oct 2024 09:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728380711; cv=none; b=KikRAGXYkow9A4BtgvCCXhF7bj3msoV2uDbE8S5BsEUoO6Q7gRNy/4Obn0/Wyb4V4KNlI1Lm2c/jiVAENoL4qT/v/wryDsRyJ+VGikJkPIAe/cabOR4KEkQWwN9wIrmyYM+PVclR+SA2Gh97vmTfT/oPdKoB+xdP0c3Ueo3ZqHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728380711; c=relaxed/simple;
	bh=n+9fb+3Nmw6pkM1BjelSY7XjQ7KVMSvaL3DgOLud2ho=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QK4O9fDNkQ6pP9ncFc8iNj3e2EarctxUw2tsQX4dUagEGZxrLc0bR8FPWHWYOkOYFFpTmRVPegqAucFGHegf+A4gD3g1Ur6jsGuu1GEGl7RftB0ZlArg31YMWVYZWBNPgDpAcqeEbR+zSE4ezlaZLD6O9tGhUBHB3kzedu5YLcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eEDYVtfT; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9977360f9fso50879666b.0;
        Tue, 08 Oct 2024 02:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728380708; x=1728985508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MFxI1VKgjkw/8hVmNciu5zIxg5NN9OAwSt9Mfm2Hu5I=;
        b=eEDYVtfTWFZoHUjhQBh+K6mspSI/LlRwZEHgBhX7pWG0Ji8SYaqtMUN8TbJvcbxGTw
         xDRKVMwK54W2WuFa9JTriqO7ISL0mUpEZNs1KoLJjuKsz/k5M7PKZ9fdOnChah3abb5l
         NUvY3GNXVi5beFWzJ7542ObE4k4istpi32Qsc1nmcTWaWm2AARPoOl27o5JSYYXlMdDq
         ZGrhqIB1jwmgylFZANdefdHx0SjAncM0rmjCjmKXjhcNgpQthrTyoiRbSo/s6GeNBe4c
         zUJv3j4C3fqYmGb6lI/kfYjRgDECTMjMY3H2SVvmIY8OIMuFjEi+AbBzNnsob00c6GeU
         rGMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728380708; x=1728985508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MFxI1VKgjkw/8hVmNciu5zIxg5NN9OAwSt9Mfm2Hu5I=;
        b=Y2JLPVmis6W1b2vR2oZaTS48cTLdLs3R3TZR+2Bsq1TBvEhw61KUdQzardvhjG4a1g
         OkXxRVqaGNS8Dyx2IBnv17IhRJZksw1isdjkjowc0EXorBOSyUfwjqHBS40fKefhwRgV
         NsnKWiVSwLf6shRQhCoYszjhtnDupjcuHxLe4dd2lQjfR+uCyooZvo6ofhcA3kaUEbYi
         UFud4qdtDY+gsrPeUAlvyosTLSfNiNtEHMgUwfPWdTLWDWc7cHs8c+0dHPq7RP9vP3r/
         fBLefubLkU2GPqt5e3vlW7eXzIHN7iA3KpOOSdCxyHGPB49j/L7ftnTI3QNl/rPkU/4b
         g0uQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfW9z7gx1SaPgNz0F1X7X2rlEbVQmjOMZie+y4YyReAfYXYl5kpjOthp6Cd3PNF0DOOq39Q4CPLOVAr3Xg@vger.kernel.org, AJvYcCXX4wen9zElbgtBqWS13GHjtpC/Y6AfsAY4NyqpEN75pRTxQn4OcF+ZxuEIp8W4um9PtOY1Z03CtQqk@vger.kernel.org
X-Gm-Message-State: AOJu0YyjJgxspKYM6BJK/n6wDU3Nu0lOA+r89EvrEqvulwb1QqlmnvxN
	2v2dUq6/sMZrALkE/iUMABgkFIg/gbbvc1zjznWzliYm+kz7mAEB
X-Google-Smtp-Source: AGHT+IGnSmpDOVJBvJdF1rcolLyjWCWVqbq2QzO6i9FJ1JqWgzWPVxVIyNydojswWiqbPunTqJhI8w==
X-Received: by 2002:a17:906:6a1e:b0:a99:742c:5a6 with SMTP id a640c23a62f3a-a99742c40ebmr136543566b.10.1728380707461;
        Tue, 08 Oct 2024 02:45:07 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e7856dbsm478108166b.122.2024.10.08.02.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 02:45:06 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Alejandro Colomar <alx.manpages@gmail.com>
Cc: Jan Kara <jack@suse.cz>,
	linux-man@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] fanotify.7,fanotify_mark.2: update documentation of fanotify w.r.t fsid
Date: Tue,  8 Oct 2024 11:45:03 +0200
Message-Id: <20241008094503.368923-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clarify the conditions for getting the -EXDEV and -ENODEV errors.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Hi Alejandro,

This is a followup on fanotify changes from v6.8
that are forgot to follow up on at the time.

Thanks,
Amir.

 man/man2/fanotify_mark.2 | 27 +++++++++++++++++++++------
 man/man7/fanotify.7      | 10 ++++++++++
 2 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/man/man2/fanotify_mark.2 b/man/man2/fanotify_mark.2
index fc9b83459..b5e091c25 100644
--- a/man/man2/fanotify_mark.2
+++ b/man/man2/fanotify_mark.2
@@ -659,17 +659,16 @@ The filesystem object indicated by
 .I dirfd
 and
 .I pathname
-is not associated with a filesystem that supports
+is associated with a filesystem that reports zero
 .I fsid
 (e.g.,
 .BR fuse (4)).
-.BR tmpfs (5)
-did not support
-.I fsid
-prior to Linux 5.13.
-.\" commit 59cda49ecf6c9a32fae4942420701b6e087204f6
 This error can be returned only with an fanotify group that identifies
 filesystem objects by file handles.
+Since Linux 6.8,
+.\" commit 30ad1938326bf9303ca38090339d948975a626f5
+this error can be returned only when
+trying to add a mount or filesystem mark.
 .TP
 .B ENOENT
 The filesystem object indicated by
@@ -768,6 +767,22 @@ which uses a different
 than its root superblock.
 This error can be returned only with an fanotify group that identifies
 filesystem objects by file handles.
+Since Linux 6.8,
+.\" commit 30ad1938326bf9303ca38090339d948975a626f5
+this error will be returned
+when trying to add a mount or filesystem mark on a subvolume,
+when trying to add inode marks in different subvolumes,
+or when trying to add inode marks in a
+.BR btrfs (5)
+subvolume and in another filesystem.
+Since Linux 6.8,
+.\" commit 30ad1938326bf9303ca38090339d948975a626f5
+this error will also be returned
+when trying to add marks in different filesystems,
+where one of the filesystems reports zero
+.I fsid
+(e.g.,
+.BR fuse (4)).
 .SH STANDARDS
 Linux.
 .SH HISTORY
diff --git a/man/man7/fanotify.7 b/man/man7/fanotify.7
index 449af949c..db8fe6c00 100644
--- a/man/man7/fanotify.7
+++ b/man/man7/fanotify.7
@@ -575,6 +575,16 @@ and contains the same value as
 .I f_fsid
 when calling
 .BR statfs (2).
+Note that some filesystems (e.g.,
+.BR fuse (4))
+report zero
+.IR fsid .
+In these cases, it is not possible to use
+.I fsid
+to associate the event with a specific filesystem instance,
+so monitoring different filesystem instances that report zero
+.I fsid
+with the same fanotify group is not supported.
 .TP
 .I handle
 This field contains a variable-length structure of type
-- 
2.34.1


