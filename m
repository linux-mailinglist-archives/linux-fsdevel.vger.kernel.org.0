Return-Path: <linux-fsdevel+bounces-68980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EA6C6A7D4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 17:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 882684E5353
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 16:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863A936998B;
	Tue, 18 Nov 2025 16:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCqWoxjf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6310021CC79
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 16:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763481654; cv=none; b=JNK4Fa1Qz9YLKOoVY0tOYGPiVeQY7xK3EkrvENLANB/v5p9AxNFD/0h+gASfgdFqkNJy3HLdFUgcQQ7qArf5GZvKzgisDNJQM+/FHuWjaGBrPVc46RdUSdAEDQSiR9fLrCDp1Dkb8Klh1zcG+0c906SSnA46MD0uzRxpOmgUkv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763481654; c=relaxed/simple;
	bh=BHJUjte1MfC7NI4WdvA1MRWGhbAGB7PmPbqG9svj//A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tscc9mL0ZppnWlu52PuB5pHoDP3gR3vdSSv2Z0tBw3P3zeDMPsILEgaynIbcI5MK/0bTuN99kK5Lp8uvtMr6/iCVKX+5klWzVPvYNImcx+zOoRt7dn8rkEprEJ85nZ5m36PzJpoP58ylxl6hNf9EBf9o9tE3iLQXRhntlh+3PzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCqWoxjf; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42b2de74838so534487f8f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 08:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763481651; x=1764086451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gnJ9oIt/pmmo5XkAfTbYYVvpzn+MWMnu22dVk/W70nw=;
        b=dCqWoxjfVAeHcOSfgUY1wl+wueu/YmZOqGJIAz1/TLoZIGz+pT/LsjMdCRNlqMsIB+
         y0z+VNk/Om86BTHj2o9rsiTnIWtrBP7SshGT3BtyZ0jBPimPvxqOM7cI5ayoOGcdezvK
         518tGrjT/X5ytPA9b5OmPNLpZA2+Bkb4VO9gT/Tn3+1dLyVuRHfJ9FxcuOXveBFycBf2
         bldFC/2cFPZSgQMfH8O6lQoeQA9KtAVuRFSy7I7/vmAWtTrl2CvGDJI5U0NkEhFHYiAu
         C3TKjpTBT1NDG/0+EUtNbnAh41gPKR6S+UvDU7rIcf+Emop7/bOFAsRtM8XVZz8FPRZB
         ewlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763481651; x=1764086451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gnJ9oIt/pmmo5XkAfTbYYVvpzn+MWMnu22dVk/W70nw=;
        b=OWEYX/WGOZZjkMCbdFKqfXsQyhYarsHZBvRK7JvSH+ZtrHr3hhZglUX94LiOWWKiAK
         g1oJlJsM1nPNoYg143yzv978VzwO2EmMHpnExHVAv10IsuQ2LtoWqD0m7q8kQeTlxRoW
         J6B+7I95cNRsW9ht/BqdLrN7ReQXjk/eDArNOpXOaWlXbUKl6j82u2qcEq9Jr17YCtXx
         ElLcTd9y9rR1BQqQDSbhuJbSSVlRAFLMuahieauTyTgVh3/oE+jJkGYEj/H8/WCs4Gfe
         wGUYMgkKwRFkK66Dk3JbUXdSEO3zfwlhkWE4v8WsVdoUi5Ie8xwgIgMOZr8sa1AcT6kd
         +poA==
X-Forwarded-Encrypted: i=1; AJvYcCX1sapX+fF5OJNROjmwLI8aohTwjgqbK925EG4h9waaEgc2RO4xGKv2wPPvtaD3yi11K/ZTfqYrmvitiJb4@vger.kernel.org
X-Gm-Message-State: AOJu0YwfOk+gBh3nql4Rf+xu1txHz9A1FkbYFulRDgLH7eelw4Cpo5Ws
	8kT1mjdlwkYEknmienUngJv3MNcEze83uFt+sV/exG8hai+XoMChWQ9z
X-Gm-Gg: ASbGncs/J7Bu7Q8p3kc3qkthqa8GGFFiRRjoPEhLPzM4cFQ7S+Yux/CuEiVPw5GPVw3
	+gl7hHqB7ACm2r4fo7cTe8Yp2BJ8xBklVRpwhEHaVQu05pYwATh9dY9/pWSznKEOQh52w1OLnc7
	P7/P02kegcN1DkYSuR9MY8T8+KETpHL6Xpz8KINWS1Ez/MokVlBrsnZcwNIJ+OqwtgI5zCGjTCZ
	JG16V44nSE8cDAa2UAUPtGPxUi72Qc2UgXTK4Z2B4csqRBy5JEM3dopQi+DmUqztX8Eq/iNEE05
	sAA30ItgCn2NKDwHR7krUrcuhcQoL8IsvYO5+d2eAOHSqhPFnFVjVFphSlGLbt8HyD69rcg6bA6
	D2GBk1LXPbhxlcgQR/RK2cUfhFzY9GvNSrk49zwmm3FVuh+jWjq6na9rtzC1NsDUVZ6BZoJdefl
	hCamTRijEF
X-Google-Smtp-Source: AGHT+IGZeR4oD1RWNRi9d5+KoKWzONNtFHElOEcj+rfeRQEk4VQrpEoxJ3JcY5G84vDxN9Nvbhsbqg==
X-Received: by 2002:a05:6000:61e:b0:429:c711:22b5 with SMTP id ffacd0b85a97d-42ca9e1c939mr1706690f8f.1.1763481649884;
        Tue, 18 Nov 2025 08:00:49 -0800 (PST)
Received: from bhk.lan ([165.50.73.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b5ce849ddsm26363051f8f.14.2025.11.18.08.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 08:00:49 -0800 (PST)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com
Cc: frank.li@vivo.com,
	glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	slava@dubeyko.com,
	syzkaller-bugs@googlegroups.com,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: 
Date: Tue, 18 Nov 2025 18:00:19 +0100
Message-ID: <20251118170023.111985-1-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <69155e34.050a0220.3565dc.0019.GAE@google.com>
References: <69155e34.050a0220.3565dc.0019.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
---
 fs/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/super.c b/fs/super.c
index 5bab94fb7e03..3f48e5cd733f 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1723,6 +1723,8 @@ void kill_block_super(struct super_block *sb)
 	if (bdev) {
 		sync_blockdev(bdev);
 		bdev_fput(sb->s_bdev_file);
+	}else{
+		kfree(sb->s_fs_info);	
 	}
 }
 
-- 
2.52.0


