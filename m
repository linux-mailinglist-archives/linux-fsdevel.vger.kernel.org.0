Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE35A4295F5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Oct 2021 19:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbhJKRoh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Oct 2021 13:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233583AbhJKRo3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Oct 2021 13:44:29 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AD0C061570;
        Mon, 11 Oct 2021 10:42:29 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id kk10so13813004pjb.1;
        Mon, 11 Oct 2021 10:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=cv+8p4QBr+yumNO08E52pdNZjmudW0YvW+eKFeVXzNw=;
        b=X2Ln10Tg4qFyX1S7WwFgytlT9WmcLpxGM4Zit5dEo/o+1WnWYfpNX3gNqY4uzNIAN6
         Ntyju7CQJyfW85aoc0hfLy+G7n+1MefYEgfBKmm0h1ZuvROPAUWv3EVbcTtD4vcfc+pg
         XrIwgPiXVy1qkK/HWnDaeiKTRSPRwPmqGK278qGMcqunMoECVG4wY8sKczSXTrp5P7dG
         p8gHyjLlv03q7Um00Npt36ae6F98ErTGhZoMrEuwsh+yY3MijosVvecksUfE/jMtXzxj
         vkO9BV7RzVaMhR3xGwb8bNFnp3uyzr8dBPSYQ+ONNzOqyFNGGEhOqfefekQeLs1fMCxj
         +bCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=cv+8p4QBr+yumNO08E52pdNZjmudW0YvW+eKFeVXzNw=;
        b=i/rcDgzX2N5JL9nXwT6WaW8czcuaP285NHTUHpGMFy4ARBmvpcAJ3rZMTomSgdaERH
         Zovr9/B0fO3OmZFhBBL+EgBgD68a2Vf2nByFq5QVSq93QnTF1cqmHeP1D0cQv2f1rcnl
         ESP4SyYI6v2m8aXSK6v5BtHuy3WnUzfdTGSkEmFjry/3S/+knXS08LLXdqHikwiiiHYj
         G1khgsMza/WuqUjfduQkKsHNtv501fXa375Fcsh8YuccTYIgrVHa/70IhXhdlaqZlDOf
         exhkmyXBDzH7hMLP6OmhptNelF7idScEtxvIKEntrNCi2o5UE4kWK9RYo/ymYJKn9o4f
         +lDw==
X-Gm-Message-State: AOAM533vpfs+SFrA3OGS4TcaBP347mhxSUCuNNA2h1fOhNVxwr9a21hU
        qzYA5sgZ4RAByWK6XezbvCo=
X-Google-Smtp-Source: ABdhPJzFg5/nX0pFvcYymJXdKatF3YOnKw5en66PJoUNMTNFTwT1k00B02IC7OgL2Qt8J7R1nPrwNQ==
X-Received: by 2002:a17:90a:8b89:: with SMTP id z9mr367573pjn.89.1633974148929;
        Mon, 11 Oct 2021 10:42:28 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id e12sm8471062pfl.67.2021.10.11.10.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 10:42:28 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 11 Oct 2021 07:42:27 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        "Pratik R. Sampat" <psampat@linux.ibm.com>, bristot@redhat.com,
        christian@brauner.io, ebiederm@xmission.com,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, mingo@kernel.org,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        containers@lists.linux.dev, containers@lists.linux-foundation.org,
        pratik.r.sampat@gmail.com
Subject: Re: [RFC 0/5] kernel: Introduce CPU Namespace
Message-ID: <YWR3g+ZE2j3w1Npz@slm.duckdns.org>
References: <20211009151243.8825-1-psampat@linux.ibm.com>
 <20211011101124.d5mm7skqfhe5g35h@wittgenstein>
 <20211011141737.GA58758@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211011141737.GA58758@blackbody.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On Mon, Oct 11, 2021 at 04:17:37PM +0200, Michal Koutný wrote:
> The problem as I see it is the mapping from a real dedicated HW to a
> cgroup restricted environment ("container"), which can be shared. In
> this instance, the virtualized view would not be able to represent a
> situation when a CPU is assigned non-exclusively to multiple cpusets.

There is a fundamental problem with trying to represent a resource shared
environment controlled with cgroup using system-wide interfaces including
procfs because the goal of many cgroup resource control includes
work-conservation, which also is one of the main reason why containers are
more attractive in resource-intense deployments. System-level interfaces
naturally describe a discrete system, which can't express the dynamic
distribution with cgroups.

There are aspects of cgroups which are akin to hard partitioning and thus
can be represented by diddling with system level interfaces. Whether those
are worthwhile to pursuit depends on how easy and useful they are; however,
there's no avoiding that each of those is gonna be a very partial and
fragmented thing, which significantly contributes the default cons list of
such attempts.

> > Existing solutions to the problem include userspace tools like LXCFS
> > which can fake the sysfs information by mounting onto the sysfs online
> > file to be in coherence with the limits set through cgroup cpuset.
> > However, LXCFS is an external solution and needs to be explicitly setup
> > for applications that require it. Another concern is also that tools
> > like LXCFS don't handle all the other display mechanism like procfs load
> > stats.
> >
> > Therefore, the need of a clean interface could be advocated for.
> 
> I'd like to write something in support of your approach but I'm afraid that the
> problem of the mapping (dedicated vs shared) makes this most suitable for some
> external/separate entity such as the LCXFS already.

This is more of a unit problem than an interface one - ie. the existing
numbers in the system interface doesn't really fit what needs to be
described.

One approach that we've found useful in practice is dynamically changing
resource consumption based on shortage, as measured by PSI, rather than some
number representing what's available. e.g. for a build service, building a
feedback loop which monitors its own cpu, memory and io pressures and
modulates the number of concurrent jobs.

There are some numbers which would be fundamentlaly useful - e.g. ballpark
number of threads needed to saturate the computing capacity available to the
cgroup, or ballpark bytes of memory available without noticeable contention.
Those, I think we definitely need to work on, but I don't see much point in
trying to bend existing /proc numbers for them.

Thanks.

-- 
tejun
