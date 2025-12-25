Return-Path: <linux-fsdevel+bounces-72092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A987CDDB4C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Dec 2025 12:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 43C3F3002486
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Dec 2025 11:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A6831A7E6;
	Thu, 25 Dec 2025 11:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="WwbGaJUw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316DB281503
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Dec 2025 11:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766661160; cv=none; b=JfstK0haY5ecKR8MobhZIh604JEk96XiEwyCkUX/AY2FeT52Zwv4ZVf9cj5VoxAMTv5BkSiYsqHXEiMN3lgtIUnqIOEgYpiNlO2tcn5XCRoxBKsc2Qz/eaDA2xmPMFQODxsZz/SZukW+kW4J4TNLlOiTvosoRrHIQWMtPjuDA3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766661160; c=relaxed/simple;
	bh=fWih+GeN/btVtE3zzGc5QXGmWWS+93NnFRq28TrHLkc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jgdYOBH8rCbz0/TNYQdzBuqR6lziGbyLwmOw4N/f0iMZcf30+W63Abnd0hq9FT2KmKQV4VX+p0tSYBFegg7k/BIUqjrf89w8AWw+iE7DKLTJv38Y633np+erqu2XOoOWxnknZ0ZesejFFZnX02wCBAEKxhn52J4+6XWY9rdow5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=WwbGaJUw; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a0a95200e8so59677685ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Dec 2025 03:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1766661158; x=1767265958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c8rC0NjEHEkMrOlMvUbyxEpQ8JhLWqfqRz2pCbhpo6A=;
        b=WwbGaJUwVZsOygU+AxrUALYdHyi3MXtmT2HFOZ2j1kPBab3QeMuD6Sror4sB/ARDV9
         3Wz5m1RQ6ACK79wEx4RdTsZTZ73DcPccWKOOSRtEa0VEzWSPbDT7YJdw5OlIhlUz51wD
         rkNzuXmxGo2Ry2BLay/wIymxZqomIp0b47yEhk2eAiJmAv3pdAJOLH3IaKLzP8HaN8dr
         edYKxAQIZ7QLsMH6eM0sVD1f5/JuAPhmJGLKEwQy7rpHQklXeRYgdmX0/VslS1E67D+K
         eiuN4wWaMHdAp2dj5FKzsoVcan9E71nFNIGGyvYF8HpfaN8TV37nBqJGNvism/X+Hfon
         AGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766661158; x=1767265958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8rC0NjEHEkMrOlMvUbyxEpQ8JhLWqfqRz2pCbhpo6A=;
        b=PLAwjZ0viAn0g49uVl9chaJRiwNia4D3OupofCpXcEkz0Jp0okvC9VGGGLQoPoaXB2
         3Ei1lC4CAXjTFeZKgL+Z/v2lhShHxcMUvKQGOJhWjrAw247pJruOlO5vInOgGWgGSBrb
         Ym7O6LNsZT1o0JSgLaNmxFdylD9IWU1VOxx39n31XZE3wnQyGhGrzuBgi2WIBXf84zvh
         mNjwkQMUiyphtNwVPWJ32W9sapUa2tz5YVsZ5IHH9viiIRW3ZLk4MatYlLXytP4PSE8b
         VDTUWippVLpOqN95LOfEPrCHX9g9VdO+E7ylS2PeRHBok2zF6sKGBtRbGmwn1PAF5dNM
         M71Q==
X-Gm-Message-State: AOJu0YzsEK8aVCPJZPgLjHp+hLcdltHpEumIsSlg7CxMD048EbB+bOiw
	6Juggn+bK1GsfFQa6wcAOlfhk0c5QynqdG/QKpZ3sRtkwErdFmZ7uT2v/Y40TvtZIkQ=
X-Gm-Gg: AY/fxX6rCax7eWIlP9UhTtKwe3VTKhIe/RURJRb6pavrIsCrmyXmq7cwmpyorGCpqqj
	At8NuxSWa+IM2XDQneiCZ3+8MyZq+TUwK6gln9DteCVtdSaU6xqCGENZkVSXCUIR9J9FcNVHEQB
	VvpLsb1BjOzdnnHOdq9QUVe6YJ3o6WyMjZh7FBf8Pm9dzolqdGLliHYXpyb6UMVCrCJSC+1wVHS
	Xy40V2kouyDEwNHYDml+YjHQU+e1Iz7vy5iXrQbHw8GvFYCcelXsGumd14qW3asVYeuHL3HpPCE
	IadSn2cHJgYqr0XE3j7EavCMRAy/1FbqIz5bMjgYLNOz9KKGyH6rXT1wZUECpnMJ4cgJtKUZ/GZ
	i92za63YTjM8vrqb9J1pzUK+1+Quz/+cEJQos4zBaqVJtab8f7dbwsDnCaxFQHOqzpdArx6IjZy
	NTGUCXmpC/d6ty17OXacPekcvaVUbJCpuPWAP/VmAbUo2Wy3OhaQ==
X-Google-Smtp-Source: AGHT+IHEinazSAxloNFVF8ro+tQ1ra75Fqr+Ad6+Eap54YpbI8TnTg60lqIFc5WBC0cxES0ohWy8hQ==
X-Received: by 2002:a17:903:298b:b0:2a1:5f23:7ddf with SMTP id d9443c01a7336-2a2f2202fb9mr216999835ad.6.1766661158409;
        Thu, 25 Dec 2025 03:12:38 -0800 (PST)
Received: from tianci-mac.bytedance.net ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d4d36esm180734295ad.63.2025.12.25.03.12.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 25 Dec 2025 03:12:38 -0800 (PST)
From: Zhang Tianci <zhangtianci.1997@bytedance.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xieyongji@bytedance.com,
	Zhang Tianci <zhangtianci.1997@bytedance.com>,
	Li Yichao <liyichao.1@bytedance.com>
Subject: [PATCH] fuse: set ff->flock only on success
Date: Thu, 25 Dec 2025 19:11:56 +0800
Message-ID: <20251225111156.47987-1-zhangtianci.1997@bytedance.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If FUSE_SETLK fails (e.g., due to EWOULDBLOCK), we shall not set
FUSE_RELEASE_FLOCK_UNLOCK in fuse_file_release().

Reported-by: Li Yichao <liyichao.1@bytedance.com>
Signed-off-by: Zhang Tianci <zhangtianci.1997@bytedance.com>
---
 fs/fuse/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 01bc894e9c2ba..d83ef81e3b9b3 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2563,8 +2563,9 @@ static int fuse_file_flock(struct file *file, int cmd, struct file_lock *fl)
 		struct fuse_file *ff = file->private_data;
 
 		/* emulate flock with POSIX locks */
-		ff->flock = true;
 		err = fuse_setlk(file, fl, 1);
+		if (!err)
+			ff->flock = true;
 	}
 
 	return err;
-- 
2.39.5


