Return-Path: <linux-fsdevel+bounces-49903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB37EAC4E39
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 14:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 707237AA227
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 12:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DD3267AED;
	Tue, 27 May 2025 12:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZlnYiIQW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2052.outbound.protection.outlook.com [40.107.100.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0955C1E1E12;
	Tue, 27 May 2025 12:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748347662; cv=fail; b=aBCJOL8F12FNQWfho90roXEVBlYi0l2SigPyTenLWW7GwaNYhKw/UWHEAicCBMkaYZh0i0NEGvggAu2t+jXrKjMb4+It5KzflKo7EOwLtmqWyoS1dpAaFDJ1bcfECPGDmiZQ0pOIBw9eeRKaH9fc15nmdOVDbQrWTsl5afO4k0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748347662; c=relaxed/simple;
	bh=1PRcc9nlaeWVA0q4nRofglSzjbtVtoHm+scSjIcw0Ok=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pBQYWeNmr2GS6c9gvHiVodYT9J/0jQhbYeXh7EyE23M9CsAEOkZ10b+UyNHat/mL4Fefn37owBG/6IUlnXuhkK//o7G3YSWbgdlZIOdcNB9zxi4dHQlmE31/Vw8ScITinVqACMxYgvhaftSL7mob7676t3Q5QVOjHwaAKFLLal4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZlnYiIQW; arc=fail smtp.client-ip=40.107.100.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EX0FapyF+egsGz5ncYvkiLCIMmotJoC1KzFAh7cdON5uXeVeKnyit93DCknzmvTyy2Gc6b830XOgMNChX7TMRfkCzvWOTnPL/f2dtMSwMC5Ljit/RYULgJaRn0S+/KBbKXZYwrvpxoof924WUclqTY0k02vRTD30vRqaTgyqrISBbraTjbirwxF5c1V8kwva/qJquJ56O5JXB3VlQF1yEieySJGoUay6pLdXJf1QI0VypH9IdMma/L2znc2k4YmFFSQW9mDHYxrLFmI1V9kolfl41eBhlWaA2RAY58KolJ9dUgKVdMIwVFNfRGETG1P4VKIPkBRTnmgpOTTDK6QcCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ngvv6QYTARlXfljXUd4tDTVVneQThAvGwQRym8FqJY8=;
 b=xuME9+xVKfJJMA/zYQRuWLcxCafE+LkjV11WTjm3EwxgPKBxjx7B+jVlM5eOzJJVi59ClB4eWixUmAWvYd1+DqYQfSTfSj6SZk27g15mj77CZipi3VIQpFTgJHRG+z3fAonq3OzsFrWN/e5tsAnljVvyNmcE1x3HbVJYNj8Wm9iBXxk+fp6nK7sEfdpsFG4FuWmAWA+XFxJkr8WDaslRy2j3guDEEqtDYe0s9gqYWNptnjBqFwEhRYQmyN5y/XXkUHylEgr6l54iwHgY+qZ1TX83sOwNAJVTLFAtK625pNm/+PHx2G/eE0oJLNvB6beB6ogM3EgO9bu5peIp+yc7MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ngvv6QYTARlXfljXUd4tDTVVneQThAvGwQRym8FqJY8=;
 b=ZlnYiIQWCTj8N8EZXQkVV02AJrt7jGiQvzglEZkHx15EOJOj+p0p7nxWFmWAl34Mn0stX8aHRbZQunYqt2FDwUfmTQ7RH2TswMm9aCmh6X8yIS1rcgJiL3um3ts30+6mJL8uz6zRgSkxuIQxgXYa7TXcAUyF3hhJ70Dl6dh4VeCB06weIuLn8DPFr4BANZlbdtXyCwhZTxodPZm5P32Urdis9uaSBqs9zlBgm8xGiAzJmW95Z8rBKlhq2Ml8Dd3A51BS2U5KM920m8WgLdgES+r/iwSRcwjkXHSekxmAbS1scVK4Znpk59aaMuWlcTISPPaad50xnjKEoP9AydNlaw==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by DS0PR12MB8573.namprd12.prod.outlook.com (2603:10b6:8:162::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Tue, 27 May
 2025 12:07:37 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%5]) with mapi id 15.20.8769.021; Tue, 27 May 2025
 12:07:36 +0000
From: Parav Pandit <parav@nvidia.com>
To: Jan Kara <jack@suse.cz>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: warning on flushing page cache on block device removal
Thread-Topic: warning on flushing page cache on block device removal
Thread-Index: AdvMbvrhAHapLL5SQLSXHQ+FhiQIJwB7b58AACZikZAAAg9cAAAAQBBw
Date: Tue, 27 May 2025 12:07:20 +0000
Message-ID:
 <CY8PR12MB7195241146E429EE867BFAF5DC64A@CY8PR12MB7195.namprd12.prod.outlook.com>
