Return-Path: <linux-fsdevel+bounces-63353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8CCBB674D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 12:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F0713B2750
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 10:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013852EA756;
	Fri,  3 Oct 2025 10:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="gcYEPwaH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBE581720
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Oct 2025 10:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759487962; cv=fail; b=Rp5GXUDgG79PuJA4Q9pRSCZoHPI8DxMuthw0MWysYumQwZ5pN78aiVjR5BM5x1uWxjpvQUzwKIqVQO9h4s5rAZtIKB9gxgQuyIprh4O3lJmeeoDUYYjERnTx7oeVpvH1dWw8xJ+/rKAigbhFlqMb57lZQ+RMOhrZXy55AGabKhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759487962; c=relaxed/simple;
	bh=oOiG3k/HM+GFPqoFhUUgZhWb8JYtwrJ+O1axAEZMenc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=W/tAoAwo4V8TGWJoTUjHQqSstzzAg3oTTYL9OZaXA2cRNUt1irpJu/afIu80ycVlwq6H/HQqKJChHmYdNwMa9JZDXCgzNFZXT/lCzVf0ersePMXi+fzFDDm9lg7/AaLcmXX0yU9p2USibLu+cuOXFj7vntt4vXlxaP0/ucJOl1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=gcYEPwaH; arc=fail smtp.client-ip=209.222.82.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022108.outbound.protection.outlook.com [40.107.209.108]) by mx-outbound23-140.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 03 Oct 2025 10:39:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GmJOeYhVqeemzKwbQYf9IX6rkX7IAPnE/R+lbOsSWwFVkq+RyeEHSm6l+Qbg4XALQCayu4e97uoMkrQjGfTneME14i9APkRRc4mX78TvIhC6OGOl33ut1Npw8XNH2U7U2oC9sC+i6HT8jkhw/dg4UdVJAGXqgnbO7ouKL0VZQsacN1F7mW7RjpSzD9Bxvf2aERCiOpxOHF3IUD/CYJ/ydKALwUP3SL4RZ+9bFtwv4RHWL9DKr4TjJ88dDNehfzi5YBUI2Ue5dIQZdi5aX+eEHDrYC2Wymvk8KetbPMky0YkjH7bFCOoFfQI5sTwlC1lGO8fgHSmFNIj1EPR8jevz7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2DvDQx/vlEwICa9fKcIl21xKVQJI5eN7aLsCrYixpKc=;
 b=Wy0Ww2Wrs8OSLxJPiwQViXgndK0xAfmrBdDPzdrUZo0NwvwBbRECqoOF2DmASdQyL6w9vu60fAnGkKtLyIZFc1fDd95hAUpyV36L3q+OiHwGdn0LLOas6WzVRtkZVUcXNiVcW7zQ3tby8CVmR22nE1ctgywGITene+ehqPAnYiXKCnQdqcnPsKYg35Zv5NnWPX41hZkcp6i7dawW1zJcaEv5Oqb3ymok+qjNaz3r9TmQ7Cpe8eYnkhV/p0cDHIR606MUzhKcDRwZMUmC5RrQaaUtYW+RpbswjY7SO4ycECcmZ3WPMkTwsZK1Abn+/9Szh6NBlPUAOpYs1Kgj+2bSHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=arm.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2DvDQx/vlEwICa9fKcIl21xKVQJI5eN7aLsCrYixpKc=;
 b=gcYEPwaH2TfskQj/Q4MpTlpIACDF7rCvf7YFHZJNc46/VUJSA7yXLA/TEbQ8u4b5lmxZuIFALEFrjKu4kgvcvm4A7g8Lx3a3FS2LEpop28JfOdlK80gLRTRHec0KxwVI/CAT0ZKquLxrNh89UJXl1y7ifeBvITywDGv3FhPmd+Q=
