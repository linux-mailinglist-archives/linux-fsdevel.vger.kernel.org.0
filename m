Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B20C449D2C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 20:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244561AbiAZTvO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 14:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244569AbiAZTvI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 14:51:08 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580EAC06173B
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jan 2022 11:51:08 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id u14so935609lfo.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jan 2022 11:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zuNchwIZAGymNJC1SQWN7Ldl6BhEKsuYVz79xP7hsik=;
        b=O8OLscWgdo8HIVwwfzb5dza2dJnXOZndHiDf93M0yfSU4tRodlztvMJGdacXImWFvT
         A4bYsx1Mbprxlx5fVLCI461Tn/UrA6CYFDOhYredwv63xNGXFUShGpNuzDAOw5ahH/wy
         fku0dNyYzo7gA9deEfIX9Ymwmf9QKMCC+oudZWHsLMyD1zQulwYSPfLrvVR5/6dhtLMv
         i8Rpx83onnbgfc/fJMHs6Eo3x2Az2PeOWwaGFbSZDbJrXy7zvLbHFcwkKlszP4w5ibDU
         SdzVZ4DBXl12xuVCuvS3fMEjBBVETtA+hOE3GdrcD8ofv5KDpVKOl0uPkj5L+7ETEBsq
         8PvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zuNchwIZAGymNJC1SQWN7Ldl6BhEKsuYVz79xP7hsik=;
        b=8MtfINWFRB90E+jGy1M1KkW+c/ECW1f9pEUwM4bV28uah5ceddnAqKffucfB0e8jMB
         99jju6l13cTwQ+tVsWOkiOwGYFxP4woFNh9rhES1z0EJmBWz+dZ6e8RYB77gKTr9RWOd
         0O7EhplpJzgnOlPzwMzUrG5Hj3WwGa1QJ5/NkO22tH3z0XQf624Wi68LqZmoQq2IBJL1
         XDxkxX1ua0ND5wt8Wo9VsBeb0xZlH9CIBAea5LJ+pugPxm2mtxsI28joq/MuTi4Zvzi3
         Cieq1RoEj9K6cenUKxKRYpKszQL99iDBiyIX9sMsbCIYooLWcNMiRYJD6Tf9CZdZ8n8E
         auJQ==
X-Gm-Message-State: AOAM531/gFghng5n4Fx7tefoS0PzkMY058aW9jn2HAIFnhbpntWSD4vi
        1idAPM4NrJokFAHZ0ZNStLiTkgYG0UnxneJV69bPsg+RcE4=
X-Google-Smtp-Source: ABdhPJyF5hb3Or3tNa1mRtH02IzvJBYrARKvzKe6UO+oIpe5xZpket39De33nXm3uzERNauernfMMMz2FTRtxCHRJ/I=
X-Received: by 2002:a19:ee13:: with SMTP id g19mr384157lfb.288.1643226666411;
 Wed, 26 Jan 2022 11:51:06 -0800 (PST)
MIME-Version: 1.0
References: <20220126175747.3270945-1-keescook@chromium.org>
 <CAG48ez3hN8+zNCmLVP0yU0A5op6BAS+A-rs05aiLm4RQvzzBpg@mail.gmail.com> <a89bb47f-677f-4ce7-fd-d3893fe0abbd@dereferenced.org>
In-Reply-To: <a89bb47f-677f-4ce7-fd-d3893fe0abbd@dereferenced.org>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 26 Jan 2022 20:50:39 +0100
Message-ID: <CAG48ez3iEUDbM03axYSjWOSW+zt-khgzf8CfX1DHmf_6QZap6Q@mail.gmail.com>
Subject: Re: [PATCH] fs/binfmt_elf: Add padding NULL when argc == 0
To:     Ariadne Conill <ariadne@dereferenced.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        Rich Felker <dalias@libc.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 26, 2022 at 7:42 PM Ariadne Conill <ariadne@dereferenced.org> wrote:
> On Wed, 26 Jan 2022, Jann Horn wrote:
> > On Wed, Jan 26, 2022 at 6:58 PM Kees Cook <keescook@chromium.org> wrote:
> >> Quoting Ariadne Conill:
> >>
> >> "In several other operating systems, it is a hard requirement that the
> >> first argument to execve(2) be the name of a program, thus prohibiting
> >> a scenario where argc < 1. POSIX 2017 also recommends this behaviour,
> >> but it is not an explicit requirement[1]:
> >>
> >>     The argument arg0 should point to a filename string that is
> >>     associated with the process being started by one of the exec
> >>     functions.
> >> ...
> >> Interestingly, Michael Kerrisk opened an issue about this in 2008[2],
> >> but there was no consensus to support fixing this issue then.
> >> Hopefully now that CVE-2021-4034 shows practical exploitative use[3]
> >> of this bug in a shellcode, we can reconsider."
> >>
> >> An examination of existing[4] users of execve(..., NULL, NULL) shows
> >> mostly test code, or example rootkit code. While rejecting a NULL argv
> >> would be preferred, it looks like the main cause of userspace confusion
> >> is an assumption that argc >= 1, and buggy programs may skip argv[0]
> >> when iterating. To protect against userspace bugs of this nature, insert
> >> an extra NULL pointer in argv when argc == 0, so that argv[1] != envp[0].
> >>
> >> Note that this is only done in the argc == 0 case because some userspace
> >> programs expect to find envp at exactly argv[argc]. The overlap of these
> >> two misguided assumptions is believed to be zero.
> >
> > Will this result in the executed program being told that argc==0 but
> > having an extra NULL pointer on the stack?
> > If so, I believe this breaks the x86-64 ABI documented at
> > https://refspecs.linuxbase.org/elf/x86_64-abi-0.99.pdf - page 29,
> > figure 3.9 describes the layout of the initial process stack.
>
> I'm presently compiling a kernel with the patch to see if it works or not.
>
> > Actually, does this even work? Can a program still properly access its
> > environment variables when invoked with argc==0 with this patch
> > applied? AFAIU the way userspace locates envv on x86-64 is by
> > calculating 8*(argc+1)?
>
> In the other thread, it was suggested that perhaps we should set up an
> argv of {"", NULL}.  In that case, it seems like it would be safe to claim
> argc == 1.
>
> What do you think?

Sounds good to me, since that's something that could also happen
normally if userspace calls execve(..., {"", NULL}, ...).

(I'd like it even better if we could just bail out with an error code,
but I guess the risk of breakage might be too high with that
approach?)
