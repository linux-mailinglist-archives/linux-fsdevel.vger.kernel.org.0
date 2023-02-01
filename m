Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169D4686550
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Feb 2023 12:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbjBALW1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Feb 2023 06:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbjBALWZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Feb 2023 06:22:25 -0500
Received: from out30-1.freemail.mail.aliyun.com (out30-1.freemail.mail.aliyun.com [115.124.30.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B8010C1;
        Wed,  1 Feb 2023 03:22:23 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R641e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0Vaglma6_1675250539;
Received: from 30.97.49.11(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vaglma6_1675250539)
          by smtp.aliyun-inc.com;
          Wed, 01 Feb 2023 19:22:20 +0800
Message-ID: <de57aefc-30e8-470d-bf61-a1cca6514988@linux.alibaba.com>
Date:   Wed, 1 Feb 2023 19:22:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v3 0/6] Composefs: an opportunistically sharing verified
 image filesystem
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Alexander Larsson <alexl@redhat.com>,
        Jingbo Xu <jefflexu@linux.alibaba.com>,
        Amir Goldstein <amir73il@gmail.com>, gscrivan@redhat.com,
        brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        david@fromorbit.com, viro@zeniv.linux.org.uk,
        Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
References: <cover.1674227308.git.alexl@redhat.com>
 <CAOQ4uxgGc33_QVBXMbQTnmbpHio4amv=W7ax2vQ1UMet0k_KoA@mail.gmail.com>
 <1ea88c8d1e666b85342374ed7c0ddf7d661e0ee1.camel@redhat.com>
 <CAOQ4uxinsBB-LpGh4h44m6Afv0VT5yWRveDG7sNvE2uJyEGOkg@mail.gmail.com>
 <5fb32a1297821040edd8c19ce796fc0540101653.camel@redhat.com>
 <CAOQ4uxhGX9NVxwsiBMP0q21ZRot6-UA0nGPp1wGNjgmKBjjBBA@mail.gmail.com>
 <b8601c976d6e5d3eccf6ef489da9768ad72f9571.camel@redhat.com>
 <e840d413-c1a7-d047-1a63-468b42571846@linux.alibaba.com>
 <2ef122849d6f35712b56ffbcc95805672980e185.camel@redhat.com>
 <8ffa28f5-77f6-6bde-5645-5fb799019bca@linux.alibaba.com>
 <51d9d1b3-2b2a-9b58-2f7f-f3a56c9e04ac@linux.alibaba.com>
 <071074ad149b189661681aada453995741f75039.camel@redhat.com>
 <0d2ef9d6-3b0e-364d-ec2f-c61b19d638e2@linux.alibaba.com>
In-Reply-To: <0d2ef9d6-3b0e-364d-ec2f-c61b19d638e2@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/2/1 18:01, Gao Xiang wrote:
> 
> 
> On 2023/2/1 17:46, Alexander Larsson wrote:
> 
> ...
> 
>>>
>>>                                    | uncached(ms)| cached(ms)
>>> ----------------------------------|-------------|-----------
>>> composefs (with digest)           | 326         | 135
>>> erofs (w/o -T0)                   | 264         | 172
>>> erofs (w/o -T0) + overlayfs       | 651         | 238
>>> squashfs (compressed)                | 538         | 211
>>> squashfs (compressed) + overlayfs | 968         | 302
>>
>>
>> Clearly erofs with sparse files is the best fs now for the ro-fs +
>> overlay case. But still, we can see that the additional cost of the
>> overlayfs layer is not negligible.
>>
>> According to amir this could be helped by a special composefs-like mode
>> in overlayfs, but its unclear what performance that would reach, and
>> we're then talking net new development that further complicates the
>> overlayfs codebase. Its not clear to me which alternative is easier to
>> develop/maintain.
>>
>> Also, the difference between cached and uncached here is less than in
>> my tests. Probably because my test image was larger. With the test
>> image I use, the results are:
>>
>>                                    | uncached(ms)| cached(ms)
>> ----------------------------------|-------------|-----------
>> composefs (with digest)           | 681         | 390
>> erofs (w/o -T0) + overlayfs       | 1788        | 532
>> squashfs (compressed) + overlayfs | 2547        | 443
>>
>>
>> I gotta say it is weird though that squashfs performed better than
>> erofs in the cached case. May be worth looking into. The test data I'm
>> using is available here:
> 
> As another wild guess, cached performance is a just vfs-stuff.
> 
> I think the performance difference may be due to ACL (since both
> composefs and squashfs don't support ACL).  I already asked Jingbo
> to get more "perf data" to analyze this but he's now busy in another
> stuff.
> 
> Again, my overall point is quite simple as always, currently
> composefs is a read-only filesystem with massive symlink-like files.
> It behaves as a subset of all generic read-only filesystems just
> for this specific use cases.
> 
> In facts there are many options to improve this (much like Amir
> said before):
>    1) improve overlayfs, and then it can be used with any local fs;
> 
>    2) enhance erofs to support this (even without on-disk change);
> 
>    3) introduce fs/composefs;
> 
> In addition to option 1), option 2) has many benefits as well, since
> your manifest files can save real regular files in addition to composefs
> model.

(add some words..)

My first response at that time (on Slack) was "kindly request
Giuseppe to ask in the fsdevel mailing list if this new overlay model
and use cases is feasable", if so, I'm much happy to integrate in to
EROFS (in a cooperative way) in several ways:

  - just use EROFS symlink layout and open such file in a stacked way;

or (now)

  - just identify overlayfs "trusted.overlay.redirect" in EROFS itself
    and open file so such image can be both used for EROFS only and
    EROFS + overlayfs.

If that happened, then I think the overlayfs "metacopy" option can
also be shown by other fs community people later (since I'm not an
overlay expert), but I'm not sure why they becomes impossible finally
and even not mentioned at all.

Or if you guys really don't want to use EROFS for whatever reasons
(EROFS is completely open-source, used, contributed by many vendors),
you could improve squashfs, ext4, or other exist local fses with this
new use cases (since they don't need any on-disk change as well, for
example, by using some xattr), I don't think it's really hard.

And like what you said in the other reply, "
On the contrary, erofs lookup is very similar to composefs. There is
nothing magical about it, we're talking about pre-computed, static
lists of names. What you do is you sort the names, put them in a
compact seek-free form, and then you binary search on them. Composefs
v3 has some changes to make larger directories slightly more efficient
(no chunking), but the general performance should be comparable.
" yet core EROFS was a 2017-2018 stuff since we're addressed common
issues of generic read-only use cases.

Also if you'd like to read all dir data and pin such pages in memory at
once.  If you run into an AI dataset with (typically) 10 million samples
or more in a dir, you will suffer from it under many devices with limited
memory. That is especially EROFS original target users.

I'm not sure how kernel filesystem upstream works like this (also a few
days ago, I heard another in-kernel new one called "tarfs" which
implements tar in ~500 loc (maybe) from confidental container guys, but
I don't really know how an unaligned unseekable archive format for tape
like tar works effectively without data block-aligned.)

Anyway, that is all what I could do now for your use cases.

> 
> Even if you guys still consider 3), I'm not sure that is all codebase
> you will just do bugfix and don't add any new features like what I
> said.  So eventually, I still think that is another read-only fs which
> is much similar to compressed-part-truncated EROFS.
> 
> 
> Thanks,
> Gao Xiang
> 
> 
>> https://my.owndrive.com/index.php/s/irHJXRpZHtT3a5i
>>
>>
