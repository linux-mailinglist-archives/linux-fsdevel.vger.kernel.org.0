Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 739FB3AB115
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jun 2021 12:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbhFQKPE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Jun 2021 06:15:04 -0400
Received: from out20-39.mail.aliyun.com ([115.124.20.39]:36461 "EHLO
        out20-39.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbhFQKPE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Jun 2021 06:15:04 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1765107|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00391928-0.000156034-0.995925;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047190;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.KTkp30b_1623924774;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.KTkp30b_1623924774)
          by smtp.aliyun-inc.com(10.147.41.199);
          Thu, 17 Jun 2021 18:12:55 +0800
Date:   Thu, 17 Jun 2021 18:12:56 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        dhowells@redhat.com
Subject: the major/minor value of statx(kernel samples/vfs/test-statx.c) does not match /usr/bin/stat
Message-Id: <20210617181256.63EB.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-Mailer: Becky! ver. 2.75.04 [en]
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

the major/minor value of statx(kernel samples/vfs/test-statx.c) does not
match /usr/bin/stat. 

major/minor of statx result seems be truncated by something like
old_decode_dev()?

kernel:5.10.44
kernel-headers:5.10.44
test fs: vfat, xfs, btrfs

btrfs output sample:

[root@T640 vfs]# ./test-statx /ssd/
statx(/ssd/) = 0
results=1fff
  Size: 200             Blocks: 0          IO Block: 4096    directory
Device: 00:31           Inode: 256         Links: 1
Access: (0755/drwxr-xr-x)  Uid:     0   Gid:     0
Access: 2021-06-16 19:16:56.644344956+0800
Modify: 2021-05-06 16:14:33.676248229+0800
Change: 2021-05-06 16:14:33.676248229+0800
 Birth: 2020-11-18 14:03:35.324915316+0800
Attributes: 0000000000002000 (........ ........ ........ ........ ........ ..-..... ..?-.... .---.-..)
[root@T640 vfs]# stat /ssd/
  File: ¡®/ssd/¡¯
  Size: 200             Blocks: 0          IO Block: 4096   directory
Device: 31h/49d Inode: 256         Links: 1
Access: (0755/drwxr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2021-06-16 19:16:56.644344956 +0800
Modify: 2021-05-06 16:14:33.676248229 +0800
Change: 2021-05-06 16:14:33.676248229 +0800
 Birth: -

vfat output sample:
[root@T640 vfs]# ./test-statx /boot/efi/
statx(/boot/efi/) = 0
results=17ff
  Size: 4096            Blocks: 8          IO Block: 4096    directory
Device: 08:01           Inode: 1           Links: 3
Access: (0700/drwx------)  Uid:     0   Gid:     0
Access: 1970-01-01 08:00:00.000000000+0800
Modify: 1970-01-01 08:00:00.000000000+0800
Change: 1970-01-01 08:00:00.000000000+0800
Attributes: 0000000000002000 (........ ........ ........ ........ ........ ..-..... ..?-.... ........)
[root@T640 vfs]# stat /boot/efi/
  File: ¡®/boot/efi/¡¯
  Size: 4096            Blocks: 8          IO Block: 4096   directory
Device: 801h/2049d      Inode: 1           Links: 3
Access: (0700/drwx------)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 1970-01-01 08:00:00.000000000 +0800
Modify: 1970-01-01 08:00:00.000000000 +0800
Change: 1970-01-01 08:00:00.000000000 +0800
 Birth: -


Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/06/17


