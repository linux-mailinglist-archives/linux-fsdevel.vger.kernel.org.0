Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E636628F334
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 15:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgJONaM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Oct 2020 09:30:12 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17188 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726924AbgJONaM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Oct 2020 09:30:12 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1602767631; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=A6A6C36Vvq/u6yR0ZZuqBhKPAQu5ldz6Ds4ACkWn8cDRfeK+J8n74wHTpHqL/oV00F6ZYQM2xY/QIb3JtV0y2DzzycMQkUt5kfDWQ6DXHJ82wzoW39TwaJWGkWwT+F+Qc/igxLkDyzBFtTn2VmM0aet6/dHt3dYNZMB5ugYNzMA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1602767631; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=Xyo7HIkORGYFk9ReDZ6mW7xWjneGhHZQI35XCXx+8EY=; 
        b=GZAuvzd1v+Ax21yK3JXpdfOf++v/f0GYxmD9EVVwEksNbHiGDhd8gjDRB2RDzteEsA1W/T/fsEpa98BGfq7FAKlfiagxpaETBEYV1VIprXNRhw4OuKDJ0FjHoRdI7y/lz3iZtmjR4WePJXkfyHvs+zTA2CFBrAWhmid8QKTvhYk=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1602767631;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=Xyo7HIkORGYFk9ReDZ6mW7xWjneGhHZQI35XCXx+8EY=;
        b=NpCL8zHQfKZ6/gVl1p+FgCkgxiNt/H0SxYchB4Rc40f17DO8rgqo6HvP08WAyKeS
        hY0g6LkHhzg5bFRcWUEKgbggB2UnpB5EZYsRGWeNqrmyiVXjFn67rdUNzsjWFmh9yz+
        oMgO+W5FySL2+WB988F6pJD4ZDA7F0xy3Bvh2uqo=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1602767628646276.63974408644185; Thu, 15 Oct 2020 21:13:48 +0800 (CST)
Date:   Thu, 15 Oct 2020 21:13:48 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Amir Goldstein" <amir73il@gmail.com>
Cc:     "Jan Kara" <jack@suse.cz>, "miklos" <miklos@szeredi.hu>,
        "linux-unionfs" <linux-unionfs@vger.kernel.org>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "cgxu519" <cgxu519@mykernel.net>
Message-ID: <1752c652963.113ee3fbc44343.6282793280578516240@mykernel.net>
In-Reply-To: <CAOQ4uxhEA=ggONsJrUzGfHOGHob+81-UHk1Wo9ejj=CziAjtTQ@mail.gmail.com>
References: <20201010142355.741645-1-cgxu519@mykernel.net> <20201010142355.741645-2-cgxu519@mykernel.net>
 <20201014161538.GA27613@quack2.suse.cz> <1752a360692.e4f6555543384.3080516622688985279@mykernel.net>
 <CAOQ4uxhOrPfJxhJ1g7eSSdO4=giFJabCCOvJL7dSo1R9VsZozA@mail.gmail.com> <1752c05cbe5.fd554a7a44272.2744418978249296745@mykernel.net> <CAOQ4uxhEA=ggONsJrUzGfHOGHob+81-UHk1Wo9ejj=CziAjtTQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] fs: introduce notifier list for vfs inode
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: ZohoCN Mail
X-Mailer: ZohoCN Mail
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E5=9B=9B, 2020-10-15 20:32:24 Amir Golds=
tein <amir73il@gmail.com> =E6=92=B0=E5=86=99 ----
 > >  > Perhaps you can combine that with the shadow overlay sbi approach.
 > >  > Instead of dirtying overlay inode when underlying is dirtied, you c=
an
 > >  > "pre-dirty" overlayfs inode in higher level file ops and add them t=
o the
 > >  > "maybe-dirty" list (e.g. after write).
 > >  >
 > >
 > > Main problem is we can't be notified by set_page_dirty from writable m=
map.
 > > Meanwhile, if we dirty overlay inode then writeback will pick up dirty=
 overlay
 > > inode and clear it after syncing, then overlay inode could be release =
at any time,
 > > so in the end, maybe overlay inode is released but upper inode is stil=
l dirty and
 > > there is no any pointer to find upper dirty inode out.
 > >
 >=20
 > But we can control whether overlay inode is release with ovl_drop_inode(=
)
 > right? Can we prevent dropping overlay inode if upper inode is
 > inode_is_open_for_write()?
 >=20
 > About re-dirty, see below...
 >=20
 > >
 > >  > ovl_sync_fs() can iterate the maybe-dirty list and re-dirty overlay=
 inodes
 > >  > if the underlying inode is still dirty on the (!wait) pass.
 > >  >
 > >  > As for memory mapped inodes via overlayfs (which can be dirtied wit=
hout
 > >  > notifying overlayfs) I am not sure that is a big problem in practic=
e.
 > >  >
 > >
 > > Yes, it's key problem here.
 > >
 > >  > When an inode is writably mapped via ovarlayfs, you can flag the
 > >  > overlay inode with "maybe-writably-mapped" and then remove
 > >  > it from the maybe dirty list when the underlying inode is not dirty
 > >  > AND its i_writecount is 0 (checked on write_inode() and release()).
 > >  >
 > >  > Actually, there is no reason to treat writably mapped inodes and
 > >  > other dirty inodes differently - insert to suspect list on open for
 > >  > write, remove from suspect list on last release() or write_inode()
 > >  > when inode is no longer dirty and writable.

I have to say inserting to suspect list cannot prevent dropping,
thinking of the problem of previous approach that we write dirty upper
inode with current->flags & PF_MEMALLOC while evicting clean overlay inode.


 > >  >
 > >  > Did I miss anything?
 > >  >
 > >
 > > If we dirty overlay inode that means we have launched writeback mechan=
ism,
 > > so in this case, re-dirty overlay inode in time becomes important.
 > >
 >=20
 > My idea was to use the first call to ovl_sync_fs() with 'wait' false
 > to iterate the
 > maybe-dirty list and re-dirty overlay inodes whose upper is dirty.
 >=20

I'm curious how we prevent dropping of clean overlay inode with dirty upper=
?
Hold another reference during iput_final operation? in the drop_inode() or =
something
else?


 > Then in the second call to __sync_filesystem, sync_inodes_sb() will take
 > care of calling ovl_write_inode() for all the re-dirty inodes.
 >=20
 > In current code we sync ALL dirty upper fs inodes and we do not overlay
 > inodes with no reference in cache.
 >=20
 > The best code would sync only upper fs inodes dirtied by this overlay
 > and will be able to evict overlay inodes whose upper inodes are clean.
 >=20
 > The compromise code would sync only upper fs inodes dirtied by this over=
lay,
 > and would not evict overlay inodes as long as upper inodes are "open for=
 write".
 > I think its a fine compromise considering the alternatives.
 >=20
 > Is this workable?
 >=20

In your approach, the key point is how to prevent dropping overlay inode th=
at has
dirty upper and no reference but I don't understand well how to achieve it =
from
your descriptions.


Thanks,
Chengguang



