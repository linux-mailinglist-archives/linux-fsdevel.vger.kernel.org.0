Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D9C4E543E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 15:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244762AbiCWOaL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Mar 2022 10:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244765AbiCWOaJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Mar 2022 10:30:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1B3B87F
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Mar 2022 07:28:36 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9DF9C1F37F;
        Wed, 23 Mar 2022 14:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648045715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/Ioe1yB2nNzhePE8bUeTHN0puFfTZRbrOkfbO3s4ArA=;
        b=VwtovTr19MBBRUb/VJFAxZZxzSbgfaoSZkDZrmuB2zN7/YKf1BiFcULI2bLb01zbEZL6pa
        P/qalNHtJc+2VIlasOjsxhpCRQiRjJtodt8LJ6fXroIXQ+yf8Cb4r/78qlbLgf73YofeM2
        SDqbDE9taow7gmpT315CzTWdr/bHxtw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648045715;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/Ioe1yB2nNzhePE8bUeTHN0puFfTZRbrOkfbO3s4ArA=;
        b=04pCmm2KJUO3vXdA+NaonXIJIOK4txle1uFDCEZFpXdHlTTI2dqffjLE5I5JGsuKe5AnnR
        H3rE2/IjH+VTk4Dg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6DD65A3B81;
        Wed, 23 Mar 2022 14:28:35 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 220A4A0610; Wed, 23 Mar 2022 15:28:35 +0100 (CET)
Date:   Wed, 23 Mar 2022 15:28:35 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, "khazhy@google.com" <khazhy@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC] nfsd: avoid recursive locking through fsnotify
Message-ID: <20220323142835.epitipiq7zc55vgb@quack3.lan>
References: <ea2afc67b92f33dbf406c3ebf49a0da9c6ec1e5b.camel@hammerspace.com>
 <CAOQ4uxgTJdcO-xZbtTSUkjD2g0vSHr=PLFc6-T6RgO0u5DS=0g@mail.gmail.com>
 <20220321112310.vpr7oxro2xkz5llh@quack3.lan>
 <CAOQ4uxiLXqmAC=769ufLA2dKKfHxm=c_8B0N2y4c-aZ5Qci2hg@mail.gmail.com>
 <20220321145111.qz3bngofoi5r5cmh@quack3.lan>
 <CAOQ4uxgOpfezQ4ydjP4SPA8-7x9xSXjTmTyZOYQE3d24c2Zf7Q@mail.gmail.com>
 <20220323104129.k4djfxtjwdgoz3ci@quack3.lan>
 <CAOQ4uxgH3aCKnXfUFuyC7JXGtuprzWr6U9Y2T1rTQT3COoZtzw@mail.gmail.com>
 <20220323134851.px6s4i6iiaj4zlju@quack3.lan>
 <CAOQ4uxhBH_0UqEmOdcUaV0E8oGTGF7arr+Q_EZPuQ=KWfvJWoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhBH_0UqEmOdcUaV0E8oGTGF7arr+Q_EZPuQ=KWfvJWoQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 23-03-22 16:00:30, Amir Goldstein wrote:
> > Well, but reclaim from kswapd is always the main and preferred source of
> > memory reclaim. And we will kick kswapd to do work if we are running out of
> > memory. Doing direct filesystem slab reclaim from mark allocation is useful
> > only to throttle possibly aggressive mark allocations to the speed of
> > reclaim (instead of getting ENOMEM). So I'm still not convinced this is a
> > big issue but I certainly won't stop you from implementing more fine
> > grained GFP mode selection and lockdep annotations if you want to go that
> > way :).
> 
> Well it was just two lines of code to annotate the fanotify mutex as its own
> class, so I just did that:
> 
> https://github.com/amir73il/linux/commit/7b4b6e2c0bd1942cd130e9202c4b187a8fb468c6

But this implicitely assumes there isn't any allocation under mark_mutex
anywhere else where it is held. Which is likely true (I didn't check) but
it is kind of fragile. So I was rather imagining we would have per-group
"NOFS" flag and fsnotify_group_lock/unlock() would call
memalloc_nofs_save() based on the flag. And we would use
fsnotify_group_lock/unlock() uniformly across the whole fsnotify codebase.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
