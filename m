Return-Path: <linux-fsdevel+bounces-23664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EB89310DC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 11:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7E641C21F33
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 09:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFD8186E35;
	Mon, 15 Jul 2024 09:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="PwLbAxNA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2086.outbound.protection.outlook.com [40.107.255.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5571A185E6A;
	Mon, 15 Jul 2024 09:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721034472; cv=fail; b=dl5S4nTHzsOHu/ANBSmQISeT6+DFLXkM9HRsNuR9dRIlLubKQlBWek900bOGCtjEULmZy+B7KRG3zFHrM9xoCh088bVHdH5o+YTS7xnV/7YRvMlxKlPsMtEK0zHH78Lk0CUq+8wT1UU3OVmbud7U5Ms9gkvxoieg5sYf16bbPuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721034472; c=relaxed/simple;
	bh=wizY8GmtJqaks2iQy1ndy1RhpaNMmJmrOB3Plo9/KTs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VQ5AwLW+8tP4n3+agEva99jEGjZ1rViWnAmf9fjmk8XoonigyELJy2soZpHr+r8tQwG2ADN6CMACLavEuHR7s/iInekwxFGFzzdvxqF76X1q24SG7zzzXvFok4PxqUBfT82VCzN1t9aIxZjogDxBb0I8F7qGlIu6YCn1jlpN2DM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=PwLbAxNA; arc=fail smtp.client-ip=40.107.255.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j5MKIFRfcmq7ZNJCxZh7zo1AKtpTqZMqikFhULUplBn3xB+4p2VJBDo470bLrZYmwI5ErMxMMKJR75MNKDmKHJnH4Oy2p1tDzvz69DZZK8punedWd5hg4E8bWgRJRcubwiN9cxFfaIAWZYft+ewvvXbNzbhB0oJ2ic8esYAYOnZMOE26jHkLBHgpoy2r3qdl21yB7lvjsr7EysewZk/cPNA30SnkAqhAeIVUrSs/OFlO4SiiRAfm5+xSwbdsGSSioXRGEpS1clMtHVor7Vwua/zneXXDB+2lW7zARDRofv81L2QDA/oz+t1Hw8zoOkji8JL+wtIDEgaIqRVgGxv/Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DfZ7CtWbon92eP/IH3UzOkpZ0YKKWHuq/pl5Jxzz95Q=;
 b=WQN6iwTQH/Mo4IqLvqmLjMU1jMup8G2eqs3nndDswARWQYqhpRSH2teIna6VfhABtBFFBlNAEKE6WZPKMwl88HkbQd20NHnWr0uzoW5hKe3wlmvwdwkcphFdAAXCnfB1hZOdl1B617ATFQW63vkIjARFgj/oS7Pr1ZkBv7yZtrFMu2kgZZP4yUp8hElpuOBrKjIC3RtItW4G5AWqhPmka+v1RWP3huFOW7We/nLnXYsTRcJtH162QJt+OW3gP06gUvKAOEqISgSTNnC6/m8vGBYdK0KCgxWNlCEzjuGW3ZrOfPdGmrF9sXjoUDzQIHA5qTc1fYvNEgyQ7GUNgUfocg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DfZ7CtWbon92eP/IH3UzOkpZ0YKKWHuq/pl5Jxzz95Q=;
 b=PwLbAxNAKqIhJaglmXYO4+zBZV4MfyWqNki8kFMu5Hg/ocqPLtj2iphW7/7LWndbu2X1KhftOL0lTtCgsPsCpp++BLsp/czwj3GknQh3DmnxJYFNLvQ4J7KAP47kaDkjY1gai1rYiDaTAwdinL0iGj1kiFFAhFUsJpuFQtr1Up0rm/FLgcUJBhjfQakZu0j+ckfE0OaOrQ5bfYhFXtOMEyhFTatOZ9ErL8CqV+78j1wfbZ476NA5aNDlioyMLFGuqHWsGqL/oYPXtQRBHPzHTuPm2XYR47Mg+Hm7SH0ODzLC4gsuTdsyHIQl7gsYDigmhDyLWkPzcZdWWn1R38j64w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com (2603:1096:101:c8::14)
 by PUZPR06MB5650.apcprd06.prod.outlook.com (2603:1096:301:fd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 09:07:44 +0000
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd]) by SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd%5]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 09:07:44 +0000
Message-ID: <c8478a67-b14f-485c-a239-8967f1e40600@vivo.com>
Date: Mon, 15 Jul 2024 17:07:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Support direct I/O read and write for memory
 allocated by dmabuf
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "T.J. Mercier" <tjmercier@google.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrei Vagin <avagin@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, Daniel Vetter <daniel@ffwll.ch>,
 "Vetter, Daniel" <daniel.vetter@intel.com>, opensource.kernel@vivo.com,
 quic_sukadev@quicinc.com, quic_cgoldswo@quicinc.com,
 Akilesh Kailash <akailash@google.com>