References:
 <CY8PR12MB7195CF4EB5642AC32A870A08DC9BA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <2r4izyzcjxq4ors3u2b6tt4dv4rst4c4exfzhaejrda3jq4nrv@dffea3h4gyaq>
 <CY8PR12MB7195BB3A19DAB9584DD2BC84DC64A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <nj4euycpechbg5lz4wo6s36di4u45anbdik4fec2ofolopknzs@imgrmwi2ofeh>
In-Reply-To: <nj4euycpechbg5lz4wo6s36di4u45anbdik4fec2ofolopknzs@imgrmwi2ofeh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|DS0PR12MB8573:EE_
x-ms-office365-filtering-correlation-id: 53389b8d-1041-43a6-cb31-08dd9d17084b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?8/QcPvtB697H9ANBb7WJCn/9Ut9COoMRnkudNmwRqy8+Hw/MVhht7jFYpTrW?=
 =?us-ascii?Q?iWESfiB1bkPF8wviHJXr9swcxr4dmjUUtIb1TcOeZKdGXW7/WWtgXXBG0faz?=
 =?us-ascii?Q?bLKHtzeETAx6JUxfH7HmCfcnSp8jRLyiMKhP938B6MZDRTjQAT2J4mx1edqY?=
 =?us-ascii?Q?h8OzOWONtNejyzcjcmV6MxpjCXW8FkJYCK0C/hwTsGe/JX8XhXS1Lm9nsFV9?=
 =?us-ascii?Q?3bWoAcb63g5PLGd8YT78ZjAOSsr4Qt5A3Z0YtYpkCrCmFv8yJAPoUr89iAob?=
 =?us-ascii?Q?VxuKqcqYcsgFlMiql1kmTsDdD0nijIIfnTgq0lP8vOIZcV7ZJx8jlOmzYcaP?=
 =?us-ascii?Q?deO44UV+HNece7B83pSFsR5XlPzK5W5um0odNGCBMdwMb9G8iOxZaceKfq6d?=
 =?us-ascii?Q?RGLDZRiZVPDlw2qdA7htR02bnSCD3rGHTT1TfHb9Ku/k4MALYJw+cXWtzgwE?=
 =?us-ascii?Q?vcfxg+EWm4RT5bVk7Vph7texxU1xu0QmcZN92sFFO/JjvN7BN8B6pgBizeC8?=
 =?us-ascii?Q?9E20B8pXODRsE2v4G19gXbMBB+9itUuQ28XkcNeg+8z3hpNfKMRd4cmnL2rM?=
 =?us-ascii?Q?7fcb//xXu9K7BOg9cVDA4QhrzuceRyCtBIvVZ697YHrBey1IH/w+CAiGUJv2?=
 =?us-ascii?Q?dPsYgXd1HO1FQPzpff7FilWLNwkujD7tSh8QpXsV+Yt5abg1xhnkeDqgQfKf?=
 =?us-ascii?Q?7aVnpCoL5QbJvoomKFT7wSq2y8kg0PIq3/ZfOCH7jPy1KiK7GSh9GWLJIOYT?=
 =?us-ascii?Q?rnnHYp0E3BQAUrpQiwuYzAbR8Zciap9p71DhYAbme9pDcA0kendztX3HoRqr?=
 =?us-ascii?Q?zy/AJXAWC+i4RxwBCbywEHoDi3xvFELubWJC696HmaKAGnP8KgJFDhpOZfmU?=
 =?us-ascii?Q?zBMMzbvPYkIh0D/TT6pEG5IRnqyVB2H/IkDrSQJoG2TbDcyzvWZcltvYrlty?=
 =?us-ascii?Q?4Vj7GhritXFTnDqB9uufxwatxIu98eoZr7WdNZ/eTtOVDFoKj2aU6+d9DFlH?=
 =?us-ascii?Q?Z5kG6Dcq0iINHbqO8DxjPm++S0hAcqv14t0+0KMnS8e280Tnoou1V265s+gM?=
 =?us-ascii?Q?/GIgcmP0jHmhjXALXICiVnx4VJK/1f6mzicXsLPQyGlL3126Gfv0+FRyeNnC?=
 =?us-ascii?Q?ZPXeHcqqrnQOdkbCfkc2gpsqEyWs6j7vDDfEXtnFGJOumwwcRynbW1IgH5tF?=
 =?us-ascii?Q?RkpwoRiKhQS0wnJw11+CS39UJ2CCYKGQekoF6Oo2OoDyjNpTMR7bc6KsSGf4?=
 =?us-ascii?Q?0L2xkmw9znwBr6+Ig7e8DqJFJ7WWNWDoIv5I9TENsbje42C15oPRAlJLVLcO?=
 =?us-ascii?Q?YC9kNj1KHYSQhIsuC5eOngJUt/YZNdEAH4wKwI8HdQ/xXTkxCXyqFLKhMAJy?=
 =?us-ascii?Q?AxbAHrkGQrRBHzegJoqVa7FxJrNzBTLO0Yxs2MGFoS2f+DoIyFdKJCC+XFI8?=
 =?us-ascii?Q?gaKNUmv/90Gd3cmZmWioXWlR9BZmFvIjWYVuoFJl2yv9v9fzm+CKfCfwtDSc?=
 =?us-ascii?Q?BAEJYRBWz7H3CXI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?viYotr7CLHbZBAbXrR9x7+Xn3eo0wZp5TNEk8bJ0DTexqFmZOUzw+PjRj3RR?=
 =?us-ascii?Q?mQx42wwt+ETshAQOlMScTG1J5o8P0GMrNtIc9iaVWcwlYkaoZCMsZ0zVCmdq?=
 =?us-ascii?Q?9EkGST0jP9aLgfqa9Yqsve2hnmYbDXgqqufg4rut9cw8rT48lvnQNlpuKPpn?=
 =?us-ascii?Q?hcuKhuiMVUAwEysNIKu82EXVhpVqGHJPJGbLOSwSnf2dUrT8s83BliAjuCPt?=
 =?us-ascii?Q?tJhbYFbW5h/g62dlUS3DQwL+pAbEOJtF0GeYCe4H2JKGYyEs2I38nKvePibs?=
 =?us-ascii?Q?Noqv1UVusRcACuczyMyskaPIiL2/82K9DzhtVd2GidfRQSzCo1g7gjhrymBx?=
 =?us-ascii?Q?4zxyAfbQekV8a8+n6NTYuWneErG/bnYfKcbU0RMTNiHMyGVuHk0zUVbtr6jS?=
 =?us-ascii?Q?j+yuGc8ffqYFn9fJBBdyDCUBuJ+cUTJqCBEWjBWtMEzBzya20ic2u/HfoSyp?=
 =?us-ascii?Q?bGciEDUaKFPuU+9/AoWbRnybL9ZJozTJNBKXWg+nmt1FCtvo2jYcU/5TkbIj?=
 =?us-ascii?Q?OfhlR2mhXnrjRVA/HAEXl/UmsgevheUAJJTrGaCsY2a+S4pMOn9qokjKu3lK?=
 =?us-ascii?Q?Kd1svzmM3Wpry43uV67SQK6GZ9LQ7wPj11kH3DG98uYwJWLH8o6CTT70JfFe?=
 =?us-ascii?Q?RfTbIlIJs7D+xkYAurWtW/RGBBgT3l14NE+J7ns3wu7zf2QWR7AgJqkHSpvL?=
 =?us-ascii?Q?R/LRGLMvsRDxcT5IHz8JeVScbpSVBHmm9Tk/+3JEPB3JxdibsIIVvnUXT29K?=
 =?us-ascii?Q?Ts5c2N5YD8DgFAq3VO0fggVV6CB43xSQ38aKC2He2H8nWmblLk1/tE2ISzri?=
 =?us-ascii?Q?vPNsX+GOG5lPosMwS7xJOj9hM0UuVZLOct5ZVglZ9E+j1En/etMd0FIES0zR?=
 =?us-ascii?Q?5siLOMMREdTArWgc6KSQ3iuGogZKgIS4cmbXn6/HJ0dPxFCr7ZQ2M9tQWgWD?=
 =?us-ascii?Q?2XHYlDS+y++py7diJX+N2f0tOJxn7oCjyJhSyrSMIEUHPuTuJgi49oTGszui?=
 =?us-ascii?Q?KrKZ2664R3Kzlz2FbUaIz1N29PmiqeQa2FOla1K/CLifFOl3/oNxe9C+QTqG?=
 =?us-ascii?Q?go6rsvJ6ef84RtV9IUgU6UDuIrbaV+nwdNz3UhKvbbd9hsRZB8B9AVhp1BxS?=
 =?us-ascii?Q?gPA6gbZh1OdlI0TEKeUiRn5Bb6cqlsJWNdTg+5Gq4l1A5pNzdU5n2QEfj64m?=
 =?us-ascii?Q?/5Z6gESOUy5QOJ7ZrLR3IxMRUOl3VcSzPruEu/NAaI31C8DdcMfek7Ap8GVv?=
 =?us-ascii?Q?+mqWcHXYoIQcBbLl7KoBkOcXf8LZ8XRUAErinNnrKk2ZTijWJ/GXWiHa6as4?=
 =?us-ascii?Q?9Wp40/2ZwRnDCcIJuNe6Y8y/hyB6St3ra6o7EvNaCwGmW0IdRwiGxp2TrsCn?=
 =?us-ascii?Q?sW7YXBwSgXKsOwn/pyAqw63/roJvcPzZFX/KDg+hQE9hqgbAsNPVu6oYUO4w?=
 =?us-ascii?Q?afx5XU2XSiejImq12e4wYsHMclOp0D1CkJpXuqJAvHqJnyCwbChSBSNZVDnh?=
 =?us-ascii?Q?cahaKyI+xOV91OWV4VIF1641RQ3Nt1DkBkLTir58vdvFLg6YNO9uaIa1sm+v?=
 =?us-ascii?Q?gH/dZWRKvMSPe140zLwH7q/iWPLYUX/nmgDwT80c?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7195.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53389b8d-1041-43a6-cb31-08dd9d17084b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2025 12:07:20.5272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FKzbbqOnOrLFOK3NqJP7dKfJf8IP1VsQw0OC4W85uolFDeWpD2RhR30bEOVS/xhbX23i4OI6OpHQ0Yk2xrcQYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8573


