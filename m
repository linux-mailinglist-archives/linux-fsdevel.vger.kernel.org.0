Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65071113A60
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 04:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbfLED3v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 22:29:51 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40818 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728132AbfLED3v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 22:29:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:To:From:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LEOOsUIAzaPk42eK67DM0XZJ5DKLzWY6tFldhWQMUFQ=; b=uLg9Z/kpfMIj32k0grGfLYso8
        BDhMq2JUx+VTTw5+GupQbd/dCr3I63PVeV5sZGw0qUjgqpp1zuZWFEo2PnLaGHFVhHx3OAyWuWjNr
        T5AGUhkYEnj2DYPieiKIboMha6SOmafIkrq10+qlPHuUDwieAQRiTw8JTe+c6BEHknzR8PWcQI/Wy
        A/keZYW8WpGeyP+DZNTQoQyDJv/akNwD4xl4zRo3INRoeufj0RBy6fMaW6P0ED0boQzwijcUo9WQZ
        Qlo8Zz3Qwnjb13Mi4aQ+M387WwvCYLFd0Gjvrg6YioMWxuYwn9A6As408s+jnvT8CFE6ZDf3IhWRI
        iV/Jvx13A==;
Received: from [2601:1c0:6280:3f0::3deb]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ichps-0001pN-LB; Thu, 05 Dec 2019 03:29:48 +0000
Subject: Re: [PATCH v4 1/2] sched/numa: introduce per-cgroup NUMA locality
 info
From:   Randy Dunlap <rdunlap@infradead.org>
To:     =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>
References: <743eecad-9556-a241-546b-c8a66339840e@linux.alibaba.com>
 <207ef46c-672c-27c8-2012-735bd692a6de@linux.alibaba.com>
 <040def80-9c38-4bcc-e4a8-8a0d10f131ed@linux.alibaba.com>
 <25cf7ef5-e37e-7578-eea7-29ad0b76c4ea@linux.alibaba.com>
 <89416266-0a06-ce1c-1d78-11171f0c80b8@linux.alibaba.com>
 <fde5d43b-447d-1b54-1bad-3a5d67e6c1f2@infradead.org>
Message-ID: <c757f282-e89c-78f6-71cd-1273d2624429@infradead.org>
Date:   Wed, 4 Dec 2019 19:29:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <fde5d43b-447d-1b54-1bad-3a5d67e6c1f2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/4/19 7:28 PM, Randy Dunlap wrote:
> Hi,
> 
> It seems that you missed my previous comments...
> 
> 
> On 12/3/19 11:59 PM, 王贇 wrote:
>> diff --git a/init/Kconfig b/init/Kconfig
>> index 4d8d145c41d2..fb7182a0d017 100644
>> --- a/init/Kconfig
>> +++ b/init/Kconfig
>> @@ -817,6 +817,15 @@ config NUMA_BALANCING_DEFAULT_ENABLED
>>  	  If set, automatic NUMA balancing will be enabled if running on a NUMA
>>  	  machine.
>>
>> +config CGROUP_NUMA_LOCALITY
>> +	bool "The per-cgroup NUMA Locality"
> 
> Drop "The"
> 
>> +	default n
>> +	depends on CGROUP_SCHED && NUMA_BALANCING
>> +	help
>> +	  This option enable the collection of per-cgroup NUMA locality info,
> 
> 	              enables
> 
>> +	  to tell whether NUMA Balancing is working well for a particular
>> +	  workload, also imply the NUMA efficiency.
>> +
>>  menuconfig CGROUPS
>>  	bool "Control Group support"
>>  	select KERNFS
> 
> 
> thanks.
> 

Ah, the changes are in patch 2/2/ for some reason.  OK, thanks.

-- 
~Randy

