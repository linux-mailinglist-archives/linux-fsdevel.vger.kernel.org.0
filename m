Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBE643A59F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 23:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235008AbhJYVRI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 17:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbhJYVRC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 17:17:02 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85552C061348
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Oct 2021 14:14:37 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d5so12191679pfu.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Oct 2021 14:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z00lUsatKc2imgSiGWIDZF0uIcC3k7FGBboNiOBf+rE=;
        b=eId9LLzyLrwvA9SohTjGnv3oVmE6ccHoQVKehocpPnrGwwPgiFRy84ppKNC+f37VpV
         mRt73YFIU/x33pg3q5YAAetghE/xrqlePxhK0vjYN35FOjfLpjl+tvmFfeY2XYDAeKh6
         sn/dyNA2Nqsw61mI5VTCzsVgIk1CFPaNCLrGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z00lUsatKc2imgSiGWIDZF0uIcC3k7FGBboNiOBf+rE=;
        b=q9yK6VHjG6nIN0rTHa+e2QyhRkWbfL2XJZCLNoYnVe1ENNLRfeP/ArFCpvf/ulNTKk
         blDCSqDvgSaW6ZyCMHr/JUxboROtMJ9M965TE6GLOO0sUTJFpvKYXmXE8Rbi+zLWn0Z0
         V4FQn/F6tMr/OllZPsDuUxct5yWbmUNwT8w6QLY/et6JgQlwcpiXddCyyI0wVgU/jiw0
         3+Rym7Zg2WEbwvlx6h++B7ctMG0UMFUxqzLyd0EHJgEvmk3weFzSS4EBNmy6PMdwFJVi
         77lxDSZ85pIKX6N6kgXrSiP4gtKJZ81c8Z0ggbwYbGnQXSMgoe4VIlJ/G4NaX8qAHj4g
         QLrQ==
X-Gm-Message-State: AOAM530zI1LsZws9qbtUp1Oedjy2YvXNgUuCZzGKg2oxeUyL0T5MauEe
        VVArdLiSXrmCa0AAX427nNRgUA==
X-Google-Smtp-Source: ABdhPJxC8V4in0W+okVM7nD41XtGYGFz6iLA1Rdh91iNuWdlW5+5qNUga5c7e3xlWKMxb0NrgoI4Ww==
X-Received: by 2002:a05:6a00:2388:b0:44d:4b5d:d5e with SMTP id f8-20020a056a00238800b0044d4b5d0d5emr20949254pfc.80.1635196477239;
        Mon, 25 Oct 2021 14:14:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t3sm16694772pgu.87.2021.10.25.14.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 14:14:36 -0700 (PDT)
Date:   Mon, 25 Oct 2021 14:14:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     akpm@linux-foundation.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com,
        pmladek@suse.com, peterz@infradead.org, viro@zeniv.linux.org.uk,
        valentin.schneider@arm.com, qiang.zhang@windriver.com,
        robdclark@chromium.org, christian@brauner.io,
        dietmar.eggemann@arm.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        dennis.dalessandro@cornelisnetworks.com,
        mike.marciniszyn@cornelisnetworks.com, dledford@redhat.com,
        jgg@ziepe.ca, linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, oliver.sang@intel.com, lkp@intel.com,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Vladimir Zapolskiy <vzapolskiy@gmail.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v6 03/12] drivers/connector: make connector comm always
 nul ternimated
Message-ID: <202110251411.93B477676B@keescook>
References: <20211025083315.4752-1-laoar.shao@gmail.com>
 <20211025083315.4752-4-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025083315.4752-4-laoar.shao@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 25, 2021 at 08:33:06AM +0000, Yafang Shao wrote:
> connector comm was introduced in commit
> f786ecba4158 ("connector: add comm change event report to proc connector").
> struct comm_proc_event was defined in include/linux/cn_proc.h first and
> then been moved into file include/uapi/linux/cn_proc.h in commit
> 607ca46e97a1 ("UAPI: (Scripted) Disintegrate include/linux").
> 
> As this is the UAPI code, we can't change it without potentially breaking
> things (i.e. userspace binaries have this size built in, so we can't just
> change the size). To prepare for the followup change - extending task
> comm, we have to use __get_task_comm() to avoid the BUILD_BUG_ON() in
> proc_comm_connector().

I wonder, looking at this again, if it might make more sense to avoid
this cn_proc.c change, and instead, adjust get_task_comm() like so:

#define get_task_comm(buf, tsk)
        __get_task_comm(buf, __must_be_array(buf) + sizeof(buf), tsk)

This would still enforce the original goal of making sure
get_task_comm() is being used on a char array, and now that
__get_task_comm() will truncate & pad, it's safe to use on both
too-small and too-big arrays.

-- 
Kees Cook
