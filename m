Return-Path: <linux-fsdevel+bounces-42821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B996BA48FAF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 04:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 979E83B7A43
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 03:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E991DED78;
	Fri, 28 Feb 2025 03:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tooXzw3h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD9F1DED55;
	Fri, 28 Feb 2025 03:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740713574; cv=fail; b=nWn0KNx1W0TZ5+aQ/UFBd6LhChozg57DI/Y7blTIKKwB//klH6/+l50reECJPm/XN8XjAUN5aCbsxy/ZMJH6B8Id6T5sMloDyT4A+adJZs5DJpNNmeMUiUCUJXnaGyY6bJHXvG9WL3T4wDNGTFwusT6qhGejjn0xxiaBIetj0Wc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740713574; c=relaxed/simple;
	bh=X623mmXDr/V8tui02oZFzBQpW5DYhwmPCmwhu2QfHlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N5yKNQmzSjmQOozBbxPqbefK4LKg++oGibCYKSVS3CefOoLbEnHN0hUyEmwtlIxjqgtHI8d30FVdlw/BjEEVzhMHjGoKiwvRfndcMMIX6Z/6+xrb2FBlrlOfqVPjWxGEjU1MLuT0h2kCqzCpGuoZTwyuDUV+tsOfSF8huuf45a4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tooXzw3h; arc=fail smtp.client-ip=40.107.92.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hb16S1Ljf8yKD7N1SgidGVhIG26Om6Zym+Q+u/JgFWjY470kLxx7pVIxWRyOW2k2+b2Xu0lMSYQHjFn9ZxZXkIC7LMUV/jxeD5e0UgZv2qBWPdbJeeUI4+m/lf0bePU6ldeNwdJZa7HtpplZmKRRRfkDgEx/q99VNb4fPFcyLYoheBrr6SJN4t6wauXveJDFPliRikdRYCZcnvheMouQKPyi//Rno1iB1EoDO6dcSpXPvxuOj11EGy5PD3spKgxu5civDRxuiN85XJ4kYwJFDrvpFi9FqQiCQ3T6HC+koRhLIYbAXgxYpwmpIdZWkpChkIuU//cyeZOuhO2bwtWxHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RtBaqYvfVYWwhkk0mbirzaJ8NN/nkFZeQ7cueszAH5c=;
 b=OSNV8Z3C3Id/LhGTjG4FCNSzY2ZZnBYq7unyMrX3xzBrTQlfncjq2Z/3+bz0SKecPR31snvkimhgYGkq+Vsa2ODeLyZYK0RZIbigW8CnCEVwSFENfRw2vkJriLoeHIGlfRriXDzYZYIH1tFvipmhRPP3pWKs/8opEnnLKaXoDF2C430QCA02JC+e8Yp+C26k+TCjOdutj5Qibd9zXIieVWRdVjcbJyvGjmZ8Qz6+uI9mqiO5r1YhTPHwsBAnfLk+JdZoOJWxZIWdfKgBHMx4CmOeRM5atm4Ey27yD+4+c1RCQtBIOMilvrQZA3RxVWDOR1N1+Ac9FZxFKP1Dk6X9Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtBaqYvfVYWwhkk0mbirzaJ8NN/nkFZeQ7cueszAH5c=;
 b=tooXzw3hwUI0Fe1wdzvmo0mGUmKMSsS/GwxOeIVQpNcnG1aZL88GTNz4yduFJwpeo+/p/FoaE4QuepLYE5sONFtBQ1kWo8HqjrqkCqeudXQ20thRkeomXfR/JYLFn7s16zBXvtfCcFEaD+Zvn0yr7SHf4TlTZ9x9kBNJyrz+aI5Iy//0xhur7H9TJfnCBbjPX6NN4b3d8XJk6jDF7Ua/p9PCNRBf9DKB1j61oUWzL7nYM8w8WXEEUPNldOyXS2Z9OBRlq/p9qU4aDrfyn+ehZpZpr9OL5jZ0OTBXCjgCtD1304x2ka7EJ5TcGfE/bn7b/3SGXtGeGEvowDzgckVUHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SJ2PR12MB7991.namprd12.prod.outlook.com (2603:10b6:a03:4d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 03:32:49 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8489.018; Fri, 28 Feb 2025
 03:32:49 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org,
	dan.j.williams@intel.com,
	linux-mm@kvack.org
