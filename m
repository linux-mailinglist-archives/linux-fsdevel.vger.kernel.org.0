Return-Path: <linux-fsdevel+bounces-45117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A03A72B6E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 09:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09EF21889D79
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 08:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1002054F6;
	Thu, 27 Mar 2025 08:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UUbH12Rz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013052.outbound.protection.outlook.com [40.107.162.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC671FFC47;
	Thu, 27 Mar 2025 08:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743063910; cv=fail; b=XFsZtTq26z+4O32pG/RNrN35Wj0ogsv6RIcAi1mWECDspY/izkQ8zHUPQr5DVH95r6/uAyqrVpM8U0yHMvGxC49Pkt9G58R4rlCRLecV1pxa+7H3hakiWni1DEIcy2Z/QigOZyHe+urr1DzITJtVcbug/pxOI9AfkbCAOihCz74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743063910; c=relaxed/simple;
	bh=jEIRlsEVxHpzIq52IBkPZAdiTCbRbMXakdv2q8ZFzmc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GPcvLKBfBxIR7BEuEyG1D7SQCiyFi6ZLbxfiym66wlGCqc+2sIhGwQBn/qhEqskYrjSUGzsb8TQy5IdhA6NquGp+Miq3Ln1JrQs99icTozxSGfOj1ArUdUvT6oDeHA5l9hwKHrbA+lSrK7jOwg/tdMVbJaPNJXYlBLfUtM3M9XQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UUbH12Rz; arc=fail smtp.client-ip=40.107.162.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EJ9XQQcx7wodU5FgUTVzaKaeuvydkVYunylpTloIneu8FGeTh7SshIcFvG1FJzGxxLWKUnLnvDcvYNLJt/0003dDb8CypmYEYSVO3dAVbidL3Y9zpWj2E1dVNoN7k0Du59n/trOWz9O55/ALYlU4ndyEV2QLGAkTGwhnJ9bq6AR5kXBGznHidkCNmmBokq3XYfvd1mfmjhmzIE0gCPSulESzaCeSVBy/sNLe5lpAU0C8XL5kpPOAT0XBRvzBpAfKTcAEFO5LHuAGrO7oPNUN93ndrN4X1wxa9BxkrLo2dVxQZV+fYk7YVbaqAmUwbMcbQpZvsTks4FsERmkQtcPagg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kp6DAApjTGbIEWbVjwOESrcgDiewF21ow/Od2lpVI8=;
 b=DKaJNlC1fw5W5eAupLDDiQ3zUJN+KvvHC8QehzUmbEiOKK4C3EDDmCkvXQQkb6TSpu5X1iGKc04Pzk8iMTDXAqGhWmrKDTaz21T/UlceaB6hY9/ERU2D+zDdEChaNo8hs+HqKlQ8ndpGin9J9t2XRIhHN6QeB8VeGv/CJKRitFUZYUh4pLDJQTEhwxeau0hxxQAph7B0Fs8xnVOqAMeX58IZAeqfnPVO1XeRpDBHu18kBi/6UwJBCljGSn9veevIrA1OWDDd3QG8rR3WMTkzKhMT2GTRulGhrkHCOU9SGZ2YEhX6ygZ/EYBVL3TYlqxZIZox5AiJLawWdznwpEsSSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kp6DAApjTGbIEWbVjwOESrcgDiewF21ow/Od2lpVI8=;
 b=UUbH12RzAIcSJvUK1aV3Otx4PQySCZR6ti2h4b9gBzbi12v8y8xTy+aN0TZRFBTUIA62/C7bbYrzlwKBpQBDJw+e19kV+zZcfffQvcsDclyYxvraAZqC5Wz8td0aPi4AZqzVyaJQ0erhsHiczRZUKiIYHyxV7owYh8wDwe7Jy2Ogl0dg9ZwXHNnTyrachEzi89JnghCrZ2iHtFu6jNsfEGm3s9c9dI8qbIfklJPWgscoq+7bzk0eqND+0foNZvh9OYeaRS4928L/lPxLiV26M6o98IAqnKVSHtrEVFzzE50UiZA4fvNPnNucL8nmkopHCP4rhde52l+PfpwS9bwDvw==
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by AS5PR04MB9969.eurprd04.prod.outlook.com
 (2603:10a6:20b:67c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 08:25:04 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687%7]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 08:25:04 +0000
From: Carlos Song <carlos.song@nxp.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
CC: "surenb@google.com" <surenb@google.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "willy@infradead.org" <willy@infradead.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Subject: RE: [EXT] Re: Ask help about this patch b951aaff5035 " mm: enable
 page allocation tagging"
Thread-Topic: [EXT] Re: Ask help about this patch b951aaff5035 " mm: enable
 page allocation tagging"
Thread-Index: AduZebW2ju8oka4lQKylDObdr1dPaQAEPqYAAVmWuTA=
Date: Thu, 27 Mar 2025 08:25:04 +0000
Message-ID:
 <VI2PR04MB111475781D58AE4EA89988D9DE8A12@VI2PR04MB11147.eurprd04.prod.outlook.com>
References:
 <VI2PR04MB11147C17A467F501A333073F4E8D82@VI2PR04MB11147.eurprd04.prod.outlook.com>
 <x5bdxqmy7wkb4telwzotyyzgaohx5duez6xhmgy6ykxlgwpyx2@rsu2epndnvy3>
In-Reply-To: <x5bdxqmy7wkb4telwzotyyzgaohx5duez6xhmgy6ykxlgwpyx2@rsu2epndnvy3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2PR04MB11147:EE_|AS5PR04MB9969:EE_
x-ms-office365-filtering-correlation-id: b83ea8cb-dd78-4993-4b2d-08dd6d08e01e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|13003099007;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?XNgCYcir9uwwhNZ0ndwpZdCQsex2/6KEo4JHWv/gYoIc+oEx05I9WwjE0i?=
 =?iso-8859-1?Q?hlfchkvSvw2o3x/h+j21l4MZadDFVZYo8Bvo3kqdffKrr6CEftlL1sSaZV?=
 =?iso-8859-1?Q?AX4N4jRV6yoCFE3RDqMwh9raLjnPHEvVWaj8uMKCYSR0HHMNfpAPbnt8zW?=
 =?iso-8859-1?Q?lu5+c4d7X6oBzZFG/LxHswuegtKy5tPbZnMNyi7za4ozTiO4Fiqc8ELFvb?=
 =?iso-8859-1?Q?+f4a0WxnOuZqzqm140+govnNumK6jL0xXnM8tDzkxImuCfnHiOEpMDdclu?=
 =?iso-8859-1?Q?LI3J4oBwUFTZDfRXJcX8KpfD3EYIZsv0aDj0Rp0K9OcWzyIlXvVpQIkbb2?=
 =?iso-8859-1?Q?nOnqu9DgdtLL2wMmGtGAXvNu65DhJYwXiE1rdzPnEZhLwHbyPDQ72ISjsx?=
 =?iso-8859-1?Q?LpDY79QkqR5DMihp/1urqxSK/Rk/hYg79ysQtmkutfPVWPDVMag0t6yjXP?=
 =?iso-8859-1?Q?im0rAff8lPgduxL5btVSi4RzwwWOaZAdi3bSFreyts1FfcY0LGUwf6qny/?=
 =?iso-8859-1?Q?7nWAar9sMcmMSHEBAPxDMRntKyn+BnP28PP3En8Rfc4tJXF1nWoqci/6lM?=
 =?iso-8859-1?Q?t4aG0aQ1tmD+P1sFr75D4G3Aegm9xzi7fYOGL6diijxlLqrsLf3WGsO7/6?=
 =?iso-8859-1?Q?tbHDjAYhoNWw+HpqHjabAYeNKALV2IgJKi9yP8H5f7s+SPtpv2m3SHtDlA?=
 =?iso-8859-1?Q?3oBFIrOiX/XKq7wFyf+WMD5xCwmnYO55pTDUTzUraxYnRBmzxlCfSevtEt?=
 =?iso-8859-1?Q?X1yg3dRjaZ3IMXAfhcVU6AnT/bG5jrZ2qEKUCfW+eaUj3RQRFYUsHg/X4K?=
 =?iso-8859-1?Q?WdQmO/beT9QThsQI61qogmgQhi6hj1Mpt19sasYXyzoJRGFHlrVh9GA8d2?=
 =?iso-8859-1?Q?Gk+fFIPwl/P5p8tEJlgHWHhb4qdElbmRyIjcgvqrTWR3otpuLvgN+SFvKZ?=
 =?iso-8859-1?Q?dUhmNz+TZcerFizmwv9ZyuwsBbYEpKWJTfNMTn6hEHMrgjm0ivK0OCxQJS?=
 =?iso-8859-1?Q?DK+wuU2I7dMU/75Cli2jyUqS9k28ZPkODJRaQPrdbZLTIdtF529ZcNAjto?=
 =?iso-8859-1?Q?GHW2I3ibl7sgPeXBKjgWsy3gMyL9X37HFWZMu98mHzENiO7RJTn/27NWey?=
 =?iso-8859-1?Q?3ZiT28ILGgICxpJ9mL1FZQ3pvhmc0Al3NM4vusvHq6D1clpeoLMByqz0Oc?=
 =?iso-8859-1?Q?Fge0e/KCXpvCOxRmG+ggMQVrmrQNkwsLU7LuusvaX26Dv8Yb2gQJjsEYa1?=
 =?iso-8859-1?Q?Efzt/A02YjPYJBHfp1z43P6k0nukd8Z+nSSdCWpbBbQno2JwogB7lSy1lB?=
 =?iso-8859-1?Q?xv/6NNEP7LKdc6ztxweagmFEj2GS8uPbtC5wA3Mxyz8KPV6SBmaWiwMRnW?=
 =?iso-8859-1?Q?brEm8XwFyBypgg4pdqyNQTgyPyrKGa/95mQdzAxtu9gb1AR6z3ckFhWMTB?=
 =?iso-8859-1?Q?LQbO1orNO0GLkOIg7L56XC7PbO7XQINU4vmq27eXp2vjqLTGu/RNaVYOCh?=
 =?iso-8859-1?Q?E=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11147.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(13003099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?2T4zSh1x9+UHxqH9fySzE439SMXDJ7sUMO+Km/SUbyumaMg3EaUxFmOm/U?=
 =?iso-8859-1?Q?G4Ghwobtn14YSH8a5rt/Vski48DDh64XzTY9zGcTprQWghKg28BRvc7PhW?=
 =?iso-8859-1?Q?kpwzTn5IywQlnjVA+2NW4iyC9Fgs+tuH35MmnuKBVAE1v4OdeprWaXVlP1?=
 =?iso-8859-1?Q?7mOiPl958lGSEiaBkc3NLPWrX6fYUQKUqisJUCKucnZ6DEAGYxSImMpWyx?=
 =?iso-8859-1?Q?VUvpMsFa31GAoa0Y+0eKJi2T9ib0xaalgiqeE32ciYQYPjIg2AvsYJJzfK?=
 =?iso-8859-1?Q?S1N8Oxbj/CuwC2cQvFktbCocjkGDlPhzoL7/aY1kQ1zgX+D8EbnosNWmIB?=
 =?iso-8859-1?Q?OUKOKSD1qy6Xa+2Z46fDgjIXyWrhUPPSVX3C8D0SpO3kq5ku7ymkG2Y9Rr?=
 =?iso-8859-1?Q?JXQ7GYF0phPPrm7ehBid4Bw4MI6uJefwFTlnnQSqLLghs7om+Xif0/kQC6?=
 =?iso-8859-1?Q?CWyMtjYJkWJtbiWQeOreWXfQotw0bMfe21PD+jGyCfF5jD2GSA2aRG5GfM?=
 =?iso-8859-1?Q?GqZfHVtzxq/Ucru1YEW2Sr3wTO1XbeZHwsWcMkW2MABF4rDXF6jR3/iw8O?=
 =?iso-8859-1?Q?1Px3KSVkqaGv5kgIhaMAjoR9UJDFUyA7s2mcfb9s5j3Ecoa+uGLpF2D2Bn?=
 =?iso-8859-1?Q?B1P5y4mJmcft7MKGBS/KD+OTsChTKJuRe/56m/3EhUl72OzZq3KB/LXtH7?=
 =?iso-8859-1?Q?z6U6dR6nT7NDZ891zyVeuLBnWLiPOZxqQbdsscveySmXaQv2mtgP8deQvA?=
 =?iso-8859-1?Q?fdJZbqGjc0lx0qixwDj80ym8HgNF3CNMksonqe01WUFsvQB6WmJlCfAY7s?=
 =?iso-8859-1?Q?V/WlMRZJ2GTBGDdKQZzUT9NO/GlAThuuSODzgfiJmQohJSrc0sXaRgZRXV?=
 =?iso-8859-1?Q?TCLB1ZoRgMboTvOP2HeLCU01gCeWNRLhOkHPb2Y6U4+aDWQ9x02WPtzama?=
 =?iso-8859-1?Q?S+IhVOEWU37NUOD/jl+uIJvnOyJISvniXc+7bfKbV3KwAbg3ocv71QcHY8?=
 =?iso-8859-1?Q?3Mfofzjn6K9s/Sv747h0vL871/knbRrY0gQhVHk0+axfYhNAf5mkJijYqn?=
 =?iso-8859-1?Q?K4MBcLLxoKqTh89vp9BwfPH8tQMDyakUNzD6NJCBymQbdoql1NUUvSfVpa?=
 =?iso-8859-1?Q?T192b8zP3gtN+aJBvEy+ffaNO/OIzOHluV1ritP8G8vY7teC142geT4qoL?=
 =?iso-8859-1?Q?0txBlIT1FperYpWSLfPzyv1G+8sfB/iZAy+NMDZJftSAd4lAg1toFEW4KN?=
 =?iso-8859-1?Q?VkNXbRRraDoUH4AW5zqyfnQT3m+g2uEsDVVZPVarYyPIXvKrfVIldZtTy/?=
 =?iso-8859-1?Q?0tlTGpQhx+ov64nDGDJ+isJ6xrg/4/cCq7XfS2MDg9C5eYpcmEuthFtjiN?=
 =?iso-8859-1?Q?Wja6k+AnVWnyVYhzRT2LhIoYIx4gxwr7CaK84/H9ZXw0+0tEJhfymUCNg8?=
 =?iso-8859-1?Q?tzcGBR5WgArKfhr6EHzsAPn+tJQIg9fsGEjhGKM2DQiS8GP80+fPTw+s54?=
 =?iso-8859-1?Q?VHhfvmg1OH/sZ674rBVWP4ImIbyg5w6olTOIWil/UCvMBDrlPHyRsJxp39?=
 =?iso-8859-1?Q?q9qH/fA19DuDbep/g4A1YcteraGvTSt5fEUHPcDmwrSfHWbvdZyTo9KzdK?=
 =?iso-8859-1?Q?bGMrYAG69b1VidxmpZdUB7Rhz9Fy3+2exg?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11147.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b83ea8cb-dd78-4993-4b2d-08dd6d08e01e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2025 08:25:04.3482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2N67ujq4VgfmJQO0W6avA129dT8cO4bcFTKt7RRrHQYNM0svzV1mk5YaFe2DjFw476bbM3fAVUXXTp6XmYCSQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9969



> -----Original Message-----
> From: Kent Overstreet <kent.overstreet@linux.dev>
> Sent: Thursday, March 20, 2025 7:25 PM
> To: Carlos Song <carlos.song@nxp.com>
> Cc: surenb@google.com; akpm@linux-foundation.org; willy@infradead.org;
> linux-mm@kvack.org; linux-kernel@vger.kernel.org;
> linux-fsdevel@vger.kernel.org
> Subject: [EXT] Re: Ask help about this patch b951aaff5035 " mm: enable pa=
ge
> allocation tagging"
>
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report =
this
> email' button
>
>
> On Thu, Mar 20, 2025 at 11:07:41AM +0000, Carlos Song wrote:
> > Hi, all
> >
> > I found a 300ms~600ms IRQ off when writing 1Gb data to mmc device at
> I.MX7d SDB board at Linux-kernel-v6.14.
> > But I test the same case at Linux-kernel-v6.7, this longest IRQ off tim=
e is only
> 1ms~2ms. So the issue is introduced from v6.7~v6.14.
> >
> > Run this cmd to test:
> > dd if=3D/dev/zero of=3D/dev/mmcblk2p4 bs=3D4096 seek=3D12500 count=3D25=
6000
> > conv=3Dfsync
> >
> > This issue looks from blkdev_buffered_write() function. Because when I
> > run this cmd with "oflag=3Ddirect" to use blkdev_direct_write(), I can =
not see
> any long time IRQ off.
> >
> > Then I use Ftrace irqoff tracer to trace the longest IRQ off event, I f=
ound some
> differences between v6.7 and v6.14:
> > In iomap_file_buffered_write(), __folio_alloc (in v6.7) is replaced by
> _folio_alloc_noprof (in v6.14) by this patch.
> > The spinlock disabled IRQ ~300ms+. It looks there are some fixes for th=
is patch,
> but I still can see IRQ off 300ms+ at 6.14.0-rc7-next-20250319.
> >
> > Do I trigger one bug? I know little about mem so I have to report it an=
d hope I
> can get some help or guide.
> > I put my ftrace log at the mail tail to help trace and explain.
>
> Did you track down which spinlock?
>
> >

Hi,

Sorry for my late reply and thank you for your quick reply!
From the trace log, I think the spinlock is from here like this:

__alloc_frozen_pages_noprof =3D=3D> get_page_from_freelist=3D=3D>spinclok

Do you need other log not only this?

> > =3D> get_page_from_freelist"
> > =3D> __alloc_frozen_pages_noprof
> > =3D> __folio_alloc_noprof
> > =3D> __filemap_get_folio


> > commit b951aaff503502a7fe066eeed2744ba8a6413c89
> > Author: Suren Baghdasaryan
> surenb@google.com<mailto:surenb@google.com>
> > Date:   Thu Mar 21 09:36:40 2024 -0700
> >
> >     mm: enable page allocation tagging
> >
> >     Redefine page allocators to record allocation tags upon their invoc=
ation.
> >     Instrument post_alloc_hook and free_pages_prepare to modify current
> >     allocation tag.
> >
> >     [surenb@google.com: undo _noprof additions in the documentation]
> >       Link:
> https://lkml.kern/
> el.org%2Fr%2F20240326231453.1206227-3-surenb%40google.com&data=3D05%
> 7C02%7Ccarlos.song%40nxp.com%7Cdf027bbb97074fc2cde808dd67a1d6c5%7
> C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638780666983046738%
> 7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDA
> wMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C
> &sdata=3DAby13KyQjF5pcbYW%2BkfsEJLiaPmS2ZiJLUHJ%2BCr2JXM%3D&reserve
> d=3D0
> >     Link:
> https://lkml.kern/
> el.org%2Fr%2F20240321163705.3067592-19-surenb%40google.com&data=3D05
> %7C02%7Ccarlos.song%40nxp.com%7Cdf027bbb97074fc2cde808dd67a1d6c5%
> 7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638780666983065790
> %7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMD
> AwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7
> C&sdata=3Dn0hjs2fhjYs%2BcnbrxHy4vFK6D4GFVL4%2Fu72anOOLiEI%3D&reserve
> d=3D0
> >     Signed-off-by: Suren Baghdasaryan
> surenb@google.com<mailto:surenb@google.com>
> >     Co-developed-by: Kent Overstreet
> kent.overstreet@linux.dev<mailto:kent.overstreet@linux.dev>
> >     Signed-off-by: Kent Overstreet
> kent.overstreet@linux.dev<mailto:kent.overstreet@linux.dev>
> >     Reviewed-by: Kees Cook
> keescook@chromium.org<mailto:keescook@chromium.org>
> >     Tested-by: Kees Cook
> keescook@chromium.org<mailto:keescook@chromium.org>
> >     Cc: Alexander Viro
> viro@zeniv.linux.org.uk<mailto:viro@zeniv.linux.org.uk>
> >     Cc: Alex Gaynor
> alex.gaynor@gmail.com<mailto:alex.gaynor@gmail.com>
> >     Cc: Alice Ryhl aliceryhl@google.com<mailto:aliceryhl@google.com>
> >     Cc: Andreas Hindborg
> a.hindborg@samsung.com<mailto:a.hindborg@samsung.com>
> >     Cc: Benno Lossin
> benno.lossin@proton.me<mailto:benno.lossin@proton.me>
> >     Cc: "Bj=F6rn Roy Baron"
> bjorn3_gh@protonmail.com<mailto:bjorn3_gh@protonmail.com>
> >     Cc: Boqun Feng
> boqun.feng@gmail.com<mailto:boqun.feng@gmail.com>
> >     Cc: Christoph Lameter cl@linux.com<mailto:cl@linux.com>
> >     Cc: Dennis Zhou dennis@kernel.org<mailto:dennis@kernel.org>
> >     Cc: Gary Guo gary@garyguo.net<mailto:gary@garyguo.net>
> >     Cc: Miguel Ojeda ojeda@kernel.org<mailto:ojeda@kernel.org>
> >     Cc: Pasha Tatashin
> pasha.tatashin@soleen.com<mailto:pasha.tatashin@soleen.com>
> >     Cc: Peter Zijlstra peterz@infradead.org<mailto:peterz@infradead.org=
>
> >     Cc: Tejun Heo tj@kernel.org<mailto:tj@kernel.org>
> >     Cc: Vlastimil Babka vbabka@suse.cz<mailto:vbabka@suse.cz>
> >     Cc: Wedson Almeida Filho
> wedsonaf@gmail.com<mailto:wedsonaf@gmail.com>
> >     Signed-off-by: Andrew Morton
> > akpm@linux-foundation.org<mailto:akpm@linux-foundation.org>
> >
> >
> > Ftrace irqoff tracer shows detail:
> > At v6.14:
> > # tracer: irqsoff
> > #
> > # irqsoff latency trace v1.1.5 on 6.14.0-rc7-next-20250319 #
> > --------------------------------------------------------------------
> > # latency: 279663 us, #21352/21352, CPU#0 | (M:NONE VP:0, KP:0, SP:0 HP=
:0
> #P:2)
> > #    -----------------
> > #    | task: dd-805 (uid:0 nice:0 policy:0 rt_prio:0)
> > #    -----------------
> > #  =3D> started at: __rmqueue_pcplist
> > #  =3D> ended at:   _raw_spin_unlock_irqrestore
> > #
> > #
> > #                    _------=3D> CPU#
> > #                   / _-----=3D> irqs-off/BH-disabled
> > #                  | / _----=3D> need-resched
> > #                  || / _---=3D> hardirq/softirq
> > #                  ||| / _--=3D> preempt-depth
> > #                  |||| / _-=3D> migrate-disable
> > #                  ||||| /     delay
> > #  cmd     pid     |||||| time  |   caller
> > #     \   /        ||||||  \    |    /
> >       dd-805       0d....    1us : __rmqueue_pcplist
> >       dd-805       0d....    3us : _raw_spin_trylock
> <-__rmqueue_pcplist
> >       dd-805       0d....    7us : __mod_zone_page_state
> <-__rmqueue_pcplist
> >       dd-805       0d....   10us : __mod_zone_page_state
> <-__rmqueue_pcplist
> >       dd-805       0d....   12us : __mod_zone_page_state
> <-__rmqueue_pcplist
> >       dd-805       0d....   15us : __mod_zone_page_state
> <-__rmqueue_pcplist
> >       dd-805       0d....   17us : __mod_zone_page_state
> <-__rmqueue_pcplist
> >       dd-805       0d....   19us : __mod_zone_page_state
> <-__rmqueue_pcplist
> >    ...
> >       dd-805       0d.... 1535us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-805       0d.... 1538us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-805       0d.... 1539us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-805       0d.... 1542us+: try_to_claim_block
> <-__rmqueue_pcplist
> >       dd-805       0d.... 1597us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-805       0d.... 1599us+: try_to_claim_block
> <-__rmqueue_pcplist
> >       dd-805       0d.... 1674us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-805       0d.... 1676us+: try_to_claim_block
> <-__rmqueue_pcplist
> >       dd-805       0d.... 1716us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-805       0d.... 1718us+: try_to_claim_block
> <-__rmqueue_pcplist
> >       dd-805       0d.... 1801us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-805       0d.... 1803us+: try_to_claim_block
> <-__rmqueue_pcplist
> > ...
> >      dd-805       0d.... 279555us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-805       0d.... 279556us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-805       0d.... 279558us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-805       0d.... 279560us+: try_to_claim_block
> <-__rmqueue_pcplist
> >       dd-805       0d.... 279616us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-805       0d.... 279618us : __mod_zone_page_state
> <-__rmqueue_pcplist
> >       dd-805       0d.... 279620us : find_suitable_fallback
> <-__rmqueue_pcplist
> > ...
> >       dd-805       0d.... 279658us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-805       0d.... 279660us : _raw_spin_unlock_irqrestore
> <-__rmqueue_pcplist
> >       dd-805       0d.... 279662us : _raw_spin_unlock_irqrestore
> >       dd-805       0d.... 279666us+: trace_hardirqs_on
> <-_raw_spin_unlock_irqrestore
> >       dd-805       0d.... 279712us : <stack trace>
> > =3D> get_page_from_freelist
> > =3D> __alloc_frozen_pages_noprof
> > =3D> __folio_alloc_noprof
> > =3D> __filemap_get_folio
> > =3D> iomap_write_begin
> > =3D> iomap_file_buffered_write
> > =3D> blkdev_write_iter
> > =3D> vfs_write
> > =3D> ksys_write
> > =3D> ret_fast_syscall
> >
> > At v6.7:
> > # tracer: irqsoff
> > #
> > # irqsoff latency trace v1.1.5 on 6.7.0 #
> > --------------------------------------------------------------------
> > # latency: 2477 us, #146/146, CPU#0 | (M:server VP:0, KP:0, SP:0 HP:0 #=
P:2)
> > #    -----------------
> > #    | task: dd-808 (uid:0 nice:0 policy:0 rt_prio:0)
> > #    -----------------
> > #  =3D> started at: _raw_spin_lock_irqsave
> > #  =3D> ended at:   _raw_spin_unlock_irqrestore
> > #
> > #
> > #                    _------=3D> CPU#
> > #                   / _-----=3D> irqs-off/BH-disabled
> > #                  | / _----=3D> need-resched
> > #                  || / _---=3D> hardirq/softirq
> > #                  ||| / _--=3D> preempt-depth
> > #                  |||| / _-=3D> migrate-disable
> > #                  ||||| /     delay
> > #  cmd     pid     |||||| time  |   caller
> > #     \   /        ||||||  \    |    /
> >       dd-808       0d....    1us!: _raw_spin_lock_irqsave
> >       dd-808       0d....  186us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d....  189us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d....  191us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d....  192us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d....  194us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d....  196us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d....  199us : steal_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d....  203us!: move_freepages_block
> <-steal_suitable_fallback
> >       dd-808       0d....  330us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d....  332us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d....  334us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d....  336us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d....  338us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d....  339us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d....  341us : steal_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d....  343us!: move_freepages_block
> <-steal_suitable_fallback
> >       dd-808       0d....  479us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d....  481us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d....  483us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d....  485us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d....  486us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d....  488us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d....  490us : steal_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d....  492us!: move_freepages_block
> <-steal_suitable_fallback
> >       dd-808       0d....  630us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d....  632us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d....  634us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d....  636us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d....  638us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d....  640us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d....  642us : steal_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d....  644us!: move_freepages_block
> <-steal_suitable_fallback
> >       dd-808       0d....  771us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d....  773us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d....  775us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d....  777us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d....  778us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d....  780us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d....  782us : steal_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d....  784us!: move_freepages_block
> <-steal_suitable_fallback
> >       dd-808       0d....  911us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d....  913us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d....  915us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d....  916us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d....  918us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d....  920us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d....  922us : steal_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d....  924us!: move_freepages_block
> <-steal_suitable_fallback
> >       dd-808       0d.... 1055us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 1058us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 1059us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 1061us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 1063us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 1065us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 1066us : steal_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 1068us!: move_freepages_block
> <-steal_suitable_fallback
> >       dd-808       0d.... 1194us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 1196us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 1198us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 1200us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 1202us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 1203us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 1205us : steal_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 1208us!: move_freepages_block
> <-steal_suitable_fallback
> >       dd-808       0d.... 1333us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 1335us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 1337us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 1339us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 1341us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 1342us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 1344us : steal_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 1346us!: move_freepages_block
> <-steal_suitable_fallback
> >       dd-808       0d.... 1480us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 1482us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 1484us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 1486us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 1488us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 1490us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 1492us : steal_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 1494us!: move_freepages_block
> <-steal_suitable_fallback
> >       dd-808       0d.... 1621us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 1623us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 1625us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 1627us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 1629us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 1630us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 1632us : steal_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 1634us!: move_freepages_block
> <-steal_suitable_fallback
> >       dd-808       0d.... 1761us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 1763us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 1765us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 1766us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 1768us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 1770us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 1772us : steal_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 1774us!: move_freepages_block
> <-steal_suitable_fallback
> >       dd-808       0d.... 1900us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 1902us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 1903us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 1905us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 1907us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 1909us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 1911us : steal_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 1913us!: move_freepages_block
> <-steal_suitable_fallback
> >       dd-808       0d.... 2038us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 2040us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 2042us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 2044us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 2046us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 2047us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 2049us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 2051us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 2053us : steal_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 2055us!: move_freepages_block
> <-steal_suitable_fallback
> >       dd-808       0d.... 2175us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 2176us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 2178us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 2180us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 2182us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 2183us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 2185us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 2187us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 2189us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 2191us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 2192us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 2194us : steal_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 2196us!: move_freepages_block
> <-steal_suitable_fallback
> >       dd-808       0d.... 2323us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 2325us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 2327us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 2328us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 2330us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 2332us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 2334us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 2335us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 2337us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 2339us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 2341us : find_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 2343us : steal_suitable_fallback
> <-__rmqueue_pcplist
> >       dd-808       0d.... 2345us!: move_freepages_block
> <-steal_suitable_fallback
> >       dd-808       0d.... 2470us : __mod_zone_page_state
> <-__rmqueue_pcplist
> >       dd-808       0d.... 2473us : _raw_spin_unlock_irqrestore
> <-__rmqueue_pcplist
> >       dd-808       0d.... 2476us : _raw_spin_unlock_irqrestore
> >       dd-808       0d.... 2479us+: tracer_hardirqs_on
> <-_raw_spin_unlock_irqrestore
> >       dd-808       0d.... 2520us : <stack trace>
> > =3D> get_page_from_freelist
> > =3D> __alloc_pages
> > =3D> __folio_alloc
> > =3D> __filemap_get_folio
> > =3D> iomap_write_begin
> > =3D> iomap_file_buffered_write
> > =3D> blkdev_write_iter
> > =3D> vfs_write
> > =3D> ksys_write
> > =3D> ret_fast_syscall
> >
> > Best Regard
> > Carlos Song
> >

