Return-Path: <linux-fsdevel+bounces-19861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BB58CA70A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 05:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD5DA2824EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 03:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CE41BF50;
	Tue, 21 May 2024 03:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UVPo1Zb2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2042.outbound.protection.outlook.com [40.107.6.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6678717C6D;
	Tue, 21 May 2024 03:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716262106; cv=fail; b=J1zfeIzjO/X9konG+lGsLrJzbSAsKANvTaH+ppY1J1PjN0g1LHwLUyi+ANUpWDrdPbqzMC+o+yW7t2JSKN8Gh1unylPU9/kBun4nNtssy3NCTuQ5wPZ0qWi4P8P1E1TmHvUEeFl0JElzzLFyVnU/JCJKrWlCMD4EdUIkcGrsWrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716262106; c=relaxed/simple;
	bh=MzPB7ZZ6Z5IdenVabdWi9YtXEVUNaX4sVy16S8Rv2K4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IycSvGJzTLuNW/DeJWP1ZITmfNAtKd71ntDJ+jZ9J0zAhZ7io4laz11JTJcBohi3/LMITpQe7WXHhXpDnqUTvvk+b3Zby8TE4bjuXQy+rrRPb1lTw6ZcNY3PSVT8U/7GcaHbx0HgBBErU3/qKv0Ns5/YctNXzsrWVu+3DrDvJVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=UVPo1Zb2; arc=fail smtp.client-ip=40.107.6.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOsKWZF19KLSmWu208QqdOHaEtg7AfUmOf1+uD8fl6c3ZghHIFQ7GeJ1fLuVQio19OnYPxq4q90GpPPu01gZSc5wIP7fF62SwLRpXN7wfOdKwDd0A/ygPZu97FyH10YSbeIew2bJ8e0yhKRaREO82+Ep9JuQ1ZoNGy0TkwLBBUEtAkaVNJDRLazcI4ybSC6zmXCSZMDETbJSVEzhSsh0Kvn409GawRA32mdU2gG9muesiD7V4+qEcBffwE8h3bSB1wbIYgGUP2BMt1oZ/5bJtC+MPKA7lmUVG3/yJfn5d3mAow1jjW2hN4U4XLIubOH9ZOpw6yRYmo+sYZOQqHQmaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WochignTIwIPyyTdxOzcLlmWpQ7M5ZVQRhp2E5OLnAQ=;
 b=j7KykuDttWzGPZTsvhGRRfy1WYIK2rTNjcnvurgaKru1cbpPbbLA4gSnGAVkf74ypC7IHVNjBZbrLGS92lppD/2++zicGzYU6zPOKQ2L8jQhXY6slk+66jTG9P48a2Z38Dd/MYdN1PFuTyw5XqVj+THg7pETDIu2LzIjpu2fokd+twRrjYcJkb6mypaJIoBo4gZGnE9GYVdIUKj4f9vPIsANBsbcbqenx44aRBMCaSAKD44+yi8o5gjhjPU78ngM1DgXxLepICuvUnQ3cgTE/ySYbg5ETGKq7efb88XL33a1rwiVx+owcAJiGT8B1E016klXB6ypO6vHLg41//xzsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WochignTIwIPyyTdxOzcLlmWpQ7M5ZVQRhp2E5OLnAQ=;
 b=UVPo1Zb2eq/rhEHN6lYLXFXba7TIjrJEAB8e7zKG+AtaaCtvjHOtU7x7tMyceT3FWKN+LCn+4jrgvHsfKMtpk1XRa+oZzt0oUc1jx1gN0AUfgFvLWGPJE5mJ9xVIU4k9e+VmJvFid5RI+DseNW21oceBuQam8t/y4m9IoCW9wvA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by PAXPR04MB8606.eurprd04.prod.outlook.com (2603:10a6:102:219::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 03:28:21 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f%6]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 03:28:21 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: brauner@kernel.org,
	djwong@kernel.org,
	willy@infradead.org,
	kpm@linux-foundation.org
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	jun.li@nxp.com
Subject: [PATCH v4 2/2] iomap: fault in smaller chunks for non-large folio mappings
Date: Tue, 21 May 2024 19:36:24 +0800
Message-Id: <20240521113624.2538951-2-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240521113624.2538951-1-xu.yang_2@nxp.com>
References: <20240521113624.2538951-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0022.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::8)
 To DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|PAXPR04MB8606:EE_
