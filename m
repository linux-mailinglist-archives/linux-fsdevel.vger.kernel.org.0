Return-Path: <linux-fsdevel+bounces-55717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AF2B0E39D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 20:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 626FE1C85CCD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 18:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD2E28137E;
	Tue, 22 Jul 2025 18:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="xEDmKcud"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D7A1B808
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jul 2025 18:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753209811; cv=none; b=J6UlU0dxi93Y6WIFTSg0bwPcHtVda2veQyQvnmFOpm+p1O9wqY0uoYeUhIM1Z2qJMuq+VfeJKJn6/SEcXZZojnQqIxjputS88C9SoDnlgT+bpOvKDjBXWq4l0zaWRenhB4pu0615ZhbyHKLiwo5JxHvbPMCnkUpdxStifDCK0xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753209811; c=relaxed/simple;
	bh=1K1NDIGHxWM68nwv6FKBkBqGY56OcTOxIgt5OLhCvW8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rqIlHaboAwz/3OPNgHumrPLznUfsyblJonKX5o3ZLYrHE1zucjX5751GhAkcz5UIaoo8m2RPSIEbhR9F8Fq3h6zN1c7nFpTDZBIVCLqxLXcCSjLov5pKG077ZMnFl9QbNfz8szThjNzbuTN76UnLz31UO1E47PD4XgUje7iTWv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=xEDmKcud; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e8d707b9bc2so4499900276.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jul 2025 11:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1753209808; x=1753814608; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wTMgD9Ssjgi1hDIAisXZjqLNpii0HoyiutxO0egoRQE=;
        b=xEDmKcudK7UOC/N3qaDY202VDK6120rMMIwNfIoUnl8VhLx4I+OqvFxaPbqNh4b6XX
         I5CIpfjlJJL7eBl7g2VXK7fHj8OoPPhxvqBvS7c7/PKSJdmKUPsnm8whUkhLR8DYdqQS
         EO3upF5NUyu6Qsb/RjyKd+VGGLBUCgY+eB+dXR5Ys1H6wtTNvc2gTyzruaCKCuJybbcd
         pnMa6hb3tAMZCioonrs1Z7b9GYJ1cAWYwkuKDaz8Es8dweDc0KrOpZ9GX9RUA5hxqehP
         9sRi6phRZlH2QpkFvl6EjWW1Hua+KWimFKQzMppQqOqZb+//7cx4eHVjLhZ8mW2mNLp2
         +anw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753209808; x=1753814608;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wTMgD9Ssjgi1hDIAisXZjqLNpii0HoyiutxO0egoRQE=;
        b=sjGU56/5EOO7SFMk1Y6eQ3xAisyJAf59tQo49YBKEFLdX+Ara5Ebrl+aryJxwltIl3
         Hciu6rzD5G2Obc1hN9tDmBjYDylwJtsImIwLexm6XbS0TTldAZkty7oqwpvAM9tu+g0l
         NcF2mquVvrTJlb1ou6JN0vJ36AVoVgsfFTJtwgG53P4ZkXL0FIst1/UseECjW7ngEdf0
         iO20nMbX/7NBz6nH/PnI7WcTz8nU+UMJKAclOPa78xc+7dDs8UWiTQGgYYKQsrk1Fo5+
         LyXg6jVGi02d3mAmyEtXWhVbSfSYWKhsbrjyY4yW4he01Zxx6sr0+eZoXtV0IJlCtoq/
         yR9A==
X-Forwarded-Encrypted: i=1; AJvYcCXeStKYrmDDtbDKomzCKn1/w6/O3DqU/DbBdDkQHJqKr+zM5JoGiaUalY/JQ6TtJPPPL084CdfP+jNuiijR@vger.kernel.org
X-Gm-Message-State: AOJu0YzrMa1J2FMgjL0YhKecjTPP2VxEk+N492FfcVu4E2sPFTrqeGTd
	oPCmvZrz05f7MvZIetIGVDAIMR8b5FbD+KGPAe4EhI3Z5GPnE52mRluZhk8kO3caDIo=
X-Gm-Gg: ASbGncuL1/ZvMotBDpYK0kyEqMck8rBkcpfJUHie8aup+qmsutSnCrMQ5rqHyoAG0Mf
	GWon8H3SL3Fb4I8ZVR3EGedbWkc+4dQhqWAC+aO+mG0TbaVCW7uZEa0yPMe+wXrJQIBrExWYRJa
	ofJJPcnggpsoSi5znXOPS8i0JjLGY+4HdpJDw9GBDPAlC/tO24zVN2MVRcZIIO9WtGjAP8a+Qn4
	OMH6HGgLBEQKgGwl2W42A+xE6GCPVkAwFqMNvg+KSZ6NhtEesiptsI24bmxGQKjzGVqfyIahwOB
	E2QWr+3/fXb1u7KxF7PZhfSSxNOGu9uTsY6AOTAm30eXHtbPmJjzoaEKiwFAD6au7LsV9bGiXOx
	i4Jn7Q7+uyrjK2e4Gg1Fb5DR3A7RlS5lWtjA5FPWS96JFPGFDI4bnwUXVL6LsXVlYeMrh5A==
