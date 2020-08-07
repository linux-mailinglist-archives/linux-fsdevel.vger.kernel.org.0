Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F332C23EB97
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Aug 2020 12:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgHGKfW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Aug 2020 06:35:22 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:53066 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgHGKfV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Aug 2020 06:35:21 -0400
Received: from fsav101.sakura.ne.jp (fsav101.sakura.ne.jp [27.133.134.228])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 077AZDUx016685;
        Fri, 7 Aug 2020 19:35:13 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav101.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav101.sakura.ne.jp);
 Fri, 07 Aug 2020 19:35:13 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav101.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 077AZCcr016659
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 7 Aug 2020 19:35:12 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: splice: infinite busy loop lockup bug
To:     syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
References: <00000000000084b59f05abe928ee@google.com>
Cc:     syzbot <syzbot+61acc40a49a3e46e25ea@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <29de15ff-15e9-5c52-cf87-e0ebdfa1a001@I-love.SAKURA.ne.jp>
Date:   Fri, 7 Aug 2020 19:35:08 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <00000000000084b59f05abe928ee@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot is reporting hung task at pipe_release() [1], for for_each_bvec() from
iterate_bvec() from iterate_all_kinds() from iov_iter_alignment() from
ext4_unaligned_io() from ext4_dio_write_iter() from ext4_file_write_iter() from
call_write_iter() from do_iter_readv_writev() from do_iter_write() from
vfs_iter_write() from iter_file_splice_write() falls into infinite busy loop
with pipe->mutex held.

The reason of falling into infinite busy loop is that iter_file_splice_write()
for some reason generates "struct bio_vec" entry with .bv_len=0 and .bv_offset=0
while for_each_bvec() cannot handle .bv_len == 0.

--- a/fs/splice.c
+++ b/fs/splice.c
@@ -747,6 +747,14 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 		}
 
 		iov_iter_bvec(&from, WRITE, array, n, sd.total_len - left);
+		if (!strncmp(current->comm, "syz-executor", 12)) {
+			int i;
+			printk("Starting vfs_write_iter from.type=%d from.iov_offset=%zu from.count=%zu n=%u sd.total_len=%zu left=%zu\n",
+			       from.type, from.iov_offset, from.count, n, sd.total_len, left);
+			for (i = 0; i < n; i++)
+				printk("  array[%u]: bv_page=%px bv_len=%u bv_offset=%u\n",
+				       i, array[i].bv_page, array[i].bv_len, array[i].bv_offset);
+		}
 		ret = vfs_iter_write(out, &from, &sd.pos, 0);
 		if (ret <= 0)
 			break;

When splice() from pipe to file works.

[   31.704915][ T6552] Starting vfs_write_iter from.type=17 from.iov_offset=0 from.count=4096 n=1 sd.total_len=65504 left=61408
[   31.709098][ T6552]   array[0]: bv_page=ffffea000870a7c0 bv_len=4096 bv_offset=0

When splice() from pipe to file falls into infinite busy loop.

[   31.717178][ T6553] Starting vfs_write_iter from.type=17 from.iov_offset=0 from.count=4096 n=2 sd.total_len=65504 left=61408
[   31.720983][ T6553]   array[0]: bv_page=ffffea0008706680 bv_len=0 bv_offset=0
[   31.723565][ T6553]   array[1]: bv_page=ffffea00086f4e80 bv_len=4096 bv_offset=0

Is it normal behavior that an empty page is linked to pipe's array?
If yes, don't we need to skip empty pages when iter_file_splice_write() fills in "struct bio_vec *array" ?

[1] https://syzkaller.appspot.com/bug?id=2ccac875e85dc852911a0b5b788ada82dc0a081e

