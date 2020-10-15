Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A79CC28F071
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 12:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbgJOK5r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Oct 2020 06:57:47 -0400
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25310 "EHLO
        sender2-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726144AbgJOK5q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Oct 2020 06:57:46 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1602759420; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=H7kJtCm/qrZ0BatUPs5FYaYw3RqFkh5JDeMPDcLGoOXIs0OvRKLj3lZ60dp6rZ5mOui0PNP5g2m5YqYTsYDObRJPYH10VYH3NHXujDm0fWkcuDYheSu+VYHHoj2W275NBxKEsiROxf/PEQfNqINFXXPI2D3cbHBWSQycJu9e5Bc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1602759420; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=bD7EQfsvG3hIlxovgQzxo+XxqblY4z2H0vHWOBZPuIg=; 
        b=CK8GFwU6ZEW1L+AYLYcwDrdyiy7HKMr4vSKOKlZ6ZgWwi4oJ5pnOzA+ih77AYfojOmDT2JWhWGpWWgFPsniDaprJF27QXV489ZwzQzBlXsL9yPCEzx9j99BLqKBFKi7z6X528YT5x/YYoz/SHbU4Ih9YbdioXvBscPECzqxC6CY=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1602759420;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=bD7EQfsvG3hIlxovgQzxo+XxqblY4z2H0vHWOBZPuIg=;
        b=byUXmfZsmRk3pzHKIiYaBZyb65P7JWUw14wEhvNxf41Uk4tZd0gnbhruAZDsmWdM
        M8l7mT1SDSnvXboBUTtXqZQxWbutqx+ySTx8fRtjXJa84XqRmy6mXhzoLdlDYeFArNd
        2GGeJx0/jDWrtV87hCIUXIdXPv78BVrR2citM2Ak=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1602759418342808.4789300189692; Thu, 15 Oct 2020 18:56:58 +0800 (CST)
Date:   Thu, 15 Oct 2020 18:56:58 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Al Viro" <viro@zeniv.linux.org.uk>
Cc:     "miklos" <miklos@szeredi.hu>, "amir73il" <amir73il@gmail.com>,
        "jack" <jack@suse.cz>,
        "linux-unionfs" <linux-unionfs@vger.kernel.org>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>
Message-ID: <1752be7e1e4.c50a427c44245.2164023825568045339@mykernel.net>
In-Reply-To: <20201015045741.GP3576660@ZenIV.linux.org.uk>
References: <20201010142355.741645-1-cgxu519@mykernel.net>
 <20201010142355.741645-2-cgxu519@mykernel.net>
 <20201015032501.GO3576660@ZenIV.linux.org.uk>
 <1752a5a7164.e9a05b8943438.8099134270028614634@mykernel.net> <20201015045741.GP3576660@ZenIV.linux.org.uk>
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

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E5=9B=9B, 2020-10-15 12:57:41 Al Viro <v=
iro@zeniv.linux.org.uk> =E6=92=B0=E5=86=99 ----
 > On Thu, Oct 15, 2020 at 11:42:51AM +0800, Chengguang Xu wrote:
 > >  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E5=9B=9B, 2020-10-15 11:25:01 Al Vi=
ro <viro@zeniv.linux.org.uk> =E6=92=B0=E5=86=99 ----
 > >  > On Sat, Oct 10, 2020 at 10:23:51PM +0800, Chengguang Xu wrote:
 > >  > > Currently there is no notification api for kernel about modificat=
ion
 > >  > > of vfs inode, in some use cases like overlayfs, this kind of noti=
fication
 > >  > > will be very helpful to implement containerized syncfs functional=
ity.
 > >  > > As the first attempt, we introduce marking inode dirty notificati=
on so that
 > >  > > overlay's inode could mark itself dirty as well and then only syn=
c dirty
 > >  > > overlay inode while syncfs.
 > >  >=20
 > >  > Who's responsible for removing the crap from notifier chain?  And h=
ow does
 > >  > that affect the lifetime of inode?
 > > =20
 > > In this case, overlayfs unregisters call back from the notifier chain =
of upper inode
 > > when evicting it's own  inode. It will not affect the lifetime of uppe=
r inode because
 > > overlayfs inode holds a reference of upper inode that means upper inod=
e will not be
 > > evicted while overlayfs inode is still alive.
 >=20
 > Let me see if I've got it right:
 >     * your chain contains 1 (for upper inodes) or 0 (everything else, i.=
e. the
 > vast majority of inodes) recepients
 >     * recepient pins the inode for as long as the recepient exists
 >=20
 > That looks like a massive overkill, especially since all you are propaga=
ting is
 > dirtying the suckers.  All you really need is one bit in your inode + ha=
sh table
 > indexed by the address of struct inode (well, middle bits thereof, as us=
ual).
 > With entries embedded into overlayfs-private part of overlayfs inode.  A=
nd callback
 > to be called stored in that entry...
 >=20


Yeah, actually  that could implement the logic but I'm afraid of performanc=
e degradation
caused by lock contention of hash table in concurrent file write because in=
 practice we
build up hundreds of overlayfs instances on same underlying filesystem.

Thanks,
Chengguang

