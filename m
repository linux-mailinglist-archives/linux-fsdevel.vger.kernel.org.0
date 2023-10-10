Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034877C0366
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 20:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbjJJS27 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Oct 2023 14:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbjJJS2z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Oct 2023 14:28:55 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9421D9E;
        Tue, 10 Oct 2023 11:28:53 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-65b0383f618so38729856d6.1;
        Tue, 10 Oct 2023 11:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696962532; x=1697567332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wnajvNZsdDrjqmDE9m+4VY4K3z2D3qww+2KfBOKVw1Y=;
        b=e4zTVIDgV/xdihFaUQvo1GC7mqQhc260fXf41qKAW8YQIHQKU7kYtnvStm4greE1Qu
         XGmkU/bkciHoI8q5QpalDiQ4+4vRkjWKIWQP99Fo/bRhtp+Y+mJPHAMJP9cc32kBZrxf
         mAbeycr9JiCT7u10FBE3FnWNuCOY5eBuC6GMd07Mpr/I4HGBZOTzv7b6eMG5ocsDbvoe
         YP5oJ7jCCF2jwQyU4g6JGte25odgGX4UZ8WYorBsllu94PTMDEg8ZDnIu4ClmN0uJ8o/
         3BTXtEzdGkxVmasNV28zhP+rw73ANJDyl5GYaq37wQeke69f6HWxMTf5duV8n+ECl9q6
         eenA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696962532; x=1697567332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wnajvNZsdDrjqmDE9m+4VY4K3z2D3qww+2KfBOKVw1Y=;
        b=HD2uaq4IQFzewxbqqqpRDtvjPM6cLZ4JhuVXRKcX7oaJWOWxVM4wdMoBUPSE1Xw5wY
         nSVKXEO+WVk6r4Nn2INLRzN9pWPyilg0uA3MidB4fXFbh8El/mSteTljwaUiFwHPGaqd
         jHfqzYT3m47sC+u+oxpiPo8cFLpS4XjKKk4Hz8xEGCr0hn/c6ODbmHi9ttJjXemWkfoQ
         I/GDRTg9RgvqD+NhGm1bN5Krq+QH1gCO+CgS3aq4vriXic+VIux4HEvwOLYHcgpoKGvD
         FYN1DE6adTb2zA2w81STBQ8Phs5aoab8tDhK3rb4+h/VZFGXkB+NQG3M3sR/s6+dA5WO
         UE6A==
X-Gm-Message-State: AOJu0YzLf5D2XwmSqOVFIsBpDbrES7scfGHRhTtGkI9A+7uivXtU/a51
        a/iyLcYZmqfEBIA970OeXlpUMXPOs36fdff/8Yw=
X-Google-Smtp-Source: AGHT+IGOjBU3V2UBhf2oW84TcfxBy53NLZBbEJsIqRV0DPj+iZr9o2ZQe+dH7YssI0mKsfkjputPkReAeBl2Xjmhbqk=
X-Received: by 2002:a0c:cb0b:0:b0:66a:f5ef:d7e7 with SMTP id
 o11-20020a0ccb0b000000b0066af5efd7e7mr12457450qvk.27.1696962532599; Tue, 10
 Oct 2023 11:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <20231009153712.1566422-1-amir73il@gmail.com> <20231009153712.1566422-4-amir73il@gmail.com>
 <CAJfpegtcNOCMp+QBPFD5aUEok6u7AqwrGqAqMCZeeuyq6xfYFw@mail.gmail.com>
 <CAOQ4uxiAHJy6viXBubm0y7x3J3P7N5XijOU8C340fi2Dpc7zXA@mail.gmail.com>
 <CAOQ4uxipA5oCQXn1-JZ+TbXw2-5O+_++FfNHC6fKqhNXfR7C0w@mail.gmail.com>
 <CAJfpeguEf71ZknP5rGU9YNtJTp1wBGBKyv6M0JZ=5ETuaipDxQ@mail.gmail.com>
 <20231010165504.GP800259@ZenIV> <20231010174146.GQ800259@ZenIV>
 <CAOQ4uxjHKU0q8dSBQhGpcdp-Dg1Hx-zxs3AurXZBQnKBkV7PAw@mail.gmail.com> <20231010182141.GR800259@ZenIV>
