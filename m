Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158AC619613
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Nov 2022 13:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbiKDMUT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Nov 2022 08:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbiKDMUQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Nov 2022 08:20:16 -0400
Received: from out199-10.us.a.mail.aliyun.com (out199-10.us.a.mail.aliyun.com [47.90.199.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168112CDCE;
        Fri,  4 Nov 2022 05:20:14 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R671e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VTxExbC_1667564409;
Received: from 30.221.128.121(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VTxExbC_1667564409)
          by smtp.aliyun-inc.com;
          Fri, 04 Nov 2022 20:20:11 +0800
Message-ID: <6064150a-7517-c0e1-72bb-e1a8adcfae74@linux.alibaba.com>
Date:   Fri, 4 Nov 2022 20:20:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH 2/2] erofs: switch to prepare_ondemand_read() in fscache
 mode
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>, dhowells@redhat.com,
        xiang@kernel.org, chao@kernel.org, linux-cachefs@redhat.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20221104072637.72375-1-jefflexu@linux.alibaba.com>
 <20221104072637.72375-3-jefflexu@linux.alibaba.com>
 <2e2eceeb11972462bb9161a73c00a9c77f8af8d2.camel@kernel.org>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <2e2eceeb11972462bb9161a73c00a9c77f8af8d2.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 11/4/22 7:46 PM, Jeff Layton wrote:
> On Fri, 2022-11-04 at 15:26 +0800, Jingbo Xu wrote:
>> Switch to prepare_ondemand_read() interface and a self-contained request
>> completion to get rid of netfs_io_[request|subrequest].
>>
>> The whole request will still be split into slices (subrequest) according
>> to the cache state of the backing file.  As long as one of the
>> subrequests fails, the whole request will be marked as failed. Besides
>> it will not retry for short read.  Similarly the whole request will fail
>> if that really happens. 
>>
> 
> That's sort of nasty. The kernel can generally give you a short read for
> all sorts of reasons, some of which may have nothing to do with the
> underlying file or filesystem.
> 
> Passing an error back to an application on a short read is probably not
> what you want to do here. The usual thing to do is just to return what
> you can, and let the application redrive the request if it wants.
> 

Yeah, thanks for your comment. We can fix this either in current
patchset or a separate series. As we just discussed on IRC, we will fix
in the following series.



-- 
Thanks,
Jingbo
