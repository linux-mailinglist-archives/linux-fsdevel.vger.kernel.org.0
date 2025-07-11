Return-Path: <linux-fsdevel+bounces-54684-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4DBB02287
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 19:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 177E83B3FA9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 17:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7C12F0051;
	Fri, 11 Jul 2025 17:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="hE4tT+ZS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930D123BD13
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 17:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752254652; cv=none; b=DRWEDpBAPQ+FBy7m4GklqCERS2nzIv+QzZPEeMPKxEQkSXIvyFvT6f3wXDLcZSTgm+uCveMf2yhfoER5sqtDvdiz0XU+5dnNxIZOEOGtoquSEvUeOcZDIhI1aLpqDORqgPfOBjMkAsjk8XAGmgFv1+NmCaeWQesyHRm9pgXLF/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752254652; c=relaxed/simple;
	bh=rFvnXqzG1GLjrHgSVAb22Q0N/7iZ9QhWuDvqrzKaiFI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bQ16TvxNm0UwUG5LU5g2l2GsVg2t/4l94qbz6nKObPW/wvyg5YhjS44+tC1qEtM/03JYj/ajA8q9kkkQ2rpa9EpMvHkLgobvRku43i6ZuOUQE7h8UweVFv7Q7S9zEDnPZcNAqusCFF01HVAyJuuYHpAOu3JWt7hXhBWS18Nkpj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=hE4tT+ZS; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e81749142b3so2159124276.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 10:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1752254649; x=1752859449; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rFvnXqzG1GLjrHgSVAb22Q0N/7iZ9QhWuDvqrzKaiFI=;
        b=hE4tT+ZSl4/b02+I9nHagGijHkWkk33b2dP5e3H8AwIHjp2VaFlrINdb3y5y+GC+0t
         Ye5giZ8fVOaJPKWCUCnDIPfL9tViHmTGDwE8IAqyenUt5q8nkFRJ0bgH7v67h7OR7G9w
         zUMCL7qRoZc/1IU/ad5vMXFrK9roGWA9mnxSXw0QssZB/dw+o+CzpN0gtouJgGPticGJ
         PN7bw9jOsS0hwhB92gQBcniSpkOsUwuLTzN3HhVluODGoGSLaa6soBprf5ehSibK55vO
         SMB4cEjeIPAFUqmBIsIiFDIlFayQI2ZHHEDigjHf13i8Z+U5f6Ig8yMYry7ofvSz297z
         1TyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752254649; x=1752859449;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rFvnXqzG1GLjrHgSVAb22Q0N/7iZ9QhWuDvqrzKaiFI=;
        b=JVaEdaGf2f5Z6r9solxYrDp1E0d0lnNtN4cs0tEFiEbmzRFgQ9F/ESb2Kv+CrkrzOq
         7SXwf6T4XTq9fapAEzwGwNQeNJbZgfDSxEYmATYYmQ99gKX5QGeBKnJ2/XJIKV+Qc+UH
         Lud1fNjufX2tmDVEIJ6U1CpvxQ4d44ywSOgvdrQIAvnz44WEk1C7d1IQ2lO9WJmBa5yk
         nE58OtSqy+MfVpYAJHYiH2vAciNHVgXcyUv05rI4GULipHP/zUkWuqz4/xKuipAFBV5H
         cQUcbqYo7UyrZ9l0Rqr0pQ788KgnffwqnsB1blURem6EWKZuY2GekyKWHbngwyUA4OkN
         mVug==
X-Forwarded-Encrypted: i=1; AJvYcCUUZW9e9zJhFrT4XCY2mwiqZLcvw7k0lfRa7A0XNUZ8wLZV+msydQ2kvsw9zPuJ3cYoYd6VFG1uFgj9FqMN@vger.kernel.org
X-Gm-Message-State: AOJu0Yx40ZIQiPJx9OMU7Zd75jp4Whtvn4JapzC7U4dVt8SSbNWEvMvB
	/soKzIwIC3xHqmqnHYnXy6CuYPRcr1Y5KE2h36tUx5tmHGr0A7JvBI1YX2L5f8Qp9iM=
X-Gm-Gg: ASbGncseKYSACgAbXka+jNTooVbAP6CQp86egdfmRcoWrwnSeYrB8oXJLSc0WXE8Zxy
	g+/LjZuVESgxBTqjDg/uquj+L4co+kPZixw2jL6t+p5eh4F+Bh/405RzxYYFcfx8rzTao4XQGTv
	cGaifiKHw36mgTVLBYTadjwk0OupTB4nlfWha75um85pLzqqNSQ4xBnrdk4NR74IJRFVnLurqsY
	+5ZhJ+lrwx3iGB6o1LLVQZHmklSBCUgD71iI+LTY/ScJsf4rdjXLzGgwwptKerp+wkPVL0Omx9i
	WXklPijGRZBqlP0l+3KwCXRyRgyJXa7vmmsr7EFNxH/lkRSx218tOqh5YCYA/HzC7Hpayg7BqOQ
	kas37myxN4p6EzoQKYfA9AjSonH99zSqkX2e/bl3XzlvdJzTO/e+fZqjea5H9wENIrBA=
