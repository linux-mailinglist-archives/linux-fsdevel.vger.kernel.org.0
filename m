Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECCF33087A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Mar 2021 07:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235066AbhCHGxe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Mar 2021 01:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235050AbhCHGxK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Mar 2021 01:53:10 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DDEC06174A
        for <linux-fsdevel@vger.kernel.org>; Sun,  7 Mar 2021 22:53:09 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id p21so19243862lfu.11
        for <linux-fsdevel@vger.kernel.org>; Sun, 07 Mar 2021 22:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RUf6YK7Pbg6+iTFisLTzXO2HwYinFRUhW6KJnLMuDNI=;
        b=etm3nnK8bmOjgvI5OvVHNEA7tyQCpVhusqJ9ueTJDqFj67gFouUocXIOhoLsqsexbp
         o6zKAFNH3D5OyJzUeQwQ57ZFx1Ma+ry6AkUfU6cvIU2MXLTetatj1RzR1jRyPvoylo3C
         979bbQfrp+sFg3W+65aqRy3RPeeJ9lBoDBNpuqLxnJRUpQIyFrqS3EnTtvAHl9HxZwtR
         HKr5MLjPBIsVcIJfpNqK97Gi3oC/3hAEcvHC26M05Bep5dypC3m/z2vILyFUHA/Dnme8
         ioqlgDGCc3Y0dG/aSAGVDvGwkvfTLoHouvnJNX+TZql1llm9a9+b/MYjDlI7Yc5po/5u
         SI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RUf6YK7Pbg6+iTFisLTzXO2HwYinFRUhW6KJnLMuDNI=;
        b=sRz4wAtLT0ZVSu8Ga+vuFg0Ui+BOr4UFoVbRKLVB9X69MyqXci48pXZjZ8upqCRLcM
         6X69ShnDss9sUMT+TcxG9X2ctZQOkJzlCQeRXC9NCVwNjJLLK/fNNXJZhyWY/rWfmjTo
         0Mm2z5CcoIYUwCxcjwho8h+aPDPnGhzEdWB9Pn6/0RhX4r0lspkgWWB0vS3hIIv9nAbE
         7dcEuT2kSlMZFwty6blDQY2fEE04dRB7V8AOVuOZNV9JU9c3z7H0VKwW8QoUZy0CTblz
         Tshq31GTJgaOAlURNk4JhP5J0+LpnZXZTB3woGRKDKZHslbh/tq4iHEogso57oNg+5bc
         T9Eg==
X-Gm-Message-State: AOAM532XfhmlziYMZvypdxHhJA7Qt4NsXfv6IC2Y8M3cS7kYKt69XPfk
        P1RNN0rnWNJk3TvYvPMvs+XSLdH/6FDnUuLBSeKDuw==
X-Google-Smtp-Source: ABdhPJxh1vhheABhPdE+eMg+f0jzVW0I+FN3Q3w1WzPUi+TIbBt6qGQ/qDRwNmbeyQuENp0Pt99oemM5cn/gipQmNiM=
X-Received: by 2002:a19:3804:: with SMTP id f4mr6053417lfa.117.1615186388282;
 Sun, 07 Mar 2021 22:53:08 -0800 (PST)
MIME-Version: 1.0
References: <20210217001322.2226796-1-shy828301@gmail.com> <20210217001322.2226796-8-shy828301@gmail.com>
In-Reply-To: <20210217001322.2226796-8-shy828301@gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sun, 7 Mar 2021 22:52:54 -0800
Message-ID: <CALvZod4dPe5vMYf+vmL5NTAeVtZvVi06Rx4RCg-6NB2+2unEZg@mail.gmail.com>
Subject: Re: [v8 PATCH 07/13] mm: vmscan: add shrinker_info_protected() helper
To:     Yang Shi <shy828301@gmail.com>
Cc:     Roman Gushchin <guro@fb.com>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 16, 2021 at 4:13 PM Yang Shi <shy828301@gmail.com> wrote:
>
> The shrinker_info is dereferenced in a couple of places via rcu_dereference_protected
> with different calling conventions, for example, using mem_cgroup_nodeinfo helper
> or dereferencing memcg->nodeinfo[nid]->shrinker_info.  And the later patch
> will add more dereference places.
>
> So extract the dereference into a helper to make the code more readable.  No
> functional change.
>
> Acked-by: Roman Gushchin <guro@fb.com>
> Acked-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
