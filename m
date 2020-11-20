Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC4D2BBA83
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 01:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbgKUAGN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 19:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgKUAGN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 19:06:13 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97204C0613CF
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2020 16:06:12 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id r17so11853901ljg.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2020 16:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XGbTCIuZOTjImDuECPHgPztM+ob1Jh/w4JCSuaWysl8=;
        b=F7GS0CnZoLQZsd60ze5qvCDpXMSLI40/SpzvFW2rlnL2ZGQsu9FP2VdHFJJcXSc/Mx
         ywQViQeQUDiVRYnXhOndM5IYUrsZOLGAJjBoQXUcy4dOA6BiQjBOf3l0N81v74uaIp5Q
         /AlhPw10MHseYMV2hIMrFXL3A+9XwPIxX2AA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XGbTCIuZOTjImDuECPHgPztM+ob1Jh/w4JCSuaWysl8=;
        b=Fhd6FIyregq1KrU5PvyyJODA6Y4j+7edrIClzYt24GCCshqrPhJyEKtKry/ngbwLJi
         +NCvN8SpncRhx4nI4AtLNEKcT1ZhVC36rNJ+SFdDEY3ekNBEn+/gDt12jEZXmIuI++WR
         M6o1t/SfXJOHJC9z2AvGEeeJ5p6/roUaiGFI214PD8EjxoQOn2L8ozzRu5JKOIXfxssm
         oWyJPxrvetHZidOlOOhHNqh8cZjO8RVYrE54t27bSwUiWPbT5Khu/W6DpNKusx66aK95
         euJt0jhajEjTOhuJYYEse616Vtx2NWfW8xuFmJgTAYvzhg6T66SLTUlTT41I3rxy0XJ5
         O0sw==
X-Gm-Message-State: AOAM532Iili6RF6WEejahqe/kh58oDHwG/ElWmJA3bm93M7ylo2vb8SQ
        SGBulPmTQzIxNRFfu1uZwu3s6Itk5oz+Mw==
X-Google-Smtp-Source: ABdhPJzJ16qpoLfpBnBcHfctyLUhR9NahG7XAQ/5z7j5IpayBf15KZaCMZszs/UqEClEmj/nSg2Xpw==
X-Received: by 2002:a2e:3204:: with SMTP id y4mr8455254ljy.342.1605917170605;
        Fri, 20 Nov 2020 16:06:10 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id q4sm434026ljh.38.2020.11.20.16.06.10
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2020 16:06:10 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id u18so15860590lfd.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2020 16:06:10 -0800 (PST)
X-Received: by 2002:a05:651c:2cb:: with SMTP id f11mr8560585ljo.371.1605916752808;
 Fri, 20 Nov 2020 15:59:12 -0800 (PST)
MIME-Version: 1.0
References: <87r1on1v62.fsf@x220.int.ebiederm.org> <20201120231441.29911-1-ebiederm@xmission.com>
In-Reply-To: <20201120231441.29911-1-ebiederm@xmission.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 20 Nov 2020 15:58:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh9YvRgb2TsBaJnRM3eARaUp1U-_H-5yMVmSHifC6b-QQ@mail.gmail.com>
Message-ID: <CAHk-=wh9YvRgb2TsBaJnRM3eARaUp1U-_H-5yMVmSHifC6b-QQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/24] exec: Move unshare_files to fix posix file
 locking during exec
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, criu@openvz.org,
        bpf <bpf@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Jann Horn <jann@thejh.net>, Kees Cook <keescook@chromium.org>,
        =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chris Wright <chrisw@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 20, 2020 at 3:16 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> @@ -1257,6 +1258,13 @@ int begin_new_exec(struct linux_binprm * bprm)
>         if (retval)
>                 goto out;
>
> +       /* Ensure the files table is not shared. */
> +       retval = unshare_files(&displaced);
> +       if (retval)
> +               goto out;
> +       if (displaced)
> +               put_files_struct(displaced);

It's not obvious from the patch (not enough context), but the new
placement seems to make much more sense - and it's where we do the
de-thread and switch the vm and signals too.

So this does seem to be the much more logical place.

Ack.

      Linus
