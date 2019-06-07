Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1517739332
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 19:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731416AbfFGR3k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 13:29:40 -0400
Received: from mail-yb1-f178.google.com ([209.85.219.178]:36450 "EHLO
        mail-yb1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729550AbfFGR3k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 13:29:40 -0400
Received: by mail-yb1-f178.google.com with SMTP id y2so1073170ybo.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Jun 2019 10:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XxlVCeRgEIaUT8M+VwFtPChqEnieudHDwKBNflzAwnE=;
        b=OqibJKHgGJKVpF0nAPZToy3ZpWM9rOGhlJ/FaMiug3AEgLGIJ28UBppQV9BQYinPup
         YgcMcd0hKKBZOYcMPuAFbZUFx6ksi8KNULp6FOFmsmegvjS8BaetQHAsBXmXtN+AvnA6
         KDDAJro5/Ml+HTs8bTaKJiLVtENmtd29moBwmjCgHLTWmqG+puiPMey4N4NkMr2EIDl1
         vn9VQPZZBicKN7EdLLwyY3h+MTPJrO/oPbPDdGIfn9+6HdKONT7ByKawgdPENWNB32Ps
         NtrPF8zShQkBvhwt7qMvp9i9dVZ3Qpu+jLOKOLv1cr3sdwI1gK+0T2WrYzX2FXjcv23P
         QGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XxlVCeRgEIaUT8M+VwFtPChqEnieudHDwKBNflzAwnE=;
        b=gcfRQo3URPcpNeJYZnuujwvHd8qR09+z3eJObFOzaQ/tND4O+XCK0niKBCY56lrt3Z
         UIc6YrskLd1OILb97YoTquRnxJUw+2lyAnOjVUakuM6MRBNjVqTCDxSo5lN7xH1Euyip
         uw81v8yyLN/SCBOOPcaeWQm49bLuePY1Rruledox4s3XHg3Yb6UoHF94uOcOiBjtnFLr
         PLPQGOetkGOUYliEb7WtqZ8VYlsgLQgq71foKMCgJqxoQ0AsX0TzLRF/KJV0b++17/il
         4vYvimzcJGfAX50cEDkNtOPlMayLzIH6yY3wLy7v5Ag70lgf0oQ6iP/pWnOOUzBaYoJw
         4Tjw==
X-Gm-Message-State: APjAAAWb8Dp0v8Jm1+TOlC8Ue6jUf7TVKLcLfjyw+/rwF5VImYO0ztmz
        o3z8Vdnl3hKbfQtBl9RHmamKDUQ30JalloQXFIw=
X-Google-Smtp-Source: APXvYqyXz6wRpfRUc/tB/YeTIbAq7A0YCjEZM8112aXomn1MQG7pp6cIMLmYQu2J6gqQyrLuZF6bpGGPDMcSWj/L6Ic=
X-Received: by 2002:a25:8109:: with SMTP id o9mr23721032ybk.132.1559928579272;
 Fri, 07 Jun 2019 10:29:39 -0700 (PDT)
MIME-Version: 1.0
References: <87zhmt7bhc.fsf@drapion.f-secure.com>
In-Reply-To: <87zhmt7bhc.fsf@drapion.f-secure.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 7 Jun 2019 20:29:27 +0300
Message-ID: <CAOQ4uxjP4kxE6-+UrbHWJ7OWUibixNhTwGWUfdJydYSnRhaxGA@mail.gmail.com>
Subject: Re: fanotify and pidfd?
To:     Marko Rauhamaa <marko.rauhamaa@f-secure.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 7, 2019 at 5:31 PM Marko Rauhamaa
<marko.rauhamaa@f-secure.com> wrote:
>
>
> As it stands, fanotify reports the process ID of the file that is being
> operated on:
>
>            struct fanotify_event_metadata {
>                __u32 event_len;
>                __u8 vers;
>                __u8 reserved;
>                __u16 metadata_len;
>                __aligned_u64 mask;
>                __s32 fd;
>                __s32 pid;
>            };
>
> One nasty problem with this is that the process often is long gone by
> the time the notification arrives.
>
> Would it be possible to amend this format with:
>
>                __s32 pidfd;
>

It's possible to report pidfd instead of pid with user opt-in
(i.e. FAN_REPORT_PIDFD)

If you want to implement this, follow the footsteps of code, test and
man page for FAN_REPORT_TID.

> It would hold the pid still for the duration of notification processing
> and allow for the fanotify monitor to safely use the pid field to
> inspect /proc/<pid>.
>

It will hold pid until someone closes pidfd.
That also needs to be documented.

> And the possibility of sending signals to the monitored process might
> come in handy as well.
>
> Thinking about this a bit more, could the fd field take on the dual role
> of allowing you to read the file in question as well as acting as a
> pidfd?
>

Please no.

Thanks,
Amir.
