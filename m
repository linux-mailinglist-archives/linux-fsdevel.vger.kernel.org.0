Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F72671DD3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 14:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjARNdM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 08:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjARNcz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:32:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070E984579;
        Wed, 18 Jan 2023 04:59:36 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674046774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ia5mcSSMCX645DNR37kXbpCtB0DOcgHMBUz20RFHfC4=;
        b=PgZLyda/qk+zlwhzR6idZiNhlWjQ9dhxCmeT4rrrl2GneTevgb/CsxE+hZPT77/XxN/D3C
        OdouussxQq3+fqW0hIcz/Ki25tMkMCvzzYDB8pBZcMQlLCpDT5VZb1pVYMSDA/j2hwWryO
        XALXhf/W98qKDyrndcj1X2VDtSU3suaEkQMvFPFJNRpd3rP5YqRNavHx/iRYRfI3oGDLj7
        Fyk2vEI66UfwY0KA5lZAxmspc7UiU9mKVU0asexmqh+7rGYFxRvu36Ar6cF1VNhzA334Kh
        j+N92wF2QwyoojycoKuUH4XjJ9yjXMXivJ1ePjsam5T0B2hbJpAWejPbykJQrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674046774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ia5mcSSMCX645DNR37kXbpCtB0DOcgHMBUz20RFHfC4=;
        b=twkPO4xqcEqK9BdeHGZeT7P1XO2VXaNzoSGOiyD8GCiyvcCMbRNK/TsG05ivxP6PlVlbsI
        bMflMGBUtRJ91XBw==
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
Subject: Re: [PATCH RFC v7 07/23] dept: Apply sdt_might_sleep_strong() to
 wait_for_completion()/complete()
In-Reply-To: <1673235231-30302-8-git-send-email-byungchul.park@lge.com>
References: <1673235231-30302-1-git-send-email-byungchul.park@lge.com>
 <1673235231-30302-8-git-send-email-byungchul.park@lge.com>
Date:   Wed, 18 Jan 2023 13:59:34 +0100
Message-ID: <87wn5khubt.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 09 2023 at 12:33, Byungchul Park wrote:
> Makes Dept able to track dependencies by
> wait_for_completion()/complete().
>
> In order to obtain the meaningful caller points, replace all the
> wait_for_completion*() declarations with macros in the header.

That's just wrong.

> -extern void wait_for_completion(struct completion *);
> +extern void raw_wait_for_completion(struct completion *);

> +#define wait_for_completion(x)					\
> +({								\
> +	sdt_might_sleep_strong(NULL);				\
> +	raw_wait_for_completion(x);				\
> +	sdt_might_sleep_finish();				\
> +})

The very same can be achieved with a proper annotation which does not
enforce THIS_IP but allows to use __builtin_return_address($N). That's
what everything else uses too.

Thanks,

        tglx
