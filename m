Return-Path: <linux-fsdevel+bounces-29775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8433697DB28
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Sep 2024 03:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F4A71F221E4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Sep 2024 01:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982A23D64;
	Sat, 21 Sep 2024 01:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7LjhjN3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB4836C;
	Sat, 21 Sep 2024 01:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726881190; cv=none; b=Jo1UTiPfQpIR22FHQF3VSGj+0bfDRSXerZCXaEX8kNI2+QC6whybEaBx7ZLn0sIqgpdZzoBM8EtBdGG0umUQGJ54AuHuUICC5RrzOgcAV3+Q3SdXdx1rLeL4/45aU0o6Vqu7bh1woCQS9cPxMcPDrfB70lV0LPTtTETALLQ4m2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726881190; c=relaxed/simple;
	bh=ApJBXp8aU52y3hgoyxSgPpJcY20lFPBpYtQwSED9mO0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tE4Hq9YRu34aBSGZzZmUqc9it06V2Ebh7k8JgoRqwnRIBCcwMQdgcsID8REcCA3Ut1fq4+5beiyuKQBKixd9/XSCb+rSWxeNorFoELd1USAZ6P4IR+gkik6lGCYfztoRuQuZXtBKuTRY7Wl4nhCcDhX3dhjIrHWtPIkHvmogdT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g7LjhjN3; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20570b42f24so29786495ad.1;
        Fri, 20 Sep 2024 18:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726881188; x=1727485988; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KhWTpLUtCJ0kiQ1X7/HJbn73e+6H15QHc9kTJn9s/H8=;
        b=g7LjhjN3mGy8idV5EHk81zJZjC4DUZNf+G0eAsDNzM7hKkLTOrLLxTjYzqfv2he8RS
         tfPESMAyvjnvIw0JRwW5SkdU4ST1AdTWVpp+MzaRcQb2SYHt21kM2Ilvhygw9JAh/TDY
         Sa5SpTRTdwDPxdWaWlXcSzcElS54wyqGewXtjNhl68+/KlzJyu9J6llhQOTFTmhde+gH
         dm1R41JsdpPgZQAsDMk1UyhksXsHdJAibe6MwLVIc/hWIjHnlu7gMfbA737B5wZaogva
         nlod7RujLiwCxukERsm9iH3zNl+K5f9Yj3oCf7e1l9KQbEhFAdtcBPSGmlG2HSt4blpl
         3Imw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726881188; x=1727485988;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KhWTpLUtCJ0kiQ1X7/HJbn73e+6H15QHc9kTJn9s/H8=;
        b=d5f6mnK17ufky9wZ0EyIK6I0Aha4+l7z+pvvLSACYyIFp2qvNWu29/jxE7FKcU4PMr
         21Qz6sEsmXjv6mptT0TTdmtLLH/zqcniYcKaN3d8+DeiJVu42V7Nwltn3U8wuO36an3x
         bz+iY7k1TqpG41fW0nkcE0cUMBVDwO/DWPUDaZHBrYptRSYO0R+0XabXivV31iyVx7Pu
         LlfaCWFPJhg77t0Eau/fcNmR2UupdPaCVCdrqt6Hg17/GSu7ePxQhu1Rz1taM9tOpWLJ
         XPUgORbzqdjhgM2noeCRytuM/dh7b6Bb5siCwXO0NfDC3daXg3O9rxc+0yPefBHk0x7V
         68cg==
X-Forwarded-Encrypted: i=1; AJvYcCWwxWcD4WYEbW1etJtfx9w2zk+PXz9En/NAlSc0pFrIU4g4P+WrgMkOf9nEDNi6AKEtxdFm81RjVlttZgrs@vger.kernel.org, AJvYcCXxei4h0XLmRezSZx5fp/PJknBh3eOBEUAv6bFdHzUeTK4JZdgq5ddxxIWwA3J4HU6Y/ontF5+BDaHnYSIz@vger.kernel.org
X-Gm-Message-State: AOJu0YxrXJzi9koPd4LynD+Oq83vx+zmwXjHOpnZn7o41lMYSXRGvPt0
	yF2C24Jyy/AXsaJCE0hMzsRt2S6w2iGOR2b9vPodpu5WiSoSW0OS
X-Google-Smtp-Source: AGHT+IFb/4FuUoDCmoFChGv5caoTFoY7jrMIDatYtcYptR4hgzZ4J7g/uEd8146atPwtf85TrjOdYA==
X-Received: by 2002:a17:902:e54e:b0:205:894b:b5b0 with SMTP id d9443c01a7336-208d83a1cabmr71344795ad.33.1726881187970;
        Fri, 20 Sep 2024 18:13:07 -0700 (PDT)
Received: from gmail.com ([24.130.68.0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207945da7b8sm100732825ad.16.2024.09.20.18.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 18:13:07 -0700 (PDT)
Date: Fri, 20 Sep 2024 18:13:05 -0700
From: Chang Yu <marcus.yu.56@gmail.com>
To: dhowells@redhat.com
Cc: jlayton@kernel.org, netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	marcus.yu.56@gmail.com, skhan@linuxfoundation.org
Subject: [PATCH] netfs: Fix a KMSAN uninit-value error in netfs_clear_buffer
Message-ID: <Zu4doSKzXfSuVipQ@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use kzalloc instead of kmalloc in netfs_buffer_append_folio to fix
a KMSAN uninit-value error in netfs_clear_buffer

Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
Reported-by: syzbot+921873345a95f4dae7e9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=921873345a95f4dae7e9
Fixes: cd0277ed0c18 ("netfs: Use new folio_queue data type and iterator instead of xarray iter")
---
 fs/netfs/misc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index 0ad0982ce0e2..6f967b6d30b6 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -22,7 +22,7 @@ int netfs_buffer_append_folio(struct netfs_io_request *rreq, struct folio *folio
 		return -EIO;
 
 	if (!tail || folioq_full(tail)) {
-		tail = kmalloc(sizeof(*tail), GFP_NOFS);
+		tail = kzalloc(sizeof(*tail), GFP_NOFS);
 		if (!tail)
 			return -ENOMEM;
 		netfs_stat(&netfs_n_folioq);
-- 
2.46.0


