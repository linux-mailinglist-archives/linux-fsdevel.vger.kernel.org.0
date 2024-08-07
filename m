Return-Path: <linux-fsdevel+bounces-25231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF14494A150
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 09:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58F791F271BC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 07:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1B61C4605;
	Wed,  7 Aug 2024 07:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBI9o0YM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B212D1C2330;
	Wed,  7 Aug 2024 07:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723014348; cv=none; b=SwO6+LIqXmt7Q4J5y2A4xkrNFlHTVsVpt2WviqA0HwnFWh1nBAnJn80OU+zBOnFhjJvW9cixsB1b442+IvP9AqfDsfisnobgdsh0sbJ3oPtXsjRDxRJ+GFkxtE6OUoPeVhCZagDO2SJ/HjcsA7hXYG5Ls9TiRbCiNsvWxfzHPF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723014348; c=relaxed/simple;
	bh=uPYGf6jSgkZQ46n1jyJkeGgS8nxj28UBFXb1XA3o2oA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ncIe+cFUeTPM/pTiErbez1GbiV34B0pp5Ucy56cHDbzNUhQPQk28XQoqgcJrpy4hpLmAyGRTJBu6ncCSk3sU9HzskxWJphFu4guiX2RSZgB2X8/GtNopgjPTLGTXnc6Ra+2JiuknnV/E9ngMqCDZFGVii7zinQN0jzdR2F9txEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBI9o0YM; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7a92098ec97so1231271a12.2;
        Wed, 07 Aug 2024 00:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723014345; x=1723619145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qUM7HGjsdnxud42kIvriQziI7ePv5pZPFlwBrJcwdGg=;
        b=EBI9o0YMzGFMaIEp6K1gK1+mYkU1/+LbF11GNfX8KfvLM0BYGWLhpCjXczb+Wex6yo
         KIP9i6yCK5SQdG++F3o75dXbtj9rOC7CTx/cSp/d/F9fjkP/mcvgHjh/PEbaB11MtNGF
         LSXcpCKgcascbQEGvM3/lGsbWqTaQeXKZXLL+dKP7tLd9U6TEUqUWJhihrQ7tj2ven/O
         /+2I9Y3BnpA86GTrOILPKM9bAKUeQ7b2KoSNHSG58PJaRsuDAPMvhUNDHyuQX8JO70ND
         Oz3YA0Cati3R/flM0uHWOLVYD8hBmxGG/SDYoYRPWcZFW9MTZDmQknHu1qaL9RoKy3HG
         5OVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723014345; x=1723619145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qUM7HGjsdnxud42kIvriQziI7ePv5pZPFlwBrJcwdGg=;
        b=iYDaCqUYQhXPirkNU9MnhEx/lF3vNOPfXfdnrIILBkYQZrg1RkOIYAESEhjo1CfG43
         RS1ttdaG5dJG9glAsoCxX15PRZfFjcVBianILFlJhCfprb0N38yGeQpU/12fQvV8Y5R7
         HsEGB9dRbxRQMYKdQVU7e3g63YgUdNjtZYd5k8CBr7Cfdvl2/v1wjHt6oX4wlMUAUbzv
         8a6HBXxhcPfE+SIVxxPIFDVIDJ83eSOO/TRUWGhhdNq42eKCybwFHKcci2hz2UZVDEMm
         GT/EO/zsj6/Rk/6zdeeCDL3pCWz6k9drqlgkpNqtHk4Ez2avRdDpDAY6zhUpqnftWn0k
         emhg==
X-Forwarded-Encrypted: i=1; AJvYcCUDgbEU/wFF8cf4ZS01TvJiVqDdXyTsE3y+9/u6mPx6jksiCEqI+9mIh3m0OFNcgLERdGXTgQ3n93Dq0Ux33LGIIkZaMxLVnOnzRna3ZXAmghEnuxgHHmP6cQl2go+1J+79G+VH9EKdzb6nHbJXAY/4T20fhDIAj4SKS1TQa5E4yUSGQbGbSlQ1BZgqXlSsDumGo/ScvtkcEWS2HNxev58cHg==
X-Gm-Message-State: AOJu0YxMhBniBGOa07i6KHRl+UgVNORWJ3H+4nwG761tJy4VGHM2/D9F
	To1y+/uqdKpZ1PoiOrcrUgK9T8SosiaoKxxgBKgGWiqXLfiJKYcq
X-Google-Smtp-Source: AGHT+IGN6T/3RL8PYal4XJ7ceDqWl3YtvCvMiTOV5qexUqq/6gQupmS/QIoPcN8yr7hcNx1oVC9y+A==
X-Received: by 2002:a17:90a:be17:b0:2c9:6aa9:1d76 with SMTP id 98e67ed59e1d1-2cff9419d3cmr17451049a91.18.1723014345097;
        Wed, 07 Aug 2024 00:05:45 -0700 (PDT)
Received: from xiaxiShen-ThinkPad.. ([50.175.126.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1b36f6cd9sm510842a91.1.2024.08.07.00.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 00:05:44 -0700 (PDT)
From: Xiaxi Shen <shenxiaxi26@gmail.com>
To: brauner@kernel.org,
	djwong@kernel.org,
	corbet@lwn.net
Cc: skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	shenxiaxi26@gmail.com,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Fix spelling and gramatical errors
Date: Wed,  7 Aug 2024 00:05:36 -0700
Message-Id: <20240807070536.14536-1-shenxiaxi26@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed 3 typos in design.rst

Signed-off-by: Xiaxi Shen <shenxiaxi26@gmail.com>
---
 Documentation/filesystems/iomap/design.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/iomap/design.rst b/Documentation/filesystems/iomap/design.rst
index f8ee3427bc1a..37594e1c5914 100644
--- a/Documentation/filesystems/iomap/design.rst
+++ b/Documentation/filesystems/iomap/design.rst
@@ -142,9 +142,9 @@ Definitions
  * **pure overwrite**: A write operation that does not require any
    metadata or zeroing operations to perform during either submission
    or completion.
-   This implies that the fileystem must have already allocated space
+   This implies that the filesystem must have already allocated space
    on disk as ``IOMAP_MAPPED`` and the filesystem must not place any
-   constaints on IO alignment or size.
+   constraints on IO alignment or size.
    The only constraints on I/O alignment are device level (minimum I/O
    size and alignment, typically sector size).
 
@@ -394,7 +394,7 @@ iomap is concerned:
 
  * The **upper** level primitive is provided by the filesystem to
    coordinate access to different iomap operations.
-   The exact primitive is specifc to the filesystem and operation,
+   The exact primitive is specific to the filesystem and operation,
    but is often a VFS inode, pagecache invalidation, or folio lock.
    For example, a filesystem might take ``i_rwsem`` before calling
    ``iomap_file_buffered_write`` and ``iomap_file_unshare`` to prevent
-- 
2.34.1


