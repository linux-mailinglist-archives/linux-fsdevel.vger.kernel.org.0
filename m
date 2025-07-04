Return-Path: <linux-fsdevel+bounces-53956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7F2AF90D2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 12:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7673F167E63
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 10:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E132EA72F;
	Fri,  4 Jul 2025 10:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="x2SgVYZ1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327FB20C00B;
	Fri,  4 Jul 2025 10:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751625691; cv=fail; b=fcbzfKqvIFgIHnanBe5/jic+wLH63ZCcEcX0eyZXdc330DXHGdt5EbHKcLFXkIhmv0yGkAIZhtwMKThpjBSy4TYkLJR36L9NBBltqSry/ee1QRESayVmOGo+cFNcGlcavnNNo6WzOeXBFGgfXEcozZB+XXtokgJwY+455D64xYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751625691; c=relaxed/simple;
	bh=akbp5+UdU2FW3Bo479NqH76/3egoKE0KrP+5QYI+WvE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JU+PnmUNGRcdIpCIcHDSZraxU0aQOYuOVLnOzwvYxHP78N4LwEWwM/2QHYvd71BlV6wpq4ulp5QqszGi2Uhuz7ylDiZBrBk/JK72H2UGVVP79CquNro0QuP0VLdY7tJ/+XgzjNz928HDZf3Z/xgt4QvwR3i+MGw7rmevLKIl1Qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=x2SgVYZ1; arc=fail smtp.client-ip=40.107.220.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U2vbEOb36JlqhMHp1KyveR7H96Y4TPyK07gu8zsX9Ru/UUV1idp8YTxTKqipikuuymSH8Z13CZCQWGZfp6XPrHKm72g377cWKrglz2Spjqik1U7Z69jmqqfg40jNQQHQi8eh3o64ek4SlkHGS+CiuYrmqC2mpM4gohHUBglwMtGqWXBqgFoARUrwpEAzAN5CXgrfRfGD51XbN6r+jyNjzXiw213po/gG5hfXZhDkUwysGxWIMUN0otVyTfHmmXHmgON18LWWnNoCeUH5+utm9CtV6NiWoamgUgnvnTVTw/4Qt5QkZBWyYVrb70fqFHTIOqsKJG5Jnoe6fORPM1Vu/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJwuPJmWTTV5cLBJxplctMGHYYyVy9wpGMoKBhgyYB0=;
 b=TUG8u6T1QP68csvhfrohU0d9FAqagM8qx4swtdq2WDI4UpZLqJ36XdCogBAw7bs11IQTT++kwCU4ZQY/QVECGCPX/qsZH+WJdryx3yv3JJUcPWhCAvxUUfolLEiDwEB4/oPE3qzVQExS/Sp52cRsEj2vDGkUJ0RS+sTwkTOzPK8gbsdspjOmwX1NEKhpf8kni6FGPKUgIGF1gaMBO09jdSmBtVOOcgMTYw/tVudro8K4w/bAKxXkK+quV+EZG9YxT+/GCOCFrF03j2NqMkG/M4aBK5ywYI6m1OCjLGN2zF/QdMT0U511SRuLtxUXIT7QT/EfL8LTCVCPHGe25mPKxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJwuPJmWTTV5cLBJxplctMGHYYyVy9wpGMoKBhgyYB0=;
 b=x2SgVYZ1lwULja6k7i3iocGs49yFGHK2ZL2Gebb79FOQGWWs8Tk1p11G8XKDZplhNBURuNBQW0G5ost0GxgqZ/QsOl5Tv1/9iw+ok31HqDWCfgvTt6PVW5BMFD9bEBIY0yF9WYrbx2J0Ss3bqYoKABm+9/y4jY7Jl7BLNFu/5tc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9aa) by DM4PR12MB5866.namprd12.prod.outlook.com
 (2603:10b6:8:65::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Fri, 4 Jul
 2025 10:41:28 +0000
Received: from SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 ([fe80::40bb:ae48:4c30:c3bf]) by SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 ([fe80::40bb:ae48:4c30:c3bf%8]) with mapi id 15.20.8722.031; Fri, 4 Jul 2025
 10:41:27 +0000
Message-ID: <67c40ef1-8d90-44c5-b071-b130a960ecc4@amd.com>
Date: Fri, 4 Jul 2025 16:11:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] fs: generalize anon_inode_make_secure_inode() and fix
 secretmem LSM bypass
