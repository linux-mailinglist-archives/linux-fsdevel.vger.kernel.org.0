Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D486228FEED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Oct 2020 09:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404286AbgJPHKb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Oct 2020 03:10:31 -0400
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25315 "EHLO
        sender2-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2394503AbgJPHKa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Oct 2020 03:10:30 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1602832180; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=R+M18zk++GMjGpjqjy1i/9byzAk4VBAAEaIdxBEVKzexNVHTzGKtJYPEQ9GHjghSLvwbQU/TbgGBnRAVYO446UvGogyNVzkPIlyuXMkhDw78Iqsgl9G3Ww3cN3L0zMpzXkA5kHAnHzRW7JIStiRtPzkM4GRzkcrI77zbnQbTarQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1602832180; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=8H9LAHFIA+AhDfpYtbj8paGnKhDwdmvRlbesaqVWxJE=; 
        b=Z3uNwqwB6hvTvmJgN6hmR/jTeVciqmoJklyX50CFUfnYxEq9vJW6BaYKupYpAoSsCBlHc7WyerXuCcWlQEb2dQWi6JiGMkiw659cH9dAL5MWegU5KcVTrZ/jr9kwF6dpOEHHZqJ3ZI0WKK3chNmHjtyMje+KyHYkzxGRxLu6kQc=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1602832180;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=8H9LAHFIA+AhDfpYtbj8paGnKhDwdmvRlbesaqVWxJE=;
        b=PfraqAf//zjp4ajJSEKpKOojTF34tSKfJHpIgkXpsooSMV8b8LIt5m6WgGiJyO15
        wl2j3cis+OcnzQMQPPO1vHEM3qSduX1SET86lftSfG6HNddwhq2evdAWRX/tQ95L9dl
        kHkg83lXheVs41w5GS82JY36ltSz+5bNOUQiRNkU=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1602832178473516.6721618998677; Fri, 16 Oct 2020 15:09:38 +0800 (CST)
Date:   Fri, 16 Oct 2020 15:09:38 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Al Viro" <viro@zeniv.linux.org.uk>,
        "amir73il" <amir73il@gmail.com>, "jack" <jack@suse.cz>
Cc:     "miklos" <miklos@szeredi.hu>,
        "linux-unionfs" <linux-unionfs@vger.kernel.org>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "cgxu519" <cgxu519@mykernel.net>
Message-ID: <175303e1d27.105ba43f146287.2025735092350714226@mykernel.net>
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

Hi AI, Jack, Amir

Based on your feedback, I would to change the inode dirty notification
something like below, is it acceptable?=20


diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 1492271..48473d9 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2249,6 +2249,14 @@ void __mark_inode_dirty(struct inode *inode, int fla=
gs)
=20
        trace_writeback_mark_inode_dirty(inode, flags);
=20
+       if (inode->state & I_OVL_INUSE) {
+               struct inode *ovl_inode;
+
+               ovl_inode =3D ilookup5(NULL, (unsigned long)inode, ovl_inod=
e_test, inode);
+               if (ovl_inode)
+                       __mark_inode_dirty(ovl_inode, flags);
+       }
+
        /*
         * Don't do this for I_DIRTY_PAGES - that doesn't actually
         * dirty the inode itself
diff --git a/fs/inode.c b/fs/inode.c
index 72c4c34..ed6c85e 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -820,7 +820,7 @@ static struct inode *find_inode(struct super_block *sb,
=20
 repeat:
        hlist_for_each_entry(inode, head, i_hash) {
-               if (inode->i_sb !=3D sb)
+               if (sb && inode->i_sb !=3D sb)
                        continue;
                if (!test(inode, data))
                        continue;


Thanks,
Chengguang
