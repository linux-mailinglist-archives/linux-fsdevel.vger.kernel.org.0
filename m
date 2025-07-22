Return-Path: <linux-fsdevel+bounces-55753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A89B0E5DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 23:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87D9D17F978
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 21:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97E828725F;
	Tue, 22 Jul 2025 21:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="EBKgy3qz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B9A28C00E
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jul 2025 21:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753221498; cv=fail; b=sp+ZBzAEUnFzNbWY1GA899p+DNnQZtzltvma/idXd33IUXSyBWUOhZxvfpv6+n77JbsLqTmeYPY32Zs0661MaiqqkKVbS80H000vyWbNRgpUQy/TE0bI2jD5BbW3BnXaWc2Qx5B82kqGojDyt8LOKShKJv5P5gBM5pUyyPQSz6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753221498; c=relaxed/simple;
	bh=VOnGWVBVd+T+ocK6db6fafbEpDu55jt0L4CkkQ4slRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R9vBiUkw4PJci9iSmpRPZ0I0c175EiRiXzMiqbphY/9tgYO0al5eZhvN7LwRPgAUXhqrg13z+GjWmb8EQJxi756p+lgtYa2H+/QUSUr9SGJb3JD5ghL0gEgtvIK+K3WlBSsZTekYaV/g2Msya11IYc9u+3bKAPRoe6oulmgsNiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=EBKgy3qz; arc=fail smtp.client-ip=209.222.82.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2098.outbound.protection.outlook.com [40.107.223.98]) by mx-outbound41-31.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 22 Jul 2025 21:58:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UHmUvS1qPXOWSoY+RNHXxZ+ZF6sqB1q/264/deTk2H0zQvhUWFjuPlCEy5PSA2Na1Im59T3UEwGgo/zn4zMeP4qSyrz9j29ON35B5YLtyrz/CS/Aw6sGUPxGtX4r6eL1SkS3wf2TJCwVHM1Gs3qj1iMRih14qX9IMQy1ksJxXn45Ag1kpy9/NG8rPE2IbuzqeAaiLaN9TT4htBXjR8+sWUGpmgcjn6n7/xvCrSkKx1sX8bp37tcj9vXYI2gYWMB7OFWiPWLsCO/wlLT2XF2zIbOkOUgFuAPm0S8rNHi8J8rX6PHpCOdbaJen0AgN7hamBs3mUCjSuKLBPm7bxOKgyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YifxhdPN3bbFAgY/U+xVi+lepjolg9gcoar6GYEa2Gw=;
 b=k2Yayz/kIZNzMAA7/cSm+zdNBGCrNUwq8lqqPBo+kRD6ICIGK7T3ia09dNaJbRdUj7CKnBPXBGf5i+dCHkPWvIrs4EZQQ6tTiCyovgA8dY8IN/T2bcHVVlpWnZ+fADQOsuUbXNoQww6TzX2Ze+XPKgVtVUyQ6+iPiGqMKkEEb65gfT5+6UX5rrshDJq/cXy21mIaQJibnu0ZmgPUfLAHyPkRbd6CinaXCN9jy2+KzOWHKf65A4hYtyqq74dOHwLyLxeQIsKbLi8zqnEzMDLHepX138ohEtO7b72Jaz84p2C173SaXrZTtL9jR6uPHLbuZChVdcJEkTNYWiK0Lsbv2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YifxhdPN3bbFAgY/U+xVi+lepjolg9gcoar6GYEa2Gw=;
 b=EBKgy3qzXdUjR03Imp5TZLORvwqOSFnN3IskQNWakZnBU+s2VjgkV/5sYc6bDGvLjsicF0DzUmTHoUH34SCnPQPOhxFDORDNMvi+gFioznomlxtFRg1RUE8dcdkKAbeZHOCRyfkn1u+aDMx9c+92IwyMxoWdp9QOGEQArjMlN3U=
