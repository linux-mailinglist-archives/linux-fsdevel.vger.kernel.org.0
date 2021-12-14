Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0939474470
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Dec 2021 15:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234718AbhLNOFB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Dec 2021 09:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbhLNOFB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Dec 2021 09:05:01 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1170C061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Dec 2021 06:05:00 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id l24so35033086uak.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Dec 2021 06:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1xbz4OXeAqbKGLrAlz6aBGLF8sjufKoUKm+Xe5+JoJA=;
        b=JARGe2eoC/eTZcuanFZRzYpsDXDSoQewPbnakQD+331znIsBHz8gmitw9WPtlEmsg5
         uuC/oF7UnkIzFru6YZykfCHoA/dCQ/aZhOpgLLllCCfuMP4s+3GHvBi4UJdWXIbaal7e
         8gluZ7eIr+cjylNfqkyc7DZbfFc4OwOPvFz4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1xbz4OXeAqbKGLrAlz6aBGLF8sjufKoUKm+Xe5+JoJA=;
        b=r8JARpZLitgEt0PBHmLza1l5cij38kl4y+a3nXnXhK0LUeXscBV5QDn520G2d8D76U
         oY9rv7qXzYdTHN+tEEMJHqEKMg/m36sabBvQ2bqLhBgv9nJjIf2IY47usdUKafoKBV6U
         +QPbLmx/zL7INkL80JQR/btcEHx/DAl9GH5/Qca86snIVWd8K8jHBS8WnzhAbRY+rnDn
         UfzL0Unqi61sWKRzn7n396s0GU8f0VEfytZtqkH3RymSi/FTSTL8rhzGHLWS4r8TnLMp
         jtGYW2ZKgg2nWbRX3+EdhyCzUmJ0QcVHbFczQj2irrZm9KQNy80b+5tWwDpAd/Cj5mUY
         sD0w==
X-Gm-Message-State: AOAM530oM5gxwTlYOuUbry6ikWlcx0SxgZYM1n3+vTpRW53qWWXt2j0e
        gu6u1pHP1qSP/aqwFbbYuPnPNqO3aEn+9nCS7WmZyQ==
X-Google-Smtp-Source: ABdhPJw8wIxuLC1AhuXLJvqn7YhSyg+qMm3mcnrLJRJlJySTp7NA5ryLzri0V1MgE3AcPcaQZqRlasYp55P7URrgslA=
X-Received: by 2002:ab0:2696:: with SMTP id t22mr5457527uao.13.1639490700022;
 Tue, 14 Dec 2021 06:05:00 -0800 (PST)
MIME-Version: 1.0
References: <CADVsYmhF2=Y9AktyHdvKq5=CzJBALBjKfrSu8+2+=YdkSRazpg@mail.gmail.com>
In-Reply-To: <CADVsYmhF2=Y9AktyHdvKq5=CzJBALBjKfrSu8+2+=YdkSRazpg@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 14 Dec 2021 15:04:49 +0100
Message-ID: <CAJfpegvEppXZbX25Nage463biMjWPKthr=519PSJ61yZmTavCw@mail.gmail.com>
Subject: Re: [fuse-devel] Reconnect to FUSE session
To:     Robert Vasek <rvasek01@gmail.com>
Cc:     fuse-devel <fuse-devel@lists.sourceforge.net>,
        Hao Peng <flyingpenghao@gmail.com>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 14 Dec 2021 at 13:58, Robert Vasek <rvasek01@gmail.com> wrote:
>
> Hello fuse-devel,
>
> I'd like to ask about the feasibility of having a reconnect feature added=
 into the FUSE kernel module.
>
> The idea is that when a FUSE driver disconnects (process exited due to a =
bug, signal, etc.), all pending and future ops for that session would wait =
for that driver to appear again, and then continue as normal. Waiting would=
 be on a timer, with ENOTCONN returned in case it times out. Obviously, "co=
ntinue as normal" isn't possible for all FUSE drivers, as it depends on wha=
t they do and how they implement things -- they would have to opt-in for th=
is feature.
>
> Use-cases span across basically anything where the lifecycle of a FUSE dr=
iver is managed by some external component (e.g. systemd, container orchest=
rators). This is especially true in containerized environments: volume moun=
ts provided by FUSE drivers running in containers may get killed / reschedu=
led by the Orchestrator, or they may crash due to bugs, memory pressure, ..=
., leading to very possible data corruption and severed mounts. Having the =
ability to recover from such situations would greatly improve reliability o=
f these systems.
>
> I haven't looked at how this would be implemented yet though. I'm just wo=
ndering if this makes sense at all and if you folks would be interested in =
such a feature?

A kernel patch[1] as well as example userspace code[2] has already
been proposed.

[1] https://lore.kernel.org/linux-fsdevel/CAPm50a+j8UL9g3UwpRsye5e+a=3DM0Hy=
7Tf1FdfwOrUUBWMyosNg@mail.gmail.com/

[2] https://lore.kernel.org/linux-fsdevel/CAPm50aLuK8Smy4NzdytUPmGM1vpzokKJ=
dRuwxawUDA4jnJg=3DFg@mail.gmail.com/

The example recovery is not very practical, but I can see how it would
be possible to extend to a read-only fs.

Is this what you had in mind?

Thanks,
Miklos
