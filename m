Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2761C2B5527
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Nov 2020 00:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730133AbgKPXg6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 18:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbgKPXg6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 18:36:58 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3F5C0613CF;
        Mon, 16 Nov 2020 15:36:57 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id q16so5338382edv.10;
        Mon, 16 Nov 2020 15:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UYQGpP+dBh+zFdLRXZzINpNeGgI4AE9NCG0zVfcVLXo=;
        b=MizuHETq6KXHqDJRR0zOdEenTO6bELg1HqHrvBHp/1bu0+UZrhoWPlFmA/OC2mymY5
         GqeWLRz1K3yLT2hzdVlFRos3wGe7h9YjhvQCeDee4ChfnPT0CNgyDemUSYC86p5Qa+KA
         rUoQgkAPHIQ8RuQ/JALN3mRFxZPRE48OsEnrLbMvo2UUi1Ibzo8M8leGpxzALcvLqnFV
         1zSJK1Bv1zdWczO8apKCnmYR51OKmZ9NvBw77r8GsAyj2MKV3XveWxOwvJPYYAKvY62R
         daeJazRS3V2w11cvLluU6k97gcNfh0TnDSZjdd/E75jGxRxTM8NWKg9adlP/Cgs6gcAu
         R8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UYQGpP+dBh+zFdLRXZzINpNeGgI4AE9NCG0zVfcVLXo=;
        b=X+tjJw+ol5rOEqvfWR5BN6WKjC6w8u2VGoPf5BLDYK7wdCN7L4j047ORnQCpSOFoK4
         VzokOo78o2o9sADLNFsJxoPyFH/KAsDtH1e3wLP9WVWN6RdYzu1geUeIN2Kg2sUpPVFo
         FTIZgA+Lp5OhDeEr4f5NIqWCOQVpX0VEcJ27fARbCWj2K9rFbsWB9tsvlBHkX+jEHQrJ
         QPI8ySv+88PgONG5E7/eYXNxLT0NpZuOwDxhVJllWBbd1pHuXpevlkx9GWmjqOaPOPY2
         CoDwb9IKjEnDeCO9dXgLhgx07NpL3NDRy3eQPrZovbecRLE8Z/vyHdvHfBLwZ4AUcQWz
         T+bQ==
X-Gm-Message-State: AOAM532DmMu6jVMVaP9W68NSgghBaJX5gO0/6eZczygGSAiAAFr1T1mQ
        68rHEYHi/iHohraohsSdY+pKpfZ7u+ThtiagIqg5IBaC
X-Google-Smtp-Source: ABdhPJxzYHJ1roiYvmyh2Os32B/jxh7IknlWpZ+dVlsfxj3oaLI/FKiDVinRcasFGI+/0CZ6FDei6N8C69ic9tIToRs=
X-Received: by 2002:a50:cd0a:: with SMTP id z10mr17704769edi.223.1605569816680;
 Mon, 16 Nov 2020 15:36:56 -0800 (PST)
MIME-Version: 1.0
References: <20201116161001.1606608-1-willemdebruijn.kernel@gmail.com> <20201116120445.7359b0053778c1a4492d1057@linux-foundation.org>
In-Reply-To: <20201116120445.7359b0053778c1a4492d1057@linux-foundation.org>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 16 Nov 2020 18:36:19 -0500
Message-ID: <CAF=yD-JJtAwse5keH5MxxtA1EY3nxV=Ormizzvd2FHOjWROk4A@mail.gmail.com>
Subject: Re: [PATCH v2] epoll: add nsec timeout support
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Soheil Hassas Yeganeh <soheil.kdev@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Shuo Chen <shuochen@google.com>,
        Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 16, 2020 at 3:04 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Mon, 16 Nov 2020 11:10:01 -0500 Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
>
> > From: Willem de Bruijn <willemb@google.com>
> >
> > Add epoll_create1 flag EPOLL_NSTIMEO. When passed, this changes the
> > interpretation of argument timeout in epoll_wait from msec to nsec.
> >
> > Use cases such as datacenter networking operate on timescales well
> > below milliseconds. Shorter timeouts bounds their tail latency.
> > The underlying hrtimer is already programmed with nsec resolution.
>
> hm, maybe.  It's not very nice to be using one syscall to alter the
> interpretation of another syscall's argument in this fashion.  For
> example, one wonders how strace(1) is to properly interpret & display
> this argument?
>
> Did you consider adding epoll_wait2()/epoll_pwait2() syscalls which
> take a nsec timeout?  Seems simpler.

I took a first stab. The patch does become quite a bit more complex.

I was not aware of how uncommon syscall argument interpretation
contingent on internal object state really is. Yes, that can
complicate inspection with strace, seccomp, ... This particular case
seems benign to me. But perhaps it sets a precedent.

A new nsec resolution epoll syscall would be analogous to pselect and
ppoll, both of which switched to nsec resolution timespec.

Since creating new syscalls is rare, add a flags argument at the same time?

Then I would split the change in two: (1) add the new syscall with
extra flags argument, (2) define flag EPOLL_WAIT_NSTIMEO to explicitly
change the time scale of the timeout argument. To avoid easy mistakes
by callers in absence of stronger typing.

epoll_wait is missing from include/uapi/asm-generic/unistd.h as it is
superseded by epoll_pwait. Following the same rationale, add
epoll_pwait2 (only).

> Either way, we'd be interested in seeing the proposed manpage updates
> alongside this change.

Will do. What is the best way? A separate RFC patch against
manpages/master sent at the same time?
