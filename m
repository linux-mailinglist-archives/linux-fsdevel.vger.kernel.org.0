Return-Path: <linux-fsdevel+bounces-43771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BA0A5D76B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 08:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 168583B9AA1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 07:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1E91F463E;
	Wed, 12 Mar 2025 07:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HeDIrOqi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E31C1F419D
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 07:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741765145; cv=none; b=f04XqrhMIA3Zy0L9eG5GGImVWhv637PZt6n8DN3atcU4IBL2gj97ByJ1n3Y5x6lmiR+EiPbcc3WJ8DqDP3CI6dfu9+63VLKpOKoFW+AxMknMvHab6P9BD+OHFAW0dusl4nYCSA4Unji0xngWD5h9b8FREz/Ily4tzdrTjPLgDBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741765145; c=relaxed/simple;
	bh=/rOCAt1GyVkpzHU3IkZAjzIjdK46yCqVbQSVConueeQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XpNOJQ8nDhfKNnCkxE6Xq7FO6D+UL3JgvvT7CS/FhgNfabMWillzMxtIjHf5guhjqAxZphfE3QUmXtRVbBoeYg5WePMmnjp+qcBeVUvca+HGm3an8kSMM0qKSTfn6nbJtBH//YDUTE5uriA0IYqE3EbiSOseI0d8BOzhT3c0xCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HeDIrOqi; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac297cbe017so122237666b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 00:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741765142; x=1742369942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZtCeKv6mXgDvaZfcbJLDl1nCwkzDkIL3ON1FgL1MyU=;
        b=HeDIrOqiMlZetQleEGK4MxEiH3GpAof2qpP33nWIQDlAzXTW0Q+lldNb29V3Tzic9e
         jiuBthOog6CO2IZrqUECkKt5ZodwZIvEWHI8dWgWs4Owh81/udP/GgETEy45ZMBLhaRX
         7EreYg4zA3yk4LOx6x/cQ1q3hJLfFwJEchyMQ1bCovMhTxP9ZPYH6wmMVmC6SsWin0Oh
         Vgg9jlEVwQa6pYKE4CSq1dfetrF8XeHZ2FCwLrA0cymViVmNpEnf7dbJombRoRu3CZDr
         8nJtNe2y9lZe9Qr5YzelivnvhrM9tZshqkGA2YB8nLPMr3PEof+lku3gUkj5iaZIvT4s
         Fb9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741765142; x=1742369942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZZtCeKv6mXgDvaZfcbJLDl1nCwkzDkIL3ON1FgL1MyU=;
        b=EDH8x8Qv/mnlISgdR8ubBIyYFIGyvt2Ndix2P9OU0z/YQProjzQ2rYGnggVznVEJdy
         4tC54/C4REWixoo+xBi2qmWwZHZsPK2ejP1NlkY4ijNGhRhwUPV6E+ymzgdZdcnhp9Bo
         5HgZ1csR76gGmYHAIRR3VE5sXKxpZwmeDQJNlOm62XQlh12Nf+R+SdPT2QEqesandD/c
         0mKhZltzHw7vEfEFw3oEOZowLULyvS9JbxBQzOGQEjcImLtO+TvXfMKLXhmHZ90BvBlA
         5G6ryzxfb82Savt9A4Ach6tJfK1nRP/JQH9Ouwk0I/k7eiBidJK4wGMsKQZmeCyyQGrp
         jsBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlctGABzcSr1f/B10C1o7/TfWeahM7g+yGo6WqzsZ97GWCntwvEJ70Ob8Zpg5vOJsbPW3lM3r4QdRM3cUJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzEKThFLkN1XPFYSb2iKRtKLLXfRVtV0JqjdDpnqsEPV+/YpUs+
	cGkXlyVostiIavkb8rSomkNDkAKlemCDylTa/a9DK7OCCx6dNbBN
X-Gm-Gg: ASbGncvNsFs8yROekiWJWkeVXgAagc1MEuax0jNijvxPrSdIxHSZyzAiHkHClVnXZdN
	7xoEcfETtHdPYJBHZ4Cf26qv4/YZen/2186GLNP2oqEZsxvzqKGKHQ+M5OkVK2gwqKCb+JmdHfI
	EpNcPOEPVKnFNIdtR5sFnuUZ3bAu8NFGdGNJTltomZz8hQxRSCBLuglUmOvtJS50nE/fu/Ma/RK
	CNcjty0Fqt5ztaDVaLfIfCGnQ5xh3yODH897DqLoC+7mf8PbOFZiGqsAyz6vzsw3CR2goMj1+s+
	9kKARW19OeG/63eU2JYvp44whFCjXqXDv/yRY4Nx0uOpIqWuO8FK4IY4ziZgb9dJ9Qvi1MpCbTR
	OROT8vKymOOfcYyuF6X+lUWI1IAgCHyUDH1lZjh4AOQ==
X-Google-Smtp-Source: AGHT+IEDLicMYo5wrVMzxXmJns8T7Rc0qAzgkOVTtLk9IaHkRTIuBY/c3ap9z2y5v68kO7sqHdLuJA==
X-Received: by 2002:a17:906:6a06:b0:ab7:d34a:8f83 with SMTP id a640c23a62f3a-ac2ba4ec689mr787368766b.17.1741765142056;
        Wed, 12 Mar 2025 00:39:02 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac282c69e89sm624740666b.167.2025.03.12.00.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 00:39:01 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 2/6] Revert "ext4: add pre-content fsnotify hook for DAX faults"
Date: Wed, 12 Mar 2025 08:38:48 +0100
Message-Id: <20250312073852.2123409-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250312073852.2123409-1-amir73il@gmail.com>
References: <20250312073852.2123409-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit bb480760ffc7018e21ee6f60241c2b99ff26ee0e.
---
 fs/ext4/file.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index a5205149adba3..3bd96c3d4cd0c 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -756,9 +756,6 @@ static vm_fault_t ext4_dax_huge_fault(struct vm_fault *vmf, unsigned int order)
 			return VM_FAULT_SIGBUS;
 		}
 	} else {
-		result = filemap_fsnotify_fault(vmf);
-		if (unlikely(result))
-			return result;
 		filemap_invalidate_lock_shared(mapping);
 	}
 	result = dax_iomap_fault(vmf, order, &pfn, &error, &ext4_iomap_ops);
-- 
2.34.1


