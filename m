Return-Path: <linux-fsdevel+bounces-50446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00337ACC48D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 12:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2CF2188EC3F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 10:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D91A22A4E9;
	Tue,  3 Jun 2025 10:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wpr7kBZ2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83ADA2C3263;
	Tue,  3 Jun 2025 10:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748947281; cv=fail; b=BHjPy9Af7Vc0JdKzMujNi+YHkujV8NXcBGqCHlIK46tbUy9dgOA6RAMOpUq730cx6t/mZ90MhVAjV1oCkHDNpkkJSse5T/MUOokrX0fa9YF8zGCGZmLf1ll4pjf4CTVimFiSeDsB/tx1zVtPplrBgTGZcfsWxiw+cyCwJx+xhjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748947281; c=relaxed/simple;
	bh=Rhl46nBX98b67/3AkzN0/szDIlGic4kk1kwN7WgR4r0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SU3yTo7PqhYOj+GxorsK6yPss4h6Nnk4ALnR4C6Y5dIaCUHSNn2YwQ+3c8NBcx2mCUnGk2XxkbiAdLCLm2BVfo6iWjgCdiYqM+1n/Kd1na2pC8k8QiMPVd9WDtIHRhp1ttKjr64ILyCpUAY6izrcmhOSStqUd9Xzj/9qh/9dSPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wpr7kBZ2; arc=fail smtp.client-ip=40.107.244.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJc5O5sVZVR/h0wd8q3jnWkqTgy9Bms9WsC4LK+LS8vdVrOAOJw+8/lk8Am6Yjbgug1R90nX28JHqUzeLE8bFmsQAidezY07it9tgypd9bFm71qnPXuInRJDVRCxJzCwTSisgVpL3ubCUf6F1RLMpw7LqMlN67oRi6lqK+Eyu1zBNzqyVbg8tlEfWwuG0nQM2VB3Csl1scN1i/vVUQ1aK0um7/wNbRMHMEChfat+p5n07DH1US44+r5uofOAfhgOZr10E30GEbBVya8R9xSGemYUR0gbhkei7e5ng7CR3Cd8RiaE31W460gib2XqTHQjd26J2kVIK6FEn+01OvSGeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YeQSnx68ZkRYjijGqhQ8m9AW1HUicX6Yj4NSbnYMsJ4=;
 b=MB6vSHCM4GeGvePaG6D2up6NylXDgOGHttyzRFnoAbSZNQrvXLUUAEk8jngz/0Nc9fNvlWa1Ph6XmoYOtE3gjjvsFZvmJfAPjDovAThF85tk0TYGo5Sot5mzwEXOpvh+zsokjBnwL8eytJX6GnEOmd62Q0BXMenD65Cw+POaRQYiV0Y/NKZnSHaVBJvnTzTimZM0jaoUoLo3ng2/UJ+ScTBD8L2wQZjWHYhBc6XjkfsFT9DnPyIbCd+2ckxm73Td63IZ9wJC7I3RTRhl6yRgKP01hUTD6lY29Yv3DqzBIuS77BdWgMxS3SqFJDdRWmcPZP7jJ3027/pyYOrvUUrOGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YeQSnx68ZkRYjijGqhQ8m9AW1HUicX6Yj4NSbnYMsJ4=;
 b=wpr7kBZ2MiMQs2624pwhtRu34tqYETQ6zqZMPGDcYkR0+oQZkRbXCV6n3VJGMxi8wMpsEplp1Ju6oePAfIW9TrtRU2uHFtBuucTzvuWQVLumG/XaEeiwXsrIOcZNPgHXqSsPSYhDcaOrtgegs50X6QIttf8cvDWybhvUP7m5M/E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8)
 by PH0PR12MB8128.namprd12.prod.outlook.com (2603:10b6:510:294::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 10:41:14 +0000
Received: from CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870]) by CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870%5]) with mapi id 15.20.8769.035; Tue, 3 Jun 2025
 10:41:13 +0000
Message-ID: <5f909bbf-d583-4a0a-86f8-abc581ad8cb3@amd.com>
Date: Tue, 3 Jun 2025 16:10:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] fs: Provide function that allocates a secure
 anonymous inode
