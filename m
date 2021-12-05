Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 214BE468B57
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Dec 2021 15:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234759AbhLEOLc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Dec 2021 09:11:32 -0500
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25335 "EHLO
        sender2-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234681AbhLEOLc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Dec 2021 09:11:32 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1638713205; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=Pjh04aKkpVNie8eXie7ArqZYcveJ6yO9/4vbA9WsBvgt/JsBHCkXdbmwGTiKUzM2y+yV6BewgiE2ockRb68kt8K+mpKnKImneTl2/DKhcbhc44+iiYkcxA+kICNsSa5KtUfceR9MswgpY2ECxILmE5YuASdoh0ithyO2+UGPUGI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1638713205; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=WnJnhhs1cbnIWKL9y83KTn2rqy7va24PIvxGY6Xuyzc=; 
        b=IMvvACGa3zW0ts56hwYy1RIIBPjZ+WaKoC4XosdVvkRKCXGkOXY4NmaxFa6qi6UpBM3ewgtpAC75C+NSNtVMz5nn7AOs7Poi+oFr0tbWD/l4zmFJTTeNspzziBV0cmbTf/XX/b1n0Z12la0/IVupcHEafbMR2x4akGFhN1Q3+hQ=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1638713205;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=WnJnhhs1cbnIWKL9y83KTn2rqy7va24PIvxGY6Xuyzc=;
        b=cScm90w9au9fBHlByU7rncxL05tpuy46N5Gm3jac7Ii2AW6VBwimc3c3BM8cyDC4
        8PkNQxoR+0u8tcZnelC6jRRO/UM9UWJmKxUGNAvcB6SGgRXi60/ASz5JaO4jBUTXhdZ
        zHY6aajjBdFKUmqyEHUUGPe7oMMXzMeTBuhNscHk=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1638713203144575.728615583318; Sun, 5 Dec 2021 22:06:43 +0800 (CST)
Date:   Sun, 05 Dec 2021 22:06:43 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Amir Goldstein" <amir73il@gmail.com>
Cc:     "Jan Kara" <jack@suse.cz>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "overlayfs" <linux-unionfs@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "ronyjin" <ronyjin@tencent.com>,
        "charliecgxu" <charliecgxu@tencent.com>,
        "Vivek Goyal" <vgoyal@redhat.com>,
        "Miklos Szeredi" <miklos@szeredi.hu>
Message-ID: <17d8aeb19ac.f22523af26365.6531629287230366441@mykernel.net>
In-Reply-To: <CAOQ4uxiEjGms-sKhrVDtDHSEk97Wku5oPxnmy4vVB=6yRE_Hdg@mail.gmail.com>
References: <20211118112315.GD13047@quack2.suse.cz> <17d32ecf46e.124314f8f672.8832559275193368959@mykernel.net>
 <20211118164349.GB8267@quack2.suse.cz> <17d36d37022.1227b6f102736.1047689367927335302@mykernel.net>
 <20211130112206.GE7174@quack2.suse.cz> <17d719b79f9.d89bf95117881.5882353172682156775@mykernel.net>
 <CAOQ4uxidK-yDMZoZtoRwTZLgSTr1o2Mu2L55vJRNJDLV0-Sb1w@mail.gmail.com>
 <17d73da701b.e571c37220081.6904057835107693340@mykernel.net>
 <17d74b08dcd.c0e94e6320632.9167792887632811518@mykernel.net>
 <CAOQ4uxiCYFeeH8oUUNG+rDCru_1XcwB6fR2keS1C6=d_yD9XzA@mail.gmail.com>
 <20211201134610.GA1815@quack2.suse.cz> <17d76cf59ee.12f4517f122167.2687299278423224602@mykernel.net> <CAOQ4uxiEjGms-sKhrVDtDHSEk97Wku5oPxnmy4vVB=6yRE_Hdg@mail.gmail.com>
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

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E5=9B=9B, 2021-12-02 06:47:25 Amir Golds=
tein <amir73il@gmail.com> =E6=92=B0=E5=86=99 ----
 > On Wed, Dec 1, 2021 at 6:24 PM Chengguang Xu <cgxu519@mykernel.net> wrot=
e:
 > >
 > >  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=B8=89, 2021-12-01 21:46:10 Jan K=
ara <jack@suse.cz> =E6=92=B0=E5=86=99 ----
 > >  > On Wed 01-12-21 09:19:17, Amir Goldstein wrote:
 > >  > > On Wed, Dec 1, 2021 at 8:31 AM Chengguang Xu <cgxu519@mykernel.ne=
t> wrote:
 > >  > > > So the final solution to handle all the concerns looks like acc=
urately
 > >  > > > mark overlay inode diry on modification and re-mark dirty only =
for
 > >  > > > mmaped file in ->write_inode().
 > >  > > >
 > >  > > > Hi Miklos, Jan
 > >  > > >
 > >  > > > Will you agree with new proposal above?
 > >  > > >
 > >  > >
 > >  > > Maybe you can still pull off a simpler version by remarking dirty=
 only
 > >  > > writably mmapped upper AND inode_is_open_for_write(upper)?
 > >  >
 > >  > Well, if inode is writeably mapped, it must be also open for write,=
 doesn't
 > >  > it? The VMA of the mapping will hold file open. So remarking overla=
y inode
 > >  > dirty during writeback while inode_is_open_for_write(upper) looks l=
ike
 > >  > reasonably easy and presumably there won't be that many inodes open=
 for
 > >  > writing for this to become big overhead?
 >=20
 > I think it should be ok and a good tradeoff of complexity vs. performanc=
e.

IMO, mark dirtiness on write is relatively simple, so I think we can mark t=
he=20
overlayfs inode dirty during real write behavior and only remark writable m=
map
unconditionally in ->write_inode().


 >=20
 > >  >
 > >  > > If I am not mistaken, if you always mark overlay inode dirty on o=
vl_flush()
 > >  > > of FMODE_WRITE file, there is nothing that can make upper inode d=
irty
 > >  > > after last close (if upper is not mmaped), so one more inode sync=
 should
 > >  > > be enough. No?
 > >  >
 > >  > But we still need to catch other dirtying events like timestamp upd=
ates,
 > >  > truncate(2) etc. to mark overlay inode dirty. Not sure how reliably=
 that
 > >  > can be done...
 > >  >
 >=20
 > Oh yeh, we have those as well :)
 > All those cases should be covered by ovl_copyattr() that updates the
 > ovl inode ctime/mtime, so always dirty in ovl_copyattr() should be good.

Currently ovl_copyattr() does not cover all the cases, so I think we still =
need to carefully
check all the places of calling mnt_want_write().


Thanks,
Chengguang



 > I *think* the only case of ovl_copyattr() that should not dirty is in
 > ovl_inode_init(), so need some special helper there.
 >=20
 > >
 > > To be honest I even don't fully understand what's the ->flush() logic =
in overlayfs.
 > > Why should we open new underlying file when calling ->flush()?
 > > Is it still correct in the case of opening lower layer first then copy=
-uped case?
 > >
 >=20
 > The semantics of flush() are far from being uniform across filesystems.
 > most local filesystems do nothing on close.
 > most network fs only flush dirty data when a writer closes a file
 > but not when a reader closes a file.
 > It is hard to imagine that applications rely on flush-on-close of
 > rdonly fd behavior and I agree that flushing only if original fd was upp=
er
 > makes more sense, so I am not sure if it is really essential for
 > overlayfs to open an upper rdonly fd just to do whatever the upper fs
 > would have done on close of rdonly fd, but maybe there is no good
 > reason to change this behavior either.
 >=20
 > Thanks,
 > Amir.
 >=20
