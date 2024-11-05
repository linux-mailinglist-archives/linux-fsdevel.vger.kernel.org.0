Return-Path: <linux-fsdevel+bounces-33671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B4B9BCFBA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 15:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADC201C238F5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 14:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61B91D63DE;
	Tue,  5 Nov 2024 14:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMvdVxeH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783D3EAD2;
	Tue,  5 Nov 2024 14:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730818186; cv=none; b=bDt9+5U/Dp2LY5U/KL78DzBr/YDrs4OWsczNCRetj7U4nGzm3nHC/X8UDy/bwqcXiJYSrqteaCVIZOeH4MBPzWjQiyRT7mjm2erbM/ODB/QzNQ/Pw+FXu7AIt263G+1l0yXDqYGmXwYPibvKHdCpuQ1J4gQbHqEXnGrkkqJldeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730818186; c=relaxed/simple;
	bh=BPmak7LfWUub+WbdJVbC9KXrNqE7WYbqXVJeJu+IZMI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p7RCq9zxVzZuXFSWG0FxoQmbw/G4S701cKWLwusv9TWDcef6uqhU4d1XAcUTgr3tM8nfRP3M016sDx7bubfiZcC2tOm3/hmGZQnbgvnl+LfDaJNBJ5SeIIxyDoAQI/H8bcJ0ooY9TA2nib1OE9UJ99YZngw472z0GkGmhJrSv7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MMvdVxeH; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-431548bd1b4so47017075e9.3;
        Tue, 05 Nov 2024 06:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730818183; x=1731422983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eJTxByR6AXHxnxbRyHX5zBRxGd3Nb4QSHtvdR715Tsw=;
        b=MMvdVxeHmKF56b9a92cTFbLiBWBrjrTdpKrlxvUxFUvLsgOincIbHnas5jE0M0RaEm
         0Cq0p01FmPLHyJz4MMkNjKcZ9jITFR1QXH0+p2LHJaCgkWqy+8CeRkAKuRP7E4WDvqer
         O5ZcxSij2f+GjxregP03bLfuDSnDDudCF+GMxxVLv/jupU/8LgGXgclwjgcg1l8hdrZP
         cLhnggmQxj0RoUC62/F5jyaocf/5ptf0QEllDI2yT0xlkhbFaOTXgh6xz39wBZOcAa5k
         QEjNuDgOWL2JOYpk3AKzm5tBSaNE42GfGUIHnPPCRAwpdwd1yn8bEYIpiF5A1DgScqd7
         xMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730818183; x=1731422983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eJTxByR6AXHxnxbRyHX5zBRxGd3Nb4QSHtvdR715Tsw=;
        b=XfcW+KLxm9gw9wBoqI+TUwX4jQBHd4m3qXHWOuQawEngZT3izeO8IFmjYqmVXzZj46
         ZKCyUNwleuLGvGNWWbGOsaWTpnI07I1dxcfi3qs9VGVscb8Cn0IdM4A4rtfw0z0ZrSVS
         vc0RlVR1HTimXpirTH4c0MdBQJ9NDmD3v5W5p+Yq2TOQvvZLOvSdMbOBeJPZJoF12hnX
         G9rVJa27RnyMn1YLzCajssHeyiicdnYWHBryI2gZajFupOHurwd2p6D/GEL7I9LkCJyZ
         7a1kYADb9RNUDNyR7dQ2FHQilNjD8R9Fa4l8HHr6u1h2CIDiNFluVu/WCIbBNU5jgYZm
         LAvA==
X-Forwarded-Encrypted: i=1; AJvYcCUsT/DMx88kZxJLwK1+Q0YXHTpNSGPfpNuTeuH+PhZAkJNR2YOdlRTAo7gLISuV93LdSMBZYsih/TVRrFxv@vger.kernel.org, AJvYcCWb1qkIpTjbLrnneeB+EBXFK2QBDE2lCgfpF3l08Og7jQO8OOHs8/BlheMEtYhDzRdbC/y1NPLGrnqM@vger.kernel.org
X-Gm-Message-State: AOJu0YzQRli7RaVmLeA1MuumjPlSNFvQOn8YhfhKPouVOyYvXrY2223i
	YUuKckNb3O+Z6eiNNK+c/S+oR6f0TPYOCBosNeRM+cE4uSWQ3WGh
X-Google-Smtp-Source: AGHT+IG7EnAqRoxVWbC4512PRc4VgwkDio9NbETO03MkFzUoX4suavZEzxCwHPy6srxGm71/I8kdpg==
X-Received: by 2002:a05:600c:3150:b0:431:5ce5:4864 with SMTP id 5b1f17b1804b1-432832aa0b1mr125838825e9.35.1730818182411;
        Tue, 05 Nov 2024 06:49:42 -0800 (PST)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5ab2aasm190488065e9.6.2024.11.05.06.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 06:49:41 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Alejandro Colomar <alx.manpages@gmail.com>
Cc: Jan Kara <jack@suse.cz>,
	linux-man@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2] fanotify.7,fanotify_mark.2: update documentation of fanotify w.r.t fsid
Date: Tue,  5 Nov 2024 15:49:39 +0100
Message-Id: <20241105144939.181820-1-amir73il@gmail.com>
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

Changes since v1:
- Fix review comments [1]

[1] https://lore.kernel.org/linux-fsdevel/20241101130732.xzpottv5ru63w4wd@devuan/

 man/man2/fanotify_mark.2 | 27 +++++++++++++++++++++------
 man/man7/fanotify.7      | 11 +++++++++++
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/man/man2/fanotify_mark.2 b/man/man2/fanotify_mark.2
index fc9b83459..47cafb21c 100644
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
+this error can be returned
+when trying to add a mount or filesystem mark.
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
index 449af949c..b270f3c99 100644
--- a/man/man7/fanotify.7
+++ b/man/man7/fanotify.7
@@ -575,6 +575,17 @@ and contains the same value as
 .I f_fsid
 when calling
 .BR statfs (2).
+Note that some filesystems (e.g.,
+.BR fuse (4))
+report zero
+.IR fsid .
+In these cases,
+it is not possible to use
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


