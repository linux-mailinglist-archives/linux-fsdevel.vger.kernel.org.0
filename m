Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A893324D7F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 17:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgHUPEM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 11:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgHUPEK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 11:04:10 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0E8C061573;
        Fri, 21 Aug 2020 08:04:10 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id j187so1604924qke.11;
        Fri, 21 Aug 2020 08:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1FzqZJ6ck6KUzOqSuKnj7ejxM9ufdWSJqP1xoW29qVs=;
        b=YMyC8odRxwt4e+ebHOdmQFNxzIqRf1A3/okUdcouS+5ljxpc1mDGkbrRKCaOWLMRFr
         tbYI+SM/yvrHIvogo40z5OqLqYJkChEfGfUzeEtpFZaCRIPZPxYLYEHSc17+Zo/0VE9d
         TzKI7FDaqtwoQKWX9hUMNi6bHRg3MniqKbnRaJ20ycXK2km/LwmfJw14EqQ2fXHsyxJH
         0cd8PXp02Ei2m+BYXl573s3GRyAK3iD/xnGq61OQAg6T9ndogxeZFI095Wf2QmPScfjg
         nermWatu5yNdkT9mlCcjxRIfZTCkdBGzvDieCK0LVBtz3oicHcxtogJkOwk+IkcJnSXu
         Ya/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1FzqZJ6ck6KUzOqSuKnj7ejxM9ufdWSJqP1xoW29qVs=;
        b=iUJkRQeFuIukuRSEOMFErl0LkqrL0GhzAQyEUQlCYB5bVklpS1yEj+XAX66UPrmDuf
         00YjYkUrT04sHR23bLHQ4Lk9/mfUbjvOe4yFZyp0T/a7KDGy/9/yEPKyRxHIcqM4sBKR
         rVf5yAF9CBWPWFJk7Ekt+lF99XR3pZczL7zh+YbBmYCeA1/NaJL0iSOHYDoF43RtUnfK
         Dpo0chkyE6ts3u5DGrkIn4BdE4fdRJVT2yS4Ai5DlGX0Kjf9T0gDdvfplaJjleS78VBZ
         l1xqJbzaGbxMjIuYH4l3SMF3eLed3qwUj2iEh7eudzn4Ah7SXIQRKXitOzgfex6uJ7EO
         sb6A==
X-Gm-Message-State: AOAM530WGpk0dcBgs7pBgxdpKQNKzYBRjKI8hn0kaq82MMkDD9JJ+fEO
        jPiy0dxR2yG/Fbo9kW0xXgw=
X-Google-Smtp-Source: ABdhPJyBL+mb4e1OJT95Eq9kjSKGYgP7Np7BlljR/yVQfblx5fKS/WHmWdNwlkY/T6ACOLTj7g3OPw==
X-Received: by 2002:a05:620a:24c9:: with SMTP id m9mr3122749qkn.487.1598022249324;
        Fri, 21 Aug 2020 08:04:09 -0700 (PDT)
Received: from dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com ([2620:10d:c091:480::1:4586])
        by smtp.gmail.com with ESMTPSA id 65sm1942875qkf.33.2020.08.21.08.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 08:04:08 -0700 (PDT)
Date:   Fri, 21 Aug 2020 11:04:05 -0400
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
To:     Shakeel Butt <shakeelb@google.com>
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
Subject: Re: [PATCH v6 0/4] Charge loop device i/o to issuing cgroup
Message-ID: <20200821150405.GA4137@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com>
References: <20200528135444.11508-1-schatzberg.dan@gmail.com>
 <CALvZod655MqFxmzwCf4ZLSh9QU+oLb0HL-Q_yKomh3fb-_W0Vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod655MqFxmzwCf4ZLSh9QU+oLb0HL-Q_yKomh3fb-_W0Vg@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 20, 2020 at 10:06:44AM -0700, Shakeel Butt wrote:
> On Thu, May 28, 2020 at 6:55 AM Dan Schatzberg <schatzberg.dan@gmail.com> wrote:
> >
> > Much of the discussion about this has died down. There's been a
> > concern raised that we could generalize infrastructure across loop,
> > md, etc. This may be possible, in the future, but it isn't clear to me
> > how this would look like. I'm inclined to fix the existing issue with
> > loop devices now (this is a problem we hit at FB) and address
> > consolidation with other cases if and when those need to be addressed.
> >
> 
> What's the status of this series?

Thanks for reminding me about this. I haven't got any further
feedback. I'll bug Jens to take a look and see if he has any concerns
and if not send a rebased version.
