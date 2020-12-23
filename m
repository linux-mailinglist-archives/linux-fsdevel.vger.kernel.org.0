Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4312E21DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Dec 2020 22:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbgLWVCB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Dec 2020 16:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727605AbgLWVCB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Dec 2020 16:02:01 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3357C061794
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Dec 2020 13:01:20 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id x20so349431lfe.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Dec 2020 13:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g36tAmTEjSaA0vpBKIUlCpStJerd4pisa8lbF6yxKNQ=;
        b=kn3BVILCed5+28QuNVyEq3hRiqw3fts33Is0SKnBnm17qBAVZ6oxU+DgC7uMmunsTH
         2a8wsM30fyoKI6v9GWohnvTMO5TYWEKkVvE4s/DF3tT8r5sdLksMQxtNkyWi0AcTFDW4
         hzsZELBW0HTOt7N1u6bEzGc/JOnkLsHiAVA5rj/vh/uyWPVcX86QX6MXrj/vEh+tO/wr
         0sSNB2ZbmhP1LDMvMU6ZvEQDpTyGMYClmNF1sruJq5YfeMV7C8cqn0Px8HjHsQIdLbk8
         5GRLH2bKy5K4w+EZF35tH6U5vIO0TqDfdYVDaxNJu/ntR7m/JgE56e2Kf41SGSmLlpc3
         h6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g36tAmTEjSaA0vpBKIUlCpStJerd4pisa8lbF6yxKNQ=;
        b=ADcs//BHSevDRkdMHdFVc3Qxml16p0J3kbSx6QF9H6kZrKF6H3o/PGWB6pUzU7i2UC
         9Yg7CCTQGwtuhX4RAwfev6TP+l6LZLqFm2xTjVBD2psLxLjRdA+xUS6ikXR23jYy2vCC
         DYU55RajvRM/Tkg1RLf8sU2IsfC6GON9lEQZOdNrcPZnDYQkoXkXvgeRklHFBr3egxVJ
         hSEBuLMq2xwkYDBJZR+qHq1OvS6qJb2LT0kSvTa8jyv2w1ZJOLYcj7/a+P0lpdFrxN4j
         wAF4/X6yokMOTK6ER9bG1RDRqUT/5tSLRKejL0OvAKvoD0z1bpZSS3BJiLws37msPTfl
         /wvg==
X-Gm-Message-State: AOAM532I+mRZCRye2cBNWHMsT6HFH1u7yfCXt7cs1S9xiGDN9hIH+TZU
        CnNRZLUbiaUwFdlAsTlpmoimuY03Z3peTy3vI7px1g==
X-Google-Smtp-Source: ABdhPJzUj3Wj8zvd/BiNPBjip+KqSkpO464X2X8czRYKgivNp/qw7V05sLyQmik/Lb/Q79cNJkjuGGYHdZ2ec0Abdnk=
X-Received: by 2002:a05:6512:687:: with SMTP id t7mr10984209lfe.432.1608757278987;
 Wed, 23 Dec 2020 13:01:18 -0800 (PST)
MIME-Version: 1.0
References: <20201217034356.4708-1-songmuchun@bytedance.com> <20201217034356.4708-2-songmuchun@bytedance.com>
In-Reply-To: <20201217034356.4708-2-songmuchun@bytedance.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 23 Dec 2020 13:01:07 -0800
Message-ID: <CALvZod7WqYEVOD0o7y+JVcTjdF8N=cbZHEeXa3VvkMsJDQjeKg@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] mm: memcontrol: fix NR_ANON_THPS accounting in
 charge moving
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Feng Tang <feng.tang@intel.com>, Neil Brown <neilb@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 16, 2020 at 7:45 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> The unit of NR_ANON_THPS is HPAGE_PMD_NR already. So it should inc/dec
> by one rather than nr_pages.
>
> Fixes: 468c398233da ("mm: memcontrol: switch to native NR_ANON_THPS counter")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
> Reviewed-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
