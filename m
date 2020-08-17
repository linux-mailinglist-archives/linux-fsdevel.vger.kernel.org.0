Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C369247B47
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 01:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgHQXyz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 19:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgHQXyx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 19:54:53 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98333C061342
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2020 16:54:53 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id w14so19411845ljj.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2020 16:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zRD9fxr2dmL3cWS6/haxe+/7+RVNAwBfQJLvwFE/2BM=;
        b=GttK3xwVXIEnQDmtYMvF2IJlJWEatfccGGsHzVm20TPi9ekAoaV3TrMSE8QIJupeaU
         o5VYt+7CPeShna6icVTEVqf0cqW5xz6D3gxuRcD4PasdgxEfOrygjNQEgJGTOM8C+RQ7
         unaPe2LNmBbFRNpH7o6v91jPT9h97hM2C5bOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zRD9fxr2dmL3cWS6/haxe+/7+RVNAwBfQJLvwFE/2BM=;
        b=R8BGbAc9gnJ/LsM9Pj4xpg+/SPnY/tAt7v3qAGc7SUkWAjxH99xzwx6+vMZDzzSjVw
         +ccd/4V9z/ZDXnNQ38qhxyhnCyzXVnEb84VjPStHjPqd6hl6mUNlPiTwhCEFKFvYHmcy
         Gcj5yauyvH284np9B1VzgrO9ZcfwXQiN/3N0XjMlxf5Ad6X9LteNBnXQKAEh3IlFsqQW
         x3GegEILRMi/117URnXB61jSK2yPNM0+6ot+RMjb7F6cPmEnqcpKPv/gzb15w3Xw/Wf5
         8mHaVh9RsPjMxfd7139HFSpBLp9r/XMVV27lOhAyHFbQJNYR6a5vyaSoIZn1PGt512ho
         Xzmw==
X-Gm-Message-State: AOAM531RSepJ3fLieapi5o32ce6i21T8yCDRIV5sMx82Pst3OqPgEkfP
        4EasvFa3ln+MVUkoOPj+Y5j7Ofcs6iFUiw==
X-Google-Smtp-Source: ABdhPJx2BeEd0jmoKPtNaCCHtFXIY6qmbgDWL8LtAPjDXDA7LiGHfedX4p+64a/d2t6A8Vh9a689YQ==
X-Received: by 2002:a2e:9743:: with SMTP id f3mr8561945ljj.299.1597708491893;
        Mon, 17 Aug 2020 16:54:51 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id u5sm5887047lfr.3.2020.08.17.16.54.50
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 16:54:51 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id g6so19361797ljn.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2020 16:54:50 -0700 (PDT)
X-Received: by 2002:a2e:9a11:: with SMTP id o17mr7971652lji.314.1597708490610;
 Mon, 17 Aug 2020 16:54:50 -0700 (PDT)
MIME-Version: 1.0
References: <87ft8l6ic3.fsf@x220.int.ebiederm.org> <20200817220425.9389-9-ebiederm@xmission.com>
In-Reply-To: <20200817220425.9389-9-ebiederm@xmission.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Aug 2020 16:54:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=whCU_psWXHod0-WqXXKB4gKzgW9q=d_ZEFPNATr3kG=QQ@mail.gmail.com>
Message-ID: <CAHk-=whCU_psWXHod0-WqXXKB4gKzgW9q=d_ZEFPNATr3kG=QQ@mail.gmail.com>
Subject: Re: [PATCH 09/17] file: Implement fnext_task
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, criu@openvz.org,
        bpf <bpf@vger.kernel.org>,
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

I like the series, but I have to say that the extension of the
horrible "fcheck*()" interfaces raises my hackles..

That interface is very very questionable to begin with, and it's easy
to get wrong.

I don't see you getting it wrong - you do seem to hold the RCU read
lock in the places I checked, but it worries me.

I think my worry could be at least partially mitigated with more
comments and docs:

On Mon, Aug 17, 2020 at 3:10 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> +struct file *fnext_task(struct task_struct *task, unsigned int *ret_fd)

Please please *please* make it clear that because this does *not*
increment any reference counts, you have to be very very careful using
the "struct file" pointer this returns.

I really dislike the naming. The old "fcheck()" naming came from the
fact that at least one original user just mainly checked if the result
was NULL or not. And then others had to be careful to either hold the
file_lock spinlock, or at least the RCU read lock so that the result
didn't go away.

Here, you have "fnext_task()", and it doesn't even have that "check"
warning mark, or any comment about how dangerous it can be to use..

So the rule is that the "struct file" pointer this returns can only be
read under RCU, but the 'fd' it returns has a longer lifetime.

I think your uses are ok, and I think this is an improvement in
general, I just want a bigger "WARNING! Here be dragons!" sign (and
naming could be nicer).

            Linus