To: Paul Moore <paul@paul-moore.com>, david@redhat.com,
 akpm@linux-foundation.org, brauner@kernel.org, rppt@kernel.org,
 viro@zeniv.linux.org.uk
Cc: seanjc@google.com, vbabka@suse.cz, willy@infradead.org,
 pbonzini@redhat.com, tabba@google.com, afranji@google.com,
 ackerleytng@google.com, jack@suse.cz, hch@infradead.org,
 cgzones@googlemail.com, ira.weiny@intel.com, roypat@amazon.co.uk,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20250626191425.9645-5-shivankg@amd.com>
 <a888364d0562815ca7e848b4d4f5b629@paul-moore.com>
Content-Language: en-US
From: Shivank Garg <shivankg@amd.com>
In-Reply-To: <a888364d0562815ca7e848b4d4f5b629@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0084.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26d::14) To SA5PPFF1E6547B5.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8ea)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPFF6E64BC2C:EE_|DM4PR12MB5866:EE_
X-MS-Office365-Filtering-Correlation-Id: 84aaf0b9-30c9-499a-5327-08ddbae753e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NFhidjYzQ2xva1ZCekF4Y1F4OFZibTFRMVIzOTY0cHlzMVpUUUg0c05Xcm9Y?=
 =?utf-8?B?RlZheTh6cmhPV05WdzlXakliY1pzelY5d1hHaFJDWWpFVlhQQ2ppanBiMzhD?=
 =?utf-8?B?V0t5MG5zRXdPQUQwN0xzNHhFc2ZxNHUyZGFZbm1TdmI1WHpYa3RLZlJnMGh4?=
 =?utf-8?B?d3dmd09BMEZTUHFrKzRpSXRGeXh0UnM2NEFCM1JacTBFUWgxUnhBNitUZ0Ry?=
 =?utf-8?B?Slk1SUJJZXlXTjJrS1pwbHQxT0pmUXU2TXpkWkVNUFdxZ3pGcURKYnhseVdS?=
 =?utf-8?B?U0g2Q2NzckE4WDNrOVM2Z3NiVE1JOHlRR3l0RjFhSEw0ZldhbnhXM1ozM0dn?=
 =?utf-8?B?OWFRVmg0UkpXZlhOV0JkZ05ZTnpXU0V5cE5leFBkaHJNTE5VLzRhbFl2Ymg2?=
 =?utf-8?B?WngwOWw5dC9FZ0R1T3BnaWk0UDZuZXhZSWQyb284VFcvVTJKZlRhckxSNmNt?=
 =?utf-8?B?NHB4aVB5QjA1VmZUeUJneXVvZzdYVDlUUjJGL3JRYVp2VjJ2bTRGN3lGWW9h?=
 =?utf-8?B?Y2c1clpqK0xnL0JKK3ZjNFN6NDM1SDJzREpuakp2bkJBMHloYUNIZGowOVdT?=
 =?utf-8?B?d3E3YktpNmJMcXpqcmhmd0E3bTZBVzBkL1J1ZERZWFF3V0lIVzdIUWltZHQr?=
 =?utf-8?B?Q1gyUGpHc3YvS2ZrVlVlelFWZ1BHbW5uU29jTmhKTzgxN0NXOVZ1ZExaSHV2?=
 =?utf-8?B?S0E1Z0ExZGFDcnUyWEdTVTBBdy9tQmhnOU5wOVFrUUxoMkN1SWtZbStXZjZO?=
 =?utf-8?B?Q1d6VzdmMEhCUlIzZHdXNVR1WUZyRmJyYnpwcWkyeFhxZUVsaFlaaCtXU1Vl?=
 =?utf-8?B?d051R0FLTTI1SGg0ZFNiN2xHMWlpbXAvNGJISkxoYmNlYlJzNkFsdUY0Z0U0?=
 =?utf-8?B?cTF6K0hBamlXUHJQd2NHeVdXSFphRFd6amRIWWtTbFJIS25xOVJCZndaNFov?=
 =?utf-8?B?WGt5THFzcnJxNW4yRnc0Z0FkdTFndUQ4aFNuVlZmNnA1Y0JXUUdobVBCKzlh?=
 =?utf-8?B?ekhJdUFaU2szQkJZZ3BGSUUrWjRoUFRSbmxMR1BYVWdJcFZYbERIdCtZWERB?=
 =?utf-8?B?M0IvSmI0VzFwYnVtR3IybGZQM2EzV2xrRDhBMFpMRWh5S3NLN0ZHVFF0cEJU?=
 =?utf-8?B?QmYwS05LSHJzQmtqcnIzdzRMVkdZOERiSXRtS21jYjdaV2djT2ozWmdJNzZs?=
 =?utf-8?B?dEJ4TTJkMFhOSk1wakhoeDVZeVpNdnN4Qi9IMjQ0S25CcGJzNzNzcGhER0dr?=
 =?utf-8?B?NTVTUFNZejE0UTlKZlMyc3dVUHkrWFVESEo3U0UwWmV0N3Fja1doVFlvU1Uy?=
 =?utf-8?B?Q0crYVV3TnBvQzFhRWN0TFphVXhoemVQaDhHNnlvbGEwL1h3bzMyY1R1bFFs?=
 =?utf-8?B?ZWhoc1VMREFSN1BzcW1OcXBuOHI4amIxZ2F5ZlRZeG51OUQ5NWR1NnYyWGk1?=
 =?utf-8?B?bXNtOVN5Y2o2Y3Y0d2ZqeWtJZ0dNeWNhNnZ6OGxjZXJKaUI0bllXWFZnMHVV?=
 =?utf-8?B?RzAvdWU1dkhrYmlNVGcyTkJ1SXE4Zmo0QVRwMVU1WUxkeDcxcGJNVDIrMmNn?=
 =?utf-8?B?SWs4QWxDNExJRTVVckhTQTNsbVJGa1ZnaXRnUGRCK1p5ZEZhYjdZelloaE1P?=
 =?utf-8?B?ZWlMSGJmZzZHZG1uWEFVdmhiaFBBcDBUeWx4ZnF0dkVyckIxQzJ4N2tGdGEr?=
 =?utf-8?B?MkZUMCtiVlNoUmphRXM1b25vQThLZDIvQ3RROERMTW1OV1hjMC9KcFZGQWFk?=
 =?utf-8?B?c1R5S29PUHpMQU9yU3NKWnN2Q1NGL1pIT3R0bmFoNEROdUtrWUlRTXJaR1Zo?=
 =?utf-8?B?MVpXYnptYm1FWVI3RTJROGpTaFkxaEJiejVUUm44OERteGpSbkF1Z3FhdUZE?=
 =?utf-8?B?Z0dUY2w2RkFuYldtRWlJUUFMMWRHMlFYU1hvcjFObTBOSjdpb3JSSkUyMmRS?=
 =?utf-8?Q?b/vhC4egp9k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPFF6E64BC2C.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHEycWVBVUhTSlFmZDVvOFlmbCsrTjdBL1lib09Dc2gwZDlML2t5MjRWNDR0?=
 =?utf-8?B?TTZIdzR0QXNpb0U4M2I0TXUrS1k2cmx3MC9ybmp6L1ZrVzJWOU5vNWFESVND?=
 =?utf-8?B?bVdQSEFYTlRhQVlUbnRZV3YrNnR1QnpwRWdSWXgzVlE1SXpVaVJlU1BQSGxN?=
 =?utf-8?B?L21sa29UTnFIdFlBRXBkeXJIZG5ZbkhQRGNwVlhYaDVtSGszZmlRemZONU5j?=
 =?utf-8?B?RTVQWitxbTVCekUvRVdrV0txSkR4WUZJWjlxQzNzVzA1Y29TcWJid1IvcU5S?=
 =?utf-8?B?Z1lJRFR4VTkybDNNZTdzR2JVR3RiNW4rVE1ocG1OWnZFN2lqeTZnZ0s2eHpJ?=
 =?utf-8?B?dGltT2NpVHpyS1lQVTQ2RWlJb1NlTkppaTJ4engydmRDL01NUlAremxJWUpB?=
 =?utf-8?B?cXNzNXR1UmRyVmw1Q055ekduWFlCRDlFYXNMWFJ2VHdlQUpMdk50NUFueWt2?=
 =?utf-8?B?QW1iWXpTUVh4TXJtNUNVSHZaNU5UOFd6T3RUWjc1akJRNkUyNUxsL01wL05t?=
 =?utf-8?B?N290Q203MTUrTHFrV1BZSmJWaExoNkxYNkF1VjZua2lQNjVjSXVaaUdQMXdU?=
 =?utf-8?B?Ujd2VjhGVmZpZTJUcmcwWnlsb3dKYkFYVGkrcVMySUdTODdCK2JFdHRWNVl5?=
 =?utf-8?B?cHNWM0tFejVYdVdDcXdWMzdyanJ5d2F4aUhFVE9UOXJFam9WV2xHWDZFbG9k?=
 =?utf-8?B?NDBzUnhkVDFYRVZOckk0amxEYzZNeWkrNVdETXJFeFozMEhTSy9PQ3RJbUs4?=
 =?utf-8?B?M2l0SFBUODNvYUliT1hyZ3hnV1h4VXV3dFQweHZMZnlUa1c4M1Q1c2pXUGF3?=
 =?utf-8?B?MERzMFpqemdVVG8zdndkRk9haFZCK2N6cmdHNVVzZGp4emhsS1JHeWdhSlJl?=
 =?utf-8?B?NTEvcytNeFg0RmVSRkdYd2VYVE9sWGJGb0xsNjZmT21UOW9VLzV3QTZ3ZUhz?=
 =?utf-8?B?dENzRFZoR2cyYjlWc1pYd2lVeHJVUiswd2dSblBqa3lGcGNmYSsvTnVXZkxy?=
 =?utf-8?B?RzU3ZXZhRUVqaU9mb1lZakM5WGVoTkRVTnVybXpjcnpVTjh1RUV0Znd2azgv?=
 =?utf-8?B?V1FHSWNHanNBQUZPOEkraHp0T2dUSjR5czJXTFFzT0dXYzhlS1B0TnNiMDZG?=
 =?utf-8?B?Q1F2MWZ5L2xBenRsNEJlYS9keFdEUUJzTjlKVjJGMGNOdkdwenlxS1hTWEJi?=
 =?utf-8?B?U0JtcFVSWnpMdXVzajZxVlB2MVdkNUNrNmUveFFFbElVeWN3Rkhtdi84UlZh?=
 =?utf-8?B?Vlk5T0xaVDZhajc1aHBUbTNpY3JLdzdSUjRJMHNuQjkwQ3AxYmpoeTBVNjJ0?=
 =?utf-8?B?OE9mQ1d3OTEvVGpYeVFJaFgvV2U2RFZPRUFMQVRKaXJaYnZiUExYS2tYUFBB?=
 =?utf-8?B?VDRUK0xZMm85T0dhMFh5cFVDZ1Vzc0s0blpKVERVMTRQcGM1RmxWMUZHcEcr?=
 =?utf-8?B?RE9EZDVwSEpZOWZsdWJuL3hSMnF3QUo5QkdIeUhNK2ZCREdGdlJNNi9HUXdM?=
 =?utf-8?B?V1dVZjBQTUZMSWpYT0hKRVVzK2ppdnlONno4Zkpaako0WWVDRHVHVzlrVzNv?=
 =?utf-8?B?UDVnOTZwbi9NTHZud2V0VmxvbkJSeUhCWktvejFlbzFoa0NCVGNuU2ExU3lo?=
 =?utf-8?B?c0l4VmQ3MldrN0d3ckxXMUJHWVBTMTdaZXdBT2pBdHVEN2N6MWhJYjQ3bHBH?=
 =?utf-8?B?eHF0L3NuTmNQTVdCT0h2MHQ3Y0IvSHhMK1ZRcEw2OEhIeWgwc1N5dlRRUTdq?=
 =?utf-8?B?MzczZjl5eVZGS3RBVW13bG1RT2plVVNaVFo4MHFHY3JXdVZOVVJWdG1SUnpM?=
 =?utf-8?B?UDNSTVJwSXdGTXZYUUhnbi9yUWNSSE5IUXNsT0hYWHBEcmJqNDAvWkJvTkk0?=
 =?utf-8?B?Y1dMdThHalEyYVRjL2RoaS8xQ1ZTdlFjdUduR0U2ZFpua0p4SUxrSTg0ZTh6?=
 =?utf-8?B?ZTM5S01EcEtXNmhRZGU3RnkrMEM4MGkzZndRcy82QzdzNTFVTUtrTVZwVnFp?=
 =?utf-8?B?M2c3K05BQjhoT1JRVDVwUzZkK0wwZmxBMkVzOGdYL0tIWXlDZDlSYkd4VDFr?=
 =?utf-8?B?Y0FTbW9QaW9xTTgxSVZjd2FIMk1UdnJLWHBsUEJwdCsrUUxva1lIczlORE9B?=
 =?utf-8?Q?oc+so9vtQNhOFy0h0G5oDQR7r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84aaf0b9-30c9-499a-5327-08ddbae753e5
