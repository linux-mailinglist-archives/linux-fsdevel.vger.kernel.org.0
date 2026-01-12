Return-Path: <linux-fsdevel+bounces-73252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F4FD13642
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 16:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 388A430E3C77
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 14:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4052D73BC;
	Mon, 12 Jan 2026 14:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BoAamKyW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lDQHUxPA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B309D2BDC34
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 14:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768229483; cv=none; b=ItpkRSa77urkk5bO3qtjOQOIXOhpwh8CuHTPaIKaVCpy/VfVPKXrsKNP2rzS87qi33ZboR8SA4OYU9R5mhKrvKTQjOJMwpuxdOvLdS0DOxqcTgAwqhJQfRpsNVCu5mlZvgvHuirNSfDnzsGoFmT43Hd5ZgiN8mXSwWuioKYLPB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768229483; c=relaxed/simple;
	bh=Ui6S9HS3D72Dvt607rkAeRvO/cjZeK06ykAfQjo8x1Q=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJ/JLOqKeDl7+wTGb7wELAqNCpSYJOjnO1ORSj7MDJ+4ixFbw3rCGaiuRDJM0h1SY6KVdcUB4S28ovC9vU7ysIhLDgsuDfAHk/kppQdwHHs/jzRt3rSqiL7dFgEtviefsqhBRuYKzlNCaLIfPW+CKEVjV2yhhUU0Xpe1NdCdOV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BoAamKyW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lDQHUxPA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768229480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GkYVW08k0HM8Mu7wCr7O7tI/HJOedcd0CF4Vxrv4g90=;
	b=BoAamKyWBUnylQ7174wUfQIlWRO64LNjqC2JtA47y7LjOxaktNFpwnsdVXg7yLtj2kPgwM
	fLnSsS29gbK85yVMyW4CGZpySbnBhF/hF+ak+fY9FOXGvUDXMJkYsSwoVLk3J2fag36RTD
	4eWd3eFP50uGNEnLpkWfjBSWQ0eSAak=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-hk56ZhqqPDekjPaFZOhcfg-1; Mon, 12 Jan 2026 09:51:14 -0500
X-MC-Unique: hk56ZhqqPDekjPaFZOhcfg-1
X-Mimecast-MFC-AGG-ID: hk56ZhqqPDekjPaFZOhcfg_1768229472
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b86fff57291so311281166b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 06:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768229472; x=1768834272; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GkYVW08k0HM8Mu7wCr7O7tI/HJOedcd0CF4Vxrv4g90=;
        b=lDQHUxPANfydzZOUGK2nZuKbf5M6x1fGzt40YirfAMSvxnIzQ1/eyirLxOlHSDxHiz
         EkC0h6+nviKgPYLfksCbotB7MontMnURDPEhcgq6gDj0XMAagOtJ2KUPOV8bSxaR4n/t
         sFQPVbwa7wrIk3C9FgSFk2Va1IpWF2Fqsb9q+W6nOGCQ07ESsBStXvjQS08FuFL/JyXo
         ssDg7yzIekeYjhwgjOOq0LJSU6v4V8x8jProVCLgaQrSTkJZAypCnKZVm7shBKwnUdQz
         iP/I0fdQljrwt2PS6DiFBC2AjhFVRG+V3mKNk0044mTH3qb53Fekj3lNKIB3Vp/qikaf
         A6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768229472; x=1768834272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GkYVW08k0HM8Mu7wCr7O7tI/HJOedcd0CF4Vxrv4g90=;
        b=meWbPeJZxE0s6E0/NZEHrcoM/f5E2vJ82qFr2Kfv2/bRODEQ9OyJgtwf4uyX47lDeD
         tg9tP2NshZyxO0ncGfuk+0W0xrtDA0WTiCvVfHAbgGqV+swGnx47oEVTjRu3OWOVpSQN
         Bh9l4ItCXIR0k3Nz4Qaan7Lyul9hEiIrOt+axzcZCjokBE1dO9eeRJWlMJOsd75O66B6
         omMPZeqztFhiSAlwB8eOSb3xCQ6LXZsD1QfgyvjTLnEPUROA0XdTJTlob+hIYNj2u6B6
         Jrrzz0/EQCqaV72HRJ9ULIfbWZsbdERkrBV5ziJa1OTRZQfTYlVErYxe0tIeIMGswMvG
         zBSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEdDzBUYZz+erl5DJfTioUDU6KJBl/6Om67jYC4lofc1hJFzLgSAc6Vbsa2olKeylYOuY4A0gZK40vNQnU@vger.kernel.org
