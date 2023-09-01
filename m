Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC9479038F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Sep 2023 00:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350817AbjIAWOe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Sep 2023 18:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350889AbjIAWOU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Sep 2023 18:14:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207B63589;
        Fri,  1 Sep 2023 15:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693605736; x=1725141736;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nVfmxbqDXIh8A00RhIxKfwpnsfXzBnk7+8/dEd/IxcY=;
  b=HyombUfGICAFZXOK8ShUSLCvD94Cp/7oB4uMd6qnVMTXoBLYdWegwges
   i59rlSL+7hm7e+c7/JAOI7sWdHGpwyj+opENZ7ahuW6KxeFVBHxsq5UZT
   J12g4EfRGpIRF2EnogQgMsGic9R7RBdaUC0XVZXOnBAhhONiNX6it7PfG
   AOp3zb+uMBh/qPyHhGGxG5z+EHsW6SyydcmtJlkfCNytmGGZqYLJXW/PF
   68StLWdHu0Cs7Yp9wEcOOcJuJ6uvCjYrdyqjD+5VDAvS1aT4hVZ5kMalF
   hHFTwBNDtlrmiXXULxATR+44VixJIBimnLLYcne4X5/0o2y/zM9z5nXKb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="442715689"
X-IronPort-AV: E=Sophos;i="6.02,221,1688454000"; 
   d="scan'208";a="442715689"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 15:02:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="913841298"
X-IronPort-AV: E=Sophos;i="6.02,221,1688454000"; 
   d="scan'208";a="913841298"
Received: from leihuan1-mobl.amr.corp.intel.com (HELO [10.0.2.15]) ([10.92.27.231])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 15:02:10 -0700
Message-ID: <ec4c69a4-c1fb-d18f-d467-316161c51ac4@linux.intel.com>
Date:   Fri, 1 Sep 2023 18:02:03 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1] fs/fuse: Fix missing FOLL_PIN for direct-io
Content-Language: en-US
To:     Bernd Schubert <bschubert@ddn.com>,
        Bernd Schubert <bernd.schubert@fastmail.fm>,
        linux-kernel@vger.kernel.org
Cc:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        David Howells <dhowells@redhat.com>
References: <1693334193-7733-1-git-send-email-lei.huang@linux.intel.com>
 <572dcce8-f70c-2d24-f844-a3e8abbd4bd8@fastmail.fm>
 <5eedd8a6-02d9-bc85-df43-6aa5f7497288@linux.intel.com>
 <0ffc15ea-6803-acf3-d840-378a15c7c073@ddn.com>
From:   Lei Huang <lei.huang@linux.intel.com>
In-Reply-To: <0ffc15ea-6803-acf3-d840-378a15c7c073@ddn.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Bernd,

Actually, we do not have a simple code to reproduce this issue yet. We 
observed the issues in a suite of tests. There are up to 8 tests 
scheduled to run concurrently with many small tests. I could observe 
about 5~10 cases with wrong data in one day. I tried repeating a single 
test for very long time and did not observe the issue. I guess it would 
help to run simultaneously multiple processes causing bad memory 
fragmentation. Please let me know if you need more information. Thank 
you very much for looking into this issue. Have a great weekend!

Best Regards,
-lei

On 9/1/23 14:05, Bernd Schubert wrote:
> Hi Lei,
> 
> On 8/30/23 03:03, Lei Huang wrote:
>> Hi Bernd,
>>
>> Thank you very much for your reply!
>>
>>  > Hmm, iov_iter_extract_pages does not exists for a long time and the 
>> code
>>  > in fuse_get_user_pages didn't change much. So if you are right, there
>>  > would be a long term data corruption for page migrations? And a back
>>  > port to old kernels would not be obvious?
>>
>> Right. The issue has been reproduced under various versions of 
>> kernels, ranging from 3.10.0 to 6.3.6 in my tests. It would be 
>> different to make a patch under older kernels like 3.10.0. One way I 
>> tested, one can query
>> the physical pages associated with read buffer after data is ready 
>> (right before writing the data into read buffer). This seems resolving 
>> the issue in my tests.
>>
>>
>>  > What confuses me further is that
>>  > commit 85dd2c8ff368 does not mention migration or corruption, although
>>  > lists several other advantages for iov_iter_extract_pages. Other 
>> commits
>>  > using iov_iter_extract_pages point to fork - i.e. would your data
>>  > corruption be possibly related that?
>>
>> As I mentioned above, the issue seems resolved if we query the 
>> physical pages as late as right before writing data into read buffer. 
>> I think the root cause is page migration.
>>
> 
> out of interest, what is your exact reproducer and how much time does i 
> take? I'm just trying passthrough_hp(*) and ql-fstest (**) and don't get 
> and issue after about 1h run time. I let it continue over the weekend. 
> The system is an older dual socket xeon.
> 
> (*) with slight modification for passthrough_hp to disable O_DIRECT for 
> the underlying file system. It is running on xfs on an nvme.
> 
> (**) https://github.com/bsbernd/ql-fstest
> 
> 
> Pinning the pages is certainly a good idea, I would just like to 
> understand how severe the issue is. And would like to test 
> backports/different patch on older kernels.
> 
> 
> Thanks,
> Bernd
> 
> 