X-Google-Smtp-Source: AGHT+IEIvANQyOFFhibGZKN9f00/b3Jqmo6r/ZQ+Vle9Z+V7vyd2yc5p75dnDDqCIOOZ8Jkb09DGgQ==
X-Received: by 2002:a05:6902:18c6:b0:e8b:8010:5540 with SMTP id 3f1490d57ef6-e8dc57cc7bcmr476955276.10.1753209807353;
        Tue, 22 Jul 2025 11:43:27 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:7b5e:cc7f:ebd6:8d83? ([2600:1700:6476:1430:7b5e:cc7f:ebd6:8d83])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8d7cc0b1cesm3342828276.3.2025.07.22.11.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 11:43:26 -0700 (PDT)
Message-ID: <a7e1e30c99d753de3af1d373041a9527d61d746e.camel@dubeyko.com>
Subject: Re: [PATCH v2] hfs/hfsplus: rework debug output subsystem
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Yangtao Li <frank.li@vivo.com>, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, Johannes.Thumshirn@wdc.com
Cc: Slava.Dubeyko@ibm.com
Date: Tue, 22 Jul 2025 11:43:24 -0700
In-Reply-To: <4c8bc1e6-7f40-43c0-941a-87c7e9f86730@vivo.com>
References: <20250710221600.109153-1-slava@dubeyko.com>
	 <a52e690c-ba13-40c5-b2c5-4f871e737f72@vivo.com>
	 <9f9489e0577f7162cfe4f44670114cec357be873.camel@dubeyko.com>
	 <4c8bc1e6-7f40-43c0-941a-87c7e9f86730@vivo.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-07-22 at 15:50 +0800, Yangtao Li wrote:
