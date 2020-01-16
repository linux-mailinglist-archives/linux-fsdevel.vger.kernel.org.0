Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB68113D5CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2020 09:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbgAPIRQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jan 2020 03:17:16 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42023 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgAPIRQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jan 2020 03:17:16 -0500
Received: by mail-qt1-f195.google.com with SMTP id j5so18183913qtq.9;
        Thu, 16 Jan 2020 00:17:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SHx+W0xgTOIdgDlSNYwe3t+59KMiJbuoH0CsD6blozI=;
        b=M+aOV9CTzAoDYhj89ExWq/tuq11a5wbN5OuI2/Wfq6y+JAZfvCyP5l0u9/h51xTtGj
         bmKClpXVImCk6M8r+CfOTsqZWxzTPHRYvG5XDNGqYApIM0DUez3My3uf+uhFhw8t6/Mg
         f1OYt85b5MiAUbpBvEEk3kGXYHcj5oVGXfaOnkmKa5iFt/50gXr2m8yk3hYMYm1vThuN
         8wtN77FwzFGecmkiTZCl/4PM0f3UaG648bn1KeiCrC5uh6vEUoraz4WC37QiLgTkow+f
         JdsWTizd6ByBlKQtsvl6orpAshq2G2Ld7G4Rb9Abr1NCmwN5t4Cf8MCH+XsgIgOFBjCZ
         46Mw==
X-Gm-Message-State: APjAAAW0Ybn+09lO9zjLf4eyJ9GxSBMIfK6Ejpeh35wCK8d+uvcCOawi
        NTp9/faMyLazXDqFrqhNWWynwbfc/dV68ZXwJUvNs1L5SJg=
X-Google-Smtp-Source: APXvYqxxEgYZxh/oglRrD13l2We9XiMjLrNP+WNauD3mETHrsgL78QqP91F3Jrx/mUnwnxYJrxlJPRNLLyYwlDqgnIY=
X-Received: by 2002:ac8:ff6:: with SMTP id f51mr1256489qtk.60.1579162635612;
 Thu, 16 Jan 2020 00:17:15 -0800 (PST)
MIME-Version: 1.0
References: <20200116022049.164659-1-syq@debian.org> <7af5c24d-dd24-b728-92cf-a5a759787590@vivier.eu>
In-Reply-To: <7af5c24d-dd24-b728-92cf-a5a759787590@vivier.eu>
From:   YunQiang Su <syq@debian.org>
Date:   Thu, 16 Jan 2020 16:17:04 +0800
Message-ID: <CAKcpw6VEVaeBA9y1UC+vMzM=u9q4mc4Mr3FWewxDFkFBBtV1xA@mail.gmail.com>
Subject: Re: [PATCH v2] binfmt_misc: pass info about P flag by AT_FLAGS
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        YunQiang Su <ysu@wavecomp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Laurent Vivier <laurent@vivier.eu> 于2020年1月16日周四 下午4:07写道：
>
> Le 16/01/2020 à 03:20, YunQiang Su a écrit :
> > From: YunQiang Su <ysu@wavecomp.com>
> >
> > Currently program invoked by binfmt_misc cannot be aware about whether
> > P flag, aka preserve path is enabled.
> >
> > Some applications like qemu need to know since it has 2 use case:
> >   1. call by hand, like: qemu-mipsel-static test.app OPTION
> >      so, qemu have to assume that P option is not enabled.
> >   2. call by binfmt_misc. If qemu cannot know about whether P flag is
> >      enabled, distribution's have to set qemu without P flag, and
> >      binfmt_misc call qemu like:
> >        qemu-mipsel-static /absolute/path/to/test.app OPTION
> >      even test.app is not called by absoulute path, like
> >        ./relative/path/to/test.app
> >
> > This patch passes this information by the 3rd bits of unused AT_FLAGS.
> > Then, in qemu, we can get this info by:
> >    getauxval(AT_FLAGS) & (1<<3)
> >
> > v1->v2:
> >   not enable kdebug
> >
> > See: https://bugs.launchpad.net/qemu/+bug/1818483
> > Signed-off-by: YunQiang Su <ysu@wavecomp.com>
> > ---
> >  fs/binfmt_elf.c         | 6 +++++-
> >  fs/binfmt_elf_fdpic.c   | 6 +++++-
> >  fs/binfmt_misc.c        | 2 ++
> >  include/linux/binfmts.h | 4 ++++
> >  4 files changed, 16 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> > index f4713ea76e82..d33ee07d7f57 100644
> > --- a/fs/binfmt_elf.c
> > +++ b/fs/binfmt_elf.c
> > @@ -178,6 +178,7 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
> >       unsigned char k_rand_bytes[16];
> >       int items;
> >       elf_addr_t *elf_info;
> > +     elf_addr_t flags = 0;
> >       int ei_index;
> >       const struct cred *cred = current_cred();
> >       struct vm_area_struct *vma;
> > @@ -252,7 +253,10 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
> >       NEW_AUX_ENT(AT_PHENT, sizeof(struct elf_phdr));
> >       NEW_AUX_ENT(AT_PHNUM, exec->e_phnum);
> >       NEW_AUX_ENT(AT_BASE, interp_load_addr);
> > -     NEW_AUX_ENT(AT_FLAGS, 0);
> > +     if (bprm->interp_flags & BINPRM_FLAGS_PRESERVE_ARGV0) {
> > +             flags |= BINPRM_FLAGS_PRESERVE_ARGV0;
> > +     }
>
> Perhaps we also need a different flag in AT_FLAG than in interp_flag as
> BINPRM_FLAGS_PRESERVE_ARGV0 is also part of the internal ABI?

yep. It may be really a problem.
So, should we define a set of new macros for AT_FLAGS?

>
> Al?
>
> Thanks,
> Laurent
>
