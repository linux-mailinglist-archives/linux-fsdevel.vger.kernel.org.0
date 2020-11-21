Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE152BBF58
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 14:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgKUN5p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Nov 2020 08:57:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727741AbgKUN5o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Nov 2020 08:57:44 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB66DC0613CF;
        Sat, 21 Nov 2020 05:57:43 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id j7so13832133wrp.3;
        Sat, 21 Nov 2020 05:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hkIhGHP8YvYo+Fe39wHlU1jbDv53qs8LMyCMcK/zpZY=;
        b=VaBp/PLmuipBixL0nMuXp6MaXGOZSp43PZb/H349yWjQZbL8XgahpAKmvYSVtUba2K
         D94skssyBZrM3brTxpClvUnnYd55Xcs/DWqfm7uxaU5xscH5z/im4Rpf5Vo3C8OOi0LO
         RK2F7CcSvsxyFVCxJ0ZHYXTSmrCvENyfjs1dp+srb0+PNLeCNlGAEtga/jvq4PE2sFtJ
         f2Xv15CzfLKlizH75s7Mbo9lGdzMeDStHHrfv6NeoY4XSTKxLn8Cgr6opToqCueWKPbt
         EEr13/NldYV2iMxGshbX0FiQ4ddXMSUNFTUfuqAFderusNDI/beXx13TH0vVAFA+EXBF
         HxRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hkIhGHP8YvYo+Fe39wHlU1jbDv53qs8LMyCMcK/zpZY=;
        b=p6YBVWvUnrASZp0VExqbjBozqeqYcWnbzcYkaUkj9+vka3HD0Cibo/U1uOUOdc+U14
         kotVa4HHMDy7glZF3KmzBP1/7Fuw4rKkz7c38y/Y7vOyXM/AwYBpxF8cHkNTQMDa3ymE
         prro12ktBCJAk9sfXbVyjCpDXkhKoWi6mjR5HSATrQNaStUk0hf2uCSWOcKEmST1/9Uw
         C1c1FkSJxynvbgYnc5QeoUVo16svYJ/z20KXzXgHAif/rNJy5sm/HPb2jZ7a8z4oQJNE
         hEwniWjFAmNwHDggHf3kf0NjipNg642EGCCR6Nd3Gn3JRfuZbMKpoo6Tilyu0YLHySo8
         sYEQ==
X-Gm-Message-State: AOAM533LOwlJePlMeMPr7wvoP0bgbOge6ztCf2lMXD7f4bw1zVHB4crU
        Js5m2O3Eg+Aa7+JISQE2D2g=
X-Google-Smtp-Source: ABdhPJwmkpTRUbrB2W5NzI3x6cse1Q2KjRmZodLmHqIkyT6kUobzrzy8+QO4GAH4PsQV7LyCsl7HEw==
X-Received: by 2002:adf:fe46:: with SMTP id m6mr22982503wrs.254.1605967061833;
        Sat, 21 Nov 2020 05:57:41 -0800 (PST)
Received: from localhost.localdomain ([170.253.49.0])
        by smtp.googlemail.com with ESMTPSA id 17sm41689951wma.3.2020.11.21.05.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 05:57:41 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] fs/anon_inodes.c: Use "%s" + __func__ instead of hardcoding function name
Date:   Sat, 21 Nov 2020 14:57:33 +0100
Message-Id: <20201121135736.295705-2-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201121135736.295705-1-alx.manpages@gmail.com>
References: <20201121135736.295705-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---
 fs/anon_inodes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
index 89714308c25b..7609d208bb53 100644
--- a/fs/anon_inodes.c
+++ b/fs/anon_inodes.c
@@ -152,11 +152,11 @@ static int __init anon_inode_init(void)
 {
 	anon_inode_mnt = kern_mount(&anon_inode_fs_type);
 	if (IS_ERR(anon_inode_mnt))
-		panic("anon_inode_init() kernel mount failed (%ld)\n", PTR_ERR(anon_inode_mnt));
+		panic("%s() kernel mount failed (%ld)\n", __func__, PTR_ERR(anon_inode_mnt));
 
 	anon_inode_inode = alloc_anon_inode(anon_inode_mnt->mnt_sb);
 	if (IS_ERR(anon_inode_inode))
-		panic("anon_inode_init() inode allocation failed (%ld)\n", PTR_ERR(anon_inode_inode));
+		panic("%s() inode allocation failed (%ld)\n", __func__, PTR_ERR(anon_inode_inode));
 
 	return 0;
 }
-- 
2.28.0

