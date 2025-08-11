Return-Path: <linux-fsdevel+bounces-57264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD05B2012E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 10:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1A5217D392
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 08:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558212DBF43;
	Mon, 11 Aug 2025 08:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WS7bzQRD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE986245033;
	Mon, 11 Aug 2025 08:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754899369; cv=fail; b=jdQCjCBR5vTSj7T3FxeT4goKIKvtIA0I2L+CxHDw0LXip+MqN1UFFf2NDWB+mjdL896BJCgy7zfaD/uJ9gU+LEaHd/8RrMN09/CbxC0l2huSGkKceUad2GIwbNluMi//yvxLE42iexKnd8xJ/zuqz76Sv30JgXlC+gzAbJMSoB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754899369; c=relaxed/simple;
	bh=063wlaLHZzg4fKu7jfKaHjUVjO+Y9dU0YUICssxkRhQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TpY4SCUvmPhTQQV24sruI4sIFgJ8NJ30FLIBi0RLjHbUg+klzu2WvS/MpsATB9x6KC7aY+RTy3oCvfzkdFMTkuxCynZlu76hUGLpa0Y2Ism9Ux/2c8+AwmZDxaA8kwMFFzoV08l++EpKXPNLviiBwBz1yZ6xXfTDlsgdTTeIUiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WS7bzQRD; arc=fail smtp.client-ip=40.107.243.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pguBnmlPX8swyfEiIKQo2QWN0z27ScX5KHPnqAHJ0bdlUv0usQJY6mbq0mZ2Ems2zrXrSQfiAgI6p1IXzfwOPBco2tg+Hp64Qt3pXkmyDHBIVGcrd0XV86MXUpORfiFsezLjaFl3GzCw5CpBSpGRRPc1JMqdJnE6PxrfygUHJlHe5r3nJCxZ99XzA0n+kiuqkixqE6k1m1TZBgorVhSxEWc6RqdpsCBsOKz602LA1+qzy74WL6tvXFzDhJM9ppVAjf+eAfFqz7EOJVt0jgLwFfUvT5QVHoGvkY6gQDbMsRWtCCNmMlZUoHol5C+1K+xRaxGYAzQF0A3xCQeGkktLuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FDaTXbWrN02L5Uyf4hXtyH0NdOzjsbxjcT4rgqm8jQw=;
 b=R+6UsM1vyqO/1MNPxuyiwJHJm+Vmy5aAf3A9V+UCL2uR2/Md6WblAzC+og14F79030H4+5+VosszYPK2tLbdFQPfzBbe2O82klkFIGiUndIKdcz9zbze9aK6l5/2VGGY+GL3peuzIE8DvxNO4eGkaxuqMvAkD52+pbS6IuwiMAvT9qSiPy2zAzIzC7cmE0yvaz4XRv5o0Bq7EXmyQNBQbp284DAMIGVfUABtt2acBt7n8WnLZfs1Ad0F8M91dgt4zmkXzDv4L3HJEH5Uh/85MTAYztfU4urzTb9U/lLmPftjqfunozrOa+UJ4w4gBvqHmR2V7RXNzlJjxC0HVxP2Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDaTXbWrN02L5Uyf4hXtyH0NdOzjsbxjcT4rgqm8jQw=;
 b=WS7bzQRDPPjBiEyvI93bXqjCjHrS7AaNE0wmI1qHOcfpW5jDb3SatKvx6Q4flLn7WYXHpxsAMMcQU31MzRn+6bOumh+HTNeLb4UQ207/5C+I6bnr2oIOBHJbdEmtAF/Qr0I7eZXHEcjbAWcvhc4lUjlZU+EYPeQ7y28hN4YtMlo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9aa) by SA1PR12MB8597.namprd12.prod.outlook.com
 (2603:10b6:806:251::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Mon, 11 Aug
 2025 08:02:45 +0000
Received: from SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 ([fe80::40bb:ae48:4c30:c3bf]) by SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 ([fe80::40bb:ae48:4c30:c3bf%8]) with mapi id 15.20.8722.031; Mon, 11 Aug 2025
 08:02:45 +0000
Message-ID: <b3d59f69-3239-4c28-874a-4151e96cd0bf@amd.com>
Date: Mon, 11 Aug 2025 13:32:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V9 1/7] KVM: guest_memfd: Use guest mem inodes instead of
 anonymous inodes
