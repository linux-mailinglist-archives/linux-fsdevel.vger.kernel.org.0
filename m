Return-Path: <linux-fsdevel+bounces-55760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7275B0E648
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 00:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07CA7AA4AF7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 22:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569132882C9;
	Tue, 22 Jul 2025 22:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="GYqfwt5t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8EC76025
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jul 2025 22:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753222535; cv=fail; b=tYsWegJimVNdp33nJmjt3oGL4UHqXF9FbhJCdmS1E2Ashi5sAlxGDpoBt9aq19u/BNJFwf1Wz5lmsZYgC5cdXY11ugzfMAXI1Lg3b+ICaZqONtfCv2jTDqSMkWnJNCOSPYDpkjh3M2MiwkL90AUsN6AzB2QgMzNA376BKT9hRss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753222535; c=relaxed/simple;
	bh=6HkZq8A+NmdOlvHtALiHbhxtBsUyVei9YdL2zYmSe6k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MWFV5Jk7hzxSeRoLj3yy0+PQqAaskA4EgIr3Sn2xL6ErTmadgcgjSCO8nHAerdbyUd0AHKkInhhvjsdsTxBd65GmyOdYM0rtFWFSawy6j4SvezR0p6ohA8/09lwmUoIM7dNkj56cWNr9CnUOUVbJn6LldLox0TfgZyWytEPrwB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=GYqfwt5t; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2115.outbound.protection.outlook.com [40.107.244.115]) by mx-outbound9-205.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 22 Jul 2025 22:15:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kisRcnecfWRCM8rxwNTSZdWYEkoJChG4wQ5JNzOL06VqQRrpSkHn7DVOdFqy//SmRryruEOXZQswaLZc6mf5jKfjipbxm/kzVHgDWUKv1Zbq4pywWmaFxrJeUa7WzJJerW7JquxbUba1SSUKGBX+UOOjSfXbmBoxJq4Fi469NeZYTo7vgrPHl4VHFjfBZJwkKuOyRWhbC387H/weXqSyYEhWij521/kTFsLmZ9Mp7PL1EfBoHR9MliHH5Rm19cNBZz8xyarlO/mUMG3sIqRHaVkjgA9hnTWkSJ4k6X1CzrPX93CjK2dw8dkRYwvuGAGKJoUfc/PhHBhgmJXoQcrpsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PXHmNIOXHCRciFxBuoffN5mRA5ifn1k3o9WoPoc1yFE=;
 b=TnykWNix17lM0zmIVxTkd+x2uMpQBy0B3mS9BVqwKU4NVusztgYMCUirC2Cdyf+XcGDzWnI/saiwuPFTV8daPvXJS5EZoSliN9MNZxfc/dj4gIKCR/IAs0aVu1WhTHZRp+d4R1GZtT/1mCBoueXyMleiLF8HMkUOfT+aPUn4zOI9CSlEDMs1korAj7cBpTkt+DyUExNpC21pINv5Dby2BEfuh9ZQAj3fwO/OZaJ4QgfTUhbpp2eZShALjE6jPHLkEKPg7WkwCqVOGjE1S+IEbP+U8YsgjjRDivc9vsREZE+cY/78TR7EiQIc6AlgM9SsZi8MwDXSWaA4jnoQYrUJyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXHmNIOXHCRciFxBuoffN5mRA5ifn1k3o9WoPoc1yFE=;
 b=GYqfwt5tev3p7XW4N2SUFYs22vMCRWOefEhcTQlCDraByXTSglrVbKq79LDe1GzFGJxy3g5hEElG5EUqdWw5P17fcPgQBsTxL4S52cyooNC1/l3D/RwKfNbjxgoh+vTzaqSdcCvZm7VBQ/qlegXkKgR3rcCqRwSJBpAFoYykM2Q=
