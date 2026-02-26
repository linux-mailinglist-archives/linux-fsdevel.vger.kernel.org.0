Return-Path: <linux-fsdevel+bounces-78431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +J82E5u1n2mKdQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 03:53:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E42801A0373
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 03:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B9DC306A536
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 02:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF6C3815C4;
	Thu, 26 Feb 2026 02:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XbD0vrWY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012001.outbound.protection.outlook.com [52.101.43.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDF2191F92;
	Thu, 26 Feb 2026 02:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772074369; cv=fail; b=HSw4t1JoRwv3DdRiJYGuIHdMqmms1a0dUN81zIMRD+s+pLv12lcDvlBZPf3hV3iOnbKAevEneTqPsW1h05qgf6I4+pJ1H90DYJytTpxRFRZwFyMvjAvS8R7bG79rdZVugFKDVMeYYHM61mG4st1B4cOHuGZvaxafWwBS56gOkwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772074369; c=relaxed/simple;
	bh=ajdALQnpVqVGO3JRIu6t/UFXIk1DPakJifSLul2oMw4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WSyuPTYdide8d+ExSEMXFVyCuBFahPafT3aH8ZE09LdLWCnkkpySO9r8obcMFFE57vBDjubcsZD2mCIqyCHXyqoRNNmO1k6+1GgciyYPredyHAKrz/HmfOddGMliuZl7BgxnswLAvSXLtVhG1p7pn9Jr/4OMQudqIPMPupA+TaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XbD0vrWY; arc=fail smtp.client-ip=52.101.43.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=boHPx/JnClcDNQFa7peRmIspJq/IiGNIBRUhBAGIjBUXMR/HcmLCDw78eDeLdGxXwEncHqZqv1lqTjL6u53d5TaoUM/mJRRnA/GTBPd/G8+3wTrAoGVoNMmTV7IRjk5f+48CEe+SaMhFkQzFdoR9lW4KvDrhIy9zG2wrMYu5khrdX4BbKgtk0iE2y9NS6XCQJN+iUmITpTD7a1bwjvtYZ3XLTTtSQSobIOBZdcHUzD2sN+MVOKYzf0F7sVA8cS6stxe4t2Ns7l/Ch+cNrM6Ec323BB41rErw2iz+fJWWj5tDjaK9ZsmATGE2REqO3Lp2fqGN00U9dDcRr74kYeqYtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JvG3sp+tK2Hd+lIwEz+cV0SdmB7fBfQ0JvujxR/8ed8=;
 b=JhcvuPxsClrwI0B6Aepc1/GV06gJ4+7XId1BnQJ4LO/9lWS6lIWM+WPBMAsEVugpwEEKUpVUqu5NlxWslpYsNLBf1clRbnY0+fpWhQl2k0gzaBikGIzqMzO5LIu1sIw95Lm16unTIYzrqu5iCFtWEG8Qw/n1qHqWyHTOK+jqaLMYN5x9uZ2vf6EagRyyvmY6vXwbLDjwtuf7ros5pui9n2ZDkshV3VYcn04+FLKTUtK18pZypv2VbqmEr+Bd8+OCnAZm9eBvU+l2WPbJI7KtjezQ19NELSiHv8YVTVSbAQI6mconlbDllBwSofObm1HkmtAZYnBoVpOS4ysvl9fYIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JvG3sp+tK2Hd+lIwEz+cV0SdmB7fBfQ0JvujxR/8ed8=;
 b=XbD0vrWYmbngP/dzuzpi8Nlj3bWz/vqjgj9HDSLeWhYEM7JN+dZD/g19fjt+V/J80dtGEZooLRIZcg54kHrm9jzJIjRLaFxytwOL8VMRNOgXqWll6BvONrBk9YdwQdyON1GqKrdqOoQQwSSU6QK13PlF+dlQE4nwNSYHdU6u9Va4yKq+AREC7CJHhjkrdCdCK9+jKSo6x+Y3DjkSiF1EdJePhoO951FCyTezCFlslA4xe8yvNs3GU55xCUqXX8On/95zPfuVEp7N+FuwbHGxYc0XBlcyqGDYoRI0gc0hLNUeqBSMPF7kZ1/dakqY983CeaoOluKYGs6PfVMhb+qFmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 DM4PR12MB7574.namprd12.prod.outlook.com (2603:10b6:8:10e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.22; Thu, 26 Feb 2026 02:52:43 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%7]) with mapi id 15.20.9654.007; Thu, 26 Feb 2026
 02:52:43 +0000
