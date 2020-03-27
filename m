Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDB20195C0E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Mar 2020 18:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbgC0RKq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Mar 2020 13:10:46 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37945 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgC0RKq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Mar 2020 13:10:46 -0400
Received: by mail-ot1-f68.google.com with SMTP id t28so10488883ott.5;
        Fri, 27 Mar 2020 10:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Uz+T/mHoGv3NzPZQFttOck1KCbWaKiOsJFWw1oiNn4=;
        b=AmJeA7jHA5gU1mKTHQX7pKpNnvlXEZEWSPxy9vjKsSruz9wmAUIYQBAmmZBIfHhlbL
         pGFqCe7zQXkI4e8XDoB1LDgyktHCwn/pSjdj5k4U3z6raJBvjyQFT8EyfqJaMrxVtiJM
         gf5eRVi+XHrebrt0R97V0WIlMEMBv7yi3oS/8AEgk1kI7F41UNjfn4udzeLgWI3NJFid
         rZsGJBdDbpbh7RAKXZiChOVNL6yOSVyI9WRfZNy08dd1QE32PCsjKANvtykGN8+io9l5
         91HnyKTI+zv414zN247LX8LkHlQU+ja91QQ/3Iqj3Ju8+gAsQZBGo55yaB/lnRpTQX6x
         QA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Uz+T/mHoGv3NzPZQFttOck1KCbWaKiOsJFWw1oiNn4=;
        b=nbaCJRM0eKb3T4Ky8ZL9rFyLBlpjOdP6Itm2YxNaMZx02TBATfB+tabSNpkxLZ7MRi
         WpJoQ12+ad52BB1KjW4kCVBjwzwc9Fcn7tEYitAI9rD7rV/JW2d/BJuRyFmFwwnmpSYB
         JAOxEI71jUrdosEVoT7eH+cBB45xod6MSxO8cDKkc/gvf5RjQbtA/jRyLJWfyRtQhbQC
         L9IoVufF9VuLPWCfPqD8Ewc3B+8o+VlETzemzMBINwPJOOzkqmVNM/ijTxEj24iZ6Olm
         fM6dT5qcyGmd4VaTw9lf7TcU3Ycw7u8VrdZGA76XTzw3xNOhY/r3LC2JjJDCWNjYi4wN
         snpA==
X-Gm-Message-State: ANhLgQ3DYuHFt1y2Bv43X+r6hWgeMx/oeLuvcTbjfPOKRKR8NcMjqu0S
        KlIKGq6gV8IS/E/DLDsevto=
X-Google-Smtp-Source: ADFU+vsLgQwi/EEDtILnJFOfKJw+bzvHFICjlavWiG8jn6HpSdq8ljMRCa2YJ3Kd37rI7/XmNhx1Lg==
X-Received: by 2002:a9d:6857:: with SMTP id c23mr11129155oto.224.1585329045188;
        Fri, 27 Mar 2020 10:10:45 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id l188sm1967881oib.44.2020.03.27.10.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 10:10:44 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH -next] fanotify: Fix the checks in fanotify_fsid_equal
Date:   Fri, 27 Mar 2020 10:10:30 -0700
Message-Id: <20200327171030.30625-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Clang warns:

fs/notify/fanotify/fanotify.c:28:23: warning: self-comparison always
evaluates to true [-Wtautological-compare]
        return fsid1->val[0] == fsid1->val[0] && fsid2->val[1] == fsid2->val[1];
                             ^
fs/notify/fanotify/fanotify.c:28:57: warning: self-comparison always
evaluates to true [-Wtautological-compare]
        return fsid1->val[0] == fsid1->val[0] && fsid2->val[1] == fsid2->val[1];
                                                               ^
2 warnings generated.

The intention was clearly to compare val[0] and val[1] in the two
different fsid structs. Fix it otherwise this function always returns
true.

Fixes: afc894c784c8 ("fanotify: Store fanotify handles differently")
Link: https://github.com/ClangBuiltLinux/linux/issues/952
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 fs/notify/fanotify/fanotify.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 7a889da1ee12..cb54ecdb3fb9 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -25,7 +25,7 @@ static bool fanotify_path_equal(struct path *p1, struct path *p2)
 static inline bool fanotify_fsid_equal(__kernel_fsid_t *fsid1,
 				       __kernel_fsid_t *fsid2)
 {
-	return fsid1->val[0] == fsid1->val[0] && fsid2->val[1] == fsid2->val[1];
+	return fsid1->val[0] == fsid2->val[0] && fsid1->val[1] == fsid2->val[1];
 }
 
 static bool fanotify_fh_equal(struct fanotify_fh *fh1,
-- 
2.26.0

