Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACECE49C337
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 06:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbiAZF0g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 00:26:36 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:34963 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231165AbiAZF0f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 00:26:35 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V2tupFr_1643174792;
Received: from 30.225.24.77(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V2tupFr_1643174792)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 26 Jan 2022 13:26:33 +0800
Message-ID: <2946d871-b9e1-cf29-6d39-bcab30f2854f@linux.alibaba.com>
Date:   Wed, 26 Jan 2022 13:26:32 +0800
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
References: <2815558.1643127330@warthog.procyon.org.uk>
 <20220118131216.85338-1-jefflexu@linux.alibaba.com>
 <3116562.1643142458@warthog.procyon.org.uk>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <3116562.1643142458@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 1/26/22 4:27 AM, David Howells wrote:
> David Howells <dhowells@redhat.com> wrote:
> 
>>  (1) Duplicate the cachefiles backend.  You can discard a lot of it, since a
>>      much of it is concerned with managing local modifications - which you're
>>      not going to do since you have a R/O filesystem and you're looking at
>>      importing files into the cache externally to the kernel.
> 
> Take the attached as a start.  It's completely untested.  I've stripped out
> anything to do with writing to the cache, making directories, etc. as that can
> probably be delegated to the on-demand creation.  You could drive on-demand
> creation from the points where it would create files.  I've put some "TODO"
> comments in there as markers.

Thanks for your inspiring work. Some questions below.

> 
> You could also strip out everything to do with invalidation and also make it
> just fail if it encounters a file type that it doesn't like or a file that is
> not correctly labelled for a coherency attribute.
> 
> Also, since you aren't intending to write anything or create new files here,
> there's no need to do the space checking - so I've got rid of all that too.
> 
> I've also made it open the backing files read only and got rid of the trimming
> to I/O blocksize for DIO purposes.  The userspace side can take care of that -
> and, besides, you want to have multiple files within a backing file, right?
> 
> You might want to stop it from marking cache *files* in use (but only mark
> directories).  It doesn't matter so much as you aren't going to get coherency
> issues from having multiple writers to the same file.
> 


> You then need to add a file offset member to the erofscache_object struct, set
> that when the backing file is looked up and add it to the file position in
> erofscache_read().  You also need to look at erofscache_prepare_read().  If
> your files are contiguous complete blobs, that can be a lot simpler.

To be honest, I'm not sure if I get your points correctly. Do you mean
each file in erofs has only one chunk (and thus corresponds to only one
backing blob file), so that netfs lib can work well while given the only
cookie associated with the netfs file?

By the way, let me explain the blob mapping in erofs further. To
implement deduplication, one erofs file can be divided into multiple
chunks, while these chunks can be distributed over several backing blob
files quite randomly (rather than a round-robin style). Each erofs file
maintains an on-disk map describing the mapping relationship between
chunks and backing blob files. Something like the extent map. Thus
there's a multi-to-multi relationship between erofs file and backing
blob file.

Thus each erofs file can correspond to multiple cookies in this way,
i.e. one 'struct netfs_i_context' can correspond to multiple cookies.
Besides, the mapping relationship between chunks and backing blob files
is totally implemented in upper fs (i.e. erofs), I have no idea how we
can "do the blob mapping in the backend" [1]. So I don't think we can
use netfs lib **directly** even with this R/O fscache backend
implemented. Please correct me if I misunderstand it.


[1]
https://lore.kernel.org/lkml/Yeeye2AUZITDsdh8@B-P7TQMD6M-0146.local/T/#mfbb2053476760d8fac723c57dad529192a5084c6


Besides, IMHO it may suffer great challenges when implementing a new R/O
backend, since there's quite many code duplication. I know it's just a
starting version from scratch, but I'm not sure if it's worth it.

-- 
Thanks,
Jeffle
