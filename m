Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6B635D52A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Apr 2021 04:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241002AbhDMCOj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Apr 2021 22:14:39 -0400
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25304 "EHLO
        sender2-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239254AbhDMCOj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Apr 2021 22:14:39 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1618280047; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=T4MaCSudNEtndU8u98W1zkmY6SPQiGwHtzV8gpCUO7oEgwrOn41LAAASvnQoorPJjO405H5G2Eezi3cen3+KF5Tb5XsUE5sVVeyWLKmk+4vM+8Ht1OlbyCb/HnbB7ETegB3IYPk+VbkiSPRgkavdrmatfpkZk4HNkUgYZprBnlI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1618280047; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=QfEE3GeQ2y8jkajBXmU9OhellyZGKOuAfHuTC8ZUNd0=; 
        b=Sjn+x9kM3fJ82C9V+1dA/t2ZOc4q7yP23ApoZbMmjFDMZxdSnBPhhRXRqFYka3RevplTEcselluOmNxx682MvSS8bg9xeWM9R8n1f+GJSlIoUQTmIx+HIPkoTxB10dFA+Cxm0BgCBfyOJ/m/3K5n6kJp7xm4Dtp3xS6fl6JukoA=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1618280047;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=QfEE3GeQ2y8jkajBXmU9OhellyZGKOuAfHuTC8ZUNd0=;
        b=ZMPIyw3rYvRGao8v9OmNpnTWrgjoWmfDyDcP8j7IfUVodwZKhRK1juAzNaEMLtPN
        3blKsudY632CfWZQVtsy/mHKP2ZcD0eWzUyq5PhoPmDJTgbEuv9m+Zg/Vn6OzrvvYeI
        TYKTzZk+tTsNj3aVYsrA78djZV5PoLCI7saeEvnI=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1618280044464418.17248206147053; Tue, 13 Apr 2021 10:14:04 +0800 (CST)
Date:   Tue, 13 Apr 2021 10:14:04 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Miklos Szeredi" <miklos@szeredi.hu>
Cc:     "Jan Kara" <jack@suse.cz>, "Amir Goldstein" <amir73il@gmail.com>,
        "overlayfs" <linux-unionfs@vger.kernel.org>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>
Message-ID: <178c901d7ad.fdc7d65c21509.6849935952336944935@mykernel.net>
In-Reply-To: <CAJfpegtpD5012YQsmFEbkj__x52N4QrV0jSi=7iZtREqVf3tcA@mail.gmail.com>
References: <20201113065555.147276-1-cgxu519@mykernel.net> <20201113065555.147276-8-cgxu519@mykernel.net> <CAJfpegtpD5012YQsmFEbkj__x52N4QrV0jSi=7iZtREqVf3tcA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 7/9] ovl: cache dirty overlayfs' inode
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: ZohoCN Mail
X-Mailer: ZohoCN Mail
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=94, 2021-04-09 21:50:35 Miklos Sze=
redi <miklos@szeredi.hu> =E6=92=B0=E5=86=99 ----
 > On Fri, Nov 13, 2020 at 7:57 AM Chengguang Xu <cgxu519@mykernel.net> wro=
te:
 > >
 > > Now drop overlayfs' inode will sync dirty data,
 > > so we change to only drop clean inode.
 >=20
 > I don't understand what happens here.  Please add more explanation.

In iput_final(), clean overlayfs inode will directly drop as the same as be=
fore,
dirty overlayfs inode will keep in the cache to wait writeback to sync dirt=
y data
and then add to lru list to wait reclaim.

The purpose of doing this is to keep compatible behavior with original one,
because without this series, dropping overlayfs inode will not trigger sync=
ing
underlying dirty inode.


Thanks,
Chengguang
