Return-Path: <linux-fsdevel+bounces-71706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0409ACCE497
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 03:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AAD2E3031274
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 02:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAFA26FD9A;
	Fri, 19 Dec 2025 02:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/QzUamP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B101A9FA8
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Dec 2025 02:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766112391; cv=none; b=BbG4LwZfp/3Zy6pM86WFcP3D1AG/UW5SFFTENBWkTxKfNv/uWPwE8sDENI9S9g4L6UDcd3gAgs5bKnlH1ObCx7d8UQwjwnvjL1aEu5TcUt1MOR9tThW/EXc29AswyR/SXk2faq8rH+kiYom6TowBkvLy1am9d13Ik1NlX6df4Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766112391; c=relaxed/simple;
	bh=gx9egYwNyOLG8COiLMNJ2G5D5Xz6fhuoKXZkEZT2GTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JehrxksUoOGB2mI4zUTBoOj414IMcHEuGOwq+b/Gkc8/a2yo9REtaPEyYYm5qoypDL1JkAcvtQpT98oO+SQHjGLvhvlzK6odLM8QcL2HW2kOUF3u9LGh3/OVyVGv4zHuFMTXqWw2si1HhgtO/Go1jXidxu9F8nzH5EhIoYeEiqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/QzUamP; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a110548cdeso17811015ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 18:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766112389; x=1766717189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=grQdtE3r9/QTZpn5w2Pcmx+yheOSssd7sfy0R6WcoWM=;
        b=F/QzUamPyqT7G02oHRSKCrsQiKtANCcRZzVVtO1WjEDXv5j7GjbHujIrXKGxNY0iu4
         Se+0eOUEDJuDOslieXa0ibjK4a81OiVAtZ3+s3WUmf4d2kTxg5QlHD92M7A0nD5BzZbt
         kF6UgETrQjL6EY58XLDjHwDp9v17lb86cad3OZZ7LVpWGF/H7TfNP9Ikukh+WhAaN2BV
         U4sZfw6ldKp7aZKwgurCCpKaE33M80URw3PHWVz8prWmIUlj4+bCdPq3PWvD9kdn5WtC
         XR2XuM4Gy0+2VQR3cx1qk4NmeQKi+ufXneYsTBNBQg9xUmuOr1j/NYkvYL7MdzOpQr/A
         Aghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766112389; x=1766717189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=grQdtE3r9/QTZpn5w2Pcmx+yheOSssd7sfy0R6WcoWM=;
        b=tdWmZlHZC6NiLP4jgCmNCAk5fNYOobWCwfpVwNIJiDTU9myG+iAkiDaTdgvABc0Hha
         eB1pxxyJjFXVKH9IIUMgA28VDzale1Rmf7H2yEZOg3R9YTA60SSciQLKqlxEq6cgdKT+
         4DYfMZJi9VIfpUL4VP0xJ10AiUHlaGoH3HtkROtQr5nH1mH1C9Kqyi8ICtcHqarJeFr5
         +FehFjZh4Rori8NEYChj+NBWcL7HLyrja1Rf1tIjvY5K+jUQpoSe6jtOY5EOI/mm88xc
         FoiJiodQmlI1Jg/NPTgRgDUAL8h/rnhZ7ezS+KobbYGLMwcoJlsLty5/3D8QhqNfgml4
         IJHA==
X-Forwarded-Encrypted: i=1; AJvYcCXm648MTKXU4ET0B9HweFJ7LMnkC+Oe1oOCdze0yxE70X9rlrR2njheclnlaQ+v7Nl+r9J6LlfpBoDZv1yn@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr0L6h+FBJL6p4bdXf5VLG8sqmqx7Pp8hUCeKM1qaD1UYG8XN3
	co6yAEN+xm8aENA/ASxMW1QqYDLBf+eUs+mkWpIvadbFn0y6SVGnUHBl
X-Gm-Gg: AY/fxX5NkcFD6Zno3l1yON861PJYoPKO5c4S2vBeuOTSPIwqLWG4Mu4rHpv36JAd0pe
	++jkpxJlhF5K2tr4D8QmU+UfbMltrcVvW0VcyVgmxhwbwpU5MZoFJSTuQ/lty8ZgZp9eqaKXzTF
	8YWvjMEggf07FWCX2/hnf8bmQa/fdpMSSVL+oQJGzFnohckZtN3IEn4ZPUgMdrszYRYJzPVAQNO
	t4oXREllL5utGCYVvF+Vn24NavolWfJ7OV0INb126gG1nIumGaummQ4wwNiAEXjLQNgEP1x5XAA
	CPLcJc4VF7A0+MafWL0afLl8kqqGEW5VNgP1yK2MNzitjIriF0S4NNARj50gS0DH+MIs35LIlb2
	4X53OqFn+ESJAGq7ERzyE9HZGWjXqnOKhmiRLU4s/iPmFK69pNgT6f7CPxAaSmAcWKzbk3muUxc
	NuK5oK+QIFIGg=
X-Google-Smtp-Source: AGHT+IH6kLdkFfg9Uw/sw8p7iPd9I7eoSdIQVM2ft77XXUj+1bapU8czFaYiA+8gRzoA48e9kIsrsw==
X-Received: by 2002:a17:903:1c7:b0:29e:76b8:41e5 with SMTP id d9443c01a7336-2a2f2830f94mr13246755ad.30.1766112389351;
        Thu, 18 Dec 2025 18:46:29 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d5d428sm5996655ad.73.2025.12.18.18.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 18:46:28 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 5CE9A4006BF8; Fri, 19 Dec 2025 09:46:26 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Filesystems Development <linux-fsdevel@vger.kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Amir Goldstein <amir73il@gmail.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 1/2] fs: Describe @isnew parameter in ilookup5_nowait()
Date: Fri, 19 Dec 2025 09:46:19 +0700
Message-ID: <20251219024620.22880-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251219024620.22880-1-bagasdotme@gmail.com>
References: <20251219024620.22880-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1054; i=bagasdotme@gmail.com; s=Zp7juWIhw0R1; h=from:subject; bh=gx9egYwNyOLG8COiLMNJ2G5D5Xz6fhuoKXZkEZT2GTU=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJkuu/9xxp72dJiYaPx/dZbpx2mqf4/kbKj1f7LzLM8yR aejD9+Vd5SyMIhxMciKKbJMSuRrOr3LSORC+1pHmDmsTCBDGLg4BWAifmaMDFNXXGqwKfHsmHM9 9r5v97zo5r2FsmEzffoubzN7Waq2UoWR4djOZpWJxQFGNsvWtF/g2r2b4xZn+PNHS/J+ee1zLMi 4yQ0A
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Sphinx reports kernel-doc warning:

WARNING: ./fs/inode.c:1607 function parameter 'isnew' not described in 'ilookup5_nowait'

Describe the parameter.

Fixes: a27628f4363435 ("fs: rework I_NEW handling to operate without fences")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 fs/inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index 521383223d8a45..379f4c19845c95 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1593,6 +1593,9 @@ EXPORT_SYMBOL(igrab);
  * @hashval:	hash value (usually inode number) to search for
  * @test:	callback used for comparisons between inodes
  * @data:	opaque data pointer to pass to @test
+ * @isnew:	return argument telling whether I_NEW was set when
+ *		the inode was found in hash (the caller needs to
+ *		wait for I_NEW to clear)
  *
  * Search for the inode specified by @hashval and @data in the inode cache.
  * If the inode is in the cache, the inode is returned with an incremented
-- 
An old man doll... just what I always wanted! - Clara


