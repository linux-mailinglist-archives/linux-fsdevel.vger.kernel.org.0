Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6F2165689
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 06:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgBTFK3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 00:10:29 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33237 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgBTFK2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 00:10:28 -0500
Received: from mail-pf1-f199.google.com ([209.85.210.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <matthew.ruffell@canonical.com>)
        id 1j4e6T-0001mM-CT
        for linux-fsdevel@vger.kernel.org; Thu, 20 Feb 2020 05:10:25 +0000
Received: by mail-pf1-f199.google.com with SMTP id c185so1726332pfb.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2020 21:10:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E2kvQmkvb81bm+34qLewRFV/m+iH5XOHaaYoAXUsntE=;
        b=H/6JBwvPmrGRlicl5NaFADUhWJFrkiQZ6As/JMuUBOG+K7xexNQtYLWi6oiM4VDSZI
         u7qsYT/WhLEfqyvdRNA8QDbEEic7W4F9Y7CyvKQXM9thkAj8QcGMex4r6Uad115sQ7ma
         wOOcNnnsllSozr0ctKCbBs67s3evR7vm/5GMHSZRH619clmEEmbiE8OhQBSTTFD3M0Vw
         snMjVkOyPPViPTlzwF4namAUKQQpry1iLfKNsGH/OpFfzX5KSkHvGEw7OHFHRbNdzBtW
         agJNbuStUpDOXVD1TJm4TFZz3I/DODh8SBmxmxudKF8cFwg0MdidpoiyXsHb5Nlb7+WF
         piZQ==
X-Gm-Message-State: APjAAAVpKUqArnKcKmRO0ukT9tumJD+Drv79SnvIb8oT6Q2E04SGf/po
        i/mDUwPV53jgnBzuEa5plI9NkqtHyPa3DK7SlPjvR54BXEA861CkeR0EkgwlXVlmT1UYMhIe8St
        9EDhQs3SJKhb7dak/ql2JYmYz+qfmMKF0ZqzurrvxGCg=
X-Received: by 2002:a17:902:74cc:: with SMTP id f12mr30182179plt.192.1582175423564;
        Wed, 19 Feb 2020 21:10:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqxpv4ToaCrZq27eJx3tmSweCd5e39rD0FKboP3/oMdOKh/N4L3ZGJLecz8fafviyr/+amqp/g==
X-Received: by 2002:a17:902:74cc:: with SMTP id f12mr30182164plt.192.1582175423112;
        Wed, 19 Feb 2020 21:10:23 -0800 (PST)
Received: from localhost.localdomain (222-154-99-146-fibre.sparkbb.co.nz. [222.154.99.146])
        by smtp.gmail.com with ESMTPSA id p3sm1409714pfg.184.2020.02.19.21.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 21:10:22 -0800 (PST)
From:   Matthew Ruffell <matthew.ruffell@canonical.com>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     pabs3@bonedaddy.net
Subject: [PATCH 0/1] coredump: Fix null pointer dereference when kernel.core_pattern is "|"
Date:   Thu, 20 Feb 2020 18:10:14 +1300
Message-Id: <20200220051015.14971-1-matthew.ruffell@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

A user was setting their kernel.core_pattern to "|" to disable coredumps, and
encountered the following null pointer dereference on a Ubuntu 5.3.0-29-generic
kernel:

Steps to reproduce:
Save the following intentionally broken program, save as socktest.c:

#include <sys/socket.h>
#include <netinet/in.h>
#include <string.h>

int main()
{
    int listenfd = 0;
    struct sockaddr_in serv_addr;

    listenfd = socket(AF_INET, SOCK_STREAM, 0);
    memset(&serv_addr, '0', sizeof(serv_addr));

    serv_addr.sin_family = AF_INET;
    serv_addr.sin_addr.s_addr = htonl(INADDR_ANY);
    serv_addr.sin_port = htons(6000);

    bind(listenfd, (struct sockaddr*)&serv_addr, sizeof(serv_addr));

    listen(listenfd, 10);

    *(int*)33 = 33;

    return 0;
}

$ sudo sysctl kernel.core_pattern="|"
$ gcc -o socktest socktest.c
$ ./socktest
<program will hang and will not be killable>

dmesg output:

BUG: kernel NULL pointer dereference, address: 0000000000000020
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0 
Oops: 0000 [#1] SMP PTI
CPU: 1 PID: 1026 Comm: socktest Not tainted 5.3.0-29-generic #31-Ubuntu
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.12.0-1 04/01/2014
RIP: 0010:do_coredump+0x536/0xb30
Code: 00 48 8b bd 18 ff ff ff 48 85 ff 74 05 e8 c2 47 fa ff 65 48 8b 04 25 c0 6b 01 00 48 8b 00 48 8b 7d a0 a8 04 0f 85 65 05 00 00 <48> 8b 57 20 0f b7 02 66 25 00 f0 66 3d 00 80 0f 84 9b 03 00 00 49
RSP: 0000:ffffa784c0887ca8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff8c5c743caec0 RCX: 00000000000019ab
RDX: 0000000000000000 RSI: ffffa784c0887c68 RDI: 0000000000000000
RBP: ffffa784c0887dd8 R08: 0000000000000400 R09: ffffa784c0887be0
R10: ffff8c5c79c51850 R11: 0000000000000000 R12: ffff8c5c70b869c0
R13: 0000000000000001 R14: 0000000000000000 R15: ffffffffa4d15920
FS:  00007f5b7288d540(0000) GS:ffff8c5c7bb00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000020 CR3: 000000017ab8a006 CR4: 0000000000160ee0
Call Trace:
? signal_wake_up_state+0x2a/0x30
? __send_signal+0x1eb/0x3f0
get_signal+0x159/0x880
do_signal+0x34/0x280
? do_user_addr_fault+0x34f/0x450
exit_to_usermode_loop+0xbf/0x160
prepare_exit_to_usermode+0x77/0xa0
retint_user+0x8/0x8

This happens on kernels 5.3 and above. On kernels 5.2 and prior, the user would
expect to see the following message in dmesg instead:

Core dump to | pipe failed

And the program would terminate on a standard segmentation fault.

Now, do_coredump+0x536 points more or less to the file_start_write() function
in do_coredump():

565 void do_coredump(const kernel_siginfo_t *siginfo)
566 {
...
788     if (!dump_interrupted()) {
789         file_start_write(cprm.file);
...
810 }

But this is not the "real" cause of the fault.

The problem was introduced in the following commit:

commit 315c69261dd3fa12dbc830d4fa00d1fad98d3b03
Author: Paul Wise <pabs3@bonedaddy.net>
Date: Fri Aug 2 21:49:05 2019 -0700
Subject: coredump: split pipe command whitespace before expanding template

Here is the actual fault. When we enter format_corename(), cn->corename[0] is
set to '\0' after being allocated on the heap:

191 static int format_corename(struct core_name *cn, struct coredump_params *cprm,
192                size_t **argv, int *argc)
193 {
...
196     int ispipe = (*pat_ptr == '|');
...
202     cn->corename = NULL;
203     if (expand_corename(cn, core_name_size))
204         return -ENOMEM;
205     cn->corename[0] = '\0';
...
}

ispipe is also 1, since the first character of the core_pattern is "|".

In the next if statement:

207     if (ispipe) {
208         int argvs = sizeof(core_pattern) / 2;
209         (*argv) = kmalloc_array(argvs, sizeof(**argv), GFP_KERNEL);
210         if (!(*argv))
211             return -ENOMEM;
212         (*argv)[(*argc)++] = 0;
213         ++pat_ptr;
214     }
215 
216     /* Repeat as long as we have more pattern to process and more output
217        space */
218     while (*pat_ptr) {

argv[0] is set to 0, and after, we do not enter the while(*pat_ptr) loop because
we have already reached the end of the core_pattern string.

Back in do_coredump():

676         for (argi = 0; argi < argc; argi++)
677             helper_argv[argi] = cn.corename + argv[argi];
678         helper_argv[argi] = NULL;

helper_argv[0] is set to cn.corename, which still has '\0' at index 0, and
argv[0] = 0, so helper_argv[0] == cn.corename.

When the call to call_usermodehelper_setup() is issued:

680         retval = -ENOMEM;
681         sub_info = call_usermodehelper_setup(helper_argv[0],
682                         helper_argv, NULL, GFP_KERNEL,
683                         umh_pipe_setup, NULL, &cprm);
684         if (sub_info)
685             retval = call_usermodehelper_exec(sub_info,
686                               UMH_WAIT_EXEC);

sub_info->path is set to helper_argv[0], and in call_usermodehelper_exec():

548 int call_usermodehelper_exec(struct subprocess_info *sub_info, int wait)
549 {
550     DECLARE_COMPLETION_ONSTACK(done);
551     int retval = 0;
552 
553     if (!sub_info->path) {
554         call_usermodehelper_freeinfo(sub_info);
555         return -EINVAL;
556     } 
...
568     if (strlen(sub_info->path) == 0)
569         goto out;
...
597 out:
598     call_usermodehelper_freeinfo(sub_info);
599 unlock:
600     helper_unlock();
601     return retval;
602 }

retval is initially set to 0. sub_info->path is a valid pointer, since it points
to the '\0' character, the check if (!sub_info->path) fails and we continue on
to the strlen check. This passes, and we goto out, which returns the retval of 
0.

Back to do_coredump():

688         kfree(helper_argv);
689         if (retval) {
690             printk(KERN_INFO "Core dump to |%s pipe failed\n",
691                    cn.corename);
692             goto close_fail;
693         }

We check to see if retval is nonzero. Since it is zero, we can continue on, and
get stuck at the null pointer dereference at the call to file_start_write()
pointed out earlier.

What should happen, is that we keep the same behaviour as kernels before
commit 315c69261dd3fa12dbc830d4fa00d1fad98d3b03, and enter the "if (retval)"
statement to print the "Core dump to |%s pipe failed\n" message and goto
close_fail.

We can add a simple string length check to fix the issue:

689         if (retval || strlen(cn.corename) == 0) {
690             printk(KERN_INFO "Core dump to |%s pipe failed\n",
691                    cn.corename);
692             goto close_fail;
693         }

Attached is a patch. It keeps the semantics the same as before
315c69261dd3fa12dbc830d4fa00d1fad98d3b03. Note, cn.corename will never be a
null pointer, and will always be null terminated.

If you can think of a better fix, please let me know.

Thanks,
Matthew Ruffell
Sustaining Engineer @ Canonical

Matthew Ruffell (1):
  coredump: Fix null pointer dereference when kernel.core_pattern is "|"

 fs/coredump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.20.1

