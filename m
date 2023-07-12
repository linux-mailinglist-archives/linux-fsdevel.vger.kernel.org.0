Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3978775117F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 21:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbjGLTsf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 15:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbjGLTse (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 15:48:34 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D2C1FE6
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 12:48:33 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-666ed230c81so6596148b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 12:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689191312; x=1691783312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M4ZDRM5fvQMo9GlwKOHCyQm7Bm/RC8HHEV7PqArueRk=;
        b=P+qxeFDIOXYrfb8mKf4q2MKsfsAdNORvRZzlqorQhCiYlGDr4HR+fqoRqyaaCSw8qs
         gqW+0q6vFVb2yZh+NqTkF3pZvEHl6EAsJ5/5S2zGkkS41VQ+jjWhCanZHeMf4krxerwW
         t0YdCT3qXtqyZGRJ7+TrJBxjvX45zPbkp8JNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689191312; x=1691783312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4ZDRM5fvQMo9GlwKOHCyQm7Bm/RC8HHEV7PqArueRk=;
        b=NNkttE2WfzAzbNYZYpuBMg6qmZh6NfSCGL8xByI4VS0mKE7n4ureCQHYMnleGaGfKN
         n7Ldwht9tyAD7lV3aFN6gn2Lf9x5bUaRgMlUy2op5es+jVXEfSiA0sIZTFjOJuRWvOvX
         /sKpwH+ZNrBnuuZeELQC2wyb3D8IXXMNm41cpzInxkFfDWDrKG5oUKNvsFOiZmjvMwAu
         dwiusD7VuCKBaBMIVKnJPNDEJNm0Gdq3ITrUATARdkVyNjQpxMxh7feT0WpjR1BD61c9
         r7x8NYiGsBAU0Hu61GOdeaPDWOB65In9CTmq+wcCLCSwjttokOFRwpvELLAYEaaNPKsP
         1RtA==
X-Gm-Message-State: ABy/qLamywi+ef31+udd/ou7cmMZ43ZWqv1WyrTEJFxbbnWROw0QCZR8
        nfLdpxVpDu+9U8eER5k8PJjCew==
X-Google-Smtp-Source: APBJJlHM2vxo8fnmZa5oicXLm6Q8d+5+DCS3hBxF+8rUtbVzNiS44Xe3ydnwgRLPo/qT2TQvgD/JCw==
X-Received: by 2002:a05:6a20:7353:b0:132:2f7d:29ca with SMTP id v19-20020a056a20735300b001322f7d29camr7630596pzc.24.1689191312528;
        Wed, 12 Jul 2023 12:48:32 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h3-20020aa786c3000000b00682af82a9desm4082520pfo.98.2023.07.12.12.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 12:48:32 -0700 (PDT)
Date:   Wed, 12 Jul 2023 12:48:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        djwong@kernel.org, dchinner@redhat.com, sandeen@redhat.com,
        willy@infradead.org, josef@toxicpanda.com, tytso@mit.edu,
        bfoster@redhat.com, jack@suse.cz, andreas.gruenbacher@gmail.com,
        brauner@kernel.org, peterz@infradead.org,
        akpm@linux-foundation.org, dhowells@redhat.com, snitzer@kernel.org
Subject: Re: [GIT PULL] bcachefs
Message-ID: <202307121241.8295B924F@keescook>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <20230706155602.mnhsylo3pnief2of@moria.home.lan>
 <20230712025459.dbzcjtkb4zem4pdn@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712025459.dbzcjtkb4zem4pdn@moria.home.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 11, 2023 at 10:54:59PM -0400, Kent Overstreet wrote:
>  - Prereq patch series has been pruned down a bit more; also Mike
>    Snitzer suggested putting those patches in their own branch:
> 
>    https://evilpiepirate.org/git/bcachefs.git/log/?h=bcachefs-prereqs
> 
>    "iov_iter: copy_folio_from_iter_atomic()" was dropped and replaced
>    with willy's "iov_iter: Handle compound highmem pages in
>    copy_page_from_iter_atomic()"; he said he'd try to send this for -rc4
>    since it's technically a bug fix; in the meantime, it'll be getting
>    more testing from my users.
> 
>    The two lockdep patches have been dropped for now; the
>    bcachefs-for-upstream branch is switched back to
>    lockdep_set_novalidate_class() for btree node locks. 
> 
>    six locks, mean and variance have been moved into fs/bcachefs/ for
>    now; this means there's a new prereq patch to export
>    osq_(lock|unlock)
> 
>    The remaining prereq patches are pretty trivial, with the exception
>    of "block: Don't block on s_umount from __invalidate_super()". I
>    would like to get a reviewed-by for that patch, and it wouldn't hurt
>    for others.
> 
>    previously posting:
>    https://lore.kernel.org/linux-bcachefs/20230509165657.1735798-1-kent.overstreet@linux.dev/T/#m34397a4d39f5988cc0b635e29f70a6170927746f

Can you send these prereqs out again, with maintainers CCed
appropriately? (I think some feedback from the prior revision needs to
be addressed first, though. For example, __flatten already exists, etc.)

-- 
Kees Cook
