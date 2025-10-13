Return-Path: <linux-fsdevel+bounces-64014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C016EBD5D39
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 21:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 45B06351858
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 19:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4908A2D540D;
	Mon, 13 Oct 2025 19:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="uxnyDS5g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C357929B8C7
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 19:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760382050; cv=fail; b=mwwB4uIwbe9I5VfBQjYJDSX3oG2MtfR/pSw8JJRyHPJ2yWmploDWSnBbAYqoFpT2uxLjiBBWkVeaZzbVfwxPq9V+KF58V0egeqGlPcq5vLsuHodbCRfkiqZr2evXHvRtx6JfjhyhPoj3aZqpes9MULO2amd9V6bWoR/PnjVj7lI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760382050; c=relaxed/simple;
	bh=ZeHblBT2tqwhlIvF+wstUGB7bZK4mInPS51QzpdL+6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=I37QdU21UNKiI3Rc1oBfZg+GINcVz9xw52eH6VC1JthbgEJBMP9vD83Lay4oBLx9LX/82xNmnp18bM+El+yQDd78WGpzaqto7WGqsegdPmLMSICo9oR5utBhAsH589bBi5ERWqNl2Q0G5PRY3I5Bc+sygpRqD9eK6XhsxLYJO+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=uxnyDS5g; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022092.outbound.protection.outlook.com [52.101.43.92]) by mx-outbound46-233.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 13 Oct 2025 19:00:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rez2ZdHplzYRdGMErjteKSYMhXojIIkm+wgU574xUuvsYKQyi/4BlmQFOYh69tRSlKgQDUFK3P/niTUNikI5lVxTZvcUld23oGr0o9lMxrinlQDZesuL8h47T/Y3nUWwQm2aDjtj6J6teFOMiFmAp4Nfzq6mTx6G5QnYTd79q6/Cl6HtcBFBYSZp3BSc5CPR30vmpK+LoKGwZmRgFevc0XXo+O/djAcKCPTkpswtUgsKkzF9+kjzri681e26aie4YnFaNL8qtO54Lat14zNSsacUuJDLCCKzjk3scNLh/w0vuEtHakpoDbqYS0LYAFcyC+PM+ewqjaiFG9WkesCXSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wvewn4ErwTnqK6xIJA1lc6oMvzkWmPi9vFnNraB/Gdc=;
 b=MW7mlvrOsM9PEjF8BdMycaKM2l2AIxnQsIGf6EDAdvBahGYwOGcE1Q/KQdAP7CtZvQxz7hrze3YviEOsLR6jh4Zba5YFXvXTDud5ae7Cdqva72Nz+l2P3cmWw1v1rzuDJZKZOW2iKEZF6s1UpesUIWJ+e/muoGnki6I5d4X9lJGhMKMZ8KhrQ28yF2J+GeNVmrwCs6srk16weZgDUodR6f2O/DeUIgysWCxUe/H4ki98P83fRodG3PC4GhhoVN6yloxnlnzXXz3mRjvIaTgVdaN9aVbBA+DoRiso+ePm/AvZ6Tr2DAxQh3GlpkDgLyOTammpNdKC5S8wStz03moZPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=arm.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wvewn4ErwTnqK6xIJA1lc6oMvzkWmPi9vFnNraB/Gdc=;
 b=uxnyDS5g0ED8UoIC1mfP5rjf3lWNMJQ8Z2kJgiZ/91DUS9XqZXldlAMLDpcJFO+AfB4gRwz97PcHjDcnjKYF6NhcwKMh2Ie0+S3MoTOhJR5SD02go9hChRKuvxRXUrvyeY/UL2a9PRLKzX4hac7jGr3kIIy+mKWG3pbFJvW3dkY=
