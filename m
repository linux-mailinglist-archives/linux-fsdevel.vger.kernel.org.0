Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79F9A4503DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Nov 2021 12:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhKOL6u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Nov 2021 06:58:50 -0500
Received: from sender3-op-o12.zoho.com.cn ([124.251.121.243]:17276 "EHLO
        sender3-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229613AbhKOL6l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Nov 2021 06:58:41 -0500
X-Greylist: delayed 955 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Nov 2021 06:58:40 EST
ARC-Seal: i=1; a=rsa-sha256; t=1636976377; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=aUnp4H6QX9VcHeA7c4RukbCsQKy36J6+ny1xmly4vRu+i3w9fEBepRU39n0qPuErHJw8cK5npkr8CUSROtyNlK7kX1b3/PI2gAUDrZ3x4Fcdw3oZJRhrMM++MUPIIPXepd5CNSre0ardZwCwlEF/8yaCEzc2svaUP0NbiTjTGGQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1636976377; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=zjH/uFgyaW5ns3imYgu5Ys7Ojv3UneKOmCTaKuDKr+k=; 
        b=Jib3FJvVjdkFw2vnQbVpVViX45yBLRfzOUcckd8aXH//TT8DrdBg0em4F4HYpNGmSieQYiZXEn8xT4VHQO786jukJ3anqE02Ai2x22a8CaVg7VtAf0fYRqM5BBRt/s4vhVZ+4sFeWJFAi+2o0ButfdtUOks/5mOQDRK2l6hy0us=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1636976377;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=zjH/uFgyaW5ns3imYgu5Ys7Ojv3UneKOmCTaKuDKr+k=;
        b=RE07lEIk8fOhlYN7heLD5nBd/W9BgnH6q+5fZY2Q3CNNsi208wSkWx4LKEOyr/1h
        VM44TG6EHoB3b8DJIGNI/zyDMtoR8ar0PXc1XBDKSTs1Mt3pWDuYmENhQDeGbJc7IdQ
        eIz6GhiUr81dwzmjHfTZYMpY5RxzmnE1dzam6y/A=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1636976375951813.331584415134; Mon, 15 Nov 2021 19:39:35 +0800 (CST)
Date:   Mon, 15 Nov 2021 19:39:35 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Amir Goldstein" <amir73il@gmail.com>
Cc:     "Miklos Szeredi" <miklos@szeredi.hu>, "Jan Kara" <jack@suse.cz>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "overlayfs" <linux-unionfs@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <17d2365388e.10ca295a42584.1997095568982277851@mykernel.net>
In-Reply-To: <CAOQ4uxj4no4zHaOKSXyefUpP+JuMsjeuMPzpZ8BAm1xrs2h+Aw@mail.gmail.com>
References: <20210923130814.140814-1-cgxu519@mykernel.net> <20210923130814.140814-10-cgxu519@mykernel.net> <CAOQ4uxj4no4zHaOKSXyefUpP+JuMsjeuMPzpZ8BAm1xrs2h+Aw@mail.gmail.com>
Subject: Re: [RFC PATCH v5 09/10] fs: introduce new helper
 sync_fs_and_blockdev()
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: ZohoCN Mail
X-Mailer: ZohoCN Mail
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=8C, 2021-10-19 15:15:28 Amir Golds=
tein <amir73il@gmail.com> =E6=92=B0=E5=86=99 ----
 > On Thu, Sep 23, 2021 at 4:08 PM Chengguang Xu <cgxu519@mykernel.net> wro=
te:
 > >
 > > Overlayfs needs to call upper layer's ->sync_fs
 > > and __sync_blockdev() to sync metadata during syncfs(2).
 > >
 > > Currently, __sync_blockdev() does not export to module
 > > so introduce new helper sync_fs_and_blockdev() to wrap
 > > those operations.
 >=20
 > Heads up: looks like __sync_blockdev() will be gone soon,
 > but you will have other exported symbols that overlayfs can use
 >=20
 > https://lore.kernel.org/linux-fsdevel/20211019062530.2174626-1-hch@lst.d=
e/T/
 >=20

Hi Amir,

Thanks for the information.

Chengguang,
