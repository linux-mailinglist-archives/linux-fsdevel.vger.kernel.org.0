Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F56044ABB1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Nov 2021 11:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245425AbhKIKni (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Nov 2021 05:43:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245420AbhKIKnh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Nov 2021 05:43:37 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9BCC061767
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Nov 2021 02:40:52 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id t21so20141198plr.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Nov 2021 02:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ijkZGpaFpq6LV8Gg8reo+SGCxLMW6UmnTU/srKB0UIc=;
        b=T3YiUPJYSknWJO0k0ZBPc+Hfc2pdbROPOfOnZ4i3Bzpubl9KUT7aLNzl70vpfrZFd4
         S8PgbtElpzfz+ter7uV5y4U8QWPW0Md0+qantVOPX3mxmhU//7vzBGlJ7L/jxFxuU3dF
         be45f4qIlcndP6Em8lOmWG6KHlo6gZsW20iKtn/FmXagbz8rKmwu10WBo+M3RWJo7qQC
         LLjeIxWF61EQUqZa2aIO+rWRbG2+wVmDr6cpa9AWL16MI5lAeaPKFMjAACnqAOtmH8Xd
         j0UA8kXzVVj+gd/r9HnVZiYnP+wKj9L9NR/RjfVPuejWnVT6CvC6rv1GPRvJ24UJPl/u
         DUmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ijkZGpaFpq6LV8Gg8reo+SGCxLMW6UmnTU/srKB0UIc=;
        b=VJ/W2UqHljYQU4+TpHs5gPsCqQMH+oHUsERE7Zhu3Ek/YWqI1IGzbf1VwY+dJMDdFp
         bKYasRhHxaJTPcegraUTrfL9kftn9OemW6ajNv2+yAIaiOxkVykUbktAS43w+ot8N3MF
         rMIN2G7fDZNLN2AucrUHvsWzgHxtIitYut5rjVsJoSmnew9vZmb4zjhJSMlt+zUiy3F9
         Bkee54Ilmr52VjDGkWUgNmqBegm0oF4lW3KY6pIdLxBV4ML38ngdfNE3c96F9Wa5Fc0q
         XPdxkC2QQzcN/+uOv+kK7cfKCTAZIMSUxemdgt8dlbBiU7HQ+BixrSqPiPAIcdCjnpwY
         Z3rw==
X-Gm-Message-State: AOAM531hbd5/COAqLJfabN+9zjD+W87ItC3dta13UHx3vvmpfX7sVXdI
        2smqqmI5CWmIkCLiUY2QFlpOjQ==
X-Google-Smtp-Source: ABdhPJyh2eh8cVDZfvZs49FwaWVzUtwCEWQ1SARsnhb2KFJzuK+iPRCqbAddHfiRgdFarLhZ85oEzA==
X-Received: by 2002:a17:90a:2fc7:: with SMTP id n7mr6006745pjm.141.1636454451646;
        Tue, 09 Nov 2021 02:40:51 -0800 (PST)
Received: from [10.254.105.98] ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id s2sm8895919pfg.124.2021.11.09.02.40.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Nov 2021 02:40:51 -0800 (PST)
Subject: Re: Re: Re: Re: [PATCH v1] sched/numa: add per-process numa_balancing
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
From:   Gang Li <ligang.bdlg@bytedance.com>
Message-ID: <7de25e1b-e548-b8b5-dda5-6a2e001f3c1a@bytedance.com>
Date:   Tue, 9 Nov 2021 18:40:43 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211109091951.GW3891@suse.de>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/9/21 5:19 PM, Mel Gorman wrote:
> On Tue, Nov 09, 2021 at 04:28:28PM +0800, Gang Li wrote:
>> If the global tuning affects default behaviour and the prctl
>> affects specific behaviour.  Then when prctl specifies
>> numa_balancing for a process, there is no way for the
>> global tuning to affect that process.
> 
> While I think it's very likely that the common case will be to disable
> NUMA balancing for specific processes,
> prctl(PR_NUMA_BALANCING,PR_SET_NUMA_BALANCING,1) should still be
> meaningful.
> 

I'm still a bit confused.

If we really want to enable/disable numa_balancing for all processes, 
but some of them override the global numa_balancing using prctl, what 
should we do?

Do we iterate through these processes to enable/disable them individually?


