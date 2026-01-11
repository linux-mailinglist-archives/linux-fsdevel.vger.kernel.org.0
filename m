Return-Path: <linux-fsdevel+bounces-73155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E38D0EBCB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jan 2026 12:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 636E1300429D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jan 2026 11:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD59E3382CE;
	Sun, 11 Jan 2026 11:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="J/IJvli/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41574B640;
	Sun, 11 Jan 2026 11:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768132105; cv=fail; b=oD6OAiu/bm2YEjGPupEOzGJwTv8VYIjnLq18xny21n7usB+b2rZH+PvU0DDlxjksogXdK+zpkJzqeABO7amNxkxQEqWgWlujfpLE5RYgZEl7UBR1Iwf5vDpybFfAAT5VANi+TehVxcDEl8qPaWQYhuzIGoTD44a7tHcZEcfcyXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768132105; c=relaxed/simple;
	bh=raQAemcR1wX95qQJw8IYGmuoCqsNLcjcatg7IAbgd0A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gYsL7/9XD3wGlVqGPy/XU7YFiwQUijpJG595X5EmtduIrHVAGELoDbJ6wzG0zo7R3W2W8jz7VOcHP7vZ61mUFkfUJ0vumxv3RLlqdSMIy0n8g6kHvd75dZq4/sv/MbPyKceA+wmZsu3hhhtlrqIIzc2dtMhBdR68qru51J99Hsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=J/IJvli/; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021088.outbound.protection.outlook.com [52.101.52.88]) by mx-outbound43-48.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Sun, 11 Jan 2026 11:48:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VCvXtwcMHQfPh96TIYFMzfKAjbZnydnoyp7s4HdoOGmKq0SHaG5c5fS2fBHt8uD/g2HOSOIlYeiEv2N2jnpMG0027hEeQOY3VkYP2NPVAoTdCZPx+QP31UdwsCMKXP+6IQXp5XIuybnPoZhpjj9H24ohpAILgN7eqbM6/xIpQou1yAPOZO7Mz0jhDIOgzgXkuiLWvIwVBhqhCe2k0mLVZrG7ORDqQEVQx0ALsRAqsxBStjFffWtdPn1DsgekZcnTny+OcY0FUSsLow1jE+a/g3ppF/siMAeZ3XMVncL/ndk7JGNEhNuf3I6o+VaheCeCEnNNDkR0B2KZ1PildECEeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ca6sbpfQD6U+Vq5C3P88ZrMtNMeI/tpD577wDbBgRww=;
 b=sLR3owf2MEbNbYWcwZe/yyTayoSGIKuubbsGQaE2S76tKPwSEjPvEtzmF5Z4KmS2yFgdiYiB+IHVjAzdyCmHMS2OH3j4qgyZUyQSTwBpGOFrcHu6x8DCU1sVPa2fzJeBSWbBXMZSz9rJ3VJd1sf7pubo0YxMR4KpwfCgD55iBE0dYHbCx6RFAQi2M54SSaP/9GRft5yc/56JaELi1lOOY0OCJ/I4Jv2Ia/TzAJqGOE3+7EynE5ipKxjebOhC5xvZsP8OW/AmW9ygyGgDiVW3xUSeq0HzCn+Y4WBCCY5Dtluk42k43wQ/GIGJMla+x/HIPk+S2EUmtJ22NQQZUppTxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ca6sbpfQD6U+Vq5C3P88ZrMtNMeI/tpD577wDbBgRww=;
 b=J/IJvli/MXdmr7PchdlOCvuRRiBhZUETC9WIOXuM2jdQ8WmO8fkVHbCII+22BPSwIgJhFgcsX+x0WGi78d0CuHo/iSxyKarANhXqdIkUB32QImA/C9Ud2Dc7MUWAODKJUdTNojbJJIPIbyGOHGEWCDYxed36qHAc0ulo998FwYA=
