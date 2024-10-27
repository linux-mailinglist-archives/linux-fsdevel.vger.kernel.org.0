Return-Path: <linux-fsdevel+bounces-33029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B009B1FAF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Oct 2024 19:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53E18B20A15
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Oct 2024 18:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C03C186E27;
	Sun, 27 Oct 2024 18:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fe02/s6E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD15175D4F;
	Sun, 27 Oct 2024 18:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730053083; cv=none; b=b126QtEfOAeXfsMhe9hX7ukoZzth01Rx7RV6VRiFmUHN7l3RQMlRYzMxr0yh3z5/wYK5K13HzZeYvUzzWmCP8DConvYa2m34MMlYOAzpTz9+kXuD9pfwaWndQAcrkWSZUAq5zNPMV4tePY/POAJQhvFs+/AnD2hw5ja77jReGMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730053083; c=relaxed/simple;
	bh=kzZEMQtGjT3xUvEAgHBfB/Plmy9itmDznejbLu1l7yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VGUuerI4ovDzMal0G7468tJn1pYhPa8yI4O0jaV9crGjZtTbiU4UkpIZ5kl7MYVId2+S9GAeVr0M+WXDgMMEJLqsL1z2JlhBPlM3apIEJGjVL9GspRNisC8OGtwOHzBmj4lxLwkBdfCaMpQHTVaums3AD1u8nHruK4pdVjKG3pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fe02/s6E; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-207115e3056so29127435ad.2;
        Sun, 27 Oct 2024 11:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730053080; x=1730657880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHyJQcVgH8e0oFFdgLIXEiGBIAl5grLOxXR97atkfWU=;
        b=fe02/s6EK3Dhoqh6+i/38MfVtPrauywLohVUm7lxjHgdg5k0PKRrK3rqmZnu4Fmf/w
         UDjF7tLKR5eHP2RbL0bhqueCHnFlc8JZJEIfoM+gXcSiZX96MQjqFg5UymE5dIV4qNVN
         TihQ5D/sreHl/DQCVXl3TZLGLNxUNwpHIC1KJHAVNw/tCBP6GeQ5D965Dwg2GsA8rVaP
         +wqwy48eUduxxqCRlkaMjbRsArS+MbQoybmR1RbgmjSzPU2FlxLtTEssL5yGZlYC8NDf
         bFFGaBXtsI0MvuWVMVzFnIF/tlgdHmXGHrKw3Py5UQyeS8lTdbsjsJUe2fkHDrzocF5t
         x94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730053080; x=1730657880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NHyJQcVgH8e0oFFdgLIXEiGBIAl5grLOxXR97atkfWU=;
        b=Ua+CcUL7wtn+ynzz2JsAd/weN0NpLakXAmQH3QSOHmBWPueRgl+jcY/8IDPmj3Bgzq
         QIpl0pTJUAuaFK25m28dUAXwZZir/L/s4tFrMaug5hNKkRG9lJhHsIUVcLyegtRaUwDE
         BEGucmqsW+Fqkf8BelShYV9zAyTJlm8vUjc/WJYWyW7edeuBxEZQ2Hnix0bxy5yA3yQ7
         FHJmV0y5KpOpGahHIyXoPgUQgveT3dBrRx3W5E7O3IFt1QvfiuToMoclhBo9EJfyAKUX
         B804jgMvg/bExhAsz57rfi5I/UaM2tGQ5Mjs8AeGSdrnF53gKkK02JKi7ahcCBP340yM
         JZ+w==
X-Forwarded-Encrypted: i=1; AJvYcCVOvSWlG1eDHIkVzKTU6pyZtX5rZ+prUcRkjiLkJ6YW5F95FCpRmdhqW3HU3Qfz9xgoTS62OP80T/QqkvDg@vger.kernel.org, AJvYcCW0/BAHdEKAn9vgFbzSePVikXFo4DY683rG/W9Q7nfCer3lGde7HHSfd6Bqx2G71cP12+9EbSWNKyMYulI3@vger.kernel.org, AJvYcCWfJ9zjK2/dZKuSVyoH6KrAebFrE23TAf2hEKCvzPrY/R+AQCdUt7R7m/r5vMX7W4uXSdzV/p7mS/Yb@vger.kernel.org
X-Gm-Message-State: AOJu0YzCbU5JMUda6BhjXyOC8aTcGM4NHSdcKTMqszUgQYsIf6ym+mA/
	Vq/h95630qWS+VmVYrvY5RjfhknTWFJnL0/07ppnSoJi0ktZ27e9g6sHIQ==
X-Google-Smtp-Source: AGHT+IHlK1DQGgtyzFZ/u5B+HQUDv5dmC5qOpcScmo4peyuali8RqyvqysJpa6H37hq37KZO+0Zbnw==
X-Received: by 2002:a17:903:2309:b0:20c:5e86:9b5e with SMTP id d9443c01a7336-210c687399amr73289195ad.3.1730053080009;
        Sun, 27 Oct 2024 11:18:00 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([171.76.83.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc867d0c1sm4306492a12.33.2024.10.27.11.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 11:17:59 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	John Garry <john.g.garry@oracle.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Dave Chinner <david@fromorbit.com>,
	linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v2 4/4] ext4: Do not fallback to buffered-io for DIO atomic write
Date: Sun, 27 Oct 2024 23:47:28 +0530
Message-ID: <80da397c359adaf54b87999eff6a63b331cfbcfc.1729944406.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1729944406.git.ritesh.list@gmail.com>
References: <cover.1729944406.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iomap can return -ENOTBLK if pagecache invalidation fails.
Let's make sure if -ENOTBLK is ever returned for atomic
writes than we fail the write request (-EIO) instead of
fallback to buffered-io.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/file.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 8116bd78910b..22d31b4fdff3 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -576,8 +576,18 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		iomap_ops = &ext4_iomap_overwrite_ops;
 	ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
 			   dio_flags, NULL, 0);
-	if (ret == -ENOTBLK)
+	if (ret == -ENOTBLK) {
 		ret = 0;
+		/*
+		 * iomap can return -ENOTBLK if pagecache invalidation fails.
+		 * Let's make sure if -ENOTBLK is ever returned for atomic
+		 * writes than we fail the write request instead of fallback
+		 * to buffered-io.
+		 */
+		if (iocb->ki_flags & IOCB_ATOMIC)
+			ret = -EIO;
+	}
+
 	if (extend) {
 		/*
 		 * We always perform extending DIO write synchronously so by
--
2.46.0


