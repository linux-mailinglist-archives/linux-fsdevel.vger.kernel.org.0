Return-Path: <linux-fsdevel+bounces-59464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6782AB3934A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 07:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFAB89802C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 05:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FE3279907;
	Thu, 28 Aug 2025 05:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XiJEwkqk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24AE277C84;
	Thu, 28 Aug 2025 05:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756360213; cv=fail; b=NQ4v55b3/F5/e8TEeBRkQSIstRES+E2MuoSmKO2/cSgeUavR9IbOdEw34SpiGjMbHQyb8noFQVICm+YmFHtcOhjitjTO68Jyr0ZiWZqP6c+FexZKnK7TG9SHMkO+Njm/xEM9q0/Q0uga6aDS5umRgyF7UQFM+oCX6tWmVVogTJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756360213; c=relaxed/simple;
	bh=DOxAdQ6YoKREcpXXSAt8H9OuDfH4+87kVFnfIKwSaWo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=POC6RxekAShVZJ+XjngfzS2X6K35nwv6WNgreI4kaf+Fg4e2QA+g6VGnIcS9iXMsCnQ68ZiMGH9duLL19//5FkqvbJE7DaEudLZDadnY4m4vBeCTOR5H2yzcjUQ/fjoFyoHsN3FFv7iMCN/jtwLorVdjtQNc0YJvQUeo98ml8Zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XiJEwkqk; arc=fail smtp.client-ip=40.107.223.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G3M6DTR5z4T++XIVgZCUI4gyOVzHTSTRTTUGSjBmOKoCUXIvNh8gok0YIY1tSpe8l7LjAqshMMqyfLn8parJsdIXBilLqwHlt0/bE1d0WjJsxLTOkpbTckM8lld+hihrpNYh5M27BgxMAbXCsH1ojO5im0j390RWtS2rInBGrT8DKHAfnXaQHiGyBOCtMNEsuET2Sv7LCBWL4Hjs+cKwzHMIFvA0HPe6vK0zPFhmTSenDjvZWNqAHCbLuAyA4Wa4s82CiidWo61rNutCir/d/rkliF4E9J7krjEZDqU/oo0WXP22uWbrMkD3dYsp91QeXdrx4/6O8CTa+AtxzAuBlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TTJFJKt45U35ereDwr6S16MRTnX5v57OqnbZZtW+/Sg=;
 b=ge3J6QRuRQO4BHBry7E01G6/AVDp+D8DRqL4njmr6UBkPSudLIx8MFsKythYIq8g1xR2N2HbuFHZHYYb1NvVS9LmTtPlGyk5FFo1i0gavbdgTtlNOli3sVNuuaJSMUgCG0dSL53ZYd7Vdlsv+Gx+Xfxh9j+kby3UUZSn0bjcN/XFZANEKr2yuKslqrwJObng/uPTyCV2rH0u5fs7CAKk5hWU0mBcp8e3qGO7Gal2vlhSrTCbGX9Z4kFhvJ9l9JKosFCCUVeSqrqr/9d3Az7rolTE7r4W62gVUUHG5QoTrXFEZXZG++Yb0bgdzq3zaQTZtOnMh5dH/mAeujHznY3r9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TTJFJKt45U35ereDwr6S16MRTnX5v57OqnbZZtW+/Sg=;
 b=XiJEwkqk89yYcEJFIDOKpE/jd+q2n4mjH9cnySSLG1GC1GvqIoPRKdHjkhQzty+b+ZpturWnp02FDtFNxsj1vtFPIOVWBmNTNhVEvn2vlNlcQs+iT8a8BwDuBtDsChS9SRUM4GT5IVbpU5Fkr2jcmi2/N0XMCiQ/CwYh9x+mQ9E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9aa) by PH0PR12MB7080.namprd12.prod.outlook.com
 (2603:10b6:510:21d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Thu, 28 Aug
 2025 05:50:08 +0000
Received: from SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 ([fe80::329f:948a:34ef:9848]) by SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 ([fe80::329f:948a:34ef:9848%7]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 05:50:08 +0000
Message-ID: <79fae787-7160-4245-886f-671860b5708a@amd.com>
Date: Thu, 28 Aug 2025 11:19:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH kvm-next V11 4/7] KVM: guest_memfd: Use guest mem inodes
 instead of anonymous inodes
To: Ackerley Tng <ackerleytng@google.com>, willy@infradead.org,
 akpm@linux-foundation.org, david@redhat.com, pbonzini@redhat.com,
 shuah@kernel.org, seanjc@google.com, vbabka@suse.cz
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, dsterba@suse.com,
 xiang@kernel.org, chao@kernel.org, jaegeuk@kernel.org, clm@fb.com,
 josef@toxicpanda.com, kent.overstreet@linux.dev, zbestahu@gmail.com,
 jefflexu@linux.alibaba.com, dhavale@google.com, lihongbo22@huawei.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, ziy@nvidia.com, matthew.brost@intel.com,
 joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
 gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com,
 tabba@google.com, paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
 pvorel@suse.cz, bfoster@redhat.com, vannapurve@google.com,
 chao.gao@intel.com, bharata@amd.com, nikunj@amd.com, shdhiman@amd.com,
 yan.y.zhao@intel.com, Neeraj.Upadhyay@amd.com, thomas.lendacky@amd.com,
 michael.roth@amd.com, aik@amd.com, jgg@nvidia.com, kalyazin@amazon.com,
 peterx@redhat.com, jack@suse.cz, hch@infradead.org, cgzones@googlemail.com,
 ira.weiny@intel.com, rientjes@google.com, roypat@amazon.co.uk,
 chao.p.peng@intel.com, amit@infradead.org, ddutile@redhat.com,
 dan.j.williams@intel.com, ashish.kalra@amd.com, gshan@redhat.com,
 jgowans@amazon.com, pankaj.gupta@amd.com, papaluri@amd.com,
 yuzhao@google.com, suzuki.poulose@arm.com, linux-bcachefs@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-coco@lists.linux.dev
References: <20250827175247.83322-2-shivankg@amd.com>
 <20250827175247.83322-7-shivankg@amd.com> <diqztt1sbd2v.fsf@google.com>
Content-Language: en-US
From: "Garg, Shivank" <shivankg@amd.com>
In-Reply-To: <diqztt1sbd2v.fsf@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0187.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::14) To SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9aa)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPFF6E64BC2C:EE_|PH0PR12MB7080:EE_
X-MS-Office365-Filtering-Correlation-Id: c4ed136c-ec85-44bb-e470-08dde5f6be67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bURpMnFyclQyK3hTZ0RMMXJIOGgzN1VlS2lKUXN4cjcrYU11K2I1RjFCVllh?=
 =?utf-8?B?LzJQUTFBUUVINU8rSTBOYnZLTnhZNGNSbHpidS9wbTFOWllkTFpFQUlpRmtQ?=
 =?utf-8?B?RVpKSTQ3WllCdFc5M2pIMFUwVXlOV05pR1FhSXd0cXpTZFIzU2h6Q3RVemxD?=
 =?utf-8?B?eE1qMzRaU250ak1NR0hzWW9aQTlKV2djenM0VnJjdllRNis0VkYwRkdnVU9K?=
 =?utf-8?B?cHhaNFR3SmJEUUVmZ21ZUHpQUGpUeWhZSFhWMUlxNFZXSzVCbHdMS1EzNXpW?=
 =?utf-8?B?S05yb3VDMXdpVDNFYThTYkxaa3RiWkIyTzVjcVpRMHY2Y1FDL0IyV1QzU2ky?=
 =?utf-8?B?NGx2RUpiUTMwTWZGMkZ4NENIUDU4TTFnd212bEw2YjFVQXVTaDU3UFo1VW1D?=
 =?utf-8?B?bEljMmk0MkhVWE9uS1V1eXczQmt5L2QvY0RSOE9mekxiWG9zeHQ5TFlZZ2lp?=
 =?utf-8?B?c0JaUkpJODIwK3kzMWtHakRlbFhrVEJJa0xndXlsWElNd2thazBvaThMMzNO?=
 =?utf-8?B?bXZCM0U4UVcxRnZQV2tIMDZIZktxT2FMNFNJUGgyMU51ZkJrTXYxRE5QSFF5?=
 =?utf-8?B?VWx5Yjh0R1NSZjdRVW5VY2tmSHpkaUczckhjcWRqT0lQc2dySWRsRmRlMUV5?=
 =?utf-8?B?b3dSWGZRMlRNQkZmQXFWT1hFVEhoVm1ZdmREcFFPemdJODU4aFQxYlRLc3Jk?=
 =?utf-8?B?cUcvUy9xSTg1aU1LNWM1YzJob1JrT2NEL1J0U1djL2RxM0dQR0c1S1Q2TkhB?=
 =?utf-8?B?clVja1h2dWFoRlFWM2szbjhPckgydjBhYVN2M0NjY1J4NGFjeDlaNlZrMUVr?=
 =?utf-8?B?bXo2U2s0b1ZIYnA4MnZCME1scExUOUhRc1A1OG0wa2RxUnN4K1UvQWV2YW5Z?=
 =?utf-8?B?ZEhaS3k3cjNseVNLV2hFN1ZEUkJ1RzFsNUhrT2NacjFhb0ZxeWhkRDdIclpJ?=
 =?utf-8?B?MzdUcVlub3czcXdiNm5ONkVUOTFiMTdMYkJJUDdSRFFOSjQvYmhnaUlSbmty?=
 =?utf-8?B?L3Bhd01EanZuQlFsa3FHL0V2Q1lXVHhyZWpIV3B1bks1YUYwQ2NtN2EvK1dJ?=
 =?utf-8?B?MmwrM0ZpTGtYdUNRNHRVaUYzQzZrbXNwYnB6NFhlMXZLOEtGdGg4ejN3WExF?=
 =?utf-8?B?WS85VmhZTCtONDAwU204L0xXbEw2Y0d5Y245SnBHdmUrUSs4ekxFeEFsWkV3?=
 =?utf-8?B?Qmt6SlB0cnJHeUVIUVVsOG9yVW1IblNjbStodFRFdjhVbFpsNmVoMTFoSEZV?=
 =?utf-8?B?bWErZEFmQnVzcEw0Q2l2dTVIbndqNTVhZ0tCeVAvVkhMdTVxVmZTZy9rT3pk?=
 =?utf-8?B?bUZnM1ErTUx3dGpQaS9ZdmgyN25hMFRDZFV6MFJiK2RHMUZTYzdXYzN4eEpF?=
 =?utf-8?B?M0czanVpK3lqbVlLZmw2SUxJVDVPWEJEcVh0QUVtT1FjZjZrYlFpU2N5OVZr?=
 =?utf-8?B?U3JoQmZJb1FJanVRYUxEczZjOTh5VkRaUXVFZzFPSVNuZXBsV0dDNFpCU3g0?=
 =?utf-8?B?aFJuTVM5QWtBOEw3TXdXTDQrVGs4cW5xUVZRay9pS3MzekNiZVRiSGxYSHRR?=
 =?utf-8?B?ZDZybzRsY0x2UTJEUml2dms1TzNZc0Z5RVVsWXIreFVuTExhRnMwanhoemRJ?=
 =?utf-8?B?VmI1YzVPWXZPQ2tIK2RBMXdvaWhIbUI1bzcxbVJQVlp0NnYxS0FMb1BCdFRt?=
 =?utf-8?B?NGRTdGJkMmZPeklnem8zdVhRWWtnL001OC9VNm01Y3dNNEFQRmcxZzkrT0JB?=
 =?utf-8?B?Sm5EWEZreHQrY0pwdlQxQkZ3S29VVnB6U3Z5T28vNy9POGxCWFVEN1d3TW9C?=
 =?utf-8?B?bndVVFBJOTlscUREa1gxZGl0LzRUeHNCbzN5MkxqNzdxY1J6SVNOa0JHQTgz?=
 =?utf-8?B?aDRFYzF4Uk81VnMvM2VqS0N0Mm9DdWZITDVpUVc4dEJoUHBKRFhnUFhoSXgz?=
 =?utf-8?Q?faLzxGAC1aw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPFF6E64BC2C.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1g4SWlVN1dBd3l0YnlPVitwb0JOUXJJZmlHZFN3S1gwK0wyTjdpM1RFVDZl?=
 =?utf-8?B?eFI1c3poRFZtdGZaMTd1RC81YzNGRUpGQ3FSaytvSG1rcTFhcGE2aHZFdVh0?=
 =?utf-8?B?RTBYMWRnUEl5Y3U5QkY5c0hkbHpwRkhxazRkMXRLVXN4c3dIcVVkVThrOWVZ?=
 =?utf-8?B?ZVRqbXFxUUxpM3dlNi9ZdGdGRDJQWEI1a2xpTHVhQkZVYTdRNFp2ZWpuVEV5?=
 =?utf-8?B?ZmxKN2VYclo4L0ZqdDhvUmJhMmJKNURUTStiRGR3dWd5NS9rNjVXNFQ2UjNE?=
 =?utf-8?B?U2VobGZ0TEswU1BZU3ZDODNPTm4yYTIrTGJiRDhSc1FhVDllRVJlZ0wxR21x?=
 =?utf-8?B?R2ZQTEYrRWhCa0J0a2hBa3VjKzV1TDlmMTV6OEpCUXBva2dSVGpydllOQUlR?=
 =?utf-8?B?UXQ3RTJqK01xY2NGMXY4ZCtQRlBSR1NKQ3NoWHR0Um5VZHROUkRYaXd4bmZV?=
 =?utf-8?B?cEhyS2tDTm9JdUlEUXdmNDJpbUZ6eTY1akpoQTFVYXFxTXgycy90dU0xanRj?=
 =?utf-8?B?SFRjTGlQNXRqamJOaGhRMjg5Q3R0Kzg0ck14YjNGN3RucEJXZ1g3Q1hZVklS?=
 =?utf-8?B?Ry83dTlaV0NVQ1EyK3Q4em5LTldpNlczaG9zb0Fxa2MrcDBPS0VSSFpCUzB4?=
 =?utf-8?B?ZFdYUTlTVTZYN05INzZUTVNic2xUQWVmUUU1bEVWZXdBaHpNaFB0WG1CODNE?=
 =?utf-8?B?ZVcvZzhuNmM2MXRpdklVSFpzMlFZWmJHS2VDRStwY2cwR2FqZmRwS2FndVRY?=
 =?utf-8?B?dWdYZG1nY3VIRUc5akowWWwzbTVrM2ZNanRxb1V0dTVuK0tDUE5RTlRYTWVM?=
 =?utf-8?B?cnY5K1RXeTNRYlZTUEZnQVYvOENUWFRueDcrRk5LRjZZeGtoQlVYSTc2MjRE?=
 =?utf-8?B?eHk3c2FWYVQ0RnFzNCsrNmdFa3RPSFhsb0dxdEppSVlLRStQNnZoWlRXQnVH?=
 =?utf-8?B?STEraDc5U0V4cktiR0VXelM1NjkrYmtlSmhJVzZrbkcvQWdTWUduRHJiakNL?=
 =?utf-8?B?djhSd2RaSFduVXVwb3BOcVRjbXcraENNNmRDUUsxeUJyS2JXZEtrRXBTWGtO?=
 =?utf-8?B?eW5zZlhkSktUUFdyZDFKR1JwY3g4Zk1pTHQrNGNLbUdsekZBNVJqNGV6RmtN?=
 =?utf-8?B?UTRJc1pzSkFRSmgyNUhOaU5CTGVTdktNSFRHMWIxNHFkZy94cFhiVmE0TVdJ?=
 =?utf-8?B?R251cVcwcjFMUkxoWlpkakQyWWJKQ2t1RTV2OURKdnFoNGM4YzNiOEtzZ2Q2?=
 =?utf-8?B?d1dVZmxMU21qcFowRWtsVzZaL1B2bWdkWWZURTBOTUV3YjYvSWw2TWF2NGVM?=
 =?utf-8?B?QkNvNGVXeERuMkdEbWZMcG5HSUM0aURNT3JEZGgzLzA0aFBpUlArMkdYSDdP?=
 =?utf-8?B?SG9jeityU3IxdGVxZFVGQUxwUmRNWmlDNmw5d3p2WUpxbzBoR0JBWHFRSElW?=
 =?utf-8?B?S1NLd0w2TGl3NWtOanZjRUJiYU9HSzBTaWlaU0NrOGNsNm9aanR2d3FKdEt3?=
 =?utf-8?B?SFgzakhYQWR5OFdtZk1hcUd5S1NVQkZod0paWDVYR0RlSTd6QlNUSExrSEFD?=
 =?utf-8?B?NDIwZUdCeUIyTVo5MEd3ZU9ydjJ2MWZjTVVrTkw2TjQ3VjZ4STZ0VDdKeTZ2?=
 =?utf-8?B?OXhJbXRmalI2T3hPUWw2TDF4MDBqSnBQUlo1T3Q1eEgxKzlLdnBFTzU3YlZw?=
 =?utf-8?B?dFlMZUFDQ1ZxTy9VbVRjUTl4Qkt5bjRTa0c5MzRLTkNhUkE1ditBSy84SWFX?=
 =?utf-8?B?MWNQRXg5N1o3WHhlOXNGMDJvSk1xOFQrMTNEVis0QmFwY0h3QStQNmNLdCtZ?=
 =?utf-8?B?dFVLUEcreHo2WXJzR2pHM2Fnc3ExYlM2YTYxMHNSU1JLR2NFMmRFTjZveklw?=
 =?utf-8?B?bDBUMSt3SXlGRm5zQm1wb3NTNVV3Wjk2d3BZaUp2ZjFtQW9IN2VFeE42WVkv?=
 =?utf-8?B?UUc4UHZuTXZwRVFQZFZycXNTNW1TaGRUSnNJaDhFTUo1SzRYQi9xZGUrS1Bl?=
 =?utf-8?B?Vk9MeThQTmRsMVcrS3psWmZzdGhsaHEySTBQZisxclQvK25EZ0tyMkw3aTh0?=
 =?utf-8?B?TjRKK3o2MW5RWVNNVkJ5RUpMRGhrbzdPQ20zamRUZEhGWHZkZ3lBQU1mdUFt?=
 =?utf-8?Q?ss8uKsoA5RDePAGgncrO9j2YN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ed136c-ec85-44bb-e470-08dde5f6be67
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 05:50:08.0701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9fP3mXn4Yi3dhBdxvsXdKgKW3f8Z/3mLTEtLNquCwv60WYfYjnPSxKH6aJg66UjSH5R0xOMhxTB5D6lQL95ufQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7080



On 8/28/2025 4:13 AM, Ackerley Tng wrote:
> Shivank Garg <shivankg@amd.com> writes:
> 
>>
>> [...snip...]
>>
> 
> I meant to send this to you before this version went out but you were
> too quick!

I wanted to get it merged quickly ;)

> 
> Here's a new version, Fuad and I reviewed this again internally. The
> changes are:
> 
> + Sort linux/pseudo_fs.h after linux/pagemap.h (alphabetical)
> + Don't set MNT_NOEXEC on the mount, since SB_I_NOEXEC was already set
>   on the superblock
> + Rename kvm_gmem_inode_make_secure_inode() to kvm_gmem_inode_create()
>     + Emphasizes that there is a creation in this function
>     + Remove "secure" from the function name to remove confusion that
>       there may be a "non-secure" version
> + In kvm_gmem_inode_create_getfile()'s error path, return ERR_PTR(err)
>   directly instead of having a goto
>

Thanks for the quick update! The changes look good. I'll incorporate them
in the next version.

Best Regards,
Shivank

