Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAD63753A5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 May 2021 14:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbhEFMSD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 May 2021 08:18:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:39450 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229777AbhEFMSC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 May 2021 08:18:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D9432B1BC;
        Thu,  6 May 2021 12:17:03 +0000 (UTC)
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id d11f9587;
        Thu, 6 May 2021 12:18:34 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.de>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: Re: 9p: fscache duplicate cookie
References: <87czu45gcs.fsf@suse.de> <YJPIyLZ9ofnPy3F6@codewreck.org>
Date:   Thu, 06 May 2021 13:18:34 +0100
In-Reply-To: <YJPIyLZ9ofnPy3F6@codewreck.org> (Dominique Martinet's message of
        "Thu, 6 May 2021 19:45:28 +0900")
Message-ID: <87zgx83vj9.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dominique Martinet <asmadeus@codewreck.org> writes:

> Hi,
>
> Luis Henriques wrote on Thu, May 06, 2021 at 11:03:31AM +0100:
>> I've been seeing fscache complaining about duplicate cookies in 9p:
>> 
>>  FS-Cache: Duplicate cookie detected
>>  FS-Cache: O-cookie c=00000000ba929e80 [p=000000002e706df1 fl=226 nc=0 na=1]
>>  FS-Cache: O-cookie d=0000000000000000 n=0000000000000000
>>  FS-Cache: O-key=[8] '0312710100000000'
>>  FS-Cache: N-cookie c=00000000274050fe [p=000000002e706df1 fl=2 nc=0 na=1]
>>  FS-Cache: N-cookie d=0000000037368b65 n=000000004047ed1f
>>  FS-Cache: N-key=[8] '0312710100000000'
>
>> It's quite easy to reproduce in my environment by running xfstests using
>> the virtme scripts to boot a test kernel.  A quick look seems to indicate
>> the warning comes from the v9fs_vfs_atomic_open_dotl() path:
>> 
>> [...]
>> 
>> Is this a know issue?
>
> I normally don't use fscache so never really looked into it, I saw it
> again recently when looking at David's fscache/netfs work and it didn't
> seem to cause real trouble without a server but I bet it would if there
> were to be one, I just never had the time to look further.
>
> From a quick look v9fs uses the 'qid path' of the inode that is
> supposed to be a unique identifier; in practice there are various
> heuristics to it depending on the server but qemu takes the st_dev of
> the underlying filesystem and chops the higher bits of the inode number
> to make it up -- see qid_path_suffixmap() in hw/9pfs/9p.c in qemu
> sources.
>
> (protocol description can be found here:
> https://github.com/chaos/diod/blob/master/protocol.md
> )
>
>
> In this case if there is a cookie collision there are two possibilities
> I can see: either a previously hashed inode somehow got cleaned up
> without the associated fscache cleanup or qemu dished out the same qid
> path for two different files -- old filesystems used to have predictable
> inode numbers but that is far from true anymore so it's quite possible
> some files would have the same lower bits for their inode number on the
> host...
> If you have the time to investigate further that would be appreciated, I
> have confirmed the fscache rework David suggested did not fix it so the
> work will not be lost.
>
>
> That's going to be very verbose but if you're not scared of digging at
> logs a possible way to confirm qid identity would be to mount with -o
> debug=5 (P9_DEBUG_9P + ERROR), all qid paths are logged to dmesg, but
> that might not be viable if there is a real lot -- it depends on how
> fast and reliable your quite easy to reproduce is...

Thanks a lot for the quick reply, Dominique.  I'll definitely allocate
some time to try to find a bit more about this issue (although I may end
up just hacking the code to print out the qids instead of turning on all
the debug).  I just wanted to make sure I wasn't hitting some known
fundamental problem that simply couldn't be fixed without major changes.

Cheers,
-- 
Luis
