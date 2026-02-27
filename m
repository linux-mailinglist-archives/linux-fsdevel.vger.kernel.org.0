Return-Path: <linux-fsdevel+bounces-78807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFVBJhMtomk/0gQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 00:47:31 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 058591BF28F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 00:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47F1530F7CF1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 23:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D853A7F63;
	Fri, 27 Feb 2026 23:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZFYwdLHi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012057.outbound.protection.outlook.com [52.101.53.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0752337BE75
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 23:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772235868; cv=fail; b=bPC8LWPlCxA9e0NXL7KnNcMWWJ6hGnRZOoEnRIExUAdbDLdczIcBJh53j2xKFXyMX0VqbJHb/erndT7j/34MLu4Ec1yPgWGVvcr1PEql+JPhLs3sd1V4/qaBIP2W9OIpbgjQKkfP2Ers0r2WUPWxiGj64spjyIQnjHJEGS3A2N8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772235868; c=relaxed/simple;
	bh=tjv/V0326Dd9qTIqsUXZPuVb24VdVPSWJJvl20KXqGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ecC885I36DkBWQVgbJAxaj1KD8ghdPLkiysO+Nu8/Vzatg6iHJu8Rya5ayDGrMbOX2zZaTBs3pUxtl9EjYj7Wld1FfkV2amtC+oGXvgv646ysTq1Z1UshqIPKDHstssvAeTNDq+4IU4QChsce2xtiEsSuxIZDZzYfGoLA4opv50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZFYwdLHi; arc=fail smtp.client-ip=52.101.53.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ELUlp2htQ42x20lttbKGC8PY6qSU+XbYqlAlMQBuHqf/YeyM9utPrzqbwB1/2oECCj2s8C5USgYstj6qqRS25r8G5zam71LV3J4zbK3Wt8llZdsHXtZXKO7E0cqj53gkKw0UADuSt+RH8o7TLY7QSW/gwGWB+pkM7u2KnuDxG/Og08AHN6VuutxZ5iIyEZpdocz7Q6T+CTuV9NA4f3F5zlTFElytFT++M+Kx4MwwUt/+d247dtj51c2rKUHskdYXWMtsIoolYxQeSw7/2BO/sVO8xR1wPit9Xg0Ex5cXOODht5b/P89SLhjHoxaS86V++zy6jcnrZn/11eO7NMWdLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2jthDnzJUoIOsvrBRpIwweVx3aNelNKRI6ebjHLxJE=;
 b=R1+ChZfwhYaaJA6wxOSBuf2Fx9jOkFWWaFuHcZePOWaGWuseudLwWUIHLsplo1QTQA10zIozB5X0u+raA6IDD1XYqPw4zuls6q7yv/3J3MWoJVzuq0pIzWGMPOaH7tOyvPzpiElwHLVdaSGVR7P8z7mZ2BFhY4TrFyWQouXbaKyU2WOSUIZt6ruLbFAzaUeLkTwIQQY6mvaWZQpGM2MF+xhSKCXXLgnpkPbJq0WzIc560Ms2P6YVdBXEm1NZ6R6M8KmoUl8+R7mLMOBEmxPqDKCX3vUyfqc+Wg+psEScxmZ7Dc5oySTpZREWL9evXibw5M3Xvjae0I7CTRbNBxxoAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2jthDnzJUoIOsvrBRpIwweVx3aNelNKRI6ebjHLxJE=;
 b=ZFYwdLHipVLUXZH2RQKffCCTRef9R7bst6/Ya642Pe21SmUcR1k1ERM1ud35IQnkRxqLGL358c0ThFciboDnQD0x6KmxI9VPHnJRRt4MQLtBr675ugmWJ/xZvYNaqpegkt/wR/QhB4zQL3aRbxE1zeEOjxlFGycWAuxhwvmd+Pp2nRoKxjdABa1YvxnAhaDXYO2QxPDPXFB21fvzbHbH69wwfbfk5ErMiGFR+bSvbWK5mM53CUn+VpSspuLQ2j6boSDlsPCsyX9dqcJVn1/jlpm2UAjdayrKkEqNqfynpuoJ1VJ2iMDF7NwgzUJLDx6SG3je4l1apkN4Hpi8LMkRHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 23:44:23 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 23:44:23 +0000
From: Zi Yan <ziy@nvidia.com>
To: Bas van Dijk <bas@dfinity.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, regressions@lists.linux.dev,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 Eero Kelly <eero.kelly@dfinity.org>,
 Andrew Battat <andrew.battat@dfinity.org>,
 Adam Bratschi-Kaye <adam.bratschikaye@dfinity.org>
Subject: Re: [External Sender] [REGRESSION] madvise(MADV_REMOVE) corrupts
 pages in THP-backed MAP_SHARED memfd (bisected to 7460b470a131)
Date: Fri, 27 Feb 2026 18:44:18 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <49DBB7AB-9BC7-4543-91DE-DC472D7A5B44@nvidia.com>
In-Reply-To: <CAKNNEtziooemhq3Yb8OpOjg4N0bV+Kc+1in0P7L1i_NBWS-q=A@mail.gmail.com>
References: <CAKNNEtw5_kZomhkugedKMPOG-sxs5Q5OLumWJdiWXv+C9Yct0w@mail.gmail.com>
 <CB5EF1C4-6285-4EEC-ABD0-A8870E7241E8@nvidia.com>
 <D4BD80F5-6CA2-42E1-B826-92EACD77A3F3@nvidia.com>
 <CAKNNEtwZzt3xWh_b1pn4X4FG+cq6FLOP5rR4+G=WUsjHsJRjaA@mail.gmail.com>
 <2EECA9B4-E1F0-42FF-9E61-3E4AC4B4DC13@nvidia.com>
 <CAKNNEtziooemhq3Yb8OpOjg4N0bV+Kc+1in0P7L1i_NBWS-q=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::7) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MN0PR12MB5953:EE_
