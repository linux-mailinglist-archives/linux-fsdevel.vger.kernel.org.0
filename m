Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA24F445547
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Nov 2021 15:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbhKDO24 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Nov 2021 10:28:56 -0400
Received: from mta-101a.oxsus-vadesecure.net ([51.81.61.60]:35403 "EHLO
        nmtao101.oxsus-vadesecure.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230511AbhKDO24 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Nov 2021 10:28:56 -0400
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Nov 2021 10:28:56 EDT
DKIM-Signature: v=1; a=rsa-sha256; bh=fJKpGIUJYIZLWasrbvMyg3t5SstuQrvOLXM4gS
 tKI1A=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-subscribe:list-post:
 list-owner:list-archive; q=dns/txt; s=dk12062016; t=1636035673;
 x=1636640473; b=ggTJFAHH9eIYMl759UOxCaRBqTgMJpe20tdlLH/qEykY2QLdzU5QRYh
 3BXZqIAfM0AXdz4UAtOnV9L9VJ+UL1t5iIWRvI8gO2DOijBblNU8p93sC7yaVGFgqGwMK6M
 6mDnpNSd0ouuxdE3SSbqDxZx1KZ3s+iWY3+Nam+PH8ITYGC1ZrhR5RjBK3KOG3Abfe/MRMs
 9niAAt6C/+zWH32FGFACkH7DrTAl+7WDmqL80a1VzMNDpedWSZjMg6Kc6R8P8zrYv/X62la
 dfxWRX0ic6z5XqHwBxmUeNHb0HFD5czFDwvzVTK1rF1bt6Kl0O4dB6yPb/xy0OoYJ7R85ml
 e3Q==
Received: from FRANKSTHINKPAD ([76.105.143.216])
 by smtp.oxsus-vadesecure.net ESMTP oxsus1nmtao01p with ngmta
 id fbdefa56-16b45dc6c6c0bd07; Thu, 04 Nov 2021 14:21:13 +0000
From:   "Frank Filz" <ffilzlnx@mindspring.com>
To:     "'Jeff Layton'" <jlayton@kernel.org>,
        "'Miklos Szeredi'" <miklos@szeredi.hu>
Cc:     <linux-fsdevel@vger.kernel.org>
References: <88ba5bf0c8d5f08b9556499a9891543530471f03.camel@kernel.org>         <CAJfpegtNDk2QA5VF+28zo6ViagW5CSvhaajs5ePwbC0r7AF=AA@mail.gmail.com> <ac100fa4d845c932fd4ce79027b821e80a9adbbc.camel@kernel.org>
In-Reply-To: <ac100fa4d845c932fd4ce79027b821e80a9adbbc.camel@kernel.org>
Subject: RE: FUSE statfs f_fsid field
Date:   Thu, 4 Nov 2021 07:21:12 -0700
Message-ID: <05a401d7d187$38ddd050$aa9970f0$@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Content-Language: en-us
Thread-Index: AQKKmTAbAe38HjD5+mM4s6LazE+lswIqsDO7AYiuiYyqcD80UA==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On Thu, 2021-11-04 at 14:50 +0100, Miklos Szeredi wrote:
> > On Thu, 4 Nov 2021 at 14:27, Jeff Layton <jlayton@kernel.org> wrote:
> > >
> > > Hi Miklos!
> > >
> > > I was looking at an issue [1] with ceph-fuse and noticed that =
statfs
> > > always reports f_fsid =3D=3D 0 via statfs. Is there a reason for =
not
> > > letting the driver fill out that field?
> >
> > Hi Jeff,
> >
> > I do not remember ever hearing of this field.   The statfs(2) man =
page
> > doesn't make it very obvious either:
> >
> >    The f_fsid field
> >
> >        [...] The general idea is that f_fsid contains some random
> > stuff  such  that
> >        the  pair (f_fsid,ino) uniquely determines a file.  Some =
operating sys=E2=80=90
> >        tems use (a variation on) the device number, or the device =
number  com=E2=80=90
> >        bined  with  the  filesystem  type. [...]
> >
> > I'd be somewhat concerned about allowing an unprivileged fuse server
> > to fill this, as that may allow impersonation of another filesystem.
> >
> > For a privileged fuse server I see no problem with allowing to set =
this.
>=20
> Thanks, Miklos,
>=20
> Good point about impersonation. I'll have to think about whether it's =
worthwhile
> to change this for privileged servers.

I'm not sure what all uses f_fsid. I know nfs-ganesha uses it (but we =
have a way around it so long as the file system either has a UUID =
available via blkid or has a unique device id (actually, we require all =
file systems to have unique device id at the moment...). The find tool =
and similar tools may use it in their loop detection where they stop =
traversing into a file system if they see duplicate fsid/inode number =
pairs (not sure if they use other mechanisms to distinguish file =
systems).

Impersonating another file system would obviously cause problems with =
those uses of fsid. Other than a DOS though, I'm not sure what else they =
could do and there is some administrator control over mounted file =
systems.

This always being 0 for FUSE file systems would definitely be a hiccup =
to nfs-ganesha using FUSE file systems, though that's not something we =
have put any effort into testing...

Frank

