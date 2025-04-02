Return-Path: <linux-fsdevel+bounces-45542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB7FA794DE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 20:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90A813A5287
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 18:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1401C84B9;
	Wed,  2 Apr 2025 18:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="ciDc++ZQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD2C1E4A4
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Apr 2025 18:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743617612; cv=fail; b=hW6KNYwRO9qCyAs8IrojwBW8druEZ2lkTg8k/PDNPMSfQzXWYnOnKxTKn7E3hUgCwZE6v3obSpxm6YYElGp3wJ+cSoEg7ntIPOJ8GSYlrxOrXD8z/v+9Z+Up+CwSCVuSMYEaH//v9hB3b+G5AWQu56V6fw0NBd5y/NsgPwrFgNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743617612; c=relaxed/simple;
	bh=SmvmgXaqM9hwTpi5nGlt/Ad51OqXVaMhAFbUqGF0FOk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oPd9yPdzzAlz3FY6XLdiD8ozZnEeoN5stWUYy1ldlW2VaXoB0dXstvSta9rCSW6fonDk7euzPGHt5Nbxfr2zZ7WUhyQ6se2/HIeYR+GWX7yZ1Wa5eUvtuROj999CdyRy7giML+I2fXMLs6YR5zYKrwZEleq9rzBFNIW5Oozr9dI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=ciDc++ZQ; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42]) by mx-outbound43-133.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 02 Apr 2025 18:13:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EQCTj4u/UMhR3zrFcWUeT6oA6lpzaqXFRB33YZPkOcCLD1Ul4KaqdKP/lSMI9s47bDH2LsN0bcxg6q5eK0qnwgtsUKD5w+ZZagEJ+e8nkheAaSFAn/LcMOSyHrwM77J5y0zl5ckJfLC9lSjQcv/Q0OFt1Wm4c42tareS5Wwkwr0q6JOGSLzgMmkJwSuHsezIX4NsMWVDnWVZAotdo/NxHya+LPB68bcXAaARkPYvsmEnT9lwp/fECLXgv0A5gpyWzQnOTnaCqa/yQsCE/vTUlhx/9lWXnZMK5wD77e1WmwbLL9RdmgGWbQxSPbTZEkoNlj5CaGiodSWNNxk6xydzdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RaaLCrfkX5DMJKvyhENtIkwlLfcwMioyJ/CgNceT/lY=;
 b=N4xfS85wfS6uCmuCtGvlX8mb1Iefm4Rec7YjC+Y5a/WpnDxuXxOwZpmWRVtuC75h0XqkbQ8psn/0lpb8Pq4zKlKDF9vAdmx2qfa7FwH3068ik0l+0NFydZm83kCqOzqT9FR5Y7y4wjvfaG7evuh5Qd8/qSdtfmKois26DWYpWcfufcykHIc3aaaS/HiV/8shAAkrJaydQ1QkeWc3Ywq8GtagFFX2ZwkddkxWqZKxklyAqxwVGkajDaqp4w1+7e5szuvU1jNbiEtH87vaJKG1KeNUGMRDDwptPW0usJT3qoLQfMrsM7pJRR6WR2YlTz0q7ugeKKtC6pveQqfp1NAwEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RaaLCrfkX5DMJKvyhENtIkwlLfcwMioyJ/CgNceT/lY=;
 b=ciDc++ZQWFtZTuqWQOOjIQFXn5sTnEGiU3H3zNlUAPgUka2QCBYKtsz78wVL8XCUKWiTfTNK3bgF9/GZiqbz2XvJYOCytndHDmoGW8MUBZ8PFKlN7bGB390YaUQFMd54qskynwy7BuvpvKpVrUyV72UE17hiw2uRj1nosnaU6H8=
Received: from SA9PR13CA0058.namprd13.prod.outlook.com (2603:10b6:806:22::33)
 by SJ2PR19MB8096.namprd19.prod.outlook.com (2603:10b6:a03:53a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 17:41:00 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:22:cafe::30) by SA9PR13CA0058.outlook.office365.com
 (2603:10b6:806:22::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.22 via Frontend Transport; Wed,
 2 Apr 2025 17:41:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.22
 via Frontend Transport; Wed, 2 Apr 2025 17:40:59 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id EC29E4A;
	Wed,  2 Apr 2025 17:40:58 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH 0/4] fuse: Improve ftraces, atomic req unique and code dup
 removal
Date: Wed, 02 Apr 2025 19:40:50 +0200
Message-Id: <20250402-fuse-io-uring-trace-points-v1-0-11b0211fa658@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKN27WcC/x3MPQqAMAxA4atIZgO1+INeRRy0ppqllURFkN7d4
 vi94b2gJEwKQ/GC0M3KMWRUZQFun8NGyGs2WGMbUxuL/tLcIl7CYcNTZkd4RA6nYtubqqmXpbO
 ugzw4hDw//3ycUvoA2osHNGwAAAA=