Cc: Alistair Popple <apopple@nvidia.com>,
	Alison Schofield <alison.schofield@intel.com>,
	lina@asahilina.net,
	zhang.lyra@gmail.com,
	gerald.schaefer@linux.ibm.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	logang@deltatee.com,
	bhelgaas@google.com,
	jack@suse.cz,
	jgg@ziepe.ca,
	catalin.marinas@arm.com,
	will@kernel.org,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	dave.hansen@linux.intel.com,
	ira.weiny@intel.com,
	willy@infradead.org,
	djwong@kernel.org,
	tytso@mit.edu,
	linmiaohe@huawei.com,
	david@redhat.com,
	peterx@redhat.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	jhubbard@nvidia.com,
	hch@lst.de,
	david@fromorbit.com,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	loongarch@lists.linux.dev,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH v9 18/20] dcssblk: Mark DAX broken, remove FS_DAX_LIMITED support
Date: Fri, 28 Feb 2025 14:31:13 +1100
Message-ID: <33eef2379c0d240f40cc15453fad2df1a4ae34c8.1740713401.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.8068ad144a7eea4a813670301f4d2a86a8e68ec4.1740713401.git-series.apopple@nvidia.com>
References: <cover.8068ad144a7eea4a813670301f4d2a86a8e68ec4.1740713401.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0018.ausprd01.prod.outlook.com
 (2603:10c6:10:1f9::9) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SJ2PR12MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: aa6f5491-eb67-4c2c-6a5c-08dd57a892f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h7ay5QSLmeI7YT+4ZV4qVX6heTeO+TEo/Z7BHuCs7C3NfLH6exwHV4wL6Gju?=
 =?us-ascii?Q?jLSUeNcleBppmzdNqtLEjpbvRcm3B0xhEifQvG03+4JbbX/YCpYuHHlNh721?=
 =?us-ascii?Q?oG2YqddRPViR9Xu2+f1DMZCodN14GxPpp6+CsXcasOHhARzKKcvyi/pEV65F?=
 =?us-ascii?Q?bRfwJgZDzjITY4JbWA0iYAwkVZQTo80c3gmdlga4lpiO6sgenusAHUkuvu8w?=
 =?us-ascii?Q?wrCqiVALPvq7edEGoHAfdRXokbJWObsfoJqeauQrkPs5TRbftOb2IfBbyBTf?=
 =?us-ascii?Q?ytKkjpOQl1hvbQJp7fT8aA+BhNInDDA2svPL5gYDp4BQulm0QGaIZPcaY5M2?=
 =?us-ascii?Q?0TnipA76a6Ummpf4g52GqNr6md7YyN63r9ZiM2edxeM071Ti7niGS7aiA6RK?=
 =?us-ascii?Q?WUsNySrzUajfJulVggvAZh+Gu25CSV2R5u2AYDtFH4aoRBpdfhDKtPao5Bge?=
 =?us-ascii?Q?B/WTfv8BHL6y19XOqgp4C2xqIaArHy5mPlpxQHKHyEUY9BLkoVvwr8NmiDiV?=
 =?us-ascii?Q?hS4XQ0JZFv0kCWrjluGCI6V5BEDJmRsoJb24uQZpclaTzP65MsysqDkTs/Kt?=
 =?us-ascii?Q?yZ1ApvPwmV2RwQNAld0VNhUHLcemlxwkZ9xlP/9gb9f4qRe4vQwAYe69XDej?=
 =?us-ascii?Q?GyZZMbG1rDyOeUDJVE6nLaMMB8SuJSr8MPY99DhygQoSwkH9unj8wjrzRJJm?=
 =?us-ascii?Q?02H87qpCIxWSaLwrWQJhTMRtBIg8t+5vP5kyeJJ15vh9lU0XtyWHO6smJ0IC?=
 =?us-ascii?Q?D8DCd7wRQ4ZYWO1bH3s68QzB7bhVl3bCbWUAFxCZehgkjW+WKvJ2p+Fhp0H4?=
 =?us-ascii?Q?5VLVUkDqztPZ2buJ0Z4kwoyhcRXt46I7R1IlVNlrnSw+PupG5+ceuhXdmk4S?=
 =?us-ascii?Q?CJKhyB/CMD9+1KbvtElcNaCjWaBBiX90o+knSq81o0/mnI5TPQugs9VjG+BF?=
 =?us-ascii?Q?8luxoDbzOZxsWBh/zylOi5hLSzeVF/bNpTZJEcKfCGRft0s6T2qJvT15svl7?=
 =?us-ascii?Q?eqNh1jAizWh8L8WPMY/mKtyslEYnYJMsOT6veZ6F+qiOn3BMt39vD+RceZhR?=
 =?us-ascii?Q?ndjyhXkJiqB7P4etDTEmhDUWewkOBk26LYNO/KbCQW5tuJFdbtn3hKtsckz+?=
 =?us-ascii?Q?g5lPBKIPIZ8JmerelW5XShW9hz/YFEJwZsQGBV8lV9rmhJuj4wQ48fO5FaEN?=
 =?us-ascii?Q?VdOW2+6U7CbSzH0BpEZomNskYUoPQPmzL3ZrjP+XwE2ZV0dXhdOu/y/ZaKQh?=
 =?us-ascii?Q?MszsJGGMdLj28+u/a0UbmwqCC3bJe2DLLdOPIcgM8kwiwmcRaFA4wy52zUB2?=
 =?us-ascii?Q?9hysA4/OotMV5L3QfsnzdBsF5bR+Nh8wDZqbfsxUAaDMLNe6BXETYoudwEUE?=
 =?us-ascii?Q?4uAv8AqL0whYYW92sxGIEzyWuCsV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CND0fBQ8L/d1zldUve59EuaaNXPfI40hSQ3grFH4b4BrGcFsRR10nXninaBb?=
 =?us-ascii?Q?4H9OLZ18748D4Uw+Y146nX6UmmbF9xxnYXp8t+3+IkV8UIm+iYgY/cU27rDA?=
 =?us-ascii?Q?znXa6MHQwU/rdYg8j0bEA/MHf5NxkjJm0XoXOHjJBVECgVHgcj7S/gXHBp99?=
 =?us-ascii?Q?vxDlZWjMFkGTYQLbm6c3b1Ug9ccnGaZ3/2AJwBrbvlRreVo4DUprMHdMeyKT?=
 =?us-ascii?Q?/KOBj6wDSsXIUY6o8fDPTIHNaPIYzFNnDZ9W07KhEoc/9DGcN0BpFXMnzFbX?=
 =?us-ascii?Q?6oCwrDuArV6a3kBdQaRWHo7P4uszLHA/uEnhKKATcVgnq6b0AZjon4qP7a/D?=
 =?us-ascii?Q?R8TIVGuhWRaKMvFgx1YJ5o3BIQkZb8m3B8wXaP3jOmq4mdlNNJnpZnQ5ODwj?=
 =?us-ascii?Q?yxV1CdRSToxmNLST/wpDBTMOXRG4p2AuV5EXZwyUVqxvnF3AwvvxB/278Ig1?=
 =?us-ascii?Q?sbMl+EZml1LZxqVqn7WRbiRFjwTSHNmqoF8EibsXes6NEITaCz6/2b09G0KD?=
 =?us-ascii?Q?hpvOW4T8Np8M9W9zTc2YsO9Q9zwNINbbcK62AP63h7xvERnPagyxtHsa5Ybf?=
 =?us-ascii?Q?CwinDwl56VW7dmfESruN2VW0T0QpVsl8UXFtGuVOIbOOISKDfTpWpjZ2vnB+?=
 =?us-ascii?Q?ZatSL7dPU9gAwWlPBrrgl4r2Ogc5HL870Soeat5TqMQQSEEq7vx2vJ6/+XSR?=
 =?us-ascii?Q?gcoWsOxo5HpwoEBzBBlrPVTCLlcOHV+H7KuOArtbNaaKfT3fFzRYVpqT5xAE?=
 =?us-ascii?Q?WEescK6Lq1yjDT9DL5pr+QzTDE2Is/1b6JCGFK6EWoSc2vs34Ld+7TvPXE+k?=
 =?us-ascii?Q?ATp4w6r00LjuHSH6IC6qrYdKHl0+SkJIhRe31tv1rImzsz2ZKniaMpDMUTv1?=
 =?us-ascii?Q?Kw6gLDnrqEroXCdl6GTYOjxzz5DEbpMIZ5d2dXEPB9W+GvXHRorz+OQsIuZg?=
 =?us-ascii?Q?aWjrqV5WOCJ/t0hsM6YOYilr/6EreLabbvSK3Pz5Rl6z64sRDkYinw4O8vR3?=
 =?us-ascii?Q?IkSBIooiRuTDLfaqXOJtWaogaCcX3u/B/cqjqh1QKDncPAvAkVUJoi5jtBez?=
 =?us-ascii?Q?KPdr5VoEEJwm4XA2WYRRypatgJA5Ws3bhAklOxZSxdB5PwYUc9YiHGGz+zfL?=
 =?us-ascii?Q?mpursspLCsTlLgnFulpJZsWXvSmKtXblwLsLNOsxduYnrsJX6xRRAC3DDkUC?=
 =?us-ascii?Q?RC3VSnyEj9ADX+l4FGi+LIiQKFB4DKEhSERsoAS3BrnH3eoa4gl9CF/rjMIl?=
 =?us-ascii?Q?3UUIJA+ZWHurf4qV/oTW9tMEcnBXjyZS/O5KiEyCSbMelDItjLeujCUxuFI9?=
 =?us-ascii?Q?SeEGOeeJPh+paUb6u6/VqaBCdY58lnA5OK8Iyi1wsf0i7LpnknWOJROwMm4Y?=
 =?us-ascii?Q?cSHVqtpdsWWU/h1j5wzOiSmqVSzhV7MsyY2/o1dXbfmQXWHWl7K7SAl6Uiyy?=
 =?us-ascii?Q?SAonsM60Me/m+nDlBaCElnYqcCbQy5gMFBBUaD8P01rSv0XD4NLKB9BC/yNh?=
 =?us-ascii?Q?fxIUWxdxdsbW3TuyxOYhMBKrqddWpwLEed9kiSrhH1u+12FSfQW+7U4HwIhI?=
 =?us-ascii?Q?/fSa/bzaak6rhcBTTeLxBSbcN57H+aB7YndAzOec?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa6f5491-eb67-4c2c-6a5c-08dd57a892f7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 03:32:49.2190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1gu48D8Xkt1oQiym/ArIhc9IDia1HbiFv1k+f705iM4PQ8njlUzEM/378T4g7WNR16aKv2ZH/qcEONBHZlvFZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7991

