Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1981A39CA4F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jun 2021 19:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbhFERyP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Jun 2021 13:54:15 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:38823 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbhFERyP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Jun 2021 13:54:15 -0400
Received: by mail-io1-f49.google.com with SMTP id b25so13849189iot.5
        for <linux-fsdevel@vger.kernel.org>; Sat, 05 Jun 2021 10:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TG0Z0AhadiSMh7o20DfWQUt9Vgnpq7gs6IKlK0681qE=;
        b=A5n5OsKhQMZ/THaQqGkGpNpXmqCEJDnINLYZAgWwTERvLBrVcl9BU0YMgkKWghS8z6
         eKKx7fM/+hGvBX+1ne1Y6sUAxhDl2HwF310IqtTJdBPKtnBcMW4Jrv+J6GRc14N5VTBH
         ZFl2J6sWTMo1N22vFp4LWRnw8N6ZQjo2l3hUutLeU63eQzMrQKC5n0lidC9cMPmw/MO3
         H07YQmx41qJhVmeSRV6CGrj9Hjc9G0t1yTuWdn2x9L+fl7GXBeBOs0ncqWfOWVDtXHEj
         bmZcLMaa5ehWOIdpWWBzkP6m1JOlFJRYTRgHQX1LeFFqQVnglEc19t95ciYWu56WP3zK
         BITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TG0Z0AhadiSMh7o20DfWQUt9Vgnpq7gs6IKlK0681qE=;
        b=ca3droDWkZZrZ7DdKqSciwoLEQ01mOr3Pf8a4YyZfuAKuVnD8hWW5z8LwaUivb9EVS
         HksIX0qRsqex1ERgB2/QKhN71D5QIIotzVEn7j5ZiBSwMMHEM9k0KoZug6y8r9XyIxJW
         SDSmdXVndiVdZqE5PzdbM4cpr6szVynWTDECX1E94hNArwyIPw5rZyyDy/eoJb+JlaZs
         8CeHuo0NZkGrM3yIbJ3k2lkljRxaZumCgSSthWghTVcgXWOVXeT8VyDANbkpajaKg7E5
         Ex5Dju/jQQ5BUD8U6UfS2qWKeD2KyWrwbkPTFtkWrirs6Z0k3VGwjOnPIM7Zwd8QLHlW
         NU9A==
X-Gm-Message-State: AOAM533gf/kAG/rglj2biLUwtdv+8IBb1lKm5YBjeYd9QjEBZVNGsx//
        KpG+cu1fZQAGYmMaTKD1GlVKhTzuMzzh8iRm8oo=
X-Google-Smtp-Source: ABdhPJx6j2mhNEqgFY1UJ7eBcL4De0oePWw/BkQL8T9lgsbkkAwq4IhSbaqnalL1Ul5rfEs5BOjuFvYp/I5N3Q/fVng=
X-Received: by 2002:a6b:3119:: with SMTP id j25mr8266290ioa.64.1622915470652;
 Sat, 05 Jun 2021 10:51:10 -0700 (PDT)
MIME-Version: 1.0
References: <1461.1622909071@jrobl>
In-Reply-To: <1461.1622909071@jrobl>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 5 Jun 2021 20:50:59 +0300
Message-ID: <CAOQ4uxhkDBgC1Sa87vt=DV6mfCoZR-8X5Oc1iqHD6_vVfjv_Ug@mail.gmail.com>
Subject: Re: fanotify: FAN_OPEN_EXEC_PERM stops invoking the commands
To:     "J. R. Okajima" <hooanon05g@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 5, 2021 at 7:04 PM J. R. Okajima <hooanon05g@gmail.com> wrote:
>
> Hello,
>
> fanotify has a neat feature called "perm event" which makes the listener
> process can allow/deny the access to a file by another process.
> But it doesn't work well if
> - FAN_OPEN_EXEC_PERM event is monitored
> - the other process's executable is monitored by the listener process
>
> The scenario is like this.
> - fanotify_init(O_RDWR)

Did you mean:
- fanotify_init(FAN_CLASS_CONTENT, O_RDWR) ?
I think you want:
- fanotify_init(FAN_CLASS_CONTENT, O_RDONLY)

> - fanotify_mark(FAN_OPEN_EXEC_PERM, "/dirA")
> - read() the event via fanotify_fd. it blocks.
> and run "/dirA/a.out" executable on another terminal.
>
> Then
> - FAN_OPEN_EXEC_PERM event is enqueued
> - the listener process tries reading the event
> - fanotify tries preparing FD by opening the executable. the flag to
>   open is the one given to fanotify_init(). it is O_RDWR here.
> - we cannot open the running executable with O_RDWR flag.
> - fanotify forces FAN_DENY as a response to the perm event.
> - the listener read() gets ETXTBSY from fanotify.
>
> As a result,
> - the listener process cannot get the perm event, and cannot write
>   the response FAN_ALLOW either.
> - a.out process fails to start (EPERM) because fanotify sets FAN_DENY.
>
> In other words, fanotify stops invoking a.out even if the listener
> process wants to allow it.
> That is bad.
>
> My question is,
> Why do we need to reuse full fsnotify_group->fanotify_data.f_flags when
> opening the executable?  I can understand people may want to set
> O_NONBLOCK or O_CLOEXEC flags.  But how about RW flags?  Isn't it good
> enough to force opening fanotify_event_metadata.fd with O_RDONLY?
> Passing O_RDWR to fanotify_init() should be kept in order to make
> fanotify_fd writable.
>

fanotify_fd is writable regardless of the argument event_f_flags of
fanotify_init(). See fanotify_init(2) man page and example in fanotify(7).

Thanks,
Amir.
