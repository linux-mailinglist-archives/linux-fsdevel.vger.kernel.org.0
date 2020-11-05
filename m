Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423752A80BE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Nov 2020 15:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730943AbgKEOVj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Nov 2020 09:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730676AbgKEOVj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Nov 2020 09:21:39 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA98C0613CF;
        Thu,  5 Nov 2020 06:21:39 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id n12so1964638ioc.2;
        Thu, 05 Nov 2020 06:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kEvDpsDJNPurWHlkjxy3UIPQavtN9DMdXBn8z8jdwHo=;
        b=g+o/c7hwijDDcrWw/a5bdfv9C/Q34/sgszETJQPzykhxgSC7zKHuy3cm6c6zrwRC43
         XpsFj/Jdwtg+IZDrndQ7k0+JHeP7JBQdvrU69AihZ6c5UdijlgpMy9uPkEWQER/MFlUM
         ENRF9Z7FxORGVfj0UQQ7iH2BI84I+tslxd8UvcRvoyLC9AsIeQ6r7njZbyTv/IeQAzl2
         6uPMM2cq5JjxAem5NfbEapmxKQx1rQIkPRhn+YSNkSuMFfvZu9d+Lc9Z4Th/L/PYUsyM
         V0sPRURUYwRjrvO+QuZ96I2NZAfQAhScrLVqT3I7qZn2J4y+dsu2iqq+GhCoK/Wkqa7N
         kZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kEvDpsDJNPurWHlkjxy3UIPQavtN9DMdXBn8z8jdwHo=;
        b=L1DX6HH3wUtp2yoNBLjVzYeb95K8B15ZOVnXJLiAXhklvQLlv9e5gY8NFZHmxoP0P+
         OpTZJVh8Hhlt13guCyiia1B3vS6Uo6pU5zmux0Ynfo/MxMZ8SPm2mF/+SMrpYByq1MV7
         p/fxDH5WgWgjyvcrKegq6QFSZ01j7+1CJLTv/QWXlLAJEXKVuU2JjhfMKziCnD4jo4kq
         cIuHn5dMHPdNv6MrlfbuOOMwyPy3uStyh4+n0iYDLQzR7PXLG0ZKWNImuYn1LUts7JKl
         R7oGZ/Uu83iSpswuhHqqsbDEWNbWNOQuhJztROcWtqAbTkqHdwZK/dylanyTDHy8wAy/
         xygQ==
X-Gm-Message-State: AOAM531sC48jgcnk7mDasUFhotJ54F9AGIGeziG/7OfyfTHQrsdbj3rA
        6N2vqT9soUH4Jzv2W7SW0nOdwm2Fc68Cdzu3zDU=
X-Google-Smtp-Source: ABdhPJzJU62MwvoH1G8x0woLyZwKsy3kzFzgYHOUyTU5q7NUMOkbeq0LgVNscVAAKch8XUfGdZPM3qz9zuG1BUKipwE=
X-Received: by 2002:a02:2e45:: with SMTP id u5mr2131698jae.81.1604586098836;
 Thu, 05 Nov 2020 06:21:38 -0800 (PST)
MIME-Version: 1.0
References: <20201025034117.4918-1-cgxu519@mykernel.net> <20201025034117.4918-6-cgxu519@mykernel.net>
 <20201102173052.GF23988@quack2.suse.cz> <175931b5387.1349cecf47061.3904278910555065520@mykernel.net>
 <20201105140332.GG32718@quack2.suse.cz>
In-Reply-To: <20201105140332.GG32718@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 5 Nov 2020 16:21:27 +0200
Message-ID: <CAOQ4uxiH+1rV9_hkjed2jt7YF0CMJJVa6Fc+kbzeTuMXYAQ8MQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 5/8] ovl: mark overlayfs' inode dirty on shared
 writable mmap
