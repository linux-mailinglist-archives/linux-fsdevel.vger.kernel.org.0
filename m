Return-Path: <linux-fsdevel+bounces-52674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72227AE5A10
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 04:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DE681BC18C7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 02:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B152C25F960;
	Tue, 24 Jun 2025 02:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctKtK5Jf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54D0202C46;
	Tue, 24 Jun 2025 02:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750731802; cv=none; b=Jcl1ufZ7lM91RMniQ/GWFJa1QjCW8oqffSs5LK0ak7G+uLDbEGa/dG80CpChqb/wxrfo4yG2IMZofGJ8sCTvQYSnRaYsjOHtoNVtbQsonF21fRLWLKLZXmXYSTGv0BPeoa3ptfMUv6twePTAV6KT7EXwmhUV/2T0OJ64yw1to7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750731802; c=relaxed/simple;
	bh=NXvJXV7hV5VX1A3DbVPlfuB+DQXi7Ai0ttTfd/GgEBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iu9OI71etVw8PObDXqs+jx26p9ZVVdCYnIDvO2U83EpcxUwmHApRUSjw1J40TwHggkUFcZig4rwTdUVYsELR30F0AuUua78ItA4OKIy9Zo6gQ2d3mShZmVhJlrprTmSmNLzkvr8Ahr00MHxq+jzjSnyR2XYbdF/F57r4tSvmf6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctKtK5Jf; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23636167afeso49622615ad.3;
        Mon, 23 Jun 2025 19:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750731799; x=1751336599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vS9enxGE4scyhOnl0jCRmBaC3QtnFwkaoENIefu8KUc=;
        b=ctKtK5JfHgLMXKWUMv8egUJZGu5iFwFCcrvlYwKrRzSnG5c01Xm4qSJR4ZZdNak8LO
         GAsgO1esFDqC2d19UiUYt6iq0zUN0QEmzPxbEQYiLJLUtc9+M1kliHNS/BFZweZ05SqC
         gJElLFOIT36PThUEsY8gdWhYO5lzaX317jiiyGSzKyzbhN385uv17ptrWWOu/vKXlpXF
         +K+MiwJ+DnqT8LcUIuKEdkVTUGC3wIoyMNs0zgOphnX/wEhndClEM0//mlbhV96LZ7b6
         14RfT/ZfJ7qOVCiywrkSR1uWM1gDQrZ2IrCf+Yv1fcV5VuAXHBabpr/dNi4RoUMXGTXp
         thYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750731799; x=1751336599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vS9enxGE4scyhOnl0jCRmBaC3QtnFwkaoENIefu8KUc=;
        b=PIrZwYTSun3VH3iR62SFp9w9aWlZMaJj5eGF0eoMklggLVL290/gd4VYTgWE+sYQRw
         8XnyVXiKUWCpf615GANFuJtoJkC8z+Nelc1fbh7CJ6AXh9NR0VgK1EwtkhJJ+E1HVBhK
         XZDu25unGTp4gcem6y2HhG5fZldJVpVRwKpP0W51CZrCD/aaACrnGBVRUJ/pp51asgu/
         pMQo5d8v8GknLZBYjhHDhhYcEjNDzipsHCex4g+e/eDjsXxydwjdDLOm/vgp2Dv2s3TW
         uL6RD46HWw2jOZHru/pHA9gMHF701MHdY6W2LWpRPipnqw168QfQisD+ybcd1NALHnIK
         058A==
X-Forwarded-Encrypted: i=1; AJvYcCVGri8Z6iqmFXGvDyxFD+RR+fC5OZAk+aNZZV3A5kgoQTGz1ROsJX7vX77TgbwkmETC0EmQ5kGfBBIxRw==@vger.kernel.org, AJvYcCVKzwlPQE2Mjso/3NQNSWzc+a7kiPSO+m1pCe/SO7OuFIupEC2bb5L17ATxKmg2Bpp11VlNnIAKoD5/@vger.kernel.org, AJvYcCWYoEu8Wvw1RRX5x0imxO8b4zyqfljN3RgXuYZ6V0MeC4nEQ5YRjnfl1TUnGvUhjb6Hy3p7kLyE8Pjp@vger.kernel.org
X-Gm-Message-State: AOJu0YzZUicrCI3Wyuiks+AATzswLRtjrrjve7erNxFLJ43lNysbCCJo
	8Idci3ekaRKp2c5JfteigRVfJPFoLekCf0Up95IDCVl/oDmXibwVD3wyf9mxcA==
X-Gm-Gg: ASbGncs/JanG6Jl750bn9cOplK2RAEx9N4OryYqWxjJ99IRDb0MAewdmk5BAMlFo0bX
	Rqycd+aR6eIoLGv2bENw0BPXZiPpSpQTH8Oh3nwBVlawIEWwq4he1Y7EHptAFfXB5Ft+1WJ9Z/e
	T+BFGLfFNi4gsbeKdlfPZfdOp4X9sZ/0Q/Sc6IdcBBRVhCylKjXTH9kDCARQ3vtmvKJKCQFZi8n
	BFmtgnXRWw9OZ9Wzd8jcrvAlunPTA+ctZ42+xYXJ8mxfn2JNsBNAMw402aX7gfygyf9uEwA32h9
	7VKA9Oxl8IBbpQkyXP+eV2vz6I7oFiZYkvLLsd/llteXoTqUIDJsk/j9vw==
X-Google-Smtp-Source: AGHT+IHHN3NdI6A3Tl2/yAf+aHNuymc0kUa5+C9+HT99bCU5TJxjq+SW6ZDmi5lIXml65nLdWimKwQ==
X-Received: by 2002:a17:902:e544:b0:236:748f:541a with SMTP id d9443c01a7336-237d95a285amr209985895ad.0.1750731799044;
        Mon, 23 Jun 2025 19:23:19 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d867b438sm93975805ad.176.2025.06.23.19.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 19:23:18 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: hch@lst.de,
	miklos@szeredi.hu,
	brauner@kernel.org,
	djwong@kernel.org,
	anuj20.g@samsung.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	kernel-team@meta.com
Subject: [PATCH v3 15/16] fuse: hook into iomap for invalidating and checking partial uptodateness
Date: Mon, 23 Jun 2025 19:21:34 -0700
Message-ID: <20250624022135.832899-16-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250624022135.832899-1-joannelkoong@gmail.com>
References: <20250624022135.832899-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hook into iomap_invalidate_folio() so that if the entire folio is being
invalidated during truncation, the dirty state is cleared and the folio
doesn't get written back. As well the folio's corresponding ifs struct
will get freed.

Hook into iomap_is_partially_uptodate() since iomap tracks uptodateness
granularly when it does buffered writes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 35ecc03c0c48..865d04b8ef31 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3109,6 +3109,8 @@ static const struct address_space_operations fuse_file_aops  = {
 	.launder_folio	= fuse_launder_folio,
 	.dirty_folio	= iomap_dirty_folio,
 	.release_folio	= iomap_release_folio,
+	.invalidate_folio = iomap_invalidate_folio,
+	.is_partially_uptodate = iomap_is_partially_uptodate,
 	.migrate_folio	= filemap_migrate_folio,
 	.bmap		= fuse_bmap,
 	.direct_IO	= fuse_direct_IO,
-- 
2.47.1