X-Change-ID: 20250402-fuse-io-uring-trace-points-690154bb72c7
To: Miklos Szeredi <miklos@szeredi.hu>, Vivek Goyal <vgoyal@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>, 
 Josef Bacik <josef@toxicpanda.com>, Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743615658; l=1190;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=SmvmgXaqM9hwTpi5nGlt/Ad51OqXVaMhAFbUqGF0FOk=;
 b=A0s5aDhNZqjUCMYIxzH2yfm5snnEpGYagierK6j+WcnAna9bxMh/OJSMqjXSydLu/F/WV0R6K
 PYcvpnKq5R2AEdsZfy3dHrISbWbhyHFIRG7aseOSeUCZ0/kHZzVjsRq
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|SJ2PR19MB8096:EE_
X-MS-Office365-Filtering-Correlation-Id: a38ddaa1-329e-4321-9851-08dd720d8812
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SWczcDdTZUdPSkEzL05RTVh6eVRvT2VMM3ZhRkh1ZnkxY3h6bVM2ZWM4ODVB?=
 =?utf-8?B?ZDg2Z1Q4WnRSNmpVNkQvdkFBVUdSd2txWWtrLzBBeldOS0RnZ3gyNXpXU2lV?=
 =?utf-8?B?VVVmYitTaC95MTdtTm9oclVsSnlpN0dOd3QrTDg2MU05NE04RVJKS3hEVDZa?=
 =?utf-8?B?UUVzUjVLUDVvSGduN0R4cHY0V1FvWW5INm5UNVZHL05rMFZlSUlqOVAwTWM4?=
 =?utf-8?B?djVrL2djdDFYTFhwOXlhY2xaaStWNGxXMkU1T01vRURmd3ZYTkNLdXZ3bzNu?=
 =?utf-8?B?cVVJb0RaTVYwVzlCWFUxZ0RHa08vVjd5dFFnV1FxcXQ4WTNXcVRGM25nYjRl?=
 =?utf-8?B?RC9IUTU5TVZ5cDQyU21WdGh5ZGxCUjRPS0xkaHhCNTVuTXRZb1kzNjRES29I?=
 =?utf-8?B?alRKWS9MczVDS0FpTHBWNHlVeWF6d3Z6VDVKYllTY3JRVGY3Y0hpaUVzWXY3?=
 =?utf-8?B?QjlkSnBTK24rNlBncldMSXRTbVFWOStSNHc3L3BSa002ejl2ZzZIUWtmTjd1?=
 =?utf-8?B?RXoxcndEQTFsR1JIQWlTTXV1dGx6c2FDeUFrN3pMQ1RCY01DZVRxelR5aStK?=
 =?utf-8?B?UXFWT08wMEFtT0QzSXlBdmhpbFlRR1dJZUc3UUl6S1hLWWpVVGgrN3cvQlRh?=
 =?utf-8?B?T2UybjV1Y2k2dm1XOHVDSEhFZDJmNERrckNqaFBDUjJpME53Q0pKY3krTTJk?=
 =?utf-8?B?TUFnbFUrb25TMXFGUVhnUmt4VUp4cGdoZTRpMnNEYUt4R0tiYU1YRXRRWmlN?=
 =?utf-8?B?d0ZkQWtUZlI3RE9TVTJjVkhOVW9BdWtvVnVyTDcxQkR4bU93RkRUcmJOTHRU?=
 =?utf-8?B?bC96Y2NWT3JLYkQzTHlTS1cxNXJwdjFNc2ZUTnVRbmdIZmxTN2ltd3dWNjZx?=
 =?utf-8?B?OHNYYlBENUtxY3JoaGFOTTRUZGwwQ0NydlNvZ1lNN1FIWGFJdmpFa25IcnVl?=
 =?utf-8?B?WHRGZXhRQXRsNXNLblZadVFabmZkLzVqVXF2b3QzRUw4Wk1XdGZWMGZZUlNV?=
 =?utf-8?B?Zm9Ld2FFWjdsSHg1SzBBQStXc082dUtkdFBvZ3ZwQ3pZd0E2a1pyOUpaa3Vp?=
 =?utf-8?B?ZmFpbWd6bTJ2TThrRlN3VWxxdTFFemgrVGkvOTZnYnhHTWp4bnlxMUFYTU1E?=
 =?utf-8?B?WTFDaGQ0UTM4T0FtWHV5WlZobGYzVzZSM3Zoc3hNdzR3OVpQMDMzb29yajRX?=
 =?utf-8?B?SENuR05XellSN0NGd3h4MSt5UDhpa2FOODVsenREaHNXYjMrUm1LMXRpOUZ1?=
 =?utf-8?B?TmZqbDBnWk1rRVROblNlbEpUZE5oc1VSNkhpMUZzaVJmNWZGcUtvVnR2Sjdj?=
 =?utf-8?B?R3lZNXUwa0ZHUXZra010WkdqZXlMb1pPR1dBbnlqV1hLZUZJbE1IMXhyWkVZ?=
 =?utf-8?B?VjVJUzBFOGszbzFhd285WjBhdmowT1MyaFVuOFdOSW9QVE1JMzUyR0hScTJS?=
 =?utf-8?B?VnVETm5DeWcxZDE4SWVZS1hCL1RuYzVVUVJjNkpKaWlDeXJxcnNXM1Y3b1BT?=
 =?utf-8?B?aHZBa0xGbndCa1UxL0xYVzV2a2gweUlaTTVodnFvemlPeFd5QlBjemJnOU1O?=
 =?utf-8?B?ZDhSNVpyeDBUUmVUKzBKa050b0RHWnA3MGpITWNhSzU5WU54eFQ2ZGx2SFR3?=
 =?utf-8?B?L2ZOK2J1ZUxMMHJRVXpmNnNRanJQMGRvTEVCSHFEZzBQUmh3NlN6RGczcnE3?=
 =?utf-8?B?TWI2bEVNREZLMDRUdFlkWFFsODRRb3Rjby9tQkNpZGp2Q0JCZ1BJQjJ5aER2?=
 =?utf-8?B?M2tRVmc0VUErOUtRT1YwMms1VXZBZ2tOUnpVcjZPOVQ1Sks4ckdod2pIL3B1?=
 =?utf-8?B?V0tEeUl3eTlKQWxtMUNJQ1MxbTNUalhIVm04MVZQYVhIM1B0dVA0bExqNVli?=
 =?utf-8?B?bWUvK3NwcHNwdmpYT1FMVGJBek5aNnlxQWVMaXJoRWd3ejFWWmxkY29BdlhT?=
 =?utf-8?B?QWFKQzIzV0tGcDBYRHNDQnljT3Q0S3pua3M5MS9tdzN5ZkZ6OXdldkVPREpa?=
 =?utf-8?Q?JhGvwsxOnDMEFklftAmRVkHUZAr6kE=3D?=
