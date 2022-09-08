Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF335B2589
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Sep 2022 20:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbiIHSWC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 14:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbiIHSWA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 14:22:00 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC4EEB855;
        Thu,  8 Sep 2022 11:21:59 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t14so20271096wrx.8;
        Thu, 08 Sep 2022 11:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=0qMQLVEVJZBmgN+4OndfYCHKMuf7l9KBNcONt34CdKc=;
        b=GcZoTl2bCRlFzOoz5mrR7kWHp6+udvfQfj1QwcUqbtCRz/DA8W+t8Al/tF2lbjU4JW
         YqG6M9K63oE09s+sPMnVBIWAHX4ldXqlmA9f6TyzzTW8yYK8lX5LXE8EtxFin8xYiaLA
         Q+cxyy89dgx7Zapzjgub6gTZWG1DqCqOZ8bBxzZepzOv1GJ+PqEJQAKkcTFJs3t/cQkz
         jo0l0wFSXXZLMb8Pr/WJ8XEz/esYSRt1VQWZLLCOmjK/UkoptIN+MAXtAYbfHbK1TmcD
         g5Lx8cGpVvd/nQOkNmAUawBsbRxre3OxOUKsEq9EZG5pXpwkxDOilKIAJ4x3BbmdvRaL
         /Vsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=0qMQLVEVJZBmgN+4OndfYCHKMuf7l9KBNcONt34CdKc=;
        b=VZmMNUCf2K8447qdDaqYvGOg++oAdNOP72cDEnBI1X3Ob9Qa7rH9yV8Sy6fTBH8hYj
         w7QZALzoyyCIytLxldVFl2usfYnZrqPVIB0hJBD9ownJiNsKUITYfHYdjT5nvOwcR8UX
         ydj0QeyVnt/bjWAmGYUSKGwACLjVpjMJdTGU/Urm6t3zwDCFKWeAUeEaH02gmcluulQw
         WDTT++S+7a3cve11JhGlx3dYEfjNCK1NLu8Id5FAn1e90evU26CBBMmDuPaTUbhPdwaQ
         kR6Tj5971NO1Bxwjr7FzT/Qiz8wMH1Xu8yczmrvgZLoMJWW6y22I9pqJtyYQjwx8HJtS
         fNUw==
X-Gm-Message-State: ACgBeo0WJC03BfIahgHRlHe1df5PpsA0zf8/As/P0dECpk//iPc1J3sM
        vQfPwpz8XdKv9Up5TdxknPLy58NzfA==
X-Google-Smtp-Source: AA6agR7aWX/HRycU6uw0R9yfi5EVkde2QgjMxCzhbJcJD71dTGHhItjYI9gpQcmJ1mrsBHaNOt8Vmw==
X-Received: by 2002:a05:6000:1706:b0:22a:2c1d:f578 with SMTP id n6-20020a056000170600b0022a2c1df578mr3230336wrc.236.1662661317193;
        Thu, 08 Sep 2022 11:21:57 -0700 (PDT)
Received: from localhost.localdomain ([46.53.251.11])
        by smtp.gmail.com with ESMTPSA id m29-20020a05600c3b1d00b003a845fa1edfsm10465228wms.3.2022.09.08.11.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 11:21:56 -0700 (PDT)
Date:   Thu, 8 Sep 2022 21:21:54 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] proc: give /proc/cmdline size
Message-ID: <YxoywlbM73JJN3r+@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Most /proc files don't have length (in fstat sense). This leads
to inefficiencies when reading such files with APIs commonly found in
modern programming languages. They open file, then fstat descriptor,
get st_size == 0 and either assume file is empty or start reading
without knowing target size.

cat(1) does OK because it uses large enough buffer by default.
But naive programs copy-pasted from SO aren't:

	let mut f = std::fs::File::open("/proc/cmdline").unwrap();
	let mut buf: Vec<u8> = Vec::new();
	f.read_to_end(&mut buf).unwrap();

will result in

	openat(AT_FDCWD, "/proc/cmdline", O_RDONLY|O_CLOEXEC) = 3
	statx(0, NULL, AT_STATX_SYNC_AS_STAT, STATX_ALL, NULL) = -1 EFAULT (Bad address)
	statx(3, "", AT_STATX_SYNC_AS_STAT|AT_EMPTY_PATH, STATX_ALL, {stx_mask=STATX_BASIC_STATS|STATX_MNT_ID, stx_attributes=0, stx_mode=S_IFREG|0444, stx_size=0, ...}) = 0
	lseek(3, 0, SEEK_CUR)                   = 0
	read(3, "BOOT_IMAGE=(hd3,gpt2)/vmlinuz-5.", 32) = 32
	read(3, "19.6-100.fc35.x86_64 root=/dev/m", 32) = 32
	read(3, "apper/fedora_localhost--live-roo"..., 64) = 64
	read(3, "ocalhost--live-swap rd.lvm.lv=fe"..., 128) = 116
	read(3, "", 12)

open/stat is OK, lseek looks silly but there are 3 unnecessary reads
because Rust starts with 32 bytes per Vec<u8> and grows from there.

In case of /proc/cmdline, the length is known precisely.

Make variables readonly while I'm at it.

P.S.: I tried to scp /proc/cpuinfo today and got empty file
	but this is separate story.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/cmdline.c    |    6 +++++-
 include/linux/init.h |    1 +
 init/main.c          |    7 +++++--
 3 files changed, 11 insertions(+), 3 deletions(-)

--- a/fs/proc/cmdline.c
+++ b/fs/proc/cmdline.c
@@ -3,6 +3,7 @@
 #include <linux/init.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+#include "internal.h"
 
 static int cmdline_proc_show(struct seq_file *m, void *v)
 {
@@ -13,7 +14,10 @@ static int cmdline_proc_show(struct seq_file *m, void *v)
 
 static int __init proc_cmdline_init(void)
 {
-	proc_create_single("cmdline", 0, NULL, cmdline_proc_show);
+	struct proc_dir_entry *pde;
+
+	pde = proc_create_single("cmdline", 0, NULL, cmdline_proc_show);
+	pde->size = saved_command_line_len + 1;
 	return 0;
 }
 fs_initcall(proc_cmdline_init);
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -143,6 +143,7 @@ struct file_system_type;
 extern int do_one_initcall(initcall_t fn);
 extern char __initdata boot_command_line[];
 extern char *saved_command_line;
+extern unsigned int saved_command_line_len;
 extern unsigned int reset_devices;
 
 /* used by init/main.c */
--- a/init/main.c
+++ b/init/main.c
@@ -143,7 +143,8 @@ void (*__initdata late_time_init)(void);
 /* Untouched command line saved by arch-specific code. */
 char __initdata boot_command_line[COMMAND_LINE_SIZE];
 /* Untouched saved command line (eg. for /proc) */
-char *saved_command_line;
+char *saved_command_line __ro_after_init;
+unsigned int saved_command_line_len __ro_after_init;
 /* Command line for parameter parsing */
 static char *static_command_line;
 /* Untouched extra command line */
@@ -665,6 +666,8 @@ static void __init setup_command_line(char *command_line)
 			strcpy(saved_command_line + len, extra_init_args);
 		}
 	}
+
+	saved_command_line_len = strlen(saved_command_line);
 }
 
 /*
@@ -1372,7 +1375,7 @@ static void __init do_initcall_level(int level, char *command_line)
 static void __init do_initcalls(void)
 {
 	int level;
-	size_t len = strlen(saved_command_line) + 1;
+	size_t len = saved_command_line_len + 1;
 	char *command_line;
 
 	command_line = kzalloc(len, GFP_KERNEL);
