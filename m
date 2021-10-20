Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4599435044
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 18:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbhJTQhu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 12:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhJTQht (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 12:37:49 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C58C06161C;
        Wed, 20 Oct 2021 09:35:34 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id x66so49959pfx.13;
        Wed, 20 Oct 2021 09:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rIB4RavRgXcRDUTdHan5IBjQWDQ5rtleRcIK4BBeq24=;
        b=Dq+l1NK7j0k2wEeaEka8PtuRkbWUI5me6x4H3y/NPBhOwrtkvjXZAjEaOas436KnV2
         gG6PMQIq1yCDlSpOFJqTbRwGuaHqi4NBsDeij5PHYLdqqBG1txBmVnnfuVsIEvwnW3ZL
         qV4y3xiXseZ/JGB+NIpZLTyRC+0SYpkFkFQDu9pRlQJrhNVLFwNxc6vczwNTmJb7dlf1
         thQOnjKhR83LyLLFoZcEUmCimKclCXoJmG0COBS+sVshkiAT7xs/NFgbk2kLf/zpiMBR
         JIfG2xgxuac+KpO0LVdJ9dvK8pMAr98ttvMLuRxIlJVLfUpkerbnLI0/q2Bxx4p6Rq9v
         X6qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=rIB4RavRgXcRDUTdHan5IBjQWDQ5rtleRcIK4BBeq24=;
        b=Gn9ZUn+f3NatoPOO0olusCpzihaKlXXOZtG7tXA8FFdJ0zMdSTKMqWYSvv9I0wIqHn
         9q31hAEMYhwzGAUw+1s8+EZf4eZbGI/FGYuriZczYBTasUV/BknEqzfsvzTT3tElXDPm
         iXny7eUmhw0RBsJDGwtffliYu7Iv5BjFbD9KGn6mN75siSZON3aEwpQ+PsNg7tS4QEaC
         9F9Jzdjmlg20Yuil8PeEAYN0hMSkvPiEXsCSjvakj3Umj2eaCNNxocfQyyZPcaJ8Pwb7
         KJIo66ATFgi6gDlZ40IaVfqBS9+QaQR5gsOR19hjvePbAfd/492uGDQ2VfbXy7JfHyIP
         MpJQ==
X-Gm-Message-State: AOAM531g2MBDKlZWFmijbRT8n4Uzcfjb+lpTjdTfF/2pg/fTvxFmpZKG
        AQP3aVgJqe95oh843hdGahw=
X-Google-Smtp-Source: ABdhPJwALo6nxYWT/V1hWLI4mzfR05GZFNtQBPWFfux4F1VqxpYZSced0Qcn1LIJDg/X5wvpMwaUFQ==
X-Received: by 2002:a05:6a00:216f:b0:44b:6212:4967 with SMTP id r15-20020a056a00216f00b0044b62124967mr311110pff.23.1634747734135;
        Wed, 20 Oct 2021 09:35:34 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id z24sm3175655pfr.141.2021.10.20.09.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 09:35:33 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 20 Oct 2021 06:35:32 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Pratik Sampat <psampat@linux.ibm.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        bristot@redhat.com, christian@brauner.io, ebiederm@xmission.com,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, mingo@kernel.org,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        containers@lists.linux.dev, containers@lists.linux-foundation.org,
        pratik.r.sampat@gmail.com
Subject: Re: [RFC 0/5] kernel: Introduce CPU Namespace
Message-ID: <YXBFVCc61nCG5rto@slm.duckdns.org>
References: <20211009151243.8825-1-psampat@linux.ibm.com>
 <20211011101124.d5mm7skqfhe5g35h@wittgenstein>
 <a0f9ed06-1e5d-d3d0-21a5-710c8e27749c@linux.ibm.com>
 <YWirxCjschoRJQ14@slm.duckdns.org>
 <b5f8505c-38d5-af6f-0de7-4f9df7ae9b9b@linux.ibm.com>
 <YW2g73Lwmrhjg/sv@slm.duckdns.org>
 <77854748-081f-46c7-df51-357ca78b83b3@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77854748-081f-46c7-df51-357ca78b83b3@linux.ibm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On Wed, Oct 20, 2021 at 04:14:25PM +0530, Pratik Sampat wrote:
> As you have elucidated, it doesn't like an easy feat to
> define metrics like ballpark numbers as there are many variables
> involved.

Yeah, it gets tricky and we want to get the basics right from the get go.

> For the CPU example, cpusets control the resource space whereas
> period-quota control resource time. These seem like two vectors on
> different axes.
> Conveying these restrictions in one metric doesn't seem easy. Some
> container runtime convert the period-quota time dimension to X CPUs
> worth of runtime space dimension. However, we need to carefully model
> what a ballpark metric in this sense would be and provide clearer
> constraints as both of these restrictions can be active at a given
> point in time and can influence how something is run.

So, for CPU, the important functional number is the number of threads needed
to saturate available resources and that one is pretty easy. The other
metric would be the maximum available fractions of CPUs available to the
cgroup subtree if the cgroup stays saturating. This number is trickier as it
has to consider how much others are using but would be determined by the
smaller of what would be available through cpu.weight and cpu.max.

IO likely is in a similar boat. We can calculate metrics showing the
rbps/riops/wbps/wiops available to a given cgroup subtree. This would factor
in the limits from io.max and the resulting distribution from io.weight in
iocost's case (iocost will give a % number but we can translate that to
bps/iops numbers).

> Restrictions for memory are even more complicated to model as you have
> pointed out as well.

Yeah, this one is the most challenging.

Thanks.

-- 
tejun