X-MS-Office365-Filtering-Correlation-Id: b283f680-2b96-4a97-fa65-08dc794610a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|52116005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mtIuQs436rEL/iPQ6cnC7nMG5A3Y0WK5ehJTqVlacpNpwpMqWdRJwY9X9GEF?=
 =?us-ascii?Q?lG6AOE1CKDUq5VVnltqYT4MLroEdhUmkj4Bsd7TdfvSpUBZjs9SazwUKYQwc?=
 =?us-ascii?Q?hL4G3ZiWeAyT86mIviEsXwQDvZUL8EEPbn9L4wsz4/kbtQH0Nb/DXXqMQk14?=
 =?us-ascii?Q?f9xsS8TTaFn+SmOxgA4iNv7v+WYNSeTxfQ16NPcvDJ0+kqobZdcsy6OEPfYq?=
 =?us-ascii?Q?QdHp1uTW4tn/PAscJGoqqBqDd29nYbQZ2YHx8jQwpJgCE9K1yI+KeRaYTw3H?=
 =?us-ascii?Q?Raryl/8YhNcu5h/dsoWZr8KAYgh06znGW89IX4VPR0ja1xGTBUnK6zP4+Au1?=
 =?us-ascii?Q?sM3skI4uWWfSX07PfUshDDi5nLAnCnwnytvWGlOaYFCSYhDBVivYYwzcfrA8?=
 =?us-ascii?Q?fcIQECGW4C9qG6woj0kaeQ2aTy+7Ug3TAuawhubfJnBjpHFMOkcioflSfoHl?=
 =?us-ascii?Q?wQfbGlagFoVO6FdrvrfChQd631W7IJoymRMk6h9sm8OxdwCjyOuzdeRUsBMf?=
 =?us-ascii?Q?XkTQYBnCQ3TxNHgY29EPg/aMhtM6nBS6s8F0DrV3QxaWSZf4O8vdPvxYlwey?=
 =?us-ascii?Q?RLUxKDp/OI31/L8y6JbhWA8e8kDWiIGdSbfh/iOa4yjoDkD/No8RdCRJhGgI?=
 =?us-ascii?Q?/xvg5NEf4U+WlOrRobZKoO6gkd5CQEzZ1uh4sMWgQ5pbMgTZhj8ZJtRJViu6?=
 =?us-ascii?Q?j1zMh2AcWUhjrlC6YKqy3fccFeN+hgIy07gQYveCX1kaZiTNNqG1JZoNI6nf?=
 =?us-ascii?Q?fkIYJvSXATmdwzRVa+2J7OXQBGdHweVAkECKkKfDT+QA1u6DuAcSsfHfw5Rw?=
 =?us-ascii?Q?InfnivIdBe73Vt7ntdh8la+EqNV6EiZS78zIyO67LugMuk/Eq4EuqJvN3EO5?=
 =?us-ascii?Q?6FrEJek61v8h3vO04LE2KALrhLJtQW/e7CYKFQf4eq2uk3pOpHjVdwWevbJw?=
 =?us-ascii?Q?cp+DGC5YMMnJK9J6YX3IE8+NjBz5T1P8S6Qq1+Rg7i2UJLcVDxjEX9sz0iGj?=
 =?us-ascii?Q?Eg1bJdlD9xLlPMC9hlKpcB7UVo+KY1EC4MdVKdOOeyPiQUTriI9yBayVHx96?=
 =?us-ascii?Q?KvNgr6mpCGSBIaXz1Y1xGyDwJW2PvgSvEp1E3VvU10aa8IjR35SJGn+2xpdG?=
 =?us-ascii?Q?wptsNnF5SVPdgfTmqekCKIa2zV24AA64Hm3XsMJzzMgwzJdVVkNrCDBXNWg3?=
 =?us-ascii?Q?EZoUDmhVgx3v0XTNQCsGRQX2JEQKfZ0G48EVStZknS1FDjOqquc6d+L/Zafc?=
 =?us-ascii?Q?yDPkTP6cYpPGLYHgxmGNfztsnpTO0h/Te0di1evaKA3Q4jA78WfIseU1dI9U?=
 =?us-ascii?Q?+TTLcoWFMGsaqaVgBhAAIe+j/JADP1MahHmyNJT3MZqDSg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(52116005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DZ+VDfzlbLPa3j43FmSht4mwUDXDTVZoCUwjHcrxZylmYUBvzDRdEvdyW9Bu?=
 =?us-ascii?Q?/ysuCNdHfEUxXWp3+I+D8KFMs3sew+3PC/hlc7r4PE0F+lvVkR/hW42ScK+2?=
 =?us-ascii?Q?wLmAFayaG6D/IplNDEiFA2hBfrAEopJB8y1KkEU1m2e7zB+ulA6fh6iyQpmu?=
 =?us-ascii?Q?oAitaVXiH+MJVzw2SRgB7v2ddLeFefhBtgV//iNNr/aInQSLPVyG6KP5YNI9?=
 =?us-ascii?Q?UnFhpv5uM7Nh+tz/IuQp8x2srp4tzIkmDrPYhcs2BlTwHk/ONdLT6OKnDwaY?=
 =?us-ascii?Q?krdbl/0GvAoleEU0z/sfJ86Y6qFV/u37UhHun6xuKlLdZ4finRmSZJ7ZRLiF?=
 =?us-ascii?Q?4t0s1NgZBPe34ecBGm7SLhr3KUFZ37HVXO44mPNWWOi4tcI2L6P37mIDiUPA?=
 =?us-ascii?Q?sS0jnlQft5Id9NmYAJM90A5yIFeUlaYvb8w6F+hlYMF7F/OcS8yOCaWtbbBZ?=
 =?us-ascii?Q?6par9EAb7zA80e9/oJTu5k0pauhJGOzixIV9ZXKTNmWceaRXkYy6btfPc6To?=
 =?us-ascii?Q?aGB0DXlKmNeubP0OK2PyCnvm3y6idori5ZUL7VSJByt7XRIK5qyHazixBMGT?=
 =?us-ascii?Q?VWx4V4hRBld8KJvcsl4B0HOm8FhoBAs61wbXeSbqkmEt/vsA2PYeNCNgntLE?=
 =?us-ascii?Q?Yk0Bnr0ID4HLkLf/nt+niqXDcCwhj6C7GYoL8PCXV0+xxTZ/p3uDUbIHu8sP?=
 =?us-ascii?Q?tzHYj411Teqw1qp/wngKN+m/BSATRaz+IMAASE5qZhSzIMpiCzR89cYFszyg?=
 =?us-ascii?Q?Fk76dlEfgGc+zohv/o4jSC/z9jsEQaaj44l0T4ultPgtNjvJPwqKGl5hpmv0?=
 =?us-ascii?Q?8pRwtYC/QLH9Y3ZyEussfDaO3WyJZGcLBKHoPNixPosQfXs9X70GyTGm5NEB?=
 =?us-ascii?Q?EnCBS5k72gBhUtU8XKZCHToXrY/NluPdQ6jGg6kFmSzRW2wKLH0ZJTHngvBR?=
 =?us-ascii?Q?zstIsQEVPVThpKWTBSURYQ4YM4p+hgxG+AAS6+Uhetuj5rXjKTG1anBs3npz?=
 =?us-ascii?Q?oe5K3EGLq3focTiu4n0BTUCaDKnYU6qV3TVM9+5lSqFSNtKlE61LamFBnv0r?=
 =?us-ascii?Q?+UEAdobCTtmufuzJFQmuj6Q/te0K5f1UdUetu4eQBTn0SqQN625lwTanCT9X?=
 =?us-ascii?Q?TtcsAqJTy/KGPg/IPMwvgdQQjdU/BoqNOjNGv/GPm+PVQkCLQyFP8ziHd8Ec?=
 =?us-ascii?Q?YCXFXZTcN+oAUKWIh5TDjql437h/tJgFJrocWlSnDAc62RfUawpTSO4ny79K?=
 =?us-ascii?Q?an7VeDSSRcJAwcay9VOSHgxI71BiKgJHkZLCbfBfvJkLHA1FHgwHQt/1L4ak?=
 =?us-ascii?Q?MUbTZ5L8WjG/V85HcLMsg+HSg3VDKt1cY7yDHwApYgyzu6MapHdDmUiox+xl?=
 =?us-ascii?Q?6sZcvCX+bZr7qS5imb+CxQMuTDhhqXyhib0JTPC9DdTRYCPAjL2xMabRnYcS?=
 =?us-ascii?Q?K9GRCMrJLnZxoACvGKgFzXEGPOxxUB7q83MmNwT0uXMQKqPlaGwDSpPCy6W4?=
 =?us-ascii?Q?wK9JQB1HE0Xw6vgrKp80qUgeBDJq8QXxAd4rX90heMzfxZa2ygrCwpTcrQyK?=
 =?us-ascii?Q?f+drbFR3sqNB3X7qvHYZAW9P1EwK18kQjDcZ3Nl0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b283f680-2b96-4a97-fa65-08dc794610a4
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 03:28:21.6777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kXuiFbf7TgqmUIn09s4fmFe7zwhLC2ErouoZ2cUEe6zXl773XL+xRnxYsMJd9OUo70UnHiYjBIwBjiy5xUDEZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8606

Since commit (5d8edfb900d5 "iomap: Copy larger chunks from userspace"),
iomap will try to copy in larger chunks than PAGE_SIZE. However, if the
mapping doesn't support large folio, only one page of maximum 4KB will
be created and 4KB data will be writen to pagecache each time. Then,
next 4KB will be handled in next iteration. This will cause potential
write performance problem.

If chunk is 2MB, total 512 pages need to be handled finally. During this
period, fault_in_iov_iter_readable() is called to check iov_iter readable
validity. Since only 4KB will be handled each time, below address space
will be checked over and over again:

start         	end
-
buf,    	buf+2MB
buf+4KB, 	buf+2MB
buf+8KB, 	buf+2MB
...
buf+2044KB 	buf+2MB

Obviously the checking size is wrong since only 4KB will be handled each
time. So this will get a correct chunk to let iomap work well in non-large
folio case.

With this change, the write speed will be stable. Tested on ARM64 device.

Before:

 - dd if=/dev/zero of=/dev/sda bs=400K  count=10485  (334 MB/s)
 - dd if=/dev/zero of=/dev/sda bs=800K  count=5242   (278 MB/s)
 - dd if=/dev/zero of=/dev/sda bs=1600K count=2621   (204 MB/s)
 - dd if=/dev/zero of=/dev/sda bs=2200K count=1906   (170 MB/s)
 - dd if=/dev/zero of=/dev/sda bs=3000K count=1398   (150 MB/s)
 - dd if=/dev/zero of=/dev/sda bs=4500K count=932    (139 MB/s)

After:

 - dd if=/dev/zero of=/dev/sda bs=400K  count=10485  (339 MB/s)
 - dd if=/dev/zero of=/dev/sda bs=800K  count=5242   (330 MB/s)
 - dd if=/dev/zero of=/dev/sda bs=1600K count=2621   (332 MB/s)
 - dd if=/dev/zero of=/dev/sda bs=2200K count=1906   (333 MB/s)
 - dd if=/dev/zero of=/dev/sda bs=3000K count=1398   (333 MB/s)
 - dd if=/dev/zero of=/dev/sda bs=4500K count=932    (333 MB/s)

Fixes: 5d8edfb900d5 ("iomap: Copy larger chunks from userspace")
Cc: stable@vger.kernel.org
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v2:
 - fix address space description in message
Changes in v3:
 - adjust 'chunk' and add mapping_max_folio_size() in header file
   as suggested by Matthew
 - add write performance results in commit message
Changes in v4:
 - split mapping_max_folio_size() into a single patch 1/2
 - adjust subject
 - add Rb tag
---
 fs/iomap/buffered-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 41c8f0c68ef5..c5802a459334 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -898,11 +898,11 @@ static bool iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
 static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 {
 	loff_t length = iomap_length(iter);
-	size_t chunk = PAGE_SIZE << MAX_PAGECACHE_ORDER;
 	loff_t pos = iter->pos;
 	ssize_t total_written = 0;
 	long status = 0;
 	struct address_space *mapping = iter->inode->i_mapping;
+	size_t chunk = mapping_max_folio_size(mapping);
 	unsigned int bdp_flags = (iter->flags & IOMAP_NOWAIT) ? BDP_ASYNC : 0;
 
 	do {
-- 
2.34.1