X-MS-Office365-Filtering-Correlation-Id: 538d7503-a945-4ad6-b01f-08de765a22b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	qR81BLpThoBSuQQ5xQEH3YQkTFGJ+HLhURTf2pFDZNfTlWqR/edxrKidmHuW0yR1A2jFhkavea8EGXZLUFN2OQ91ECz8pbmZVaXeB/ametb8VMxd3S9y1u5fjUKoTHVeGndMP46uYdoztbSNKilZ24odqu95qxhBDY5Ip3qsVeRoEJ1S9Ip1Ubu5xyRAokXs3hvnsOPihsBbd+RTjfVIhJ22RRj6XOB/Rh1tlUolLrvyRkiotl5Vf6wDX4BmmxmrfYtB7hIZ/qNwyyuMmKITMj8hWpY07KaHq/wpi21fZaI8GSLaCZ4TF0TlOXjmlUX7R8sDdGaOL+CwMoVBbfcJ/SNpIMnjN9y9SQk8Fu85k06gb4iwhoK82mdkP0mdx7zbH03wN5zCJc+yfJG2BvX2Poj6j0jT1/si1/qb4sRQyfJjMs25Rz62BubfBZrOLzlZKBAJeQVwPNSVP3iaIvEtHnTKxEYYSKpJrQCG0+hVZ63ajrkd29xNbpZlOVdY/miBMOJYyuYm110Pr7muQ4NBTneGGcFeKB4nEi98I2PvhZIbuV7BV5pieATPhRFAzsrbOAbTtF0g+qohUqcHh6vnqVvobhS50TMcajajxi+E7qJLBdlaUdI7dAT6g3GiA58+md1NDHaXHeA7dVROOzStSGMbpnGqLHaT2XWKUyD1ufsn8MTUWnjhU5TJYUPDWY9sXT8btcm6hLYymVZYEfMFOPZG9dDwRRo4uo5zlzfi33lRDrcM6ohqzwIddurLxKdH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2dTMEtDanV0NTc1M3NQYlFHWWZyazgrNWF6SExyQlF3d0RKcmgwalUrMHJP?=
 =?utf-8?B?QU9jQUZhNDh6TVVPOGJ3UmZjZ1BSS3ZHVlB2M0t1NGRGMldMSEhEK2hqOXQz?=
 =?utf-8?B?UzJQdUtPRmdiWFlZVGYwVEpoWDlTLzZSM0pOM3Z0K28yTUROVHd1Z3RvdzRW?=
 =?utf-8?B?anpjNHhBTWFCV2pCNjg3aHQyWkdqYmtTZmx5UUE4UEpMcVJFbE4zMlA3K2hL?=
 =?utf-8?B?YURodHhnZUtSRUNUNGpsZUlPZXFyZXlKZWVLZzVDWGlXM08vZ0xxT2RUbkNG?=
 =?utf-8?B?bGhNKzN4RTJxYVh4ZXhrMGl6Ynk4bzNxYXpCVWpGakxMcWJGQndHayswOVZF?=
 =?utf-8?B?OSs5NlIyUTUrRG5nQTAzOFVpOGpzM0pqMjVQUWFFc1RVT3NKbytFL1dsdWF5?=
 =?utf-8?B?ZS96bm5xRW9WTkhvNnFtcHMrNEVpMVN1Nzlhc1Y2OE9qa3kwSGE2cmVwNVNX?=
 =?utf-8?B?ZGxFSXdPN1VjWWxyWXNIeTBWaEthRE1SZnJyaS9NRGNaM3Ntbmh2ci96c2Ry?=
 =?utf-8?B?M3BYOHNYNjJyZ1d4S3lYTlBzV0VtRUJZblFsZ2ZiZWNFTGU5bG03aEJaNVI2?=
 =?utf-8?B?WW94U2c1QVdjUDlPMzJaMmo1R1l0NTR5dWNEdFI4azY1ZlpJYURYelJza0Jy?=
 =?utf-8?B?OG1Dd1dxUFh0SkFNVkZKMjRRN0NhRUh4V3FMSHRCUW01QTZVaHZLOXRzcVYv?=
 =?utf-8?B?RHhjZ3ZScGN0Y2NuS3kyZmlHR3k4VkUxcTM3VnRZaUFDaFd4akM4WnhKWXNa?=
 =?utf-8?B?L0tZMnlQZ2g5bEk0YVRlYW9wSTc2OTRCQ29LTkhxeVI1eGQwa3YxUWpOUGFp?=
 =?utf-8?B?bUpqTzh2cHY0Sjg4Z1NwZ0Y1Zy9xNWo5KzJtSCtYRGUzQXp0YnlUZ3BjYVh1?=
 =?utf-8?B?ekpRZ0dtWklJUk9SM2xRWXhUcUJRWk83cFFDUzN5ZE8wOXJ3R1VPRmRlQkps?=
 =?utf-8?B?K3FoODcvSmEvVk1tVUJDaithcXJZMTBadFM3ZXJOR0ZGYVBPV2FiMGFydklI?=
 =?utf-8?B?NjZkRjJGTUZpdERGY0xoR2VZUEhJQzhkL2lxKy8xYmdqbWd6MHVkTWRDSmc3?=
 =?utf-8?B?TWdMRXpRbytWOUVkWmxCSkF6RDVBai9pQW1KL2RCR3ZYYjlOd1lGb3Q3bXdq?=
 =?utf-8?B?ZHdvZUxYalo2WENORnNvd2cxQ2JGMUYwNEtkRnBCdzlwYzhZckZxMHB4RzVk?=
 =?utf-8?B?WTVCbTJOcmU3VUpITWsrZElaV0xpcVZSQittbnZIcXhya29HSFp5OVF1SW5Q?=
 =?utf-8?B?UTgrbmZncDAxUmFuVWxtQngyVlArY3UxN01iTkV6OFUyZVJWbmN5akVuZDhK?=
 =?utf-8?B?a3BWUTJ3SVluV3lqNWFxUFA5Uzg3ZnZqNW05a1dRZlRqRk00eENuVTZYRzJ4?=
 =?utf-8?B?VDR0RUNKRXpYSW5KNHRGeklhamh0eFhlak1nZENQbWNBME9NZUZzZnNFdXRt?=
 =?utf-8?B?TEpzU0RMM3hlYjQ4SUw5MDAxdHR0YXUvaGM5ZEtwenhwUHVYeUV6SE9LK2hR?=
 =?utf-8?B?T3hCZndaZm5GbS85elljQ0lIU1kwd08vLzFYKy81R1hOZUY3cmYwV2pjOXZ5?=
 =?utf-8?B?bE9HSENrTUgydURMZ2h3K0llN1dzV0tFNG82YXdES2xoOXZET3ViRDBQa0Mv?=
 =?utf-8?B?U01haFZqTCtNVG5SNFI4YmZpbFpCeE10MGFBWXVnQVRWYXlOalJJeDA5V1VZ?=
 =?utf-8?B?YnkxbVJObjRTQTdjUGVjdi9MMUhTVGtKSkN2aEQ4QlRNZW1yQzFqaHhPUko3?=
 =?utf-8?B?OUZEcTN5amJsaWFneU1QaGdZQ1hia3dPYzBtb3FuVE1UVGcwNi8zNWNHN0Jl?=
 =?utf-8?B?WnFvZTcrVEQvbU5zZmtNcTlNWFliZlR6dXhvZUVoeUxKWGFHUi8zZ09DZlZB?=
 =?utf-8?B?VTRNUFFJeVlVU2tvSlp2TDNkN0pUSWRqSHptRGpqMkZHdThwcHBUWjZaamU5?=
 =?utf-8?B?YWptK3dpODkySzZjendMZFh3NnZVdkYzcTRxSUFHTVF0MUxJQTI2YWdXNlJ1?=
 =?utf-8?B?dCtkb3RoOGFoRm94ZDNGOEdlM29sdDVabUZtUVoyQnh3L1lOcEU3YnZRdkZY?=
 =?utf-8?B?SWxYTzNxZ2MrWFBpTGFQcnRNMGNzVG4zK1E3S2xqODhZaTlaWDdxTHA5eTc0?=
 =?utf-8?B?TWlwTmxzOEswOWJxNEw1YUpZRHA5cXVFMllyVXRXaG93TnZCZ3FGSXZYRVVT?=
 =?utf-8?B?OC9IM3ZyMy9sOCtwQnBYMWJjdnk5M01zZWk2bExsVTBXaWZXNTE1ZURRZThL?=
 =?utf-8?B?ai9Cb0Y0RWdBTng1dWJRenZRQlBXQ2YrMnNobi92Zjl6eVg2ZXZXU0FVRElq?=
 =?utf-8?Q?VyCdqaxTu2d+5XLGPH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 538d7503-a945-4ad6-b01f-08de765a22b7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 23:44:23.6079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Snw/274y3gbZtvXSziUHypEKT1+9nyRqhW0FPq70KT71wpYMtJ5/HSFAKptqpM+v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5953
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-78807-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ziy@nvidia.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 058591BF28F
X-Rspamd-Action: no action

