Return-Path: <linux-fsdevel+bounces-78639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEhyAo22oGnClwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 22:09:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E25F1AF78B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 22:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA58D30985A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 21:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2C83939B3;
	Thu, 26 Feb 2026 21:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WqPRPndM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012005.outbound.protection.outlook.com [40.93.195.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F831389456
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 21:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772139988; cv=fail; b=XRVeFWsEpSd3p7ePaPmmN6AGiJ6sPcAhr92CPg1KAmI8TXNW1iNfC5TblKM3nntaAVkgPK4QcSUvo9XYDX4DmAsfum7ZhAvbHUcAuphHb78TQpu02iBvU7qYqq9YFjlsGsWCupd5122tWaOxagds3qWyz78J2wLpsveH01R6WA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772139988; c=relaxed/simple;
	bh=fuiIrRfwKx/doxHxA+bF9yJU3bFg7n9mA+VEMf5auZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I7hLykBylCkm+zHXr3HTgY0hQvlhc8DHUK6mpoiZ+TbEPK5avXsuPeaE/XCLqSK2EfyiAWoV0TpDxxt50TIwPhukRNfnKJsbu/vqhP5VSCrWkhKV+Z7Brg8f1fCEUJ0wZ11RtI6qfLdA8a9LWcrfc5I/H3Zmtz1elP7Y7wyW8a0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WqPRPndM; arc=fail smtp.client-ip=40.93.195.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a0l2i0kVg+Ld2o7AOHh90bH04NXe4uy3XiMGRf92IxFyHR7w5XKefCQ7IpigfXpam9izGN0+qKiD87rT9AG/ec+9EZqBkQoPu95a8yc3G55HNVh1Z79DD4SvBrLCzchFVqheMPUJvkQ7h6qzssnXuk6mMKBTyG9Mo2YWTGoHlu+Ku+L0lFjB+zw1iHiGkO/gsLBvd0RmyGFRZR904oGqL9aG7KwBaCWb2Tg9dd/LaB7Z6E62Q4CPFfk/NUVx24L7udPnuLCoGkFXgvb9VepIhvSrPWLk41A9I5FhFkTsVLgskXqZGBPvrBygOqgYsZYWMqA/rxgBQ456Z/RZiwm0Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7I2Ej1xdJZkVyxaoVEE1kbh+d3X89VaxfOyiF/TzOKw=;
 b=fQLjCZr2wCjWJ+aAsbHvqe2qs2iD68yx7pTnTKErD3RjWzozG7Iz1eyAscSKNge2Ae6/CaQr3/eb6aG2yPOYO2ksO1uA8zLsNKvsMYxBIuI4k0SM57czcfwRshldLN5eAsheW0fLCOdyrAk2OMleiFtXd6vSNFIMZc9tOKXVJCCelsr6A8+PYKN3HOwzdn6GJTHrFm4C1GWLS3thv1ozXBYaq3NA2l/YcXKwHqtOfpuyE9/WmOQ1wi7rDGwczgxP6zLwuAQ937Z07bhGyTuVJocBI4IefOBNx6Aye1WN1+isv2BaJoqJrZwWh7zs1hlD3jKaVlWtGMtpE1pjUVqWbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7I2Ej1xdJZkVyxaoVEE1kbh+d3X89VaxfOyiF/TzOKw=;
 b=WqPRPndMuBWGcR9m0zCzC0y5U3pKIx2tWACtp5yahgeCGNMpbkNYeTak22LM/+v/zqY2yX9cU1S4aDy85LPRU7Mq4iuFA19PW0ks8NEFHE11wssaQvc+KB3fuOKMEbyqJFa9lppEtLCNrwsVwpI+Y0cReQkw3PHPrnBdjLdlUOzfpgCGz515mmO2gNx6fffQMTugkigkAbsjwb2OOd6ZFPIHYNtr54aMdGrqKqGRjFLDWgUQLDQXtd8Uh02NpFJHf9OA2wracAOtqsA3L7SFrHfWRXQBapPpyodBYf/nRGGSOhY8O5QJGNcP8ZlAuyujA4U1yy4WHMLkxieFi4As7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MN2PR12MB4174.namprd12.prod.outlook.com (2603:10b6:208:15f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.15; Thu, 26 Feb
 2026 21:06:23 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 21:06:21 +0000
From: Zi Yan <ziy@nvidia.com>
To: Bas van Dijk <bas@dfinity.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 <regressions@lists.linux.dev>, <linux-mm@kvack.org>,
 <linux-fsdevel@vger.kernel.org>, Eero Kelly <eero.kelly@dfinity.org>,
 Andrew Battat <andrew.battat@dfinity.org>,
 Adam Bratschi-Kaye <adam.bratschikaye@dfinity.org>
Subject: Re: [REGRESSION] madvise(MADV_REMOVE) corrupts pages in THP-backed
 MAP_SHARED memfd (bisected to 7460b470a131)
Date: Thu, 26 Feb 2026 16:06:16 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <D4BD80F5-6CA2-42E1-B826-92EACD77A3F3@nvidia.com>
In-Reply-To: <CB5EF1C4-6285-4EEC-ABD0-A8870E7241E8@nvidia.com>
References: <CAKNNEtw5_kZomhkugedKMPOG-sxs5Q5OLumWJdiWXv+C9Yct0w@mail.gmail.com>
 <CB5EF1C4-6285-4EEC-ABD0-A8870E7241E8@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::25) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MN2PR12MB4174:EE_
X-MS-Office365-Filtering-Correlation-Id: e07bd22c-3c06-426b-a584-08de757ae450
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	xOxa3qNP8blyPb1qYqSPIztHpPkJwCn8HvPI3xaB9saEmSOYdHI28VBwgLWXMiabIuWu9wcAeS0wl5MvsrpHknqOC+W4oNy/B5VN0LqDutnuPKd/IbAXIIOjhVSNhcQzxT2953AExCl8AsmP9lpJl59riMGu7kuEjhccK0j304R1hZawot3eDfs3iREGIDxyd4vLTcAaiQ56RalzgiGUGmSjQIuIvMqK9LlBT7eXmXUaF7iytFu2ksffBD4UvyNslEH4l8Ni7IRtg2aE9SE+VZvJNatk6ifYjaYozjFxDMyJsVrVda3txOH81gMGmC3dstRv7kR7NwnIiOAH+qRUl7B2z89mfl6Wl0NwAi+2Q5z7+JL8WcRPoN7TImn9JH3lffMGUxm4Wy9iC5sPYTclapIpCDnXTaCVtjTN6aeWZHObPqOOgGb5/2B4K4P+CmYxJjPkbiiGUMJ9Pg3CRcNcEzIpK10WHw2D04wHIeoudNg3yH49euLUDGr3/BPnOl0q1pWGppNTT7g+OMsXibP6vHKJUGUF8hDLBncxvBLPFEvImDy72UVDXLkFezaHGUrCYwhF80rMgbTf74RZId19ip/CUXEP/laCnP1BoeWkf0bnyFdX3IRgg9yV6KV2Kdd5iiFxKKEKPFFernZPx5qLdu6nUzorpWuzM1ZrP6p0mVtCYfmlniL48OBjoBQxldDoiwGlkCpvwv9ladn8P2/jGKEIRDN9O/QF4C2IuynfjT4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jdNUXjsGxElTiwlhQqMQiH7CUpugo8Ev1QjV7lBvpgkhNBp8Mlw5tgKuIgUK?=
 =?us-ascii?Q?5NplUGvvv2OknxIzC4fuYWVYU6ZEfiwFEYfcMY4Q0JGIa5lfQ8uaVmHjM8dQ?=
 =?us-ascii?Q?1DrrO3sZxFlAUXNTE4OtEHTKr1GNE5hdA7Qpz/J2ysmLjeqqKdpdgg2nSOzc?=
 =?us-ascii?Q?6/4QrTGVJyIQ4rI6GCMmFAP+pzHq+ooUIWw7tg9lgfCkIV+SAKe2gtbhTvmm?=
 =?us-ascii?Q?VyoJkTREHL5Wx61VHoA4VzaxfiofYXF6wuS8ygAoiFIfu509Wp78V0DZtayE?=
 =?us-ascii?Q?Pk61ZwOHnAh//MYp339RlJJ13dPyermFNwsqk4GhWipoarTnMiV+wCooBarE?=
 =?us-ascii?Q?B2eRlxQVn3o/R1HqvOVDV5jQOQZf3WPswGF07ZUt58++JKql1W2SWRMoiAKE?=
 =?us-ascii?Q?NpC9kiuUnHhT9ySTUvtRh6gTPVd00UEt1bt8owGsQgwcZNxIeQFYA4kNSr/F?=
 =?us-ascii?Q?VWFCAgexdAceGutqgf4hpT8ghKsZ/vEXw77BzrjdpvbG5OeZQu4R3N7rFbO6?=
 =?us-ascii?Q?nOLk9ocbHZUCRqceUSRS+ZRO4LoqW7NUkqXqMO56PGs31m673jfQ/syp2z3X?=
 =?us-ascii?Q?5M8VQRYwH57HOKmWScPp8hqkYAGdh+HusYONl4kqg0Rjdpr7OHrXjI7iA5Mm?=
 =?us-ascii?Q?2JQN4D57rkiBgGQFC/wKuYPt/3Bl/+kthmLkmMPr5fugeSE6cyAOUs8cO6lP?=
 =?us-ascii?Q?uaMxLeSDmVoPFbBXLJh1S65Gtoh0vcMyjrqPn81NjVwzFDFOiduQ6WZCTCvg?=
 =?us-ascii?Q?holBjHEPc30coJmpzcnOmHp/z57yd8vzDLCbT/+N3y74MdONL5Tgbhexgvo4?=
 =?us-ascii?Q?9gHnhvb+onUl60KpcmfD0iH0jND9iRlNKWbyOLMbhmglPxeSV/n/wselwJg3?=
 =?us-ascii?Q?SV2PaVqdXUPR9cabWfGhAqlJRVuEPBtPHKrOGE7Urng3uw8kPQIGrvq2ky4d?=
 =?us-ascii?Q?QW6jt4841pg8Ta4xN95XuYTztn0wMv/9XB8fn8Ndu1JHlmePaqVHykwj8PCo?=
 =?us-ascii?Q?nrjoPy6cXv/HbD4v2sDt2OVUOinHUq4ZblDbMZ1qec29V0CZtps+LuNE5VJD?=
 =?us-ascii?Q?b9u+NPfoZTpiwXS/zUs1RxunpABIdnzNnOYNV3sdx3CIKXjjz6cDt1VacS3d?=
 =?us-ascii?Q?OujEF5gWnU/3yVEovmqtoTE8Yr7D/ev84XIhQKn63zNDL2e0/X7aszfGu0p1?=
 =?us-ascii?Q?RdeuD9iucg7Yu5S/KQCwHWtWdC79Z8oRM2Zbw9OajNm2hj4T1xxq3w2MbdAs?=
 =?us-ascii?Q?Ss/L01mX5XVOumEBek2LI1zv+GKcv/+7DemXg0oiyN5Rf/7p12/MIfCb24nD?=
 =?us-ascii?Q?RCjTYCG2m/Rawzgb5enSSBXlTZsOPPfp7O9GQXumJKn6MjbhJLk2acRSdJGK?=
 =?us-ascii?Q?Ow6Qx+14DhuL/dSI7IbM3n9ikb6DB5Wt9QHfnZ0YQDK7ZsOsNM91tfr2bHRT?=
 =?us-ascii?Q?mx78nRDuG7BpodDK5k/hILYSXO3WzcytNUlPaVHKFjIPZ91QAJj6E1ZKfbHO?=
 =?us-ascii?Q?AZKsLvK814jfW8U9GQT7s+fcYMQ328p7T4z1TDml3q+ldW5wC2/k9J9MXFjk?=
 =?us-ascii?Q?yKPv5JmMs4BL5iwacj2lXM4rxYcYp920x+UEcdRVgteN1xfBmKtsh5Ve6S50?=
 =?us-ascii?Q?E4lgZoZ3h6E731nssSfTmyJ6QQ1yP5lP/P7KBWJ63QxCgpQlthRDNWyuvltE?=
 =?us-ascii?Q?SRGQ+SKJx56kVThtd4Qe/uPhXi5jHpT8UMmChNCSxhWtyc6TCux/C2NuhVDw?=
 =?us-ascii?Q?Cxz+4op0pQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e07bd22c-3c06-426b-a584-08de757ae450
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 21:06:21.1270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JTqrOpV9ysnXWEFJtH6+riEMZHLGi4pz+iSxNZauRdrQJ9o9YzGquRUPdheppHDT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4174
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[ziy@nvidia.com,linux-fsdevel@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-78639-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 7E25F1AF78B
X-Rspamd-Action: no action

On 26 Feb 2026, at 15:49, Zi Yan wrote:

> On 26 Feb 2026, at 15:34, Bas van Dijk wrote:
>
>> #regzbot introduced: 7460b470a131f985a70302a322617121efdd7caa
>>
>> Hey folks,
>>
>> We discovered madvise(MADV_REMOVE) on a 4KiB range within a
>> huge-page-backed MAP_SHARED memfd region corrupts nearby pages.
>>
>> Using the reproducible test in
>> https://github.com/dfinity/thp-madv-remove-test this was bisected to the
>> first bad commit:
>>
>> commit 7460b470a131f985a70302a322617121efdd7caa
>> Author: Zi Yan <ziy@nvidia.com>
>> Date:   Fri Mar 7 12:40:00 2025 -0500
>>
>>     mm/truncate: use folio_split() in truncate operation
>>
>> v7.0-rc1 still has the regression.
>>
>> The repo mentioned above explains how to reproduce the regression and
>> contains the necessary logs of failed runs on 7460b470a131 and v7.0-rc1, as
>> well as a successful run on its parent 4b94c18d1519.
>
> Thanks for the report. I will look into it.

Can you also share your kernel config file? I just ran the reproducer and
could not trigger the corruption.

Thanks.

Best Regards,
Yan, Zi

