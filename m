Return-Path: <linux-fsdevel+bounces-7477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5292825682
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 16:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C574F1C22E43
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 15:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF1632197;
	Fri,  5 Jan 2024 15:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="rwPkPCBi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD6F31739
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jan 2024 15:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DC8743F2D2
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jan 2024 15:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1704468120;
	bh=3ehRu/Zuzjv9SF1nMloRA0oZhzJAyfoaCoaYcJRfDMg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=rwPkPCBiHVlCldgv1sD58NcKh6RZeUqv43gVGNFpIrNa5xhPBiV3B54lXJMaZlnzY
	 HAudK6cegJ49sxWgtlXKY/Ln+Ht+pmtaB3C2dXn4xqwqCa0Gk51j5ioHbcYzOIufrZ
	 s5lUzk4QCqTTv02CjFNJdyrpgwvFHmVSRSAB5NPfhfHjnl5iLVUEaofKfMn0dgPRq4
	 3MRr5lniVgIFsCQmXuz/NwAX1N1IOG6wzLD4WGcFeL+WwHiHJ1Ws2heHfx+GyLyVzO
	 dZLT9yePaQxNODjaXtb/VVrg5uCB5cIZX/St1u4bLS/tgWrpv0UgIvYZ25Qp6a3OsU
	 uGlfjEVTvx5Wg==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a19c5cbbe86so93139866b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jan 2024 07:22:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704468120; x=1705072920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ehRu/Zuzjv9SF1nMloRA0oZhzJAyfoaCoaYcJRfDMg=;
        b=ESokJtBv5P2QhigisNfYXyqVeTYB86QhB/RvPyLVUFTmwHFKLyakD1GfJOOPOABxrS
         3TJvtv8v5s8hpgxik1xwBb4KMAhoJvZzZ3a239jsyCSDW1XpIIfS0gUpOkizoVV+cAdz
         Is+LPAwIpwQqFppkQ3MM2Hm/4noyIIekSrKxG4hrJ1QwrMlbFWE7JCTOqxaIuPm9h15O
         1uFq2df5Yv44VBg7tticzd8Hgi4+qRrV6+hNFITxF1iiRtpvt9B3VI7GGCVVZwEKWXPp
         J1ZcQPQ6La1ofYDZIa33gizPPkILOkFcxoO20+8c6SQOHV80dl8oanf3IWC35ZfYW2Vh
         TynA==
X-Gm-Message-State: AOJu0YzhmcijqjdQAXOEUoA8gvV91WtT/OC/C5DpTNnjUoVGb8wAHo1k
	erHTfcIS3nlBVIU2+f1uVEUrABMFN2DjpNnSD5pzLsNwC+PCE/BozoWiFDROvX7uUkaBkzPhQwI
	Mjt8d/aLIKUQjBS8xHa16hXaWl7n+o6fxvqKZxN2sfudhe6x0jA==
X-Received: by 2002:a17:906:e0d8:b0:a27:6e73:a248 with SMTP id gl24-20020a170906e0d800b00a276e73a248mr773798ejb.68.1704468120504;
        Fri, 05 Jan 2024 07:22:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1Qf95Xc1DtQrvYbmkcZs/ajyvnuK5OKpFVhctUoOgo9efyvmBIthHb9SYj+TsVGtv7sYLnA==
X-Received: by 2002:a17:906:e0d8:b0:a27:6e73:a248 with SMTP id gl24-20020a170906e0d800b00a276e73a248mr773791ejb.68.1704468120298;
        Fri, 05 Jan 2024 07:22:00 -0800 (PST)
Received: from amikhalitsyn.lan ([91.64.72.41])
        by smtp.gmail.com with ESMTPSA id i23-20020a170906115700b00a298adde5a1sm345630eja.189.2024.01.05.07.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 07:21:59 -0800 (PST)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: mszeredi@redhat.com
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] fuse: __kuid_val/__kgid_val helpers in fuse_fill_attr_from_inode()
Date: Fri,  5 Jan 2024 16:21:29 +0100
Message-Id: <20240105152129.196824-4-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240105152129.196824-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240105152129.196824-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the sake of consistency, let's use these helpers to extract
{u,g}id_t values from k{u,g}id_t ones.

There are no functional changes, just to make code cleaner.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: <linux-fsdevel@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/fuse/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index b8636b5e79dc..ab824a8908b7 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1489,8 +1489,8 @@ static void fuse_fill_attr_from_inode(struct fuse_attr *attr,
 		.ctimensec	= ctime.tv_nsec,
 		.mode		= fi->inode.i_mode,
 		.nlink		= fi->inode.i_nlink,
-		.uid		= fi->inode.i_uid.val,
-		.gid		= fi->inode.i_gid.val,
+		.uid		= __kuid_val(fi->inode.i_uid),
+		.gid		= __kgid_val(fi->inode.i_gid),
 		.rdev		= fi->inode.i_rdev,
 		.blksize	= 1u << fi->inode.i_blkbits,
 	};
-- 
2.34.1


