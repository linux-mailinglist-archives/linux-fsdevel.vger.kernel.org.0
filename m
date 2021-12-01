Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 608D64650B3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Dec 2021 16:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350182AbhLAPEA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Dec 2021 10:04:00 -0500
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25346 "EHLO
        sender2-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350140AbhLAPD5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Dec 2021 10:03:57 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1638370778; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=byxPawvpsz9PY88EUKl47Fet4j2i0n9QeBqTTKnIlgahrNSfKqsvdRzHcnhYGhc+X1xT/7kbuIcnuQriKI6W0Wgckt5QPmyJ8+W7sNsMsgTqZjEfZwxsGpDLnhkOO8/HaMjK45w6YMxl6sDq3qF0kY8U8bpdhMy3Q7Z66ZsPcDo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1638370778; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=yJlbHNFyL+xacHgeF/Vdj133+UCdaX/2f7IuSx0T0m8=; 
        b=qdJqaAisZMhShZC+aKJranFs/1YN2ZYd4oclGnnylpL2TFuzbbB5wxJ3niyXmLfvdKAaxfLjmQfHykPvGrPS7mvXtoQ4jnnGHKfROVTUpyGvP/R8Lyn+8c1HPHevDF7LWaeoGL3dAEA+8U+Te4YiN6/DxGISwvSfkN8oGJRT15Y=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1638370778;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=yJlbHNFyL+xacHgeF/Vdj133+UCdaX/2f7IuSx0T0m8=;
        b=M4jDjnP13Mlls9qVw3F/Rjn5r6uPbDMI3i4Ca15Ba8tF5FMhVXkIMBON5FNxaiG/
        4lIoKNJ6HKXDkzyZ5Ho0wtVgk4obUNWqZBXox4WvQUU+zMHtgKpn+YUh3A8rZKBGPd/
        CdcMDAJLSVlQtlc3YSZOOknDldarQxzvEQDXHC/U=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1638370776754126.6507127138733; Wed, 1 Dec 2021 22:59:36 +0800 (CST)
Date:   Wed, 01 Dec 2021 22:59:36 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Jan Kara" <jack@suse.cz>
Cc:     "Amir Goldstein" <amir73il@gmail.com>,
        "Miklos Szeredi" <miklos@szeredi.hu>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "overlayfs" <linux-unionfs@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "ronyjin" <ronyjin@tencent.com>,
        "charliecgxu" <charliecgxu@tencent.com>,
        "Vivek Goyal" <vgoyal@redhat.com>
Message-ID: <17d76821691.c8e249b322113.2136207110726046721@mykernel.net>
In-Reply-To: <20211201134610.GA1815@quack2.suse.cz>
References: <20211118112315.GD13047@quack2.suse.cz>
 <17d32ecf46e.124314f8f672.8832559275193368959@mykernel.net>
 <20211118164349.GB8267@quack2.suse.cz>
 <17d36d37022.1227b6f102736.1047689367927335302@mykernel.net>
 <20211130112206.GE7174@quack2.suse.cz>
 <17d719b79f9.d89bf95117881.5882353172682156775@mykernel.net>
 <CAOQ4uxidK-yDMZoZtoRwTZLgSTr1o2Mu2L55vJRNJDLV0-Sb1w@mail.gmail.com>
 <17d73da701b.e571c37220081.6904057835107693340@mykernel.net>
 <17d74b08dcd.c0e94e6320632.9167792887632811518@mykernel.net>
 <CAOQ4uxiCYFeeH8oUUNG+rDCru_1XcwB6fR2keS1C6=d_yD9XzA@mail.gmail.com> <20211201134610.GA1815@quack2.suse.cz>
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

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=B8=89, 2021-12-01 21:46:10 Jan Kara <=
jack@suse.cz> =E6=92=B0=E5=86=99 ----
 > On Wed 01-12-21 09:19:17, Amir Goldstein wrote:
 > > On Wed, Dec 1, 2021 at 8:31 AM Chengguang Xu <cgxu519@mykernel.net> wr=
ote:
 > > > So the final solution to handle all the concerns looks like accurate=
ly
 > > > mark overlay inode diry on modification and re-mark dirty only for
 > > > mmaped file in ->write_inode().
 > > >
 > > > Hi Miklos, Jan
 > > >
 > > > Will you agree with new proposal above?
 > > >
 > >=20
 > > Maybe you can still pull off a simpler version by remarking dirty only
 > > writably mmapped upper AND inode_is_open_for_write(upper)?
 >=20
 > Well, if inode is writeably mapped, it must be also open for write, does=
n't
 > it?=20

That's right.


 > The VMA of the mapping will hold file open.=20

It's a bit tricky but currently ovl_mmap() will replace file to realfile in=
 upper layer
and release overlayfs file. So overlayfs file itself will not have any rela=
tionship with
the VMA anymore after mmap().


Thanks,
Chengguang


 > So remarking overlay inode
 > dirty during writeback while inode_is_open_for_write(upper) looks like
 > reasonably easy and presumably there won't be that many inodes open for
 > writing for this to become big overhead?
 >=20
 > > If I am not mistaken, if you always mark overlay inode dirty on ovl_fl=
ush()
 > > of FMODE_WRITE file, there is nothing that can make upper inode dirty
 > > after last close (if upper is not mmaped), so one more inode sync shou=
ld
 > > be enough. No?
 >=20
 > But we still need to catch other dirtying events like timestamp updates,
 > truncate(2) etc. to mark overlay inode dirty. Not sure how reliably that
 > can be done...
 >=20
 >                                 Honza
 > --=20
 > Jan Kara <jack@suse.com>
 > SUSE Labs, CR
 >=20