X-MS-Exchange-CrossTenant-AuthSource: SA5PPFF1E6547B5.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 10:41:27.6989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uqf4nUg5UHBbBXNySsH40k2lE4AQlyWsDviNL9QBoFXYtyxDRkhZQF3QMQL7mAwmt/RLnUukd5BQMbAYEBZPjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5866



On 7/3/2025 7:43 AM, Paul Moore wrote:
> On Jun 26, 2025 Shivank Garg <shivankg@amd.com> wrote:
>
...
> Thanks again for your continued work on this!  I think the patch looks
> pretty reasonable, but it would be good to hear a bit about how you've
> tested this before ACK'ing the patch.  For example, have you tested this
> against any of the LSMs which provide anonymous inode support?
> 
> At the very least, the selinux-testsuite has a basic secretmem test, it
> would be good to know if the test passes with this patch or if any
> additional work is needed to ensure compatibility.
> 
> https://github.com/SELinuxProject/selinux-testsuite

Hi Paul,

Thank you for pointing me to the selinux-testsuite. I wasn't sure how to properly
test this patch, so your guidance was very helpful.

With the current test policy (test_secretmem.te), I initially encountered the following failures:

~/selinux-testsuite/tests/secretmem# ./test
memfd_secret() failed:  Permission denied
1..6
memfd_secret() failed:  Permission denied
ok 1
ftruncate failed:  Permission denied
unable to mmap secret memory:  Permission denied
not ok 2
#   Failed test at ./test line 23.
ftruncate failed:  Permission denied
unable to mmap secret memory:  Permission denied
ok 3
ftruncate failed:  Permission denied
unable to mmap secret memory:  Permission denied
ok 4
memfd_secret() failed:  Permission denied
ok 5
ftruncate failed:  Permission denied
unable to mmap secret memory:  Permission denied
not ok 6
#   Failed test at ./test line 37.
# Looks like you failed 2 tests of 6.

