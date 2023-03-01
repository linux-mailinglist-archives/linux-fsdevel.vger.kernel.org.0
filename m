Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5AC96A6718
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 05:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjCAEtS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 23:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjCAEtQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 23:49:16 -0500
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4B7B754;
        Tue, 28 Feb 2023 20:49:14 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vco0u.M_1677646151;
Received: from 30.97.48.239(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vco0u.M_1677646151)
          by smtp.aliyun-inc.com;
          Wed, 01 Mar 2023 12:49:11 +0800
Message-ID: <c6612406-11c7-2158-5186-ebee72c9b698@linux.alibaba.com>
Date:   Wed, 1 Mar 2023 12:49:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
To:     Matthew Wilcox <willy@infradead.org>, Theodore Ts'o <tytso@mit.edu>
Cc:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org
References: <Y/7L74P6jSWwOvWt@mit.edu> <Y/7WJMNLjrQ+/+Vs@casper.infradead.org>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <Y/7WJMNLjrQ+/+Vs@casper.infradead.org>
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

Hi Matthew!

On 2023/3/1 12:35, Matthew Wilcox wrote:
> On Tue, Feb 28, 2023 at 10:52:15PM -0500, Theodore Ts'o wrote:
>> For example, most cloud storage devices are doing read-ahead to try to
>> anticipate read requests from the VM.  This can interfere with the
>> read-ahead being done by the guest kernel.  So being able to tell
>> cloud storage device whether a particular read request is stemming
>> from a read-ahead or not.  At the moment, as Matthew Wilcox has
>> pointed out, we currently use the read-ahead code path for synchronous
>> buffered reads.  So plumbing this information so it can passed through
>> multiple levels of the mm, fs, and block layers will probably be
>> needed.
> 
> This shouldn't be _too_ painful.  For example, the NVMe driver already
> does the right thing:
> 
>          if (req->cmd_flags & (REQ_FAILFAST_DEV | REQ_RAHEAD))
>                  control |= NVME_RW_LR;
> 
>          if (req->cmd_flags & REQ_RAHEAD)
>                  dsmgmt |= NVME_RW_DSM_FREQ_PREFETCH;
> 
> (LR is Limited Retry; FREQ_PREFETCH is "Speculative read. The command
> is part of a prefetch operation")
> 
> The only problem is that the readahead code doesn't tell the filesystem
> whether the request is sync or async.  This should be a simple matter
> of adding a new 'bool async' to the readahead_control and then setting
> REQ_RAHEAD based on that, rather than on whether the request came in
> through readahead() or read_folio() (eg see mpage_readahead()).

Great!  In addition to that, just (somewhat) off topic, if we have a
"bool async" now, I think it will immediately have some users (such as
EROFS), since we'd like to do post-processing (such as decompression)
immediately in the same context with sync readahead (due to missing
pages) and leave it to another kworker for async readahead (I think
it's almost same for decryption and verification).

So "bool async" is quite useful on my side if it could be possible
passed to fs side.  I'd like to raise my hands to have it.

Thanks,
Gao Xiang

> 
> Another thing to fix is that SCSI doesn't do anything with the REQ_RAHEAD
> flag, so I presume T10 has some work to do (maybe they could borrow the
> Access Frequency field from NVMe, since that was what the drive vendors
> told us they wanted; maybe they changed their minds since).
