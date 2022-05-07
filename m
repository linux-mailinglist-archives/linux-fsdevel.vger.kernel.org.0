Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6FD251E52E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 May 2022 09:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446068AbiEGHZF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 May 2022 03:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446038AbiEGHY6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 May 2022 03:24:58 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F35F33883;
        Sat,  7 May 2022 00:21:11 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 202so7862914pgc.9;
        Sat, 07 May 2022 00:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rNQz935Rwo42XgI1l8Va40p/MEeV4p6HEVCQ52VDnf4=;
        b=P42+8ex/HBpVSeUhi79CcZsiB1rEwx7SjPsWOzHKtYtuDRjT+7g81hnQb9Bg+3nrwT
         De8dQlU9BcgwoEV9wdnbeE3D82XEoM9rdMizKhVMhmThyQPs7pG6yQdXOZHUILyVEB8B
         MZOMaM5Nag+I9ca+mSFwEkbaCfc+mVQpZN8W0UFxaI3P1zlBAo3OLxIQcU7yZiXAhU1h
         Jiaawf+dpE+KAoqOYTid6KwfvlqOs8L3T25b9+uILvT8+qC03iIX5R5P7pBVqRxRlV1/
         2L77a/eKzFW5m+4Q8qaNXGrcogU5pQhNHMvwFRhhaVI7cMNifBapsGydQXtopBhbDEvv
         tGKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rNQz935Rwo42XgI1l8Va40p/MEeV4p6HEVCQ52VDnf4=;
        b=dbeW4iM7xzP1pedpoDFeZtPSpmc86HZmgQb1X3b5lrJZdzI+tplsVsUWaqsF8L1s8A
         2U5tF6esDkokfGvo/YHHeEeec6aJgpFOSQsbfcC/MQkEGcSX5c6FVHf+p0IAokhhPB+q
         l4FClkS0nKcw4/jXpPICClyeLZ89tcDKSfVADmhw1kbEBSWgGwHU2IfmpJuqLMTtJCrk
         PNN3GDEiLwWAtr5iU9coSPpxe6mLDsAFWt5TUq8XBXVcrXTGHRmuddlv7L2GujvJklTK
         nC7flNwS/oLwTTv+whKqvnsq60zWSNjk4GLU7zCTih+92OwvzA6oXuZtj6nRsBqwc11D
         eWlA==
X-Gm-Message-State: AOAM533mkWrE91d5Fv8TF+MsfcWOY5uSudTeBV1ZFoloI+2u15sES9gD
        tRsM1an+HHlHXwUaVI9RE7Q=
X-Google-Smtp-Source: ABdhPJy8wngBA9nCSkNphuykt/x5APcFu3ZWQNW14hKz2s7Rb0bLuKnbzsVQiG9xcQts5UZOdrCb6w==
X-Received: by 2002:a65:6093:0:b0:373:9c75:19ec with SMTP id t19-20020a656093000000b003739c7519ecmr5972095pgu.539.1651908071104;
        Sat, 07 May 2022 00:21:11 -0700 (PDT)
Received: from hyeyoo ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id 1-20020a170902c20100b0015ec44d25dasm2956759pll.235.2022.05.07.00.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 00:21:10 -0700 (PDT)
Date:   Sat, 7 May 2022 16:20:50 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
        linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
        joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
        chris@chris-wilson.co.uk, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
        gregkh@linuxfoundation.org, kernel-team@lge.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
        ngupta@vflare.org, linux-block@vger.kernel.org,
        paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, jack@suse.com, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        hamohammed.sa@gmail.com
Subject: Re: [PATCH RFC v6 00/21] DEPT(Dependency Tracker)
Message-ID: <YnYd0hd+yTvVQxm5@hyeyoo>
References: <CAHk-=whnPePcffsNQM+YSHMGttLXvpf8LbBQ8P7HEdqFXaV7Lg@mail.gmail.com>
 <1651795895-8641-1-git-send-email-byungchul.park@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1651795895-8641-1-git-send-email-byungchul.park@lge.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 06, 2022 at 09:11:35AM +0900, Byungchul Park wrote:
> Linus wrote:
> >
> > On Wed, May 4, 2022 at 1:19 AM Byungchul Park <byungchul.park@lge.com> wrote:
> > >
> > > Hi Linus and folks,
> > >
> > > I've been developing a tool for detecting deadlock possibilities by
> > > tracking wait/event rather than lock(?) acquisition order to try to
> > > cover all synchonization machanisms.
> > 
> > So what is the actual status of reports these days?
> > 
> > Last time I looked at some reports, it gave a lot of false positives
> > due to mis-understanding prepare_to_sleep().
> 
> Yes, it was. I handled the case in the following way:
> 
> 1. Stage the wait at prepare_to_sleep(), which might be used at commit.
>    Which has yet to be an actual wait that Dept considers.
> 2. If the condition for sleep is true, the wait will be committed at
>    __schedule(). The wait becomes an actual one that Dept considers.
> 3. If the condition is false and the task gets back to TASK_RUNNING,
>    clean(=reset) the staged wait.
> 
> That way, Dept only works with what actually hits to __schedule() for
> the waits through sleep.
> 
> > For this all to make sense, it would need to not have false positives
> > (or at least a very small number of them together with a way to sanely
> 
> Yes. I agree with you. I got rid of them that way I described above.
>

IMHO DEPT should not report what lockdep allows (Not talking about
wait events). I mean lockdep allows some kind of nested locks but
DEPT reports them.

When I was collecting reports from DEPT on varous configurations,
Most of them was report of down_write_nested(), which is allowed in
lockdep.

DEPT should not report at least what we know it's not a real deadlock.
Otherwise there will be reports that is never fixed, which is quite
unpleasant and reporters cannot examine all of them if it's real deadlock
or not.

> > get rid of them), and also have a track record of finding things that
> > lockdep doesn't.
> 
> I have some reports that wait_for_completion or waitqueue is involved.
> It's worth noting those are not tracked by Lockdep. I'm checking if
> those are true positive or not. I will share those reports once I get
> more convinced for that.
> 
> > Maybe such reports have been sent out with the current situation, and
> > I haven't seen them.
> 
> Dept reports usually have been sent to me privately, not in LKML. As I
> told you, I'm planning to share them.
> 
> 	Byungchul
> 
> > 
> >                  Linus
> > 

-- 
Thanks,
Hyeonggon
