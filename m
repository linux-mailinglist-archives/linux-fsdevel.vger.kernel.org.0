Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF265671DC9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 14:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjARNbS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 08:31:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjARNa6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:30:58 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A8A5FD64;
        Wed, 18 Jan 2023 04:56:21 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674046579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c3JFb7ryDvxt6kfTas+EBXgdHnTgzdObc57Vw9ZeH+c=;
        b=RkYLBLDFu+BSqtqCe9gVFBIlXjOenVwwh49XhzIqjELZ9HqJHfNhjWfCnNMVc8cPpDrjGu
        fHHMudvvmRJXrEQYnp6pmHJ7/x2BhEsVlUErZwEWP9OmdLISTlPMxTEfMrts7Xp5oxY4Tf
        v1X+2ZYAKD+AtDe6ue4bsE/4NFLAVNW/qL9ny/0Qmr/HkmBdNio0GwcBziefCJvIm3QF6Q
        zEinam4LnFzWkserhl4YJ/KnKJ5Lw98uHAuX8KeWRZ7pdnPgWLBMwVm+mQxEdVGhy/MpQ0
        QOIA6FWeYPvRO5pH3YhEfyxc9YzRLmKSgG/lJLl227kdNGHcVgThlW3eckB2yA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674046579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c3JFb7ryDvxt6kfTas+EBXgdHnTgzdObc57Vw9ZeH+c=;
        b=s9oPM++l3VgQU9WqZ90zGcmNtrFEMFdByek9aTcYmIInLI5zG8je33ycn3okxgKtYzMBYK
        Y+YGothbjAzY7AAw==
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
Subject: Re: [PATCH RFC v7 06/23] dept: Add proc knobs to show stats and
 dependency graph
In-Reply-To: <1673235231-30302-7-git-send-email-byungchul.park@lge.com>
References: <1673235231-30302-1-git-send-email-byungchul.park@lge.com>
 <1673235231-30302-7-git-send-email-byungchul.park@lge.com>
Date:   Wed, 18 Jan 2023 13:56:19 +0100
Message-ID: <87zgaghuh8.ffs@tglx>
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
> It'd be useful to show Dept internal stats and dependency graph on
> runtime via proc for better information. Introduced the knobs.

proc?

That's what debugfs is for.
