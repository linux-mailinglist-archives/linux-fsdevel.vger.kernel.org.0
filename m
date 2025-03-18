Return-Path: <linux-fsdevel+bounces-44319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF639A67405
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 13:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C0753BFF55
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 12:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09C020DD57;
	Tue, 18 Mar 2025 12:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="c2aj7h8X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2089.outbound.protection.outlook.com [40.92.20.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6B020C48E;
	Tue, 18 Mar 2025 12:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742301428; cv=fail; b=R91EcN4BHjuAINekV/DVSpX3E1OVm2YEJ8mv0fGJY3enD+L9O8C+taDkD2RVKG6L6m+AocQ0wIdkpZl8ctZbuFADInj1+YxMmAuManxeppZmeWHApCqX9TURbEjeXkuqvNIf/tnvT+C1HITYosis7x0/yowHnga0iELiPfHJNIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742301428; c=relaxed/simple;
	bh=9OTivvKl9oiolYgS+pSl2bmcYrpY7jbLZZ458OIpn64=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qq8CPxZ+Foor4vH/Yk+IDvheL1ShjU8yPFMngemeo+fH/gcjnHNIMiNSrIsxxIOuVrWwUOKGXjx++NeXh5fwBKtG8vgh1dHJdcPeDyLCJfzGCoGOQsc/3ocI8+DJe6feJZUJ/j4hOwRYgfWjFkOFDAKZ5SQo0zC08/sMUfpdr5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=c2aj7h8X; arc=fail smtp.client-ip=40.92.20.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ntt8bEQe+v+1NAgo70tmU/y6m2Ci9IUKekUQdAf0utWCdjy4hMZqmg/h6MPAYxQarur0BbWWTh7yJZcHx31/uxlZOd26IzkoOmjQ9BkGLCjl3CAV5NdXNeJCYt3HbX7/AhtJz/ji8ozWoPOrUzzndg9Kz9gpMdWI7sBC32t4NwyKIpjnbfG7RrrURNL+o67nDTIq78qvJ0gcHZEWHG7qbx33LAPrx6RdwLgq1ia6IuQ7gnjls9ocheE8GpWI0g7p7aPXNPVWItyEmWlzUB7ydd4k3CB74r6Tdg5ewenHkW2vPbZqXGVhoOV+KR7AuvkG+VPVwMrTUG/ZLVnDCr49wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9OTivvKl9oiolYgS+pSl2bmcYrpY7jbLZZ458OIpn64=;
 b=ZOOut96Ah1yBxGGtVhPik+WoWvsEojRi12AUnO+BLSPQrVMmBcN/BiofSi1MAlBA1NEYuOHiO8zKP++O/07kB3N4NRKKkr12sWmzFTEM1O1OpYNocKpmgwC+EW9EiOIoVdP0Lp7ZDmZAXQ1uOkhpqnqO3XNeIXSR+i3XGgEIvDqtE9Rh1dLhpToBtW5AExGpRypiOuj7Wj6Nu7IzzdfoyDRc+8XQ02y6CHeJdx3eHBbbK21TE7FK79YDNLfNtrcZym20kS7BkLEL/2tXptegUQHgNl/Mmvlgb6tBkfyEb8iiw07F4OeSTWbL6LH2RKxHtsmm/KgUSBy2BzoPHOAdGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OTivvKl9oiolYgS+pSl2bmcYrpY7jbLZZ458OIpn64=;
 b=c2aj7h8XuvpUPOwM0emFtIzQIJQs+j2QPmtx6b8ZP47JBgZ3wW1Cf/3e321TXsadcn4KVdnLP8opb5CElhFz94v7arsdQpX7JaHMkoLa3wmt8oIyFHRKtaMsMTcv7x9syoTOjjZvg7oLE5/mtGNckVdHLfeWHfwa3uL/EEMqEqoKdZGbR7z8lDnRABuxxngrBCx0Ia6bGTU8sAfaHzTlzjQfOHaZAXw2gzJ+XWb2rmb5Hn3keQNTnZGi5MYgJ3nWAmoNkbU3A2WWVK/KehqxeI8AkatBm2P3TE6rHNXDwvFRdiMsJSdj9X/TfND735GglScJl30iAV7zMWtpEGEYwA==
