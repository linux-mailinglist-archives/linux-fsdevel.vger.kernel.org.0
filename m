Return-Path: <linux-fsdevel+bounces-45450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AB2A77D16
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 16:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 662EB1887F00
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 14:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E9F2046B3;
	Tue,  1 Apr 2025 14:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVaWvAtX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A8D2A1BF;
	Tue,  1 Apr 2025 14:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743516067; cv=none; b=MhYCNvlDqZHzC6eOxpsd+i7V9mGnxxtySSYUdONn1IZgJ1qgAfue494GcpLwfBXZ/Bv3CsGRTu5RUhgFBDEtKCVUl56JpeT/qVTOtYShf5IPnHV7tmUjeDDHEzB2+PqT4X0UvvV8lGDgC9vvyfCSWOCq2VCTJxtz1LQdoPA6I6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743516067; c=relaxed/simple;
	bh=OZal3L7mtXEder/H6CrdBAslI+LzGs7YCRqR7XqIJ0I=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=MM/xJwGiUzAFdYAdHYkiQlmCLES3FkFNT95KkVXKhG166Oznw9Y0a7OU3HVdmdufhp04TKReCIlXvbA7J2cGssA3WWVl5o4z7HTYpgCn+jsSZk7TOl1jeHqeSF3AHSvEgd6c3KSBqizbQKBs3TtoJ9zpd0uKk3fjpfRdkqrSccI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVaWvAtX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B840C4CEE4;
	Tue,  1 Apr 2025 14:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743516067;
	bh=OZal3L7mtXEder/H6CrdBAslI+LzGs7YCRqR7XqIJ0I=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=PVaWvAtXXIQZkeYWCOq//UgHRMDvzmQc3DehzBvwNwjIv1+6KFa5EI2+zipoVSLsN
	 I6DV7DjmmjRCDsHK1fTU4z+a3eb7OltU0DCuN4kj2fv83QRev6MdUKZ7ahyazZGKva
	 VzCfxDZVmkyDM0jj1CF96rRNavhbTVGnoGMqlmRWhGf9Okw5JZPOUYG5Dg8i8Idze7
	 8irxkcJixXmxZ1c4IRgNn2bK0TkVmwWSUTI4HzqZZGe+lMmTEfbKzG8lNyYFx2zgwX
	 iSqdgwfHTBirqpwMC8phRvTIY2DubJSIysXgQZ/DMrHc4pjDCDjxuqORFZxYNMnh7d
	 NVbpiP5T4oDAQ==
Date: Tue, 01 Apr 2025 07:01:04 -0700
From: Kees Cook <kees@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>, joel.granados@kernel.org
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Josef Bacik <josef@toxicpanda.com>, linux-mm@kvack.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_proc=3A_Avoid_costly_high-order?=
 =?US-ASCII?Q?_page_allocations_when_reading_proc_files?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20250401073046.51121-1-laoar.shao@gmail.com>
References: <20250401073046.51121-1-laoar.shao@gmail.com>
Message-ID: <3315D21B-0772-4312-BCFB-402F408B0EF6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On April 1, 2025 12:30:46 AM PDT, Yafang Shao <laoar=2Eshao@gmail=2Ecom> w=
rote:
>While investigating a kcompactd 100% CPU utilization issue in production,=
 I
>observed frequent costly high-order (order-6) page allocations triggered =
by
>proc file reads from monitoring tools=2E This can be reproduced with a si=
mple
>test case:
>
>  fd =3D open(PROC_FILE, O_RDONLY);
>  size =3D read(fd, buff, 256KB);
>  close(fd);
>
>Although we should modify the monitoring tools to use smaller buffer size=
s,
>we should also enhance the kernel to prevent these expensive high-order
>allocations=2E
>
>Signed-off-by: Yafang Shao <laoar=2Eshao@gmail=2Ecom>
>Cc: Josef Bacik <josef@toxicpanda=2Ecom>
>---
> fs/proc/proc_sysctl=2Ec | 10 +++++++++-
> 1 file changed, 9 insertions(+), 1 deletion(-)
>
>diff --git a/fs/proc/proc_sysctl=2Ec b/fs/proc/proc_sysctl=2Ec
>index cc9d74a06ff0=2E=2Ec53ba733bda5 100644
>--- a/fs/proc/proc_sysctl=2Ec
>+++ b/fs/proc/proc_sysctl=2Ec
>@@ -581,7 +581,15 @@ static ssize_t proc_sys_call_handler(struct kiocb *i=
ocb, struct iov_iter *iter,
> 	error =3D -ENOMEM;
> 	if (count >=3D KMALLOC_MAX_SIZE)
> 		goto out;
>-	kbuf =3D kvzalloc(count + 1, GFP_KERNEL);
>+
>+	/*
>+	 * Use vmalloc if the count is too large to avoid costly high-order pag=
e
>+	 * allocations=2E
>+	 */
>+	if (count < (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER))
>+		kbuf =3D kvzalloc(count + 1, GFP_KERNEL);

Why not move this check into kvmalloc family?

>+	else
>+		kbuf =3D vmalloc(count + 1);

You dropped the zeroing=2E This must be vzalloc=2E

> 	if (!kbuf)
> 		goto out;
>=20

Alternatively, why not force count to be <PAGE_SIZE? What uses >PAGE_SIZE =
writes in proc/sys?

-Kees

--=20
Kees Cook

