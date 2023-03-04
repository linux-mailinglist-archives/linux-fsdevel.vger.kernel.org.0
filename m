Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88DD6AA69E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Mar 2023 01:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjCDAq5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Mar 2023 19:46:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjCDAq4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Mar 2023 19:46:56 -0500
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CDB637CF
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Mar 2023 16:46:54 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Vd0zWbd_1677890809;
Received: from 192.168.31.66(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vd0zWbd_1677890809)
          by smtp.aliyun-inc.com;
          Sat, 04 Mar 2023 08:46:50 +0800
Message-ID: <6ecbe86b-f97f-30f6-9a6e-cb3090ec35cf@linux.alibaba.com>
Date:   Sat, 4 Mar 2023 08:46:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [LSF/MM/BFP TOPIC] Composefs vs erofs+overlay
Content-Language: en-US
To:     Alexander Larsson <alexl@redhat.com>,
        lsf-pc@lists.linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
References: <e84d009fd32b7a02ceb038db5cf1737db91069d5.camel@redhat.com>
 <CAL7ro1E7KY5yUJOLu6TY0RtAC5304sM3Lvk=zSCrqDrxTPW2og@mail.gmail.com>
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <CAL7ro1E7KY5yUJOLu6TY0RtAC5304sM3Lvk=zSCrqDrxTPW2og@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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



On 3/3/23 9:57 PM, Alexander Larsson wrote:
> On Mon, Feb 27, 2023 at 10:22 AM Alexander Larsson <alexl@redhat.com> wrote:
> 
> * Erofs on top of direct-io enabled loopback causes quite a drop in
>   performance, which I don't really understand. Especially since its
>   reporting the same memory use as non-direct io. I guess the
>   double-cacheing in the later case isn't properly attributed to the
>   cgroup so the difference is not measured. However, why would the
>   double cache improve performance?  Maybe I'm not completely
>   understanding how these things interact.
> 

Loop in BUFFERED mode actually calls .read_iter() of the backing file to
read from it, e.g. ext4_file_read_iter()->generic_file_read_iter(),
where heuristic readahead is also done.

-- 
Thanks,
Jingbo
