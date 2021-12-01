Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A523C464731
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Dec 2021 07:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346950AbhLAGfC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Dec 2021 01:35:02 -0500
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25385 "EHLO
        sender2-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231871AbhLAGfB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Dec 2021 01:35:01 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1638340270; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=nc89We7fprJFJj0iCwIY36mAj57z7q9UdRyQth1WFFa0qnL868vhl8t5iWz48yERi3lLgq5jDlRPVz9JR4nImI3wudwUeA1OjoxFrLBDs6RuQIk6ReCpoU77ftgoRJV5oMmxoD1RKjdz7WuW48/Aq6SFn9KFToqe2ZdvRdYZ91o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1638340270; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=Lg5zvaMs6C2o4U/Pk9W5wVW/ymfD8HT+KVRP221yzRE=; 
        b=H11eBcDZlL8kDDFkUldkZlV2mKOu+rLIhqO3eoQTWVUEmBckLn/yJtg0YepEr6Dj1XXZEmPSJu8JZkuDIhsVpXgsVLAD5Yt7YIDRq5t1X+VR2YujdQ+8j8lkuz/Qsr/1k5xgAnsmkiU20otb4yLe+73lNjRYQVi40QN92EkbGL8=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1638340270;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=Lg5zvaMs6C2o4U/Pk9W5wVW/ymfD8HT+KVRP221yzRE=;
        b=DLqYV8FIbBgvmB6YCBxKv6e38Exl3Ac2ykTV8DlXssczk6hSw9mm14MjDiBRNIBx
        nL/qH5ZkOb/2EB/NrTAoJRY9nSFSJjcT46HNIXfJXk0Vn9kNOsE4xpOO2NY/lrWILiD
        HpkalLlvtpnaimanlnOU5UgrSaN/MeZptFuqN+og=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 163834026749220.29544718265288; Wed, 1 Dec 2021 14:31:07 +0800 (CST)
Date:   Wed, 01 Dec 2021 14:31:07 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Amir Goldstein" <amir73il@gmail.com>, "Jan Kara" <jack@suse.cz>,
        "Miklos Szeredi" <miklos@szeredi.hu>
Cc:     "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "overlayfs" <linux-unionfs@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "ronyjin" <ronyjin@tencent.com>,
        "charliecgxu" <charliecgxu@tencent.com>,
        "Vivek Goyal" <vgoyal@redhat.com>
Message-ID: <17d74b08dcd.c0e94e6320632.9167792887632811518@mykernel.net>
In-Reply-To: <17d73da701b.e571c37220081.6904057835107693340@mykernel.net>
References: <17c5adfe5ea.12f1be94625921.4478415437452327206@mykernel.net>
 <CAJfpegt4jZpSCXGFk2ieqUXVm3m=ng7QtSzZp2bXVs07bfrbXg@mail.gmail.com>
 <17d268ba3ce.1199800543649.1713755891767595962@mykernel.net>
 <CAJfpegttQreuuD_jLgJmrYpsLKBBe2LmB5NSj6F5dHoTzqPArw@mail.gmail.com>
 <17d2c858d76.d8a27d876510.8802992623030721788@mykernel.net>
 <17d31bf3d62.1119ad4be10313.6832593367889908304@mykernel.net>
 <20211118112315.GD13047@quack2.suse.cz> <17d32ecf46e.124314f8f672.8832559275193368959@mykernel.net>
 <20211118164349.GB8267@quack2.suse.cz> <17d36d37022.1227b6f102736.1047689367927335302@mykernel.net>
 <20211130112206.GE7174@quack2.suse.cz> <17d719b79f9.d89bf95117881.5882353172682156775@mykernel.net> <CAOQ4uxidK-yDMZoZtoRwTZLgSTr1o2Mu2L55vJRNJDLV0-Sb1w@mail.gmail.com> <17d73da701b.e571c37220081.6904057835107693340@mykernel.net>
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


 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=B8=89, 2021-12-01 10:37:15 Chengguang=
 Xu <cgxu519@mykernel.net> =E6=92=B0=E5=86=99 ----
 >=20
 >  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=B8=89, 2021-12-01 03:04:59 Amir Go=
ldstein <amir73il@gmail.com> =E6=92=B0=E5=86=99 ----
 >  > >  > I was thinking about this a bit more and I don't think I buy thi=
s
 >  > >  > explanation. What I rather think is happening is that real work =
for syncfs
 >  > >  > (writeback_inodes_sb() and sync_inodes_sb() calls) gets offloade=
d to a flush
 >  > >  > worker. E.g. writeback_inodes_sb() ends up calling
 >  > >  > __writeback_inodes_sb_nr() which does:
 >  > >  >
 >  > >  > bdi_split_work_to_wbs()
 >  > >  > wb_wait_for_completion()
 >  > >  >
 >  > >  > So you don't see the work done in the times accounted to your te=
st
 >  > >  > program. But in practice the flush worker is indeed burning 1.3s=
 worth of
 >  > >  > CPU to scan the 1 million inode list and do nothing.
 >  > >  >
 >  > >
 >  > > That makes sense. However, in real container use case,  the upper d=
ir is always empty,
 >  > > so I don't think there is meaningful difference compare to accurate=
ly marking overlay
 >  > > inode dirty.
 >  > >
 >  >=20
 >  > It's true the that is a very common case, but...
 >  >=20
 >  > > I'm not very familiar with other use cases of overlayfs except cont=
ainer, should we consider
 >  > > other use cases? Maybe we can also ignore the cpu burden because th=
ose use cases don't
 >  > > have density deployment like container.
 >  > >
 >  >=20
 >  > metacopy feature was developed for the use case of a container
 >  > that chowns all the files in the lower image.
 >  >=20
 >  > In that case, which is now also quite common, all the overlay inodes =
are
 >  > upper inodes.
 >  >=20
 >=20
 > Regardless of metacopy or datacopy, that copy-up has already modified ov=
erlay inode
 > so initialy marking dirty to all overlay inodes which have upper inode w=
ill not be a serious
 > problem in this case too, right?
 >=20
 > I guess maybe you more concern about the re-mark dirtiness on above use =
case.
 >=20
 >=20
 >=20
 >  > What about only re-mark overlay inode dirty if upper inode is dirty o=
r is
 >  > writeably mmapped.
 >  > For other cases, it is easy to know when overlay inode becomes dirty?
 >  > Didn't you already try this?
 >  >=20
 >=20
 > Yes, I've tried that approach in previous version but as Miklos pointed =
out in the
 > feedback there are a few of racy conditions.
 >=20

So the final solution to handle all the concerns looks like accurately mark=
 overlay inode
diry on modification and re-mark dirty only for mmaped file in ->write_inod=
e().

Hi Miklos, Jan

Will you agree with new proposal above?



Thanks,
Chengguang































