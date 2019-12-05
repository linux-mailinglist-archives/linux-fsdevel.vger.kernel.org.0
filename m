Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78310113A5D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 04:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbfLED2W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 22:28:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40766 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728132AbfLED2V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 22:28:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oqL8/LJldF/xpJ5wL2bY4bLF5cbG/PM1/R70EhClXc4=; b=JLYiG2yMhnrivWqbU3SHw0vvG
        7xZICEJjsts5O8dqqPS/Bh3l80ti1SZgJZoupGmzpUwk0hrBi5QhU1BnQJP8nt2nVXEbU406tYe27
        +UWIwNwZ7s1NL8xOi27nzuhe5QPVBSVqM09uyKFPzp4I7P0J0zXnoqaS3Lbvsa9LgIWLUyTpHaQZi
        7S1yV+QIVBzHDv/zhJsn7W+7dQyxl6BIlkIC568vo0XjAvMTg5Ta09+lgEGdFYOcOM0GgHtFDyM9M
        WUML86WAkP/MogHmcib/qPoAGiN7POl2aH6jIHA249WpabKfW6iPIQQg8lsJoa/xvIFKkTqvv8sSq
        bWLuBogHw==;
Received: from [2601:1c0:6280:3f0::3deb]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ichoO-0001jz-Pc; Thu, 05 Dec 2019 03:28:16 +0000
Subject: Re: [PATCH v4 1/2] sched/numa: introduce per-cgroup NUMA locality
 info
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
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <fde5d43b-447d-1b54-1bad-3a5d67e6c1f2@infradead.org>
Date:   Wed, 4 Dec 2019 19:28:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <89416266-0a06-ce1c-1d78-11171f0c80b8@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

It seems that you missed my previous comments...


On 12/3/19 11:59 PM, 王贇 wrote:
> diff --git a/init/Kconfig b/init/Kconfig
> index 4d8d145c41d2..fb7182a0d017 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -817,6 +817,15 @@ config NUMA_BALANCING_DEFAULT_ENABLED
>  	  If set, automatic NUMA balancing will be enabled if running on a NUMA
>  	  machine.
> 
> +config CGROUP_NUMA_LOCALITY
> +	bool "The per-cgroup NUMA Locality"

Drop "The"

> +	default n
> +	depends on CGROUP_SCHED && NUMA_BALANCING
> +	help
> +	  This option enable the collection of per-cgroup NUMA locality info,

	              enables

> +	  to tell whether NUMA Balancing is working well for a particular
> +	  workload, also imply the NUMA efficiency.
> +
>  menuconfig CGROUPS
>  	bool "Control Group support"
>  	select KERNFS


thanks.
-- 
~Randy

