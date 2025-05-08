Return-Path: <linux-fsdevel+bounces-48500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A75FAB03AF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 21:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FE601C20722
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 19:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C0421C19E;
	Thu,  8 May 2025 19:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F5QpGXRX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2083.outbound.protection.outlook.com [40.107.100.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED79D229B16
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 May 2025 19:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746732619; cv=fail; b=pNIVZUH8Y0tR4n0DQMaCH9YX219lZEWb+gU7tVhAsglT3S9eRpuuTrlA/ch2PjDG+S01QbbYHYEXp3obm6dQ09qrZN58XiswZOxwsR+j/osZlvUnQSAKaQ09yPzCVNoM9ez2HzbjhM0/fIHwmDclr05DrEn3VQ7NC++ixd10vNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746732619; c=relaxed/simple;
	bh=Jh/ckjKgbmum4Advldd50uW4wUwdgbDd3BD2ZruHTPc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OhCXodRwNLxGqVQCI3hYtRfGwDSBn5yFTZKJrlbeglJYPA8zuHnf0SzFOpdb2OlklbGGbhaLHNpWfo1HjNSSE89GyM4/oHId2wJuTkqtTtNZljqCL0L5RZyBsdxrfY6IB9l5p3NZw71okTomDsNDaI+JYy5Y/qQrSJupFAXyS1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F5QpGXRX; arc=fail smtp.client-ip=40.107.100.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sYlUZd4OphVKzeR29dOcFTJ/mMYqs8OdONO5iD6e/N9hN7PiainRgNIbLNB74s1NPO/okDHLaRPQOYiT9r2skSyV66izhR0uTMRcrAYtbyumkSAVEdtYeUn/Ul1yyKPMMuW8N6gSUlIJheU/ZNVOzF2tOR0I84VQtYA+WB4ECw5A7zH8rpvIEtp/s797kiV7jq87cocGpjfPmYgQdVAT3pwU+CUVRib4W+s1UnoW54i/86b1A7P/FbqQHafaAf5BfEELXmObsJGdBsWngc2Pz+Qh/X3RAZeV7DzCIXYIInVcRDXNKmzhPSz0UH/r7ORwwUGZVEXwqAwpBtqnbfOU+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WOR18wBaKUZk3gTuB7o1XnkPvT3Q1QG5DXxngHiGHoE=;
 b=XRVa4KKKPxkjkuDNH7GcFZf2Am87CdLd2Wl6g58X7Cxe+N8jftSBHiCdnQeuVpC6H7SuHuGZOy6Gp/dOM8/OuC/t+q3/WY9lzUzdIkkMQUASp4oNSBFcA5RVCm6urnH7kSffpk2i6A67uuuW/xrdKTZvK6VrfVFQevqERI5SHA1mynOIFKur+oG6Iob1SHfEEToQzTyjKhhF7lOCx0bgI5jd9EbSVIvmPcdEuQ4vwg9aSMSbETUyehZAjx5XONpQtJ8z9YJ5MPSrw1RLI77xLNrG3hzKMDucqx5ClrJs/s78iANnQnHAtkcPVIv25GquCmEj0ixcErO7GsDPQgCP1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOR18wBaKUZk3gTuB7o1XnkPvT3Q1QG5DXxngHiGHoE=;
 b=F5QpGXRXCR3rorRc4oy+BwfjPOQ4zDnKvE+MSWIv+hEX33iLrc+qQ4O+iqgJio3mUE2UWqRO88l3oPOoEdmKQ+vkV9dsxconSYl1XR2hdNS2H+KNCUK2u8r6HbDpl8gLGFXaEugN1VF66LnWCYEpx8XRwg/O2pc5wZMr84Y4F9ZW9TEm+4l2e9B7HdnepKLY26IM7eJ0XZAhhAf4/Bj4crRNUzAbtSL17xuQfO677Vcvb3Jhn4sMMnPMpuuPAGe6HsCW6vMrekQ+3Eyh0w+70yJW8mI1336DNOxKG+cgxYWwLKvYdTKGsZzZTbV16rau1Es/cLxtSWZTb9+33A2faQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by IA0PR12MB8894.namprd12.prod.outlook.com (2603:10b6:208:483::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.24; Thu, 8 May
 2025 19:30:10 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%7]) with mapi id 15.20.8722.021; Thu, 8 May 2025
 19:30:10 +0000
Message-ID: <3919219e-9678-46b8-a6bc-c83ccdf82400@nvidia.com>
Date: Thu, 8 May 2025 12:30:09 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] selftests/fs/statmount: build with tools include dir
To: Amir Goldstein <amir73il@gmail.com>,
 Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>