From: Dan Williams <dan.j.williams@intel.com>

The dcssblk driver has long needed special case supoprt to enable
limited dax operation, so called CONFIG_FS_DAX_LIMITED. This mode
works around the incomplete support for ZONE_DEVICE on s390 by forgoing
the ability of dax-mapped pages to support GUP.

Now, pending cleanups to fsdax that fix its reference counting [1] depend on
the ability of all dax drivers to supply ZONE_DEVICE pages.

To allow that work to move forward, dax support needs to be paused for
dcssblk until ZONE_DEVICE support arrives. That work has been known for
a few years [2], and the removal of "pte_devmap" requirements [3] makes the
conversion easier.

For now, place the support behind CONFIG_BROKEN, and remove PFN_SPECIAL
(dcssblk was the only user).

Link: http://lore.kernel.org/cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com [1]
Link: http://lore.kernel.org/20210820210318.187742e8@thinkpad/ [2]
Link: http://lore.kernel.org/4511465a4f8429f45e2ac70d2e65dc5e1df1eb47.1725941415.git-series.apopple@nvidia.com [3]
Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Tested-by: Alexander Gordeev <agordeev@linux.ibm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Alistair Popple <apopple@nvidia.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/filesystems/dax.rst |  1 -
 drivers/s390/block/Kconfig        | 12 ++++++++++--
 drivers/s390/block/dcssblk.c      | 27 +++++++++++++++++----------
 3 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/Documentation/filesystems/dax.rst b/Documentation/filesystems/dax.rst
