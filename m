Return-Path: <linux-fsdevel+bounces-49901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4DDAC4CA7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 13:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C70F317D84E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 11:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DA1258CF4;
	Tue, 27 May 2025 11:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Nlq+N71R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2B243ABC;
	Tue, 27 May 2025 11:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748343664; cv=fail; b=PP7pNamc9CjhDHE2f+LtV3V2YInNsbayLDwvVIvCDWvGjo5leLUtVjZW39chq16SU9fueOXmwUGUMK2DrNQPA7rsqSWhrbwQriPd/Qr3o/TKqFQACtKMqOpGx5FfkFBwo9mFeyTTgrDuSQvHi2K1p6qiev7dPRFDra1/KlSCHZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748343664; c=relaxed/simple;
	bh=WBEdxGXij5L/Gdf3AjRn3nFgT4nnK2DzogQ2RelaUh8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BjpNE4J8N+uQsZf8aRbZz0vN/NFMjY9w1ZiHny6zKNenyObALLu/TvizkCjlot7CG3QseHlpezIeojb6mvc9aiZ7BhqG+9nuX1rsTCICrec7yKhtJMU5rRxJr+ZThCwmIlfSq2bmwXMH5yX+/TaoyA1V+xa82FO743wQTOO/UdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Nlq+N71R; arc=fail smtp.client-ip=40.107.244.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cSsTOZgX5m1WTA286ae2/MQCXBr0FVAujTbcZng12tsWNYyp1UmWFgWOcXOQYPEmoeKJNSiODQbE5BVfPsMdg7CJLRrpGvLGAwp1Ii8O1MZNMVP4lHE2gFxrI6FlvpJOO6HU3wOuu0evSuVSCr4lYKYl8xNO+mMvYeR+RujRUqPt3hSuHQfico5EoyYJ1X21oUU4AFeBOx1spSi8yd2lLWQniKJQIOqSfrjqk+CJnQ+kCwellbvZkJ9QoG2vmFSRr3jJtIHNhEduI/hT55lhLOjxbzAid/ynpMff+DGDuPGs0ZeCVnh+7WHEuJQwMovcAE521+YeXASt2Ss3xofEiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y32cg9SCuQG2PeJ1pnYr9igQGFySTHHn0oMoyg7TN8k=;
 b=B4Ca4PteQJ1EuQ0oqWhs7RclMSWJpS98AGZElRsWgOv7CfVMeZJ/ZgYBrbNSjKLefWpjhdMdogv8IxPZ/zdihx748kLqa4maCzSSZOn/SQBOJ3QS89pZAx2G6DbjySiK9iLIOeVm4VG8cq5NDdHn25sfXSCsyL42l73mx7vjs5FRdA59vdRhLp2GJinqsZb91EfeAPVRjthCORIq77F02OLyLcKSOabEXSzSACGLAlfsKZ94uYYyANJQXBvu9T3vz6rAG6fBPigpPJqSuaSLA3P5TUTMZk8TiOODz1E2+sAHwqBpubTrenrUMsvIG8a4qgxshhY8ju4zOtO2r92UoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y32cg9SCuQG2PeJ1pnYr9igQGFySTHHn0oMoyg7TN8k=;
 b=Nlq+N71RZI+mPYGLdElbx0SDQIoz0ZotuFZxUeBw2LwbiVtaeirTGezYEzF2HbbgnUAfhZhy59m4Ean2zbTy+g/dbEibkSFx9FtoaG5vh8xye1Sn2PQl8xNOVtGIiDVPfofQGfxMp4FVha7D9hR+wu4NvkdllkTDB7vkre3ANvkoPprmZUCN07JB1r4z/8qditERkfxvzybEZvmq/ZdbmrOZXpXpSlmEjmS2Rnzq05U1wy7dOWkEuLlkRjWg64TXoa6GKIfPcnwMIw5gc37TauyJo8xXYMt4wPouf2IA+EOWdMX8DY3PrsKjzf7+StjxBsahVelX8RHUmdQoiuWCWg==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by SJ0PR12MB6903.namprd12.prod.outlook.com (2603:10b6:a03:485::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Tue, 27 May
 2025 11:00:57 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%5]) with mapi id 15.20.8769.021; Tue, 27 May 2025
 11:00:56 +0000