In-Reply-To: <20231010182141.GR800259@ZenIV>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 10 Oct 2023 21:28:41 +0300
Message-ID: <CAOQ4uxg7ZmDfyEam2v7Be5Chv_WBccxpExTnG+70fRz9BooyyQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] fs: store real path instead of fake path in
 backing file f_path
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 10, 2023 at 9:21=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Tue, Oct 10, 2023 at 08:57:21PM +0300, Amir Goldstein wrote:
> > On Tue, Oct 10, 2023 at 8:41=E2=80=AFPM Al Viro <viro@zeniv.linux.org.u=
k> wrote:
> > >
> > > On Tue, Oct 10, 2023 at 05:55:04PM +0100, Al Viro wrote:
> > > > On Tue, Oct 10, 2023 at 03:34:45PM +0200, Miklos Szeredi wrote:
> > > > > On Tue, 10 Oct 2023 at 15:17, Amir Goldstein <amir73il@gmail.com>=
 wrote:
> > > > >
> > > > > > Sorry, you asked about ovl mount.
> > > > > > To me it makes sense that if users observe ovl paths in writabl=
e mapped
> > > > > > memory, that ovl should not be remounted RO.
> > > > > > Anyway, I don't see a good reason to allow remount RO for ovl i=
n that case.
> > > > > > Is there?
> > > > >
> > > > > Agreed.
> > > > >
> > > > > But is preventing remount RO important enough to warrant special
> > > > > casing of backing file in generic code?  I'm not convinced either
> > > > > way...
> > > >
> > > > You definitely want to guarantee that remounting filesystem r/o
> > > > prevents the changes of visible contents; it's not just POSIX,
> > > > it's a fairly basic common assumption about any local filesystems.
> > >
> > > Incidentally, could we simply keep a reference to original struct fil=
e
> > > instead of messing with path?
> > >
> > > The only caller of backing_file_open() gets &file->f_path as user_pat=
h; how
> > > about passing file instead, and having backing_file_open() do get_fil=
e()
> > > on it and stash the sucker into your object?
> > >
> > > And have put_file_access() do
> > >         if (unlikely(file->f_mode & FMODE_BACKING))
> > >                 fput(backing_file(file)->file);
> > > in the end.
> > >
> > > No need to mess with write access in any special way and it's closer
> > > to the semantics we have for normal mmap(), after all - it keeps the
> > > file we'd passed to it open as long as mapping is there.
> > >
> > > Comments?
> >
> > Seems good to me.
> > It also shrinks backing_file by one pointer.
> >
> > I think this patch can be an extra one after
> > "fs: store real path instead of fake path in backing file f_path"
> >
> > Instead of changing storing of real_path to storing orig file in
> > one change?
> >
> > If there are no objections, I will write it up.
>
> Actually, now that I'd looked at it a bit more...  Look:
> we don't need to do *anything* in put_file_access(); just
> make file_free()
>         if (unlikely(f->f_mode & FMODE_BACKING))
>                 fput(backing_file(f)->user_file);
> instead of conditional path_put().  That + change of open_backing_file()
> prototype + get_file() in there pretty much eliminates the work done
> in 1/3 - you don't need to mess with {get,put}_file_write_access()
> at all.
>
> I'd start with this:
>
> struct file *vm_user_file(struct vm_area_struct *vma)
> {
>         return vma->vm_file;
> }
> + replace file =3D vma->vm_file; with file =3D vm_user_file(vma) in
> the places affected by your 2/3.  That's the first (obviously
> safe) commit.  Then the change of backing_file_open() combined
> with making vm_user_file() do this:
>         file =3D vma->vm_file;
>         if (file && unlikely(file->f_mode & FMODE_BACKING))
>                 file =3D backing_file(file)->user_file;
>         return file;
>
> Voila.  Two-commit series, considerably smaller than your
> variant...
>

Yap. looks very nice.
I will try that out tomorrow.

Anyway, it doesn't hurt to have the current version in linux-next
for the night to see if the change from fake f_path to real f_path
has any unexpected outcomes.

Thanks for the suggestions!
Amir.
