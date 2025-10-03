Return-Path: <linux-fsdevel+bounces-63358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D43BB6783
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 12:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E49419E1F52
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 10:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7E82EAB6F;
	Fri,  3 Oct 2025 10:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="msK6v1n4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90B32EAB89
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Oct 2025 10:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759488032; cv=fail; b=D2KCj2XHDvc9fxTW/ImUst95yDV4h0Dl/dyNfKh+0Jzal4rq4Mh0u68WasDCyUtQXbC4/vHQ6kTjORSpEmQRzNV2Joysqh2s15/LNDfEZomd91JsdhfrCizRz6MAjNuj9o3xKgoZS3maV1CSPu+0dJTihJSG+PJWq4CWGuLDPjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759488032; c=relaxed/simple;
	bh=fTClVSe48zs+5XEweIW2PXj7KJFR23i10wXnFpE8M1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q0wZXrCZaxKjpiH0C8DTEBTjHJI9fWbkbV2TAHJcD2JweB6pA1TKjROm4o0WHPM6RFkkjaTO1c30hFyO09haXIBiBPCmN/AX9EOcrZprEJ7ZT2doiF2/aFPC1rMfc9DM8ZoRzYJ6I8wZsLGOBs349tYQzLoA/oJjef1S9xH5Bhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=msK6v1n4; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020102.outbound.protection.outlook.com [52.101.193.102]) by mx-outbound-ea46-43.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 03 Oct 2025 10:40:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N4ChTqh15nRfmiyzXsxXsD6t9f1M2BMJRovfLT/en9TJ3FL433+25UmfwrTnn0+zjkKFXoVEf4eyJ1Nv8FRxXrAGBBBwE75qVEztif9OKKWa4FBFiDHAMh0zPkh/KxagGHViFAPUSOE3FNPulcEjO4llyzxAP5YhXHENLH329d758GI0aN7Y0LNF8ePAM7LVducrIyvvyS/b39pQL/8GZlZ2qHxM9knkeT49pQY0s5rwZSG6NK1GxYmu2vHsPJ5wgpQ/dECZuQRl+j76zoQ2bRUdhn9GjrCfxzanOQ1uOemJMtb9YYyOUqzRu+aOM/kORWxxHwwsYObLnmCo4kGf9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2i+NUg6UIzH1Whe2gU7HVfjo7wS0bQ9CKizbGOLZvk=;
 b=CewsbaNKUZct671KYVUtssiYLymGbfOeIuc5+osTbwdxZAr/h3RhNkzYDYFsfbPqoMLaIV0JXfO2OBRAPPbMr1yPuYq15Q74HrgiSV18FLnsJCZ8WXVag7E4Nkvh2bv2PcKP6+2Mw7CSp43cwUqxUD/7q5mHXQcVQ9e1e3i/a0Nh7oi6BCCrNI1PcJZPHzxTWh6UL1lcoWdnlqjSwd9OPnfizujhoj2M6OfT7ZJyC65ccCG8M6gEnc+JFezI0xvbRUkjEw/t0KarYGOCoPi56nmrlgeMbMVwAXZ3RD35OL3EfN2wkJidIdgsKjVRbJA6QOMvQ2W2zF1U+YcSxPVdOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=arm.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2i+NUg6UIzH1Whe2gU7HVfjo7wS0bQ9CKizbGOLZvk=;
 b=msK6v1n4IBQIxL20djEIGkc/a18emL4SYHkI2IwyH5UBy2AAs+GYCQOWWnEzcP43G10LwyVRq6+Po0v4qWTnSsFJ3DFxZ+bWqRrxdIY3k69lnXVZLEd6SY8QPrSUGNID17vXuBIm+Ppf0LAx/liHpEy/Kgo5MqJBq1ROC6xE5oc=
