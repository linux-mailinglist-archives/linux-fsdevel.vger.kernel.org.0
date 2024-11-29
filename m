Return-Path: <linux-fsdevel+bounces-36133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 113D19DC22B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 11:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C895B2250B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 10:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1C618A956;
	Fri, 29 Nov 2024 10:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bDRl3Aiq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A55155345;
	Fri, 29 Nov 2024 10:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732876357; cv=fail; b=R5OQy2KFv5AwlBr18ftCWQVk+OcnfoBXHsr5QcCW3xJT74seVSOIR7kliLzEZHRe4Y3j9aZV8o/aOJuAy/+OGbs6vLuBaxkiLxgGD1giPwZMF8gEHp0Pci/svs5FLaoVj6TgMFAxeV782ww24Auan5oT7Hg3obWR4W+grwR2i3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732876357; c=relaxed/simple;
	bh=P/3Fqls7qSNdAipjAe1165k94dL513yrHn8Ae1l/Gb4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GgaaA7o7ejIVVVbDeVQDE8bYJP0f6YSxxkpL+lHkwuQsPgH2zas553OvBWo57+EN+8Is/7HcoW0wfQrDTyf0Jq/S5D9hwLp6OeoxDEdRgwlQAy9X1czXTRtTFIguAcC2hiaM0qvbNujS2+FDhOkrJpp8T98uxgigDbPJrC+JGpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bDRl3Aiq; arc=fail smtp.client-ip=40.107.220.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YxSost2kDcba4qx7au6eM/NTtTqkRebgZcxRl4KcENiN/CuLEgmmxCqIDjXX6RMYIAXve0/nDRP5GTjWZrAQAlUu1WFfbPVi7h4I/ynnzwv1Okb9IqbGC6/+rbXCd1jOwcq7XSDAfJ4LhqHLrCSBT+uuD/JjWIL9lFawVhc62qGGtfmOeSRNGVkLAWsO7jP8NYyOsQz1/V8r9xmNRaNsYHYqKjK37ku28Eae7GJwK8fdvDSW9hGJy/WoAw6dULGLcHU6a2fiEScQGusZcTzXdSDWW34G1KkcbLYctdlq/5fo1NaJW5JJjEqkf9hgmTOLw3X19ovmJsQ6n1EZCOwTeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XumvygVx3tIDEr4J5he6cycO30ca3UbTxPVRDyY99c=;
 b=MnvQDOlrt0uAGHMreljT/2knrrXstYOyb4raP2guE7CQnf3VoyNTMK4DsqlUPLMpmrr+Cov2Kl0WJKyhTLbAlqXDL9gFoHGAL/UgTmI2pSk0+7DojoS97TZZE34Qi6xJTs5M/KfkOCezdsO6dyw0Pb3NrcomSIkO26zu9Eo8sHtAbyNGVSOZ8ouec8epMAv/hJOXZT/qhJcJAsqqktZNBrt8G5vP+OylqFQEUFSXqvlko8SJ8oYDONbWNck8exQuh+K56d9AroZWud0zAs4aKOXS0WGIEiIOtYKCHec4MbzbY3RUT6gqymKSEkXWEa2MeFnIIbQeT71NMV1gYrN7aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XumvygVx3tIDEr4J5he6cycO30ca3UbTxPVRDyY99c=;
 b=bDRl3AiqLNiVcX/HlvmvRirgKlam8iVTE/FXmI4LmX0zvKSEEfAU0Hb9/EdFrQJMPTC7yDwuEkI9ITC0JSaa9eJepjKCiI9qvKSzXe57KYNoymhL4gJxbpk2te6/kv443BkKelhKCK9hUHBLkHp3OUdO6VYVH1opBdNOPRt/ch0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by MN0PR12MB6056.namprd12.prod.outlook.com (2603:10b6:208:3cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Fri, 29 Nov
 2024 10:32:29 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134%4]) with mapi id 15.20.8207.010; Fri, 29 Nov 2024
 10:32:29 +0000
Message-ID: <f6878438-8fcf-4f78-88f5-e7f275b157eb@amd.com>
Date: Fri, 29 Nov 2024 16:02:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/1] Large folios in block buffered IO path
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, nikunj@amd.com, vbabka@suse.cz, david@redhat.com,
 akpm@linux-foundation.org, yuzhao@google.com, axboe@kernel.dk,
 viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 joshdon@google.com, clm@meta.com
