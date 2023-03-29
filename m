Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A996CF371
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 21:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjC2TpE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 15:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjC2To5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:44:57 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2659355B4
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 12:44:39 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id x3so67721325edb.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 12:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1680119073; x=1682711073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XnJoqbTavyu9K/yoHzgubvrjHRh2PzDenbxkIB/h7+4=;
        b=AmWilesZA7Cx28WzP3yFWo+ycRjUDstvCIEQdcL9h2ji/PzH46Nxf3fI2KHZ6vk941
         qvMCBePZgaCm8h7uiYtrf43gpmBZJKaz0+28TCCNiMRPGTLxyWcqT4rymisGjRQ0dVhc
         PhvCZTzfJcAqbu5qQIiAJSX6ayDwpAzXpsL1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680119073; x=1682711073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XnJoqbTavyu9K/yoHzgubvrjHRh2PzDenbxkIB/h7+4=;
        b=IOxuAvJg8lhZX2S84hozpjoKewlqkniOGQukBABNVbmIF467bvPZbQmxacpnPFiDtg
         Oggo8yOTKJWPFospPHXF70frqGh4qsFY+7+i5zXNaTMSFniLc70HJkWZP7+HOLFdto74
         Lz1IQkK3dXsWNQPM3q76qd8IzabIwHctG0NQCiriv85THCrD6XQhwjuVIvujaJo+95BR
         CuYP5eX2kALAW9zWuwgL/EGotlIh5zrMsAuVfyhzHlE3goW077bTowoqVVvEQMiFAzwG
         fWJ3x3cB9xE7B9yQtOzlujw1b+p6jEobH0HCjWzJblnM3H4EEg+G7gV/Xgk+OI+5Lrnd
         ASQQ==
X-Gm-Message-State: AAQBX9cINvfJSQ3YzccyD+XML1KHylPg2BU4y2Pz0/02r0e8EuqutOg5
        AHf/offQlC3ecsAZhbdBosKQAaO+/1f7f7ztU2eR19HB
X-Google-Smtp-Source: AKy350adqF5Rd22bZWwpIUOru2xytU3aHvTSL/6KTs6Fm/6EEe+Nowc+Goa97t+fPG9qt+dWhtqG8Q==
X-Received: by 2002:a17:907:174f:b0:7e0:eed0:8beb with SMTP id lf15-20020a170907174f00b007e0eed08bebmr21103780ejc.41.1680119073104;
        Wed, 29 Mar 2023 12:44:33 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id qq24-20020a17090720d800b008df7d2e122dsm16710598ejb.45.2023.03.29.12.44.32
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 12:44:32 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id x3so67721055edb.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 12:44:32 -0700 (PDT)
X-Received: by 2002:a50:ce4e:0:b0:502:4c87:7982 with SMTP id
 k14-20020a50ce4e000000b005024c877982mr4574717edj.2.1680119071832; Wed, 29 Mar
 2023 12:44:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230329184055.1307648-1-axboe@kernel.dk>
In-Reply-To: <20230329184055.1307648-1-axboe@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 29 Mar 2023 12:44:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=whjCu0Scau47RAGXO5FF8Xtc__Nw11Qh50gyMNWVcwh_A@mail.gmail.com>
Message-ID: <CAHk-=whjCu0Scau47RAGXO5FF8Xtc__Nw11Qh50gyMNWVcwh_A@mail.gmail.com>
Subject: Re: [PATCHSET v6 0/11] Turn single segment imports into ITER_UBUF
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 29, 2023 at 11:41=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote=
:
>
> Passes testing, and verified we do the right thing for 1 and multi
> segments.

Apart from the pointer casting rant, this looks sane to me.

I feel like 02/11 has a few potential cleanups:

 (a) it feels like a few too many "iter.__iov" uses remaining, but
they mostly (all?) look like assignments.

I do get the feeling that any time you assign __iov, you should also
assign "nr_segs", and it worries me a bit that I see one without the
other. Maybe room for another helper that enforces a "if you set the
__iov pointer, you must be setting nr_segs too"?

And maybe I'm just being difficult.

 (b) I see at least one "iov =3D iter_iov(from)" that precedes a later
check for "iter_is_iovec()", which again means that *if* we add some
debug sanity test to "iter_iov()", it might trigger when it shouldn't?

The one I see is in snd_pcm_writev(), but I th ink the same thing
happens in snd_pcm_readv() but just isn't visible in the patch due to
not having the context lines.

            Linus
