Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E00D81D4816
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 10:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgEOI0k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 04:26:40 -0400
Received: from sender2-of-o52.zoho.com.cn ([163.53.93.247]:21152 "EHLO
        sender2-of-o52.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726727AbgEOI0k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 04:26:40 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589531144; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=ixFbuSBPPVCG6ruwRqaLDPMMYnO3GDMoccu9a2/5uxO0Iawht3Aa7XEGc8qvWutIF5YD4Yf1dv7GBXgS+OUWyFVtvzM1YWdCSzSZrRNCHv/qcbYSpQSarmwqWQUemHuIOukWfzBz69xS3a4mZ3uJf2oKmm7YYw0VG4rkTGid1wg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1589531144; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=v1j7yEUJl56Wd+AibdnWdMvB5tgV4YAFK3rS7smIP0g=; 
        b=Yo6KoS5jfWndY1sPxgn2P3MS8BjC2kPHNglNzvW/Kr8IJNWUoBdHvq3PybPKe1cJMnm6wN8RN5zr9njVeNzqUYmT4bCZAjk+CvkEifo6mHPBVZcsMJpjGb8ENbo697GmyZC19NbtwPFhuG/cw/gFJzaV/cX96MKUJKDuzvKqbWM=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1589531144;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=v1j7yEUJl56Wd+AibdnWdMvB5tgV4YAFK3rS7smIP0g=;
        b=TI33a0FFY0CCfXG7PMfm8QQgL08VL1d+0dpF0IHSw32OU0zUnsPh9vFScdP3Nap2
        rJnvF5SH2ItAkWXgCfArrFYw474F0CYXOG5Cwc0+F+DuCeYgw4r+9WNCGDLocNNLfhs
        7KJcdt1ZMYxwDPYacblo57I3BxF3U1afYnqnZ9go=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1589531142535211.24543515194716; Fri, 15 May 2020 16:25:42 +0800 (CST)
Date:   Fri, 15 May 2020 16:25:42 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Amir Goldstein" <amir73il@gmail.com>
Cc:     "Miklos Szeredi" <miklos@szeredi.hu>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "overlayfs" <linux-unionfs@vger.kernel.org>
Message-ID: <17217706984.f5e20fe88512.8363313618084688988@mykernel.net>
In-Reply-To: <CAOQ4uxhytw8YPY5WR+txeeHhuO+Hvr0eDFuKOahrN_htXtH_rA@mail.gmail.com>
References: <20200515072047.31454-1-cgxu519@mykernel.net> <CAOQ4uxhytw8YPY5WR+txeeHhuO+Hvr0eDFuKOahrN_htXtH_rA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/9] Suppress negative dentry
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: ZohoCN Mail
X-Mailer: ZohoCN Mail
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=94, 2020-05-15 15:30:27 Amir Golds=
tein <amir73il@gmail.com> =E6=92=B0=E5=86=99 ----
 > On Fri, May 15, 2020 at 10:21 AM Chengguang Xu <cgxu519@mykernel.net> wr=
ote:
 > >
 > > This series adds a new lookup flag LOOKUP_DONTCACHE_NEGATIVE
 > > to indicate to drop negative dentry in slow path of lookup.
 > >
 > > In overlayfs, negative dentries in upper/lower layers are useless
 > > after construction of overlayfs' own dentry, so in order to
 > > effectively reclaim those dentries, specify LOOKUP_DONTCACHE_NEGATIVE
 > > flag when doing lookup in upper/lower layers.
 > >
 > > Patch 1 adds flag LOOKUP_DONTCACHE_NEGATIVE and related logic in vfs l=
ayer.
 > > Patch 2 does lookup optimazation for overlayfs.
 > > Patch 3-9 just adjusts function argument when calling
 > > lookup_positive_unlocked() and lookup_one_len_unlocked().
 >=20
 > Hmm you cannot do that, build must not be broken mid series.
 > When Miklos said split he meant to patch 1 and 2.
 > Patch 1 must convert all callers to the new argument list,
 > at which point all overlayfs calls are with 0 flags.
 >=20
 > Once that's done, you may add:
 > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
 >=20

OK, I got it, I'll still wait for a while in case of other feedbacks.

Miklos, AI

I'm not sure this series will go into whose tree in the end,=20
so I just rebased on current linus-tree, any suggestion for the code base?

Thanks,
cgxu



