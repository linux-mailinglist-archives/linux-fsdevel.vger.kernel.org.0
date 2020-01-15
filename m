Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C86CB13B64F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 01:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbgAOADr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 19:03:47 -0500
Received: from mail-io1-f45.google.com ([209.85.166.45]:40834 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgAOADr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 19:03:47 -0500
Received: by mail-io1-f45.google.com with SMTP id x1so15846366iop.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2020 16:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hQdoWd7nqkbbCTx81FdH4PMrLEZoErvkjF77pn+STsU=;
        b=icXtvNn+/K0gnh1+ANBFLobrt2JhuNwd9g1vgAXPZCJMWeEJjhw5upPaieE2NpQiEU
         akphOyzrSiLMOMIYAleOdaVmgoCrv5Tmmkn4vdvRdW+BDAifT9APJhdLcpuMhYC0bQ6G
         9NTIcaex/rPLaB6lHeN1cDxpc/x6HqOmxF7FokRxjp49uHXkxk+oBNm+3lwv8lTipiH6
         3/WXyg4W80sZycy2Ncei4garglI8uwTMbyEvw9Tu51CycomKdFvpCFBmaRZwvksN7S6V
         5V7GMsdveCdASW7wQAOeV3NvzHOWr/xOp0zvnBI/GMDn8YAvwo/QjcLvv47OiZ5tF24r
         F9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hQdoWd7nqkbbCTx81FdH4PMrLEZoErvkjF77pn+STsU=;
        b=no1RIEOwFLclb9qhrdQ4X+J/ryaqu9dsd2MhzQHQAoiY6Ss7VCvK8rFuQYQvuNkNNi
         bkwP+GTRWCMU2I4Me7YZEUqWwFkRp7p89rGN/Hacxb2Ox3/O3Lh5zfVuv+/iEGeHE8/v
         N78W6ODK6C7la81l962Xa6kDStjxKO3ur9cmu7Cw2vRXU8EdPD14hRDP3WZDh5AmD1FM
         zHl8UXC9Uozz8GQy6NMek7c5vsc5pQHKqrorOc7zaCjNfAkxNJDryPVvriMxaszPtGGT
         lnBkQY9i7iBjpQ+0EzqNXyJy4CdGcGdCFy/dbjq3Awoll53Ds196rBjAGHciqf1GmTDz
         srKg==
X-Gm-Message-State: APjAAAWkeS+XiP2CZZCIB4Adl92jSj1q+NEPUfgaPrqSXGlSpulRuZDb
        pqvIvNnXldqPdIlUADOR8GywJ+tqMMDw+K1wmiAhlyzX
X-Google-Smtp-Source: APXvYqxVbe45hhkFGZZDOFYDsh5a94H++JUT/4guAwpC4DonMT022isije9hpg/jHlapit2IFqpjrtFRm3sJKRCRr4g=
X-Received: by 2002:a5d:814f:: with SMTP id f15mr19404423ioo.275.1579046626762;
 Tue, 14 Jan 2020 16:03:46 -0800 (PST)
MIME-Version: 1.0
References: <20200114154034.30999-1-amir73il@gmail.com> <20200114162234.GZ8904@ZenIV.linux.org.uk>
 <CAOQ4uxjbRzuAPHbgyW+uGmamc=fZ=eT_p4wCSb0QT7edtUqu8Q@mail.gmail.com>
 <20200114191907.GC8904@ZenIV.linux.org.uk> <CAOQ4uxh-1cUQtWoNR+JzR0fCo-yEC4UrQGcZvKyj6Pg11G7FRQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxh-1cUQtWoNR+JzR0fCo-yEC4UrQGcZvKyj6Pg11G7FRQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 15 Jan 2020 02:03:35 +0200
Message-ID: <CAOQ4uxggg4p6MD2LiAKr2dzj+35iA-B3BptXPpOjWMEUX=QbeA@mail.gmail.com>
Subject: Re: dcache: abstract take_name_snapshot() interface
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 14, 2020 at 9:58 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Tue, Jan 14, 2020 at 9:19 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Tue, Jan 14, 2020 at 08:06:56PM +0200, Amir Goldstein wrote:
> > > > // NOTE: release_dentry_name_snapshot() will be needed for both copies.
> > > > clone_name_snapshot(struct name_snapshot *to, const struct name_snapshot *from)
> > > > {
> > > >         to->name = from->name;
> > > >         if (likely(to->name.name == from->inline_name)) {
> > > >                 memcpy(to->inline_name, from->inline_name,
> > > >                         to->name.len);
> > > >                 to->name.name = to->inline_name;
> > > >         } else {
> > > >                 struct external_name *p;
> > > >                 p = container_of(to->name.name, struct external_name, name[0]);
> > > >                 atomic_inc(&p->u.count);
> > > >         }
> > > > }
> > > >
> > > > and be done with that.  Avoids any extensions or tree-wide renamings, etc.
> > >
> > > I started with something like this but than in one of the early
> > > revisions I needed
> > > to pass some abstract reference around before cloning the name into the event,
> > > but with my current patches I can get away with a simple:
> > >
> > > if (data_type == FANOTIFY_EVENT_NAME)
> > >     clone_name_snapshot(&event->name, data);
> > > else if (dentry)
> > >     take_dentry_name_snapshot(&event->name, dentry);
> > >
> > > So that simple interface should be good enough for my needs.
> >
> > I really think it would be safer that way; do you want me to throw that into
> > vfs.git (#work.dcache, perhaps)?  I don't have anything going on in the
> > vicinity, so it's not likely to cause conflicts either way and nothing I'd
> > seen posted on fsdevel seems to be likely to step into it, IIRC, so...
> > Up to you.
>
> Sure, that would be great.
>

Only problem I forgot about is that I need to propagate name_snapshot
into fsnotify_move() instead of qstr (in order to snapshot it).
That means I will need to snapshot also new_dentry in vfs_rename(), so
I have a name_snapshot to pass into the RENAME_EXCHANGE
fsnotify_move() hook.

My current patch passes the cute &old_dentry->d_name_snap abstract
to fsnotify_move().

What shall I do about that?

        take_dentry_name_snapshot(&new_name, new_dentry);
???

Thanks,
Amir.
