Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 187F23D8609
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 05:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbhG1DRT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 23:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbhG1DRS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 23:17:18 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3066C061757;
        Tue, 27 Jul 2021 20:17:16 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id q17-20020a17090a2e11b02901757deaf2c8so2360195pjd.0;
        Tue, 27 Jul 2021 20:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I4bD52HQNVCYUp+mhhWgz8FNJ8BrE2vk1IbUNpEx9mc=;
        b=O8vdbtiSSnF7huzNnfIfptHg4BK2bgYcoQEclIsnGfmOOra4Xdk/QITTy+84+9kitx
         BYp/Sh5ewo+8bf4AJC/P0Q3U71IPe5HMptnSED42dGXWQLpHDPAIPhX1bguUnlZBnKgB
         aB2kecaHynHcaIXmEvnRg/G+0aET27nYjz9g3UGIpLWkw1q0dbTRHfXC/5CfsCDz4uXW
         ewgCEvqemZc+Ov93GmBN5AB9uTpFGRjHiUqfyqI16jZ8Czu3kW1dAmstrpgNb4SF+kqX
         oO1KbPFuqiSo1ZH3QZGC0coDcFt4AnZXvxc37pSgmdHNPlAsBCVh4BPL96npS4gCVwAJ
         nVsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I4bD52HQNVCYUp+mhhWgz8FNJ8BrE2vk1IbUNpEx9mc=;
        b=byZ6I65iGn9cyWbbRK/WnnTy+VtKUUbvfFQie9bbxaiZDgMuuS0P5cV8ehH+M5LyPx
         EuptAugGpI2c/5NTK/BE0B4KC2FM4StCfXjIPGnerpmJYZxzETZd+iztZwlAW4YX6yaj
         H4+0RCNU7RBn63u0EBNeeB19mEidt4PLt3+egCTj0Aizm1Vs9+YITItEV29kND6a5Zas
         VG1Doh+wSvdfpJxhR+F90HeU8kQR6EXpzl34jCypf9j/J7ij/uqJXrw3MUOhQL0OEp31
         UFTLYDoQBggyDuUOyM3DDLceA98W62lJCKj0mpxChfjn/HrdnHXs6bs8+3ZyAMiyApFY
         YJkg==
X-Gm-Message-State: AOAM532GWwCRzAUKlmz9eQw6pZatPbc4IV4/N2kW+wedIyC/rTqcWv9Q
        CBDJ2ssi9tGudoYm3J3J1qziSChn7Z4FgQ==
X-Google-Smtp-Source: ABdhPJzts8MDkebguIrKuEo2Mf7Fx/AxDKnceNtdB8dlpgbg5FjJsoG0NmlSjh+uCI/aKrnf5iiFFw==
X-Received: by 2002:a63:d34e:: with SMTP id u14mr7960675pgi.244.1627442236125;
        Tue, 27 Jul 2021 20:17:16 -0700 (PDT)
Received: from [192.168.255.10] ([203.205.141.110])
        by smtp.gmail.com with ESMTPSA id l10sm4363284pjg.11.2021.07.27.20.17.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 20:17:15 -0700 (PDT)
Subject: Re: [RFC PATCH v2 1/3] misc_cgroup: add support for nofile limit
To:     Tejun Heo <tj@kernel.org>
Cc:     viro@zeniv.linux.org.uk, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org
References: <3fd94563b4949ffbfe10e7d18ac1df3852b103a6.1626966339.git.brookxu@tencent.com>
 <YP8ovYqISzKC43mt@mtj.duckdns.org>
 <b2ff6f80-8ec6-e260-ec42-2113e8ce0a18@gmail.com>
 <YQA1D1GRiF9+px/s@mtj.duckdns.org>
From:   brookxu <brookxu.cn@gmail.com>
Message-ID: <ca2bdc60-f117-e917-85b1-8c9ec0c6942f@gmail.com>
Date:   Wed, 28 Jul 2021 11:17:08 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQA1D1GRiF9+px/s@mtj.duckdns.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Tejun Heo wrote on 2021/7/28 12:32 上午:
> Hello,
> 
> On Tue, Jul 27, 2021 at 11:18:00AM +0800, brookxu wrote:
>> According to files_maxfiles_init(), we only allow about 10% of free memory to
>> create filps, and each filp occupies about 1K of cache. In this way, on a 16G
>> memory machine, the maximum usable filp is about 1,604,644. In general
>> scenarios, this may not be a big problem, but if the task is abnormal, it will
>> very likely become a bottleneck and affect other modules. 
> 
> Yeah but that can be configured trivially through sysfs. The reason why the
> default limit is lowered is because we wanna prevent a part of system to
> consume all the memory through fds. With cgroups, we already have that
> protection and at least some systems already configure file-max to maximum,
> so I don't see a point in adding another interface to subdivide the
> artificial limit.
> 

Yeah we can adjust file-max through sysctl, but in many cases we adjust it according
to the actual load of the machine, not for abnormal tasks. Another problem is that in
practical applications, kmem_limit will cause some minor problems. In many cases,
kmem_limit is disabled. Limit_in_bytes mainly counts user pages and pagecache, which
may cause files_cache to be out of control. In this case, if file-max is set to MAX,
we may have a risk in the abnormal scene, which prevents us from recovering from the
abnormal scene. Maybe I missed something.

> Thanks.
> 
