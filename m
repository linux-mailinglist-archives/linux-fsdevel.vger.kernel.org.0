Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F8C686344
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Feb 2023 11:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjBAKBN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Feb 2023 05:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjBAKBM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Feb 2023 05:01:12 -0500
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE72611FB;
        Wed,  1 Feb 2023 02:01:08 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R281e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VagQuEQ_1675245665;
Received: from 30.97.49.11(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VagQuEQ_1675245665)
          by smtp.aliyun-inc.com;
          Wed, 01 Feb 2023 18:01:06 +0800
Message-ID: <0d2ef9d6-3b0e-364d-ec2f-c61b19d638e2@linux.alibaba.com>
Date:   Wed, 1 Feb 2023 18:01:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v3 0/6] Composefs: an opportunistically sharing verified
 image filesystem
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
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <071074ad149b189661681aada453995741f75039.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/2/1 17:46, Alexander Larsson wrote:

...

>>
>>                                    | uncached(ms)| cached(ms)
>> ----------------------------------|-------------|-----------
>> composefs (with digest)           | 326         | 135
>> erofs (w/o -T0)                   | 264         | 172
>> erofs (w/o -T0) + overlayfs       | 651         | 238
>> squashfs (compressed)	            | 538         | 211
>> squashfs (compressed) + overlayfs | 968         | 302
> 
> 
> Clearly erofs with sparse files is the best fs now for the ro-fs +
> overlay case. But still, we can see that the additional cost of the
> overlayfs layer is not negligible.
> 
> According to amir this could be helped by a special composefs-like mode
> in overlayfs, but its unclear what performance that would reach, and
> we're then talking net new development that further complicates the
> overlayfs codebase. Its not clear to me which alternative is easier to
> develop/maintain.
> 
> Also, the difference between cached and uncached here is less than in
> my tests. Probably because my test image was larger. With the test
> image I use, the results are:
> 
>                                    | uncached(ms)| cached(ms)
> ----------------------------------|-------------|-----------
> composefs (with digest)           | 681         | 390
> erofs (w/o -T0) + overlayfs       | 1788        | 532
> squashfs (compressed) + overlayfs | 2547        | 443
> 
> 
> I gotta say it is weird though that squashfs performed better than
> erofs in the cached case. May be worth looking into. The test data I'm
> using is available here:

As another wild guess, cached performance is a just vfs-stuff.

I think the performance difference may be due to ACL (since both
composefs and squashfs don't support ACL).  I already asked Jingbo
to get more "perf data" to analyze this but he's now busy in another
stuff.

Again, my overall point is quite simple as always, currently
composefs is a read-only filesystem with massive symlink-like files.
It behaves as a subset of all generic read-only filesystems just
for this specific use cases.

In facts there are many options to improve this (much like Amir
said before):
   1) improve overlayfs, and then it can be used with any local fs;

   2) enhance erofs to support this (even without on-disk change);

   3) introduce fs/composefs;

In addition to option 1), option 2) has many benefits as well, since
your manifest files can save real regular files in addition to composefs
model.

Even if you guys still consider 3), I'm not sure that is all codebase
you will just do bugfix and don't add any new features like what I
said.  So eventually, I still think that is another read-only fs which
is much similar to compressed-part-truncated EROFS.


Thanks,
Gao Xiang


>    
> https://my.owndrive.com/index.php/s/irHJXRpZHtT3a5i
> 
> 
