Return-Path: <linux-fsdevel+bounces-28824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC6F96E846
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 05:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAD5B1C2216C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 03:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B05B4594D;
	Fri,  6 Sep 2024 03:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Re2zRyXf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE32335A5
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Sep 2024 03:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725593530; cv=none; b=lBdQHjJJnR3Qb8tGk1WBfU8lNr8nXb5/m/BCHnO3VtRmjHnBlMLqeG9HGdwlIS1ibCof34Cj+yB4UA7m3/EnoCHKtFYrB2tHYzD62SP1QuP71e97h93Pc3lbDpX9fpgV1Iw7G4yz6qThRNc82JKAtziVg+9Q7w6BOLrscKqTT+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725593530; c=relaxed/simple;
	bh=PUW7tPIXnPbZ6PDcK6zWF04NUzlToP1OGPf/UN2hz24=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SWiaVSsHmG0qW7xL6tOKCRFoqVsaYtcS3HsVuvD2ZRQMEau4cJUBVAqEeQd8qxe4mp5PwYXGnd2YTuatAFPhKbOoh77FTfu87fOtfQ0/zFaEG4mlRws/08cMzvJhFBeO1DCZuwVcKO+Tczgawpkkoy8ygPwpl5hHs3+4r0lhkOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Re2zRyXf; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-81f9339e534so59950039f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Sep 2024 20:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725593528; x=1726198328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pklHzsyr81y4E/QnTXPkxYxJuOqPd2EU67TIdWayiGo=;
        b=Re2zRyXflA6tlDMO7Uf42yK4YmsejeAJoRn99PP2VPIK5SokZvLEsEoBtGfQ2YF/vM
         4fHJlhVUuqbqqqE+kP9NLsGo514HsG7PAjD3lm2tEFdjUj9/Gr7uhqCU/69eoS3FOFfp
         0kUhcWpDwVTiiH7BoSJHGTpg7B6Aon0THrFZruFddoEX3o+rb75BVnL+r8jBpz8V3I2W
         chmM/+9icb8W4C6pKSmy+nwvO7oMx8BQVGt1PKjD9N7prDfxg+UMn7l54lVwI+yJ2xcZ
         Xx3zv/iH+OIQ1k9e9NSaK4z909eC4vNCpIklZ7vGG4PqbPibTcxINBcPW1vRwmVEdkgP
         rG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725593528; x=1726198328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pklHzsyr81y4E/QnTXPkxYxJuOqPd2EU67TIdWayiGo=;
        b=OROSs8GyQPb/DR+RDuvsfBvpNYochTgs6JxYDa2DigkeTQUXIsMYYgc0vh8yqRdzDp
         wjUitrYik+Q9cmg5cu/8mKaoXsiQ2pT9xCHLUwenjC5iEyBytBNgh7dCBIRr3bjOumzI
         maUuKyWRmiw4kGWkFYHJ/quUVghiIBRSys5S/QY9c1iR4a0xiAuREdOVJU+F+GzWkdYE
         udJPgjvOHv/g6cmkx7AY+RMGL4XKXrczSNsc0diRGIZ7HoxYxzk7dbO7dHIl8NbLeuFb
         6yKNWmjMhNblSOCNUiBv4QbgjMRn1ty5MPbRqRa1RWhIwSlhBAo5XTFd7l2ELvjeVx1n
         5p3A==
X-Gm-Message-State: AOJu0Yxc9e3f2owAtOsV45TWzkcK/YpBjnBnA+SSjfUGwm8HMTKcmNvU
	9SAcgGX1XamPEQiOphCieFQa9n136uzoXlO+4csqNHQAg9HiIgTpTBW6Hg==
X-Google-Smtp-Source: AGHT+IHq0dVlvK3ONTaWMjk2iuMJy+WNXACBRnzIFfTnx6cAN90xN2hdDN5EQBPBggsj1JTulJXBSw==
X-Received: by 2002:a05:6e02:1a85:b0:39f:5c5f:e487 with SMTP id e9e14a558f8ab-39f5c5fe651mr188391455ab.17.1725593527697;
        Thu, 05 Sep 2024 20:32:07 -0700 (PDT)
Received: from localhost ([123.113.110.156])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d666fb3ee4sm679228a12.86.2024.09.05.20.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 20:32:06 -0700 (PDT)
From: Julian Sun <sunjunchao2870@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	Julian Sun <sunjunchao2870@gmail.com>
Subject: [PATCH] vfs: return -EOVERFLOW in generic_remap_checks() when overflow check fails
Date: Fri,  6 Sep 2024 11:32:02 +0800
Message-Id: <20240906033202.1252195-1-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Keep it consistent with the handling of the same check within
generic_copy_file_checks().
Also, returning -EOVERFLOW in this case is more appropriate.

Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
---
 fs/remap_range.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/remap_range.c b/fs/remap_range.c
index 28246dfc8485..97171f2191aa 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -46,7 +46,7 @@ static int generic_remap_checks(struct file *file_in, loff_t pos_in,
 
 	/* Ensure offsets don't wrap. */
 	if (pos_in + count < pos_in || pos_out + count < pos_out)
-		return -EINVAL;
+		return -EOVERFLOW;
 
 	size_in = i_size_read(inode_in);
 	size_out = i_size_read(inode_out);
-- 
2.39.2


