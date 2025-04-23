Return-Path: <linux-fsdevel+bounces-47021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3626A97DB4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 06:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DB6617DEAA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 04:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5325264FB2;
	Wed, 23 Apr 2025 04:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="lA9sTrj/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012044.outbound.protection.outlook.com [40.107.75.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EEF262804;
	Wed, 23 Apr 2025 04:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745381106; cv=fail; b=DXpxrGitTII4JhvWLz/LIPaxRlJudkB5SrCTQBLkne7Iq1Sgpfqt/Ib7UXMWHldRtecyj0E2qcf/+w/ysjmSQ5OVrmepCu+pO1ZGSbUV6qK3kSjcn0QZVdZA2odSOzvao/IQ8VNgRsv3097wEByjnmHdnzl9vLseue2vWKkMnPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745381106; c=relaxed/simple;
	bh=4fU3eQcofxVt0EnYG3rKvCxpErpYAu1Wfsk1HPfH7Ew=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uRaUbVom4GVCJre0564VAX9UpnBl6ErVnRom0AYUxI4hEZAAIaOtdM4jOEKi+Ap5XS+XJ1EOMxU0dgrNq0Us3p4kVd76PmUqCRYhZorUM2q+tAf6tY0udp07qBElT/gVGVzKq8QOBVFfR/JOFTy3m50PxXp5qQrxYsj75A8rhts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=lA9sTrj/; arc=fail smtp.client-ip=40.107.75.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hhzl6mOxrag68AsSWwF0seqYyqdut6e0Q54ns8rwzcwds4cVmtoX/P6ZqCIJg/AUM+FPI7i2TbAo8X/reARZBSGMS40pZ/jO/7w8WeFT7pkf2irBYuk6LMenfPkJfqsQw8ojPRbkjPpEWbtBLeLmwhBCPa6s2f+p9n5ZZTPdAOYVRm9QYUm8YJhE4movGS4UUchXngWISR8YSk8wD0PgzHErISkCBXKqL3dwlhad4Jn5CaPcuQAkUj/tI67BC3/U3/QbKowHuyIsWlx7Vi59A5EyGBh/Of+zVMPtMhyH0FjqQE8za4ZPcZh1HK3yMRtMtrKeyDqxjckmRt7birgOUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jD29mLdR0OWjLyISwUWjkDPqE2QX+Tyx/6lA/0ApRGg=;
 b=NKkvop0XWiG/aTKwADGXsyQhXorDeRK3i8VNGJxgAQauH1ZnRMMOQyeOdkf1uL5JIcCgLm6ozRkHINrFTGx+Cz9WXftUYSK+yrUULGMY8sWyq9QFtIVKz5FqDJ2Uc4C4IrVJRSl8t8DPzuzAtcZ6Y8snQ+zbUwOIu1nKxcGc7OqhKza4x1PvguK0td6QO3sYvE5Gfw+O1wCHm5u+KCkeDBQ6Rq3LH5D6+tWW0+Wt6qCDrGlp5KXt8qQBWQBvY7eeeiqq98RcEeRuSj6/MYXtpHbp9fYY/Tx/8ibb3X4baY5KeoO3ym8x9AO9EwbuQN0bWDIcumaC24UvBxBWKAy/iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jD29mLdR0OWjLyISwUWjkDPqE2QX+Tyx/6lA/0ApRGg=;
 b=lA9sTrj/kFqyPXW76QInvLsBGNsat4kRo4Tdqvfyd/J1zgVB+45JTq/KeHphicYoh9cvn5SFFGZjt13SteXl99MUGLKE+ZMLm95pOXfBfB5wXNyHAHl5QOZQhSEdG2otfhvRBiA4oLcO5frmrKhpLiNGFx2rDPy1/XfRfQqaiHa5WlZe0XeST/RlCZtOeelXQu2Et57mdZQVnqKplsTfEFOliskjQNMGE7EouqBe5Rgek1Wmi6kjxJC14t9GzW9kJ1CXk9aihuV8J1TO7sn8LV/QSA5dz6VTmctLTaV8UpRt0nWjd+qZjcGfuaH+16IKHIHHKGHZYSAooea2pd3uNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5398.apcprd06.prod.outlook.com (2603:1096:101:8f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.25; Wed, 23 Apr
 2025 04:04:58 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%6]) with mapi id 15.20.8655.031; Wed, 23 Apr 2025
 04:04:57 +0000
