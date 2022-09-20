Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5415BE02C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Sep 2022 10:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbiITIc6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Sep 2022 04:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbiITIco (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:32:44 -0400
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E2B1277E;
        Tue, 20 Sep 2022 01:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1663662763; x=1695198763;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=VMI90VsaFAznWdudY3c2Y8bpe/V3g+agyL0jxa8IuF4=;
  b=pmmZZwlFGh21UmGmFUZHaiH/UOZTbefz5tEOU1KumvlazQnzlpoZJscY
   4GduEfHqpEn7ctHEluZ42lAsCr+bNR6hLiu5xrzacL9UGWZLbAQP+J++8
   VofGhLLdIAO+8Sm1ZI13Z1jQ8ofrAEAL/7sIWRXNPx5W0lWYzwtRNg98J
   4=;
X-IronPort-AV: E=Sophos;i="5.93,330,1654560000"; 
   d="scan'208";a="1056013639"
Subject: Re: [PATCH] libfs: fix negative value support in simple_attr_write()
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-54a073b7.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 08:27:36 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1d-54a073b7.us-east-1.amazon.com (Postfix) with ESMTPS id 3C907A287C;
        Tue, 20 Sep 2022 08:27:35 +0000 (UTC)
Received: from EX19D013UWB003.ant.amazon.com (10.13.138.111) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Tue, 20 Sep 2022 08:27:33 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX19D013UWB003.ant.amazon.com (10.13.138.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Tue, 20 Sep 2022 08:27:33 +0000
Received: from [192.168.162.64] (10.85.143.179) by mail-relay.amazon.com
 (10.43.161.249) with Microsoft SMTP Server id 15.0.1497.38 via Frontend
 Transport; Tue, 20 Sep 2022 08:27:28 +0000
Message-ID: <f75a7d97-58cb-9136-093b-bf5af48da99a@amazon.com>
Date:   Tue, 20 Sep 2022 11:27:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <viro@zeniv.linux.org.uk>, <yangyicong@hisilicon.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <andriy.shevchenko@intel.com>, <hhhawa@amazon.com>,
        <jonnyc@amazon.com>, Akinobu Mita <akinobu.mita@gmail.com>,
        "Farber, Eliav" <farbere@amazon.com>
References: <20220918135036.33595-1-farbere@amazon.com>
 <20220919142413.c294de0777dcac8abe2d2f71@linux-foundation.org>
Content-Language: en-US
From:   "Farber, Eliav" <farbere@amazon.com>
In-Reply-To: <20220919142413.c294de0777dcac8abe2d2f71@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-14.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/20/2022 12:24 AM, Andrew Morton wrote:
> On Sun, 18 Sep 2022 13:50:36 +0000 Eliav Farber <farbere@amazon.com> 
> wrote:
>
>> After commit 488dac0c9237 ("libfs: fix error cast of negative value in
>> simple_attr_write()"), a user trying set a negative value will get a
>> '-EINVAL' error, because simple_attr_write() was modified to use
>> kstrtoull() which can handle only unsigned values, instead of
>> simple_strtoll().
>>
>> This breaks all the places using DEFINE_DEBUGFS_ATTRIBUTE() with format
>> of a signed integer.
>>
>> The u64 value which attr->set() receives is not an issue for negative
>> numbers.
>> The %lld and %llu in any case are for 64-bit value. Representing it as
>> unsigned simplifies the generic code, but it doesn't mean we can't keep
>> their signed value if we know that.
>>
>> This change basically reverts the mentioned commit, but uses kstrtoll()
>> instead of simple_strtoll() which is obsolete.
>>
>
> https://lkml.kernel.org/r/20220919172418.45257-1-akinobu.mita@gmail.com
> addresses the same thing.
>
> Should the final version of this fix be backported into -stable trees?


I think that my patch can be dropped in favor of Akinobu's patch.

--
Regards, Eliav

