Return-Path: <linux-fsdevel+bounces-62923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7A6BA5A3A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Sep 2025 09:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B87043AD421
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Sep 2025 07:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6761B2BEC55;
	Sat, 27 Sep 2025 07:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEtbOpIa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C0B242D8C
	for <linux-fsdevel@vger.kernel.org>; Sat, 27 Sep 2025 07:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758958134; cv=none; b=RrTyCIUu8gTG47AUwTIl0FGqNBuwLPPr0XakZtyLSiMgbpy2HECHu3uzc6wMcTn1ttLsILSW6/kyOAVxZNr5S3R75rv1RDU3u9xoh/AuvCcrPCLaWJPJPSDRtk1Th8c1NXvs3c/M3mreAbHi6aZS2n+vFAcNFZZZEDxdiC+H5jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758958134; c=relaxed/simple;
	bh=ws6xOthopswVWueNlcODedeBAn7z4k/3lJ3AIjx7Pvc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pKmN/gIJdRhGE0Fka53X0nPnBKaxHlcKeoWkFIEctqvnr34oWcPXwfLM/oUGoS9LZKnRcwE9J/z6QwPUhA2rSgKiOfWQ474z/gHP2K9AraIs/OgcfLHzbevR8JKR9kEBs4Qi3xDfpe6UHV90FeYuT/Lobl5XjhCTEixYs3EQXbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEtbOpIa; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ed20bdfdffso2411163f8f.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Sep 2025 00:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758958131; x=1759562931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LUF4AT79yZ/1kgypLqGgmkelfJrwmvBHPVvrxZ6wlWo=;
        b=WEtbOpIasBDeUX1KxBla7JPT+sKpR2RT8DYQooaKVsS9YHbTOgsJD8XRhPQcKYP7QY
         Z9YvWTBWql0AXZkfPf2A6a3s6zUfu0Kow1yxUnrFeckB6MoTeWY9h+wFcYT4wWiStp2b
         ADRFXDly4bLhkyP6x8+KUHiImMJuE7Kwf+UP+IJBhZBHq5NqTUdX1RyXpVDZWR1DHHsf
         YCimSn95LhE7VxrMOMpVmw0Hn3X+57LO+ANgyz0UrkCXwZGvefSQsHfYOV+vgdNqwsWT
         qFKmwhr2ZQuoC6McHa+juIbxgx7IXXgdSVtzBMUhsrPoDboea3RY8RlxCJjwULVSEI0A
         5Jpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758958131; x=1759562931;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LUF4AT79yZ/1kgypLqGgmkelfJrwmvBHPVvrxZ6wlWo=;
        b=Tu3Mt/7B4HlQA6P5hz008hK5KQcnoCUdKmTuflJKQ8+5F9QMPfaJFpqKtYrhC7lVB9
         T6XGW0j6gDvF1SfptRyFKibormflF0LOFrHP62YbavydCHRZaJJY988N99MuDX6PopVM
         SjabK6g56jEqe8n1C4kqc9mIITy1BzIaWWLI/oL+85Pxy4PpMRB7Y1Z9Fk3pjZuFIDcU
         XhTrE3pfyV9A2FSaVp9/7LvhpNELSBtQNBLRyRH0Vq0hmjNzCYGVdiRvkwymPzOOMzTR
         dTce2EdyJpjY/ltL1ewPayGi8TJ9Cb0jPy3XKkdGVDv/ObQdxJVBjrtZCYZcTKJhVcas
         erxQ==
X-Gm-Message-State: AOJu0Ywl6X2K3AEWv8xCnijH4WngoEfLlzsnfcP4lrGMjOIc42wlRN5c
	3AyKbBTAwrLVk/iK+0xnMzdt4rWQw3DDwDrz2xyvcjxbJXDK5dQlea1MQRaCOHEv
X-Gm-Gg: ASbGncvH0mRbFtYXBwbcW1LH1GsFq0lcbe24Ajt//X+ot3OQtPQgvg+QwzqrNiJ8X+i
	XY1GF7IG/Ji5Ovq+IPdhgeghW92Nev6+U29ySUOvRdKu4Noo5FXD9DcxtpkLyX5NK+krgBy1cdS
	egbtYI0/cYOajTzGptDPs9jIhsQZIK4hcF6S1Uq7xYcq2GQCN2H/tAUMqIBb7XylHEFwitxwlEG
	oPn2AJLrIZTD7wlq/S1m7yYlhUp9I4Gft7xrzkm7t2WRhzUj/8YpCicr9Pouj/AiKbZMESKapMn
	xfUkVI7PBGIHJwy9IybdKn2BOSPMsHqqxzt6Qq/89tITQ8GEAOxPl6gJiGjXMfTCmTKGXVyvrl7
	kNGOqjHunoMugZqL7UpGbICDWXyW5/4JvDN29V8/VqPzFtSGiwF/KS5V0/tkm2bGbHc72FbULdW
	Vw
X-Google-Smtp-Source: AGHT+IHs7ZcfbMRLMn987bC07Y3CP3fXnKcHfcSNzdjHsjvCZVyVGzddO2NeFAa+7uLn15UHmZSsmA==
X-Received: by 2002:a05:6000:26c9:b0:3ec:dd26:6405 with SMTP id ffacd0b85a97d-40e481be731mr8950415f8f.26.1758958131217;
        Sat, 27 Sep 2025 00:28:51 -0700 (PDT)
Received: from dell (117.red-81-33-123.dynamicip.rima-tde.net. [81.33.123.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc6921bcfsm10353127f8f.43.2025.09.27.00.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 00:28:50 -0700 (PDT)
From: Javier Garcia <rampxxxx@gmail.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	Javier Garcia <rampxxxx@gmail.com>,
	syzbot+e126b819d8187b282d44@syzkaller.appspotmail.com
Subject: [PATCH] hpfs: Initialize memory in `hfs_find_init`
Date: Sat, 27 Sep 2025 09:28:04 +0200
Message-ID: <20250927072804.583940-1-rampxxxx@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid the use of uninit-value in `hfsplys_strcasecmp` and `case_fold`.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-and-tested-by: syzbot+e126b819d8187b282d44@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e126b819d8187b282d44
Signed-off-by: Javier Garcia <rampxxxx@gmail.com>
---
 fs/hfsplus/bfind.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
index 901e83d65d20..75f1c029c2ed 100644
--- a/fs/hfsplus/bfind.c
+++ b/fs/hfsplus/bfind.c
@@ -18,7 +18,7 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
 
 	fd->tree = tree;
 	fd->bnode = NULL;
-	ptr = kmalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
+	ptr = kzalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
 	if (!ptr)
 		return -ENOMEM;
 	fd->search_key = ptr;
-- 
2.50.1