On 27 Feb 2026, at 18:32, Bas van Dijk wrote:

> On Fri, Feb 27, 2026 at 8:29=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>>
>> On 26 Feb 2026, at 16:16, Bas van Dijk wrote:
>>
>>> On Thu, Feb 26, 2026 at 10:06=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>>>>
>>>> On 26 Feb 2026, at 15:49, Zi Yan wrote:
>>>>
>>>>> On 26 Feb 2026, at 15:34, Bas van Dijk wrote:
>>>>>
>>>>>> #regzbot introduced: 7460b470a131f985a70302a322617121efdd7caa
>>>>>>
>>>>>> Hey folks,
>>>>>>
>>>>>> We discovered madvise(MADV_REMOVE) on a 4KiB range within a
>>>>>> huge-page-backed MAP_SHARED memfd region corrupts nearby pages.
>>>>>>
>>>>>> Using the reproducible test in
>>>>>> https://github.com/dfinity/thp-madv-remove-test this was bisected to=
 the
>>>>>> first bad commit:
>>>>>>
>>>>>> commit 7460b470a131f985a70302a322617121efdd7caa
>>>>>> Author: Zi Yan <ziy@nvidia.com>
>>>>>> Date:   Fri Mar 7 12:40:00 2025 -0500
>>>>>>
>>>>>>     mm/truncate: use folio_split() in truncate operation
>>>>>>
>>>>>> v7.0-rc1 still has the regression.
>>>>>>
>>>>>> The repo mentioned above explains how to reproduce the regression an=
d
>>>>>> contains the necessary logs of failed runs on 7460b470a131 and v7.0-=
rc1, as
>>>>>> well as a successful run on its parent 4b94c18d1519.
>>>>>
>>>>> Thanks for the report. I will look into it.
>>>>
>>>> Can you also share your kernel config file? I just ran the reproducer =
and
>>>> could not trigger the corruption.
>>>
>>> Sure, I just ran `nix build
>>> .#linux_6_14_first_bad_7460b470a131.configfile -o kernel.config` which
>>> produced:
>>>
>>> https://github.com/dfinity/thp-madv-remove-test/blob/master/kernel.conf=
ig
>>
>> Hi Bas,
>>
>> Can you try the patch below?
>
> The test passes twice with the patch manually applied to the latest
> master (4d349ee5c778). Thank you!

