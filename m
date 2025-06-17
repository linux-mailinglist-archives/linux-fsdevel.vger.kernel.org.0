Return-Path: <linux-fsdevel+bounces-51828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7CDADBF10
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 04:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF64D162D2B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 02:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA962116F6;
	Tue, 17 Jun 2025 02:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ApnM/d5c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020132.outbound.protection.outlook.com [52.101.193.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1F42BF013;
	Tue, 17 Jun 2025 02:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750126762; cv=fail; b=Wnr/B7jxmBkHJM579bsfM62fCBL6PKJRbUXsa0PIEczSDc6aoJCal/8JabTNx/mqiSpf1n3lP4nl7hSItzi3z1SaDdTj/60A7ETjGP0yScUCcBY/YpNOXvE8eqIwaySWxlWrDI+30Oqvip2/bOAYyK5khADhPPs6dQnX9GHFnUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750126762; c=relaxed/simple;
	bh=ts8RDu7zF/+/dbGCd9AJQ+V5tgE2bRdsQ9AWKv6deWY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Px/tblsYK73LwH4Nb0xqF1D9dZdc8h5z8G/1lTvpabtJquPPDFaHqmixXuVpJ8Nq/MP/BPH9avNkkab6FnWsCAg/3dKd5zjXl0LYQR1ISVpTG84SOPvcR5f1vPBcIRYmgENvOYJJmA7h3dBW6lD109UufVhmP1u/YyKb/WR6AwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=ApnM/d5c; arc=fail smtp.client-ip=52.101.193.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CgDPcXZDoMWfhobRSXjYRzKEgXiY2lZkZAsRDvcvgAd10m30EU8U8alrxQLhrBz41WcegcSBx4wongZqzCemDtYwCMjGOr0bDYWUgqZTDgZjS27X+6phccQzlO9prFV2VHsRkFIvfajgRrkRtWAIchmJW3lBbKPAGwGsZhHNcEZUxXFowmmxX31+yYPPmzHa6ald3uOqKfeeeLbPYh6c5A2PrheZTzFAJL5qd9oTcQbuoII7T1ce77ZzRK6n4ky+pgKCDgY3wiJj86OwRL7X7vlbcA6x7M6HRv3ThUQEpMuBOlM5USMEp71+GMtC1U2Lc9aOPtyvz3ax8r3+yCK/nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ts8RDu7zF/+/dbGCd9AJQ+V5tgE2bRdsQ9AWKv6deWY=;
 b=DhakjZZWW2Jt7xki39/J9BP9eDD3wCZGqmzSUQUqYGua6ioAXDJOGFUF/ohC3j3xVXN6dZRIqwxTt8ewIwOkfUj2rjkVOe/rZbCD0TNiPP39hTISmRDotIfHbIx1C+kDu6Gxa5ZDwG87KOJRWhifhm4FifYE2fgKGiCOWnbjwn7INBC4Sg6qCIQgDYKtScoNQ1KaZV3b7hjL+e0PLXWq6/+5K4r+7rAmlp3m8/ZRUA9tAeIJkx/zxyhIsXC5UBdtHSYeYsYdnKMx8Ovh2Cvlq+oxqzmtDnJj2yYmo3jXWtWfD0hG0My+8Ot3gsuGo3QKF58Spm7f25OKojX9/b/YVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ts8RDu7zF/+/dbGCd9AJQ+V5tgE2bRdsQ9AWKv6deWY=;
 b=ApnM/d5cbX8YZi7bDpJeiThxZ2KpsGi8JUFbSjGt6m+4HBEYghyquSealqzUucc491PX0ij54tyd5L3Jw7h273257wZkkkGO5osOMrczerlJ+1eZGJQ1qUYGSnoayMZaO5WLOwaFJuNZaWUz2T/PMeaUMBLThkAfD7nhMF1F6Hc=
Received: from BL0PR2101MB1313.namprd21.prod.outlook.com (2603:10b6:208:92::7)
 by IA1PR21MB3595.namprd21.prod.outlook.com (2603:10b6:208:3e0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.15; Tue, 17 Jun
 2025 02:19:17 +0000
Received: from BL0PR2101MB1313.namprd21.prod.outlook.com
 ([fe80::41a:7834:dfad:d2da]) by BL0PR2101MB1313.namprd21.prod.outlook.com
 ([fe80::41a:7834:dfad:d2da%4]) with mapi id 15.20.8857.015; Tue, 17 Jun 2025
 02:19:11 +0000
From: Jason Rahman <jasonrahman@microsoft.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC: Adam Prout <adamprout@microsoft.com>, Girish Mittur Venkataramanappa
	<girishmv@microsoft.com>, "kbusch@meta.com" <kbusch@meta.com>, James
 Bottomley <james.bottomley@microsoft.com>
Subject: md raid0 Direct IO DMA alignment
Thread-Topic: md raid0 Direct IO DMA alignment
Thread-Index: AQHb3y3UX9tqZun5hUeSu5vBGRb8Ng==
Date: Tue, 17 Jun 2025 02:19:11 +0000
Message-ID:
 <BL0PR2101MB1313AA35D88E8F547132B505A173A@BL0PR2101MB1313.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-06-17T02:19:11.049Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR2101MB1313:EE_|IA1PR21MB3595:EE_
x-ms-office365-filtering-correlation-id: 9ff2e12b-dcc5-443c-9864-08ddad455915
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?C4xwIPES1oSkWNJ1FkaCVRTfBcHuH227y6k2QtFIhyH3Ayfl4bG+dJH75h?=
 =?iso-8859-1?Q?OeZMaO7YOoJWQI1s6jzNPX9wlEJMNlX+mbZJ80vejxitTR1JRuswfWpwzv?=
 =?iso-8859-1?Q?HGtvbOj1lqcAIlsDSDg3L51RLZzaAgiNWEHgAe/5Id427PG4lXUN17zCix?=
 =?iso-8859-1?Q?LN3n9/6GtT54u8xORniNxgI+ap13nhJOqLNOvqpjEWS/Pzjw65dyEimL3T?=
 =?iso-8859-1?Q?n7KqgQzPIIjpoLdnecM50ClI4sm7S348ZGu7ojS8QeOoNmfqh61KgktZoW?=
 =?iso-8859-1?Q?wlGgyd1bZ3sP6/zcRCk6DshCROJkQO/NdlumNvMHMEQAxo2d+YCmOFpTfE?=
 =?iso-8859-1?Q?z7qx9LxPAL8HWtKTfST8OhlkaXrAs/xqgslc3aOe0nwVmvnSJDmU9XGHoc?=
 =?iso-8859-1?Q?j7qxuolMU0eBIG6a/EFy6g2/SjNHEqrk+JK/kjVOU+CwtcS3QPWEy6iWJJ?=
 =?iso-8859-1?Q?Yr6XtSZou0+11Tpa37Nca5U4DVXrTTENnzNmERkzJdnuPpN2GEi4Q4ai1k?=
 =?iso-8859-1?Q?YFOuiwmtw8er2feUx0v6kAd4MJJBg5zgqpg6sd9ilb+la/vvhO9i1GR3wR?=
 =?iso-8859-1?Q?wai42F0aX/A9Kmi+DlnC4KLr1WLWtBZpzMFx8406VUsNlhodgIK7UoLcNB?=
 =?iso-8859-1?Q?kTaQrYW/iJS2pVdq5HZx7LFXnvOptMzgBI6U7mVN7YMjID+WpJXOKuOvcm?=
 =?iso-8859-1?Q?NvN0N1BzfW9aORQxiMe594roOfnYtuTqBDCOdyl1wdFA4tXRhq9De3G3uw?=
 =?iso-8859-1?Q?EcAwu0YQeRH+7XHJXB1E1m0PmJkDDr0YAYx8ZCUZ/BP3v/yRRSdc70YsnS?=
 =?iso-8859-1?Q?CdcRWtRpfbkO26v/z4P1VZd3o1sOp+GhVPZLS6QIDZ4pqDRuHTSLE6teTl?=
 =?iso-8859-1?Q?eQFEjUXV20ClrQs+q3oxyA/I5nLQF62e3MjWD3gXskxJQpV3oAO6StVXUA?=
 =?iso-8859-1?Q?M41CFWthhL8FU7CC3sAfRpoFxqih4+OJ5f8wk2D7jvWJZn5QQWfzXo2Xf8?=
 =?iso-8859-1?Q?RKWPaTyAWY9ivoJpXpS5vtvUu2O8IdVjWSfgV3Zx8F4FGrICvcQX8Dz8bY?=
 =?iso-8859-1?Q?0nsjjAm3LSyI4ovt4x0IBPmonazyd8vrQlUQGWqzDyLZJr3KqPMDL80G7l?=
 =?iso-8859-1?Q?iD4RmwuHS+6ac8VS6eKVPsVDW9yAz7NiS4nhNx6G9IfWDDXAOqXqu5roDV?=
 =?iso-8859-1?Q?Qi4nf8oJbWkTNjUrtJ/CBmWbAgbuQxmI+dQ49IElQCujIsXL2HAP7AEZHw?=
 =?iso-8859-1?Q?YvObOPp0jcIc/k7SRuN8WZKOqYqcFupW9sBcwS+/uXWf0IS006QQtqpY3C?=
 =?iso-8859-1?Q?P+dvGXlk3BYw7JudI7nA5o/bGhbRqaW0aeH2giZPxhnVQxft2ntX6ohNTf?=
 =?iso-8859-1?Q?a6nEYnW519OzMuQqLnplMIjMUmegN08yaptc5iMjdQW2vh8WGaSIO/Fal+?=
 =?iso-8859-1?Q?+hM4y7D1e+sLtEk5qTD79YV54cCouW/LfnkneHQU49TGD9awl73BEYT1yV?=
 =?iso-8859-1?Q?lxdpG2Zj9YD43PmyJ+wOdG?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1313.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?n9vgWeuhGbrVlWS/XRieuX2Uvn0bNbyBEwVYnQcIZH3/pmjlMJrOd3JktV?=
 =?iso-8859-1?Q?pvIescCGM4ahlS4e2g3WDAiXY7Da01KTikqK1A3a7YgUqQn6xo4zujXyTP?=
 =?iso-8859-1?Q?umc2ur/7txXbPfGuwbOW22ZRNr2OdRCTc3EgJszOdd7IJx6ucv6Wzo2xvO?=
 =?iso-8859-1?Q?IXroK4tpAuuk/mY1l/6q3c8scsTG0mS7LSM5NkXNEK7MY3UJP0KZQb/lt0?=
 =?iso-8859-1?Q?6M6k8Xy5RH0nydtXL5UdG+InlurJOVizIz7e0Pr76ODzzK2BcbnLI7/y+G?=
 =?iso-8859-1?Q?P+iVrCzGrNN5CT7abF8jHcXoLr4leeJDxWXmgWwwykZsoLpootEpeHVejG?=
 =?iso-8859-1?Q?a1FHnYJ1XCrte+bolpUz12CboveVQ2iM2BHkMuj2RiFtBAV7X2fLoiIkXC?=
 =?iso-8859-1?Q?dC3tG2WgVYa8PcyqfDzi3XVjtYw+KH34Fz7u5ltZ4lBEwiK9zD1LizU8wL?=
 =?iso-8859-1?Q?oQaO0Dga2LejP/pW1fAZJiEaQAoqvVSrwGcWGCZ4kr5581ZhZTgrqkmhu6?=
 =?iso-8859-1?Q?nlhbF7uvC0Tbqk2arseQ9l1ckovhFSh+9L972LuE30RwQXvCDIbIpc3eil?=
 =?iso-8859-1?Q?PwL03h0sLZjP4Hi3O/Twqdr9NqDgriARHb3+sGhx5UQeXxlI9xgqLg9Ke4?=
 =?iso-8859-1?Q?owAsEOcxcnVdLMtJJYp2f0Dsht8SAEm/QAq/cN2lx/6ThQDxd/qqCcPBpm?=
 =?iso-8859-1?Q?xip3pnNgEKhm7YccXbNz/jFO0iHrwUtWxe+wIGqg1WMacbaJnUDpima/H7?=
 =?iso-8859-1?Q?02G5qMIsFMiWKEj8g5clSpO5ZbjpnGV/HXSLe2fMN6hfkFIWeB7f0s69P6?=
 =?iso-8859-1?Q?pyhu/YAOYhy/ms7n1y9OypR2jhjSJ1Nfq61oHANSoacXZulY7DVO1lqqcC?=
 =?iso-8859-1?Q?LxmS+oCBJs1ed5+yqAswAkCwWXfBcqFtBtVMPXA7CPzuXvoOlGryV1MVei?=
 =?iso-8859-1?Q?9CrxX15JCavKK5Ko6urUpbVYJIiMilwLGiqDWM2kGXPnjsSmAP2jfeeMMi?=
 =?iso-8859-1?Q?H/ZW+26RL6Ybs04st18dINTb25ndjHQflZIlfllN8QLQrCUP87FCkgYD3+?=
 =?iso-8859-1?Q?S4jQa4fMrdlzC+9mTkgyjdXT4fOTtgvqMRHEqlg9R0AV2WVPle9slWBE8R?=
 =?iso-8859-1?Q?xHbUMdZkuh7Ve331GQGGPTMtyKjY81N977R7ukBKnC6ZjY4ADn2UBmXeif?=
 =?iso-8859-1?Q?XNpeh4xDxx1/oa6oWfP1eyf/cjwhH3mXeRxgL6v8tjKE/eQegqsGVSurcH?=
 =?iso-8859-1?Q?4sXk8ujPPyhcF2ocwq7DN0rhxD1B5b9e3zDgIy6RqK/A65HafnCqhc/E8Y?=
 =?iso-8859-1?Q?VCMgqA+ppKFk5R5APv2RInyigkqyOhSG7hISl10m1DCEr9r0gaq6K1oc5F?=
 =?iso-8859-1?Q?lFh2brmeHrzzxMtt/bWbO1W/YODP7dg7tWJl7lKFyXdfSjoxLf/UWb9v46?=
 =?iso-8859-1?Q?KiHHU+5j2Kyvwh/PQKywzRsHoNLBBMxgxQyhV2Mx+lGmasRgPbDblcFCno?=
 =?iso-8859-1?Q?Uh43UXYGJvUOLe+P1a300X9T23yqTpN/BuAVSMZG3dfoI6sLhCQeUKXwoo?=
 =?iso-8859-1?Q?sWRJU2yno7Bi5Yv3+3L2w68vVyQt?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1313.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff2e12b-dcc5-443c-9864-08ddad455915
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2025 02:19:11.5054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pzMghhBxMeMxWUqVmKXLAxq0A3ByHKpOKs2b1aTZmJoERqJoXFosQ9PifaBIINfIoKoFkTIheTNzQzQ9vcafkX144338iPyCjcrUiwaAMng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR21MB3595

Hi, I have a question around DMA alignment for MD block devices (RAID0 in o=
ur case, but applicable to other MD array types). Many underlying block dev=
ices support more permissive DMA alignment requirements. For example, in ht=
tps://github.com/torvalds/linux/commit/52fde2c07da606f3f120af4f734eadcfb52b=
04be#diff-dc92ff74575224dc8a460fa8ea47dd00968c082be4205ecc672530e116a0043bL=
1776=A0the NVMe controller DMA requirements were relaxed to only require 8 =
byte alignment on the buffer provided for Direct IO.=0A=
=0A=
However, when NVMe devices (or any other devices with less restrictive DMA =
alignment) are used to back a MD device (RAID0 in our case), the dma_alignm=
ent on the block device queue is set to a much more restrictive value than =
what the device supports. From initial exploration, I don't see why that is=
 necessary. If the underlying devices support less strictly aligned Direct =
IO buffers, and the sector/block sizes are a multiple of that alignment, al=
l possible addresses handed off to the backing devices will be correctly al=
igned. For example, even if the buffer is split across multiple stripes on =
a mdraid array, since the IO starts with sector alignment on the disk, any =
multiple of sectors from the start of the buffer will still be correctly al=
igned.=0A=
=0A=
Within the md driver and block layer, when setting up the md block device q=
ueue limits, md_init_stacking_limits() is called which in turn sets up defa=
ult values from blk_set_stacking_limits here: https://github.com/torvalds/l=
inux/blob/9afe652958c3ee88f24df1e4a97f298afce89407/block/blk-settings.c#L42=
. The DMA alignment requirement initialized there (SECTOR_SIZE - 1) is far =
stricter than required by many/most actual backing devices. Then when the m=
d layer later calls into mddev_stack_rdev_limits, it calls into queue_limit=
s_stack_bdev which takes the max of dma_alignment on the current queue limi=
ts and the next device in the mddev.=0A=
=0A=
It seems that rather than setting dma_alignment to SECTOR_SIZE - 1 in md_in=
it_stacking_limits, it should be set to zero, and as queue_limits_stack_bde=
v is called on each backing device, the dma_alignment value will be updated=
 to the largest dma_alignment value among all backing devices. Are there an=
y thoughts/concerns about updating the mddev dma_alignment computation to t=
rack the underlying backing device more closely, without the minimum SECTOR=
_SIZE - 1 lower bound today?=0A=
=0A=
Regards,=0A=
=A0 =A0Jason=0A=

