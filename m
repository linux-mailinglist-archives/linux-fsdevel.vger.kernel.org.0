Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90146A6732
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 05:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjCAE7Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 23:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjCAE7X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 23:59:23 -0500
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096C420D3D;
        Tue, 28 Feb 2023 20:59:21 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VcnLHeP_1677646758;
Received: from 30.97.48.239(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VcnLHeP_1677646758)
          by smtp.aliyun-inc.com;
          Wed, 01 Mar 2023 12:59:18 +0800
Message-ID: <8c4e5b16-fb7f-ebd1-60d5-0bb9718fd8dd@linux.alibaba.com>
Date:   Wed, 1 Mar 2023 12:59:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, lsf-pc@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org
References: <Y/7L74P6jSWwOvWt@mit.edu>
 <7c111304-b56b-167f-bced-9e06e44241cd@linux.alibaba.com>
 <Y/7XOSj5LUu/MYCU@casper.infradead.org>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <Y/7XOSj5LUu/MYCU@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/3/1 12:40, Matthew Wilcox wrote:
> On Wed, Mar 01, 2023 at 12:18:30PM +0800, Gao Xiang wrote:
>>> For example, most cloud storage devices are doing read-ahead to try to
>>> anticipate read requests from the VM.  This can interfere with the
>>> read-ahead being done by the guest kernel.  So being able to tell
>>> cloud storage device whether a particular read request is stemming
>>> from a read-ahead or not.  At the moment, as Matthew Wilcox has
>>> pointed out, we currently use the read-ahead code path for synchronous
>>> buffered reads.  So plumbing this information so it can passed through
>>> multiple levels of the mm, fs, and block layers will probably be
>>> needed.
>>
>> It seems that is also useful as well, yet if my understanding is correct,
>> it's somewhat unclear for me if we could do more and have a better form
>> compared with the current REQ_RAHEAD (currently REQ_RAHEAD use cases and
>> impacts are quite limited.)
> 
> I'm pretty sure the Linux readahead algorithms could do with some serious
> tuning (as opposed to the hacks the Android device vendors are doing).
> Outside my current level of enthusiasm / knowledge, alas.  And it's
> hard because while we no longer care about performance on floppies,
> we do care about performance from CompactFlash to 8GB/s NVMe drives.
> I had one person recently complain that 200Gbps ethernet was too slow
> for their storage, so there's a faster usecase to care about.

Yes, we might have a chance to revisit the current readahead algorithm
towards the modern storage devices.  I understand how the current
readahead works but don't have enough slots to analyse the workloads
and investigate more, also such heuristic stuff can have pro-and-con
sides all the time.

As a public cloud vendor, it becomes vital to change since some users
just would like to care about the corner cases compared with other
competitors.

Thanks,
Gao Xiang