index 719e90f..08dd5e2 100644
--- a/Documentation/filesystems/dax.rst
+++ b/Documentation/filesystems/dax.rst
@@ -207,7 +207,6 @@ implement direct_access.
 
 These block devices may be used for inspiration:
 - brd: RAM backed block device driver
-- dcssblk: s390 dcss block device driver
 - pmem: NVDIMM persistent memory driver
 
 
diff --git a/drivers/s390/block/Kconfig b/drivers/s390/block/Kconfig
index e3710a7..4bfe469 100644
--- a/drivers/s390/block/Kconfig
+++ b/drivers/s390/block/Kconfig
@@ -4,13 +4,21 @@ comment "S/390 block device drivers"
 
 config DCSSBLK
 	def_tristate m
-	select FS_DAX_LIMITED
-	select DAX
 	prompt "DCSSBLK support"
 	depends on S390 && BLOCK
 	help
 	  Support for dcss block device
 
+config DCSSBLK_DAX
+	def_bool y
+	depends on DCSSBLK
+	# requires S390 ZONE_DEVICE support
+	depends on BROKEN
+	select DAX
+	prompt "DCSSBLK DAX support"
+	help
+	  Enable DAX operation for the dcss block device
+
 config DASD
 	def_tristate y
 	prompt "Support for DASD devices"
diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index 0f14d27..7248e54 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -534,6 +534,21 @@ static const struct attribute_group *dcssblk_dev_attr_groups[] = {
 	NULL,
 };
 
+static int dcssblk_setup_dax(struct dcssblk_dev_info *dev_info)
+{
+	struct dax_device *dax_dev;
+
+	if (!IS_ENABLED(CONFIG_DCSSBLK_DAX))
+		return 0;
+
+	dax_dev = alloc_dax(dev_info, &dcssblk_dax_ops);
+	if (IS_ERR(dax_dev))
+		return PTR_ERR(dax_dev);
+	set_dax_synchronous(dax_dev);
+	dev_info->dax_dev = dax_dev;
+	return dax_add_host(dev_info->dax_dev, dev_info->gd);
+}
+
 /*
  * device attribute for adding devices
  */
@@ -547,7 +562,6 @@ dcssblk_add_store(struct device *dev, struct device_attribute *attr, const char 
 	int rc, i, j, num_of_segments;
 	struct dcssblk_dev_info *dev_info;
 	struct segment_info *seg_info, *temp;
-	struct dax_device *dax_dev;
 	char *local_buf;
 	unsigned long seg_byte_size;
 
@@ -674,14 +688,7 @@ dcssblk_add_store(struct device *dev, struct device_attribute *attr, const char 
 	if (rc)
 		goto put_dev;
 
-	dax_dev = alloc_dax(dev_info, &dcssblk_dax_ops);
-	if (IS_ERR(dax_dev)) {
-		rc = PTR_ERR(dax_dev);
-		goto put_dev;
-	}
-	set_dax_synchronous(dax_dev);
-	dev_info->dax_dev = dax_dev;
-	rc = dax_add_host(dev_info->dax_dev, dev_info->gd);
+	rc = dcssblk_setup_dax(dev_info);
 	if (rc)
 		goto out_dax;
 
@@ -917,7 +924,7 @@ __dcssblk_direct_access(struct dcssblk_dev_info *dev_info, pgoff_t pgoff,
 		*kaddr = __va(dev_info->start + offset);
 	if (pfn)
 		*pfn = __pfn_to_pfn_t(PFN_DOWN(dev_info->start + offset),
-				PFN_DEV|PFN_SPECIAL);
+				      PFN_DEV);
 
 	return (dev_sz - offset) / PAGE_SIZE;
 }
-- 
git-series 0.9.1

