Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89939452776
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Nov 2021 03:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344502AbhKPCZk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Nov 2021 21:25:40 -0500
Received: from sender3-pp-o92.zoho.com.cn ([124.251.121.251]:25330 "EHLO
        sender3-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1377521AbhKPCXp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Nov 2021 21:23:45 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1637029227; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=WCo8yP/Mp+vvRMy95Mg4v3McsZSGa8270Ye5eoxKFXdIeWpIVcIEoqKNuCoj7nRiSx1BxiS/NXv1CeKgm+7baolAqZz8MsLr1Cp9G5mNSFQvZM1QvJc69ua1fZL7RVr2xtfraWziYXuFzXzSBFhjXFRq69NCVzxLyxGxs94eOOU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1637029227; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=LuIJUeTMH8qUDBjjFztaebboxfRi3dEBuIBUJxcrZaY=; 
        b=PtbofILqWkQ/6H9sU+RIsfhoabeoue4z2hzfJDKBml2D7b3qyc2HBUn2iZll3TNvsHtMyyNRbQuq97IG78QPmyII7P7heATSRVFCFFxAtxGxP/1JoEWH2WlWGMpzOscPxB0eac4LCmXDP3FMjZaNiGZbZZ4HBqR20ynum1y3318=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1637029227;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=LuIJUeTMH8qUDBjjFztaebboxfRi3dEBuIBUJxcrZaY=;
        b=buVt17RAg7UqP/iPhB03nDbqZTj2Rv7wmSghkDXknkWeq6tZXaRPP/pGJCnOciiD
        FfB2CDJhC4uvHAS4GAZZ9K1Z+TG5/pDTmtEJBVdVmqgWe9lf3oOQIV+WUYD7J+t8A3y
        2WL+PUhkHRYUKmrT65klnp+U3E+ps0x7zYN/eCpM=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1637029225424575.2069224539918; Tue, 16 Nov 2021 10:20:25 +0800 (CST)
Date:   Tue, 16 Nov 2021 10:20:25 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Miklos Szeredi" <miklos@szeredi.hu>
Cc:     "Jan Kara" <jack@suse.cz>, "Amir Goldstein" <amir73il@gmail.com>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "overlayfs" <linux-unionfs@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <17d268ba3ce.1199800543649.1713755891767595962@mykernel.net>
In-Reply-To: <CAJfpegt4jZpSCXGFk2ieqUXVm3m=ng7QtSzZp2bXVs07bfrbXg@mail.gmail.com>
References: <20210923130814.140814-1-cgxu519@mykernel.net> <20210923130814.140814-7-cgxu519@mykernel.net>
 <CAJfpeguqj2vst4Zj5EovSktJkXiDSCSWY=X12X0Yrz4M8gPRmQ@mail.gmail.com>
 <17c5aba1fef.c5c03d5825886.6577730832510234905@mykernel.net>
 <CAJfpegtr1NkOiY9YWd1meU1yiD-LFX-aB55UVJs94FrX0VNEJQ@mail.gmail.com> <17c5adfe5ea.12f1be94625921.4478415437452327206@mykernel.net> <CAJfpegt4jZpSCXGFk2ieqUXVm3m=ng7QtSzZp2bXVs07bfrbXg@mail.gmail.com>
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

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E5=9B=9B, 2021-10-07 21:34:19 Miklos Sze=
redi <miklos@szeredi.hu> =E6=92=B0=E5=86=99 ----
 > On Thu, 7 Oct 2021 at 15:10, Chengguang Xu <cgxu519@mykernel.net> wrote:
 > >  > However that wasn't what I was asking about.  AFAICS ->write_inode(=
)
 > >  > won't start write back for dirty pages.   Maybe I'm missing somethi=
ng,
 > >  > but there it looks as if nothing will actually trigger writeback fo=
r
 > >  > dirty pages in upper inode.
 > >  >
 > >
 > > Actually, page writeback on upper inode will be triggered by overlayfs=
 ->writepages and
 > > overlayfs' ->writepages will be called by vfs writeback function (i.e =
writeback_sb_inodes).
 >=20
 > Right.
 >=20
 > But wouldn't it be simpler to do this from ->write_inode()?
 >=20
 > I.e. call write_inode_now() as suggested by Jan.
 >=20
 > Also could just call mark_inode_dirty() on the overlay inode
 > regardless of the dirty flags on the upper inode since it shouldn't
 > matter and results in simpler logic.
 >=20

Hi Miklos=EF=BC=8C

Sorry for delayed response for this, I've been busy with another project.

I agree with your suggesion above and further more how about just mark over=
lay inode dirty
when it has upper inode? This approach will make marking dirtiness simple e=
nough.

Thanks,
Chengguang
