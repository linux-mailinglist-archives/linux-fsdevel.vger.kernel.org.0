Return-Path: <linux-fsdevel+bounces-56856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F0CB1C9FE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 18:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82C59189B1CF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 16:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924C729B79A;
	Wed,  6 Aug 2025 16:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="MaklA8EZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013061.outbound.protection.outlook.com [40.107.44.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539E8295D86;
	Wed,  6 Aug 2025 16:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754498979; cv=fail; b=YGN2XNT09VWz2L4xmRj8H9g6fcGLEZKoCJGQNS/sGc83g8l9V28qov9kB5fA2do4aFcRCjYkIh3PU7hoxSI7CsripmkGx/yABJck2KEpj/6+3hj2rGEsdL7obC5Ayzk6uIOoaDxhogLG912R/YrcUgQ6LN5om9xRodqi+aEjIew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754498979; c=relaxed/simple;
	bh=cyTiw/vNBjG7r+hLUfkb+DhhiC1maF9kujKKkdtZuPA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=mmG4Zw/uhz4J76ihIpU+DD5FXm41pKpVgX8fmARpFSSSNUhgLVY2ovxngigS6Fgwr8y7najL2ivMZw01szmGFh0nNqCLOhceuZPGR7X+LlETqECiqOwLO9WelqInvRWxsscsL7S6sBr1vnXDTGjyl7LHdhkMigVIDGhd94wIo5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=MaklA8EZ; arc=fail smtp.client-ip=40.107.44.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y/fCrSYOMbSjZcZRaKieq7mmk8Dem1Gc06sntZ+vaJfUQ0BqS5z/eKJtvdm9BUfQl7VAJD001I0ET59edCuYAl2DWiRIz/YWTepraGLkvAG3HQCqt4dhrYAWgj1jXYk0za8g3+yuXVAPEHAIHR3WIAaNJqLGHtdnriUFSHqOr1wB38DjHZCgoERWX76bcBBHA6sixRjzB8nuPQDwz8iSCIcu1A5LfNhzUu0Xu9P2PAybzkFjMSGqb5BRNlrgNOnU/g84WwqfYUKU1xsjX1vFYSb5WRAXUviTODwF0BmbIuTN8zY17cGdDDZ8V/ov4t9QEz3gwWlFLCTjcrJadW0uEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=87Wp8uYCuSIPQRT2Uaz045ReplMY7YJLiBXH+t1L1BE=;
 b=WnfmRlIXXmlX7HWOC7lusoR7f9UyTNKitSQ72qjHS+3R/xs7kPKnfNKlI9B8TqyGJY+LiVOY7OO651Uvh5pdHi/Z8RlCHSU5ddixCXpbNEgoeReP7ICVABsErt+3v2D3xMb96UWE4WtGZxEGabaLmoLy20beeGXnxwy2hIZb3C1vWBIfa1CbOF23Q1KI1+H99UFHStwGjJ/fF58W3en3Sg8K2a9nrgOuKz5ci1COpZKr3xKbOaJYiN/W3TdzWn+yqvYdd4z9g3PSLlXpFaKwdYVKsA3WVXBbLw8lTFPhXogP6tS1+nHWdsR7dl3b0f04WfvB4oMdLcKqct3jUNrZOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87Wp8uYCuSIPQRT2Uaz045ReplMY7YJLiBXH+t1L1BE=;
 b=MaklA8EZj0h4JNh1z1iwLkUSzBgjExYKPzicfUbQBOTAEoRTbu7QQHQRLWu8ilkR4vwZu/Qm2hEyVZmFY869f5slWeXXwWCGw2lymngoY9Qdn3gBxTrOV7kofvfb7gT1/XlYx1URXW+QSN9S99IUDVzJl+tdlcaGfwLaOF2FejHx7nLJ920NUs0869jkZfSzmZiLU/6eYah/btEkX5y1Ljn/dy/TjWhP7kpb6PJr5SegeS9638mTW3rQLYcWjAoUkDCi3hRX3GtrXKPMX1Fa8zekaFCuhYVSp8ouvF55fphD1q94FNpHADuxTC02kuQssPnQkW3vtCvMNBH4E/PT+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYSPR06MB6337.apcprd06.prod.outlook.com (2603:1096:400:42b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Wed, 6 Aug
 2025 16:49:30 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%4]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 16:49:29 +0000
