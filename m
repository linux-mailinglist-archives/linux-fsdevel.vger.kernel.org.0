Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4004F158230
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2020 19:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgBJSXh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 13:23:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:46780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726896AbgBJSXh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 13:23:37 -0500
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2115D21739
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2020 18:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581359017;
        bh=t3Wks9ek7HdZAz6PJfkKNyateIsqhC1vSgHRd0AbOp8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iiK85FFk1llSss7Y+WKoCQhsXOljBpzzUvKnMT33O/2Qb4MLgmoMZsRb/ugOpUOYA
         maNfzqkY1lGCPD+4umyoaW2df4LcCztXq2pR9ffElISHzDdNZQQxIkNB+SStreUyHy
         kWIfoQZJbKDHzCBnaTfwpRYalPutSU3oG+LzdppA=
Received: by mail-wm1-f44.google.com with SMTP id g1so284537wmh.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2020 10:23:37 -0800 (PST)
X-Gm-Message-State: APjAAAWMAJIIrIebSLPQW5CJTmekkZQcq8zflpja+Gi/HZtl7djpZYVF
        Pd20p6hngBdFxl1fH/inviJFvy9fAXbo8NpvBprcbw==
X-Google-Smtp-Source: APXvYqyvQmNAMgah8c6tQsJZ+XZQiG6GIX/jTddr8+dPCUtkW0/ytdNqMktRK7dZRNI8z6/OdYPguTtbJfJo4KyutMo=
X-Received: by 2002:a7b:cbcf:: with SMTP id n15mr262021wmi.21.1581359015424;
 Mon, 10 Feb 2020 10:23:35 -0800 (PST)
MIME-Version: 1.0
References: <20200210150519.538333-1-gladkov.alexey@gmail.com> <20200210150519.538333-4-gladkov.alexey@gmail.com>
In-Reply-To: <20200210150519.538333-4-gladkov.alexey@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 10 Feb 2020 10:23:23 -0800
X-Gmail-Original-Message-ID: <CALCETrWGpRr86tVKJU-sEMcg+x0Yzp+TbiBhrAc71RaO8=DYGQ@mail.gmail.com>
Message-ID: <CALCETrWGpRr86tVKJU-sEMcg+x0Yzp+TbiBhrAc71RaO8=DYGQ@mail.gmail.com>
Subject: Re: [PATCH v8 03/11] proc: move /proc/{self|thread-self} dentries to proc_fs_info
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Solar Designer <solar@openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 10, 2020 at 7:06 AM Alexey Gladkov <gladkov.alexey@gmail.com> wrote:
>
> This is a preparation patch that moves /proc/{self|thread-self} dentries
> to be stored inside procfs fs_info struct instead of making them per pid
> namespace. Since we want to support multiple procfs instances we need to
> make sure that these dentries are also per-superblock instead of
> per-pidns,

The changelog makes perfect sense so far...

> unmounting a private procfs won't clash with other procfs
> mounts.

This doesn't parse as part of the previous sentence.  I'm also not
convinced that this really involves unmounting per se.  Maybe just
delete these words.
