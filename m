Return-Path: <linux-fsdevel+bounces-44256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81457A66A63
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 07:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 889F61896FC5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 06:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F631DE3A5;
	Tue, 18 Mar 2025 06:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="HBS548EW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2019.outbound.protection.outlook.com [40.92.23.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8D31DDC34;
	Tue, 18 Mar 2025 06:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742279337; cv=fail; b=CKDrxpAdA0UYKt0X19ZPkpQkhEYGPGZzVBEsyhUScmfu0LZiFRlrvLML2VRa+C5wjm23rH9FJNqvBb/tk9OesDR3Yk7lAULSidLGxkPcGRdnDLIPVgD6gGRRSQTYACPsB80PfG/BtFNktj5GgTbURCSCTWEE0TvQ/yoVfAnx2DU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742279337; c=relaxed/simple;
	bh=bkcISOZvk8kLoWTw+W99ypZ5IBBTROvPAtarMhweAng=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AgAonRDJV+GItaqAbbGw0hTw/lRwvL6tb4/6r68f3D6V7IrjD7cMr9EKXXaalbkXd77qgCRkVAXDAxNSNLxl4pc8n6QbgJvoKYTg5CDoSCZuNb+COFI4Dd/Qt+rXjjj9Hb8i2kaYNdxKLRURF63mE9Nb7VakdQBjOkWCtYY3/ro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=HBS548EW; arc=fail smtp.client-ip=40.92.23.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cjX1QGgit0DerLopruvC53buK2FtXYx3IQlGT6HRXBe/oGJsPPkogkvpu3t/3CaZJ47NHBj7pQzvA9qhUPH24I6tAS2EetK853/0ek+oeBjd8guy6FbvqeptGBcKtXfZml+M68ePtha43tQKUcUFT1+3QsOIo6DjO88VgYuHXi5zZ0P3+GPUF2IX+G8FOVCMPIxPCYK9RPqJA9vc/dQu0AD5c+au0c2lk4jlW9hLWIBGJ15D1lIb811sk5+TpMfdwFIrxO75mRbTkmSuWvfx6lu8oSYK2xSJnR+swbsjYjsT+bNjQvo8S+6wOgvziNEyX69+LHvO70dZgosUDFev8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bkcISOZvk8kLoWTw+W99ypZ5IBBTROvPAtarMhweAng=;
 b=ccaVqNE41WCNBBZn8Ol4ed6AN771cFFln4FfewuLDIN7I2x/if5OM+vv7rh1mK61I0l8fhmaGisZL63moUeXRc/XN9ejvz/RhbTRHl1vkDH5MMRkhmhgZHuUNqPHFqa8UcFHkvRD48+8SXgUBJKOW4FT5JysC7MdnIxFeFvPO2HgNimQRukGoNSde14rD2JCnxRXDPGpYT/Vc9y+MLepIYnfAPSYLonXFK6woacP4ugiF6kRCLHWQYVTo2rJIkZcyS8LsCq0sbe0xb5Vopm2mMq4h/H1jWCLT0jJBKN8smX9Wtl2nA7ZE4xVhST9+tL1QzuzCWw2MvO1KMxcmMAL5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bkcISOZvk8kLoWTw+W99ypZ5IBBTROvPAtarMhweAng=;
 b=HBS548EWmlCO2TR43zQNS8NbhUnHtIMIO2jjJi7LfWl9DwRNHI9484PkMYHf8OyPsmlQ2sK4sGWVYkhybkcFBAg2wqXuLXFSGLDMWsxN2QkMSfFHh2oKYB0+7PLBWXUw7x5VLFh0eqAU/AL2VdyGik4LsBzS0QHG2SUCNNbv7O5ipjY1WTiFqSd73WlD65+3zaJbxO0wHG6ZwYCuJLic6ihNwslkopQMX/ArTF/FVINLPSux9sg9O0hb699vlokujbkM8SH59V+lsC7jTqMkRZBzhDFnCF7aPzNHtV4EFoPp2rxqw1BbwufJ3mf9GKF65Um8VcGjtNZ0AoJYV11Igg==
