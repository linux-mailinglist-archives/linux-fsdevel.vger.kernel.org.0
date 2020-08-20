Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B6524C42B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 19:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730362AbgHTRJZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Aug 2020 13:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730446AbgHTRIL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Aug 2020 13:08:11 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F09C06134B
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2020 10:06:57 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id 185so2889505ljj.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2020 10:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j6WgqePZAKFwWv7oibyf66OC3S+SA0EwtLkT0KHMn7s=;
        b=bo+7UCzu3XtlLDsIdFcX5T2SOSSTsIkuEKVjv+td78vJUz4Qxj8E6pMzu0KujU0A8E
         wEY9X0HcNUH4MKDpEJcRCVekv731AB5t41ds1k6HDNgEAnDfiMuAYEd0JBMBCKkPIAls
         1ofwEbhEVneHVJ6n0purqzcbgSFawo2aR5Qj0bawUT6gizMqMxUdTu5Dax0QynHmnjhd
         hdB/1ctAxAaeD4O9/Pq7Bw19oxiBt6p7riIhI2gRNppDgxaBqie0QR49HWNaHkfr4pZR
         PmOswhZhm3v8rhV4eoYr9SX2GbowE+xyG+XqtRWsKplLcBdxMd2TZogrYKHaEzvA8E9/
         12yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j6WgqePZAKFwWv7oibyf66OC3S+SA0EwtLkT0KHMn7s=;
        b=TuV0QYbTKpmITCj9BmSWI9/oSYe5emeMJ2QV7MzX71xZSTzuGLWJwAELoCbkVQnGkz
         vTDVTlRpCZR87/Pk2BFTKrdythxgCQlqM55FcBbRJZ+RySROl48F8T9x1fJqSwcCqSA0
         gQLRzH+vTiCyDepWRlwLmsoZUssYnAKZESFPpz/6e9tCvzAxuMwQ4Jb8f8g1N4Bi8jPR
         v4cXdo9YqWx+Po5LxYC0OWgml2h0EksZHKCoAb3qVHxAWnA3WWk26/SygAbhm2YUeYfb
         KvdJnjBafCdSGr84qJ0C3YyV+jQsOns6laBt1USrjO+cNuBPkEINrSdDUzRe/XQmBXl4
         Dsmg==
X-Gm-Message-State: AOAM532qtFOrc2SIhxAFOm2zkEyHk9zf7Xu+Hh0ScHy24KfSzqUXEZ/x
        ddGIYJhEzwwk5Utjrb9L03XVGjzpK8By5G7WFbI/VA==
X-Google-Smtp-Source: ABdhPJziUJGXBSB9o6ksa6wt3btAspt3JpWrpRS8ydIXvVTIxvdXw64pBpOlKiXdI5HRmfJyA09t5CJD1wgjuiuMX0o=
X-Received: by 2002:a2e:9396:: with SMTP id g22mr2214071ljh.446.1597943215596;
 Thu, 20 Aug 2020 10:06:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200528135444.11508-1-schatzberg.dan@gmail.com>
In-Reply-To: <20200528135444.11508-1-schatzberg.dan@gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 20 Aug 2020 10:06:44 -0700
Message-ID: <CALvZod655MqFxmzwCf4ZLSh9QU+oLb0HL-Q_yKomh3fb-_W0Vg@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] Charge loop device i/o to issuing cgroup
To:     Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 28, 2020 at 6:55 AM Dan Schatzberg <schatzberg.dan@gmail.com> wrote:
>
> Much of the discussion about this has died down. There's been a
> concern raised that we could generalize infrastructure across loop,
> md, etc. This may be possible, in the future, but it isn't clear to me
> how this would look like. I'm inclined to fix the existing issue with
> loop devices now (this is a problem we hit at FB) and address
> consolidation with other cases if and when those need to be addressed.
>

What's the status of this series?
