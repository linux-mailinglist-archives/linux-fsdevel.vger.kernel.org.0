Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 298DF2861FF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Oct 2020 17:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbgJGPYQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Oct 2020 11:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgJGPYQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Oct 2020 11:24:16 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EECC061755;
        Wed,  7 Oct 2020 08:24:16 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j2so2667953wrx.7;
        Wed, 07 Oct 2020 08:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9fZtNueIKa1HonbojTUuFEHA3Qjc+wNXpiWwCGdSRok=;
        b=vK7q1RY3f0TWa5MN6WxRKfIlZGN25DpQ5+088RPNAZbjbYhGezt/0RWRtW+0/Fg49a
         +tOdjU+9QgwsoDG5dgzQqVAfIJTO61hiBoVNw1PJXYr6DJ8zYRknWXI6jqmdvNTBQr/Q
         KUNST5SqMdBYYpcHRj1mH14BROSTD/HxappTUVaEbPgXTdMeqcJ4hNMphB+EUINIhXOL
         O955hN9/O3KJowrq2KG2YUSMVHgkZOhoVnzxzFgp97vf+UB5ugI379g0ntuB3THVI3Fo
         7XIt8BwSZPaHwCDjczD2vT2J50j4pd7jJfL6MQytVELw4TJVAhjif0ohavtCfc+4ZydV
         qffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9fZtNueIKa1HonbojTUuFEHA3Qjc+wNXpiWwCGdSRok=;
        b=kvYO85jLm1hZDHA0xEX0iiXJAfveOz7/mSaWZReTy3bY+o4V8xUyE+Xx++ClmmKqpJ
         BAZOJMjLBGwGRtzAQnD7OrSIQI+Ld+Vii/RLkpL6lgypoHfWQNoVCC4uc4E+nVfCQcsd
         cBru9fKwuwRBj0J6cGS8ODOueqna3ZnXBOPJMCFjbbEbmxiSDC19fAYmzcxN6ObRXrOu
         VL4OUcsS0I9bDEAIzo+fPLoyaiEzXBkS2f3I5skc8mefjtxV0NxdG/lNCn7rIYPPwAR6
         usW5RHyoqbFgsU+Qcae1RQsdJ2jJp26Pyc3X1LlE0QFdnJxgATpv5ULHQ2q5QxgnWLaJ
         lMbQ==
X-Gm-Message-State: AOAM5304yh5LMFyxR9lU34Sklc80BgeHO11hAPypSr0o1OohUge8OZny
        rZHszkRCaRXXlYCDKJRAmsw=
X-Google-Smtp-Source: ABdhPJwUld/XygEX1hTNO+qWq9Mc1WE1opsxETj+NlwHC3C1dbCijY44BsjTyuOzuBVPl4aH9Q/1mw==
X-Received: by 2002:adf:de11:: with SMTP id b17mr4129147wrm.82.1602084254649;
        Wed, 07 Oct 2020 08:24:14 -0700 (PDT)
Received: from localhost.localdomain (host-92-5-241-147.as43234.net. [92.5.241.147])
        by smtp.gmail.com with ESMTPSA id d30sm3562742wrc.19.2020.10.07.08.24.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Oct 2020 08:24:13 -0700 (PDT)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-safety@lists.elisa.tech,
        linux-fsdevel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH v2] kernel/sysctl.c: drop unneeded assignment in proc_do_large_bitmap()
Date:   Wed,  7 Oct 2020 16:19:04 +0100
Message-Id: <20201007151904.20415-1-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The variable 'first' is assigned 0 inside the while loop in the if block
but it is not used in the if block and is only used in the else block.
So, remove the unneeded assignment and move the variable in the else block.

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---

v1: only had the removal of assignment

The resultant binary stayed same after this change. Verified with
md5sum which remained same with and without this change.

$ md5sum kernel/sysctl.o 
77e8b8f3cd9da4446e7f117115c8ba84  kernel/sysctl.o

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
2.11.0

