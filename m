Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C9345D9F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Nov 2021 13:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349788AbhKYM0t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Nov 2021 07:26:49 -0500
Received: from mail-pg1-f180.google.com ([209.85.215.180]:45875 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349714AbhKYMYt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Nov 2021 07:24:49 -0500
Received: by mail-pg1-f180.google.com with SMTP id h63so5065506pgc.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Nov 2021 04:21:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ThdZv00Zr8gQoS8DnE92TjoljFWdGSx6haj/8BBLCuk=;
        b=J/Nv+pnfRlyEpGcqAFzPKFt5OlJsa/I3DyxfMmiVmNoj8QXPkNBmZZ6YmHHUWAg4bt
         SBZ1RrubAgAxrhgZiRHbiR8zY17Yq9m4L5k0pVhpP4dvoxJckWLzTUd3eWOBRQBQUZXt
         7MXzP4cLCbodVrGzabH2NkHuSKYDEOw51lkP96dq5KP/UEITW3sCDMOMC+qqZ7X/Y+ji
         79JhiYUTc8r0FhfUnP2WHGgX4cOhdJXFAGQVwk6cVQUyR1EM9x8VPeQnL4HGZmPJG/Tn
         5ozN5Itb4PqZ5eIJIv4T3swqrFZW68HjBbHspWKOR9IypLHi6fgO5v6mvNYU583jUP2i
         932w==
X-Gm-Message-State: AOAM533fryq8hf72ij4/tHe5igPgp8cSnPf/DpwoKKvghwL2qYLk+DwH
        megGfrIZE3xWOpOTRKZK6PTYyyBorEw=
X-Google-Smtp-Source: ABdhPJz/reuJ8Tga2DLrc+MSenp6t1A/nDU39/4VOOsiV2KG8MwPSDa+iEKS/cERevI42ItetPy3KA==
X-Received: by 2002:aa7:9ddb:0:b0:4a4:f597:a4ca with SMTP id g27-20020aa79ddb000000b004a4f597a4camr13352134pfq.57.1637842896974;
        Thu, 25 Nov 2021 04:21:36 -0800 (PST)
Received: from localhost.localdomain ([61.74.27.164])
        by smtp.gmail.com with ESMTPSA id oa2sm8454859pjb.53.2021.11.25.04.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 04:21:36 -0800 (PST)
From:   Namjae Jeon <linkinjeon@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     sj1557.seo@samsung.com, Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH] exfat: move super block magic number to magic.h
Date:   Thu, 25 Nov 2021 21:21:25 +0900
Message-Id: <20211125122125.6564-1-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move exfat superblock magic number from local definition to magic.h. 
It is also needed by userspace programs that call fstatfs().

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/exfat/exfat_fs.h        | 1 -
 fs/exfat/super.c           | 1 +
 include/uapi/linux/magic.h | 1 +
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index a8f5bc536dcf..9665fa0b2d56 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -10,7 +10,6 @@
 #include <linux/ratelimit.h>
 #include <linux/nls.h>
 
-#define EXFAT_SUPER_MAGIC       0x2011BAB0UL
 #define EXFAT_ROOT_INO		1
 
 #define EXFAT_CLUSTERS_UNTRACKED (~0u)
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 4b5d02b1df58..8c9fb7dcec16 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -17,6 +17,7 @@
 #include <linux/iversion.h>
 #include <linux/nls.h>
 #include <linux/buffer_head.h>
+#include <linux/magic.h>
 
 #include "exfat_raw.h"
 #include "exfat_fs.h"
diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index 35687dcb1a42..8ab81ea13424 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -43,6 +43,7 @@
 #define MINIX3_SUPER_MAGIC	0x4d5a		/* minix v3 fs, 60 char names */
 
 #define MSDOS_SUPER_MAGIC	0x4d44		/* MD */
+#define EXFAT_SUPER_MAGIC	0x2011BAB0
 #define NCP_SUPER_MAGIC		0x564c		/* Guess, what 0x564c is :-) */
 #define NFS_SUPER_MAGIC		0x6969
 #define OCFS2_SUPER_MAGIC	0x7461636f
-- 
2.17.1

