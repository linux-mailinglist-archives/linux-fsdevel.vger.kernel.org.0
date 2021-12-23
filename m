Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF5147E8A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 21:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350208AbhLWULu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 15:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbhLWULu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 15:11:50 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4423C061401
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Dec 2021 12:11:49 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id j21so25493967edt.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Dec 2021 12:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bUoKqKXav8GLeL8li3Vc/v8SEeuVLhpuAYYxjYZyCOs=;
        b=HBVjgu0AzE2cyS3rGvR4GkNmbepRCwIYU1YnXYIATUUKwMJ4CLwLln8sDgup/0C9V5
         wB8DGO1L1VZZtzRTC93vFJ/yD4p/E24ViKIkLiS7xnFaJM8EsBm+ypSvTf7HSJRqi5EN
         I1MlMHJoKIuQZBwvzanaLfgP1lA2YEfqjmyko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bUoKqKXav8GLeL8li3Vc/v8SEeuVLhpuAYYxjYZyCOs=;
        b=eUP1l0sNiL6WoHbzzGM+vxm0VsaGel/t6x+mk9GCM9wzxen7Y3Y7HgtONtJ5XSkD7E
         p6m9GYRT7woFnwczYC0doAmUCgdl2ZukdmCPcgAegiMkLMDBqL72CgC8yxHrB9UblF2t
         dcjKnlSm2f6vwhLa2E/97sDMOLZVJDy3cgVJNlr7nHwdWcMNRaw0sJ/pP0lpCjKhqyNN
         8SRTfJyN4is3vfRfX8F1bmufgUiYGCGNe7pawjQ20X7Cw7Dob5RjmSc2yLb5l7mKrNgt
         8Ztd4rkClCURkX2ulsKH31BhcqHXTh91XdI7u6org7zKHKGoWPhgBclckkcbnfkHDpIS
         6McA==
X-Gm-Message-State: AOAM530eAjjnZmuVjbE/5k0Wy3hqRtEbi+ujl+ajvG0vPlnoIAO2DJ83
        G2M+DCjPSdxzai2LIhtU/SHDWu+mLeJzKCQXBNo=
X-Google-Smtp-Source: ABdhPJysazXl9/+oYIKt+cmv32YmbWD0/l2Ubg2hUfcpuItTkgnfin/N7JhIB34UyKviug43lz7hIg==
X-Received: by 2002:a17:906:5603:: with SMTP id f3mr3102506ejq.272.1640290308084;
        Thu, 23 Dec 2021 12:11:48 -0800 (PST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id bx6sm2288183edb.78.2021.12.23.12.11.47
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Dec 2021 12:11:47 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id e5so3971239wmq.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Dec 2021 12:11:47 -0800 (PST)
X-Received: by 2002:a05:600c:4f13:: with SMTP id l19mr2912168wmq.152.1640290307233;
 Thu, 23 Dec 2021 12:11:47 -0800 (PST)
MIME-Version: 1.0
References: <20211223195658.2805049-1-shr@fb.com> <20211223195658.2805049-3-shr@fb.com>
In-Reply-To: <20211223195658.2805049-3-shr@fb.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Dec 2021 12:11:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjZ4YORKUBswiH5CZ5pukRju=k+Aby6pKwdgCbqXJP1Nw@mail.gmail.com>
Message-ID: <CAHk-=wjZ4YORKUBswiH5CZ5pukRju=k+Aby6pKwdgCbqXJP1Nw@mail.gmail.com>
Subject: Re: [PATCH v7 2/5] fs: split off setxattr_copy and do_setxattr
 function from setxattr
To:     Stefan Roesch <shr@fb.com>
Cc:     io-uring <io-uring@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 23, 2021 at 11:57 AM Stefan Roesch <shr@fb.com> wrote:
>
> +       /* Attribute name */
> +       char *kname;
> +       int kname_sz;

I still don't like this.

Clearly the "just embed the kname in the context" didn't work, but I
hate how this adds that "pointer and size", when the size really
should be part of the type.

The patch takes what used to be a fixed size, and turns it into
something we pass along as an argument - for no actual good reason.
The 'size' isn't even the size of the name, it's literally the size of
the allocation that has a fixed definition.

Can we perhaps do it another way, by just encoding the size in the
type itself - but keeping it as a pointer.

We have a fixed size for attribute names, so maybe we can do

        struct xattr_name {
                char name[XATTR_NAME_MAX + 1];
        };

and actually use that.

Because I don't see that kname_sz is ever validly anything else, and
ever has any actual value to be passed around?

Maybe some day we'd actually make that "xattr_name" structure also
have the actual length of the name in it, but that would still *not*
be the size of the allocation.

I think it's actively misleading to have "kname_sz' that isn't
actually the size of the name, but I also think it's stupid to have a
variable for what is a constant value.

             Linus
