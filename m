Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F3D7A53C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 22:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjIRUSd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 16:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjIRUSc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 16:18:32 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC5910A
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 13:18:26 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50300141a64so4071648e87.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 13:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695068305; x=1695673105; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5hiqGPeu+uF2kVYNtC9QmaELCxRejOYJFO8VayGWNAw=;
        b=gnPtYwIWD9VYq0nKHU0jqdq0LngTIh0/PqrWRm5+GEtU1lCAN9y4oGeGUyv0UQ/Q82
         WqwBguxXgShXF5VK3zw+PxPS++I/x3w/ZEc5DPgEpKDlBcz10JBHpY2nqcY2By/z/ycr
         /64z6aGaBlqFwt6jYWYwK21A5XR3QOH1ezDZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695068305; x=1695673105;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5hiqGPeu+uF2kVYNtC9QmaELCxRejOYJFO8VayGWNAw=;
        b=SD8a4S1Yn+tPJOKT0Cl3CkscCW8qmKKRlOXkzBhTrErg9ULsbcALGKNq9gangcFu2p
         rT68TTiLoGx4FLtxSx+2OMqDfPwqjbak1zSos/r5UNqmGxk26FQaHB2LAC3wXM+W0ziF
         03/XrsiJzFNSqBTgQU1UR50DHeqjOu/gjRiOHsFUGPHVeJSoTvsRl5axo7zWGYZw4dCs
         ylSROe3llFdWOZJGKCvcL30Z8BCcg/v0LaLX+gtp8jNXsnLNrLgmdotMIdHMGUplBxN5
         1Dym7Pwfidru/WfEfg5rJm49EhEm0Zi48sIqO5kFakI4fnsgqzIvjDfvc18RuY6yJf8p
         Hfog==
X-Gm-Message-State: AOJu0YzRGxR5wkMmTF3YKz4Y+XOOFQ55uXocoXZznJlU0LRxSA86LkH1
        vaVENoIR3l5QXduVKKZzVaniYleBhvTT4MIa8x7DRwWQ
X-Google-Smtp-Source: AGHT+IGiSOZqPh5e6dxojc9A9xdy6o2tRnGLG69zsH75Z48+6ZZ1/ip3M8GPGdvocrqhh4lCePJYDg==
X-Received: by 2002:a05:6512:3b0:b0:500:b964:37e0 with SMTP id v16-20020a05651203b000b00500b96437e0mr8106205lfp.6.1695068305008;
        Mon, 18 Sep 2023 13:18:25 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id h25-20020aa7c619000000b0052fdc837d93sm6494384edq.47.2023.09.18.13.18.24
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 13:18:24 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-530ab2d9e89so3562494a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 13:18:24 -0700 (PDT)
X-Received: by 2002:aa7:c152:0:b0:52f:6942:4553 with SMTP id
 r18-20020aa7c152000000b0052f69424553mr8578677edp.6.1695068303973; Mon, 18 Sep
 2023 13:18:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230918-hirte-neuzugang-4c2324e7bae3@brauner>
 <CAHk-=wiTNktN1k+D-3uJ-jGOMw8nxf45xSHHf8TzpjKj6HaYqQ@mail.gmail.com> <e321d3cfaa5facdc8f167d42d9f3cec9246f40e4.camel@kernel.org>
In-Reply-To: <e321d3cfaa5facdc8f167d42d9f3cec9246f40e4.camel@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Sep 2023 13:18:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgxpneOTcf_05rXMMc-djV44HD-Sx6RdM9dnfvL3m10EA@mail.gmail.com>
Message-ID: <CAHk-=wgxpneOTcf_05rXMMc-djV44HD-Sx6RdM9dnfvL3m10EA@mail.gmail.com>
Subject: Re: [GIT PULL] timestamp fixes
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 18 Sept 2023 at 12:39, Jeff Layton <jlayton@kernel.org> wrote:
>
> In general, we always update the atime with a coarse-grained timestamp,
> since atime and ctime updates are never done together during normal read
> and write operations. As you note, things are a little more murky with
> utimes() updates but I think we should be safe to overwrite the atime
> with a coarse-grained timestamp unconditionally.

I do think utimes() ends up always overwriting, but that's a different
code-path entirely (ie it goes through the ->setattr() logic, not this
inode_update_timestamps() code).

So I *think* that even with your patch, doing a "touch" would end up
doing the right thing - it would update atime even if it was in the
future before.

But doing a plain "read()" would break, and not update atime.

That said, I didn't actually ever *test* any of this, so this is
purely from reading the patch, and I can easily have missed something.

Anyway, I do think that the timespec64_equal() tests are a bit iffy in
fs/inode.c now, since the timespecs that are being tested might be of
different precision.

So I do think there's a *problem* here, I just do not believe that
doing that timespec64_equal() -> timespec64_compare() is at all the
right thing to do.

My *gut* feel is that in both cases, we have this

        if (timespec64_equal(&inode->i_atime, &now))

and the problem is that *sometimes* 'now' is the coarse time, but
sometimes it's the fine-grained one, and so checking for equality is
simply nonsensical.

I get the feeling that that timespec64_equal() logic for those atime
updates should be something like

 - if 'now' is in the future, we always considering it different, and
update the time

 - if 'now' is further in the past than the coarse granularity, we
also update the time ("clearly not equal")

 - but if 'now' is in the past, but within the coarse time
granularity, we consider it equal and do not update anything

but it's not like I have really given this a huge amount of thought.
It's just that "don't update if in the past" that I am pretty sure can
*not* be right.

                  Linus
