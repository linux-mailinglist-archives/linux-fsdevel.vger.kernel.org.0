Return-Path: <linux-fsdevel+bounces-50839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64343AD012A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 13:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FA4E3AD771
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 11:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CB22882AE;
	Fri,  6 Jun 2025 11:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="K4XSxYRD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714FC286D5B;
	Fri,  6 Jun 2025 11:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749208864; cv=fail; b=MF7IGbZ1EfczyvLMKhSMNDV8hucwGFnDHC+xdAC7qlSi4z75ZjR2mjqFMD7gkXEioF7ypHoeylE+8duGjFptKmdhtWkiIhi1JwV5xTvEasU2rTN5bUFFO2XLto6omSQwpf654/t/YBDKLD4Nwq7kUUCQ5wdngNWrC1MYgkwDzOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749208864; c=relaxed/simple;
	bh=aYJg6svoNVn5VCbrkI6OjaE1F8iZj3UtM/gB83tGq9I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fTLhebWqGdjuU2voCagEsWj0O3T4APLOYQTHCuSA95X4KW6NNCKSlvAu1XxIsKczSVqcVQD9AU5mzu7+2Fix24xkbiicPPE2uq1nnGAx95Mjmxajv5JQC7KwsEL7znpNm46YquEiVy0pL4Xp0L1Ld5TfFFpjCDk/zovIweTIK9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=K4XSxYRD; arc=fail smtp.client-ip=40.107.223.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OMH3eJ3eDrXRSOEt35moK28RiMam/psoBhTYmmKxhP+TavkOHoRGjd3WEwas7srOtNh3yXP0JLXi+pDkONnkxXMCV2ygPsjgpP01Yf1XyFSywT8JIL8Z6vgwtyX4sqY9kGeiswUTt+Gb/pre+xtH04NrRSL07tkfXb0LtGMSplbvAxydhlBeAUyBAkhqT/SKP8Pnci8kqkECFM54TMYTv8IDYe+W9IoaMS+U0Pmz8sPAJo/8I10HMSXDZdU4fwEGCVzbYVf6SLarVY+ChBVCJUNo0T/wXdi+wpqf5IxYqMQJ/emqgMZ7/Xqlro64ot43zdEpGm30pg7vAhjWMGO0tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ebMxtEElMePjAJIxLtoSH0aUNAIqzDaSD0SbSVcXdE=;
 b=BdG3y/syRrSGKPeMKvOQ8WoOziaKuQULQBta3gl139SUDJ9iRAGL0jvbtqqik04YKQdM+J3jJ2mND/D5tvdD9xDJv3CdCTsibWX6Z81hAfzwcUbZxwI02cYGb5vxU7qOeXMs/m47ymf9qy76yVnBqoV4x71x8/4/DcnBelht4nuBIIEcN+XPyg8QSbcYzFTs4arxL+5Fkpw9QL5sPDGRTENHGGMk/KevEix3EEQr62et1YQiFBkXSiOyvQQ+VxE8vYQwmQKyoaoNIUeM6rQnTPejjZW5ibI6nOqjMixul7FTIi5pobfOcsVE+/geGJC4kk/m5XrHA+rA1jWKyZH1rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ebMxtEElMePjAJIxLtoSH0aUNAIqzDaSD0SbSVcXdE=;
 b=K4XSxYRDVLMuBgcg7wC2eKGtzutChLyyfrRvFx/FxvpUp79WC4dBROQN2lXylwNEgtWNBGdokdXdMhj+wgLCjcb7qHnWfCVr8Kpx2TA116I+JBz4m40JrJiZWSOVeSC4IvRwgDhLxaudlgnxVRzGwXrGOGy6qBovaOTam4DUOBg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB7448.namprd12.prod.outlook.com (2603:10b6:510:214::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.38; Fri, 6 Jun
 2025 11:20:59 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Fri, 6 Jun 2025
 11:20:58 +0000
Message-ID: <a766fbf4-6cda-43a5-a1c7-61a3838f93f9@amd.com>
Date: Fri, 6 Jun 2025 13:20:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] Implement dmabuf direct I/O via copy_file_range
To: wangtao <tao.wangtao@honor.com>, Christoph Hellwig <hch@infradead.org>
Cc: "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "vivek.kasireddy@intel.com" <vivek.kasireddy@intel.com>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "brauner@kernel.org" <brauner@kernel.org>,
 "hughd@google.com" <hughd@google.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "amir73il@gmail.com" <amir73il@gmail.com>,
 "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
 "Brian.Starkey@arm.com" <Brian.Starkey@arm.com>,
 "jstultz@google.com" <jstultz@google.com>,
 "tjmercier@google.com" <tjmercier@google.com>, "jack@suse.cz"
 <jack@suse.cz>, "baolin.wang@linux.alibaba.com"
 <baolin.wang@linux.alibaba.com>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "wangbintian(BintianWang)" <bintian.wang@honor.com>,
 yipengxiang <yipengxiang@honor.com>, liulu 00013167 <liulu.liu@honor.com>,
 hanfeng 00012985 <feng.han@honor.com>
