Return-Path: <linux-fsdevel+bounces-69510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B081C7E0E5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 13:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5C3B6347CC0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 12:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6692D0C95;
	Sun, 23 Nov 2025 12:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J61glzUb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF6F85C4A
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 12:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763900024; cv=none; b=iJkt/YCPjJ+zExKicyShnAO3CgjSLYX2DrAaM7yseKvLD3efytp9Zt7iUBM4ustPZU+9Hj6yfesgmcnjtl8Ws/Bw0cqp+JS/ykhHhBBQQYb5jps7Nyj/kDH2g1EvaJQjDX92mif4ke7BjhRlWtpgIkMIkmA8xUoAKv3SR00J+FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763900024; c=relaxed/simple;
	bh=C31m14QTTyacaf6yZhVFxGlYz8X/OYOM4Xmwxefxn3A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LJs7LxSDlIxVmDguwB5EVFU/D3kzJNo54dLnX2vNjIpmRTIF57+4FqEy6DSB6alqdgKbtj8BSSjRoUN+Nq4YaW0SGgkkNPz9l/Pq6mBXwOhmBHKeD1rYiHZwNumgDRzh5aV/mx17jcz3E//EzdxtkyzUtVHZEeogKDpX7qrKjlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J61glzUb; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-340e525487eso2298051a91.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 04:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763900022; x=1764504822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WyX1swaZXCFxH3YUkv+TSnEmlsdS6cyArMsiSXhLY8A=;
        b=J61glzUbCU/rIjw1kc7vw8SYWNgg2wK+JLM8jUeVNdiZgIQvxldTsGNDZGjovVPnyR
         Wj+0AnL264pC5qRe4E8eR+SHHxfTrfGOi09cysyf6mAs81FBtaZCIaqcVJP/MRFKv1/c
         Uw/MD66DVA/7W6wQukBSNPTnIUa/atkWor3hFoo0JBfohHyJWsdIZaADWjGTJ5ewJduj
         KLV4NgHP4ZA8Yo54EuPxv6fBJrSkpgk/wwCQYFoA56GSW12c0s/K/lBZ8V0pSNaealZg
         woitTrBUDaBCljp9ru8Lbx2+E1ywU7aYMUfrZb2sxyAVgxfPOMjaZz7050HQthdxWcVM
         kJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763900022; x=1764504822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WyX1swaZXCFxH3YUkv+TSnEmlsdS6cyArMsiSXhLY8A=;
        b=TU2pfukEcfh3B8rtbM86HMGZtrXI1kv7GZYkKM4FV5489j9sA1UN+3bjr4lGTpLtan
         tMdCMlLxBXHjQVRsAV/fcFaw2QbZsOgjlu4bMYKQuf679zknc7QCdEl2xKWPUaoCansD
         H1VHDgXve4vMfHGFfkaDX8Wd9TGqKIsmwR3Cr6wda3vPYp4NLPvEpA/Eu369upI8d774
         ScIbtATL986KjhqBJCmOiUqOLMO8VXX7F++A5hUbGt7emIjnnvzGMUQkFC6kwvoSovT8
         YsY0jP+XCfdQACXWgnhgNTnJUNg57E9S6yGr2g92k5CVRzYIy38MaMSE8eNjPWREyeZ7
         mKOw==
X-Gm-Message-State: AOJu0YwQUI5UtsGrnr17folEpNBLwa3be1PIa6tEtLIgd+yaSI/ApUZ7
	rfU49QScEv958D5al9MlplzBepYjotTQP6YvxTKccj0g7S+sizIGgNcl
X-Gm-Gg: ASbGnct/A2l/p/oKv21l2HYAUzHJAfDN4aTgddNnWe0uxzXWZ1qUdYiTMqbFhnILIFZ
	Ba33/wH6VP8rdM037OgzdlTVfysjzqMy3avXNn14JChoVjDp0HSTeJXYHqH987ovXLBC9Z1mfqy
	SDpjTitqK5s2BFETl4ZVxh8ZgizhzadNmcZtHGlV6GC7ohU2x6z6j7kx8+P2s5O1RISm+N8egq/
	ytwDBOw/5AGJq995lGhBqptk34mUGT+HxrPbtf+IJeeMhKcaez/SvcqMNxsIWtub8Rwkpfd9nj3
	qvniWXVCFAT4OFcL5NiUi5V1w5SH7MY1Y5uvuKRgWvJDaDLgH5bgOIRRkRsqI7PoZMmvOk0ESWP
	2m5X7eESllQaGhq1yixZEaHruJuNOKKNF650+gcACAVkV7t/i/wyeMgSgJi2Rx9I/cZZR4hzvuY
	mOpAWwzHT1DSmUo+7E0da5DQ==
X-Google-Smtp-Source: AGHT+IGkiJz43MaVKsspec2x97fyah8pulbznh0JEMfdt2JxPUnEwy2ZNySTL4iXFirGNGrPJuyjNw==
X-Received: by 2002:a17:90b:534e:b0:341:a9e7:e5f9 with SMTP id 98e67ed59e1d1-34733d76c4dmr7119993a91.0.1763900021914;
        Sun, 23 Nov 2025 04:13:41 -0800 (PST)
Received: from yangwen.localdomain ([121.237.95.138])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd75b61c29dsm10368943a12.0.2025.11.23.04.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 04:13:41 -0800 (PST)
From: YangWen <anmuxixixi@gmail.com>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com,
	yuezhang.mo@sony.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	YangWen <anmuxixixi@gmail.com>
Subject: [PATCH] exfat: fix memory leak in exfat_fill_super
Date: Sun, 23 Nov 2025 20:13:39 +0800
Message-ID: <20251123121339.25501-1-anmuxixixi@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If exFAT encounters errors during multiple mount operations, 'sbi' and 'nls' will not be released,
which will cause a memory leak.

Fixes: 719c1e1829166 ("exfat: add super block operations")
Signed-off-by: YangWen <anmuxixixi@gmail.com>
---
 fs/exfat/super.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 74d451f732c7..db28a426206c 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -722,10 +722,15 @@ static int exfat_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_root = NULL;
 
 free_table:
+	exfat_free_upcase_table(sbi);
 	exfat_free_bitmap(sbi);
 	brelse(sbi->boot_bh);
 
 check_nls_io:
+	unload_nls(sbi->nls_io);
+	exfat_free_iocharset(sbi);
+	sb->s_fs_info = NULL;
+	kfree(sbi);
 	return err;
 }
 
-- 
2.43.0


