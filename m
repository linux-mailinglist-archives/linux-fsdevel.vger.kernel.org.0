Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935354368B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 19:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbhJURIZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 13:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbhJURIY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 13:08:24 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7BBC061764;
        Thu, 21 Oct 2021 10:06:08 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id o4-20020a17090a3d4400b001a1c8344c3fso1505230pjf.3;
        Thu, 21 Oct 2021 10:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jrhIGZEqu0h/B8SeVSRWWn+zXKY1Hb4XraNoMEue39w=;
        b=OA705iIhr1YeBmH3LY1wuCrgfL3CUIvPxUFSRUYOFLixDWJ9TtX9x0pjMdukts/TdN
         aqXY23DJC+n0Mhx1JwFCNmnb0QvKL+AkBtOPdksPbpodAsZGKpKUp/R3Pr6QRt0IuSzr
         KS/WNb+Mvv5CVTVbuIdcK/5ZHYS6cN/etcx16Rc1NzHhH0IZGcAECTbnQfbgk3UY9FEG
         HnsSFWAfHrLCWehkpvqtY8RYoCWngNQoyPpeHfkAEHxTnNraxY2i52QEePbjkdpoglgM
         +cveexLYdYNMeRr61ZopCZ1boXOX6XShZbQEOJSZRz/3xBePCVgxaMhNi+E8oUdgznBY
         JOvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=jrhIGZEqu0h/B8SeVSRWWn+zXKY1Hb4XraNoMEue39w=;
        b=0zP4ijNBDQZz0WBlLTD4B0hP6uIjha53X97I9MbaYGszKnhG0VSHwJanfrImBbDNkH
         SoLau7ZayX+TQYb2amEVy/h4N+NAl9Vxt+i6H58uoDNXzdLNPbhkIhQ0Lj5RFcxKbi1G
         uOqLhc8oj4cjTf982J2eIXK4pgeYIXVJHNkhaW2DujW8ff4voh6y+jcN3vmFnUxAa1n2
         S3Tvs15fRrtrKPwW7iTGy3ueWccGcsJ4vFstuY4OSbGbZpRBRoGIbKMx55/cS8Rme36C
         KNPxx62V5nq+WbHma3CknGNMQhO9V9McaTQxbH+u5oQIuf4gm7XMdhIy7n0GCLvTqkn8
         IYiw==
X-Gm-Message-State: AOAM530kQfhz2t7kObYsdwteWpcwtIgRGOwdo/F5DaeP+Qdfq9pjjXa4
        jjaosoT81UI9pPWb2pKy3Zo=
X-Google-Smtp-Source: ABdhPJxNnBJ3A4oS8et0paTH4JI99DT0N0T5gYetTWhMgLWDBcJGMtkZJiafBFFyVFt1ubfsfcrmAw==
X-Received: by 2002:a17:90a:c913:: with SMTP id v19mr3805112pjt.117.1634835967957;
        Thu, 21 Oct 2021 10:06:07 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id z24sm6310084pgu.54.2021.10.21.10.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 10:06:07 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 21 Oct 2021 07:06:05 -1000
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
Message-ID: <YXGd/T0YHG/xEAkw@slm.duckdns.org>
References: <20211009151243.8825-1-psampat@linux.ibm.com>
 <20211011101124.d5mm7skqfhe5g35h@wittgenstein>
 <a0f9ed06-1e5d-d3d0-21a5-710c8e27749c@linux.ibm.com>
 <YWirxCjschoRJQ14@slm.duckdns.org>
 <b5f8505c-38d5-af6f-0de7-4f9df7ae9b9b@linux.ibm.com>
 <YW2g73Lwmrhjg/sv@slm.duckdns.org>
 <77854748-081f-46c7-df51-357ca78b83b3@linux.ibm.com>
 <YXBFVCc61nCG5rto@slm.duckdns.org>
 <bd1811cc-0e04-9e44-0b46-02689ff9a238@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd1811cc-0e04-9e44-0b46-02689ff9a238@linux.ibm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On Thu, Oct 21, 2021 at 01:14:10PM +0530, Pratik Sampat wrote:
> I'm speculating, and please correct correct me if I'm wrong; suggesting
> an optimal number of threads to spawn to saturate the available
> resources can get convoluted right?
> 
> In the nginx example illustrated in the cover patch, it worked best
> when the thread count was N+1 (N worker threads 1 master thread),
> however different applications can work better with a different
> configuration of threads spawned based on its usecase and
> multi-threading requirements.

Yeah, I mean, the number would have to be based an ideal conditions - ie.
the cgroup needs N always-runnable threads to saturate all the available
CPUs and then applications can do what they need to do based on that
information. Note that this is equivalent to making these decisions based on
number of CPUs.

> Eventually looking at the load we maybe able to suggest more/less
> threads to spawn, but initially we may have to have to suggest threads
> to spawn as direct function of N CPUs available or N CPUs worth of
> runtime available?

That kind of dynamic tuning is best done with PSI which can reliably
indicate saturation and the degree of contention.

> > The other
> > metric would be the maximum available fractions of CPUs available to the
> > cgroup subtree if the cgroup stays saturating. This number is trickier as it
> > has to consider how much others are using but would be determined by the
> > smaller of what would be available through cpu.weight and cpu.max.
> 
> I agree, this would be a very useful metric to have. Having the
> knowledge for how much further we can scale when we're saturating our
> limits keeping in mind of the other running applications can possibly
> be really useful not just for the applications itself but also for the
> container orchestrators as well.

Similarly, availability metrics would be useful in ballpark sizing so that
applications don't have to dynamically tune across the entire range, the
actual adustments to stay saturated is likely best done through PSI, which
is the direct metric indicating resource saturation.

Thanks.

-- 
tejun