References: <20241127054737.33351-1-bharata@amd.com>
 <CAGudoHGup2iLPUONz=ScsK1nQsBUHf_TrTrUcoStjvn3VoOr7Q@mail.gmail.com>
 <CAGudoHEvrML100XBTT=sBDud5L2zeQ3ja5BmBCL2TTYYoEC55A@mail.gmail.com>
 <3947869f-90d4-4912-a42f-197147fe64f0@amd.com>
 <CAGudoHEN-tOhBbdr5hymbLw3YK6OdaCSfsbOL6LjcQkNhR6_6A@mail.gmail.com>
 <5a517b3a-51b2-45d6-bea3-4a64b75dfd30@amd.com>
 <Z0fwCFCKD6lZVGg7@casper.infradead.org>
 <e59466b1-c3b7-495f-b10d-77438c2f07d8@amd.com>
 <fb026d85-7f2e-4ab5-a7e1-48bf071260cf@amd.com>
 <CAGudoHGnNDOQtmNXTG4dphNnQW1MD7idAa0fmvk8fBPF34sUCw@mail.gmail.com>
Content-Language: en-US
From: Bharata B Rao <bharata@amd.com>
In-Reply-To: <CAGudoHGnNDOQtmNXTG4dphNnQW1MD7idAa0fmvk8fBPF34sUCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN1PEPF000067ED.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::29) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|MN0PR12MB6056:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c11168c-020e-441f-b36d-08dd10611fc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q0JOTDdTdjBocGJ0M1pzaXo4aVdQb3h3UjF4Zmd5aWlTeEtQV242R0ZuN1pC?=
 =?utf-8?B?YVE2aFFZcm1lbFdQak9hVWlZL1g2Z1p6L2ljUW52M2ZldzFQOEFmZmNRUlVI?=
 =?utf-8?B?NEZCNWIrVWREbFQvcW9CaGU1S3gwaXBnSWpmL2NlNkRoS2d1aE5oVkFNV2NG?=
 =?utf-8?B?MTVJVGFYdUZvbmRvbUNKNmEyalRmK1Zldi9hTlQ2UGZVNjl1VzhpK3Z1TGZ0?=
 =?utf-8?B?RW9CM3dYMEJMcmd3VVZOZkJlcTVYTUhhcjI0U3lPdC9kZzdNcU50Mmg5Zmsw?=
 =?utf-8?B?R3NzQURHZEVIbXBVZkNxM1hLa0Z2R3Q2c0VTdmJpQVBORlV1eTdwckQvY1RM?=
 =?utf-8?B?OUNGb3lwOExYVmI2SXpTR1RESmRheHN5dXVKa3lJbk1mMFFiay9FL29VWHRa?=
 =?utf-8?B?RzdLdG51Q0lhRXZNQ1kwaXdEVWhIbzJsN09Ea2Z4SDc4VUNzdU12Vnp5a0dI?=
 =?utf-8?B?OGxzTk5XSExiNjdPVTZSL0swb29QSVZUZkVtcDhCS1hyaEd0MVpLMkJKQTZz?=
 =?utf-8?B?UXB5THlEY3ZtR2NNU24vRDd3dCt5TVJpbGNQOVA3bFI4ejJmK1FUb0ZMMlY1?=
 =?utf-8?B?UkVkeG9saTFPbmJMUDMwTkFHVTltM1MwYWlpWDRsYUpkN21wYWpLTzdUVk9o?=
 =?utf-8?B?OGZrNDUyQkRLQU9CN0hxYVRNZFhmVDRJT1J6Qy9XSUpaZTA4QlFPOXYrOTFa?=
 =?utf-8?B?bW42dDNacEVxeCt0WGJyMXJVYUlEUnhnazdNd3puYnVxYTBSQmV0cEtvMW9k?=
 =?utf-8?B?REJ1dFRNaWZwTXhKZGJUZm5EWnRxc1pQTDdBQms5T3Q0RmpEbFB3OENlMVpw?=
 =?utf-8?B?OTZMdHRuNXdsTXZJcmlqZXVSOG9jVDhndThpK2dmZDhGbHVPYm9rNzNCRFRw?=
 =?utf-8?B?OHV5L2JYVE5nZEhpR0xkaE5Jb3F6dGNlVnBRdzdYdE5hS3o0bmw1aGdEUzl6?=
 =?utf-8?B?SzkxaitZT3k1SzNieU80WFJoKzF2VUhTNm5rWnZCdWRwL1JxL3hWNEsxam5Z?=
 =?utf-8?B?NU94TENmbnFZQXhCTjBwVVJRQjlWMmZSVXFpNWczampHZk1tRE9yVWNEcEFs?=
 =?utf-8?B?QkV1RzNmVUdTcGd5VCtWSUtWdDVSODYzZDBTRCtreEJGbnhDOU9PQWRZdkdM?=
 =?utf-8?B?SGlaUXV2U2xCTm9sODZVVjlCOHVyaGo3VG5FVFkwbGhnSTkzeVczamM0a09I?=
 =?utf-8?B?Sk4zRFNQMlVkUyt4U3pXeWJLenNLNlV0c1FuSGRLTHBaalNEN3hLNkxSdzNX?=
 =?utf-8?B?YXg2bWl2ZDZ3bU5leGxZNjMrSlhHQUcwb2lkRHJBK3hoN21JcTloYmJ5bDJa?=
 =?utf-8?B?ZTJqb2FtZzNjc241UHpzUVpBNzZ5T2ZLS2RkNFMreXNWbHNFN3JHdlh0eHAx?=
 =?utf-8?B?ZHJ2VWZkTEhWZzY5OTFIZ3Q4WWRialk0MjByczZCMmt4eDNGUFdydWxRQ1Vt?=
 =?utf-8?B?RlA1REhObEtwNW1KYS8rMVVNTXFxY3NjVnRKL2wycWJ3MG5nNUhMRTFldUZl?=
 =?utf-8?B?dVg2Tk9mZEdXYjNKd1g5dUhFV2lIZUdZZmxMamRnSXZXMTZia3p1MzZ1Ym1x?=
 =?utf-8?B?N2ZRUDdCb0VNN2Z4Unl6bk15NjFMOUtnMkI3U0kySjVQR3I4WE9XRXpZNnpQ?=
 =?utf-8?B?cUJIaUxtbFozTmtkUnZGamJvSkR6WWtOUE9vM1ZZRVdHOE1pRGUwUUhtblBv?=
 =?utf-8?B?V2VoN3JPeHVkdzk2bEdSWkVyazltdXcxdEpLUTJyS253TFNvSCt2R0NTRk03?=
 =?utf-8?B?ZFpkQTMrcXNNdEx3ZFJUcG9QQzUvRlc4ZnMvRXVMUGNyY2VqOGFUclNsa0tJ?=
 =?utf-8?B?RGEyN2kyWitZUWJSNXNIQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0xYTk1JUkVDL2MvZ2VEcG5EaEEzR1FiWEJjblN2SzhLTXpkMHFmMlQ2RVRG?=
 =?utf-8?B?YkZuaWltdFF6TWt1OHdndVBHVGlSTVNJb0VYdGJJTWZOQTVPR09HRitzSUI3?=
 =?utf-8?B?OUdEdFBoQzYyTGw4bnFhZVo2RGt4ZWxjeEN3bUhkbnBSU0hsQ0pBYldKUVJU?=
 =?utf-8?B?NUlDcTNzaXJOdkZVaG9ESFJjMDczb1o4M3FTUFQzRnNFWE5FbUZyNzY1cUhz?=
 =?utf-8?B?Q2hqMTRPTGhYcGZLM0J5T3lUeVY3QWYzUjVreGU5ZmJRRk81SU5WNDNmV3Zk?=
 =?utf-8?B?L3FwazJzbSs4VkRiQVg4WEhyWjJUVkk1QXo4cG1jL0luYnMvUEExZzZVMVVE?=
 =?utf-8?B?eG9XeElQQ21KZWtydExteHlhcWpVU0JQalJiU0gwN25GQmtKcGx4OTFVbk9Q?=
 =?utf-8?B?M052YzJZSDFLSmxSVHpDSGQ1UE11bjNuTnVjSVpNOTJGL0JjZElnN0oxNHFn?=
 =?utf-8?B?aDRJRGtsTTNYdmFBNk1lUk01bk1aODJaMkhSUUJwZnV6OHlva2cvbW4vNkVu?=
 =?utf-8?B?QTVHY0dhblVxbGlVTlNkY2NJSkNlRFBKdVFnT3RZL3ZVai9HMkNxMkVGaEh0?=
 =?utf-8?B?aC9rWlRsRy9EcXZIbFlVVnlodUlKcmc5eEVvZkxiVUdTdjJiaCt4RjNvbkE3?=
 =?utf-8?B?dldNTGFJYVUyUGU4bFdRKzgxYzFMY1k4akxMb2JzdDNxbFNPOUludmFvRDVW?=
 =?utf-8?B?RWZ0ZUxBWXZwOUVlV3VHNElqQXNGZk9nRitDY1JSakNFUFRxbmF1M2IzaUdr?=
 =?utf-8?B?TnhXeUUwWDJuUkxFTWJ2aFVQSzgwTUZ4UW5IdmtnbnhOYTZ5TWMvZU5Wbzhv?=
 =?utf-8?B?RVQ3ZEtuaUJFL2NVNmJKWVZaVVFsZmE4dmRUSURhTVl0elh3c3lQOUxGQ3FN?=
 =?utf-8?B?YmJHZFRZa2phN0s4c0xVclo0WWMxV3dwdDVLY3BXQ3NRZSttMmw5ck5tbHdK?=
 =?utf-8?B?QzhZRXJYbWs5Q0NtRjZiOWtNL0NsUmJzcUxnZWlQWm5QV0JBcXJvbGkrVWlh?=
 =?utf-8?B?MnMvWHA0TlJHbzVqSEprR1pLcWorM3kwbVkxUXZDbnM1SG1TWmV1Y0ZUbUpU?=
 =?utf-8?B?OUo5VHNJSmdBL2s2NDJXZ2NqRDlLZEIzYzk5TmlCMm1jcDV5cUF2SS9DbzZQ?=
 =?utf-8?B?QnplY1NreDJ3eGpIYnFWYlBVcFgxbWRDL2l6T1VMclhsNkFXdVlGSno3Z1FT?=
 =?utf-8?B?TEpySmJHV1BpMmlEcnJLT2N2anBTak1aTk54dDJXQmtuTkRPbDlXaE02WUNX?=
 =?utf-8?B?ZjlxczRoc1BqN3hZNElNNGhQamxFS2FNWWRvRldITmZvM3NkTHE1aTFoMXRB?=
 =?utf-8?B?anFzQ2t1M0VubUdxVER5NGI2ZU9QSG1qQXJkdW5Za0FiWjQxbmpqMVNQZ09E?=
 =?utf-8?B?d0dHOWRRQm5tZTdYSlQ2UkRGYk80VXMxR3lXU2pZdGwzR0RpSERUSUZzYWNz?=
 =?utf-8?B?aEI3VktWZjJsSmlHdThRMXNRUDJQTUV0Slg5WGx6b0RidVNKZk4vS2puYlY1?=
 =?utf-8?B?MkJIL2Zvb2VjYnVidENVM1FFcGtXYURjNkVPREpwYzdpVmRIOG8venRhZFk4?=
 =?utf-8?B?MkQrMmxYYjdwUFlUVFlLbEtOTVlNYlFaM3FkemhhNUJ4NHp3VDR1SjFkVWpG?=
 =?utf-8?B?bWlybnZFWk50SDBXdlJhNE9lTGxnREJoc2ZHVlhCWWU0ZmxDbFVTZTBZWkxl?=
 =?utf-8?B?cGFURTR4STRwOGZJTTBRS2dnVFNxVFRsbzdmOTNrWWtTd1NiUlJIWEdvb2xM?=
 =?utf-8?B?cFNCT1I4SDB4SlFNTXhlUlBYVGZNMU1kNGVNVEprNXZnYTFRUEdqUjJiMHNU?=
 =?utf-8?B?c3VXVi9oY1JmZjVEdW9FWi8xSVJweTJYZnQxZWVYQnAyWVBzdGRQZUphWHpI?=
 =?utf-8?B?QnJwWkE4Nk94aXA4UzVOaWhiQUFVNVcxSzB0ZGtZTjBmSFBiMmlzc3NKRUQ0?=
 =?utf-8?B?eis2OGw2NHNrN1NtTkhKbzNMSWpTcTNtVFAzTXVoYzA3K3N4MjlGMzlEYjBi?=
 =?utf-8?B?aTBqWnJKU3Y2TmhOL1FPMXJNNEZJTjk1VlR4RGt1SmV3TWhMbXZHY3BVc2RN?=
 =?utf-8?B?bWdYL29IOW9OSXVwVERMVGdCVE9WbmhEeklkMmtPWXkvbnVGWm9XMjdXRHhs?=
 =?utf-8?Q?JZkkDVETs5JGnJzTwZ4/u8sb9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c11168c-020e-441f-b36d-08dd10611fc4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 10:32:29.0450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TRR6tlg3ANKy5Kafz69re0SDNTgzyi3q38nGA7TRFz1NvY/64t0lvKtn7hb+SsdYNEiJPxVvgVn0aM5X51h80A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6056

