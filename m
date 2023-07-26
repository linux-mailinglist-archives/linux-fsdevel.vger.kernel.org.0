Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA5B763884
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 16:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbjGZOIx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 10:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234396AbjGZOH4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:07:56 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3D42727
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 07:07:16 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230726140714euoutp02ab2a4f5c09105826d68213726ffe6eee~1cAyymBL_1608116081euoutp02U
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 14:07:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230726140714euoutp02ab2a4f5c09105826d68213726ffe6eee~1cAyymBL_1608116081euoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690380435;
        bh=y+3JcMDmwcBxmDJnO96kGfYESZ6WRSROP/M0qnZiaW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bn8TlKhaPm+ZoNVd1/sk8+To5fFDMyF8NWplF1EFtK0Ja4bYvIxtB9ek8mo548IZg
         qVrJ7TTRD0zEHi3nbJSRzRD6Z/UHSz/l6jmklfsW8lch+iL5j9gSe6xuqoPkxOaaOF
         n/QKCdN/Wc2bHqQAFpAaP7SRnOSQoz37IyoyIiZE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230726140714eucas1p17067e35c5306c93c315855e164a426f4~1cAyiQPQ62256722567eucas1p1_;
        Wed, 26 Jul 2023 14:07:14 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 3D.76.42423.29821C46; Wed, 26
        Jul 2023 15:07:14 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230726140714eucas1p186bad44daf14c4c8c93f9aaf52deade5~1cAyRGU8u2041620416eucas1p1-;
        Wed, 26 Jul 2023 14:07:14 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230726140714eusmtrp17d12f7d118f120e8c898b69e46e1046a~1cAyQjihf2411224112eusmtrp1b;
        Wed, 26 Jul 2023 14:07:14 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-b0-64c12892eb80
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B3.67.14344.29821C46; Wed, 26
        Jul 2023 15:07:14 +0100 (BST)
Received: from localhost (unknown [106.210.248.223]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230726140714eusmtip1e2ad697c5d7344b8bd32e0d7e06a4b6a~1cAyDjtKe0954609546eusmtip1X;
        Wed, 26 Jul 2023 14:07:14 +0000 (GMT)
From:   Joel Granados <j.granados@samsung.com>
To:     mcgrof@kernel.org, Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Cc:     willy@infradead.org, josh@joshtriplett.org,
        Joel Granados <j.granados@samsung.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 14/14] sysctl: Use size as stopping criteria for list macro
