Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738FA4FCCEC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Apr 2022 05:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236713AbiDLDT2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 23:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233603AbiDLDT0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 23:19:26 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C2D32EEE;
        Mon, 11 Apr 2022 20:17:07 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0V9saviW_1649733421;
Received: from 30.225.24.141(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V9saviW_1649733421)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 12 Apr 2022 11:17:03 +0800
Message-ID: <65116657-bf3f-94ae-9565-fa15b4ebcd83@linux.alibaba.com>
Date:   Tue, 12 Apr 2022 11:17:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v8 07/20] cachefiles: document on-demand read mode
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, xiang@kernel.org, chao@kernel.org,
        linux-erofs@lists.ozlabs.org, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, willy@infradead.org,
        linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org, luodaowen.backend@bytedance.com,
        tianzichen@kuaishou.com, fannaihao@baidu.com
References: <20220406075612.60298-8-jefflexu@linux.alibaba.com>
 <20220406075612.60298-1-jefflexu@linux.alibaba.com>
 <1094292.1649684331@warthog.procyon.org.uk>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <1094292.1649684331@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.5 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, thanks for such thorough and detailed reviewing and all these
corrections. I will fix them in the next version.


On 4/11/22 9:38 PM, David Howells wrote:
> Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
> 
>> + (*) On-demand Read.
>> +
> 
> Unnecessary extra blank line.
> 
> Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
> 
> What's the scope of the uniqueness of "id"?  Is it just unique to a particular
> cachefiles cache?

Yes. Currently each cache, I mean, each "struct cachefiles_cache",
maintains an xarray. The id is unique in the scope of the cache.


> 
>> +
>> +	struct cachefiles_close {
>> +		__u32 fd;
>> +	};
>> +
> 
> "where:"
> 
>> +	* ``fd`` identifies the anon_fd to be closed, which is exactly the same
> 
> "... which should be the same as that provided to the OPEN request".
> 
> Is it possible for userspace to move the fd around with dup() or whatever?

Currently No. The anon_fd is stored in

```
struct cachefiles_object {
	int fd;
	...
}
```

When sending READ/CLOSE request, the associated anon_fd is all fetched
from @fd field of struct cachefiles_object. dup() won't update @fd field
of struct cachefiles_object.

Thus when dup() is done, let's say there are fd A (original) and fd B
(duplicated from fd A) associated to the cachefiles_object. Then the @fd
field of following READ/CLOSE requests is always fd A, since @fd field
of struct cachefiles_object is not updated. However the CREAD (reply to
READ request) ioctl indeed can be done on either fd A or fd B.

Then when fd A is closed while fd B is still alive, @fd field of
following READ/CLOSE requests is still fd A, which is indeed buggy since
fd A can be reused then.

To fix this, I plan to replace @fd field of READ/CLOSE requests with
@object_id field.

```
struct cachefiles_close {
        __u32 object_id;
};


struct cachefiles_read {
        __u32 object_id;
        __u64 off;
        __u64 len;
};
```

Then each cachefiles_object has a unique object_id (in the scope of
cachefiles_cache). Each object_id can be mapped to multiple fds (1:N
mapping), while kernel only send an initial fd of this object_id through
OPEN request.

```
struct cachefiles_open {
	__u32 object_id;
        __u32 fd;
        __u32 volume_key_size;
        __u32 cookie_key_size;
        __u32 flags;
        __u8  data[];
};
```

The user daemon can modify the mapping through dup(), but it's
responsible for maintaining and updating this mapping. That is, the
mapping between object_id and all its associated fds should be
maintained in the user space.


>> +
>> +	struct cachefiles_read {
>> +		__u64 off;
>> +		__u64 len;
>> +		__u32 fd;
>> +	};
>> +
>> +	* ``off`` identifies the starting offset of the requested file range.
> 
> identifies -> indicates
> 
>> +
>> +	* ``len`` identifies the length of the requested file range.
>> +
> 
> identifies -> indicates (you could alternatively say "specified")
> 
>> +	* ``fd`` identifies the anonymous fd of the requested cache file. It is
>> +	  guaranteed that it shall be the same with
> 
> "same with" -> "same as"
> 
> Since the kernel cannot make such a guarantee, I think you may need to restate
> this as something like "Userspace must present the same fd as was given in the
> previous OPEN request".

Yes, whether the @fd field of READ request is same as that of OPEN
request or not, is actually implementation dependent. However as
described above, I'm going to change @fd field into @object_id field.
After that refactoring, the @object_id field of READ/CLOSE request
should be the same as the @object_id filed of CLOSE request.



>> +CACHEFILES_IOC_CREAD ioctl on the corresponding anon_fd::
>> +
>> +	ioctl(fd, CACHEFILES_IOC_CREAD, id);
>> +
>> +	* ``fd`` is exactly the fd field of the previous READ request.
> 
> Does that have to be true?  What if userspace moves it somewhere else?
> 

As described above, I'm going to change @fd field into @object_id field.
Then there is an @object_id filed in READ request. When replying the
READ request, the user daemon itself needs to get the corresponding
anon_fd of the given @object_id through the self-maintained mapping.


-- 
Thanks,
Jeffle