X-Gm-Message-State: AOJu0YybycZbI6B80Sgl79vGJBByaqgr6/thmO7XExl+oBD54g7XtNQi
	w9r6ToyWZz1ih0Zk58rKhIPg8iGcHoM0jgpEdE+CD/oiKb9T9uFsQOZAy/ImOEWCTeNtpKD0ckY
	Ql2FLUtggFaSTo62M752pHLIyq0FgHmrMQKM4xcxEeAOZQ8ggebXbdW3TolFTFsmr4A==
X-Gm-Gg: AY/fxX53HWHQyR9K7h/fOGFhXUeNmKsYigR5LNGUv6TwT1SaZSrMs6TanJUVAW9ESmO
	PDdiW5viN+BHrUazdE/Qn5GhTG88wGn3ikea4KH8nFTKJektgfQ2ymP/gAmIMS+rHHvwLfVEUGK
	pvhM2T6pTrpQw3fkMi6s1ZPIdJxtYS7DJ9F5Di7lWS54S1zbhXFCkrWffKjioi4sVv2oHFmpeJc
	h6GgxHIW3HHylARMkg/LClN+eXVYZOicqH5Uu9vv2FAbDeOM6+RtSXmLNVMbn5rIsBaLPUuKOy3
	iVcP9/s8sdg2W94r9XYfgSqQHzVOaDbJbEItR4/dgxUGQ5dNtWF1vtJMeVwTcuyG/C56sGaQDUE
	=
X-Received: by 2002:a17:907:3c86:b0:b7c:fe7c:e383 with SMTP id a640c23a62f3a-b8444f2399cmr1908211466b.22.1768229472383;
        Mon, 12 Jan 2026 06:51:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQ1ZUBBBfOOPZZu6PAvc2nvhedv6mbNuX/r+QasAtk1f3qnZVL9hQtJxfwvPp4FpofexbIuw==
X-Received: by 2002:a17:907:3c86:b0:b7c:fe7c:e383 with SMTP id a640c23a62f3a-b8444f2399cmr1908208166b.22.1768229471737;
        Mon, 12 Jan 2026 06:51:11 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a4d1c61sm1897676066b.35.2026.01.12.06.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 06:51:11 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Mon, 12 Jan 2026 15:51:10 +0100
To: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, 
	ebiggers@kernel.org, linux-fsdevel@vger.kernel.org, aalbersh@kernel.org, 
	aalbersh@redhat.com, djwong@kernel.org
Cc: djwong@kernel.org, david@fromorbit.com, hch@lst.de
Subject: [PATCH v2 11/22] xfs: add verity info pointer to xfs inode
Message-ID: <7s5yzeey3dmnqwz4wkdjp4dwz2bi33c75aiqjjglfdpeh6o656@i32x5x3xfilp>
References: <cover.1768229271.patch-series@thinky>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1768229271.patch-series@thinky>

Add the fsverity_info pointer into the filesystem-specific part of the
inode by adding the field xfs_inode->i_verity_info and configuring
fsverity_operations::inode_info_offs accordingly.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/xfs/xfs_icache.c | 3 +++
 fs/xfs/xfs_inode.h  | 5 +++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index 23a920437f..872785c68a 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -130,6 +130,9 @@
 	spin_lock_init(&ip->i_ioend_lock);
 	ip->i_next_unlinked = NULLAGINO;
 	ip->i_prev_unlinked = 0;
+#ifdef CONFIG_FS_VERITY
+	ip->i_verity_info = NULL;
+#endif
 
 	return ip;
 }
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index bd6d335571..f149cb1eb5 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -9,6 +9,7 @@
 #include "xfs_inode_buf.h"
 #include "xfs_inode_fork.h"
 #include "xfs_inode_util.h"
+#include <linux/fsverity.h>
 
 /*
  * Kernel only inode definitions
@@ -99,6 +100,10 @@
 	spinlock_t		i_ioend_lock;
 	struct work_struct	i_ioend_work;
 	struct list_head	i_ioend_list;
+
+#ifdef CONFIG_FS_VERITY
+	struct fsverity_info *i_verity_info;
+#endif
 } xfs_inode_t;
 
 static inline bool xfs_inode_on_unlinked_list(const struct xfs_inode *ip)

-- 
- Andrey


