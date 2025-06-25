Return-Path: <linux-fsdevel+bounces-52962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F80AE8C4C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 20:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAD41175D9A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 18:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF1E2D9EE2;
	Wed, 25 Jun 2025 18:24:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2094.outbound.protection.outlook.com [40.107.236.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C27D2D6633;
	Wed, 25 Jun 2025 18:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750875866; cv=fail; b=nyzTzibBo/n9JriwKvImPWGS0rvRO9qyNtlxpkLSBh4Drlj93dDomyxM3JVLsu8PHb6ShwNJqZPswApY48Sqasl7P4MjI6QuX4pVMFABmt9XUjAHstggSpMkmAVlkinJHOyzXAk/Cxe6KzZqx5BYWDYuGu3bB9umS9Rc9QBRjss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750875866; c=relaxed/simple;
	bh=E7zjMNx/ptzWdQJoCI0CCfnmnjhyE3w/Kz0qBG8h7Ho=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b6/0LLMGU0/OWk+5O2+INKABUaDH0BjsbT9xOVAWTabU4v/0MTv82n98MMIjW+RKp4MF3MIX068ynACfrrFzFAjHnPf0o2nSFvszVRJqISpEUz7OSpwOw2bH+F1kc1+2GlNtDy83B0Qc2QHznkryVD35hp0FCgiLhzaDj4Zudwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com; spf=pass smtp.mailfrom=talpey.com; arc=fail smtp.client-ip=40.107.236.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=talpey.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lSmRNdTbWFcKjxNa21g0Or38fbx5B1gEfZUqMNK9Njvk4/FciuIVgjr3SGT0dkH8359YKoOQkwwi6xMDZotBPQrjCXgSeHkG2DKIeI7EUqTi/0N0FDi6IiqhZ0ISrQCnGrkaLbuuP+No9Xd4jgodjx6VU0KuISHe0j4ZY0xwtAC1UnSVDZakLw7tsyGNkFMdGl9UWIZi9zMj8XxKz6Lc1IJ8T67MnSD7rrrDmYK5Ol+YGjnLlL1MJM2aHgaQ4hXkBcJ2gWUf2x6cicgQVwDBkmYUCWxJC7EjdrylbqREQHxbARWWxYZroqAiH3LefxIGZp8jTk1HZAed961ObIa+HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/hJNO4LSjDvBINtJLorvk4nElVFpDPRP9twB+J/ntg=;
 b=Oj35carvZWnodxsBpysNS6sA7iPeqh8hXkW+qwsP/7/iUoRh4uVrr142PTnEPF1XsHc+QngumIj93/K8lA69sHxlgTfxeDeDXorSW275VflsqteylgzVv4cQBa/0WFKE7uEbbcrE+J0LmXe4MOP+wt0khRyLgPB/+R7YXLdn4JiotRVjVH6czCQCNjBf5HjCi1O9nNjR3mhta99UKOYOA7YHdwrA9YVM6iZnz8jzF3l7QYKBHZFoGNQY/vprXWQsYTFf0PS+dehhJFGA5OFGVtg0jyCYIFaSWAEWtaoX6vWSLwZRKdgXWkFVe5VZQ5ViuuFiRCyAYcBcVhL2eqdYew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from BL3PR01MB7099.prod.exchangelabs.com (2603:10b6:208:33a::10) by
 SA3PR01MB8014.prod.exchangelabs.com (2603:10b6:806:31c::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.30; Wed, 25 Jun 2025 18:24:19 +0000
Received: from BL3PR01MB7099.prod.exchangelabs.com
 ([fe80::e81a:4618:5784:7106]) by BL3PR01MB7099.prod.exchangelabs.com
 ([fe80::e81a:4618:5784:7106%5]) with mapi id 15.20.8880.015; Wed, 25 Jun 2025
 18:24:19 +0000
Message-ID: <9e58524a-856c-4efe-80c5-195bc7b55743@talpey.com>
Date: Wed, 25 Jun 2025 14:24:17 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/16] cifs: Fix reading into an ITER_FOLIOQ from the
 smbdirect code
To: David Howells <dhowells@redhat.com>, Stefan Metzmacher <metze@samba.org>
Cc: Christian Brauner <christian@brauner.io>, Steve French
 <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>,
 netfs@lists.linux.dev, linux-afs@lists.infradead.org,
 linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Steve French <stfrench@microsoft.com>, Matthew Wilcox <willy@infradead.org>
References: <658c6f4f-468b-4233-b49a-4c39a7ab03ab@samba.org>
 <20250625164213.1408754-1-dhowells@redhat.com>
 <20250625164213.1408754-13-dhowells@redhat.com>
 <1422741.1750874135@warthog.procyon.org.uk>
Content-Language: en-US
From: Tom Talpey <tom@talpey.com>
In-Reply-To: <1422741.1750874135@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR12CA0006.namprd12.prod.outlook.com
 (2603:10b6:208:a8::19) To BL3PR01MB7099.prod.exchangelabs.com
 (2603:10b6:208:33a::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR01MB7099:EE_|SA3PR01MB8014:EE_
X-MS-Office365-Filtering-Correlation-Id: 7129fe3f-efa8-46a1-841d-08ddb4157fc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WjBRMStmdGpWR0h3SXh6L1YrRVFiaVlLYm1vcU01YWd2dDVYaGR4aGpYZ0ZE?=
 =?utf-8?B?RkNtZkxoRkl2SVFicmY0NDhxNkQ3MjE0K3ZVNjhqRzFPK1ZSd0tLYmFDRGdD?=
 =?utf-8?B?MmVvZElndkZFbFBWelRnVkE5ZG5rQjlLcHl3NkZJSjVxYytCQmZMZDluTTNt?=
 =?utf-8?B?NTh4T2U1eFUrNzZpa2ZGTm1UeEhKaW5FU2d0YXllTndkMkJuYS9LRy9Ua05l?=
 =?utf-8?B?UUlWdkFWeW9ESnFLUVBTVXpJcVpRTjJzOUp4M2FYZm9wRTVYZzYzeVdvQmVN?=
 =?utf-8?B?Zi9UNWVqWTZqT2p5eFYybzBXVjhkaTZHK1hYSVE1cGZYb3FLK2lJa0xTU3d6?=
 =?utf-8?B?TGJieU9KVU90ZnlmYkV6TUZmQldYeHhrTmxrR2o2MlJ6RDN0L2toREhRS3RK?=
 =?utf-8?B?OWlGZk4yU2FLc0xscTF2cWxqMkgyWUlyaHU2S0thRzhDd3piSFlZcU8vOWRx?=
 =?utf-8?B?bVoxT2pEb001eTg5aDJqOFBZYVdrb214VjdpQkNFV2h0eStMVnphbUNhWmVy?=
 =?utf-8?B?QlJoYWV2cWcwbCswTVNROGhBbm1yVU12S1ltbXYrVHdmRzF5MTZ1V3EyUEJI?=
 =?utf-8?B?Y2ZDeVFidDNCN29xOVdkRnIydGJKUE9KTlJOOXlwaEtNZFVVVGJRUDNqOTNY?=
 =?utf-8?B?c1JSbHFGOHNEY29pamt1cGxoS2VZSzhjR3NVK3pDMWQ4VUQ2UUhqNkRNbm9i?=
 =?utf-8?B?bzFmVW5kODRXN3FHZm5KMkR0RHdYR0FBVTU3c2twYXc4S0tKVmEzWFNVSnl2?=
 =?utf-8?B?Sld3U3pMRExPNVRqRHNhNStHeDgxY1lZM3pQejhTRTc3WGJvczg1S3c1TVNV?=
 =?utf-8?B?V0FMalZtenk2NjczN00vY3ZoalF3R2FYVjNHWkZ5Tm9ZVitiOWRrYXNnQTEx?=
 =?utf-8?B?OFJDVlk2NlVRS0FPaGJra0g1QWNvMGJxOTZ0NG1MSnMrdjhxelBNSWh0TkM1?=
 =?utf-8?B?VWVPVjlqUi9hZTQvbDlyQVlzMlhFQVp0UWFDT0NwTTFXbGtiUXJKQnpnYTZu?=
 =?utf-8?B?R28ycGd6WHFTZ3FqZzRpdXByd3ZxWFpTUUJrMDhiSk1WblNpcWhhM2hNMU1T?=
 =?utf-8?B?U25MSjJFK3JPSzlSV2l3eDB5TnR3ejBETStDaFJxWTh4bUJOSFRNQi93RGhZ?=
 =?utf-8?B?RmZITTRGWDk2ZkhieE5qTjRDVnUyQ1RpL2thVE85dDZWZnhOYk03WVFnaWpt?=
 =?utf-8?B?NVRYMy9VVEJMZnRvaEQ5RDFRM0UyN3BOTlVhRWo1c2FKb3FYWDZPTlhzUFdE?=
 =?utf-8?B?b3pTTFRnS2NaYzlRVElaQ2d4KzZQczE3NGh0U2QrQVZQNmtzOFAxczhCTlYv?=
 =?utf-8?B?bHF0cGl0WEZFNEw2Z1VWR2VCYmFlZi9TdUVqelIzcjBxckZHMmQ0NVNGb0pu?=
 =?utf-8?B?VFpLWWpnajRObFNzVWhJbWRjTklLZnhtaGZYTjVtSzJLQmw0bk5XMXZSalpW?=
 =?utf-8?B?UDVMZnRucDBwZjdKT3JQNm0vYkVyZ0grT1dBRExjakVmZE9uSSszM0JBWDdt?=
 =?utf-8?B?S2V3UzA5Y0VNbG5oQnZ3cGJlZi9BczM3UWVBeUVCTHF6NnlKSkNqY3BrQjNZ?=
 =?utf-8?B?bkh0azdlYjRDWDRTb1F6eDRRblozUVUySzUzVUtVNjY4TU5iRFBXclFyL0g4?=
 =?utf-8?B?ZnMzQXhxL3pkNnJSOEUvem5MWWFBb25nSkRmS3ZLcjhyc0l5bWNHZ1QzWFNW?=
 =?utf-8?B?TjQ4NGVnaG1YNGh0QlpRWGtKeXNKTVJ5cUttNUdpaXVFRVcwQ3Z3NEM4S0Vv?=
 =?utf-8?B?TlZ1ODN1QUgrR2dyN1dNOWgvc1dTR3g5RDYybW9NdjNYNFh0ZlVzeE1xTEov?=
 =?utf-8?B?REZSTEJMUTF0T0dpa3V5ZFIwWjB1RzFkVVplSHkzdFhrb0hxTFAyZE1XUTFN?=
 =?utf-8?B?LzQ1NFQ3QURkaUUzcm5Tc0p1eTd2NXBxVG5yNzN5d3E2VEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR01MB7099.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?anRxdFR4Y1JVbnRVSTRUMXBCcCtDdVUyNC9iY3g1ZG5WdVdoVlJ3K25vdjlv?=
 =?utf-8?B?RDZJdzJPTUpIN3o2OTBkQnhWenpNZkQxTW1KZStwand0NGFxaU4ybWthTndr?=
 =?utf-8?B?MTEvekFvUVZXekwvU0FrY1BiN0MzYXh6K3NkdkkrVzNLSGcvd2hCdzJsTmRD?=
 =?utf-8?B?bUhuNDhiTDJpM2FrbkFTVXFxd2ZQd0xSeTRjbTE0ZEpyRkk4anE0c1dLanNm?=
 =?utf-8?B?eE9ZMk1PSXJkTXJMZ0xoN2lwK0Fubis4NFdGbFlmUHR5UDlRb2F4bU4xbmZQ?=
 =?utf-8?B?TVlzaUFDdlF5am9RakwxeWMzT3JFakpQY3RBKytGdlZuKzVjMVFjTTg4MWRB?=
 =?utf-8?B?blMrVjU2cjR2RVRSWFMzS29GT2lzdjdmMWxvMTA4N0ozVktSU09wblVBamtl?=
 =?utf-8?B?RXRTUkhDM0RGV0lONGJXTW5mcDRHTHJpQ2h0dXBXWVNIQTRpd0N6Q25sM0d3?=
 =?utf-8?B?N2NXMHRPQ0l1TmxRQlF3OVMvd3ovN0tXcWtHc21FVm1wNEdZQ1d6M2Uza0c4?=
 =?utf-8?B?YTYvWlRHK1ZkaHJETlpkVkFQMXlZNnBuZExrbGQxYURPTzQ0cC8vTUoxYis2?=
 =?utf-8?B?d09WajY2SHR0a2JYS0pMa2JlS0tnczBWQmtBMFZXU0l0d0dSclZIODJKMXpt?=
 =?utf-8?B?UTd5MFBqWndwOFh0cnZFQmxub3crdjdXRFljQUo2RnlnT1k2bmd0RmVKU0ZK?=
 =?utf-8?B?Rjh2dnFnM2NSUDAzM3pqTmM5VU9NaFh1bnM1VlhXc04xV0JIckZSbVd4LytE?=
 =?utf-8?B?aVgybEk4dHdvNTFsNWlCN2NUT0VlRkJTSGRFc1M1YVFES2thZE5wbkI3b0Fv?=
 =?utf-8?B?aHNmVGs1NnRuWjRWV0MzWlBXMGMzaXhnVkRiS21RMC83UWpQWDh6emljQmZl?=
 =?utf-8?B?ZUxrTHd6ckJ0Z1IxckhuQ1ZaZmxGMDJHU2JDbHNtWTJkQU1DZGhIMkdpd25V?=
 =?utf-8?B?bUlFWXMwZnRhYTI1cm1QdUc4bGxRWWtiTVZLNHR3UFE3RERrck1ERlFTUFNH?=
 =?utf-8?B?aUJnNlM0b2M1bVBIME0rejdwWTRwaE9pTXpQTk0vMk9RVExGaFlSb2tnODJr?=
 =?utf-8?B?bFhuY1dLNzNvVU1jN3RHbWpYVStxSi9xeGxPZlFDdzM2alppRFVPN0N1K0xP?=
 =?utf-8?B?Wmx6MVFza0IwTFQvUHFyazFqdVNPQVJhTmJ4OENkZWFjQXJQL0s0MGttZ3Q5?=
 =?utf-8?B?dXFmVU1RQjU4akFsL253K0JMcVZMOUlrWlJrNStCQUw0MkNVRW9IcXNtcTMz?=
 =?utf-8?B?bUxlOWpSYzQ1a2pvY0JESWQyQ202VlROWmpkT2tOVGFwL3NmYkRCNVI0YTI3?=
 =?utf-8?B?VER6L09vT3BBOUtURHhpdURiQTJlckxjb25vY1lJVVVNVlhUOXNJbDBzN0ts?=
 =?utf-8?B?Z3JiMHQwQkkvaDVJQ0dUdGpvQzJVcTAzNUQvNlpZNXA0aFBpZmEyQTlueXNS?=
 =?utf-8?B?azg2SUEwVnpjMDN0WU8zN3c2T2VHNFozaDQrYTV2UGtLcUtkS2NhNUZpYk0x?=
 =?utf-8?B?SGY3bEVLWVpOZnEzV285WmFlVUxsaGdGNmRVR2svWnVqS2xubmxsQUd1L3RB?=
 =?utf-8?B?WmZoZkZKRHdqcFkzN2tCdE1raTNPVmg5ZzZ3eXpZc0s0UmE5VU95NmFBbGNJ?=
 =?utf-8?B?MG9NWUlHOWRJQzRSVnNzRmZPa05IZDErTnBSczNQZ21rcGttOGF4ck5scGhy?=
 =?utf-8?B?ZklIRFFFWmV1MnhMZXBUdmxmTytJbm9OSlE4bko2MXVZNWFiNHdKZmlLSVlk?=
 =?utf-8?B?Y0VZSGNGNXQ0U05KZmxUMy9jNnFsaU5rd0VNRGFvWWY0cFZTMG5wUzlJYmVQ?=
 =?utf-8?B?cUNwM0FGbFpLMFEycDY1RGxTV2dDbDBzVlJNZW5rd0FlTmMxcGd5RlVpNDBC?=
 =?utf-8?B?M1FFWE9nbnRKL1lsUnVOSEU2aXByYmdDb0NTcFFQUXN2Y0xiQWY0Y1ZvWHhj?=
 =?utf-8?B?WnZqWXg1TjlkMEF3dnltelBqQnowWWtXRkdqcW9IcHU3RW5pb0crSUFlbndZ?=
 =?utf-8?B?TXFCTTJjUFRjYmptR0FtbTRscXM5RVoyQ2tHTTVvRmFwUDNHRTlaVDJCQklr?=
 =?utf-8?B?aUUrT3RXc0JNWC9QU0ZXTGtpWDVpbTNCa2REc1lVQUhWL2NqMnZnN0VISFo5?=
 =?utf-8?Q?+LLU=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7129fe3f-efa8-46a1-841d-08ddb4157fc8
X-MS-Exchange-CrossTenant-AuthSource: BL3PR01MB7099.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 18:24:18.9800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AR+4KbY+6KVsGoHAt7vtaxqB03Wa61EKJ5AsvQod0OriBy7hTvcozQzfJMcUhcfe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR01MB8014

On 6/25/2025 1:55 PM, David Howells wrote:
> Stefan Metzmacher <metze@samba.org> wrote:
> 
>>>    read_rfc1002_done:
>>> +		/* SMBDirect will read it all or nothing */
>>> +		msg->msg_iter.count = 0;
>>
>> I think we should be remove this.
>>
>> And I think this patch should come after the
>> CONFIG_HARDENED_USERCOPY change otherwise a bisect will trigger the problem.
> 
> Okay, done.  I've attached the revised version here.  I've also pushed it to
> my git branch and switched patches 12 & 13 there.
> 
> David
> ---
> cifs: Fix reading into an ITER_FOLIOQ from the smbdirect code
> 
> When performing a file read from RDMA, smbd_recv() prints an "Invalid msg
> type 4" error and fails the I/O.  This is due to the switch-statement there
> not handling the ITER_FOLIOQ handed down from netfslib.
> 
> Fix this by collapsing smbd_recv_buf() and smbd_recv_page() into
> smbd_recv() and just using copy_to_iter() instead of memcpy().  This
> future-proofs the function too, in case more ITER_* types are added.
> 
> Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
> Reported-by: Stefan Metzmacher <metze@samba.org>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Steve French <stfrench@microsoft.com>
> cc: Tom Talpey <tom@talpey.com>
> cc: Paulo Alcantara (Red Hat) <pc@manguebit.com>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: linux-cifs@vger.kernel.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>   fs/smb/client/smbdirect.c |  112 ++++++----------------------------------------
>   1 file changed, 17 insertions(+), 95 deletions(-)
> 
> diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
> index 0a9fd6c399f6..754e94a0e07f 100644
> --- a/fs/smb/client/smbdirect.c
> +++ b/fs/smb/client/smbdirect.c
> @@ -1778,35 +1778,39 @@ struct smbd_connection *smbd_get_connection(
>   }
>   
>   /*
> - * Receive data from receive reassembly queue
> + * Receive data from the transport's receive reassembly queue
>    * All the incoming data packets are placed in reassembly queue
> - * buf: the buffer to read data into
> + * iter: the buffer to read data into
>    * size: the length of data to read
>    * return value: actual data read
> - * Note: this implementation copies the data from reassebmly queue to receive
> + *
> + * Note: this implementation copies the data from reassembly queue to receive
>    * buffers used by upper layer. This is not the optimal code path. A better way
>    * to do it is to not have upper layer allocate its receive buffers but rather
>    * borrow the buffer from reassembly queue, and return it after data is
>    * consumed. But this will require more changes to upper layer code, and also
>    * need to consider packet boundaries while they still being reassembled.
>    */
> -static int smbd_recv_buf(struct smbd_connection *info, char *buf,
> -		unsigned int size)
> +int smbd_recv(struct smbd_connection *info, struct msghdr *msg)
>   {
>   	struct smbdirect_socket *sc = &info->socket;
>   	struct smbd_response *response;
>   	struct smbdirect_data_transfer *data_transfer;
> +	size_t size = iov_iter_count(&msg->msg_iter);
>   	int to_copy, to_read, data_read, offset;
>   	u32 data_length, remaining_data_length, data_offset;
>   	int rc;
>   
> +	if (WARN_ON_ONCE(iov_iter_rw(&msg->msg_iter) == WRITE))
> +		return -EINVAL; /* It's a bug in upper layer to get there */
> +
>   again:
>   	/*
>   	 * No need to hold the reassembly queue lock all the time as we are
>   	 * the only one reading from the front of the queue. The transport
>   	 * may add more entries to the back of the queue at the same time
>   	 */
> -	log_read(INFO, "size=%d info->reassembly_data_length=%d\n", size,
> +	log_read(INFO, "size=%zd info->reassembly_data_length=%d\n", size,
>   		info->reassembly_data_length);
>   	if (info->reassembly_data_length >= size) {
>   		int queue_length;
> @@ -1844,7 +1848,10 @@ static int smbd_recv_buf(struct smbd_connection *info, char *buf,
>   			if (response->first_segment && size == 4) {
>   				unsigned int rfc1002_len =
>   					data_length + remaining_data_length;
> -				*((__be32 *)buf) = cpu_to_be32(rfc1002_len);
> +				__be32 rfc1002_hdr = cpu_to_be32(rfc1002_len);
> +				if (copy_to_iter(&rfc1002_hdr, sizeof(rfc1002_hdr),
> +						 &msg->msg_iter) != sizeof(rfc1002_hdr))
> +					return -EFAULT;

Shouldn't there be some kind of validity check on the rfc1002 length
field before this? For example, the high octet of that field is
required to be zero (by SMB) and the 24-bit length is not necessarily
checked yet. The original code just returned the decoded value but
this sticks it in the msg_iter. If that's safe, then ok but it seems
odd.

Tom.

>   				data_read = 4;
>   				response->first_segment = false;
>   				log_read(INFO, "returning rfc1002 length %d\n",
> @@ -1853,10 +1860,9 @@ static int smbd_recv_buf(struct smbd_connection *info, char *buf,
>   			}
>   
>   			to_copy = min_t(int, data_length - offset, to_read);
> -			memcpy(
> -				buf + data_read,
> -				(char *)data_transfer + data_offset + offset,
> -				to_copy);
> +			if (copy_to_iter((char *)data_transfer + data_offset + offset,
> +					 to_copy, &msg->msg_iter) != to_copy)
> +				return -EFAULT;
>   
>   			/* move on to the next buffer? */
>   			if (to_copy == data_length - offset) {
> @@ -1921,90 +1927,6 @@ static int smbd_recv_buf(struct smbd_connection *info, char *buf,
>   	goto again;
>   }
>   
> -/*
> - * Receive a page from receive reassembly queue
> - * page: the page to read data into
> - * to_read: the length of data to read
> - * return value: actual data read
> - */
> -static int smbd_recv_page(struct smbd_connection *info,
> -		struct page *page, unsigned int page_offset,
> -		unsigned int to_read)
> -{
> -	struct smbdirect_socket *sc = &info->socket;
> -	int ret;
> -	char *to_address;
> -	void *page_address;
> -
> -	/* make sure we have the page ready for read */
> -	ret = wait_event_interruptible(
> -		info->wait_reassembly_queue,
> -		info->reassembly_data_length >= to_read ||
> -			sc->status != SMBDIRECT_SOCKET_CONNECTED);
> -	if (ret)
> -		return ret;
> -
> -	/* now we can read from reassembly queue and not sleep */
> -	page_address = kmap_atomic(page);
> -	to_address = (char *) page_address + page_offset;
> -
> -	log_read(INFO, "reading from page=%p address=%p to_read=%d\n",
> -		page, to_address, to_read);
> -
> -	ret = smbd_recv_buf(info, to_address, to_read);
> -	kunmap_atomic(page_address);
> -
> -	return ret;
> -}
> -
> -/*
> - * Receive data from transport
> - * msg: a msghdr point to the buffer, can be ITER_KVEC or ITER_BVEC
> - * return: total bytes read, or 0. SMB Direct will not do partial read.
> - */
> -int smbd_recv(struct smbd_connection *info, struct msghdr *msg)
> -{
> -	char *buf;
> -	struct page *page;
> -	unsigned int to_read, page_offset;
> -	int rc;
> -
> -	if (iov_iter_rw(&msg->msg_iter) == WRITE) {
> -		/* It's a bug in upper layer to get there */
> -		cifs_dbg(VFS, "Invalid msg iter dir %u\n",
> -			 iov_iter_rw(&msg->msg_iter));
> -		rc = -EINVAL;
> -		goto out;
> -	}
> -
> -	switch (iov_iter_type(&msg->msg_iter)) {
> -	case ITER_KVEC:
> -		buf = msg->msg_iter.kvec->iov_base;
> -		to_read = msg->msg_iter.kvec->iov_len;
> -		rc = smbd_recv_buf(info, buf, to_read);
> -		break;
> -
> -	case ITER_BVEC:
> -		page = msg->msg_iter.bvec->bv_page;
> -		page_offset = msg->msg_iter.bvec->bv_offset;
> -		to_read = msg->msg_iter.bvec->bv_len;
> -		rc = smbd_recv_page(info, page, page_offset, to_read);
> -		break;
> -
> -	default:
> -		/* It's a bug in upper layer to get there */
> -		cifs_dbg(VFS, "Invalid msg type %d\n",
> -			 iov_iter_type(&msg->msg_iter));
> -		rc = -EINVAL;
> -	}
> -
> -out:
> -	/* SMBDirect will read it all or nothing */
> -	if (rc > 0)
> -		msg->msg_iter.count = 0;
> -	return rc;
> -}
> -
>   /*
>    * Send data to transport
>    * Each rqst is transported as a SMBDirect payload
> 
> 


