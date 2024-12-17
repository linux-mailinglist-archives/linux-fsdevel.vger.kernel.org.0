Return-Path: <linux-fsdevel+bounces-37598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A61819F42A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 06:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E6DD7A7067
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 05:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555021F4263;
	Tue, 17 Dec 2024 05:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p8U5s9Q2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AF41F03FB;
	Tue, 17 Dec 2024 05:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734412547; cv=fail; b=c5xO3QBpodWfDeniF03HMFGaRUy6YLFsuY9fJM2oxyIkhxBAPg6aK86guAN5Jkx6NMGwaeHx5Yx4EG3gp2i3ocl+aLKdksu6gYtP+MdwnY+e/fSm8eGAISQ/bC8ZAZNueT/e2NHlA2Bj9+dZ6kmKA5zNHUKLTVJdRVhMhzvO7w8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734412547; c=relaxed/simple;
	bh=7tC62UaFFOND9jqZ/Kiel4AWqP41Dki7UpugUQ3Pudc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MBruhIcjA5yk4m6TuGlYPcVfhZAGuXxdif+86cnHoohKwTXVUlyFHgydxuQ9PMP4XpndaK/vu6jQIzN2Wpq6JtxUyXz0t9xrPThLMgkeJXsWC/yMSSoQSeiVGJklw6TWAFIaCTuG2NlGmSwySuOSqnpJRVdmKZfTupulTJ1DaTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p8U5s9Q2; arc=fail smtp.client-ip=40.107.237.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KPMezhShlyF6M5yQINdHseD+QIZyML2Ij9jTWPexM2ZzyKnQ1a6ruQX88luTf7sCuRVoalkWiIsOYv6A6vDnvHn8mp16dZvCPx0Yc4FBWzTNyQd7V2/BmNmGhiknlaPcRTlwx3yXvuBDu1CZgOQgFc3HPNaxjzWy//fl6GDxNbXmI/MjCijVVDFYL5ZWWSd2xqXV/qqqWpUKh6D74skLfGdJ/rw5wrD0VUGURNCFL+3LNXGw5PQYk/XeQuLIeM8F9/Az0EIrEzcu/MRGdXtX0JsFN4Xgpk9whNmJG5mi6EK/+NAb+D2MZI81Op8b5UBxBYQU3g0kAO1mQ5NFkYiYPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJ8eaYAFrzU68SAIlDA+gzvdBpEXGp0zYFwVqTek9Vk=;
 b=yk5dDGygce9amlG2MP+HguG13K+fyo0zsWzJqTwa8vOdzjA/syijvbAbRqBWb2YT9RYZhwkywqb/edS0qGf9msD2y5y3fqX+aMXwiVvMebX/VeZeykzE/NaOdeRDLzn7yR85zgp+srwPXNpi7tSM6d67QNt+S999sOrRueYk/ILQHXBRhfMk9Hs4U34Bw13LW6w4TXE6YAzc/FdpzPTUtLgYboKzzytXefL0X/CLhjqmm4GBx3DBbSnPlUBcNY58p2X3JmKvmC6fdYFsH4GRsOGVBeAdbEaZtrapxQXF43gpOB6OysraS6szYnVPiEYdJym1rgg5xtk9MSN2CiSw7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJ8eaYAFrzU68SAIlDA+gzvdBpEXGp0zYFwVqTek9Vk=;
 b=p8U5s9Q2d000HW7EDbxKUBJQtpv6HpJeD7hTP3gWdY3tyFu+ptIPY1xoDRNFfM0qtY6zuBIcJTEwOOjPzQ1yitbPDvIxuekB/KLdxXQffDI0hoBfkCjTKiBLxdBRhWuwpcwzq+56zqEau1urt9qa9+ZQdnIneiSDnuave8+wsY0iJJ60uNDRlkhUJ9effhFWODsPwBsBH2XDxLUv016/02wNxmXAsokJ+SmWKpp9XGU2Yl23nlEVE6dB5dXL0cMyN91AB2mZXIIUwr4oj0PAkP/BTlVbhsUMW1sxjWqlQJOY9dewryqvM4v1NtYrrv7WxXS6nhwA/BOwQLHrc3dMSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 DM6PR12MB4388.namprd12.prod.outlook.com (2603:10b6:5:2a9::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.22; Tue, 17 Dec 2024 05:15:43 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 05:15:43 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org,
	dan.j.williams@intel.com,
	linux-mm@kvack.org
Cc: Alistair Popple <apopple@nvidia.com>,
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
	david@fromorbit.com
Subject: [PATCH v4 24/25] mm: Remove devmap related functions and page table bits
Date: Tue, 17 Dec 2024 16:13:07 +1100
Message-ID: <910fbc82c517aed14ce2d80074ff603b1dc0d6ef.1734407924.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.18cbcff3638c6aacc051c44533ebc6c002bf2bd9.1734407924.git-series.apopple@nvidia.com>
References: <cover.18cbcff3638c6aacc051c44533ebc6c002bf2bd9.1734407924.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY8P282CA0002.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:29b::9) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|DM6PR12MB4388:EE_
X-MS-Office365-Filtering-Correlation-Id: 86fe9813-c1b3-442a-b057-08dd1e59daed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xl8I1yEFtbq3hHZgMUs6/6WqpDJB+q24e1ZZvjkPOtPQGjdIRgspnTfzTAI+?=
 =?us-ascii?Q?LakWS5pjEtw4ybNbCKyy+CEasZOBLBVJdxkpEOE2cXvpa3fHLsdtASlNVSd6?=
 =?us-ascii?Q?+9o5KUy57h21bt0OjjAJ+s1IEj4iu/BKIn8tWuYzaQjNVx1CYRTVIsg0NpF8?=
 =?us-ascii?Q?vsRUwdBBJf7zDge87OnuILRlavOJUAVemMEmC7dAXSnlcrlLXTOmLW7380mS?=
 =?us-ascii?Q?wFz+0OkCrO0RRqc0nGCYyn+z/9w1JN1cCHyMv3vzaVd5fVvw/DAqXe4c0Hl2?=
 =?us-ascii?Q?BFcIsmATj21kutewJPgtxHR/5OljmsuV+aSTToHqnX03aQyMv38WqXgMimI2?=
 =?us-ascii?Q?NbMsAiyvPTn309+uQIw9sN3OSyWjS1OqNZdJZ0sOOdEY6fKzVf3S+MSNFGo5?=
 =?us-ascii?Q?Vy0o1EefINxH+FY9InbS3mgy79hjcUlaMGG/qa+jdywtE4QsLiQxJy8RgNQE?=
 =?us-ascii?Q?PoJi0JcXlfbI3DTYmTH50hfaN6BzExeAnEoAIFER+TDB0JVWvJXYpdoFS9en?=
 =?us-ascii?Q?gGnXwl/2tUwTSmT0ugp6J6jjL7Q1NQTfBYC+163aj9ORxW+s8DxTt6WFEaVS?=
 =?us-ascii?Q?15dzWs0cBOp+AlMU/yUij4TxUrW1HBAw/mxJyZzXZ7hkTxk50KrFfcBAvrCi?=
 =?us-ascii?Q?NhhD201pBcBPYGdPw0gX4or3Mlg5hoERLyWxZ/Bio4+gx94csHwLfsPRXm0I?=
 =?us-ascii?Q?x6Fix3yCGFhRjbr5EwRB1syAo93fi+EkqLCwVTld6jiJsKcLOIFok+MVjj2J?=
 =?us-ascii?Q?iu20TrBvJljLa5hvlco12Lb1ApR+3kEMaXauTtKM3ErYcqWP2tNqFS5deSot?=
 =?us-ascii?Q?LjVDiVleIKZaZh1zIX/oOObJ3UGhu/SlDBFAerTYpy1VuIChb2bYBmuYtA4q?=
 =?us-ascii?Q?4huUuGqhld0/4klB/kav5F6OY8PcbOFZpd4gk4rBkhKG0kTAgU76THSFVo+0?=
 =?us-ascii?Q?kKNWhvNIEQCyjH/er+S1Yszh/7TyOPcCOGAf1GGlnFhxbS+7kaFNmd4WgevT?=
 =?us-ascii?Q?8xd9GyH8vJerGLvUsTNQ8UVaEfs1g1ngxQcRM8/D/eIloRpLlvSkw9V8ZZx+?=
 =?us-ascii?Q?JtJK3/ikM5UqabD6mPxu+8GVhdCl0+w5mExsZ+iF+VYHIlQvVoskoZsF6O6i?=
 =?us-ascii?Q?8lcxLIM/CkRNbNY9tyByzkJHz5wPlTKaBNQNbr5SlKCY/KB72sA2oQs6vN/v?=
 =?us-ascii?Q?k1GSr4QxzUJngaIBkeY1/3mp1O2VN1Spkez92XgBsCxImZoTr3kqx4RvoufG?=
 =?us-ascii?Q?chxdytgXuiliaz0bdU/h46pJgyMj7HNFu8aH5KYHMK5uP5FRUzW3AbHs16in?=
 =?us-ascii?Q?D6BZfMc7xEYp3DlP4L+1tIWroBKaCkJ5Vzs9lM7ZHc3zJuHsTLQIfn2CbLns?=
 =?us-ascii?Q?z3Qfk+wOYSbXpUQI7/TKXYucTWZ5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Iaf98bv4Nm3Vzw/Q4zw9jA/Dsgu3PIF8LHcXt/uxSbTPjnqX3HWaK4SvWXAa?=
 =?us-ascii?Q?CUCCXcHtTkSnDxnNcn9D1er0wBBmpTBGdI9UBUvhFNSyzt49I/qPqa/LaBYj?=
 =?us-ascii?Q?+4WAawBEYQPt82MQ4bTKwkEUfWrFelvNqjnBrLGvK4mW4U5J4DXof4rz58CB?=
 =?us-ascii?Q?jtAD2d5bN5/DRa3jUlOksWPPL0Yz+AoY6HjzRbfFPP/z2PzvAcbHmSULKwlI?=
 =?us-ascii?Q?9r2rlJw7aP+onvAddY86Dh5azP7yjccV0kKIcoqOcgVYVdwPC/xaG4dHXkvG?=
 =?us-ascii?Q?OFVoeWDTPPmXqaEIb9qNmV9tNVUw2dwWpYSsUlU1pTbZ8jHLMXAXgFESfDUU?=
 =?us-ascii?Q?HcNDu34Olimb9WZD+ya6sOgogbvb16ykGz2WJU8HLG3WCtderitRkJ+14Mg9?=
 =?us-ascii?Q?64r7qXbhlmkJZc3bt4Qy03OL9tderfmkfWEwbfkU7kEkGvWloAK9yXHwpYVQ?=
 =?us-ascii?Q?muvgPwJyR2/JK/IVJyCGVBb8D55pYnrBJVE6mLpK5SixO+ZuTBVMz3aSWQ68?=
 =?us-ascii?Q?KAnHrihvpsycDlsBPa+/nMr92m9MFVFoDg8Jtt+21p+W94LVwB23RHIbbAde?=
 =?us-ascii?Q?HVC3jN6GxI0x3C0Bgl7cYk5afBT3rr6G9XBFBtqRcE7STHMCvBbx6KWM9YVD?=
 =?us-ascii?Q?YusqTyLS3nHBF2WAKaRJE1yFyoPXNUg8WZt5kfIvgCV8N9KP1/yPACu1uSaz?=
 =?us-ascii?Q?y6L1Z5RWrbG1jM2fkX4crC+KGj5FCwSK01o7cNJ/pWcj/JTRfpZvaIbFRdEn?=
 =?us-ascii?Q?VnF2ihtl5YtwMtPIQZIMX31zlbVinBjmGwcyZo7SMUIvxLDMku3XoOwi91a4?=
 =?us-ascii?Q?o/YMvpF3kvLwnDu5DpMZ/3lR89sBO11RLkjK4cL2ei99Pf3btgujHrrCoU0a?=
 =?us-ascii?Q?p57QYNn1hBxF4RidKHwaKGV1VSv8yzo7lr7j45UzjpEX2cczldWlloP5vd7u?=
 =?us-ascii?Q?RMsoXh3uS8B6UgyxnYnVhEXusgXKAA2pG1tCXZ8hhC8KMCOvhumpKgpiw6oS?=
 =?us-ascii?Q?XhuY897AFRRc0RZkJWDkLmb+WdgNFeFDwLXpNVcBPM+2JesWdLksxyGYdU51?=
 =?us-ascii?Q?73vMH9NbP55VQq7zEonoccBH4amx1TUzkBzEygk9GFVA1ZksJY1aO+nxhPe7?=
 =?us-ascii?Q?2pVmqPZVyElDHp6byM3FDD2gj3daONMcc80EN3BTcA+KOsM/G+R4v/ToDYX4?=
 =?us-ascii?Q?cCAQB759aV7H4LW6lCnZecpNcFIxfle16fbPvXxLyGQuUQ+vSCOR0DVGtfTH?=
 =?us-ascii?Q?ml8PshAp4DH/EH650L8M6+ugAD8ndGgnN8oXDBVXrtPd9cne+OSL94chTvyi?=
 =?us-ascii?Q?a9w5CCgSkMRhAJYIW7Z95bO1rWp7D0TSNV3DppBBh3TW18lDA5/SFAROWKeE?=
 =?us-ascii?Q?gULcfWAyaCOsS2qISwqHyWQZucR1fY02br91jdsIvakxAXC+HSlleH9eNmio?=
 =?us-ascii?Q?NPe+ItbgqU/RENiLUTNKxfnVmCmUdP5F54pNoUXPhDBkvk2XBMuYPFpxAdS3?=
 =?us-ascii?Q?LBnlrBmg18XqkHGJ8UyM/E62f82XcZeJKTtPPmETu6u4WC5g8y/BiIn3gBmr?=
 =?us-ascii?Q?Vlnfxr006QG6ofeWX0GZSEtrb8ZxMA31/GcUj3Lk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86fe9813-c1b3-442a-b057-08dd1e59daed
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 05:15:43.3494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jrh6Iyk9P1xLXVh6ObNgkGbEDHxbECjBQieWwTdIcmIJ0wU5mgmiaDYYNefMGvTb1V5pL9VHOGMT3Ub5ZrRYmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4388