Received: from BYAPR11CA0067.namprd11.prod.outlook.com (2603:10b6:a03:80::44)
 by CY8PR19MB6939.namprd19.prod.outlook.com (2603:10b6:930:60::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Fri, 3 Oct
 2025 10:06:44 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:80:cafe::86) by BYAPR11CA0067.outlook.office365.com
 (2603:10b6:a03:80::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.16 via Frontend Transport; Fri,
 3 Oct 2025 10:06:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.15
 via Frontend Transport; Fri, 3 Oct 2025 10:06:43 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id E86E663;
	Fri,  3 Oct 2025 10:06:42 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH v2 0/7] fuse: {io-uring} Allow to reduce the number of
 queues and request distribution
Date: Fri, 03 Oct 2025 12:06:41 +0200
Message-Id: <20251003-reduced-nr-ring-queues_3-v2-0-742ff1a8fc58@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADGg32gC/42NQQ6CMBBFr0Jm7RgokYIr72GIqZ0RZmHRqRAN6
 d2tnMDle8l/f4XIKhzhWKygvEiUKWQwuwL86MLAKJQZTGkOpTUGlWn2TBgUVcKAz5lnjpcaG+e
 vtiNHnW0hzx/KN3lv6XOfeZT4mvSzPS3Vz/4RXSos0bmWa+u4s9yciMLeT3foU0pfwBWmO74AA
 AA=