> Hi Slava,
>=20
> =E5=9C=A8 2025/7/12 01:24, Viacheslav Dubeyko =E5=86=99=E9=81=93:
> > On Fri, 2025-07-11 at 10:41 +0800, Yangtao Li wrote:
> > > Hi Slava,
> > >=20
> > > =E5=9C=A8 2025/7/11 06:16, Viacheslav Dubeyko =E5=86=99=E9=81=93:
> > > > Currently, HFS/HFS+ has very obsolete and inconvenient
> > > > debug output subsystem. Also, the code is duplicated
> > > > in HFS and HFS+ driver. This patch introduces
> > > > linux/hfs_common.h for gathering common declarations,
> > > > inline functions, and common short methods. Currently,
> > > > this file contains only hfs_dbg() function that
> > > > employs pr_debug() with the goal to print a debug-level
> > > > messages conditionally.
> > > >=20
> > > > So, now, it is possible to enable the debug output
> > > > by means of:
> > > >=20
> > > > echo 'file extent.c +p' > /proc/dynamic_debug/control
> > > > echo 'func hfsplus_evict_inode +p' >
> > > > /proc/dynamic_debug/control
> > > >=20
> > > > And debug output looks like this:
> > > >=20
> > > > hfs: pid 5831:fs/hfs/catalog.c:228 hfs_cat_delete():
> > > > delete_cat:
> > > > m00,48
> > > > hfs: pid 5831:fs/hfs/extent.c:484 hfs_file_truncate():
> > > > truncate:
> > > > 48, 409600 -> 0
> > > > hfs: pid 5831:fs/hfs/extent.c:212 hfs_dump_extent():
> > > > hfs: pid 5831:fs/hfs/extent.c:214 hfs_dump_extent():=C2=A0 78:4
> > > > hfs: pid 5831:fs/hfs/extent.c:214 hfs_dump_extent():=C2=A0 0:0
> > > > hfs: pid 5831:fs/hfs/extent.c:214 hfs_dump_extent():=C2=A0 0:0
> > > >=20
> > > > Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
> > > > cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> > > > cc: Yangtao Li <frank.li@vivo.com>
> > > > cc: linux-fsdevel@vger.kernel.org
> > > > cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
> > > > ---
> > > > =C2=A0=C2=A0 fs/hfs/bfind.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++--
> > > > =C2=A0=C2=A0 fs/hfs/bitmap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++--
> > > > =C2=A0=C2=A0 fs/hfs/bnode.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 28 ++++++++++++++--------------
> > > > =C2=A0=C2=A0 fs/hfs/brec.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 8 ++++----
> > > > =C2=A0=C2=A0 fs/hfs/btree.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> > > > =C2=A0=C2=A0 fs/hfs/catalog.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 +++---
> > > > =C2=A0=C2=A0 fs/hfs/extent.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 18 +++++++++---------
> > > > =C2=A0=C2=A0 fs/hfs/hfs_fs.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 33 +---------------------------
> > > > -----
> > > > =C2=A0=C2=A0 fs/hfs/inode.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++--
> > > > =C2=A0=C2=A0 fs/hfsplus/attributes.c=C2=A0=C2=A0=C2=A0 |=C2=A0 8 ++=
++----
> > > > =C2=A0=C2=A0 fs/hfsplus/bfind.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 4 ++--
> > > > =C2=A0=C2=A0 fs/hfsplus/bitmap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 10 +++++-----
> > > > =C2=A0=C2=A0 fs/hfsplus/bnode.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 28 ++++++++++++++--------------
> > > > =C2=A0=C2=A0 fs/hfsplus/brec.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 10 +++++-----
> > > > =C2=A0=C2=A0 fs/hfsplus/btree.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 4 ++--
> > > > =C2=A0=C2=A0 fs/hfsplus/catalog.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 6 +++---
> > > > =C2=A0=C2=A0 fs/hfsplus/extents.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 24 ++++++++++++------------
> > > > =C2=A0=C2=A0 fs/hfsplus/hfsplus_fs.h=C2=A0=C2=A0=C2=A0 | 35 +------=
---------------------
> > > > -----
> > > > --
> > > > =C2=A0=C2=A0 fs/hfsplus/super.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 8 ++++----
> > > > =C2=A0=C2=A0 fs/hfsplus/xattr.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 4 ++--
> > > > =C2=A0=C2=A0 include/linux/hfs_common.h | 20 ++++++++++++++++++++
> > >=20
> > > For include/linux/hfs_common.h, it seems like to be a good start
> > > to
> > > seperate common stuff for hfs&hfsplus.
> > >=20
> > > Colud we rework msg to add value description?
> > > There're too much values to identify what it is.
> > >=20
> >=20
> > What do you mean by value description?
>=20
> For example:
>=20
> 	hfs_dbg(BNODE_MOD, "%d, %d, %d, %d, %d\n",
> =C2=A0=C2=A0		be32_to_cpu(desc.next), be32_to_cpu(desc.prev),
> =C2=A0=C2=A0		desc.type, desc.height, be16_to_cpu(desc.num_recs));
>=20
> There are 5 %d. It's hard to recognize what it is. Changing it to=20
> following style w/ description might be a bit more clear?
>=20
> 	hfs_dbg(BNODE_MOD, "next:%d prev:%d, type:%s,
> height:%d=C2=A0	=20
> num_recs:%d\n", be32_to_cpu(desc.next), be32_to_cpu(desc.prev),
> hfs_node_type(desc.type), desc.height, be16_to_cpu(desc.num_recs));
>=20

We can rework it step by step. First of all, the reworking of all debug
messages at once is too much for one patch. Secondly, the style of
messages is history of HFS implementation. I suggest to make this first
step and, then, we can rework the debugging messages in the background
of bug fix. Does it make sense to you?

> >=20
> > > You ignore those msg type, maybe we don't need it?
> >=20
> > Could you please explain what do you mean here? :)
>=20
> -#define DBG_BNODE_REFS	0x00000001
> -#define DBG_BNODE_MOD	0x00000002
> -#define DBG_CAT_MOD	0x00000004
> -#define DBG_INODE	0x00000008
> -#define DBG_SUPER	0x00000010
> -#define DBG_EXTENT	0x00000020
> -#define DBG_BITMAP	0x00000040
>=20
> I'm not sure whether we should keep those dbg type.
>=20
>=20

I have removed all these types because with dynamic debug this stuff
doesn't make sense. If you would like to enable the debug output from
different parts of driver, then you can use commands [1]:
(1) enable all the messages in HFS module:
echo -n 'module hfs +p' > <debugfs>/dynamic_debug/control
(2) enable all the messages in file:
echo -n 'file inode.c +p' > <debugfs>/dynamic_debug/control
(3) enable all messages in the function hfs_dump_extent:
echo -n 'func hfs_dump_extent +p' > <debugfs>/dynamic_debug/control
(4) disable debug output:
echo -n 'module hfs -p' > <debugfs>/dynamic_debug/control
echo -n 'file inode.c -p' > <debugfs>/dynamic_debug/control
echo -n 'func hfs_dump_extent -p' > <debugfs>/dynamic_debug/control

So, the dynamic debug is flexible enough and you don't need to
recompile the kernel. So, why do we need to keep these dbg types?

Thanks,
Slava.=20

[1]
https://www.kernel.org/doc/html/v4.14/admin-guide/dynamic-debug-howto.html