Now that DAX and all other reference counts to ZONE_DEVICE pages are
managed normally there is no need for the special devmap PTE/PMD/PUD
page table bits. So drop all references to these, freeing up a
software defined page table bit on architectures supporting it.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Acked-by: Will Deacon <will@kernel.org> # arm64
---
 Documentation/mm/arch_pgtable_helpers.rst     |  6 +--
 arch/arm64/Kconfig                            |  1 +-
 arch/arm64/include/asm/pgtable-prot.h         |  1 +-
 arch/arm64/include/asm/pgtable.h              | 24 +--------
 arch/powerpc/Kconfig                          |  1 +-
 arch/powerpc/include/asm/book3s/64/hash-4k.h  |  6 +--
 arch/powerpc/include/asm/book3s/64/hash-64k.h |  7 +--
 arch/powerpc/include/asm/book3s/64/pgtable.h  | 52 +------------------
 arch/powerpc/include/asm/book3s/64/radix.h    | 14 +-----
 arch/x86/Kconfig                              |  1 +-
 arch/x86/include/asm/pgtable.h                | 51 +-----------------
 arch/x86/include/asm/pgtable_types.h          |  5 +--
 include/linux/mm.h                            |  7 +--
 include/linux/pfn_t.h                         | 20 +-------
 include/linux/pgtable.h                       | 19 +------
 mm/Kconfig                                    |  4 +-
 mm/debug_vm_pgtable.c                         | 59 +--------------------
 mm/hmm.c                                      |  3 +-
 18 files changed, 11 insertions(+), 270 deletions(-)

