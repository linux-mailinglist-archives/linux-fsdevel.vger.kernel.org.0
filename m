Return-Path: <linux-fsdevel+bounces-49773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA0BAC2340
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 14:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E8D5A46456
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 12:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F43C14A09C;
	Fri, 23 May 2025 12:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxera.com header.i=@tuxera.com header.b="eofHChoP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2120.outbound.protection.outlook.com [40.107.20.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C890310A1F;
	Fri, 23 May 2025 12:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748005079; cv=fail; b=EwyVsGQBtOuO5niZEGvkfgD2C4y+YLwCC62jwnvuGVYEGCLq1FqTrazEArosYlZ8XYOkYJEUsd6vNj7CG8zA9QJGY+cd9cyj4we3NJzvAwdDmDswA4qRkMfw4PKdSobz5vsZmb/OWj+TkhoQZR+c51iPglp/a6ws5noRSz6+5ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748005079; c=relaxed/simple;
	bh=9HzKjeYCrXlV+jzYVDuGtBO8+EdK/CkZImUZ0pVQS8M=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AVDi8MXpmMADNyDjJAPn/prcfPYlbhgfzkTF1iDMPCAPLAktHr1GAFWRAimCJhU41nRMTSqNCK11c2Ls9IyVPlc5Ps0cG9oUGUV0RWHYKhhrCD8zEwoNn985f6uskaRi9sDrV64CNh79YlYemVup7SCw8A69UQkjrOdMNowehLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxera.com; spf=pass smtp.mailfrom=tuxera.com; dkim=pass (2048-bit key) header.d=tuxera.com header.i=@tuxera.com header.b=eofHChoP; arc=fail smtp.client-ip=40.107.20.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JGBMgpfZFrhcMqXw5dGIN5ofCj9QE95WI8JfjYFoOEfIT/RwF8QEHQft9mtrYNNg2JwRn1bvELq8tvGz0eSpheUuLpoRLp5RYYYzGqzoOiL5JjVf7JakrjRd1OzNsduu/X6dfEOp16QdCraGgPwTnAevpmpuAm3G4sPtGYKvJQajN3JzkYzpaq9af35zf6+tJ5+JSAhNu+LW+i9fyivUzUzLeZwzSkfAMDxPPdkJ79xSXRiAeMZVFVN1kTV8us+Nsm0UNjF0BT458pwdq9U5ZSRHqQCN6gF/saEZOvh+eAawD0wEP5lxOXCSWCZbhlnpEjyBnEkCfHhYSLc4jR7wNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVP+ygWcitRHxmtADqmqYED5plcWhRm31plhQOlqjE8=;
 b=dVZ/Fhz1nekkiwcwc6DsiDiWLyUWHB/rLk9yibL06VV0YP+pnIOMnl7dKB9slkTdwmLjaCIQu1SFo1CAABsE54y7xbzT5LXFHlX8S87qxTkkbS/YS/yvh9job/VcyTfhNgK5Tf99tjLLV6LaKHzG45uqljz3KnnFAHiyBqNRUFMf8E17r3kS9FKe8GNzAFzizCvSIyiAWskMVSXCoAEckzh9ROGhAwK7vD1e1dc5wZN9UaoC2zqshmhEZM+SD4qh043+HwcytsggDwROFsnv1lYIOFxXzyQcPfqXdVLb4Ym/dAvRwksRWtV35cKNLDF+GsuH35KuY7/5aCRFIHwKfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tuxera.com; dmarc=pass action=none header.from=tuxera.com;
 dkim=pass header.d=tuxera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVP+ygWcitRHxmtADqmqYED5plcWhRm31plhQOlqjE8=;
 b=eofHChoPBaxTOIynf7JqpAz/egOKn/Pn3wXTveg9gfhqKRW2Qv6L/VhpXvbvcNNkSIpSNyxYZ6WxLeD5qN1RGNksblj9V45vV2FJUJSoYjNQXCGc+mUaH2guYbCPdHH1fVrLAlpLIRBqwFTTQ/RDfDaurBDIi34cSVmWzzu0cgizErL+b08LP4QIdlGf4NzLhFcvQuV9ITp5Gf4mufQj3zjpzZVpZWUaRpRWzkoqi50SqvuZORj9L4o4V+BXsLMiIW3+r1drJZOI/5GOd8Q76LUMBWsYtPeTtuHAwcRZzrtYEkjc9Ha+LP7WpyA5bAwsRsdYNz9wsRHWp7k3St9I+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tuxera.com;
