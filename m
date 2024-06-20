Return-Path: <linux-fsdevel+bounces-21953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5739103A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 14:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 458D21C2151B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 12:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E781AAE02;
	Thu, 20 Jun 2024 12:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRobeOtx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD318175E;
	Thu, 20 Jun 2024 12:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718885051; cv=none; b=lzAmetBQ/dYbuzG2dCJnCOdFJmlfluSDFZ9GgtFLza5gNbc9C0vwRjJyXl/hHhMtvVT4kHFzqK7EWnoDB/Y/8Dx4s4xh9+NjzRW6TOirlC9/5Y9CFItgEGCeEQ4jHH5OLkIAMN+Q/IpUkgI6+gN2YDyXUaBNDdb40L4Kj6nT34U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718885051; c=relaxed/simple;
	bh=jw9jn4dsIGLF70lLXk4kCoM1lWPV9Zpcd6bZKLpofrc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZF2VgWTsR6FBX3zey/CZMW1Pr+AoTGdE4aaxxTAs7bppkkdI0wVX6gCeQtr6dPcWMLEdiQTb1BBds+QeM33HtTpfsNKocytguT7J7QGK+X/iVSQfzUaifzUB2Gz2e731eI8lcisCs+GPCHq3GvWv/zf72Ha/VDnrGIOxsVSmTws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRobeOtx; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a6efacd25ecso42599266b.1;
        Thu, 20 Jun 2024 05:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718885048; x=1719489848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/AaUc3ZkhsIxWpW3uI+GcMRAhaupihujWoCiEujg0ys=;
        b=SRobeOtxEUNwmHHRglxJag5r+wCE1L+fqtRlg21dOznmEFsEducRmj7ug8xHe0P3vN
         DVL0b29BSErp6qwMByKVhIasTAFKuHzhRdvhOUNe4Xyk+gEp7cfDoHMVxgtlOASIp4ss
         l6UMyFlL77WDk/LwUwzpPH/FA2GMSRZqdUS/i38Y07IEKTbkyoUJpd7hUSFHxYkOR78m
         iqvdZuHOTkSIoQes3Z0vEEeJEXEa+UUe9dLyZ8oKHW4zgRFroM12YAv0f7Oxeqxi7hrh
         SvMjXR7Mw9N0JW8ZOkTS9S8/QYd6Zur+gVlOK4qwVcHLH0c9HM2amrG5zP3Hni/aHSPO
         QyvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718885048; x=1719489848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/AaUc3ZkhsIxWpW3uI+GcMRAhaupihujWoCiEujg0ys=;
        b=O4sTg5fmDfjh9O1ecvNAtlyktPujJxOssO/Hv1fS3YIeE1JBvQ/PbvpD3IpdldlghE
         KzBaaXgB2Uh2IN4maBMtNxTuGLtnJXmiHKmOtPAz/GQg5fFWmspjprwtGOJ8mUHh6SZu
         oQqON4bOCxjyttwGUojb9dNq61sNdXWD+g0Urz2hIYKAWTdsOAyJovW+5s2Bx+sircwZ
         R1Dt+fFWmQS2byMVDLztiuQDs2MsnVMwyIbWv0heHvN2FqQE+FHZcJsBCUwOfT4p42+b
         rf97rxTVMefa1fmYAYtKuYv1iUCEY1p5MvQW+5mYA8cmqGMcdT3wpqdnvHNr7WNbg9eW
         djrA==
X-Forwarded-Encrypted: i=1; AJvYcCVRFak3Q1Gw9hYR1CD9BkJDi2v8RLq0Wy2Qr1tHuyA1l4apjLcnz2//RxXfOY6EVRBANY9fTG+zIdc/+7JUOabbJyEhBtOKGeVBmy9LQDTyvBWW/Dz1oLhzQMKT3JnSpJ1Em6eZJjk9gxb3Uw==
X-Gm-Message-State: AOJu0YwaL8R96SEnABf0TjzImmwbfpzUqDx2HlGEahcCL55p0TtXu4WM
	gNxU3pX/nlvNAosN36M2S1ylcW2EmBgQMz64PbcjyhBjYslR7KYP
X-Google-Smtp-Source: AGHT+IFjrLuRYiY96Fj5RfuW1qRweYOeuU8hS/E7k/WB3LJHzg63yG9kRBFVsuL+fxsUXIBU0EpGzA==
X-Received: by 2002:a50:9f2b:0:b0:57c:a7dc:b0dc with SMTP id 4fb4d7f45d1cf-57d07e0d41cmr3736382a12.4.1718885047803;
        Thu, 20 Jun 2024 05:04:07 -0700 (PDT)
Received: from f.. (cst-prg-30-39.cust.vodafone.cz. [46.135.30.39])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d2376ccb3sm667397a12.74.2024.06.20.05.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 05:04:07 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] vfs: reorder checks in may_create_in_sticky
Date: Thu, 20 Jun 2024 14:03:59 +0200
Message-ID: <20240620120359.151258-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The routine is called for all directories on file creation and weirdly
postpones the check if the dir is sticky to begin with. Instead it first
checks fifos and regular files (in that order), while avoidably pulling
globals.

No functional changes.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/namei.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 63d1fb06da6b..b1600060ecfb 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1246,9 +1246,9 @@ static int may_create_in_sticky(struct mnt_idmap *idmap,
 	umode_t dir_mode = nd->dir_mode;
 	vfsuid_t dir_vfsuid = nd->dir_vfsuid;
 
-	if ((!sysctl_protected_fifos && S_ISFIFO(inode->i_mode)) ||
-	    (!sysctl_protected_regular && S_ISREG(inode->i_mode)) ||
-	    likely(!(dir_mode & S_ISVTX)) ||
+	if (likely(!(dir_mode & S_ISVTX)) ||
+	    (S_ISREG(inode->i_mode) && !sysctl_protected_regular) ||
+	    (S_ISFIFO(inode->i_mode) && !sysctl_protected_fifos) ||
 	    vfsuid_eq(i_uid_into_vfsuid(idmap, inode), dir_vfsuid) ||
 	    vfsuid_eq_kuid(i_uid_into_vfsuid(idmap, inode), current_fsuid()))
 		return 0;
-- 
2.43.0