diff --git a/Documentation/mm/arch_pgtable_helpers.rst b/Documentation/mm/arch_pgtable_helpers.rst
index af24516..c88c7fa 100644
--- a/Documentation/mm/arch_pgtable_helpers.rst
+++ b/Documentation/mm/arch_pgtable_helpers.rst
@@ -30,8 +30,6 @@ PTE Page Table Helpers
 +---------------------------+--------------------------------------------------+
 | pte_protnone              | Tests a PROT_NONE PTE                            |
 +---------------------------+--------------------------------------------------+
-| pte_devmap                | Tests a ZONE_DEVICE mapped PTE                   |
-+---------------------------+--------------------------------------------------+
 | pte_soft_dirty            | Tests a soft dirty PTE                           |
 +---------------------------+--------------------------------------------------+
 | pte_swp_soft_dirty        | Tests a soft dirty swapped PTE                   |
@@ -104,8 +102,6 @@ PMD Page Table Helpers
 +---------------------------+--------------------------------------------------+
 | pmd_protnone              | Tests a PROT_NONE PMD                            |
 +---------------------------+--------------------------------------------------+
-| pmd_devmap                | Tests a ZONE_DEVICE mapped PMD                   |
-+---------------------------+--------------------------------------------------+
 | pmd_soft_dirty            | Tests a soft dirty PMD                           |
 +---------------------------+--------------------------------------------------+
 | pmd_swp_soft_dirty        | Tests a soft dirty swapped PMD                   |