Received: from MW2PR2101CA0007.namprd21.prod.outlook.com (2603:10b6:302:1::20)
 by BY3PR19MB5012.namprd19.prod.outlook.com (2603:10b6:a03:361::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 22 Jul
 2025 22:15:13 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:302:1:cafe::f0) by MW2PR2101CA0007.outlook.office365.com
 (2603:10b6:302:1::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.4 via Frontend Transport; Tue,
 22 Jul 2025 22:15:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.20
 via Frontend Transport; Tue, 22 Jul 2025 22:15:12 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 3E3E6B0;
	Tue, 22 Jul 2025 22:15:12 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Wed, 23 Jul 2025 00:15:10 +0200
Subject: [PATCH 2/2] fuse: Flush the io-uring bg queue from
 fuse_uring_flush_bg
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-bg-flush-v1-2-cd7b089f3b23@ddn.com>
References: <20250723-bg-flush-v1-0-cd7b089f3b23@ddn.com>
In-Reply-To: <20250723-bg-flush-v1-0-cd7b089f3b23@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753222509; l=1842;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=6HkZq8A+NmdOlvHtALiHbhxtBsUyVei9YdL2zYmSe6k=;
 b=UZsZ5eM1qKRYTA1EM1MrXkIg+8EiLu+ld1OO2Jxc2npIRCzwofnUUezMK/ZTC2loDXK3CEqSV
 SwfT22hhtvFAEoaR2lRKQfTZcr2xhArgrnW8UAIIGqt0ZaJ/8O+JQ33
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|BY3PR19MB5012:EE_
X-MS-Office365-Filtering-Correlation-Id: c8ee8d55-9909-4683-9633-08ddc96d3acf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|19092799006|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWhYcnQycG9sazZlemZvSlVXZStIRXkza0N5ajR4azVySk1pMStjV2ozZkVG?=
 =?utf-8?B?a0M5M2cwL0pVenZxVXRQaFNLTllGSVZ3V3hpclFLRlpHM0lJY1BNRmYvTjIr?=
 =?utf-8?B?L2t0cVpWc0dCelZCVlVaVytzMmkwbTduSmdvUUhPYWhYOWsrQlpOZE9zTy9u?=
 =?utf-8?B?dVNxZEd6WW1KZndaQkZHRTE4MTU1MVhyREczTHJ3WWs3dS9EZ0E0SG5Zb0xP?=
 =?utf-8?B?RjBIbWZITjZUT0ZCMjBHeTlTc2dGZ3VuN2Y4Ynk3Z2lvMXFlbjh0ZjJ0Vm0w?=
 =?utf-8?B?YnFQbE80b21ocFZGam5NNnB2RXFidFdKeUJJRFlZSG1aQzZIUGxBSGRkOVlu?=
 =?utf-8?B?ajFLRHEzdnJScXZjQ1U5UkpKMENhZ0dKblFNdE9OQjFvWHdYZkZoc25GMS92?=
 =?utf-8?B?MGtzTTNCamhNaU81UElIYmRZNHJzOEp6azQvVlhHdm1iRFd0M05raU1sb0xL?=
 =?utf-8?B?VWtjdENpMTk4V3pVdm40SWIzWXZGdk1WM0l1Q3ZOVWxrTkZiQ1lsVUVzaFhU?=
 =?utf-8?B?UmNxZ2JydXJUUmtRcS96d3pER3o3NFptM3B5SU9wRTVWRm50STRFRS9lb3Yw?=
 =?utf-8?B?ZklxK01Fa042V25vR1ljMWN6R2lpSG1lNWRhNUN3TnpKN0ZhdHBBSyttUTFh?=
 =?utf-8?B?Mlg0SEF1eWUwUWJLNmRTN1YxMldwR3JwOFZOTjVrQTJkcFprU25MZ3d6RXpO?=
 =?utf-8?B?M2Y0MmdjOUNOSDRIRGZZbUh0NWxSUTZTTUg1emk2djlLMW1SdnZuc3JvMk9l?=
 =?utf-8?B?ME51NDY3QXMvdUhzQ3lRdmdoMWVFVTJrcytaeHFKRkFGUjRiaVpxOGliRm4z?=
 =?utf-8?B?Y2lKMEFFZmt2c3hzZm85NS8rd3VxejhsUlJRWVVIRXFuYXk1OEVoak9RZTI5?=
 =?utf-8?B?emtoN2pZTnRCS3pOWXlFVXc4ZXBVR3Y0cXdGTnNkVGVaQStJUHVqYlVCY1Np?=
 =?utf-8?B?RkUxOGp0YWg4WFNMSUNoUHo3bFhQYzRnQnVUbUZDaWllODJ4bXlGazlqSFVR?=
 =?utf-8?B?a2RUS0sxWlc0U08xRWd5MHhVMTFyNmgxU2FvU0twRjE1aXhEOHNTYmJVQzZF?=
 =?utf-8?B?WlZtdXlEQUpKazI1YlRVekx0ZjRST3lueVlZZVhzT0c4cjRoS2xxdmlxSHc1?=
 =?utf-8?B?T1FxOVJvWW5vNStlKy9ySXVHZFZIVXlvOEJPQ3lTZVVNS1JKVXJjOXJrWHEv?=
 =?utf-8?B?MCtGSEQranBhTVNEbFBBOGdlSWJ3dXFsL1A3ck1TR25UeVU5dUNoYkZ4ODB6?=
 =?utf-8?B?akl4STFISDJFNGx5RU16SEgxakhyWW1rR1VzbWZ5dTVwM29tdVJ1UWJVRW5k?=
 =?utf-8?B?MXU2SGVCNlByS24wUnc3SmVqbUoxN2tkWndsYUhLSDF2RjZnMDJXK0FtdFdC?=
 =?utf-8?B?R3FiOEFmMXNnYVhNVGg2WTM2RjgvUmpvTmxqbUx6MzBPd1dmVjRmVGdzNmJG?=
 =?utf-8?B?NHlJeEE5bDNHQkhjV3ZNYjRLdTA5RUl3dEU1alorVHhhTE91dmhOMnA0ZXhU?=
 =?utf-8?B?cHI4cWpQSlE4aXhkWitld1liMWthK1BWN1luZ3FqeHRJbU1YT1E5SFViZk93?=
 =?utf-8?B?RklsY2Rnb09LTWl4eVFjNGF5YkR6SEo0YmplYm1zcVRnM1djSkRtNW5SYlFm?=
 =?utf-8?B?UnZTVE9aTHZaOVhNYzNZZEVnUGNGbFVQL1g5RFZvUWo4Wm84RTMzMUZRQzNQ?=
 =?utf-8?B?bm9hUlRnWXJORkgvYS91N0hOWTlSN1JuNnJzK0MwYktDRnE1Z3RPN3lvVGto?=
 =?utf-8?B?M0hFU2wzN3lwUkRqSXBUbmNuYktRM09xVWEwUGV5VUVVSE5ESXZzZ1ZIbGVa?=
 =?utf-8?B?clkxTFVkbHRDV2Z1K29IazJKd2pTbTFmUE8yVXVqMlpoRWJEZEJna09CTWpq?=
 =?utf-8?B?Y3kxcllzMURJRUlPalo0WnRyblhlOE50bk9wMzlERmNib1lZQnhaRWdtRHdN?=
 =?utf-8?B?OGFRQlZPUitNY2hIcm1Rd25TZ29zY3hrQW9La1RMTWI0d2gwaUxsS1VFMU5z?=
 =?utf-8?B?RlZ1OU5nbXA5L1doZzJheWJ3U1FldGhpWXFvVTdqMDVKbk9GMHdvQ3A3WHc5?=
 =?utf-8?Q?6sYa89?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(19092799006)(82310400026);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uit/aa1CXu1m2OP34nU0J6WlN/bJ62nAQBe7I6ItEexxf9c5IwotMCor3WL5vsKyOoMb/ixRjvJHkHYxA4I1NcvmuTCITQltKuaE+WJeeCBwhjcnQgBigDve6yigkal7D4dMj8b0J8xnjHQx27qyGTPC7HozXjL7Q0POgKsSaG6pbBlK6FCuIq6nWLzxdAnQKk9m11bNU3wt0nDRseOcMQcSKlf5WO6/rvk2syW6lJ8Vze1dl5AKx553NiYwu2fRL7znxPXX0G/QDopzApttMEfMyaSQUr19Tg20PKllY60wYjasMVmH8hn+dKF5mWMj4dH1PBPvI/sZVXGEqG7hTfuSmDoBit3P5u+q3VW7LIlDNvLnERMvoHVX2cxe69q2qoiZ1NF+9iaSbgwYNNfrK+TgV5EM1bWDtVDDritZg09urXHiunE/wYTcVTAVBAz13tmWSvOZjgXIaaaWtqaSZDpimdBuzFdadeXj2b3k7EY548HuV/UqYKb86rwA2FHEyfPi5er9WNeoB8o298A02kXlcQdenoS8G5li9/0AWA2/WOtmsy2PZVOV1opC+aq4ZWkJb0eIFiPd8fLnmAyz44Rx/wPEtLzyqWB1AjQyVDrDWSkAcZV8EbDN4hs4SCUno5KaWmtp+UIDnMS7TWNAnQ==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 22:15:12.9979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8ee8d55-9909-4683-9633-08ddc96d3acf
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR19MB5012
X-BESS-ID: 1753222518-102509-20386-20430-1
X-BESS-VER: 2019.1_20250709.1638
X-BESS-Apparent-Source-IP: 40.107.244.115
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVobmFuZAVgZQMNXSzMzQLDk1JT
	HNzNIiLTEl0dLYODHZyCDRwNzS0sxIqTYWAKXCtGdBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.266236 [from 
	cloudscan17-230.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

This is useful to have a unique API to flush background requests.
For example when the bg queue gets flushed before
the remaining of fuse_conn_destroy().

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev.c         | 2 ++
 fs/fuse/dev_uring.c   | 3 +++
 fs/fuse/dev_uring_i.h | 4 ++++
 3 files changed, 9 insertions(+)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 5387e4239d6aa6f7a9780deaf581483cc28a5e68..d5f2fb82c04bf1ee7a35cb1d6d43e639270945af 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2408,6 +2408,8 @@ void fuse_flush_requests(struct fuse_conn *fc, unsigned long timeout)
 	spin_unlock(&fc->bg_lock);
 	spin_unlock(&fc->lock);
 
+	fuse_uring_flush_bg(fc);
+
 	/*
 	 * Wait 30s for all the events to complete or abort.  Touch the
 	 * watchdog once per second so that we don't trip the hangcheck timer
diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index eca457d1005e7ecb9d220d5092d00cf60961afea..acf11eadbf3b6d999b310b5d8a4a6018e83cb2a9 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -123,6 +123,9 @@ void fuse_uring_flush_bg(struct fuse_conn *fc)
 	struct fuse_ring_queue *queue;
 	struct fuse_ring *ring = fc->ring;
 
+	if (!ring)
+		return;
+
 	for (qid = 0; qid < ring->nr_queues; qid++) {
 		queue = READ_ONCE(ring->queues[qid]);
 		if (!queue)
diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
index 55f52508de3ced624ac17fba6da1b637b1697dff..ae806dd578f26fbeac12f880cd7b6031a56aec00 100644
--- a/fs/fuse/dev_uring_i.h
+++ b/fs/fuse/dev_uring_i.h
@@ -206,6 +206,10 @@ static inline bool fuse_uring_request_expired(struct fuse_conn *fc)
 	return false;
 }
 
+static inline void fuse_uring_flush_bg(struct fuse_conn *fc)
+{
+}
+
 #endif /* CONFIG_FUSE_IO_URING */
 
 #endif /* _FS_FUSE_DEV_URING_I_H */

-- 
2.43.0


