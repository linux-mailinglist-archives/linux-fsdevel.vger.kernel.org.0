Return-Path: <linux-fsdevel+bounces-37339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 555D99F11B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 17:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C100162995
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 16:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74E01E3776;
	Fri, 13 Dec 2024 16:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="mp5fPYdl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C481E048B
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 16:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734105720; cv=fail; b=bYd23tx+YatWRxsSTM/wIaGrpZIOtr2DQkjVllkz9zx/GiKMptEpyYFD0YZ1XaUfZptGQQFd8VG3fys56ewhQALlvx8EsJd9ACoZqWA9dyZAkAuSxJqhkgjAbJwRT0FynWsaWEzDlXyWeFEBr7SQP6B0TbLFzjULnVHFtdxA1/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734105720; c=relaxed/simple;
	bh=FZRmVzsz58hGYYVTZ12+XkENyBULU+gegbWE1xZkJaE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oLE3xJEZQlppO/Dgef/aXUPO76PIb9AAdvk4+ayNgDM1yahqgJ8odvn/jNeu7yZhpMjYiCJF8QXVB3/ipcBlWT8KQ3nAn0Dtaud7K2lRg0Lopw7hSE26OgFYKZ5L0LBtsoLWLU49wOxMmuJ2OSCvXESa4Xn/5PQINgnCqbnaePQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=mp5fPYdl; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174]) by mx-outbound11-79.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 13 Dec 2024 16:01:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VQNMzd4MD/tnLhhTjxpLpmaqr1NJOmb4qh61DQkxcwWoPjHsJvAbk9BTNDo5ISkl+lbcCI+TDymTlAaoipVso4QNAx+J2GWzSZiELs7DH9Nmd3IcJvDgQS/xfZOpm70JYKnUDvmeyMQpKPlO26CmZvlV6ntGPBDjtR3XpRiTsCfrIwJoCewl9G09mTr/VF6BEYafla7fugyWBWOzF9msdJlqNlLjV3Maj9hTVxDKy9Pz3hD4C3T13zO98bJzIMJsF2Nfz/6QKNjC2UesABffqEQC9rxC4+ZV5CmRVrHUEDwGH00QsStY66uDxX7ki6aNJSxpgv9MB2yFwLXeTSpgmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V72MyOBpU9qIVL+M1tHLicKoLDcti9/XLM99R3qiExU=;
 b=jw78sWs1sl5hBWjKJ/FyRMa5vx8BirfIbaIYa2ncM+IsV8J4e1rZgyBT2pBSZ320iczmaTxgE4c06zG4PQgNClqBGOLCHExl4Fl/SnI/AcxtgQDN2artyh6Md04jsU0/NVij3sP4S6Hm/9p7MqahKjg1dPYuKrbFZ/unOrRAsoJN5lj4AeCpvWBiQ33qLzPB9Gd1bTnJoC0fjlYeDOESxyLTYEgZKVrrHdBhL+7I2m2ddh2OosIbbvNYSxYUxqCr/C4ErznF89EJeD8rbzxROeAoMIaR/SoDmkTgxhM+aGL2cO2sbRbn8ZpNULJ1i+YSMJIkymJvL5LZ2w9Kx78F7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V72MyOBpU9qIVL+M1tHLicKoLDcti9/XLM99R3qiExU=;
 b=mp5fPYdlaQ6YCjkUhGbN8/YOj3rdrfyLXdtNQnDbl4rxKg9W/6WDgwRWQQFJj9cINIGt53kG5qzw0rXNsqxA83VJf9YzJkOGeNToyMlJ65+He0VIF7B2fcyKeAYboQvkUA/y2a7ElUPfgnAGh7KrH2+O0Ya3f4ppqzpX2wtzZhg=
Received: from SA1PR02CA0024.namprd02.prod.outlook.com (2603:10b6:806:2cf::24)
 by DS7PR19MB6205.namprd19.prod.outlook.com (2603:10b6:8:9e::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.16; Fri, 13 Dec 2024 16:01:42 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:2cf:cafe::1a) by SA1PR02CA0024.outlook.office365.com
 (2603:10b6:806:2cf::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.16 via Frontend Transport; Fri,
 13 Dec 2024 16:01:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Fri, 13 Dec 2024 16:01:42 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 8010A4A;
	Fri, 13 Dec 2024 16:01:41 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH v2 0/2] fuse: Increase FUSE_NAME_MAX limit
Date: Fri, 13 Dec 2024 17:01:38 +0100
Message-Id: <20241213-fuse_name_max-limit-6-13-v2-0-39fec5253632@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGJaXGcC/42NQQ6CMBBFr0K6dgwzgAFX3sMQUuggk9hiWiQY0
 rtbOYHL95L//q4Ce+GgrtmuPK8SZHYJ6JSpYdLuwSAmsaKcSiQkGN+BO6ctd1Zv8BQrC1wAC8C
 6qqk3RWNMqdL85XmU7Ujf28SThGX2n+NpxZ/9I7oi5NBQzxWNOfKgb8a48zBb1cYYv5otqJy+A
 AAA
