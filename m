Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 703244255D7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 16:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242212AbhJGOzi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 10:55:38 -0400
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25328 "EHLO
        sender2-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242165AbhJGOzi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 10:55:38 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1633618384; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=DDDHZlDWo+5WO3B+uN7PiJMZPS3Ma7R8eSk3Xg4n+RImp0vrhVIH/lgMHgaBBXCbWfmeknC8tkvansvD/nIHZeo23Q5ZiFZhjaE3Li1G3D7WLJVT4lKy/TDANoXDPbp4cX2gW8NRbrOMyuh0y8hpkP4XOItYVyR8r4Jx6A23l/g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1633618384; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=ALDuNPX38fhXXa+zXpsu/pg/N+jdzTq1/9LsmnJf8oE=; 
        b=haXNF92PhlygjHFnDrGa6rVw41FF+NYWBVcGSIOj245/euJunAMDZ0FtCi8/xZR0q5WVeZ1jqPVxFzJzGVeunxSp2s/FlueHR9QDc3Huh97+PfdRf64864HsXSURh44MShece1Q3ox7SAdug+8CYVl1YSMTdOZnCP5dOPhjMVnw=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1633618384;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=ALDuNPX38fhXXa+zXpsu/pg/N+jdzTq1/9LsmnJf8oE=;
        b=L+O1RDm1I3OpdzH0D6CTw2wyfU0dcaZteD/O29Fd2o5YjEBSNkNtABol0C1uMzkw
        cN6FztZZ0n4UUz0GE8ioNGnhLjZInMABhE0MeHBypVJ5MiTqps70yMIZSYETjf3+X00
        aT/mbHhLtTu1QzgX834N4qvEKiHtScX14z7z+UtI=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1633618382638215.82362575268553; Thu, 7 Oct 2021 22:53:02 +0800 (CST)
Date:   Thu, 07 Oct 2021 22:53:02 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Jan Kara" <jack@suse.cz>, "Miklos Szeredi" <miklos@szeredi.hu>
Cc:     "Amir Goldstein" <amir73il@gmail.com>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "overlayfs" <linux-unionfs@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <17c5b3e4f2b.113dc38cd26071.2800661599712778589@mykernel.net>
In-Reply-To: <20211007144646.GL12712@quack2.suse.cz>
References: <20210923130814.140814-1-cgxu519@mykernel.net>
 <20210923130814.140814-7-cgxu519@mykernel.net>
 <CAJfpeguqj2vst4Zj5EovSktJkXiDSCSWY=X12X0Yrz4M8gPRmQ@mail.gmail.com>
 <17c5aba1fef.c5c03d5825886.6577730832510234905@mykernel.net>
 <CAJfpegtr1NkOiY9YWd1meU1yiD-LFX-aB55UVJs94FrX0VNEJQ@mail.gmail.com>
 <17c5adfe5ea.12f1be94625921.4478415437452327206@mykernel.net>
 <CAJfpegt4jZpSCXGFk2ieqUXVm3m=ng7QtSzZp2bXVs07bfrbXg@mail.gmail.com> <20211007144646.GL12712@quack2.suse.cz>
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

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E5=9B=9B, 2021-10-07 22:46:46 Jan Kara <=
jack@suse.cz> =E6=92=B0=E5=86=99 ----
 > On Thu 07-10-21 15:34:19, Miklos Szeredi wrote:
 > > On Thu, 7 Oct 2021 at 15:10, Chengguang Xu <cgxu519@mykernel.net> wrot=
e:
 > > >  > However that wasn't what I was asking about.  AFAICS ->write_inod=
e()
 > > >  > won't start write back for dirty pages.   Maybe I'm missing somet=
hing,
 > > >  > but there it looks as if nothing will actually trigger writeback =
for
 > > >  > dirty pages in upper inode.
 > > >  >
 > > >
 > > > Actually, page writeback on upper inode will be triggered by overlay=
fs ->writepages and
 > > > overlayfs' ->writepages will be called by vfs writeback function (i.=
e writeback_sb_inodes).
 > >=20
 > > Right.
 > >=20
 > > But wouldn't it be simpler to do this from ->write_inode()?
 >=20
 > You could but then you'd have to make sure you have I_DIRTY_SYNC always =
set
 > when I_DIRTY_PAGES is set on the upper inode so that your ->write_inode(=
)
 > callback gets called. Overall I agree the logic would be probably simple=
r.
 >=20

Hi Jan, Miklos

Thnaks for your suggestions. Let me have a try in next version.


Thanks,
Chengguang