Received: from PH8P221CA0033.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:346::10)
 by CH8PR19MB9024.namprd19.prod.outlook.com (2603:10b6:610:254::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Sun, 11 Jan
 2026 11:48:11 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:510:346:cafe::43) by PH8P221CA0033.outlook.office365.com
 (2603:10b6:510:346::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Sun,
 11 Jan 2026 11:48:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.0
 via Frontend Transport; Sun, 11 Jan 2026 11:48:10 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 018BD98E;
	Sun, 11 Jan 2026 11:48:09 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Sun, 11 Jan 2026 12:48:07 +0100
Subject: [PATCH] fuse: Check for large folio with SPLICE_F_MOVE
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260111-fuse_try_move_folio-check-large-folio-v1-1-04921ecf466f@ddn.com>
X-B4-Tracking: v=1; b=H4sIAPaNY2kC/yWNUQqDMBAFryL73UASUWqvIiXouqlLrZGNiiLe3
 WA/5zG8OSCSMEV4ZQcIrRw5jAnMIwPsm/FDirvEYLUttTFG+SWSm2V3v7CS82HgoLAn/KqhkaT
 /l6fN26oqOtQlQvqahDxvd6d+n+cF1lNHPHcAAAA=
X-Change-ID: 20260111-fuse_try_move_folio-check-large-folio-823b995dc06c
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
 Bernd Schubert <bschubert@ddn.com>, Horst Birthelmer <hbirthelmer@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768132089; l=1284;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=raQAemcR1wX95qQJw8IYGmuoCqsNLcjcatg7IAbgd0A=;
 b=VKu/DL9VYibI2j/VRSYjuJnfhejGxq1zJZLiLnEoZ4XQAWXCpX7Ud9NeoGpYTDGQ3sGjARG22
 tJWTcSGZgXJBEKe/vPz9sz3Vji2X7V7478TJV8y+PyVRgF8+JIUS/0b
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|CH8PR19MB9024:EE_
X-MS-Office365-Filtering-Correlation-Id: 70f4f1e0-df4c-4c2f-2b3b-08de51074b95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N01VMXFhSE56cGxCa1I1ajhIWGRDY1hQSVp3VE40eXZUMkdOMjlRblVCNU1V?=
 =?utf-8?B?ZVo5Mkh3eUxUSFhmU1lpenpnTi9XTjlBcytzSDhZVjBjVWQxRnRNU2ZPTjRW?=
 =?utf-8?B?ZHJNaVdhblE0ZlBtNUwyY1FKWGpQSXJLNDgvczNiOWZjbWt1cFJOeURBblIv?=
 =?utf-8?B?dWZtYjc2K2VNUStKZFlDczdMVlNuS092NXRDMlBlRklZVWZvMU04aGtwN1l6?=
 =?utf-8?B?dU9aQ1VxVEt4NU5BK1c2UGh6WjBiWFBvRHQ1ZmdoWkNLNEkyaThpU1VlMmVs?=
 =?utf-8?B?QWo4WnRxdFZpbENXaTNoMnVRVThDVVdkTUo3amdPc3hjMTE2RmxNNGpMOXI4?=
 =?utf-8?B?NXAvNFNQNTFrdDJMR0FtL0RjanBZRngwYkhwbFFsV0dSekloZ2ZkVk5pQVZh?=
 =?utf-8?B?YUgzQ2JTR0JQVGtjRitGcTlnUDlXK0dCWFpFMGU3R3pYbUJ6ME1FQWd5aUVs?=
 =?utf-8?B?YmhrdTdTMisrdnBLSWhIZkdvQWo2RldzVXBQV1ppdVR0SDlzN3ZEOGpVeUNO?=
 =?utf-8?B?U01zM3kvU1VVUHpKb1ptYVh5eVloTlErR1RSU1FLMHZBdlI4T1V6OCtqajZz?=
 =?utf-8?B?Y3RZM0lCMlljV0cyNEJWZUFEK3QxTjJzQlJhKzdGYThRWGU4Ykc4Q1JMT2Yx?=
 =?utf-8?B?elA2aGhkZUpPZ0grZEdrajV5Tk14UkttVWVNRjlyemtHR1cybmpwT2YyS0g3?=
 =?utf-8?B?NzJUanVWVG9QYythaVFZd0JNMjVZY2FSR0dNb09TOURyVGMzYlg1SUN3Q2dJ?=
 =?utf-8?B?K1AyS29kbjU4U09odjZvb3I4K0NUZTM2RThQT3hqSFFFbDQ5QTdwNTNRWlRt?=
 =?utf-8?B?WEd3K1pacTkwWWpzREtqWHVCeGR5NFowdkZ1SDE4K1FZYVJ4Z3g2ZVc3TW5N?=
 =?utf-8?B?Y0NyQjNUUU5UbWdYSDV0dlVpbmo4VUlzZEVDSXovVHNhdWhLU0N2RXU3bE1K?=
 =?utf-8?B?Q0hLWEY4bndGSjNNVHR2QTVaQUhxQzk1RkhhU2s5UWxHUjhMSDMwMzBnNkJk?=
 =?utf-8?B?WEV1MlR2TW5venk4WVJzVVVYUmFhUmxUY1c5UFFqZDc2WkhqSUs3T0V3SUla?=
 =?utf-8?B?RVhpNjBOcUl3OXRRZmxXcUQrWkxMSHZ2THY1UVI1bVhERU9BUURFeW9oenNq?=
 =?utf-8?B?S1l5M0FWbFpVVkxJdFZrVXl5V0tqY2hSTW11ZUoyVG8wcEJLbUt5V3ExbVFq?=
 =?utf-8?B?NzN1WHRRMXppR3VmK3NnUmszMm4xTys1eVVvZ01vZ29tRzdPZHR2TlJvRENx?=
 =?utf-8?B?aW44bVErNVc5S2ZXd0ZJT3VsN01iN2kxOWdKb24xY2VFMElrOHZpVlV4REJF?=
 =?utf-8?B?aXNDdUJIRUhGSXBRa3dvOWUrdG1LNno3SlVXZzFpN2QvUHE3OUFYVGRDdTRH?=
 =?utf-8?B?QVhhR0UzYlRCZU9YenVZMzN1YjlUMFJ6eGZ3V0E1QUZ3SUVUS2ZhOERpdytk?=
 =?utf-8?B?UFMraFdpQ294cE1VaVIxRCs3Z1N2UVNoOEE1LzdFNWlqRzJnTTB5dkpOaGMv?=
 =?utf-8?B?aWRQUFZPY09Gdm1ZVHg5cHVteko0U05MQzdwd3I4US80RnRPOVRJQURvQnRr?=
 =?utf-8?B?eXhQMUFveEF4Q2ZlOE03Vmcra3RWamVkNUswb0hWMk8za3R2ZHBsd3ptRUxD?=
 =?utf-8?B?Mm5wM3YvVnNJcU9TSEZQTHl1Q1Z2TUY2RGVtWW1yaUozdWJvaUxBdjQ0THh1?=
 =?utf-8?B?Q2ZxUUxCUmp3Rk5oakEwczRnTjNIZ0dlSTJobk1tQnl3d3FjN05Zcjc0WUIz?=
 =?utf-8?B?UkUrc1ZvdmhvU3JndjR2Y3UyZmRtTE8xbys3QXdvSmhPRnYvNEZnMlNuakYw?=
 =?utf-8?B?Mnpxb1M2SmRuSFdJTmJGN0I1Tkp1WFBOdVUwTXVQN2g4bXJmSllPWFdTVDFm?=
 =?utf-8?B?Z1JQRFAvVCt2RnBPQ0FXRnRoTGJzVEhiNUw1RWt3NGVMQlR5UmxpaE9KY0lz?=
 =?utf-8?B?YmVyNTdjQndSMGdac2cyYVdUNHBXOElnZExPZ21uYVYrMExSOWxQeU1JeFVy?=
 =?utf-8?B?MkZCajRRdmtQeHBxWTFaMnR1K2s1VGV1dThnckVicGVYUXNKTTArVzZBOG9r?=
 =?utf-8?B?UXpWQmRHL2QydWxEYkdXUmRBQkxFdWpwdzlpa0pHN3VJRXVEZExrbWFacmRL?=
 =?utf-8?Q?dHXY=3D?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(19092799006)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sNPCdsRguKUi91zj4E1edi3sACJSblsVv0iieucrj2dFA0jiAKuguSaKELgnoTOzLl4RI24AFzmBTyeypgCZUDNAQk0BeBJqaH+ATYVdAj5a7Q/yf8UdAS+tI8uS1PHfyEluH+Y5DIrSY5mCpSwkrW17Eid1medSYsTYpdmdFqHrmj+MVTwlHMzLZ3vieG7zJn7RSwSYyYCUCZtjS5RgwjPVIcv/9YALdhdLJehOWszr21VQIDPFpX+MstxURwce4+CSR5y2ZZpI/18dAM7q6zFuer0kUsIn+45w44BHpGwwarBmfqPA/0SAUbE+dEdTc+UJ3knLsRAcvCgOZy5vpMKk0BTy/wLLQArJdyN+IndcQspqI9IsPjY5KT6qqrv00EPyfysM27Pj8g9rDdYxAsBgOLZpYEd8IpFD5ciVaxZ7DFDdww0azmXPJx3+r7hYaoGSOPOee9ICrMgy+3pEORe0koG6sqoxXgvwzgLitIEi96l6O2Iyz/fdqFfNz41GOw5BMu4Ks/t6MAbI1A5IHlbD5GqSsyrosIIoUe1hOZHp7r8RGv94r8XG3X/KT2xUENNUHd/42/IfGlSfEuZn88Ruxn0uQg+JJJEKbPRcaNIV0hr2e8+LLHLJ+2+s8wsbvDzMrIMkEsyJWCQlI/6URw==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 11:48:10.6941
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70f4f1e0-df4c-4c2f-2b3b-08de51074b95
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR19MB9024
X-BESS-ID: 1768132095-111056-12969-28677-1
X-BESS-VER: 2019.1_20251217.1707
X-BESS-Apparent-Source-IP: 52.101.52.88
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoZGJmZAVgZQ0CjZ1MQwySTVzD
	AxzcjA0Nw0zcg01dDMNDXR0CLJ3MJCqTYWAPOcRO5BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.270319 [from 
	cloudscan12-144.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

xfstest generic/074 and generic/075 complain result in kernel
warning messages / page dumps.
This is easily reproducible (on 6.19) with
CONFIG_TRANSPARENT_HUGEPAGE_SHMEM_HUGE_ALWAYS=y
CONFIG_TRANSPARENT_HUGEPAGE_TMPFS_HUGE_ALWAYS=y

This just adds a test for large folios fuse_try_move_folio
with the same page copy fallback, but to avoid the warnings
from fuse_check_folio().

Cc: stable@vger.kernel.org
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
---
 fs/fuse/dev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 6d59cbc877c6ad06deb6b02eba05a9015228cd05..1f1071d621441b334573ab42b6d820d996bdb00d 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1011,6 +1011,9 @@ static int fuse_try_move_folio(struct fuse_copy_state *cs, struct folio **foliop
 	folio_clear_uptodate(newfolio);
 	folio_clear_mappedtodisk(newfolio);
 
+	if (folio_test_large(newfolio))
+		goto out_fallback_unlock;
+
 	if (fuse_check_folio(newfolio) != 0)
 		goto out_fallback_unlock;
 

---
base-commit: 755bc1335e3b116b702205b72eb57b7b8aef2bb2
change-id: 20260111-fuse_try_move_folio-check-large-folio-823b995dc06c

Best regards,
-- 
Bernd Schubert <bschubert@ddn.com>


