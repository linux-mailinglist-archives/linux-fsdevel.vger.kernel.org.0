Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE0F519DE0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 May 2022 13:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348713AbiEDL1Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 May 2022 07:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234974AbiEDL1X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 May 2022 07:27:23 -0400
Received: from mxout04.lancloud.ru (mxout04.lancloud.ru [45.84.86.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63A5140BE;
        Wed,  4 May 2022 04:23:44 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 2E7B02130938
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH RFC v6 16/21] dept: Distinguish each work from another
To:     Byungchul Park <byungchul.park@lge.com>,
        <torvalds@linux-foundation.org>
CC:     <damien.lemoal@opensource.wdc.com>, <linux-ide@vger.kernel.org>,
        <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>,
        <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <peterz@infradead.org>, <will@kernel.org>, <tglx@linutronix.de>,
        <rostedt@goodmis.org>, <joel@joelfernandes.org>,
        <sashal@kernel.org>, <daniel.vetter@ffwll.ch>,
        <chris@chris-wilson.co.uk>, <duyuyang@gmail.com>,
        <johannes.berg@intel.com>, <tj@kernel.org>, <tytso@mit.edu>,
        <willy@infradead.org>, <david@fromorbit.com>, <amir73il@gmail.com>,
        <bfields@fieldses.org>, <gregkh@linuxfoundation.org>,
        <kernel-team@lge.com>, <linux-mm@kvack.org>,
        <akpm@linux-foundation.org>, <mhocko@kernel.org>,
        <minchan@kernel.org>, <hannes@cmpxchg.org>,
        <vdavydov.dev@gmail.com>, <sj@kernel.org>, <jglisse@redhat.com>,
        <dennis@kernel.org>, <cl@linux.com>, <penberg@kernel.org>,
        <rientjes@google.com>, <vbabka@suse.cz>, <ngupta@vflare.org>,
        <linux-block@vger.kernel.org>, <paolo.valente@linaro.org>,
        <josef@toxicpanda.com>, <linux-fsdevel@vger.kernel.org>,
        <viro@zeniv.linux.org.uk>, <jack@suse.cz>, <jack@suse.com>,
        <jlayton@kernel.org>, <dan.j.williams@intel.com>,
        <hch@infradead.org>, <djwong@kernel.org>,
        <dri-devel@lists.freedesktop.org>, <airlied@linux.ie>,
        <rodrigosiqueiramelo@gmail.com>, <melissa.srw@gmail.com>,
        <hamohammed.sa@gmail.com>, <42.hyeyoo@gmail.com>
References: <1651652269-15342-1-git-send-email-byungchul.park@lge.com>
 <1651652269-15342-17-git-send-email-byungchul.park@lge.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <24e4d6db-9dc9-f113-f655-9af3a51723d4@omp.ru>
Date:   Wed, 4 May 2022 14:23:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1651652269-15342-17-git-send-email-byungchul.park@lge.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

On 5/4/22 11:17 AM, Byungchul Park wrote:

> Workqueue already provides concurrency control. By that, any wait in a
> work doesn't prevents events in other works with the control enabled.
> Thus, each work would better be considered a different context.
> 
> So let Dept assign a different context id to each work.
> 
> Signed-off-by: Byungchul Park <byungchul.park@lge.com>
[...]
> diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
> index 18e5951..6707313 100644
> --- a/kernel/dependency/dept.c
> +++ b/kernel/dependency/dept.c
> @@ -1844,6 +1844,16 @@ void dept_enirq_transition(unsigned long ip)
>  	dept_exit(flags);
>  }
>  
> +/*
> + * Assign a different context id to each work.
> + */
> +void dept_work_enter(void)
> +{
> +	struct dept_task *dt = dept_task();
> +
> +	dt->cxt_id[DEPT_CXT_PROCESS] += (1UL << DEPT_CXTS_NR);

   Parens around << unnecessary...

[...]

MBR, Sergey