Received: from BY3PR05CA0010.namprd05.prod.outlook.com (2603:10b6:a03:254::15)
 by CH2PR19MB4022.namprd19.prod.outlook.com (2603:10b6:610:93::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.37; Tue, 22 Jul
 2025 21:58:02 +0000
Received: from CO1PEPF000075F0.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::ee) by BY3PR05CA0010.outlook.office365.com
 (2603:10b6:a03:254::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Tue,
 22 Jul 2025 21:58:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 CO1PEPF000075F0.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.20
 via Frontend Transport; Tue, 22 Jul 2025 21:58:01 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id E9AAEB0;
	Tue, 22 Jul 2025 21:58:00 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Tue, 22 Jul 2025 23:57:59 +0200
Subject: [PATCH 2/5] fuse: {io-uring} Rename ring->nr_queues to
 max_nr_queues
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-reduced-nr-ring-queues_3-v1-2-aa8e37ae97e6@ddn.com>
References: <20250722-reduced-nr-ring-queues_3-v1-0-aa8e37ae97e6@ddn.com>
In-Reply-To: <20250722-reduced-nr-ring-queues_3-v1-0-aa8e37ae97e6@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753221478; l=4316;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=VOnGWVBVd+T+ocK6db6fafbEpDu55jt0L4CkkQ4slRc=;
 b=VmDJGkEDi/wQIkpTGBlkmpm6uZIzJWMT22r7dRtQYozSI9ww8q1kTz4XSlmx2SdJcXp0QNx3r
 RQ1RJUx+LVqAqQQqODZnshEI+mB2mdian+VDcrKJyHMqmy18KCm6q7y
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F0:EE_|CH2PR19MB4022:EE_
X-MS-Office365-Filtering-Correlation-Id: 09080935-a369-467e-722e-08ddc96ad40b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|19092799006|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RWlWb1QyYTArUGhFVjRxYWRKTXcrZ2VhYnU3Q0JwOW5TQzRuZVlHUFJVelZ2?=
 =?utf-8?B?NXFWVmIrdzRaREFSRnhzNnVESXdYYVpDK09Ja2J0MW1lRXVVaVRpNmVrOEpL?=
 =?utf-8?B?NWtxR3hwWTg0VmR6TlpubXhZakZBSlIrVVRuKzUvMmhuNTgvbnZQWlM1T0Q1?=
 =?utf-8?B?QjRJUE1FTDFxT2FuOVVSOVhraHBlY1EwUFd4NmtpdTFkU0g5K2EyU3RQcDZT?=
 =?utf-8?B?d2E4ekNIMUx0MUNrNDNub3piRTFoMGhxRlNDbGVVODJMdXdiR09UVnk4TjdK?=
 =?utf-8?B?TnZXdnhFL3QyRWhJNDh1VjhtaXF3enQxWW9ITWZuTWxVaHNCV3VVOWVhRmdi?=
 =?utf-8?B?V0xwY3ZrU0hGQ2d6Y3AyblRvdVFjdTBFTVdXQnV3dlQrZmthVUxGOXRJNTJW?=
 =?utf-8?B?VEFrRGFlK0lGZmFTMTduTEFXaEFuNTV3cGRsOGhlVm81WVF4U1M2SUcyZmxP?=
 =?utf-8?B?L0N1U29NbEwvVE1TcnVjM3VGdDFUckM0R2pkUmlOdldZYi93b2J5eU5HblhN?=
 =?utf-8?B?K0xtNkNrZnVQcmZBSHczdmZEaHdqZFpPbnd3bkZyQVBrM2lyUEFuM3JMazB2?=
 =?utf-8?B?RGpZclc3MkdVM3N6cTBLNlYzeTk5VXlURE5sMUFFOUNtUytUZkpaOTdhdE12?=
 =?utf-8?B?Yk42b0ZOS0tUTVkzL3pUaEg1UTNaaXhtakpYQ0ZlZUxLcmhjRi80dWJhZUhX?=
 =?utf-8?B?RkY2L2tBM1Q4eGl4bWJRQmZxaVNBb2Y5K3lZUVJoOWlMZ3V4MGJ1eFpJbnNX?=
 =?utf-8?B?cktNcVJhUWFvVGZZUE1NV0syVkJ1OXVpL20yOU5waUNZdkJOQzM4Mkw4RlFV?=
 =?utf-8?B?OTJDZWQvamQvK0VBRkNBSTVQS25NY3lrSHBZZ0Radmc2bk9STlpiOEl6eUM3?=
 =?utf-8?B?MCtHdHdZam1qWUFreWV1SnRZUENaUWprY3ZUREV0YXFsemtQZzdSN0huZzNS?=
 =?utf-8?B?NDVURU52OUVZdnNKWEMwUjArUG9JNWxVb1pwamRpYmZuSUVhejBtc3pGKzhq?=
 =?utf-8?B?MUh4SXcwOXpGZDhuR05sdS80Q3RLd2IzYk5pTmd4YkpVNEdkS1JZU3lPY0JF?=
 =?utf-8?B?VDBqZnJsQ1pqbEVqRDVJay80UU03WENIWGdCSFZURmpQRzhnaU1oZi81Rm96?=
 =?utf-8?B?U0pkVmJPaFlydDNmU1VEUHRoOGRLWm5DVjFEeGRjMG1nNlJMRnM0N2Vjci9N?=
 =?utf-8?B?dlN5b2NQRGVJdW9FVUFsWFVUNk1Dd0pobjRibzlzbEVTbUVERmNVNjRBMGhs?=
 =?utf-8?B?YWRSUEovWXBCWEtRVVc3TWNpMFp0OUhVSHVJUWJzUEF5akdPT1FWK0tsMFhN?=
 =?utf-8?B?a2tNQVRZaldRMnVpTDdxV09XdDFMQXR5d1k0MlVQL1NCYXJXMG5UUktFMjBS?=
 =?utf-8?B?dGxxLzBMWlJsR2pWOWxlOVJCdVUwQ2xrZXFGNHpWdUQwUzcxYUlnWXZBVDdn?=
 =?utf-8?B?cU5xMkNNZndqUlRpZFdlT1FhUWptMjMxQ1Vuc2pjaU53MkQ4NXlZUnkvTWg1?=
 =?utf-8?B?NE5mSnVpclFRWm96NVJ4Qzd2OGg4NnBqT3phZnhwUkt1WS9KL1o3aTBYMWt1?=
 =?utf-8?B?RmowSnhyL2pwZ21ZNGtUOWNHendud0JIMmphNEJ3SXplcVJtV3lSV3JOWnRU?=
 =?utf-8?B?a2cwZ3NtcXhybXJNaXlVU1luanlyQmNsN0lGa3VhZjdWdk92S2xIOG11TW81?=
 =?utf-8?B?eE1oUVc0VEZZTTdWUGoyR2F6eGdJamdxRkpjMXV3NFF5QnM3T1RqU1NjdTRL?=
 =?utf-8?B?WEoydXZWZE5oa0ZzUWxBb3dRMnZ1N0pnUW4vR09HTFJBWWEwNlNUNkFkVVJZ?=
 =?utf-8?B?Q3Y4SEcxZkFsMSttUkZsNHZCdGRPYVdlekt3akNyd3VxSi84UUloU3ZuR2Fv?=
 =?utf-8?B?WjgxNCtXMCtHZWx6QVBjckRnbkVMT3VPcHRaZXVwL2lBK1FRL1dBUnBERUtR?=
 =?utf-8?B?R1kzd0F1T1Y2VU9OdmRXVWptaFprUW52aEpEdTM1bGFPWm5DQUt5MmFqdWtI?=
 =?utf-8?B?SEtwZDlNR25MbUlvOWZOc1ZldFROR3pvUU8zc1NzUzF3V2VSdjhvMUEzbkNz?=
 =?utf-8?Q?q1vTi/?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(19092799006)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	s6VeNcG4V1KzqQlicoYEKfHELZFXIxIn8JyMPjE+HIYT0Yr7WH2leYDrKARatZN5ywGvV3YwD8BPfgYplvUSvMUYffsm5pdiG5BGoL/ydambCRkZQj9xtZPicKwHuS8Y447FIJba7GIYlWhy17hs5TOTEwu7GIfzwuBfWzCeRDPbn2ztQOY5li1wKufzUEkyFbrWzAI1VDfuga/DH40bN0pQzvEQxl6m8grv1W6DRvGgQr+mdjONYftZAfc2ZrP1+9kZiVBei+ZxYeycQC+/tk10qaFwcPbI15GSRgOS6/IUNDoOlU98rmsVOVvbAy2N8bKan5LMymvT6+1ViHP2k1IxwjyiyoPtJs80m+D9fLHi/zL/T+yjGCiZf57q9tjQbuExUmuaru3+ov9bPoqIzfPaM55bm2AJTELWsIz57FWNEtXzdJE4k6kEu8CLGqWSDbfS6CQIl/hKQlayP3094nl2B6UGxyY5yieWnN1mGqRYeouSNG6ZKxp4nnYwbnitgeYwUkAHxwbr/Csqbh/V+sTrb5+b4fX4Qn4KG+AndfS5R4ntp7FtON+X7KL7hPFF4mm+MW1qn9qjwK4nn42hFnDUak5Xdhjbz8vZ92HMQC+iCETpaTrlsg2NsTHraW9oeD4EDHxvQ9iL+p48TKbRbg==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 21:58:01.6197
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09080935-a369-467e-722e-08ddc96ad40b
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR19MB4022
X-BESS-ID: 1753221488-110527-13914-24662-1
X-BESS-VER: 2019.1_20250709.1638
X-BESS-Apparent-Source-IP: 40.107.223.98
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKViaGFmZAVgZQ0MjS0jTFJNXCIt
	Uo0SjZxMwiKc3QzDgpxcQ8NdnQPNlIqTYWACaQU4dBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.266236 [from 
	cloudscan13-22.us-east-2a.ess.aws.cudaops.com]
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