References: <20250507204302.460913-1-amir73il@gmail.com>
 <20250507204302.460913-3-amir73il@gmail.com>
 <ad3c6713-1b4b-47e4-983b-d5f3903de4d0@nvidia.com>
 <CAOQ4uxin2B+wieUaAj=CeyEn4Z0xGUvBj5yOawKiuqPp+geSGg@mail.gmail.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CAOQ4uxin2B+wieUaAj=CeyEn4Z0xGUvBj5yOawKiuqPp+geSGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0045.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::20) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|IA0PR12MB8894:EE_
X-MS-Office365-Filtering-Correlation-Id: 45c2c15b-e639-4f32-44af-08dd8e66bf4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TDZTbEo1WFZVWFdKSkRxK0Z5MEFyazVhSDRLeURrMVpyUUcxZWxSaWZQQWFl?=
 =?utf-8?B?TitoTUdHU3d0RXZQSEREQlZyZkFhSkt4UFd3dlhwVW5KaDZtRlpFTlJibllI?=
 =?utf-8?B?QXZ2eFRXdTZrK212UEtBTURxR1psS21ZTE1jRURTaUIxNW9IdDdwME1PdDBQ?=
 =?utf-8?B?MVNuYTBBMS82a0hXMVdFMUtTSThRYjlEUnl1OVJaWDhJUEE5MHR6dm84U3Z6?=
 =?utf-8?B?dDZTNzR4SDdPZWlKN21rczd2NVJBeWxwZXF6cXkzVkcvVjhnaUF3UUVyMW1j?=
 =?utf-8?B?UUlVMWd6STRsLzVrd2JubXdIdCtaUVZvWEFMT3dsSzBPSFdCbG9IYzloS0dP?=
 =?utf-8?B?RktobE1WdVlYbGkyZjd4OXBwVUlRV0dNOVN6MlpvSUpvTEJsYm9zY2VRYm5t?=
 =?utf-8?B?YlZOMnpzeDVZVElJUUZvbzhsNzdRMlUreUswVVY5MGlVcjJhN0VobkdQczR4?=
 =?utf-8?B?b2JUSkorZHVmOGMzSVVhNFpvdmtkVnFTT3dYclAvRG9JdjlNQnBLYXU3RnBT?=
 =?utf-8?B?bVZSbm9tbzNtcXRNZksreUNyRythcnlMZEdNa3p0Qm5kN0l3U1RLOVFPNjNZ?=
 =?utf-8?B?UUl6OENKL09MOE8vZnpSeVhzWHY5enljeEdadDNrV1h3VUxYTUFkQzhUK3RC?=
 =?utf-8?B?MmlxZU1BMlpxdzBXMVB4RUVEVWN0a1FHTjIyZFZUbFM2Vms1Z1JiejdSRFNU?=
 =?utf-8?B?eCs3UjRUSTFtR1RlS0FwVnBwN0R6eWNVWGFUYzdBU0piVGpxNUNYNWVIemhn?=
 =?utf-8?B?MDYxKzdsbnVPS2xTY2F5emE0bFNINzg5cGtES0hYNTBlZGtJQVJHSFVuOHFU?=
 =?utf-8?B?TFAxbHg3Yk12dlpkT21QSEhaNFo4T1FwUzdQTnFiV3Y0VjlCS2U2eEFpdVVH?=
 =?utf-8?B?TEdhVytIMC9EblJKREc3MC8ydXRDQ3BZc1FiSFdRRDlQVXlPN1BZeHd4c3Ft?=
 =?utf-8?B?VEdZQzNnRlNFUVFvcmlkcEU1MzhOVzJBNGtvbGMwUG5McGlyVEEyY2JpY1ll?=
 =?utf-8?B?L0MwbnZ5ODJGQnM5dkJWNkZEbTVUYSt6NVZaRnBEckhqNFhRMUI4RnRYVlJZ?=
 =?utf-8?B?KzEzWHZYWVNZOWgybXpRTGVTRFIrRzgwMXFCU0VXZ0hTSE1CNTFzSUNUbzBJ?=
 =?utf-8?B?Y09CdUt1U0xkY1JNdnJiYXBpbk51RG52dGhScE0xbE9nOTd0cVhXK0ptQ2Ex?=
 =?utf-8?B?QlZiaHlXbjFXVnFtNTh1TDkwUDBna01uSFZicEFkOHFjSjVwLzBLWUJHaFQ3?=
 =?utf-8?B?NTZMcHc3VHAyd28zTUMzVng1MzhvU0tTUjE3UFo4bisrdStkVGtOMHByZkxk?=
 =?utf-8?B?UlFHT3hUL0sxVTV1L3RhYkpnd2dtbWRva2xUWnRMMWJxKzFWWG9NSXdLcEZQ?=
 =?utf-8?B?UkY4cHNpd0RyZU8rWDZJQTdvRTJMVkp2L0IwQjJhK0JCWGtlOGV4bDFhS3lY?=
 =?utf-8?B?YkdSVEtrU1VYdGY2cGNjT1ZYc1NrS0F2cXY2YXZERWhxbTEvdTZ0bDJ5aW5p?=
 =?utf-8?B?ZEYyZkM2NjhqMDRnVzhiWVhZWjVqUHJDdlROQWV0blg0NkdzbTROcmNWeDFt?=
 =?utf-8?B?T2Ntd0hmMWp2WmlTa244Rm53cFRuQmxSY2NLcmIwK25KTHZDbG5DbUoyZHdw?=
 =?utf-8?B?cUE5M0poVVhLdFJ5ZkxjT1U1MjFVL0hsVTRHeWlmTjYzRHM5L3F6V0pkYjYv?=
 =?utf-8?B?WFBQQ3loUGZnSWQ1Z1BNV0p3dGJLSzJwcmxqS3BEY2xuanlQZVNOUURCak9N?=
 =?utf-8?B?Y2VlNnhEb25vQm53Tnp0TzQ2dTFiTTFJYzJLQitOK00zbndKVFI3OVNpOC9q?=
 =?utf-8?B?OFI0ZlBKaTlNajFwSzhSRnliaVZTVUhHQmlOc2VtNk1IUW83emVDSkZPK1dx?=
 =?utf-8?B?NStVZmY3d0xFTDVhQjFrMnNMbWhUNFl0MVZKUXZ5eHR3UVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0dFN21iNHVRYU1pR09UNEhNVUo0dnlQTHVRRFlvRnhpY0pKSFZRelhscmRp?=
 =?utf-8?B?Z1VRVEdQOU5mT3cxN1R5RUZudENYMjZaNHhyampBMjM2cEZwSVk0UUI4UDh1?=
 =?utf-8?B?L1dDdjNCb1A3VnZOTURIaU13R1pMRUpzWUErbUdXeDNzWEg2bEZqSnZXUG1z?=
 =?utf-8?B?ZGlmMEFBRzNpR2xrY0I3L3plMU1vNmFBSWZLc3JGcGtmRnAySXNSVmxRWkwr?=
 =?utf-8?B?SVRSOHBzb2hwS0NOYmJJWFFBOUNvMWVRTUYvaXdBcVdaa2hpenhwOTRvN2V4?=
 =?utf-8?B?S3R0dk5scWhxMjhpNjdtQm1LSXRwZDRGY1FpYWxLWksreHNXNnNrbzUwdmd5?=
 =?utf-8?B?Nlg5YmRtTmg5R1dRVnRRVy8wRUpleG9lTG1PM0t4VEFCWmx1cVVKbm80MWFS?=
 =?utf-8?B?ekNsd210QW4zdDNlRTU3cng0ZkRzbllvYStmSmZJS2J0bk0xU3FsdXFGTnEv?=
 =?utf-8?B?ZitFTEpYTVFMWEE2UVFSQjNVR1ZadE8wR1oyRFYrRGh5WVBsVUE4bE9GTVg4?=
 =?utf-8?B?UC9FRUhsQWpnOGhiWlBXVEErcEtKNXhpemh4cnFJR21GYzRadlpYL0JQazY1?=
 =?utf-8?B?REM2ZGZDazd1d2o1U3Axenc1cE85WXlyWEN1d3NBTnJjbTNxUTFLTGpDVjlZ?=
 =?utf-8?B?VlVVblpGS2xRbG81V0I2MXY0TmFHWm9GUk9OY2ZIRjQ4VStkaS9hVmwzZkR4?=
 =?utf-8?B?cmdLVk11OHdlQ3U4SjBMVDJjbzRIK0NTaW5SdjdSTDB4VWJSYWhRTXd3UUxQ?=
 =?utf-8?B?RWVSTHdobHJtcmtNaHNabGNNajFzalBZeUM0bE0rSkpMZHEzQkZ6S3k1OWoy?=
 =?utf-8?B?TC9MV1lpaTJXNk92WG5LbFlhd1JqTjJUKzVqY3FVTStpdjA0VHUxWEJBUTZh?=
 =?utf-8?B?RVpjZUd4Sm5yaWpzZGZOd1ZYVDVUQTNabUZMUjZ0SDZUaTRYd3pOSlFOSVcz?=
 =?utf-8?B?OXRKU1ZBbjhrMS9PSDlIWDNrUFlicXozcFNCT0ZsZkpwanhpU0ZvdmtoUzh3?=
 =?utf-8?B?ckJycU9wOU0wOFd3N0RtOWwwRzlvaGJiR2wreCsrN1JjSFNGTTRUSjRIcDBr?=
 =?utf-8?B?cFdsVzJaZnJmM3BCem1GMW16ZEIrbjZFOTltOHVXU0VtM2FDOElpNUc4ZUdK?=
 =?utf-8?B?YVVjWWhCdUpEK2hBKzNnQVJ1SUR0UER6MmVyR0w4R0h1SlpkRzVZaEVEdEFO?=
 =?utf-8?B?TEd4cy8yV0EwTzJEdDZoc1FLeXpOak40aXU1a2ZXNE1tTGJCd0RTVm0yOUls?=
 =?utf-8?B?QW5iYWZNQ3BrL0lVa2p2QnlLT3BhVEo1bWJ3MkhYcUVtQUdqRSs4TFdNSXQx?=
 =?utf-8?B?S3RLQzhnU0ZuWW8rYjltRG1LTVhoNG1vVlVZVSs2Zm5uSTBsbTZvL0VQdUFR?=
 =?utf-8?B?WDcwWVZqVGVEazgwalRqUjI4eFppQ1VndE1JWTFtYldWQ3R1em1wc3NXS0ZR?=
 =?utf-8?B?VzBVc3NKV3pDRndTdXVaSTJIL25IZFpTZ0ViZG5nQ1h2bzFwRWtJeStWNmJj?=
 =?utf-8?B?TUF0RVlJSnBKYW5rbTNSelJYdnNUVlgyamhiTCtoZS9tMCtqVE5OZVNoRld5?=
 =?utf-8?B?MWFaNFhPc2tKNTlrakcxcWVjWDhCcmlGSTg4a3hqejg3TEloL3FDcW5DWkF2?=
 =?utf-8?B?VjNUb0FkdlBkejM3Zk5uVE5wTG9KN2ZDUXJKNTZTeDNiUEZjZDF5d2pQTkhC?=
 =?utf-8?B?NHdVV1BmS0RrazZjR1MvNS9pT3hHaElNbWhYaEM2RDlSc2UweXdmVkRFZk1j?=
 =?utf-8?B?MHJqQkNXVlo3RnZRTmhXRE9aYzZ5Ky85YW1LSGx2OEowVTdrM0FjMzBzbTEy?=
 =?utf-8?B?Q1htb3FmdWpabHZPUnNBNTMzbVdFNHpVMU83MTdvOTV2MG9CblZobzBIck9t?=
 =?utf-8?B?SE5wakpMbnlDMWtFY1NaeGpIT08rNnpyME5QS3hMOHowZGNUejREZDF4MGlI?=
 =?utf-8?B?NjMyeHNaU1orK0twa1RrWHUzUkdNT0NwZnBCckt4Z2wwQktXMmttRDJ2bGNW?=
 =?utf-8?B?VzRwNnh3RGxsR3BXNkRYdGtsR0hZNmVkaml0K0hmQmpVZnZlWmRJb2J5TjZi?=
 =?utf-8?B?MEorWCt3MWRMYnVDWWJxKzFlMDBxNWMrak5BK2NXM1ZFOU4yVndpUWYwcTh6?=
 =?utf-8?Q?FRl9zvb6PexAhQ5coHhItKvn1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45c2c15b-e639-4f32-44af-08dd8e66bf4d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 19:30:10.6126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eNNTL3OQQ7TPeg97WtOCqnKeaCXhmHcxdxnrmmww2iOv33A8fxADfhlabs+gw+LM1sijGjPgGHyZMCqG9Yv+kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8894

