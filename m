Return-Path: <linux-fsdevel+bounces-64009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BD0BD5C29
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 20:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AEFA24E1ED1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 18:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C194F2D73AD;
	Mon, 13 Oct 2025 18:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="vzigmlpj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588D14C81
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 18:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760381041; cv=fail; b=bgTDXO4XeQ2LuUWuWSrBz+E624KY0fWTVqvcfcTx1Y2yFbDfyLbwfev7FqQWw7QsNZjQZf0kW6lhA8TAi+3q3VczEV4Xj5M7H+pfQhkx9irlbI91DAIsZ1EUY0JR0n0eX237xMIpSsM/TMf1Y1XC9gWByrIEiE3bsFO/4YVAZ3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760381041; c=relaxed/simple;
	bh=PIge3iA4u/aNpUo3th0WRDg5M/judJa9H4DI7Rg46sg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kxowbwygqftOsdlTIMJ3XW1wF1Ufkd7ACWf9xLvMEJqWhw9iWG5DOS/z0hMBJXGhskyhh2c7Yk/WQITx4fYQQVok+WL2JNvhgAMkggNpVEPuPfvqaeqnBM03VYhBvQrfO8RAXhVnegtqcEBjsRFwPbHOLFDQbgp9GFFjtTkUQlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=vzigmlpj; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020087.outbound.protection.outlook.com [52.101.56.87]) by mx-outbound46-233.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 13 Oct 2025 18:43:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ncfyathZWUveWG8hCTSW+nKK48z91iujeYJymsI8dXuP1NujtAW/g5uZ59Vsp7NnAPSfuZIBe4jAEzDUTLktcGvx+Idf4k4CzQZLyQ1vXPOed0ELSjvQw/UzQ57UELJ2M5ndhqp8H9LP3mJjgQn2ZCbv/twCdoGcrNnq61L44W5c+ntsTOsL6uU40vkbHTFKpUDQxjDh17jEMXfsEhxKvBTc5f8xzgklUTN6b1BJEXqgG+X4EqHYzQxY9cu000/P7m/0KiJJQ2Eu5nQAzhlYdjQMK1j5hS6s2s4D/S1GfwE8D5DVttnm6qPSSlLxveOPjhfzG/V+WaF56cRrVvt6MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wwyXClVpKveqOzhjlbTgQ+SFzY2/eNntH7I5jl+LODA=;
 b=wjSWWDuUvlUHFHeGhosIuXeCFdkM4jB2CQPjie3TUDiBVAzL1mkEP08snN/V7xHSFmU85fSNsEgucPlEYwUrLj3mGTKkdTD4Wznni1xuZaPwl2l5tgTEV+Nd5yBG8VEh2pWZJo3tXwkiyq2lDPDfe9VwVWzc2NHqRyy75beUGmK+x+SizBmXa+yj/zv/i9VWzX7WAzntP6tS4YCYkyJwh/phKL0dtP6pVQleY6+LlJnv7L3rfQ/HR3qtb/ccfiHQaT7t9z7suVNruK+eQtgzSiPgMlx0LsoXCjMNY8DGPl2SFQIC7BA3rHRFNtm7PHsVoAubsgNphrc9Qedm22qpjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwyXClVpKveqOzhjlbTgQ+SFzY2/eNntH7I5jl+LODA=;
 b=vzigmlpjETJ41UA7CZlyS2ys+i7s7B3wwu/oRXHfWgERmwwiaB4KEtKb5xU1BBmVzfLKn42xfROgWx2V+D1Nwbn3sMVjRtBqehyn+lWCPkcM1irbspXvimOG7mM39tyzVkjJdXNBI1FABcjO2aq9tF4/mn0URKZt038rU7OH2qw=