Received: from PAXPR06MB7984.eurprd06.prod.outlook.com (2603:10a6:102:1a9::9)
 by VI2PR06MB9358.eurprd06.prod.outlook.com (2603:10a6:800:225::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Fri, 23 May
 2025 12:57:53 +0000
Received: from PAXPR06MB7984.eurprd06.prod.outlook.com
 ([fe80::f663:f3dd:7a0:7d4f]) by PAXPR06MB7984.eurprd06.prod.outlook.com
 ([fe80::f663:f3dd:7a0:7d4f%5]) with mapi id 15.20.8722.031; Fri, 23 May 2025
 12:57:52 +0000
From: =?UTF-8?q?Aaro=20M=C3=A4kinen?= <aaro@tuxera.com>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org
Cc: =?UTF-8?q?Aaro=20M=C3=A4kinen?= <aaro@tuxera.com>,
	stable@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Anton Altaparmakov <anton@tuxera.com>
Subject: [PATCH V2] hfsplus: Return null terminated string from hfsplus_uni2asc()
Date: Fri, 23 May 2025 15:57:31 +0300
Message-ID: <20250523125731.83227-1-aaro@tuxera.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV3PEPF0000366A.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::386) To PAXPR06MB7984.eurprd06.prod.outlook.com
 (2603:10a6:102:1a9::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR06MB7984:EE_|VI2PR06MB9358:EE_
X-MS-Office365-Filtering-Correlation-Id: 295978d8-3475-46ee-ebab-08dd99f96dcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VU85OHp4VHp5QUtnS3pSWVZLdFRWYkdQZDZHQ0hJZUIyNFF3ekJMRDlHMDRT?=
 =?utf-8?B?RWFCaUtCdkEwSXpFVm5ucE5WOTFVYlYxenlqUFNBQTVjN3ROb2I1a1R4ZmFv?=
 =?utf-8?B?eWNWK05pU1BnRnVzcVVxM01DREJqOHFQcFFYbDYyNlR6Sit0L0VxTXdWS2o2?=
 =?utf-8?B?WnM5RGczS3dBb1ZTdFFjanB0UTVOQStjOFVTK3ZaSEp6UnBTNkNlZXgrWTJQ?=
 =?utf-8?B?YTIwL0dPc3pFemVHcGJSOW9UUlBWZVlmM3pvNFovT2xuSnBEQ0tmSTk3Szdp?=
 =?utf-8?B?dytrWEtZdnZVQ2pvaXk1U0E5dThiaFNMc3ZHMWF5bXJ1T1g5Smp1ZWlNU3lm?=
 =?utf-8?B?Mk5JamV5dmZGblVZZjFzWFBvUjVtK2ZGM29PamV4aEkrSVIra2xrTTUxM2dX?=
 =?utf-8?B?NjBXUDRNQWZGVzI3aEk1RHFFL2tjSTQyNUs3SHJQNFpWclIybEsrc0I4R1l1?=
 =?utf-8?B?ejJQK3RmZkcxdEJ0cmY3eHZPaWJpYkh6czVUR1ZGZXhKRGpqcWJGRUFkaUlG?=
 =?utf-8?B?Wlc1U2JnTUNHc2JTL3JRUDJGMU5mN3NOSXhrdTZUUkpzL0hIelhvVTh4QUZw?=
 =?utf-8?B?TlpWOXc2Tmx4TkF6elJxTElsSEJ3TGN6VDVGL25LODY3dmRLbFhDTDlHaURm?=
 =?utf-8?B?b0N4anc3REF6R2hMR256N3lwOEwwUkxESmN2Q3lRZ1czSDNEbnJDYStLZ1pT?=
 =?utf-8?B?Y2MzZ0tGeU05ZXk3TFRuWjNibTNJcUxMQ2VqU3FURzhyWU0zSlJyY1dQcUdv?=
 =?utf-8?B?QkpwZUtNUXJzck12T1FiZm5FKytIZHJiUGNSZWZ6Q014ZEVkTUlNbjFYd2ZV?=
 =?utf-8?B?QWd6RWkyUklBVU4xcG5sbWVwSmUyZWNFK0lTMzJoZG15MWN5SUdkWGFILzdh?=
 =?utf-8?B?VTdXRWpTeHVyQ2JOMTZxZExKRU84cnBISXFMRmtqRklLdlhldTFWTG9rbVlN?=
 =?utf-8?B?dmdqTndNeUttQUFYRGk0VkovNDRsTWpyN0JQNnA4UDdkd21udVJZQTk2UzBI?=
 =?utf-8?B?eTYrRXB0bU96K3BRMUpNRnVWdkYyWmtldTFPRkJuaDRSMHYzeVFIWDhWMTJP?=
 =?utf-8?B?TTVmdm8wZmttdkNGWFdVdk9iV29tTXF1cWw3bWROU2VOQ1dqWTc1M0ZCSFE5?=
 =?utf-8?B?em5abmVjY01TTit2RFM0K0F6WndnZnpHVE5ERFk0ZkE0K25GNXFGMjNya1Bm?=
 =?utf-8?B?YzA3S0dmV3BHVkx3YXBYOXdGTVNTc1ZydzhVNmFlb1JQM1RRU1dobCt4QWJn?=
 =?utf-8?B?UEliay8wRnFsMzZ3Sy91TW5WK2JSMW1oaDZid0tGaUdMajZIK3ArK2I1YUIr?=
 =?utf-8?B?MEYzTXBpZHh2QXoyUnBFWGllQmtPelNPQ1ZaUERlRFhXQk9mVGpJL0NZSmdp?=
 =?utf-8?B?RW1KdkkvUjFES2U5ei9VODU0Z2NqNUtBOE5hRnovMjBnR21QUEF4d2JGRmNZ?=
 =?utf-8?B?Z1JxVDFxRGdEZHFSNUY3S3p4dklsQ2s2Sm1aTkcyZVhLTUFsall5TTRnRFNV?=
 =?utf-8?B?cWF0RXVPSmp5cTViZzlLaE1JelZMQjF5RWxrSzQxVWJBZlNkT05XZ24rbE9J?=
 =?utf-8?B?WWVUbEozZDEvSTJmMmdGQmFIZ2pMZGRMdUNLWmwzenJJWFY2Ykxka0ozaXYy?=
 =?utf-8?B?dE9pV1BVZDR2Qytyd1BxanRqdUFBcDNXRlhvNkhHOGVVKzY4QkJFMzhyWDB3?=
 =?utf-8?B?M0M4RTc4VTRibER5VU1SK1Fra1c4ZEIxRkE4Ly9Fa3E2c0kwYkRrZXBVUy8w?=
 =?utf-8?B?S0lMdnk3VXNTYXlBM1lBWXozeTV3UXB6MTQvYUJPTnp6ZUJCY283WVorbTFr?=
 =?utf-8?B?OStrVmMxazRhWEFVVzYrTStETVRVYmVhUWtiN1NoVlc4TUFXenBRNytsM24z?=
 =?utf-8?B?elk3a01iMlVYTVVLbUtOckhDVXR2ZHIwSnIraVdQaHdGNlRpZHgwNDFkbVQ1?=
 =?utf-8?B?TnE5VUlXTzlwWWhwVm5RaU9ybGhRbUlJUUpqTlhqeGZHamlDVExBaXJmNkJw?=
 =?utf-8?B?ODdsLzBqa2RnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR06MB7984.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2J4V3ZRMWN0Y0R5QjB3bXAzeHRzVzlIdTZ1OFdtaGRidS9LTHlZVi9uWU5h?=
 =?utf-8?B?NmVwbzYwNnFzUnNQbklaQW1YZko4WmQ5czk3a1drektmeHJTU0tJd0MxdXBU?=
 =?utf-8?B?bVNOQzdLR1RQSzIySVdJcXZyV0RPSjRjc3kzUHRXVVZ3MzNVdWlaaHljMURt?=
 =?utf-8?B?UlRxQ2UrRjhZOWdnY09UNDFpcEJsQkhhd2Y1ck5PRnpqck9YaVJBeWFuNzNF?=
 =?utf-8?B?T1AzL0RnSEFKcXpSbkdWOVFTUlNRZVpDbnJVcGRSRjJldFZjOEJXOUMzWTBT?=
 =?utf-8?B?OCtFeHdmUWhoV3VPZnpOUEZ2MEZqU0JtYUlTZGg0Szg3Q1FFYmdHdG5GS1NB?=
 =?utf-8?B?V24rQWNXL3phRXUrck9HSkpyMjRiZ3dzSXppZlo0MUpuaFZSc21ZNnBkY3JZ?=
 =?utf-8?B?OC83LzJvOUd6bHdqZlRzQ296OVAzWHQrT0hkaTZhZkp4cUR0dW1QdW5XKzR2?=
 =?utf-8?B?UTQvZk9tNVRIeStlTTNxaU1TcFhCb1lQZGRWY0c4NjExRTM4cWxvR1M2K09I?=
 =?utf-8?B?MnFNaU0xaDl6ZDFwWVJEakFWc1dwMlBRM3pMTzZ4TFQ1b1Z6WHdhaDYxQmR5?=
 =?utf-8?B?MUdnMEZOVy9nejMxRUtrU01xWG9UNmFnMyt1VCtIZG83TndTaDJDZFB6anpF?=
 =?utf-8?B?U1RVUEtiT21GUm9Qay9BcFMzWkFtSlA1NWFLbm5yeHVBZ2NXRE55S3VJTVlq?=
 =?utf-8?B?eDhDRjd6NXVBOTlTWTFlQWRybksrNm9teSsxMmIzV3VXcFVoRlZiZzh3LytB?=
 =?utf-8?B?K1JLc1REYjdqeStVQk05dWwrNGNIcVNpbjlDdEVPanVTcitpNVB2RjcyRXFH?=
 =?utf-8?B?VlpMRkdhMnhmV01yY2pTTjZIVXh5cWl2OU9CNnd1VjQ1TWIyZTVuM1lqbzhv?=
 =?utf-8?B?QkdSUEYzeHBRYWJqZXFaUVhGUlhTVjdKT0VTdEY0RjRiWDVtcFB0RGlKdEY4?=
 =?utf-8?B?UnRjTWhGa2p0MUlnL2NLR2lnVGxwVGFJUkZla2FtczMvYzBLeldnVnBiVm13?=
 =?utf-8?B?TjRON3ZNRWlxaVNQV1REYStIbkNmVFZtNXZxS2tRck4xWHFFUmpHUnN3M3Bm?=
 =?utf-8?B?cFkyT3E5TTBsVTRCOGtVSURVWlB4L0FqeC9LQmpyTWRCdGVWQXhYYlh5Q3V3?=
 =?utf-8?B?NnpPa2xJZmU5UXUzRU9Ddld4ZGU3SUlJc0JteUFzVVRZdnVpclROZkMxZGpY?=
 =?utf-8?B?ZnhPMlhRK2E1NnZXSGdMMWFzaUVYdFFQUjFRayswSmVhMjRaTnQ4MUlzbjFY?=
 =?utf-8?B?VmVVRWE0VGJpOGRObkVJd3o2Uk9DVDdZZVFucHF5dTZUOFUyeHptM2NtN0Vx?=
 =?utf-8?B?MElrYU9rN0VqNjExN2VsVy9MdmhnODZyYTVJT1lSUEhDVFFEMkxFcTNxK2JX?=
 =?utf-8?B?L3pwWTcxWlJibVNjN2pYNldqcmlacnRkb3MvN2FoTm1QaDRma0IxM0dDODE5?=
 =?utf-8?B?bjM0c09tRE9IMmVJUm9RMEozN1NrUG80aXZDNFkvc1ZSVVlKVmlyU3BZZGJq?=
 =?utf-8?B?aFJrL3hZZjFtMlFHRmR2ZUpiZTUwekNXMzJaZ1diWXZobzdwY3BWcG9DMlZH?=
 =?utf-8?B?WC9UWUhVYnU5OEU2MUd0S3lacStRTldyN0ZYdFBiaTVNSEVKcERUdWtIck41?=
 =?utf-8?B?MW9kZEJubWx2NjB6OWtSK3RkNWF3RC9BSVpBMnBPS1Y0TUs2UWt3VUF5ZXgx?=
 =?utf-8?B?Y2dybWFDdHlDYVJFWkw5eVM4ZEdPaEYwMlMrMWc2d1Z4ZUdTYzNhMkNrYUIx?=
 =?utf-8?B?U21oUHk4SlFPdDRsZCtPNTNXZkdETWlpb2IyQmNnVDhVTDZaNjBCK0VZUlow?=
 =?utf-8?B?Y1VacVlkSEJjOGh5ZHNLcnR2Z2llRWx4QiswM291R0NTZmJqdjJGQThWVVow?=
 =?utf-8?B?N01FL282bkszMXl6ZlgzZXhPWjc4KzhVeldRZXIxc09GNGdXbUI5R0dPRkJV?=
 =?utf-8?B?bklSdlNIT1hMMC9VTk1SeGkwbXE0VDNEQ2p1OENnUkNYam5tOS9pUmY5cDBF?=
 =?utf-8?B?bXl2N3RFSFpkWmtwbmUxQllOWG9UYUxyblNuRFMvUEFoa0JUOENOYVlWR1pn?=
 =?utf-8?B?NlZVQWVUdEdtdTBqbDBNS3ZEQW1SZ1d2RkplblFMZnY3MWl0cGY2anJCcC9U?=
 =?utf-8?Q?xz+p3sDUL+WgcL1q1FdsRXzs2?=
X-OriginatorOrg: tuxera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 295978d8-3475-46ee-ebab-08dd99f96dcd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR06MB7984.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 12:57:52.6171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e7fd1de3-6111-47e9-bf5d-4c1ca2ed0b84
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WYi5reTpz3U4eUlN0iFMndy9AbQKkX9rZAyPBFjztsp00PuhXLng7QoNB7C9pY44
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR06MB9358

In case hfsplus_uni2asc() is called with reused buffer there is a
possibility that the buffer contains remains of the last string and the
null character is only after that. This can and has caused problems in
functions that call hfsplus_uni2asc().

Also correct the error handling for call to copy_name() where the above
problem caused error to be not passed in hfsplus_listxattr().

Fixes: 7dcbf17e3f91 ("hfsplus: refactor copy_name to not use strncpy")
Cc: stable@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Aaro Mäkinen <aaro@tuxera.com>
Reviewed-by: Anton Altaparmakov <anton@tuxera.com>
---
Changes in v2:
  - Add Cc tag to sign-off area 
---
 fs/hfsplus/unicode.c |  1 +
 fs/hfsplus/xattr.c   | 13 ++++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/hfsplus/unicode.c b/fs/hfsplus/unicode.c
index 73342c925a4b..1f122e3c9583 100644
--- a/fs/hfsplus/unicode.c
+++ b/fs/hfsplus/unicode.c
@@ -246,6 +246,7 @@ int hfsplus_uni2asc(struct super_block *sb,
 	res = 0;
 out:
 	*len_p = (char *)op - astr;
+	*op = '\0';
 	return res;
 }
 
diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index 9a1a93e3888b..f20487ad4e8a 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -746,9 +746,16 @@ ssize_t hfsplus_listxattr(struct dentry *dentry, char *buffer, size_t size)
 			if (size < (res + name_len(strbuf, xattr_name_len))) {
 				res = -ERANGE;
 				goto end_listxattr;
-			} else
-				res += copy_name(buffer + res,
-						strbuf, xattr_name_len);
+			} else {
+				err = copy_name(buffer + res,
+					strbuf, xattr_name_len);
+				if (err < 0) {
+					res = err;
+					goto end_listxattr;
+				}
+				else
+					res += err;
+			}
 		}
 
 		if (hfs_brec_goto(&fd, 1))
-- 
2.43.0