References: <20240710135757.25786-1-liulei.rjpt@vivo.com>
 <5e5ee5d3-8a57-478a-9ce7-b40cab60b67d@amd.com>
 <d70cf558-cf34-4909-a33e-58e3a10bbc0c@vivo.com>
 <0393cf47-3fa2-4e32-8b3d-d5d5bdece298@amd.com>
 <e8bfe5ed-130a-4f32-a95a-01477cdd98ca@vivo.com>
 <CABdmKX26f+6m9Gh34Lb+rb2yQB--wSKP3GXRRri6Nxp3Hwxavg@mail.gmail.com>
 <63237086-223f-44fb-90a0-076a5f56dfdc@amd.com>
From: Lei Liu <liulei.rjpt@vivo.com>
In-Reply-To: <63237086-223f-44fb-90a0-076a5f56dfdc@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0131.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::13) To SEZPR06MB5624.apcprd06.prod.outlook.com
 (2603:1096:101:c8::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5624:EE_|PUZPR06MB5650:EE_
X-MS-Office365-Filtering-Correlation-Id: a78f968a-d67d-49fa-c261-08dca4ad9678
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dDdDWS9pS2pGS3hEZ1pSdjZYaWpVeFByS1ViZTA2MzFUMHRBK0pTNWFPdU9X?=
 =?utf-8?B?dExZWWNHck1NRWJtTDNSM0tobWNEdVM5SEoybkxCWkpsVVM0MkE4b1FyQWUw?=
 =?utf-8?B?cGpMOUpJN0RFd0hGYmFNUS9oTVJxbmtrb1c1dm5HbTRPM0JUK0VSdEhGbkIw?=
 =?utf-8?B?Y0lHZlVTRzJOQWtENG9QSmdyeHFuUUdRWERJaGhzRG8wSmRqakRtMVhUL1Zw?=
 =?utf-8?B?VnRsQjhiNmJpRW1IVGZ6SUozcElRWS9URldvT2JZL1ZNcm5FbmRqZVNGSEhW?=
 =?utf-8?B?YWJ5cUQvZm52ZEJ4NEErcTlsZkhEQS9wZkU5R0M5dnhZaFgzUUswSStPUDZF?=
 =?utf-8?B?QmJHRmxESUwrT3FIakxTMVp3aHVER1JXMmdEZExoWDkzVDdKcFJnVjBZMGNW?=
 =?utf-8?B?cm5TZDZCOC9JaUZVLzJXZ0M2VzBnZ3U1emxOY2xmZExZNWF4cUFFMFZ3UUtL?=
 =?utf-8?B?VVVjamJwY3RCdFhVdTNrUVN3aFhabTJKQ0lkNGlQUmZHNXlmN0hjSmx5OU1M?=
 =?utf-8?B?a0VnMm8xQk8xUkk1UHJ5clJOVGo2Qkl0Qmt3Y3ppSnNxbEFpNVllem9zRk5y?=
 =?utf-8?B?ZnhjZlgwWFFOTm5Xa1diQlNwVDJPZEdGdkpTUGwwUjdQR1pweHY1U3FEUWZh?=
 =?utf-8?B?bUtSNkxEYnRTRVh5dUhQS3RvbkFsZzdZdkFLK3NpdituNCtUS25sb29oS2lL?=
 =?utf-8?B?QkROcUg5cFFHVGRrSDcyVTAvSEd4UjZjMnVUSW1GMkpWM2ZieHV6ODRMVnli?=
 =?utf-8?B?NFk2MVo3elF2OHErRVIxNGxzYm81eHV2RG1NbGsrMC9JSWhJTUt0eURzMGdh?=
 =?utf-8?B?NEpBTkdzWFJVWmFDY0N0Zm5TZDBjOHIzT2JGUHJLbVk5TkhRWlgwRTZSUWpq?=
 =?utf-8?B?VndlTGtZenp5SnlmMDNpWnZCSytaRUFLVW1Nek51Z1Q3eEJYNDY3L0pXZFRk?=
 =?utf-8?B?d2RnSUVQRzJqTytCNlRvWUVwcmd3c0dlQjVOK1liYnRoU3o0VnlpUUZlTm9B?=
 =?utf-8?B?eVB2cGlVRkRGQkJKR1hMeXpTdktHM09YdkpIOXFkNmNxSml2My9tamxPUGVF?=
 =?utf-8?B?bzVDNjd2R0ozNDRoUnlpTldWaExEdnB1dXc1WG9DemxtTlZlSmRuVEpOY29a?=
 =?utf-8?B?SW5ybG9kcldZWmMrbUJKbTFweUdjT241bmNOSjBRQXU0ajFDd2lJTUU3TERL?=
 =?utf-8?B?NkN6Z3A5OWNxa0NvZWUzVEN4SWNDOGQyemMzTis0emNkQndqVDZDNzFoUVZn?=
 =?utf-8?B?MEdjZ3dIbjNuMVc0MktwY21jdUttdmFvajBOUnFzT2I4R3FKZXYzK3ZvN2Jw?=
 =?utf-8?B?SnN3dXVMU3dSOE16cU9Od3FsQlZKYndqejU3N0VqSXRvNzFSL01jSTJITjVK?=
 =?utf-8?B?SXFGNW01RjZDS3dSdEJaRXQ5RHdVOTlLYVJGRlFWNm1MYVpKOUp0Zk5vaFNt?=
 =?utf-8?B?V3VkTGlXQUltcWZ3dGhiYjcrOVJpUE9LaGI4ZjNOYmpDaVJXUW8wZEhlUHcz?=
 =?utf-8?B?cGZLZE1udkY3d2Q5WVJicUNXbllnQVB3cW1BeUc0dlFrLzFjekhEeG5xUjJW?=
 =?utf-8?B?OUxOK3Z6OHBuV3NCTEUxVmFWdGRFbTM4TmRlMmdKRDhwRzJrZmh0MUovZkZs?=
 =?utf-8?B?K05nTTcvdk9iMzdacDBOVFVETzBmbUw3Yzc0Q09jOFZFTkZMajZZQThOdzlu?=
 =?utf-8?B?TVE3MlNIVlFwN2k3Q0pqQ0U5MHRKN3hOZFpTMzNZZ293TFV2UTIxOVBNdmZF?=
 =?utf-8?B?cDhNY001bExEbG9sQmhrSHVQYUNCa3ZyUE5aZTRFbS92ejRtTVJaUHhEYTg5?=
 =?utf-8?B?UThoNGphMEV3YTRSMVNPc2wxMWdPRXF0SUpYaHRReERVM3RzcUpKdTlHM1lu?=
 =?utf-8?B?ZU41VDgrd01nQytRRktzQUV3RVBtWmVyQmxxVW9SSmxXUlE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5624.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2lzR21JTDVVR2llZXVHeDd6anpVSlpnVmd0SmV2VjZlcmdOU3R1bGdjTHRm?=
 =?utf-8?B?Q2RrbC8rc1lYOHZIb2FMQmx2ZVAxclRwclRHNzBTR3UvclUzV0ozNGhPWDVk?=
 =?utf-8?B?UkZRdk1VWlV6QmFudlMrSkRENS8vb1NsaHJwZjZCQlNPQWZxTFUyQ1Q4TTNX?=
 =?utf-8?B?TENrRDl6elBvVGI3NGxwbUIvMFYzZ3FlTS9zYjhESDNSN0hkSlM0VVJadktD?=
 =?utf-8?B?YzJpRmx6c3JPcHB2eEc4R0UzQWMzUWo5TUFxQ013eklSdDJ4MDBpQ2IvMGRl?=
 =?utf-8?B?TmMyeWxhb3lzaEw4bnF6SndxdWlMdG4yQ3ZURTNiOXEyTjYwdlorMXprMVhS?=
 =?utf-8?B?VUdaUThpRXhVTVVPdFBuQXFhc0UvTFRSSDRhVWkzdGpRNFNwa3IxWHZCL2JG?=
 =?utf-8?B?TDQ2TlNRVGlZRFc4Y0MzZ01nRk1ZcE9IRzM3WjNBSFBFS3dnQ2lRSnFPeFRy?=
 =?utf-8?B?dWVwZ0d4dHJhRnYreW0rcG1NRU4yM1dyREhDVXhPbjNWUXBjYTBBaFM3SGU1?=
 =?utf-8?B?RG5ydWpjTkp4VTBBNk9Bc3M3OVZlTnVjOFkvSzlUcTVhb3E3dCtLZkwxK2U0?=
 =?utf-8?B?eDNEL3BhQ1IwZnRyajNCRUZIcUR5SFhNaGFoY3hXQWFRQzlBYUtuOVZVWGtT?=
 =?utf-8?B?WkswbmhqSnhDdTArLzNNWjM3czRLU2FZMTFIQldFNXdtUCt1eWdEL2xXdlBn?=
 =?utf-8?B?TU5QT005U2JtbDkvTGVKcVozWUZiemhZQzVTNitvOC9VQmVSam9QVVV6RjEz?=
 =?utf-8?B?ZjdFek1iM3RTbEN4VC9oN0JjZUgwOXhsWnVYclNxWDBoM01hazJMWWt1QVp4?=
 =?utf-8?B?dHRWRlR6NTNOVW1LVzdneWh3bHRJYUZ3b05rdit5ekJpMTVPM3llcGhMMnFC?=
 =?utf-8?B?UzVmM3IvSFhUa2tFQnZ2MnpqYkdwWEYyNFY5bjBzRVdpa2toUXRYSmorYm1r?=
 =?utf-8?B?czRINmtwN2R2RE1KcVlHNHNXbFlwbXc5SDdZVHA5S0F1dFVKKzRMYmIydm9h?=
 =?utf-8?B?N0ZzQjdEL0pIVWVhVzY0MUNZMXN0eFhjY3ZvQmZ3SExuSUQrV0FVSEdZWGxE?=
 =?utf-8?B?V2NHazF4bWJSUDBzV2gwcFA1blV4ZDBXY0dtTnJkTm9GZ0Y2UEZIeVR1S0Y2?=
 =?utf-8?B?aVIvL0hMTDhGWFEyUCs2Z2M2c2VWczlWSFZVWFFDVkdTNzZ4c2FTSEZENDJN?=
 =?utf-8?B?Zkg5dGpvOTU2dm1WUGFPMmVzdWc4K0RmQklvbkN5K0pENS9UNUdlL1ZwWFZp?=
 =?utf-8?B?a0xoY0RmVXFFYnJtakd2Mjg2V2RPK090dEMydnhxR1NQT2pqVWx5WHZZQXZY?=
 =?utf-8?B?TC9WdFNBcHM5R2hpOUtKbVJJY01mbjM1Q1I0cHcvd1NNaEtmVXZRa042TWNE?=
 =?utf-8?B?TzlZRXF6ek9taUZuK1lsMlduOGJLRmo5amFsQjRJSnMrMko5NS9yaE1wTVZq?=
 =?utf-8?B?RWx4R1BucURDN1JPcmx1TXFCNS9qY3J6eTd3Q0ZiOXl0bFYySHRjbE9oUUs5?=
 =?utf-8?B?MkQ4N1pZdmN0M20vNS9XMHBNWW80SEhWOXZuWU1XcUNNblJMc1NvbW9MSVZz?=
 =?utf-8?B?SkxVZ3FsSWRoL0pjekQrWTlhK0ZJSVVYZXdhTWdNeXdmM1ljeTJ5ZkNqZWFo?=
 =?utf-8?B?clMxZkVXQnRYelFLSkFNVmRxcnlIRzcrMzNMejZqZzJBanE4RGhvR3ZDYTJ6?=
 =?utf-8?B?UXFTclVtUkc2M3pYemUrUDdMbHcyK3BYTWRKdXlWRGtpdGxTU09SL1NkV0s2?=
 =?utf-8?B?OXJoQ25EOUNWaWxLSWM2dkgvUjJtb1d0ZjNCUkk5b2o1WTgyc3NhVE43QjJT?=
 =?utf-8?B?a0RBSUE4L1N0ZzhZTjdhdUtucjJZL09xRHI5Z0xQWVFvWmErRzM0VlN5SENu?=
 =?utf-8?B?VzhFYytheHFnMk9nMHFPQkNhaEVKMEhTNEJZZlB6WUh5MDEwZ0pvemRlakFr?=
 =?utf-8?B?ZHBpZTJiS1ppQXNFNEtBRXNnUVh1ZHNGL3JpSis2UEhIcXJvYzlEVUozWGNt?=
 =?utf-8?B?TS9iQ0habkZ0eGs1RTlJcWpxVXV0aW45K1hHeGFGWDJKcjF4UUc4dFY3TEhL?=
 =?utf-8?B?MDN1cGVGaGlLZDRkN3JldzNWbHVucVByd1ljSUhZOWQzcUVvaWZHYjVBbEFM?=
 =?utf-8?Q?hExiq+TkwMjS83Cu2blVHiiBt?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a78f968a-d67d-49fa-c261-08dca4ad9678
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5624.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 09:07:44.2351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pLV8bq80bY0l5qxLnCHk4EFDEaQslHHnXMwMWaUppjAV4BebgZvGv4+xjMj4/5Q21w7ZI/ITpXxkisPIPWlx+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5650


On 2024/7/11 22:25, Christian König wrote:
> Am 10.07.24 um 18:34 schrieb T.J. Mercier:
>> On Wed, Jul 10, 2024 at 8:08 AM Lei Liu <liulei.rjpt@vivo.com> wrote:
>>> on 2024/7/10 22:48, Christian König wrote:
>>>> Am 10.07.24 um 16:35 schrieb Lei Liu:
>>>>> on 2024/7/10 22:14, Christian König wrote:
>>>>>> Am 10.07.24 um 15:57 schrieb Lei Liu:
>>>>>>> Use vm_insert_page to establish a mapping for the memory allocated
>>>>>>> by dmabuf, thus supporting direct I/O read and write; and fix the
>>>>>>> issue of incorrect memory statistics after mapping dmabuf memory.
>>>>>> Well big NAK to that! Direct I/O is intentionally disabled on 
>>>>>> DMA-bufs.
>>>>> Hello! Could you explain why direct_io is disabled on DMABUF? Is
>>>>> there any historical reason for this?
>>>> It's basically one of the most fundamental design decision of DMA-Buf.
>>>> The attachment/map/fence model DMA-buf uses is not really compatible
>>>> with direct I/O on the underlying pages.
>>> Thank you! Is there any related documentation on this? I would like to
>>> understand and learn more about the fundamental reasons for the lack of
>>> support.
>> Hi Lei and Christian,
>>
>> This is now the third request I've seen from three different companies
>> who are interested in this,
>
> Yeah, completely agree. This is a re-occurring pattern :)
>
> Maybe we should document the preferred solution for that.
>
>> but the others are not for reasons of read
>> performance that you mention in the commit message on your first
>> patch. Someone else at Google ran a comparison between a normal read()
>> and a direct I/O read() into a preallocated user buffer and found that
>> with large readahead (16 MB) the throughput can actually be slightly
>> higher than direct I/O. If you have concerns about read performance,
>> have you tried increasing the readahead size?
>>
>> The other motivation is to load a gajillion byte file from disk into a
>> dmabuf without evicting the entire contents of pagecache while doing
>> so. Something like this (which does not currently work because read()
>> tries to GUP on the dmabuf memory as you mention):
>>
>> static int dmabuf_heap_alloc(int heap_fd, size_t len)
>> {
>>      struct dma_heap_allocation_data data = {
>>          .len = len,
>>          .fd = 0,
>>          .fd_flags = O_RDWR | O_CLOEXEC,
>>          .heap_flags = 0,
>>      };
>>      int ret = ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, &data);
>>      if (ret < 0)
>>          return ret;
>>      return data.fd;
>> }
>>
>> int main(int, char **argv)
>> {
>>          const char *file_path = argv[1];
>>          printf("File: %s\n", file_path);
>>          int file_fd = open(file_path, O_RDONLY | O_DIRECT);
>>
>>          struct stat st;
>>          stat(file_path, &st);
>>          ssize_t file_size = st.st_size;
>>          ssize_t aligned_size = (file_size + 4095) & ~4095;
>>
>>          printf("File size: %zd Aligned size: %zd\n", file_size, 
>> aligned_size);
>>          int heap_fd = open("/dev/dma_heap/system", O_RDONLY);
>>          int dmabuf_fd = dmabuf_heap_alloc(heap_fd, aligned_size);
>>
>>          void *vm = mmap(nullptr, aligned_size, PROT_READ | PROT_WRITE,
>> MAP_SHARED, dmabuf_fd, 0);
>>          printf("VM at 0x%lx\n", (unsigned long)vm);
>>
>>          dma_buf_sync sync_flags { DMA_BUF_SYNC_START |
>> DMA_BUF_SYNC_READ | DMA_BUF_SYNC_WRITE };
>>          ioctl(dmabuf_fd, DMA_BUF_IOCTL_SYNC, &sync_flags);
>>
>>          ssize_t rc = read(file_fd, vm, file_size);
>>          printf("Read: %zd %s\n", rc, rc < 0 ? strerror(errno) : "");
>>
>>          sync_flags.flags = DMA_BUF_SYNC_END | DMA_BUF_SYNC_READ |
>> DMA_BUF_SYNC_WRITE;
>>          ioctl(dmabuf_fd, DMA_BUF_IOCTL_SYNC, &sync_flags);
>> }
>>
>> Or replace the mmap() + read() with sendfile().
>
> Or copy_file_range(). That's pretty much exactly what I suggested on 
> the other mail thread around that topic as well.