Received: from BYAPR21CA0012.namprd21.prod.outlook.com (2603:10b6:a03:114::22)
 by IA1PR19MB7208.namprd19.prod.outlook.com (2603:10b6:208:42c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 17:10:06 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::3e) by BYAPR21CA0012.outlook.office365.com
 (2603:10b6:a03:114::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.2 via Frontend Transport; Mon,
 13 Oct 2025 17:10:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Mon, 13 Oct 2025 17:10:05 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 07F2B81;
	Mon, 13 Oct 2025 17:10:04 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Mon, 13 Oct 2025 19:09:59 +0200
Subject: [PATCH v3 3/6] fuse: {io-uring} Use bitmaps to track registered
 queues
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-reduced-nr-ring-queues_3-v3-3-6d87c8aa31ae@ddn.com>
References: <20251013-reduced-nr-ring-queues_3-v3-0-6d87c8aa31ae@ddn.com>
In-Reply-To: <20251013-reduced-nr-ring-queues_3-v3-0-6d87c8aa31ae@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
 Luis Henriques <luis@igalia.com>, Gang He <dchg2000@gmail.com>, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760375401; l=5499;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=PIge3iA4u/aNpUo3th0WRDg5M/judJa9H4DI7Rg46sg=;
 b=fcHCfUKybFAZ+oEL49UGsKvI69equ8Kbn2OB1haLHZ8z5qxdh/ltNy84/bvqqvHtZWUUol65S
 D8QkMs64fcwA1L8EBaDZfbKlfZ4DblL33/eM4D1Xbyonc34uOPEnIsz
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|IA1PR19MB7208:EE_
X-MS-Office365-Filtering-Correlation-Id: 48ac06c1-ed1b-4a6d-bec4-08de0a7b5b21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|36860700013|19092799006|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?dTNXbzZjc1V6clBGZlhNZ0I3Q1pqOG10NWtvdGxEM2pvbDFNWUxyODhWS091?=
 =?utf-8?B?SzAxVFZqWUlGSHl4dEhNRXZMSS9pVVdaVnBCdndiOHhSSmhnWEhhQjVpb2Ry?=
 =?utf-8?B?VjQrZmZVZTMvTU43R2R3eFpmN0pBZXFzeFI5TEtHb1dSZHRkSnRKL2ovdGU5?=
 =?utf-8?B?Q0NObDA3Z3BhVG1hdEw0THRVd0hPYUh3NllxdjQwY3FiOEdxQ1dUZ1NhUktK?=
 =?utf-8?B?SXNPdG1yYi8zQXBjSm9IaE9BQjlJaHFCbnlJbUF2QjdpRXQxckpmQStiSzlR?=
 =?utf-8?B?THhVamVHajlrck0xRk4rSUVvbjg1REhIS2o3bGdKSEFDakJ5WVFheHFMZHZu?=
 =?utf-8?B?UXVhZjVjdUJMMnQvNmw2R2c3T2E1Zm9OUG92NjZHT1VFUXpnM2toWWNJdWpv?=
 =?utf-8?B?ZFZpMWw4U0I2ako1R0RDUFp3TTZhTndua1FEQkg0ekEwd0FnZDdTWnJ1elFG?=
 =?utf-8?B?d2ZwQUFjWm8zNklUNXpnekVwdlQrK0tPSWRhNjRuTzZ5VFJGTFBhWExUZGhE?=
 =?utf-8?B?eE0vc0tNTVc3eEtDZDIwYW5UVnRGY2owbDVFNjJTbmhueXU4eGd2UWpFa1JJ?=
 =?utf-8?B?UVV5amltblFMYlRldlM5KzJUSlk4b3V6V3lzVmhpbERPYUJHcE0rZVJXL0Fx?=
 =?utf-8?B?TjVWQWVwVStnemExTEdnWGw5WUJDQlRYM3pvS0M4RmkwYzhWYXJqb0dJbHRD?=
 =?utf-8?B?UXFqSG9qWU9kcEE0eEcvZldNTFZXZXZGRDh3d2JHRnR3RzdYRlBnNm1uY3pJ?=
 =?utf-8?B?UlhRNWxweFMwN0dZR0JWV2VHWDJMcXlBa3QzclE4V1pPM1FBempTMnVmSlZs?=
 =?utf-8?B?cGttRzZQU2g2MS92SVJHVDBWSHgxVm9YallXaTlxaWNlZU1OaFRjcCtaYzVW?=
 =?utf-8?B?WGFTK3NiMVR5MDA1TE5zaWNib3dHdDJjU3BtTVk1ekc3WUIyM1gyRFRFKzhZ?=
 =?utf-8?B?MGJ5aTU0b1FuT1U3QnhreGFCQnFieWRrWW9seC9ocEhjVjA2TDExZVJvNVFQ?=
 =?utf-8?B?MysxYlZoTm9kdGdoYmVBVGtpTmFudzNycUMzVmZ5OFE5bWpRZjNoWnI0K2RG?=
 =?utf-8?B?S2xxREpkSDNkdFh1akJYeDE4YzJmNkViSmV2VHkweTVlTHhSZ3NhR0RoQk93?=
 =?utf-8?B?SysrWnNKVnR5L3pLbFF4Qmw1Z2FuVlkrVk1BVjF2cnJ5MktTUHdTOW1PK25x?=
 =?utf-8?B?YUliRnFjZ3lpeE1KMzlLcnNreHNXQWd3aVdJQ1JkdGtjNTRocXFlQjZVYk5j?=
 =?utf-8?B?UFdtMXBGTmZSeDM3QTB6UldDVENMVHdxY1FxcXJzcU15eUNJeFRNS2ZzTVdD?=
 =?utf-8?B?cWlrcnovVjhFOHFLaEtSQURkWnp0c0l6SnI0Tjc5L2g3QjlLMlU3bzN6QllS?=
 =?utf-8?B?d1pPYndTVjBPWkJnU3ZoYVRycnBDWXU3by9JMFkxeno2NG0zVWRHc3NOZlho?=
 =?utf-8?B?SmtBZmdxZGlqLzY1NENJWkdoRVYrZ1c5N242Nm05cFpoY0VBL2tJZjNlYThp?=
 =?utf-8?B?dVNEbmZYYndMaGlGT2x4NG0wd0tDbU85TzcvUmlxZXBDZ1NKdUtaVjgvZXJs?=
 =?utf-8?B?OGRnSXlLVHJWdWRtNzVYYmtyYS9rMDlzR1N5YUxtTmhNYTh3dTZLc3F6dEF6?=
 =?utf-8?B?UU5nRVVuQW5ScnUxUmJWbnlKcTQyaXdRUUlSbzFSSWZwRTcwR3c0Vkx5K0hT?=
 =?utf-8?B?L0haNUF2elVRMnErMFNTNlczajJ1VjBha1FmaUpNdHplZFgrVFFvSU5iSnFG?=
 =?utf-8?B?VW9vSDcvQk55dEVBM1FIK1AvVGtMUHNZUCtaS2RmSmpVdUVrUnUzOVlIQkc0?=
 =?utf-8?B?SkVYSlB4bmdiL2o2UHVrRllRSjEyeWtzekpLaENTb3lsNVA3ZDZJYmpJcmQ1?=
 =?utf-8?B?MjYxaHpiODNSOTdrVzlaOGU1L0ZiTjJFUzRaODNwL0RCYmNmKzBEMmpyQ09G?=
 =?utf-8?B?N1VwQXVJR0tVQTFBR2swTlpNODFZc084TURUTmoxekVubDFoTnh1NzdybnBt?=
 =?utf-8?B?cmxvMVFoelNnU0MyeVNybk1nVFZlY1hLWi9BQ0V5dWQzYjY2SGxSV012RXNk?=
 =?utf-8?B?OUNvemJJa2lLY2Y4L1A3djAwN1gxU1ZYZzFMYmZ5QUdlUUpBaGpHSTNuM1lQ?=
 =?utf-8?Q?wj6A=3D?=
X-Forefront-Antispam-Report:
 CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(19092799006)(376014)(82310400026);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
 EhILb7ljGMua9L8ZRY1e7hepk4MjooZzy1REQ9sNunezx0XaTZfq8F17Ssl35kEMp5KDnbJjApTzceaHtcihZFPoIeVgbuVYYfPOCrkJb63skJb71JVtXiNzw8LdL+ABG4GHQFfuMctUftyR9hbP8/FUUGK26kU6SvLoKXiezt56IrJKKFtgASF6cV7bKuEyESyLmEXyiHpCIojo4LK9+UAXWxiKwo/Ujo0WWljQjVj6eMIsHRLfG8hAYFxSzzB4xr1KbjUPAJwOgdEm8f/nxU96gxOiUvuCmPBttknH4yilDUncXkiJ7Ck8HPlhVBQy9Yi16kSIKg2iGoj3FWywYQ3/85A5oiG7bHrnnGTyPdYmWfspxuhLTlf/B5z63cwwH+ptQGukcp0Ew56Xoj+dR5uVr+Z1t4W7iB2vB8Hd9o3SiD6XRJ49pXL7s3P4E3BThZc9PvPAiWcVrXP4YQQxNAExSakklYqHsQDfxN4CI+oP+FckB4JJr1LI1hayDeKAMN9KoM92cgNgetKc/FTVPz8b75aD+vCMbcH+i37UqgVtAfp2S12x5F6ThyBno7raC6D/VB6pGnxQVSY9+p08yxQC8ksbS7syqXySfZqbh97Y89tdjja4D4d20FdFlRKtDmVC7x1YbnYUp9CbRw77IA==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 17:10:05.7928
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ac06c1-ed1b-4a6d-bec4-08de0a7b5b21
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
 CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR19MB7208
X-OriginatorOrg: ddn.com
X-BESS-ID: 1760381036-112009-8483-12498-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 52.101.56.87
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVqbGRkZAVgZQMDE1Ldk4ycAs2c
	g4MdXIyCzZxMQsydg0FShuYWJqmapUGwsAlBC3lEEAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.268183 [from 
	cloudscan17-52.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Add per-CPU and per-NUMA node bitmasks to track which
io-uring queues are registered.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev_uring.c   | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dev_uring_i.h |  9 +++++++++
 2 files changed, 64 insertions(+)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 70eed06571d7254f3a30b7b27bcedea221ec2dd1..02c4b40e739c7aa43dc1c581d4ff1f721617cc79 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -185,6 +185,18 @@ bool fuse_uring_request_expired(struct fuse_conn *fc)
 	return false;
 }
 
+static void fuse_ring_destruct_q_masks(struct fuse_ring *ring)
+{
+	int node;
+
+	free_cpumask_var(ring->registered_q_mask);
+	if (ring->numa_registered_q_mask) {
+		for (node = 0; node < ring->nr_numa_nodes; node++)
+			free_cpumask_var(ring->numa_registered_q_mask[node]);
+		kfree(ring->numa_registered_q_mask);
+	}
+}
+
 void fuse_uring_destruct(struct fuse_conn *fc)
 {
 	struct fuse_ring *ring = fc->ring;
@@ -216,11 +228,32 @@ void fuse_uring_destruct(struct fuse_conn *fc)
 		ring->queues[qid] = NULL;
 	}
 
+	fuse_ring_destruct_q_masks(ring);
 	kfree(ring->queues);
 	kfree(ring);
 	fc->ring = NULL;
 }
 