@@ -177,8 +173,6 @@ PUD Page Table Helpers
 +---------------------------+--------------------------------------------------+
 | pud_write                 | Tests a writable PUD                             |
 +---------------------------+--------------------------------------------------+
-| pud_devmap                | Tests a ZONE_DEVICE mapped PUD                   |
-+---------------------------+--------------------------------------------------+
 | pud_mkyoung               | Creates a young PUD                              |
 +---------------------------+--------------------------------------------------+
 | pud_mkold                 | Creates an old PUD                               |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 39310a4..81855d1 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -41,7 +41,6 @@ config ARM64
 	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_NONLEAF_PMD_YOUNG if ARM64_HAFT
-	select ARCH_HAS_PTE_DEVMAP
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_HW_PTE_YOUNG
 	select ARCH_HAS_SETUP_DMA_OPS
diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index 9f9cf13..49b51df 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -17,7 +17,6 @@
 #define PTE_SWP_EXCLUSIVE	(_AT(pteval_t, 1) << 2)	 /* only for swp ptes */
 #define PTE_DIRTY		(_AT(pteval_t, 1) << 55)
 #define PTE_SPECIAL		(_AT(pteval_t, 1) << 56)
-#define PTE_DEVMAP		(_AT(pteval_t, 1) << 57)
 
 /*
  * PTE_PRESENT_INVALID=1 & PTE_VALID=0 indicates that the pte's fields should be
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index f8dac66..ea34e51 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -108,7 +108,6 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
 #define pte_user(pte)		(!!(pte_val(pte) & PTE_USER))
 #define pte_user_exec(pte)	(!(pte_val(pte) & PTE_UXN))
 #define pte_cont(pte)		(!!(pte_val(pte) & PTE_CONT))
-#define pte_devmap(pte)		(!!(pte_val(pte) & PTE_DEVMAP))
 #define pte_tagged(pte)		((pte_val(pte) & PTE_ATTRINDX_MASK) == \
 				 PTE_ATTRINDX(MT_NORMAL_TAGGED))
 
@@ -290,11 +289,6 @@ static inline pmd_t pmd_mkcont(pmd_t pmd)
 	return __pmd(pmd_val(pmd) | PMD_SECT_CONT);
 }
 
-static inline pte_t pte_mkdevmap(pte_t pte)
-{
-	return set_pte_bit(pte, __pgprot(PTE_DEVMAP | PTE_SPECIAL));
-}
-
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
 static inline int pte_uffd_wp(pte_t pte)
 {
@@ -587,14 +581,6 @@ static inline int pmd_trans_huge(pmd_t pmd)
 
 #define pmd_mkhuge(pmd)		(__pmd(pmd_val(pmd) & ~PMD_TABLE_BIT))
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-#define pmd_devmap(pmd)		pte_devmap(pmd_pte(pmd))
-#endif
-static inline pmd_t pmd_mkdevmap(pmd_t pmd)
-{
-	return pte_pmd(set_pte_bit(pmd_pte(pmd), __pgprot(PTE_DEVMAP)));
-}
-
 #ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
 #define pmd_special(pte)	(!!((pmd_val(pte) & PTE_SPECIAL)))
 static inline pmd_t pmd_mkspecial(pmd_t pmd)
@@ -1195,16 +1181,6 @@ static inline int pmdp_set_access_flags(struct vm_area_struct *vma,
 	return __ptep_set_access_flags(vma, address, (pte_t *)pmdp,
 							pmd_pte(entry), dirty);
 }
-
-static inline int pud_devmap(pud_t pud)
-{
-	return 0;
-}
-
-static inline int pgd_devmap(pgd_t pgd)
-{
-	return 0;
-}
 #endif
 
 #ifdef CONFIG_PAGE_TABLE_CHECK
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index da0ac66..3e85f89 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -147,7 +147,6 @@ config PPC
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PHYS_TO_DMA
 	select ARCH_HAS_PMEM_API
-	select ARCH_HAS_PTE_DEVMAP		if PPC_BOOK3S_64
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_SCALED_CPUTIME		if VIRT_CPU_ACCOUNTING_NATIVE && PPC_BOOK3S_64
 	select ARCH_HAS_SET_MEMORY
diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
index c3efaca..b0546d3 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
@@ -160,12 +160,6 @@ extern pmd_t hash__pmdp_huge_get_and_clear(struct mm_struct *mm,
 extern int hash__has_transparent_hugepage(void);
 #endif
 
-static inline pmd_t hash__pmd_mkdevmap(pmd_t pmd)
-{
-	BUG();
-	return pmd;
-}
-
 #endif /* !__ASSEMBLY__ */
 
 #endif /* _ASM_POWERPC_BOOK3S_64_HASH_4K_H */
diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index 0bf6fd0..0fb5b7d 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -259,7 +259,7 @@ static inline void mark_hpte_slot_valid(unsigned char *hpte_slot_array,
  */
 static inline int hash__pmd_trans_huge(pmd_t pmd)
 {
-	return !!((pmd_val(pmd) & (_PAGE_PTE | H_PAGE_THP_HUGE | _PAGE_DEVMAP)) ==
+	return !!((pmd_val(pmd) & (_PAGE_PTE | H_PAGE_THP_HUGE)) ==
 		  (_PAGE_PTE | H_PAGE_THP_HUGE));
 }
 
@@ -281,11 +281,6 @@ extern pmd_t hash__pmdp_huge_get_and_clear(struct mm_struct *mm,
 extern int hash__has_transparent_hugepage(void);
 #endif /*  CONFIG_TRANSPARENT_HUGEPAGE */
 
-static inline pmd_t hash__pmd_mkdevmap(pmd_t pmd)
-{
-	return __pmd(pmd_val(pmd) | (_PAGE_PTE | H_PAGE_THP_HUGE | _PAGE_DEVMAP));
-}
-
 #endif	/* __ASSEMBLY__ */
 
 #endif /* _ASM_POWERPC_BOOK3S_64_HASH_64K_H */
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 6d98e6f..bda0649 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -88,7 +88,6 @@
 
 #define _PAGE_SOFT_DIRTY	_RPAGE_SW3 /* software: software dirty tracking */
 #define _PAGE_SPECIAL		_RPAGE_SW2 /* software: special page */
-#define _PAGE_DEVMAP		_RPAGE_SW1 /* software: ZONE_DEVICE page */
 
 /*
  * Drivers request for cache inhibited pte mapping using _PAGE_NO_CACHE
@@ -109,7 +108,7 @@
  */
 #define _HPAGE_CHG_MASK (PTE_RPN_MASK | _PAGE_HPTEFLAGS | _PAGE_DIRTY | \
 			 _PAGE_ACCESSED | H_PAGE_THP_HUGE | _PAGE_PTE | \
-			 _PAGE_SOFT_DIRTY | _PAGE_DEVMAP)
+			 _PAGE_SOFT_DIRTY)
 /*
  * user access blocked by key
  */
@@ -123,7 +122,7 @@
  */
 #define _PAGE_CHG_MASK	(PTE_RPN_MASK | _PAGE_HPTEFLAGS | _PAGE_DIRTY | \
 			 _PAGE_ACCESSED | _PAGE_SPECIAL | _PAGE_PTE |	\
-			 _PAGE_SOFT_DIRTY | _PAGE_DEVMAP)
+			 _PAGE_SOFT_DIRTY)
 
 /*
  * We define 2 sets of base prot bits, one for basic pages (ie,
@@ -609,24 +608,6 @@ static inline pte_t pte_mkhuge(pte_t pte)
 	return pte;
 }
 
-static inline pte_t pte_mkdevmap(pte_t pte)
-{
-	return __pte_raw(pte_raw(pte) | cpu_to_be64(_PAGE_SPECIAL | _PAGE_DEVMAP));
-}
-
-/*
- * This is potentially called with a pmd as the argument, in which case it's not
- * safe to check _PAGE_DEVMAP unless we also confirm that _PAGE_PTE is set.
- * That's because the bit we use for _PAGE_DEVMAP is not reserved for software
- * use in page directory entries (ie. non-ptes).
- */
-static inline int pte_devmap(pte_t pte)
-{
-	__be64 mask = cpu_to_be64(_PAGE_DEVMAP | _PAGE_PTE);
-
-	return (pte_raw(pte) & mask) == mask;
-}
-
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	/* FIXME!! check whether this need to be a conditional */
@@ -1380,35 +1361,6 @@ static inline bool arch_needs_pgtable_deposit(void)
 }
 extern void serialize_against_pte_lookup(struct mm_struct *mm);
 
-
-static inline pmd_t pmd_mkdevmap(pmd_t pmd)
-{
-	if (radix_enabled())
-		return radix__pmd_mkdevmap(pmd);
-	return hash__pmd_mkdevmap(pmd);
-}
-
-static inline pud_t pud_mkdevmap(pud_t pud)
-{
-	if (radix_enabled())
-		return radix__pud_mkdevmap(pud);
-	BUG();
-	return pud;
-}
-
-static inline int pmd_devmap(pmd_t pmd)
-{
-	return pte_devmap(pmd_pte(pmd));
-}
-
-static inline int pud_devmap(pud_t pud)
-{
-	return pte_devmap(pud_pte(pud));
-}
-
-static inline int pgd_devmap(pgd_t pgd)
-{
-	return 0;
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index 8f55ff7..df23a82 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -264,7 +264,7 @@ static inline int radix__p4d_bad(p4d_t p4d)
 
 static inline int radix__pmd_trans_huge(pmd_t pmd)
 {
-	return (pmd_val(pmd) & (_PAGE_PTE | _PAGE_DEVMAP)) == _PAGE_PTE;
+	return (pmd_val(pmd) & _PAGE_PTE) == _PAGE_PTE;
 }
 
 static inline pmd_t radix__pmd_mkhuge(pmd_t pmd)
@@ -274,7 +274,7 @@ static inline pmd_t radix__pmd_mkhuge(pmd_t pmd)
 
 static inline int radix__pud_trans_huge(pud_t pud)
 {
-	return (pud_val(pud) & (_PAGE_PTE | _PAGE_DEVMAP)) == _PAGE_PTE;
+	return (pud_val(pud) & _PAGE_PTE) == _PAGE_PTE;
 }
 
 static inline pud_t radix__pud_mkhuge(pud_t pud)
@@ -315,16 +315,6 @@ static inline int radix__has_transparent_pud_hugepage(void)
 }
 #endif
 
