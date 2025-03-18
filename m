Return-Path: <linux-fsdevel+bounces-44247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A89A6688B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 05:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 585D4177AE1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 04:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A9619992C;
	Tue, 18 Mar 2025 04:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Se6HfJzt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04olkn2036.outbound.protection.outlook.com [40.92.45.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABACBC2F2;
	Tue, 18 Mar 2025 04:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.45.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742273231; cv=fail; b=a+Y0O+eKH+hKdofpniALSpzU9mHAV/AZD+GcHCR9brkFds0XOm4J9WrQdwLKNhXve7caLwhSECCZKmnQorHizlWcIGy1y7tp9hwidzu9yvdW3QLHVrR6TBE1v3Rvs5wBZCHhn2NOyWsjZSghbZYH+N70OOf9CFPeMOyfRTytxKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742273231; c=relaxed/simple;
	bh=4fIs79Jb42/7drmhfvQu2GVdOLqdrEU8m8ZkNmTmfco=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WzmbA0JUMHYiBGjqGq6bcFdNmIGyXaoW+Vxp8hNG3Idfpx030zglzU9uuEN2CTMfZz9H9iucLutlAXa2pglq1/j3pXlB7v4eQCVogERF+/aLeDpB4nspbMSDmVe/klNVVWl0NVW/v6hX0vbWI1DpRRaSRa7OYG5uUjSzNUAy4x0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Se6HfJzt; arc=fail smtp.client-ip=40.92.45.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B8/k7SqxhS/0UJ7Zqa3ltgsrG6625+dQyVj9FX4kNUmLa2jLVFWGgVxkxZkS9CHXZNbI3w4ds2LHInj6PxzBljI/XXWiFrNhau7hc0EgQVruDxf4E0bR9qhzQM0Vyq7DuxXuEyov9YbkZyf/Ihcf1woeACNVyYWM9F2/G8eZOXiQbXvBRe9xBCD/V/AwKK/ky6KxKdRKYvJvhtxaXG0PqEyBwhlDaA24zHzFU7XclGKw61E97nBDbSRH0clYfLosBvvna2+adEUsBrU1t2URc97LASh1Zd6GSLf35K73pX8mgWFQaB+BI2DhQqBN7/OqCrouUPVQI44NuAxIAxBiKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4fIs79Jb42/7drmhfvQu2GVdOLqdrEU8m8ZkNmTmfco=;
 b=YBN2KBpYdFQnv1NPhyB2nzXaxcYCsz0jOtTM1xpb/u88U0tdu+kSU4OKLkjI3NG7vTd5LP2aOB+gW8tbsw8GG9n8uSSFF4pyDd+jSkPS/38df9UNZWH2D3DeyvgtBOJRujaqR5whbTuCkDurd3ogqCnyf2t+nDiYj3NAKmGh4F2KuzB6kJavJjqtyVVdByRdvo5BHSUgWrDlY2Cw97KTg15vQjs/Ou7m5p7p8iS/MVBOzg179ZvJhUWXTEmC9QXFaJfh45uWQECI81W9B+SSuEoh8H8NfH+usw140C6hBJ7wZe/I/YWOknO5y5QsEAd4mY6inGgOVY5lh1ST+5N+DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4fIs79Jb42/7drmhfvQu2GVdOLqdrEU8m8ZkNmTmfco=;
 b=Se6HfJzthNsZU+gafNcvt8sAmG21tG3aGyvACl0FX/ClN/5V+0n3BVOht5fOGpE4yhbHEO/VamWSurPUbNNK7hyuk5qe/iYz6WK/kleeaqPKYvf/OAX+jqwgf1ICfSc5AdtM8YNeNM+pi+1dqWBy61ZhaIIymLiMpolunG7xvrast2nDl/s8gf/GVXj6YvpwC1OQxotn79ZX5efm4+iA0WODxKLv6qQJ4GTmlqf3azMbzCrBXqhX4peMGxVYCVEeNQThQBJA1HCZMWbJCz/IF+U9cy3V8Ixt12calDQDh1RaBVVjd6e+SV/hKr3fM5xDqW0f2uDqqOwaHAOXyd7fgA==
Received: from BYAPR12MB3205.namprd12.prod.outlook.com (2603:10b6:a03:134::32)
 by DS4PR12MB9636.namprd12.prod.outlook.com (2603:10b6:8:27f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 04:47:07 +0000
Received: from BYAPR12MB3205.namprd12.prod.outlook.com
 ([fe80::489:5515:fcf2:b991]) by BYAPR12MB3205.namprd12.prod.outlook.com
 ([fe80::489:5515:fcf2:b991%5]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 04:47:06 +0000
From: Stephen Eta Zhou <stephen.eta.zhou@outlook.com>
To: David Disseldorp <ddiss@suse.de>
CC: "jsperbeck@google.com" <jsperbeck@google.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "lukas@wunner.de" <lukas@wunner.de>,
	"wufan@linux.microsoft.com" <wufan@linux.microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH] initramfs: Add size validation to prevent tmpfs
 exhaustion
Thread-Topic: [RFC PATCH] initramfs: Add size validation to prevent tmpfs
 exhaustion
Thread-Index: AQHblJ3gvljUi14PpUKtURVssHl1u7N28UyAgAAdT5aAAQ5UAIAAMmVp
Date: Tue, 18 Mar 2025 04:47:06 +0000
Message-ID:
 <BYAPR12MB320504EE908AABFD1600AB87D5DE2@BYAPR12MB3205.namprd12.prod.outlook.com>
References:
 <BYAPR12MB3205F96E780AA2F00EAD16E8D5D22@BYAPR12MB3205.namprd12.prod.outlook.com>
	<20250317182157.7adbc168.ddiss@suse.de>
	<BYAPR12MB3205A7903D8EF06EFF8F575AD5DF2@BYAPR12MB3205.namprd12.prod.outlook.com>
 <20250318121424.614148e1.ddiss@suse.de>
In-Reply-To: <20250318121424.614148e1.ddiss@suse.de>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB3205:EE_|DS4PR12MB9636:EE_
x-ms-office365-filtering-correlation-id: 4ccf1c0f-2f90-41d9-2e27-08dd65d7ef6a
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|19110799003|15030799003|461199028|8060799006|8062599003|102099032|3412199025|440099028|12091999003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?fHK5uScLH32ZSzV/frs2oCUq/CKVVdKMOk4gwy/TYRwakew9WPeH8D55KE?=
 =?iso-8859-1?Q?pSbKE7EcVJ4mfDiOGZA1oAE+9pQSY3fiim9CcWJ4cmLhQwIVakqk5JK/sQ?=
 =?iso-8859-1?Q?Uvv2SwnCITkx4ays6+UXl5CM7CX3UQxTxAXuHFEgnXPIN0altjKk9/mImm?=
 =?iso-8859-1?Q?j2x0mkWq790DkvqluLU4KGWgn1qURd5yyIm/CCCn8RW5m4bDzeU0utRkL5?=
 =?iso-8859-1?Q?Q5D93PotwUe5AzAvMvjJc+FOTkU9dYKbOL13jGvrlk2b3n/RM4pW6uebFX?=
 =?iso-8859-1?Q?7QNwp74FDBeSQ1iUose4PnWILZ/v8pqrdHE4vp7UVRoEEvUfp+bR1rDF1r?=
 =?iso-8859-1?Q?hwgjzZANe7xzUyIbwMP/+IeUn3+uySoFQYVahu5v3030DBwwYsHalReAQS?=
 =?iso-8859-1?Q?NFAcaO7tZYuyDBXLLMnXy9gJ8mZ+qhIXh4aouVivYPymV0oiUqD1k7vwQe?=
 =?iso-8859-1?Q?KLdsaKhn0AV/dD2t/FtwverRjVoX2qAgA/4HTlr+nTwyu4ptzheSHlrgCz?=
 =?iso-8859-1?Q?JQanC9176vXitMvaj+kKIpXgtshgBRoAjhseKKcdPIqXuJXbsPVX9cAkEx?=
 =?iso-8859-1?Q?n1WNtanXMkpH6gpA8qnjNcOgsgMqBJgmTxypA8j9CFtR+yHR5m00fFGGOf?=
 =?iso-8859-1?Q?9xe83OMo2FSQM15jwNuaATaOFoNvK97GHq2yvbWVnl0pdUDxXOjmGGp4ib?=
 =?iso-8859-1?Q?gf+ZXoGrId3Byt054xN4g/UXxsTNB4hZZhx+K7IgB9Q0aXNml0TGUachVG?=
 =?iso-8859-1?Q?A0oCqBl112KIzlKL1DrnMLox180XA8VQRTGo7JWfF2Qm4/Io6LT3Jj3F9K?=
 =?iso-8859-1?Q?oCZIPGbNsbfHcwrZd6IirflAOUE5j0rHW5HuF8xm1Qd4gAJBWTxO2HQcPj?=
 =?iso-8859-1?Q?0I4sfHhPWzkr0O13dSeLLhGet5xrC2mZtS1gT3wNN3xxajBjoUmWkPUphZ?=
 =?iso-8859-1?Q?n1wsjy14BrVPqFfH423iRkBYPS4m7XpA9yl6pkBNH6jX3+R3drsh3PSVwa?=
 =?iso-8859-1?Q?Ls/r48b7FR0o++G9pFRZL7oSFeI9iUwMQZIoeVL60M444Fr/me4mALqiKI?=
 =?iso-8859-1?Q?wZ83laTaEnLkpQE815le74iKFIN0VEJKwyoD/bf+RHRCsZwqRx1B5Rr4lM?=
 =?iso-8859-1?Q?dG0JPw/Pskt23KGzFfiFrKEwn/+CMIj68Qcd9PMMGMWW4OGAer7ZvTngZX?=
 =?iso-8859-1?Q?pYd6BFdPOb3qHw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?q0odnzSBl5flmXLOKrTo8gSfjCZ1jNk+mFSNBQVFh82hLns/vRzCNBAeax?=
 =?iso-8859-1?Q?HccR8Fhzifh7WpnO4FJRlyYz3RK5/6TdOZYVefW0XWN+n/jdnNUtPvR2vY?=
 =?iso-8859-1?Q?irYNjPjR18gRIGFbc+/IC67SwzbvNbXwNDES3Z7/uc0XwH6szYasZXnUjW?=
 =?iso-8859-1?Q?dLUndYLm3pXnb4AMbCExxiPWUt+VXC3kcJtPs8W/odQPnnLFu/nWhg4fF7?=
 =?iso-8859-1?Q?5QM62TZPUuIPxmdRGDyWTt4Zpd294pEt0rwI0pRVlfi/CqAIm0b2rWpIOr?=
 =?iso-8859-1?Q?fSTUxpYUP5ZwR/fyDV1hM/WRi40n1oCcsCJw8eztT96jb+jC+52dfB3uFK?=
 =?iso-8859-1?Q?JwjDcgcr2DkU1yByR/otk1O7q1qrPo5JB7UZfgmjo1hpI9FJSn0TmF8p4P?=
 =?iso-8859-1?Q?cU4VXjbJ17RHtwFDfj7zJRtYosgeHxLquHxi1+Jtb9pF8sGYRJEt6YqEs0?=
 =?iso-8859-1?Q?Aw02utGER3YSK6y2Vxxa4lGd0tz3SS2ijTDqE+fl7KHV6RET1phqy3EnBK?=
 =?iso-8859-1?Q?XpYA4OcQMQdnx26DRBkrk30L+PNXCBADpp7t6VCTs0UxyrPxOtVOHJbpzx?=
 =?iso-8859-1?Q?kc/elvuNHwEQ1ijlIB1ozZ78razAadOt3MtwK3H9vzuSVRpK+XzLzYJc4R?=
 =?iso-8859-1?Q?PF1xE6grGlzIA+vggNzBRKkUHMEFsaTc1K+glrZbWwcWdfpYGEbeFsBWXF?=
 =?iso-8859-1?Q?xn2Lm/idWV9aaEQpCRCoGqfutFbtUE8SFHq+2+nIX1qheQH4f0rsTSjBvg?=
 =?iso-8859-1?Q?lpe+D2Ru//vZyPMOaji9/yPxLOe4Gkkv3HF3O1Fh4CK1WrcAFX87XTpjVm?=
 =?iso-8859-1?Q?C64mAwqnRHCcvstbBQSS8eg3ztBzcOH3Z5B4Bn3NHvP2XHlggkcdUCWTvo?=
 =?iso-8859-1?Q?odv6YAWuyxfvW3EibvkmBWpSBHCRj9feuI58yG7paMuxg/ZHBoD0Irw31w?=
 =?iso-8859-1?Q?xGwLbO+XUPfLwqO07n3NYJfJ72iT1HgjDe7tSgSJnJH0F2Yysdvv3s+xK9?=
 =?iso-8859-1?Q?bDRq1P+WqMfE+jrIRw2I70tQ99wClZybea6LiE1dJJqaRWH7lmJ/5D1se+?=
 =?iso-8859-1?Q?ZwllRXfQBZ+TPh/uRinXCNVQeasTvZLAbUqtT+8VJEHJ+ABQnYGc+ElsZ9?=
 =?iso-8859-1?Q?5bnfZavHGheIr37CSvgPCnnn82zhAO6FA1HwxXactjT86MYTXCchjgpUwa?=
 =?iso-8859-1?Q?MfujcLIxtpjGWEa0L2mVpzI8YY2akWGhvnBcGhtUIeXonjO/WG4bxdv8kF?=
 =?iso-8859-1?Q?jA+YgmnZ4d8+yjM/msyjYxT6oGB/BDzFSr4s9OEd8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3205.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ccf1c0f-2f90-41d9-2e27-08dd65d7ef6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 04:47:06.5008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9636

=0A=
> I0t's still not clear to me why early-user-space can't determine this=0A=
> before attempting to mount, etc. It's in a better position to know the=0A=
> resource requirements of what it's going to run.=0A=
=0A=
Before init runs, initramfs is unpacked to tmpfs, and if tmpfs runs out of =
resources, the system may already be in an unrecoverable state (crash or pa=
nic), which can cause problems: the system may be in an unrecoverable state=
 before init has a chance to check.=0A=
Unrecoverable state can come from drivers or subsystems that cannot create =
files in tmpfs. For example, if the rootfs is created on a system with very=
 limited RAM (e.g., an embedded device with 64MB RAM), unpacking a large in=
itramfs may leave so little space that even init cannot allocate memory.=0A=
The kernel error log may show OOM errors, but the underlying problem is tha=
t the initramfs is too large and there is not enough space left to support =
subsequent programs.=0A=
=0A=
So I think the kernel should provide protection during decompression, so th=
at if tmpfs is insufficient, the kernel can handle the error gracefully and=
 accurately, without running at the risk of panic or crash. At least when s=
uch a situation occurs, developers will know where the problem is at a glan=
ce, and spend too much energy to gradually troubleshoot the problem, and it=
 can also strengthen the kernel's ability to handle problems early.=0A=
=0A=
Sometimes when we troubleshoot errors, we always check step by step, and fi=
nally find that the problem may have occurred in the first link or some par=
ameter configuration at the beginning of startup. In this case, why can't w=
e expose the problem as soon as possible?=0A=
=0A=
=0A=
> There's room for improvement WRT how out-of-memory failures are reported=
=0A=
=0A=
> and handled during decompression and I/O. However, adding an extra pass=
=0A=
=0A=
> and some arbitrary free-space logic doesn't improve the situation IMO.=0A=
=0A=
My intention is that pre-checking free space before unpacking ensures that =
failures are predictable and recoverable. This check can be a simple size c=
omparison between the initramfs archive and the free tmpfs space, which has=
 minimal overhead compared to a full unpack and subsequent failure.=0A=
Proactive checking prevents unnecessary I/O operations and reduces the comp=
lexity of debugging at boot time.=0A=
This is done to provide early assurance to the kernel.=0A=
=0A=
Thanks,=0A=
Stephen=0A=
________________________________________=0A=
From:=A0David Disseldorp=0A=
Sent:=A0Tuesday, March 18, 2025 09:14=0A=
To:=A0Stephen Eta Zhou=0A=
Cc:=A0jsperbeck@google.com; akpm@linux-foundation.org; gregkh@linuxfoundati=
on.org; lukas@wunner.de; wufan@linux.microsoft.com; linux-kernel@vger.kerne=
l.org; linux-fsdevel@vger.kernel.org=0A=
Subject:=A0Re: [RFC PATCH] initramfs: Add size validation to prevent tmpfs =
exhaustion=0A=
=0A=
=0A=
On Mon, 17 Mar 2025 09:41:35 +0000, Stephen Eta Zhou wrote:=0A=
=0A=
...=0A=
=0A=
> Before the init process runs, initramfs needs to be decompressed to tmpfs=
 and become the root file system (rootfs). If there is insufficient tmpfs s=
pace after decompression, init may not be able to run at all, causing the s=
ystem to crash or panic.=0A=
=0A=
>=0A=
=0A=
> Letting the init process decide whether it is sufficient means that the i=
nitramfs must be decompressed first, which may have filled up tmpfs, making=
 the entire system unusable, rather than a controllable error handling proc=
ess.=0A=
=0A=
>=0A=
=0A=
> This problem is more obvious in extreme cases, for example:=0A=
=0A=
>=0A=
=0A=
> 1. After initramfs is decompressed, there is only a small amount of avail=
able space in tmpfs, causing early-user-space tasks such as mount and udeva=
dm to fail, affecting device initialization.=0A=
=0A=
=0A=
=0A=
It's still not clear to me why early-user-space can't determine this=0A=
=0A=
before attempting to mount, etc. It's in a better position to know the=0A=
=0A=
resource requirements of what it's going to run.=0A=
=0A=
=0A=
=0A=
> 2. On embedded devices, tmpfs is usually configured small, and insufficie=
nt space is found after decompression, which directly leads to boot failure=
.=0A=
=0A=
>=0A=
=0A=
> The reason why the check is performed before decompression is to expose t=
he problem in advance to avoid the passive failure mode of insufficient spa=
ce after decompression.=0A=
=0A=
> Calculating the theoretically required tmpfs resources and making judgmen=
ts in advance can reduce unnecessary I/O operations and provide clearer err=
or reports to help users adjust the initramfs size or tmpfs configuration.=
=0A=
=0A=
> My idea is to expose problems as early as possible. If problems occur dur=
ing operation, it may be more troublesome to troubleshoot or bring unnecess=
ary risks.=0A=
=0A=
=0A=
=0A=
There's room for improvement WRT how out-of-memory failures are reported=0A=
=0A=
and handled during decompression and I/O. However, adding an extra pass=0A=
=0A=
and some arbitrary free-space logic doesn't improve the situation IMO.=0A=
=0A=
=0A=
=0A=
Cheers, David=0A=
=0A=

