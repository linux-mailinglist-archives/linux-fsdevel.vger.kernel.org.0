Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD8B581C26
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jul 2022 00:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbiGZWon (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jul 2022 18:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbiGZWom (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jul 2022 18:44:42 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7DD30551
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Jul 2022 15:44:41 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id w10so3044248plq.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Jul 2022 15:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EigelYic/mxYtYmvK0d/ECOSCSbvSWY9zQwdwCRE1xU=;
        b=UQB5ZRRO/QUEJ7UXOy6hfUeP2LGg1iG1G2L6lYRV5CN7MRKqOoRhhJ4LOvk4dTPamc
         +md4YSbZu+dAdt63YD8hmAv8crfk6YQaADLjxgo+/ld9tgr6+hZ6w/eLdhXZLTDcE+vI
         ClkDybitc/QF9orOkDDQ4FE77XeMPHs3tS+0otbeBopmtZiSgI7wtixYW/N+tV0VugHQ
         J2NgbSSfvdA9hY8UkURK6fcJe3veUhbuwVAQVxAWTJHuTxBSsGzjwFssiyA87h8thrSU
         zPUwHjXaZtrw2AA48hQ2V5ep+pupP4d4X1198rrPhCezPyKz59zOxXTH5gZDeUR/Gq2u
         rPmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EigelYic/mxYtYmvK0d/ECOSCSbvSWY9zQwdwCRE1xU=;
        b=p9NlWuYrz9UKLdCn3EwX6DoUzAUlbkb6ImAUciomL87yLDabBU+9wJxSaG+Gfswlz3
         n71R2KjnVDM455g25WU1NH3k+OqJFieHaqm8rcJFvOKc+EE2cKeODmTT5g4at2Uxal1G
         l/kbD4wqwr/nJqKbUyBtfGpHnHH4cXVJZbtUvoO0q4EzCCUgbzfy+NYSGgJ11fTldMJ9
         pXO5ac71TSep2vbEBmTJFcnQzHX/HjIUnTFWDiW39GUr00FHV4MQvf94Bo8f3b5N4kFu
         9RPOmrUe8iTAO0yb9A8LaUjZ34xwkYg13wM3jhX/tamrP7qgn7AT8PRBIS9R1nwhFACG
         V/yQ==
X-Gm-Message-State: AJIora8MFAyLbgPSPywolSpgwVj3wguVx+6QyR1ViDeRhGsr2kNLiQVz
        ja0AfQJ/g81JeB0WqFOZNMQKGWQ9cmSAPA==
X-Google-Smtp-Source: AGRyM1tcRAA4xAbymdsqTaThXEc4HUQqOMO2kpv7vOHwV02hYfUDtDpUXJ1EqX72UMNc82bdqIWL3w==
X-Received: by 2002:a17:90a:4e87:b0:1f2:1c52:4082 with SMTP id o7-20020a17090a4e8700b001f21c524082mr1217645pjh.237.1658875481002;
        Tue, 26 Jul 2022 15:44:41 -0700 (PDT)
Received: from desktop.. ([2601:1c0:4c00:ad20:feaa:14ff:fe3a:b225])
        by smtp.gmail.com with ESMTPSA id n59-20020a17090a5ac100b001f2b0f8e047sm110408pji.27.2022.07.26.15.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 15:44:40 -0700 (PDT)
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tadeusz Struk <tadeusz.struk@linaro.org>,
        syzbot+bd13648a53ed6933ca49@syzkaller.appspotmail.com
Subject: [PATCH] ext4: try to flush inline data before calling BUG in writepages
Date:   Tue, 26 Jul 2022 15:44:28 -0700
Message-Id: <20220726224428.407887-1-tadeusz.struk@linaro.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <983bb802-d883-18d4-7945-dbfa209c1cc8@linaro.org>
References: <983bb802-d883-18d4-7945-dbfa209c1cc8@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix a syzbot issue, which triggers a BUG in ext4_writepags.
The syzbot creates and monuts an ext4 fs image on /dev/loop0.
The image is corrupted, which is probably the source of the
problems, but the mount operation finishes successfully.
Then the repro program creates a file on the mounted fs, and
eventually it writes a buff of 22 zero bytes to it as below:

memfd_create("syzkaller", 0) = 3
ftruncate(3, 2097152)       = 0
pwrite64(3, " \0\0\0\0\2\0\0\31\0\0\0\220\1\0\0\17\0\0\0\0\0\0\0\2\0\0\0\6\0\0\0"..., 102, 1024) = 102
pwrite64(3, "\0\0\0\0\0\0\0\0\0\0\0\0\202\343g$\306\363L\252\204n\322\345'p3x\1\0@", 31, 1248) = 31
pwrite64(3, "\2\0\0\0\3\0\0\0\4\0\0\0\31\0\17\0\3\0\4\0\0\0\0\0\0\0\0\0\17\0.i", 32, 4096) = 32
pwrite64(3, "\177\0\0\0\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377"..., 4098, 8192) = 4098
pwrite64(3, "\355A\0\0\20\0\0\0\332\364e_\333\364e_\333\364e_\0\0\0\0\0\0\4\0\200\0\0\0"..., 61, 17408) = 61
openat(AT_FDCWD, "/dev/loop0", O_RDWR) = 4
ioctl(4, LOOP_SET_FD, 3)    = 0
mkdir("./file0", 0777)      = -1 EEXIST (File exists)
mount("/dev/loop0", "./file0", "ext4", 0, ",errors=continue") = 0
openat(AT_FDCWD, "./file0", O_RDONLY|O_DIRECTORY) = 5
ioctl(4, LOOP_CLR_FD)       = 0
close(4)                    = 0
close(3)                    = 0
chdir("./file0")            = 0
creat("./bus", 000)         = 3
open("./bus", O_RDWR|O_CREAT|O_NONBLOCK|O_SYNC|O_DIRECT|O_LARGEFILE|O_NOATIME, 000) = 4
openat(AT_FDCWD, "/proc/self/exe", O_RDONLY) = 6
sendfile(4, 6, NULL, 2147483663) = 1638400
open("./bus", O_RDWR|O_CREAT|O_SYNC|O_NOATIME, 000) = 7
write(7, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0", 22) <unfinished ...>

This triggers a BUG in ext4_writepages(), where it checks if
the inode has inline data, just before deleting it:

kernel BUG at fs/ext4/inode.c:2721!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 359 Comm: repro Not tainted 5.19.0-rc8-00001-g31ba1e3b8305-dirty #15
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-1.fc36 04/01/2014
RIP: 0010:ext4_writepages+0x363d/0x3660
RSP: 0018:ffffc90000ccf260 EFLAGS: 00010293
RAX: ffffffff81e1abcd RBX: 0000008000000000 RCX: ffff88810842a180
RDX: 0000000000000000 RSI: 0000008000000000 RDI: 0000000000000000
RBP: ffffc90000ccf650 R08: ffffffff81e17d58 R09: ffffed10222c680b
R10: dfffe910222c680c R11: 1ffff110222c680a R12: ffff888111634128
R13: ffffc90000ccf880 R14: 0000008410000000 R15: 0000000000000001
FS:  00007f72635d2640(0000) GS:ffff88811b000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000565243379180 CR3: 000000010aa74000 CR4: 0000000000150eb0
Call Trace:
 <TASK>
 do_writepages+0x397/0x640
 filemap_fdatawrite_wbc+0x151/0x1b0
 file_write_and_wait_range+0x1c9/0x2b0
 ext4_sync_file+0x19e/0xa00
 vfs_fsync_range+0x17b/0x190
 ext4_buffered_write_iter+0x488/0x530
 ext4_file_write_iter+0x449/0x1b90
 vfs_write+0xbcd/0xf40
 ksys_write+0x198/0x2c0
 __x64_sys_write+0x7b/0x90
 do_syscall_64+0x3d/0x90
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
 </TASK>

This can be prevented by forcing the inline data to be converted
and/or flushed beforehand.
This patch adds a call to ext4_convert_inline_data() just before
the BUG, which fixes the issue.

Link: https://syzkaller.appspot.com/bug?id=a1e89d09bbbcbd5c4cb45db230ee28c822953984
Reported-by: syzbot+bd13648a53ed6933ca49@syzkaller.appspotmail.com
Signed-off-by: Tadeusz Struk <tadeusz.struk@linaro.org>
---
 fs/ext4/inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 84c0eb55071d..de2aa2e79052 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2717,6 +2717,10 @@ static int ext4_writepages(struct address_space *mapping,
 			ret = PTR_ERR(handle);
 			goto out_writepages;
 		}
+
+		if (ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA))
+			WARN_ON(ext4_convert_inline_data(inode));
+
 		BUG_ON(ext4_test_inode_state(inode,
 				EXT4_STATE_MAY_INLINE_DATA));
 		ext4_destroy_inline_data(handle, inode);
-- 
2.37.1
