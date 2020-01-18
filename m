Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 948B014183B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2020 16:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbgARPFF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jan 2020 10:05:05 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40876 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729140AbgARPFE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jan 2020 10:05:04 -0500
Received: by mail-pl1-f196.google.com with SMTP id s21so11153273plr.7;
        Sat, 18 Jan 2020 07:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TYGs3SXJ2yDp3Yezgkj4US6oBtUd82pmodJxScDYIkU=;
        b=m4xGYsonPjj16AQ4A5vaIKz2QQIoTUGWqbQm5wsAci4gmh0ElEyfX3mph0rut/XwW3
         KiZIooOnUmFhlpk3OXTIQdyMXjZoKzNWU+v+51liPRHLRJU2P4Awiypa0J1dySJy1Ctp
         ZbkQCwqaBPvFeopwZ945ZbKThMmq0iKp66rbw8pL7BBKayWuegoFHIUvqhuiARcwZz/p
         jhKF06CWLkpM+4r4ROVfjiyyfyz0MpzB9c5z8p3hcJm3aEwTUvNRb6z2iSJ7nmKXpftI
         6dEsLHbQ/E+uolB11Jz4p8jySGeZDpbqvdPeJNM3KhD8B/YS1EP9P2Z5MAby093g6hYt
         1/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TYGs3SXJ2yDp3Yezgkj4US6oBtUd82pmodJxScDYIkU=;
        b=hfEk8fjPcOojCpnbh86IltJlYUw9BaIo4YojUUK2i2AVXU2gYP4mvcP2nD6BXbBoYQ
         UdXgbwYGGjHJcbl5LEREzjVquQQyQKc6Pp42nWOkySHCBPFuNjucwYrE9hdZw+3GXUVa
         TXfgg8mQDby3kIcryXWqfvesSPEe95qm/5RTKPmb/kxagpaXuq4BVpFmXRzu9BGsmX9f
         oXFLrq4mxE8sg3MVmhpBIEe3qHr3SYgtWj/qIrxynA+i+jfS3OY43yowYESDkGG1OB4y
         S4aVZudvU+O3DVagYMVEABpC9zHrzGBhl1qSTQiHyOU2180voZ/x28DlYI3fOv0muPgS
         RW7A==
X-Gm-Message-State: APjAAAWaOB1+PbG9pPtCpWAQXXaBsSpq6KA7pfGyhCm3Hqbkk1tNvP2E
        Dx/dqhwp5vo0sqI7TUKfQaUafFD2
X-Google-Smtp-Source: APXvYqw7vWmOoi7NBnSVjgvlK3AgwfUkLn3f1rgInfrGnJtbLCtLP1dUxkxAC4rfljYrD8jeIEc3mA==
X-Received: by 2002:a17:902:6a88:: with SMTP id n8mr5246756plk.265.1579359903327;
        Sat, 18 Jan 2020 07:05:03 -0800 (PST)
Received: from localhost.localdomain ([221.146.116.86])
        by smtp.gmail.com with ESMTPSA id v10sm32072078pgk.24.2020.01.18.07.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 07:05:02 -0800 (PST)
From:   Namjae Jeon <linkinjeon@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, pali.rohar@gmail.com, arnd@arndb.de,
        namjae.jeon@samsung.com, Namjae Jeon <linkinjeon@gmail.com>
Subject: [PATCH v11 14/14] staging: exfat: make staging/exfat and fs/exfat mutually exclusive
Date:   Sun, 19 Jan 2020 00:03:48 +0900
Message-Id: <20200118150348.9972-15-linkinjeon@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200118150348.9972-1-linkinjeon@gmail.com>
References: <20200118150348.9972-1-linkinjeon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Namjae Jeon <namjae.jeon@samsung.com>

Make staging/exfat and fs/exfat mutually exclusive to select the one
between two same filesystem.

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
Reviewed-by: Pali Rohár <pali.rohar@gmail.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/exfat/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/exfat/Kconfig b/drivers/staging/exfat/Kconfig
index 292a19dfcaf5..9a0fccec65d9 100644
--- a/drivers/staging/exfat/Kconfig
+++ b/drivers/staging/exfat/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 config STAGING_EXFAT_FS
 	tristate "exFAT fs support"
-	depends on BLOCK
+	depends on BLOCK && !EXFAT_FS
 	select NLS
 	help
 	  This adds support for the exFAT file system.
-- 
2.17.1

