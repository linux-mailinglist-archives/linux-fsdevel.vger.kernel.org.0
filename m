Return-Path: <linux-fsdevel+bounces-71027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6143BCB11CC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 09 Dec 2025 22:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFB6E30E1D64
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Dec 2025 21:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711653191D4;
	Tue,  9 Dec 2025 21:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b="JU031yjD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ACD31815D
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Dec 2025 21:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765314578; cv=none; b=UNbBuTEJbDmG2BFiUbeT7bWKIqIeTOFOk3Q0gL4zl5SSJT1Nb43rOZ33VX0YZ9KinuUIjPLX9maXKdMfasWBBiD8cbueSGvpOPNPfJeq3d3rOsyh6L96tTZLG5DKPRE/pwlRIQIxjWyqWsi41pHVld4cpTMV20XZxy5W2QRB5p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765314578; c=relaxed/simple;
	bh=2k0PC6ht6M6NEOEFT/PgcJz9mrmgPJtjnaFtGClyTHM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tEIKkGn8Y/Ae2gcIRn1ZMm1Dg+vEPR8HKgYVSUEkL0xtc8EQ9k3kHwB3WJi+YOQb0MhW/jhXaW/xI9/g/lXT7DVQ1bYp80aUwAfi9FTtL+ae0WoQMxtqu3rAw+I2XZoULfstJP7DKTuIEHPj69iyIRmH3OoeDXIse7gSVtRk2pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net; spf=pass smtp.mailfrom=opensrcsec.com; dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b=JU031yjD; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensrcsec.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so69123685e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Dec 2025 13:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1765314575; x=1765919375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NtsQDaRhPI3iWLZbIBK7GGrlOKhFHrt2R62TxY8kPXA=;
        b=JU031yjDtbqjYmXuxc5HbG9mF8JDMdPVDQeZ90Bqi+09+PVRmlvdOonklMjp6sEhad
         41Cu95ZLaNqfCgp5UiWAheFDB+NIsrjNs8whKaI/+2Bnc3InEYn6ezrDmwhziB0ulijo
         Pb+thyAwfrUmrlrtfcYnC2uKZGEoWy0L0ZAUBeKaTAF7WIY87OVUJLXX9xiOfp1J1veA
         gXa+MDY0MoWqj8pBNgStY3nnSDCEQA+Q1aGWoPOG+EJgQRCpPbYcphoxePXmIYBWOmgO
         BOiW5qX2DMdJYbEyHA+RssvGFd09l0DhrEpv3/9isW9fz92n6MJlptCLNit2/p6YI1ou
         +Dng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765314575; x=1765919375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NtsQDaRhPI3iWLZbIBK7GGrlOKhFHrt2R62TxY8kPXA=;
        b=jGUewpgXBAYNHbhFI5mj5JoMhjnoIQyxjIqZNxwgNwwi+me5Q1pog8ov+jnltcL1DV
         t3d/7JQI1Q6wPe+cSk+76uOqjxPbjY8dr7+OltMZVnovGT6gqWtMBmh2sneMBsuYL3K7
         aQQZ5ELWza9/GuShHWuivWVYjCAlSOlNqp/dN7LEUOvctEsJD8X5u6xfjM+K0w7LFumA
         m4lJB8b5IXvclle43Bz1Ar1i1Ji1+r48Mom1keiOkf9jdFhtTpFv6U1aZUn7h3HUSFcQ
         uQj70et8mYwvM8ipU/cQjLm+Ct14RqTbEDn5VE+F85itgkHUyZuGx2MDW1cldU7YUsb8
         nPoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkmsbOynZO//Sq/qRwu957x6LKDiDBntCtKsbcdvUs5d3HyKHC+jVJ+96Zrk2fQ2fK0zGkxUmHw5hrRTZb@vger.kernel.org
X-Gm-Message-State: AOJu0YzMqcO5W1dr9BQjBbMs+GbnrpK6peo2qFsTJJXKZEhjHUMHXUlB
	x5s1dOtovyjzlxrvgwpboVcSFt48z2CQPKSFYullajGjMbJraQozymjNM+jpexY+w0s=
