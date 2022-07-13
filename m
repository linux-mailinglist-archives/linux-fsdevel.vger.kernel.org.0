Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA65573BDC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jul 2022 19:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbiGMRSY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 13:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiGMRSX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 13:18:23 -0400
X-Greylist: delayed 120 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Jul 2022 10:18:21 PDT
Received: from mail-relay150.hrz.tu-darmstadt.de (mailout.hrz.tu-darmstadt.de [IPv6:2001:41b8:83f:1611::150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96DA2F673
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Jul 2022 10:18:21 -0700 (PDT)
Received: from smtp.tu-darmstadt.de (mail-relay158.hrz.tu-darmstadt.de [130.83.252.158])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mail-relay158.hrz.tu-darmstadt.de", Issuer "DFN-Verein Global Issuing CA" (not verified))
        by mail-relay150.hrz.tu-darmstadt.de (Postfix) with ESMTPS id 4Ljkpy4wbwz43W3;
        Wed, 13 Jul 2022 19:18:18 +0200 (CEST)
Received: from [IPV6:2001:41b8:810:20:8488:f081:d781:11f2] (unknown [IPv6:2001:41b8:810:20:8488:f081:d781:11f2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by smtp.tu-darmstadt.de (Postfix) with ESMTPSA id 4Ljkpw56Tnz43VZ;
        Wed, 13 Jul 2022 19:18:16 +0200 (CEST)
Message-ID: <5548ef63-62f9-4f46-5793-03165ceccacc@tu-darmstadt.de>
Date:   Wed, 13 Jul 2022 19:18:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   =?UTF-8?B?QW5zZ2FyIEzDtsOfZXI=?= <ansgar.loesser@tu-darmstadt.de>
Subject: Re: [PATCH] fs/remap: constrain dedupe of EOF blocks
Reply-To: ansgar.loesser@kom.tu-darmstadt.de
To:     Dave Chinner <david@fromorbit.com>,
        Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        ansgar.loesser@kom.tu-darmstadt.de, Christoph Hellwig <hch@lst.de>,
        Amir Goldstein <amir73il@gmail.com>,
        Mark Fasheh <mark@fasheh.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Security Officers <security@kernel.org>,
        Max Schlecht <max.schlecht@informatik.hu-berlin.de>,
        =?UTF-8?Q?Bj=c3=b6rn_Scheuermann?= 
        <scheuermann@kom.tu-darmstadt.de>
References: <a7c93559-4ba1-df2f-7a85-55a143696405@tu-darmstadt.de>
 <CAHk-=wjrOgiWfN2uWf8Ajgr4SjeWMkEJ1Sd=H6pnS_JLjJwTcQ@mail.gmail.com>
 <CAEzrpqdweuZ2ufMKDJwSzP5W021F7mgS+7toSo6VDgvDzd0ZqA@mail.gmail.com>
 <CAHk-=wgEgAjX5gRntm0NutaNtjkzN+OaJVMaJAqved4dxPtAqw@mail.gmail.com>
 <Ys3TrAf95FpRgr+P@localhost.localdomain>
 <CAHk-=wi1-o-3iF09+PnNHq6_HLQhRn+32ow_f44to7_JuNCUoA@mail.gmail.com>
 <Ys4WdKSUTcvktuEl@magnolia>
 <CAHk-=wjUw11O60KuPBpsq1-hut9-Y76puzGqvgFJr5RwUPLS_A@mail.gmail.com>
 <20220713064631.GC3600936@dread.disaster.area>
 <20220713074915.GD3600936@dread.disaster.area>
In-Reply-To: <20220713074915.GD3600936@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Header-TUDa: ojcikQSbzn2d+spFzzJ5aU5AePmwsvCtgTXL20BfEJ2+xLksyb6n64vCojia7M9STmwPIanSCJX23eer57pLC4llkXT0Gf
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is another problem regarding deduplication and EOF. In some cases 
the syscall reports successful deduplication even if the data does not 
match (and thankfully nothing was actually deduplicated). A more formal 
description of the bug, an example code to exploit it and a proposed 
solution are attached below.

I *think* this behavior is not fixed completely by this patch yet, 
although I am not sure yet whether the `bad rounding` can still occur.

Best  regards,
Ansgar


FIDEDUPERANGE ioctl signals success, even if no bytes were deduplicated

The FIDEDUPERANGE ioctl can signal successfull deduplication even though 
the data in the `src` and `dest` fds does not match.

confirmed on 5.18.3 (amd64, debian), introduced in 4.19-rc1 (commit 
5740c99e9d30)
Reported-by: Ansgar Lößer (ansgar.loesser@kom.tu-darmstadt.de), Max 
Schlecht (max.schlecht@informatik.hu-berlin.de) and Björn Scheuermann 
(scheuermann@kom.tu-darmstadt.de)

The FIDEDUPERANGE ioctl will set `bytes_deduped` in any provided 
`file_dedupe_range_info` structs to the `src_length` provided in the 
main `file_dedupe_range` struct, as long as the deduplication request 
was generally valid. This is a problem, because 
`vfs_dedupe_file_range_one(...)` can internally shorten the 
deduplication range, which can lead to situations where trying to dedupe 
half a block, leads to the range being shortened down to 0, which 
results in successfull deduplication.

Even worse, the shortening happens before the actual data of the `src` 
and `dest` fds get compared, which can lead to situations where you're 
trying to deduplicate two files containing vastly different data, but 
the ioctl still claims have successfully deduplicated everything.

The proposed fix is to return the actual amount of bytes that got 
deduplicated, instead of the input length. This also seems to have been 
the standard behavior before 4.19-rc1 (commit 5740c99e9d30).

example code to reproduce the issue (`dedupe_wrong_status.c`)
```C
#define _XOPEN_SOURCE 500 // pwrite
#include <linux/types.h>
#include <linux/fs.h>
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/ioctl.h>

int main(int argc, char** argv)
{
     int src_fd = open("src_file.tmp", O_RDWR | O_CREAT | O_TRUNC, 0777);
     if (src_fd == -1)
     {
         fprintf(stderr, "failed to open src_file.tmp with %d\n", errno);
         return -1;
     }

     int dest_fd = open("dest_file.tmp", O_RDWR | O_CREAT | O_TRUNC, 0777);
     if (dest_fd == -1)
     {
         fprintf(stderr, "failed to open dest_file.tmp with %d\n", errno);
         return -1;
     }

     // write 1 block + 1 byte of data to each file
     // src file contains 0 bytes, dest files contains 1 bytes

     char zero = 0;
     char one = 1;
     for (__u64 i = 0; i < 4097; i++)
     {
         pwrite(src_fd, &zero, 1, i);
         pwrite(dest_fd, &one, 1, i);
     }

     // truncating src_fd and only writing a single byte, fixes it
     /*
     ftruncate(src_fd, 0);
     pwrite(src_fd, &zero, 1, 0);
     */

     // try to dedupe the first byte of the first block of src_fd
     // with the first byte of the second block of dest_fd

     char buffer[sizeof(struct file_dedupe_range)
         + sizeof(struct file_dedupe_range_info)];
     struct file_dedupe_range* arg = (struct file_dedupe_range*)buffer;
     arg->src_offset = 0;
     arg->src_length = 1;
     arg->dest_count = 1;
     arg->reserved1  = 0;
     arg->reserved2  = 0;

     struct file_dedupe_range_info* info = &arg->info[0];
     info->dest_fd = dest_fd;
     info->dest_offset = 4096;
     info->reserved = 0;

     int result = ioctl(src_fd, FIDEDUPERANGE, arg);

     printf("result %d, status %d, bytes deduped %d\n",
         result, info->status, info->bytes_deduped);

     // the byte we're trying to dedupe doesn't match, so we expect
     // status == FILE_DEDUPE_RANGE_DIFFERS (1)
     // instead this returns status == FILE_DEDUPE_RANGE_SAME (0)
     // and bytes_deduped is set to 1

     close(src_fd);
     close(dest_fd);

     return 0;
}
```

proposed fix (dedupe_wrong_status.patch)
```
diff --git a/fs/remap_range.c b/fs/remap_range.c
index e112b54..072c2c4 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -546,7 +546,7 @@ int vfs_dedupe_file_range(struct file *file, struct 
file_dedupe_range *same)
          else if (deduped < 0)
              info->status = deduped;
          else
-            info->bytes_deduped = len;
+            info->bytes_deduped = deduped;

  next_fdput:
          fdput(dst_fd);
```


Am 13.07.2022 um 09:49 schrieb Dave Chinner:
> From: Dave Chinner <dchinner@redhat.com>
> 
> If dedupe of an EOF block is not constrainted to match against only
> other EOF blocks with the same EOF offset into the block, it can
> match against any other block that has the same matching initial
> bytes in it, even if the bytes beyond EOF in the source file do
> not match.
> 
> Fix this by constraining the EOF block matching to only match
> against other EOF blocks that have identical EOF offsets and data.
> This allows "whole file dedupe" to continue to work without allowing
> eof blocks to randomly match against partial full blocks with the
> same data.
> 
> Reported-by: Ansgar Lößer <ansgar.loesser@tu-darmstadt.de>
> Fixes: 1383a7ed6749 ("vfs: check file ranges before cloning files")
> Link: https://lore.kernel.org/linux-fsdevel/a7c93559-4ba1-df2f-7a85-55a143696405@tu-darmstadt.de/
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
> 
> This is tested against the case provided in the initial report. Old
> kernel:
> 
> $ ./dedupe.sh |less
> secret
> $
> 
> Patched kernel:
> 
> $ ./dedupe.sh
> dedupe-bug: t.c:90: main: Assertion `status != FILE_DEDUPE_RANGE_DIFFERS' failed.
> ./dedupe.sh: line 11:  4831 Aborted /home/dave/dedupe-bug $MNT/writeonly.txt $MNT/test.tmp
> $
> 
> So now it fails with FILE_DEDUPE_RANGE_DIFFERS because it can't use
> short files to discover the dedupe character match one byte at a
> time.
> 
> It also passes fstests ismoke tests via running the './check -g
> dedupe' test group, so the fix doesn't obviously break anything.
> 
>   fs/remap_range.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/remap_range.c b/fs/remap_range.c
> index e112b5424cdb..881a306ee247 100644
> --- a/fs/remap_range.c
> +++ b/fs/remap_range.c
> @@ -71,7 +71,8 @@ static int generic_remap_checks(struct file *file_in, loff_t pos_in,
>   	 * Otherwise, make sure the count is also block-aligned, having
>   	 * already confirmed the starting offsets' block alignment.
>   	 */
> -	if (pos_in + count == size_in) {
> +	if (pos_in + count == size_in &&
> +	    (!(remap_flags & REMAP_FILE_DEDUP) || pos_out + count == size_out)) {
>   		bcount = ALIGN(size_in, bs) - pos_in;
>   	} else {
>   		if (!IS_ALIGNED(count, bs))

-- 
M.Sc. Ansgar Lößer
Fachgebiet Kommunikationsnetze
Fachbereich für Elektrotechnik und Informationstechnik
Technische Universität Darmstadt

Rundeturmstraße 10
64283 Darmstadt

E-Mail: ansgar.loesser@kom.tu-darmstadt.de
http://www.kom.tu-darmstadt.de
