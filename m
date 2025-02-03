Return-Path: <linux-fsdevel+bounces-40652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C16CA263BD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 20:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A65403A60DF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 19:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0852209F22;
	Mon,  3 Feb 2025 19:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maxgrass.eu header.i=kernel-org-10@maxgrass.eu header.b="gPlzJnHQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4253B150980
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Feb 2025 19:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738610786; cv=pass; b=JIWtmBFFoFZGwwnEh5DSveTlnkTEn80fnq1HY0iGsLRasYWBnJL4H7RUtr8bRb7pLoQVxzXV3I8wOQDTTOHooBm3cmKWk9dCLhnnTESAJ4tIlyLoUqHWN6WHQXNBmKiLW4rprQEq4BQHdfV72DvXR1noQ4VMbLou5DMqDTuJitU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738610786; c=relaxed/simple;
	bh=4rWqWzZVxod9UCVLMZiH7d8mZWZqxhCKMlqkfLjtc9M=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=KueNzaf0McbsTV94FLSBx8cKME59FaJ/5Ji8kmtkCqbWn3MpF6ysLnoAsP9EOWYdV+4NivdkQxfFBe3O7MSS/RtCRtpdtMDl2ePjiLdbuHZaQU6PL/EdzgzuVXh1borYaEVQqQu9cW93hVBqJ3XoJhyX5SnTFZiTv/scRZXFHto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maxgrass.eu; spf=pass smtp.mailfrom=maxgrass.eu; dkim=pass (1024-bit key) header.d=maxgrass.eu header.i=kernel-org-10@maxgrass.eu header.b=gPlzJnHQ; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maxgrass.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxgrass.eu
ARC-Seal: i=1; a=rsa-sha256; t=1738610777; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZJXwYOC9OhXHpWCjOS/n7LRfDHq2umdmhdgb/W3IsE3OF6pILUeInyTJAmgh5Tv+oJoekCSA3HbdY+lPy0lGVdZ0bRiPv3f2kxdjrF+B14hT5O0c1w5gSmIHth8cwFV8dyF+ktYJGZpiEcTAY6yP2bdr8mBYnxFWKyX/fZGRkh0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1738610777; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4rWqWzZVxod9UCVLMZiH7d8mZWZqxhCKMlqkfLjtc9M=; 
	b=D0JwjSJq9ivedyMx8aT/cAl7J1Hzwwbuwk9zN5euuA1ugLcTxC4wVITxyFapssRJidRrjn2TbFD4TaOPUeIo9ARt3o6EdxpRlseqKC8iM7y1wi/RH08k1omGn1MLFV7J0GYNelPfOUB00Jl8f/IAaeuYheKFgTO6T+BASkFD3wY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=maxgrass.eu;
	spf=pass  smtp.mailfrom=kernel-org-10@maxgrass.eu;
	dmarc=pass header.from=<kernel-org-10@maxgrass.eu>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1738610777;
	s=main; d=maxgrass.eu; i=kernel-org-10@maxgrass.eu;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=4rWqWzZVxod9UCVLMZiH7d8mZWZqxhCKMlqkfLjtc9M=;
	b=gPlzJnHQ9KMwj9Rd+idQmZHMCJVuaM4jJ7E2C0wpQvRXU5r1mK3HPRTIWj0xm+ge
	GVaULNjeisySncr/yxuUd1EyR0t+4/kxuLkoMMuLOJrz2Tlj34eWeDJbYrABmUkIzga
	u2D0eoHc58iPnijniqoDJ7id33WDRSCfhBXxUG5s=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 173861077475633.93765098129916; Mon, 3 Feb 2025 11:26:14 -0800 (PST)
Date: Mon, 03 Feb 2025 20:26:14 +0100
From: Noah <kernel-org-10@maxgrass.eu>
To: "linux-fsdevel" <linux-fsdevel@vger.kernel.org>
Cc: "linkinjeon" <linkinjeon@kernel.org>,
	"sj1557seo" <sj1557.seo@samsung.com>
Message-ID: <194cd4712cc.ee1623c120595.8792309438151342323@maxgrass.eu>
In-Reply-To: <194cd33028e.d4f0541717222.3605915477419792562@maxgrass.eu>
References: <bug-219746-228826@https.bugzilla.kernel.org/> <bug-219746-228826-lg3LNttcRh@https.bugzilla.kernel.org/> <194cd33028e.d4f0541717222.3605915477419792562@maxgrass.eu>
Subject: [exFAT] Missing O_DIRECT Support Causes Errors in Python and
 Affects Applications
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

=C2=A0=C2=A0=C2=A0 Hello,

=C2=A0=C2=A0=C2=A0 I=E2=80=99ve encountered an issue with the exFAT driver =
when attempting to create an empty file, resulting in the following error:

=C2=A0=C2=A0=C2=A0 OSError: [Errno 14] Bad address

=C2=A0=C2=A0=C2=A0 Reproduction Steps:

=C2=A0=C2=A0=C2=A0 mkdir /tmp/exfat
=C2=A0=C2=A0=C2=A0 cd /tmp/exfat
=C2=A0=C2=A0=C2=A0 fallocate -l 512M exfat.img
=C2=A0=C2=A0=C2=A0 mkfs.exfat exfat.img
=C2=A0=C2=A0=C2=A0 sudo mkdir -p /fatimagedir/
=C2=A0=C2=A0=C2=A0 sudo mount -o umask=3D0022,gid=3D$(id -g),uid=3D$(id -u)=
 /tmp/exfat/exfat.img /fatimagedir/
=C2=A0=C2=A0=C2=A0 cd /fatimagedir
=C2=A0=C2=A0=C2=A0 python3 -c 'open("foo", "wb", buffering=3D0).write(b"")'

=C2=A0=C2=A0=C2=A0 Observations:

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 With the kernel exFAT driver:
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Produces=
 OSError: [Errno 14] Bad address on Linux 6.12.10.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Despite =
the error, the file is created.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 As noted=
 by Artem S. Tashkinov:

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 "While this code produces an error under Linux 6.12.10, it =
still works as intended - the file is created."

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 With exFAT-FUSE:
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Works as=
 expected without errors:

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sudo losetup -f exfat.img
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sudo fuse/mount.exfat-fuse -o lo=
op,umask=3D0022,gid=3D$(id -g),uid=3D$(id -u) /dev/loop0 /fatimagedir/
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cd /fatimagedir
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 python3 -c 'open("foo", "wb", bu=
ffering=3D0).write(b"")'
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ls
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 foo

=C2=A0=C2=A0=C2=A0 Impact:

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Affects Python's file handling a=
nd popular applications like VSCodium and Zed, which rely on unbuffered I/O=
.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Likely related to the lack of O_=
DIRECT support in the kernel exFAT driver.

=C2=A0=C2=A0=C2=A0 References:

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://bugzilla.kernel.org/show=
_bug.cgi?id=3D219746
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://bbs.archlinux.org/viewto=
pic.php?id=3D294837
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://github.com/zed-industrie=
s/zed/issues/21595

=C2=A0=C2=A0=C2=A0 Is the lack of O_DIRECT support intentional, or would th=
is be considered for future implementation?


=C2=A0=C2=A0=C2=A0 Best regards,
=C2=A0=C2=A0=C2=A0 Max Grass