To: Ackerley Tng <ackerleytng@google.com>,
 David Hildenbrand <david@redhat.com>, seanjc@google.com, vbabka@suse.cz,
 willy@infradead.org, akpm@linux-foundation.org, shuah@kernel.org,
 pbonzini@redhat.com, brauner@kernel.org, viro@zeniv.linux.org.uk
Cc: paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, pvorel@suse.cz,
 bfoster@redhat.com, tabba@google.com, vannapurve@google.com,
 chao.gao@intel.com, bharata@amd.com, nikunj@amd.com, michael.day@amd.com,
 shdhiman@amd.com, yan.y.zhao@intel.com, Neeraj.Upadhyay@amd.com,
 thomas.lendacky@amd.com, michael.roth@amd.com, aik@amd.com, jgg@nvidia.com,
 kalyazin@amazon.com, peterx@redhat.com, jack@suse.cz, rppt@kernel.org,
 hch@infradead.org, cgzones@googlemail.com, ira.weiny@intel.com,
 rientjes@google.com, roypat@amazon.co.uk, ziy@nvidia.com,
 matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
 byungchul@sk.com, gourry@gourry.net, kent.overstreet@linux.dev,
 ying.huang@linux.alibaba.com, apopple@nvidia.com, chao.p.peng@intel.com,
 amit@infradead.org, ddutile@redhat.com, dan.j.williams@intel.com,
 ashish.kalra@amd.com, gshan@redhat.com, jgowans@amazon.com,
 pankaj.gupta@amd.com, papaluri@amd.com, yuzhao@google.com,
 suzuki.poulose@arm.com, quic_eberman@quicinc.com,
 aneeshkumar.kizhakeveetil@arm.com, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-coco@lists.linux.dev
References: <20250713174339.13981-2-shivankg@amd.com>
 <20250713174339.13981-4-shivankg@amd.com>
 <1e37e4e7-aa7b-4a2a-b1aa-1243f8094dcb@redhat.com>
 <diqz4iui4y00.fsf@ackerleytng-ctop.c.googlers.com>
