Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3C3A7E78F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2019 03:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731260AbfHBBkI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Thu, 1 Aug 2019 21:40:08 -0400
Received: from mx1.mail.vl.ru ([80.92.161.250]:50990 "EHLO mx1.mail.vl.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731233AbfHBBkI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Aug 2019 21:40:08 -0400
Received: from localhost (unknown [127.0.0.1])
        by mx1.mail.vl.ru (Postfix) with ESMTP id 84B721860D71;
        Fri,  2 Aug 2019 01:40:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at mail.vl.ru
Received: from mx1.mail.vl.ru ([127.0.0.1])
        by localhost (smtp1.srv.loc [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jI4WmwLbDOxx; Fri,  2 Aug 2019 11:40:03 +1000 (+10)
Received: from [10.125.1.12] (unknown [109.126.62.18])
        (Authenticated sender: turchanov@vl.ru)
        by mx1.mail.vl.ru (Postfix) with ESMTPSA id 016AB184BFDD;
        Fri,  2 Aug 2019 11:40:02 +1000 (+10)
Subject: Re: [BUG] lseek on /proc/meminfo is broken in 4.19.59 maybe due to
 commit 1f4aace60b0e ("fs/seq_file.c: simplify seq_file iteration code and
 interface")
To:     NeilBrown <neilb@suse.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <3bd775ab-9e31-c6b3-374e-7a9982a9a8cd@farpost.com>
 <5c4c0648-2a96-4132-9d22-91c22e7c7d4d@huawei.com>
 <eab812ef-ba79-11d6-0a4e-232872f0fcc4@farpost.com>
 <877e7xl029.fsf@notabene.neil.brown.name>
From:   Sergei Turchanov <turchanov@farpost.com>
Organization: FarPost
Message-ID: <2d54ca59-9c22-0b75-3087-3718b30b8d11@farpost.com>
Date:   Fri, 2 Aug 2019 11:40:02 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <877e7xl029.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: ru-RU
Content-Transfer-Encoding: 8BIT
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

Yes, your patch fixed this bug.
Thank you very much!

With best regards,
Sergei.

On 01.08.2019 19:14, NeilBrown wrote:
> On Thu, Aug 01 2019, Sergei Turchanov wrote:
>
>> Hello!
>>
>> [
>>    As suggested in previous discussion this behavior may be caused by your
>>    commit 1f4aace60b0e ("fs/seq_file.c: simplify seq_file iteration code and interface")
>> ]
> Yes.... I think I can see what happened.
>   removing:
> -               if (!m->count) {
> -                       m->from = 0;
> -                       m->index++;
> -               }
>
> from seq_read meant that ->index didn't get updated in a case that it
> needs to be.
>
> Please confirm that the following patch fixes the problem.
> I think it is correct, but I need to look it over more carefully in the
> morning, and see if I can explain why it is correct.
>
> Thanks for the report.
> NeilBrown
>
> diff --git a/fs/seq_file.c b/fs/seq_file.c
> index 04f09689cd6d..1600034a929b 100644
> --- a/fs/seq_file.c
> +++ b/fs/seq_file.c
> @@ -119,6 +119,7 @@ static int traverse(struct seq_file *m, loff_t offset)
>   		}
>   		if (seq_has_overflowed(m))
>   			goto Eoverflow;
> +		p = m->op->next(m, p, &m->index);
>   		if (pos + m->count > offset) {
>   			m->from = offset - pos;
>   			m->count -= m->from;
> @@ -126,7 +127,6 @@ static int traverse(struct seq_file *m, loff_t offset)
>   		}
>   		pos += m->count;
>   		m->count = 0;
> -		p = m->op->next(m, p, &m->index);
>   		if (pos == offset)
>   			break;
>   	}
>
>
>> Original bug report:
>>
>> Seeking (to an offset within file size) in /proc/meminfo is broken in 4.19.59. It does seek to a desired position, but reading from that position returns the remainder of file and then a whole copy of file. This doesn't happen with /proc/vmstat or /proc/self/maps for example.
>>
>> Seeking did work correctly in kernel 4.14.47. So it seems something broke in the way.
>>
>> Background: this kind of access pattern (seeking to /proc/meminfo) is used by libvirt-lxc fuse driver for virtualized view of /proc/meminfo. So that /proc/meminfo is broken in guests when running kernel 4.19.x.
>>
>>   > On 01.08.2019 17:11, Gao Xiang wrote:
>>> Hi,
>>>
>>> I just took a glance, maybe due to
>>> commit 1f4aace60b0e ("fs/seq_file.c: simplify seq_file iteration code and interface")
>>>
>>> I simply reverted it just now and it seems fine... but I haven't digged into this commit.
>>>
>>> Maybe you could Cc NeilBrown <neilb@suse.com> for some more advice and
>>> I have no idea whether it's an expected behavior or not...
>>>
>>> Thanks,
>>> Gao Xiang
>>>
>>> On 2019/8/1 14:16, Sergei Turchanov wrote:
>>
>> $ ./test /proc/meminfo 0        # Works as expected
>>
>> MemTotal:       394907728 kB
>> MemFree:        173738328 kB
>> ...
>> DirectMap2M:    13062144 kB
>> DirectMap1G:    390070272 kB
>>
>> -----------------------------------------------------------------------
>>
>> $ ./test /proc/meminfo 1024     # returns a copy of file after the remainder
>>
>> Will seek to 1024
>>
>>
>> Data read at offset 1024
>> gePages:         0 kB
>> ShmemHugePages:        0 kB
>> ShmemPmdMapped:        0 kB
>> HugePages_Total:       0
>> HugePages_Free:        0
>> HugePages_Rsvd:        0
>> HugePages_Surp:        0
>> Hugepagesize:       2048 kB
>> Hugetlb:               0 kB
>> DirectMap4k:      245204 kB
>> DirectMap2M:    13062144 kB
>> DirectMap1G:    390070272 kB
>> MemTotal:       394907728 kB
>> MemFree:        173738328 kB
>> MemAvailable:   379989680 kB
>> Buffers:          355812 kB
>> Cached:         207216224 kB
>> ...
>> DirectMap2M:    13062144 kB
>> DirectMap1G:    390070272 kB
>>
>> As you see, after "DirectMap1G:" line, a whole copy of /proc/meminfo returned by "read".
>>
>> Test program:
>>
>> #include <sys/types.h>
>> #include <sys/stat.h>
>> #include <unistd.h>
>> #include <fcntl.h>
>> #include <stdio.h>
>> #include <stdlib.h>
>>
>> #define SIZE 1024
>> char buf[SIZE + 1];
>>
>> int main(int argc, char *argv[]) {
>>       int     fd;
>>       ssize_t rd;
>>       off_t   ofs = 0;
>>
>>       if (argc < 2) {
>>           printf("Usage: test <file> [<offset>]\n");
>>           exit(1);
>>       }
>>
>>       if (-1 == (fd = open(argv[1], O_RDONLY))) {
>>           perror("open failed");
>>           exit(1);
>>       }
>>
>>       if (argc > 2) {
>>           ofs = atol(argv[2]);
>>       }
>>       printf("Will seek to %ld\n", ofs);
>>
>>       if (-1 == (lseek(fd, ofs, SEEK_SET))) {
>>           perror("lseek failed");
>>           exit(1);
>>       }
>>
>>       for (;; ofs += rd) {
>>           printf("\n\nData read at offset %ld\n", ofs);
>>           if (-1 == (rd = read(fd, buf, SIZE))) {
>>               perror("read failed");
>>               exit(1);
>>           }
>>           buf[rd] = '\0';
>>           printf(buf);
>>           if (rd < SIZE) {
>>               break;
>>           }
>>       }
>>
>>       return 0;
>> }


