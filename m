Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABF3A1AFDBA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Apr 2020 21:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgDSTpn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Apr 2020 15:45:43 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:33992 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgDSTpn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Apr 2020 15:45:43 -0400
Received: by mail-pj1-f67.google.com with SMTP id q16so3964021pje.1;
        Sun, 19 Apr 2020 12:45:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M3p9eZkDL4rEHA+mf+DziMPxePr/ZoUmDl5szec5+p8=;
        b=kR7P3BpAumPQtEMpAMmv0uihs24LdWxJtNtJ2omS7Ox0qs9r5J2qp9RrtvD88kWJY1
         ij8zHez55DsUUyQZWftPGU1YUdc8en78zP8XOvjclDo1rvYNdRXFKnc3RyI71JVcWsiJ
         bCieHoiHNVERbif90e3YALOBbdp+lt2cRnllLMiELsK2jfJEQk+2+WFWS5FIGgad9vN7
         Yq3Yj5/Cz80aSvUyHNUvKv8styN7QUgVcUuRotby0/HidFwnpisc8UtwedwlcYPJPr9d
         aUp3+zepgDIPzVZ+iHZRafmCRC+9gDXhAWr1fuwzWFR+EtKXxZeSmzAOHOa2IfggiSI+
         Ir3A==
X-Gm-Message-State: AGi0PuaJXAlcfUFCX6nxyLaZHUjg6T9zn9mmnYE2mo9fNogCLeaokZ1Y
        EVtbjyw4CmdDM1+UtiB5UDE=
X-Google-Smtp-Source: APiQypKEQ+ZAqACW0RZLGTrbfImbk5QqwTv9Koug1Ir4h4Bs5C6QKAeh0qwqzCBFedbk3w1nTzpjvQ==
X-Received: by 2002:a17:90a:5b:: with SMTP id 27mr16351976pjb.190.1587325542367;
        Sun, 19 Apr 2020 12:45:42 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id v4sm25201600pfb.31.2020.04.19.12.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 12:45:39 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 99AAB40E7B; Sun, 19 Apr 2020 19:45:38 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 02/10] blktrace: move blktrace debugfs creation to helper function
Date:   Sun, 19 Apr 2020 19:45:21 +0000
Message-Id: <20200419194529.4872-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200419194529.4872-1-mcgrof@kernel.org>
References: <20200419194529.4872-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move the work to create the debugfs directory used into a helper.
It will make further checks easier to read. This commit introduces
no functional changes.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/trace/blktrace.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index ca39dc3230cb..2c6e6c386ace 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -468,6 +468,18 @@ static void blk_trace_setup_lba(struct blk_trace *bt,
 	}
 }
 
+static struct dentry *blk_trace_debugfs_dir(struct blk_user_trace_setup *buts,
+					    struct blk_trace *bt)
+{
+	struct dentry *dir = NULL;
+
+	dir = debugfs_lookup(buts->name, blk_debugfs_root);
+	if (!dir)
+		bt->dir = dir = debugfs_create_dir(buts->name, blk_debugfs_root);
+
+	return dir;
+}
+
 /*
  * Setup everything required to start tracing
  */
@@ -509,9 +521,7 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 
 	ret = -ENOENT;
 
-	dir = debugfs_lookup(buts->name, blk_debugfs_root);
-	if (!dir)
-		bt->dir = dir = debugfs_create_dir(buts->name, blk_debugfs_root);
+	dir = blk_trace_debugfs_dir(buts, bt);
 
 	bt->dev = dev;
 	atomic_set(&bt->dropped, 0);
-- 
2.25.1

