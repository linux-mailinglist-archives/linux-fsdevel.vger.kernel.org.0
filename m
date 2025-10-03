Return-Path: <linux-fsdevel+bounces-63361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8700ABB6790
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 12:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DE3684EBC28
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 10:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A510A2EACF0;
	Fri,  3 Oct 2025 10:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="xBgRB9s/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA5381720
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Oct 2025 10:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759488085; cv=fail; b=fL1tUGU0kaDRoUpdy8/AFeAO4Rh4EweWzE6ofXCqCo3eYC+15+UvuoMd8ZXa3mMaMJh9zNxcKGt5tAgufjUe/fPAhCz7aFhcRuT1oZsMWbB8b5cngp0xYd6xSAY5Z9J7nXBbkH7Kv//EUa2Yon0SwqJmVVbq3Kb883W0n/kXOFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759488085; c=relaxed/simple;
	bh=SyyXi5z7cfnUNwPSJKyACp3zD1LB3EPjIp43bCbMhkI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FnUs7dD2/aHheNHuNFXfulXpAuUXAxzBNpJBHoxyoSes5LcNX6ISzHcxXE7rQiSj9FJXDeyl+h+peGJai7buSeDp3ikiF2XXOobI/H1FvKDHkNvmRgUE5aWbDTDR4fHFvBKMKnhC3b77TFe1cSBx1FJ59kaJ3bes8zfE60ueEjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=xBgRB9s/; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022115.outbound.protection.outlook.com [40.107.200.115]) by mx-outbound44-219.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 03 Oct 2025 10:41:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U+okJGZH/we66E0qCBOMiH6qqXv2cmiV0M++uMuKccLleBJfa6KSJ+iZ81tZTkhrjEfQ39J+I8kg/c3eyc9ekPzGwzxZ0uLgvzyTCq/B4+KjQ8SKwxbMe83wy5MLo6gWvmAewhUG3KxnU2ZB2/LpEF0776OLshpxAYx+76+4RT/KbRgNCxlwvLc3T7f4ivPbU43pGEiTGuooDeeCEbcX9AZS1f3vNKBZHPWfP02kAR15tmv+/SAvvNur8N0imnlK6S0KhQzGbbiPll67PupVRL+A/zxGXwg8tcMr1muFzZ9I3oNKvHWY+oIDcANcFsTDonJJzK706Fd+/Wmcxb+Y8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7M0328Fdw2huRO8xWWLXAU3DUuzQh5rVqLQzcZUbWoA=;
 b=mzM9DXwbB2zuXPdb/e7No92pLFcK69tWFD+1X4349hOgkuohl9oxFL8yAYUj21RaRmpLu+pKaV5U5h521NqmF4SrUuuh1MoItTImFj41PjrYMmU9B7lXc6USpQi7C/DAD3s6Mj3s49u2ABqTbhIf8oI+ewxeyOkzedqOWEaHPBb+3xUOxpU26t4XRhvAybe+F02chqlOWTJLvBo0kF4dcFZpTvxNeTM9CDGPxmCbDW45x1fvCwrOAN+J1Pfx4I90bWS+5vbZSzIHfUV/jvYaXxhh6Df4oKUO2lTBt19UuM8GmqffzCa5lcY0VeY/cqjD6VhTRcR+aPmDAsJwZ3vYiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=arm.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7M0328Fdw2huRO8xWWLXAU3DUuzQh5rVqLQzcZUbWoA=;
 b=xBgRB9s/OL5TPxOWAb9Bb5DNi+PcbAovc22TNnmONKC3OmOGWB4nZ6aj1k14JKlYF9W80iW75+pb2W+bpVsujpx9OllPo6PZ5If/kYQNtYwuKaSuX9QhfZOxtDoCM3CFRjIxvmczQgnQaZs5Zne9o1JVcAn+2s5Uvj+yLyjyUTw=