From: Parav Pandit <parav@nvidia.com>
To: Jan Kara <jack@suse.cz>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: warning on flushing page cache on block device removal
Thread-Topic: warning on flushing page cache on block device removal
Thread-Index: AdvMbvrhAHapLL5SQLSXHQ+FhiQIJwB7b58AACZikZA=
Date: Tue, 27 May 2025 11:00:56 +0000
Message-ID:
 <CY8PR12MB7195BB3A19DAB9584DD2BC84DC64A@CY8PR12MB7195.namprd12.prod.outlook.com>
References:
 <CY8PR12MB7195CF4EB5642AC32A870A08DC9BA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <2r4izyzcjxq4ors3u2b6tt4dv4rst4c4exfzhaejrda3jq4nrv@dffea3h4gyaq>
In-Reply-To: <2r4izyzcjxq4ors3u2b6tt4dv4rst4c4exfzhaejrda3jq4nrv@dffea3h4gyaq>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|SJ0PR12MB6903:EE_
x-ms-office365-filtering-correlation-id: e242abab-e297-4217-30a3-08dd9d0dc1ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Usip985E+XKvn995mCLLZuWYjbxMKb8GLKVmWr6w4dozvx4A8hnTTzWBBuvN?=
 =?us-ascii?Q?Xiu/Q5z6vQdn4OMPaUb3owaeO/A3u5oFhjP8pH2nQs49vTXdNg+kUErPVp8K?=
 =?us-ascii?Q?ws2oGli8GfdbGh8NnUSNMhjL0tOX8Q5SH3hY2m1yhAqBWGaAqELj/5ry6ytm?=
 =?us-ascii?Q?HSnH2jRKTpH9jXfWHd+oBXYFMz+WQYq8SsOoyEuD1xugWOUwyV4wcp35Es8v?=
 =?us-ascii?Q?ZIP6eK1N+CXCAe9wQxDbqwHQwdteb07nAy6JqY30xyPlYThYIn1Pzbz9lSze?=
 =?us-ascii?Q?FfIErRQHiqVw77EXbBpNHoNNcQEn5I2QRXMMPKfLTJf2SWN8Ik3UeroWhq9l?=
 =?us-ascii?Q?+Ub8bm1P/6X88qDd0MSWXpDfxy8dLycX2jIDZTWNkK97ZSqMMrR501tHuKGe?=
 =?us-ascii?Q?8/Y73j8qWlbqJh08mrvVNuFMW38aGhHKyJ3dqLnuojRMJErgRco6t3lFfa7B?=
 =?us-ascii?Q?ICqlAyvutTbSKGPY/1FE6OeVj0yHxXJ3ri9O0rQbzoCohqm4P+7ey13jss1t?=
 =?us-ascii?Q?KyEdzchKyv5Dl14fLl1MCNwaMSE8faU5SfMfjP9zvHr9z0ag4H+VoOCpXmsG?=
 =?us-ascii?Q?IZcUNoWnxkvAL+ElWk0ldHMHqB6TU9gR+KodbEtSJ+q4k9mRNWyH+V4OTBHk?=
 =?us-ascii?Q?ReT4HTLVvjQ79dG65x5TuwHCIBUlV2rQdcZ68kjeIEUk/681Sh1yrk1Kd3vD?=
 =?us-ascii?Q?YxGqcNYNL5UWFg6QhevEQnNT2jtlFoaSS2tNPDHVMuiUsFm+slyXeV0fIze9?=
 =?us-ascii?Q?8ha0OFw+1HVtHQrG1WJ+LoRBSw+qeRNGjgt/f671KF/uDfBf6M3o+mAIs7jU?=
 =?us-ascii?Q?TvOrFPOCTQuGRM8LTJQdZswrsau/iLlMZF7E0BSyEh0FnGNkw/2X8qrMZu6U?=
 =?us-ascii?Q?pgcSBQB28x26medASHDMrisk3whlz9xW+uzrQMruvz05vR2jCA4CnAdNuzhg?=
 =?us-ascii?Q?lCGtMWDO9A6gGdzsGofXcZDoBIuvazwF/JEjkwJp5npq2yriVz+p9u5qqBdZ?=
 =?us-ascii?Q?NLMO2g/6CkHHbvEvxNDnu/RSONHHeaL71S/HFUxk7F08s8jGe5xIkP/J8SUm?=
 =?us-ascii?Q?NAgvjGZylxLLOrwDQo4OEZFTFnc0shqg30hMGEwUicN7bbEXQNx+3eoZJMss?=
 =?us-ascii?Q?51PM792/ISphV2k2wBbHmHdlWPXWD2iJNj4X96USGqonOaJxmr0Xuqme004K?=
 =?us-ascii?Q?4BONaYEgABG6HhcPfpm8JvOPlw/PJvpQGfSUIdcvlN67n38kAGKZaZDmZaOh?=
 =?us-ascii?Q?0yHKXM/mKuZZZmCSUGnavjZ4n35fGTPgpxqjVUgdcoTmclTrYQoW5/d8tNjR?=
 =?us-ascii?Q?xwpn8PMC9uz2+JA0kwfNS0Sy2rImtsASq2l0UurfkdfzWBag/IfCkwaPGJnv?=
 =?us-ascii?Q?yWzlkqwgk2On+W2IR6uR+sBC7GolnCMYO91855I8CbPi86Ika7+Tm0sOFNGP?=
 =?us-ascii?Q?zaeQWs2iZtRNr5i33kbwKnTb3/Ap6O0MABK26KIqtC46g7U6jEAu3mhz0+e2?=
 =?us-ascii?Q?Tgnqpli2LElD0CY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ItYi2nRZw21GL+78R/j5klgh50jiW/spE6rI8TSK4Qx5COYazb7y0LFYnRAj?=
 =?us-ascii?Q?qiCNY/QCQAYPEhQ6yP/NviWqtdtszdr1oZV9X578QFJRftC0DxJxakS47z3i?=
 =?us-ascii?Q?MUnqnhiWM+ZC4RNVBLE3bKk1h3+LsEunjooUhTpEC6wepmPBFmRKr9cx7+E5?=
 =?us-ascii?Q?9oQI1QHztNyDKyxK8NsAjoe+0wyWBOCNoiV9dbi5LuJ61jaYqegbSWX6lsxt?=
 =?us-ascii?Q?qKqLqOi0piiXI10CiBoEoppesdWhFkDHagTPkxua6cOGACdveYkx7e2cl0wW?=
 =?us-ascii?Q?81bCRsORtxe8U15d8RifFQvOJd5U22U9H5mPevQXavqMAxWSEJoZAl6zBs5x?=
 =?us-ascii?Q?pnRgtv0QJEmM/0yOIGth8YNyQk3GLyweMWaOHRx8zY6mnV7/Ps397I/q8wUF?=
 =?us-ascii?Q?ZZGyVAt2Su7x6t27wRvHbhs0rgX8G9Ta8NklF10CeNSA7V/8ChJRuO9/ziWF?=
 =?us-ascii?Q?aoGCeyr3aa+0KFcqYmjGZHRPLBUxaXJajXv6MhdPZBnASek1gc78xjQbtmnP?=
 =?us-ascii?Q?0aU8zKK9Opd4jrWt8nmuDM8kzgdElssl6DzlR5ocp4KP5MU7rX/FrEmsrXId?=
 =?us-ascii?Q?/k/84wVQuR2QIemANS3Cokekdiacbfdue4wK5G8rr30z+dKMsVtU18YEfPIP?=
 =?us-ascii?Q?COXZxYnI4SSO+o1sOp3OuT8Z7bRCYHLYpakn650NBqu7NXQ0rQM0PdpP3QNH?=
 =?us-ascii?Q?uoEiMY6LyZCBwPwTJx1SH0Vzm4xs67JZ+/5APxzBqrsrTaBgIvTv7CYwQe54?=
 =?us-ascii?Q?2rn/MTnL7q41koTkuZMc/0gj+MTMwxpNOdJL20JxDtmrjTumNdPHfwnbDYkQ?=
 =?us-ascii?Q?LlTGSkMCiUeYRE4wFC0YAntK7jCoAqJ4pJNpDyTXmYIDCfiYiMpLVpBmViok?=
 =?us-ascii?Q?m67FmVgxNNoHAMzX5tVjDTbB1SO3QD9lvXzaHfV78hZaa1oiuHGgF9BWP4SU?=
 =?us-ascii?Q?nMKTWvzHF44S2ayWUuHaGqbIcbPiHH9jDese8/G76gAqwcu6OFXXl6cuOiaK?=
 =?us-ascii?Q?Cbat752ZIAepQaC5SR8WFfBx3IT8nPGMNdNMmHaxRIVs/jYyPtEJWMZCtjgF?=
 =?us-ascii?Q?bD8NooTkST3DKFD/0get2c8H7lMd73tCKLCXLHGX69FH9Ikhpnddn/Ce8yVA?=
 =?us-ascii?Q?m0ZJVtkaZQXnpxMuxEaf634iEZtUY+1b3DZq0bOPfn1Eq8hdGVC2L4HxJpnX?=
 =?us-ascii?Q?lWqqdzOEjOf12tkX4J1+Z/bjPvOo1PMDecR8BBX1m3S3UJWScvb6ZJdJNkhS?=
 =?us-ascii?Q?rdsVH01xOf3dDvvPj3CL3H2mI7r7tMT+kYY9aW5uk0+x11xlTWrSYrpa8ole?=
 =?us-ascii?Q?hsrLtgGB2ObEkhz6Wx93emK7tFP4RjjDizGytQ+j0cOJKjyysJnYgUSGz4nY?=
 =?us-ascii?Q?FqdWnQNYqoSyi/bjw2RRbIsGoQl8WexKOQLUtCzogZstqYF6GXyD+71CytRi?=
 =?us-ascii?Q?zAoKGRBnhwlHFpyJ6mUz98wz3MfJnX4G1CMIUqtko91UiqDGVeuSf0dXWR73?=
 =?us-ascii?Q?fGOcGtgRpiLZZjKo7PQYDSU+o+P3q+0uaWmPDVn5/n48VZ9UZ4IMfD4q4mlp?=
 =?us-ascii?Q?y2ZWW5e+4vU/IlJZ7ZQo9vg+OgF/HulsSD/h32Gn?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e242abab-e297-4217-30a3-08dd9d0dc1ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2025 11:00:56.7791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RvhxA8MzsWSp3Xr88+wQO82qIkXTclyOst0aqXaL+AOoP4xb1yN7EV7aS4kenRLSirBHw0lUEnzCDF8iEss9dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6903

