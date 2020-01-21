Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9BF7143D7E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2020 13:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbgAUM6c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jan 2020 07:58:32 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44821 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbgAUM6a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jan 2020 07:58:30 -0500
Received: by mail-pg1-f196.google.com with SMTP id x7so1430664pgl.11;
        Tue, 21 Jan 2020 04:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=riQeoCpIjGKHvSbMIa1Ue7ypVDo9yukWYqavka5JSLY=;
        b=l6hgVgrSsGoG9H77LMGWrav12mfQfmVUoyA8wcQ2jB46XgAnvV04Jemqlh1Cmk4lDn
         2IAGntMOhyUKJ961oVjo0HSS6Y/39AYD3Iuv27z53dQR0+wWCk5RQmtsStZBojvj6eJ5
         XiqiOIOYwFnLwoKD1tatHsZ1wZoFxx3UVgaEU2pKBpd/S7ErLyoIj1y8UGt6RC6jA+iI
         PYOUPbVTSywRrdmXn939sJpUDnADaUxp8QjZohbTVuI8EgIhfEPyeh2wOgYpKI04ob7r
         eSqs1mOwdE1xvWd8ZfRSUmrPZG7alEomnJy1jPozq7o1qKx4NO7OsMLg031Ljp8tsrSe
         yg7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=riQeoCpIjGKHvSbMIa1Ue7ypVDo9yukWYqavka5JSLY=;
        b=QnG5eQRDqYOzXaOymmM40dja2mwX1fupUI9FjtjqXPyF2yEmMtTY+iKpdK74w0DBHv
         ucqP+e4XuhfN6WUEQ+GW31V2WX/zquIsD2uZnkzjHt4w328su/qYvFS5TbVwEZ8L7koZ
         CvHxHeo2oJc3So+e/sskR0pXsurQXuEIshVZTy/T+l+kZ0hMB+dW37Knm9IQYJ5lxVRX
         jDCiZzAI9z9w14g/Mi8Fyms6KmQoKfacRBa5Ib3Rho/2jW51bVk3ZMhqCHBHfx1/UBeC
         PdjZLhnnRM7FsBLjkQOfJ/rJSQ5Jb/ir/Fi3S+gQYr5o9cghZ8XgZ6NYmtc5j+eMK4Ru
         kYXg==
X-Gm-Message-State: APjAAAUONYVBLcw23TZcgdLneVPQR51/hmz5gEO6b0pMz/77YiEtiEiv
        bOfoJGSyGPgDQOcBupCBQ1ndnF4V
X-Google-Smtp-Source: APXvYqzF9b3tt3QWm2AbHIOJSfkoQWBiFOr1khoVFKHMh5FnVS3dSphUwdWa1ztHgUYdxRtK0R5zSw==
X-Received: by 2002:a63:d108:: with SMTP id k8mr5190543pgg.434.1579611509844;
        Tue, 21 Jan 2020 04:58:29 -0800 (PST)
Received: from localhost.localdomain ([221.146.116.86])
        by smtp.gmail.com with ESMTPSA id v4sm43130132pfn.181.2020.01.21.04.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 04:58:29 -0800 (PST)
From:   Namjae Jeon <linkinjeon@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, pali.rohar@gmail.com, arnd@arndb.de,
        namjae.jeon@samsung.com, viro@zeniv.linux.org.uk,
        Namjae Jeon <linkinjeon@gmail.com>
Subject: [PATCH v13 13/13] staging: exfat: make staging/exfat and fs/exfat mutually exclusive
Date:   Tue, 21 Jan 2020 21:57:27 +0900
Message-Id: <20200121125727.24260-14-linkinjeon@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200121125727.24260-1-linkinjeon@gmail.com>
References: <20200121125727.24260-1-linkinjeon@gmail.com>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
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

