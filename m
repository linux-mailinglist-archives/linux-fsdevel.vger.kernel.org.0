Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A3B4644F8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Dec 2021 03:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346177AbhLAClR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Nov 2021 21:41:17 -0500
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25310 "EHLO
        sender2-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241261AbhLAClR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Nov 2021 21:41:17 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1638326237; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=HkED0vDVF5r5eNU/RMzPpFjgb+jLyK2S1yeTFcyZ39gw3hYBWKEXZ83D+rPND6be12eDjsDoQVcscYDnj0F62xWUOlYdzl8zWrPdNHDvZlVK9PZJ626upUvSi7C8C9WAGQfs9D2/bcr1y95QgZSu4SP3opizlw2A9+TvxjtJVwo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1638326237; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=7jJKWu1DhTE7fcd9TsgzGaE4zZchWQhQsli4rX59K3A=; 
        b=IarhBYNzodBkcf75v9dxmbm8OaQksaem/6A0TKLYnFjGNgqn32lqdrOSyrqBmKTjNZKExTUbGklpk1d9jWzvCSaaVuZA3O3w39RPxBcLH48ryVF2I+OQQ/tyaqX9DScemUA01ncAKPDYOgeF8rfeNgOhmUTqVnbCSYfRSUP726U=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1638326237;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=7jJKWu1DhTE7fcd9TsgzGaE4zZchWQhQsli4rX59K3A=;
        b=cFER/EAahkCmUSK2sjla2BeePezgHuw0YTrjd+nj6bpXuOVrDlcdqhe4jtJz+yBR
        uXPDJs5c99jKsltJHI0HqzUyV7BdHJBVagiWjsJpwoYScbjhvlptHVd50+OYUDdmwNs
        /7uoCRXKK10jkYiXECG/XBc8dKfAq4Oz2yzzsBmU=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1638326235185468.52864776275817; Wed, 1 Dec 2021 10:37:15 +0800 (CST)
Date:   Wed, 01 Dec 2021 10:37:15 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Amir Goldstein" <amir73il@gmail.com>
Cc:     "Jan Kara" <jack@suse.cz>, "Miklos Szeredi" <miklos@szeredi.hu>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "overlayfs" <linux-unionfs@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "ronyjin" <ronyjin@tencent.com>,
        "charliecgxu" <charliecgxu@tencent.com>,
        "Vivek Goyal" <vgoyal@redhat.com>
Message-ID: <17d73da701b.e571c37220081.6904057835107693340@mykernel.net>
In-Reply-To: <CAOQ4uxidK-yDMZoZtoRwTZLgSTr1o2Mu2L55vJRNJDLV0-Sb1w@mail.gmail.com>
References: <17c5adfe5ea.12f1be94625921.4478415437452327206@mykernel.net>
 <CAJfpegt4jZpSCXGFk2ieqUXVm3m=ng7QtSzZp2bXVs07bfrbXg@mail.gmail.com>
 <17d268ba3ce.1199800543649.1713755891767595962@mykernel.net>
 <CAJfpegttQreuuD_jLgJmrYpsLKBBe2LmB5NSj6F5dHoTzqPArw@mail.gmail.com>
 <17d2c858d76.d8a27d876510.8802992623030721788@mykernel.net>
 <17d31bf3d62.1119ad4be10313.6832593367889908304@mykernel.net>
 <20211118112315.GD13047@quack2.suse.cz> <17d32ecf46e.124314f8f672.8832559275193368959@mykernel.net>
 <20211118164349.GB8267@quack2.suse.cz> <17d36d37022.1227b6f102736.1047689367927335302@mykernel.net>
 <20211130112206.GE7174@quack2.suse.cz> <17d719b79f9.d89bf95117881.5882353172682156775@mykernel.net> <CAOQ4uxidK-yDMZoZtoRwTZLgSTr1o2Mu2L55vJRNJDLV0-Sb1w@mail.gmail.com>
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


 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=B8=89, 2021-12-01 03:04:59 Amir Golds=
tein <amir73il@gmail.com> =E6=92=B0=E5=86=99 ----
 > >  > I was thinking about this a bit more and I don't think I buy this
 > >  > explanation. What I rather think is happening is that real work for=
 syncfs
 > >  > (writeback_inodes_sb() and sync_inodes_sb() calls) gets offloaded t=
o a flush
 > >  > worker. E.g. writeback_inodes_sb() ends up calling
 > >  > __writeback_inodes_sb_nr() which does:
 > >  >
 > >  > bdi_split_work_to_wbs()
 > >  > wb_wait_for_completion()
 > >  >
 > >  > So you don't see the work done in the times accounted to your test
 > >  > program. But in practice the flush worker is indeed burning 1.3s wo=
rth of
 > >  > CPU to scan the 1 million inode list and do nothing.
 > >  >
 > >
 > > That makes sense. However, in real container use case,  the upper dir =
is always empty,
 > > so I don't think there is meaningful difference compare to accurately =
marking overlay
 > > inode dirty.
 > >
 >=20
 > It's true the that is a very common case, but...
 >=20
 > > I'm not very familiar with other use cases of overlayfs except contain=
er, should we consider
 > > other use cases? Maybe we can also ignore the cpu burden because those=
 use cases don't
 > > have density deployment like container.
 > >
 >=20
 > metacopy feature was developed for the use case of a container
 > that chowns all the files in the lower image.
 >=20
 > In that case, which is now also quite common, all the overlay inodes are
 > upper inodes.
 >=20

Regardless of metacopy or datacopy, that copy-up has already modified overl=
ay inode
so initialy marking dirty to all overlay inodes which have upper inode will=
 not be a serious
problem in this case too, right?

I guess maybe you more concern about the re-mark dirtiness on above use cas=
e.



 > What about only re-mark overlay inode dirty if upper inode is dirty or i=
s
 > writeably mmapped.
 > For other cases, it is easy to know when overlay inode becomes dirty?
 > Didn't you already try this?
 >=20

Yes, I've tried that approach in previous version but as Miklos pointed out=
 in the
feedback there are a few of racy conditions.



Thanks,
Chengguang