References: <20250603095245.17478-1-tao.wangtao@honor.com>
 <aD7x_b0hVyvZDUsl@infradead.org>
 <09c8fb7c-a337-4813-9f44-3a538c4ee8b1@amd.com>
 <aD72alIxu718uri4@infradead.org> <5d36abace6bf492aadd847f0fabc38be@honor.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <5d36abace6bf492aadd847f0fabc38be@honor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR12CA0025.namprd12.prod.outlook.com
 (2603:10b6:208:a8::38) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB7448:EE_
X-MS-Office365-Filtering-Correlation-Id: 908e8520-cca5-4e3d-5de1-08dda4ec3640
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SHp4Y3ZEL1VnNlQrenJsZ0M4M0w2UU81NkNSODFZRVhEMnJrOU4ramlKQ3h4?=
 =?utf-8?B?bU9QRmlzUC9BOU9JNGlPK3B4Y0IrSXZKYnRwbWNMdmlqTC94eTJVOTNyRDNJ?=
 =?utf-8?B?MEVnTEhoWXA5NVZ6MGJYcjM1RXRtQjdLcjJvclduWmJZS1NjRndFM1NLL0E2?=
 =?utf-8?B?M0hFRVFuMG91aDdPcUZuTFpGVUc1ZmFHbWpNS1RMQkc0alhWcGVUaSt4bkRJ?=
 =?utf-8?B?eVZ0eUw0TTdVRStPcVBocG40eTlOS1dEVmk1cmJub3hJdWRVdEc3ZTF3dmFT?=
 =?utf-8?B?cHZ0d0hTZEQ0WGc5bWc2T1l5d1lmVWtNVEpwY2NzYUhKTE53RzlaUlRXYm5n?=
 =?utf-8?B?OWRwZzBoZUpaWnFmV3pJNkVuS2xqNWExbDRGSGY0VFB6WGU3U3VyUy9YYXZK?=
 =?utf-8?B?Ry9WaGpnWEhDaGNiS29ZZTdkZEdzUDVBeSt1ZjlhYllybzEzNEVzQTArTFJv?=
 =?utf-8?B?RTJzZVhEV0xLWVVWN2wvQStISUU1VThJaTFyU3RER3M5WGh0aElSdml5cEsx?=
 =?utf-8?B?cllaZk5aZjN6SytQekpjQzZseXVVT1hTSzlCQjRxdkJXa1BOUlNRcVdxSmw3?=
 =?utf-8?B?Z0xYcDdqOCt6TGI4dnZQeW42Mm93Ylc0Nis0WDZvazZhWk5CcXprVXRGRVVM?=
 =?utf-8?B?SGgxbmtnUHlFdmJZdisybjVLckpVcjVCcXRIWTRoM1drRGdOSVUwakpvd2VJ?=
 =?utf-8?B?UEhxSHBqTks3MkY3Q2E0NUNPdXNiUVVsTDRhR0sxTkVkS2ZOaDRNOVcxYjVH?=
 =?utf-8?B?clRxWG9NK1hBZlFXNDY1QWtMRDdwUEEwMGpqSGFDUWhScGxCU1JMSndVbW5R?=
 =?utf-8?B?Mk9BN2JtandkT05CTjZ2b2hiazgvc1U0VkJzSC9xc24zYjJ0VHlwWWZvZmpv?=
 =?utf-8?B?Yk1ud3Y3eUl3SjZnYnZudzhkeHVsQmNXUm45QXZVdzQ3dktYaWF4ZGoyVzR4?=
 =?utf-8?B?Nk1kVFF0YmtHamdGNlFtRXRVbmZuZEtEZ01tYmF1RFhMdFJBdTQ3a00zYVZP?=
 =?utf-8?B?aHRvVnNrSHZsWHpHSTMwQTNjSUZacTJPMURER2RHVnBRZU9rYVF0ZGJEalY4?=
 =?utf-8?B?NW1SNTJFSG1FZDAvN0xqUXNSZEpCWGg2NjlxUU5pZldwTHNGY2YyR1hMSHVY?=
 =?utf-8?B?cFJnOFBPRjNCckpiRnlBamFxNlJReEFTa25jQ0JLRmMyK1RQLzVENHdHLzBo?=
 =?utf-8?B?Ti9PUGY3eEJEaDJuZTJLUE5OaWZuend5aTBVWGxvQ3ZQMW9zWDkzVlNWNGVp?=
 =?utf-8?B?THlzSDlmM2poQ29XV1lpN3o3QlJPbjc4L3BhQ3NidHZRRmVjMGhuQWljSUky?=
 =?utf-8?B?OFJYK1BkblZ0MmFWZStvVEhjR3MwZWlzUUl6OWV4Vy8rWG53UHZlQ0Y0Tlk1?=
 =?utf-8?B?YVJCVmFBT3pBMmI2R0RnNWE4blQ1cWFaVnExM3ZyYzBJZGEwN2JtSW1KbTda?=
 =?utf-8?B?Q1BMbTRtbURXak5BaUkwWmMvb2lpYWhUVUpYaHVSUGtZMm1lUzZNeTZ6Z05G?=
 =?utf-8?B?MUp6UWEvbWZwT1IwYUoveWQxMk1Qb093dWM0cnJ4Y1lQVVNuTnNBaTZ4b3E4?=
 =?utf-8?B?ZVFya0VSYUc2MVhLNXZtaXM1UzZRcTB3NjU0WWRIVUxRc01VNXRLb2xkVzZH?=
 =?utf-8?B?YnJWOHl6OTMxY01obTU3QlVndVhoeUtOcGt0bGFZYlh1WGFTQmVIbEo1dkdG?=
 =?utf-8?B?Ty9SWkdsQ21FcjgyREtvUzFvdkF2aXNPb1cwWVE4RmFTdkw5aVYwdmcwWlEy?=
 =?utf-8?B?ZGV5YjlVZHdaenhERm5xZEFpR0tmVFZXQndhWlBoMGZtUWw5VE5PcGRCUThG?=
 =?utf-8?B?NHVkNFVoS3p1eWZ5S1NreWZrRE1LNENWMGZ1SE92cGplODRvNFRQK3Q1VTZN?=
 =?utf-8?B?dUw3Y3JhQ3FGTERJVmkrRG5kYkxFWkdDVHlBeVZ4ZTRGNXpxYXRXMHpqbkpM?=
 =?utf-8?Q?+HZbZsyQfJs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1V6anIyRUlaeGFuYWFYVHVRVU1zOEF3cmN0VVltbGU5RFQ1OHRsYUxYb0da?=
 =?utf-8?B?dDBJbll4QUQ2TGxYWnFTclh6ZFlMUW9oY0gwL2JjQkF4NHpwYnNxRE9QNVZC?=
 =?utf-8?B?Ti8vbk1vbHBBckE3ZlpTYk9RTzBFdDZkVjVBQTNxYmkwaEFwT3NDenRyWC9F?=
 =?utf-8?B?TFl4VnhTL1htWDRUbXRMTFVRUXIwMnFnaVdMYklvK1FCc041RVBqVmNmdEdU?=
 =?utf-8?B?a2M3NEpKUTdsZ1BGNDBzbWZVdm94bUR1bXd6bGhvck85K05VeWRBamxuRnVW?=
 =?utf-8?B?SHFiR3lNbkZZNjJwK1Z5NVdMRi9tUlF1eTZ4bzlhbVEzelVqQnpNY2J0Tm41?=
 =?utf-8?B?WTM0YTFQT3ZhbWpDSFdFd0MyZkRCRGt1MnJEclFXd3JRYXdPMFdiUlZOZGcz?=
 =?utf-8?B?d2NYNndWUXBOMm4yNG5OYmN3VnNsVzZzQXRib01OeEp5R0twMVNtTlZzOHNY?=
 =?utf-8?B?VjVycncxSUU2OXJkUnY1cW1ZTSt4NHl6ZVkxYUJXN2l3UkF2M0pSUVV6MnVq?=
 =?utf-8?B?NXVhQW41RS8wZmFoMGsvcGErdHZrQUJkN254UnhsUklxUFdvejVYckhYYmJU?=
 =?utf-8?B?bTlBZW9BcHpaOWdTUURXSjQyZExaSFBaSUNiUms3bkkybU9qQTZZemV4WktV?=
 =?utf-8?B?dDI1SEVoNUd2RFpKdGFjaVFqVGdrcDlUU1AxQk1lNXVVc0h4YXhmUGZramcr?=
 =?utf-8?B?Nll2TjB5U3pqMzhHVXJweEJ2aXEwLzN2dFh5MlRRN21IK211K3ZCdDVaNnl3?=
 =?utf-8?B?dUV2Tkd1ajVjeFdVa0ZaOE5TRFJUNlNET3YzZmIyWVFrVlZ5blA1RzV6UzNX?=
 =?utf-8?B?ZHNKbU5jTWVRWUhSbWtuL21qOUlrRml3ZFZ4eFlrNzdJRUZBTVNmeWVCWVJu?=
 =?utf-8?B?WnFEUTJSSmNsN3FPd1habnlEYTBGZDBpa1d3QmYvL1FSVDIzR3FzSDNKZjlY?=
 =?utf-8?B?STFpM2ZjS3IzVzc5eDFubUFHajEzNVhMRXU0QWVCYzMzRFI0SjBGSTBpNnRT?=
 =?utf-8?B?YWhzcThvZGdadWFRMHhVQUR2ZVptc2s5VFFPajJEczUzUE50WFV5NWlIQUkz?=
 =?utf-8?B?YkJkbWlxeUNSc3lyMGVVSHZQUFZDajkwQm1lUjZmdERsVC9wd2dDalM1eDQ5?=
 =?utf-8?B?dXExeU5kNFlDTlZVa1BPaXRrSGE2MmNHTmRDVmVzRkNWZ0NueCtUVDJhWUVH?=
 =?utf-8?B?ZVArNVRpRHQxQXNiUnZuR2w2WkRMTkM4OXRubUtkM1ZFY1hWSzVHakYvR0FJ?=
 =?utf-8?B?clVGLzlQems3LzhoTFUxRVVwTHBNMnY4SnFCK3hhbE5VODJ3Z1Z2V0FFUmNv?=
 =?utf-8?B?bFp3aDJ1NGxGelhPN0hQY3kvOVQ4LzFUSTU5aDlDbUxFREhjcFY3NEJtNnpB?=
 =?utf-8?B?ZnY1Qzd5MENXbXVoU2IybTNOVlNjTWZNRTd0ZW9xbG5SUTF2Yy9ibFgzczFC?=
 =?utf-8?B?b094aW9uTFRaRXArWE9UYWlML0tSeDBjenE3Y3ZMRCtRNXpEZnI3LzFNZWw2?=
 =?utf-8?B?eTNOYjhhNFo2M29OU0Y0ZUpmRExSWS9vOHFuelhQaE9jbllhWG5Zc0NiU1NY?=
 =?utf-8?B?NWg3YWJoVnVCQmhZOGZDS0ljMzRqK1M5Z3B6L0pMWFJVUjBxWEhaUG9vRmtB?=
 =?utf-8?B?eUt2R1YrYWlodTEyaEkwTUVkeU9ESHZlRlpRa2taaWUwZE55WENCZlBMZHA0?=
 =?utf-8?B?OEFFaE5WMEt3djJqTlBOWjdhVG82MnlXOTE0RkhOV0htWjhaY2hubWN3NlV0?=
 =?utf-8?B?cTlxaDBGenRKeWV6K2VmSkhvWDFtVWZpWHlpRkc2TE5KY3hCSktBYm9VYXNW?=
 =?utf-8?B?djVXR0FCVmZuQ25yYWE3RWJmMXo4OHF2bXYzSGFiUWJaeWYxbkczQ2l4dUQ5?=
 =?utf-8?B?ZkFTeWtxKzFFV05OMmlSaW5HNVZMNnIwVWZxRDQ3RHZQeWZEeUdQVWM2MVd3?=
 =?utf-8?B?cFdmVWhXZkZuZFZqTGlXVGN1bDdiNWFlTk80SzZ4MGRtTWtjMXE1VnNsZjQz?=
 =?utf-8?B?MnIzR1dmVlRZbHd1dlF6Vi9rOUc2ZnVFbkxUU0FON042ZDRjSEgxeG9scGRS?=
 =?utf-8?B?Ly95eEUvOElTRHp5VEoxQ0FhQUV3STEzdmxpd2hIbFZJRTh3eW1Rc3RZcDF6?=
 =?utf-8?Q?nN1yBgiveWxeuznWSu+tvR0lG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 908e8520-cca5-4e3d-5de1-08dda4ec3640
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 11:20:58.7828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QNQHQA2MPreVu/8FZ7eCTbIh0Fm5x5i1XTDgeCC+XoZlSyKtgA/s1PYnGKL57Uj0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7448