From: Yangtao Li <frank.li@vivo.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 0/2] hfs&hfsplus: abort for unexpected name length
Date: Wed,  6 Aug 2025 11:11:28 -0600
Message-Id: <20250806171132.3402278-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYSPR06MB6337:EE_
X-MS-Office365-Filtering-Correlation-Id: 6535ea4f-0b35-47e0-e9a9-08ddd509357d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bKelNXv6/n4+iJIBinHkGoWnrVtGsOCI+H1KOU0hwl7yFfQHzBLqTa64HSoE?=
 =?us-ascii?Q?1LapBWJ7PO+aNp7KN0L29yIIxkKg9fmr3FHPKbv2zozqX6v8bnmkQMv8gFFa?=
 =?us-ascii?Q?jpLwcYtWrEu+w0GxniTT4Wk1nehfotqa+B3l90uUn2MU7s0p4zJyMWfTpBKp?=
 =?us-ascii?Q?pO+uCW99IoyiTZgoxncyNKHz/1UvcQ2UnT/GJ//biNfWnpSJztiEsY1rBFRF?=
 =?us-ascii?Q?87JuMuoquBt5QqEEElZrmABgo4f9T91sv1SEljZ0itphMHxrzkLmkAq1lpJF?=
 =?us-ascii?Q?IdA2NsheZTXFQlrzkKoYRsmjTETsczS8JdcLr2WKHxcY8nVnFkslpJoxv582?=
 =?us-ascii?Q?wbqdQTk+Z96j/R5XaaiYHhoIyctCLRRitcOmlJmst3IqLRcjzUFmdsgNVN2+?=
 =?us-ascii?Q?azBNBz57VAm4lY9WvnB+hxgbwGQ+iY/3i9uCTWkuLTeVxQc+KQx/5UULkqEQ?=
 =?us-ascii?Q?Daav1zAqzoBidMkebX5KMAhabLdQhsfKPd/NUQUVcPhJHd3pLeUfWfJUE9A3?=
 =?us-ascii?Q?NR5VpEAryLa8LCoNVbUaKIs39EyA4P6TkIec+57uhj/guuGG4who6rqOonhr?=
 =?us-ascii?Q?ifxfHqK+7NnUI+cp5fCDDzC+Rqv/K+6rAqCCKF+lqfG86OPbfP3XWRDWkrwX?=
 =?us-ascii?Q?SbVqsaUaeRVgv/h+ly0JszxsrlkzZ2GQ+R0NULXQJhRduPkbvjtvZOEnCfBm?=
 =?us-ascii?Q?iynqSZrfBxHGtCyKd2ulnI3yuZzfj6gkAUrVFCk/X8BeS+wdHBfK63oDGI9z?=
 =?us-ascii?Q?/GHu6zBRqEalI3T40Ut+G/hpI3bzmTKvZw1hgCuu9jGbAo0qzDlv0GeUR3q+?=
 =?us-ascii?Q?nFyhYTXV1q9fJCrDI/IMhNm6Oou4z0Ahg/UA6iczOKL+IU7kvkHBh6YQXm4f?=
 =?us-ascii?Q?NdGUinm8+QCyj0LQ4fzt7omLU4NnfVRQs5vp0FrGf8gfLeFkiCS5piGRZCRf?=
 =?us-ascii?Q?hKCQ3KIDN3SAsuInRBDWhe7tRweSoUdbK3G/lfC8yITdHReXtRAxzzuIKnL1?=
 =?us-ascii?Q?2v/6JZH869p27Gmi2NGHn1bX2Y20YRTP8FSAr8LPF8Rg9woZpFsPVja5ymhp?=
 =?us-ascii?Q?ZH+NDfSaFZX/II1LWFZHQDyz8GYUxrqAHbqx3MW/7Flsk3LqKZU06ihs0ZI0?=
 =?us-ascii?Q?eKb3dYARvxQJAFdizQCIYSRhkE8CmKQP46Lf4IbfZKu0DPhW0TmXHfBR8qaM?=
 =?us-ascii?Q?9Iz9gCb8whNP7raeJX0tYgmQmE8WEM4pfS3hxqv4kXRq1CX4Gk/EWCLmAD9n?=
 =?us-ascii?Q?3RFioaYEH+bIo8nPv0uBk9MXnVvFztXJiEKtP3C71t5Gpi3t1xJggi0CT/Rq?=
 =?us-ascii?Q?L0jpC5JbKL7AqJ/E4iZfo5hrpeyABBn2/s3adzz36jEaWVseeh0gsyS5RFcU?=
 =?us-ascii?Q?p5YglhzVcMM+F064eiZL/Jhh/RiWtTtH1nVcgDzLs+rfW/+Zx1eQMQtk+fZP?=
 =?us-ascii?Q?CcnLjHHfPkYKyIEh+AXQiWBV/etdfzBdR2uEVVYNl58lEo6KEXdgZA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CTe7zEhXv+H/RCr1rHF8klHnbS9qeVa9bAenyQolC96FxSTtgl8lIXUO3buL?=
 =?us-ascii?Q?/Eg3NwAvrvzK0sTmeXmw6JXCcOv41JT+4SOOJZSyVVyM4wQTQGz5nRztEjH9?=
 =?us-ascii?Q?UMGHRmTeVeqWqMAJT96GpBXq/u57GHdwZ/3u6OxOb6u62N0tqh8hq4vU/1bp?=
 =?us-ascii?Q?dtFJW6xBOcmxNBwfQfx9m1sTovn6lJu4PxknxoBekUFNIudyQG3T7sSrnWuA?=
 =?us-ascii?Q?w9LsqxQ3egMGbYEnqzLfR78n3gKJyMOFQCNHOZimnGI/0y3YykEVuXDDHNLo?=
 =?us-ascii?Q?CCX8icKKmxXlyUrgfreufafTDSQgb9ysBgvX37xYxy9Mv0p5R5VLxDOsFpkn?=
 =?us-ascii?Q?LkWdFxjmhMk7ikpJSf/1U+CN30Lhb3eRv2Z+SWJpYMPyGed3qdJXDMR08ep8?=
 =?us-ascii?Q?0spCZoEZzOIiaQ4YWz3dnS71GsFtObRZu5UvG8ArkygG9dgJXpv3fgl361Vs?=
 =?us-ascii?Q?4FTpdeBA3aZ3HuT0osQXVD5tXYsAQ01OEGgjfHB/tOTQhUs9YcWyWvZO1yic?=
 =?us-ascii?Q?VzQITj7+gUScs9hWK7tJBYyQ2+1U2FWrCMHAtN3Pvwoj4EsRuhaTTDTOsw9F?=
 =?us-ascii?Q?YbiAjnDq3dPAFwOtlC+jQhGsvXkboXkYFlebw8hAx/QoBG/q+UOSqB4B7eeg?=
 =?us-ascii?Q?Jsdm4wIBlwIoZFlWCfXjHXvvjkyAPAlHcE8a8nPDrxzTQappGNQJjscQy9tZ?=
 =?us-ascii?Q?/AkV2KFAR/PhYa1OUMmdnnXTn5vN10CsekoeDdQ10cugMZPY/i0EXJvYxMe2?=
 =?us-ascii?Q?iA3bq5dST56SnnyUKGOPtt1xJNfGtB8aJEh2p8TZ0rxsjK8wrDDDduSNTaBo?=
 =?us-ascii?Q?vZCrYixCiI0s5KIXCw4lQDcdjhRCtyJ9WEJO/VeANH1cFO2ZCQH4708a4ui5?=
 =?us-ascii?Q?Sy53WrudK5xWgCqB5n28Kobnq+Mosp0DQRbNCc3QZC9CMfex/4GbkVJGYLD1?=
 =?us-ascii?Q?KjYE8AIfMxoyUX9v4f3g3fIfaK4PqshlmZu/v0TGAjU4MXuQ7jIBb0kKii/z?=
 =?us-ascii?Q?RohsNopogSN75XqPncK/d13lvMV8rCM/WMh0cekxiMmHcJdX/bW63/7ufuJg?=
 =?us-ascii?Q?o/1sIk2btyzmCR6geX1M283Ftyz3K45o0iItOqmJJlC5X8phQFZnF2OO7EkH?=
 =?us-ascii?Q?qNbN3EicxyOx0u+HtQVqA0pyTQn/uuDEceVN18kEifu3WSbBLsiKY7UG+wfB?=
 =?us-ascii?Q?XG3dWbP4kThOjQRWtWPYSv0Kyz5ICk14JJUx8UiOR/X9dBvFgplg9Q8jaJcX?=
 =?us-ascii?Q?c0VMwfilaXCu48MhPSKI2edEIRZZwxlgi76Mz6LzJaGQ3EyARpkzhdzXle1m?=
 =?us-ascii?Q?5/eVvWVUEg38fmZlJSj9O15lxZKvC7TO5vSxJfom7DgQTIPm8QzD0xhb/gRk?=
 =?us-ascii?Q?1BPV3gnXhcHmmze9zRDsIDir2CoXY5Rii7Ptx070OEmsqFQNrh7w4obLI5NB?=
 =?us-ascii?Q?m3onjg2kZBtMGMFfnhfyp1ZW3ucgedOk6IFUf57avUuMO8JVKjncfWiWqYCp?=
 =?us-ascii?Q?091qDREFNeXW0qXUm9DLJfde44dqrpVh02HfKEasI6JGVgOMIA+muMuVl4I9?=
 =?us-ascii?Q?SFmJYg7scn4X+m2ZVSCTXtVOpND4MdihhEuDyJF7?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6535ea4f-0b35-47e0-e9a9-08ddd509357d
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 16:49:28.9813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MagZlqgTh7R7YaNUOfVdHIf849BppSYOeF+4uMGZrLDwFkjEaLkfle54zCMTPY0kau0XI6bs48+9JmSlHU+ocQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6337

We need to prevent to create unexpected files, which name length over
NAMELEN_MAX.

Yangtao Li (2):
  hfs: abort hfs_lookup if name is too long
  hfsplus: abort hfsplus_lookup if name is too long

 fs/hfs/dir.c     | 3 +++
 fs/hfsplus/dir.c | 3 +++
 2 files changed, 6 insertions(+)

-- 
2.48.1


