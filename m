Return-Path: <linux-fsdevel+bounces-59023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C16B33F6C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 14:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D48DD48079B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 12:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7C0288D6;
	Mon, 25 Aug 2025 12:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="NG3hDkI0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012057.outbound.protection.outlook.com [52.101.126.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A382BAF7;
	Mon, 25 Aug 2025 12:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756125020; cv=fail; b=Dm+226ZIzDBzPpZGzyNhY2zASnI4J4orrjTCMeF/oOinhX0gC+vpACq8kEDdM2kPkh1vBTeLd4VErUFWKNxHrs4zTq5UWz7Nec/V52dN4IsZ78SpeWueRb4xpJHz3/Pr5mQp9/R6vc1w5h4CHF2Nc/G/yD6h0B3TxYRqjliLSNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756125020; c=relaxed/simple;
	bh=HH3D41vnTVCzPOwTMPwTdejN5/WoeJu9zfHDU5D/t1s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NywvS5BvZTcyqe3fm8pgbaonJ3Ii697fo91i5oyuVTfpWXFpIxxdTaDAjVK49Dg01W4DEvwH4JzQjc0LrjY0B1A0j9Q7Fm58CaDy9T4F4hCAO6eUAL+YTXTsC+dyGb/VVhvWK3WGR+lvH2lagkuaTCZQy2A7wTfOu0DtmYP7S9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=NG3hDkI0; arc=fail smtp.client-ip=52.101.126.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b61IuaWGPXDP5VEXRTwuN7TNwmizn+dAxH5vi2jD85C3jmP1aZ37WHFPoN+fHHBI7LipLhi/wqZWPhPSX5F/Il2NPq0AuZp2bGYEfQ38k3B1HoAppGfgPYZ8hyyefv1x9+v81+u1bEQK6h1Mm3mY9kx+F4w40j4T0BOBP2vZX6xM+ihu1rtfD/9okDyIkuHCVY+VLHtBpuoKx/FJoL998RDGPFto/GrY4o+eB9D4FqzKCydl9KayQuq2n7e1H8Xx5Xul1BkujhPCmPr/OwMcpV/1FVfM7UojfDR9Z1IFyDDxlo/uN9Z9kjUIgxXQ6SrhSgH1C3VhcfxEV5kzt4wemw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+UbWGEtSqqFR1xFLWbOVoiHJ4Tx30wQR17QGn8q76E=;
 b=GCBTwMNj4pe+ynSiwKSJd9vM67YSp2q5ubKKtkis0uX2ZK5LoDYid9vqo5Wk6DyxuoMeVXF8tBMGhkPDn7Q9qaoIE+FXZr2O9WIrAnGMfihQZU0SXz8i8Zrk3G5ozvcpCrrrAmlXgys8bctcjstZNSBD+kj4udSZ6ttv5JbsWhiuspYf6PCDaBVISc2NidyBJqWtatZE6K2nhEhbcJ+lHnknsRKekD9b36nJWPpZheSAp2buXR8zfoSolIFjDbKfsds9rn9ta8SyjhIsu3dpc2ZWCguI8tCD3FucXlD/ZLCRE74FTi2JJ1Fams3I8dNwinE4SAYPsnIseYrVvfIR7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+UbWGEtSqqFR1xFLWbOVoiHJ4Tx30wQR17QGn8q76E=;
 b=NG3hDkI0tMj5Ym8pFm9Bcn0rAvZ9rXZoBGCTsYkrRKYjmqr1v8hpH8E6hVCnB+2+QI/7KDVidv39TrbzLrra900eP0/noYd9g7FurzdjCIkjK0mRDUOeYHGbb+GcQMQlvUCqZ0zeAFdCgGduYUzgIPo3HReuPx+d4rLtGSL3i5u5PCTy3N4B1ZdfAAZz0792ka1tcwJlk1tVFd2M5ZSo4mnjSxKlGOetljonJ4NvlLelTFpjPiQdcMtXhfXOeFC1bHrebUyZSnNKyJtaOexJfb/cF/JsGd9OvUai2JcwKMG60cSV/BLLP7LhwGFmBcW7BXDuv5s6exwVlI+THqUoQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SE3PR06MB7957.apcprd06.prod.outlook.com (2603:1096:101:2e4::9)
 by TYZPR06MB6113.apcprd06.prod.outlook.com (2603:1096:400:335::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 12:30:16 +0000
Received: from SE3PR06MB7957.apcprd06.prod.outlook.com
 ([fe80::388b:158a:e14b:79c4]) by SE3PR06MB7957.apcprd06.prod.outlook.com
 ([fe80::388b:158a:e14b:79c4%4]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 12:30:16 +0000
From: wangyufei <wangyufei@vivo.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	wangyufei <wangyufei@vivo.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-mm@kvack.org (open list:MEMORY MANAGEMENT - MISC),
	linux-fsdevel@vger.kernel.org (open list:PAGE CACHE)
Cc: kundan.kumar@samsung.com,
	anuj20.g@samsung.com,
	hch@lst.de,
	bernd@bsbernd.com,
	djwong@kernel.org,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	opensource.kernel@vivo.com
Subject: [RFC 1/1] writeback: add sysfs to config the number of writeback contexts
Date: Mon, 25 Aug 2025 20:29:30 +0800
Message-Id: <20250825122931.13037-2-wangyufei@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20250825122931.13037-1-wangyufei@vivo.com>
References: <20250825122931.13037-1-wangyufei@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0099.apcprd02.prod.outlook.com
 (2603:1096:4:92::15) To SE3PR06MB7957.apcprd06.prod.outlook.com
 (2603:1096:101:2e4::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR06MB7957:EE_|TYZPR06MB6113:EE_
X-MS-Office365-Filtering-Correlation-Id: ad1e146f-7adc-47d2-ea6a-08dde3d32512
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t3luDM+Ecgcw4zbeH1itaC0prbhqHhl/G1kSqaaeB5aAINL/Z4LrreSG9dTl?=
 =?us-ascii?Q?1BRH+KdeddY0d8soUCXOplfsO/6ktnCyXUR5H+ulJcTfiaeX1+nEIvFBn/jJ?=
 =?us-ascii?Q?9FADZRWccKi6ILO84ZDywdjmVlCLCJggHX6qkg7zBCKnzPg8OJCSgVZW4J41?=
 =?us-ascii?Q?qs0j8+dWvfrGRpwhyfJ+UimsJZ2vZzjuer0rTf9yuLqQ3SL4qk6yZyYthzYD?=
 =?us-ascii?Q?qx3hKDrywST4dMCO6F+VYVSeZvbnGPJMy/zsWtjPNRjiWOoJ5ssf1fQEspq7?=
 =?us-ascii?Q?Ws+2cg9PTplvDHPi7VRyJtcbqUpujUpt8tDRHbrNucEyYCG39iXRnjr1d7HJ?=
 =?us-ascii?Q?VMvWldrL6clASYu1X48Lbqw5IrUXhGN9kJTBhHj3jVYG+FgsNA/KfYJhBReL?=
 =?us-ascii?Q?N7gviw1uGo6MIdiQYsweLwQHxnab8Ab768yD9xFEuPiTZGtp0l6ZiEw6Cn5P?=
 =?us-ascii?Q?pTIUwcHPJzdEhcbnZtjh/yaYX4Xes2kBIQEIV//aNHzzGUsZ8FmQfzMbTsWQ?=
 =?us-ascii?Q?ajeJR2dh5y52mfv51CHICTGX/9vPVdR3GBcWdd6yUhZbwZmfaIPRkvpfzXMi?=
 =?us-ascii?Q?IljRSxV3Tay7odaV8cter+egFJ9DlyjDgScz+Choz2W/gLbS2ofMPMpzzzFl?=
 =?us-ascii?Q?Q9OupFNxESd4wwnK+cYuqwqCyd43Ceuj2i7ejyJ7p5cnzwwayxxLQ5nFSiEz?=
 =?us-ascii?Q?SlW860CHeZqv5iqahoRrsPsykhBBiMOs50waMvwIrMw8nebGOV5jX5nXpWhC?=
 =?us-ascii?Q?KLmBLw2mC4QkbFGG+eIc+Wl/OIlR2xNE0xxBVmA3BQV9iO7HmkVMmbaeGxxf?=
 =?us-ascii?Q?bEPgfv3vlqBjhwtuBxyCO+8KkF95YGubXb81zxRu7uNSqpcCpHZXeDB60JvH?=
 =?us-ascii?Q?8Y3mWQri5drifrd64QsbeSMW6/yIm2Vgrlbja6RHzyLAdmS3J26/wM9GzPw9?=
 =?us-ascii?Q?LXAHOhW1Hx2IZZg4xANmjql47B+V6EkTKfEez0cpGMG/hpKy87h3+wfVkH19?=
 =?us-ascii?Q?Tyq7JrOu5Hv/R77xMvaGOYrDV4b6zqsZsB2zbz2kiy/dUOEXU/WmZ5vRdLYD?=
 =?us-ascii?Q?BxNaTxCgN5BT1yOmxXsolZuRjoT6Wfw1aLm65XJbhWhRIDWuI0Im7huLDX9W?=
 =?us-ascii?Q?3ZHTBaVoJp2uKVgTGZ4nJ2FpfFy9Iyqh6+dy3XPW31Qlw48feHgwHLwkS2XP?=
 =?us-ascii?Q?CgKaw8++mqs75KTJNu/1P1pKzw3XgvvZbsvP3wXmBMAlnuNbFMYM6nBS80VO?=
 =?us-ascii?Q?ugRWbuh+FG3I8vLvZPt4MJyF5HVuISGQ/JWVqPiPqTujCTmER+/zsFxE/ESr?=
 =?us-ascii?Q?qxr5rZdvWJJoogmjW+skWE3SMixokZ7djwXSV19DU4prxqa10i93+lMw1FSP?=
 =?us-ascii?Q?VkTyNMWsSzfH1Zej1yo+1yPUdAON1KCHT5qruQd0j1p/JFKGfZz5wWX6gsoC?=
 =?us-ascii?Q?tDRljV6XhL2ipfRDJrP4uf7BHGTjocbMHEo07qNAWVkdMNBvciJV1xa1S5KW?=
 =?us-ascii?Q?DBwYHtK6B3GegHg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE3PR06MB7957.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ErFRX/webDnEKTvN6eGEsIUxvAWC7VafaQbIxIYCNngqIXJn2+WX4Fzv1UzK?=
 =?us-ascii?Q?7KwrR+Fm7Cu5mitijyBnQd+LruNmhUiqA2QRO7V2yg3jW0MuEqx0MX13XDBv?=
 =?us-ascii?Q?N1eUdvX/YtkOcgXX5sSDFbtgPO2CdbWUJmyA+oNyAPbn9+pcqwxhi7FXTBPc?=
 =?us-ascii?Q?Y6IjoPMmDDZuXShobyMJ4bIioYKJqIGnO/D8ClpzL98R4h/o6MQlHw0cWCA0?=
 =?us-ascii?Q?qiFVJfBcHD28AX2vR1LcCh2TYwKnwtaIo7fVFY4kFlS6z+4l6q7ek7qeR2qc?=
 =?us-ascii?Q?aoRVyTvLkRKU8ncGZ8uE6ICKT5RvXFFZkdcgrdA3O5v98S6n7eP3/bbYLvU8?=
 =?us-ascii?Q?b3yycKnToW69RLu53UzxOrAuMOSXGxxUxzlEnz7xC77AItoBEIoKSfUIxUfZ?=
 =?us-ascii?Q?XrDVKuzByRjsAnI7eb2D7kzpNIBu0UPL8YAhRDkMVINDScQcZOd+BwUJgXPx?=
 =?us-ascii?Q?jVnAjyy8K/Z6835NMz+0KnSRE4tVBUyPhxcSWPye8kwK3HBcHpgAh9oRJMpt?=
 =?us-ascii?Q?PCo5BWNrNw4Kps7oFlQ8yJOmYcivZkSxET6mlKnyaXdDLYA1bojSR3YN+JdH?=
 =?us-ascii?Q?FefgUsfckQ2PPC58rxgeEFLMENnPSfs1fH+feEjehoRYAhUQ8SuxcUTC2ulY?=
 =?us-ascii?Q?Yn6XBkMTTj+jZ3fuP+k4X6nmJMQZQdd/L/yE/8Fg+E0yQMLdre6iDA2lB1Kz?=
 =?us-ascii?Q?Vl6n2e40J719jrQOV8w1GxtO1NETFYT9jF7+OE1cDhs0sq7IqmTygAc0MwLp?=
 =?us-ascii?Q?DIV0OrfYFqFE9Nn1onXQm4sqCYecH0sTsitxZ82El1PqfcIZkBiLsvn1edcw?=
 =?us-ascii?Q?KDqABTFNU5tPExk4RFgDzJCI175FRPk6n0XNrAiKBiZPlVYOnVmIlemqSFYQ?=
 =?us-ascii?Q?2SOihlCofvJ3xcUu+CVk2mLjR3dEWQfk8y56MoRD3MK3uZRzEBbtuWlxBuoL?=
 =?us-ascii?Q?l92sKp11hJDJaarmsfdKSfts7474roQo10DaD9F8lJ8DXcL9Qw3AGqnQ7yEU?=
 =?us-ascii?Q?u+2rP1Wda7/k2LKbUf1AaDvwOsubn4hrALz5croOYTp1hOmkFef17EHlorFr?=
 =?us-ascii?Q?xFSOUbuQ6TULsl2h7FcnZidk4Ee+aOp4D6NQz4U+swvXCKvXWNpnkNT8Wj3c?=
 =?us-ascii?Q?E1iKJGSSa8/AxDo/wyFvZ5nqcJGLwJ+bw+vrpNI/U4poFcOqT+JStpyCY1mC?=
 =?us-ascii?Q?+jocGAk9jrLBjC2NcNEJxIrdBlP5619m6nfRBIwceU82oFzA2FydhSrbUbxM?=
 =?us-ascii?Q?WNqQIc6ML5KMp1XW+MHxMIOVjqqY5oZmyrnFILYwX1avJ4X+Lgc6w3j/F1ca?=
 =?us-ascii?Q?ce8w7ieagMP1Q/XEBL16IDQ2GRrO0J+er9YlSIbKeeczBTAu5TsQZOw9xp95?=
 =?us-ascii?Q?jUlwROov7BjdgJv5JAo4qX2lOzVHmMakqPZfoyd+cts1sRf+KEPasPzx26u9?=
 =?us-ascii?Q?4eyDlsauRtYffAyw/9UDTSpHkOpn3bpSQLDVv2IFzkb5jdjR0vFmW3+4JSbn?=
 =?us-ascii?Q?pNehGXohmruV5D+/dMvugmEIfDXxOqKEWqlBjjdCoYsObI/MEufwRZ7kK5hm?=
 =?us-ascii?Q?MQrd+GjoszuF0lKLFkPcjkPr3T+ZBPqAxSiS5v7c?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad1e146f-7adc-47d2-ea6a-08dde3d32512
X-MS-Exchange-CrossTenant-AuthSource: SE3PR06MB7957.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 12:30:15.9104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: snpljeU/y/YXAW8BSEZ5gwYk/Xh8PzpzWlp8BBV82xRgNayYnOX3SOcDU1dsebKomSM6PowkUTGoR4OcPyr9Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6113

The number of writeback contexts is set to the number of CPUs by
default. To test the impact of the number of writeback contexts
on the writeback performance of filesystems, we introduce a sysfs
interface 'nwritebacks' for adjusting bdi->wb_ctx_arr in runtime.
However, only increasing the bdi->wb_ctx_arr is supported; support
for reducing it is still under development.

Signed-off-by: wangyufei <wangyufei@vivo.com>
---
 include/linux/backing-dev.h |  3 ++
 mm/backing-dev.c            | 59 +++++++++++++++++++++++++++++++++++
 mm/page-writeback.c         | 61 +++++++++++++++++++++++++++++++++++++
 3 files changed, 123 insertions(+)

diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 30a812fbd..c59578c25 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -112,6 +112,7 @@ int bdi_set_max_ratio_no_scale(struct backing_dev_info *bdi, unsigned int max_ra
 int bdi_set_min_bytes(struct backing_dev_info *bdi, u64 min_bytes);
 int bdi_set_max_bytes(struct backing_dev_info *bdi, u64 max_bytes);
 int bdi_set_strict_limit(struct backing_dev_info *bdi, unsigned int strict_limit);
+int bdi_set_nwritebacks(struct backing_dev_info *bdi, int nwritebacks);
 
 /*
  * Flags in backing_dev_info::capability
@@ -128,6 +129,8 @@ int bdi_set_strict_limit(struct backing_dev_info *bdi, unsigned int strict_limit
 extern struct backing_dev_info noop_backing_dev_info;
 
 int bdi_init(struct backing_dev_info *bdi);
+int bdi_wb_ctx_init(struct backing_dev_info *bdi, struct bdi_writeback_ctx *bdi_wb_ctx);
+void bdi_wb_ctx_exit(struct backing_dev_info *bdi, struct bdi_writeback_ctx *bdi_wb_ctx);
 
 /**
  * writeback_in_progress - determine whether there is writeback in progress
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index a5b44dd79..44b24c1e4 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -469,6 +469,34 @@ static ssize_t strict_limit_show(struct device *dev,
 }
 static DEVICE_ATTR_RW(strict_limit);
 
+static ssize_t nwritebacks_show(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	struct backing_dev_info *bdi = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", bdi->nr_wb_ctx);
+}
+
+static ssize_t nwritebacks_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct backing_dev_info *bdi = dev_get_drvdata(dev);
+	int nr;
+	ssize_t ret;
+
+	ret = kstrtoint(buf, 10, &nr);
+	if (ret < 0)
+		return ret;
+
+	ret = bdi_set_nwritebacks(bdi, nr);
+	if (!ret)
+		ret = count;
+
+	return ret;
+}
+static DEVICE_ATTR_RW(nwritebacks);
+
 static struct attribute *bdi_dev_attrs[] = {
 	&dev_attr_read_ahead_kb.attr,
 	&dev_attr_min_ratio.attr,
@@ -479,6 +507,7 @@ static struct attribute *bdi_dev_attrs[] = {
 	&dev_attr_max_bytes.attr,
 	&dev_attr_stable_pages_required.attr,
 	&dev_attr_strict_limit.attr,
+	&dev_attr_nwritebacks.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(bdi_dev);
@@ -1004,6 +1033,22 @@ static int __init cgwb_init(void)
 }
 subsys_initcall(cgwb_init);
 
+int bdi_wb_ctx_init(struct backing_dev_info *bdi, struct bdi_writeback_ctx *bdi_wb_ctx)
+{
+	int ret;
+
+	INIT_RADIX_TREE(&bdi_wb_ctx->cgwb_tree, GFP_ATOMIC);
+	mutex_init(&bdi->cgwb_release_mutex);
+	init_rwsem(&bdi_wb_ctx->wb_switch_rwsem);
+
+	ret = wb_init(&bdi_wb_ctx->wb, bdi_wb_ctx, bdi, GFP_KERNEL);
+	if (!ret) {
+		bdi_wb_ctx->wb.memcg_css = &root_mem_cgroup->css;
+		bdi_wb_ctx->wb.blkcg_css = blkcg_root_css;
+	}
+	return ret;
+}
+
 #else	/* CONFIG_CGROUP_WRITEBACK */
 
 static int cgwb_bdi_init(struct backing_dev_info *bdi)
@@ -1292,3 +1337,17 @@ const char *bdi_dev_name(struct backing_dev_info *bdi)
 	return bdi->dev_name;
 }
 EXPORT_SYMBOL_GPL(bdi_dev_name);
+
+int bdi_wb_ctx_init(struct backing_dev_info *bdi, struct bdi_writeback_ctx *bdi_wb_ctx)
+{
+	return wb_init(&bdi_wb_ctx->wb, bdi_wb_ctx, bdi, GFP_KERNEL);
+}
+
+void bdi_wb_ctx_exit(struct backing_dev_info *bdi, struct bdi_writeback_ctx *bdi_wb_ctx)
+{
+	wb_shutdown(&bdi_wb_ctx->wb);
+	cgwb_bdi_unregister(bdi, bdi_wb_ctx);
+
+	WARN_ON_ONCE(test_bit(WB_registered, &bdi_wb_ctx->wb.state));
+	wb_exit(&bdi_wb_ctx->wb);
+}
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 6f283a777..87c77004b 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -740,6 +740,59 @@ static int __bdi_set_max_ratio(struct backing_dev_info *bdi, unsigned int max_ra
 	return ret;
 }
 
+static int __bdi_set_wb_ctx(struct backing_dev_info *bdi, int nwritebacks)
+{
+	struct bdi_writeback_ctx **new_ctx_arr, **old_ctx_arr;
+	int i, ret;
+
+	new_ctx_arr = kcalloc(nwritebacks, sizeof(struct bdi_writeback_ctx *), GFP_KERNEL);
+	if (!new_ctx_arr)
+		return -ENOMEM;
+
+	for (i = 0; i < min(bdi->nr_wb_ctx, nwritebacks); i++)
+		new_ctx_arr[i] = bdi->wb_ctx_arr[i];
+
+	for (i = bdi->nr_wb_ctx; i < nwritebacks; i++) {
+		new_ctx_arr[i] = (struct bdi_writeback_ctx *)
+			kzalloc(sizeof(struct bdi_writeback_ctx), GFP_KERNEL);
+		if (!new_ctx_arr[i]) {
+			pr_err("Failed to allocate %d", i);
+			while (--i >= bdi->nr_wb_ctx)
+				kfree(new_ctx_arr[i]);
+			kfree(new_ctx_arr);
+			return -ENOMEM;
+		}
+		INIT_LIST_HEAD(&new_ctx_arr[i]->wb_list);
+		init_waitqueue_head(&new_ctx_arr[i]->wb_waitq);
+	}
+
+	for (i = bdi->nr_wb_ctx; i < nwritebacks; i++) {
+		ret = bdi_wb_ctx_init(bdi, new_ctx_arr[i]);
+		if (ret) {
+			while (--i >= bdi->nr_wb_ctx) {
+				bdi_wb_ctx_exit(bdi, new_ctx_arr[i]);
+				kfree(new_ctx_arr[i]);
+			}
+			kfree(new_ctx_arr);
+			return ret;
+		}
+		list_add_tail_rcu(&new_ctx_arr[i]->wb.bdi_node, &new_ctx_arr[i]->wb_list);
+		set_bit(WB_registered, &new_ctx_arr[i]->wb.state);
+	}
+
+	// Make sure the initialization is done before assignment
+	smp_wmb();
+
+	old_ctx_arr = bdi->wb_ctx_arr;
+	spin_lock_bh(&bdi_lock);
+	bdi->wb_ctx_arr = new_ctx_arr;
+	bdi->nr_wb_ctx = nwritebacks;
+	spin_unlock_bh(&bdi_lock);
+
+	kfree(old_ctx_arr);
+	return 0;
+}
+
 int bdi_set_min_ratio_no_scale(struct backing_dev_info *bdi, unsigned int min_ratio)
 {
 	return __bdi_set_min_ratio(bdi, min_ratio);
@@ -818,6 +871,14 @@ int bdi_set_strict_limit(struct backing_dev_info *bdi, unsigned int strict_limit
 	return 0;
 }
 
+int bdi_set_nwritebacks(struct backing_dev_info *bdi, int nwritebacks)
+{
+	if (nwritebacks < bdi->nr_wb_ctx)
+		return -EINVAL;
+
+	return __bdi_set_wb_ctx(bdi, nwritebacks);
+}
+
 static unsigned long dirty_freerun_ceiling(unsigned long thresh,
 					   unsigned long bg_thresh)
 {
-- 
2.39.0


