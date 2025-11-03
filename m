Return-Path: <linux-fsdevel+bounces-66840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9272C2D47B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 17:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80F19420EEA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 16:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D943164C7;
	Mon,  3 Nov 2025 16:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUJzfOx8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E6331B13A
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Nov 2025 16:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188501; cv=none; b=tCM5B0mQ+qU8pvIkucz6g/1NS6SwyzRyA/xQ+c6Z/OweRaaXzOp9oC3zekO/5OpQxEoE670idaaxhyIqgob3uU2QLPOmXgtt+lzOWlqldopWHkFLJHSpl61h0JCTE8Wnq0Sdr8KM5/QP5zBNTWtaJrPogqNJ3qS37Fz4jtIC/sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188501; c=relaxed/simple;
	bh=nWCX9Xn/+IKfnehkSs57lbJDTkS9u5nAvInJtc9YeA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A3Hj0XrN+H61XVPKAwWSg99fuFLG5OCm3opWyDnWgq8MgszKA3PgV8B8kTcVPG1mAh2KQowXo4KgTFlV0fYyqPDtQJA7VAZWGxOa/TOtS5/6QoqHKenEPOIVGV4I1pNBrrOuPR89gDYNKCDzkU42Eka8Iom5BGZ9rX5NiXjWQrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XUJzfOx8; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-29558061c68so21312395ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Nov 2025 08:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762188499; x=1762793299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+UbgPj8GVBWuehInulfgB6O/0NvS5woL/wIoY+Rh1do=;
        b=XUJzfOx8Rgk5EhTJsTuTJ8g4wGWIrb+B4Nmb45rywAwTzwQIrfocseKtTizDCxZTY6
         OckdhFdR7IXuyxayuxEJ25i/58c8bzqNhk/cSlg4rEncYfw0MIAx2R9BnB4OPPzTl3nP
         jjGmwTPnFUe22OKF+KKyU8LUw2cNLQJygRO9/lb+o0O0nc0K4d1KINAD89hYqRqLAF0f
         TtoCH/Et525wmvJJaBOQ+Bi/vILYpTnV36pwd7Ptu0r/Joqx0015mIF3o5/qgf4foXhv
         9BUURVdB+XGf6Tv/tz6XxgU+jjx58r7MyZtOVg8pYGBmsPEOccZXnSVjLey4Ba54xNdC
         LSfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762188499; x=1762793299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+UbgPj8GVBWuehInulfgB6O/0NvS5woL/wIoY+Rh1do=;
        b=Z5N3iiBgu73LEUZbfD4rAWGVkTtQl+fEyw1REsijb7FSGuMZokUQDupvJB6HxWJt2m
         DmhKNEbeEwbNmZ1cx8G4b1HROGCcRnbNkPYlNnOV0TL/kLe/+hZaaPfgGlejyrzV9rdv
         WGO3TGHlFtHVh2d4GoN8Yx8528NuzS8bw+5WuSRs7Zb5QdWl4kuyPmduO/G6HHobdeCj
         k3JEZfzU57IyPVOdUib5OeaxQ/yUFqroXPPCfqc3TV39Xk9BpavL3azi8MuEyZy7eej0
         DLxNrUZtH8SOsxcPAHuTUdHTfS0CScSJTuYlEfMndd4WS8y3X03UwHum3OfpAC9oIl9V
         Jwtw==
X-Forwarded-Encrypted: i=1; AJvYcCWho/sS9H0kavlzub3IeaHI7++v3SyVOF20acpgRxWH3rknXFLUsGBlIqjnZ2eOVepbJcoS/DbvLhMI5Fb/@vger.kernel.org
X-Gm-Message-State: AOJu0YwwaSgudivt4ExFm2f4i6o0U+9I+xfMOErEpVT+773eIiQ9Cqzd
	UHR3YZ/0tiZ3USfYF1JdmJUMciHK28IG0ZKpWIwhunrSn31Mgr4RLUB4
X-Gm-Gg: ASbGncuo9WDUGc+w6GJV5bzBBJ56ZO+zm0qj5khl503D52z/fXNAKnnDB8b3blN6O16
	+v2wtJ9zqvZ8sWf+Ktzbz1QM48wVAZAiVZMB7LNVAbLsEd0Ws58u91/VPbc0qeVcesYAfntK7zV
	yULV0ZzdGcb29MJhGNskhwSAe5UjNHNnUVqU4sQKdTCb2sK3xLmrRa4bMapnbN8PfsvdFI3bu7V
	x9NzYY/rsl06dlY0avVIJu7BruKox4Wv/shtH9is/8AAP49ujIA7/xNXhjZPWS83wiGf8vNvfP6
	L8HKBcxUfFFNgrynXSK+I2i520VQNrcTujQbiBd9GNSgJvv2OvcW4EjVVtk08/rX0od0ijhZgT7
	svqYn13/rGvI56V2aZZ3sDRjI9v70qnjRo1K3M2o9DMrV2mGk7GZ4IAYLU344UwfWxblmWxK3ho
	9wjKia0+Yd1hbivINwYA7T
X-Google-Smtp-Source: AGHT+IEyuTHSlueto2QQ6kf1+GNae44GAu5fq+5W3NoVv8SuS2FAXtOnrUjUNMsA9RRKaWGorvWX3A==
X-Received: by 2002:a17:903:4b04:b0:295:4d76:95fa with SMTP id d9443c01a7336-2954d7698c5mr99114655ad.60.1762188499151;
        Mon, 03 Nov 2025 08:48:19 -0800 (PST)
Received: from monty-pavel.. ([2409:8a00:79b4:1a90:e46b:b524:f579:242b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34159a15b6fsm1607264a91.18.2025.11.03.08.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 08:48:18 -0800 (PST)
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
Subject: [PATCH v5 3/5] isofs: check the return value of sb_min_blocksize() in isofs_fill_super
Date: Tue,  4 Nov 2025 00:47:21 +0800
Message-ID: <20251103164722.151563-4-yangyongpeng.storage@gmail.com>
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

sb_min_blocksize() may return 0. Check its return value to avoid
opt->blocksize and sb->s_blocksize is 0.

Cc: <stable@vger.kernel.org> # v6.15
Fixes: 1b17a46c9243e9 ("isofs: convert isofs to use the new mount API")
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
 fs/isofs/inode.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index 6f0e6b19383c..ad3143d4066b 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -610,6 +610,11 @@ static int isofs_fill_super(struct super_block *s, struct fs_context *fc)
 		goto out_freesbi;
 	}
 	opt->blocksize = sb_min_blocksize(s, opt->blocksize);
+	if (!opt->blocksize) {
+		printk(KERN_ERR
+		       "ISOFS: unable to set blocksize\n");
+		goto out_freesbi;
+	}
 
 	sbi->s_high_sierra = 0; /* default is iso9660 */
 	sbi->s_session = opt->session;
-- 
2.43.0


