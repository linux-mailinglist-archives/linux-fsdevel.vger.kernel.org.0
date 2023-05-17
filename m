Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5E1707345
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 22:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjEQUnT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 16:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjEQUnS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 16:43:18 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E6C93E2
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 May 2023 13:42:50 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-96aae59bbd6so228744966b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 May 2023 13:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684356168; x=1686948168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CvCkfJyXdBizSrj+S1CIuIjHPj7mR2pZW70tMG5/ENw=;
        b=k1ibNgQ1aq28Dhp9cGBlgSxQJ7lbc/VdbcXrDj0eAoSPCEx1xcoDbcgMCSEqtIEIKI
         3GPic5hMCSaX21aJvzjbvjDyMc8l0sqejX2otxM8GSrW6JWPtr/4f8YtHld2rn1dnUBx
         k+aSQCrSTdfmO5gim5Lnq9Ve8U1YlVehAWMGpz0+oufZ424aTfD8G852MYX5GuYYjS21
         vsrdXtzfvgk/1X5CChW00yaz0QHjQVFPesWj0npLjj185JeKtvibvT3TRJg1tejKzou7
         gemYCK9U2mfESleEXZ1k2GewsSh30YnAmHtuHgyWG99vSxr6pMWI54GUX+JThPbOoTqA
         IbpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684356168; x=1686948168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CvCkfJyXdBizSrj+S1CIuIjHPj7mR2pZW70tMG5/ENw=;
        b=K3G8LgFYBvH7Y82gAqeIA04crQOGMq5kcCJjtoTx4nMFfyj1y+joH/04LEXsI15aKN
         uOMNsOtwZZhuiX1FVexbw1SZN0AWFNUzHpcbqBKpQUtHKalkY0KUWHbPcol8pwJL5ks8
         2PFVOtilbbKBPiGaCb9e7v3adFBsByXmKwruVESBJrUOD8ZivvZaftq0xMy5o9RBR6nH
         xyTCHGZNiHNc2re0MR7PIHt6moOD+k8wYGQMs5ZL7vo9GwPnPPprMCq/zR7lIjg553an
         FOeHEop4mkrF+NAftaVUKhyLGBsBaWzHQcH7TNMlnBPY8Ao2PoxIpto8+v5zR+JM8aRE
         s3HQ==
X-Gm-Message-State: AC+VfDzcFFCwPaJmXp43NTVuV8tXbbJESSAXYWjaa1eRIHjtHhcGHHX9
        hrRnPtaaOFbor5g9vREVRpDNv9g4BGaY6OW523KS+g==
X-Google-Smtp-Source: ACHHUZ5kUTrtS3PDNiv88Mejxdsl502rh+r9lku+/B71PLDd2EJdDbwQfpLDEruHsoMoATzJa3F7uuidOinOVVG7Ia0=
X-Received: by 2002:a17:907:9485:b0:96a:b12d:2fdf with SMTP id
 dm5-20020a170907948500b0096ab12d2fdfmr17122192ejc.12.1684356168500; Wed, 17
 May 2023 13:42:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkbHKQBoz7kn6ZjMTMoxLKYs7x9w4uRGWLvuyOogmBkZ_g@mail.gmail.com>
 <6AB7FF12-F855-4D5B-9F75-9F7D64823144@didiglobal.com>
In-Reply-To: <6AB7FF12-F855-4D5B-9F75-9F7D64823144@didiglobal.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 17 May 2023 13:42:12 -0700
Message-ID: <CAJD7tkaOMeeGNqm6nFyHgPhd9VpnCVqCAYCY725NoTohTMAnmw@mail.gmail.com>
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

