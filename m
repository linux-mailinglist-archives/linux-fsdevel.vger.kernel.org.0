Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5F04E809C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Mar 2022 12:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbiCZLmQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Mar 2022 07:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbiCZLmP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Mar 2022 07:42:15 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB134F476;
        Sat, 26 Mar 2022 04:40:38 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id b43so8801982ljr.10;
        Sat, 26 Mar 2022 04:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FMCXUD4zN8cbLx2oPee1gYgI6Vkubs2/OUjrvABtL2c=;
        b=RRQjx24ZJ+sPw0EsS4j2ufpttvcuSB2yfC+8tRvDJTNpiojfnfkLGEgveGVHRIjNTV
         sa1vjrow+35r1SevZpWaifxAYerZhfwt/vWQfA4H29iGFZqHB8BrZsxIVuJt2sVGe4E3
         iSFSVbKWcy/xc1z6NvuzyC0trCVzL0YLHez64adCxB57vpi75TlYSu/BvU3ldoYtISJm
         sgyHxOqnWOD06u9dXrUiqNAHk+R4ZE92URYJGVCQHI+cJjKyOOhzhoRgXFDfo5KOyaXY
         81q/RGFZYEULQWaJ7vb0AMZ+9LvH9WWjCFoLs6Iv4bBRyyPHXS7FjRaOk7N97n0y5QAr
         O1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FMCXUD4zN8cbLx2oPee1gYgI6Vkubs2/OUjrvABtL2c=;
        b=2kCuLTv4FQ7Ya0S6lSTsNWOmZ61IW9SVl3EX2vIR1HpX5eBODAIWZY7AXwgtFMnK97
         fZS+OsfRayO1WgvDB0Rm2FMIyqYSZY82AXCRpLweWKwngWUhidNlk3jGNlUaB5ieNs6C
         rSCWvFXhAiyjjCDyyHNda4Zitro8jDgg3qaCQkfZ626hyROrXG4AhhXcObBXb6vCNQ6L
         I5yRQW0ks4qTt/OQR7ygLOxLTvCPyo6uBZP3Lc20ivuuaasj3w2sdaBAPhOiwhkKJkWo
         uKcneVv4C9lKELlskwM96UPHj2p2oprjn4/lED2MWN/JUnZGU3vIPQ1zAoXSzrZCYVZU
         lZ2w==
X-Gm-Message-State: AOAM532AAqTGbAcP+XI2ILARLuAQxauvm3JyJGOsIEwy7ivuVc5rl0oP
        yzTkCD/QATolGpjZ/9FtlB8=
X-Google-Smtp-Source: ABdhPJx5E4HdGJ9e+XJC4t2MkkRqddhTZnzGjarstCoz0Pqv4OSoqk8vpIDnH4C2Es/0hM9Ljz/6AQ==
X-Received: by 2002:a05:651c:124a:b0:249:5eae:745e with SMTP id h10-20020a05651c124a00b002495eae745emr11733019ljh.296.1648294837194;
        Sat, 26 Mar 2022 04:40:37 -0700 (PDT)
Received: from localhost.localdomain (95-31-172-65.broadband.corbina.ru. [95.31.172.65])
        by smtp.gmail.com with ESMTPSA id l4-20020a2e9084000000b00244cb29e3e4sm1015213ljg.133.2022.03.26.04.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 04:40:34 -0700 (PDT)
From:   Fedor Pchelkin <aissur0002@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Fedor Pchelkin <aissur0002@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH 4/4] file: Fix file descriptor leak in copy_fd_bitmaps()
Date:   Sat, 26 Mar 2022 14:40:09 +0300
Message-Id: <20220326114009.1690-1-aissur0002@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If count argument in copy_fd_bitmaps() is not a multiple of
BITS_PER_BYTE, then one byte is lost and is not used in further
manipulations with cpy value in memcpy() and memset()
causing a leak. The leak was introduced with close_range() call
using CLOSE_RANGE_UNSHARE flag.

The patch suggests implementing an indicator (named add_byte)
of count being multiple of BITS_PER_BYTE and adding it to the
cpy value.

Found by Syzkaller (https://github.com/google/syzkaller).

Signed-off-by: Fedor Pchelkin <aissur0002@gmail.com>
Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 fs/file.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 3ef1479df203..3c64a6423604 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -56,10 +56,8 @@ static void copy_fd_bitmaps(struct fdtable *nfdt, struct fdtable *ofdt,
 {
 	unsigned int cpy, set;
 	unsigned int add_byte = 0;
-	
 	if (count % BITS_PER_BYTE != 0)
 		add_byte = 1;
-	
 	cpy = count / BITS_PER_BYTE + add_byte;
 	set = (nfdt->max_fds - count) / BITS_PER_BYTE;
 	memcpy(nfdt->open_fds, ofdt->open_fds, cpy);
-- 
2.25.1