Received: from BYAPR12MB3205.namprd12.prod.outlook.com (2603:10b6:a03:134::32)
 by SJ2PR12MB8181.namprd12.prod.outlook.com (2603:10b6:a03:4f6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 12:37:00 +0000
Received: from BYAPR12MB3205.namprd12.prod.outlook.com
 ([fe80::489:5515:fcf2:b991]) by BYAPR12MB3205.namprd12.prod.outlook.com
 ([fe80::489:5515:fcf2:b991%5]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 12:36:59 +0000
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
Thread-Index:
 AQHblJ3gvljUi14PpUKtURVssHl1u7N28UyAgAAdT5aAAQ5UAIAAVPUJgAA7kICAACpWmA==
Date: Tue, 18 Mar 2025 12:36:59 +0000
Message-ID:
 <BYAPR12MB32051119909383F5485DBD5AD5DE2@BYAPR12MB3205.namprd12.prod.outlook.com>
References:
 <BYAPR12MB3205F96E780AA2F00EAD16E8D5D22@BYAPR12MB3205.namprd12.prod.outlook.com>
	<20250317182157.7adbc168.ddiss@suse.de>
	<BYAPR12MB3205A7903D8EF06EFF8F575AD5DF2@BYAPR12MB3205.namprd12.prod.outlook.com>
	<20250318121424.614148e1.ddiss@suse.de>
	<BYAPR12MB320590A9238C334D68717C34D5DE2@BYAPR12MB3205.namprd12.prod.outlook.com>
 <20250318205139.71fe0c02.ddiss@suse.de>
In-Reply-To: <20250318205139.71fe0c02.ddiss@suse.de>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB3205:EE_|SJ2PR12MB8181:EE_
x-ms-office365-filtering-correlation-id: 5aa285ce-9a4e-4fa6-e793-08dd661993d0
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|15080799006|8062599003|19110799003|8060799006|15030799003|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?fGbCiNT7dQPHmpDDNk/jIw/3/Nk0B2XK/KlWYSaoiF3UFyivYZvfmur6dn?=
 =?iso-8859-1?Q?agF3wGj0NEarHYI4tcAUhn3O67SP9rAcHJ/dYbtnwVToyhg88te32yXRsx?=
 =?iso-8859-1?Q?BANv1ZS+73G7bghleEkeup3V2m98ZxpbkxQrzydvZ8p/IEp+ehJy2WDC6x?=
 =?iso-8859-1?Q?es7GlhoHgqxZxVi53bic0QHgqkrkB1JHpoGjkpEVKJBeYLwEev/xdYAEx3?=
 =?iso-8859-1?Q?69ULNFCvzxG1uq4+uijB00j3APpjBkPV/OLKsBfjbDzgNGvUnQeelPzBPI?=
 =?iso-8859-1?Q?h357bqiZeXTq0Wg3qyvSlpuwTGbibveRRI5FiPK7iDT3sUWn/dpNTC4Ddz?=
 =?iso-8859-1?Q?HKpNQOvIRl7nB/ZYdKeeVQN3KEG4pfm6bFkR4Klt7TQEtN3qJDFMLvpmrV?=
 =?iso-8859-1?Q?0MSaP2EIGloISZxuYA9vBdqQhB8tqueJbltSDhEdYbpYlE/8jYEPqbRyPg?=
 =?iso-8859-1?Q?9oLORdLqF27ZEJZZ/lc5hapSwudimLpRwZH1wo6+BGk7a5Pjx11k5jObFK?=
 =?iso-8859-1?Q?A1YYIsgqZcwjFsxq3uH7qB4Qju9/TUn7Vaf2aBoKtwpYi6574+HxzzjoL5?=
 =?iso-8859-1?Q?8onR9z9sXblx1ELnUm+73rCZMNvufO0MxNCioZuu8+NmAFyegKvvLL06cf?=
 =?iso-8859-1?Q?OUhNXaNqUtd91meo0Vcs7nLPKegWAmUmCCWEqSL43xHzANpSZjQiANrA6D?=
 =?iso-8859-1?Q?M2ODWLKZQrswtpXKitwxmozMC4DhOKhP/lGGC/Ov4552f2SKvthjjOC61d?=
 =?iso-8859-1?Q?INPLRaFxuB6ls5Lnxdn9SP2Q7dnqTzTIFzlmBfpWbzRWiCZGBbzd+ZbMBY?=
 =?iso-8859-1?Q?BWxMtenxlrTlRxJrHPl4HWYfh969Ixtq27qBYmzOgQMpdQXKdC46tlDbxR?=
 =?iso-8859-1?Q?873yYScl5s/RRKyBg3WbiXdryHgnVN1b39aV4uAwpwI83hA3klt80MN92o?=
 =?iso-8859-1?Q?6sj3xafONMDb4Ev0J/dD1BLD+Mpr4pFrUPrspH9l37WzkPmLRAoIoqDj53?=
 =?iso-8859-1?Q?RTN0XX5ID563s5WWXjfMl2yvabnan2ixDJ8Ii7d72GuMotn6MZgiNj0na5?=
 =?iso-8859-1?Q?V4iHROcElz1JfW3FGWXV6dDzRqA3OejRBCjg9QcdDrNFl/4eWT2zWwLGAJ?=
 =?iso-8859-1?Q?cxlA2ikEBCY0BKQWoC/D1TjpLCmLVLLbKYqfBXzoI72fiZEmZd?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?9xFG5qZi0Wb4WBalfaXAPMI3G82uOtcQtgqKQNxzx7i2Q5l35RLW7oLpS4?=
 =?iso-8859-1?Q?n5BHWeDv+MEr1vod73hCzIG9aiw2RiLTZfcgfHjgjqEKCyuaXWegzM4OFh?=
 =?iso-8859-1?Q?LkVnDOwJhKrLzYmo5G10G5dLF9DW5M/+/VSiypH/h6XTpkdGUwY65RZHZh?=
 =?iso-8859-1?Q?g+3GVOV9aNaeifr/5ynhW9EBfyZEz22Pr71umPkfpRwSdD66/mskcSWCxw?=
 =?iso-8859-1?Q?gZcxBnkdFBv9PsHkNWC4JF6aFeuporQnUJvW0Ph0gnmxVno0e89wKpOWt6?=
 =?iso-8859-1?Q?vzONSfu9x0OIVOG2+QCg9pchriFlzh1mQnTlZpBZZZXvLVNJTjGBowgtl+?=
 =?iso-8859-1?Q?Lt+69mm5MVM988kj6TZePEIz5uYb7J2ynGvP8APsgwoNQysEnR1uU3L10i?=
 =?iso-8859-1?Q?zvHp48QkvfAWj3GGMKE7k7/q2vX285MzsXiEAuy/cVAdeIfpdFu/xMVO1b?=
 =?iso-8859-1?Q?/Zpp8FNz9hEJdUSBsLLneabIcijVIWTOGEAEbi6fW0P9sjswJbstGZIhwr?=
 =?iso-8859-1?Q?voQy2+gxmSqd8dxrRyIRkFsB4JRpwGTjqurWxyEJSL01Wsn1YQDqLhpBdv?=
 =?iso-8859-1?Q?DPlBIaL37hi7BEvfWs5PsTrNLino+wONuLHDBAqNJTxhfIUdWwTcgCdStk?=
 =?iso-8859-1?Q?+r/07u+FiSw9OGqj6bUDaIDuAg0uX8hT9UgVnTsX/RS3jwKQ6ZELppkWas?=
 =?iso-8859-1?Q?LP36cbC2J8jhWdUD26B4Zt0OYn8p5+xueKy9cYdBOuRJaXH9CLuDy+04qC?=
 =?iso-8859-1?Q?ezc7lbH8/kIG7wTu0lYSBs0HY9tcj1Nqg/9+iMOegT2WIjVkIZGbUQ5fXd?=
 =?iso-8859-1?Q?cYhA63X9sQ40WuvVWREm+UmnexRPVQDZgBAknETtEmPiPztNnLTZvaL3zx?=
 =?iso-8859-1?Q?VDC1r/uBXRDpqH3WNXYYgcHYRD89GXb+6SKW8rj0fpyLpak4RlCYEDTgYc?=
 =?iso-8859-1?Q?k56oBSKb0jjTMR4ZudbTuL82ghZc24/u5useuw6Tt/ytlo3nMA7U8rghD6?=
 =?iso-8859-1?Q?51/hvjErVcIqWy8nfN9kBGHNQa0M/kzjib39mM7B0S2gBmf20hdTH1Z6KE?=
 =?iso-8859-1?Q?Vw6pGg2Cj6LxHjOeEPn5qLL0ZfC2drApBWf2wl6nD59fiBwXKOJvFearPG?=
 =?iso-8859-1?Q?CDyRljy0Ey+jcsDZJcOfEj3X74vCUNx74snP1IplV0RdbQE5NifR+BtAXM?=
 =?iso-8859-1?Q?zPybXrseww+cWioC9fFBsng1kllj0q8QUbNQZ402zFSueCeKAxNAYL7030?=
 =?iso-8859-1?Q?8c4fZL9C1Oz4ZwtYfqeujkapJiXW7GBmEFbYqpE2U=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aa285ce-9a4e-4fa6-e793-08dd661993d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 12:36:59.6466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8181

=0A=
> Not always. The *built-in* initramfs unpack_to_rootfs() error path=0A=
> panics, but external initramfs unpack_to_rootfs() failure won't panic=0A=
> immediately...=0A=
=0A=
You're right that the behavior differs between built-in and external initra=
mfs handling. My concern is primarily about the built-in case, where unpack=
_to_rootfs() will lead to a panic if decompression fails.=0A=
=0A=
> Are your console/serial drivers loaded as external modules? That sounds=
=0A=
> like a configuration problem.=0A=
=0A=
My console and serial port drivers are built into the kernel. I found that =
if the built-in initramfs fails to be decompressed, it will enter a suspend=
ed state when panic is called, and no logs will be output (my test environm=
ent at this time does not have the early serial port). After debugging, I f=
ound that console_flush_all did not seem to find an available console. I wi=
ll debug this problem in depth next.=0A=
=0A=
Thanks,=0A=
Stephen=0A=
________________________________________=0A=
From:=A0David Disseldorp <ddiss@suse.de>=0A=
Sent:=A0Tuesday, March 18, 2025 17:51=0A=
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
On Tue, 18 Mar 2025 06:28:53 +0000, Stephen Eta Zhou wrote:=0A=
=0A=
> > There's room for improvement WRT how out-of-memory failures are reporte=
d=A0=0A=
>=0A=
> I am currently trying to find a good optimization solution for this. Sinc=
e initramfs is decompressed in the early stage of the kernel, if the decomp=
ression fails, it will call panic to put the kernel into a panic state.=0A=
=0A=
Not always. The *built-in* initramfs unpack_to_rootfs() error path=0A=
panics, but external initramfs unpack_to_rootfs() failure won't panic=0A=
immediately...=0A=
=0A=
> There is a contradiction: at this time, the console and serial port have =
not been initialized yet, which will cause the error message to fail to be =
output, resulting in a suspended state, and no valid output can be seen.=0A=
=0A=
Are your console/serial drivers loaded as external modules? That sounds=0A=
like a configuration problem.=