X-Change-ID: 20250722-reduced-nr-ring-queues_3-6acb79dad978
To: Miklos Szeredi <miklos@szeredi.hu>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759486002; l=1868;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=oOiG3k/HM+GFPqoFhUUgZhWb8JYtwrJ+O1axAEZMenc=;
 b=h/t+kzY79wBiup3+deHFCyZVnD5OTfTfXSnl/aMSqwAB8BH4Os9WipTbHY+Rek32U5CPf2eb/
 CC0HoxNzrxCAOoQBA6QtIVKhk1ElAgz6ucxkNITEnTAXJrDEDWDUJ/b
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|CY8PR19MB6939:EE_
X-MS-Office365-Filtering-Correlation-Id: 96f95dd4-4744-4d3b-694e-08de02648e47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|82310400026|7416014|376014|36860700013|1800799024|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?NVNRZUZwblB4UUV3eG9VMkZXeHd3WkVKTWRpRnhFYjEvQzJiNzhrUktiQ2R2?=
 =?utf-8?B?Slc1TEd5Z0c3OVkrek1TaU9BaHJnaWtIN08xdXoydEwxZWFtNkdDaHMyYk0y?=
 =?utf-8?B?MklNUitoeTZpTlFWY084N2hkR2F0Kzlva1dCK1hpajExZzE4WHdXQXF0WnZG?=
 =?utf-8?B?ejBDWmV5dkFpamdtVTQydm1XMzRBV1lrWDc4bjZseHZwY0d3emZ2anZNRWlm?=
 =?utf-8?B?R2NLMGNtVEJiY0VITmhFbjFnTUE5bTdGL00wdW10Q25KUW9Iam9ibEwxMy8z?=
 =?utf-8?B?QUJMdTRYQytSNWg5OWNMOVpTMmR5azJVRk9VTmtpaWFqQURJWmFoN21SWkgx?=
 =?utf-8?B?RjhsUHdXQlRRWkN3ZGRycmNYNXpJOHJ1clFEL2JHQ3NIczBqSlMvZzdzN2JS?=
 =?utf-8?B?UC9HLytaRHV4NDQwMUsxZ0pldjNESDJUSVFIYkFqUjdSOGVEK2kza2xNTmdv?=
 =?utf-8?B?Uzg4RjR5WkRFWDNGMXpMWnhvbFptUjNHUTlhbFdSOHRKQ3UvTFFpRXNNcEVF?=
 =?utf-8?B?Q2IvVXZpSWdsQ2I3SVZ5alFnS09PQnA1VmxaaTVvZy8wSkQ5SzBjTlBlQmZl?=
 =?utf-8?B?NERRbnQybEFoNGV4MmJyVWJYUWFMWUVWQnB1elQ1ajYrYXRwZVc5YzcwMjR2?=
 =?utf-8?B?YmsxamRPSkRYdnIxc0V2d3Yxb0hlL25CT1ppQ2hoditqMTFaN3FNS2h2WGl0?=
 =?utf-8?B?cnlDbDVKcEV4bGo2bmNmYjdCMDM3a1FnQjZ0S29wQ2lKNmpIWXdMQUNsd096?=
 =?utf-8?B?T3UzbytWR3ZxeVo0akFhWkxxK0VONXpnSm1kNkdSSHdjQ1RWTEJuSUp5OWc5?=
 =?utf-8?B?d203VXpJMXhLWUhvOGxKZFM2aWRWMy9UMVhKcUNGdjF3UEZiWHQzenNBdFRR?=
 =?utf-8?B?bW40NnE4elJwcEpYOVRXWlhTMGNiOWRqbFJmK2piaG95Q3gzSDg2N3NmRFRU?=
 =?utf-8?B?MTQwTC81Q3VVN1F2N1NDVnVTMDVpNElyWHdLNTBRMnozcGhpSEdabzhTbWxX?=
 =?utf-8?B?b3IxaUVkMnJxUVB5QUc5bmE2ZTNYbTg2RUpFS1oyY1JQRjVkUTZPbUJpRTAr?=
 =?utf-8?B?MUtLWndjMVNkdU8zK2V3TE95cFZUNkFoYmFKcGQ1WFRIZHlnNmszSzU4SklJ?=
 =?utf-8?B?a0hvYXoxUW95Q0hTWExpb3hSZkFJS0NzSG9NNnl6TmJLbzlHaHBlQkdIZWgw?=
 =?utf-8?B?dmhWamVkL0ZRVEJCWWcvbjJ4RjlkSktES3NMditOMVJ0WUhRR3hzMk95WUVV?=
 =?utf-8?B?TC9pU2t5QTFhYVhERmFqNjdIT3NoMGRLOWZXNTJGYkpqa0F4c2w3aGE0dnAw?=
 =?utf-8?B?eFBYbnJMNEI5anF2c3NBdG0rbzRGK3pleE9tVEthVFRhOWZ5akRrdlBERWUw?=
 =?utf-8?B?VmdBbHdWTnBtUWJaOWIzY1pCRG4xZTZEbHByZzlZZ2o5QUpLbUxKN3o2ajhu?=
 =?utf-8?B?RWQzV3pOV25GanVsMzlZbTQvTS92bVc3SWtKSjBTbnFvdDUwcHVJSGFwSG9h?=
 =?utf-8?B?UlkvN1ZtZ0NnYUR6QWY3ZEdnSk44Vk1SQ0UweDQyMW1takZPbDZaa0hvNEdD?=
 =?utf-8?B?Tk52eG9BZnQwVDV0RVNua3hwVHA0dFZrNFZQUmN5NzlPQmlrVDRTa1k1aXB5?=
 =?utf-8?B?RWJYRGh2K1U3aFZINXA1N2dmVENDdkN4elVzd0RodDVkTG1aYXBveEk5SkpV?=
 =?utf-8?B?ck1HVkdFakpJRGpMcituUnFjZEhJdTRHc3dPekF6YmwrNTRMVkRMNll6aGdX?=
 =?utf-8?B?Ujk3dnduSDhyZ0IzYXdvQk9WZlppbTdyajVyTzBsNGZ2RHlwYkJWRHV1T3Zq?=
 =?utf-8?B?NFNPZGlVMXQxSjJWK1J1MVVGVHZlNkJqUzE5cmEvUU9CQUtOaC9IbGlnSUp3?=
 =?utf-8?B?cm1rN2liTG9LT3R1dU9wV2F0ZVhiNE1iSGc5RllXVnBQcy9VRXFoY01hV091?=
 =?utf-8?B?ZGQwQ282RHZnUStNbkFBdGpYWFMzQ0pmSENiUjgyZ29xeUk4SlVNTEl6UVVr?=
 =?utf-8?B?MnlLajNoK1lzNjhtZEFiVWpWa0VIT1g4L3NGdXhBRzhDcHh0TGZacW5ndHZa?=
 =?utf-8?B?dzFJcWpFMFpyRUtmL0x4Tld1eTV5WGxLaDRJY2drZmdQODg1QWw3K2QvZ2dH?=
 =?utf-8?Q?GHqFzxMoftCu5W/i+zCzNjruL?=