X-Forefront-Antispam-Report:
 CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
 lUs871cx6F+PtP46AXPTQEviJ6rS/ZviJZHQ/Lu7RbtYRQCI7bW2+PYuNAQLe07c8271N2vIyRTdyTSJpKbeFUtvoZ+jlKpRAaC42IfpygAU8dGYCB97/liWBgN+KN6njU5ehxH5Cl/1uCoD3wTy/gFkrPo67S/XukhqGM9NIBUQ4zOwIUstRkO0JvPUUkj9IkRMMzV2xaCflvN3X2qTq0UNbmYUvsxLtBsS+MoEcOnE/iNh5PmfDWwPm/CsNQTTdHnj9MtA8PczjJmz4ZLg6nLr34j+R2Dw5jfl4BUKOwlN4l/uT5RRapCsGNtF0C5v3QQxxmM7EOPWOydwL1YhVqO+rmEdcABTqSSjs7PSnczsHz2Km59theuD32RrFie7owyF8VSsv/Keb2brx7IASzuziFlHo2IroUBXK2Y7T0Bhhn7i2/Xx7tVHCFU4ap+IfOpo95NRQiYBz4ybYzPvarO1bMkugoqdI2Pe0kLk1OX0G4pcNcCmT3fY3KxVPfpZK8Qhm8NK0rRKKEXkoRZnjQ+wgUY7U+j1dTmz7RRLb9wyuSVHYy6B60kD9TmNs+Ose18e0aBAjsqfNhFJXdpPTjbKjKLlas6xM12PKYoBYIEYciAlGmceZcF9v6OWRRcV0QpKp1ExeFkZgbASqMOHZw==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 17:40:59.8758
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a38ddaa1-329e-4321-9851-08dd720d8812
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
 SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR19MB8096
X-OriginatorOrg: ddn.com
X-BESS-ID: 1743617607-111141-8668-9285-1
X-BESS-VER: 2019.1_20250401.1649
X-BESS-Apparent-Source-IP: 104.47.66.42
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoaGZgZAVgZQ0MzUzNjALNHIMN
	nA2MzUNMXAMDHFMjnVwjLFxDTFMMlMqTYWAHqQfuJBAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.263603 [from 
	cloudscan13-84.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.50 BSF_RULE7568M          META: Custom Rule 7568M 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

This series is mainly about improved ftraces to determine
latencies between queues and also to be able to create
latency histograms - the request unique was missing in
trace_fuse_request_send so far.
Some preparation patches are added before.

Scripts to enabled tracing and to get histograms are here
https://github.com/libfuse/libfuse/pull/1186

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
Bernd Schubert (4):
      fuse: Make the fuse_send_one request counter atomic
      [RFC] fuse: Set request unique on allocation
      fuse: {io-uring} Avoid _send code dup
      fuse: fine-grained request ftraces

 fs/fuse/dev.c        | 37 ++++++++++------------------------
 fs/fuse/dev_uring.c  | 44 ++++++++++++++++------------------------
 fs/fuse/fuse_dev_i.h |  4 ----
 fs/fuse/fuse_i.h     | 18 ++++++++++++-----
 fs/fuse/fuse_trace.h | 57 +++++++++++++++++++++++++++++++++++++---------------
 fs/fuse/virtio_fs.c  |  3 ---
 6 files changed, 82 insertions(+), 81 deletions(-)
---
base-commit: 08733088b566b58283f0f12fb73f5db6a9a9de30
change-id: 20250402-fuse-io-uring-trace-points-690154bb72c7

Best regards,
-- 
Bernd Schubert <bschubert@ddn.com>


