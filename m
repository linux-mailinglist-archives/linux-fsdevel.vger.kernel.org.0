Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A329F24805C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 10:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgHRISZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Aug 2020 04:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgHRISW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Aug 2020 04:18:22 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3F1C061389
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2020 01:18:21 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id d2so9775405lfj.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2020 01:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ldPLk00zDl2npSmv8Uf+w008g6jg8ITcXg6uW8fPbI=;
        b=eqS+9xjC9jrTPy363gkpZ79QjRN6vwbFjXLWnrbmOtoQbECfwf8F3MmNNWLOcGXLsj
         lD8wFsXw7H0WFpfmvhD3Y/1WbazKHmesFqPISyLz0ng3WqcJkAoAFslskN26G18JkPL9
         MBhIc9KTitsEhfzTiiEcYUBJYgyu4pB9nemZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ldPLk00zDl2npSmv8Uf+w008g6jg8ITcXg6uW8fPbI=;
        b=t1lKMdGx9uK+KfMR77VkmYypWUvmYIOzt/tAIMGtlgOQnX7thvfsLmzSnYeCjCZ5AQ
         Ot3jX9qQqCyjG33d9ERWskSDVjzjj08w9uXICtYibjM1oQXw4hYpep48TequV2mDdNiY
         bbDIRHixm2mWrJ1bP5MOR970IFYZuD6omkySNl7hRyq74vruTo7jhHj4T0bOraiKd5wE
         q/ZtbiyFnnW5KLa1oFIrPyHecgEPWsmrWUL0QNiHGHFPL5O8D3wUAV/tn42n8pQpSeKM
         HBpOj/yWkJSa/0WQnuPD4+x6+Wac3cLxyj1yzwtVYYOcaFabB8OHhEBimB1ce0okH3dz
         4nRw==
X-Gm-Message-State: AOAM532HdnkoRIAfFf2pmc6OHKTfbPBRRJPFZp1+rR535o5i8H7CiEJD
        E9VCBEI2BHiF36u3hWBcCuMAbVazPOVZNQ==
X-Google-Smtp-Source: ABdhPJzAJcomy8EYphrxVCedjF0K5bO4SGPEY3Z6PPEU0PEsUfLRs6jkOy5dcqkDOjSs5gTUet0JiQ==
X-Received: by 2002:ac2:4d4f:: with SMTP id 15mr9164728lfp.163.1597738699843;
        Tue, 18 Aug 2020 01:18:19 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id d20sm6253152lfn.85.2020.08.18.01.18.18
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 01:18:18 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id f26so20441173ljc.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2020 01:18:18 -0700 (PDT)
X-Received: by 2002:a2e:545:: with SMTP id 66mr9791504ljf.285.1597738698039;
 Tue, 18 Aug 2020 01:18:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200818061239.29091-1-jannh@google.com> <20200818061239.29091-5-jannh@google.com>
In-Reply-To: <20200818061239.29091-5-jannh@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 18 Aug 2020 01:18:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiOqR-4jXpPe-5PBKSCwQQFDaiJwkJr6ULwhcN8DJoG0A@mail.gmail.com>
Message-ID: <CAHk-=wiOqR-4jXpPe-5PBKSCwQQFDaiJwkJr6ULwhcN8DJoG0A@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] binfmt_elf, binfmt_elf_fdpic: Use a VMA list snapshot
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 17, 2020 at 11:13 PM Jann Horn <jannh@google.com> wrote:
>
>         /*
>          * If this looks like the beginning of a DSO or executable mapping,
> +        * we'll check for an ELF header. If we find one, we'll dump the first
> +        * page to aid in determining what was mapped here.
> +        * However, we shouldn't sleep on userspace reads while holding the
> +        * mmap_lock, so we just return a placeholder for now that will be fixed
> +        * up later in vma_dump_size_fixup().

I still don't like this.

And I still don't think it's necessary.

The whole - and only - point of "check if it's an ELF header" is that
we don't want to dump data that could just be found by looking at the
original binary.

But by the time we get to this point, we already know that

 (a) it's a private mapping with file backing, and it's the first page
of the file

 (b) it has never been written to and it's mapped for reading

and the choice at this point is "don't dump at all", or "dump just the
first page".

And honestly, that whole "check if it has the ELF header" signature
was always just a heuristic. Nothing should depend on it anyway.

We already skip dumping file data under a lot of other circumstances
(and perhaps equally importantly, we already decided to dump it all
under other circumstances).

I think this DUMP_SIZE_MAYBE_ELFHDR_PLACEHOLDER hackery is worse than
just changing the heuristic.

So instead, just say "ok, if the file was executable, let's dump the
first page".

The test might be as simple as jjust checking

       if (file_inode(vma->vm_file)->i_mode & 0111)

and you'd be done. That's likely a _better_ heuristic than the "let's
go look at the random first word in memory".

Your patches look otherwise fine, but I really really despise that
DUMP_SIZE_MAYBE_ELFHDR_PLACEHOLDER, and I don't think it's even
necessary.

             Linus