X-Forefront-Antispam-Report:
 CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(19092799006)(82310400026)(7416014)(376014)(36860700013)(1800799024)(13003099007)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
 fjnVGzGP9+ZJzAhcZ2KUPAuAgi8YsrnBykmU8glDb3/ifX5z2Ip05SDreEe0L4C93adpZorQv/vJ2/nIJbbmVyCJxZDZvSKbbpXL8zsX7cS87BxabiVsv3vtOQwvYvJMr7FNjRmzx+ZviplmVpuj17g2G55Rux3/ndNTAP+PJ2WGzYEl4VZ/4OwjDXg1NKJTIND5/bh1A/zEfLGT1rcs7QxBdtbS+L2jQNGbozBXP56RjWdM/KQSrOfpfhN+zYrk+iaK3uZIn/V+wMb+grOcIhvHjEqV8gsRqO9yYtg8qIicSSKTSre65Ds9nGNmPqW9kVG6MDidCbjTExmaCinjM6jx7tE8ecYaOtcAJxJRZU/4t7fLOzXRUx16nJDTiyM6q4L+5pii/mJtPtcAfLk/kUxRF6JltVfhwRkQQPZIbOApraWJz6lU+hJax6D9oa6GzVnBf0wQenHDBsOA1ncZ03v5j/yw8kaJlMygPa9V5x33BIUNX3YDv/XXajUFmgh8/1HnJXdiILkcTYRJ2Rw6/XQYiWQP0crruFzn3vONUbfQ2Z24qS5hxqFof6tUk9bWDBU2CMuJ5Rl+x9PZvhSENmqyi5nKVCmDXxDKHLgQNnZ02oW9aGo0aQck288/AmpDvP19oZlLNj0/xj1q8obUVg==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 10:06:43.9243
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96f95dd4-4744-4d3b-694e-08de02648e47
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
 SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR19MB6939
X-OriginatorOrg: ddn.com
X-BESS-ID: 1759487950-106028-2393-1717-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 40.107.209.108
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYWRqZAVgZQ0NIk0djYyCgl0c
	jAIsnAwjg5Ndko0SzZMsk4zdTU1DhNqTYWADs/LIBBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.267935 [from 
	cloudscan18-188.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

This adds bitmaps that track which queues are registered and which queues
do not have queued requests.
These bitmaps are then used to map from request core to queue
and also allow load distribution. NUMA affinity is handled and
fuse client/server protocol does not need changes, all is handled
in fuse client internally.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
Changes in v2:
- Overall code/logic changes, avail_q_masks were removed,
  decision which queue to use for a reqest was re-worked
  to achieve better balancing and performance
- Addressed Joannes comments. Thanks a lot for 
  kcalloc(..., sizeof(cpumask_var_t))!
- Added back optimizations that were part of fuse-io-uring to RFCv2,
  i.e. wake_up_on_current_cpu() for sync requests and
  queuing on a different cpu queue for async requests
- Added some benchmarks on the optimization commits.
- Link to v1: https://lore.kernel.org/r/20250722-reduced-nr-ring-queues_3-v1-0-aa8e37ae97e6@ddn.com

---
Bernd Schubert (7):
      fuse: {io-uring} Add queue length counters
      fuse: {io-uring} Rename ring->nr_queues to max_nr_queues
      fuse: {io-uring} Use bitmaps to track registered queues
      fuse: {io-uring} Distribute load among queues
      fuse: {io-uring} Allow reduced number of ring queues
      fuse: {io-uring} Queue background requests on a different core
      fuse: Wake requests on the same cpu

 fs/fuse/dev.c         |   8 +-
 fs/fuse/dev_uring.c   | 253 +++++++++++++++++++++++++++++++++++++++-----------
 fs/fuse/dev_uring_i.h |  14 ++-
 include/linux/wait.h  |   6 +-
 kernel/sched/wait.c   |  12 +++
 5 files changed, 234 insertions(+), 59 deletions(-)
---
base-commit: 8b789f2b7602a818e7c7488c74414fae21392b63
change-id: 20250722-reduced-nr-ring-queues_3-6acb79dad978

Best regards,
-- 
Bernd Schubert <bschubert@ddn.com>