Great. I will send a proper patch and cc stable to get it backported to all
stable kernels. Thank you for the report and testing.

>
> I had trouble applying the patch using `git am` to 7460b470a131 or
> 7.0-rc1 but this is the first time I've used `git am`, so I might have
> done something wrong.

My fix is based on linux-mm tree, so there could be some difference.

>
>> I was able to use your app to reproduce the issue after change my shmem =
THP config from never to always.
>
> Yes I had to write "advise" to
> /sys/kernel/mm/transparent_hugepage/shmem_enabled since it's set to
> "never" by default in NixOS. See:
> https://github.com/dfinity/thp-madv-remove-test/blob/d859609820113c690238=
48452bdba8b619d78a8a/flake.nix#L93
>
> It would be great if the patch could be backported to 6.17 used in
> Ubuntu 24.04 LTS since that's what we use for the Internet Computer
> and where our tests first started crashing.

The one below applies directly to 6.17.13, in case you want to use it
locally.

From 03b75f017ffe6cf556fefbd44f44655bf4a9af48 Mon Sep 17 00:00:00 2001
From: Zi Yan <ziy@nvidia.com>
Date: Fri, 27 Feb 2026 14:11:36 -0500
Subject: [PATCH] mm/huge_memory: fix folio_split() race condition with
 folio_try_get()