On Wed, May 17, 2023 at 3:01=E2=80=AFAM =E7=A8=8B=E5=9E=B2=E6=B6=9B Chengka=
itao Cheng
<chengkaitao@didiglobal.com> wrote:
>
> At 2023-05-17 16:09:50, "Yosry Ahmed" <yosryahmed@google.com> wrote:
> >On Wed, May 17, 2023 at 1:01=E2=80=AFAM =E7=A8=8B=E5=9E=B2=E6=B6=9B Chen=
gkaitao Cheng
> ><chengkaitao@didiglobal.com> wrote:
> >>
> >> At 2023-05-17 14:59:06, "Yosry Ahmed" <yosryahmed@google.com> wrote:
> >> >+David Rientjes
> >> >
> >> >On Tue, May 16, 2023 at 8:20=E2=80=AFPM chengkaitao <chengkaitao@didi=
global.com> wrote:
> >> >>
> >> >> Establish a new OOM score algorithm, supports the cgroup level OOM
> >> >> protection mechanism. When an global/memcg oom event occurs, we tre=
at
> >> >> all processes in the cgroup as a whole, and OOM killers need to sel=
ect
> >> >> the process to kill based on the protection quota of the cgroup.
> >> >>
> >> >
> >> >Perhaps this is only slightly relevant, but at Google we do have a
> >> >different per-memcg approach to protect from OOM kills, or more
> >> >specifically tell the kernel how we would like the OOM killer to
> >> >behave.
> >> >
> >> >We define an interface called memory.oom_score_badness, and we also
> >> >allow it to be specified per-process through a procfs interface,
> >> >similar to oom_score_adj.
> >> >
> >> >These scores essentially tell the OOM killer the order in which we
> >> >prefer memcgs to be OOM'd, and the order in which we want processes i=
n
> >> >the memcg to be OOM'd. By default, all processes and memcgs start wit=
h
> >> >the same score. Ties are broken based on the rss of the process or th=
e
> >> >usage of the memcg (prefer to kill the process/memcg that will free
> >> >more memory) -- similar to the current OOM killer.
> >>
> >> Thank you for providing a new application scenario. You have described=
 a
> >> new per-memcg approach, but a simple introduction cannot explain the
> >> details of your approach clearly. If you could compare and analyze my
> >> patches for possible defects, or if your new approach has advantages
> >> that my patches do not have, I would greatly appreciate it.
> >
> >Sorry if I was not clear, I am not implying in any way that the
> >approach I am describing is better than your patches. I am guilty of
> >not conducting the proper analysis you are requesting.
>
> There is no perfect approach in the world, and I also seek your advice wi=
th
> a learning attitude. You don't need to say sorry, I should say thank you.
>
> >I just saw the thread and thought it might be interesting to you or
> >others to know the approach that we have been using for years in our
> >production. I guess the target is the same, be able to tell the OOM
> >killer which memcgs/processes are more important to protect. The
> >fundamental difference is that instead of tuning this based on the
> >memory usage of the memcg (your approach), we essentially give the OOM
> >killer the ordering in which we want memcgs/processes to be OOM
> >killed. This maps to jobs priorities essentially.
>
> Killing processes in order of memory usage cannot effectively protect
> important processes. Killing processes in a user-defined priority order
> will result in a large number of OOM events and still not being able to
> release enough memory. I have been searching for a balance between
> the two methods, so that their shortcomings are not too obvious.
> The biggest advantage of memcg is its tree topology, and I also hope
> to make good use of it.

For us, killing processes in a user-defined priority order works well.

It seems like to tune memory.oom.protect you use oom_kill_inherit to
observe how many times this memcg has been killed due to a limit in an
ancestor. Wouldn't it be more straightforward to specify the priority
of protections among memcgs?

For example, if you observe multiple memcgs being OOM killed due to
hitting an ancestor limit, you will need to decide which of them to
increase memory.oom.protect for more, based on their importance.
Otherwise, if you increase all of them, then there is no point if all
the memory is protected, right?

In this case, wouldn't it be easier to just tell the OOM killer the
relative priority among the memcgs?

>
> >If this approach works for you (or any other audience), that's great,
> >I can share more details and perhaps we can reach something that we
> >can both use :)
>
> If you have a good idea, please share more details or show some code.
> I would greatly appreciate it

The code we have needs to be rebased onto a different version and
cleaned up before it can be shared, but essentially it is as
described.

(a) All processes and memcgs start with a default score.
(b) Userspace can specify scores for memcgs and processes. A higher
score means higher priority (aka less score gets killed first).
(c) The OOM killer essentially looks for the memcg with the lowest
scores to kill, then among this memcg, it looks for the process with
the lowest score. Ties are broken based on usage, so essentially if
all processes/memcgs have the default score, we fallback to the
current OOM behavior.

>
> >>
> >> >This has been brought up before in other discussions without much
> >> >interest [1], but just thought it may be relevant here.
> >> >
> >> >[1]https://lore.kernel.org/lkml/CAHS8izN3ej1mqUpnNQ8c-1Bx5EeO7q5NOkh0=
qrY_4PLqc8rkHA@mail.gmail.com/#t
>
> --
> Thanks for your comment!
> chengkaitao
>
