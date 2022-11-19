Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4956D630F25
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Nov 2022 15:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbiKSOX5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Nov 2022 09:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiKSOXz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Nov 2022 09:23:55 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC381D327;
        Sat, 19 Nov 2022 06:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668867834; x=1700403834;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lK4fXmCZxsjbTHpACp3BYMOduLnWYbe09pp2psIJaHc=;
  b=JwjvVnJNbNGGQ7pL8XMcTPmZTRUhki5OfpmnNA6+rLR1q1d69VR3lDtq
   XVoF8x9StcNKKyOePK6PLPeNsf7rH75wauIpqURx40HoEwk44tcTYxmK8
   bAxqddZKNemZCCpI6YNiOG5ZWKudTWxtVLB/WiM8oByw35/jw9cCTdbSO
   BTrN2xDDu+dT8PpealzzSHlK2yZ4x1AzSY9r7AZ3jE0m2CKEt5PBNT+jc
   csWC8rlFCR0KJEIKQUVKaO7azFKgcl0wXTdwr90hq1qvWD0d+r3gJV6PJ
   rV75qDilFBrK05UTny/zXueTlYkDkTduE/fU0LunB96xysF+GMKX7BtSN
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="340168190"
X-IronPort-AV: E=Sophos;i="5.96,176,1665471600"; 
   d="scan'208";a="340168190"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2022 06:23:54 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="704072894"
X-IronPort-AV: E=Sophos;i="5.96,176,1665471600"; 
   d="scan'208";a="704072894"
Received: from akerber-mobl.amr.corp.intel.com (HELO [10.209.36.51]) ([10.209.36.51])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2022 06:23:54 -0800
Message-ID: <50f15e81-e2f6-e63f-dbbb-072737a51e54@linux.intel.com>
Date:   Sat, 19 Nov 2022 06:23:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] Add process name to locks warning
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>
Cc:     chuck.lever@oracle.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221118234357.243926-1-ak@linux.intel.com>
 <9a521db6342b977805d7161406f86d44fea7ba55.camel@kernel.org>
From:   Andi Kleen <ak@linux.intel.com>
In-Reply-To: <9a521db6342b977805d7161406f86d44fea7ba55.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 11/18/2022 6:06 PM, Jeff Layton wrote:
> On Fri, 2022-11-18 at 15:43 -0800, Andi Kleen wrote:
>> It's fairly useless to complain about using an obsolete feature without
>> telling the user which process used it. My Fedora desktop randomly drops
>> this message, but I would really need this patch to figure out what
>> triggers is.
>>
> Interesting. The only program I know of that tried to use these was
> samba, but we patched that out a few years ago (about the time this
> patch went in). Are you running an older version of samba?


Yes it's running samba, whatever is in Fedora 35. Don't know if that 
counts as an

older version.


>
>> Signed-off-by: Andi Kleen <ak@linux.intel.com>
>> ---
>>   fs/locks.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/locks.c b/fs/locks.c
>> index 607f94a0e789..2e45232dbeb1 100644
>> --- a/fs/locks.c
>> +++ b/fs/locks.c
>> @@ -2096,7 +2096,7 @@ SYSCALL_DEFINE2(flock, unsigned int, fd, unsigned int, cmd)
>>   	 * throw a warning to let people know that they don't actually work.
>>   	 */
>>   	if (cmd & LOCK_MAND) {
>> -		pr_warn_once("Attempt to set a LOCK_MAND lock via flock(2). This support has been removed and the request ignored.\n");
>> +		pr_warn_once("%s: Attempt to set a LOCK_MAND lock via flock(2). This support has been removed and the request ignored.\n", current->comm);
>>   		return 0;
>>   	}
>>   
> Looks reasonable. Would it help to print the pid or tgid as well?

It wouldn't help me because at that time I see it it's likely long gone. 
Just need the name.

