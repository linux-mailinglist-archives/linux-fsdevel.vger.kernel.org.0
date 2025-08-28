Return-Path: <linux-fsdevel+bounces-59523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 135DCB3ABC2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 22:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABABFA03919
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 20:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49AF2D24B7;
	Thu, 28 Aug 2025 20:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="PlBMivtS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1352D0C67
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 20:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756413454; cv=none; b=FhAM8PBgl1Cwcqo6WWA6bTeYJpMwFz7QZ0EfTveIfFbTwapGKUPxr4VNTFIgQ3dkIhdUGeE07Y4uf7r6d2PfxEdajTtn+W3pmKi5vHyXA9ukVlUkJmu2qtQ26ToEAnYutWwXfrTmSSZiyECdyhqbWKZhvGrO3EpWN1J5NaKmZr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756413454; c=relaxed/simple;
	bh=v3tNAwBhpBUiFio8okJKatoWKiAA7m7Ju8WjJI9haxI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jFioVMrc7fdJwvSDik5cTbRdWKUazF59N7nNO1o3p2C99ynMYt2x+vGK2iL4WC/B5CWFfyTZRxHZhA0kUJhLoQqheFq2jmPSGPJNPKkuPsP+i+qgqOxU3IqMzkVta9vhfAxyjbbDyO/ta11/f7l4w/NYdp/dwYnD0daNrxyiMts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=PlBMivtS; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7f8ea864d54so136195785a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 13:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1756413450; x=1757018250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4RriXiZVMbDirHcW8G/DnsNKudmZ3VJAyWsZq7K2sfI=;
        b=PlBMivtS6QAMSpzIePsXIlPZBanzJDNn2658B9raE2RzeUUU6U1UoQC2LkeIUgpgg3
         VNBGREjbuz1qBRcGfXk3X5rGSHPkM8ywSJZdYY9A0NeCsexDdqOnLYjGnlgkoNmZPNtp
         6O1cHCYjKZRsNHC5pMxGvXktfAYVzL68QhJC+Q4GHZajTcJUzy8XrN4fc9gLfXxF3y1P
         tETMQoIfpshhheDjINI3uLAytlRcNrZM6qHWoRcublYjLfeZTtuVxc9jAx84AMj1MOAE
         89yI9xzTZTjd0xXtGY5u5H8vIQYt2IpdldqCVsDARoBsYH341cwR3aXT7/GNcXp02/2r
         cFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756413450; x=1757018250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4RriXiZVMbDirHcW8G/DnsNKudmZ3VJAyWsZq7K2sfI=;
        b=J7XDU3cFLZ8EYwo1ZENkNMfHIgzF7iaWIJMLhra/aq3VxjgeF/XafdVtvGVa+Nhu8y
         roVNd7oxCn+tG61kQCw3dIL/H4JYASQaJJtwg80K57f5J7rwZJ4L2YH4PJU9SSgvivuS
         /cZb56+i7DBaNSm1UDLAqbcQDvj4o56Ah3pNsSADU8o0IYPDZn1+sa2bxndCQa2PRo8g
         WD/iZDioD/0eSE4zadqXQHnWmbbbYA3Of68h2XGEM4A9fRTFP7mI+briObRYef26gJUj
         lY72G1yKVfxOKzcZNykFJ15mS12ijz1QPV/dEvHnnM7L48HJ4Mil70gNIeQdgakHTiCn
         eLUw==
X-Forwarded-Encrypted: i=1; AJvYcCVuA5C0mWT4A+A6KXVZMN0zR2pfFWWenE1+PXpsCb2FpfKiZC5+PT4Y6LXTGNXm9AlhpfBhKnrRvjLRb3by@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6DVTs/iXWchOl6f7g2BjYAmur+5Fa85PnyNWh2ZDshn4ndu+y
	2ZpDDZvBIVpWgWkCGAbBYscQTOKXhWglxfoQWFFwWJRXR8EE72cfCwH5kCS6/Wq79bQ=
X-Gm-Gg: ASbGnctBmG+1wgCeDvt/C6cbL27FYMgJXyni0ALa2Atu3vjxkMCrxvk0Cfjlu/4mCqB
	fKYUKjmx2utt/i5xT1CMKjF6DtNRIG63xs6Reu8miYfS8EQi4GYTfZ6VZR9O3LFv8jJIikYUnNj
	+UeZKxSfwjsn+NQ7SQfw23JHTjYiUbOY0/CyVVZEUZr7Sip3wAmWW+FFmkjn1/ZoODNuRk8Fpz3
	1I/dXN8VBVc9SwSnVsGrw/0hpjCg0nznNxJ6o8JPGvEpZUqyDeH+D6tq/Y0WSDyep/xTPIrBX6w
	FD2eUvCL6Y5IRNlyUuKS+/WG9Q9+XJwrwImCxOfpCt1pN2PANu5hxt0ZbpFqY0Ruyk0Ye10jMv+
	2fdDMtsT6Hn84fwY26VBoh2mxNWNOB7Q18rXEjQ==
X-Google-Smtp-Source: AGHT+IEjz8KP1dIJYFfgk9q1HARMOkHqV+Dlmyl+MAWJJuPIjW/g3EPR5yAAe9oscuHjVmxXLnELLQ==
X-Received: by 2002:a05:620a:2590:b0:7e9:e676:2162 with SMTP id af79cd13be357-7ea10f7232bmr3147260585a.13.1756413450043;
        Thu, 28 Aug 2025 13:37:30 -0700 (PDT)
Received: from ethanf.zetier.com ([65.222.209.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7fc153de18asm45879585a.54.2025.08.28.13.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 13:37:29 -0700 (PDT)
From: Ethan Ferguson <ethan.ferguson@zetier.com>
To: almaz.alexandrovich@paragon-software.com
Cc: ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Ferguson <ethan.ferguson@zetier.com>
Subject: [PATCH 2/3] ntfs3: add FS_IOC_GETFSLABEL ioctl
Date: Thu, 28 Aug 2025 16:37:15 -0400
Message-Id: <20250828203716.468564-3-ethan.ferguson@zetier.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828203716.468564-1-ethan.ferguson@zetier.com>
References: <20250828203716.468564-1-ethan.ferguson@zetier.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the FS_IOC_GETFSLABEL ioctl.

Signed-off-by: Ethan Ferguson <ethan.ferguson@zetier.com>

---
 fs/ntfs3/file.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index c1ece707b195..0a1e9f16ffaf 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -49,6 +49,14 @@ static int ntfs_ioctl_fitrim(struct ntfs_sb_info *sbi, unsigned long arg)
 	return 0;
 }
 
+static int ntfs_ioctl_get_volume_label(struct ntfs_sb_info *sbi, u8 __user *buf)
+{
+	if (copy_to_user(buf, sbi->volume.label, FSLABEL_MAX))
+		return -EFAULT;
+
+	return 0;
+}
+
 /*
  * ntfs_ioctl - file_operations::unlocked_ioctl
  */
@@ -64,6 +72,8 @@ long ntfs_ioctl(struct file *filp, u32 cmd, unsigned long arg)
 	switch (cmd) {
 	case FITRIM:
 		return ntfs_ioctl_fitrim(sbi, arg);
+	case FS_IOC_GETFSLABEL:
+		return ntfs_ioctl_get_volume_label(sbi, (u8 __user *)arg);
 	}
 	return -ENOTTY; /* Inappropriate ioctl for device. */
 }
-- 
2.34.1


