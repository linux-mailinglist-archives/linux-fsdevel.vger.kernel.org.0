Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59DA4B66E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 10:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbiBOJEV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 04:04:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235575AbiBOJEG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 04:04:06 -0500
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DCE119F0C;
        Tue, 15 Feb 2022 01:03:20 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V4Xi.eo_1644915796;
Received: from 30.225.24.85(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V4Xi.eo_1644915796)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 15 Feb 2022 17:03:17 +0800
Message-ID: <bd9cb3bb-e29c-d4b3-e9bf-915b9771b553@linux.alibaba.com>
Date:   Tue, 15 Feb 2022 17:03:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH v3 05/22] cachefiles: introduce new devnode for on-demand
 read mode
Content-Language: en-US
From:   JeffleXu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     gregkh@linuxfoundation.org, willy@infradead.org,
        linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        linux-fsdevel@vger.kernel.org, gerry@linux.alibaba.com,
        torvalds@linux-foundation.org
References: <20220209060108.43051-1-jefflexu@linux.alibaba.com>
 <20220209060108.43051-6-jefflexu@linux.alibaba.com>
In-Reply-To: <20220209060108.43051-6-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David,

FYI I've updated this patch on [1].

[1]
https://github.com/lostjeffle/linux/commit/589dd838dc539aee291d1032406653a8f6269e6f.

This new version mainly adds cachefiles_ondemand_flush_reqs(), which
drains the pending read requests when cachefilesd is going to exit.

On 2/9/22 2:00 PM, Jeffle Xu wrote:
> This patch introduces a new devnode 'cachefiles_ondemand' to support the
> newly introduced on-demand read mode.
> 
> The precondition for on-demand reading semantics is that, all blob files
> have been placed under corresponding directory with correct file size
> (sparse files) on the first beginning. When upper fs starts to access
> the blob file, it will "cache miss" (hit the hole) and then turn to user
> daemon for preparing the data.
> 
> The interaction between kernel and user daemon is described as below.
> 1. Once cache miss, .ondemand_read() callback of corresponding fscache
>    backend is called to prepare the data. As for cachefiles, it just
>    packages related metadata (file range to read, etc.) into a pending
>    read request, and then the process triggering cache miss will fall
>    asleep until the corresponding data gets fetched later.
> 2. User daemon needs to poll on the devnode ('cachefiles_ondemand'),
>    waiting for pending read request.
> 3. Once there's pending read request, user daemon will be notified and
>    shall read the devnode ('cachefiles_ondemand') to fetch one pending
>    read request to process.
> 4. For the fetched read request, user daemon need to somehow prepare the
>    data (e.g. download from remote through network) and then write the
>    fetched data into the backing file to fill the hole.
> 5. After that, user daemon need to notify cachefiles backend by writing a
>    'done' command to devnode ('cachefiles_ondemand'). It will also
>    awake the previous asleep process triggering cache miss.
> 6. By the time the process gets awaken, the data has been ready in the
>    backing file. Then process can re-initiate a read request from the
>    backing file.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---


-- 
Thanks,
Jeffle
