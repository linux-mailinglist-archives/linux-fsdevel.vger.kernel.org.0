Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9D94D8BBF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Mar 2022 19:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243801AbiCNSWm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Mar 2022 14:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243807AbiCNSWj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Mar 2022 14:22:39 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8A23D1CC
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Mar 2022 11:21:29 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id e6so22127364lfc.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Mar 2022 11:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1oixq+wvjYzthzNZ1BYgX3Lz4ydO/fekdRIrbKTsbhM=;
        b=E+Jc37Qf4L7KuZZ++HrRrbaMHzs7fTmNZ3xJc4VLSrjU6m2rek2V98HZcbgjE/khdf
         FIaSgoeSe2ChD9MeFM2oTHI/U9n+mGoTvZLQRFjQzBZYRspuYdgvATFj/ixr5dPm7d15
         UDXlDF/o6mlPgO6+geol5z3gDquxFJv1VfRj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1oixq+wvjYzthzNZ1BYgX3Lz4ydO/fekdRIrbKTsbhM=;
        b=kIS4x3XrPBiNpUzfyp/nWP1OQq5JuOuylMgMYMumsvayxS4VD2EmO/IdXebTIWG81g
         3bjif28Mx19DrP60L4TQ9gJREsIOOJJEBgodeFYGlZBAyJlkbAqSrAU6zNd3RggnO3ba
         OaLgOidGOU6y0isdqv4LI6lV+gWPH/YIJIqvlpSYztevKfbGDVhUmNYZ1zD2G9xAqSMs
         Um7HEErIxR04p6oQ/xQKpaXm/ZTH6+DpWKvx8qfcuTTJX7g/ASMjfm65+p6XczqP7jPS
         nQ2UQp4EvCXM31jCQJ/gYH2AfhGDfZdooceX24pqfocvukzsGetMLvlOzeeYKob6X7PH
         Hjug==
X-Gm-Message-State: AOAM531uli2GeuBYr/jid0OIZaimlJ0oR6gScgxW3WaRx4iGBv1vf6aq
        2WG1wifWTFAUsvBfZgCbYXLjP9PNXktNrVrd
X-Google-Smtp-Source: ABdhPJw6XvCsgvgaSG6x6/wKSQWoI+FOPeup0FVoGgXVSEroHbI4g7aqHnj8Ma0yMPyXz7UPxP6Zpw==
X-Received: by 2002:a05:6512:5c1:b0:448:2dae:4ea9 with SMTP id o1-20020a05651205c100b004482dae4ea9mr14365339lfo.495.1647282086395;
        Mon, 14 Mar 2022 11:21:26 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id o4-20020a2eb444000000b00247f29888fcsm4083509ljm.124.2022.03.14.11.21.25
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 11:21:25 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id h11so23198247ljb.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Mar 2022 11:21:25 -0700 (PDT)
X-Received: by 2002:a2e:9904:0:b0:247:ec95:fdee with SMTP id
 v4-20020a2e9904000000b00247ec95fdeemr14708357lji.291.1647282085278; Mon, 14
 Mar 2022 11:21:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220314154605.11498-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20220314154605.11498-1-lukas.bulwahn@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 14 Mar 2022 11:21:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wju=Lx3b5NQ9KntQ=0JvvXcJfpjt_nZOMWV43OWwPrUQw@mail.gmail.com>
Message-ID: <CAHk-=wju=Lx3b5NQ9KntQ=0JvvXcJfpjt_nZOMWV43OWwPrUQw@mail.gmail.com>
Subject: Re: [PATCH] aio: drop needless assignment in aio_read()
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Benjamin LaHaise <bcrl@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-aio@kvack.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Mon, Mar 14, 2022 at 8:46 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Drop this needless assignment in aio_read().
>
> No functional change. No change in resulting object code.

Ack, that assignment is indeed dead. As such, compilers will remove it
and it doesn't "hurt", but it is pointless and possibly confusing.

> I cc'ed Linus as he is the author of the referred commit, but I expect
> that this clean-up just goes the usual way to Al Viro and then in some
> git pull to Linus.

Sounds good to me.

                   Linus