From: Yangtao Li <frank.li@vivo.com>
To: slava.dubeyko@ibm.com
Cc: brauner@kernel.org,
	djwong@kernel.org,
	dsterba@suse.cz,
	glaubitz@physik.fu-berlin.de,
	jack@suse.com,
	josef@toxicpanda.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sandeen@redhat.com,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	willy@infradead.org
Subject: Re: [PATCH] hfs{plus}: add deprecation warning
Date: Tue, 22 Apr 2025 22:24:48 -0600
Message-Id: <20250423042448.2045361-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <5e5403b1f1a7903c48244afba813bfb15890eac4.camel@ibm.com>
References: <5e5403b1f1a7903c48244afba813bfb15890eac4.camel@ibm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:194::8) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB5398:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c05f27b-4178-47f0-19ca-08dd821c02c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iOyrIo8BYqdsPIzoMAMeX7VDkHmucAYXitH2Lo1w8InzFu7afja8kBEg/kQR?=
 =?us-ascii?Q?fp3wcsMHToNCOF5vFE12zOgiuMzRlrSb7lplUUBxqOmG8vrthF9jPfb49vJr?=
 =?us-ascii?Q?pUpESAWu8C6tU9VjV9eW8LoDp6ZRBrAW3zwujde1tZX2NQ4gXfJa3vwll62U?=
 =?us-ascii?Q?85lHxw8wTQ7QQ8ZEPD0DbkcHMsOy7Yx/9t1OPjWxK0d1hMgwakWFZdUJTPY8?=
 =?us-ascii?Q?BD0+XQOyfyOesK3msiMDQJdIzlhEUnn0BiyGYED3SrxHO8yOzAAH5fW224Dw?=
 =?us-ascii?Q?CP8h6kKCKwtxXFiQcez2eY0EBOLeSFQn9aiqsPXinkeaITy690LObnSf5o/I?=
 =?us-ascii?Q?rzG1PtMpvmFX5VUTyPCaGhrJMsVEIIUc1uNSOdnDXqTKbQhUzZrzVqk8igVK?=
 =?us-ascii?Q?fvrR7QzTzXgGqVTb47392n5OVc2UPuiGzpq+D5BpJEugiSKxUaY4AXVyGrfu?=
 =?us-ascii?Q?isYOb8XQuLEWuuG1YaXXMB0FvxIrU8lFbs45q6ziMD5Ki0yTNNwrpy0h51e5?=
 =?us-ascii?Q?G0xwhmo4Pkr/BUVL2uH+SH/sKyGeR5dzsvH0VeqvgpmaM9UckiHcsLDQPvxP?=
 =?us-ascii?Q?9h+7hbuKwGXzSMFg3U7QbFC9c515vftpxqr9Y6uAU42vORA1+WjsnSc+QFlO?=
 =?us-ascii?Q?m8SsUVpZzCSPOxnwyKr+hzXy0aJXbhEFMGG9SyEgItCxZMvoGYXyNBConU9F?=
 =?us-ascii?Q?yqadrTLgg6Vp/k4MUwhuCrS5E9H4z0y83Kaf03SxNdufEkWXl4dZh0KLDhD4?=
 =?us-ascii?Q?J/bLFsynXA+WrALYISeLWFrNeR8rznZrdEnPi+zC9gdDIB7ZwCTIl+GKc8ks?=
 =?us-ascii?Q?9cHJBAiTBbaH03k+cMC3RCRnheVWcVbgho651tzWaYzLP96liJIsq1kDWMnV?=
 =?us-ascii?Q?FBlMGjN04IHlnZDYYY483s4ZykxFmQTbbG3k9kAiRSsYflsQGgbihoH95KWO?=
 =?us-ascii?Q?1t2ldZnBM/MAvt58YuBHZDVpsDb7ZdgHxOFiPJgbuyRmCBWWmRL+SUMFrMmp?=
 =?us-ascii?Q?bMjaoF9fxraXb4/1q4yzHuCN4ktHzKcHtGpKgbg3L1XE6Qx9FROgWVynIGu0?=
 =?us-ascii?Q?uv0NUQOyoXvg8drWkSvXgN3igY2VqlPSliP1GY8f+HS2XMFy5vOwvoHwXjS7?=
 =?us-ascii?Q?TJ4s181vHd6m5X9TVAQTkieXwe2jRNa/r4EbchsF7Q3SFUIn7J0E3g4z0RPX?=
 =?us-ascii?Q?gujK2KNjUmQiJuioTZQ18Z4iI92LmlyEfl3Iw/Bm1LjNO7kTRrulH/zHYiuK?=
 =?us-ascii?Q?S3GrenTekqOz9l2qyBetDWdSWp+bSil6rk+W8QdYXAJigbm8FmtO6rqgiekl?=
 =?us-ascii?Q?uHuQ7Oc8j45rkqdUY07XpsE2xlpfH+Vz1JIlNVSiD7ZTntxGp3eFwcqy0sbh?=
 =?us-ascii?Q?gpfqOFnZ41LqEVYH/yKsdHJoCXBklz9dMhd5/usrdEB4zEgRt7AzhPjZCXRo?=
 =?us-ascii?Q?m0M1LdmP2hG9pXrJd9Ce+CAv6xlxT/9jIypY6OM1SXO6zOVTRQitkw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tYxJ9fzgJvmKMoI8qsa9upZoUpMy03qVntWebdPwcJva9i5cN1wDHW7Ti2cG?=
 =?us-ascii?Q?BPLRR52oHpoY+5rM6DQXbMXbnqnz8aZG3rYjp8n0o9px9dBkzDBxopVtJOZ2?=
 =?us-ascii?Q?FTuU8ioXDomDfMaNreHZFgjbYo4k/FvTIFACkpaTxPin/kgzbfdFSR50jo7w?=
 =?us-ascii?Q?PUyZKCY+Q0/gUe/B+dWL8y0rlbakYq61O0TPECQy9qf+nEsgguTVxC5ZRqyS?=
 =?us-ascii?Q?J37P7cfj5KSijiJviocRrmkrNK1M6Iz+AEbatCOvQxD84DKV1sUClYKbTsYo?=
 =?us-ascii?Q?E4IPvS+mne6mmcqNU6JYaUf5Iwl47L3QHnzSoJUbBXsjnXe4iQUqklmlNSOo?=
 =?us-ascii?Q?V/axkCQlubwrWs3l/AV1HQw2Ea4I4vNEfu73mxSLpismBgVgjw2GxKaYFxti?=
 =?us-ascii?Q?sTSBhU9b9S63vOfKN910b1AHZt7toFLJpZ0NN/yomQB/W1gol+YTe3GUeFZa?=
 =?us-ascii?Q?ykZRpIMK9cVW324gUmH30bnDQ/miFo7rK/51yKnI4w9PdlUNljiZnCUvGkHQ?=
 =?us-ascii?Q?DToHnLu8YceYVNhJ/jXFWDQtCWfaY5cHLWsbZbmbYOiP02cUqOjIXri4XtaU?=
 =?us-ascii?Q?aC0GpAw287yh0kdd2bVSoo/dOOpgvFHrUitmdVoTzofP/+XirA9UEqgF0q1w?=
 =?us-ascii?Q?o5WI5PidEDnmyupbBDb2k8xH/b1DKtixyApWm2wcX5CJnok1fNnS/2J1dBac?=
 =?us-ascii?Q?g7oasjv9cHSV/5vpVzGUbcCVhWrhlxvSe4Tae4uHqgYpZsQKBqAtFV9Rmasc?=
 =?us-ascii?Q?H4VfN++GYeI2OjuqKgp8esS6S27s/3izCe7ItLFnZHqti6EoQhuO2h8/n2qu?=
 =?us-ascii?Q?eGpy3HXuSU/Xv+baZ6IoeUzw5/31ftcvMyXEF4d3PYO2dK0So2Gkdt6d4+Am?=
 =?us-ascii?Q?X08HFZdfO1U6WQMJTE4ESeyNpi9CppV/h6AEM4H47MCVY19oXSQX5kMAOPDY?=
 =?us-ascii?Q?4KPP6q7sIpuEdxdONEthLrx0zHcMdN+dxTS1gohmlDeugERhYVD7GS4W9iTR?=
 =?us-ascii?Q?0VtjIpLj5T5gBC6Zu4YeBe3N0K3Hf3uRa8v7apsZTWU8qBTajbnRC+u3mMvp?=
 =?us-ascii?Q?a9WPEGujxWlNrZ5NPZjoO0OiBxD83vk3YZURWqlpt8U2IOUHyyy9gISUHA9g?=
 =?us-ascii?Q?Fx8TqGULYZik+BbfYOw7gPYt0PeLmPI8PY6AiJFQeoXDc83lp7EAPlpf85OZ?=
 =?us-ascii?Q?VoXBZZEVllJz3npRaSQrFZSGPcgkF6X2YgGw8riP36wA77jWqADGHPP9k/OQ?=
 =?us-ascii?Q?EpZKyKJQzwFVlGCV/MQZ/hYGY3UnLk+m4oDvrxV2191atAxKRp5VoMWHX+5d?=
 =?us-ascii?Q?J282VEQHs0HlkkFukt0dZKDCsGRV9EAtRt6sS3xwA9mc7HBPo1vOPY/WNPeG?=
 =?us-ascii?Q?YIxRgtNm4VSJyYn2/87HKU2eKY3SaoSzdqPUtUvJ/HHxYNQltLzLUd4yjJsV?=
 =?us-ascii?Q?W9LKaZX8uw8igXS1axwLs1FWZ0hiA2WNU2ABqH24BftrXGRg/UPp13WlWR/O?=
 =?us-ascii?Q?eOuwO0l1LGvJWDJXxA6vdtdfiIYj739C00nTOTwGrd98KBoGax2dwJxpW6Y4?=
 =?us-ascii?Q?4CIVKQJcXHcNnfDfE4ykT6SbZ7YFu3+h7+EsiJl4?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c05f27b-4178-47f0-19ca-08dd821c02c1
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 04:04:57.7487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FtZxItszHp8dWvzf2oynw6l673uZiP1ricvFH8XBMzUXNkmKEBjTCDWCHY3dEi5puDedIDoEcKGBy+wdsBBY8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5398

Hi Slava and Adrian,

>> Please let me know if you're interested in working together on the HFS/HFS+ driver.
>> 
>
>Sounds good! Yes, I am interested in working together on the HFS/HFS+ driver. :)
>And, yes, I can consider to be the maintainer of HFS/HFS+ driver. We can
>maintain the HFS/HFS+ driver together because two maintainers are better than
>one. Especially, if there is the practical need of having HFS/HFS+ driver in
>Linux kernel.

Do you mind if there is one more person?

I used to maintain Allwinner SoC cpufreq and thermal drivers and have some work experience
in the F2FS file system.

I have a MacBook laptop and can help verify and maintain patches if needed.

Thx,
Yangtao

