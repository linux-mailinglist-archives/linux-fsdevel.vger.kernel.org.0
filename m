Return-Path: <linux-fsdevel+bounces-63354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C058BB6774
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 12:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AAE019E1B66
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 10:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B462EAB94;
	Fri,  3 Oct 2025 10:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="NA17ZJ9U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DDE2EB861
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Oct 2025 10:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759487992; cv=fail; b=s9zn/SBncrNN2OYmHUg/5KokK+oAoL58WRa73uLSb99EC5lQNfSPkpuLrcxIXKMAdLhvpu+I9ipJFzaleDavk/5nDjonh9DUbrjlmT6inT4qbISpJptUHUqZ7piqXBJ3DZQEoXvY2N67LUkVoZMILF71TbX32XI9FwiiwUxzj3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759487992; c=relaxed/simple;
	bh=HcniHGAKZqZgUm7JOgqhNxGrJnrOjHgdaTMgj1Z5dL8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lg+8JLQPWoiwRLg8Xp+4mHPvSfnuapzjLwo84xnOg1be4z3mrdyGA0L9ZgyOr6aokV5LkZofGeVVQTLr8dek/hAmH9+JuSYQDvlx7Y5NBLPiRfkE54NffGPVweJ7Qtt7EJ0ZqdDPy0VvT6nZNoqoX3NnYsiBgh64k6HbrX2TO1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=NA17ZJ9U; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023138.outbound.protection.outlook.com [40.93.196.138]) by mx-outbound-ea9-35.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 03 Oct 2025 10:39:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kh2GGxEDnHbb4bRsAVpNCPlVgtm5sygy+aEcNbvFmRiiwaJrIZvGtkA4rE+rpK5RQDL8mpfpEv9XVAGW90Ynnx6IfT+iJfc6dmvPAPKKeEA4F5xuF+hyLNlUHP2kzCRWGV9Hprp/YNw0XJTLMNhqy8oCUzI+0MjZiK8F1fYA7TIIZdAUw2KNT/8aD4Wj+qPUp3iD8zPMcfU3GitA34pbPKTBM8i1GDuGjDj+tMEb7NWRAK3CgR1F8ZvKOw8boqIF++/msS50sWXTFlsdudfbQsImuy9GVCDGAvT/CDyWKXz3nAvQqKXTV+xDPhdQYnrYnicYgeOxfkO8ILkpkeLAzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4sg1ZposYPKE3Yo3m56o/3mXmQW0cQTHxx9RLsQDwc=;
 b=ByF4oRGdEhiY4KQx9dBpTKCQxovh73xohw8sI0MEDJY2n2fEkshK1nru8WGTcrxu68YGdXsyMXPlrllWBB7841aflm3RPebP+x/av6bdwYkOCQ8MeS8UHCyyxr3qWZViZajf1neZ1pSY68KPpYPCa+p2OXVq+1OKWP42VFoDsO1uxhO21v8T+d7IGGHby+PvQpkKtsNtOZ8M3RbkKOOXHV8N2O4cUEUCPO9flHV4IolpBDRbjDdK5EhxP2gFvlBCcUK+6bk1kU6rM1oA9XidNU2dYYW9KFFB4mYvGbNSzk18WEHDRWLqp8JKOF2yfBVDaf+V2rs5DSdLjlWbZja4ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=arm.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4sg1ZposYPKE3Yo3m56o/3mXmQW0cQTHxx9RLsQDwc=;
 b=NA17ZJ9UtVbQ5e2mOAy+Qc8PdxDKdFpg3ofqCl02BCu+UB4A9tmoJjA2+YUY6qgfKH1+tA1bkPKRMQ0PpJ7hfIt/D9MFyUaQnvU4m9AasJ1mJUhXzTlnAyn/TkwhqH88gSv4IU+gsUTSaXe+Aby25QwyEhWc3i7UpJjSN0Ayk6o=
