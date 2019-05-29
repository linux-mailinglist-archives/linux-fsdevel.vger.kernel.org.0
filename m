Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD4672DC36
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 13:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfE2LwU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 07:52:20 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35274 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfE2LwU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 07:52:20 -0400
Received: by mail-qk1-f196.google.com with SMTP id l128so1235315qke.2;
        Wed, 29 May 2019 04:52:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TdAznkRxrKE17L8clQuRvpoCe6A9H8ATfOCcLEenWWI=;
        b=s0778B/4PRJRV9CHP8Na6IFf77DRRrjYvnHi2Ijrigok937pUAnGjgZrBN0AJlbyQw
         ALs5JTxaeiWGsHVmFccnlIJca5vkxz9tVKMiv8aMDWkkjsmf1mFaYZDMe2OhGWE/H9NF
         4A+PdgvfmUPMxgumo6xz3+rGQsM4OOhsYg5ox9Ua1r9ftcR3Si2Jn+rceTEZILu1KBRG
         2pmR4YRHcGCdzmOGya6b0suS0e+hGVHP3PFngeaYW/HcwT+eXVKXZk9p/qHknpEI9R4u
         YNu/I+7Pme4clYwYpCiiujSoogHlaAwvbCMjivm+nc/285DrMguCE3ZVkIX2ykrIvVNN
         fNUA==
X-Gm-Message-State: APjAAAWaXxHw2poBQLbjUXCnIHjGt565pHQ+68cmOKh1ypgY3oFItZvz
        r9Mo+XsQ5YuVp7tEG70xNclGdRUmS8gaIal1YwE=
X-Google-Smtp-Source: APXvYqzg32MH5decqHjgAwz1/0NlrkGcjLsvjWutrE0FtLUETA9tge85aPqT4FbVImIWliuZ7t/XSkbxBIATrB3QgH4=
X-Received: by 2002:a37:bb85:: with SMTP id l127mr27927380qkf.285.1559130738893;
 Wed, 29 May 2019 04:52:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190524201817.16509-1-jannh@google.com> <20190525144304.e2b9475a18a1f78a964c5640@linux-foundation.org>
 <CAG48ez36xJ9UA8gWef3+1rHQwob5nb8WP3RqnbT8GEOV9Z38jA@mail.gmail.com> <aa7f66ad-dab5-f0b6-ade9-7d3698d509a9@westnet.com.au>
In-Reply-To: <aa7f66ad-dab5-f0b6-ade9-7d3698d509a9@westnet.com.au>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 29 May 2019 13:52:02 +0200
Message-ID: <CAK8P3a2wA4R-V-W1+pPTaqVP7Dr=170G2a76AzASpx1xtRWj0Q@mail.gmail.com>
Subject: Re: [PATCH] binfmt_flat: make load_flat_shared_library() work
To:     Greg Ungerer <gregungerer@westnet.com.au>
Cc:     Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 28, 2019 at 12:56 PM Greg Ungerer
<gregungerer@westnet.com.au> wrote:
> On 27/5/19 11:38 pm, Jann Horn wrote:
> > On Sat, May 25, 2019 at 11:43 PM Andrew Morton
> > <akpm@linux-foundation.org> wrote:
> >> On Fri, 24 May 2019 22:18:17 +0200 Jann Horn <jannh@google.com> wrote:
> >>> load_flat_shared_library() is broken: It only calls load_flat_file() if
> >>> prepare_binprm() returns zero, but prepare_binprm() returns the number of
> >>> bytes read - so this only happens if the file is empty.
> >>
> >>> Instead, call into load_flat_file() if the number of bytes read is
> >>> non-negative. (Even if the number of bytes is zero - in that case,
> >>> load_flat_file() will see nullbytes and return a nice -ENOEXEC.)
> >>>
> >>> In addition, remove the code related to bprm creds and stop using
> >>> prepare_binprm() - this code is loading a library, not a main executable,
> >>> and it only actually uses the members "buf", "file" and "filename" of the
> >>> linux_binprm struct. Instead, call kernel_read() directly.
> >>>
> >>> Cc: stable@vger.kernel.org
> >>> Fixes: 287980e49ffc ("remove lots of IS_ERR_VALUE abuses")
> >>> Signed-off-by: Jann Horn <jannh@google.com>
> >>> ---
> >>> I only found the bug by looking at the code, I have not verified its
> >>> existence at runtime.
> >>> Also, this patch is compile-tested only.
> >>> It would be nice if someone who works with nommu Linux could have a
> >>> look at this patch.
> >>
> >> 287980e49ffc was three years ago!  Has it really been broken for all
> >> that time?  If so, it seems a good source of freed disk space...
> >
> > Maybe... but I didn't want to rip it out without having one of the
> > maintainers confirm that this really isn't likely to be used anymore.
>
> I have not used shared libraries on m68k non-mmu setups for
> a very long time. At least 10 years I would think.
>
> Regards
> Greg
>
>
>
