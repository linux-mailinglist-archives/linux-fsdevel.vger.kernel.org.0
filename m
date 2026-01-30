Return-Path: <linux-fsdevel+bounces-75942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBn0NnGxfGmbOQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 14:26:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 64130BAFC0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 14:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2221C300DD40
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 13:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B742E06E6;
	Fri, 30 Jan 2026 13:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="PaX2q8mW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020097.outbound.protection.outlook.com [52.101.61.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A219429D26B;
	Fri, 30 Jan 2026 13:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769779554; cv=fail; b=OAsYPaHf0Cw8CTVp8nYVLq2/rBcIUopsjLsiz64L28JqOFxsXesKksMpHCYnW6RqGUypQOHYy8jRdBlyS4nRwgbf0Wl90Fq2yp2jw624mQiiH0Voa5smpNqk7u94hAlUps66VyEth/P5LW48EyexzqvoC4absAI3c0Mfqv3jo+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769779554; c=relaxed/simple;
	bh=jWjmfvSxQAfvOWL8S6KjbjIl7wNdbfoA/L3Ja74QJyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lAByIqbtANyj4Mtg05/oZ7teivOOU4P88iopUpVVgCJQYuBaeEDZbDz3OUgPsAk9jiZymnTT6ZGxlJ+zTriC2AhOy1ZQiEuLF25lQJZA8UXjvC1YgyurGH8EIYGB02FBiWO8SkMRwqz7deb2gR2OQX5rHhs30p/XqCY3kBjoTM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=PaX2q8mW; arc=fail smtp.client-ip=52.101.61.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ukoWZrxa8ZOgTgUMVuh7yCeGlxGiRzhpsrkUeai+rU/P6CWegO2O3SHkKdjsmwPDUKNIrF4/auSMZ1+s5+6rXl+EoAIipCDQbymvJ1Ove/gebfxUgd0rDdZCOoDSI2GskWO5yIGmGmieEpe1Nka1+wtg0LyK2oYSoixO4+wGJJD6x3fWvENResewWHoHll7HuKy8ckUQzsTc4yEyk1QJ0l7fJYWAkaWdUf8txHLzgEE0dGUzjLLpJLAvpp6vciFOdZbwDHJ3oY4+kL3+F9eFzLejHdTvifbSGCqt8qjdyVWRsyBmUX0F44cS+dnB8BVIu+/AoJLoeEw/8VmOFiNkzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UlLX1m60XtkaEr2AaK3+owIrYYJv4alK7LxgXsBAqkk=;
 b=hMtGgIioWooAGudRzHNplRjw3iKfitTZ2OwdmdSU0Wx8AAIHi5RDU5NIXanIBsgFehbUA4ab+FndamKGYqzdk2a/DKCQxNHKRRbnXJ7VGrN7K5XNJswQ48Cu4K1ssE6oGy9+AwzcibvdYZdBjWNzX9p6uu6QvjKdkatmYWKidxdm1cExvf+ge4RahgAQcvoc0LrZ3ENvPWZy3SD/eW/zKRdgyW/Ww6wryXtypgLROSBC+ed1ZwcA5cApSMjYcfmmD+pJxArcBe4umCxK9lEO5hO3+EkUWOdNc57VfY/YGx43Z8TgIPHL2w0xxSBc6ffUvvc4hfb7g5hlrcpuVKFmJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UlLX1m60XtkaEr2AaK3+owIrYYJv4alK7LxgXsBAqkk=;
 b=PaX2q8mWm8Vbw/S/VDx6IXjhYtmZY4au4Wv2q3MDScOTVeFjCDS2RChy1fG2JFo6w6lKs0YMH8JiuPqMS4+rpElt42E/Efhfafu4WT5ufcFVZoHedplDjUi73f7J4PWPHX5RzNOL6INAhl8PTCBnlBC455ZkWZfOR2TTwV2lOxE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 CH2PR13MB4458.namprd13.prod.outlook.com (2603:10b6:610:6c::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.11; Fri, 30 Jan 2026 13:25:49 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9542.010; Fri, 30 Jan 2026
 13:25:48 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Lionel Cons <lionelcons1972@gmail.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 3/3] NFSD: Sign filehandles