Using ausearch -m avc, I found denials for create, write, map. For instance:
 avc:  denied  { create } for  pid=11956 comm="secretmem" anonclass=[secretmem] 
...

To resolve this, I updated test_secretmem.te to add additional required
permissions {create, read, write, map}
With this change, all tests now pass successfully:

diff --git a/policy/test_secretmem.te b/policy/test_secretmem.te
index 357f41d..4cce076 100644
--- a/policy/test_secretmem.te
+++ b/policy/test_secretmem.te
@@ -13,12 +13,12 @@ testsuite_domain_type_minimal(test_nocreate_secretmem_t)
 # Domain allowed to create secret memory with the own domain type
 type test_create_secretmem_t;
 testsuite_domain_type_minimal(test_create_secretmem_t)
-allow test_create_secretmem_t self:anon_inode create;
+allow test_create_secretmem_t self:anon_inode { create read write map };

 # Domain allowed to create secret memory with the own domain type and allowed to map WX
 type test_create_wx_secretmem_t;
 testsuite_domain_type_minimal(test_create_wx_secretmem_t)
-allow test_create_wx_secretmem_t self:anon_inode create;
+allow test_create_wx_secretmem_t self:anon_inode { create read write map };
 allow test_create_wx_secretmem_t self:process execmem;

 # Domain not allowed to create secret memory via a type transition to a private type
@@ -30,4 +30,4 @@ type_transition test_nocreate_transition_secretmem_t test_nocreate_transition_se
 type test_create_transition_secretmem_t;
 testsuite_domain_type_minimal(test_create_transition_secretmem_t)
 type_transition test_create_transition_secretmem_t test_create_transition_secretmem_t:anon_inode test_secretmem_inode_t "[secretmem]";
-allow test_create_transition_secretmem_t test_secretmem_inode_t:anon_inode create;
+allow test_create_transition_secretmem_t test_secretmem_inode_t:anon_inode { create read write map };

Does this approach look correct to you? Please let me know if my understanding
makes sense and what should be my next step for patch.

Thanks,
Shivank

