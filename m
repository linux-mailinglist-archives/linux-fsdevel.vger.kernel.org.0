Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1945790390
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Sep 2023 00:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237050AbjIAWSV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Sep 2023 18:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235923AbjIAWSR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Sep 2023 18:18:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63431359D;
        Fri,  1 Sep 2023 15:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693606694; x=1725142694;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2LiDIeNzeiKmagemmBb/VCD9firLNoG8XZQ8FEhVjUw=;
  b=oHf0LZgQ1DCz33dOQ1aeXI+HSpznj4QFfOsIVaDAb7/nfrDE9n5eJctr
   xPoXh0Du1YG64qnHhivQrylAVtCC2/DpiClyDUmSI16+K7joqg7aInhrw
   OLR2KbnqidCpgs/YI5j0Xi3WRLTA4kLQYz80nSfZ0jG/806sdQFwOC1Yi
   HJbxPw8sdzkNrJY9CRY0hJjQztVnkSkHEc+kg3vm/C/dAD82SlvqoLXeQ
   YMbLB2f+0/CfKaeY29NdAnk6HtTDLkwfxolVouR0YVqlzaY1/50M6Vqju
   pm6dTSG14fpUTsgIYHvHrNqBkdyLQRquA7hODqihuZlRboEdIBICcv4nM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="366549370"
X-IronPort-AV: E=Sophos;i="6.02,221,1688454000"; 
   d="scan'208";a="366549370"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 15:18:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="883351147"
X-IronPort-AV: E=Sophos;i="6.02,221,1688454000"; 
   d="scan'208";a="883351147"
Received: from leihuan1-mobl.amr.corp.intel.com (HELO [10.0.2.15]) ([10.92.27.231])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 15:18:11 -0700
Message-ID: <ec657247-7340-1bae-3a63-a5a8046cd863@linux.intel.com>
Date:   Fri, 1 Sep 2023 18:18:04 -0400
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
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Bernd,

Actually, we do not have a simple code to reproduce this issue yet. We 
observed the issues in a suite of tests which shedules multiple (6~8) 
tests concurrently. I could observe about 5~10 cases with wrong data in 
one day. I tried repeating a single test for a couple of days and did 
not observe the issue. I think concurrently running multiple processes 
which can make bad memory fragmentation could help to observe the issue. 
Please let me know if you need more information. Thank you very much for 
looking into this issue. Have a great weekend!

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
