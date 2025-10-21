Return-Path: <linux-fsdevel+bounces-64996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D13BF8C32
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 22:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 358964E3FDC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 20:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00710280CFC;
	Tue, 21 Oct 2025 20:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="MNQfFohB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB5E25C6EE;
	Tue, 21 Oct 2025 20:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761079617; cv=fail; b=WGo+/pX9qRltIYsAjL8hJGv6zToVIEsvZb6XCnSSsDObo9fmUyK7FI8tsdUxKurg4sef8xEyHkQUGGF710T2tPh3JEVbEWp+MBIdKRO/YxBlpVqlf57RRBSO8VJk4gYmZKCP1bmwbpI+Oe53YR+u0hKJ1ea3pilGPKSXsvSGNtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761079617; c=relaxed/simple;
	bh=T+zXaL9ZlhWXFxC9eyZSBOnwbQNE/MNBY3xvo6CPNcc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DYNYG/qMQjHQrozNK+Q9zl1Z3/SUbQqSTHoY6XARqNqoUhYm1pXhJ6zEJwrsrrSzEbhGgM9WveHu5b0bl5so8kbhActjL2YiAtdeBrLh0s7ekt/A9ZWi63OZMGCqolOBh3lMmJdBaCs4B0MSbWMwhgNqBlpaC8igdfopacI2wrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=MNQfFohB; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020074.outbound.protection.outlook.com [52.101.61.74]) by mx-outbound-ea46-43.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 21 Oct 2025 20:46:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PWD/1ekCZ/5bohHFt+j3YAv5IJrzwcO+OC3QsHm3YkruXr5ysKWcOREiWZfa8qp3mBWahzId41nILqtHRetXJc+jF+q7mrJHDhLFWW2r8OkzTMfOpL54Hap9uhf1Y6KXR7ufoGTqn3VO6K1r4LE+aeG/rO7qlxRR5nzQxT+eS0FiHDnt7CWbcUi+UoIBGD1pe0EdUlxdtbOErk0GUs2Vg3Dcw44TN1Q6TgC47ixWbhyf8yiM5VZiYOtqeXdJhuSgCGL4r/CVOwSj0MOOH/1Aq9nLcN0Hpfz7dhn9qjhnN1820Ycpperll3u4n/aP183Iy5EbE9nHTUmqFqp4PwUvVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEx4KdYc27Y8vufIbGqsW4/OvjaNgdqfBRfiPXNhTqU=;
 b=eO2pFdjGO6MgiMW8fr9Iw+ZTTKLTev5HuvrZ79SZoZ3slM2azF69aPUz4EV3HR2aPeY7QT/2O1tiBTdU5GDd2eLzcdbGzDzSXbpH6BmcHO3u6lnDIVTljuaB7tjWz8o6s9fErVW9IkDhL0qso5ZLaR+DOeduddRebnfYxh2d0wIkU4OHZSdX2C8jFbPwSCz3iUZtH8Mc+X6jDKJTk9o4P64n5XPJlu1sVv9PpBgXUCOQ/folEnmf5pV30F15EQtzcirqh9u4cFn+ji4v8LQDhN5Ms7YiVj/mgYT2hwT1qI7Fdksl96dolwcO3BJctZbUd/q8uFnTKFeeFdCEe1WGvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEx4KdYc27Y8vufIbGqsW4/OvjaNgdqfBRfiPXNhTqU=;
 b=MNQfFohB5cjEuW9bQy9aH2zPeyUJ7arfU4bamZAZpm50oWklE6ZGskn/+R5YY+musDEe3vmfzoNxv01PW+9L1tpdj4BVYf10nNZdSyNO8cCGprM+g1IKfzXiNz9see5Gb9rm36NpI1XDsSMNG2AHLTcn0w1jJRTaOdJpUHfIU8w=
Received: from BL1PR13CA0308.namprd13.prod.outlook.com (2603:10b6:208:2c1::13)
 by DM6PR19MB3819.namprd19.prod.outlook.com (2603:10b6:5:247::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 21 Oct
 2025 20:46:47 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:208:2c1:cafe::b6) by BL1PR13CA0308.outlook.office365.com
 (2603:10b6:208:2c1::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.6 via Frontend Transport; Tue,
 21 Oct 2025 20:46:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.0
 via Frontend Transport; Tue, 21 Oct 2025 20:46:47 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 5B0524C;
	Tue, 21 Oct 2025 20:46:46 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH 0/2] fuse: Fix missing fuse_copy_finish in dev_uring.c
Date: Tue, 21 Oct 2025 22:46:41 +0200
Message-Id: <20251021-io-uring-fixes-copy-finish-v1-0-913ecf8aa945@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADLx92gC/x2MQQqAMAwEvyI5G2gDKvgV8VBr1FxaaVAU8e8Gb
 zMwuw8oF2GFvnqg8CkqOZn4uoK4hbQyymwO5KjxjjxKxqNIWnGRixVj3m/DJLqh6wK3jpjC5ME
 O9sJ/ZPthfN8PT8SZ2WwAAAA=
