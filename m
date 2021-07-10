Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F363C3612
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jul 2021 20:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhGJSYl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Jul 2021 14:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhGJSYk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Jul 2021 14:24:40 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085E4C0613E5
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Jul 2021 11:21:54 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id q18so31095191lfc.7
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Jul 2021 11:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GFrC9GbYw2pfY1GNYl1j9fooO83KwnRoXAsiXo6YHdM=;
        b=CET5A4Gg6UTWVQrmn0T1UFde0+VITgRXMOtF+pC+mv+1LrV+kNA9wWC2viZ4co6z2Z
         GupTQr1pqFZgkylinpa4Eok8C1K+DAV+94Fj6fnpvqnGTSTbh7ZezFnFOIF3AiM7BxV0
         3fi9D3iRZsJsnmsgjMjAz2eGZj55J4f0Av5j4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GFrC9GbYw2pfY1GNYl1j9fooO83KwnRoXAsiXo6YHdM=;
        b=rUT+9LAWAgPidIype1ZCrSdRYxcbOmxF8+QtCH11ECQfiBKnT7eZnmWFc/ux/LArb8
         p3gnc0JC6R7QumxDJ361noe1pvc3Hrx5v9hjdF2dBXzlvakGprsQpL6Qd53nZ6CFZY4W
         afVgTbvkFUBSjGZbIPWdMCtMpMIoAFPKta13BNuGHg2LXYF/zi3fT5y/jzg3V+c7Cevj
         2Ok5uf5E0pS5UdPrkg/jM5dhDUcNnRZtvRGroCWOcqPoZj7Qxjezn6JesdSoHVwZHnTk
         s1o/KJj8VzOxj3pV2XfLAyZTx/iAONHDfCEIjRZ2WPndkk99UdJ64feowMCwqx2/qNSL
         HqKw==
X-Gm-Message-State: AOAM533wNefAFPVyqAg0T4+VVqxjyBxamKO5oILm3FuP4wv/OmQ/NRN1
        ne5IaHLLKnuDqUCXVfafiwdKc/c1bKDamDeh
X-Google-Smtp-Source: ABdhPJwR7fLsBUbBpVQO2oX1KCgfxDvqjZJy0aJVAomrw/sEkFVIs/IPmZWLby9dWqntC+GGeUkQ4A==
X-Received: by 2002:a19:4907:: with SMTP id w7mr33639002lfa.136.1625941311875;
        Sat, 10 Jul 2021 11:21:51 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id q20sm535475lfu.168.2021.07.10.11.21.50
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jul 2021 11:21:50 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id f30so31105697lfj.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Jul 2021 11:21:50 -0700 (PDT)
X-Received: by 2002:ac2:4475:: with SMTP id y21mr5344683lfl.487.1625941310223;
 Sat, 10 Jul 2021 11:21:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210708155647.44208-1-kaleshsingh@google.com>
In-Reply-To: <20210708155647.44208-1-kaleshsingh@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 10 Jul 2021 11:21:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=whDkekE8n2LdPiKHeTdRnV--ys0V0nPZ76oPaE0fn-d+g@mail.gmail.com>
Message-ID: <CAHk-=whDkekE8n2LdPiKHeTdRnV--ys0V0nPZ76oPaE0fn-d+g@mail.gmail.com>
Subject: Re: [PATCH] procfs: Prevent unpriveleged processes accessing fdinfo
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Android Kernel Team <kernel-team@android.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 8, 2021 at 8:57 AM Kalesh Singh <kaleshsingh@google.com> wrote:
>
> The file permissions on the fdinfo dir from were changed from
> S_IRUSR|S_IXUSR to S_IRUGO|S_IXUGO, and a PTRACE_MODE_READ check was
> added for opening the fdinfo files [1]. However, the ptrace permission
> check was not added to the directory, allowing anyone to get the open FD
> numbers by reading the fdinfo directory.
>
> Add the missing ptrace permission check for opening the fdinfo directory.

The more I look at this, the more I feel like we should look at
instead changing how "get_proc_task()" works.

That's one of the core functions for /proc, and I wonder if we
couldn't just make it refuse to look up a task that has gone through a
suid execve() since the proc inode was opened.

I don't think it's basically ever ok to open something for one thread,
and then use it after the thread has gone through a suid thing.

In fact, I wonder if we could make it even stricter, and go "any exec
at all", but I think a suid exec might be the minimum we should do.

Then the logic really becomes very simple: we did the permission
checks at open time (like UNIX permission checks should be done), and
"get_proc_task()" basically verifies that "yeah, that open-time
decision is still valid".

Wouldn't that make a lot of sense?

             Linus