Date: Fri, 30 Jan 2026 08:25:45 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <97207D44-31EC-474F-8D68-CBA50CA324AE@hammerspace.com>
In-Reply-To: <CAPJSo4XhEOGncxBRZcOL6KmyBRY+pERiCLUkWzN7Zw+8oUmXGg@mail.gmail.com>
References: <cover.1769026777.git.bcodding@hammerspace.com>
 <0aaa9ca4fd3edc7e0d25433ad472cb873560bf7d.1769026777.git.bcodding@hammerspace.com>
 <CAPJSo4XhEOGncxBRZcOL6KmyBRY+pERiCLUkWzN7Zw+8oUmXGg@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PH8P222CA0012.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::25) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|CH2PR13MB4458:EE_
X-MS-Office365-Filtering-Correlation-Id: c24aaecd-7fbd-475e-bb5c-08de600314cd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7053199007|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P61He4P/F7MU9yfXZDRoNFeO/Fi6ACE652rtFVSOlZ5Gtzioycl5TSbTAx+A?=
 =?us-ascii?Q?76pwhVghNfvknT+DFd/GHPt8dZvqDlSMSD5K2b3sQ4XfDO3Z3bwpYfx+cIOi?=
 =?us-ascii?Q?vo0zLb99GpcD+JMcD3OlLRp5o2+n9hH29oqGq1u0OLG62p/hCy9aG8eaNU90?=
 =?us-ascii?Q?uxCf2T6/spT1EHGiwq9cwqZctazZKdhQ5bnFh/E1KI5OpOPNftJiLzKSAjp2?=
 =?us-ascii?Q?lKExnOJvvAwWzOyyMwCc7M1nsZxQ730rZLGf53Fx9ZkAAnBgbNKu3N2TdBBM?=
 =?us-ascii?Q?TunTt+yFOZm3LKwYHdrBFS4K9bz1zthW+91kc/iJYt2EHZHmnmlI/+0QHvhH?=
 =?us-ascii?Q?9HU+41KW0DLLu8yNuHwGWc7+lpvkLKMgnbbNl49iM1Agipuradm/oLwMyi0b?=
 =?us-ascii?Q?hbPQPTX6J8Aq0iHoeu6N7D4XyNjMOOkztbyuqq78TXaUnSaaRCxuIv2k8TIm?=
 =?us-ascii?Q?k70kRlI9V2x+pqLz0jdvShzv9s9FFdBKtrRMSZiqlXk3pWCg6K5CDTT7gce9?=
 =?us-ascii?Q?VdMh+ncoD5EPI4bkLCL/hha8LNIwWEINpctcBJxYtdNNcwdI5pbHNc8LVVzk?=
 =?us-ascii?Q?3A/uJiivdZak1DTZbq/LaFIUAUWlCbL2iiC++9p8VubpimfKV1W0qV8Yy95U?=
 =?us-ascii?Q?SIUxQzdlfhKoIBYwaqvj+WrvAtvgfGcRM/aq7MRXsMnPbOvME4kWh5B1D25v?=
 =?us-ascii?Q?IYa4XuEfKoYLj6Hgnq4HnkeftHSThqtrQ6u3MCkSu7pT8H/tHB/nK5jMnRS0?=
 =?us-ascii?Q?C73ZKjXFVr81K/C+1Uv8A/TGQneMLs8c+ORgHpWzkLbvFjZ2AURiEkh4OWPm?=
 =?us-ascii?Q?29Q4kxjHvfi4edNfMDB9CKWMRv5uuYmIoMsGpU/hFNsxve1VusKCdr0V9jpT?=
 =?us-ascii?Q?EOnPYPeE4SWTqxTGReVKIl58+bpw64mdi7tErw0eaBHIi4GYxECGsZwLKBdf?=
 =?us-ascii?Q?9LfsOLjIvg0oLPxkSDd1pS89OORSMtk2LNuagfCWeUKLLN+TjOTG6a60rABN?=
 =?us-ascii?Q?sIepZKmVOL+45zBnfupWY0FJQ7G9VQsySwZBTkH4QoCJZIBF/4VOWZGP/CrO?=
 =?us-ascii?Q?9yT5KljS2eoEWwKtEEV/NAGE1lpC9xMZm/eYTKVUu+8MB4u3LOqqt2aGvPW+?=
 =?us-ascii?Q?QCR9Y0RzuFihfB3qc5uDfRyaK7U0nQrcGg2TXdVi8qRx6g9hrSOfFCQ2Uh1d?=
 =?us-ascii?Q?QNGn+BunRtW1kIrPXhPtNazugi9TvM+vP16nw73nio3H5P4hs1DMsBnMnLwO?=
 =?us-ascii?Q?q+XZUA/I+bAUdc7xy4DK4amXwPPpmwbL9WyKoEbMXGz+PMEU8bR+R4uZxKXZ?=
 =?us-ascii?Q?sinGyNKg+yqzlZpVxVcUPE/e3nmrnVflH6rI/C8FiEDba/EgYSqwxCI5yLbw?=
 =?us-ascii?Q?TXnDzypQZCLF7qAYCJ7j05MQr9hXojCJFbvqHjgOtPE686BEgmWMCS0HzToq?=
 =?us-ascii?Q?A5eZg4FVR4c3TXqdAkGKboxWXIRUcdV7K14kmWxRruOLbKvJcSgbPrJ/oWHx?=
 =?us-ascii?Q?crrZl0cXdt9x/Qh/5bdwPdlUXo07O4oWctaRoYE45qu04XkqJRimQw2+IJjS?=
 =?us-ascii?Q?7W8C8Kvh0wB5t4zDzgM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tYqAuzKHtgLRdRusZY4cbd15JTcFmTNgs2ldJIt8MOKjxSY+WKoQr5jE3i+p?=
 =?us-ascii?Q?bAWMA4P+0XCWMYREzcdAwSCgYjI4dtXTntURIdkEnrrmwmybRnqpOrRmRKkM?=
 =?us-ascii?Q?rTzaPyXcIFLs47q/l9TYMbg9UjiDAko+vIArQfGZ5Eor8cr2yrFG890phtGT?=
 =?us-ascii?Q?vQzqueWagvHheFjRPn/hVtwbBBTl9Wvi0wtUgf1fWQn6+EoMZLdww8byzbUd?=
 =?us-ascii?Q?J6r6n2HQzYazAml2IUmp1L0EjbdytEo2e1tlT80AMsSxXz+JnNICyojiR4b1?=
 =?us-ascii?Q?BmRhjMLcbvSgkq96X4g3GaGDkNFF5vq3MjoUL+bmYI6bjpGMn6ocgaF7k0Yz?=
 =?us-ascii?Q?+q9vmlWFYg3QNhqNjftpq3udFL/ofy22fCm/a4R1lPVG+2Z6rzFNvMelnQe4?=
 =?us-ascii?Q?bQB0O0HqWBBstpKxmTxBBckggU4Aa8TQMn14WxkGAL+IZEGVO5OVXgyV4Apm?=
 =?us-ascii?Q?ki1Kh3vP8o1uk+BzfXYigwoX8h2Hdp7eFMqS3LF9g2bBhoEGHYDTu3iSqvma?=
 =?us-ascii?Q?CMAkKWR9yBiria6E62U0ULTnAgJZuiz2Ro8IxW78PP0cnicdBigIJgFq7yrv?=
 =?us-ascii?Q?xFtgEYujj1q3RyX41f9FCVUIX4ElpvPy8AtGQF5ASMIlLkE9asvZncvRv7SZ?=
 =?us-ascii?Q?liBAtdbBwF0XlbQaB1tf9+quO5fT8Ye2qDdeCU2ntI1FSgIm0zpyZkC0wyUk?=
 =?us-ascii?Q?ULxu5IdZInw4gVrrJjmBEZ9tQr0OMT1KBiC/tNQzlhbatC4wKiy8I2F9vsP0?=
 =?us-ascii?Q?h7B23w8ZDzM3oFwGCCsDDh4Fx/MOEv/kNMF6LFaUvi4yNwWwSGDCJvat1q5s?=
 =?us-ascii?Q?qtk4wUjVoCXJLINt9jF2prPKgN341uGzj63MQnVAsaMPGN+YJc39r6JqHeRY?=
 =?us-ascii?Q?K+M2V5y/xNAoPCA9VOobQFNiG6RJGcsiu22H3jwYMSUcyCvKnN5VLmOQCT1i?=
 =?us-ascii?Q?YixuZwqzijD2jhylFpl2azRNNughS/vr/p+ndmEaan5SdKuWW4WkObDVzbFF?=
 =?us-ascii?Q?FQOuT3tP05mICMofxFpTYy32gkR01tpdatgORAU90vSMK8+NUOL5KGLxrUpE?=
 =?us-ascii?Q?7AMtfBIOsd+PXlGGtC26cgqaebgyeBGjWicNAX/XqoFctRo1sQFzs84xFYSS?=
 =?us-ascii?Q?h54lwXDVwMSxcm/x7M5d+H7en8EJ/Axr3qIzszH8UUWehS6lRzN8cn9YHqLP?=
 =?us-ascii?Q?C30VOu8mru8xRZZGsp7QkDLaXi47Jj7RfCswz/av1Pb2SZlZKauCLl5FwjZm?=
 =?us-ascii?Q?gXVbe1c8v68Xp86V8lMrAa0VlwaxINNF42UZrMzRgZYvl1oXhiO/oyjIro0V?=
 =?us-ascii?Q?Z7hgK4NNsjESi53sEpy6SCZTh0FfULQzf93Bc+O0zGyBiThZby6Or/Xpb4n0?=
 =?us-ascii?Q?h8UXb7N+HD3Dtx2kLHQ0/1DVgrB5TS+e2RJYUteuwZyaWLI/tHPb1Kz0YT2D?=
 =?us-ascii?Q?BJ1cT6hBC801fUNsU4mlwt9IZE8n19vUFk4b2ryNL3GJE66i4CrG/dIoblKK?=
 =?us-ascii?Q?znvsdhdxKqDnL6EbBjcEAC+DC913fMSSxD5TG/rKJli9IR+zEOEr2cZD/TyQ?=
 =?us-ascii?Q?xR3DIe8neERCmm5A+joUZwGFlGRU7kJOc3Phhuw9Sw6hC4e4u/3Xm20gb17T?=
 =?us-ascii?Q?O0ImfvPI2XpXfL6aD1clN77X67ELuRQaIGyI7E79/keQCRrB4GOd1eeip9nF?=
 =?us-ascii?Q?WKduPQIqU0O2H7gCzLVPrCX1xDbVFNWQjLXkNAfKTk+YdV/Qgi8sAr3i6tsp?=
 =?us-ascii?Q?hLfm7dfh0z42Nw/OzAw1yBlIVQ3HvS0=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c24aaecd-7fbd-475e-bb5c-08de600314cd
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 13:25:48.5625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qiHtcloGLZJjCXVwPHcB8/i98uEe3YhiaU8SlQmouLTl/2gT6zvVBYTXNWvNvn00Ui51qr3o12NUY66ro3ruIW1Y+vJzJ04Xhuqj4ATOqFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB4458
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75942-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	REDIRECTOR_URL(0.00)[aka.ms];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:email,hammerspace.com:dkim,hammerspace.com:mid,aka.ms:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 64130BAFC0
X-Rspamd-Action: no action

