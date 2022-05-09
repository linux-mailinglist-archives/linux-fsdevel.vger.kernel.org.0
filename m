Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2B951FA31
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 12:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbiEIKsa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 06:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbiEIKs1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 06:48:27 -0400
X-Greylist: delayed 837 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 09 May 2022 03:43:36 PDT
Received: from smtp.dbxyz.space (constantine.dbxyz.space [IPv6:2001:19f0:5801:2cd::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE3CF2CF285;
        Mon,  9 May 2022 03:43:33 -0700 (PDT)
Date:   Mon, 9 May 2022 20:20:31 +1000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=dropbear.xyz;
        s=202004; t=1652091632;
        bh=3zD69nrHAktkpTKFutEwYOSsRHajHgFDe+9rh8XQpuI=;
        h=Date:From:To:Subject:From;
        b=tup1bIwVPl0WxW5/6un4amNbnCVGUUQ3RABKvKlix0WP12QSN0etB5a1SwinOkHbE
         Sw0jJCkyWEbhsneivwAP5tkoqRk8By362rpNn2E/5Rbo99YCVAsvkXlVZ5O8tYUPTw
         cZ3g9LZ5MzJ1HA2Fkvf1DskNV5W9qx3m0CIIM4A8=
From:   Craig Small <csmall@dropbear.xyz>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: procfs: mnt namespace behaviour with block devices (resend)
Message-ID: <Ynjq7yN+r6sibyUd@dropbear.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        FROM_SUSPICIOUS_NTLD_FP,PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS,
        T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

(resending as plain text as the first got bounced)

Hi,
  I'm the maintainer of the psmisc package that provides system tools
for things like fuser and killall. I am trying to establish if
something I have found with the proc filesystem is as intended
(knowing why would be nice) or if it's a strange corner-case bug.

Apologies to the non-procfs maintainers but these two lists are what
MAINTAINER said to go to. If you could CC me on replies that would be
great.

The proc file descriptor for a block device mounted in a different
namespace will show the device id of that different namespace and not
the device id of the process stat()ing the file.

The issue came up in fuser not finding certain processes that were
directly accessing a block device, see
https://gitlab.com/psmisc/psmisc/-/issues/39 Programs such as lsof are
caught by this too.

My question is: When I am in the bash mount namespace (4026531840 below)
then shouldn't all the device IDs be from that namespace? In other
words, the device id of the dereferenced symlink and what it points to
are the same (device id 5) and not symlink has 44 and /dev/dm-8 has 5.

I get that if I could look at the device IDs in qemu or use nsenter to
switch to its namespace, then the device should be 44 for the symlink
and device (which it is and seems correct to me).

How to replicate
=============
# uname -a
Linux elmo 5.16.0-5-amd64 #1 SMP PREEMPT Debian 5.16.14-1 (2022-03-15)
x86_64 GNU/Linux

The easiest way to replicate this is to make a qemu virtual machine and
have it mount a block device. I suspect there are other ways, but I
don't have many things that mount a device and switch namespaces. The
qemu process (here it is 136775) will have a different mount namespace.

# ps -o pid,mntns,comm $$ 136775
    PID      MNTNS COMMAND
 136775 4026532762 qemu-system-x86
 142359 4026531840 bash

File descriptor 23 is what qemu is using to mount the block device
# ls -l /proc/136775/fd/23
lrwx------ 1 libvirt-qemu libvirt-qemu 64 Apr 12 16:34
/proc/136775/fd/23 -> /dev/dm-8

However, the dereferenced symlink and where the symlink points to show
different data.

# stat -L /proc/136775/fd/23
  File: /proc/136775/fd/23
  Size: 0         Blocks: 0          IO Block: 4096   block special file
Device: 2ch/44d Inode: 9           Links: 1     Device type: fd,8
Access: (0660/brw-rw----)  Uid: (64055/libvirt-qemu)   Gid: (64055/libvirt-qemu)
Access: 2022-04-12 16:34:25.687147886 +1000
Modify: 2022-04-12 16:34:25.519151533 +1000
Change: 2022-04-12 16:34:25.595149882 +1000
 Birth: -

# stat /dev/dm-8
  File: /dev/dm-8
  Size: 0         Blocks: 0          IO Block: 4096   block special file
Device: 5h/5d Inode: 348         Links: 1     Device type: fd,8
Access: (0660/brw-rw----)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2022-04-12 16:15:12.684434884 +1000
Modify: 2022-04-12 16:15:12.684434884 +1000
Change: 2022-04-12 16:15:12.684434884 +1000
 Birth: -

If we change to the qemu process' mount namespace then we do see that
/dev/dm-8 has the same device/inode as the symlink.

# nsenter -m -t 136775 stat /dev/dm-8
  File: /dev/dm-8
  Size: 0         Blocks: 0          IO Block: 4096   block special file
Device: 2ch/44d Inode: 9           Links: 1     Device type: fd,8
Access: (0660/brw-rw----)  Uid: (64055/libvirt-qemu)   Gid: (64055/libvirt-qemu)
Access: 2022-04-12 16:34:25.687147886 +1000
Modify: 2022-04-12 16:34:25.519151533 +1000
Change: 2022-04-12 16:34:25.595149882 +1000
 Birth: -

Thanks for your time.

 - Craig
