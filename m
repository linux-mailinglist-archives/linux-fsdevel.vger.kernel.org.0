Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B2470A2A8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 May 2023 00:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbjESWFI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 18:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbjESWFH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 18:05:07 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6A7121
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 15:05:04 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-965ab8ed1fcso693168966b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 15:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684533903; x=1687125903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7JS9bsmb2ExhOm+g4Lt75nCSXcOXphRaQoc6aXCE0Cw=;
        b=RnHJnnkj1VIHqje8IVNGPXgjD9OytYKxqYmMWS+0edD6d8Vlh452IK5UUoVYNHA0m/
         JrZSLCWIuJkr/qFmn1GwZ0Z9okNmo3X9wIG4aOXiJQ71dR9N+z/hpGwqL9OucT/xYJs8
         sXEdyf8eOAvooUYTi70XJlwMMww38PhJnoEwn+5ccVFnCUU0iBMWPYHYxxF+nFh6BS11
         hlwa6Rx019RR4e90c7/yYg70FhEHrfU21w6a39b0FXQyYvZVkLYv79wYuo3K268S+3qN
         t9JlkLqNgoKr9rx/LuewcGO1LO3srqyemDzUIMJlk4pSxE08v9Vre2LHZVt2SYIitl+8
         7ARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684533903; x=1687125903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7JS9bsmb2ExhOm+g4Lt75nCSXcOXphRaQoc6aXCE0Cw=;
        b=igr3cc9JHlyfX+StIiKfmWsvgL2iOnSIn28Lq0iluGnDn2fUwADFz5koGB/CtC6m9g
         myHAE2+UJXcRxfBjrx+IwXjFmG78dWwFTXIML93K0quTpZ4MzSSOAhxzen+glMr8HuNI
         BHk+pO+LG3fYD/c9cWrK0L1ogXxyzQQ/CRKEul0q730gj8b9uf/gtVdb6y/ip8oSSzNQ
         uDesdCgLm/igA5wmU1SbuF1bthfcnhQ/GDkav/f/dPlme6MeAf0b1YiNRJhCf3DVXq88
         hwDF8jYYzptSTJVOPgAxN3GJSy3VoYDnZ+ZLxmE0JyHYYwjdG4OxcxfJTgTFyBLW+juU
         pn5Q==
X-Gm-Message-State: AC+VfDz2EReIt8aMyuW/wHPMAl7fUkqDjihmEjW0D7pChGirGPmMuNq1
        Wi66EzYPKGI2qux47IlzrJK1gsu/MbLikUCtOpYS9A==
X-Google-Smtp-Source: ACHHUZ7PmKcUuxcRDtXRlzFfxhF3Z2gXJBCsnJtL/zsYC6bfcRtFijkSyPQ0sZzD2Lm33IiCzO9EnEZJEPBnURKzzfQ=
X-Received: by 2002:a17:907:a428:b0:94f:59aa:8a7c with SMTP id
 sg40-20020a170907a42800b0094f59aa8a7cmr3260984ejc.20.1684533903287; Fri, 19
 May 2023 15:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkaOMeeGNqm6nFyHgPhd9VpnCVqCAYCY725NoTohTMAnmw@mail.gmail.com>
 <B66FDA24-50C6-444D-BD84-124E68A2AEEE@didiglobal.com>
In-Reply-To: <B66FDA24-50C6-444D-BD84-124E68A2AEEE@didiglobal.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 19 May 2023 15:04:26 -0700
Message-ID: <CAJD7tkb7zSFT5VnZ-00CA0mBE8dFmVqwPwvMpCYG9c-J3ovjyA@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] memcontrol: support cgroup level OOM protection
To:     =?UTF-8?B?56iL5Z6y5rabIENoZW5na2FpdGFvIENoZW5n?= 
        <chengkaitao@didiglobal.com>
Cc:     "tj@kernel.org" <tj@kernel.org>,
        "lizefan.x@bytedance.com" <lizefan.x@bytedance.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "muchun.song@linux.dev" <muchun.song@linux.dev>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "zhengqi.arch@bytedance.com" <zhengqi.arch@bytedance.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
        "chengzhihao1@huawei.com" <chengzhihao1@huawei.com>,
        "pilgrimtao@gmail.com" <pilgrimtao@gmail.com>,
        "haolee.swjtu@gmail.com" <haolee.swjtu@gmail.com>,
        "yuzhao@google.com" <yuzhao@google.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vasily.averin@linux.dev" <vasily.averin@linux.dev>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "surenb@google.com" <surenb@google.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 17, 2023 at 10:12=E2=80=AFPM =E7=A8=8B=E5=9E=B2=E6=B6=9B Chengk=