To:     Jan Kara <jack@suse.cz>
Cc:     Chengguang Xu <cgxu519@mykernel.net>, miklos <miklos@szeredi.hu>,
        linux-unionfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        charliecgxu <charliecgxu@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 5, 2020 at 4:03 PM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 04-11-20 19:54:03, Chengguang Xu wrote:
> >  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=8C, 2020-11-03 01:30:52 Jan Ka=
ra <jack@suse.cz> =E6=92=B0=E5=86=99 ----
> >  > On Sun 25-10-20 11:41:14, Chengguang Xu wrote:
> >  > > Overlayfs cannot be notified when mmapped area gets dirty,
> >  > > so we need to proactively mark inode dirty in ->mmap operation.
> >  > >
> >  > > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
> >  > > ---
> >  > >  fs/overlayfs/file.c | 4 ++++
> >  > >  1 file changed, 4 insertions(+)
> >  > >
> >  > > diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> >  > > index efccb7c1f9bc..cd6fcdfd81a9 100644
> >  > > --- a/fs/overlayfs/file.c
> >  > > +++ b/fs/overlayfs/file.c
> >  > > @@ -486,6 +486,10 @@ static int ovl_mmap(struct file *file, struct=
 vm_area_struct *vma)
> >  > >          /* Drop reference count from new vm_file value */
> >  > >          fput(realfile);
> >  > >      } else {
> >  > > +        if (vma->vm_flags & (VM_SHARED|VM_MAYSHARE) &&
> >  > > +            vma->vm_flags & (VM_WRITE|VM_MAYWRITE))
> >  > > +            ovl_mark_inode_dirty(file_inode(file));
> >  > > +
> >  >
> >  > But does this work reliably? I mean once writeback runs, your inode =
(as
> >  > well as upper inode) is cleaned. Then a page fault comes so file has=
 dirty
> >  > pages again and would need flushing but overlayfs inode stays clean?=
 Am I
> >  > missing something?
> >  >
> >
> > Yeah, this is key point of this approach, in order to  fix the issue I
> > explicitly set I_DIRTY_SYNC flag in ovl_mark_inode_dirty(), so what i
> > mean is during writeback we will call into ->write_inode() by this
> > flag(I_DIRTY_SYNC) and at that place we get chance to check mapping and
> > re-dirty overlay's inode. The code logic like below in ovl_write_inode(=
).
> >
> >     if (mapping_writably_mapped(upper->i_mapping) ||
> >          mapping_tagged(upper->i_mapping, PAGECACHE_TAG_WRITEBACK))
> >                  iflag |=3D I_DIRTY_PAGES;
>
> OK, but suppose the upper mapping is clean at this moment (upper inode ha=
s
> been fully written out for whatever reason, but it is still mapped) so yo=
ur
> overlayfs inode becomes clean as well. Then I don't see a mechanism which
> would make your overlayfs inode dirty again when a write to mmap happens,
> set_page_dirty() will end up marking upper inode with I_DIRTY_PAGES flag.
>
> Note that ovl_mmap() gets called only at mmap(2) syscall time but then
> pages get faulted in, dirtied, cleaned fully at discretion of the mm
> / writeback subsystem.
>

Perhaps I will add some background.

What I suggested was to maintain a "suspect list" in addition to
the dirty ovl inodes.

ovl inode is added to the suspect list on mmap (writable) and removed
from the suspect list on release() flush() or on sync_fs() if real inode is=
 no
longer writably mapped.

There was another variant where ovl inode is added to suspect list on open
for write and removed from suspect list on release() flush() or sync_fs()
if real inode is not inode_is_open_for_write().

In both cases the list will have inodes whose real is not dirty, but
in both cases
the list shouldn't be terribly large to traverse on sync_fs().

Chengguang tried to implement the idea without an actual list by
re-dirtying the "suspect" inodes on every write_inode(), but I personally h=
ave
no idea if his idea works.

I think we can resort to using an actual suspect list if you say that it
cannot work like this?

Thanks,
Amir.
