Return-Path: <linux-fsdevel+bounces-66841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1070FC2D3C7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 17:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6D25434B216
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 16:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A6531A550;
	Mon,  3 Nov 2025 16:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1cDta+0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADF731B138
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Nov 2025 16:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188507; cv=none; b=SpW3N7eU1hGfFjw4R6ti7j3gEHPkiZA7vo9/lULnGgSvOPkWC2kHRXuZ3oQdMiVlR+T/5rcWpwbBP2IvjBksj8mR/9dtx2g0qYJqFHEbO0Bl2Yx3j1LyrOCm3NFwibx+lE+F0IpMboqnYzj3V0MNcdwsRMRqZ6DDrpcftp2BZCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188507; c=relaxed/simple;
	bh=QVjhfMLQHjrgRMPIbt314bhjxXbir3hpnY4sM9EUf7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OxvSemdR1Dff8EgZ9Thggv0clLF7eV3hkwH0zHix0GA1Fc+aMkh8tEvWU+6nG0dyyVrZ3E768sc8sYyMraxd0DkqGd72zqjMZeo5jeRlMlR4ACfVRxU/FXLCF7AZAhtPUH791VZSvwlPCxVbYauJ//JekKKUqD8jMiGf8iUvFm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1cDta+0; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29599f08202so18000995ad.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Nov 2025 08:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762188505; x=1762793305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZeg8I26rc6UbearIJ6Ec2S3DjEynyvxSgAdjW2/ZNw=;
        b=D1cDta+0aILAknYn5nm1LmtJDQOYWRMoVh6ldmqDhA1OKI7azLUKxuVjOyP8PPAxGZ
         WBTBtJbvAF1fuOzqh++jzfQlHzE8YT0TaqVrbeRjrWRAO+B6cTpmSiGON79QvtKt4fo6
         kiBYUY8kdnw90EZqNqoAIc393CnV8Gc7zZ5saGVLdhTR73uk8pDw4D2v0p8NnZyowlII
         wDemScjx3lu6id0YkOwEMdfJE1OSOPKKoW8jD5HBxVf03v4vkvsXz4O9VmaRmffVg7sl
         erXgXMPU0P/ShLjLKfrBIc+o2a2fBPrlKTckIqrcpp+Yq6XvIEfPsKnF+XTydD3AWGmU
         LMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762188505; x=1762793305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZeg8I26rc6UbearIJ6Ec2S3DjEynyvxSgAdjW2/ZNw=;
        b=e0NTLd3ioE18u9gkqopw4b01shiSOnUj1u3m5kYMyfwMHR/LioQrSVbycVIZ4MbqY5
         8Vvfg6mbzDCara5sqgoNOEJrzyFC5muKdQAuZT9p0bq7Zou17IqU7tBrH6QxXw8vB06U
         N8/LtteYs+4QjFYTyqEXbLwr8YfBhXMNKNYa81H0FpOJM8JA36qTEKlpjV7/BxCCuabR
         WDE/sUfJwm2kelBY6rJnLQR7o4bdpH/nwIAwY5YPSW1ANTMQJjpqLEZ6A4sISQR/lSCY
         NHr7uIbgRcfXrcbG3e8u49jaM2HZnt0EvlxnZ1ESO+sJEIgM7E/X8QOlMT5+482EWxe9
         lAcw==
X-Forwarded-Encrypted: i=1; AJvYcCV0a7F627ejiccmPU6ur9V6ut9d1hOmB6a/YqYskjrfl2a5n8QxsMdKeEr7KGLeRghBjQhVIEAV6KzeKHs6@vger.kernel.org
X-Gm-Message-State: AOJu0Yya2fFEsBnreAl3FOoHa4Kr7AKViCPVQKL0QnjWWZXRFfFIHzXP
	r3h6zKXIo4/iTgPa862OZT8cq43cAjV4OQHx7guOJl3ZAB8i5cFTPE7b4VEZmEe7cco=
X-Gm-Gg: ASbGnctHDUeA1oQe8HiBWhGgJ1sgh4A+P2/C4PUE/wMIWqKaAU7o6bvqcsD49T6day+
	GqUK3zOYbzn4Y/BfOz9q2d3QC+yOMgSz/1xjYhHn4yrYb8X+qAGfGb3+IQdt1OrSZwiBzoEsQGy
	xa35ADmohv44zfT7VKKP77pTVtWANf8/tqQIhPnJPKfxYa3/wHZWVfph1CbdBfItb2mrCJQ7FCF
	n4Qv56iMTpZOcduI5DOVBY19eTQhn0Q2NtVr/K5uVXZx2RU3I87we2VkPxuxfLBUqxHBZicTw2q
	u7kTcBZKfC9yn31awg71W60BJMbDJV4sWKLCZGtIXZXB0tYxngsz/A2o15l7EKwCLdVQT8c7iG9
	OLw0NY1CKAVh+vVQ741NhKWxrLQeI2gzRaZOPF76Lb10hzoSiWksmKLz47eLNECSL8nRwvqI7HB
	MyP4jMYS2Z7EvwxWw0xYSu
X-Google-Smtp-Source: AGHT+IH4dvliuPCPeEksMdouK++OLCepXxAi6BbzFrOf3xBpwY6kdtXvLuXYSMFRaScgJRVXvvJYDQ==
X-Received: by 2002:a17:903:2442:b0:295:82c6:dac3 with SMTP id d9443c01a7336-29582c6de47mr78872695ad.32.1762188505225;
        Mon, 03 Nov 2025 08:48:25 -0800 (PST)
Received: from monty-pavel.. ([2409:8a00:79b4:1a90:e46b:b524:f579:242b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34159a15b6fsm1607264a91.18.2025.11.03.08.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 08:48:24 -0800 (PST)
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Jan Kara <jack@suse.cz>,
	Carlos Maiolino <cem@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	stable@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Yongpeng Yang <yangyongpeng@xiaomi.com>
Subject: [PATCH v5 4/5] xfs: check the return value of sb_min_blocksize() in xfs_fs_fill_super
Date: Tue,  4 Nov 2025 00:47:22 +0800
Message-ID: <20251103164722.151563-5-yangyongpeng.storage@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251103164722.151563-2-yangyongpeng.storage@gmail.com>
References: <20251103164722.151563-2-yangyongpeng.storage@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

sb_min_blocksize() may return 0. Check its return value to avoid the
filesystem super block when sb->s_blocksize is 0.

Cc: <stable@vger.kernel.org> # v6.15
Fixes: a64e5a596067bd ("bdev: add back PAGE_SIZE block size validation
for sb_set_blocksize()")
Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
 fs/xfs/xfs_super.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 1067ebb3b001..bc71aa9dcee8 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1693,7 +1693,10 @@ xfs_fs_fill_super(
 	if (error)
 		return error;
 
-	sb_min_blocksize(sb, BBSIZE);
+	if (!sb_min_blocksize(sb, BBSIZE)) {
+		xfs_err(mp, "unable to set blocksize");
+		return -EINVAL;
+	}
 	sb->s_xattr = xfs_xattr_handlers;
 	sb->s_export_op = &xfs_export_operations;
 #ifdef CONFIG_XFS_QUOTA
-- 
2.43.0