Received: from BYAPR08CA0051.namprd08.prod.outlook.com (2603:10b6:a03:117::28)
 by DM6PR19MB3978.namprd19.prod.outlook.com (2603:10b6:5:245::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Fri, 3 Oct
 2025 10:06:47 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:117:cafe::f2) by BYAPR08CA0051.outlook.office365.com
 (2603:10b6:a03:117::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.15 via Frontend Transport; Fri,
 3 Oct 2025 10:06:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.9
 via Frontend Transport; Fri, 3 Oct 2025 10:06:46 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id CAC9781;
	Fri,  3 Oct 2025 10:06:45 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Fri, 03 Oct 2025 12:06:44 +0200
Subject: [PATCH v2 3/7] fuse: {io-uring} Use bitmaps to track registered
 queues
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-reduced-nr-ring-queues_3-v2-3-742ff1a8fc58@ddn.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759486002; l=5694;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=SyyXi5z7cfnUNwPSJKyACp3zD1LB3EPjIp43bCbMhkI=;
 b=XBngaJ03zKuxZI8JJYw20L+yqW0ohS/lezXD4t5mYYslFW5JhENDbaiHcsakx6Sa+lvJ98sKS
 Gtbih9+R9vvB7c0JE6MrinO+ddqyFtYnV95BEoMAj49en2rA18P6DyK
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|DM6PR19MB3978:EE_
X-MS-Office365-Filtering-Correlation-Id: 556742bc-7ce3-46b6-47af-08de02648ff3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|7416014|19092799006|376014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?OTdIeFNNa0VaeXJxcjdkbEd5N2N2Z1hLOEl4REN0cnZza1BkcXlwTDBhSTlE?=
 =?utf-8?B?eG5Ha3Z0ZXY5TlRkL0xDUjI0YnhwR0d3Ly9jellUYlhIUUthMEFvandTTkJx?=
 =?utf-8?B?R0IvZEcrRUdHRWpaVmIwMjFYQ2ZZMTZ3YmRGQUxibktyekhQMHRUZGJybERO?=
 =?utf-8?B?NjFveVVJSGlhSVJyNHU4cFFpcWdiTzAvK3V6aEx6VzlxV0ZRKzBBeEhOS2hB?=
 =?utf-8?B?WEp5SkZKUEU0dDk4dnlOMmovK3RKTEhYenE5Y2dWeis1M3U5TVdqZXZGZzBj?=
 =?utf-8?B?WEY0ZVBSTXVQOGZuMUt5aHU3K0k5QlVTVEpDRVRyRWZrV054clpQMWE1WmJ6?=
 =?utf-8?B?aEJuK21YemZoVGg2ZVc5SzQxdHVSWERsWnJOYUdnZWdWOStzV3BDTXRUZENW?=
 =?utf-8?B?cjFuU200WFp1YXFFRlhmTkVDbkFhVWNSeWpUZHVHcHJaZXdnZi9EbHZVU0xm?=
 =?utf-8?B?WExWcDlMd2h5eXgxNGJHaXdjVk5KOHAxU2ZpREllblVjemcyS2dIL3lNZlhB?=
 =?utf-8?B?NGNNR3d1ZW9Ub1NoUEVSZWxaczM2a0dtM2ZMSklpUERVeEozK1ppb2VaY2Va?=
 =?utf-8?B?NkRUd2tkdEQ0QXdCL3k2bnJDVCtoN2pSOVlmK3F6WDBtT2xUUDlsWjN2TS9B?=
 =?utf-8?B?c0Y3Z0VkNkdHNHR3bXhVNnc1eFk0L0hQR3Zib3hrcVl4WEwvd0djQ2dKbXo1?=
 =?utf-8?B?d0tSTng1bkRIWHBKRndybGk4bGhvMDBhSExsZ3VJZ2tlaXZBWUF6bVhFc3gw?=
 =?utf-8?B?OGQrQTRhN3cxbjlwOXVOL29UendxTTl4YWJzMExJR0pZaDY4KzdWeGhSOFFR?=
 =?utf-8?B?S3V4d09iNXpYZkpiRDRSMkRITm1YTitjeW5lbjdKdzJLU2NmQjZUN1JoQzB2?=
 =?utf-8?B?MmYzTm9ENlAxdktPNEp2eVVVM1c0SzlJZDFtTURLeHFadkdDSmlOYUFDRGtU?=
 =?utf-8?B?Q2hySjJUWFFCSHRrNTVFOVF0bm4yd004UVhod1g5RkJDNFhxMmV6Z2VTOFpn?=
 =?utf-8?B?Y2Y0bk1pSmZvWktCbVpHek1ZeWZlbUs4aWpURXFoZmpMLzUzYW1KUXY2NVhm?=
 =?utf-8?B?MVBLL0QxQUJXbnBSL0VCL1BJTURMR1ZacGhoaG5RL0krSEFHMnRuT0N1SlZh?=
 =?utf-8?B?Y1BBVlB0dk1QSlBzc2VhcGNZUXB2Mm45U241ZE4raHI5S3o3QlRGTjI5TGRH?=
 =?utf-8?B?ME1EVWwzZnhUNFBqQm5SZ3gwcStxUzNwOUV3aWlGbWVZSzA5WTRqY3lSMEVu?=
 =?utf-8?B?eEtOZWVtNXJLQjBIR2RDTGJoNXQrV3FYejdhNklpbjFzMUg5cXU5WWxldjZK?=
 =?utf-8?B?NHlQRmZZdlFLOE9YVUlqOGNVU0cwczVJLzJyR3VHb1pDSXpZNU02Ujg2cHM2?=
 =?utf-8?B?bGVWMjJjdU12dnp2QUxvQlhkVkU1akM0OFRidmgwTTM5VXdWbFUxZTF6dGI0?=
 =?utf-8?B?bWl2Vllmd1l1M25qVk0yVnBGMXkyM1lPeTFiWm9SM1h3ZHZUMkRtdWM3MzJG?=
 =?utf-8?B?TU94VDkwUjBrU0ZLTWtjNEJaaXdpYWJNWitYNmppcE5RSktyNEZSam5RMUZR?=
 =?utf-8?B?Qy9RV0dBZWlBSHM5R3FScm1Fdk9vYlZKanlLMTgvYVVZbFhxYWMyaXJRSmZX?=
 =?utf-8?B?RjMvU201eEJZd0IvN2p3UCtkbW9qYlBXRzN6NHYySklWQ3A0ZGRZVkc0dVMr?=
 =?utf-8?B?dWVPdE9jcDdVTzdPYjZmVGNpS0QvMWN2WnZ3N0RGL2tnR0JvdUdqREc3MGJW?=
 =?utf-8?B?QkV1RGFlWmxMeXJXQmtWd25MdXBEK2VhY2FuMmtVZHdaa1VmSUVuSXZ4VHNi?=
 =?utf-8?B?UFc2cndUZ0RTWFhsTTc4d2ZSSGJpVThsVzJtaGtmSitIZXNsTS8xS3Bza2FJ?=
 =?utf-8?B?elppeVArY1J0c1IzdjYwcW1vdytkRXZzTS8yNXVLUTdVb1VxUlB3dUxFRk1B?=
 =?utf-8?B?TGFHUFZuaE9Ia1pUazJDODhkOHMrRWhZaVNNbTJhSTlrSlkrN0o2S2xET0tK?=
 =?utf-8?B?OGdzc1Q2YjVYUHowQ2h4Vnk1ZTFXT2oxdWdCVUNmb0hta3NKeHpaZVRlYis0?=
 =?utf-8?B?UnVQMDhGZDFvR1Nmd3BLV0pGdjRDVDhWZGI4TWFlMkR1YmRzTmxXK3AxSWdZ?=
 =?utf-8?Q?TPOGjaMWWIZhVm8FxZ2KBlnyJ?=
X-Forefront-Antispam-Report:
 CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(19092799006)(376014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
 qvAi8HbtIkMr3Kt1aw67U27JTTJIti0d++mgNLg48u6oaPUhQAotdrW29M4W26MjsmhI9jB5V9y572FqX2UeMb5iAZ0Yv40U9Faon576g2rw38F3sZkC7aYzHKlY1ORGjBcFxZUrSDkQw4J1hH8RC8R1Imz9T4hzOtc5J6sZD4OpMTnbB6zAY03pSP4z3P18ZHaWzlrXTLf0Mdn7KzpAm+AR+caOhvnDP3Bewq6kJkpxq+qgXwGUry7il4mYU99YsiT3GkA5ABmIFyDt+/pQiWSZYz53v/EbNRX9PdtRK5FriAMbaMzdDrMOoFQ20NSvzmfvchssL99Zn6vawS6SIKqcvIl8xbeOm9hU5JQct8J34qdogI/GjKNEAjsvCp+oI/e7kK7Du7qGH7Eo6/ys7flIUK/BJj2NEigg043go6O2mcCV46W0poreg3wUq4NstD9RRGzo9axepSsZAhIh0gfUb/a8yu/NqtSBlu/tlMPyc051wMOMoDenEIHb27D2HUMRo7WVm0p2OMKTfy004+HPjll7VF8Su1ynTewWrhwBI3LW6iSE/1avnZoLujlgwe/RECq45O+NvqrHCg4en2Ww4k+GvtPkeOUW5kDdkAJKpXr8sGPbp58U48idTB36mk2efiDgiS/1cfEXsrveUQ==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 10:06:46.7038
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 556742bc-7ce3-46b6-47af-08de02648ff3
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
 MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB3978
X-OriginatorOrg: ddn.com
X-BESS-ID: 1759488080-111483-7666-101755-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 40.107.200.115
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVqamhoZAVgZQ0CTZIDnN0CTF0M
	TQyNI42dIkJcU01cLAINHcJDXN0sBEqTYWACYedNNBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.267935 [from 
	cloudscan13-135.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Add per-CPU and per-NUMA node bitmasks to track which
io-uring queues are registered.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev_uring.c   | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dev_uring_i.h |  9 +++++++++
 2 files changed, 63 insertions(+)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 0f5ab27dacb66c9f5f10eac2713d9bd3eb4c26da..dacc07f5b5b1a48acefa278279f851c3ae2b1489 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -18,6 +18,8 @@ MODULE_PARM_DESC(enable_uring,
 
 #define FUSE_URING_IOV_SEGS 2 /* header and payload */
 
+/* Number of queued fuse requests until a queue is considered full */
+#define FUSE_URING_QUEUE_THRESHOLD 5
 
 bool fuse_uring_enabled(void)
 {
@@ -184,6 +186,18 @@ bool fuse_uring_request_expired(struct fuse_conn *fc)
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
@@ -215,11 +229,32 @@ void fuse_uring_destruct(struct fuse_conn *fc)
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
@@ -229,11 +264,14 @@ static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
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
@@ -242,6 +280,10 @@ static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
 	max_payload_size = max(FUSE_MIN_READ_BUFFER, fc->max_write);
 	max_payload_size = max(max_payload_size, fc->max_pages * PAGE_SIZE);
 
+	err = fuse_ring_create_q_masks(ring);
+	if (err)
+		goto out_err;
+
 	spin_lock(&fc->lock);
 	if (fc->ring) {
 		/* race, another thread created the ring in the meantime */
@@ -261,6 +303,7 @@ static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
 	return ring;
 
 out_err:
+	fuse_ring_destruct_q_masks(ring);
 	kfree(ring->queues);
 	kfree(ring);
 	return res;
@@ -423,6 +466,7 @@ static void fuse_uring_log_ent_state(struct fuse_ring *ring)
 			pr_info(" ent-commit-queue ring=%p qid=%d ent=%p state=%d\n",
 				ring, qid, ent, ent->state);
 		}
+
 		spin_unlock(&queue->lock);
 	}
 	ring->stop_debug_log = 1;
@@ -469,6 +513,7 @@ static void fuse_uring_async_stop_queues(struct work_struct *work)
 void fuse_uring_stop_queues(struct fuse_ring *ring)
 {
 	int qid;
+	int node;
 
 	for (qid = 0; qid < ring->max_nr_queues; qid++) {
 		struct fuse_ring_queue *queue = READ_ONCE(ring->queues[qid]);
@@ -479,6 +524,11 @@ void fuse_uring_stop_queues(struct fuse_ring *ring)
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
@@ -982,6 +1032,7 @@ static void fuse_uring_do_register(struct fuse_ring_ent *ent,
 	struct fuse_ring *ring = queue->ring;
 	struct fuse_conn *fc = ring->fc;
 	struct fuse_iqueue *fiq = &fc->iq;
+	int node = cpu_to_node(queue->qid);
 
 	fuse_uring_prepare_cancel(cmd, issue_flags, ent);
 
@@ -990,6 +1041,9 @@ static void fuse_uring_do_register(struct fuse_ring_ent *ent,
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