To: Christoph Hellwig <hch@infradead.org>,
 Ackerley Tng <ackerleytng@google.com>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-fsdevel@vger.kernel.org, aik@amd.com,
 ajones@ventanamicro.com, akpm@linux-foundation.org, amoorthy@google.com,
 anthony.yznaga@oracle.com, anup@brainfault.org, aou@eecs.berkeley.edu,
 bfoster@redhat.com, binbin.wu@linux.intel.com, brauner@kernel.org,
 catalin.marinas@arm.com, chao.p.peng@intel.com, chenhuacai@kernel.org,
 dave.hansen@intel.com, david@redhat.com, dmatlack@google.com,
 dwmw@amazon.co.uk, erdemaktas@google.com, fan.du@intel.com, fvdl@google.com,
 graf@amazon.com, haibo1.xu@intel.com, hughd@google.com, ira.weiny@intel.com,
 isaku.yamahata@intel.com, jack@suse.cz, james.morse@arm.com,
 jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, jhubbard@nvidia.com,
 jroedel@suse.de, jthoughton@google.com, jun.miao@intel.com,
 kai.huang@intel.com, keirf@google.com, kent.overstreet@linux.dev,
 kirill.shutemov@intel.com, liam.merwick@oracle.com,
 maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, maz@kernel.org,
 mic@digikod.net, michael.roth@amd.com, mpe@ellerman.id.au,
 muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es,
 oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com,
 paul.walmsley@sifive.com, pbonzini@redhat.com, pdurrant@amazon.co.uk,
 peterx@redhat.com, pgonda@google.com, pvorel@suse.cz, qperret@google.com,
 quic_cvanscha@quicinc.com, quic_eberman@quicinc.com,
 quic_mnalajal@quicinc.com, quic_pderrin@quicinc.com,
 quic_pheragu@quicinc.com, quic_svaddagi@quicinc.com, quic_tsoni@quicinc.com,
 richard.weiyang@gmail.com, rick.p.edgecombe@intel.com, rientjes@google.com,
 roypat@amazon.co.uk, rppt@kernel.org, seanjc@google.com, shuah@kernel.org,
 steven.price@arm.com, steven.sistare@oracle.com, suzuki.poulose@arm.com,
 tabba@google.com, thomas.lendacky@amd.com, vannapurve@google.com,
 vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com,
 wei.w.wang@intel.com, will@kernel.org, willy@infradead.org,
 xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com,
 yuzenghui@huawei.com, zhiquan1.li@intel.com
References: <cover.1748890962.git.ackerleytng@google.com>
 <c03fbe18c3ae90fb3fa7c71dc0ee164e6cc12103.1748890962.git.ackerleytng@google.com>
 <aD5_hL-caOZjSk8x@infradead.org>
