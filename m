Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4003520629
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 22:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiEIUvW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 16:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiEIUvR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 16:51:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E922B1DD1;
        Mon,  9 May 2022 13:47:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77FE061707;
        Mon,  9 May 2022 20:47:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A498C385BA;
        Mon,  9 May 2022 20:47:14 +0000 (UTC)
Date:   Mon, 9 May 2022 16:47:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>, torvalds@linux-foundation.org,
        damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, will@kernel.org, tglx@linutronix.de,
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
Message-ID: <20220509164712.746e236b@gandalf.local.home>
In-Reply-To: <20220509001637.GA6047@X58A-UD3R>
References: <CAHk-=whnPePcffsNQM+YSHMGttLXvpf8LbBQ8P7HEdqFXaV7Lg@mail.gmail.com>
        <1651795895-8641-1-git-send-email-byungchul.park@lge.com>
        <YnYd0hd+yTvVQxm5@hyeyoo>
        <20220509001637.GA6047@X58A-UD3R>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 9 May 2022 09:16:37 +0900
Byungchul Park <byungchul.park@lge.com> wrote:

> CASE 2.
> 
>    lock L with depth n
>    lock A
>    lock_nested L' with depth n + 1
>    ...
>    unlock L'
>    unlock A
>    unlock L
> 
> This case is allowed by Lockdep.
> This case is *NOT* allowed by DEPT cuz it's a *DEADLOCK*.
> 
> ---
> 
> The following scenario would explain why CASE 2 is problematic.
> 
>    THREAD X			THREAD Y
> 
>    lock L with depth n
> 				lock L' with depth n
>    lock A
> 				lock A
>    lock_nested L' with depth n + 1

I'm confused by what exactly you are saying is a deadlock above.

Are you saying that lock A and L' are inversed? If so, lockdep had better
detect that regardless of L. A nested lock associates the the nesting with
the same type of lock. That is, in lockdep nested tells lockdep not to
trigger on the L and L' but it will not ignore that A was taken.

-- Steve



> 				lock_nested L'' with depth n + 1
>    ...				...
>    unlock L'			unlock L''
>    unlock A			unlock A
>    unlock L			unlock L'

