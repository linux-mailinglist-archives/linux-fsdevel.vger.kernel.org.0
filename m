Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40A2671DF9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 14:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbjARNei (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 08:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjARNeW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:34:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3C959566;
        Wed, 18 Jan 2023 05:01:02 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674046861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PvU5ktIQmVNE7PMEvHhaDxnSXDUDDxFR9HB1GTxmaWs=;
        b=zqvl7Bj+ZRP9DSrW/fabry1GJ6PA3Qs7F0wn8VIaO3nv79rgrCMrMlgJcMINIqL9TcAz6a
        P8bb+kjC3vFVYjKqtFTr2wq5LoUKf+cRMpTyTa6OFw1uIS842CRMYDilcYo5ld1kHwt+BM
        Lpk6hvrc0bUAVHQdFG+nNoPV7xV14/Z2zZ+AMPBkDEl1eQpu8xWhx5HxJckCd6It3gtwOp
        b00/Ba7HLqNcXFVoI9RBqA1XXiX/QSg0sLO/wio0GiDmh9tAQOgXOFfbfIrSWIknG7fvQG
        dVIxwGYgY4T9XvjdSg8nnQ1rNvaAiKcBKllNi8/QiKvD6BLG71Crj8WAdF07dQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674046861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PvU5ktIQmVNE7PMEvHhaDxnSXDUDDxFR9HB1GTxmaWs=;
        b=QXhl89bqfWvcYxf1pYaDR/+FRpRaGdsHvTHK92uTVq3RXeDDH1cKWqHk6Icb4ZDeglUhSq
        KVsyMn+ekUETd0DQ==
To:     Byungchul Park <byungchul.park@lge.com>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
        linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
        will@kernel.org, rostedt@goodmis.org, joel@joelfernandes.org,
        sashal@kernel.org, daniel.vetter@ffwll.ch, duyuyang@gmail.com,
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
        jack@suse.cz, jlayton@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com,
        42.hyeyoo@gmail.com, chris.p.wilson@intel.com,
        gwan-gyeong.mun@intel.com
Subject: Re: [PATCH RFC v7 03/23] dept: Add single event dependency tracker
 APIs
In-Reply-To: <1673235231-30302-4-git-send-email-byungchul.park@lge.com>
References: <1673235231-30302-1-git-send-email-byungchul.park@lge.com>
 <1673235231-30302-4-git-send-email-byungchul.park@lge.com>
Date:   Wed, 18 Jan 2023 14:01:01 +0100
Message-ID: <87tu0ohu9e.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 09 2023 at 12:33, Byungchul Park wrote:
> +/*
> + * sdt_might_sleep() and its family will be committed in __schedule()
> + * when it actually gets to __schedule(). Both dept_request_event() and
> + * dept_wait() will be performed on the commit.
> + */
> +
> +/*
> + * Use the code location as the class key if an explicit map is not used.
> + */
> +#define sdt_might_sleep_strong(m)					\
> +	do {								\
> +		struct dept_map *__m = m;				\
> +		static struct dept_key __key;				\
> +		dept_stage_wait(__m, __m ? NULL : &__key, _THIS_IP_, __func__, true);\
> +	} while (0)
> +
> +/*
> + * Use the code location as the class key if an explicit map is not used.
> + */
> +#define sdt_might_sleep_weak(m)						\
> +	do {								\
> +		struct dept_map *__m = m;				\
> +		static struct dept_key __key;				\
> +		dept_stage_wait(__m, __m ? NULL : &__key, _THIS_IP_, __func__, false);\
> +	} while (0)
> +
> +#define sdt_might_sleep_finish()	dept_clean_stage()
> +
> +#define sdt_ecxt_enter(m)		dept_ecxt_enter(m, 1UL, _THIS_IP_, "start", "event", 0)
> +#define sdt_event(m)			dept_event(m, 1UL, _THIS_IP_, __func__)
> +#define sdt_ecxt_exit(m)		dept_ecxt_exit(m, 1UL, _THIS_IP_)

None of the above comes with a proper documentation of the various
macros/functions. How should anyone aside of you understand what this is
about and how this should be used?

Thanks,

        tglx
