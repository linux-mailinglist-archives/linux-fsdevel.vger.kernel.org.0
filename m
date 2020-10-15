Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3A528EBB4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 05:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbgJODnq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 23:43:46 -0400
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25320 "EHLO
        sender2-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727281AbgJODnq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 23:43:46 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1602733374; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=glihQqZHOWEanX82GEQUt1QvPdrkmls0lPHtbBpbRWFgxKTypLMPv2tECuftevG8C+f9NjlGpI0mjss9lPGHnoG4L4xYqgNfku7qQd04ilko8bchB5z18XqTWN77D4uME0X259x5HZGNeEyhRYpk4cStgbFI4tUoYMWjnb0qiJ8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1602733374; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=gM+h3UABq11r8FW6zPR1UVWPjXGD5LCom+7Ae3jDVuA=; 
        b=gS8OQhrTSC/O0EgpiecF1OalTqKjzyBEKD/cRo6F3lHdMlSIHkXjIFJU5xPuANBUo7VaEufjMP6e51ruk62vOAaLEvXwKSpbB5LFhS31tjluczUuCrU2NKCuG0fczVwNO5yNgAiDoXoDKnQ+H5h9uL3PxMk3VNLg9R8JU9ujGkE=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1602733374;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=gM+h3UABq11r8FW6zPR1UVWPjXGD5LCom+7Ae3jDVuA=;
        b=UAFxCW3iwtWx0fwbR+oI79bsV2JPIokYXjgzTimZMvke/+qZO4/VHQaAKhJFMj6m
        7EWX4RT5RYxKYeaa3jwG54wxRBUARTJEFxzr991qB6U42gqxayMQUxCpCJDZOA0QMtP
        I7peKhFAr2Wzmi5rvXZxEV3+xI+kc9CSMbG/6KgI=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1602733371751111.20093810371054; Thu, 15 Oct 2020 11:42:51 +0800 (CST)
Date:   Thu, 15 Oct 2020 11:42:51 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Al Viro" <viro@zeniv.linux.org.uk>
Cc:     "miklos" <miklos@szeredi.hu>, "amir73il" <amir73il@gmail.com>,
        "jack" <jack@suse.cz>,
        "linux-unionfs" <linux-unionfs@vger.kernel.org>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "cgxu519" <cgxu519@mykernel.net>
Message-ID: <1752a5a7164.e9a05b8943438.8099134270028614634@mykernel.net>
In-Reply-To: <20201015032501.GO3576660@ZenIV.linux.org.uk>
References: <20201010142355.741645-1-cgxu519@mykernel.net>
 <20201010142355.741645-2-cgxu519@mykernel.net> <20201015032501.GO3576660@ZenIV.linux.org.uk>
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

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E5=9B=9B, 2020-10-15 11:25:01 Al Viro <v=
iro@zeniv.linux.org.uk> =E6=92=B0=E5=86=99 ----
 > On Sat, Oct 10, 2020 at 10:23:51PM +0800, Chengguang Xu wrote:
 > > Currently there is no notification api for kernel about modification
 > > of vfs inode, in some use cases like overlayfs, this kind of notificat=
ion
 > > will be very helpful to implement containerized syncfs functionality.
 > > As the first attempt, we introduce marking inode dirty notification so=
 that
 > > overlay's inode could mark itself dirty as well and then only sync dir=
ty
 > > overlay inode while syncfs.
 >=20
 > Who's responsible for removing the crap from notifier chain?  And how do=
es
 > that affect the lifetime of inode?
=20
In this case, overlayfs unregisters call back from the notifier chain of up=
per inode
when evicting it's own  inode. It will not affect the lifetime of upper ino=
de because
overlayfs inode holds a reference of upper inode that means upper inode wil=
l not be
evicted while overlayfs inode is still alive.


Thanks,
Chengguang
