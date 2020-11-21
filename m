Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4538A2BBAB5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 01:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbgKUAMa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 19:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbgKUAM3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 19:12:29 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6E3C0613CF
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2020 16:12:28 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id p12so11837658ljc.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2020 16:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Aw1h99jPDQe/6TOVAJhjAG6iMelLYm16MqfYmIDPDPI=;
        b=VLPDB9MROoKGlTf965IdLvuhLwy9WbOxPtEyf2fG8/dob+NNDhYJ69CthAiNd+OdUf
         341GaBNiZU7VT+POpLUxn8HDlaAj54iiak5VnRd2ErQU+tHYUwpawQmii7qM4xYhdKyG
         27eJ/F+WI/+k5LJSDqYYhKlmCoPS0P2g9HIZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Aw1h99jPDQe/6TOVAJhjAG6iMelLYm16MqfYmIDPDPI=;
        b=itfzwY+R7NvukwHfDvUCKwlqs+UiQym62elAntvGDC+B47bWRKQ/Z0eI80rl0cu4q1
         ixGBnIANFT3DH/RGXOhz4KRdEtUNavTMCJ3vbNbQwrL8DWpDejPznVIILBXBEKFE7wPt
         c6tKvlfCtM9k/IY0iuBeFJHWlVaglXbgCnchuqkI3MFsvDpy6RveykNSYLfHgwHBg9Hv
         iJEVe1X1qAXm3SVwm5/tNk6nbuONsc9fmXt0KGTFkjS91OnfGUqYBwJ5rNPCBihUfRT9
         BHUhSZZe9l72wvnQvfqJadSpGsogzjadFVaUqL1r4yPtJPSY3mf7JwJQg6FbqlDTuL0A
         kalw==
X-Gm-Message-State: AOAM531NcLc1CA/2cnQ8g+4/E5bnPWjSUQ/bIRw26VJ3CE0dQQcGUApX
        UGSM2qqoYe768RqTPMHg7PSFXA8E/p48Lw==
X-Google-Smtp-Source: ABdhPJx5Hw3E8GKNpEL/9AaVKV1yorzc0s7sER1S6eZR5XrB2Mn5tBXjhainJ51o2zCmjzr+SqJoOQ==
X-Received: by 2002:a2e:9614:: with SMTP id v20mr9369370ljh.13.1605917547026;
        Fri, 20 Nov 2020 16:12:27 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id i7sm504950lfi.269.2020.11.20.16.12.26
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2020 16:12:26 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id 11so11866194ljf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2020 16:12:26 -0800 (PST)
X-Received: by 2002:a19:ae06:: with SMTP id f6mr9766930lfc.133.1605917163430;
 Fri, 20 Nov 2020 16:06:03 -0800 (PST)
MIME-Version: 1.0
References: <87r1on1v62.fsf@x220.int.ebiederm.org>
In-Reply-To: <87r1on1v62.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 20 Nov 2020 16:05:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wge0oJ3fbmNfVek101CO7hg1UfUHnBgxLB3Jmq6-hWLug@mail.gmail.com>
Message-ID: <CAHk-=wge0oJ3fbmNfVek101CO7hg1UfUHnBgxLB3Jmq6-hWLug@mail.gmail.com>
Subject: Re: [PATCH v2 00/24] exec: Move unshare_files and guarantee
 files_struct.count is correct
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

On Fri, Nov 20, 2020 at 3:11 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> This set of changes cleanups of the code in exec so hopefully this code
> will not regress again.  Then it adds helpers and fixes the users of
> files_struct so the reference count is only incremented if COPY_FILES is
> passed to clone (or if io_uring takes a reference).  Then it removes
> helpers (get_files_struct, __install_fd, __alloc_fd, __close_fd) that
> are no longer needed and if used would encourage code that increments
> the count of files_struct somewhere besides in clone when COPY_FILES is
> passed.

I'm not seeing anything that triggered me going "that looks dodgy". It
all looks like nice cleanups.

But that's just from reading the patches (and in some cases going and
looking at the context), so I didn't actually _test_ any of it. It all
looks sane to me, though, and the fact that it removes a fair number
of lines of code is always a good sign.

It would be good for people to review and test (Al? Oleg? others?),
but my gut feel is "this is good".

             Linus