Content-Language: en-US
From: Shivank Garg <shivankg@amd.com>
In-Reply-To: <aD5_hL-caOZjSk8x@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0059.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:270::10) To CH2PR12MB4262.namprd12.prod.outlook.com
 (2603:10b6:610:af::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4262:EE_|PH0PR12MB8128:EE_
X-MS-Office365-Filtering-Correlation-Id: 3183e387-d66a-4b3e-74a4-08dda28b292f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2VVbFlDL0hKTDZXWERoa042OHpIRFhNeVVzTjJmZGN1Q2FNVlhGMjBabitP?=
 =?utf-8?B?bzlTQ2NHTzVpTEFHVk90RTA1R01DVmdpUE55TXpGd2lWK2NjV2NyODM3eGJC?=
 =?utf-8?B?MmFGRXJLakFxK3BvZENzK0FST3NuZ09KQW9ETkxNWGRNeFU2b3dJcURjYmU1?=
 =?utf-8?B?R1g2Kzh0enZtL1VlbXYxc1hDK3FiRDU1aDNraWNvM1QwWkFxOTc3aHlzd0RY?=
 =?utf-8?B?a3ZlRk9HeDZjU254SWJYckw5dVZDWlJ3Qk9GbTR5c1AyNE45OWllNk9oOGxh?=
 =?utf-8?B?Z3A3dzBWOCs3SmdhNERsaldheUNjbTJGamU3dEZkaTFLbmcrQmtrTTVBNkdW?=
 =?utf-8?B?Z0lvYW5na0gvMzRhNU1sVFFTN0ljdVRrN3lEd041RW8yaEluZzJiQXhoaUs3?=
 =?utf-8?B?MmczTDRJVlpBeDZLY3FzaVIvNlkvWkxaQU9ETllxd3lVZXA0TllHK2RsYTZD?=
 =?utf-8?B?Y3ZFVEZXTFNpb3V5UVQvbDl4aEJvSHYvaVFhclZERXcwV2huY1VEUmFORndi?=
 =?utf-8?B?ajRlU245bWQ0bVBEcGpvVkNHT3RGN2FrbEVkVnk0L2pOUjkyeG9hcGFValVj?=
 =?utf-8?B?WU5ZQTRpWTAwbytEejNvaGQ0VTc4OTdISWlNUVNRREVzblZEUDJRMytwL29u?=
 =?utf-8?B?aXhlSld2K3JMVWtXUWtCQjQycEtyK3R1OFhrVFJyTVRHV25VY0JRY3k5QUVa?=
 =?utf-8?B?NEtxa0JNNjBKOVI2cExTM3dObUNlN0VFL2t6ZFA5RzBObnlpR0I1bG5lMVlH?=
 =?utf-8?B?SVJLckNLWTVZRlFxNDBnTjdwQ094VWRXSmxZQitBWnBseXM5WjRZdUY1Y0ZW?=
 =?utf-8?B?Um1YUkx6dE1ueEQ5U3hQemx0R0pEYTAyTXdWbXdRS1NSR3lqZHE3Q0M5azZP?=
 =?utf-8?B?c0pNTW5MRkcrTzFycGhuYVg4bExuWkZzVjhWbnRCdWJMMDY5TUIwbGkvSUVh?=
 =?utf-8?B?T292UHdHaXduQ2VqYXBNR2hkOVo3SUtOczdiOEY5VWdQb3o0YjlOcUFkOTg1?=
 =?utf-8?B?UEpxMUowRm1VU2hLdGVOZEFVTTc5RWRxS1VqMUlEVjZWVzNubDJNdlNLSUJO?=
 =?utf-8?B?dDdySjA1L2dUUThnRHRqMmxrOUMxeGQxaEtOM2pheXg4aGY5OHYxNlVFSVda?=
 =?utf-8?B?TDkrcmNaMGtqMXRBYnNmVldXZmdQVjhxeGg3cjZxU0FPTXpVcitTQStPZ3Fw?=
 =?utf-8?B?dTBvdThnTnNQSGxnTzd1U3YxT2VZaCsyd2xPbER0bHBRTkZ5MnJCZ2dGNDRR?=
 =?utf-8?B?Z2tpRzNpbWVsdjJ6OEdRc29PQUdPaTJHWmR5ekltbkZLSWZKMVhCNGg1ZTA1?=
 =?utf-8?B?dmdUQWNiNFEwdUFzUVRDek80ZWZhTG95eVRTYllqcVk0eVVncUVzV1hwRzN1?=
 =?utf-8?B?R00ySDFqQlp2TGEyY01TNXhhZWJzT0pnT2FMT0xyL2hkRzRQUDFjVjU5bi9Z?=
 =?utf-8?B?UXQvOGluR1doQjlMZnZ1ejVPVjBsZjR3K2hNZ2dzeGxSaWpJNHA5YStwSHN2?=
 =?utf-8?B?NE1kcnpJZHpoTjdtOG1zN0hnSzZHZWY3dlhiRDdvbFdvZVEwcjliQ1dGV0lU?=
 =?utf-8?B?aTRWUjk2TkFNTWtDWkNKSGNINlhybnJhL1gwVHpUOHh3eldoNTJaeUIxSVN2?=
 =?utf-8?B?S00rcDI2cVhXcWkvY1pVQnBBbXdRbEcxVFhZeUpSUmc4UWUwL09HYW5XRVk3?=
 =?utf-8?B?RGgvVW1uOEpWbW54TXhweG44NzZqSkFFY1FMTkp0djk1Umh6cnBvS29IY1ZN?=
 =?utf-8?B?YjgyUmpvQWIzMnNpQnFxaFBULzFMckJaRjI3R0x6WGsyTE01Q1ZjL3BaT2Zr?=
 =?utf-8?B?MlozZjltS3FMNVdkMUNWVS82dVpJRUxFM0ZicExmQUt5enIvOUt3dVMvZmY1?=
 =?utf-8?B?WHFtcW5lVDZ1b1hYc09iclZLRGlzcjBOelJKdUVZRm1YQ2I0ZVdpUTZqbGQx?=
 =?utf-8?Q?e1xd8/+pZaM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4262.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkVlLytoUWhOcjlqRHN3N2MrTDZ0ZnBEdnRaNmtROTF5di9LTTJVNmZDNWhE?=
 =?utf-8?B?Tm8yMHlScUp3YVBITzhJRkZaVXBQd1JuN1RzUGdNWjBpcmFTTDhveGlibDRU?=
 =?utf-8?B?LzlxcjI0QmQzNHkxVHJyZ1dXdzh6Z2tQZUVKcTVOZ05RWThPejQxSkMwOHND?=
 =?utf-8?B?ZVdnS21OWVJ1ZGVwVFViSGtIZkEyQ0pHSzBRZ3VucktDWFJRZFBDVkJtOVN2?=
 =?utf-8?B?ZkpHb3NVSXdqeWVIL2tyR2xQbUJmSHcxeXB5dE9LdDV3clNRT2hSclk3dXZt?=
 =?utf-8?B?UVFnSDVPbmVPSXYrMGxQZDExSllLNDBUQjJDQVNFMEFxZHdyK1kvODdtWG9y?=
 =?utf-8?B?cUpZTldNQWg5NXFRSEszRHc5NVFoRUorN1h5YTNOOXRUeitRczMvdDl1N0x3?=
 =?utf-8?B?KzJqVHlQNkN0Y0ZDajlKRlVnODhIQ0RVZW1HRkRGMEhLNzkwSzU1bncxcWJp?=
 =?utf-8?B?SVZhT2k2V0FPQkY0YndHcW9FclEzK2E0NnlvL1QzK0FtZzdSY3laRkNzN1c4?=
 =?utf-8?B?K3BVNGtkRXJRUE1XV29GdkNWQWtZaE96Tlk4N0NVT1ZzcDNLenFZcW9vYUJP?=
 =?utf-8?B?YU5TQzIzL3kvVUN2Nks1YzlXdW1FdGF0cTVnMzNrZkFqSEd4M2ZJenFkMGtz?=
 =?utf-8?B?OXlpdGt0T21MWGM3cmRkbjlJOWtBSTRTNkdnUWVhTmRiWm1rMFdLZXI5Sjdn?=
 =?utf-8?B?cW94S3pHMkNsdnpnKy85UXpwNVVDMGhqZHozemRVMlY4Nnl5b1hXS2JwbGVu?=
 =?utf-8?B?Z0dVS0JCTisvcUtYeHNYRk9kQmppTXk4TUFDblBZQU1qYmJxaFgyYmdiMnFy?=
 =?utf-8?B?akxEZ2JuS0RVcXNsMUJxaHJBNHFBYjBzS0NLSGp6ZjdSYmRzMXB5bzUrN3k1?=
 =?utf-8?B?bVBFQ2xGWGJwUis0SHJxVGlJVlZrWFlSU1p2SXJwUmxJSThrbG1CajluZW01?=
 =?utf-8?B?OEZVSEszUCtrZlpaR0hqa2NHbUhUUnJtMmk0VWJIdmRJeXloNTNqTkMwMHlV?=
 =?utf-8?B?Y3pIN3ZQanBqTk9Tc2JzSTg3NFFZTjczbTFTTkxWSEltSlo4M3pjSHM4bUF4?=
 =?utf-8?B?LzRGbGpDQ3lRbFZ0eFpQWXdBWTVLWEpiKzBuVjFRUmYyQjZvcWZsTmhEMTl4?=
 =?utf-8?B?UTdTUC95ZHp3bzh1dUJQcGtwWlNYMnhxS2xoTVpRbER3VkF2dnZNVGpCalYr?=
 =?utf-8?B?b0psVUNXaEV3a0JVWWg0Tk9nU1Z4akdjQkcrZjE2K2hVaExUUXN4R2RINkJY?=
 =?utf-8?B?NURFNEdQTHhMYlZVSUJmczhWVFo2RTdMOW9vdWpNZ05sVTMrZDNnMjNWN1Jv?=
 =?utf-8?B?WnFpUXZJRnVWSW1ZaVRQNityQ1RNZ0lNUlkzMkgweTg3UllUR3M2TXFDL0RI?=
 =?utf-8?B?WlM0RDZiV3piVHdqU3JPYkdmOUVhUHpuOUsvcUlZdXlVdEc2RTJwYkpPK2to?=
 =?utf-8?B?L3JJaUFRT3V6WGpIT05IOHN3dUlCemhITDRBemtJYjhmOEdEUmR4Q05EcFln?=
 =?utf-8?B?SEg5YmpFYzl2dU1UZHhyS3dMU1I0SG5VWTRmMmMybUVoREpOVTR5b2Q1MDJM?=
 =?utf-8?B?WGl0NS92Sk5hdDFaMVlvdUhLUGdSbDNZcWl3cW5rbHpuVW1LbmFrRnpCbUIz?=
 =?utf-8?B?c3ZITFZOSkFicmlmeXNvZTFUS1E4eVZjK3RuS0p5RlhsNWYvek85aHBTclo5?=
 =?utf-8?B?UkNHMS9rRHpJY0ROajVRaHJwZW96SnJpZlBpVzlOc1NhWHIyQjVuR1JRZzJV?=
 =?utf-8?B?VmpnV2VhNGt3a1JVcldCbHRlWExDV2ttdW5TL1I1TWV2aXlWazJFVlpYQld5?=
 =?utf-8?B?M0FOVWFvL1NxejVBd1hZeWU1SjNVZ0JGSERFMWNyVTdQZXk2bFNnM0dnY2VJ?=
 =?utf-8?B?L0xYQ2Y2djVtR2VwZVV6UDh0SmhkdWo1Ymo0alZtRHcrNmhXOHk2THlVOWt6?=
 =?utf-8?B?TjVnSGx0ZmZqdHhoZUNRZEcwZHlXalZHalVjM3M3NnNxZTd1czlCTDVFVUl6?=
 =?utf-8?B?K3VSTk1aTHpoS0dCZkdCQW1TNWlNL0xrUzRpNkVQeHVvZk5sUVBCaUV0VTZa?=
 =?utf-8?B?S2ZpeTRkeXl1WHJpbnoyUExlYlRacUpNWndKSnVyU2d5dHpnMHgrNHZEOUZN?=
 =?utf-8?Q?ngPl2Q4nnfol3FZPhBlcBrAOl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3183e387-d66a-4b3e-74a4-08dda28b292f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4262.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 10:41:13.6964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S5pw5XT7HLGN0xr8imjR6AR+ZAVt0ZWMKt/I+5gUoKoYQtC4jgRpOZ2RuPjRZNPr/VHmISzG9UPk44BytXPQWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8128

On 6/3/2025 10:22 AM, Christoph Hellwig wrote:
> On Mon, Jun 02, 2025 at 12:17:54PM -0700, Ackerley Tng wrote:
>> +struct inode *alloc_anon_secure_inode(struct super_block *s, const char *name)
>> +{
>> +	return anon_inode_make_secure_inode(s, name, NULL, true);
>> +}
>> +EXPORT_SYMBOL_GPL(alloc_anon_secure_inode);
> 
> What is "secure" about this inode?
> 
> A kerneldoc explaining that would probably help.
> 
Hi Ackerley,

I had been working on the same based on David's suggestion and included kernel-doc
for the new functions.

https://lore.kernel.org/linux-mm/fc6b74e1-cbe4-4871-89d4-3855ca8f576b@amd.com

Feel free to incorporate the documentation from my patches,
Happy to send it as a follow-up patch or you can grab it from my earlier version.

Thanks,
Shivank

>> +extern struct inode *alloc_anon_secure_inode(struct super_block *, const char *);
> 
> No need for the extern here.  Spelling out the parameter names in
> protypes is nice, though. (and fix the long line while you're at it).
> 
> 





