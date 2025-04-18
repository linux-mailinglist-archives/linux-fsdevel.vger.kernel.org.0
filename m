Return-Path: <linux-fsdevel+bounces-46701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C10A93F4F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 23:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6268016F5B8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 21:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5210F23C384;
	Fri, 18 Apr 2025 21:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJPpLzwY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529B02868B
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Apr 2025 21:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745010393; cv=none; b=Ja1DNldm1svIiTwPZ+wLetL83+WQjq16BlKp9ok1Nyw1U/+HI74c857RiwTISfvSQdUu66/94DnZ3eDGpeCTdl+aGdARuV/BZP+PNb0K4gXVM3cdy5IZkeI466YuI60JaH1HJOzeEOKjMaktv/6xMic4wolxwf0R74V1KIaILwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745010393; c=relaxed/simple;
	bh=OWuDyVi5J82Q8TbAPmxYxTbJrtn3nJTilZ91Gmbzf1k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c36NmZahe5ZGY4yy4H3Z2/DCt74iJdOVmavGnYAqJbPwlupzP751emn/hFJaGV0YBhuHRVf68hLpz2hFUFeJ/sRzFz050KfjYhAxLnlcXNboW4Tlp2o+9ZgDB6tQUtLcaOJcB22UrouJDWrvZpoY7Mh1aMhIkLJUz7D9EbWlX80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJPpLzwY; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2254e0b4b79so33212335ad.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Apr 2025 14:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745010390; x=1745615190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kfKWa0Frjpv1kfe3/4KaXXf5xWJhnv79WJ6ByiHAm1g=;
        b=UJPpLzwYidAnXmH/Ns5iJoMljaMzv1NMR4KqytlGbb6nnLpN2J3Ot0/HUUUFVqO1Ic
         VQ534t76YmHol32dJ0G6LNQXjtSpG9MTfKkTyKflmerKyX0AZHWnfot8X0YYU9QwXPor
         hJRipOsA6kyu3FizUNVUI1wxWrsSdw+seKyMo1uk0DCpmX0IAR4HW2isrD0xRKPUmFXC
         iGFRCp3GXUztkps0/myrvF0SkIXYGjOIwsYq+AMJESaVdXwNqiKHSFnLIJTizqkc4Wlm
         8i4KUEl4zcHQimYZcJ4RqF9kYyq/NEkxtfozbbdrf73tvUHQ8RI5Op5P1MlBBhLW5ifs
         QyHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745010390; x=1745615190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kfKWa0Frjpv1kfe3/4KaXXf5xWJhnv79WJ6ByiHAm1g=;
        b=hczQNDp3U3i3bRVVpvVSuZkiKqS5JvTKlPY9cvQJyT0wvhO8rZb3AIpE8jjf48F2w6
         SH3CaNnPKFvWSVfMYkJTcdOMsHLEYWQYg+NK5a8eDLQ1Ow4e7ebDwUQ8bx7z6Pm88uhS
         mQDopeONxKz4eBQ+UPMQwG71ZHUrWpdkkT+xDo3uPMoijL0F2SGZw2VHkrOGOYjbSiYs
         jvNERGuMW+YdCsonzHkSBMOSevVngcRdXqhuU7edONEFHz6jxx00m+DRZ4h5fywA7MzB
         bvkIlIAQTZ/NdlEUuUylfPtVTESAwvSvgGgrdyU4ghFpkfOTF841ORjB9SOSActaLhBa
         129g==
X-Gm-Message-State: AOJu0YxdGDPG6+au5FGfrLHAA8SnJMdold7Q4fkBhpNEWMmAVCl1lgOw
	4YiUOTHhzUDYcTsgtEklErje+HEqP3x1OV68NDi2BwafgbVA4bpk
X-Gm-Gg: ASbGncuGQOQ9gZ9GBOff5jtcCZ/vRhAV9KXJtvEjZlH2D7U4YMlZsDqtFyDQPHs6/x4
	QLHcLDdIQgEgDv1MKzu6uHUY8pmlCLRXJdUrz8qUVKBUInm/RGJ+yo1Ly9uTrlg/SYJtE45hkKP
	OIb7Lfl3mGldmQVHJmYSd3s42jBpVG/3nm2g761BiiGFNZDdKCHYwimUNEgSSgZiKRsvXsBXmY9
	wJm5inxxI5v7A3yXL7T9JL8afWSYcgRy+d534dsngDNiQYN1bHJBEe9/SwRUW14tgqbqRoEGY/6
	xGwTWHVJZyOdXk+UJTTakedPC0/DK7R4dx4=
X-Google-Smtp-Source: AGHT+IHs+oMFJF2GEWK7lysTJDL3B4PnToLBfKqJrprWvsSFw/NOTwLDVSCXpglbMwxzKUg2Uu2YYQ==
X-Received: by 2002:a17:903:2f81:b0:223:4b88:780f with SMTP id d9443c01a7336-22c53582679mr68955605ad.17.1745010390346;
        Fri, 18 Apr 2025 14:06:30 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:c::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50fde986sm21229095ad.244.2025.04.18.14.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 14:06:29 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	bernd.schubert@fastmail.fm,
	kernel-team@meta.com
Subject: [PATCH 1/2] fuse: optimize struct fuse_conn fields
Date: Fri, 18 Apr 2025 14:06:16 -0700
Message-ID: <20250418210617.734152-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a bitfield for tracking initialized, blocked, aborted, and io_uring
state of the fuse connection. Track connected state using a bool instead
of an unsigned.

On a 64-bit system, this shaves off 16 bytes from the size of struct
fuse_conn.

No functional changes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/fuse_i.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index b54f4f57789f..6aecada8aadd 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -690,24 +690,24 @@ struct fuse_conn {
 	 * active_background, bg_queue, blocked */
 	spinlock_t bg_lock;
 
-	/** Flag indicating that INIT reply has been received. Allocating
-	 * any fuse request will be suspended until the flag is set */
-	int initialized;
-
-	/** Flag indicating if connection is blocked.  This will be
-	    the case before the INIT reply is received, and if there
-	    are too many outstading backgrounds requests */
-	int blocked;
-
 	/** waitq for blocked connection */
 	wait_queue_head_t blocked_waitq;
 
 	/** Connection established, cleared on umount, connection
 	    abort and device release */
-	unsigned connected;
+	bool connected;
+
+	/** Flag indicating that INIT reply has been received. Allocating
+	 * any fuse request will be suspended until the flag is set */
+	int initialized:1;
+
+	/** Flag indicating if connection is blocked.  This will be
+	    the case before the INIT reply is received, and if there
+	    are too many outstanding backgrounds requests */
+	int blocked:1;
 
 	/** Connection aborted via sysfs */
-	bool aborted;
+	bool aborted:1;
 
 	/** Connection failed (version mismatch).  Cannot race with
 	    setting other bitfields since it is only set once in INIT
@@ -896,7 +896,7 @@ struct fuse_conn {
 	unsigned int no_link:1;
 
 	/* Use io_uring for communication */
-	unsigned int io_uring;
+	unsigned int io_uring:1;
 
 	/** Maximum stack depth for passthrough backing files */
 	int max_stack_depth;
-- 
2.47.1