Received: from BY5PR13CA0001.namprd13.prod.outlook.com (2603:10b6:a03:180::14)
 by LV3PR19MB8704.namprd19.prod.outlook.com (2603:10b6:408:26f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Fri, 3 Oct
 2025 10:06:50 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::bf) by BY5PR13CA0001.outlook.office365.com
 (2603:10b6:a03:180::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.7 via Frontend Transport; Fri, 3
 Oct 2025 10:06:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.15
 via Frontend Transport; Fri, 3 Oct 2025 10:06:50 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 9B1D781;
	Fri,  3 Oct 2025 10:06:49 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Fri, 03 Oct 2025 12:06:48 +0200
Subject: [PATCH v2 7/7] fuse: Wake requests on the same cpu
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-reduced-nr-ring-queues_3-v2-7-742ff1a8fc58@ddn.com>
References: <20251003-reduced-nr-ring-queues_3-v2-0-742ff1a8fc58@ddn.com>
In-Reply-To: <20251003-reduced-nr-ring-queues_3-v2-0-742ff1a8fc58@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759486002; l=4448;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=fTClVSe48zs+5XEweIW2PXj7KJFR23i10wXnFpE8M1A=;
 b=knkXKquZLZaJCBtYrde4ArLuiB1Bl4y8aOko7+h2tSp1khpXsJQKJNVjuF031wgAfhecdb1Gq
 us9SPhMtY7GCPI6b5eV0UYgyZqb0afAdEC953eQUiKWmXgXs7dAYgXq
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|LV3PR19MB8704:EE_
X-MS-Office365-Filtering-Correlation-Id: d2758f54-6d26-42ce-3b1f-08de0264922d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|19092799006|7416014|376014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Yk8xTVdJSWRJOHVLVlp0ZVhOcVdGL0NHQklSRGxCcHBjRHhXQnpjZldJQzJD?=
 =?utf-8?B?Y21kaXJ6TWY5WlIydDRGVTdGSXdNRzhaTWpwOU45UEFsSGxaVDhNVGZ0WFNC?=
 =?utf-8?B?cm1VWStjd2s4VldzQ3hNY01ieUFlNzZ2OThZNldQOFpORytIbCt1Y3o1aGxU?=
 =?utf-8?B?R0VmMzdFUmwrbTY0TklCSGYzZDB1eEFtYXE5OWxXQXJIM1BqRUJMNy94ZEw4?=
 =?utf-8?B?Vzd3QmJXRkhFTFZlc0xJN1Y5M0tubzRIYzRBMzNEVlBmTzZSd2NuUTlLalUz?=
 =?utf-8?B?Z0JEQUROMVk3NTZtK2VxTnEzYkZidXk4cWt3MGdaUk5hWnB2WXdNdTZ5M3FR?=
 =?utf-8?B?TkFLVVNDbVdXS3ZLVnJLV2YyT1VzcSswcDZJa0U2RGtEblhFZ2J6SGpQWnVK?=
 =?utf-8?B?bXFlNkNucXNraW92enRHRVczUWRGb1Q0a0J4enV1QUUySko5RmtpMG0wNjVa?=
 =?utf-8?B?R1QyMFFEbkNLbndFYnkrWEo0dXpsSllqRkVvck4vOVVsbE9vREdCOFJZUUY0?=
 =?utf-8?B?YjIwaWtXa1JsMThKeWZ2czNtcURBU05vMEZqcGp2N0FGZHp1Q29RVmg1bHda?=
 =?utf-8?B?YytpMit6Ky8vaGVndGZGMW1yVEk0ODVaS1d3VlE2aURZeUZhMmNhME9kZ2Vj?=
 =?utf-8?B?TW01eEhhbXRrZFErMUs4ZzNkQ1pTUGNtTkcyR2hhRGU3djJLaE5FWVRwYTFa?=
 =?utf-8?B?SXJHZzRpemE0RzBnVEVHSjlUdERxQ1FucGo0amlSQ3RkNzZ1ZFVhbUtQTWdz?=
 =?utf-8?B?NUdhU2NqUUR2ZmtKY3ZFdEtpcjluVk5GYW1wQXF4QWtXL0ZyeEliWEk2UlRt?=
 =?utf-8?B?NDRpWmZpc21RSlgraVRsSzM4OGtvUjE5SkNJdHFQU3FOa0xlK3I0L21VWXR4?=
 =?utf-8?B?YitCMGJQcEt5K0RIOXVwTGRxcytBc0hNWmpSYnhRRTRZcHl4cUtlNUNqakQy?=
 =?utf-8?B?SVNEanNIcWJBQllvdkF0T2ttUjRVazNNNFlQMTRFVnZjZVFETWlJTmp2eUNv?=
 =?utf-8?B?SUtLU0VqQWNTU3NwcTFwRE5mNjlWU2R2OXk3SkFPMmE2cTh4RHk4M3gxcHU4?=
 =?utf-8?B?RjRoUE5tMXZXYTRqSElJQjlGNXFjc3Jna0RqaDFrT09TeTBJYllVRXQveW1E?=
 =?utf-8?B?elp5alhNd3NjN2JiQUc4bHM4MTBKSEdWU2xKdXhKbjRVbW5iOEdQYmY2UDBv?=
 =?utf-8?B?SzNYWmlnOE02VDBOQk9WKzdEQ2MzK1ZkcUFCRDFrK2ZCRllTcE9SdloxR2tE?=
 =?utf-8?B?cHdobWxOUFBuamxSOXhpZVdtRWU0Z0RRbndiZUZLUGtlYkFDQWg3T20rWVpj?=
 =?utf-8?B?ajlWN0FuUUsra0FPOC9YNFlDN1pGL1dpVEdJeWM2RTBMbWp0YXBwcnQvTmtj?=
 =?utf-8?B?SERQcWpuYmFzaXRYN25SS2JJWEpQakpiUzBpR2FodHFPTytJblorVExoOWM3?=
 =?utf-8?B?SHM5elNmOWF2MVorL2xNVkVnSjVZQVNEWktudnJmOWVIc01uZkorcyt4U2dw?=
 =?utf-8?B?Vm5MZE1ndEVyMkhRS1prTHN3ajd0SzB3VUJjM3p3V1Vpc0h1YlpxcDQ3dS8y?=
 =?utf-8?B?WGV0UG1Ba3k0YkJ4VnlaSWZPeUhralJjZFJuVmVXOWtGYWdBTUhUeVBObVVt?=
 =?utf-8?B?TmVxaGdzK1Z1M0ZGem90OTZEY2RxNGNFNFZXRDhseUpwLzlRUll1aDFzSlgv?=
 =?utf-8?B?eXNlU01hZTVGMENvNFVpcjN2UzRieE02VkU3c09QU1V6eUE1UmRxZnpDSVZR?=
 =?utf-8?B?aEhZTXlzVThnUUlRR0gyTXFOcm5UYzByd1VlYk9HRlJmTkpHZFBTOGtrR3dv?=
 =?utf-8?B?djVnNTFwK3VLbUZkYXRNc0d6Yll4YW1mZVdGL3N2UEpnanBTeE5OZ01uWkhY?=
 =?utf-8?B?UkViRXVBSzMxM1p0aCt2ZjVZU2duYXQrb0FTdmJHWFpOaXVTOGpIWHVwQlZh?=
 =?utf-8?B?UXkrTXpUT2FRUmZScVpYNGpQZWRqNXJZVk1tRlU2YSs4SmxJd0pIdEl2UDQ1?=
 =?utf-8?B?d2xjVFZpTzFzY2p6c2NLUXI3VU5ubDVsMExWY3k5SDI1cmRzOGQ2Mi9hTFBB?=
 =?utf-8?B?MTR4ZEpYZTBobUE4dzM5WFpsNVlpSHVqb1d5Nk1yZ2Zlb1NMWTNTNlN6VWJx?=
 =?utf-8?Q?bWoScsKpHbQqxtX8ukwbcXOp3?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(19092799006)(7416014)(376014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8i6XwGLUUrL3Xg7GqV3SW4ips6asuqaHeu0VHnnGs3AYWIjBztgb5zexX5aLx1vvMWbHfr2LhlizjY38Yb3qoCXOB9EYVvRBr/Fny/SN1E2e2V7qP5t1bZ1l/k3ZLSKif9ghaJRPng9iKqvv/rNtOaDJoLVFQtAN7xs9WHRPwXJI8ELWxCE61gGelNTpILgo6iy/5wHbLhbuu6jbKihgWpjKITrI+K4dKT2L0W9V3NZlBJSVhL5krcnBeAm7K3qmuAoRrYbmWP49ggCt/PdwrZGAqosK53AKPV3RJ8dwQ+r2lvKfK9WhwqUE5KYgJlSktT12opAMG6OmwxfjknOkPSMGvkQNMSzRqhmjts48nTkRtvaForHIwozaLm8u0dAg9UmHXXG+5heApzOMGc8z+aptrpIg0qzV0Y8Yl6ZORDyoh6S8ghH7G2d0GVELTYt3TFsMVxdVN1N6nS84lDEJc2sF+CrY332RtMbEKpq+kvEeuspmmnRhy+k1DGOFE8CzjR3ouL6mcn36PxyDbsXdqyJcacIMvm+YgVspAQPQxejsd9CymDoL5mevtY9uy2ZV6U8BK9z1xCjWFCz5j3ZlXYSBluyRjkaFsjZ/dDScLr1hoU1WOiUVsoCz171Yze4JvNrmphKLctSluMmYgMuHUQ==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 10:06:50.4632
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2758f54-6d26-42ce-3b1f-08de0264922d
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR19MB8704
X-BESS-ID: 1759488027-111819-10308-5227-1
X-BESS-VER: 2019.3_20251001.1824
X-BESS-Apparent-Source-IP: 52.101.193.102
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVibGRpZAVgZQ0MDE0sjQwiDRxN
	AozdTMyMjYPNnA2MA0ydDUyMzMzNRQqTYWAB/3ijlBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.267935 [from 
	cloudscan10-68.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
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
 fs/fuse/dev.c        |  8 ++++++--
 include/linux/wait.h |  6 +++---
 kernel/sched/wait.c  | 12 ++++++++++++
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 5150aa25e64be91e17fc45b1dbefb92491c81346..cbff7091124cb1d74e04ad40d9f461b4815bcca4 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -479,8 +479,12 @@ void fuse_request_end(struct fuse_req *req)
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
index 09855d8194180e1848db857b2af95112df91128c..595979a601f8a943438482a33e8af2d20979d409 100644
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

-- 
2.43.0


