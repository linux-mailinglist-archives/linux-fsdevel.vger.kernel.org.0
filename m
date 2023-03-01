Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAAC56A66F4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 05:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjCAESh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 23:18:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjCAESg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 23:18:36 -0500
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D765D1631A;
        Tue, 28 Feb 2023 20:18:33 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Vcmfsg9_1677644310;
Received: from 30.97.48.239(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vcmfsg9_1677644310)
          by smtp.aliyun-inc.com;
          Wed, 01 Mar 2023 12:18:31 +0800
Message-ID: <7c111304-b56b-167f-bced-9e06e44241cd@linux.alibaba.com>
Date:   Wed, 1 Mar 2023 12:18:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
To:     Theodore Ts'o <tytso@mit.edu>, lsf-pc@lists.linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org
References: <Y/7L74P6jSWwOvWt@mit.edu>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <Y/7L74P6jSWwOvWt@mit.edu>
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



On 2023/3/1 11:52, Theodore Ts'o wrote:
> Emulated block devices offered by cloud VM’s can provide functionality
> to guest kernels and applications that traditionally have not been
> available to users of consumer-grade HDD and SSD’s.  For example,
> today it’s possible to create a block device in Google’s Persistent
> Disk with a 16k physical sector size, which promises that aligned 16k
> writes will be atomically.  With NVMe, it is possible for a storage
> device to promise this without requiring read-modify-write updates for
> sub-16k writes.  All that is necessary are some changes in the block
> layer so that the kernel does not inadvertently tear a write request
> when splitting a bio because it is too large (perhaps because it got
> merged with some other request, and then it gets split at an
> inconvenient boundary).

Yeah, most cloud vendors (including Alibaba Cloud) now use ext4 bigalloc
to avoid mysql double write buffers. In addition to improve performance,
this method can also minimize unnecessary I/O traffic between computing
and storage nodes.

Once I hacked a COW-based in-house approach in XFS by using the optimized
always_cow with some tricks to avoid storage dependency.  But nowadays
AWS and Google Cloud are all using ext4 bigalloc, so.. ;-)

> 
> There are also more interesting, advanced optimizations that might be
> possible.  For example, Jens had observed the passing hints that
> journaling writes (either from file systems or databases) could be
> potentially useful.  Unfortunately most common storage devices have
> not supported write hints, and support for write hints were ripped out
> last year.  That can be easily reversed, but there are some other
> interesting related subjects that are very much suited for LSF/MM.
> 
> For example, most cloud storage devices are doing read-ahead to try to
> anticipate read requests from the VM.  This can interfere with the
> read-ahead being done by the guest kernel.  So being able to tell
> cloud storage device whether a particular read request is stemming
> from a read-ahead or not.  At the moment, as Matthew Wilcox has
> pointed out, we currently use the read-ahead code path for synchronous
> buffered reads.  So plumbing this information so it can passed through
> multiple levels of the mm, fs, and block layers will probably be
> needed.

It seems that is also useful as well, yet if my understanding is correct,
it's somewhat unclear for me if we could do more and have a better form
compared with the current REQ_RAHEAD (currently REQ_RAHEAD use cases and
impacts are quite limited.)

Thanks,
Gao Xiang

> 