aitao Cheng
<chengkaitao@didiglobal.com> wrote:
>
> At 2023-05-18 04:42:12, "Yosry Ahmed" <yosryahmed@google.com> wrote:
> >On Wed, May 17, 2023 at 3:01=E2=80=AFAM =E7=A8=8B=E5=9E=B2=E6=B6=9B Chen=
gkaitao Cheng
> ><chengkaitao@didiglobal.com> wrote:
> >>
> >> At 2023-05-17 16:09:50, "Yosry Ahmed" <yosryahmed@google.com> wrote:
> >> >On Wed, May 17, 2023 at 1:01=E2=80=AFAM =E7=A8=8B=E5=9E=B2=E6=B6=9B C=
hengkaitao Cheng
> >> ><chengkaitao@didiglobal.com> wrote:
> >> >>
> >> >> At 2023-05-17 14:59:06, "Yosry Ahmed" <yosryahmed@google.com> wrote=
:
> >> >> >+David Rientjes
> >> >> >
> >> >> >On Tue, May 16, 2023 at 8:20=E2=80=AFPM chengkaitao <chengkaitao@d=
idiglobal.com> wrote:
> >> >> >>
> >> >> Thank you for providing a new application scenario. You have descri=
bed a
> >> >> new per-memcg approach, but a simple introduction cannot explain th=
e
> >> >> details of your approach clearly. If you could compare and analyze =
my
> >> >> patches for possible defects, or if your new approach has advantage=
s
> >> >> that my patches do not have, I would greatly appreciate it.
> >> >
> >> >Sorry if I was not clear, I am not implying in any way that the
> >> >approach I am describing is better than your patches. I am guilty of
> >> >not conducting the proper analysis you are requesting.
> >>
> >> There is no perfect approach in the world, and I also seek your advice=
 with
> >> a learning attitude. You don't need to say sorry, I should say thank y=
ou.
> >>
> >> >I just saw the thread and thought it might be interesting to you or
> >> >others to know the approach that we have been using for years in our
> >> >production. I guess the target is the same, be able to tell the OOM
> >> >killer which memcgs/processes are more important to protect. The
> >> >fundamental difference is that instead of tuning this based on the
> >> >memory usage of the memcg (your approach), we essentially give the OO=
M
> >> >killer the ordering in which we want memcgs/processes to be OOM
> >> >killed. This maps to jobs priorities essentially.
> >>
> >> Killing processes in order of memory usage cannot effectively protect
> >> important processes. Killing processes in a user-defined priority orde=
r
> >> will result in a large number of OOM events and still not being able t=
o
> >> release enough memory. I have been searching for a balance between
> >> the two methods, so that their shortcomings are not too obvious.
> >> The biggest advantage of memcg is its tree topology, and I also hope
> >> to make good use of it.
> >
> >For us, killing processes in a user-defined priority order works well.
> >
> >It seems like to tune memory.oom.protect you use oom_kill_inherit to
> >observe how many times this memcg has been killed due to a limit in an
> >ancestor. Wouldn't it be more straightforward to specify the priority
> >of protections among memcgs?
> >
> >For example, if you observe multiple memcgs being OOM killed due to
> >hitting an ancestor limit, you will need to decide which of them to
> >increase memory.oom.protect for more, based on their importance.
> >Otherwise, if you increase all of them, then there is no point if all
> >the memory is protected, right?
>
> If all memory in memcg is protected, its meaning is similar to that of th=
e
> highest priority memcg in your approach, which is ultimately killed or
> never killed.

Makes sense. I believe it gets a bit trickier when you want to
describe relative ordering between memcgs using memory.oom.protect.

>
> >In this case, wouldn't it be easier to just tell the OOM killer the
> >relative priority among the memcgs?
> >
> >>
> >> >If this approach works for you (or any other audience), that's great,
> >> >I can share more details and perhaps we can reach something that we
> >> >can both use :)
> >>
> >> If you have a good idea, please share more details or show some code.
> >> I would greatly appreciate it
> >
> >The code we have needs to be rebased onto a different version and
> >cleaned up before it can be shared, but essentially it is as
> >described.
> >
> >(a) All processes and memcgs start with a default score.
> >(b) Userspace can specify scores for memcgs and processes. A higher
> >score means higher priority (aka less score gets killed first).
> >(c) The OOM killer essentially looks for the memcg with the lowest
> >scores to kill, then among this memcg, it looks for the process with
> >the lowest score. Ties are broken based on usage, so essentially if
> >all processes/memcgs have the default score, we fallback to the
> >current OOM behavior.
>
> If memory oversold is severe, all processes of the lowest priority
> memcg may be killed before selecting other memcg processes.
> If there are 1000 processes with almost zero memory usage in
> the lowest priority memcg, 1000 invalid kill events may occur.
> To avoid this situation, even for the lowest priority memcg,
> I will leave him a very small oom.protect quota.

I checked internally, and this is indeed something that we see from
time to time. We try to avoid that with userspace OOM killing, but
it's not 100% effective.

>
> If faced with two memcgs with the same total memory usage and
> priority, memcg A has more processes but less memory usage per
> single process, and memcg B has fewer processes but more
> memory usage per single process, then when OOM occurs, the
> processes in memcg B may continue to be killed until all processes
> in memcg B are killed, which is unfair to memcg B because memcg A
> also occupies a large amount of memory.

I believe in this case we will kill one process in memcg B, then the
usage of memcg A will become higher, so we will pick a process from
memcg A next.

>
> Dose your approach have these issues? Killing processes in a
> user-defined priority is indeed easier and can work well in most cases,
> but I have been trying to solve the cases that it cannot cover.

The first issue is relatable with our approach. Let me dig more info
from our internal teams and get back to you with more details.

>
> --
> Thanks for your comment!
> chengkaitao
>
>