Received: from BYAPR12MB3205.namprd12.prod.outlook.com (2603:10b6:a03:134::32)
 by CY8PR12MB7490.namprd12.prod.outlook.com (2603:10b6:930:91::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 06:28:53 +0000
Received: from BYAPR12MB3205.namprd12.prod.outlook.com
 ([fe80::489:5515:fcf2:b991]) by BYAPR12MB3205.namprd12.prod.outlook.com
 ([fe80::489:5515:fcf2:b991%5]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 06:28:53 +0000
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
Thread-Index: AQHblJ3gvljUi14PpUKtURVssHl1u7N28UyAgAAdT5aAAQ5UAIAAVPUJ
Date: Tue, 18 Mar 2025 06:28:53 +0000
Message-ID:
 <BYAPR12MB320590A9238C334D68717C34D5DE2@BYAPR12MB3205.namprd12.prod.outlook.com>
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
x-ms-traffictypediagnostic: BYAPR12MB3205:EE_|CY8PR12MB7490:EE_
x-ms-office365-filtering-correlation-id: 9cab7d8e-c36b-4584-bf6b-08dd65e6274c
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|15030799003|8060799006|19110799003|15080799006|461199028|440099028|3412199025|12091999003|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?iVW2wZDziR4c99lNi5yFFLrUkKuIC33DmajBYN3SiekpG3LxGfnhx07SCv?=
 =?iso-8859-1?Q?ayW7ZsA89TiLYPkp7f8mJgodYOQygpLsrzqOm7gRJnUVf+XTGVSaEQoX4X?=
 =?iso-8859-1?Q?70WTPoBs3S4KMqNGZx6OallMmccB7cblBqJjMm5nlcq6NLgNaqPsDQiGXf?=
 =?iso-8859-1?Q?gjhyYw+OcsNckOFgJAEtnYtMiYxzWXPwKcuc12iNzHszWgRg981Zmw13sS?=
 =?iso-8859-1?Q?XqgruUMppGchM9+7ERozsr49bwNhSVBAgsjQb65SsGZW1t0Y6X7owgFt5g?=
 =?iso-8859-1?Q?mdzZ3zV8ZgoZEhigmQzh7TlawruMZg9N8cSS9aZa4nEooWRiAGXr4deupR?=
 =?iso-8859-1?Q?I2Ar5rmp7i5dTP+RpcGjLb/NFvep52sNaXeyyAZET0MOfVkHLRrBmN58Q7?=
 =?iso-8859-1?Q?UKRGeaePUgTZ/nJ9Ur8ZH0NIupZLnc+lQhfXsdu4pEltR1aUU6XeQxNgfF?=
 =?iso-8859-1?Q?74DbVfAlG7pLiGvNaMIisL3hQnLq8lX5Az3aE8Qy6ts789zYtS15/ZBnMf?=
 =?iso-8859-1?Q?t4INUF2FFrECR1Abs1kbVuFx7G7SFQe3Xu3jHTqsUGCk7jLRKLMk34mb62?=
 =?iso-8859-1?Q?VAtk3nlYg3bg8yEmvNM+yEKaIEk6AXAKLJcSf+ureWNiLKrReEhAJT+08J?=
 =?iso-8859-1?Q?q7l6F0uT91dAGkt9OUWw8Br1HpaAr1Aqs1r+vnp0rPgV59CEfAhR3mJ/Lj?=
 =?iso-8859-1?Q?smw445woYhA3GSTP/TCJ9v2avwG7luJZJ3uSvdU4PvtOzASKnTHJyZlkdp?=
 =?iso-8859-1?Q?aOeyfaiBCyZBg3qkthysYip8Q9l/KZut46Th+bQ9AWtOamhhg4CysaRgSS?=
 =?iso-8859-1?Q?zjanY/yJoq0gjtlazpWIUXeI48waCg0N9uemOYTqKZ6JYImHSqNvVzMj0C?=
 =?iso-8859-1?Q?GP9mw3tO1gt2A3GKIG5VRS25pAS1sN0pusxejknSwL3rBhkT2HXohQmMom?=
 =?iso-8859-1?Q?NVghOvXA4+MAFjYeMRVVsckAi72yOnsu8EnM9Vq3S+PC6Ok8abz6b+gEqP?=
 =?iso-8859-1?Q?wxzbiEqkqYvdUAK2HERChzdbxokQusebUHf1zmLikixJ5MoQxbQNnhaBpg?=
 =?iso-8859-1?Q?TbFEOXkTDAYZV3QsS33EotmTvUnPc3M3b6/SHqH4NQbzM5sSkNHSYqxr4u?=
 =?iso-8859-1?Q?k7IcxGA1nH+TqGUkCvjAGldp/LUZC+uExCgci3c7VWvFziMQz5nY+MibIN?=
 =?iso-8859-1?Q?hwyK3vrRE9O1/w=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?XO2HjwajF0FNeNNhJJzH3vkM+Dz9rI8dLvy4W8hQMXyfTOC9k6+t8g0dzR?=
 =?iso-8859-1?Q?zcG0+/7tJLfYKoL3mtcmNQY02hV/oFraDUuMYGlI+AzivFnutHiDIvCOWA?=
 =?iso-8859-1?Q?ZOVC1nDqxRZqWm4Tjp5HHYJW+6K7rRuGtLBVXdcEaU9w+OpTuoorIlONof?=
 =?iso-8859-1?Q?SXTynPW668C9K/85V3RkKBXYU6P+ESypWjfuYk6YD9lG5OzDwB4TYGilyz?=
 =?iso-8859-1?Q?4IdysB7WHfMUe34nA5IIR9Tc4BYSkqIeTcHuZU+qJJQR8PegGRCfvzn5R0?=
 =?iso-8859-1?Q?4RdzPUiGO4EejAUVfz2XngKpSpYx7SAMwOdrhbEdgNSs0KMc10iDZR+WjA?=
 =?iso-8859-1?Q?gy8RdRAxOg/pnOZSntyMEzMxzgSZqWRXJSeJM5eIDsh3TyNoWwzYk/kdhE?=
 =?iso-8859-1?Q?jEL/ezG2bM99L1EavcgmZHLHE6v/znFXqFTlzYvysP8Mb0IHoEJYQRVmKG?=
 =?iso-8859-1?Q?viAGLyXJwJVToIoVOiBz0/+e4t9GLUSCXNdy5pVPfSM6fF3NRdo+T6mOrW?=
 =?iso-8859-1?Q?FaeBhffwOXxjXIa66iVWV/OSOZv9sRowLIHxXKt1mWRtDF6L2JteOPAmhA?=
 =?iso-8859-1?Q?js72qo/omL8DUIRq4BmF/2QlDTqORdUMnjp9WD4Ka9SGwaBCHYNk5BRs/T?=
 =?iso-8859-1?Q?2aqoXN4sc+jh8edL6JrRl95xoxpfltxmk81ATCj0KvECvMK0M1//xU8vum?=
 =?iso-8859-1?Q?qg2r0Cup17Ady4ibAccuR0OTPyv2i+6md5gkVLZQTzGXUVMt0t2amu6rhn?=
 =?iso-8859-1?Q?uAwyps26if6A3Mr5cTCt4/ZkqAIFeFv/grwS8guoIfF/Zn6XK7xqAshPqu?=
 =?iso-8859-1?Q?JW0MhE+t6F239CexFzE8an+JEfyTdZRtDCknhdomusHB3diNBg6cvZalsx?=
 =?iso-8859-1?Q?0qaxfRuqJ3L3iBYNtQu839y9P5/SH1yonOH1YnZbnTQg9HgEIyX1CxbMsV?=
 =?iso-8859-1?Q?IcOqtFs+ixzgC2VHIEnR0jd8XZ2WnPdo0Lj+YRPC02HIuXzGyhr5HzZ4Zb?=
 =?iso-8859-1?Q?wditCOjKU3ng01QdUHhmCCgD29y6hWPKJg/jPCirGHbzEPcitVJ6mcBndm?=
 =?iso-8859-1?Q?0UXy92IrdFZxqmegE/rzJXNLtZSDARQlY0sPw5bW1TvdZJ/kP2pcPhZhXq?=
 =?iso-8859-1?Q?mOgYRNCNeWogkWt05b5ifIevJpzmCB94uQLP21sSqe6+2lXM3Q9nDr1Bl+?=
 =?iso-8859-1?Q?fn3vS358wM2eBsw8hvSAq8N8OZPPI7VqRFWZ83KGijL9zabRL+rHJUZZ/Q?=
 =?iso-8859-1?Q?3eZvR6EoAmNycRoc1fGfOh9LM42cgCDrq7/Oo4ub8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cab7d8e-c36b-4584-bf6b-08dd65e6274c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 06:28:53.2097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7490

=0A=
> There's room for improvement WRT how out-of-memory failures are reported=
=0A=
=0A=
I am currently trying to find a good optimization solution for this. Since =
initramfs is decompressed in the early stage of the kernel, if the decompre=
ssion fails, it will call panic to put the kernel into a panic state. There=
 is a contradiction: at this time, the console and serial port have not bee=
n initialized yet, which will cause the error message to fail to be output,=
 resulting in a suspended state, and no valid output can be seen.=0A=
________________________________________=0A=
From:=A0David Disseldorp <ddiss@suse.de>=0A=
Sent:=A0Tuesday, March 18, 2025 09:14=0A=
To:=A0Stephen Eta Zhou <stephen.eta.zhou@outlook.com>=0A=
Cc:=A0jsperbeck@google.com <jsperbeck@google.com>; akpm@linux-foundation.or=
g <akpm@linux-foundation.org>; gregkh@linuxfoundation.org <gregkh@linuxfoun=
dation.org>; lukas@wunner.de <lukas@wunner.de>; wufan@linux.microsoft.com <=
wufan@linux.microsoft.com>; linux-kernel@vger.kernel.org <linux-kernel@vger=
.kernel.org>; linux-fsdevel@vger.kernel.org <linux-fsdevel@vger.kernel.org>=
=0A=
Subject:=A0Re: [RFC PATCH] initramfs: Add size validation to prevent tmpfs =
exhaustion=0A=
=A0=0A=
On Mon, 17 Mar 2025 09:41:35 +0000, Stephen Eta Zhou wrote:=0A=
...=0A=
> Before the init process runs, initramfs needs to be decompressed to tmpfs=
 and become the root file system (rootfs). If there is insufficient tmpfs s=
pace after decompression, init may not be able to run at all, causing the s=
ystem to crash or panic.=0A=
>=0A=
> Letting the init process decide whether it is sufficient means that the i=
nitramfs must be decompressed first, which may have filled up tmpfs, making=
 the entire system unusable, rather than a controllable error handling proc=
ess.=0A=
>=0A=
> This problem is more obvious in extreme cases, for example:=0A=
>=0A=
> 1. After initramfs is decompressed, there is only a small amount of avail=
able space in tmpfs, causing early-user-space tasks such as mount and udeva=
dm to fail, affecting device initialization.=0A=
=0A=
It's still not clear to me why early-user-space can't determine this=0A=
before attempting to mount, etc. It's in a better position to know the=0A=
resource requirements of what it's going to run.=0A=
=0A=
> 2. On embedded devices, tmpfs is usually configured small, and insufficie=
nt space is found after decompression, which directly leads to boot failure=
.=0A=
>=0A=
> The reason why the check is performed before decompression is to expose t=
he problem in advance to avoid the passive failure mode of insufficient spa=
ce after decompression.=0A=
> Calculating the theoretically required tmpfs resources and making judgmen=
ts in advance can reduce unnecessary I/O operations and provide clearer err=
or reports to help users adjust the initramfs size or tmpfs configuration.=
=0A=
> My idea is to expose problems as early as possible. If problems occur dur=
ing operation, it may be more troublesome to troubleshoot or bring unnecess=
ary risks.=0A=
=0A=
There's room for improvement WRT how out-of-memory failures are reported=0A=
and handled during decompression and I/O. However, adding an extra pass=0A=
and some arbitrary free-space logic doesn't improve the situation IMO.=0A=
=0A=
Cheers, David=