Thank you for your suggestion. I will study the method you suggested 
with Yang. Using copy_file_range() might be a good solution approach.

Regards,
Lei Liu.

>
>> So I would also like to see the above code (or something else similar)
>> be able to work and I understand some of the reasons why it currently
>> does not, but I don't understand why we should actively prevent this
>> type of behavior entirely.
>
> +1
>
> Regards,
> Christian.
>
>>
>> Best,
>> T.J.
>>
>>
>>
>>
>>
>>
>>
>>
>>>>>> We already discussed enforcing that in the DMA-buf framework and
>>>>>> this patch probably means that we should really do that.
>>>>>>
>>>>>> Regards,
>>>>>> Christian.
>>>>> Thank you for your response. With the application of AI large model
>>>>> edgeification, we urgently need support for direct_io on DMABUF to
>>>>> read some very large files. Do you have any new solutions or plans
>>>>> for this?
>>>> We have seen similar projects over the years and all of those turned
>>>> out to be complete shipwrecks.
>>>>
>>>> There is currently a patch set under discussion to give the network
>>>> subsystem DMA-buf support. If you are interest in network direct I/O
>>>> that could help.
>>> Is there a related introduction link for this patch?
>>>
>>>> Additional to that a lot of GPU drivers support userptr usages, e.g.
>>>> to import malloced memory into the GPU driver. You can then also do
>>>> direct I/O on that malloced memory and the kernel will enforce correct
>>>> handling with the GPU driver through MMU notifiers.
>>>>
>>>> But as far as I know a general DMA-buf based solution isn't possible.
>>> 1.The reason we need to use DMABUF memory here is that we need to share
>>> memory between the CPU and APU. Currently, only DMABUF memory is
>>> suitable for this purpose. Additionally, we need to read very large 
>>> files.
>>>
>>> 2. Are there any other solutions for this? Also, do you have any plans
>>> to support direct_io for DMABUF memory in the future?
>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> Regards,
>>>>> Lei Liu.
>>>>>
>>>>>>> Lei Liu (2):
>>>>>>>     mm: dmabuf_direct_io: Support direct_io for memory allocated by
>>>>>>> dmabuf
>>>>>>>     mm: dmabuf_direct_io: Fix memory statistics error for dmabuf
>>>>>>> allocated
>>>>>>>       memory with direct_io support
>>>>>>>
>>>>>>>    drivers/dma-buf/heaps/system_heap.c |  5 +++--
>>>>>>>    fs/proc/task_mmu.c                  |  8 +++++++-
>>>>>>>    include/linux/mm.h                  |  1 +
>>>>>>>    mm/memory.c                         | 15 ++++++++++-----
>>>>>>>    mm/rmap.c                           |  9 +++++----
>>>>>>>    5 files changed, 26 insertions(+), 12 deletions(-)
>>>>>>>
>

