Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5482FD6F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 18:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731317AbhATOIr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 09:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388457AbhATNDd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 08:03:33 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304D1C0613CF;
        Wed, 20 Jan 2021 05:02:51 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id o10so3254997wmc.1;
        Wed, 20 Jan 2021 05:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aZWXyCbP+U2boEa8uNybDlOvftZDrpKrYpE90tBdO/I=;
        b=NfTkZ7D2/tplLqXUW2cnYbIE3URW+SkN8m+yTQJ4ZGSL+AYfg3hNlocXoPfV5b2Jhu
         +ixXi6ZV5/XnLD7pIPYP8OHP9cINcTHBgEeRwUmW/Su7gxq1g1mUYGASMWz7C9zs4t6A
         y50i3lmSRGUcW04c3vPsr1lCP+85UXzzT9jmE360jaQg3hWMEN+NntHB5lEVWQDFmeWd
         05PieFO6nSf8h9OqFZJE4f0oe4wwY/a/6dTYkH9T5sLoIfguuDFs+ld/C8TREnpvs4V1
         TKfQU6JwkunadeGlB65yq9UZR02vZ/doEr6MEl4ueGO3fR1IPRWnpQM16XVaDKNZWcIA
         edAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aZWXyCbP+U2boEa8uNybDlOvftZDrpKrYpE90tBdO/I=;
        b=AQFtXNl5rfBx/So9lSG+abxlYZWmulAE2xQ4eVTNp5pg/kU7DJTsI3ep/DT/4vlupu
         ajsftfDsyvpOZi0LqpwsrjQivtf9Bu8JuRziNERu5FAR03lCfxTU46ssdkiTgQG/ifLV
         iwg4hmxdMw3fRwfVwWWOW+hEQnghtJbzQ6/4fgaoftIPKUf/b5UMF9HCDit/oc+CtF35
         1V4WXY/QiXLPDnHc84ZZrybPEKbR8lVmHHazMT6XgGrpd0jjWv4cWk3hKaOwE21LpJme
         mtESOWyMlAZlBQFMD6sTa5fLtCLH+VFSAASX1EGZTyNOFAck+zSXxhswxy+mqQy4mcdr
         jwNA==
X-Gm-Message-State: AOAM531xvaokxc9c9PoPkgC0evKlOmh9+7B1EdllJvku6CTWWgNuLJ60
        KrnozHQ2lWZJ7b9grwqgHcY=
X-Google-Smtp-Source: ABdhPJzmC7mqWGYQbuS7U2cZCI98+spNpj7nNT9OHLll9rJhgKCSZuk0YbuvOhoIj1W8MStOWoiV+Q==
X-Received: by 2002:a1c:1d09:: with SMTP id d9mr4229892wmd.125.1611147769957;
        Wed, 20 Jan 2021 05:02:49 -0800 (PST)
Received: from curtine-Aspire-A515-55.lan ([2001:818:e279:2100:6955:745:9baf:484e])
        by smtp.googlemail.com with ESMTPSA id m82sm4035221wmf.29.2021.01.20.05.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 05:02:49 -0800 (PST)
From:   Eric Curtin <ericcurtin17@gmail.com>
Cc:     ericcurtin17@gmail.com, Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list),
        linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and
        infrastructure))
Subject: [PATCH] Increase limit of max_user_watches from 1/25 to 1/16
Date:   Wed, 20 Jan 2021 13:02:31 +0000
Message-Id: <20210120130233.15932-1-ericcurtin17@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The current default value for  max_user_watches  is the 1/16 (6.25%) of
the available low memory, divided for the "watch" cost in bytes.

Tools like inotify-tools and visual studio code, seem to hit these
limits a little to easy.

Also amending the documentation, it referred to an old value for this.

Signed-off-by: Eric Curtin <ericcurtin17@gmail.com>
---
 Documentation/admin-guide/sysctl/fs.rst | 4 ++--
 fs/eventpoll.c                          | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/fs.rst b/Documentation/admin-guide/sysctl/fs.rst
index f48277a0a850..f7fe45e69c41 100644
--- a/Documentation/admin-guide/sysctl/fs.rst
+++ b/Documentation/admin-guide/sysctl/fs.rst
@@ -380,5 +380,5 @@ This configuration option sets the maximum number of "watches" that are
 allowed for each user.
 Each "watch" costs roughly 90 bytes on a 32bit kernel, and roughly 160 bytes
 on a 64bit one.
-The current default value for  max_user_watches  is the 1/32 of the available
-low memory, divided for the "watch" cost in bytes.
+The current default value for  max_user_watches  is the 1/16 (6.25%) of the
+available low memory, divided for the "watch" cost in bytes.
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index a829af074eb5..de9ef8f6d0b2 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2352,9 +2352,9 @@ static int __init eventpoll_init(void)
 
 	si_meminfo(&si);
 	/*
-	 * Allows top 4% of lomem to be allocated for epoll watches (per user).
+	 * Allows top 6.25% of lomem to be allocated for epoll watches (per user).
 	 */
-	max_user_watches = (((si.totalram - si.totalhigh) / 25) << PAGE_SHIFT) /
+	max_user_watches = (((si.totalram - si.totalhigh) / 16) << PAGE_SHIFT) /
 		EP_ITEM_COST;
 	BUG_ON(max_user_watches < 0);
 
-- 
2.25.1