Content-Language: en-US
From: "Garg, Shivank" <shivankg@amd.com>
In-Reply-To: <diqz4iui4y00.fsf@ackerleytng-ctop.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0060.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::14) To SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9aa)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPFF6E64BC2C:EE_|SA1PR12MB8597:EE_
X-MS-Office365-Filtering-Correlation-Id: d60de6cd-b47d-4f14-5c5e-08ddd8ad7420
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bnZDOE9zN3RjZ3pRN1RFZytJN1l2YzU1RkdKd21mZ2dKczBjbE8wN0l1Uis2?=
 =?utf-8?B?cWN1YWNpbnhMYlVVd0U5QlZXcGJPYnNuMWlBb0JUQU5WYWVJcjQ4SGY0S3JU?=
 =?utf-8?B?eGppRGxGcHdPU0EwSDFOUzdNVzhaOG9Ta1VkRnUrT05mcisxS1V5Y1dUR1V5?=
 =?utf-8?B?cHQxM3EyR0ZRdDVORmZ2UkFQZVp5QTF4SithME9KZWlrcjF3T3NFQU03dWZN?=
 =?utf-8?B?TEZET1FlMWNtK2lkUU9hSmRjbHU4ZElzMDJwcVVZTW9HRkxWWTdLVXRTRWEy?=
 =?utf-8?B?M0JwUjE3UzJIK2lPRjZUc3NkNVlsRlRQQW5BWDUwYTdmbmpZbXpxV1NxMTBU?=
 =?utf-8?B?R1NlS1ZZM0tIbWVDSmU3RTQ2M2tuem5xbFNMbFdrSDlTM1J5UXBXajJnc0c1?=
 =?utf-8?B?WVZ4Z054bTZnZTJmR0NOemFyYVFPSHpJT0xTZk9OcmJaL1JJS0hKcUFlS3JZ?=
 =?utf-8?B?YVcvaElMcDhISzcxWkxKL3hqWENUOS84OUx1dXpSdGVxcVNkcDhXZmpxQko1?=
 =?utf-8?B?R2l6OGliNmtpamlCZUNPdUhxaUZPTVQrT3VuVlZwcnZtM0pDR3lCcEoybTRh?=
 =?utf-8?B?aDlpblRMZDE2R05ONnBZa1ZKUXdnSDJMY3FhbmI3b0pueHBvMTVTY2hPQ2VB?=
 =?utf-8?B?MEdIWTRyNktmQWt2MmtJZmRveDJuLzdwemdHNmNvdVZtN1NNZVBWUXhKdm85?=
 =?utf-8?B?UUhBcmxEdDNLNktjZERvczRGTGcvNmRjU2NDekRGVkRna3ErOUNJeEh5RGlJ?=
 =?utf-8?B?MmI5YUtSMUo5dkVWS3FqYW9DMnd6TmtJWEJYTDBUbEl0TndROGlhQjVMZDZZ?=
 =?utf-8?B?NkFqQnRMbkVrZmtXTUN1NVdYUDdobHgxMnVrMk5ka1M3bnIwcEhpYWFEN0t4?=
 =?utf-8?B?ZE51SHQ1NXJnbjEwMEFOdzlVZ0t5V3ZYYk5ENnR1aVZqYXRGam9ESVpVNWRy?=
 =?utf-8?B?aWd2c2wwNTNxZ2RpT2lOTHhOYjhUZCtJcHJwUlpJUERwUFBtQnVPL2tnWkJ6?=
 =?utf-8?B?SVpIWVcvN1ROZFN0eWdkdzJEKzBBdjZjWnBEYVFKTXgzWVdCN2F6RnpucHV6?=
 =?utf-8?B?T3VLbEZ0VmVMS0k2NkZTVlZsNStMa0tSeVIwVUYzV0Y0TS9sWEI0NjJ4WXBz?=
 =?utf-8?B?eXBpL3d5SWRBL2xTSmVaZG9mMUxlMG9ZZFhXNk00SE40bUJkRm55aVlxUHgz?=
 =?utf-8?B?T1oyUkVIaG5ibTVPV3FxbCtsVDRMaVJPWi9kZWJOcFI4aC9JbEZ1L1lPZ2k2?=
 =?utf-8?B?YzVwZmwvWEU3OGxIbnVDV3hGNVNzeHl6QjdFMEkrOUlMdlpFYkd3NFNtVllp?=
 =?utf-8?B?WmJ0eU82bEEyRGxaN1g5ZVNhd2x3cHJVQmdUYzdwanlnNmhsMkxPODhPeURS?=
 =?utf-8?B?ejI1NDRQeGpkRnB1MktWY3pKZWVaT0ZUcSt3SWtCejZvdnVBU1Joenh6Ukh1?=
 =?utf-8?B?TjlwT1l1ZXhBR2ZLWkFvQ2IvMTBCTVgrN0dxVUhRM2d1RnAvZjJSS2loNVhv?=
 =?utf-8?B?UDF3VEQ1WE9VbmJwTElkMmRlWmJmaUZWYVFwTDUvZ1hSNkp3ZWxFTm9kQUlO?=
 =?utf-8?B?cTNRa2VRM3BKZVRDMU53aDNJdTZjM0h0MXlxbkhlUXlmYVVLbDRmS2RERDli?=
 =?utf-8?B?QVB5UHV1dzkxcVJsNjdGMW51MkJWK2Q5UzZKU2RhUTZtd0tsL2N1UkRxeUdP?=
 =?utf-8?B?a3dqVGwvTzZIYjVJRGRRbkZwb1dObU9DbTk0cUFodFpIUWxTOUQ4cEtQZmVr?=
 =?utf-8?B?OG9vVlcwM00vTHUxRis4YlRYc2x5eWsvRVBOQTdKdGpxOGcvVWNvZEFweXNx?=
 =?utf-8?B?T29OMW83MlVkcWNTdGxyQnp5aW05TGswTjJLbFFReDUzbGZIZmJjNzQ5MHhP?=
 =?utf-8?B?VFlqeEx2QUF1Q0pzT1BQN3ZxYWUyQ3RyaFgvdGFXOThDdkdpKy82SlpmVTho?=
 =?utf-8?B?SzZSRkxVcU9EWE5URG5LSjJLaUwrQzV4SXorR1ZxRkFZMkIwZ0IxYy9YNHcw?=
 =?utf-8?B?SUFxNjZJL2pRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPFF6E64BC2C.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VElIWlJ3aTg0T25pWW1VV3FWZW5qaUNCS0syc1ppWlEyYnpwU2FkR1dXais4?=
 =?utf-8?B?TVMwRlJNY2R3enJMN2Naa0pQZTdzL3djc2ZWWlpBbld0WGpoSitReEpsTk80?=
 =?utf-8?B?VytRUlM3V3g3U3BGNnJCTkI5djRDb1RxeXJCdWhWb2JEai8zQ0xLK0UvOFRv?=
 =?utf-8?B?aTJlQXRLUUJCQmpPT3lpNEdnS1BhamFyQWlmYkhYc1RJMXlmTXFKUzFEUEI0?=
 =?utf-8?B?aUdEK1BVVTlITkdWcVl5dXplWmlRdjdGWUpjN05MdU8zMTNEV2lQa3VwR1d0?=
 =?utf-8?B?ZE5TOFpDeHdSaFo2ck9mRkVWNVFhR3cyUTBPMDMzWnNBZW4rZTVzQzZHM0hh?=
 =?utf-8?B?dE9DaFhMQ1pPd2VlNXZMcGRHMW1nVDlWUHpIcU1sSng5M1o4dXIzdWlveHE5?=
 =?utf-8?B?YUhsWHFoN0haM3J4QVhjd0U3YUJsdTkyUDd6OVV5MktveWJKZU9IQzRLV0hG?=
 =?utf-8?B?eWU3RTVZWFJNczNaMHFPb2gzTHc1YVNoK3dJakFNNXVRbGNZWGladlI4d2lu?=
 =?utf-8?B?MSs3SDhZbDQzcERWTXRrZ1VESXJSYjBqVUhBcG1KSkRVK1o4cWgzRytLd2E4?=
 =?utf-8?B?THpadGhzNlVKb0lIQ0RPWDVveTFRZHM5RWJDQVJGQ3gvVlB5UlBJY0E2Q25o?=
 =?utf-8?B?RHBoa0NBSUY2S2NMdXlyUjBZMWUwdUFkb1NrWmFwMFFKaWFCcm04TmlSOFha?=
 =?utf-8?B?eG9DTm0yTk1kK1d5bzJUUmdEWGpDMk9XMVpwMG5WNGNLVmJEeXhkRHZndEpT?=
 =?utf-8?B?UkNKbWpMb3NWeG4ya3pXYm9PU0hmUTlQdkJ1TFJhY2Q1M1NycFZ5VUhIclEy?=
 =?utf-8?B?Y0JDVzRVNWJBaUdrcklZeC9YWTg0cVAvdUsyRStVcDE0UklENGlWcjZiOVBh?=
 =?utf-8?B?ZDduSmVwSk85anRGZGx6a0tCbkxGdjk3bVBMcll6MXdVNytMLytveTFrODdm?=
 =?utf-8?B?bVVrKytvTE04cUFUVzlqb0hpbjJ1NTBZOHplMmRQdzE5dnQ5c2h3Z2JlL3hr?=
 =?utf-8?B?bEpwT2lVSjNtUjdMY2E4bU5kaTcwa3dqOHU0MXZSaHpGRThMTTltK0RWOUdr?=
 =?utf-8?B?eTNJRUg5cWVsMnFyaTlDVVI2WjZ3MEtmVlBDN0ZnYWZqY0RCU1lHYkhrbTgz?=
 =?utf-8?B?K1hlVFQwYWVJNm9PRmozRU5Lc0NHWFpKTThhelR2UmNCeE96QVAxaDJDSFp1?=
 =?utf-8?B?VHRLcGo1Z2JSRHdETCt6Mmc5SkZWTVcwSUlTNndPU01xc0w3NmRJQ3RLcWFU?=
 =?utf-8?B?Sys3NjRXcE9oNFNNQklLM2hWSDVUZHhDdUpDUS9XK1E1OEdzNU00a1ZXd3Ez?=
 =?utf-8?B?UVJQVTB3dmZVMy9uWFhrYlhtRnkxNXNQamlJUlkwaUZmMGRheTZGeWNYYThW?=
 =?utf-8?B?TWEyd1crVk44dW1nTnZza0JZOUU0bm9aelJ1RW5sUFFvWmFsOUNBcmQxOEUr?=
 =?utf-8?B?Mi8wLzFvdC9pL1dKbjlvOUpkNm81TTlKYWwwOCtQeUw5ZjlJZmdiZmxxOEJ1?=
 =?utf-8?B?bUJJSUtXdVJ5YUdHQVlIMndLdW52ZzIxTmc4U2ZiSm5NZldCRmRnYTNzSnJk?=
 =?utf-8?B?RmtTQkhrSDc1S01LQXYraE1VcmNRY212cll4SDUybkd1YjUzdmxMZkRxaVZs?=
 =?utf-8?B?TUR6cys2M1BCTXlSUCtSZHJkODhrZlNKc04xS1lGNVBpbW55Vzh0K0Q3VWo2?=
 =?utf-8?B?S1U0dDJ4and3bjhVcUpJWk1KT2REL3ZyYnhMblFLUnFRM1BJSVRHN2hXcTRP?=
 =?utf-8?B?QkhwVEEzYTBJbVFIZk5oYXBtcEVsVnhhL2VkUkU3VEwrZ2lJWU9lVmVpUWNu?=
 =?utf-8?B?MTZadkVOcjhuME9YNEFhaUNqcFNXU1NTUXdYRkY3VjNiZUhTUGpjUkRKcXpZ?=
 =?utf-8?B?WW8rdVhSVHZJYkMybzVrdVBTWVM5Q3JsSXNlUmhER1hEaHBYbllhS1dJWEVF?=
 =?utf-8?B?V1BCWnV0aFdBU0RhODBRSVFZWmFRcGd2L3dJVVc3dTJUa3FzOXl4eHlCcFFJ?=
 =?utf-8?B?VW1jeTlvemVNZ2ZOTEE1WUJrOE4yS0RaZmdrQUhHcVRySW1ScGUrRHV6NkVw?=
 =?utf-8?B?UWpkcnZzSHN1SDVqK0IrUDNCZGtSeVB1M2ZlWjB0QjVFTk0vYlRBRTUweTZv?=
 =?utf-8?Q?qt0HhD2vnHENcgECjHVND0LYj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d60de6cd-b47d-4f14-5c5e-08ddd8ad7420
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 08:02:44.9170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zdSBqN60FAQOlXMUtt2RG6q1hV7F9Ebb63RQbLuT1GYE+B98Lwm3yBF2Y96b17ix1Ep3QZDgAfybcLV3LAQHbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8597