-static inline pmd_t radix__pmd_mkdevmap(pmd_t pmd)
-{
-	return __pmd(pmd_val(pmd) | (_PAGE_PTE | _PAGE_DEVMAP));
-}
-
-static inline pud_t radix__pud_mkdevmap(pud_t pud)
-{
-	return __pud(pud_val(pud) | (_PAGE_PTE | _PAGE_DEVMAP));
-}
-
 struct vmem_altmap;
 struct dev_pagemap;
 extern int __meminit radix__vmemmap_create_mapping(unsigned long start,
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 77f001c..acac373 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -97,7 +97,6 @@ config X86
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PMEM_API		if X86_64
 	select ARCH_HAS_PREEMPT_LAZY
-	select ARCH_HAS_PTE_DEVMAP		if X86_64
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_HW_PTE_YOUNG
 	select ARCH_HAS_NONLEAF_PMD_YOUNG	if PGTABLE_LEVELS > 2
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 593f10a..77705be 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -308,16 +308,15 @@ static inline bool pmd_leaf(pmd_t pte)
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-/* NOTE: when predicate huge page, consider also pmd_devmap, or use pmd_leaf */
 static inline int pmd_trans_huge(pmd_t pmd)
 {
-	return (pmd_val(pmd) & (_PAGE_PSE|_PAGE_DEVMAP)) == _PAGE_PSE;
+	return (pmd_val(pmd) & _PAGE_PSE) == _PAGE_PSE;
 }
 
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
 static inline int pud_trans_huge(pud_t pud)
 {
-	return (pud_val(pud) & (_PAGE_PSE|_PAGE_DEVMAP)) == _PAGE_PSE;
+	return (pud_val(pud) & _PAGE_PSE) == _PAGE_PSE;
 }
 #endif
 
@@ -327,24 +326,6 @@ static inline int has_transparent_hugepage(void)
 	return boot_cpu_has(X86_FEATURE_PSE);
 }
 
-#ifdef CONFIG_ARCH_HAS_PTE_DEVMAP
-static inline int pmd_devmap(pmd_t pmd)
-{
-	return !!(pmd_val(pmd) & _PAGE_DEVMAP);
-}
-
-#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
-static inline int pud_devmap(pud_t pud)
-{
-	return !!(pud_val(pud) & _PAGE_DEVMAP);
-}
-#else
-static inline int pud_devmap(pud_t pud)
-{
-	return 0;
-}
-#endif
-
 #ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
 static inline bool pmd_special(pmd_t pmd)
 {
@@ -368,12 +349,6 @@ static inline pud_t pud_mkspecial(pud_t pud)
 	return pud_set_flags(pud, _PAGE_SPECIAL);
 }
 #endif	/* CONFIG_ARCH_SUPPORTS_PUD_PFNMAP */
-
-static inline int pgd_devmap(pgd_t pgd)
-{
-	return 0;
-}
-#endif
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 static inline pte_t pte_set_flags(pte_t pte, pteval_t set)
@@ -534,11 +509,6 @@ static inline pte_t pte_mkspecial(pte_t pte)
 	return pte_set_flags(pte, _PAGE_SPECIAL);
 }
 
-static inline pte_t pte_mkdevmap(pte_t pte)
-{
-	return pte_set_flags(pte, _PAGE_SPECIAL|_PAGE_DEVMAP);
-}
-
 /* See comments above mksaveddirty_shift() */
 static inline pmd_t pmd_mksaveddirty(pmd_t pmd)
 {
@@ -610,11 +580,6 @@ static inline pmd_t pmd_mkwrite_shstk(pmd_t pmd)
 	return pmd_set_flags(pmd, _PAGE_DIRTY);
 }
 
-static inline pmd_t pmd_mkdevmap(pmd_t pmd)
-{
-	return pmd_set_flags(pmd, _PAGE_DEVMAP);
-}
-
 static inline pmd_t pmd_mkhuge(pmd_t pmd)
 {
 	return pmd_set_flags(pmd, _PAGE_PSE);
@@ -680,11 +645,6 @@ static inline pud_t pud_mkdirty(pud_t pud)
 	return pud_mksaveddirty(pud);
 }
 
-static inline pud_t pud_mkdevmap(pud_t pud)
-{
-	return pud_set_flags(pud, _PAGE_DEVMAP);
-}
-
 static inline pud_t pud_mkhuge(pud_t pud)
 {
 	return pud_set_flags(pud, _PAGE_PSE);
@@ -1012,13 +972,6 @@ static inline int pte_present(pte_t a)
 	return pte_flags(a) & (_PAGE_PRESENT | _PAGE_PROTNONE);
 }
 