Message-ID: <0cbf0f20-e374-4360-8dbb-1f9536774c31@nvidia.com>
Date: Wed, 25 Feb 2026 19:52:40 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: LSF/MM/BPF: 2026: Call for Proposals
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
 bpf@vger.kernel.org, lwn@lwn.net
Cc: lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20260110-lsfmm-2026-cfp-ae970765d60e@brauner>
 <20260119-bagger-desaster-e11c27458c49@brauner>
 <20260129-beidseitig-unwohl-9ae543e9f9f5@brauner>
 <20260216-ruhelosigkeit-umlegen-548e2a107686@brauner>
 <20260224-sangen-aufatmen-06ba16719f33@brauner>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20260224-sangen-aufatmen-06ba16719f33@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0015.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::28) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|DM4PR12MB7574:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dac6e78-6691-473a-0aaf-08de74e21cfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|3613699012;
X-Microsoft-Antispam-Message-Info:
	rZGZTEnTXygE0fdSp2kODT9lIHTseRmEHFVA+ZVQff4LtuuVG6KCbHxskP989r1gOwL/4AXEZd5s5nsLu0Rl0Qg2DTQX0cpdt9xhb+yVvoJOUWoWOJhWYUch8lBfj7Va0Z8Vr0YNOzr7KFCUTTDOO+ipSjHUHFyiCBV5IJG5KxrtwilHjP4mr4y6AZwH/P0SIww6A0C1jZ8I69rNkck1V0MrEjvn+TSejHp7Nax0x4D3bV9ApEpHp+loExqCKGTW5ckOECvcbRaPN6SPmgAdWCoJuyOw6At+UYzuCnX9rsFQDPN3R7HWniab02WF0nLBFb9QFDlkLUPuGgNFzObpUfD8wY3okLLLDqoeXZT3OBmD0Vko9lxowgQ/qSckCc7kwshnp9UsnNXFGbF5O2bf4rbiXNRfXDuBdC77NOvRJ/ZvumIAC1hmqSs0ERSYfCFYgHK4fFzEiew8F7SWJ1ACmMvXjbOyBnAkk5JKaQMPRWlyzZgR5INFWXhOCVpRORjiJ+YdtnSLDXWuSJigTdQ5pqXjlKdIGnmH6Xok9S4adEua6y57Dc9KloUHpt1UaIrcbUFRBzPO9h0zeE0vcSC6caA92jMnFUeFd9r/s97ahrRikeAepJ2BNqt0+JbEGKhp1iyzSX1+d4v2myZo7xm3hQwzqg9gbMAegbR4VppXabAIjfvwjUWYSG6+r0grXf9YAeIlCJSyBHyCFaja17ZQQGiKAbzSMNT+YRJplGCoWpjZUBdBKU7V9bfllULoNGAjgf16At+DpFyzCqWWZxFqUz9N8PG3Iv4RynBssnoWtTM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR12MB9416.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(3613699012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGsxYWc5V20zMjljb1ExRGIzMEo3bmU2dzZlOUdFL0ljc0hTb040U0pkZDM0?=
 =?utf-8?B?QmxaNEZJUll0NEswLzQrckRlY1YrS1ZOcE53TmtVUFJxNHYzR1BJbjNhelZl?=
 =?utf-8?B?NC9iRy9yQ2lDYTJCaWZ0K2FmWjh2N2dBTU9yWHBpblU1YUpqbXppV3pCUVNS?=
 =?utf-8?B?dmhHYnB2QXlvUVo0cExUMW1oVHJ6NmhBMndSN1gvakdmamRiZnJ1NmovVUdm?=
 =?utf-8?B?OTJ6UTlJTzhTa2F4WkZ3WVV5SWl5UzdaaE9kdVJweVl2QjlKWGxkU3M4bnRF?=
 =?utf-8?B?eUhoaC9TOVFMZzB5ZjFuUHFkQzY0b0UvdmVIcU5oNm5va3BLSC93bElyOCtw?=
 =?utf-8?B?Nmx6NmRnZFFiRFFieFpsUGh6elp4UDlYMjg0d291NXVOUHB5eDNoVUFHNTQ1?=
 =?utf-8?B?clJXT1RsazdsbFYzZnVrdWt4OExobFZxMlgrbmJUQnNSM3hzajRJQ1NTdVV6?=
 =?utf-8?B?SWpVaEw1d3V6ak4rSzBramJUeFJHeTlpeXh0cUYwcHVmSkptRW43dlRYTTJH?=
 =?utf-8?B?YzBUeVVBK1NpMHozSDJ5azJyWThwN2JSR1pHUWw4ay85K0V6MWRVdmd1dTRa?=
 =?utf-8?B?ZzU2QTh5NzlWQW9RaGM4ZEQxVjB1aWxsK1h3eHRBTGtpVGVNb3ZRdkkvMmZR?=
 =?utf-8?B?RGRDNmNMSS9oN3FuUUlVT2FuaDhuWHlWRFlidjNZUm94SS9GaW5HWU1hT1Fl?=
 =?utf-8?B?cSs3YnZhZi8rcytaQTVGa0pxQjZPQ1pjRkM4cFUxRTc5S3Uya0g2M09CaHl5?=
 =?utf-8?B?T2xSaC8rYklnREhjME9EaVZFbXBwZ0hhV001V3F4dDB1MVFrR0M1TUtYc2Ix?=
 =?utf-8?B?bW12SEM1ZWRPa0VrWkprNHErd044OGRuczExNXpESXIveXg3dWEyeWhIMXlu?=
 =?utf-8?B?ZWlZSDZFNnRUN2J0SnlIbnFNbkxGMXU4TENFR2RVZ0g1LzFkdXlHUFQ0cFBG?=
 =?utf-8?B?M0V2ZnVPWHdGUTBGYWdSYzVKbzNJRlV0MkRBejJkL0hIRWdSNERzUVM0YkFF?=
 =?utf-8?B?U3FkWEpSdTdRWHYzVFZON1RNT2JvUXZXQXRYWXBBMlR5dnFvQ3BCZ3JvNkZR?=
 =?utf-8?B?SEkyemh6N2tUeWhJaWhKYlVEb2FOaGhTcG56dXhNRzBFRnRsSUdnNXVWWE5u?=
 =?utf-8?B?cWg0aCtYK2dKdnFzM01MMjV5dEp2R0xTc0cyNGF6UWpVREg0TytzbnBZMFJi?=
 =?utf-8?B?OE9BeGRTcEFMZGpGZGhTNy8rT1hjK0IvZWFRV0ovQmQ3bEYxZUk1N2YxTEY3?=
 =?utf-8?B?K0lGTTVicGVrZzF3VjBWNzFUY0ZNR2tLMFNvZEFwcEtyQU9vNE8zVHM5QjEr?=
 =?utf-8?B?TEo5ZW00cTAzYmlwOGQxeEM2TUswVFhoQ216T0ZKUG1QU1ljT3Z6aGk3eDJ1?=
 =?utf-8?B?cTczbkllcDFZWWVHRWo1NnlqdGhzSCtCMmRVOWNhdkFnMENaNXJ5eEJPTGhm?=
 =?utf-8?B?OTRNYUdWUEw0VU1OUnpZNGhvQlZFMnRoVWZNWkdJVmU5Wll0TnJudUxQMElo?=
 =?utf-8?B?VDRtc01rMmMvaXNuS0tUWWpLQzJWSk5MaEtlcmhPMmthU1hYSFh2dWhMREF5?=
 =?utf-8?B?dHM2SGwrc21USnBucGhKZDNEUG1oSWVZWjNlY09kbHp3M3BhclRiZlU4Qkd5?=
 =?utf-8?B?dXVCcDdzdkhhRnNuWWprRGJxdnRhekpub1cwU1kxVUR6MWl1bVpYRS81bDVI?=
 =?utf-8?B?VSt2akxRQlhmKy9tcnhRT1I5OUVYUWJnZGY2eUhuTjhpS2dMSTB2WTB6STd0?=
 =?utf-8?B?ZUI1NnEyckV3aS9GVi9OKzRGcDdCT0hjbDlCZEtvbTBZSXBiREUwcUQ3Mzcz?=
 =?utf-8?B?VStyZkJ6RFhMeE5aZEU2RjNDVExtYW5Ub1FPZmNvZlNBcko0NE9HdGd3R3NI?=
 =?utf-8?B?MlUxRUdsZkozaEJYUGNhQ1V6MkRZblBFMllIS1hoWjVXclRrakphbkZhYWsw?=
 =?utf-8?B?aU9qK3NtSzlnSGtLS3NXZGt3Y2xBSDNwWFZnc0h0bTlXSVBaTUJTN09kQTFs?=
 =?utf-8?B?NGJiZHFyR2RKQngwQ3pzaHdKMDhHclk3UmlON2g1WXR3YlE4MDdUNlEwVkNj?=
 =?utf-8?B?ajVzWmh2L2JIK3BtcnBla1lVTWF1VG5kR0VHcmNpNHh6cUZOMXNwL0FUVEVx?=
 =?utf-8?B?am9EeW5ta2RFRkhhUFp4NklESlE0Qm12L3RBN0kzWTdPbkJPb0JmNWN3Zzgx?=
 =?utf-8?B?d2RWdWw1WVBVdG54bGtudVNETWNWc2FpYWN6MGF6WDBsNkdGaUQzZit0Z3Jy?=
 =?utf-8?B?L09FVUdYNml0Z0p3ckJkaEt1ektLblY4YmY2Z3dNWnNUL2swNGg5ZW90SnBP?=
 =?utf-8?B?Q1JXSFVZNHJYKy93SHh6TFo5Vm5udzJ1RDRpN29FR1VCL0pHUkIyUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dac6e78-6691-473a-0aaf-08de74e21cfb
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 02:52:43.3498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f/SIxtUputapC89b9rg9ZGDBwqc78A2YW+x7azCvwzf+fntQP+sUNHkzQTkRbiNzVggTtWuP99oqBNgI69wGlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7574
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-78431-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhubbard@nvidia.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid]
X-Rspamd-Queue-Id: E42801A0373
X-Rspamd-Action: no action

