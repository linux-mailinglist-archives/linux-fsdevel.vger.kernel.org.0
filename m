Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038BD686614
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Feb 2023 13:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjBAMkA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Feb 2023 07:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBAMj7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Feb 2023 07:39:59 -0500
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A334D9;
        Wed,  1 Feb 2023 04:39:57 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0Vagso9Y_1675255193;
Received: from 192.168.31.66(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vagso9Y_1675255193)
          by smtp.aliyun-inc.com;
          Wed, 01 Feb 2023 20:39:54 +0800
Message-ID: <bba7c78e-ead3-fb42-8d04-1e376a7809b0@linux.alibaba.com>
Date:   Wed, 1 Feb 2023 20:39:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v3 0/6] Composefs: an opportunistically sharing verified
 image filesystem
Content-Language: en-US
To:     Alexander Larsson <alexl@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Gao Xiang <hsiangkao@linux.alibaba.com>, gscrivan@redhat.com,
        brauner@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, david@fromorbit.com,
        viro@zeniv.linux.org.uk, Vivek Goyal <vgoyal@redhat.com>,
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
 <CAOQ4uxhzGru2Z8tjcAWvKVi0reNeX9SHMi6cwdyA9Vws8c1ppw@mail.gmail.com>
 <ea8819bc-c340-bf4c-ad91-1a520fe3914b@linux.alibaba.com>
 <bb87534811ecd092bbc6d361df9d02aff35b17ed.camel@redhat.com>
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <bb87534811ecd092bbc6d361df9d02aff35b17ed.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
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



On 2/1/23 5:52 PM, Alexander Larsson wrote:
> On Wed, 2023-02-01 at 16:59 +0800, Jingbo Xu wrote:
>>
>> I redid the test with suggestion from Amir, with all files inside the
>> erofs layer are redirected to the same lower block, e.g.
>> "/objects/00/014430a0b489d101c8a103ef829dd258448a13eb48b4d1e9ff0731d1
>> e82b92".
>>
>> The result is shown in the fourth line.
>>
>>                                   | uncached(ms)| cached(ms)
>> ----------------------------------|-------------|-----------
>> composefs (with digest)           | 326         | 135
>> erofs (w/o -T0)                   | 264         | 172
>> erofs (w/o -T0) + overlayfs       | 651         | 238
>> erofs (hacked and redirect to one |             |
>> lower block) + overlayfs          | 400         | 230
>>
>> It seems that the "lazy lookup" in overlayfs indeed optimizes in this
>> situation.
>>
>>
>> The performance gap in cached situation (especially comparing
>> composefs
>> and standalone erofs) is still under investigation and I will see if
>> there's any hint by perf diff.
> 
> The fact that plain erofs is faster than composefs uncached, but slower
> cached is very strange. Also, see my other mail where erofs+ovl cached
> is slower than squashfs+ovl cached for me. Something seems to be off
> with the cached erofs case...
> 


I tested erofs with ACL disabled (see fourth line).

				  | uncached(ms)| cached(ms)
----------------------------------|-------------|-----------
composefs (with digest)		  | 326		| 135
squashfs (uncompressed)		  | 406		| 172
erofs (w/o -T0)			  | 264		| 172
erofs (w/o -T0, mount with noacl) | 225		| 141


The remained perf difference in cached situation might be noisy and may
be due to the difference of test environment.


-- 
Thanks,
Jingbo
