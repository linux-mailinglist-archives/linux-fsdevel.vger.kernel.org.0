Return-Path: <linux-fsdevel+bounces-68415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5248EC5AFEC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 03:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5B963BBED5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 02:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E52227B83;
	Fri, 14 Nov 2025 02:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntOfl7jF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E561DE2C9
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 02:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763086740; cv=none; b=Qe6IHwiGR+656o8bbETv6YIcr6J97oJ1FcggamN3dWiHK+HshZHoYkeucQawjafayEivrGAO9p8DQJSchS3w7sGr7YUSAgWM/Zz5q59ikeP/u2USAT7QN2SNmRyUSjJIyrMTEKdL+w0MzOmarHWdWMR/Eq5+aVdA0auClF+4pCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763086740; c=relaxed/simple;
	bh=aaTapZJg1cOY1ZdzXs9dT3OyjM5tPnQly3Nc2KVVOZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dpgkBiVCXy4sXuG1B7yOfmRo4QhSW6vH8DBFzx9eErcF9feMRJJdkDprAoN49/g68kC2k3yWRgaLtctitKWHJlsAzgSZJCKch1dgbkdP8+Rl3+6kqhLmgYbGNDtEfJkimIkqvxpsqRqrBqNUHNJFyggWSJ7A8Ysl03sl741W7xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ntOfl7jF; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47776c366ccso1114075e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 18:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763086737; x=1763691537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NwrwxTxUzQb9AjfV/y8UNbl/r1epHm5OOQqMSRPRK6c=;
        b=ntOfl7jFMFWMRWsdFeWXSaCFK/iI+YaMiT1ZxbZRtxAInbhev6y1dCok5rDg0nxKen
         UeQudeMROorZi4C536eke+W9fxxFXIj9YvmOYsf8S6KIfCyY2zEK00+A6dmFAOpYjWxp
         coIF+zoIXHLQhch3P+0FyBMOXsWDJgXqThrst6hAx/5fQ6M8+nk651fDtM8HOP11Iony
         WXt61VO5yrM1LrVKANkLfccaVOUqc6STFnWVVb51ZVEjZz6HrGH22RaDRaQYcIN/2fdB
         gp5DyuMVfI1QwnkNr23NveM8AZyo5Dfk507xySh7tXhNRQGTAE18NQAO9DTgA9rn/h3J
         5YJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763086737; x=1763691537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NwrwxTxUzQb9AjfV/y8UNbl/r1epHm5OOQqMSRPRK6c=;
        b=YgPnZGnECZr2GecrzQxOKJKJwYlB5NVtArrr6LA54DgiPrp61XEza5IgBEHgGb4VDG
         Pn8BXDuwqHYNyk6Bv9brSq6t0yKn6oFhY9P4BhLjjQXrL4mnYfQ6DgFCIDVcGtYZ4g/F
         afPEnq7dPLbcVD3nT/Rq8fmIDQMb3PE0c0wMNDZPx+/7uYIrzXxT4HB9oeZzxbmhur/7
         Nxle6Mw4gRQ6liIvW/eQqymkJQ00rN/+aAPP6gGQ/sFGoT5zamkqvFzqrnA7KjBlAIuV
         SlU3gtOdUEh48T1ZaP7YflXn4JcDNJc5ybuUwG+8buoxv+zCKvowcvm3OB0NviN85WNG
         +N3g==
X-Forwarded-Encrypted: i=1; AJvYcCUDphXez770olSm1b10ijyeeompHCX7Oewq3B0zG/823xa+fJmGSGgw9ftWiO2XDqaUHYxzQdAQYto2A0nh@vger.kernel.org
X-Gm-Message-State: AOJu0YxCTy58KCu2em4wfe7lWlQokQXhlFPd2Zr2TI8/otDf4OjDh3PA
	L8o6MiN3S4mBH2ou1fjgiiFoXXI9IOdRsd5SMZyXvW14ebD2iBte/dVM
X-Gm-Gg: ASbGncvLdZqCOzDLkUDL+PSxlgSFple7z19DjNgND+rJocWP7pzERIcqR9Dt5Gy95u0
	A/fn+wNFt551y4dOomV8/ZzDTk7ta0AClGCsmg0WKSv9lnLAfIoN3S4YkLIaZiUMv9CSiZylJel
	jaOFnpDoTj88CIoWrGobomy2fZvSlqlbaexh66/iKtBW7tzr4tPpGd5+rNwCsb9j+8dxe2DG9QE
	Iwga/VdiXCjSHKhW9Jiw1uVQUlfng8rtbcsdQRiT1trdP5CBLZesXIpbYPF92FehNecvn2hB0b1
	MFSW3S/P1oUchAX+ocvKVErn/iSPjTEsCs1bKSsp+rZXHsd4J1v0BujPsg4W7cJyrwLgcnADeIf
	GNbtuS9fSHd1H1WkeLWor9PhCsucNcnczNO2VWnM/nKL3Jfjf1NrCUM21xFAXgkq5mk1ghYNkZf
	ptLhIK/Q==
X-Google-Smtp-Source: AGHT+IEvOJ8xQT/X2J8vy+zOs8QKQwoLcQhZrUs269sPUMtjZwT5Ka9GCmivx1Ax8RGuYGjHfFeVHQ==
X-Received: by 2002:a05:6000:438a:b0:429:b4ce:c692 with SMTP id ffacd0b85a97d-42b5a9879a5mr416331f8f.7.1763086736824;
        Thu, 13 Nov 2025 18:18:56 -0800 (PST)
Received: from bhk ([196.239.132.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f0b513sm7021699f8f.30.2025.11.13.18.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 18:18:56 -0800 (PST)
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
Date: Fri, 14 Nov 2025 04:18:28 +0100
Message-ID: <20251114031838.3582-1-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.51.2
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

diff --git a/fs/super.c b/fs/super.c
index 5bab94fb7e03..b1a78189b2c5 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1690,6 +1690,7 @@ int get_tree_bdev_flags(struct fs_context *fc,
 		if (!error)
 			error = fill_super(s, fc);
 		if (error) {
+			fc->s_fs_info = s->s_fs_info;
 			deactivate_locked_super(s);
 			return error;
 		}
-- 
2.51.2


