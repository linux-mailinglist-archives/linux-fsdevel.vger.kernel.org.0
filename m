Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED22124EA19
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Aug 2020 00:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgHVWsM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Aug 2020 18:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbgHVWsK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Aug 2020 18:48:10 -0400
Received: from shout01.mail.de (shout01.mail.de [IPv6:2001:868:100:600::216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50DFC061573
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Aug 2020 15:48:08 -0700 (PDT)
Received: from postfix01.mail.de (postfix02.bt.mail.de [10.0.121.126])
        by shout01.mail.de (Postfix) with ESMTP id 1AB2E1002DA;
        Sun, 23 Aug 2020 00:47:57 +0200 (CEST)
Received: from smtp04.mail.de (smtp04.bt.mail.de [10.0.121.214])
        by postfix01.mail.de (Postfix) with ESMTP id 01861A002B;
        Sun, 23 Aug 2020 00:47:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
        s=mailde201610; t=1598136477;
        bh=QokiOLPGZApJfCtnTqSbil/5509D45ZST8EQRyl0bIY=;
        h=From:Subject:To:Cc:References:Date:In-Reply-To:From;
        b=Jy7fQgCmEIIO4x00rKPDRSJuiY2yqaNElGQuP4ft7ZsA/LT7JBZ1AHLTSF5rPEXDZ
         wACI7puDGvbzng3+al/IwB55icBY481i1/OwLpGZRWAwyoninUcrK0mg8AphhZ+4Pc
         Sc11TMZh6mRhCvKRhT21aKT9d17zJZA4mUR7G4H4=
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp04.mail.de (Postfix) with ESMTPSA id 418BBC0038;
        Sun, 23 Aug 2020 00:47:56 +0200 (CEST)
From:   Tycho Kirchner <tychokirchner@mail.de>
Subject: Re: fanotify feature request FAN_MARK_PID
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <dde082eb-b3eb-859e-b442-a65846cff6fa@mail.de>
 <CAOQ4uxjEm=vj5Be5VoUyB9Q+YVq=+aO_4PfXp-iEYZA7qzO1Gw@mail.gmail.com>
Message-ID: <9def9581-cc09-7a79-ea27-e9b8b75bbd6a@mail.de>
Date:   Sun, 23 Aug 2020 00:47:55 +0200
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxjEm=vj5Be5VoUyB9Q+YVq=+aO_4PfXp-iEYZA7qzO1Gw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 5642
X-purgate-ID: 154282::1598136476-00000568-4D9014DB/0/0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Amir, and Thanks for the quick response!

> strace, seccomp, and eBPF


Also thanks for these tips. However:

strace
Is a performance killer. As shournal tracks everyday work on the shell 
and also runs e.g. during expensive genomic analysis, ptrace-based 
approaches are not acceptable here.

seccomp and eBPF
Thanks - I took a deeper look at BPF and the PID-filtering is very nice, 
following child-processes/forks looks also doable; maybe it's better to 
implement it with cgroups(?)..

However, using the current fanotify-approach, to recognize files later, 
consuming the FAN_CLOSE_WRITE-event they are xxHashed (partially, based 
on size) using the passed file-descriptor, which is very nice, because 
renaming/etc does no harm (resolving a path and opening the fd later 
introduces a race condition).
Thus, with BPF, one might try to trace fs/file.c:__close_fd.
Calculating the hash in kernel-mode would be ideal but reading bytes 
from files is not allowed in BPF-programs.
As far as I can tell, BPF also does not support sending the fd to the 
user-space-process (like fanotify does).
The last acceptable resort would have been to resolve the path (within 
BPF) using the fdtable from files_struct *files, but this is not allowed 
within a BPF-program, because it might produce a page fault (see [1] - 
kernel-patch with bpf_fd2path is available, but not in mainline).
Resoling the path in userspace with the known pid and fd-number using 
/proc/$pid/fd/$fdnum is possible but the process might be gone already.

Any further help is appreciated.

Thanks,
Tycho


[1]: https://github.com/iovisor/bcc/issues/2538#issuecomment-541393483



Am 17.08.20 um 19:02 schrieb Amir Goldstein:
> On Mon, Aug 17, 2020 at 7:08 PM Tycho Kirchner <tychokirchner@mail.de> wrote:
>>
>> Dear Amir Goldstein,
>>
> 
> Hi Tycho,
> 
> 
>> Dear Matthew Bobrowski,
>>
>> Dear developers of the kernel filesystem,
>>
>> First of all, thanks for your effort in improving Linux, especially your
>> work regarding fanotify, which I heavily use in one of my projects:
>>
>> https://github.com/tycho-kirchner/shournal
>>
> 
> Nice project!
> 
>> For a more scientfic introduction please take a look at
>> Bashing irreproducibility with shournal
>> https://doi.org/10.1101/2020.08.03.232843
>>
>> I wanted to kindly ask you, whether it is possible for you to add
>> another feature to fanotify, that is reporting only events of a PID or
>> any of its children.
>> This would be very useful, because especially in the world of
>> bioinformatics there is a huge need to automatically and efficiently
>> track file events on the shell, that is, you enter a command on the
>> shell (bash) and then track, which file events were modified by the
>> shell or any of its child-processes.
> 
> I am not sure if fanotify is the right tool for the job.
> fanotify is a *system* monitoring tool and its functionality is very limited.
> If you want to watch what file operations a process and its children are doing,
> you can use more powerful tracing tools like strace, seccomp, and eBPF.
> For starters, did you look at bcc tools, for example:
> https://github.com/iovisor/bcc/blob/master/tools/opensnoop.py
> 
> [...]
> 
>> I imagine e.g. the following syscalls:
>>
>> 1.
>> Use fanotify_mark to restrict the fanotify notification group to a
>> specific PID, optionally marking forked children as well.
>> fanotify_mark(fan_fd, FAN_MARK_ADD | FAN_MARK_PID, FAN_EVENT_ON_CHILD,
>> pid, NULL);
>> // FAN_EVENT_ON_CHILD -> additional meaning: also forked child processes.
>>
> 
> Technically, it is quite easy to filter out events generated by
> processes outside
> pid namespace (which would report pid 0), but I doubt if the use case you
> presented justifies that. Maybe there are other use cases...
> 
>> 2.
>> Use fanotify_mark to remove a PID from the notification group.
>> fanotify_mark(fan_fd, FAN_MARK_REMOVE | FAN_MARK_PID, 0, pid, NULL);
>>
>> 3.
>> When reading from a fan_fd, which is marked for PID's which have all
>> ended or were removed, return e.g. ENOENT.
>>
>>
>> Independent of that it would be also useful, to be able to track
>> applications, which unshare their mount namespace as well (e.g.
>> flatpak). So in case a process, whose mount points are observed,
>> unshares, the new mount id's should also be added to the same fanotify
>> notification group. To preserve backwards compatibility I suggest
>> introducing a new flag FAN_MARK_MOUNT_REC:
>> fanotify_mark(fan_fd, FAN_MARK_ADD | FAN_MARK_MOUNT |
>> FAN_MARK_MOUNT_REC, mask, AT_FDCWD, path);
>>
> 
> The inherited mark concept sounds useful.
> I also thought of a likewise flag for directories.
> The question is if and how you clean all the inherited marks when program
> removes the original mark. It's an API question. Not a trivial one IMO.
> 
> The thing is, with FAN_MARK_FILESYSTEM (v5.1), you can sort of implement
> what you want in userspace with the opposite approach:
> 1. Watch events on filesystem regardless of which mount
> 2. When getting an event with an open fd, resolve the mount
> 3. If you are NOT interested in that mount add a FAN_MARK_IGNORED
>      mask on that mount
> 4. Soon, you will be left with only the events you care about
> 5. When mount is unshared, you will get the events generated on that mount
> 
> But that will only work if the unshared mount is visible in the mount namespace
> of the listener, so it is not a complete solution, but maybe it works for some
> of your use cases.
> 
> Thanks,
> Amir.
> 