X-Change-ID: 20251021-io-uring-fixes-copy-finish-07ae602e2ab1
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Luis Henriques <luis@igalia.com>, Joanne Koong <joannelkoong@gmail.com>, 
 Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
 Bernd Schubert <bschubert@ddn.com>, Cheng Ding <cding@ddn.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761079605; l=636;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=T+zXaL9ZlhWXFxC9eyZSBOnwbQNE/MNBY3xvo6CPNcc=;
 b=PbfbJ9mod5duCmNGgMW/+ktKijMRbW8IgQ3/KXPVBZt+6NE2Dz9f9uy9DmKZBIuJkzBeRNear
 fA6CjLvhmYzCE6Wv+SoG7l1fUcOgghc6hhOSFOANoM1Jxufn/vsXnqA
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|DM6PR19MB3819:EE_
X-MS-Office365-Filtering-Correlation-Id: 7091f513-8fa6-4409-b58a-08de10e2f3e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|19092799006|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rzd1UXdPSGQxZ0F4VlFVTnBZVC9IaXZkMkRaaUZEQTAwK09PSU1vWDJLb2Jj?=
 =?utf-8?B?RkYwaW5hZDVLYmsvQ2ZXKzUwRjNYRlVkNVN3dDhrenVsN2lSbGNMMXlzY1Zr?=
 =?utf-8?B?d1QzT3NCQXk1cWVweVVtUVVoTDZUajh0NE9hZkdKQWxCN2dBcGFvOWRjeWdZ?=
 =?utf-8?B?Q3IvYVg4d3FXaTErRnlCYnR3M2NDem5iL2dzSDZSaVV1K2RFQkZMY0ZHUG0w?=
 =?utf-8?B?aUtKRU9lWGdESUZDSmpBcHVRQ1V3aEhsSDFUbkhPREQzNzhFWHhCdTVJLytQ?=
 =?utf-8?B?bjdURm9kTFBUbmxIRFRqWWJoK2dEZkZuNk5NNkl6UUpvRGFwV0RHRUpSUmJH?=
 =?utf-8?B?RGZqbHdlUGw2RWF4Q2xOdjZ6MWx4ZnBPTGpsejZRMkFDekI2YThlL3J0a2hK?=
 =?utf-8?B?cDdOYjBwUThLdjV5c3ZrYnJXbEYzbXRHY3hhZnRIRXN2UjgwUmdkUTdncUtT?=
 =?utf-8?B?OVJRQjI0c1VodlZFcnNrb3BqSXkwbnNyOFpBUmVSWkJXNWhUMEl0a0R5aEQw?=
 =?utf-8?B?bHd0WDlJdlAwYzFxZDFFYWFHSzZKUVZHbW40NHdhNXVDa3FsUXBuREFPVk1V?=
 =?utf-8?B?dXEyckdpbXVsMkgydnNlTkMrYTZlK25QT0NVWXpiMGdzbmxrNkNpTnZMZXRx?=
 =?utf-8?B?L2ZEeXlBU2lVU0tJbGVETFNyWmgwUXplYWZFZ2dGdFZEWGhVbmFjdmd0NE5B?=
 =?utf-8?B?RWdodmNWVVpscEF5ZlpabVhpdmNJQ2xCWUhZbnNtaG5tU0lXMUZOL2tqeEwr?=
 =?utf-8?B?aGlNelg4amRzSGVObmpXTTdMQ0VrSkpFRUowak5UbGZTRXBDdDh3dldxeGhR?=
 =?utf-8?B?dVdYMmhqcEJuUDFUVDlrUnl6d01MalYwWTByR0krY3RPK0JKNS9YYld1bGtV?=
 =?utf-8?B?RFNGaWx1RjdNdW9wLys3ZlNCV0Q5ZVpBWVpadTBBdGNkK0pGSFhJM09NL2FU?=
 =?utf-8?B?RWQyNmt6eTZuQzg2UUhUZW5wbGNuaEJXa0FZZjNZOEFuMFYxci82a0pES0Ja?=
 =?utf-8?B?L0JFNHhoK2RjV1lTb1ZMaW01a2RjWVoyamN0NHV2cHliaXByL09jTENaUnBG?=
 =?utf-8?B?bTByWlQvRzFHaGpndkMzWHNtOFlEbnJEUjJZQ3Z4aC9xbjdlL2ZmbmdvY1d0?=
 =?utf-8?B?dEE3VVQ2QW9zQUd2NVYrak9Cb0tWclgrV1EzcUtlb2R4cE85QkpKY3JlNGRE?=
 =?utf-8?B?NUtiMHdTaG1FUXJtV1RvYjFaSVJLYlVoZnNHV0F1U3I3L1JLZkRSZEMycnhq?=
 =?utf-8?B?b0dFeUw0UEhtRG1vMzRJNTQ1VE1zRWxqcnN4c29KRk5pdU1mcEg5Z1hFcXJU?=
 =?utf-8?B?bFB6UE5scmlONDJHd3JaTzdEdGI0eGtLNnd1bkI0cVFWcVk5S3EzWWdUdlRZ?=
 =?utf-8?B?YVN5V2ZKSVkvREo3K2Z1V0tFM2ZNZ2VGV0xJbFJLK2FGVWg0T3FORUYza1Qx?=
 =?utf-8?B?UktmZkpMeFdzSU4vUFNueHRzaW10Y3h6bnlFU29GYmJuMG5zSkJvZ0dmVHdL?=
 =?utf-8?B?S3Eyd0pZa0pLK1RxdXY0TXRVWUlDQ2V5WWx1ZWYvTGlSenlrZE8vbE5uSU1C?=
 =?utf-8?B?WTNRMmZ0UHgwVEU3YW1vK2lEbUxpUEZqODJ6WjhoSUpxSE5tY29QK3ByVStS?=
 =?utf-8?B?VmJnRFVkdmtkNzFYZFVFYUUyL3BqakRkWWlEQ01odTBCNVdoQm50NlFtRmdq?=
 =?utf-8?B?RGRPS0UzbEFuL1hJK0hsdDdIbmI5eVV0RExNS2o0NnBVQ1d0Y3VUMUNCdTdk?=
 =?utf-8?B?TEVwZ3Uzb1Z6aGVzMitTV0g0OUxNejBIMjhVV0Q1bzZQd2tQcWU5L1cwVTFJ?=
 =?utf-8?B?a3RsbmpOamdzeHVINy9ON0I0d0ExcGRKTmtpNGRPdUZIejIvajNLbGlKSy9P?=
 =?utf-8?B?VWlMVXlucnFGMlFoZm1Jb0pwZ2paWjlpWGVhMVpmZ0l2QU5Ub3d2aysxQWtz?=
 =?utf-8?B?WEVSK3hiNGdFNTdvOHNZSVFhWGNHUHpNTEg0aXF6cGthVkJNang0QW9Cb2pQ?=
 =?utf-8?B?ZU1ka1BVRFRDS1JXRldPenJTTHVsMHFIMjY0VUUrd3FSaDBscXQwVFAwdXdZ?=
 =?utf-8?Q?w9BB00?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(19092799006)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mkjlpI65Fng7P6L7dlOt04C+XxLzYKsyloC9GlV4lJwlhUyUy3REcDBUN+SW0RzmHF7Sk3OlMO6JXkbnFH2i94ZgHnWp9odzHX5wAYWPnK0n6I3Ex1NWvf86hJcCkw1+5ZrjWGbY/XitZzRsbQ/Ui6hNWLbhdjKTbV6B5B3mxZ9G5otvd0tyvY9JkrGyn1HnFx1BdJ5ptW+ykAuynhr2LcG+Ob5RfdM7BTymvmAJwYwh9Co7Jo6sVi9GFdMShe/QkdNwI4UqrIwRAt/RfC/Xxo4i3rod64VUN3QvAjBi3nedEb+E86ZvZW8wgrffkWBQbaUfRZpdxnDYMgdzVepwlYIYHUs4RmrFp8ZHMwiWWstFCnysFAJLwPhjbRDh5U5opGnrUnHhRUaX6n7egvILBqd3Z/PmP5GMqZWnElk+CWndOLeeVZ3FaYaiNGzqfubAE8KEa3qWNb9YGzHeBjJnGVrU/RCFjVoMJaNOwGYmirsN8toeoPP5GEcUNYsWne3ekxUVNUYHxU9jw0UC3VRYl6j0qqDMiHsh5TXUROE/bDmlDatzD7Zuzna8eSSje5Wb7mzyOsoXy+f/WSqYILr8o4FV8OgniN+z/hC1nX+hwxyXjTNk/0GYDUtH7zS5DeXpo1wyyCZC2vddQYy/iyUkcQ==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 20:46:47.2101
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7091f513-8fa6-4409-b58a-08de10e2f3e1
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB3819
X-BESS-ID: 1761079609-111819-18346-16641-1
X-BESS-VER: 2019.3_20251001.1824
X-BESS-Apparent-Source-IP: 52.101.61.74
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVmaGZkBGBlDMLCnZ0DgxzcDQ1N
	LcMDHJ0MwkKS01xcTIwCI5OSnF2FKpNhYAiaAk80AAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.268376 [from 
	cloudscan9-172.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Both argument copies in dev_uring.c miss fuse_copy_finish.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
Bernd Schubert (1):
      fuse: Fix whitespace for fuse_uring_args_to_ring() comment

Cheng Ding (1):
      fuse: missing copy_finish in fuse-over-io-uring argument copies

 fs/fuse/dev.c        |  2 +-
 fs/fuse/dev_uring.c  | 18 ++++++++++++------
 fs/fuse/fuse_dev_i.h |  1 +
 3 files changed, 14 insertions(+), 7 deletions(-)
---
base-commit: 6548d364a3e850326831799d7e3ea2d7bb97ba08
change-id: 20251021-io-uring-fixes-copy-finish-07ae602e2ab1

Best regards,
-- 
Bernd Schubert <bschubert@ddn.com>