-#ifdef CONFIG_ARCH_HAS_PTE_DEVMAP
-static inline int pte_devmap(pte_t a)
-{
-	return (pte_flags(a) & _PAGE_DEVMAP) == _PAGE_DEVMAP;
-}
-#endif
-
 #define pte_accessible pte_accessible
 static inline bool pte_accessible(struct mm_struct *mm, pte_t a)
 {
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 4b80453..e4c7b51 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -33,7 +33,6 @@
 #define _PAGE_BIT_CPA_TEST	_PAGE_BIT_SOFTW1
 #define _PAGE_BIT_UFFD_WP	_PAGE_BIT_SOFTW2 /* userfaultfd wrprotected */
 #define _PAGE_BIT_SOFT_DIRTY	_PAGE_BIT_SOFTW3 /* software dirty tracking */
-#define _PAGE_BIT_DEVMAP	_PAGE_BIT_SOFTW4
 
 #ifdef CONFIG_X86_64
 #define _PAGE_BIT_SAVED_DIRTY	_PAGE_BIT_SOFTW5 /* Saved Dirty bit (leaf) */
@@ -119,11 +118,9 @@
 
 #if defined(CONFIG_X86_64) || defined(CONFIG_X86_PAE)
 #define _PAGE_NX	(_AT(pteval_t, 1) << _PAGE_BIT_NX)
-#define _PAGE_DEVMAP	(_AT(u64, 1) << _PAGE_BIT_DEVMAP)
 #define _PAGE_SOFTW4	(_AT(pteval_t, 1) << _PAGE_BIT_SOFTW4)
 #else
 #define _PAGE_NX	(_AT(pteval_t, 0))
-#define _PAGE_DEVMAP	(_AT(pteval_t, 0))
 #define _PAGE_SOFTW4	(_AT(pteval_t, 0))
 #endif
 
@@ -152,7 +149,7 @@
 #define _COMMON_PAGE_CHG_MASK	(PTE_PFN_MASK | _PAGE_PCD | _PAGE_PWT |	\
 				 _PAGE_SPECIAL | _PAGE_ACCESSED |	\
 				 _PAGE_DIRTY_BITS | _PAGE_SOFT_DIRTY |	\
-				 _PAGE_DEVMAP | _PAGE_CC | _PAGE_UFFD_WP)
+				 _PAGE_CC | _PAGE_UFFD_WP)
 #define _PAGE_CHG_MASK	(_COMMON_PAGE_CHG_MASK | _PAGE_PAT)
 #define _HPAGE_CHG_MASK (_COMMON_PAGE_CHG_MASK | _PAGE_PSE | _PAGE_PAT_LARGE)
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index a734278..23c4e9b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2769,13 +2769,6 @@ static inline pud_t pud_mkspecial(pud_t pud)
 }
 #endif	/* CONFIG_ARCH_SUPPORTS_PUD_PFNMAP */
 
