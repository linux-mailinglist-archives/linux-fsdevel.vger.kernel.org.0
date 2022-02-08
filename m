Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B910E4ACFDC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Feb 2022 04:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344131AbiBHDq5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Feb 2022 22:46:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiBHDqz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Feb 2022 22:46:55 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D20DC0401DC
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Feb 2022 19:46:55 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id y18so3156418plb.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Feb 2022 19:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=a/iY+LYCIITobxV+U+gryLnkcw30JcLX+QDe3StT71U=;
        b=Cu6tSzvdr3yyYqAV76D+Y74xDnkWul7CsRpMnMutOz8e+8VYQMvVcJH+A170U72vZH
         zj/g2rjBg0t9e/dg5i8cF/3xQHRRdO5TXCJnaA5DJYoQEZwoxZFi8GE3zeecFrE4rJSz
         F3l+erY+2uVOyLur97/KP72wIS4yoL8Y4j7U7b3ipc3xw/iFtKSv926FtSOBRzWqs1BN
         Uk/jQBNcqc4gXe54CgSZn54/1Xok42N9zuY5LGJpakyLp2Y/10LcRGYhM8Mf9F4+Oy/K
         L8lYSIxzHGo8vu+ba/qqBS8wYPbq5YkFlrjJVQAvz22D3cKe1mm+nx+BNgXlbDiwBtQ0
         BH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=a/iY+LYCIITobxV+U+gryLnkcw30JcLX+QDe3StT71U=;
        b=vGc8HTOzc5A/+Lv6jeJm7zvfEcynBhasgLAz46CgRFSWj9yaKNXOy46+41Eh0MhW/+
         Hktgt/R8OMb+s6YlsD0CDssoYWceQzAw7Y0yp4d8qCBpIZfTdCS78A5ZFz+2VeWK9Cyr
         45Ds4jycEQygonQKCHk69Xn1RpzIzJigKva8Ev9qj4gc3T0qzRMfBHykru1/rGjnTAz5
         /gBehJgfAsEjD6fEHXdMzf/zj6X3kL3q/oVfM2F3PrablGReb/Rs/bxWSaZtmgZPNsFW
         +R147d2YOveCtGsiH3oGJaRe0qHheO1zbkiiLIlhRe+RPib/C8GfneCKa0qo4JHMWQGE
         vQOw==
X-Gm-Message-State: AOAM532vbLL5/R34VRQxnaF6wXflMmZri3UurJjhMsPofQV5pHbxZ6je
        lhDFnLct39pcc8Yprr5swoa3FA==
X-Google-Smtp-Source: ABdhPJwqUMxAa6iHs4gBOdkeC8g/8E2NUBCfcixF/w3JXosdm7T9AnMKwOu/33hwyTZoc1D9flcrAQ==
X-Received: by 2002:a17:902:a9c2:: with SMTP id b2mr2696201plr.168.1644292014639;
        Mon, 07 Feb 2022 19:46:54 -0800 (PST)
Received: from [10.76.43.192] ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id d12sm9379702pgk.29.2022.02.07.19.46.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 19:46:54 -0800 (PST)
Message-ID: <43428234-93e3-806a-b0ff-0f1c2d7b7cb9@bytedance.com>
Date:   Tue, 8 Feb 2022 11:46:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: Re: [PATCH v3] sched/numa: add per-process numa_balancing
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        songmuchun@bytedance.com, zhengqi.arch@bytedance.com
References: <20211206024530.11336-1-ligang.bdlg@bytedance.com>
 <Yd7pKuvjayH4q14L@hirez.programming.kicks-ass.net>
From:   Gang Li <ligang.bdlg@bytedance.com>
In-Reply-To: <Yd7pKuvjayH4q14L@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/1/12 22:43, Peter Zijlstra wrote:
> On Mon, Dec 06, 2021 at 10:45:28AM +0800, Gang Li wrote:
>> This patch add a new api PR_NUMA_BALANCING in prctl.
>>
>> A large number of page faults will cause performance loss when numa
>> balancing is performing. Thus those processes which care about worst-case
>> performance need numa balancing disabled. Others, on the contrary, allow a
>> temporary performance loss in exchange for higher average performance, so
>> enable numa balancing is better for them.
>>
>> Numa balancing can only be controlled globally by
>> /proc/sys/kernel/numa_balancing. Due to the above case, we want to
>> disable/enable numa_balancing per-process instead.
>>
>> Add numa_balancing under mm_struct. Then use it in task_tick_fair.
>>
>> Set per-process numa balancing:
>> 	prctl(PR_NUMA_BALANCING, PR_SET_NUMAB_DISABLE); //disable
>> 	prctl(PR_NUMA_BALANCING, PR_SET_NUMAB_ENABLE);  //enable
>> 	prctl(PR_NUMA_BALANCING, PR_SET_NUMAB_DEFAULT); //follow global
> 
> This seems to imply you can prctl(ENABLE) even if the global is
> disabled, IOW sched_numa_balancing is off.
> 

Of course, this semantic has been discussed here FYI.
  https://lore.kernel.org/all/20211118085819.GD3301@suse.de/

On 11/18/21 4:58 PM, Mel Gorman wrote:
 > On Thu, Nov 18, 2021 at 11:26:30AM +0800, Gang Li wrote:
 >> 3. prctl(PR_NUMA_BALANCING, PR_SET_NUMAB_ENABLE);  //enable
 >
 > If PR_SET_NUMAB_ENABLE enables numa balancing for a task when
 > kernel.numa_balancing == 0 instead of returning an error then sure.


>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 884f29d07963..2980f33ac61f 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -11169,8 +11169,12 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
>>   		entity_tick(cfs_rq, se, queued);
>>   	}
>>   
>> -	if (static_branch_unlikely(&sched_numa_balancing))
>> +#ifdef CONFIG_NUMA_BALANCING
>> +	if (curr->mm && (curr->mm->numab_enabled == NUMAB_ENABLED
>> +	    || (static_branch_unlikely(&sched_numa_balancing)
>> +	    && curr->mm->numab_enabled == NUMAB_DEFAULT)))
>>   		task_tick_numa(rq, curr);
>> +#endif
>>   
>>   	update_misfit_status(curr, rq);
>>   	update_overutilized_status(task_rq(curr));
> 
> There's just about everything wrong there... not least of all the
> horrific coding style.

horrible code, yes.
I'll do some code clean.
-- 
Thanks
Gang Li

