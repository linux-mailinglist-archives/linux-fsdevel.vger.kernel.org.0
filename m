Return-Path: <linux-fsdevel+bounces-63357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 424B1BB6789
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 12:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E1BDD4EB794
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 10:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7623F2EB872;
	Fri,  3 Oct 2025 10:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="Ra5qyMcM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DC92EB848
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Oct 2025 10:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759488015; cv=fail; b=EnxKjhARBQ9YOVvWqIumjvxkV1h0zR54hKd9WAzKizpf+WcMUNJAqanQLG5mt9hOp7MziIVM2y64LK6LwMD0rUuTY0lbYec2RFVzt3TU97H1fJgMfL8y3ZaSamjZ8SZ8SYbmuN5PoxQIdocsJ0ymj+zogQQKg8msMmHoEABptVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759488015; c=relaxed/simple;
	bh=VOnGWVBVd+T+ocK6db6fafbEpDu55jt0L4CkkQ4slRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ujJol5fYYWOJEw70VqBA+rIBnOBvOJJfQwnPdrZ98h6+e4LD2wwoJBmR27VVMExQKZT6p3ZZ+JJ0qKaziCEEDo7N+es/qq+q8BYAtoc3AQ3cAlAGYRjq8bmZXUqhDnCX9Cnmcnwu82i4xDg3YiG0HRGYak/PesN7TNQGQYLbVWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=Ra5qyMcM; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11022116.outbound.protection.outlook.com [52.101.48.116]) by mx-outbound12-132.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 03 Oct 2025 10:40:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AGJ3oXQAJ5rS3/ULezfbO4todpM+kcGVY7gBgmkkcNaHWTBiLQ90Kv0J20JVSJM3fCSAJTe2Wnfu5yn8UXOE3K5r/Gf0UX9K8DWQ19dyPK/GperldtDzk9td+vY4azjUc8AivrrZP2pGQTV2UpZcgpn/s2U13iZVAJW0MFBew+zBrtirxwJuCuQmKxfIA6N9nXzKFq7H/rbwZKY7WScJYqQR0N/OinPwwDTSSy+F6byY2q5+DH6aMetbSitOfl1Olr9m4u2/qPpvRoPgozks2+KWgqAa22ilQLkCPolcr7ZvIA4VcMw9VJQULj/Zw9KKNwQUjrubpn2LNGuUes/Hmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YifxhdPN3bbFAgY/U+xVi+lepjolg9gcoar6GYEa2Gw=;
 b=EVVYt/dXYvtp7yAsM/9ST+yvGGSgk3ZHHP5/qCdzP0ZqKlB8UaoDuU9GBW0GZNuoErld3zSOaqvmHpVrvuU705bT6wMPmxGAKWc2qYSvV+w80AAg5tZamH9vBKRSrPBU53ZvQAAWLaSCNFYPqDKIV0YdHpYzeZ+WRqaMQxCEzB1+u4JjSy2l05l9Kj2uPf3w8LhDmP0PA+CXg5El7LSk96kL2/mQ18QFH1Hpq5DeZi5iOS8VbhXrtj5MaKAHsIgajBOa94jhQJElAGOtoOT53uXtv+N3pcJY24BgoGRajTsok9cDHwy4K0p+/LN7bkOoYTq/WSQYJkn6ko6xoh8Gng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=arm.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YifxhdPN3bbFAgY/U+xVi+lepjolg9gcoar6GYEa2Gw=;
 b=Ra5qyMcM3P2ZQKB1phgR2xLanIBZk46iFIdS5YW8ur7FVnpUhn5f82LN51WIRpX5Uyuo4WGVlI2iNaJ6G47mxroGjRGvyaqbyAdztjIrR2KQ/9hiPjZrXTgf3vBpEj4CeGxPW374R7owOk9ZNy8C7Ed+JFQLER1KaQiZJ/WnWvQ=