Received: from SN7PR04CA0049.namprd04.prod.outlook.com (2603:10b6:806:120::24)
 by IA0PPFD9AAC434D.namprd19.prod.outlook.com (2603:10b6:20f:fc04::cd3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 17:27:46 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:120:cafe::8b) by SN7PR04CA0049.outlook.office365.com
 (2603:10b6:806:120::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Mon,
 13 Oct 2025 17:27:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Mon, 13 Oct 2025 17:27:45 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id C9D1963;
	Mon, 13 Oct 2025 17:27:44 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Mon, 13 Oct 2025 19:27:39 +0200
Subject: [PATCH] fuse: Wake requests on the same cpu
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-wake-same-cpu-v1-1-45d8059adde7@ddn.com>
X-B4-Tracking: v=1; b=H4sIAIs27WgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA0Nj3fLE7FTd4sTcVN3kglLdJPOUlCSDJAMzC4tUJaCegqLUtMwKsHn
 RsbW1ANiAv9tfAAAA
X-Change-ID: 20251013-wake-same-cpu-b7ddb0b0688e
To: Miklos Szeredi <miklos@szeredi.hu>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, Luis Henriques <luis@igalia.com>, 
 linux-fsdevel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760376464; l=5188;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=ZeHblBT2tqwhlIvF+wstUGB7bZK4mInPS51QzpdL+6s=;
 b=7Ifyn9Y2nWt6nRmaTMEr0+OARthE2nHeRUZAslOrYqExkPgp4xYX20LH+08DfVxZ2ooVjrayX
 uiy9z9D8e3eCE701W6plVXmpMLduNCFTB0p/jvVX4kkHlF8vgZhXkU9
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|IA0PPFD9AAC434D:EE_
X-MS-Office365-Filtering-Correlation-Id: ffa90774-02a7-4f5c-6a3e-08de0a7dd2db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|19092799006|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWtRbWI5Q2JWZ1g5T1ZQVzJveG91ZlYrdlpkd05lMklHcjFDR29qT3ZseGZm?=
 =?utf-8?B?TXlDRVlGUElPRHE5WW04UFVUUzZPaG5DK1YvY3Fla1dvdzlKdUJVUlF0bzJp?=
 =?utf-8?B?LzlWbCs3bmVETEpubzhLQ0VqVlRMc1gvZUlvb1lkeElaZWlrSUxGbG5FbGFv?=
 =?utf-8?B?Qk1mVG96SkdNMCtwTG00U3A1MTBuWFRpc0xmQnd3V05IRG5zTFlSUExsanh3?=
 =?utf-8?B?Rjl0YlRnQlQyWXJTQ0ZESWMzNnp1dG0rc1puMlNXQ2tuZVorejY3R1B4a3p6?=
 =?utf-8?B?WDA2SW5iRG95U1ZLMXU0ck1xUXEwWllJV2pzMlFxc3oxSFl4MjRKVzNYdWNV?=
 =?utf-8?B?NWhIanUvMkJ0ZkUzbWt0ZjdEYU92amtPZU1oekZ1WTZJTVh2a3pGVTdGRjhX?=
 =?utf-8?B?UGVRekk4WFlGU3RrTTJwTDlUSFpiWk9VN252V3pvd3l0MkVhV2hnY0ZIdkVP?=
 =?utf-8?B?RjZCVnp2a1UxRXRINHg3dVRUYmxyRnBrMnJrSC9aVStVVHVCZ3pBM1U2a2FQ?=
 =?utf-8?B?Q3E5UXc2U0o3QnF1dXo3T0E4Vi8yOWlsSDZmSXFRakhTQitycjJ0Vkw1NjZv?=
 =?utf-8?B?dlNaUlZYZkRvQU5IMVgwMlZQemFQU2Rqdy9IaWxLQ3VodElWWW9WZUxyeXF3?=
 =?utf-8?B?bTJNd0I2UWp6Z2JaclpOYkxMZ3NkVEFHaGE2cmxTMy9sdnVOZENUb1IyZFBB?=
 =?utf-8?B?WGp4enUrOTA1NnREOXM3c3kwWW11NTd5UmFSVWw4QVdZNnhkTjN5WG9jT1F1?=
 =?utf-8?B?dlVLdCtYQWJyUSthVVc1ZlM3WWpNem54RmxQMVVrY3B5Um1HYVk4N0szU3B6?=
 =?utf-8?B?OG81VkdxeGFmcVhZU1NUUnBnUjRmYk9OVFZ3N2tLd3EyRTFpZUZuNlQya0R1?=
 =?utf-8?B?eTNZQ1dFcHVDK0pnWWYyc0VOcitUZU5PYURORThOTVRHN09QVkoxZGJUbFpY?=
 =?utf-8?B?V05hMzdadFBPby8xbXpRR3RSVnM3Y3FWU3BteENTWkhaemc0K20zcG5MNS9i?=
 =?utf-8?B?Um5VOEdMUXFpWHJuVWROVmN6SDNEejVraTl6eXlaTXIzMlNCM0R5aFJGcmtK?=
 =?utf-8?B?d3ZiTUtxV1V4SUdWSVhNOEdqTE14UitmWFlDWnY4ek4xZ0VpRURqa2JxZWhH?=
 =?utf-8?B?NkFxcVRFVGZXY0dEOE9zMC92dEVtZERmZklpd1B1NGduaFozeTUwZU5FaTh1?=
 =?utf-8?B?NUVsekdaLzlRZFNWU3dIVXk0UHFBWGRiNmNnNUJITXJsdVVlWjE5SktacnN1?=
 =?utf-8?B?LzZleE9reWJmUGZIa1kvZ3dMcDhQRExHVTI1d3FkQTJTZmtoaDlTQ2NUM1RU?=
 =?utf-8?B?dHdMYzA5UmdvQXFBWHl3bEtQeHl1c2VZN3hsRytpU0NnajI3NFVnaStYTHlz?=
 =?utf-8?B?S3FVMC9BbnhuZ0xOVW5tanBJS3hhUTU5ODh2Y24vdmx0KysvS1lwQ0J3eko5?=
 =?utf-8?B?akFIdmtJTDYxd1E4R1ZqU0UyaGF4QWRjK0Ezd1M3bHljbGh5Y09mVU9qaW83?=
 =?utf-8?B?WHlzaHd3QkR3a0tkYjNZanZKUWJaTVA0N051TEJwT3pQYzNrUDNxS2ZCR2hP?=
 =?utf-8?B?bWhrZ1dEeUtpWmI2T2k3UTdqTEVuQUMrbWRLUm14dVRETzRvSXdMVnFJeW5B?=
 =?utf-8?B?TzZYcnhuNGRWTGVuakRWM012RzRWdkFoOGxWdysyTDE3TVdoaDRSNHIyVGFG?=
 =?utf-8?B?NmQ3NDNOMVA2V0JqZ1FlQ0Z0TDRabWdHcGtsVnNqb1o1VlNnWnNSQmhIaXVQ?=
 =?utf-8?B?RTQwUzJXNTNmQ3JaazN5ZFJvRzNQMHJNaUd3OCtoc1V6Y0VScUYyeVkzN0s4?=
 =?utf-8?B?QmxtUFgxemoya05jYU4yV2dGb3NvNmJCa3RSNEhJbFZ5dFI1aUhSOGNNK3pS?=
 =?utf-8?B?TkhOYjUyVHE1bU54dkhPUzFUeTdMZnduUmJHN1pMT1pidzMwZTcyNllkQ09j?=
 =?utf-8?B?T2d0VVczVmMrRmFnS3dXM0pYS1hHMGVLVFVhWDh2cFBoWVlINGxXVzJ1NC83?=
 =?utf-8?B?eTBGSUJ3OUhkWXE0b0lLb3lXS09OdlVIY3JZcC9NejMzOHY3Q0V1QXlRc3Zw?=
 =?utf-8?B?TDdhZWxYLzdEQzBuRC9xWVp5SSs0bE1MSzR1MzBPejNjREdJVWRWU1R1UzNz?=
 =?utf-8?Q?uBdRBAe5tjmycnjw886OcqalF?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(19092799006)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ayieoskhSb+dhHvVGvWeuur3jRZpcpF7uPpy3FtHxokClxlx/5ODSN/Rs1aiTE2j55cpJxbxLQCadW0FedN5bJoXYrxJpVNg78C+xSW1gpVmNn0Cj1oeCkgpKLGQkG16ILdTZYPdTAFXa3sCwjl0unTK7x5zOeUzj3Ci0Un0IggFZtDrbkRxCkLlaJDqJAiwfERxLVxxQMviGOWQ24H/xHBK2mQ3UVqX8vOL8+YQYEnR9nHDlI18BPcZVbKG3bWGuumZn2uqW1muK/5QkxLw0Bsz7VPPwyYVUFDDwQvATGQheqGY45zWpCLMl8iQNFx8HyJj0woOnehs7EbWAr/uWnFQZoHSTOM/gRrjBt7wRkcz5qDwbFKgHVDPWLNdyqH8VQSka8hRxp2BucShUjcJI5Hgtp7aZM2t9/h8Ff5+b8njmygl+NJGxv8G05rCd+fzziglVzfInHbTPAR3m9Zk6cBrX3TjskSQXSSL1uWZGqqjmiEcCco5KSHCGENKG4B7M46d2x+edSgX0x5CyuULe/Sp+q3M0GA8gRcEV81uK2x4fPVDooMcy2CybuygoeBxbggHM38WQtW0C7Nxz+b1VPcdtY8COVCxajNg2spdV8JKZFXvz5sF0ewqIYXf2ET9aBgPqBTSMGZlc15ou02PrA==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 17:27:45.6559
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffa90774-02a7-4f5c-6a3e-08de0a7dd2db
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFD9AAC434D
X-OriginatorOrg: ddn.com
X-BESS-ID: 1760382046-112009-8504-13316-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 52.101.43.92
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVqYGpsZAVgZQ0MjA3MAs2cg40S
	LV1MTSONnC3NDcIDnR1MQoxTAt2SxNqTYWAJfVtj5BAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.268184 [from 
	cloudscan8-21.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
	0.50 BSF_RULE7568M          META: Custom Rule 7568M 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

For io-uring it makes sense to wake the waiting application (synchronous
IO) on the same core.

With queue-per-pore

fio --directory=/tmp/dest --name=iops.\$jobnum --rw=randread --bs=4k \
    --size=1G --numjobs=1 --iodepth=1 --time_based --runtime=30s
    \ --group_reporting --ioengine=psync --direct=1

no-io-uring
   READ: bw=116MiB/s (122MB/s), 116MiB/s-116MiB/s
no-io-uring wake on the same core (not part of this patch)
   READ: bw=115MiB/s (120MB/s), 115MiB/s-115MiB/s
unpatched
   READ: bw=260MiB/s (273MB/s), 260MiB/s-260MiB/s
patched
   READ: bw=345MiB/s (362MB/s), 345MiB/s-345MiB/s

Without io-uring and core bound fuse-server queues there is almost
not difference. In fact, fio results are very fluctuating, in
between 85MB/s and 205MB/s during the run.

With --numjobs=8

unpatched
   READ: bw=2378MiB/s (2493MB/s), 2378MiB/s-2378MiB/s
patched
   READ: bw=2402MiB/s (2518MB/s), 2402MiB/s-2402MiB/s
(differences within the confidence interval)

'-o io_uring_q_mask=0-3:8-11' (16 core / 32 SMT core system) and

unpatched
   READ: bw=1286MiB/s (1348MB/s), 1286MiB/s-1286MiB/s
patched
   READ: bw=1561MiB/s (1637MB/s), 1561MiB/s-1561MiB/s

I.e. no differences with many application threads and queue-per-core,
but perf gain with overloaded queues - a bit surprising.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
This was already part of the RFC series and was then removed on
request to keep out optimizations from the main fuse-io-uring
series.
Later I was hesitating to add it back, as I was working on reducing the
required number of queues/rings and initially thought
wake-on-current-cpu needs to be a conditional if queue-per-core or
a reduced number of queues is used.
After testing with reduced number of queues, there is still a measurable
benefit with reduced number of queues - no condition on that needed
and the patch can be handled independently of queue size reduction.
---
 fs/fuse/dev.c        |  8 ++++++--
 include/linux/wait.h |  6 +++---
 kernel/sched/wait.c  | 12 ++++++++++++
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 132f38619d70720ce74eedc002a7b8f31e760a61..0f73ef9f77b463b6dfd07e35262dc3375648c56f 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -499,8 +499,12 @@ void fuse_request_end(struct fuse_req *req)
 		flush_bg_queue(fc);
 		spin_unlock(&fc->bg_lock);
 	} else {
-		/* Wake up waiter sleeping in request_wait_answer() */
-		wake_up(&req->waitq);
+		if (test_bit(FR_URING, &req->flags)) {
+			wake_up_on_current_cpu(&req->waitq);
+		} else {
+			/* Wake up waiter sleeping in request_wait_answer() */
+			wake_up(&req->waitq);
+		}
 	}
 
 	if (test_bit(FR_ASYNC, &req->flags))
diff --git a/include/linux/wait.h b/include/linux/wait.h
index f648044466d5f55f2d65a3aa153b4dfe39f0b6dc..831a187b3f68f0707c75ceee919fec338db410b3 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -219,6 +219,7 @@ void __wake_up_sync(struct wait_queue_head *wq_head, unsigned int mode);
 void __wake_up_pollfree(struct wait_queue_head *wq_head);
 
 #define wake_up(x)			__wake_up(x, TASK_NORMAL, 1, NULL)
+#define wake_up_on_current_cpu(x)	__wake_up_on_current_cpu(x, TASK_NORMAL, NULL)
 #define wake_up_nr(x, nr)		__wake_up(x, TASK_NORMAL, nr, NULL)
 #define wake_up_all(x)			__wake_up(x, TASK_NORMAL, 0, NULL)
 #define wake_up_locked(x)		__wake_up_locked((x), TASK_NORMAL, 1)
@@ -479,9 +480,8 @@ do {										\
 	__wait_event_cmd(wq_head, condition, cmd1, cmd2);			\
 } while (0)
 
-#define __wait_event_interruptible(wq_head, condition)				\
-	___wait_event(wq_head, condition, TASK_INTERRUPTIBLE, 0, 0,		\
-		      schedule())
+#define __wait_event_interruptible(wq_head, condition) \
+	___wait_event(wq_head, condition, TASK_INTERRUPTIBLE, 0, 0, schedule())
 
 /**
  * wait_event_interruptible - sleep until a condition gets true
diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index 20f27e2cf7aec691af040fcf2236a20374ec66bf..1c6943a620ae389590a9d06577b998c320310923 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -147,10 +147,22 @@ int __wake_up(struct wait_queue_head *wq_head, unsigned int mode,
 }
 EXPORT_SYMBOL(__wake_up);
 
+/**
+ * __wake_up - wake up threads blocked on a waitqueue, on the current cpu
+ * @wq_head: the waitqueue
+ * @mode: which threads
+ * @nr_exclusive: how many wake-one or wake-many threads to wake up
+ * @key: is directly passed to the wakeup function
+ *
+ * If this function wakes up a task, it executes a full memory barrier
+ * before accessing the task state.  Returns the number of exclusive
+ * tasks that were awaken.
+ */
 void __wake_up_on_current_cpu(struct wait_queue_head *wq_head, unsigned int mode, void *key)
 {
 	__wake_up_common_lock(wq_head, mode, 1, WF_CURRENT_CPU, key);
 }
+EXPORT_SYMBOL_GPL(__wake_up_on_current_cpu);
 
 /*
  * Same as __wake_up but called with the spinlock in wait_queue_head_t held.

---
base-commit: ec714e371f22f716a04e6ecb2a24988c92b26911
change-id: 20251013-wake-same-cpu-b7ddb0b0688e

Best regards,
-- 
Bernd Schubert <bschubert@ddn.com>


