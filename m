Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2CA7465C05
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Dec 2021 03:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351572AbhLBCPl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Dec 2021 21:15:41 -0500
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25304 "EHLO
        sender2-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238880AbhLBCPl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Dec 2021 21:15:41 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1638411101; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=Q4QQXAaMwNUEtSXUPPS/YOfNXlKMJk2z4qlbAR53dauC6PpZzt97NnVFlbHeUTR06reJpJtg/PJebo+bzxdosfxHex1wr/vhQ57DRJTvyjQmVwgWUIosqeVeH1QOAHsRaEE6JuEEXY3eXtMyXzySDaE6SSiqJiTiNhNRCvbVdrs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1638411101; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=+w5c16CfQO7ePlheYkXYE6GCq8jomkga+cYzxfhQ0os=; 
        b=KvbCGbE+6xmZUulLWoQVsIMlg8tqCDIQSDWC2ZLVndG62DsUn+sCEyHlXPKTRxOP3u0JJF5FpEBgYx3kDkG7sEZzFVtOtpfr47gpR07J0Ok/m0BTq+A0L5LDKdrC1FHLPSa57tZTUo7HKeOEiHbjGefeFdB82x5/dYaY7iEI+EQ=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1638411101;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=+w5c16CfQO7ePlheYkXYE6GCq8jomkga+cYzxfhQ0os=;
        b=LOm4wWadDIWLqEiRwyWkXQfsKn6meMuDEmjLsdn4uhA7mG9arUJ1I/w3AM4aKEuL
        i90TvL06DmmjJ6jJQQKj527QcqXWvXF9awzLh3zpcjM10qwl9zGVGA2r/WC9ZWG8Zja
        g/3IdM50E6baPrFzy3SBx6CgK1xgCpfQIihCN21k=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1638411099213648.9100959012884; Thu, 2 Dec 2021 10:11:39 +0800 (CST)
Date:   Thu, 02 Dec 2021 10:11:39 +0800
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
Message-ID: <17d78e95c35.ceeffaaf22655.2727336036618811041@mykernel.net>
In-Reply-To: <CAOQ4uxg6FATciQhzRifOft4gMZj15G=UA6MUiPX2n9-NR5+1Pg@mail.gmail.com>
References: <20211118112315.GD13047@quack2.suse.cz> <17d32ecf46e.124314f8f672.8832559275193368959@mykernel.net>
 <20211118164349.GB8267@quack2.suse.cz> <17d36d37022.1227b6f102736.1047689367927335302@mykernel.net>
 <20211130112206.GE7174@quack2.suse.cz> <17d719b79f9.d89bf95117881.5882353172682156775@mykernel.net>
 <CAOQ4uxidK-yDMZoZtoRwTZLgSTr1o2Mu2L55vJRNJDLV0-Sb1w@mail.gmail.com>
 <17d73da701b.e571c37220081.6904057835107693340@mykernel.net>
 <17d74b08dcd.c0e94e6320632.9167792887632811518@mykernel.net>
 <CAOQ4uxiCYFeeH8oUUNG+rDCru_1XcwB6fR2keS1C6=d_yD9XzA@mail.gmail.com>
 <20211201134610.GA1815@quack2.suse.cz> <17d76cf59ee.12f4517f122167.2687299278423224602@mykernel.net>
 <CAOQ4uxiEjGms-sKhrVDtDHSEk97Wku5oPxnmy4vVB=6yRE_Hdg@mail.gmail.com> <CAOQ4uxg6FATciQhzRifOft4gMZj15G=UA6MUiPX2n9-NR5+1Pg@mail.gmail.com>
Subject: Re: ovl_flush() behavior
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: ZohoCN Mail
X-Mailer: ZohoCN Mail
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E5=9B=9B, 2021-12-02 07:23:17 Amir Golds=
tein <amir73il@gmail.com> =E6=92=B0=E5=86=99 ----
 > > >
 > > > To be honest I even don't fully understand what's the ->flush() logi=
c in overlayfs.
 > > > Why should we open new underlying file when calling ->flush()?
 > > > Is it still correct in the case of opening lower layer first then co=
py-uped case?
 > > >
 > >
 > > The semantics of flush() are far from being uniform across filesystems=
.
 > > most local filesystems do nothing on close.
 > > most network fs only flush dirty data when a writer closes a file
 > > but not when a reader closes a file.
 > > It is hard to imagine that applications rely on flush-on-close of
 > > rdonly fd behavior and I agree that flushing only if original fd was u=
pper
 > > makes more sense, so I am not sure if it is really essential for
 > > overlayfs to open an upper rdonly fd just to do whatever the upper fs
 > > would have done on close of rdonly fd, but maybe there is no good
 > > reason to change this behavior either.
 > >
 >=20
 > On second thought, I think there may be a good reason to change
 > ovl_flush() otherwise I wouldn't have submitted commit
 > a390ccb316be ("fuse: add FOPEN_NOFLUSH") - I did observe
 > applications that frequently open short lived rdonly fds and suffered
 > undesired latencies on close().
 >=20
 > As for "changing existing behavior", I think that most fs used as
 > upper do not implement flush at all.
 > Using fuse/virtiofs as overlayfs upper is quite new, so maybe that
 > is not a problem and maybe the new behavior would be preferred
 > for those users?
 >=20

So is that mean simply redirect the ->flush request to original underlying =
realfile?


Thanks,
Chengguang

