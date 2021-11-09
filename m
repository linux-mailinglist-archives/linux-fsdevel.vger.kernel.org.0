Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A752644AF1C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Nov 2021 14:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237074AbhKIOB2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Nov 2021 09:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbhKIOB1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Nov 2021 09:01:27 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916E2C061764
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Nov 2021 05:58:41 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id p17so18561536pgj.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Nov 2021 05:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y30tES1mRbobBQ+m/yFfcYggfkhOFouTPN0eCLqdkac=;
        b=Uxmdf4znCpTXGzwMRB/AMMCqss7/LZk+9jxusKZRrq3r5+Tb+7PwY3/Uz+yuixUuTc
         a7KF+nrZAsxO0ezbYvMvahzD9nRoKh1K1Y1fhWIYzbjkVQNwkF1Ldmtg7D7xKs02Bx1I
         +2Qzciv5ZLtEFIgXWj5hLSZStRi/GVrOhKefP5n/45RUXE4BVstirUAKlQSzaIJXE8Mq
         vOrCFmoZzUJaJnuqw3nYonp0nWKmW4aN55IH3I6CW3GGxxPXkU8syNSvsXMgoAqw69r5
         efJwpH4k6IteCT9DfyhNnHVnPdsfftpuObaExxMpZ/URQma3NEkYdYudn92CR7TZgE7B
         hKqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y30tES1mRbobBQ+m/yFfcYggfkhOFouTPN0eCLqdkac=;
        b=WelG3XNrsjTJ0aHnPWD0RtZlCeSt7/gajzFkEdJJVffluewMcXxkYix0ROgDW9gOSG
         SNIxIG0+PjdixChn5yC9tHIgKXXmSY44uIzF/i7UKrZ8nvguTn4FvgFrOnICOxICuXHb
         2kkcPe0bAMRJgw2/ZCoRMX4hU1SGe8/iI0KbVgWDaPi9Oq7OvH1wimT9OB4TiIFcWI9z
         ZeSDLNdndrmd3eGOLctLP39Rvf+2yC8RrcVvVeRb8bBC5gM9bIaOHjAQ4CKqITekeq35
         9p8uD920aQphqptasPJmnKGHsx12Mb0G+SN4+8gnawbRp87q3IwK9mlwJ5SY7JvJnc8a
         aZGQ==
X-Gm-Message-State: AOAM5314d7e3E/+w8GSyf7uQt5ZAr0NFOVjBlzvDH2pbXNFTYp6PIOZO
        F9RftzAPukm8kf5p47hJtaEBOG20vgD7mg==
X-Google-Smtp-Source: ABdhPJzWFlZcFbzZsn65SN5dY7OVkgY7rcUmnQO3V4I/9mqB60l/OLip0qZ0tcw0tPBNnSncs09/Uw==
X-Received: by 2002:a63:9042:: with SMTP id a63mr5939760pge.345.1636466321161;
        Tue, 09 Nov 2021 05:58:41 -0800 (PST)
Received: from [10.254.105.98] ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id p3sm18854221pfb.205.2021.11.09.05.58.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Nov 2021 05:58:40 -0800 (PST)
From:   Gang Li <ligang.bdlg@bytedance.com>
Subject: Re: Re: Re: Re: Re: [PATCH v1] sched/numa: add per-process
 numa_balancing
To:     Mel Gorman <mgorman@suse.de>
Cc:     Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-api@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20211027132633.86653-1-ligang.bdlg@bytedance.com>
 <20211028153028.GP3891@suse.de>
 <b884ad7d-48d3-fcc8-d199-9e7643552a9a@bytedance.com>
 <20211029083751.GR3891@suse.de>
 <CAMx52ARF1fVH9=YLQMjE=8ckKJ=q3X2-ovtKuQcoTyo564mQnQ@mail.gmail.com>
 <20211109091951.GW3891@suse.de>
 <7de25e1b-e548-b8b5-dda5-6a2e001f3c1a@bytedance.com>
 <20211109121222.GX3891@suse.de>
Message-ID: <117d5b88-b62b-f50b-32ff-1a9fe35b9e2e@bytedance.com>
Date:   Tue, 9 Nov 2021 21:58:34 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211109121222.GX3891@suse.de>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/9/21 8:12 PM, Mel Gorman wrote:
> 
> That would be a policy decision on how existing tasks should be tuned
> if NUMA balancing is enabled at runtime after being disabled at boot
> (or some arbitrary time in the past). Introducing the prctl does mean
> that there is a semantic change for the runtime enabling/disabling
> of NUMA balancing because previously, enabling global balancing affects
> existing tasks and with prctl, it affects only future tasks. It could
> be handled in the sysctl to some exist
> 
> 0. Disable for all but prctl specifications
> 1. Enable for all tasks unless disabled by prctl
> 2. Ignore all existing tasks, enable for future tasks
> 
> While this is more legwork, it makes more sense as an interface than
> prctl(PR_NUMA_BALANCING,PR_SET_NUMA_BALANCING,1) failing if global
> NUMA balancing is disabled.
> 

Why prctl(PR_NUMA_BALANCING,PR_SET_NUMA_BALANCING,1) must work while 
global numa_balancing is disabled? No offense, I think that is a bit 
redundant. And it's complicated to implement.

It's hard for me to understand the whole vision of your idea. I'm very 
sorry. Can you explain your full thoughts more specifically?

----------------------------------------------------

Also in case of misunderstanding, let me re-explain my patch using 
circuit diagram.

Before my patch, there is only one switch to control numa_balancing.

             ______process1_
...____/ __|______process2_|__...
            |______process3_|

        |
     global numa_balancing

After my patch, we can selectively disable numa_balancing for processes.
And global switch has a high priority.

             __/ __process1_
...____/ __|__/ __process2_|__...
            |__/ __process3_|

        |       |
     global  per-process

Why global numa_balancing has high priority? There are two reasons:
1. numa_balancing is useful to most processes, so there is no need to 
consider how to enable numa_balancing for a few processes while 
disabling it globally.
2. It is easy to implement. The more we think, the more complex the code 
becomes.
