Return-Path: <linux-fsdevel+bounces-55910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD176B0FD31
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 01:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0DB24E8501
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 23:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2184F248F6A;
	Wed, 23 Jul 2025 23:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="heslaQ3n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAB9282F5
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 23:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753312160; cv=none; b=abuh5EytMr+0tpHBOcw8loa7n8ZOZcYnXSHXHl3/Lb9tmf95aVul7DfSECQsBRFkDu8WhAOaeTdWmKxYUSOnpZ1S42K2MUq0MU2wYlTMWOBpmVD5u/lpegkDWNxsW1AS+xhfVK2d9+DFujwa+TSwjcUV6qnb53A59ogHzX29Xok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753312160; c=relaxed/simple;
	bh=1LZvcV7QO9X8BPXCuoaUgfmKwcKlIDLoXjwJ/lBO3MU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dT+pP4+f+FrEtptK0tnaufupTl8pA9E5yaY8soNvaHUdpcdasOg/1qmll/nDyOifJshTUtxjVEvXG+B6eGpVzdcETIlW4u4yLFSOnXVqbvhgRhLt/ecUG+WCzzpVf75DhiySXSVTqzPMP75IaIDTPOk4oCz6HffbrOp/njxDbBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=heslaQ3n; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-235a3dd4f0dso2275065ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 16:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753312157; x=1753916957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WsJFGIA3WJAa6hp1/S3YaaYo/eHlJkFOQ5eywkwQaVM=;
        b=heslaQ3nMh5FMXxdd7kY0r0lh/utuADHE6fGvwxQihbHrUDNpqCkOPnw/HIqL+3DrS
         jj67zgCbzC4wYfaekGxJK88w2gTavvDi1EtW3GRl5FiRvHiiudakOHnzmDhhceOtEnfj
         DDURmGeZ6+TS4M2ZhlbYjDlpJEZJXQtO4o4PSjgo+FJ1K3H9I7i8BK1/Eq+ITkGe0jfF
         du4legb17iJOVMPxEvwxLEVIAHzwsUFpZmpBrOWfJkHFLk3ZCKfjTZAzndKaxmQv8xGT
         22X/v0v+Qv6Q8ZiCOMcjwoWu1J8GZeib+xPx+NyyMuR1i65VoRY2wUdh3s5dauz6qDxm
         uoBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753312157; x=1753916957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WsJFGIA3WJAa6hp1/S3YaaYo/eHlJkFOQ5eywkwQaVM=;
        b=BAAW0zqr9Zr5zdcaxy8xD3tf8F9uhf5Pe7VSYA1kNmGJVFNZl6TV/PjXzaHJpTWlsF
         LWpgGFKRWn59p2LMU/8ZqRFvz0wzs4MXm/w/CUiYjRFckJKilZGir71RjPPY2wErW6OP
         dRmRpLXIWwP2UaBlzf5XLKS7t9w745+caBZJ3ds1+OAa8TqNFajhkYapgTgoSNteWDIO
         jS06nD1WJtnUvzw6SIXUgZfJtC9YuDyL3v6rjnBeYrLHEvLw+OGP9EzX6yqdbSXJKwCb
         VnSaOcd/4FUVceggs5f2mT1JEtvwqPieKOt2Mfaho34CtSQh25Gavb9kG8AaDYYyX/A6
         goAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLP84uVZ3U6TH1Z7yPA8dFX8yBDP3eK7cggynCCUH1QrMFI/edkMYUwG3CapbxDloot6zIFVCuomCpc+BV@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8YSx2NoBQVj+JXr8+11n+ZwQ+lAA+5gwcYnn9uoY1UuVL45Rx
	yMJcxPxhhqWJq7QlYdh5wg5VafoS/B0hYf3CwpemEiiVIQQnpnFFFuze
X-Gm-Gg: ASbGncuwUGfsiYd7XQliHcMOBygLj89iR76OKHhAgRQXBiKNwm1P/Ub2LISJFIbaoK5
	ARlyqUy9sIuOFK7yhGj0bLIFsUwiPaQsTWKTubtlqwYzpWUh/KjbP6MxuA4a2LalkeKFyZGhS32
	H3U0i+j2qruczuvbEVcS4ZmI0hNyAEp+0PiuELhkWXpzzI/tDCdPzn+pJP/k3LLvSEx8y/qOm9T
	S0NC/485LJpREgZC7quN1nJ1TR387E5f4MoWsKHxp1YkmFv1w4seTUVpdFtZLUUxqSf9V5HzzIP
	ObWecvA0ohl+LCVkLnEcPo73g2VOCtN9qJQtHHv9EIPHcbANHh7Syv/UePTM3uJB3z2XweugeQl
	l3z+SYKAgRgD6h0gCBA==
X-Google-Smtp-Source: AGHT+IGmSi6XewYEE53y8zZexhXKzlBjbsWzSkqIDXN3iq1VUgi28TdMuonczkOOQuNQ60sLt3y+Sw==
X-Received: by 2002:a17:903:1a68:b0:235:6e1:3edf with SMTP id d9443c01a7336-23f981bba6bmr70945475ad.34.1753312157244;
        Wed, 23 Jul 2025 16:09:17 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4e::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa475f35asm1232685ad.28.2025.07.23.16.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 16:09:16 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	miklos@szeredi.hu,
	naresh.kamboju@linaro.org,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: [PATCH] fuse: remove page alignment check for writeback len
Date: Wed, 23 Jul 2025 16:08:50 -0700
Message-ID: <20250723230850.2395561-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove incorrect page alignment check for the writeback len arg in
fuse_iomap_writeback_range(). len will always be block-aligned as passed
in by iomap. On regular fuse filesystems, i_blkbits is set to PAGE_SHIFT
so this is not a problem but for fuseblk filesystems, the block size is
set to a default of 512 bytes or a block size passed in at mount time.

Please note that non-page-aligned lens are fine for the logic in
fuse_iomap_writeback_range(). The check was originally added as a
safeguard to detect conspicuously wrong ranges.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Fixes: ef7e7cbb323f ("fuse: use iomap for writeback")
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

[1] report:
https://lore.kernel.org/linux-fsdevel/CA+G9fYs5AdVM-T2Tf3LciNCwLZEHetcnSkHsjZajVwwpM2HmJw@mail.gmail.com/
---
 fs/fuse/file.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index f16426fd2bf5..883dc94a0ce0 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2155,8 +2155,6 @@ static ssize_t fuse_iomap_writeback_range(struct iomap_writepage_ctx *wpc,
 	loff_t offset = offset_in_folio(folio, pos);
 
 	WARN_ON_ONCE(!data);
-	/* len will always be page aligned */
-	WARN_ON_ONCE(len & (PAGE_SIZE - 1));
 
 	if (!data->ff) {
 		data->ff = fuse_write_file_get(fi);
-- 
2.47.3


