Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817676E3529
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Apr 2023 07:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjDPFYX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Apr 2023 01:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjDPFYW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Apr 2023 01:24:22 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4EB268C;
        Sat, 15 Apr 2023 22:24:21 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id kx14so2492004pjb.1;
        Sat, 15 Apr 2023 22:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681622661; x=1684214661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fdkWUSVb7sItCdhVnTB2mBOM4KVOU6lu7kjDYX23i3Q=;
        b=f7+g8U3+mFIVOvJDALt1KFacWtcs933Y/aezkrPo8XtF2wgGQd0EV8t5tfjkrUc6c9
         IVlqtp4oWYPLTbTJb2GICbu51D6Ui3QNyLjgV/yMTiL8EQMvFDBTk4T83ZoDTEV/Omi9
         SzAsUh7sqbLrB2Sd0meAxr5Xru3yKa2pEAMTmfcrlzBwIYPj3TAUKrJdK06EdbeHj2L3
         sihKvU1IwhP8IZq3KkUzaS99LsQcyY6ojQ5akOOIwZPYcJSnw7vemkAHgHeMSfnqOe+f
         mDGJQCbjIT2f5q+ET05Z2M6jHW1bS7DZL31A6YlKSBTZ4dQCcl+sCmPU4H4WmdkkirtJ
         fcIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681622661; x=1684214661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fdkWUSVb7sItCdhVnTB2mBOM4KVOU6lu7kjDYX23i3Q=;
        b=QvviTqpwxa69ROGX0BTnSFzD8PnNx0GS4kaW/XxKx1mTY8bOLuySSQynIJS/SArzK7
         F6Lea3OseYG1fcMYpqhO2S28jxM5XluBllRBHt+5vEW4Hrk+5sEHoVZ1T2JbS687bsdE
         hAO6I3jK5rMlUy5k+CQ/G/GRNiR5eTPoSE/a0jM2HLEX0tpRFWcAD1jn3sGKWVlhabwn
         0AAAJB6HSXDD6+2KBBw8SMBOrc19ht29sM5pOQ1WrTBgHIvsRaeCXhNL1ypgv30m2njr
         SVsxMuk78MYoGiTo8jXo2232M3ExvBnLKKPiwiycsspxafSCOlWKpAiWtjWXT0GHnSFD
         2VQg==
X-Gm-Message-State: AAQBX9dSBplXee9kKSdA+zscL+kW3ftLwz9FP7s1DtvPd7Tq7d0BDKVK
        xMyLcqU6zOe/3NAqCd21Br7eVMLFs3P1MwIY
X-Google-Smtp-Source: AKy350abnCEb9r3OYCa7+cbhMzYT+Ab1tlvl7uuYdLAtn/VZGmCL7VEfcRSEWI1yKTgt6Mtx6aiZxQ==
X-Received: by 2002:a17:902:d583:b0:1a0:6bd4:ea78 with SMTP id k3-20020a170902d58300b001a06bd4ea78mr8667031plh.31.1681622660939;
        Sat, 15 Apr 2023 22:24:20 -0700 (PDT)
Received: from localhost.localdomain ([45.137.97.138])
        by smtp.gmail.com with ESMTPSA id c3-20020a170902724300b0019cad2de86bsm5350778pll.156.2023.04.15.22.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 22:24:20 -0700 (PDT)
From:   Chunguang Wu <fullspring2018@gmail.com>
To:     akpm@linux-foundation.org, corbet@lwn.net
Cc:     adobriyan@gmail.com, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v2] fs/proc: add Kthread flag to /proc/$pid/status
Date:   Sun, 16 Apr 2023 13:24:04 +0800
Message-Id: <20230416052404.2920-1-fullspring2018@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The command `ps -ef ` and `top -c` mark kernel thread by '['
and ']', but sometimes the result is not correct.
The task->flags in /proc/$pid/stat is good, but we need remember
the value of PF_KTHREAD is 0x00200000 and convert dec to hex.
If we have no binary program and shell script which read
/proc/$pid/stat, we can know it directly by
`cat /proc/$pid/status`.

Signed-off-by: Chunguang Wu <fullspring2018@gmail.com>
---
 Documentation/filesystems/proc.rst | 2 ++
 fs/proc/array.c                    | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 9d5fd9424e8b..8a563684586c 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -179,6 +179,7 @@ read the file /proc/PID/status::
   Gid:    100     100     100     100
   FDSize: 256
   Groups: 100 14 16
+  Kthread:    0
   VmPeak:     5004 kB
   VmSize:     5004 kB
   VmLck:         0 kB
@@ -256,6 +257,7 @@ It's slow but very precise.
  NSpid                       descendant namespace process ID hierarchy
  NSpgid                      descendant namespace process group ID hierarchy
  NSsid                       descendant namespace session ID hierarchy
+ Kthread                     kernel thread flag, 1 is yes, 0 is no
  VmPeak                      peak virtual memory size
  VmSize                      total program size
  VmLck                       locked memory size
diff --git a/fs/proc/array.c b/fs/proc/array.c
index 9b0315d34c58..425824ad85e1 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -219,6 +219,8 @@ static inline void task_state(struct seq_file *m, struct pid_namespace *ns,
 		seq_put_decimal_ull(m, "\t", task_session_nr_ns(p, pid->numbers[g].ns));
 #endif
 	seq_putc(m, '\n');
+
+	seq_printf(m, "Kthread:\t%c\n", p->flags & PF_KTHREAD ? '1' : '0');
 }
 
 void render_sigset_t(struct seq_file *m, const char *header,
-- 
2.39.1

