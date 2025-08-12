Return-Path: <linux-fsdevel+bounces-57588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B787B23B0A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 23:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F5381AA6CBA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 21:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE422E425E;
	Tue, 12 Aug 2025 21:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SuldJimQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369A52D8390
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Aug 2025 21:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755035256; cv=none; b=Ziw1mMb8tKu/ZIKLri2fKCpCSSd/5pzp4lu4YIsY+iuQSbHd7fUospVYOz9erBFlqV6/bkdzIShcRqnyQZIfbggkaDMPstUdpzaooEApJa9tIZKuxHTXqERovgVtqjvjYrqX15dIrymdHExxFw/wYkGuwvUF3JPK2C5K/G3Fgu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755035256; c=relaxed/simple;
	bh=vvw/5kregCiK4Xb4WoDPOeqQPrZom9Ew7R+7BN3pkhg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OKdfOkHG3QImP8dKA67FirQ84jwUucAuYGA1gtPzBuU7WHccXiPLPTaNMAyrqYrUb2D8FKur0HXsL137j0tGo0pdWfzZw53nj7w5hVJUesLX4+cqtYIQ2Fpj6Aoxs342AoUqepuNnkPxmH3HcFE4mdtP9JcS1QnTjUvuJJ3a4iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SuldJimQ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76bc55f6612so377272b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Aug 2025 14:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755035253; x=1755640053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PTV5I3mfnZWhEbC25Te8JUcjHByTM7xn9FR3MUFiYD4=;
        b=SuldJimQ9tPiBepQXEJn1AAm2/1LbdoMcbvCa1l5klfYroW5mxpx5ZrzHz6xFqaR0e
         a02rd1BFDd6jRbfFFuQVGrsEiq/JVW4nL5rWzQ54rChCP3HDqr7RJq35z6GRxN4oKwaB
         KFxcM5NuGlUqpjXTbpQ7iXejFRfyKBk3YXJnaLN37dbKuzCHmvUyXVoHni4R+Lg3deB4
         mVDyM9t5DXcJ7iEGXQxdJN5WLFg3rfcn2VhdH9dOnv1Pkc5GEoHWejlEphO4kcbUFMw8
         XBRpqjvaLfnrGnHlH2Jz8uERKLX1y1KcdHsPfQJ9stl5f3qiSCmuIch7RWmEtgZ27mZu
         haPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755035253; x=1755640053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PTV5I3mfnZWhEbC25Te8JUcjHByTM7xn9FR3MUFiYD4=;
        b=BZOCkGCElraRdZumIiBrDPXJ2Qh+5GHMWjY6Ck+zj6yPWEJo59ZWFCeOnadifUhSiX
         dCOQ2oPLCPiCb4DOUbOtvtbsmBmITzsiELGse8+5au0Z1zzdTCITmKTkerBnYoq0J0/C
         0EjVHahNFACAf+tEC0w8ppBY9VsSFw8n3Vf2pMchYUeq9dN/0iF96RKnaw+ItG7qHQm3
         HyQ8mM5iakirKfqKmH99e1z5W8Uv6BOGtarjDE+OAgXGAl2qdupc0RlekWgIwn1ATy+a
         O6WdP9m9bRlhyTcKk5qOMnsh7v1qzjGUVIYHrnrJbU+J1os/asEU9lBWNp1dR6rr70ts
         92Qg==
X-Forwarded-Encrypted: i=1; AJvYcCWqT3KTpdN8WjPuULIRoucTJUmPibvItJ8h74A6zxUGtTy9QjuBvfp0org6MFE9hGylgntx+9oESI+EP2oA@vger.kernel.org
X-Gm-Message-State: AOJu0YwsFn28w2veicWgp2navhhi8HfLiS3zIFEq/8z8Pat314pWEHkX
	xIC04j9B3EhFtVjZ4Av5LxbJu7+JYEfLF2hQJ4pFfMMGhuJJVLW/361c
X-Gm-Gg: ASbGncufh4iauP3r1nn94TNUvLsaXvLRcAFluPaenUNaIVAcEvt3oCmwT8xyjeJwUK4
	gSeY7AuM33byN9kxf/KSFcw6IZjErrMOp1lGXgrjpIrkuzkEPxcKc3saFSI+ZIsUkNiUdMrGDKk
	UomN7tDWHDI3UMUu10PZmEovMeqEB7zxSYOFG53310WAZQRZJog/VOt8vdCX/ibGVg1ECKCaO4H
	q7pXYSl5l1wElG7dK618olYP7G3PrioPoC4AqFklWbz/E8IOBEFo18oD4/4NqVEcwa6wkOMbkLV
	aqc1fTvHT1NonhRwRSSxNt9r0n61zftxExZk8K8R3mne+UMuBQcCa5aNfMhyc62+vT5fVY7xZ3P
	97B/eoJsoHzqBvBQ0uw==
X-Google-Smtp-Source: AGHT+IGR1bl3EVJxDDgcY0xDgd+c45aP3RzkFaR2m7mIucDxYrSVKrOs3EcX7aQ10AcQbi+Su7QDPQ==
X-Received: by 2002:aa7:9a42:0:b0:742:aed4:3e1 with SMTP id d2e1a72fcca58-76e229836f3mr149385b3a.2.1755035253357;
        Tue, 12 Aug 2025 14:47:33 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:49::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c2efd89aesm16092930b3a.106.2025.08.12.14.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 14:47:32 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: miklos@szeredi.hu,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 0/2] fuse: inode blocksize fixes for iomap integration 
Date: Tue, 12 Aug 2025 14:46:12 -0700
Message-ID: <20250812214614.2674485-1-joannelkoong@gmail.com>
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

Joanne Koong (2):
  fuse: reflect cached blocksize if blocksize was changed
  fuse: fix fuseblk i_blkbits for iomap partial writes

 fs/fuse/dir.c    |  3 ++-
 fs/fuse/fuse_i.h | 14 ++++++++++++++
 fs/fuse/inode.c  | 15 +++++++++++++++
 3 files changed, 31 insertions(+), 1 deletion(-)

-- 
2.47.3


