Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 940E428EB60
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 05:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgJODDW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 23:03:22 -0400
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25306 "EHLO
        sender2-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725919AbgJODDW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 23:03:22 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1602730987; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=O9N3vJ4fUIt/BxRzvsq1UhuTirFzSw0ghLg/wl0rDwGtOpX48MdQ90IrA4QULRpz0AVQh6kKhk8mAYYh5UH0Gk8Z/yVbK7sisP8qAU+shQwVQ9q3fxAGOr2cuMmftHsA4TgbdRSmi9+8CSUcvqaijWHm8U3Ohit5fnpMKYBtFqw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1602730987; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=XeYZ5hQ7JrCmA0e4AIA2ftCMhhgRjrhn51uZdq4xpTE=; 
        b=gjWkfMSwCO1+8IiNW2PO//d2N7pRiCrT7sjlLVqgg0W7Bctx8huzU3okL67GaIuOaQw4bFTz75gnX1MlWP15yj4LkaU09+sZIP6fRs047UXLzmqoCQWuJ5SED4PbZaijEtG0lt2vrYZNmQoOhi+F0RWN9hjVWsq9SRMyBhKh5rI=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1602730987;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=XeYZ5hQ7JrCmA0e4AIA2ftCMhhgRjrhn51uZdq4xpTE=;
        b=eq2iV2sUa8BJ7or7BOgnhqZfOf04086WUv7kDzeMU/at4c8PRNBCx8Wr9F+KE+ST
        JitG4tdh950SynxkrcBKZtwFsnh8Oa+hIfw2L/D9H3xkQTId2aw3YnSE1ndkkt/+GCm
        JJJJScogxrC6Zg6E+kg7+ys3e4oMpaYCmhMqFvFM=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1602730985108545.0431323384952; Thu, 15 Oct 2020 11:03:05 +0800 (CST)
Date:   Thu, 15 Oct 2020 11:03:05 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Jan Kara" <jack@suse.cz>
Cc:     "miklos" <miklos@szeredi.hu>, "amir73il" <amir73il@gmail.com>,
        "linux-unionfs" <linux-unionfs@vger.kernel.org>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "cgxu519" <cgxu519@mykernel.net>
Message-ID: <1752a360692.e4f6555543384.3080516622688985279@mykernel.net>
In-Reply-To: <20201014161538.GA27613@quack2.suse.cz>
References: <20201010142355.741645-1-cgxu519@mykernel.net>
 <20201010142355.741645-2-cgxu519@mykernel.net> <20201014161538.GA27613@quack2.suse.cz>
Subject: Re: [RFC PATCH 1/5] fs: introduce notifier list for vfs inode
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: ZohoCN Mail
X-Mailer: ZohoCN Mail
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E5=9B=9B, 2020-10-15 00:15:38 Jan Kara <=
jack@suse.cz> =E6=92=B0=E5=86=99 ----
 > On Sat 10-10-20 22:23:51, Chengguang Xu wrote:
 > > Currently there is no notification api for kernel about modification
 > > of vfs inode, in some use cases like overlayfs, this kind of notificat=
ion
 > > will be very helpful to implement containerized syncfs functionality.
 > > As the first attempt, we introduce marking inode dirty notification so=
 that
 > > overlay's inode could mark itself dirty as well and then only sync dir=
ty
 > > overlay inode while syncfs.
 > >=20
 > > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
 >=20
 > So I like how the patch set is elegant however growing struct inode for
 > everybody by struct blocking_notifier_head (which is rwsem + pointer) is
 > rather harsh just for this overlayfs functionality... Ideally this shoul=
d
 > induce no overhead on struct inode if the filesystem is not covered by
 > overlayfs. So I'd rather place some external structure into the superblo=
ck
 > that would get allocated on the first use that would track dirty notific=
ations
 > for each inode. I would not generalize the code for more possible
 > notifications at this point.
 >=20
 > Also now that I'm thinking about it can there be multiple overlayfs inod=
es
 > for one upper inode? If not, then the mechanism of dirtiness propagation

One upper inode only belongs to one overlayfs inode. However, in practice
one upper fs may contains hundreds or even thousands of overlayfs instances=
.

 > could be much simpler - it seems we could be able to just lookup
 > corresponding overlayfs inode based on upper inode and then mark it dirt=
y
 > (but this would need to be verified by people more familiar with
 > overlayfs). So all we'd need to know for this is the superblock of the
 > overlayfs that's covering given upper filesystem...
 >=20

So the difficulty is how we get overlayfs inode efficiently from upper inod=
e,
it seems if we don't have additional info of upper inode to indicate which
overlayfs it belongs to,  then the lookup of corresponding overlayfs inode
will be quite expensive and probably impact write performance.=20

Is that possible we extend inotify infrastructure slightly to notify both
user space and kernel component?


Thanks,
Chengguang
