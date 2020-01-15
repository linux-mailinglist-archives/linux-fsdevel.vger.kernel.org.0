Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE4113B938
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 06:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgAOFvu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 00:51:50 -0500
Received: from mail-io1-f46.google.com ([209.85.166.46]:46963 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgAOFvu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 00:51:50 -0500
Received: by mail-io1-f46.google.com with SMTP id t26so16518587ioi.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2020 21:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BmYxy9Dp1ITLJJTDI6Htb9KrDKs73UVseY852+jiS5I=;
        b=txWniKsI0YBQWNU0ri6YEgtJ81BdZ9hqqb+YA8pxEPizd6hqhkU41P/pLBQOufbiM3
         tWdPW1dvvU+oSVWLKhEzetpkO96vqoUFVbwNmNaXP40jgJ3IDu2oUC5gq1pzJiZB8TTO
         4rhPStPMerx/IGpOeIbarEVXqtWZ7AtAidnplinY1vLU0V6H/GwQ/o1fmWqP+t6XV2S5
         XfjmhUKXwLZnmfcYhAZvbOEvealOpYE30QY/nbAfeNyzM9GBJQufnZ7GbKSHwoKCVXPX
         0OyrXZDXFIFBCkk2Dclv/d13M0NJagV56zRCSQmZCLpVefRgwY4Ag5WDmZ6xKx2BR+w4
         /VwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BmYxy9Dp1ITLJJTDI6Htb9KrDKs73UVseY852+jiS5I=;
        b=IlfqWlOIRXrmw/XcTHJPDAnTkdknVqAMV1MF3HoGAl0gh1ijCiXEr6AWolWCOK4Syq
         2dYT1RNGBZsYZAmoe18XqW2dCo7c9L3AB6oK+Kxe2HLMVTG/nIMuG2mksK72KdUgQJ46
         bnDrDwTElx6YVNRpWZm+Pw6cinOCJX678pgM5phtJ1+IYYWlCT/RlVPdboqwcWtmWao0
         BMJ2SpDV9KvZdPcMyXqKLN4w/hWSFQx3770jHXo2njKTU1z/DoFTRpZzyYG+mvcbfPHM
         qDSwbv7LOfk7dVna+4V+rUfCBvs1IM5b6TfDzqiSA12mZ1l6QBKNNjdLGbJ5HeUAInCd
         GwmQ==
X-Gm-Message-State: APjAAAVYZSyLNtm6Ob+rLVpfi9G/gCXwtF9neOaV4QB0JbqifyCaScjG
        aPVbwdXgXKY7m3m+SNZuxF6b8IlAh/9hI7M6r6V0Aw==
X-Google-Smtp-Source: APXvYqz594TWpKimYpuc8stel7X9IQ6L/zIEJqRkKY6M+cfSfo7cwUf6vsxGTOT/baZE/BLEB6V/fNTf8OwTUm+qxao=
X-Received: by 2002:a6b:f214:: with SMTP id q20mr21536785ioh.137.1579067509734;
 Tue, 14 Jan 2020 21:51:49 -0800 (PST)
MIME-Version: 1.0
References: <20200114154034.30999-1-amir73il@gmail.com> <20200114162234.GZ8904@ZenIV.linux.org.uk>
In-Reply-To: <20200114162234.GZ8904@ZenIV.linux.org.uk>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 15 Jan 2020 07:51:38 +0200
Message-ID: <CAOQ4uxg+h==YBta806Zo1axETs07=F0DdMDCA=fUPjyz6aHBzQ@mail.gmail.com>
Subject: Re: dcache: abstract take_name_snapshot() interface
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 14, 2020 at 6:22 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Tue, Jan 14, 2020 at 05:40:34PM +0200, Amir Goldstein wrote:
> > Generalize the take_name_snapshot()/release_name_snapshot() interface
> > so it is possible to snapshot either a dentry d_name or its snapshot.
> >
> > The order of fields d_name and d_inode in struct dentry is swapped
> > so d_name is adjacent to d_iname.  This does not change struct size
> > nor cache lines alignment.
> >
> > Currently, we snapshot the old name in vfs_rename() and we snapshot the
> > snapshot the dentry name in __fsnotify_parent() and then we pass qstr
> > to inotify which allocated a variable length event struct and copied the
> > name.
> >
> > This new interface allows us to snapshot the name directly into an
> > fanotify event struct instead of allocating a variable length struct
> > and copying the name to it.
>
> Ugh...  That looks like being too damn cute for no good reason.  That
> trick with union is _probably_ safe, but I wouldn't bet a dime on
> e.g. randomize_layout crap not screwing it over in random subset of
> gcc versions.  You are relying upon fairly subtle reading of 6.2.7
> and it feels like just the place for layout-mangling plugins to fuck
> up.
>
> With -fplan9-extensions we could go for renaming struct name_snapshot
> fields and using an anon member in struct dentry -
>         ...
>         struct inode *d_inode;
>         struct name_snapshot;   // d_name and d_iname
>         struct lockref d_lockref;
>         ...
>
> but IMO it's much safer to have an explicit
>
> // NOTE: release_dentry_name_snapshot() will be needed for both copies.
> clone_name_snapshot(struct name_snapshot *to, const struct name_snapshot *from)
> {
>         to->name = from->name;
>         if (likely(to->name.name == from->inline_name)) {
>                 memcpy(to->inline_name, from->inline_name,
>                         to->name.len);

to->name.len + 1);

>                 to->name.name = to->inline_name;
>         } else {
>                 struct external_name *p;
>                 p = container_of(to->name.name, struct external_name, name[0]);
>                 atomic_inc(&p->u.count);
>         }
> }
>

Thanks,
Amir.
