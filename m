Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8301E11EA6D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 19:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbfLMSgk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Dec 2019 13:36:40 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:33963 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728712AbfLMSgj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Dec 2019 13:36:39 -0500
Received: by mail-io1-f66.google.com with SMTP id z193so447188iof.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2019 10:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0OvI2ceVnasRg1nbXww4p2Pl+uJhucmp3XBabX0dc/U=;
        b=BhxUsLDv0gMu5lRpN7mqlDEYuRP6HHUeW014jbkTw+9flF2Nkn42TQSrufK7bAT+iV
         Wvduseg54kaBV3k57O65NCM0EpC3T4i2/JY9cx1FRxIg/JEtcwYbxIf1T01DXjZnC7Sj
         KheFWP+/pACrV2IraDGgbby5HoR5MIwYw5B02b8e7YwV2trnX2pHorD8oL1Bn83KNCLA
         Jvysyed2cJbpnxdNAZ/We/LGER2JRjX6A4fLv14ygW+BMYouIyseNWedE9nbBjroNqWx
         P6hjS/kpiZU6DO/FbRybmIqvSLBRwOwJVgBGWi8zRfDCSeYbITxerUUiCWDTVzUzGRey
         2W7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0OvI2ceVnasRg1nbXww4p2Pl+uJhucmp3XBabX0dc/U=;
        b=qTXzTRLM0MK/7rd35JOY9y7F5L4K2ikGRqPfEwNGV2c0DUoAYO9jEuRdYv7pSWVn5v
         VKJG01CstqQi02xtS2zxaZ7suWchwBX5dmL0psUmnoTrOLOjidmBfJnJTI9wrhB687Hk
         VnWMx+F0WwtUEYW3wq8hTtnlJwInMSHxNF5BaaD7SViEPpF5V/YIb2sT+5P641oK6YgD
         HwAaVYM5t4N9kKk4RKrx7Xsw1dn3bRo+FaprYZkdNFLq41DdVmavyHLZrjjfIUEENoXY
         HliZBmyt116sfzKUe59JFMM98n9UM91Koc8vfYxkCK7uUcLN9yxkdnxYTtQ9m0SzGfSF
         PDYw==
X-Gm-Message-State: APjAAAUKpGqdBxBqd3fBWOp1W/5zPkO3amyz28CxSq31xioexCFbBrJl
        m3ddpVtNmGibnvDIIj7HmJnhELkTB7325w==
X-Google-Smtp-Source: APXvYqxdntotcojq17jJOTxQjqVcqJ/GaUQgZ6euUZiAGzOTLLij3FJzE/gCyBcXZOROXYxo6OLPMQ==
X-Received: by 2002:a6b:3b49:: with SMTP id i70mr336659ioa.106.1576262199176;
        Fri, 13 Dec 2019 10:36:39 -0800 (PST)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w24sm2932031ilk.4.2019.12.13.10.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 10:36:38 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 03/10] fs: add namei support for doing a non-blocking path lookup
Date:   Fri, 13 Dec 2019 11:36:25 -0700
Message-Id: <20191213183632.19441-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191213183632.19441-1-axboe@kernel.dk>
References: <20191213183632.19441-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If the fast lookup fails, then return -EAGAIN to have the caller retry
the path lookup. This is in preparation for supporting non-blocking
open.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/namei.c            | 2 ++
 include/linux/namei.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index 2dda552bcf7a..50899721f699 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1801,6 +1801,8 @@ static int walk_component(struct nameidata *nd, int flags)
 	if (unlikely(err <= 0)) {
 		if (err < 0)
 			return err;
+		if (nd->flags & LOOKUP_NONBLOCK)
+			return -EAGAIN;
 		path.dentry = lookup_slow(&nd->last, nd->path.dentry,
 					  nd->flags);
 		if (IS_ERR(path.dentry))
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 397a08ade6a2..a50ad21e3457 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -38,6 +38,7 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT, LAST_BIND};
 #define LOOKUP_JUMPED		0x1000
 #define LOOKUP_ROOT		0x2000
 #define LOOKUP_ROOT_GRABBED	0x0008
+#define LOOKUP_NONBLOCK		0x10000	/* don't block for lookup */
 
 extern int path_pts(struct path *path);
 
-- 
2.24.1