On 30 Jan 2026, at 7:58, Lionel Cons wrote:

> [You don't often get email from lionelcons1972@gmail.com. Learn why thi=
s is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> On Wed, 21 Jan 2026 at 22:03, Benjamin Coddington
> <bcodding@hammerspace.com> wrote:
>>
>> NFS clients may bypass restrictive directory permissions by using
>> open_by_handle() (or other available OS system call) to guess the
>> filehandles for files below that directory.
>>
>> In order to harden knfsd servers against this attack, create a method =
to
>> sign and verify filehandles using siphash as a MAC (Message Authentica=
tion
>> Code).  Filehandles that have been signed cannot be tampered with, nor=
 can
>> clients reasonably guess correct filehandles and hashes that may exist=
 in
>> parts of the filesystem they cannot access due to directory permission=
s.
>>
>> Append the 8 byte siphash to encoded filehandles for exports that have=
 set
>> the "sign_fh" export option.  The filehandle's fh_auth_type is set to
>> FH_AT_MAC(1) to indicate the filehandle is signed.  Filehandles receiv=
ed from
>> clients are verified by comparing the appended hash to the expected ha=
sh.
>> If the MAC does not match the server responds with NFS error _BADHANDL=
E.
>> If unsigned filehandles are received for an export with "sign_fh" they=
 are
>> rejected with NFS error _BADHANDLE.
>

Hi Lionel,

> Random questions:
> 1. CPU load: Linux NFSv4 servers consume LOTS of CPU time, which has
> become a HUGE problem for hosting them on embedded hardware (so no
> realistic NFSv4 server performance on an i.mx6 or RISC/V machine). And
> this has become much worse in the last two years. Did anyone measure
> the impact of this patch series?

We're essentially adding a siphash operation for every encode and decode =
of
a filehandle.  Siphash is lauded as "faster than sha255, slower than
xxhash".  Measuring the performance impact might look like crafting huge
compounds of GETATTR, but I honestly don't think (after network latency) =
the
performance impact will be measurable.

I attempted to measure a time difference between runs of fstests suite --=

there were no significant measurable effects in my crude total time
calculations.

I could, if it pleases everyone, do a function profile for fh_append_mac =
and
fh_verify_mac - but the users of this option do not care about gating it
behind strict performance optimizations because we're fixing a security
problem that matters much more to those users.

> 2. Do NFS clients require any changes for this?

No - the filehandle is opaque.

Ben