X-Change-ID: 20241212-fuse_name_max-limit-6-13-18582bd39dd4
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, Shachar Sharon <synarete@gmail.com>, 
 Jingbo Xu <jefflexu@linux.alibaba.com>, Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734105700; l=903;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=FZRmVzsz58hGYYVTZ12+XkENyBULU+gegbWE1xZkJaE=;
 b=+F5UBysaVrvLkss1tMlWSYxvEORQFSHFI9L0bIdfdLzD6wKexP9UsokU/7JR7H4gU/xo3Qdx+
 HkCfo24Zf4mAmdu8eygj/90JfrKg9KH5hLXQJIdKXujwARHpfURarvG
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|DS7PR19MB6205:EE_
X-MS-Office365-Filtering-Correlation-Id: fc0cff3d-880b-42f4-5794-08dd1b8f6f94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXRkSHNqck9RdnJSZnZvY1dqNnB6OTlWNzBkSjVJaDhYdzJDYlc5VittbnB2?=
 =?utf-8?B?RUZ1UHBoMVlwTWNmTXA0dVlhL2lLSExxK0s5Y2l5ZWVJTUQzZUhWVG9iSFNS?=
 =?utf-8?B?MXRGU09Ldk1IZnlHQnl4QjVhOEFLbmMzNDltOGFvZ05qQkxiNWExQzBUcTlK?=
 =?utf-8?B?MEtRRVY0RzZpejVNekZKMFZKU2pPenZ2M0U3S3ZwQ04zN3dyTi9lNFN3YXlH?=
 =?utf-8?B?SHhNMmRvZ2ExeXRMTGRXak5KTVdkdk9FTlpuYWRBSkZuSDRBYzR5aFl1SndL?=
 =?utf-8?B?aS9xaHg2dmlDVlRvRlVnVFM4cStlb2VhVVRMY1h3K3pFT0dPOHpIM0hLZkZr?=
 =?utf-8?B?Y2JLTndvRnR1dVJuTnEzV1djcS8wWU5FRG15V2dPY0VrRVc5Q2VuUlNBVGdM?=
 =?utf-8?B?aHJObVViWU4wNmF6N28yWkZqK1owcHROdUNSMXhQdDVtbWF1dVQzTXVNOHNo?=
 =?utf-8?B?K1ZSbCsraHlDMEpuLzZUNWRaMVVhZW14OWRnK3J3aFljdCtSMVdyZzFrTUEr?=
 =?utf-8?B?UFA5ZS9HeVhSTENTV09qczZDRWdWb2NKSko2dFZyWmpTWi8yVTNjWEx3bUd3?=
 =?utf-8?B?WWIyRldsY2k2dTBVTnhiYXVmaEJDaXdjVmY3UDV4dU1OZngyZC9hZGtGdFB5?=
 =?utf-8?B?YWlqT0M5ZTZKUmFnZGJNRy9VWkF3ZWxiblpHd3lWZGdjTWtBSHNuRlArbCtz?=
 =?utf-8?B?N0k1c3hpZndjektYWlFtRXV4Q21vaXRKWkVwUGwzTDF5QTZ4Z1B6K016Yk9h?=
 =?utf-8?B?aVQvRlR6TXlRdXRtOFBFTU9sU3ZkeVVXYk9BK0NET2FHOGVIdFFJdVFuR0ts?=
 =?utf-8?B?TVVITHJlSFJXcmRndEFyRkxrNjhMdjFJL040Z2Q4alRYOUx0Qmd1a3Z6Z2hm?=
 =?utf-8?B?NVlWNVZmUDFNeWZWZVdDMlpVL3pBekFnYnZFcHlzYTlLTW4xUEdOMVRKTW96?=
 =?utf-8?B?YzJRaHRUbVJSNDNVS080Q1B1ekhKNVpiYVd3REtEKzl2UEJKa3JrSDZHWHd5?=
 =?utf-8?B?MlNWSC8xMDZhZ1d6ZHlZQk9SY2U4dkpqcjEwQ3p5K0lpclNob3JjbEZKSTlU?=
 =?utf-8?B?Mjkrb1RCOGVwQ3BxZUZ1SDg4U0g3ZnVWaXQ0bWJucTBOeUxCV2ozV0lzT21Y?=
 =?utf-8?B?blJWbWRtZ0xNNlZ4MXdQU091SDFxVy9rTUh5NXBjN0ZmOFZxY3ZMNFlSMVhi?=
 =?utf-8?B?VW52RUxUc3FuN293YktLL3hLYitBbG9VTytrcU1jZ2dmcFRLY1MxMjc5a2NS?=
 =?utf-8?B?dWVsQzluNUJxV1Q0QzR1YWhIaFJIREdRdnJzQUltUFhiTFJrTTQyK2dBei9r?=
 =?utf-8?B?MWQ3OFpReEhYejJIUi9HYU1ZMVpBL04yMnFvd2pmekY2TDBIQUhuTEVtVnJi?=
 =?utf-8?B?QUpOaXhUbDVGZGlnM1NrRE0vMmR3U3ErOFBCa3ZoTmRvUDg5cjQ3U2pmQ3JO?=
 =?utf-8?B?MlNvYWd1K1RhV3MycytZZjlDL1pjWGpPTVA0TlkrWkhBVTBRQVgrVWhVRjdG?=
 =?utf-8?B?R2ZRT1E3VlFqTzlmN3F4c29oOVYyeUpBMTF4ODdUcjA2YkxIWVBoVktWY3Fl?=
 =?utf-8?B?cDRLS0NXYlI3Uk85R2psVWc1OExxNjVaV3gxcFNSVmZHVE1oTEFLcWxsekJ3?=
 =?utf-8?B?YW9tZkRnYlBBSWQ3eHJaV1d0bk1JR0ozR0NBenRkcmh3MlY4cCtGS3dpWkg0?=
 =?utf-8?B?c21vbTZleEpUc2k5bUFRc2J1MnFnN0NFcjdwTWZnWkdZc3cyb1QwU2dVWDRy?=
 =?utf-8?B?SzBMVVdUQXhBdmpCUTFPTHlPb0VBbzhzbXhmS1FhYUZUR2xKaEVBR1E3cHB3?=
 =?utf-8?B?dWYzV3dPOVFxSFdPT3Zsbm5Uc2hCQU9neDcyczBDckNaQTFTMlFWRmdjTWI0?=
 =?utf-8?B?WTY4b1Q1WkRkaHRIcysyR2poSmgvSUxiM1VlU0dUdDgwM3R6VXI3T2tXRW5k?=
 =?utf-8?Q?sxblG9O03xRODZCV9wBCuFRZ8+wU3l11?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5OhJ4NtQN8AoMGUme8dK/ULp9shMlHjdIIWsn8435D4XheYKHUUbO/44T/6fwWIt6bqWMotR4XaUQ26FONxAddQlPiiWns6pSf6Q90I1F2Su0ESNRZxEwq8gS84swZdu8LN9QtwqC6ZggQqgB3C/K7Oxq7o4wdOY1oZciGnP1es6NMutghGz+j6nyS2k9XjrSsigdMP6IGvpnj3EuJydXgo9BFcEz5gGG/2dbVYs6hWsFr8n2k3kFAHOGOEjL9Ln3O+O4GoTZjHfmdH1LGUwrIjhjHD2WLwwwS+uZAsRKPoNwmrB9Z1K4ZElTcip1z9FzgK/Jb6qA1uweqgofbwP38ePTP3UnCuSBHzz7BPg5VACPbR1QSwR2qJo/amNGtoJbrTOpBUs3YLt8IA/c19SY0HVb15NIKEs8zzEHGZEBIZElIMyDVKfxgeYajeyaeVNOXBn5/1m6cYXVydimMumi7Oa5WbQrX5pDVlgMlzlLbD9mxs3diUenNY7uQ6CuiTAdAs76s3B0CrCKnJ36wDZb9IG0QLSA5w0UPFOpvXwGRIPFNrhCn68UiXTG6v6T0zWrcPrT6nWsYq52nym5HUfAr+D3/lc5OMR0VcaKZEb8+t1WmSUj87ImIaATXdkBqU2PcliKF5LSsBLRDF7rHb/2A==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 16:01:42.1806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc0cff3d-880b-42f4-5794-08dd1b8f6f94
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB6205
X-BESS-ID: 1734105707-102895-13541-6919-1
X-BESS-VER: 2019.1_20241205.2350
X-BESS-Apparent-Source-IP: 104.47.55.174
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVhbm5kBGBlDMPNki2cw4MdHc3N
	LSMDk5zSDJ0sLE3NTA1NDcMtXIwkCpNhYAEHbOf0AAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.261086 [from 
	cloudscan10-29.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

First patch switches fuse_notify_inval_entry and fuse_notify_delete
to allocate name buffers to the actual file name size and not
FUSE_NAME_MAX anymore. 
Second patch increases the FUSE_NAME_MAX limit.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
Changes in v2:
- Switch to PATH_MAX (Jingbo)
- Add -1 to handle the terminating null
- Link to v1: https://lore.kernel.org/r/20241212-fuse_name_max-limit-6-13-v1-0-92be52f01eca@ddn.com

---
Bernd Schubert (2):
      fuse: Allocate only namelen buf memory in fuse_notify_
      fuse: Increase FUSE_NAME_MAX to PATH_MAX

 fs/fuse/dev.c    | 26 ++++++++++++++------------
 fs/fuse/fuse_i.h |  4 ++--
 2 files changed, 16 insertions(+), 14 deletions(-)
---
base-commit: f92f4749861b06fed908d336b4dee1326003291b
change-id: 20241212-fuse_name_max-limit-6-13-18582bd39dd4

Best regards,
-- 
Bernd Schubert <bschubert@ddn.com>


