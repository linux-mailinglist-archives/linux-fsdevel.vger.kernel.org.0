Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A1F1C551F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 14:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbgEEMMX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 08:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727090AbgEEMMV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 08:12:21 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C332EC061A41
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2020 05:12:19 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id a21so1327114ljj.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 May 2020 05:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HMlQVlmeGXEReM1yut17rciX4AB+fLsrubK71t43Crw=;
        b=by3szt0lWsRCqGRiMrxe/DgyNqYcEB22A1vW7AGwPkpIAuTE8oTuowy/tHPlyU+7Hr
         zYnWeZRfy5tq+4ogzarERxS6xYJVm19GSgbX8tCVHhxBJ+SXzTKDp6UOEj+g8ZYD6maI
         5zC94pX1b6XXgSs+iK/KYtRP0lrbaJNqa+b17nx/Jh2t8Bj2w4nwY0gznMIe3O85N/5L
         ZWkvbqczD9hQBD0yFVF+8CZnAG0B3c4Ufu9iJA61VnJGsVPAdILBJOy7VoA9Bza4pCOC
         k8EAwrX3zVhivffKg6X3aIVE2IrZjmKTacUz1hFTq5dnfV/aj9L1vZXyRf0GMC//S2I2
         VqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HMlQVlmeGXEReM1yut17rciX4AB+fLsrubK71t43Crw=;
        b=JQi7pILuCH2ESWEknhj8WnKERbZZzDwf0WO+5QA/m1PEItQlPGZvXcp/C9ZMFdn/0U
         xhq0A46JkmSQARMD3KLgpyFhHaIYWvR4EPN9dy4vFdaiVTI3WVnYCbRhYsIbC7uIkgar
         hC2eNU4LKlAk2+ikl9rcj71EHVO+VffTDAuzs3NDHDsINDvcA+pVXHsxYsWH9AMohmYL
         46grZM79SH9Ewrp5tpHQD9hsjtUE9tspb/fDK/GtzxbcB8tV1tdIOyyEAWcVLhYtC7HI
         0CEoI4mpLQl5C/xlOA8Y2ZMmxeucwFDJTqqbtd0uK8tIteOwStCH9+76yl76fjiP4cML
         6oAw==
X-Gm-Message-State: AGi0PuaAIt/Mg8TlvtXl39oNnugSYZy9KeiSQnISxz5C4VzAiAGEkr9s
        OLifgZ9TJC0PTz/Fh+1LP82ozhVyExf8eyLM36wVtQ==
X-Google-Smtp-Source: APiQypLhmclSpArV92q+mWNGffd3SX7sCUvNNXrXo90M3AxZAquw+B5r6LXmh3LnQqWsMYsSt2nT6Jp1IGBXxoz1qPY=
X-Received: by 2002:a2e:b249:: with SMTP id n9mr1688630ljm.221.1588680737938;
 Tue, 05 May 2020 05:12:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200429214954.44866-1-jannh@google.com> <20200429214954.44866-5-jannh@google.com>
 <20200505110358.GC17400@lst.de>
In-Reply-To: <20200505110358.GC17400@lst.de>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 5 May 2020 14:11:51 +0200
Message-ID: <CAG48ez0QFYGXfp3x2T2_8sxsidJs5oQA3muaeJ61=EMEwdRnYQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] binfmt_elf, binfmt_elf_fdpic: Use a VMA list snapshot
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 5, 2020 at 1:04 PM Christoph Hellwig <hch@lst.de> wrote:
> On Wed, Apr 29, 2020 at 11:49:53PM +0200, Jann Horn wrote:
> > In both binfmt_elf and binfmt_elf_fdpic, use a new helper
> > dump_vma_snapshot() to take a snapshot of the VMA list (including the gate
> > VMA, if we have one) while protected by the mmap_sem, and then use that
> > snapshot instead of walking the VMA list without locking.
[...]
> > diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> > index fb36469848323..dffe9dc8497ca 100644
> > --- a/fs/binfmt_elf.c
> > +++ b/fs/binfmt_elf.c
> > @@ -1292,8 +1292,12 @@ static bool always_dump_vma(struct vm_area_struct *vma)
> >       return false;
> >  }
> >
> > +#define DUMP_SIZE_MAYBE_ELFHDR_PLACEHOLDER 1
> > +
> >  /*
> >   * Decide what to dump of a segment, part, all or none.
> > + * The result must be fixed up via vma_dump_size_fixup() once we're in a context
> > + * that's allowed to sleep arbitrarily long.
> >   */
> >  static unsigned long vma_dump_size(struct vm_area_struct *vma,
> >                                  unsigned long mm_flags)
> > @@ -1348,30 +1352,15 @@ static unsigned long vma_dump_size(struct vm_area_struct *vma,
> >
> >       /*
> >        * If this looks like the beginning of a DSO or executable mapping,
> > -      * check for an ELF header.  If we find one, dump the first page to
> > -      * aid in determining what was mapped here.
> > +      * we'll check for an ELF header. If we find one, we'll dump the first
> > +      * page to aid in determining what was mapped here.
> > +      * However, we shouldn't sleep on userspace reads while holding the
> > +      * mmap_sem, so we just return a placeholder for now that will be fixed
> > +      * up later in vma_dump_size_fixup().
> >        */
> >       if (FILTER(ELF_HEADERS) &&
> > -         vma->vm_pgoff == 0 && (vma->vm_flags & VM_READ)) {
> > -             u32 __user *header = (u32 __user *) vma->vm_start;
> > -             u32 word;
> > -             /*
> > -              * Doing it this way gets the constant folded by GCC.
> > -              */
> > -             union {
> > -                     u32 cmp;
> > -                     char elfmag[SELFMAG];
> > -             } magic;
> > -             BUILD_BUG_ON(SELFMAG != sizeof word);
> > -             magic.elfmag[EI_MAG0] = ELFMAG0;
> > -             magic.elfmag[EI_MAG1] = ELFMAG1;
> > -             magic.elfmag[EI_MAG2] = ELFMAG2;
> > -             magic.elfmag[EI_MAG3] = ELFMAG3;
> > -             if (unlikely(get_user(word, header)))
> > -                     word = 0;
> > -             if (word == magic.cmp)
> > -                     return PAGE_SIZE;
> > -     }
> > +         vma->vm_pgoff == 0 && (vma->vm_flags & VM_READ))
> > +             return DUMP_SIZE_MAYBE_ELFHDR_PLACEHOLDER;
> >
> >  #undef       FILTER
> >
> > @@ -1381,6 +1370,22 @@ static unsigned long vma_dump_size(struct vm_area_struct *vma,
> >       return vma->vm_end - vma->vm_start;
> >  }
> >
> > +/* Fix up the result from vma_dump_size(), now that we're allowed to sleep. */
> > +static void vma_dump_size_fixup(struct core_vma_metadata *meta)
> > +{
> > +     char elfmag[SELFMAG];
> > +
> > +     if (meta->dump_size != DUMP_SIZE_MAYBE_ELFHDR_PLACEHOLDER)
> > +             return;
> > +
> > +     if (copy_from_user(elfmag, (void __user *)meta->start, SELFMAG)) {
> > +             meta->dump_size = 0;
> > +             return;
> > +     }
> > +     meta->dump_size =
> > +             (memcmp(elfmag, ELFMAG, SELFMAG) == 0) ? PAGE_SIZE : 0;
> > +}
>
> While this code looks entirely correct, it took me way too long to
> follow.  I'd take te DUMP_SIZE_MAYBE_ELFHDR_PLACEHOLDER into the caller,
> and then have a simple function like this:
>
> static void vma_dump_size_fixup(struct core_vma_metadata *meta)
> {
>         char elfmag[SELFMAG];
>
>         if (copy_from_user(elfmag, (void __user *)meta->start, SELFMAG) ||
>             memcmp(elfmag, ELFMAG, sizeof(elfmag)) != 0)
>                 meta->dump_size = 0;
>         else
>                 meta->dump_size = PAGE_SIZE;
> }