Received: from MW4PR04CA0381.namprd04.prod.outlook.com (2603:10b6:303:81::26)
 by DS4PPFA68F52737.namprd19.prod.outlook.com (2603:10b6:f:fc00::a40) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Fri, 3 Oct
 2025 10:06:46 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:303:81:cafe::af) by MW4PR04CA0381.outlook.office365.com
 (2603:10b6:303:81::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.14 via Frontend Transport; Fri,
 3 Oct 2025 10:06:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.15
 via Frontend Transport; Fri, 3 Oct 2025 10:06:45 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id D5BE063;
	Fri,  3 Oct 2025 10:06:44 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Fri, 03 Oct 2025 12:06:43 +0200
Subject: [PATCH v2 2/7] fuse: {io-uring} Rename ring->nr_queues to
 max_nr_queues
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-reduced-nr-ring-queues_3-v2-2-742ff1a8fc58@ddn.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759486002; l=4316;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=VOnGWVBVd+T+ocK6db6fafbEpDu55jt0L4CkkQ4slRc=;
 b=CYNSbNUmSa4npoj8IwLwCnDpZlolgaHDodzg50JB8irfuVreGtqt+kKqSCtrAUW3cTYSX1Yu5
 og4SxDcHP/yAWHy0TOuYRW4vYlaxz+N6sVachm4qFJQG/s6uhh7Mi36
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|DS4PPFA68F52737:EE_
X-MS-Office365-Filtering-Correlation-Id: 22a3bc3e-e2f1-4e86-82df-08de02648f52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|19092799006|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?Q2I1Mk9pSEUzYXZOYklWcnpPdWE1aWZSa0k4QXZVdEdIWWxidHVBRmlkWHp5?=
 =?utf-8?B?SjdXRkxSMW5kOTZIT0NoZHJQYU9uYUczaGdSWUVYajBBNHhzdmVwSkw0d25n?=
 =?utf-8?B?Slg0bExXbVhBMHZFSWY3ckJZWEtPaHVHTE1XNWczbTNGYy9oRGYybGlYRS9v?=
 =?utf-8?B?Y3hBR1pJZ1hrWUVqSkxxenl3bXJOQ2J4VDRERHdCQ3JyS0FpdDdlYmQ4dEl6?=
 =?utf-8?B?cE44Zkd6V2ZMZkxSR2d3QzJWSlhBOVd3ajQ2UkpXbGtpV3dtZVFtZjI4eHVZ?=
 =?utf-8?B?OUtGQ3I3QmNOcWpGRURnRVc3YUttY0c1ZDkrM1V4T2VoN2h6UHVYM284b29l?=
 =?utf-8?B?RmFZTStFV3E1RytWQVFSa2lUV2J0c21nMVRGVXlrSkErWk9XVVFTOUszY1Vx?=
 =?utf-8?B?dlR6TVM0RjNialJCYmNVazN0cUhsQnlnTnZyZ3pUSTZvdWpoU0l0NXJmVmVC?=
 =?utf-8?B?bFJzSVlYUXEyc0ptSDEyTjcxWlZ3SmxKSVhXcllZdFphUDE3SzNJRzlNSlhZ?=
 =?utf-8?B?bE9MNEZ2S0crblRVU2pQOVduSTdURWZ3VkE4OTRESWhIUmJKZWM0TXF1Zlor?=
 =?utf-8?B?QzY4bVdTaUpVbnlNWEJVU2d5MEtlRnl3cFFYMGR3NDlsaUg4NVgrMzhuVGRa?=
 =?utf-8?B?RzdBMHg3bTEwN2pnblFHd1FOZWhVSE9LWGlLZFpGdkYybk8yKzhScHR1RlVj?=
 =?utf-8?B?elZwU2JmOHpJVFRFTGUxRUhvQWFYOURKd0FlaHJFSTlEamxGWmhhVW1lb2lG?=
 =?utf-8?B?dHh4Skw4NlMyMkJMTCszZ1VqWHFscUhWVlFRa0xoT1dJV1A3NFdzTUd0cU80?=
 =?utf-8?B?d0NsWlN1bjV4enpDT0hWSFZMRDBLMnI4amw4MHZ0MEQybER0WlJOdFB2QnBZ?=
 =?utf-8?B?bGZYbHFjdkVTZFEydDJCRUxtRUcyQkNWQUMzZCtPOFRtYUJMQ2FKeVEvYUJU?=
 =?utf-8?B?eWM2cCtBNkZkT0x2QVZ4Zm0wZkhpZUFXcHRkaEFKbld0cXluMUZ6T0traUpU?=
 =?utf-8?B?RGpTbkIrSk9iTnBsaWJxcWZjNkljN2FyK0tvYUZJVzFGTmU3VGx1WXVzbGpQ?=
 =?utf-8?B?MXdEZWxmckZOYWlSWER0OEJMekR2dmNqTTFIMTEySUNxMmgzbHVsL2d5MDhx?=
 =?utf-8?B?TlppWWxSNVFKVkFXSExoYXg4ZklSYzR4NnZ4MDlLcEVDc2dYSmY1ZlV3b3pq?=
 =?utf-8?B?d1JNM0twWTlpWmVRZTIxT2RObkRNSHd3djJrbTdCaGdGZk1nSkI4OXVQRU1m?=
 =?utf-8?B?bVNydGNvNkszN3JPNVNUUmZXbEI1TXlIRHNKM1F1dklyOFREKzI5RnNVb2ZN?=
 =?utf-8?B?cmlDdlhEL1hsZjF6SWVhbG1zejNnODJYUVVJdUM1d1FrNU5CUnJUeFJ1Y2pv?=
 =?utf-8?B?a0s5ZUcwdWUxMXVIdnlWcW96SjFuV09PQWswTGhNZWZhV3pGY003cWM1K1px?=
 =?utf-8?B?MzlnUWhYSmxvOWtORDlHRTJMN2NzYUxmYk53VG8zNGw1SmlHQko4QjdFMm54?=
 =?utf-8?B?ZE9kTmo2aVFnKzBXZVdubmlmRXFZTXMzcUJPbGhERXZwMnFBV3ZBMUoyc0FB?=
 =?utf-8?B?TmpEVkxPdGZBaldXNlVJTFFxdHY4RXRKczJXZ3FwY2VIQjI4RjQycWdPY29P?=
 =?utf-8?B?OUE2NkJiRUhnTnZ0V25ySlRKV0YyZE1OMXdtS3czSjd3N0hpclBBaC9KU0l4?=
 =?utf-8?B?b1JRK3d0WFlpTXFyU1RJRWJnU3BweEdjZ3BDalZseG1jbGxaRllZdmNFd1lE?=
 =?utf-8?B?aGVCdmVIYjFYUFRIZE1TV2NvcE5NbE9wZS9TMUtLSWllbHdaMlZ6K2s4bWJD?=
 =?utf-8?B?SHFIRXdaZytoSTVxb0ZkY3JXV092ZHIyOWVZNFEzcXhOVlR1UkNLY2xKN1Ey?=
 =?utf-8?B?WkNjVm1LMTU2NEpVejN3TkhUNi9nS2tkNGdIVVRaM0xRVkY1aTV3Qk11MFAx?=
 =?utf-8?B?bCtXYkJqUDRBWmEzODY3elVFVVNvcFB6eURSMTNsdk5lcDhLM1ZNQzJ3clhF?=
 =?utf-8?B?cTY5YUxHem1vYTNzN3c5RWRndEJ4cE14UWZITkFoMzZxWDVyOE9lYWNYMDVr?=
 =?utf-8?B?WVpUMlVleWRmU2tnWWVFYU85Mit3c2grZFhjbHZ6TStublcrb3cvaytUQjVo?=
 =?utf-8?Q?v6xhtVPIjfuJS5FvCGwshGLCC?=
X-Forefront-Antispam-Report:
 CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(19092799006)(36860700013)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
 PwwN9Iwkcsy2yPDfkyulHMvIXCnWSMJnXoyJeLAamXAgpB3mIYshZB5kv42eyUH5Qi1BObJbXMS6f2rhHaRHtTYj0B+oQ+QlF0V6kMLSNuVP00ryxe6L/QZmDk9PkAH1HqtQm6WWNvpZjDZTxCxj6z+d4n/ewuLBmPXUBwVJKIjNHzq2HS7DaQz6m6JrmMRhhCUpZPNBVtjl3B1zzclP1l3zXpw8tePfti6OmjFWpUlYwbROs1I0VzdNWcGKLVAX0ry43UX9dL5wIRK3w6Sm5Tms4IJjs3DhLncMzqL1cXH1wslzV+jhBu3svL5xXz2j7/AYaeqAtrZ8HOyRm02My3xW3QbYUhgEZFmTZNXe/HdUR/DaCp0Mh/AOMHPY0CdDinXMF6Asl4TFxgCSgxrv4XRPMVTwSk5AkM5+CNbCVhMhMxImPiocwlHN8CocWEoBCph4UMP5YdMEYWd4VhUSJK0PMsDtxoOk4Tsx6BCXkWrlyZ6zKUus8/bW2X1uJrF7yT/dBmIOgK8CzQNg1W1TENo4DcvpqNodH42eJ6YfYE49DwkS3YUdQgC4bwOWLPs6wlYKFTKceKnpf3Jfg+8L9HbCRACzeiLkEyDA8sJqGA5Sq7h6NQdditAa2SDbv8X+DWcB6SePdzf/a7p21pTEZA==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 10:06:45.6785
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22a3bc3e-e2f1-4e86-82df-08de02648f52
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
 MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFA68F52737
X-OriginatorOrg: ddn.com
X-BESS-ID: 1759488007-103204-2012-2595-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 52.101.48.116
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKViaGFmZAVgZQ0MjS0jTFJNXCIt
	Uo0SjZxMwiKc3QzDgpxcQ8NdnQPNlIqTYWACaQU4dBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.267935 [from 
	cloudscan10-164.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

This is preparation for follow up commits that allow to run with a
reduced number of queues.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev_uring.c   | 24 ++++++++++++------------
 fs/fuse/dev_uring_i.h |  2 +-
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 2f2f7ff5e95a63a4df76f484d30cce1077b29123..0f5ab27dacb66c9f5f10eac2713d9bd3eb4c26da 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -124,7 +124,7 @@ void fuse_uring_abort_end_requests(struct fuse_ring *ring)
 	struct fuse_ring_queue *queue;
 	struct fuse_conn *fc = ring->fc;
 
-	for (qid = 0; qid < ring->nr_queues; qid++) {
+	for (qid = 0; qid < ring->max_nr_queues; qid++) {
 		queue = READ_ONCE(ring->queues[qid]);
 		if (!queue)
 			continue;
@@ -165,7 +165,7 @@ bool fuse_uring_request_expired(struct fuse_conn *fc)
 	if (!ring)
 		return false;
 
-	for (qid = 0; qid < ring->nr_queues; qid++) {
+	for (qid = 0; qid < ring->max_nr_queues; qid++) {
 		queue = READ_ONCE(ring->queues[qid]);
 		if (!queue)
 			continue;
@@ -192,7 +192,7 @@ void fuse_uring_destruct(struct fuse_conn *fc)
 	if (!ring)
 		return;
 
-	for (qid = 0; qid < ring->nr_queues; qid++) {
+	for (qid = 0; qid < ring->max_nr_queues; qid++) {
 		struct fuse_ring_queue *queue = ring->queues[qid];
 		struct fuse_ring_ent *ent, *next;
 
@@ -252,7 +252,7 @@ static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
 
 	init_waitqueue_head(&ring->stop_waitq);
 
-	ring->nr_queues = nr_queues;
+	ring->max_nr_queues = nr_queues;
 	ring->fc = fc;
 	ring->max_payload_sz = max_payload_size;
 	smp_store_release(&fc->ring, ring);
@@ -404,7 +404,7 @@ static void fuse_uring_log_ent_state(struct fuse_ring *ring)
 	int qid;
 	struct fuse_ring_ent *ent;
 
-	for (qid = 0; qid < ring->nr_queues; qid++) {
+	for (qid = 0; qid < ring->max_nr_queues; qid++) {
 		struct fuse_ring_queue *queue = ring->queues[qid];
 
 		if (!queue)
@@ -435,7 +435,7 @@ static void fuse_uring_async_stop_queues(struct work_struct *work)
 		container_of(work, struct fuse_ring, async_teardown_work.work);
 
 	/* XXX code dup */
-	for (qid = 0; qid < ring->nr_queues; qid++) {
+	for (qid = 0; qid < ring->max_nr_queues; qid++) {
 		struct fuse_ring_queue *queue = READ_ONCE(ring->queues[qid]);
 
 		if (!queue)
@@ -470,7 +470,7 @@ void fuse_uring_stop_queues(struct fuse_ring *ring)
 {
 	int qid;
 
-	for (qid = 0; qid < ring->nr_queues; qid++) {
+	for (qid = 0; qid < ring->max_nr_queues; qid++) {
 		struct fuse_ring_queue *queue = READ_ONCE(ring->queues[qid]);
 
 		if (!queue)
@@ -889,7 +889,7 @@ static int fuse_uring_commit_fetch(struct io_uring_cmd *cmd, int issue_flags,
 	if (!ring)
 		return err;
 
-	if (qid >= ring->nr_queues)
+	if (qid >= ring->max_nr_queues)
 		return -EINVAL;
 
 	queue = ring->queues[qid];
@@ -952,7 +952,7 @@ static bool is_ring_ready(struct fuse_ring *ring, int current_qid)
 	struct fuse_ring_queue *queue;
 	bool ready = true;
 
-	for (qid = 0; qid < ring->nr_queues && ready; qid++) {
+	for (qid = 0; qid < ring->max_nr_queues && ready; qid++) {
 		if (current_qid == qid)
 			continue;
 
@@ -1093,7 +1093,7 @@ static int fuse_uring_register(struct io_uring_cmd *cmd,
 			return err;
 	}
 
-	if (qid >= ring->nr_queues) {
+	if (qid >= ring->max_nr_queues) {
 		pr_info_ratelimited("fuse: Invalid ring qid %u\n", qid);
 		return -EINVAL;
 	}
@@ -1236,9 +1236,9 @@ static struct fuse_ring_queue *fuse_uring_task_to_queue(struct fuse_ring *ring)
 
 	qid = task_cpu(current);
 
-	if (WARN_ONCE(qid >= ring->nr_queues,
+	if (WARN_ONCE(qid >= ring->max_nr_queues,
 		      "Core number (%u) exceeds nr queues (%zu)\n", qid,
-		      ring->nr_queues))
+		      ring->max_nr_queues))
 		qid = 0;
 
 	queue = ring->queues[qid];
diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
index c63bed9f863d53d4ac2bed7bfbda61941cd99083..708412294982566919122a1a0d7f741217c763ce 100644
--- a/fs/fuse/dev_uring_i.h
+++ b/fs/fuse/dev_uring_i.h
@@ -113,7 +113,7 @@ struct fuse_ring {
 	struct fuse_conn *fc;
 
 	/* number of ring queues */
-	size_t nr_queues;
+	size_t max_nr_queues;
 
 	/* maximum payload/arg size */
 	size_t max_payload_sz;

-- 
2.43.0


