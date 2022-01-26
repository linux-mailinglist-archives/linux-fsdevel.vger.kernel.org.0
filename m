Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3920F49C37E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 07:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234959AbiAZGLA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 01:11:00 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:47915 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229772AbiAZGK5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 01:10:57 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V2uAg.f_1643177453;
Received: from 30.225.24.77(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V2uAg.f_1643177453)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 26 Jan 2022 14:10:55 +0800
Message-ID: <8f88459a-97e0-8b8d-3ec9-260d482a0d38@linux.alibaba.com>
Date:   Wed, 26 Jan 2022 14:10:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH v2 00/20] fscache,erofs: fscache-based demand-read
 semantics
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, xiang@kernel.org, chao@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org
References: <20220118131216.85338-1-jefflexu@linux.alibaba.com>
 <2815558.1643127330@warthog.procyon.org.uk>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <2815558.1643127330@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 1/26/22 12:15 AM, David Howells wrote:
> Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
> 
>> The following issues still need further discussion. Thanks for your time
>> and patience.
>>
>> 1. I noticed that there's refactoring of netfs library[1],
>> ...
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=netfs-lib
> 
> Yes.  I'm working towards getting netfslib to do handling writes and dio as
> well as reads, along with content crypto/compression, and the idea I'm aiming
> towards is that you just point your address_space_ops at netfs directly if
> possible - but it's going to require its own context now to manage pending
> writes.
> 
> See my netfs-experimental branch for more of that - it's still a work in
> progress, though.

Got it.

> 
> Btw, you could set rreq->netfs_priv in ->init_rreq() rather than passing it in
> to netfs_readpage().
> 
>> 2. The current implementation will severely conflict with the
>> refactoring of netfs library[1][2]. The assumption of 'struct
>> netfs_i_context' [2] is that, every file in the upper netfs will
>> correspond to only one backing file. While in our scenario, one file in
>> erofs can correspond to multiple backing files. That is, the content of
>> one file can be divided into multiple chunks, and are distrubuted over
>> multiple blob files, i.e. multiple backing files. Currently I have no
>> good idea solving this conflic.
> 
> I can think of a couple of options to explore:
> 
>  (1) Duplicate the cachefiles backend.  You can discard a lot of it, since a
>      much of it is concerned with managing local modifications - which you're
>      not going to do since you have a R/O filesystem and you're looking at
>      importing files into the cache externally to the kernel.
> 


>      I would suggest looking to see if you can do the blob mapping in the
>      backend rather than passing the offset down.  Maybe make the cookie index
>      key hold the index too, e.g. "/path/to/file+offset".

Have been discussed in [1].

[1]
https://lore.kernel.org/lkml/Yeeye2AUZITDsdh8@B-P7TQMD6M-0146.local/T/#m25b1229f96bf24929fb73746a07e9996e8222ac6


"/path/to/file+offset"
		^

Besides, what does the 'offset' mean?


> 
>      Btw, do you still need cachefilesd for its culling duties?

Yes we still need cache management in this on-demand scenario, in case
of backing files exhausting the available blocks. (Though these backing
files are prepared by daemon in advance, these files can all be sparse
files.) And similarly the actual culling work should be done under
protection of S_KERNEL_FILE, so that the culled backing file can't be
picked back up.

> 
>  (2) Do you actually need to go through netfslib?  Might it be easier to call
>      fscache_read() directly?  Have a look at fs/nfs/fscache.c

It would be great if we can use fscache_read() directly.


> 
>> Besides there are still two quetions:
>> - What's the plan of [1]? When is it planned to be merged?
> 
> Hopefully next merge window, but that's going to depend on a number of things.
> 
>> - It seems that all upper fs using fscache is going to use netfs API,
>>   while the APIs like fscache_read_or_alloc_page() are deprecated. Is
>>   that true?
> 
> fscache_read_or_alloc_page() is gone completely.
> 
> You don't have to use the netfs API.  You can talk to fscache directly,
> doing DIO from the cache to an xarray-class iov_iter constructed from your
> inode's pagecache.
> 
> netfslib provides/will provide a number of services, such as multipage
> folios, transparent caching, crypto, compression and hiding the existence of
> pages/folios from the filesystem as entirely as possible.  However, you
> already have some of these implemented on top of iomap for the blockdev
> interface, it would appear.
> 

Got it.


In summary,

1) I prefer option 2, i.e. calling fscache_read() directly, as the one
at hand. In this case, the conflict with the netfs lib refactoring can
be avoided. Besides, there will be less modification needed to
cachefiles/netfs. Patch 1~3 are no longer required, while patch 4~6 are
still needed, which mainly introduce the new devnode.

2) Later we can change to option 1, i.e. calling netfs lib and also a
potential new R/O backend, if the issues in [1] can be clarified or solved.

[1]
https://lore.kernel.org/lkml/Yeeye2AUZITDsdh8@B-P7TQMD6M-0146.local/T/#m25b1229f96bf24929fb73746a07e9996e8222ac6

-- 
Thanks,
Jeffle
