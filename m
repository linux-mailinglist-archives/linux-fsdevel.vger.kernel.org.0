Return-Path: <linux-fsdevel+bounces-29536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E78BB97A976
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 01:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE4732866DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 23:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0242014B95F;
	Mon, 16 Sep 2024 23:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYwAth14"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103152D045;
	Mon, 16 Sep 2024 23:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726527916; cv=none; b=m8raT0tAaIpFaGUx2LSIuRq9Laa3X5FMEIdmsFXMzCROme0tHrMGh9yVsjQ/P8nBR78irIPXghqP2zJT84Tyi7rC/z+0U4QXte6bUZf3iBMpwh5KX4InZNyCwsw6VJ1jBMkULWy1csRW/+m67n/DYzvUDj9wDhUs0QCALz1pKLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726527916; c=relaxed/simple;
	bh=p3p+2lo27LCcptAomSooMZ0s33cXcloTRQOaXZDu5LQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YoR+H/Jjt7H/+yHV/ScwIqUSwtboxcQ6iPzI55HOXX99dlxy5OLfvlRqxGYiZSy9vv7jp/nwNZnV904sWXTuK9cc1FE2AyS9rppzbddyZHs8ugRNbs57Vj5wtOELQUSAVUv2WIiamsDSvgRYFtpZmsTgLrWa4mBd7C7evquposE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYwAth14; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-718e285544fso3014593b3a.1;
        Mon, 16 Sep 2024 16:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726527914; x=1727132714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zOakHZuxa7c7c5RzK+ZKEYyw7xMGftvFG3fp4dWaRwo=;
        b=BYwAth14FW0FA1lDMTtf7nJNJGiTove2CBF2OdNFyVlau3vhLLg4siNPJGiqvH8MrF
         iwE0FpZxIx1CvdA5CRhVkIxgWsNwcwSPpxHHcdF4dUcFHOLq93HhOKvEff7QBuPs5DAB
         Qs41XeJYmNmZrzvU6FZ+tVQhiNbiFQi8A0mUSfTgP8zqSa5NPPvkCaN+W4aYOAOKICEL
         HlT5+7qk5oI9GifDSjoM+RRnHWrCETPRQJzDAqDk8tB8XFZF8o8/RpKOMTTKy2ikBB9O
         zB32mnshjTbWOg/vuggyOlX5K8A5EuvU7CRVpGpAe/8AkWrRheNcutqSFjUdqT+LJxQG
         SzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726527914; x=1727132714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zOakHZuxa7c7c5RzK+ZKEYyw7xMGftvFG3fp4dWaRwo=;
        b=Zy4hHnRgAoYGmFwVC7k/o/gBVTGYtLfQh7JHITgXgFe6A0KyEDiFWDDzvXm7cKFZxK
         MnNGxd4TsGGUBNkjelR4pkdJnpHVy+Esk0pV1rT6RcJRPjBtG8HDr/sV3CLvlt1h+TBE
         iQHr1Rc2cVJotFvKpewkocQfSNNDwNKaj1IzlL6PXZvD/OS0QIzgtq2dj3XSUL0XX72l
         aL3PYcnPgb98DDBFaK8tdnipYI12dMKq7VEsW5iTXUNsGLX8T+tc4PrFCBh1aRmblk9w
         VYcaKPV0NApcnnwnfv2/XhQ5MqYUjKLjZodLREqsxP4dNSgADo0Xl1qFjnw/SNPEM9mB
         oAoA==
X-Forwarded-Encrypted: i=1; AJvYcCUo2pqC89EvQUEK7754XtKvZw/eLdJ5gJLUEGuv/Vp9Dq6ZSqArqXbe/TF4QAIucVW+z3WQ04JNi36eLbJm@vger.kernel.org, AJvYcCXO/oHIx2Ys12Cex2TN6EsGRSuDmWYSeaKbOJw////0Vg/X4jspJJAVxB8vkaifgAmRh3HlgseN/i0Jr1ux@vger.kernel.org
X-Gm-Message-State: AOJu0YyM67FGAekfeelnaRG9+oNgVlEjsp3yPsH3iz5bcjcd0/xz92I4
	B5IjSgXwYDMDVdJvch+8/qDU+LmNthIQujeOdKQAWLRQjzOkolmQQOETtPzw8sE=
X-Google-Smtp-Source: AGHT+IE1Xmlgh0WtQ+h82E6jgcTh6JOoZOPwDF0ogIIuLkpRRAkYFk1puR+VlPrr5EjibqAmd8cQMA==
X-Received: by 2002:a05:6a21:6711:b0:1d0:7df3:25cf with SMTP id adf61e73a8af0-1d112b68b6amr21848184637.19.1726527914214;
        Mon, 16 Sep 2024 16:05:14 -0700 (PDT)
Received: from localhost.localdomain (syn-076-088-006-086.res.spectrum.com. [76.88.6.86])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71944bc9dc5sm4251658b3a.191.2024.09.16.16.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 16:05:13 -0700 (PDT)
From: Daniel Yang <danielyangkang@gmail.com>
To: viro@zeniv.linux.org.uk,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Yang <danielyangkang@gmail.com>,
	syzbot+e1c69cadec0f1a078e3d@syzkaller.appspotmail.com
Subject: [PATCH v3] fs/exfat: resolve memory leak from exfat_create_upcase_table()
Date: Mon, 16 Sep 2024 16:05:06 -0700
Message-Id: <20240916230506.232137-1-danielyangkang@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

    If exfat_load_upcase_table reaches end and returns -EINVAL,
    allocated memory doesn't get freed and while
    exfat_load_default_upcase_table allocates more memory, leading to a    
    memory leak.
    
    Here's link to syzkaller crash report illustrating this issue:
    https://syzkaller.appspot.com/text?tag=CrashReport&x=1406c201980000

Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
Reported-by: syzbot+e1c69cadec0f1a078e3d@syzkaller.appspotmail.com
---
V2 -> V3: free(NULL) is no-op, removed if() check
V1 -> V2: Moved the mem free to create_upcase_table

 fs/exfat/nls.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c
index afdf13c34..1ac011088 100644
--- a/fs/exfat/nls.c
+++ b/fs/exfat/nls.c
@@ -779,8 +779,11 @@ int exfat_create_upcase_table(struct super_block *sb)
 				le32_to_cpu(ep->dentry.upcase.checksum));
 
 			brelse(bh);
-			if (ret && ret != -EIO)
+			if (ret && ret != -EIO) {
+				/* free memory from exfat_load_upcase_table call */
+				exfat_free_upcase_table(sbi);
 				goto load_default;
+			}
 
 			/* load successfully */
 			return ret;
-- 
2.39.2


