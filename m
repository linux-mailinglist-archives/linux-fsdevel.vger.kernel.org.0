Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 005804540AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Nov 2021 07:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbhKQGOq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Nov 2021 01:14:46 -0500
Received: from sender3-pp-o92.zoho.com.cn ([124.251.121.251]:25328 "EHLO
        sender3-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229632AbhKQGOp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Nov 2021 01:14:45 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1637129490; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=mxk3aax3nsywqc5mT59ijhnvyxe0SGv9swJ+Ij8uZiGWX3VtVXQav5YFykTJS5TSf/jqX8tdiGXEINV1g3EEBgSLPfo6TQl15QcWZkXWchiy2zjeZko/yk7nfxPKSh1MSAI69ArodTtVuJ9MHxe4/wq/Mydd9JUtlgKmyR09YY8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1637129490; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=rfxVLTH3564AhzBpdXSLlUU2L9D17YJOYA+HFb4ouvw=; 
        b=hfL+PRXqKOtQJ6ohcayTXzhPFh0hlaa4TOAiyZAI21cGnZ5/LbMVHJWUNQeL9szSKWUrm1MY5HMouYSZFFbhTV0P0Sh762Yb2iWLoYPinoJhywecK0w+VDU3nCQ/g0WJgygjIM8e2usviYGAXFH9z1geO48IqNrooBmRfN4owIY=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1637129490;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=rfxVLTH3564AhzBpdXSLlUU2L9D17YJOYA+HFb4ouvw=;
        b=VBo1wrw2RvH4FjSyhldbTQ9LUE18HTagC6XlwQ1KA/GF5BVPxi8ZFxOOmdSSwvAR
        aPDY9jOXjk5U3kkIC2tAlB2E5/1uXnR41FkKFlVPs1Zv2xZRVj6g7PL15mRGfoouelv
        F0j9lAb9Sb34DpPr2g8e21H2yAQml68dZh/XRIwE=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 163712948978472.95351357724451; Wed, 17 Nov 2021 14:11:29 +0800 (CST)
Date:   Wed, 17 Nov 2021 14:11:29 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Miklos Szeredi" <miklos@szeredi.hu>
Cc:     "Jan Kara" <jack@suse.cz>, "Amir Goldstein" <amir73il@gmail.com>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "overlayfs" <linux-unionfs@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <17d2c858d76.d8a27d876510.8802992623030721788@mykernel.net>
In-Reply-To: <CAJfpegttQreuuD_jLgJmrYpsLKBBe2LmB5NSj6F5dHoTzqPArw@mail.gmail.com>
References: <20210923130814.140814-1-cgxu519@mykernel.net> <20210923130814.140814-7-cgxu519@mykernel.net>
 <CAJfpeguqj2vst4Zj5EovSktJkXiDSCSWY=X12X0Yrz4M8gPRmQ@mail.gmail.com>
 <17c5aba1fef.c5c03d5825886.6577730832510234905@mykernel.net>
 <CAJfpegtr1NkOiY9YWd1meU1yiD-LFX-aB55UVJs94FrX0VNEJQ@mail.gmail.com>
 <17c5adfe5ea.12f1be94625921.4478415437452327206@mykernel.net>
 <CAJfpegt4jZpSCXGFk2ieqUXVm3m=ng7QtSzZp2bXVs07bfrbXg@mail.gmail.com> <17d268ba3ce.1199800543649.1713755891767595962@mykernel.net> <CAJfpegttQreuuD_jLgJmrYpsLKBBe2LmB5NSj6F5dHoTzqPArw@mail.gmail.com>
Subject: Re: [RFC PATCH v5 06/10] ovl: implement overlayfs' ->write_inode
 operation
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: ZohoCN Mail
X-Mailer: ZohoCN Mail
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=8C, 2021-11-16 20:35:55 Miklos Sze=
redi <miklos@szeredi.hu> =E6=92=B0=E5=86=99 ----
 > On Tue, 16 Nov 2021 at 03:20, Chengguang Xu <cgxu519@mykernel.net> wrote=
:
 > >
 > >  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E5=9B=9B, 2021-10-07 21:34:19 Miklo=
s Szeredi <miklos@szeredi.hu> =E6=92=B0=E5=86=99 ----
 > >  > On Thu, 7 Oct 2021 at 15:10, Chengguang Xu <cgxu519@mykernel.net> w=
rote:
 > >  > >  > However that wasn't what I was asking about.  AFAICS ->write_i=
node()
 > >  > >  > won't start write back for dirty pages.   Maybe I'm missing so=
mething,
 > >  > >  > but there it looks as if nothing will actually trigger writeba=
ck for
 > >  > >  > dirty pages in upper inode.
 > >  > >  >
 > >  > >
 > >  > > Actually, page writeback on upper inode will be triggered by over=
layfs ->writepages and
 > >  > > overlayfs' ->writepages will be called by vfs writeback function =
(i.e writeback_sb_inodes).
 > >  >
 > >  > Right.
 > >  >
 > >  > But wouldn't it be simpler to do this from ->write_inode()?
 > >  >
 > >  > I.e. call write_inode_now() as suggested by Jan.
 > >  >
 > >  > Also could just call mark_inode_dirty() on the overlay inode
 > >  > regardless of the dirty flags on the upper inode since it shouldn't
 > >  > matter and results in simpler logic.
 > >  >
 > >
 > > Hi Miklos=EF=BC=8C
 > >
 > > Sorry for delayed response for this, I've been busy with another proje=
ct.
 > >
 > > I agree with your suggesion above and further more how about just mark=
 overlay inode dirty
 > > when it has upper inode? This approach will make marking dirtiness sim=
ple enough.
 >=20
 > Are you suggesting that all non-lower overlay inodes should always be di=
rty?
 >=20
 > The logic would be simple, no doubt, but there's the cost to walking
 > those overlay inodes which don't have a dirty upper inode, right? =20

That's true.

 > Can you quantify this cost with a benchmark?  Can be totally synthetic,
 > e.g. lookup a million upper files without modifying them, then call
 > syncfs.
 >=20

No problem, I'll do some tests for the performance.

Thanks,
Chengguang