Received: from SJ0PR13CA0031.namprd13.prod.outlook.com (2603:10b6:a03:2c2::6)
 by SA0PR19MB4207.namprd19.prod.outlook.com (2603:10b6:806:82::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Fri, 3 Oct
 2025 10:06:48 +0000
Received: from SJ5PEPF000001EE.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::48) by SJ0PR13CA0031.outlook.office365.com
 (2603:10b6:a03:2c2::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.14 via Frontend Transport; Fri,
 3 Oct 2025 10:06:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 SJ5PEPF000001EE.mail.protection.outlook.com (10.167.242.202) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.15
 via Frontend Transport; Fri, 3 Oct 2025 10:06:47 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id BFDE963;
	Fri,  3 Oct 2025 10:06:46 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Fri, 03 Oct 2025 12:06:45 +0200
Subject: [PATCH v2 4/7] fuse: {io-uring} Distribute load among queues
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-reduced-nr-ring-queues_3-v2-4-742ff1a8fc58@ddn.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759486002; l=4620;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=HcniHGAKZqZgUm7JOgqhNxGrJnrOjHgdaTMgj1Z5dL8=;
 b=IcsMJtwmlXZJI8sqWmeeE2Y2qESrNxJZqtbUUkdXN2crYry4qqr8M7Ao6J0WFmVH1VFBYm3SY
 Occ4uO1lxgrCzn4wVhD2D9pA3X8HxLUXWjC+7CPFFoOO+Mb2i+1yRCU
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EE:EE_|SA0PR19MB4207:EE_
X-MS-Office365-Filtering-Correlation-Id: 43918196-d486-486f-f9e7-08de02649085
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|19092799006|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?RWxrb3BiN1pudVNKQ3ZhQzYra3J5Rjc1TWVJaHZHMVJjUTc5R0RBWUdHcUVv?=
 =?utf-8?B?SEprT3FBZVVxdEtpV2VXMGVLSS85TGhyWnNBOEpBcUJJVDhWcktkanhncnpi?=
 =?utf-8?B?SE1OQjgxWlhIckx5OGExOEY4R2VxTkFSbVg0T0N4aVh5T0dQQzF5bDd2Z3Fz?=
 =?utf-8?B?WHF2SzN3cnJqMTVUK3RuMHVyVGVVVUp1dEVPZXRHV3ZXVlN0STR4Y2VrbENo?=
 =?utf-8?B?WkludlpMRVp5WXBZR2hnVmJLNWloRVBvUzBia2lTOHVyNHRnUlZIOG1hV2Zi?=
 =?utf-8?B?dFhuWENhQnFzNU5XSUJ0dFRhOFQ3ckZ4Y1p3Qlh1b1RFNHFPWTVwSlJqajdC?=
 =?utf-8?B?dmpranBpZUtxcjVoQ0JaaDMxWGxzeElCY296VkFvRUg2WXIzNlZ5TTFsd29M?=
 =?utf-8?B?NmZhQ3RSbWJiMW9SZi9VeWx1RE5GYWpYNzZHc1I4cmJyeUZEOWhPZG5KM2cx?=
 =?utf-8?B?RUdQVXgvVFBpSVZKdGc3YmhwcHo4aUFwaHQ1Z0dwWWlTSHZ0eWdDUVRoZG12?=
 =?utf-8?B?Vkc2Qjc4SHZSUE1zcWRGQXAvbkRPNDdaa2dzSEtWcWFqNGU4SEVGZ3dFSFBn?=
 =?utf-8?B?ZmpnWlAxZFBxQ2pISDlGcVpvQWtmNjRBbVNPYzN2RWRlVGdYSzRZSVVpcVJn?=
 =?utf-8?B?bURkN2w5RFN4NUh1NVdWRmkwQjJhM0hkUEplL0ZCVVVlNEprQ2tQY0VqcVRK?=
 =?utf-8?B?Mlk2TUVLU2JVZmlNN29mRFFlVnBERFNWeWxBbGVpYVFrbmV5YXFzMFBoaHBL?=
 =?utf-8?B?OUt0SFpnSlhQQndBWVhkS0U4S0VFTlpvZlU1MnJCamlVZk9SSkdkbW9IajZ1?=
 =?utf-8?B?S25jaUU0azJ4c2VRZnVLcjlzVm9qQlhONkVweERDc1N6TjNoTkJmK2ZNRFZK?=
 =?utf-8?B?eTFaVmh6elFVWDV5a01KMWxWcklROTdYUkhYbU5DR05BaXpRMld0RlRBeVY3?=
 =?utf-8?B?a2QxNTIzOVppNWJkSy95RmpaMlk3SFZTQUpZQ1lKdVZxdEE5K05lMGYxRGlT?=
 =?utf-8?B?cVduTTVUZjMrVmNsRmdTRS9DYnovQkJyQnBrdnZpMzBJOGFtYUtvcElGN2xZ?=
 =?utf-8?B?R2ZzRVZJQi9ENU42bUJmS213TW9NY0Uyb0tmMnpVSVlUREZ3Z1BRdTNTQXVy?=
 =?utf-8?B?ajMrck1PUnd6V0dNOFNVWFBuTENBU2tDRmE1bmNNTTVKcjBGcFFrR1ZMeU56?=
 =?utf-8?B?bndYSWorZnFaTUZEU1QySnhOWkxZVkNoczNSSmoxMmZ6SlUwb2xERWxQbk5x?=
 =?utf-8?B?THZIN3lDSFBQWVp4MHNPdElqMTAySjMrT211K0k1MmxxQ0oyZERvNWl6RVBJ?=
 =?utf-8?B?ZnhGZVFITW1JdmFkQ0pHS0tQeGN2VmxKSlBOcEpiMWZFYTVzcjlwcmdueVFB?=
 =?utf-8?B?SFBIalZBc1hqRWpWdlZ5aUlvSEZYOXdZOHl2ZjNDQkxsai80cTZGMlBtVUxx?=
 =?utf-8?B?blJtSDBmc1M3ekFidTZIbG9heEhnK2hXeFlGL1NsdklOSnpDdHd0SU9PcXQ5?=
 =?utf-8?B?WjZGT1FFYVJ4RCtva2Uxdys1SmQyazdUMGNBMGdsVEpybi95QVdjajk3eFE4?=
 =?utf-8?B?MUJraFp3WkZFRFhCdWNKTWRtdytkSmhHU2p6UXM5NnlzV1hQRE5UdXZuL1hl?=
 =?utf-8?B?Y0tESCtVQkdSRzNqSzY3MzdvNEdUSjI5YUJCdHpwSHFlOUpYSm5PcWdTckFo?=
 =?utf-8?B?dEFOWG1md1BXOHJhZGtINWRwTUJlM0dHUHJCWXFBUVpQYmJhN2xCMFFvZGJD?=
 =?utf-8?B?NzM2bW8wTDBtVTNFeUxETFh6UjhFd214bHBNanhQNDBZcVNqZ204RlVUc0dR?=
 =?utf-8?B?eVNYZTQwYzRGMXVkalhydjV2MzR3YlJMdkVoMHlkUU1mS1A2NWtxUFY5S0kr?=
 =?utf-8?B?LzlvWWtBeXdhandwREZUMk1sbVRGRXNjRk96YXpUSU5CdGxyalp5aHFWb2dD?=
 =?utf-8?B?WHZGa3BlUGx2VHdtVG9yK2NFOWc4MGJzNytRdm1WOThXdWJ0b3BqMzd5TnBj?=
 =?utf-8?B?dmdrVDQzbG5UanNIOVE4Um5aSzlmMzJ4SW1XOEtIV25QNXhSdjRQQVlzQVlU?=
 =?utf-8?B?dm00SGp5Q3docngyckJ2dzZMS213UmlaTllvam9MZjIwQzNiVVBSMXhJdmpF?=
 =?utf-8?Q?WHXW2GRxHVOt3+iX6JQY8YkYS?=
X-Forefront-Antispam-Report:
 CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(19092799006)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
 y8AnohRM+kV5vGtYAoRjBqj0fm8FSaQwgzNs6UeMpt3fVhYxu98moF6RHR8vLUE9H08j7MsmmjI6t5sPVpDHr3F/q7aF082+mcfV8nHyrzRHlk/3M7Lqeddhm7TipLKv8DyriZOJJNm+gi+q/fHgVb3q71aG5uA3GaNvhwAemxIHiG3E8hj1fjfkqi3QaG7EC5gDA6k+xLejQf1L4mn10znB+FZRKWiHAh1sE/04tX4Tk6iOG3JEr/VbyaXKALPTE4LPimWaxkGhHL4mHdm5xG1YlMt7K5toRVq+kCz2d5GxndVOZADPqp/mjGYS5gr3reUWjzA3fuPLvmiZMIPt5a2DQqyS0sY7gHB31rvvH8PHg8soUGuFFnqc7GJlMRPip5Namm5tWkcnwFeDqWwuvZXI8pQZoMmtsnq6zVO24GQTVmbU7mSilF+O8BfqFdSBsIZCaJB5cQfBMcmGgE3EUJSE4uGe48jHKUqLgU6a+9688467ejn05BD/PBhO/uIBITwq6h5ekV+VyKRFCx69OZLko1zJpkxYOJpyUN6w+whxjBypjd6NyGQ0E0R/RYQxfYxIIiuydyRRDprilxwG8unxIoOZEJxXug8ny/xhsH45aAYTn+whFhXQrIJF8Q/JDQ84GnUCpLJFf8boWWP1Ng==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 10:06:47.6909
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43918196-d486-486f-f9e7-08de02649085
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
 SJ5PEPF000001EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR19MB4207
X-OriginatorOrg: ddn.com
X-BESS-ID: 1759487987-102339-5138-1350-1
X-BESS-VER: 2019.3_20251001.1824
X-BESS-Apparent-Source-IP: 40.93.196.138
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKViYm5uZAVgZQ0MzUPNnSIC3F0s
	jQ2DzZwtTQzDAt0dIy0cgi2dA81cJMqTYWAIW8WhZBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.267935 [from 
	cloudscan18-99.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

So far queue selection was only for the queue corresponding
to the current core.
A previous commit introduced bitmaps that track which queues
are available - queue selection can make use of these bitmaps
and try to find another queue if the current one is loaded.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev_uring.c | 88 +++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 79 insertions(+), 9 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index dacc07f5b5b1a48acefa278279f851c3ae2b1489..bb5d7a98536963ec2e4c10982d33633db2573f4d 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -19,7 +19,9 @@ MODULE_PARM_DESC(enable_uring,
 #define FUSE_URING_IOV_SEGS 2 /* header and payload */
 
 /* Number of queued fuse requests until a queue is considered full */
-#define FUSE_URING_QUEUE_THRESHOLD 5
+#define FURING_Q_LOCAL_THRESHOLD 2
+#define FURING_Q_NUMA_THRESHOLD (FURING_Q_LOCAL_THRESHOLD + 1)
+#define FURING_Q_GLOBAL_THRESHOLD (FURING_Q_LOCAL_THRESHOLD * 2)
 
 bool fuse_uring_enabled(void)
 {
@@ -1283,22 +1285,90 @@ static void fuse_uring_send_in_task(struct io_uring_cmd *cmd,
 	fuse_uring_send(ent, cmd, err, issue_flags);
 }
 
-static struct fuse_ring_queue *fuse_uring_task_to_queue(struct fuse_ring *ring)
+/*
+ * Pick best queue from mask. Follows the algorithm described in
+ * "The Power of Two Choices in Randomized Load Balancing"
+ *  (Michael David Mitzenmacher, 1991)
+ */
+static struct fuse_ring_queue *fuse_uring_best_queue(const struct cpumask *mask,
+						     struct fuse_ring *ring)
+{
+	unsigned int qid1, qid2;
+	struct fuse_ring_queue *queue1, *queue2;
+	int weight = cpumask_weight(mask);
+
+	if (weight == 0)
+		return NULL;
+
+	if (weight == 1) {
+		qid1 = cpumask_first(mask);
+		return READ_ONCE(ring->queues[qid1]);
+	}
+
+	/* Get two different queues using optimized bounded random */
+	qid1 = cpumask_nth(get_random_u32_below(weight), mask);
+	queue1 = READ_ONCE(ring->queues[qid1]);
+
+	do {
+		qid2 = cpumask_nth(get_random_u32_below(weight), mask);
+	} while (qid2 == qid1);
+
+	queue2 = READ_ONCE(ring->queues[qid2]);
+
+	/* Return lowest loaded queue */
+	if (!queue1)
+		return queue2;
+	if (!queue2)
+		return queue1;
+
+	return (queue1->nr_reqs <= queue2->nr_reqs) ? queue1 : queue2;
+}
+
+/*
+ * Get the best queue for the current CPU
+ */
+static struct fuse_ring_queue *fuse_uring_get_queue(struct fuse_ring *ring)
 {
 	unsigned int qid;
-	struct fuse_ring_queue *queue;
+	struct fuse_ring_queue *local_queue, *best_numa, *best_global;
+	int local_node;
+	const struct cpumask *numa_mask, *global_mask;
 
 	qid = task_cpu(current);
-
 	if (WARN_ONCE(qid >= ring->max_nr_queues,
 		      "Core number (%u) exceeds nr queues (%zu)\n", qid,
 		      ring->max_nr_queues))
 		qid = 0;
 
-	queue = ring->queues[qid];
-	WARN_ONCE(!queue, "Missing queue for qid %d\n", qid);
+	local_queue = READ_ONCE(ring->queues[qid]);
+	local_node = cpu_to_node(qid);
 
-	return queue;
+	/* Fast path: if local queue exists and is not overloaded, use it */
+	if (local_queue && local_queue->nr_reqs <= FURING_Q_LOCAL_THRESHOLD)
+		return local_queue;
+
+	/* Find best NUMA-local queue */
+	numa_mask = ring->numa_registered_q_mask[local_node];
+	best_numa = fuse_uring_best_queue(numa_mask, ring);
+
+	/* If NUMA queue is under threshold, use it */
+	if (best_numa && best_numa->nr_reqs <= FURING_Q_NUMA_THRESHOLD)
+		return best_numa;
+
+	/* NUMA queues above threshold, try global queues */
+	global_mask = ring->registered_q_mask;
+	best_global = fuse_uring_best_queue(global_mask, ring);
+
+	/* Might happen during tear down */
+	if (!best_global)
+		return NULL;
+
+	/* If global queue is under double threshold, use it */
+	if (best_global->nr_reqs <= FURING_Q_GLOBAL_THRESHOLD)
+		return best_global;
+
+	/* Fall back to best available queue */
+	return best_numa ? best_numa : best_global;
 }
 
 static void fuse_uring_dispatch_ent(struct fuse_ring_ent *ent)
@@ -1319,7 +1389,7 @@ void fuse_uring_queue_fuse_req(struct fuse_iqueue *fiq, struct fuse_req *req)
 	int err;
 
 	err = -EINVAL;
-	queue = fuse_uring_task_to_queue(ring);
+	queue = fuse_uring_get_queue(ring);
 	if (!queue)
 		goto err;
 
@@ -1364,7 +1434,7 @@ bool fuse_uring_queue_bq_req(struct fuse_req *req)
 	struct fuse_ring_queue *queue;
 	struct fuse_ring_ent *ent = NULL;
 
-	queue = fuse_uring_task_to_queue(ring);
+	queue = fuse_uring_get_queue(ring);
 	if (!queue)
 		return false;
 

-- 
2.43.0


