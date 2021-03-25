Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F06DB3489CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 08:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbhCYHGX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 03:06:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45614 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhCYHGV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 03:06:21 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616655979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qtOSCAcacChPRUdAo0KnSFEyBG7D6PRUlhsVYvdS+4w=;
        b=CteCm5YtEyxr1gpAGn0H16skKQ6cKyaoEWKnaTjvHWKDKRGk0lRaCzF8FcQwgxeElgKyrD
        9o48Tcp/YMWdu+KTcDy7DS0UNmU3OU/7gFLf9gK6tTylZNw1Kya+nhfsXJmrrPnOHG3ZCE
        mbNXme/0ySjL29Y7Wq7lUoL4mAqObx4YFE3BBkVU02FO2xe7n5gzLiYZGNyQUwUUl5eEZc
        hnuUA+J5xC66EYblKbJMVsYiUeBqFL/lnpsiAA8Pf+903bTAtTdfrf29bWFzOCxgIfKZLF
        qQ7XKB5PiDdHquVUath1SvtmlGc6G6ORvUfPFx3uVFjf0au9fYtAealnMIp/pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616655979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qtOSCAcacChPRUdAo0KnSFEyBG7D6PRUlhsVYvdS+4w=;
        b=44U9bX+fjOho4Of8zG3fIdRwqf2BZf64r/+X62gEv/ijcPX6+MqQqyw8mTDY/DxW/xYxav
        cK/xpLJIsDDBGoAA==
To:     Manish Varma <varmam@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kelly Rossmoyer <krossmo@google.com>, kernel-team@android.com
Subject: Re: [PATCH] fs: Improve eventpoll logging to stop indicting timerfd
In-Reply-To: <CAMyCerKf4MfsjAcVhXi7DVuP9mvt0X6VamwMiHa3KgRvnr7p9Q@mail.gmail.com>
References: <20210302034928.3761098-1-varmam@google.com> <87pmzw7gvy.fsf@nanos.tec.linutronix.de> <CAMyCerL7UkcU1YgZ=dUTZadv-YPHGccO3PR-DCt2nX7nz0afgA@mail.gmail.com> <87zgyurhoe.fsf@nanos.tec.linutronix.de> <CAMyCerKf4MfsjAcVhXi7DVuP9mvt0X6VamwMiHa3KgRvnr7p9Q@mail.gmail.com>
Date:   Thu, 25 Mar 2021 08:06:19 +0100
Message-ID: <87h7kzbtlg.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Manish,

On Wed, Mar 24 2021 at 22:18, Manish Varma wrote:
> On Mon, Mar 22, 2021 at 2:40 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> Not that I expect any real dependencies on it, but as always the devil
>> is in the details.
>
> Right, there are some userspace which depends on "[timerfd]" string
> https://codesearch.debian.net/search?q=%22%5Btimerfd%5D%22&literal=1

Details :)

> So, modifying file descriptor names at-least for timerfd will definitely
> break those.
>
> With that said, I am now thinking about leaving alone the file descriptor
> names as is, and instead, adding those extra information about the
> associated processes (i.e. process name or rather PID of the
> process) along with token ID directly into wakesource name, at the
> time of creating new wakesource i.e. in ep_create_wakeup_source().
>
> So, the wakesource names, that currently named as "[timerfd]", will be
> named something like:
> "epollitem<N>:<PID>.[timerfd]"
>
> Where N is the number of wakesource created since boot.

Where N is a unique ID token. :)

> This way we can still associate the process with the wakesource
> name and also distinguish multiple instances of wakesources using
> the integer identifier.

If that solves your problem and does not make anything else breaks which
relies on the exisitng epollitem naming convention, then I don't see a
problem with that.

Thanks,

        tglx
