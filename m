Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA644DE169
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Mar 2022 19:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239894AbiCRS5p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Mar 2022 14:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbiCRS5o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Mar 2022 14:57:44 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68519215472
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Mar 2022 11:56:25 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id bx44so5924416ljb.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Mar 2022 11:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x0WpCPeJF/glvoQcLTwJKAKI6FncEVSy4Y2K6xPy2Y8=;
        b=f7MfvhR/cTZArrnZxlIv8GZbrzzOnswona1V4BXmQPljdWKur1uZmgcfw5Gov3BZTV
         +8oIobQjsXBFlocU280eAc/KMDRwR0QsHriW+A424ELUu54U5AF1TX4DGsG3wfztxp2c
         uc7bAxqjmBZAmgiEe/ZSRGk4oCxcgeO2gFlNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x0WpCPeJF/glvoQcLTwJKAKI6FncEVSy4Y2K6xPy2Y8=;
        b=A6pjzY7DA/BWWQFsJsPL/P3o5MgS7n+BReyudHl76GAjylLgEj6JJiA+AOmi+WyJfT
         5WAXWunxh9ArDHe75e590FDEAVoMQOAbFJ4hyqkfE0xYlRkWT0lmLS05hb+a0NhT8Uwt
         1PYG+ix+svf0LIJQNvL8xJvHTMO+e5GxuVTD4LeQjpt2f3aEv1aSVJ72pBuAzk0qDVlu
         LX7Tol03YtjgvzZByvqw//tBOR+Z29ZwtaDE+ACfHwyD+FBMNiE25NTNGh7torSjSOU/
         nMst8b3od4iFTTEVxazAShBKMcQuG5TBsm9Nu6G3XG8kzI+GVFHoBS3FDdENNxXu7swG
         bFxA==
X-Gm-Message-State: AOAM5339yTmyyaXPqVyMuEGMEgG9Vb8FygP9rJJ16+A5WRx4DcPN0zPH
        CiNeWVkS1VLYDkg23GjHcW5KRVt9iNg4n+dWd3Q=
X-Google-Smtp-Source: ABdhPJzCZNmbyVhuofvX9amqZUYc8KYUApJ7aNCRou1ggsx8sIgPydkUe0pDo+xTDLkEWZY61ChyNQ==
X-Received: by 2002:a2e:a58b:0:b0:249:1e4c:8e31 with SMTP id m11-20020a2ea58b000000b002491e4c8e31mr7002460ljp.14.1647629783473;
        Fri, 18 Mar 2022 11:56:23 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id b23-20020a05651c033700b00247eb53f798sm1081571ljp.140.2022.03.18.11.56.21
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 11:56:21 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id bt26so15514311lfb.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Mar 2022 11:56:21 -0700 (PDT)
X-Received: by 2002:a05:6512:2037:b0:448:92de:21de with SMTP id
 s23-20020a056512203700b0044892de21demr6661516lfs.52.1647629780934; Fri, 18
 Mar 2022 11:56:20 -0700 (PDT)
MIME-Version: 1.0
References: <YjDj3lvlNJK/IPiU@bfoster> <YjJPu/3tYnuKK888@casper.infradead.org>
 <CAHk-=wgPTWoXCa=JembExs8Y7fw7YUi9XR0zn1xaxWLSXBN_vg@mail.gmail.com>
 <YjNN5SzHELGig+U4@casper.infradead.org> <CAHk-=wiZvOpaP0DVyqOnspFqpXRaT6q53=gnA2psxnf5dbt7bw@mail.gmail.com>
 <YjOlJL7xwktKoLFN@casper.infradead.org> <20220318131600.iv7ct2m4o52plkhl@quack3.lan>
In-Reply-To: <20220318131600.iv7ct2m4o52plkhl@quack3.lan>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 18 Mar 2022 11:56:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiky+cT7xF_2S94ToEjm=XNX73CsFHaQJH3tzYQ+Vb1mw@mail.gmail.com>
Message-ID: <CAHk-=wiky+cT7xF_2S94ToEjm=XNX73CsFHaQJH3tzYQ+Vb1mw@mail.gmail.com>
Subject: Re: writeback completion soft lockup BUG in folio_wake_bit()
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Ashish Sangwan <a.sangwan@samsung.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 18, 2022 at 6:16 AM Jan Kara <jack@suse.cz> wrote:
>
> I agree with Dave that 'keep_towrite' thing is kind of self-inflicted
> damage on the ext4 side (we need to write out some blocks underlying the
> page but cannot write all from the transaction commit code, so we need to
> keep xarray tags intact so that data integrity sync cannot miss the page).
> Also it is no longer needed in the current default ext4 setup. But if you
> have blocksize < pagesize and mount the fs with 'dioreadlock,data=ordered'
> mount options, the hack is still needed AFAIK and we don't have a
> reasonable way around it.

I assume you meant 'dioread_lock'.

Which seems to be the default (even if 'data=ordered' is not).

Anyway - if it's not a problem for any current default setting, maybe
the solution is to warn about this case and turn it off?

IOW, we could simply warn about "data=ordered is no longer supported"
and turn it into data=journal.

Obviously *only* do this for the case of "blocksize < PAGE_SIZE".

If this ext4 thing is (a) obsolete and (b) causes VFS-level problems
that nobody else has, I really think we'd be much better off disabling
it than trying to work with it.

                 Linus
