Return-Path: <linux-fsdevel+bounces-45122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66803A72E63
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 12:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2CC1189DB0A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 11:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9945720FAA9;
	Thu, 27 Mar 2025 11:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZI5yv3HW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2076.outbound.protection.outlook.com [40.107.247.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CE23C463;
	Thu, 27 Mar 2025 11:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743073379; cv=fail; b=MKeQxh/8YqH7OpAi4mh1eIURELCMOyaX43KNAuT12Q3PU+LwC1ZnqxM8Bsv8ixKEZvXeWx9ygN2/n4yzu2JF9ReV+Gi6h4AKLor9eSqjnUdkFrrfQFnnc+BqMvJ8+d0j+et13GAE+udBrWymXrJBFrtBwwMi1HQR7bGFKmKLkiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743073379; c=relaxed/simple;
	bh=zH29cgDUEsUtKwLM/YgoohqnHw4cYVLbbhnjSsO3l9M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BFe0WYmna+Hpr9GeeAbFwARM7WWKUIY9Lkdj6pO9T2B2Ff8BB4xesSfDi3q48Kl7k+k+5h27njMasEB583m+6umDmUYcwt/4L++wqowe8+qwKExSj/6PqM/we94H+o/d9LSxyjMVddYGWcKOI+TsKeJdfQnXv2HjubZMg4HBdis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZI5yv3HW; arc=fail smtp.client-ip=40.107.247.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qb2kNByNGOMujJ1FuFYFVRpP3efww4zxsZHFCw+5OqywS+H5zsF5JWygjQxb0+YtiwVJOFYe5CDdB0CXp3D9MPNN67FM69eEtAqB1gwoLUocY0cX6xZdkuEJuJnLrt8Zsru50+Ejq5kMoS6TsjBXwJwCr7b2g/YEtNFYsR7+VNFrhmjKIm5fWGTQQaQVkyK3LP80qo/0brFzQb2vDntCVF6yawJmLMTD0lWIyQCqQb5vsJGmFuHX+yEWoxW5J1epUzqfBSLPZiIAnugjog4zDdE3UmQ08Jxer5nqCq9vx5rmaTCwkMG/HsfR7x0OB2oI+J2PA/MKkQILhqoAhK7OKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TUHdcbX5BUW35RdPF3HwaU0HhzdMlXyKhNoe4Xzkfbg=;
 b=CcThUt17iWU0eVc+snui3l/vnd7MEc3d4xZ9/Iz2Y8VyEDFQT2Rf3sg4RdEboEYPpY5KSg3GRcmooL4hqGgezU54vSb2lgA7xfDTYesHJfnBDQNkEJEwQW+lns9Lm5KQ3ocXtxrUpcXRDSLzdmPrCE+jJksJZcdw/OkexUAZI8UcADXttRTV/iFyWZJNyObe07k7+m3ua0/OV5s3DLk1Qqm3ehtdbI3XgH9VqnX/q00ZlXAnf9Hw40i2yx5L6kH8+xNTXIRNVgjaYUFK9ttrejKp83aAF4j+UFUaPQDNoU5i0Q7FIAvt9K51KKKzGYaP7ECtDjXMsSPdq7gLD2WLyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUHdcbX5BUW35RdPF3HwaU0HhzdMlXyKhNoe4Xzkfbg=;
 b=ZI5yv3HWN/uHkG+8rqHkKVJ82YipMJ5qrvdTPInntGC0DBSeU30XRt8uazcVhCYDM+WwkDSFGTi3R1U8ETKs/jKwmDoHdJ2HBZC+RP12XrVi7zcVodK87VYap26vMj7sHlIqXPgOC1lC6LPjpV303YwY/NpQokiMuLZdO6gsFl6xlEnBLdvgRYMZHKSOBLa85CNfeH5EKhO1roocIIvab9krFmseZQWJ66GOH8wRfJbiZuJ2W6IUntulUK0ORIWdmf8XbqW7H7VaItdlonNgQp5d5E+OSbloYv6uVvQxSbdqGQdt9t9c8ed99oIH41vWT5ZdCBm3N28609XRIHJjbw==
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by GVXPR04MB10852.eurprd04.prod.outlook.com
 (2603:10a6:150:225::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 11:02:52 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687%7]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 11:02:52 +0000
From: Carlos Song <carlos.song@nxp.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
CC: "surenb@google.com" <surenb@google.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "willy@infradead.org" <willy@infradead.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Subject: Re: Ask help about this patch b951aaff5035 " mm: enable page
 allocation tagging"
Thread-Topic: Ask help about this patch b951aaff5035 " mm: enable page
 allocation tagging"
Thread-Index: AQHbnwfICz9NxsMpW0yqT4fiPMCKAw==
Date: Thu, 27 Mar 2025 11:02:52 +0000
Message-ID:
 <VI2PR04MB1114769569D65535C9DA20F0AE8A12@VI2PR04MB11147.eurprd04.prod.outlook.com>
References:
 <VI2PR04MB11147C17A467F501A333073F4E8D82@VI2PR04MB11147.eurprd04.prod.outlook.com>
 <x5bdxqmy7wkb4telwzotyyzgaohx5duez6xhmgy6ykxlgwpyx2@rsu2epndnvy3>
 <VI2PR04MB111475781D58AE4EA89988D9DE8A12@VI2PR04MB11147.eurprd04.prod.outlook.com>
In-Reply-To:
 <VI2PR04MB111475781D58AE4EA89988D9DE8A12@VI2PR04MB11147.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2PR04MB11147:EE_|GVXPR04MB10852:EE_
x-ms-office365-filtering-correlation-id: 1babdb0c-336f-4375-059a-08dd6d1eeb54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|13003099007|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?aS7auWJEa9cvr77WURS98mSGczDz9MR89EQ4VWHADov2mjoH80xfID46+Z?=
 =?iso-8859-1?Q?kZ2OSs9TJ9/XOWNeXUMZRckUrdBxWuccMsYXtc+fmGNJgEfGAqp+jitJ9I?=
 =?iso-8859-1?Q?ZynjA45eoYdOgbo4YsRmRaQ34v2vSfkYyNFbzBwVHUpcD45E/Z0i8wJQco?=
 =?iso-8859-1?Q?GMaABADdhkHYrsfss3cDwgfkJ7UWroXoCDCaA/FCiRfmoajZS5JXFX7nHS?=
 =?iso-8859-1?Q?1gjx27z1Z75NNz6E9sxs4wcBcmxSC6Ck7+D+Ug7OGFHFB8ZONehtvJC2Wf?=
 =?iso-8859-1?Q?1BWfSt1YzaREc+TM5JRfamwF0cUl+9UkpIlmmUC8r5PWdbjGF/9LtTGkn3?=
 =?iso-8859-1?Q?wpvP7MJWEWujVD/n7F5yNyLuwVHTnHwERUjqeCqKopsisIVVyLaMY0ntlR?=
 =?iso-8859-1?Q?Ye0zo3sQsPidfjV1bhn2RCFXtjMLFAtADaLtRMqsHcpyP1OL5IhIGggqdB?=
 =?iso-8859-1?Q?PPcRWTlnf16xulNI6r5QYVpfVPZMR8YIj7wRoJM+mCU5ZIeXt/IpISbR8h?=
 =?iso-8859-1?Q?hoWhrW23YyV3bwQTjz+Hn8wajm7b4VMzHmZPWKiYCn0Hkaj3Y0SoXd+7+Z?=
 =?iso-8859-1?Q?QUrtBIqUpS/8OzNYhxt12kpgr8JZ3y/8Nbxq8PPg1qcae8el7UFa5Hga+O?=
 =?iso-8859-1?Q?pH7YEnjaG4cGfE14mq6CmWkhB9h5lMsQi8M1KMwIpuoB6ZWskZwrvuaau7?=
 =?iso-8859-1?Q?7bHNfjaaMac4SuIChutZSDQ5YDZd9e9UFr1HGrE+WdXUqfPSIF5S2coGHm?=
 =?iso-8859-1?Q?4NEQXBQlcoNJjbUjLpYgdRr/SxG5e82zrUVf9juSL9asn6m3jASijhy9hZ?=
 =?iso-8859-1?Q?3m/kj1jz4M+uWVVTb9K9ZbZMHcq6O/NSrF7zq2vxonLwbwur6ZW+8dSFys?=
 =?iso-8859-1?Q?dSock0R1qZUXvpIpTeChx/psdNB+jl9Zcl6yPMF2nSZ1WnryU5TjF0ukY2?=
 =?iso-8859-1?Q?gcrnlsqAk9LnQBcxqL4aCZ7ooCRoOMcotX1VGJ8mjUgigTW+5RpHxM6q/O?=
 =?iso-8859-1?Q?zcTy64hX/IZg44qbfdR//R4m+fB78/rMIxGPeUt5o5/LXaJD4PPZhr/q3K?=
 =?iso-8859-1?Q?FZ8SpCYnhLUlUX+DEmK3vq+KrXVbl1EdgKS0NDs405h/6l8tTMmOJeVdRQ?=
 =?iso-8859-1?Q?ErSRkRr7QRZQrmfzJEL6Re009jdoeV3uW6tkcWwpPIXydfZQV5KtDPNWMp?=
 =?iso-8859-1?Q?E4UNeefKyHW191IjlmNLW3K2SFCgx36DuX2+rSjqczzx/D83sRJ3WOQeMV?=
 =?iso-8859-1?Q?aVn1ULz8Ipb765wE2IEGHXaMqF4QWU9y+t9F6I3GyoVAxBZU7vNOe1hlpj?=
 =?iso-8859-1?Q?P5q2dJWlQ4bcAVm2yKO8UJpCMkgzCXq0uXrEuIgkVdFEZw50PdUxtuLfPj?=
 =?iso-8859-1?Q?xO+3RRvlz3M3RtRO2+iBrZolIEDApR19jKvBApV5p/iZYTepw20gJb35+3?=
 =?iso-8859-1?Q?8sdJqAVS0uteL6eBnc5wENaPn1e8NVbLvsGNigMHSWnfr6gqHEMNVOPSD0?=
 =?iso-8859-1?Q?vdJ4515tEmEoUQmhK4mbdJ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11147.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(13003099007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?xaOYOXa8CSHnRyzL+qSowU6Rd9/xHCxan8tC5SKm8LtGpUJSk43bttmB7P?=
 =?iso-8859-1?Q?mIEd/ckjws2VvqWNBQoSVLmNFHXlKQnCUmGr0olGsWgK9cj9McPaL49Qdn?=
 =?iso-8859-1?Q?JQ4XcjGq/NUZzqQEkxbVGDayS730FNNlIejF2n9fPqJxwXkvmKZU5/8JKm?=
 =?iso-8859-1?Q?rmYcOURsQK5vA4XZmsK0s+sS9zTnJQM2RDnq70FNNiULQio5GWeb7tLWwx?=
 =?iso-8859-1?Q?ZWkGIVDVyDtliyu4UfhRrYTaHYWkSWPa6r3iOIzmcyO3zUEOEoUmZJ9Nia?=
 =?iso-8859-1?Q?iis+HnbfVo83NasYtdJ7g5+TRZBhxFYvwlLO/Xl0uGnZIgFYrZ3hSC0pWj?=
 =?iso-8859-1?Q?HrNgVIAt39/blYCdj9LyhfKQ/hhOzhUHS5Jg/On+NyB4LDJA1lABkdCFRn?=
 =?iso-8859-1?Q?G3Z4spzVCjV2wfxtJQ2JIZLzWE9RO/EUBa+e68cdH5A1in/PydLT28YpwP?=
 =?iso-8859-1?Q?w/KE72qg9Nkv8zAgSH/z2QhFqSRD5r7YfOpo8KHuvtF4EnBHE5VisexFKS?=
 =?iso-8859-1?Q?SMembPhnK94PhvW6GlwtEi2DCmTyKHK9BhEqIElgxsQ+phX37Agg36tmTk?=
 =?iso-8859-1?Q?kRk3eIF6EDA/Wf8dpe9hdHPs2AD9zSobvBUMS4JZjpzQuWVU2FiIpi/Mqp?=
 =?iso-8859-1?Q?KXecdoYi68wXw2K7ycWDxjSsSHfb8aYodskDlnHGdLh25SjKzcihPUD6Gw?=
 =?iso-8859-1?Q?8QwG3UZB/lqy1uL14iff2G7j8eqLrFTXBHQCKRhbVTs7gOtOgavtiiza6k?=
 =?iso-8859-1?Q?HiNttM3+B2wL3I9quamvc/0/LtUj6z7LCTRfTyl+HxPVH6RKNSmwFwLxB2?=
 =?iso-8859-1?Q?x3zabT/ccNUa0h++nK/WAucD+0dwXVP5dyIeS5B1+6iPROhzTbTq6X7JOg?=
 =?iso-8859-1?Q?db/ZjUwv9X2XrxCjJOssRAM/X0ziYTnTuBPgq823ar/LDzbXmlN5Kg16K5?=
 =?iso-8859-1?Q?0RIVlu5qR4LxXkmgm2Wg0t6yv7emyT24Sf6997TAMUQE9ZxPKy0iVH3HmD?=
 =?iso-8859-1?Q?odDjWGOu0zMqs5DOaWXjIKYCxEdoE4zzbMFLtx5VV1uhj+XPxfZxO5thXA?=
 =?iso-8859-1?Q?m4TgzNnrQAHGSQdpokgq3NXEEPDmdFcRREh+k8V/CQwKBuJkl/YWc/ouM/?=
 =?iso-8859-1?Q?5mgdOdnCZLOGN8erpNGJ0+qJ58vfRHQDGMAxwH3elJWAFfgRj123UYkY/K?=
 =?iso-8859-1?Q?hR7V+gbYOU+0XoSjOhRxx2qWotfozbDHT99Hx4DEwiYvnWSkIL4EeENazB?=
 =?iso-8859-1?Q?2nE+Wt3+KSa2rnfmtRkfNJzBHK7/9Sr9fatMu8ZfzTYO6sB2QEHnPMGBw9?=
 =?iso-8859-1?Q?p8NINDSNQmaBsL3b1osc0Xl7VtFUqmdaM9DHD1nk8bD66AUrtM/xA3oQir?=
 =?iso-8859-1?Q?57XVgcsgSjfBS7yhnkXiU/5zWMP4U616k1CDgNUj48XOLFbWoZROLe/HkD?=
 =?iso-8859-1?Q?qrUC45p7Xgcq/1dv00CpDC3q9cMFk+C6+OfMoCmi+8Y7gzLB15/I/JDUyb?=
 =?iso-8859-1?Q?6H6klAmG1paT/F/Uo8NlF0+hHNiq/iuf/iFRdzOP+NO9PYS8upZWr8rTs7?=
 =?iso-8859-1?Q?X782xDw+7WTuY4KOk4ToLridyTE5wMjewdhZJgy5JrxpO2dvMT9/gVzNBy?=
 =?iso-8859-1?Q?OpDAmceNLVXIacxF8bleu/qc6v9/+l9sUY?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1babdb0c-336f-4375-059a-08dd6d1eeb54
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2025 11:02:52.0657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NDVBDbJgehkHpRRwwG2JfC05wAS4BY3REPaDhqfDN6vMPx4+eZMv7aQkOOHQkDh4XwB28gJTWDw54Ltlm2XTdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10852

Hi,

I get the function calling step log, I hope it can help debug little.

The spinlock_irqsave from 136.725021 to 136.966962_raw_spin_unlock_irqresto=
re.
Around 260ms? It is Just one case, sometimes it will spend more time.

 			  dd-828     [000] .....   136.724980: fdget_pos <-ksys_write
              dd-828     [000] .....   136.724982: vfs_write <-ksys_write
              dd-828     [000] .....   136.724983: blkdev_write_iter <-vfs_=
write
              dd-828     [000] .....   136.724984: I_BDEV <-blkdev_write_it=
er
              dd-828     [000] .....   136.724985: file_update_time <-blkde=
v_write_iter
              dd-828     [000] .....   136.724986: inode_needs_update_time =
<-file_update_time
              dd-828     [000] .....   136.724987: ktime_get_coarse_real_ts=
64 <-inode_needs_update_time
              dd-828     [000] .....   136.724989: timestamp_truncate <-ino=
de_needs_update_time
              dd-828     [000] .....   136.724990: iomap_file_buffered_writ=
e <-blkdev_write_iter
              dd-828     [000] .....   136.724992: iomap_iter <-iomap_file_=
buffered_write
              dd-828     [000] .....   136.724993: blkdev_iomap_begin <-iom=
ap_iter
              dd-828     [000] .....   136.724994: I_BDEV <-blkdev_iomap_be=
gin
              dd-828     [000] .....   136.724995: balance_dirty_pages_rate=
limited_flags <-iomap_file_buffered_write
              dd-828     [000] .....   136.724996: inode_to_bdi <-balance_d=
irty_pages_ratelimited_flags
              dd-828     [000] .....   136.724997: I_BDEV <-inode_to_bdi
              dd-828     [000] .....   136.724998: preempt_count_add <-bala=
nce_dirty_pages_ratelimited_flags
              dd-828     [000] ...1.   136.725000: preempt_count_sub <-bala=
nce_dirty_pages_ratelimited_flags
              dd-828     [000] .....   136.725001: fault_in_readable <-faul=
t_in_iov_iter_readable
              dd-828     [000] .....   136.725003: iomap_write_begin <-ioma=
p_file_buffered_write
              dd-828     [000] .....   136.725004: iomap_get_folio <-iomap_=
write_begin
              dd-828     [000] .....   136.725005: __filemap_get_folio <-io=
map_write_begin
              dd-828     [000] .....   136.725006: filemap_get_entry <-__fi=
lemap_get_folio
              dd-828     [000] .....   136.725007: __rcu_read_lock <-filema=
p_get_entry
              dd-828     [000] .....   136.725008: __rcu_read_unlock <-file=
map_get_entry
              dd-828     [000] .....   136.725009: inode_to_bdi <-__filemap=
_get_folio
              dd-828     [000] .....   136.725010: I_BDEV <-inode_to_bdi
              dd-828     [000] .....   136.725012: __folio_alloc_noprof <-_=
_filemap_get_folio
              dd-828     [000] .....   136.725013: __alloc_pages_noprof <-_=
_folio_alloc_noprof
              dd-828     [000] .....   136.725014: get_page_from_freelist <=
-__alloc_pages_noprof
              dd-828     [000] .....   136.725015: node_dirty_ok <-get_page=
_from_freelist
              dd-828     [000] .....   136.725016: preempt_count_add <-get_=
page_from_freelist
              dd-828     [000] ...1.   136.725018: _raw_spin_trylock <-get_=
page_from_freelist
              dd-828     [000] ...1.   136.725019: preempt_count_add <-_raw=
_spin_trylock
              dd-828     [000] ...2.   136.725021: _raw_spin_lock_irqsave <=
-__rmqueue_pcplist
              dd-828     [000] d..2.   136.725022: preempt_count_add <-_raw=
_spin_lock_irqsave
              dd-828     [000] d..3.   136.725025: __mod_zone_page_state <-=
__rmqueue_pcplist
              dd-828     [000] d..3.   136.725028: __mod_zone_page_state <-=
__rmqueue_pcplist
              dd-828     [000] d..3.   136.725029: __mod_zone_page_state <-=
__rmqueue_pcplist
              dd-828     [000] d..3.   136.725031: __mod_zone_page_state <-=
__rmqueue_pcplist
              dd-828     [000] d..3.   136.725032: __mod_zone_page_state <-=
__rmqueue_pcplist
              dd-828     [000] d..3.   136.725034: __mod_zone_page_state <-=
__rmqueue_pcplist
              dd-828     [000] d..3.   136.725036: __mod_zone_page_state <-=
__rmqueue_pcplist
              dd-828     [000] d..3.   136.725037: __mod_zone_page_state <-=
__rmqueue_pcplist
              dd-828     [000] d..3.   136.725038: __mod_zone_page_state <-=
__rmqueue_pcplist
              dd-828     [000] d..3.   136.725039: __mod_zone_page_state <-=
__rmqueue_pcplist
              dd-828     [000] d..3.   136.725040: __mod_zone_page_state <-=
__rmqueue_pcplist
              dd-828     [000] d..3.   136.725042: __mod_zone_page_state <-=
__rmqueue_pcplist
              dd-828     [000] d..3.   136.725043: __mod_zone_page_state <-=
__rmqueue_pcplist
              dd-828     [000] d..3.   136.725044: __mod_zone_page_state <-=
__rmqueue_pcplist
              dd-828     [000] d..3.   136.725046: __mod_zone_page_state <-=
__rmqueue_pcplist
              dd-828     [000] d..3.   136.725047: __mod_zone_page_state <-=
__rmqueue_pcplist
              dd-828     [000] d..3.   136.725048: __mod_zone_page_state <-=
__rmqueue_pcplist
              dd-828     [000] d..3.   136.725050: __mod_zone_page_state <-=
__rmqueue_pcplist
              dd-828     [000] d..3.   136.725051: __mod_zone_page_state <-=
__rmqueue_pcplist
              dd-828     [000] d..3.   136.725052: __mod_zone_page_state <-=
__rmqueue_pcplist
              dd-828     [000] d..3.   136.725053: __mod_zone_page_state <-=
__rmqueue_pcplist
              dd-828     [000] d..3.   136.725055: __mod_zone_page_state <-=
__rmqueue_pcplist
              dd-828     [000] d..3.   136.725056: __mod_zone_page_state <-=
__rmqueue_pcplist
              dd-828     [000] d..3.   136.725057: __mod_zone_page_state <-=
__rmqueue_pcplist
              dd-828     [000] d..3.   136.725058: __mod_zone_page_state <-=
__rmqueue_pcplist
              dd-828     [000] d..3.   136.725060: __mod_zone_page_state <-=
__rmqueue_pcplist
              dd-828     [000] d..3.   136.725061: __mod_zone_page_state <-=
__rmqueue_pcplist
              dd-828     [000] d..3.   136.725062: __mod_zone_page_state <-=
__rmqueue_pcplist
              dd-828     [000] d..3.   136.725063: __mod_zone_page_state <-=
__rmqueue_pcplist
              dd-828     [000] d..3.   136.725065: __mod_zone_page_state <-=
__rmqueue_pcplist
              dd-828     [000] d..3.   136.725066: __mod_zone_page_state <-=
__rmqueue_pcplist
              dd-828     [000] d..3.   136.725067: __mod_zone_page_state <-=
__rmqueue_pcplist
              dd-828     [000] d..3.   136.725068: __mod_zone_page_state <-=
__rmqueue_pcplist
              dd-828     [000] d..3.   136.725070: __mod_zone_page_state <-=
__rmqueue_pcplist
              dd-828     [000] d..3.   136.725071: __mod_zone_page_state <-=
__rmqueue_pcplist
              dd-828     [000] d..3.   136.725072: __mod_zone_page_state <-=
__rmqueue_pcplist
              dd-828     [000] d..3.   136.725073: __mod_zone_page_state <-=
__rmqueue_pcplist
              dd-828     [000] d..3.   136.725075: __mod_zone_page_state <-=
__rmqueue_pcplist
              dd-828     [000] d..3.   136.725076: __mod_zone_page_state <-=
__rmqueue_pcplist
              dd-828     [000] d..3.   136.725077: __mod_zone_page_state <-=
__rmqueue_pcplist
              dd-828     [000] d..3.   136.725079: __mod_zone_page_state <-=
__rmqueue_pcplist
              dd-828     [000] d..3.   136.725080: __mod_zone_page_state <-=
__rmqueue_pcplist
              dd-828     [000] d..3.   136.725081: __mod_zone_page_state <-=
__rmqueue_pcplist
              dd-828     [000] d..3.   136.725082: __mod_zone_page_state <-=
__rmqueue_pcplist
              dd-828     [000] d..3.   136.725083: __mod_zone_page_state <-=
__rmqueue_pcplist
...
              dd-828     [000] d..3.   136.820279: find_suitable_fallback <=
-__rmqueue_pcplist
              dd-828     [000] d..3.   136.820280: find_suitable_fallback <=
-__rmqueue_pcplist
              dd-828     [000] d..3.   136.820281: find_suitable_fallback <=
-__rmqueue_pcplist
              dd-828     [000] d..3.   136.820282: find_suitable_fallback <=
-__rmqueue_pcplist
              dd-828     [000] d..3.   136.820283: find_suitable_fallback <=
-__rmqueue_pcplist
              dd-828     [000] d..3.   136.820284: find_suitable_fallback <=
-__rmqueue_pcplist
              dd-828     [000] d..3.   136.820285: find_suitable_fallback <=
-__rmqueue_pcplist
              dd-828     [000] d..3.   136.820286: find_suitable_fallback <=
-__rmqueue_pcplist
              dd-828     [000] d..3.   136.820287: find_suitable_fallback <=
-__rmqueue_pcplist
              dd-828     [000] d..3.   136.820289: find_suitable_fallback <=
-__rmqueue_pcplist
              dd-828     [000] d..3.   136.820290: steal_suitable_fallback =
<-__rmqueue_pcplist
              dd-828     [000] d..3.   136.820525: __mod_zone_page_state <-=
steal_suitable_fallback
...
           dd-828     [000] d..3.   136.966945: __mod_zone_page_state <-ste=
al_suitable_fallback
              dd-828     [000] d..3.   136.966946: find_suitable_fallback <=
-__rmqueue_pcplist
              dd-828     [000] d..3.   136.966947: find_suitable_fallback <=
-__rmqueue_pcplist
              dd-828     [000] d..3.   136.966948: find_suitable_fallback <=
-__rmqueue_pcplist
              dd-828     [000] d..3.   136.966950: find_suitable_fallback <=
-__rmqueue_pcplist
              dd-828     [000] d..3.   136.966951: find_suitable_fallback <=
-__rmqueue_pcplist
              dd-828     [000] d..3.   136.966952: find_suitable_fallback <=
-__rmqueue_pcplist
              dd-828     [000] d..3.   136.966953: find_suitable_fallback <=
-__rmqueue_pcplist
              dd-828     [000] d..3.   136.966954: find_suitable_fallback <=
-__rmqueue_pcplist
              dd-828     [000] d..3.   136.966955: find_suitable_fallback <=
-__rmqueue_pcplist
              dd-828     [000] d..3.   136.966956: find_suitable_fallback <=
-__rmqueue_pcplist
              dd-828     [000] d..3.   136.966957: find_suitable_fallback <=
-__rmqueue_pcplist
              dd-828     [000] d..3.   136.966958: find_suitable_fallback <=
-__rmqueue_pcplist
              dd-828     [000] d..3.   136.966959: find_suitable_fallback <=
-__rmqueue_pcplist
              dd-828     [000] d..3.   136.966961: find_suitable_fallback <=
-__rmqueue_pcplist
              dd-828     [000] d..3.   136.966962: _raw_spin_unlock_irqrest=
ore <-__rmqueue_pcplist
              dd-828     [000] d..3.   136.966965: irq_enter <-generic_hand=
le_arch_irq
              dd-828     [000] d..3.   136.966966: irq_enter_rcu <-generic_=
handle_arch_irq
              dd-828     [000] d..3.   136.966967: preempt_count_add <-irq_=
enter_rcu
              dd-828     [000] d.h3.   136.966969: gic_handle_irq <-generic=
_handle_arch_irq
              dd-828     [000] d.h3.   136.966970: generic_handle_domain_ir=
q <-gic_handle_irq
              dd-828     [000] d.h3.   136.966971: __irq_resolve_mapping <-=
generic_handle_domain_irq
              dd-828     [000] d.h3.   136.966972: __rcu_read_lock <-__irq_=
resolve_mapping
              dd-828     [000] d.h3.   136.966974: __rcu_read_unlock <-__ir=
q_resolve_mapping
              dd-828     [000] d.h3.   136.966975: handle_irq_desc <-gic_ha=
ndle_irq
              dd-828     [000] d.h3.   136.966976: handle_percpu_devid_irq =
<-handle_irq_desc
              dd-828     [000] d.h3.   136.966978: ipi_handler <-handle_per=
cpu_devid_irq
              dd-828     [000] d.h3.   136.966979: do_handle_IPI <-ipi_hand=
ler
              dd-828     [000] d.h3.   136.966981: generic_smp_call_functio=
n_single_interrupt <-do_handle_IPI
              dd-828     [000] d.h3.   136.966982: __flush_smp_call_functio=
n_queue <-do_handle_IPI
              dd-828     [000] d.h3.   136.966986: sched_ttwu_pending <-__f=
lush_smp_call_function_queue
              dd-828     [000] d.h3.   136.966987: preempt_count_add <-sche=
d_ttwu_pending
              dd-828     [000] d.h4.   136.966990: _raw_spin_lock <-sched_t=
twu_pending
              dd-828     [000] d.h4.   136.966991: preempt_count_add <-_raw=
_spin_lock
              dd-828     [000] d.h5.   136.966993: preempt_count_sub <-sche=
d_ttwu_pending
              dd-828     [000] d.h4.   136.966994: update_rq_clock.part.0 <=
-sched_ttwu_pending
              dd-828     [000] d.h4.   136.966996: ttwu_do_activate <-sched=
_ttwu_pending
              dd-828     [000] d.h4.   136.966997: activate_task <-ttwu_do_=
activate
              dd-828     [000] d.h4.   136.966998: enqueue_task_fair <-acti=
vate_task
              dd-828     [000] d.h4.   136.967000: update_curr <-enqueue_ta=
sk_fair
              dd-828     [000] d.h4.   136.967001: update_min_vruntime <-up=
date_curr
              dd-828     [000] d.h4.   136.967003: __cgroup_account_cputime=
 <-update_curr

BR
Carlos Song

> > On Thu, Mar 20, 2025 at 11:07:41AM +0000, Carlos Song wrote:
> > > Hi, all
> > >
> > > I found a 300ms~600ms IRQ off when writing 1Gb data to mmc device at
> > I.MX7d SDB board at Linux-kernel-v6.14.
> > > But I test the same case at Linux-kernel-v6.7, this longest IRQ off
> > > time is only
> > 1ms~2ms. So the issue is introduced from v6.7~v6.14.
> > >
> > > Run this cmd to test:
> > > dd if=3D/dev/zero of=3D/dev/mmcblk2p4 bs=3D4096 seek=3D12500 count=3D=
256000
> > > conv=3Dfsync
> > >
> > > This issue looks from blkdev_buffered_write() function. Because when
> > > I run this cmd with "oflag=3Ddirect" to use blkdev_direct_write(), I
> > > can not see
> > any long time IRQ off.
> > >
> > > Then I use Ftrace irqoff tracer to trace the longest IRQ off event,
> > > I found some
> > differences between v6.7 and v6.14:
> > > In iomap_file_buffered_write(), __folio_alloc (in v6.7) is replaced
> > > by
> > _folio_alloc_noprof (in v6.14) by this patch.
> > > The spinlock disabled IRQ ~300ms+. It looks there are some fixes for
> > > this patch,
> > but I still can see IRQ off 300ms+ at 6.14.0-rc7-next-20250319.
> > >
> > > Do I trigger one bug? I know little about mem so I have to report it
> > > and hope I
> > can get some help or guide.
> > > I put my ftrace log at the mail tail to help trace and explain.
> >
> > Did you track down which spinlock?
> >
> > >
>=20
> Hi,
>=20
> Sorry for my late reply and thank you for your quick reply!
> From the trace log, I think the spinlock is from here like this:
>=20
> __alloc_frozen_pages_noprof =3D=3D> get_page_from_freelist=3D=3D>spinclok
>=20
> Do you need other log not only this?
>=20
> > > =3D> get_page_from_freelist"
> > > =3D> __alloc_frozen_pages_noprof
> > > =3D> __folio_alloc_noprof
> > > =3D> __filemap_get_folio
>=20
>=20
> > > commit b951aaff503502a7fe066eeed2744ba8a6413c89
> > > Author: Suren Baghdasaryan
> > surenb@google.com<mailto:surenb@google.com>
> > > Date:   Thu Mar 21 09:36:40 2024 -0700
> > >
> > >     mm: enable page allocation tagging
> > >
> > >     Redefine page allocators to record allocation tags upon their
> invocation.
> > >     Instrument post_alloc_hook and free_pages_prepare to modify
> current
> > >     allocation tag.
> > >
> > >     [surenb@google.com: undo _noprof additions in the documentation]
> > >       Link:
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flkm=
l
> > .kern
> >
> el.org%2Fr%2F20240326231453.1206227-3-surenb%40google.com&data=3D05%
> >
> 7C02%7Ccarlos.song%40nxp.com%7Cdf027bbb97074fc2cde808dd67a1d6c5%7
> >
> C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638780666983046738%
> >
> 7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDA
> >
> wMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C
> >
> &sdata=3DAby13KyQjF5pcbYW%2BkfsEJLiaPmS2ZiJLUHJ%2BCr2JXM%3D&reserve
> > d=3D0
> > >     Link:
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flkm=
l
> > .kern
> >
> el.org%2Fr%2F20240321163705.3067592-19-surenb%40google.com&data=3D05
> > %7C02%7Ccarlos.song%40nxp.com%7Cdf027bbb97074fc2cde808dd67a1d6c5
> %
> >
> 7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638780666983065790
> > %7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuM
> D
> >
> AwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7
> >
> C&sdata=3Dn0hjs2fhjYs%2BcnbrxHy4vFK6D4GFVL4%2Fu72anOOLiEI%3D&reserve
> > d=3D0
> > >     Signed-off-by: Suren Baghdasaryan
> > surenb@google.com<mailto:surenb@google.com>
> > >     Co-developed-by: Kent Overstreet
> > kent.overstreet@linux.dev<mailto:kent.overstreet@linux.dev>
> > >     Signed-off-by: Kent Overstreet
> > kent.overstreet@linux.dev<mailto:kent.overstreet@linux.dev>
> > >     Reviewed-by: Kees Cook
> > keescook@chromium.org<mailto:keescook@chromium.org>
> > >     Tested-by: Kees Cook
> > keescook@chromium.org<mailto:keescook@chromium.org>
> > >     Cc: Alexander Viro
> > viro@zeniv.linux.org.uk<mailto:viro@zeniv.linux.org.uk>
> > >     Cc: Alex Gaynor
> > alex.gaynor@gmail.com<mailto:alex.gaynor@gmail.com>
> > >     Cc: Alice Ryhl aliceryhl@google.com<mailto:aliceryhl@google.com>
> > >     Cc: Andreas Hindborg
> > a.hindborg@samsung.com<mailto:a.hindborg@samsung.com>
> > >     Cc: Benno Lossin
> > benno.lossin@proton.me<mailto:benno.lossin@proton.me>
> > >     Cc: "Bj=F6rn Roy Baron"
> > bjorn3_gh@protonmail.com<mailto:bjorn3_gh@protonmail.com>
> > >     Cc: Boqun Feng
> > boqun.feng@gmail.com<mailto:boqun.feng@gmail.com>
> > >     Cc: Christoph Lameter cl@linux.com<mailto:cl@linux.com>
> > >     Cc: Dennis Zhou dennis@kernel.org<mailto:dennis@kernel.org>
> > >     Cc: Gary Guo gary@garyguo.net<mailto:gary@garyguo.net>
> > >     Cc: Miguel Ojeda ojeda@kernel.org<mailto:ojeda@kernel.org>
> > >     Cc: Pasha Tatashin
> > pasha.tatashin@soleen.com<mailto:pasha.tatashin@soleen.com>
> > >     Cc: Peter Zijlstra
> peterz@infradead.org<mailto:peterz@infradead.org>
> > >     Cc: Tejun Heo tj@kernel.org<mailto:tj@kernel.org>
> > >     Cc: Vlastimil Babka vbabka@suse.cz<mailto:vbabka@suse.cz>
> > >     Cc: Wedson Almeida Filho
> > wedsonaf@gmail.com<mailto:wedsonaf@gmail.com>
> > >     Signed-off-by: Andrew Morton
> > > akpm@linux-foundation.org<mailto:akpm@linux-foundation.org>
> > >
> > >
> > > Ftrace irqoff tracer shows detail:
> > > At v6.14:
> > > # tracer: irqsoff
> > > #
> > > # irqsoff latency trace v1.1.5 on 6.14.0-rc7-next-20250319 #
> > > --------------------------------------------------------------------
> > > # latency: 279663 us, #21352/21352, CPU#0 | (M:NONE VP:0, KP:0, SP:0
> > > HP:0
> > #P:2)
> > > #    -----------------
> > > #    | task: dd-805 (uid:0 nice:0 policy:0 rt_prio:0)
> > > #    -----------------
> > > #  =3D> started at: __rmqueue_pcplist
> > > #  =3D> ended at:   _raw_spin_unlock_irqrestore
> > > #
> > > #
> > > #                    _------=3D> CPU#
> > > #                   / _-----=3D> irqs-off/BH-disabled
> > > #                  | / _----=3D> need-resched
> > > #                  || / _---=3D> hardirq/softirq
> > > #                  ||| / _--=3D> preempt-depth
> > > #                  |||| / _-=3D> migrate-disable
> > > #                  ||||| /     delay
> > > #  cmd     pid     |||||| time  |   caller
> > > #     \   /        ||||||  \    |    /
> > >       dd-805       0d....    1us : __rmqueue_pcplist
> > >       dd-805       0d....    3us : _raw_spin_trylock
> > <-__rmqueue_pcplist
> > >       dd-805       0d....    7us : __mod_zone_page_state
> > <-__rmqueue_pcplist
> > >       dd-805       0d....   10us : __mod_zone_page_state
> > <-__rmqueue_pcplist
> > >       dd-805       0d....   12us : __mod_zone_page_state
> > <-__rmqueue_pcplist
> > >       dd-805       0d....   15us : __mod_zone_page_state
> > <-__rmqueue_pcplist
> > >       dd-805       0d....   17us : __mod_zone_page_state
> > <-__rmqueue_pcplist
> > >       dd-805       0d....   19us : __mod_zone_page_state
> > <-__rmqueue_pcplist
> > >    ...
> > >       dd-805       0d.... 1535us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-805       0d.... 1538us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-805       0d.... 1539us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-805       0d.... 1542us+: try_to_claim_block
> > <-__rmqueue_pcplist
> > >       dd-805       0d.... 1597us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-805       0d.... 1599us+: try_to_claim_block
> > <-__rmqueue_pcplist
> > >       dd-805       0d.... 1674us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-805       0d.... 1676us+: try_to_claim_block
> > <-__rmqueue_pcplist
> > >       dd-805       0d.... 1716us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-805       0d.... 1718us+: try_to_claim_block
> > <-__rmqueue_pcplist
> > >       dd-805       0d.... 1801us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-805       0d.... 1803us+: try_to_claim_block
> > <-__rmqueue_pcplist
> > > ...
> > >      dd-805       0d.... 279555us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-805       0d.... 279556us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-805       0d.... 279558us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-805       0d.... 279560us+: try_to_claim_block
> > <-__rmqueue_pcplist
> > >       dd-805       0d.... 279616us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-805       0d.... 279618us : __mod_zone_page_state
> > <-__rmqueue_pcplist
> > >       dd-805       0d.... 279620us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > > ...
> > >       dd-805       0d.... 279658us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-805       0d.... 279660us : _raw_spin_unlock_irqrestore
> > <-__rmqueue_pcplist
> > >       dd-805       0d.... 279662us : _raw_spin_unlock_irqrestore
> > >       dd-805       0d.... 279666us+: trace_hardirqs_on
> > <-_raw_spin_unlock_irqrestore
> > >       dd-805       0d.... 279712us : <stack trace>
> > > =3D> get_page_from_freelist
> > > =3D> __alloc_frozen_pages_noprof
> > > =3D> __folio_alloc_noprof
> > > =3D> __filemap_get_folio
> > > =3D> iomap_write_begin
> > > =3D> iomap_file_buffered_write
> > > =3D> blkdev_write_iter
> > > =3D> vfs_write
> > > =3D> ksys_write
> > > =3D> ret_fast_syscall
> > >
> > > At v6.7:
> > > # tracer: irqsoff
> > > #
> > > # irqsoff latency trace v1.1.5 on 6.7.0 #
> > > --------------------------------------------------------------------
> > > # latency: 2477 us, #146/146, CPU#0 | (M:server VP:0, KP:0, SP:0 HP:0=
 #P:2)
> > > #    -----------------
> > > #    | task: dd-808 (uid:0 nice:0 policy:0 rt_prio:0)
> > > #    -----------------
> > > #  =3D> started at: _raw_spin_lock_irqsave
> > > #  =3D> ended at:   _raw_spin_unlock_irqrestore
> > > #
> > > #
> > > #                    _------=3D> CPU#
> > > #                   / _-----=3D> irqs-off/BH-disabled
> > > #                  | / _----=3D> need-resched
> > > #                  || / _---=3D> hardirq/softirq
> > > #                  ||| / _--=3D> preempt-depth
> > > #                  |||| / _-=3D> migrate-disable
> > > #                  ||||| /     delay
> > > #  cmd     pid     |||||| time  |   caller
> > > #     \   /        ||||||  \    |    /
> > >       dd-808       0d....    1us!: _raw_spin_lock_irqsave
> > >       dd-808       0d....  186us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d....  189us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d....  191us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d....  192us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d....  194us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d....  196us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d....  199us : steal_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d....  203us!: move_freepages_block
> > <-steal_suitable_fallback
> > >       dd-808       0d....  330us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d....  332us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d....  334us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d....  336us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d....  338us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d....  339us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d....  341us : steal_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d....  343us!: move_freepages_block
> > <-steal_suitable_fallback
> > >       dd-808       0d....  479us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d....  481us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d....  483us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d....  485us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d....  486us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d....  488us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d....  490us : steal_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d....  492us!: move_freepages_block
> > <-steal_suitable_fallback
> > >       dd-808       0d....  630us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d....  632us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d....  634us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d....  636us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d....  638us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d....  640us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d....  642us : steal_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d....  644us!: move_freepages_block
> > <-steal_suitable_fallback
> > >       dd-808       0d....  771us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d....  773us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d....  775us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d....  777us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d....  778us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d....  780us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d....  782us : steal_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d....  784us!: move_freepages_block
> > <-steal_suitable_fallback
> > >       dd-808       0d....  911us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d....  913us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d....  915us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d....  916us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d....  918us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d....  920us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d....  922us : steal_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d....  924us!: move_freepages_block
> > <-steal_suitable_fallback
> > >       dd-808       0d.... 1055us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 1058us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 1059us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 1061us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 1063us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 1065us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 1066us : steal_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 1068us!: move_freepages_block
> > <-steal_suitable_fallback
> > >       dd-808       0d.... 1194us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 1196us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 1198us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 1200us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 1202us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 1203us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 1205us : steal_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 1208us!: move_freepages_block
> > <-steal_suitable_fallback
> > >       dd-808       0d.... 1333us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 1335us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 1337us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 1339us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 1341us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 1342us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 1344us : steal_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 1346us!: move_freepages_block
> > <-steal_suitable_fallback
> > >       dd-808       0d.... 1480us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 1482us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 1484us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 1486us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 1488us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 1490us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 1492us : steal_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 1494us!: move_freepages_block
> > <-steal_suitable_fallback
> > >       dd-808       0d.... 1621us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 1623us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 1625us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 1627us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 1629us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 1630us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 1632us : steal_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 1634us!: move_freepages_block
> > <-steal_suitable_fallback
> > >       dd-808       0d.... 1761us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 1763us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 1765us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 1766us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 1768us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 1770us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 1772us : steal_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 1774us!: move_freepages_block
> > <-steal_suitable_fallback
> > >       dd-808       0d.... 1900us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 1902us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 1903us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 1905us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 1907us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 1909us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 1911us : steal_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 1913us!: move_freepages_block
> > <-steal_suitable_fallback
> > >       dd-808       0d.... 2038us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 2040us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 2042us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 2044us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 2046us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 2047us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 2049us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 2051us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 2053us : steal_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 2055us!: move_freepages_block
> > <-steal_suitable_fallback
> > >       dd-808       0d.... 2175us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 2176us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 2178us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 2180us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 2182us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 2183us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 2185us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 2187us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 2189us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 2191us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 2192us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 2194us : steal_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 2196us!: move_freepages_block
> > <-steal_suitable_fallback
> > >       dd-808       0d.... 2323us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 2325us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 2327us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 2328us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 2330us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 2332us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 2334us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 2335us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 2337us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 2339us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 2341us : find_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 2343us : steal_suitable_fallback
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 2345us!: move_freepages_block
> > <-steal_suitable_fallback
> > >       dd-808       0d.... 2470us : __mod_zone_page_state
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 2473us : _raw_spin_unlock_irqrestore
> > <-__rmqueue_pcplist
> > >       dd-808       0d.... 2476us : _raw_spin_unlock_irqrestore
> > >       dd-808       0d.... 2479us+: tracer_hardirqs_on
> > <-_raw_spin_unlock_irqrestore
> > >       dd-808       0d.... 2520us : <stack trace>
> > > =3D> get_page_from_freelist
> > > =3D> __alloc_pages
> > > =3D> __folio_alloc
> > > =3D> __filemap_get_folio
> > > =3D> iomap_write_begin
> > > =3D> iomap_file_buffered_write
> > > =3D> blkdev_write_iter
> > > =3D> vfs_write
> > > =3D> ksys_write
> > > =3D> ret_fast_syscall
> > >
> > > Best Regard
> > > Carlos Song
> > >