On 6/6/25 11:52, wangtao wrote:
> 
> 
>> -----Original Message-----
>> From: Christoph Hellwig <hch@infradead.org>
>> Sent: Tuesday, June 3, 2025 9:20 PM
>> To: Christian König <christian.koenig@amd.com>
>> Cc: Christoph Hellwig <hch@infradead.org>; wangtao
>> <tao.wangtao@honor.com>; sumit.semwal@linaro.org; kraxel@redhat.com;
>> vivek.kasireddy@intel.com; viro@zeniv.linux.org.uk; brauner@kernel.org;
>> hughd@google.com; akpm@linux-foundation.org; amir73il@gmail.com;
>> benjamin.gaignard@collabora.com; Brian.Starkey@arm.com;
>> jstultz@google.com; tjmercier@google.com; jack@suse.cz;
>> baolin.wang@linux.alibaba.com; linux-media@vger.kernel.org; dri-
>> devel@lists.freedesktop.org; linaro-mm-sig@lists.linaro.org; linux-
>> kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org; linux-
>> mm@kvack.org; wangbintian(BintianWang) <bintian.wang@honor.com>;
>> yipengxiang <yipengxiang@honor.com>; liulu 00013167
>> <liulu.liu@honor.com>; hanfeng 00012985 <feng.han@honor.com>
>> Subject: Re: [PATCH v4 0/4] Implement dmabuf direct I/O via
>> copy_file_range
>>
>> On Tue, Jun 03, 2025 at 03:14:20PM +0200, Christian König wrote:
>>> On 6/3/25 15:00, Christoph Hellwig wrote:
>>>> This is a really weird interface.  No one has yet to explain why
>>>> dmabuf is so special that we can't support direct I/O to it when we
>>>> can support it to otherwise exotic mappings like PCI P2P ones.
>>>
>>> With udmabuf you can do direct I/O, it's just inefficient to walk the
>>> page tables for it when you already have an array of all the folios.
>>
>> Does it matter compared to the I/O in this case?
>>
>> Either way there has been talk (in case of networking implementations) that
>> use a dmabuf as a first class container for lower level I/O.
>> I'd much rather do that than adding odd side interfaces.  I.e. have a version
>> of splice that doesn't bother with the pipe, but instead just uses in-kernel
>> direct I/O on one side and dmabuf-provided folios on the other.
> If the VFS layer recognizes dmabuf type and acquires its sg_table
> and folios, zero-copy could also be achieved. I initially thought
> dmabuf acts as a driver and shouldn't be handled by VFS, so I made
> dmabuf implement copy_file_range callbacks to support direct I/O
> zero-copy. I'm open to both approaches. What's the preference of
> VFS experts?

That would probably be illegal. Using the sg_table in the DMA-buf implementation turned out to be a mistake.

The question Christoph raised was rather why is your CPU so slow that walking the page tables has a significant overhead compared to the actual I/O?

Regards,
Christian.

> 
> Regards,
> Wangtao.
> 


