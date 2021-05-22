Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB0C38D5A7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 May 2021 13:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbhEVLdr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 May 2021 07:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbhEVLdq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 May 2021 07:33:46 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8E4C06138A;
        Sat, 22 May 2021 04:32:20 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id t193so16334491pgb.4;
        Sat, 22 May 2021 04:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5T431k7g6aKVzK1xUunLmmQKi2pgkqZ8L8xtmvs/QnA=;
        b=IZXyTd5+cs+5qO8U6EN1jdhr0gtYjocvlXO/go7CdYldnEukWdFqw4ALo+FTzrdEqQ
         HZkoFtoMVcP2X6U+T84nPphlp68QKN2k9UzMpzR3rnCw1HGUe/JjoSrk42nUJ7iG5k+Q
         rqL0LpamXTcCvIMautmzhYcokYUaMCxiYZ1rw4q64+YuULAnLkSgz003k3ICXnJIRNuv
         CNhaiJuK/cl9sWyuimfoSP/IvXJ6NuIbM9JsjGc8HgWgPWIE8neWIkCqNSlvACsbhc69
         wrfC8llEUshGoSguVwjTT3aNyOmvqfdrywHx+3b6FzKsxxgdBXWyNGJIHMtLojlsILTA
         WjNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5T431k7g6aKVzK1xUunLmmQKi2pgkqZ8L8xtmvs/QnA=;
        b=hUek9Mv+6FhVWKjtYGDj9Q7TKk344oWlq4schxVlSI48g2dy8E9DlmB6Vr3s+35+Rj
         G6RAdRvqaQA6w37QL2+1c9u/kL6i1RCp7KHdZytWN3K8X52of6G3iW5xsXRms8UXpN+S
         /PyX+aPgJvih9aTeH4EeuqC4vq46yXvbcPzk25m4jWB8RULG/ICneN+lNFFlOHWXv6Gg
         fOzc/SnrZX9KWEQX5pfN6w9xtvCrPxL/Hcd3s9NPn6WKjUO2HlWrMuYF8A6QVLIW7SjR
         q+iS/zj9x6/poygnNi/DD64r3fD0nMzlq5UWdiEcq4gAjwhA/gf8BdC4jOMV+ZJjjqMl
         UO1Q==
X-Gm-Message-State: AOAM531aT0jTaIt22+9u1nrt0pRW00O15KggskM1dG5u5mVEXqxLat7N
        GvNsWD31JkJdorwwQSU85zQ=
X-Google-Smtp-Source: ABdhPJzZKlpUn6eKHq2iT2D3CBaTxC2s5pKPQsBZn6C70PdkfDyf3u+qA0Iqg/5ZpwNydco4Sw2Wng==
X-Received: by 2002:a65:5684:: with SMTP id v4mr3607064pgs.218.1621683140113;
        Sat, 22 May 2021 04:32:20 -0700 (PDT)
Received: from localhost ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id w123sm6284875pfw.151.2021.05.22.04.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 04:32:19 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: dong.menglong@zte.com.cn
To:     mcgrof@kernel.org
Cc:     viro@zeniv.linux.org.uk, keescook@chromium.org,
        samitolvanen@google.com, johan@kernel.org, ojeda@kernel.org,
        jeyu@kernel.org, joe@perches.com, dong.menglong@zte.com.cn,
        masahiroy@kernel.org, jack@suse.cz, axboe@kernel.dk, hare@suse.de,
        gregkh@linuxfoundation.org, tj@kernel.org, song@kernel.org,
        neilb@suse.de, akpm@linux-foundation.org, brho@google.com,
        f.fainelli@gmail.com, wangkefeng.wang@huawei.com, arnd@arndb.de,
        linux@rasmusvillemoes.dk, mhiramat@kernel.org, rostedt@goodmis.org,
        vbabka@suse.cz, glider@google.com, pmladek@suse.com,
        ebiederm@xmission.com, jojing64@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] init/main.c: introduce function ramdisk_exec_exist()
Date:   Sat, 22 May 2021 19:31:53 +0800
Message-Id: <20210522113155.244796-2-dong.menglong@zte.com.cn>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210522113155.244796-1-dong.menglong@zte.com.cn>
References: <20210522113155.244796-1-dong.menglong@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Menglong Dong <dong.menglong@zte.com.cn>

Introduce the function ramdisk_exec_exist, which is used to check
the exist of 'ramdisk_execute_command'.

It can do absolute path and relative path check. For relative path,
it will ignore '/' and '.' in the start of
'ramdisk_execute_command'.

Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>
---
 init/main.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/init/main.c b/init/main.c
index eb01e121d2f1..95cab17046e0 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1522,6 +1522,21 @@ void __init console_on_rootfs(void)
 	fput(file);
 }
 
+bool __init ramdisk_exec_exist(bool absolute)
+{
+	char *tmp_command = ramdisk_execute_command;
+
+	if (!tmp_command)
+		return false;
+
+	if (!absolute) {
+		while (*tmp_command == '/' || *tmp_command == '.')
+			tmp_command++;
+	}
+
+	return init_eaccess(tmp_command) == 0;
+}
+
 static noinline void __init kernel_init_freeable(void)
 {
 	/*
@@ -1568,7 +1583,7 @@ static noinline void __init kernel_init_freeable(void)
 	 * check if there is an early userspace init.  If yes, let it do all
 	 * the work
 	 */
-	if (init_eaccess(ramdisk_execute_command) != 0) {
+	if (!ramdisk_exec_exist(true)) {
 		ramdisk_execute_command = NULL;
 		prepare_namespace();
 	}
-- 
2.31.1