During a pagecache folio split, the values in the related xarray should not
be changed from the original folio at xarray split time until all
after-split folios are ready and stored in the xarray. Otherwise, a
parallel folio_try_get() can see stale values in the xarray and a stale
value can be a unfrozen after-split folio. This leads to a wrong folio
returned to userspace.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d4ca8cfd7f9d..3d5bf3bb8a3e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3628,6 +3628,7 @@ static int __split_unmapped_folio(struct folio *folio=
, int new_order,
 	const bool is_anon =3D folio_test_anon(folio);
 	int old_order =3D folio_order(folio);
 	int start_order =3D split_type =3D=3D SPLIT_TYPE_UNIFORM ? new_order : ol=
d_order - 1;
+	struct folio *origin_folio =3D folio;
 	int split_order;

 	/*
@@ -3653,7 +3654,13 @@ static int __split_unmapped_folio(struct folio *foli=
o, int new_order,
 				xas_split(xas, folio, old_order);
 			else {
 				xas_set_order(xas, folio->index, split_order);
-				xas_try_split(xas, folio, old_order);
+				/*
+				 * use the original folio, so that a parallel
+				 * folio_try_get() waits on it until xarray is
+				 * updated with after-split folios and
+				 * the original one is unfreezed
+				 */
+				xas_try_split(xas, origin_folio, old_order);
 				if (xas_error(xas))
 					return xas_error(xas);
 			}
--=20
2.51.0



Best Regards,
Yan, Zi

