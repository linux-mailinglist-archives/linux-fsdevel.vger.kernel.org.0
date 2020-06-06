Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E234A1F0568
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jun 2020 08:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbgFFGc2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 Jun 2020 02:32:28 -0400
Received: from mail.loongson.cn ([114.242.206.163]:38852 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725765AbgFFGc1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 Jun 2020 02:32:27 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxj2p0ONtesFg+AA--.1141S3;
        Sat, 06 Jun 2020 14:32:21 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
Subject: [PATCH 2/3] fs: Introduce cmdline argument exceed_file_max_panic
Date:   Sat,  6 Jun 2020 14:32:19 +0800
Message-Id: <1591425140-20613-2-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1591425140-20613-1-git-send-email-yangtiezhu@loongson.cn>
References: <1591425140-20613-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9Dxj2p0ONtesFg+AA--.1141S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZr4ktr15uw4rCry8tF1UZFb_yoW5XrWkpF
        Z3Zws0krZ5Jr47Wrn3Ca97ZryS9rZrJr1vq3s3u398Cry5Grn5Crs7JF1agFy8KrW0qw1a
        vw43KryrCF48JaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBq14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
        ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
        8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
        jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r47MxAIw2
        8IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
        x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrw
        CI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI
        42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
        80aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjjQ6tUUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It is important to ensure that files that are opened always get closed.
Failing to close files can result in file descriptor leaks. One common
answer to this problem is to just raise the limit of open file handles
and then restart the server every day or every few hours, this is not
a good idea for long-lived servers if there is no leaks.

If there exists file descriptor leaks, when file-max limit reached, we
can see that the system can not work well and at worst the user can do
nothing, it is even impossible to execute reboot command due to too many
open files in system. In order to reboot automatically to recover to the
normal status, introduce a new cmdline argument exceed_file_max_panic for
user to control whether to call panic in this case.

We can reproduce this problem used with the following simple test:

[yangtiezhu@linux ~]$ cat exceed_file_max_test.c
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

int main()
{
	int fd;

	while (1) {
		fd = open("/usr/include/stdio.h", 0444);
		if (fd == -1)
			fprintf(stderr, "%s\n", "open failed");
	}

	return 0;
}
[yangtiezhu@linux ~]$ cat exceed_file_max_test.sh
#!/bin/bash

gcc exceed_file_max_test.c -o exceed_file_max_test.bin -Wall

while true
do
	./exceed_file_max_test.bin >/dev/null 2>&1 &
done
[yangtiezhu@linux ~]$ sh exceed_file_max_test.sh &
[yangtiezhu@linux ~]$ reboot
bash: start pipeline: pgrp pipe: Too many open files in system
bash: /usr/sbin/reboot: Too many open files in system

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 fs/file_table.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/file_table.c b/fs/file_table.c
index 26516d0..6943945 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -121,6 +121,17 @@ static struct file *__alloc_file(int flags, const struct cred *cred)
 	return f;
 }
 
+static bool exceed_file_max_panic;
+static int __init exceed_file_max_panic_setup(char *str)
+{
+	pr_info("Call panic when exceed file-max limit\n");
+	exceed_file_max_panic = true;
+
+	return 1;
+}
+
+__setup("exceed_file_max_panic", exceed_file_max_panic_setup);
+
 /* Find an unused file structure and return a pointer to it.
  * Returns an error pointer if some error happend e.g. we over file
  * structures limit, run out of memory or operation is not permitted.
@@ -159,6 +170,9 @@ struct file *alloc_empty_file(int flags, const struct cred *cred)
 	if (get_nr_files() > old_max) {
 		pr_info("VFS: file-max limit %lu reached\n", get_max_files());
 		old_max = get_nr_files();
+
+		if (exceed_file_max_panic)
+			panic("VFS: Too many open files in system\n");
 	}
 	return ERR_PTR(-ENFILE);
 }
-- 
2.1.0

