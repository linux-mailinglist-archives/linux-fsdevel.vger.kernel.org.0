Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E41D12AB1A8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Nov 2020 08:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbgKIHLV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Nov 2020 02:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728873AbgKIHLV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Nov 2020 02:11:21 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C51BC0613CF;
        Sun,  8 Nov 2020 23:11:21 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id t9so4190666edq.8;
        Sun, 08 Nov 2020 23:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UfP7NvLo6S+A1T4P52kCNANXDGDMhGjiqRkXf0+vq8s=;
        b=V8s9PjVuXRHQUnumeZE/K6/4rUWKfmFosECHfDoCiXn77p6ESRxpFAb/h0PabSJ+3F
         Tv+GegeUwQsNPyAkOfJh8lkfwSX9E89hHXTJRbG/+qdXYpY5sa/jcbsAimTV584v6oxv
         PIJ59dglSJByveZKSbe9liAekwljB7udNNe0JXGiaLtwBKrEItYieIbK0iFoAwqjwsdq
         ifVG2kd+cH/OmpEYlk/iy0YyuTxgblK/S3BG6jP98OljusWhPblKhnfQMGXQ4UHRKFHV
         XaSH+45hN6Vc9q3p2T/L2OQ/VXYG+Ail46zk+MMn3krMk7WgjVI3ism+31fo8/GlXdAb
         VKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UfP7NvLo6S+A1T4P52kCNANXDGDMhGjiqRkXf0+vq8s=;
        b=TIvr3B9IyzcxqIJS6FaNPhJ+4f6WuHWyPYANRo7fuBFQ18CG697afrUnyhWEVyAQRF
         pBEHinZ0Z57Of1OIMd/lg9UAAibMcSo93ILzN0J91S7wvIZD0c2RpWvZwsCBxRPHBKr7
         Gmp/FNBOLJDtKnC9GBtqKeJ0am2rFF02CDo18utCUMSuLKeQFp3weA5MBfHRWILs0lPi
         ipfMu+Xlq8cs0w74KEIdzbYpQyYvNxN0syMJuew/nbcbnDrI/2gmXLpVcRa083/WGZf1
         WiSsoz5t8FMymjSPy+gwqRlIwIw7iL4cLT6Fiy4ucYLOHEOOBuhbi0RChEOEJ5E8JqWd
         O4kA==
X-Gm-Message-State: AOAM5319FkqHL21uVr+13krFv1UfhpkSKLTo4GLHaYrjVY1xDLtE+Yf+
        peW0qZCQbTpoe4Hkw9FNuAc=
X-Google-Smtp-Source: ABdhPJzhHR+67E+DYO2yePXQ7qtu/vPbRWHs85ceZqGD85nEPjCdQnX1S3utiJyuNpq5GiAY+nK5Ww==
X-Received: by 2002:a50:eb87:: with SMTP id y7mr14459918edr.187.1604905879680;
        Sun, 08 Nov 2020 23:11:19 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2dd6:1d00:28e2:5274:acbe:6374])
        by smtp.gmail.com with ESMTPSA id s3sm8066314ejv.97.2020.11.08.23.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 23:11:18 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-fsdevel@vger.kernel.org
Cc:     Tom Rix <trix@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-safety@lists.elisa.tech,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] sysctl: move local variable in proc_do_large_bitmap() to proper scope
Date:   Mon,  9 Nov 2020 08:11:07 +0100
Message-Id: <20201109071107.22560-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

make clang-analyzer caught my attention with:

  kernel/sysctl.c:1511:4: warning: Value stored to 'first' is never read \
  [clang-analyzer-deadcode.DeadStores]
                          first = 0;
                          ^

Commit 9f977fb7ae9d ("sysctl: add proc_do_large_bitmap") introduced
proc_do_large_bitmap(), where the variable first is only effectively used
when write is false; when write is true, the variable first is only used in
a dead assignment.

So, simply remove this dead assignment and put the variable in local scope.

As compilers will detect this unneeded assignment and optimize this anyway,
the resulting object code is identical before and after this change.

No functional change. No change to object code.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on v5.10-rc3 and next-20201106

Luis, Kees, Iurii, please pick this minor non-urgent clean-up patch.

 kernel/sysctl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index ce75c67572b9..cc274a431d91 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1423,7 +1423,6 @@ int proc_do_large_bitmap(struct ctl_table *table, int write,
 			 void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int err = 0;
-	bool first = 1;
 	size_t left = *lenp;
 	unsigned long bitmap_len = table->maxlen;
 	unsigned long *bitmap = *(unsigned long **) table->data;
@@ -1508,12 +1507,12 @@ int proc_do_large_bitmap(struct ctl_table *table, int write,
 			}
 
 			bitmap_set(tmp_bitmap, val_a, val_b - val_a + 1);
-			first = 0;
 			proc_skip_char(&p, &left, '\n');
 		}
 		left += skipped;
 	} else {
 		unsigned long bit_a, bit_b = 0;
+		bool first = 1;
 
 		while (left) {
 			bit_a = find_next_bit(bitmap, bitmap_len, bit_b);
-- 
2.17.1

