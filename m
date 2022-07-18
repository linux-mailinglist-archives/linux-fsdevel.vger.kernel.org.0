Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4EA577F04
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jul 2022 11:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbiGRJvv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jul 2022 05:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbiGRJvt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jul 2022 05:51:49 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E7A1AF3F
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jul 2022 02:51:43 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id ss3so20161706ejc.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jul 2022 02:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RiLfSPG+jClf3kMGZRiuZEBRpwhLt+4GrcqCg7VELk0=;
        b=LAdIowJ91/gUZxwIyFbBh+maGqGsqFiQfNOb7+Km6vo29sbQeKC6VQBPi+wrNZLHlx
         zH7oYinSGgwTwfWe/IN9O4FRBC52tO3o6SDE0JdHQVmkM0cXhn53s457/bleEcuVPlUq
         QGW/uu90sHSYtS2b+/v1EPZleAIPR3H9c/AtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RiLfSPG+jClf3kMGZRiuZEBRpwhLt+4GrcqCg7VELk0=;
        b=RH7nkB9x3YTirTPiZx3h19HzKmbAylkocTTtUmy0jcHdp0tCYxLhe7GXsRtIqne4ya
         Z1ur1Tq2TNWSfE3f6R8KOXnATHz2MlUfMFzg4E0vo5LoRvztmzHB8wo8F7EEoLGYhedM
         UQm4KXm86lGmX9TpGc9f+FADHR0xT6b7JcFWdgvLlpS8OgX1f6SHZ84VS90NM9/E4O+u
         vJkaUTVzYMWizxqSgFP3srdPBRZ9iihW6HRAG05fAONo8zRSGacEb9JvggnhVSuZh/CE
         ruu9OgS1EXgXmfFYuImfAwysY1+p53KwAMEVL8xMGz1fLiHfG0/4d24pL37pFqO0tW1u
         VrmQ==
X-Gm-Message-State: AJIora+5PSIkZSs7eC75HXNw6DN8rrASW5DcJfPIbmJivcoBDWFMYeqC
        cC1kmN6/rnpo3SLqFiL0C03wIko1lBf1d/CvUxj/Cg==
X-Google-Smtp-Source: AGRyM1vlbx2uFDgQZlteYGU8/BVd543S2VQZEI2+vWh3QOJOZkSuwUg75H32xmDvy47HCTzOScYb3uueVvG04DwO0yE=
X-Received: by 2002:a17:907:2854:b0:72b:7daf:cc0d with SMTP id
 el20-20020a170907285400b0072b7dafcc0dmr24294498ejc.524.1658137902383; Mon, 18
 Jul 2022 02:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220601011103.12681-1-dlunev@google.com> <20220601111059.v4.1.I0e579520b03aa244906b8fe2ef1ec63f2ab7eecf@changeid>
In-Reply-To: <20220601111059.v4.1.I0e579520b03aa244906b8fe2ef1ec63f2ab7eecf@changeid>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 18 Jul 2022 11:51:31 +0200
Message-ID: <CAJfpegv8-0_Jsf7wUOVsXkt69o4Xrq0TgvwUzZF+RHX4_nxMzw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] fs/super: function to prevent super re-use
To:     Daniil Lunev <dlunev@chromium.org>
Cc:     linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        Daniil Lunev <dlunev@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 1 Jun 2022 at 03:11, Daniil Lunev <dlunev@chromium.org> wrote:
>
> From: Daniil Lunev <dlunev@chromium.org>
>
> The function is to be called from filesystem-specific code to mark a
> superblock to be ignored by superblock test and thus never re-used. The
> function also unregisters bdi if the bdi is per-superblock to avoid
> collision if a new superblock is created to represent the filesystem.
> generic_shutdown_super() skips unregistering bdi for a retired
> superlock as it assumes retire function has already done it.
>
> Signed-off-by: Daniil Lunev <dlunev@chromium.org>
> Signed-off-by: Daniil Lunev <dlunev@google.com>
> ---
>
> Changes in v4:
> - Simplify condition according to Christoph Hellwig's comments.
>
> Changes in v3:
> - Back to state tracking from v1
> - Use s_iflag to mark superblocked ignored
> - Only unregister private bdi in retire, without freeing
>
> Changes in v2:
> - Remove super from list of superblocks instead of using a flag
>
>  fs/super.c         | 28 ++++++++++++++++++++++++++--
>  include/linux/fs.h |  2 ++
>  2 files changed, 28 insertions(+), 2 deletions(-)
>
> diff --git a/fs/super.c b/fs/super.c
> index f1d4a193602d6..3fb9fc8d61160 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -422,6 +422,30 @@ bool trylock_super(struct super_block *sb)
>         return false;
>  }
>
> +/**
> + *     retire_super    -       prevernts superblock from being reused

s/prevernts/prevents/

> + *     @sb: superblock to retire
> + *
> + *     The function marks superblock to be ignored in superblock test, which
> + *     prevents it from being reused for any new mounts.

This works for block supers and nothing else, at least as this patch
stands.  That might be okay, but should at least be documented.

Thanks,
Miklos