Hi,


> From: Jan Kara <jack@suse.cz>
> Sent: Monday, May 26, 2025 10:09 PM
>=20
> Hello!
>=20
> On Sat 24-05-25 05:56:55, Parav Pandit wrote:
> > I am running a basic test of block device driver unbind, bind while
> > the fio is running random write IOs with direct=3D0.  The test hits the
> > WARN_ON assert on:
> >
> > void pagecache_isize_extended(struct inode *inode, loff_t from, loff_t
> > to) {
> >         int bsize =3D i_blocksize(inode);
> >         loff_t rounded_from;
> >         struct folio *folio;
> >
> >         WARN_ON(to > inode->i_size);
> >
> > This is because when the block device is removed during driver unbind,
> > the driver flow is,
> >
> > del_gendisk()
> >     __blk_mark_disk_dead()
> >             set_capacity((disk, 0);
> >                 bdev_set_nr_sectors()
> >                     i_size_write() -> This will set the inode's isize t=
o 0, while the
> page cache is yet to be flushed.
> >
> > Below is the kernel call trace.
> >
> > Can someone help to identify, where should be the fix?
> > Should block layer to not set the capacity to 0?
> > Or page catch to overcome this dynamic changing of the size?
> > Or?
>=20
> After thinking about this the proper fix would be for i_size_write() to h=
appen
> under i_rwsem because the change in the middle of the write is what's
> confusing the iomap code. I smell some deadlock potential here but it's
> perhaps worth trying :)
>
Without it, I gave a quick try with inode_lock() unlock() in i_size_write()=
 and initramfs level it was stuck.
I am yet to try with LOCKDEP.

I was thinking, can the existing sequence lock be used for 64-bit case as w=
ell?=20
=20
> 								Honza
>=20
>=20
> > WARNING: CPU: 58 PID: 9712 at mm/truncate.c:819
> > pagecache_isize_extended+0x186/0x2b0
> > Modules linked in: virtio_blk xt_CHECKSUM xt_MASQUERADE xt_conntrack
> > ipt_REJECT nf_reject_ipv4 xt_set ip_set xt_tcpudp xt_addrtype
> > nft_compat xfrm_user xfrm_algo nft_chain_nat nf_nat nf_conntrack
> > nf_defrag_ipv6 nf_defrag_ipv4 nf_tables nfnetlink nfsv3
> > rpcsec_gss_krb5 nfsv4 nfs netfs nvme_fabrics nvme_core cuse overlay
> > bridge stp llc binfmt_misc intel_rapl_msr intel_rapl_common
> > intel_uncore_frequency intel_uncore_frequency_common skx_edac
> > skx_edac_common nfit x86_pkg_temp_thermal intel_powerclamp
> coretemp
> > kvm_intel ipmi_ssif kvm dell_pc dell_smbios platform_profile dcdbas
> > rapl intel_cstate dell_wmi_descriptor wmi_bmof mei_me mei
> > intel_pch_thermal ipmi_si acpi_power_meter acpi_ipmi nfsd sch_fq_codel
> > auth_rpcgss nfs_acl ipmi_devintf ipmi_msghandler lockd grace
> > dm_multipath msr scsi_dh_rdac scsi_dh_emc scsi_dh_alua parport_pc
> > sunrpc ppdev lp parport efi_pstore ip_tables x_tables autofs4 raid10
> > raid456 async_raid6_recov async_memcpy async_pq async_xor xor
> async_tx
> > raid6_pq raid1 raid0 linear mlx5_core mgag200  i2c_algo_bit
> > drm_client_lib drm_shmem_helper drm_kms_helper mlxfw
> > ghash_clmulni_intel psample sha512_ssse3 drm sha256_ssse3 i2c_i801 tls
> > sha1_ssse3 ahci i2c_mux megaraid_sas tg3 pci_hyperv_intf i2c_smbus
> > lpc_ich libahci wmi aesni_intel crypto_simd cryptd
> > CPU: 58 UID: 0 PID: 9712 Comm: fio Not tainted 6.15.0-rc7-vblk+ #21
> > PREEMPT(voluntary) Hardware name: Dell Inc. PowerEdge R740/0DY2X0,
> > BIOS 2.11.2 004/21/2021
> > RIP: 0010:pagecache_isize_extended+0x186/0x2b0
> > Code: 04 00 00 00 e8 2b bc 1f 00 f0 41 ff 4c 24 34 75 08 4c 89 e7 e8
> > ab bd ff ff 48 83 c4 08 5b 41 5c 41 5d 41 5e 5d c3 cc cc cc cc <0f> 0b
> > e9 04 ff ff ff 48 b8 00 00 00 00 00 fc ff df 49 8d 7c 24 20
> > RSP: 0018:ffff88819a16f428 EFLAGS: 00010287
> > RAX: dffffc0000000000 RBX: ffff88908380c738 RCX: 000000000000000c
> > RDX: 1ffff112107018f1 RSI: 000000002e47f000 RDI: ffff88908380c788
> > RBP: ffff88819a16f450 R08: 0000000000000001 R09: fffff94008933c86
> > R10: 000000002e47f000 R11: 0000000000000000 R12: 0000000000001000
> > R13: 0000000033956000 R14: 000000002e47f000 R15: ffff88819a16f690
> > FS:  00007f1be37fe640(0000) GS:ffff889069680000(0000)
> > knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f1c05205018 CR3: 000000115d00d001 CR4: 00000000007726f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > PKRU: 55555554
> > Call Trace:
> >  <TASK>
> >  iomap_file_buffered_write+0x763/0xa90
> >  ? aa_file_perm+0x37e/0xd40
> >  ? __pfx_iomap_file_buffered_write+0x10/0x10
> >  ? __kasan_check_read+0x15/0x20
> >  ? __pfx_down_read+0x10/0x10
> >  ? __kasan_check_read+0x15/0x20
> >  ? inode_needs_update_time.part.0+0x15c/0x1e0
> >  blkdev_write_iter+0x628/0xc90
> >  aio_write+0x2f9/0x6e0
> >  ? io_submit_one+0xc98/0x1c20
> >  ? __pfx_aio_write+0x10/0x10
> >  ? kasan_save_stack+0x40/0x60
> >  ? kasan_save_stack+0x2c/0x60
> >  ? kasan_save_track+0x18/0x40
> >  ? kasan_save_free_info+0x3f/0x60
> >  ? kasan_save_track+0x18/0x40
> >  ? kasan_save_alloc_info+0x3c/0x50
> >  ? __kasan_slab_alloc+0x91/0xa0
> >  ? fget+0x17c/0x250
> >  io_submit_one+0xb9c/0x1c20
> >  ? io_submit_one+0xb9c/0x1c20
> >  ? __pfx_aio_write+0x10/0x10
> >  ? __pfx_io_submit_one+0x10/0x10
> >  ? __kasan_check_write+0x18/0x20
> >  ? _raw_spin_lock_irqsave+0x96/0xf0
> >  ? __kasan_check_write+0x18/0x20
> >  __x64_sys_io_submit+0x14e/0x390
> >  ? __pfx___x64_sys_io_submit+0x10/0x10
> >  ? aio_read_events+0x489/0x800
> >  ? read_events+0xc1/0x2f0
> >  x64_sys_call+0x20ad/0x2150
> >  do_syscall_64+0x6f/0x120
> >  ? __pfx_read_events+0x10/0x10
> >  ? __x64_sys_io_submit+0x1c6/0x390
> >  ? __x64_sys_io_submit+0x1c6/0x390
> >  ? __pfx___x64_sys_io_submit+0x10/0x10
> >  ? __x64_sys_io_getevents+0x14c/0x2a0
> >  ? __kasan_check_read+0x15/0x20
> >  ? do_io_getevents+0xfa/0x220
> >  ? __x64_sys_io_getevents+0x14c/0x2a0
> >  ? __pfx___x64_sys_io_getevents+0x10/0x10
> >  ? fpregs_assert_state_consistent+0x25/0xb0
> >  ? __kasan_check_read+0x15/0x20
> >  ? fpregs_assert_state_consistent+0x25/0xb0
> >  ? syscall_exit_to_user_mode+0x5e/0x1d0
> >  ? do_syscall_64+0x7b/0x120
> >  ? __x64_sys_io_getevents+0x14c/0x2a0
> >  ? __pfx___x64_sys_io_getevents+0x10/0x10
> >  ? __kasan_check_read+0x15/0x20
> >  ? fpregs_assert_state_consistent+0x25/0xb0
> >  ? syscall_exit_to_user_mode+0x5e/0x1d0
> >  ? do_syscall_64+0x7b/0x120
> >  ? syscall_exit_to_user_mode+0x5e/0x1d0
> >  ? do_syscall_64+0x7b/0x120
> >  ? syscall_exit_to_user_mode+0x5e/0x1d0
> >  ? clear_bhb_loop+0x40/0x90
> >  ? clear_bhb_loop+0x40/0x90
> >  ? clear_bhb_loop+0x40/0x90
> >  ? clear_bhb_loop+0x40/0x90
> >  ? clear_bhb_loop+0x40/0x90
> >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > RIP: 0033:0x7f1c0431e88d
> > Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f8 48
> > 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> > 01 f0 ff ff 73 01 c3 48 8b 0d 73 b5 0f 00 f7 d8 64 89 01 48
> > RSP: 002b:00007f1be37f9628 EFLAGS: 00000246 ORIG_RAX:
> 00000000000000d1
> > RAX: ffffffffffffffda RBX: 00007f1be37fc7a8 RCX: 00007f1c0431e88d
> > RDX: 00007f1bd40032e8 RSI: 0000000000000001 RDI: 00007f1bfa545000
> > RBP: 00007f1bfa545000 R08: 00007f1af0512010 R09: 0000000000000718
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> > R13: 0000000000000000 R14: 00007f1bd40032e8 R15: 00007f1bd4000b70
> > </TASK> ---[ end trace 0000000000000000 ]---
> >
> > fio: attempt to access beyond end of device
> > vda: rw=3D2049, sector=3D0, nr_sectors =3D 8 limit=3D0 Buffer I/O error=
 on dev
> > vda, logical block 0, lost async page write
> >
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