Date:   Wed, 26 Jul 2023 16:06:34 +0200
Message-Id: <20230726140635.2059334-15-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230726140635.2059334-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SeUxScRzvx3vAk0Jf5OI7ZGkGyy6PYg3zbNZGp3bNDlsxeKkT0fGkzNWy
        u6y8Ukm0zRVZis6NLirNIsvMssyWrexaWh65NDNsNk18tPrvc32v7UtgAiNbRMRrUyidVqnx
        5vDwaw9+Nc3L9bmr9s+wSuUXaj8i+WhJkvzxiUR5dU0DLm+5WcyRv8ruQPLhoTFUemN1OKEo
        Sm/GFSUWveLypdmK1z0hCkv5cY4i80o5UgxYpkVxN/OC1ZQmfiel8wvdzosr/tXATTbwUofe
        ytLRPSIDuRBAyiCnfwTPQDxCQF5CMGCzOMkPBE967iCGDCB4N2LG/pZU3bJjjHERwYu6g07S
        haDzUyfXkeKQc+Hp17YxgyDcya1wPk/tkDHSgMBULHbgKeQKyDE1IgfGSSmMfrSxHZhPhoLN
        XsBmhnnCkVbDeMZlTC+rtDszk6GhsB1nenrCwatF4zsA+ZCAB1kVOFO8BN6brjobTYHu+itc
        Bouh8fRJnCk4jaB2pI/LEDOC0v2DLCYVBIdetHMdF2DkLKi66cfIi6Em6xbukIF0hVe9k5kl
        XCH3mgFjZD4cOyJg0hLIvJDnXEcErS03OAxWQNHvVnY2mm787xzjf+cY/80tQVg5ElJ6OjGW
        ogO01C5fWplI67WxvqqkRAsae5/GkfrvVnS2u9/XhlgEsiEgMG93fkDMbbWAr1buTqN0Sdt0
        eg1F25AHgXsL+XNCGlQCMlaZQiVQVDKl++uyCBdROmtroXvWl+uR+Su9ot08xcurC18fmBgt
        kfp49MlExJYlh1XrZrlZzxXNaA18TFSE/az4bNqr32BUqpKW1S7fIQl/FLZ44caIVaW3O7u8
        Bg2xK4vJfeKXEwc3RT17meI5v/7YF4tYz65r7gwsXaQNCmtsar7PEvoHPcyXtuW6RkzgfuYI
        Zf0JEbLVe98cTZiZqhL09MYJy4fz3Gdopg1WVvKj3mAc29Nv6+2mR8Lz8+oyaxa0e/Unl53c
        kB1T0vREMnUSK2OPNLIvMvBDm7nDai7DhGfMwSELfdbUT3juf/lUgZ3fEVoYTvfSqTnB7KC1
        1pqKsqV+IuMhTdomr17ViqmSU944HacMmI3paOUfVApnra0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42I5/e/4Xd1JGgdTDC4dE7JYuv8ho8X/BfkW
        Z7pzLfbsPclicXnXHDaLGxOeMlr8/gFkLdvp58DhMbvhIovHgk2lHptXaHncem3rsWlVJ5tH
        35ZVjB6fN8kFsEfp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSW
        pRbp2yXoZcz5eZK9YDpXxY+7Jg2Mhzm6GDk5JARMJNbv/s7cxcjFISSwlFGif9pTxi5GDqCE
        lMT3ZZwQNcISf651sYHYQgLPGSXeTgoHsdkEdCTOv7nDDGKLCMRLzHx8nwlkDrPAbEaJ1ScP
        gSWEBbwlJi45zQhiswioSvx/eIgVxOYVsJM49H0aK8QCeYm269PBajiB4ivXfmeFWGYr0TP1
        KTtEvaDEyZlPWEBsZqD65q2zmScwCsxCkpqFJLWAkWkVo0hqaXFuem6xkV5xYm5xaV66XnJ+
        7iZGYIxsO/Zzyw7Gla8+6h1iZOJgPMQowcGsJMJrGLMvRYg3JbGyKrUoP76oNCe1+BCjKdDd
        E5mlRJPzgVGaVxJvaGZgamhiZmlgamlmrCTO61nQkSgkkJ5YkpqdmlqQWgTTx8TBKdXApPLf
        3Y2/eP/HU/cXP9S1Nvfi0IpX8unedeKzNXfFgmMXA7TDpWfPS+WRuMbgdd3swrrTKTKxRzVv
        bZp6dX5X5tnnvVP8TIwu3VCZ84JtxSmJlYs5z0T/eJxkeZW75/2DsJjGp+//3TgRsdztdFvb
        7u8s+9x1ghm/F6w8/1fntRvvghqWe0VLmM1mx8dkrG7OtHM36AnvS51tbLXx6DEDr/s71E5l
        /Sl0C65csTuzcPFN7SMrPux6d2TBiwMKTHeuWj9dXajq/qx9iY74wh3bputULJO66MCX5ni5
        6C+HrcU2jpO77hd8c8pS7Pf36Wdr3Lxpcah/hpaUjd6J0vmrlN+4GTn7inl+7r3gslx3qhJL
        cUaioRZzUXEiAEYQkfAaAwAA
X-CMS-MailID: 20230726140714eucas1p186bad44daf14c4c8c93f9aaf52deade5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230726140714eucas1p186bad44daf14c4c8c93f9aaf52deade5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230726140714eucas1p186bad44daf14c4c8c93f9aaf52deade5
References: <20230726140635.2059334-1-j.granados@samsung.com>
        <CGME20230726140714eucas1p186bad44daf14c4c8c93f9aaf52deade5@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add header->ctl_table_size as an additional stopping criteria for the
list_for_each_table_entry macro. In this way it will execute until it
finds an "empty" ->procname or until the size runs out. Therefore if a
ctl_table array with a sentinel is passed its size will be too big (by
one element) but it will stop on the sentinel. On the other hand, if the
ctl_table array without a sentinel is passed its size will be just write
and there will be no need for a sentinel.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 fs/proc/proc_sysctl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 6c0721cd35f3..3eea34d98d54 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -19,8 +19,9 @@
 #include <linux/kmemleak.h>
 #include "internal.h"
 
-#define list_for_each_table_entry(entry, header) \
-	for ((entry) = (header->ctl_table); (entry)->procname; (entry)++)
+#define list_for_each_table_entry(entry, header)	\
+	entry = header->ctl_table;			\
+	for (size_t i = 0 ; i < header->ctl_table_size && entry->procname; ++i, entry++)
 
 static const struct dentry_operations proc_sys_dentry_operations;
 static const struct file_operations proc_sys_file_operations;
-- 
2.30.2

