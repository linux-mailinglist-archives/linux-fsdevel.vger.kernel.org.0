Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C00247BCB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 03:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbgHRBV2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 21:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgHRBV1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 21:21:27 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42840C061389
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2020 18:21:27 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id h19so19555009ljg.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2020 18:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H9GGIPZeeCr2buv5LskGV0KUkXunajXDJwMIsnUEH9E=;
        b=XB+4puoAJ7oLIcF7LzRl/MGchCEIBEGK143/RcJlKBa6gZV2vs2J0/WgoHfVuiYGzU
         yP8FrR6fRFu089/Ospd7PbbInczCklxVj6i0XRwtqWSI/I6DXT6hmzzEpnvoMEV80Id2
         N57VYh7HVcjr6EsHTAY/h831U5di5F/kheIj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H9GGIPZeeCr2buv5LskGV0KUkXunajXDJwMIsnUEH9E=;
        b=WE2BY1RlNg1OjCTtPFKXI1/23iIHgkVYbVZ+9e71Ln9sDCfsmC/D7uyn3AZNGv2MSn
         UYL7A/bDHRs2A2XYMKByDO5wv4BvbMyvV2kNPL35ETQDFxDKs139ymhV9LXhxt5YVzP6
         o2mUBtvmOeWxQ8PqQMf7jr8moiCwZ85A8MOYkh26VdrVb/zPDcOo0SE/jaJPJz0UxHaY
         qoN4ZGYmOC8atmpAXNZiPbHWfui9SYSqz1tMSf7D7R9s1SMWVsGQ8kayGEs+s/4PzGaG
         X+IZzO2Jnjm0XHpgNyNcp40ikRqtpbw8ioJZetfzj9BXfX58O+92dsb5/HhayfjPDQ34
         8ezw==
X-Gm-Message-State: AOAM533bX1JXjIrTXuyMK/oWv8371pGBE1wC6Bb6NCd7gBhz3yIgYRh+
        tKwokkxbNX/gV8Eu/zT6+gZB786kAKbvhQ==
X-Google-Smtp-Source: ABdhPJxgFETDnQS32C/DlwfHr+VdjCMPY1BDxXsw4/nwez9ZBTv6VEJqXx2S6LvnVfTNRd0mnM2g0Q==
X-Received: by 2002:a2e:320c:: with SMTP id y12mr8156784ljy.399.1597713685368;
        Mon, 17 Aug 2020 18:21:25 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id 10sm5441463ljn.22.2020.08.17.18.21.23
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 18:21:24 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id i19so9334914lfj.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2020 18:21:23 -0700 (PDT)
X-Received: by 2002:a05:6512:241:: with SMTP id b1mr8521728lfo.125.1597713683604;
 Mon, 17 Aug 2020 18:21:23 -0700 (PDT)
MIME-Version: 1.0
References: <87ft8l6ic3.fsf@x220.int.ebiederm.org> <20200817220425.9389-12-ebiederm@xmission.com>
 <CAHk-=whnocSU8muZvmCBoJNz8vYO53fi8S06cSYwdqh1WfDqig@mail.gmail.com> <87v9hg69ph.fsf@x220.int.ebiederm.org>
In-Reply-To: <87v9hg69ph.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Aug 2020 18:21:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj_Tg4TYz2_SPE=h+xjXKTDCTCRzg=1ERgh_6WOVTgz9w@mail.gmail.com>
Message-ID: <CAHk-=wj_Tg4TYz2_SPE=h+xjXKTDCTCRzg=1ERgh_6WOVTgz9w@mail.gmail.com>
Subject: Re: [PATCH 12/17] proc/fd: In fdinfo seq_show don't use get_files_struct
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "<linux-fsdevel@vger.kernel.org>" <linux-fsdevel@vger.kernel.org>,
        criu@openvz.org, bpf <bpf@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Jann Horn <jann@thejh.net>, Kees Cook <keescook@chromium.org>,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@debian.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Matthew Wilcox <matthew@wil.cx>,
        Trond Myklebust <trond.myklebust@fys.uio.no>,
        Chris Wright <chrisw@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 17, 2020 at 6:13 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> task_lock is needed to protect task->files.

Hah. Right you are. I found a few cases where we didn't do that, but I
hadn't noticed that they were all of the pattern

        struct task_struct *tsk = current;

so "tsk->files" was safe for that reason..

So never mind.

           Linus
