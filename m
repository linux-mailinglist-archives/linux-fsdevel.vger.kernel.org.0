Return-Path: <linux-fsdevel+bounces-23284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A02892A421
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 15:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDBD71F21BE9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 13:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB36A13DDB0;
	Mon,  8 Jul 2024 13:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ucyyUUtl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7118E13C81E;
	Mon,  8 Jul 2024 13:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720446803; cv=fail; b=p37X09Lw0j5XqN1NrgY06pTmJ2xzJpuDIhnX8vOasiJ1l1qreiJpYtUJ/4sgWV3MBDwxkdDIU9VcMaQzyFdQC2p1u71EUBakn2SvPNIZ8cBEXppS5B75kJPDfIrdvFym2OPf0B6FDLQPHSQPWgARLnkg5FsH/KPsm3KeF5g1FwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720446803; c=relaxed/simple;
	bh=aeso8fVescQZ0MZc69JVSe2jc6gZjLsl5tBD4b/rHCs=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:MIME-Version; b=TL8UHGvvVmM3d/pkJYLUYh4b0wHeOJQyyT6OMneuTC9/DI4KAM6rkKutqDwUlWCWvaon2btMtroXqL/r7sbVGIlyEnmx21vbc2THTexWpvYW8YF1vfVxFjvMQ8aWBK61EEQTyeAJyk9b3iPxMFFfgAhb7+0u8ee3cpTPF45MtFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ucyyUUtl; arc=fail smtp.client-ip=40.107.220.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m1CLPItcjrVaUXDXWcyzzA28+qeeZVhAQcEkEmrTfatuQLJvp3tmr6oZfgy9DWJmZWnmxt8kXzjaE7sdlCK0xn8znRb/4MrYLzwc3wnftPMkcikstIAAXd6Mf3cIRQmBtoqKChdwJXzTJMjM0Yi3ap/UbVD0JIiDYRjyQTeuJvlOb5Tml99Po58gUj1Zr//0Q4PkxyfK7/HFzKvfPMeJLauoDXK7o7+yXhdK1NXapErxF9K//AyfjuQizPXi0m1aybjUU+7f41aXw6rOk9GlLhgdPRqLq2IOfulIiBV/aI8rtOk8lnK2nq395qt4hWMMY9OFaMujIsIj9XmU0O9VaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5Fm1hTuap6dn+x0mX9+FN1IOX0Ip3UF2kAF7OkrAeE=;
 b=XOCyzZ4eZy//YjOWhqvk2WJu6gB2VHXopnDko1A2tYBfZ/Tg1LmZmIvl8kTH7giJTlHfAhB3EfiRNErwQ4m1a+AIgHYKYq8g7NFc2gC8ocX2jzSnzyxo1J3jJzgZngOzYrzKbx+KrgKsVkhR7TXw3BQA0C9UGMyqFvmVcxu3ixGPoRTurBlyY84o4yNdDRW35Pma4Kh+91vt1wrdYYrYgq6OMDEcIFaQak27PVibYAQcMwVp0LeEcqnrEMEdLOsoC4XDMGuNMOT+OJIFfbSAxygvnDI7zTa3wqY4e2vxbXNBYbYier7glHaOKPJgJqn142D2MJL9/iPXXshF0Gmq1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5Fm1hTuap6dn+x0mX9+FN1IOX0Ip3UF2kAF7OkrAeE=;
 b=ucyyUUtl6uM5p0oBVJmn+PyuXg30uszYpXJ+TGkBOIzNgYrmt1P/qSdDi5E0Idvzv5vzp8e5pMzaAhATfK1wEpIOoykY1ntx/rcXiHEkG1an+NOI/O66C/tkPuD4yZVPPR0Tc1nlRx0vyZkdyNl6mpn9udfKevck+6GQq90D/dkCqYC3cmcV/fsYG1t3H0MRSlVQZiLgZ0I0Np1y2ummobCDibMstVwPnOA0iqW+yk5CXnF2OJ4aT5yzuH8N4EcJFERmcFGpTWHneQxKL9gZfhPF/ZKZXziKCLMiOeXLbjvTKu/p0YLGJouIq0FmjxKSVZkSJIdTentlMK9fIPNg/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5730.namprd12.prod.outlook.com (2603:10b6:208:385::9)
 by SJ2PR12MB9241.namprd12.prod.outlook.com (2603:10b6:a03:57b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 13:53:17 +0000
Received: from BL1PR12MB5730.namprd12.prod.outlook.com
 ([fe80::afc:1e4b:7af6:115c]) by BL1PR12MB5730.namprd12.prod.outlook.com
 ([fe80::afc:1e4b:7af6:115c%5]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 13:53:17 +0000
Content-Type: multipart/signed;
 boundary=af546dc83fec9019c7e7b57f9bd41bf174c52a17d3058ccb45ac78148542;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Mon, 08 Jul 2024 09:53:03 -0400
Message-Id: <D2K7HHAVJDR9.8PR2HQZ00FXA@nvidia.com>
Subject: Re: [PATCH v9 04/10] mm: split a folio in minimum folio order
 chunks
Cc: <yang@os.amperecomputing.com>, <linux-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>, <john.g.garry@oracle.com>,
 <linux-fsdevel@vger.kernel.org>, <hare@suse.de>, <p.raghav@samsung.com>,
 <mcgrof@kernel.org>, <gost.dev@samsung.com>, <cl@os.amperecomputing.com>,
 <linux-xfs@vger.kernel.org>, <hch@lst.de>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 <david@fromorbit.com>, <willy@infradead.org>, <chandan.babu@oracle.com>,
 <djwong@kernel.org>, <brauner@kernel.org>, <akpm@linux-foundation.org>
From: "Zi Yan" <ziy@nvidia.com>
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.17.0
References: <20240704112320.82104-1-kernel@pankajraghav.com>
 <20240704112320.82104-5-kernel@pankajraghav.com>
In-Reply-To: <20240704112320.82104-5-kernel@pankajraghav.com>
X-ClientProxiedBy: BL1PR13CA0375.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::20) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5730:EE_|SJ2PR12MB9241:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e0eb9fb-a200-46a9-b2ca-08dc9f554ab9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eDNPek1lMW9YSDRNL3BiVGNrT0EySDI0TnhGV2F1eTZNL2xMS2lmYnFhYmJi?=
 =?utf-8?B?bytWYUhvaHVlYjlORVk0aG0yaDFhN0pMcEcvbWEyR2hTTzA5S3V0RC9Yb2xv?=
 =?utf-8?B?MkQxWHdJMXJRdmNxenBsQXIvVUkva3MrMlpmMGJDaGhaMGplQkRUbUFCdFc1?=
 =?utf-8?B?TURmOFJqSkMvTTd1Z3FMcTZDSVkzZWorMlpISlV5NWZmMlFNNmdDbnJDbWRD?=
 =?utf-8?B?MUtPYmdVNzRIZDBmL0FVa25BaEpvd2puR2ppVm9SbHJCRkhJb1Q5K09mdVp6?=
 =?utf-8?B?bWMzcVdqMHlUMnZja2kycUtJRlZ3VUFXRi9ZVmZsVmN4T0dPclJDNlVVT2JR?=
 =?utf-8?B?VDFaTU94TGdkUm5BN3FQR1ZVaEdmNVplMlFlZk9ZelIzVkhGdVpsTHhoZnFw?=
 =?utf-8?B?M3g4dHphZ3plUGpxNWxRSTUxcGVDaSt3ZUhucExjVnlsY2FPWkIrcVVsdUhJ?=
 =?utf-8?B?NlBwTjFJRDh0ZGJkcGhCY3BoOFdHUGRtYmRKbVBRM21VdHNLeURDOG1GS0Z2?=
 =?utf-8?B?R2x0YnhJT3RsbW5yL25YY1ljcWJnZHBuTGllRUM2Y0R2Vm93bmM4SzB5Tzl5?=
 =?utf-8?B?VHk0MHluTk9KL3Q1MXRLOWVmaWhTV2ordytNQXpxSW5uSk1BMGpUZW1ZNTFM?=
 =?utf-8?B?OU4rQzB6ZDdWZ3U3bFRPWEp6ZkFxdGs4NlZVWktqKy9JS0ZwcW9GejFRckcx?=
 =?utf-8?B?dGovMENlSTRBSGdxNi9iV25pMkdtK2hhNFlxRStNc1ZLN0NJMUlkYjN2U3Vj?=
 =?utf-8?B?RGVUNEExWTJhemxrSDN5cG9sVG5TVzMrb2NreDU3ZHFMeFNIRmVTZUsvK0pP?=
 =?utf-8?B?SUxIMzJOZlZoSDBWTnRVSEpJZHdPOGtzajZoVE9KMmFGTExNNTUySE8yTEJP?=
 =?utf-8?B?dGpaYjdqSlBQSDdGK0ZqRGsvbFdzZUFlNEdSSXl0aUNEUlEzODJmNHowSmR0?=
 =?utf-8?B?Mmt2emRyczIwSlEwZzd4Qmt2QVVic1lTS0hpVXJGM2JnNldmYll1Z2lETnBz?=
 =?utf-8?B?KzRMVVNmdkZvUVMwOWpuTDUyNFZTVzJ6MXBjVk9yVThxbVZ3enAweXRwVjBH?=
 =?utf-8?B?ZnpYWUxtVjNuQS9EMmdpSmJzY041L1ZEZTFCL3M1Tzgvamp5VFFONFJ5T0pW?=
 =?utf-8?B?QUFJZVNHU01OSlByK2dPZi9lMVRpU3dzaGJxZDVyUEVab1MrYkNpMFVKL09x?=
 =?utf-8?B?Y0V6TU5OZFphVjdxZUx6VmdUeE1YZFJaRmdJd25VWlRzUEdlbjFESVRQcTZk?=
 =?utf-8?B?YlZ1ejVNQndGQjQ2dXBFRnI3Y0tHOHNOTGVJQ2d6TFRLYmpuTm1NckhCUlRB?=
 =?utf-8?B?UUp1UTUwc3JkZDRuU0x0UjVpMnFwYXl1UGRha0g0d2x4WTZjTExJZmlVS0Yx?=
 =?utf-8?B?clpMNVhaZkt4Zk91QXYrRjd2cHFxUFg2UEhlU3N0TEZncUZsODNwSnRsQVps?=
 =?utf-8?B?eElCMStJMFBpS1o1bnRLMklDU2cvdC9iWlAxRjFrLzd4SStmTlFVZXI3SmxO?=
 =?utf-8?B?c3ViWGNxY1N3UzZGQlJTakVnWThJN2RNQndTeWo3SE9nWVFRaDFublJuMUt4?=
 =?utf-8?B?Q0U4c0xBazI2eWJXN3FzYmQrM2xoNURPWG5CRjlMamJNa0ExTW5Nd0N1di9P?=
 =?utf-8?B?dTJFQzhPa0M3bVQ2OVdIRjlOblVubFBsdGpQNnloY2RzOUg1aGoyK1hNUWNw?=
 =?utf-8?B?SXA0RzdlM00xTFVscG8rUG4rdWZTWkxJaXJqLzhXbUs4UUdSZEhldDJzWmts?=
 =?utf-8?B?cTRmOHdReVlqT0lUZjBmeVhZeTVEY2RIdDV3ZkRwa0VrZ1ZtM01aZ1REUW9q?=
 =?utf-8?B?bmlvR0wrNXJSWnc2N01DUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5730.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnhXbXJ2R2hlVC9MMlFLWkJWakEvTVVnbmQyZThBY01HOVh2Z2hUQ0xpSzBG?=
 =?utf-8?B?NG50S2ViNDBGVEpBaWpRZDNNWmdUcE80ejc2M2R1VDRXUGFCTXcvYXJTQ3F5?=
 =?utf-8?B?aU5MUjVJM2duaUovUXVQbXMyQnVQNjMzcmZ4ei8zMU9XMVJCRnZadnhZYkI3?=
 =?utf-8?B?OXlJTmJ4RjNZUWdUZFMzSlZZd3owSE0vc3haVDBIeHVSditCSUQ5VW1aQU5z?=
 =?utf-8?B?L0E3emV2blkxRjFYMFBLREhxdFo1bm1WaDJwb1BGTDBWMkV1S1g5MHdHMU9V?=
 =?utf-8?B?b0syM1Fhd0UyVzk3RHFyNHJzUmNueXpTNDliOU4wTERRSjljb2s0VHl0VENO?=
 =?utf-8?B?SDlZYTZRbjZUNGpwcWZWNlQ4L3VjdlA1MkhtbllXVWFpSHJ1bUFUVktkd0dX?=
 =?utf-8?B?WE0zTGduQmRLbGpSUUk1b2p5NkNGT3MyRyt3TGdvVVdrS1N1UXlFdThtSmtq?=
 =?utf-8?B?OFE0bTZycFkrV215L3NEVUFLcjRvTWVtdzlMZk9OMktjSXlIdDVkdk5uVDFo?=
 =?utf-8?B?UTVid0xPWC9ZaStJWm1wemFObUJnYVhDbWdFNThZR0lyNXBQQ2FPMEhiZ0JQ?=
 =?utf-8?B?bXNNYnNoaGQ2T2JBbDNUUjh2MEhlT3gxZWpRK3B0alI1VlZ0dG5BWFVnMnVm?=
 =?utf-8?B?cDhKTDhrcVdOR1RhOStkRVEwMnJXZnZ1MExnYXlHZ21WckpneGtjSjZtVzNh?=
 =?utf-8?B?MjAzY0thYm1peTB4cmNJMWdLY3pjYlRPaml1MmZIZ0twTmc5NHlvN3p4ZHhY?=
 =?utf-8?B?S0NtbEtvaFJYSVZyTXhDeDJCTStmd2ZKaWNlcWFaTVByZUhiTWtJQTRMaXJv?=
 =?utf-8?B?Zm9SSDhCcE1EdlMrRUFKdEs5Nms5WXpycEZWY1AyYytmZEhPcHl3bmlGMUhm?=
 =?utf-8?B?amUvczh5WUZSQ0h0TFRxZmloZzFGdlIxMmpYdTFGYWllQnhSd0kzTXdtdVlX?=
 =?utf-8?B?bkJOMUNNVVJUTXRQZ0VPRGhUQkVYU1k1R1JVMWhmRm5qYThRcmd4Q3ZjSDJ3?=
 =?utf-8?B?WTJZOEVubjhteWlQMjNBeFFsUm1ZczR2Y2YzdlgyVUNtZm9YSDgxTTRkZTNU?=
 =?utf-8?B?ZWpxelhadGhlYWtlVFJkMXFTSDh4Y08xNHR2aVpBTm5weWFVZWlQWWl6MnVr?=
 =?utf-8?B?Z20zNzgzQzR1R3l3bXBpT0F5Q3ppREFndlR1clB0YWxNMCtUeE9INER5S2Vu?=
 =?utf-8?B?RGI0WWF0TTVCck8wTXN5UDVuOGpBMmlVUnZZWVc1NUhiQXFoaWNHYUJEZ0RO?=
 =?utf-8?B?YUJNT0Y1NGVRc2wwL0d4Z24yNnVLNmRYdmNXNUU4MDFOajNoY1oxT2dkOWVQ?=
 =?utf-8?B?RXpUYzVXT0NrYlJiKzl2RUlsaURGS3dUK1RGa1premhFa0FVTUF1M25NeUxD?=
 =?utf-8?B?UjkrZGQvZUpyZGd1Wm16WTB5SnVxWEZXbFdXRDJZcWZMOVpGNm1TOHRVc2ZY?=
 =?utf-8?B?YUVTanN1bEV6OE9Pem10T3ZEQ0ZxRDV5TW9lUE1ja0JIRVBaQjY2K29ER0pu?=
 =?utf-8?B?S2xlUmowRWNIY1FISmFVczA2Sml5YjA0WHJQL0tkSEZqbHEvSVdMcnl6eFd5?=
 =?utf-8?B?c25FNkJaczZ2NkhZcVhQRW1LbVdqK2Ywc3pGV1J4NEEwOXFwNk9uREErMnhH?=
 =?utf-8?B?NGFzWGxRMU9TVFY0aU1JYmxrcjFYZmNrQXZnUWxhSVJpOU4wdGtJQWFUTmtS?=
 =?utf-8?B?WEJoN21lTjJpMkIvbkNGQktTZWNQNW9MMXhORlhHWTV3YmhiR1M1Z1EwK2Ft?=
 =?utf-8?B?Rm5VMGoyVnhyS0MyMXE4b1NZcjV1cTRRQW1ZaVVhaUpRNVRxUXJ3TVRjRkxu?=
 =?utf-8?B?bHhGcFVzRm9rZ05IaHRQRmxjYkJrSDhVK3hORFliZHp4SUg2OHl4Vk11Rm1G?=
 =?utf-8?B?cEhrak9iYll2K3QwWmdqMjVEZTQ0eERtd0RBejJGeGRXWUoybTRqQ2RadXY3?=
 =?utf-8?B?Vm5STTRkTGZIVGkzQmRiM2ZmNFo5Yml5a29qenFaYmdRTnNydWlXcTBDQkR2?=
 =?utf-8?B?TkNjeGlpZ3FEVXZVTHNVMWZSMCs3WmNiajMwQ2R0eVZ1TjdBUzVnOVVUK3FV?=
 =?utf-8?B?NHlOdks0aGpncVI1M0xjVG9wRC94YWZ1cXRqL1VSWEcwOHdsNkQwRnh5TUZl?=
 =?utf-8?Q?8ah8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e0eb9fb-a200-46a9-b2ca-08dc9f554ab9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 13:53:11.9018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aeb4Fn0V4Cvag6UAi0o0Pv+fPdenF/nAt8EBIvHDo39ibNYGHkICZCLLoKkTxDV2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9241

--af546dc83fec9019c7e7b57f9bd41bf174c52a17d3058ccb45ac78148542
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Thu Jul 4, 2024 at 7:23 AM EDT, Pankaj Raghav (Samsung) wrote:
> From: Luis Chamberlain <mcgrof@kernel.org>
>
> split_folio() and split_folio_to_list() assume order 0, to support
> minorder for non-anonymous folios, we must expand these to check the
> folio mapping order and use that.
>
> Set new_order to be at least minimum folio order if it is set in
> split_huge_page_to_list() so that we can maintain minimum folio order
> requirement in the page cache.
>
> Update the debugfs write files used for testing to ensure the order
> is respected as well. We simply enforce the min order when a file
> mapping is used.
>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> ---
>  include/linux/huge_mm.h | 14 ++++++++---
>  mm/huge_memory.c        | 55 ++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 61 insertions(+), 8 deletions(-)

<snip>
>
> @@ -3265,6 +3277,21 @@ int split_huge_page_to_list_to_order(struct page *=
page, struct list_head *list,
>  	return ret;
>  }
> =20
> +int split_folio_to_list(struct folio *folio, struct list_head *list)
> +{
> +	unsigned int min_order =3D 0;
> +
> +	if (!folio_test_anon(folio)) {
> +		if (!folio->mapping && folio_test_pmd_mappable(folio)) {
> +			count_vm_event(THP_SPLIT_PAGE_FAILED);
> +			return -EBUSY;
> +		}

This should be

		if (!folio->mapping) {
			if (folio_test_pmd_mappable(folio))
				count_vm_event(THP_SPLIT_PAGE_FAILED);
			return -EBUSY;
		}

Otherwise, a non PMD mappable folio with no mapping will fall through
and cause NULL pointer dereference in mapping_min_folio_order().

> +		min_order =3D mapping_min_folio_order(folio->mapping);
> +	}
> +
> +	return split_huge_page_to_list_to_order(&folio->page, list, min_order);
> +}
> +
>  void __folio_undo_large_rmappable(struct folio *folio)
>  {
>  	struct deferred_split *ds_queue;


--=20
Best Regards,
Yan, Zi


--af546dc83fec9019c7e7b57f9bd41bf174c52a17d3058ccb45ac78148542
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAABCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmaL70EPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUXcMP/iccsjWcIvFQ9jDlM8/d+4avm3j5WJ6niHNw
4FgZnZk4/UOc92X4CMDrbuarZduoppsaSUulm+yp4CvL9s8i7bRct2mW74Uhyaws
XE0hcwIfYa/zcxMHFAvePBVhto9gi1BsZwpcQ/baob+T8a6WYs6d44kl9Gq60Dgd
XqNZ1z0EKbOw10x8o+/vQwu0MOtQRaNHsld2qBP+Y41HvM0x6oC5asDrCqxTmdbr
EUvp8tB4zVrDGt2m1dq/73aUpFIysvsGTE2nArAHEDYgY/KklQUMSSBRZlq5ne5M
0COAVMVIT/EEljf4AQLf4C4/I6//Sc9vAlryU53iEoMLllKDTq/43KHoUp/HVrLf
rOXp7UcW9KnIAF5+lkhUtu+U+Vv+/3+FfyBUwvoy7UvFtdAmk0w8i851Tz+9SedX
qPHmF8D+sA1/NnUqVIPAL30607rjt/MSMkyeX6XjwmHAFQpr/owzd7enYTLyojDF
V2UTTzf38BDd/YebEbk8zxSTVkuIwx/iMxj7LYIiPndiwuNuL/k0xUvhAWdwnzkD
QkEjV4oY2o4PSjHmpZcLKOYqWOMgQdgGUnc5e51tXp+76NW0jeDPXDilaHwmslre
cOYUgDsIvVmVVhwOrQLdpM+lJaHYJEGqKAsssipZCFugwnVNyl2uo4NWTfiB12bL
pv7L1SkB
=Gq8t
-----END PGP SIGNATURE-----

--af546dc83fec9019c7e7b57f9bd41bf174c52a17d3058ccb45ac78148542--