I guess I can make that change, even if I personally think it's less
clear if parts of the fixup logic spill over into the caller instead
of being handled locally here. :P

> Also a few comments explaining why we do this fixup would help readers
> of the code.
>
> > -             if (vma->vm_flags & VM_WRITE)
> > -                     phdr.p_flags |= PF_W;
> > -             if (vma->vm_flags & VM_EXEC)
> > -                     phdr.p_flags |= PF_X;
> > +             phdr.p_flags = meta->flags & VM_READ ? PF_R : 0;
> > +             phdr.p_flags |= meta->flags & VM_WRITE ? PF_W : 0;
> > +             phdr.p_flags |= meta->flags & VM_EXEC ? PF_X : 0;
>
> Sorry for another nitpick, but I find the spelled out version with the
> if a lot easier to read.

Huh... I find it easier to scan if it is three lines with the same
pattern, but I'm not too attached to it.

In that case, I guess I should change it like this? The old code had a
ternary for VM_READ and branches for the other two, which didn't seem
very pretty to me.

phdr.p_flags = 0;
if (meta->flags & VM_READ)
        phdr.p_flags |= PF_R;
if (meta->flags & VM_WRITE)
        phdr.p_flags |= PF_W;
if (meta->flags & VM_EXEC)
        phdr.p_flags |= PF_X;

> > +int dump_vma_snapshot(struct coredump_params *cprm, int *vma_count,
> > +     struct core_vma_metadata **vma_meta,
> > +     unsigned long (*dump_size_cb)(struct vm_area_struct *, unsigned long))
>
> Plase don't use single tabs for indentating parameter continuations
> (we actually have two styles - either two tabs or aligned after the
> opening brace, pick your poison :))

I did that because if I use either one of those styles, I'll have to
either move the callback type into a typedef or add line breaks in the
parameters of the callback type. I guess I can write it like this...

int dump_vma_snapshot(struct coredump_params *cprm, int *vma_count,
                      struct core_vma_metadata **vma_meta,
                      unsigned long (*dump_size_cb)(struct vm_area_struct *,
                                                    unsigned long));

but if you also dislike that, let me know and I'll add a typedef instead. :P

> > +     *vma_meta = kvmalloc_array(*vma_count, sizeof(**vma_meta), GFP_KERNEL);
> > +     if (!*vma_meta) {
> > +             up_read(&mm->mmap_sem);
> > +             return -ENOMEM;
> > +     }
> > +
> > +     for (i = 0, vma = first_vma(current, gate_vma); vma != NULL;
> > +                     vma = next_vma(vma, gate_vma)) {
> > +             (*vma_meta)[i++] = (struct core_vma_metadata) {
> > +                     .start = vma->vm_start,
> > +                     .end = vma->vm_end,
> > +                     .flags = vma->vm_flags,
> > +                     .dump_size = dump_size_cb(vma, cprm->mm_flags)
> > +             };
>
> This looks a little weird.  Why not kcalloc + just initialize the four
> fields we actually fill out here?

Yeah, I can just change the syntax here to normal member writes if you
want. I just thought C99-style initialization looked nicer, but I
guess that's unusual in the kernel...

(And I just noticed that that "filesize" member of that struct
core_vma_metadata I'm defining is entirely unused... I'll have to
remove that in the next iteration.)
