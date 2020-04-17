Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED5391AE21A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Apr 2020 18:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730224AbgDQQUr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Apr 2020 12:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729581AbgDQQUq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Apr 2020 12:20:46 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610BEC061A0C;
        Fri, 17 Apr 2020 09:20:46 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id y25so1279900pfn.5;
        Fri, 17 Apr 2020 09:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uEC1NxgO3wDxKhGD+oHS7PoCQCoDC/4sznGP0BFL7YQ=;
        b=J5rQiyqwo/AipGRK7qskSONOpPidp/DsEQxq00hgiAwSXPh1pBxheO5mdSsW1lwZ4a
         GFzUj1JEpdEAaSpxk22bXhnNCzeJ/aLB+xiXFaYXMqxq2UaX5xy5W/f3BwG/+XDK3FtC
         mW24yMH/2NMQI9lLx9+/O3vSSqCRB+/U1NEyYxlcRWJAsbkGWXYqJ8roMmoCaeS/Pz0q
         VDPALjTcz6QgpcriDH6yXo44w+sflCEsL/CYxbj3c9E6E2/aaNi5+J8HCaPUnLI2VrUg
         dq0VqMNfoytaHJvzn19owbq9UN6gEEQ/Hv9nBzzonOTGNklKnU6XEM0A1diU7b0z8oTy
         41Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uEC1NxgO3wDxKhGD+oHS7PoCQCoDC/4sznGP0BFL7YQ=;
        b=swWPWJUoldnCYiNrTmb4HoxMB5eInvOOxOzzHEfOmUDRFS0YgvyEao+jvbTcddnG+6
         1M5M8/dpWTx2+px3fupJX/97L30/NJfyHwOE+TQ8/goXr9eG1u1uKKvmrh3ExIgsD/ON
         qxww8DS7X/Q0QCKJndV2OLVYCbfMsZp3tZLPzu05Na/SZpplBFUrkf8Fru/EP548+/fb
         aHD+XlHEqW7y7tz/hodJGCfLhjNyKRit5mcWpvrKqREXz/V8GLoc9hVgrXwQ6nIn3ofo
         Jb7L9EtUeZO07rHnPxdExj1Mel7UqYxKAcCG4bWjhT7V8kpatYWvBhN67rAP9IDZ0kpB
         Xagw==
X-Gm-Message-State: AGi0PuYEPPMx5sum+BlasHDG2vzVxwY8/Ra3ZVIPI956k6oPxHccMPn3
        Pa0tF9GQ2OaymJYLDIQbYMo=
X-Google-Smtp-Source: APiQypKYFg9CEaDEiRYqPjPP3BMFVTkk+0sDCZA3OenufiuvDzXx6rPIHtLq7MiWi4I5tw75Oc6tjw==
X-Received: by 2002:a62:5b87:: with SMTP id p129mr3892027pfb.5.1587140445832;
        Fri, 17 Apr 2020 09:20:45 -0700 (PDT)
Received: from Smcdef-MBP.lan ([103.136.220.73])
        by smtp.gmail.com with ESMTPSA id i8sm17611763pgr.82.2020.04.17.09.20.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Apr 2020 09:20:45 -0700 (PDT)
From:   Kaitao Cheng <pilgrimtao@gmail.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com, Kaitao Cheng <pilgrimtao@gmail.com>
Subject: [PATCH] fs/buffer: Remove the initialization of variables bh_{accounting, lrus}
Date:   Sat, 18 Apr 2020 00:20:37 +0800
Message-Id: <20200417162037.91546-1-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The static global variables will be automatically initialized to 0,
and we do not need to manually initialize to 0. So remove the
initialization of variable bh_{accounting, lrus}.

Signed-off-by: Kaitao Cheng <pilgrimtao@gmail.com>
---
 fs/buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 1b3d2e66c496..c13898b1e964 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1274,7 +1274,7 @@ struct bh_lru {
 	struct buffer_head *bhs[BH_LRU_SIZE];
 };
 
-static DEFINE_PER_CPU(struct bh_lru, bh_lrus) = {{ NULL }};
+static DEFINE_PER_CPU(struct bh_lru, bh_lrus);
 
 #ifdef CONFIG_SMP
 #define bh_lru_lock()	local_irq_disable()
@@ -3368,7 +3368,7 @@ struct bh_accounting {
 	int ratelimit;		/* Limit cacheline bouncing */
 };
 
-static DEFINE_PER_CPU(struct bh_accounting, bh_accounting) = {0, 0};
+static DEFINE_PER_CPU(struct bh_accounting, bh_accounting);
 
 static void recalc_bh_state(void)
 {
-- 
2.20.1