X-Google-Smtp-Source: AGHT+IGMb9ihHRytHbgn/783bZ0yoc3M3OCg0uG4q1zkpN2Mkg3KAXJrXgpScYLLmiXaZCXRqMbphA==
X-Received: by 2002:a05:6902:5089:b0:e8b:75d5:aa0a with SMTP id 3f1490d57ef6-e8b85b2987cmr3669801276.36.1752254649155;
        Fri, 11 Jul 2025 10:24:09 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:afb0:402c:a1d5:c65? ([2600:1700:6476:1430:afb0:402c:a1d5:c65])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8b7aff3f6esm1225397276.51.2025.07.11.10.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 10:24:08 -0700 (PDT)
Message-ID: <9f9489e0577f7162cfe4f44670114cec357be873.camel@dubeyko.com>
Subject: Re: [PATCH v2] hfs/hfsplus: rework debug output subsystem
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Yangtao Li <frank.li@vivo.com>, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, Johannes.Thumshirn@wdc.com
Cc: Slava.Dubeyko@ibm.com
Date: Fri, 11 Jul 2025 10:24:07 -0700
In-Reply-To: <a52e690c-ba13-40c5-b2c5-4f871e737f72@vivo.com>
References: <20250710221600.109153-1-slava@dubeyko.com>
	 <a52e690c-ba13-40c5-b2c5-4f871e737f72@vivo.com>
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

On Fri, 2025-07-11 at 10:41 +0800, Yangtao Li wrote:
> Hi Slava,
>=20
> =E5=9C=A8 2025/7/11 06:16, Viacheslav Dubeyko =E5=86=99=E9=81=93:
> > Currently, HFS/HFS+ has very obsolete and inconvenient
> > debug output subsystem. Also, the code is duplicated
> > in HFS and HFS+ driver. This patch introduces
> > linux/hfs_common.h for gathering common declarations,
> > inline functions, and common short methods. Currently,
> > this file contains only hfs_dbg() function that
> > employs pr_debug() with the goal to print a debug-level
> > messages conditionally.
> >=20
> > So, now, it is possible to enable the debug output
> > by means of:
> >=20
> > echo 'file extent.c +p' > /proc/dynamic_debug/control
> > echo 'func hfsplus_evict_inode +p' > /proc/dynamic_debug/control
> >=20
> > And debug output looks like this:
> >=20
> > hfs: pid 5831:fs/hfs/catalog.c:228 hfs_cat_delete(): delete_cat:
> > m00,48
> > hfs: pid 5831:fs/hfs/extent.c:484 hfs_file_truncate(): truncate:
> > 48, 409600 -> 0
> > hfs: pid 5831:fs/hfs/extent.c:212 hfs_dump_extent():
> > hfs: pid 5831:fs/hfs/extent.c:214 hfs_dump_extent():=C2=A0 78:4
> > hfs: pid 5831:fs/hfs/extent.c:214 hfs_dump_extent():=C2=A0 0:0
> > hfs: pid 5831:fs/hfs/extent.c:214 hfs_dump_extent():=C2=A0 0:0
> >=20
> > Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
> > cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> > cc: Yangtao Li <frank.li@vivo.com>
> > cc: linux-fsdevel@vger.kernel.org
> > cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
> > ---
> > =C2=A0 fs/hfs/bfind.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++--
> > =C2=A0 fs/hfs/bitmap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++--
> > =C2=A0 fs/hfs/bnode.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 28 ++++++++++++++--------------
> > =C2=A0 fs/hfs/brec.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 8 ++++----
> > =C2=A0 fs/hfs/btree.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> > =C2=A0 fs/hfs/catalog.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 6 +++---
> > =C2=A0 fs/hfs/extent.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 18 +++++++++---------
> > =C2=A0 fs/hfs/hfs_fs.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 33 +--------------------------------
> > =C2=A0 fs/hfs/inode.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++--
> > =C2=A0 fs/hfsplus/attributes.c=C2=A0=C2=A0=C2=A0 |=C2=A0 8 ++++----
> > =C2=A0 fs/hfsplus/bfind.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 4 ++--
> > =C2=A0 fs/hfsplus/bitmap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
10 +++++-----
> > =C2=A0 fs/hfsplus/bnode.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 28 ++++++++++++++--------------
> > =C2=A0 fs/hfsplus/brec.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 10 +++++-----
> > =C2=A0 fs/hfsplus/btree.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 4 ++--
> > =C2=A0 fs/hfsplus/catalog.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 6 +++---
> > =C2=A0 fs/hfsplus/extents.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 24 ++=
++++++++++------------
> > =C2=A0 fs/hfsplus/hfsplus_fs.h=C2=A0=C2=A0=C2=A0 | 35 +----------------=
----------------
> > --
> > =C2=A0 fs/hfsplus/super.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 8 ++++----
> > =C2=A0 fs/hfsplus/xattr.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 4 ++--
> > =C2=A0 include/linux/hfs_common.h | 20 ++++++++++++++++++++
>=20
> For include/linux/hfs_common.h, it seems like to be a good start to=20
> seperate common stuff for hfs&hfsplus.
>=20
> Colud we rework msg to add value description?
> There're too much values to identify what it is.
>=20

What do you mean by value description?

> You ignore those msg type, maybe we don't need it?

Could you please explain what do you mean here? :)

Thanks,
Slava.

