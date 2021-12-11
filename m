Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 964C94711F2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Dec 2021 06:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhLKFg1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Dec 2021 00:36:27 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:54496 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229630AbhLKFg0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Dec 2021 00:36:26 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V-DjWG1_1639200767;
Received: from 192.168.31.65(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V-DjWG1_1639200767)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 11 Dec 2021 13:32:48 +0800
Message-ID: <aff937a0-b8fb-b9fc-22ef-d0099b392461@linux.alibaba.com>
Date:   Sat, 11 Dec 2021 13:32:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [RFC 02/19] cachefiles: implement key scheme for demand-read mode
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, xiang@kernel.org, chao@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org
References: <20211210073619.21667-3-jefflexu@linux.alibaba.com>
 <20211210073619.21667-1-jefflexu@linux.alibaba.com>
 <269788.1639134293@warthog.procyon.org.uk>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <269788.1639134293@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 12/10/21 7:04 PM, David Howells wrote:
> Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
> 
>> Thus simplify the logic of placing backing files, in which backing files
>> are under "cache/<volume>/" directory directly.
> 
> You then have a scalability issue on the directory inode lock - and there may
> also be limits on the capacity of a directory.  The hash function is meant to
> work the same, no matter the cpu arch, so you should be able to copy that to
> userspace and derive the hash yourself.

Yes, as described in the cover letter, I plan to make the hashing
algorithm used by cachefiles built-in into our user daemon, so that the
user daemon could place the blob file on the right place. Then the core
logic of cachefiles won't be touched as much as possible.

> 
>> Also skip coherency checking currently to ease the development and debug.
> 
> Better if you can do that in erofs rather than cachefiles.  Just set your
> coherency data to all zeros or something.
> 

Yes it is preferred to keep the general part of cachefiles untouched.
Later we can set "CacheFiles.cache" xattr on blob files in advance to
pass this check.


-- 
Thanks,
Jeffle