On 5/8/25 4:36 AM, Amir Goldstein wrote:
> On Thu, May 8, 2025 at 9:31 AM John Hubbard <jhubbard@nvidia.com> wrote:
>> On 5/7/25 1:42 PM, Amir Goldstein wrote:
> ...
>> Yes, syscalls are the weak point for this approach, and the above is
>> reasonable, given the situation, which is: we are not set up to recreate
>> per-arch syscall tables for kselftests to use. But this does leave the
>> other big arch out in the cold: arm64.
>>
>> It's easy to add, though, if and when someone wants it.
> 
> I have no problem adding || defined(__arm64__)
> it's the same syscall numbers anyway.
> 
> Or I could do
> #if !defined(__alpha__) && !defined(_MIPS_SIM)
> 
> but I could not bring myself to do the re-definitions that Christian
> added in mount_setattr_test.c for
> __NR_mount_setattr, __NR_open_tree, __NR_move_mount
> 
> Note that there are stale definitions for __ia64__ in that file
> and the stale definition for __NR_move_mount is even wrong ;)
> 
> Christian,
> 
> How about moving the definitions from mount_setattr_test.c into wrappers.h
> and leaving only the common !defined(__alpha__) && !defined(_MIPS_SIM)
> case?
> 

By the way, is this approach possibly something that the larger kselftests
could use (not in this series, of course)? I recall most of them are doing
something that is x86-only, as well. And so if you have made some observations
about syscall numbers such as "only alpha and mips are different" (?), I
could definitely take that and run with it for the overall kselftests.

thanks,
-- 
John Hubbard


