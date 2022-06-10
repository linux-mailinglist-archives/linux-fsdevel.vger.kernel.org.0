Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D5F5464F7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jun 2022 13:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349390AbiFJLAG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jun 2022 07:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349033AbiFJK7y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jun 2022 06:59:54 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB227370E40;
        Fri, 10 Jun 2022 03:58:58 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id d14so9207019eda.12;
        Fri, 10 Jun 2022 03:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=w6F5upqNbqcjOOBJM+5BezuuZ8DymaMUCrQuFA3GOnA=;
        b=YZZv8NAd4bFAUuTNFuwIlDcmKTp86LFMvcog24DagojMbNLE5Se1DmFMVmJ87uRvVn
         DHg3DsyZl5P8aCUmB2QRs6OBqSILElVCVRD7bc68R64iLg9kYb342KPpCwWXWO184NBc
         HQcHyAdUhV8Q0WhynDc+yQ4/sZ7PQcZevq6VBL5SzqV6KYGeklmIRe38n9bvYY5Q1+JK
         WhZSTnmlqR3Jo6PN7avr1sSEwFMtRIB63k6sjGq6yDCPtUFoSFNusdQKAtNJh/AlfSLS
         +4BnHWFH5oLHuBp1MpFR5IFuUXStqITHPSeYQd5mB00paW4tZfj70WmiPHpMoU2dylt+
         VQsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=w6F5upqNbqcjOOBJM+5BezuuZ8DymaMUCrQuFA3GOnA=;
        b=Pr96j6qLhdcjOQnVJtW2daiDWogbgZXr4/x22m0Qe9SSsQlL7Yldinwk8MAAnoJl/E
         Jj1ZVFmAW3P8rujEEip0YvMH9QwJNzUSmK4PutV3l1SP3SCzTIwyLSVXWoPsrEqZ7HUc
         cUD6+jmO6xRvHG7Ux6fUP+vVuBs/OhhORuaEobmFRQe0LjI2mC1dgzuO+2yuIvUAZkmv
         yu5Q9eBwmRcqltArE24BE79cJnXKMPVa7KPeArBFFwJPW8FKEU2uIs+AZZqCuqHntc6j
         PG2kiNXAlu3Do8buTym0BQiRvFexNxsP0K91rFerlnRbSxJ1jd/BcLm+N7dCZfoB7MUU
         nd/A==
X-Gm-Message-State: AOAM532nUG4L7R9cMKY+lh0n4tkJfAk5USljJQjwQi5Mkn0ImomEvkAt
        SrITSVsdaqPrquQdAuXCIuc=
X-Google-Smtp-Source: ABdhPJwRYA/7eDJK0xNPvbtH+OzO5lQ4tB0JbSJQSmwOmyloSbsX0o7RtK6TGGmCWnVQA/XG1FkVRA==
X-Received: by 2002:a05:6402:368a:b0:42d:ef42:f727 with SMTP id ej10-20020a056402368a00b0042def42f727mr50676107edb.204.1654858736837;
        Fri, 10 Jun 2022 03:58:56 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea02f.dip0.t-ipconnect.de. [91.14.160.47])
        by smtp.gmail.com with ESMTPSA id fi20-20020a1709073ad400b006fec8e8eff6sm12055062ejc.176.2022.06.10.03.58.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jun 2022 03:58:55 -0700 (PDT)
Message-ID: <3f7d3d96-0858-fb6d-07a3-4c18964f888e@gmail.com>
Date:   Fri, 10 Jun 2022 12:58:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 03/13] mm: shmem: provide oom badness for shmem files
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        alexander.deucher@amd.com, daniel@ffwll.ch,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        hughd@google.com, andrey.grodzovsky@amd.com
References: <20220531100007.174649-1-christian.koenig@amd.com>
 <20220531100007.174649-4-christian.koenig@amd.com>
 <YqG67sox6L64E6wV@dhcp22.suse.cz>
 <77b99722-fc13-e5c5-c9be-7d4f3830859c@amd.com>
 <YqHuH5brYFQUfW8l@dhcp22.suse.cz>
 <26d3e1c7-d73c-cc95-54ef-58b2c9055f0c@gmail.com>
 <YqIB0bavUeU8Abwl@dhcp22.suse.cz>
 <d4a19481-7a9f-19bf-c270-d89baa0970fc@amd.com>
 <YqIMmK18mb/+s5de@dhcp22.suse.cz>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <YqIMmK18mb/+s5de@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am 09.06.22 um 17:07 schrieb Michal Hocko:
> On Thu 09-06-22 16:29:46, Christian König wrote:
> [...]
>> Is that a show stopper? How should we address this?
> This is a hard problem to deal with and I am not sure this simple
> solution is really a good fit. Not only because of the memcg side of
> things. I have my doubts that sparse files handling is ok as well.

Well I didn't claimed that this would be easy, we juts need to start 
somewhere.

Regarding the sparse file handling, how about using 
file->f_mapping->nrpages as badness for shmem files?

That should give us the real number of pages allocated through this 
shmem file and gracefully handles sparse files.

> I do realize this is a long term problem and there is a demand for some
> solution at least. I am not sure how to deal with shared resources
> myself. The best approximation I can come up with is to limit the scope
> of the damage into a memcg context. One idea I was playing with (but
> never convinced myself it is really a worth) is to allow a new mode of
> the oom victim selection for the global oom event. It would be an opt in
> and the victim would be selected from the biggest leaf memcg (or kill
> the whole memcg if it has group_oom configured.
>
> That would address at least some of the accounting issue because charges
> are better tracked than per process memory consumption. It is a crude
> and ugly hack and it doesn't solve the underlying problem as shared
> resources are not guaranteed to be freed when processes die but maybe it
> would be just slightly better than the existing scheme which is clearly
> lacking behind existing userspace.

Well, what is so bad at the approach of giving each process holding a 
reference to some shared memory it's equal amount of badness even when 
the processes belong to different memory control groups?

If you really think that this would be a hard problem for upstreaming we 
could as well keep the behavior for memcg as it is for now. We would 
just need to adjust the paramters to oom_badness() a bit.

Regards,
Christian.