+static int fuse_ring_create_q_masks(struct fuse_ring *ring)
+{
+	int node;
+
+	if (!zalloc_cpumask_var(&ring->registered_q_mask, GFP_KERNEL_ACCOUNT))
+		return -ENOMEM;
+
+	ring->numa_registered_q_mask = kcalloc(
+		ring->nr_numa_nodes, sizeof(cpumask_var_t), GFP_KERNEL_ACCOUNT);
+	if (!ring->numa_registered_q_mask)
+		return -ENOMEM;
+	for (node = 0; node < ring->nr_numa_nodes; node++) {
+		if (!zalloc_cpumask_var(&ring->numa_registered_q_mask[node],
+					GFP_KERNEL_ACCOUNT))
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
 /*
  * Basic ring setup for this connection based on the provided configuration
  */
@@ -230,11 +263,14 @@ static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
 	size_t nr_queues = num_possible_cpus();
 	struct fuse_ring *res = NULL;
 	size_t max_payload_size;
+	int err;
 
 	ring = kzalloc(sizeof(*fc->ring), GFP_KERNEL_ACCOUNT);
 	if (!ring)
 		return NULL;
 
+	ring->nr_numa_nodes = num_online_nodes();
+
 	ring->queues = kcalloc(nr_queues, sizeof(struct fuse_ring_queue *),
 			       GFP_KERNEL_ACCOUNT);
 	if (!ring->queues)
@@ -243,6 +279,10 @@ static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
 	max_payload_size = max(FUSE_MIN_READ_BUFFER, fc->max_write);
 	max_payload_size = max(max_payload_size, fc->max_pages * PAGE_SIZE);
 
+	err = fuse_ring_create_q_masks(ring);
+	if (err)
+		goto out_err;
+
 	spin_lock(&fc->lock);
 	if (fc->ring) {
 		/* race, another thread created the ring in the meantime */
@@ -262,6 +302,7 @@ static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
 	return ring;
 
 out_err:
+	fuse_ring_destruct_q_masks(ring);
 	kfree(ring->queues);
 	kfree(ring);
 	return res;
@@ -424,6 +465,7 @@ static void fuse_uring_log_ent_state(struct fuse_ring *ring)
 			pr_info(" ent-commit-queue ring=%p qid=%d ent=%p state=%d\n",
 				ring, qid, ent, ent->state);
 		}
+
 		spin_unlock(&queue->lock);
 	}
 	ring->stop_debug_log = 1;
@@ -470,6 +512,7 @@ static void fuse_uring_async_stop_queues(struct work_struct *work)
 void fuse_uring_stop_queues(struct fuse_ring *ring)
 {
 	int qid;
+	int node;
 
 	for (qid = 0; qid < ring->max_nr_queues; qid++) {
 		struct fuse_ring_queue *queue = READ_ONCE(ring->queues[qid]);
@@ -480,6 +523,11 @@ void fuse_uring_stop_queues(struct fuse_ring *ring)
 		fuse_uring_teardown_entries(queue);
 	}
 
+	/* Reset all queue masks, we won't process any more IO */
+	cpumask_clear(ring->registered_q_mask);
+	for (node = 0; node < ring->nr_numa_nodes; node++)
+		cpumask_clear(ring->numa_registered_q_mask[node]);
+
 	if (atomic_read(&ring->queue_refs) > 0) {
 		ring->teardown_time = jiffies;
 		INIT_DELAYED_WORK(&ring->async_teardown_work,
@@ -983,6 +1031,10 @@ static void fuse_uring_do_register(struct fuse_ring_ent *ent,
 	struct fuse_ring *ring = queue->ring;
 	struct fuse_conn *fc = ring->fc;
 	struct fuse_iqueue *fiq = &fc->iq;
+	int node = cpu_to_node(queue->qid);
+
+	if (WARN_ON_ONCE(node >= ring->nr_numa_nodes))
+		node = 0;
 
 	fuse_uring_prepare_cancel(cmd, issue_flags, ent);
 
@@ -991,6 +1043,9 @@ static void fuse_uring_do_register(struct fuse_ring_ent *ent,
 	fuse_uring_ent_avail(ent, queue);
 	spin_unlock(&queue->lock);
 
+	cpumask_set_cpu(queue->qid, ring->registered_q_mask);
+	cpumask_set_cpu(queue->qid, ring->numa_registered_q_mask[node]);
+
 	if (!ring->ready) {
 		bool ready = is_ring_ready(ring, queue->qid);
 
diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
index 708412294982566919122a1a0d7f741217c763ce..35e3b6808b60398848965afd3091b765444283ff 100644
--- a/fs/fuse/dev_uring_i.h
+++ b/fs/fuse/dev_uring_i.h
@@ -115,6 +115,9 @@ struct fuse_ring {
 	/* number of ring queues */
 	size_t max_nr_queues;
 
+	/* number of numa nodes */
+	int nr_numa_nodes;
+
 	/* maximum payload/arg size */
 	size_t max_payload_sz;
 
@@ -125,6 +128,12 @@ struct fuse_ring {
 	 */
 	unsigned int stop_debug_log : 1;
 
+	/* Tracks which queues are registered */
+	cpumask_var_t registered_q_mask;
+
+	/* Tracks which queues are registered per NUMA node */
+	cpumask_var_t *numa_registered_q_mask;
+
 	wait_queue_head_t stop_waitq;
 
 	/* async tear down */

-- 
2.43.0