X-Gm-Gg: ASbGncuk6+kCsSl50OnRSp6Z5DWjPSxZ65h63NKKnzSLvB1RgyWXGDggVriVmI9jS+n
	b6AzpULPuQGw2HvzX3/tjr6D+9ySZE0nZkH4Vf3EGO6a0xY3n6zrw+fJQIjN2bNODru5/0TNoHG
	xXjdzoYcUnMSr6ghhcBEO9LC97uEZi3DwnTbGHCLLfNOj/h6f3123h/RGUKX98LsrpOhMp5Y/mj
	gaWvuRPp3wYu5vKr+yTmwsLeu1UPp/VUUpdHgMtkoPASfnfm3vIQz2GVaMkbbS+EwdFHvQzwJhC
	mZLq6O5J9p30wg7IoOnomjlOoHcp76/8K+79IeaG/UkGXANhD303n4XlO3u2/RIZOOlZ/V4aMiW
	2LZbOlQk+aEgsitR20HCfy/sNtJQwSeb6JOTUCd2AQ2fY9W0Sw1hz26cgjp4m4+YAeBUr6XjrIm
	axuEGZjcYqooEr86PyDhTMv/pl8ArkWFefeigDKaP63DPNx2K6Kd5d6kmdMiY6o4c7mEGztvYqb
	rdJTAY=
X-Google-Smtp-Source: AGHT+IES3w0dcuVSm0JMkRvuCMXWp1JC484g7fQlkWdPEF/a4S7wXCybAkGBmrOuHEVsvSoC2JcobA==
X-Received: by 2002:a05:600c:c165:b0:477:214f:bd95 with SMTP id 5b1f17b1804b1-47a838436bdmr1345995e9.23.1765314574917;
        Tue, 09 Dec 2025 13:09:34 -0800 (PST)
Received: from bell.fritz.box (p200300faaf29b100e8b27dbf0b1165fc.dip0.t-ipconnect.de. [2003:fa:af29:b100:e8b2:7dbf:b11:65fc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a7d9243b2sm27982455e9.1.2025.12.09.13.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 13:09:34 -0800 (PST)
From: Mathias Krause <minipli@grsecurity.net>
To: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-media@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mathias Krause <minipli@grsecurity.net>
Subject: [PATCH] media: mc: fix potential use-after-free in media_request_alloc()
Date: Tue,  9 Dec 2025 22:09:03 +0100
Message-ID: <20251209210903.603958-1-minipli@grsecurity.net>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 6f504cbf108a ("media: convert media_request_alloc() to
FD_PREPARE()") moved the call to fd_install() (now hidden in
fd_publish()) before the snprintf(), making the later write to
potentially already freed memory, as userland is free to call
close() concurrently right after the call to fd_install() which
may end up in the request_fops.release() handler freeing 'req'.

Fixes: 6f504cbf108a ("media: convert media_request_alloc() to FD_PREPARE()")
Signed-off-by: Mathias Krause <minipli@grsecurity.net>
---
 drivers/media/mc/mc-request.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/mc/mc-request.c b/drivers/media/mc/mc-request.c
index 2ac9ac0a740b..3cca9a0c7c97 100644
--- a/drivers/media/mc/mc-request.c
+++ b/drivers/media/mc/mc-request.c
@@ -315,12 +315,12 @@ int media_request_alloc(struct media_device *mdev, int *alloc_fd)
 
 	fd_prepare_file(fdf)->private_data = req;
 
-	*alloc_fd = fd_publish(fdf);
-
 	snprintf(req->debug_str, sizeof(req->debug_str), "%u:%d",
-		 atomic_inc_return(&mdev->request_id), *alloc_fd);
+		 atomic_inc_return(&mdev->request_id), fd_prepare_fd(fdf));
 	dev_dbg(mdev->dev, "request: allocated %s\n", req->debug_str);
 
+	*alloc_fd = fd_publish(fdf);
+
 	return 0;
 
 err_free_req:
-- 
2.47.3


