Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE043A85EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 18:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbhFOQDO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 12:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbhFOQDJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 12:03:09 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF88CC061144;
        Tue, 15 Jun 2021 08:59:27 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id j62so28675310qke.10;
        Tue, 15 Jun 2021 08:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GL+RU9f1AKmMjTvDhvbMJyhE7RlsIlk2mxWhqIrVH80=;
        b=jkq8Km4vHTP7xZdrBvuBD4dByJ3zPoS+EImCYNZJ7O2IRlpr0D0e7kKl3ZXrex3iEj
         EKbrXTLwfwseiGI0RACOJgzGGcn7IRmzsobaa3/g8UYVQgWtCLTeMkK1y45t7JJg7E4G
         pGUhbQA0ppXUGAcG4qnauwNA3tYW6f1mm/77DyS53+guGLUR+UeaUKC+gvu9a1fxHza7
         FCR+80zeNEJUhhaYae5sZM+lTC0Lc6xzJrFDbWdadTr8AcOtAcc4ZCyvvVySiWXaTsHv
         ioDfO+9kBeUDmvBjr4hUmoEjD6wQxXww9KLyipFDbDLCELWSFIPAL0dwTvcAKYYHpOvF
         KuEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=GL+RU9f1AKmMjTvDhvbMJyhE7RlsIlk2mxWhqIrVH80=;
        b=AjE99Dqd7ZjDU+DDU+M3qtXkL45WXG1WonmwQVOglKdxxgMYId72Lwq4SRNyoFB/5+
         F6zfGmPoF95V879TPLFNpYhOiiBkMyLB3xtsXh7s7ucRFe20fgIVRh76drfd1DLCz95G
         cOKJUPKM794bRIPzd5TsX7xE2v19p1GNhqcTmqyXhJOYWN9NoLsp95awme/eud+2TF4M
         +UDy7YxGHm1LxN/RgREvDaQywvfLY2RjguzsUYuweL76z1Q6dq9EenH8UY7PjJ+e5Wr+
         8cdQDcU0zqitSBtTatC5VneQZ3IYcfgWnZSsEMwhNK23AbYvew+JA+QXd1zeo5+TyeZi
         kAAQ==
X-Gm-Message-State: AOAM533xrQmk30N8R1ws75GVPDaUhYh46voa5OypKLGs+w7rtsT4P3Kd
        pz5/AxCg10fqC4WOjede7BJ4zMA/4gC7Xg==
X-Google-Smtp-Source: ABdhPJwqJf7MDjwtRrhsG7BsS7Rr+a8TPLjDd3Rn4jgmAZ6wvYAx7YTZW8JCgQHoNuxEHZpWNqBOoQ==
X-Received: by 2002:a37:3c2:: with SMTP id 185mr343685qkd.140.1623772766962;
        Tue, 15 Jun 2021 08:59:26 -0700 (PDT)
Received: from localhost ([199.192.137.73])
        by smtp.gmail.com with ESMTPSA id 75sm10439412qkm.57.2021.06.15.08.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 08:59:26 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 15 Jun 2021 11:59:25 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <llong@redhat.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>, x86@kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/4] cgroup/cpuset: Allow cpuset to bound displayed cpu
 info
Message-ID: <YMjGXlwQEHFwXZ4/@slm.duckdns.org>
References: <20210614152306.25668-1-longman@redhat.com>
 <YMe/cGV4JPbzFRk0@slm.duckdns.org>
 <0e21f16d-d91b-7cec-d832-4c401a713b10@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e21f16d-d91b-7cec-d832-4c401a713b10@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello, Waiman.

On Mon, Jun 14, 2021 at 10:53:53PM -0400, Waiman Long wrote:
> Thanks for your comment. I understand your point making change via cgroup
> interface files. However, this is not what the customers are asking for.

It's not like we can always follow what specific customers request. If there
are actual use-cases that can't be achieved with the existing interfaces and
features, we can look into how to provide those but making interface
decisions based on specific customer requests tends to lead to long term
pains.

> They are using tools that look at /proc/cpuinfo and the sysfs files. It is a
> much bigger effort to make all those tools look at a new cgroup file
> interface instead. It can be more efficiently done at the kernel level.

Short term, sure, it sure is more painful to adapt, but I don't think longer
term solution lies in the kernel trying to masquerage existing sytsem-wide
information interfaces. e.g. cpuset is one thing but what are we gonna do
about weight control or work-conserving memory controls? Pro-rate cpu count
and available memory?

> Anyway, I am OK if the consensus is that it is not a kernel problem and have
> to be handled in userspace.

I'd be happy to provide more information from kernel side as necessary but
the approach taken here doesn't seem generic or scalable at all.

> BTW, do you have any comment on another cpuset patch that I sent a week
> earlier?
> 
> https://lore.kernel.org/lkml/20210603212416.25934-1-longman@redhat.com/
> 
> I am looking forward for your feedback.

Sorry about the delay. Will take a look later today.

Thanks.

-- 
tejun