-#ifndef CONFIG_ARCH_HAS_PTE_DEVMAP
-static inline int pte_devmap(pte_t pte)
-{
-	return 0;
-}
-#endif
-
 extern pte_t *__get_locked_pte(struct mm_struct *mm, unsigned long addr,
 			       spinlock_t **ptl);
 static inline pte_t *get_locked_pte(struct mm_struct *mm, unsigned long addr,
diff --git a/include/linux/pfn_t.h b/include/linux/pfn_t.h
index 2d91482..0100ad8 100644
--- a/include/linux/pfn_t.h
+++ b/include/linux/pfn_t.h
@@ -97,26 +97,6 @@ static inline pud_t pfn_t_pud(pfn_t pfn, pgprot_t pgprot)
 #endif
 #endif
 
-#ifdef CONFIG_ARCH_HAS_PTE_DEVMAP
-static inline bool pfn_t_devmap(pfn_t pfn)
-{
-	const u64 flags = PFN_DEV|PFN_MAP;
-
-	return (pfn.val & flags) == flags;
-}
-#else
-static inline bool pfn_t_devmap(pfn_t pfn)
-{
-	return false;
-}
-pte_t pte_mkdevmap(pte_t pte);
-pmd_t pmd_mkdevmap(pmd_t pmd);
-#if defined(CONFIG_TRANSPARENT_HUGEPAGE) && \
-	defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
-pud_t pud_mkdevmap(pud_t pud);
-#endif
-#endif /* CONFIG_ARCH_HAS_PTE_DEVMAP */
-
 #ifdef CONFIG_ARCH_HAS_PTE_SPECIAL
 static inline bool pfn_t_special(pfn_t pfn)
 {
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 00e4a06..1c377de 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1606,21 +1606,6 @@ static inline int pud_write(pud_t pud)
 }
 #endif /* pud_write */
 
-#if !defined(CONFIG_ARCH_HAS_PTE_DEVMAP) || !defined(CONFIG_TRANSPARENT_HUGEPAGE)
-static inline int pmd_devmap(pmd_t pmd)
-{
-	return 0;
-}
-static inline int pud_devmap(pud_t pud)
-{
-	return 0;
-}
-static inline int pgd_devmap(pgd_t pgd)
-{
-	return 0;
-}
-#endif
-
 #if !defined(CONFIG_TRANSPARENT_HUGEPAGE) || \
 	!defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
 static inline int pud_trans_huge(pud_t pud)
@@ -1875,8 +1860,8 @@ typedef unsigned int pgtbl_mod_mask;
  * - It should contain a huge PFN, which points to a huge page larger than
  *   PAGE_SIZE of the platform.  The PFN format isn't important here.
  *
- * - It should cover all kinds of huge mappings (e.g., pXd_trans_huge(),
- *   pXd_devmap(), or hugetlb mappings).
+ * - It should cover all kinds of huge mappings (i.e. pXd_trans_huge()
+ *   or hugetlb mappings).
  */
 #ifndef pgd_leaf
 #define pgd_leaf(x)	false
diff --git a/mm/Kconfig b/mm/Kconfig
index 7949ab1..e1d0981 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1044,9 +1044,6 @@ config ARCH_HAS_CURRENT_STACK_POINTER
 	  register alias named "current_stack_pointer", this config can be
 	  selected.
 
-config ARCH_HAS_PTE_DEVMAP
-	bool
-
 config ARCH_HAS_ZONE_DMA_SET
 	bool
 
@@ -1064,7 +1061,6 @@ config ZONE_DEVICE
 	depends on MEMORY_HOTPLUG
 	depends on MEMORY_HOTREMOVE
 	depends on SPARSEMEM_VMEMMAP
-	depends on ARCH_HAS_PTE_DEVMAP
 	select XARRAY_MULTI
 
 	help
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index bc748f7..cf5ff92 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -348,12 +348,6 @@ static void __init pud_advanced_tests(struct pgtable_debug_args *args)
 	vaddr &= HPAGE_PUD_MASK;
 
 	pud = pfn_pud(args->pud_pfn, args->page_prot);
-	/*
-	 * Some architectures have debug checks to make sure
-	 * huge pud mapping are only found with devmap entries
-	 * For now test with only devmap entries.
-	 */
-	pud = pud_mkdevmap(pud);
 	set_pud_at(args->mm, vaddr, args->pudp, pud);
 	flush_dcache_page(page);
 	pudp_set_wrprotect(args->mm, vaddr, args->pudp);
@@ -366,7 +360,6 @@ static void __init pud_advanced_tests(struct pgtable_debug_args *args)
 	WARN_ON(!pud_none(pud));
 #endif /* __PAGETABLE_PMD_FOLDED */
 	pud = pfn_pud(args->pud_pfn, args->page_prot);
-	pud = pud_mkdevmap(pud);
 	pud = pud_wrprotect(pud);
 	pud = pud_mkclean(pud);
 	set_pud_at(args->mm, vaddr, args->pudp, pud);
@@ -384,7 +377,6 @@ static void __init pud_advanced_tests(struct pgtable_debug_args *args)
 #endif /* __PAGETABLE_PMD_FOLDED */
 
 	pud = pfn_pud(args->pud_pfn, args->page_prot);
-	pud = pud_mkdevmap(pud);
 	pud = pud_mkyoung(pud);
 	set_pud_at(args->mm, vaddr, args->pudp, pud);
 	flush_dcache_page(page);
@@ -693,53 +685,6 @@ static void __init pmd_protnone_tests(struct pgtable_debug_args *args)
 static void __init pmd_protnone_tests(struct pgtable_debug_args *args) { }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
-#ifdef CONFIG_ARCH_HAS_PTE_DEVMAP
-static void __init pte_devmap_tests(struct pgtable_debug_args *args)
-{
-	pte_t pte = pfn_pte(args->fixed_pte_pfn, args->page_prot);
-
-	pr_debug("Validating PTE devmap\n");
-	WARN_ON(!pte_devmap(pte_mkdevmap(pte)));
-}
-
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-static void __init pmd_devmap_tests(struct pgtable_debug_args *args)
-{
-	pmd_t pmd;
-
-	if (!has_transparent_hugepage())
-		return;
-
-	pr_debug("Validating PMD devmap\n");
-	pmd = pfn_pmd(args->fixed_pmd_pfn, args->page_prot);
-	WARN_ON(!pmd_devmap(pmd_mkdevmap(pmd)));
-}
-
-#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
-static void __init pud_devmap_tests(struct pgtable_debug_args *args)
-{
-	pud_t pud;
-
-	if (!has_transparent_pud_hugepage())
-		return;
-
-	pr_debug("Validating PUD devmap\n");
-	pud = pfn_pud(args->fixed_pud_pfn, args->page_prot);
-	WARN_ON(!pud_devmap(pud_mkdevmap(pud)));
-}
-#else  /* !CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
-static void __init pud_devmap_tests(struct pgtable_debug_args *args) { }
-#endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
-#else  /* CONFIG_TRANSPARENT_HUGEPAGE */
-static void __init pmd_devmap_tests(struct pgtable_debug_args *args) { }
-static void __init pud_devmap_tests(struct pgtable_debug_args *args) { }
-#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
-#else
-static void __init pte_devmap_tests(struct pgtable_debug_args *args) { }
-static void __init pmd_devmap_tests(struct pgtable_debug_args *args) { }
-static void __init pud_devmap_tests(struct pgtable_debug_args *args) { }
-#endif /* CONFIG_ARCH_HAS_PTE_DEVMAP */
-
 static void __init pte_soft_dirty_tests(struct pgtable_debug_args *args)
 {
 	pte_t pte = pfn_pte(args->fixed_pte_pfn, args->page_prot);
@@ -1341,10 +1286,6 @@ static int __init debug_vm_pgtable(void)
 	pte_protnone_tests(&args);
 	pmd_protnone_tests(&args);
 
-	pte_devmap_tests(&args);
-	pmd_devmap_tests(&args);
-	pud_devmap_tests(&args);
-
 	pte_soft_dirty_tests(&args);
 	pmd_soft_dirty_tests(&args);
 	pte_swap_soft_dirty_tests(&args);
diff --git a/mm/hmm.c b/mm/hmm.c
index 285578e..2a12879 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -395,8 +395,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 	return 0;
 }
 
-#if defined(CONFIG_ARCH_HAS_PTE_DEVMAP) && \
-    defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
+#if defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
 static inline unsigned long pud_to_hmm_pfn_flags(struct hmm_range *range,
 						 pud_t pud)
 {
-- 
git-series 0.9.1