On 8/8/2025 3:04 AM, Ackerley Tng wrote:
> David Hildenbrand <david@redhat.com> writes:
> 
>> On 13.07.25 19:43, Shivank Garg wrote:
>>> From: Ackerley Tng <ackerleytng@google.com>
>>>

>>> +	ctx->ops = &kvm_gmem_super_operations;
>>
>> Curious, why is that required? (secretmem doesn't have it, so I wonder)
>>
> 
> Good point! pseudo_fs_fill_super() fills in a struct super_operations
> which already does simple_statfs, so guest_memfd doesn't need this.
> 

Right, simple_statfs isn't strictly needed in this patch, but the
super_operations is required for the subsequent patches in
the series which add custom alloc_inode, destroy_inode, and free_inode
callback.

>>> +	if (!try_module_get(kvm_gmem_fops.owner))
>>> +		goto err;
>>
>> Curious, shouldn't there be a module_put() somewhere after this function 
>> returned a file?
>>
> 
> This was interesting indeed, but IIUC this is correct.
> 
> I think this flow was basically copied from __anon_inode_getfile(),
> which does this try_module_get().
> 
> The corresponding module_put() is in __fput(), which calls fops_put()
> and calls module_put() on the owner.
> 

>>> +
>>>
>>
>> Nothing else jumped at me.
>>
> 
> Thanks for the review!
> 
> Since we're going to submit this patch through Shivank's mempolicy
> support series, I'll follow up soon by sending a replacement patch in
> reply to this series so Shivank could build on top of that?
> 

yes, I'll post the V10 soon.

Thanks,
Shivank