> From: Jan Kara <jack@suse.cz>
> Sent: Tuesday, May 27, 2025 5:27 PM
>=20
> On Tue 27-05-25 11:00:56, Parav Pandit wrote:
> > > From: Jan Kara <jack@suse.cz>
> > > Sent: Monday, May 26, 2025 10:09 PM
> > >
> > > Hello!
> > >
> > > On Sat 24-05-25 05:56:55, Parav Pandit wrote:
> > > > I am running a basic test of block device driver unbind, bind
> > > > while the fio is running random write IOs with direct=3D0.  The tes=
t
> > > > hits the WARN_ON assert on:
> > > >
> > > > void pagecache_isize_extended(struct inode *inode, loff_t from,
> > > > loff_t
> > > > to) {
> > > >         int bsize =3D i_blocksize(inode);
> > > >         loff_t rounded_from;
> > > >         struct folio *folio;
> > > >
> > > >         WARN_ON(to > inode->i_size);
> > > >
> > > > This is because when the block device is removed during driver
> > > > unbind, the driver flow is,
> > > >
> > > > del_gendisk()
> > > >     __blk_mark_disk_dead()
> > > >             set_capacity((disk, 0);
> > > >                 bdev_set_nr_sectors()
> > > >                     i_size_write() -> This will set the inode's
> > > > isize to 0, while the
> > > page cache is yet to be flushed.
> > > >
> > > > Below is the kernel call trace.
> > > >
> > > > Can someone help to identify, where should be the fix?
> > > > Should block layer to not set the capacity to 0?
> > > > Or page catch to overcome this dynamic changing of the size?
> > > > Or?
> > >
> > > After thinking about this the proper fix would be for i_size_write()
> > > to happen under i_rwsem because the change in the middle of the
> > > write is what's confusing the iomap code. I smell some deadlock
> > > potential here but it's perhaps worth trying :)
> > >
> > Without it, I gave a quick try with inode_lock() unlock() in
> > i_size_write() and initramfs level it was stuck.  I am yet to try with
> > LOCKDEP.
>=20
> You definitely cannot put inode_lock() into i_size_write(). i_size_write(=
) is
> expected to be called under inode_lock. And bdev_set_nr_sectors() is
> breaking this rule by not holding it. So what you can try is to do
> inode_lock() in bdev_set_nr_sectors() instead of grabbing bd_size_lock.
>
Ok. will try this.
I am off for few days on travel, so earliest I can do is on Sunday.
=20
> > I was thinking, can the existing sequence lock be used for 64-bit case
> > as well?
>=20
> The sequence lock is about updating inode->i_size value itself. But we ne=
ed
> much larger scale protection here - we need to make sure write to the blo=
ck
> device is not happening while the device size changes. And that's what
> inode_lock is usually used for.
>=20
Other option to explore (with my limited knowledge) is,=20
When the block device is removed, not to update the size,

Because queue dying flag and other barriers are placed to prevent the IOs e=
ntering lower layer or to fail them.
Can that be the direction to fix?

