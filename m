Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901756A9DD0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 18:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjCCRhb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Mar 2023 12:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbjCCRha (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Mar 2023 12:37:30 -0500
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC71BB44E
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Mar 2023 09:37:18 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Vd0E9qe_1677865035;
Received: from 192.168.3.7(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vd0E9qe_1677865035)
          by smtp.aliyun-inc.com;
          Sat, 04 Mar 2023 01:37:16 +0800
Message-ID: <13e7205f-113b-ad47-417f-53b63743c64c@linux.alibaba.com>
Date:   Sat, 4 Mar 2023 01:37:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [LSF/MM/BFP TOPIC] Composefs vs erofs+overlay
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Alexander Larsson <alexl@redhat.com>,
        lsf-pc@lists.linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Jingbo Xu <jefflexu@linux.alibaba.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
References: <e84d009fd32b7a02ceb038db5cf1737db91069d5.camel@redhat.com>
 <CAL7ro1E7KY5yUJOLu6TY0RtAC5304sM3Lvk=zSCrqDrxTPW2og@mail.gmail.com>
 <ffe56605-6ef7-01b5-e613-7600165820d8@linux.alibaba.com>
In-Reply-To: <ffe56605-6ef7-01b5-e613-7600165820d8@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/3/3 23:13, Gao Xiang wrote:

...

>>
>> And of course, there are disadvantages to composefs too. Primarily
>> being more code, increasing maintenance burden and risk of security
>> problems. Composefs is particularly burdensome because it is a
>> stacking filesystem and these have historically been shown to be hard
>> to get right.

Just off a bit of that, I do think you could finally find a
fully-functional read-only filesystem is useful.

For example with EROFS you could,

  - keep composefs model files as your main use cases;

  - keep some small files such as "VERSION" or "README" inline;

  - refer to some parts of blobs (such as tar data) directly in
    addition to the whole file, which seems also a useful use cases
    for OCI containers;

  - deploy all of the above to raw disks and other media as well;

  - etc.

Actually since you're container guys, I would like to mention
a way to directly reuse OCI tar data and not sure if you
have some interest as well, that is just to generate EROFS
metadata which could point to the tar blobs so that data itself
is still the original tar, but we could add fsverity + IMMUTABLE
to these blobs rather than the individual untared files.

The main advantages over the current way (podman, containerd) are
  - save untar and snapshot gc time;
  - OCI layer diff IDs in the OCI spec [1] are guaranteed;
  - in-kernel mountable with runtime verificiation;
  - such tar can be mounted in secure containers in the same way
    as well.

Personally I've been working on EROFS since the end of 2017 until
now for many years, although it could take more or less time due
to other on-oning work, I always believe a read-only approach is
beyond just a pure space-saving stuff.  So I devoted almost all
my extra leisure time for this.

Honestly, I do hope there could be more people interested in EROFS
in addition to the original Android use cases because the overall
intention is much similar and I'm happy to help things that I could
do and avoid another random fs dump to Linux kernel (of course not
though.)

[1] https://github.com/opencontainers/image-spec/blob/main/config.md

Thanks,
Gao Xiang