On 2/24/26 2:53 AM, Christian Brauner wrote:
>> Don't forget to pester^wask^wremind your respective organizations to
>> sponsor LSF/MM/BPF 2026! If it helps, you can tell them that we're
>> considering renaming it LSF/MM/BPF/AI.
> 
> I have just looked at the sponsorship site for LSF/MM/BPF/AI again and

Logos only show up there after the sponsorship agreement is completed.
If you are on the LSF/MM committee and are wondering what sponsorships
are really in the pipeline, then I'd recommend checking with your
Linux Foundation contacts, they might be allowed to tell you what is
in the pipeline (maybe?).

In particular, I've been handling the NVIDIA sponsorships for LSF/MM
since 2017, we've done it every year, and we're doing it again this
this year as well.

But it's still getting signed and finalized, so you won't see the
logo up on the LSF/MM page yet. Soon.


thanks,
-- 
John Hubbard

> we all really need to go out and go steal some of that AI funding money
> and funnel it into one of the conferences that really drives development
> of the operating system that drives the compute for all of this.
> 
> Please go and remind your organizations to sponsor. They should know how
> to get in touch with the Linux Foundation. Just going by the sponsorship
> page we're missing a bunch of large organizations that we would
> appreciate if they decided to pitch in. :)
> 
> Christian
> 