On 29-Nov-24 5:01 AM, Mateusz Guzik wrote:
> On Thu, Nov 28, 2024 at 12:24 PM Bharata B Rao <bharata@amd.com> wrote:
>>
>> On 28-Nov-24 10:07 AM, Bharata B Rao wrote:
>>> On 28-Nov-24 9:52 AM, Matthew Wilcox wrote:
>>>> On Thu, Nov 28, 2024 at 09:31:50AM +0530, Bharata B Rao wrote:
>>>>> However a point of concern is that FIO bandwidth comes down drastically
>>>>> after the change.
>>>>>
>>>>>          default                inode_lock-fix
>>>>> rw=30%
>>>>> Instance 1    r=55.7GiB/s,w=23.9GiB/s        r=9616MiB/s,w=4121MiB/s
>>>>> Instance 2    r=38.5GiB/s,w=16.5GiB/s        r=8482MiB/s,w=3635MiB/s
>>>>> Instance 3    r=37.5GiB/s,w=16.1GiB/s        r=8609MiB/s,w=3690MiB/s
>>>>> Instance 4    r=37.4GiB/s,w=16.0GiB/s        r=8486MiB/s,w=3637MiB/s
>>>>
>>>> Something this dramatic usually only happens when you enable a debugging
>>>> option.  Can you recheck that you're running both A and B with the same
>>>> debugging options both compiled in, and enabled?
>>>
>>> It is the same kernel tree with and w/o Mateusz's inode_lock changes to
>>> block/fops.c. I see the config remains same for both the builds.
>>>
>>> Let me get a run for both base and patched case w/o running perf lock
>>> contention to check if that makes a difference.
>>
>> Without perf lock contention
>>
>>                   default                         inode_lock-fix
>> rw=30%
>> Instance 1      r=54.6GiB/s,w=23.4GiB/s         r=11.4GiB/s,w=4992MiB/s
>> Instance 2      r=52.7GiB/s,w=22.6GiB/s         r=11.4GiB/s,w=4981MiB/s
>> Instance 3      r=53.3GiB/s,w=22.8GiB/s         r=12.7GiB/s,w=5575MiB/s
>> Instance 4      r=37.7GiB/s,w=16.2GiB/s         r=10.4GiB/s,w=4581MiB/s
>>
> 
> per my other e-mail can you follow willy's suggestion and increase the hash?

With Mateusz's inode_lock fix and PAGE_WAIT_TABLE_BITS value of 10, 14, 
16 and 20.
(Two values given with each instance below are FIO READ bw and WRITE bw)

                 10              14              16              20
rw=30%
Instance 1      11.3GiB/s       14.2GiB/s       14.8GiB/s       14.9GiB/s
                 4965MiB/s       6225MiB/s       6487MiB/s       6552MiB/s
Instance 2      12.3GiB/s       10.4GiB/s       10.9GiB/s       11.0GiB/s
                 5389MiB/s       4548MiB/s       4770MiB/s       4815MiB/s
Instance 3      11.1GiB/s       12.3GiB/s       11.2GiB/s       13.5GiB/s
                 4864MiB/s       5410MiB/s       4923MiB/s       5927MiB/s
Instance 4      12.3GiB/s       13.7GiB/s       13.0GiB/s       11.4GiB/s
                 5404MiB/s       6004MiB/s       5689MiB/s       5007MiB/s

Number of hash buckets don't seem to matter all that much in this case.

Regards,
Bharata.

