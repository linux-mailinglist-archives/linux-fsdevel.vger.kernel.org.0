Return-Path: <linux-fsdevel+bounces-51760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C63ADB0F8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 15:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84D5E172F02
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 13:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16B12DBF4E;
	Mon, 16 Jun 2025 13:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FLFRu5Sw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C8C292B51;
	Mon, 16 Jun 2025 13:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750078897; cv=fail; b=VKLD9crMFXLCKYmb1VlbPS2Amv98dAwxZNzztvVIRnSAqqiwzJYnqIwgKc6SdECe1Qb6diOxbnLFpbI1zbaDOirGmyRh9V50LdIzPXecWXpKpvRRGRDdgLQlSypbmsNM3PZ8R8uqpMLuykVRfyPxQHppdjYAXI4jSFVd/hy4DzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750078897; c=relaxed/simple;
	bh=FBsog3KiXhzbGX1q/hcSOmDy8EFV5jFFzdb89okXMLM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R2hwLiG5roMfBqlSfEcRhcJUFmNgXGl25b5Hki1Pjso0LWi2cbFxWbRAf21JFWl+9r8R6Byk/jjQ89baBziyJcnLbpkw1D6NEN7QFoyNaDn4wUIdw00H4+d+TMQAu2zOupUaqLTynTPz/jR+MNExK5cN7UdYNKid8QH4yzSSlzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FLFRu5Sw; arc=fail smtp.client-ip=40.107.244.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WYHJvSNYKYRwcz6ktMbtPobsahaGEaKUPlO60TlURAAdQLN/jrHvDZ+tN6Klp1RWWGQOQnMm5cw7n/kEUWARUDe8ygsUyCe+2CyADHvR6nLXAr+jf36H4BlEDHh1evOM5MmbCt34n8mfY5P8lcwNMra4G62J4k+S79LLSyf/juqpGNFlufd+LXR3QVxmYItwIE+ADpmnjoWUGQPA4Tad/Mtjd+lyJxxVkCI9ssdPr5UbIwNwFlhgCm9qxugUFfgKiVdVoKe2UU9+p9HSFwtaJpuE7GQT7MXF1G3itW8w1gBkhZK4WeUyZWtUNTFqZh6KhoyqYxaRbwEL9eeGDEf2/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKXp5UEP8KSZHPiW/UJj/FomDwwHtlo2HmHcrKu+0zI=;
 b=Yzsws4l6oLkhy5W/MwFtC7dL83pT2LRBB0+VR4xRzcgL/lMqx+HdwkzZTGNOtA3mGvPgf8kTE6lZJLyuLHBe6LujdsarKAJKfrTyjQ3r8CEXSGDU49ff4t7sq6V5aYg29Lr8mBkwGDabFmWvm6KHeV5bJt1adyHBdf9LO+FEi8AB+1ZfLczSc2KcZPcU58L2n3syrD1jYg/i7Cic9APFcwo+mODBB68rTPUzaqvJBxy3bZKI9pCIq3j1QlYEZWN3rhEp+9js4ag8uwmWN/giErzQN1ja0tW6ZkivcAcvvVnfoGqHNoc226cqZGGGAaeVFIOoB6uChtwKzFHGOlDU6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKXp5UEP8KSZHPiW/UJj/FomDwwHtlo2HmHcrKu+0zI=;
 b=FLFRu5SwOQ55+KoUOFDi5Pr3C5AXr+wwESnBHrr4gc45VeaC/48ev9PMV7X6Q0zOZkr/HFawq/PKbp1udqBVAuSSQagWbWl2v3G1GpSkronf7OBF7p2ALOjWWdHZJRUsfb3SD8fdjQsmZ2XiYQxruKxKp83g/1TyMWpHzuWeEIo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8)
 by PH7PR12MB6718.namprd12.prod.outlook.com (2603:10b6:510:1b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 13:01:32 +0000
Received: from CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870]) by CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870%5]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 13:01:31 +0000
Message-ID: <647ab7a4-790f-4858-acf2-0f6bae5b7f99@amd.com>
Date: Mon, 16 Jun 2025 18:30:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] fs: Provide function that allocates a secure
 anonymous inode
To: Ira Weiny <ira.weiny@intel.com>, Paul Moore <paul@paul-moore.com>,
 Mike Rapoport <rppt@kernel.org>
Cc: Ackerley Tng <ackerleytng@google.com>,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
 kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-fsdevel@vger.kernel.org, aik@amd.com,
 ajones@ventanamicro.com, akpm@linux-foundation.org, amoorthy@google.com,
 anthony.yznaga@oracle.com, anup@brainfault.org, aou@eecs.berkeley.edu,
 bfoster@redhat.com, binbin.wu@linux.intel.com, brauner@kernel.org,
 catalin.marinas@arm.com, chao.p.peng@intel.com, chenhuacai@kernel.org,
 dave.hansen@intel.com, david@redhat.com, dmatlack@google.com,
 dwmw@amazon.co.uk, erdemaktas@google.com, fan.du@intel.com, fvdl@google.com,
 graf@amazon.com, haibo1.xu@intel.com, hch@infradead.org, hughd@google.com,
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
 roypat@amazon.co.uk, seanjc@google.com, shuah@kernel.org,
 steven.price@arm.com, steven.sistare@oracle.com, suzuki.poulose@arm.com,
 tabba@google.com, thomas.lendacky@amd.com, vannapurve@google.com,
 vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com,
 wei.w.wang@intel.com, will@kernel.org, willy@infradead.org,
 xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com,
 yuzenghui@huawei.com, zhiquan1.li@intel.com
References: <cover.1748890962.git.ackerleytng@google.com>
 <c03fbe18c3ae90fb3fa7c71dc0ee164e6cc12103.1748890962.git.ackerleytng@google.com>
 <aD_8z4pd7JcFkAwX@kernel.org>
 <CAHC9VhQczhrVx4YEGbXbAS8FLi0jaV1RB0kb8e4rPsUOXYLqtA@mail.gmail.com>
 <aEEv-A1ot_t8ePgv@kernel.org>
 <CAHC9VhR3dKsXYAxY+1Ujr4weO=iBHMPHsJ3-8f=wM5q_oo81wA@mail.gmail.com>
 <68430497a6fbf_19ff672943@iweiny-mobl.notmuch>
Content-Language: en-US
From: Shivank Garg <shivankg@amd.com>
In-Reply-To: <68430497a6fbf_19ff672943@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1PR01CA0153.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::23) To CH2PR12MB4262.namprd12.prod.outlook.com
 (2603:10b6:610:af::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4262:EE_|PH7PR12MB6718:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f567cc4-79e9-4e33-b730-08ddacd5ea09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RG13TEJQa0JHbVNubWtNV29JL1BIRm00ODNOdnFSQ0x1TUJ6ZGVYRHZzOHda?=
 =?utf-8?B?Z0h5MG00Nnh0NkNFOTJQSi9FalE0Q1FQRUNYKzlib1BvdThyck9lN2VIUmZa?=
 =?utf-8?B?eTk2QXV3Q2JnN2REM0VFSklkRnpuazhkRzZrcExBa2dZN3NFU2dyRXoxZUxR?=
 =?utf-8?B?aE5TSzk2NDJvcmMvdGV5clVVRGFaZXp5Sk9Zbml0MFppTnZ5WnlzajJKZHdm?=
 =?utf-8?B?R2RoSVlqVHIxNUFuWEM0aGtUUjFJcTVUQzJLQmxOTlVGRzRPRmVBdWNqV0FD?=
 =?utf-8?B?ZDRsVzQ0NWk2K3pXaDZ2UytnanQyeCtNZVJtZ2lqUHFnWExvTi9JSGpCNStM?=
 =?utf-8?B?L0JseXZjcUpiWVFMMkk2ZUppcnJaK0FJcENNQmNkUVI5dkpmZllvdVBtTHRu?=
 =?utf-8?B?elR0RDBycFJUUG8rMEZZZGUraDJnUGMyTCtrUUl5QnVRSXJka2lmeUsvTUhl?=
 =?utf-8?B?bVpzVHVFeDFlQ2dtUjlRSEJ6QnhjKzllYnh0QUxQR2lyT3AwU1dDMnRKaS9v?=
 =?utf-8?B?QmtwZlM3WkgvclZjMGthUTRVN1ZCU3BzNUhibmNMNjJNaGtoMmM0VGlxSVVZ?=
 =?utf-8?B?VnBROUE4K3JUU0lPUUVET3Y1MkNhVDNMQ1MxSTEzNTZhSUJVcnBTaFA2NE51?=
 =?utf-8?B?eXExZXlPUWs1bldBNkNuMVI3dFc5VVZFL3ZkZC9PNnFVQnZSQWlmT1BRSnNZ?=
 =?utf-8?B?dmNKUHVlUEhrUSsrdHZ3UVA2c2p5OURWc29lWEQ0R1NXdFFRY3hXVGc3SmRQ?=
 =?utf-8?B?WW0rNmxDTHV2NnVneWtHOXAyYy9Ba1ZjanF4Rm9SdnBjRjdHWG9CYW53ZG1H?=
 =?utf-8?B?WjNDSDd5Ykk2QWlleDR4bWtDWkJDdGhva1Faa2g4MXZUUjkwd0dFMzBPOTdN?=
 =?utf-8?B?cUd0NjU4bGVSMUt2OC9TOHdzdzdYa0p6WUV2MEJWWTJHWXFVM1RVZXM1aVhO?=
 =?utf-8?B?WmxVdEpxQml3a1lzZEZRYTNMWDlWVmlhL1NybmkzV3lwRnBiT3ZIWmJkQURD?=
 =?utf-8?B?dDhGSll0ZSt2TmZYaDgxZVFxLzdkalBjSW1vVVkzTm4yQjdHL3VWU2dlZjZU?=
 =?utf-8?B?b3NsazBuUWxjNkpkN256Y1lOeUpES1NtRGRoRmhxTVlCejg5MTYvcEl0Y1lQ?=
 =?utf-8?B?TGVNbGpuTWZqdCtMUnd2a0U5UWtZYjVhSmVraCtoQXpQbGhyY1o4YjFITHBZ?=
 =?utf-8?B?WE1CWFRzRjA0OERENnRxWmwrTjRvWHZHdTBWM3FNM3hNdHEvTXlSM2k5RTdC?=
 =?utf-8?B?R0xxbTNpcVhVZ1NIbkFEUWxjNEk3cmdPV2N3UThyVXJJYWdRZlNFL0hoY2ZZ?=
 =?utf-8?B?MTg4OWJPajh1SkZxZHY4cVVOYkJCTWpVazVYNFJHWjJWV1ZVUGQ4Y3Y2NGtv?=
 =?utf-8?B?bHoxMCtIVGpGTkQxQ21uSXRLK3hBaHBOU1dLUktaV054MTQvVEdsZUNVTWhJ?=
 =?utf-8?B?S0Z2TVg0Zmg5NHdhSUhrL0pXZm1BcHhwYktXWTAwUzJSUmtxUGlUbUo1RlFr?=
 =?utf-8?B?eUxNaWJ1V1h3RC9OK2lac3BkUCtRNzNxNkloT2FQcDZ2R1F0OUdJRks0d2lo?=
 =?utf-8?B?Wm5UUUVGYVk5SmpDQjQ3MnMyRUd3YjdkbzZNK3pYSXlyZ2swLzlxT2llUG85?=
 =?utf-8?B?L1VVeW9Da2k5OWVCbTdmbSsrblNvVHJ0cXovMElQMENtNTkxaGR4T0QzeXd5?=
 =?utf-8?B?dzEybTFCeFpqZjVoaGN3S1IzdnpkMUhQSFVwMTFuZXZrL3pEOE01bDhaY1M4?=
 =?utf-8?B?dlhLU0pTYVc5SkV4RDdXb3ZmY1ZOc1FOTkdIaXdpN054VXhJc1lEYStEeEFr?=
 =?utf-8?B?ZElFcGNLMjkvaHhrTmhCVC9KSGJLWFM1dnRuajNLUEw2QTVWUFpmSmlrUHFM?=
 =?utf-8?B?eVZBWEorWWpWbjBNREhmeDNCMmxKNjlYN2tRemVZeFB5K1hjNGlKVEhORmcv?=
 =?utf-8?Q?FaQpmvNfH/g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4262.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3ZhYzlDelUvUXl4WkNXMnJNNmxmdUJ3OU84NHhld2RUQURTSGtwYkhWTzhK?=
 =?utf-8?B?QjQwSkFRYVdxNk40OUlUbmYyNlBhWFNuUnZzVzdyNSszRERWNE1mc25OYytZ?=
 =?utf-8?B?UHBWMzNXcUg1NTFFR0tQeUJhNzVTQVlQSFpDNzNXcVhRQnlFVnRuYVNvMFVX?=
 =?utf-8?B?SXdGZHhMWmRWK3JEa0ZJMzJaclJ2Mjl4UCtCTlN4SWJIQkFFcUpqQlJvdnRB?=
 =?utf-8?B?SWd5YWdCbnNsUS9aTzlpbkpJUDF6RUwxTDFscitKZnl2aUNnYWRYRVFoZzJD?=
 =?utf-8?B?Z1pqU3lBV3ZTRkpuRDBPUk8zYUNubkVINEdqQXJlcFJWc3RKZDltL0tvNTFT?=
 =?utf-8?B?Q3FKZGVoeStoWmV4V3YwblEyOXYyRCsvVUhpUjB4QVhzcmczU0cwNGphNC9u?=
 =?utf-8?B?aVhDNDZ1ekJtdDNYL2t2dzRQMGNuei8vdzhKQndMazQvUmp3YzJIclFYNmI0?=
 =?utf-8?B?QUtxd2pFRDZhUGh5QlVRc055aHRJanhhS0VjcC9MT2diNng4WVlmR1lYQTUw?=
 =?utf-8?B?L1dtWi9JdFFuNVNxaituc2xZclU5ZWtPbDN1UUZSM0NwOTI3OEZEMmNrZEFY?=
 =?utf-8?B?U3FvbTJpZVo4eHFYOE9ibkdwN3UzSGVUM0xMZHJDVk9NWTZNaEJxLzVVNXFC?=
 =?utf-8?B?MXBISWIzc3h6RVNRcUxHMi91ak5vNS9WOXlmZnJEU3c3VGVsM25pQ1lGazQ1?=
 =?utf-8?B?YnhHdTRQcXZKc21oL05sbUZkaEVoTDZ1MzJaSjNXcFUySTEwQnZ6Mk9oOEpS?=
 =?utf-8?B?ZWJhZGxjQ1pPcjRpaEQ5Sy80b0NYemZBUStJR2xqNTNQdkJXajV3dnA0VVZ6?=
 =?utf-8?B?V09VK0o3TmJJZU5EK25VNktGaWFXT3dBL3J0Y3BnSHBmdVlPcklxRVlUN0VF?=
 =?utf-8?B?TFlvcjZFd25zWDcrZzYrUTVSQ3BkVUVJazMyU0pMLzl3Y2daTzNCUXB3YkRU?=
 =?utf-8?B?R0hTUnJCQm1rTjlnZnFhTys2ZGtrMUhKK1JuZ01weEZuZXJhSHprQ1d0TFVE?=
 =?utf-8?B?dTc2ejEvWEdNa2h3SEN2R0J3ZEl2SjdvRGpzaW5uaDZxdTlNOXBPcHBMS3BC?=
 =?utf-8?B?TTZZOHl1NHV4V2RicnZRK3dHNHM2V3RYNDI1Z1pHeTFEck15b0t3OTI3ZEp6?=
 =?utf-8?B?RHFWZGdGbi8rdkZMbTZPOVN6Yk8xNlpLU1daVE51aUlKSytUdXBrVHZTdnZY?=
 =?utf-8?B?VUwzOCsxTlY2aXVwN2RVK2tlbUdnSXQwbGM4bWhSNDFUalRrMEZjaHVDbVV6?=
 =?utf-8?B?TXdEVXN3dG90UUgzYUdVeHRCRnJkWFlEYkNSQ2xqY0Erb3QycFArY2xJa3Zq?=
 =?utf-8?B?UGN2RitHalJTbmxwNXNGWnMrNlI4ZDNGdkhQZzBDQ2krakFxN2xXTWFSQW5h?=
 =?utf-8?B?ZWRERzd1b1d2dmorem9HbHNnQkZSdGRhTm91dnJia3Fyb09VU2ZBYi90cW5Q?=
 =?utf-8?B?aGhGaHJXeHlVcEF0Y1RoWlJFQzl5amlHSTdGeVV5Uzg2SUVVbmtweEdQNnMv?=
 =?utf-8?B?UktmUmpUbWFCUTMwbGE1TlF5WktpMjJpQWV1Z0NHSzJmbjdtaXRoOGNCbnFt?=
 =?utf-8?B?ZGY4NlBJU3YzSWFUMTF0T3JuN1JiM1pWTHdWQWprQ2RvUG1mMWI5WW5hRmgw?=
 =?utf-8?B?RVpuVzFLWEo1SVE5VUwyT2RRVE1DN0JBcXFTUHc1U0UzajZ5RXE1eTR5TXVE?=
 =?utf-8?B?ZDhFaEQwMWpGUTU2N0pDYmpCaitJOSttT2E0OXZGY1dDQWY3RWhUeTFUaWJU?=
 =?utf-8?B?UE1CTE81aGRlNzk3QWpkTE9RK0R4TVdSTTBDcEF1bTZoWFczK1BpK1FiL2wv?=
 =?utf-8?B?VjNDcEUvTUpaVmtOSEJ6dTRtRURTaDUzMDViMURjQzdVQWdVVHpRWWlOU0o2?=
 =?utf-8?B?dFc1MHhjeGZOUmVsbUJvYTJtRHZocW5pUk5FZjZsekRVQ0hITk9xclA0Q0N1?=
 =?utf-8?B?RTNOd0N2Q0FkcFlYK0pjcngzbzVNdFc3MVdYa3k0cFlteXBjQy9TTGVRY3ZS?=
 =?utf-8?B?VitaY2ZqaUhqZS9QbVh1S25ybFZaeXE5R0ExTDhQN20yQmRINFpxQmxWd09h?=
 =?utf-8?B?RlZ2M1BSSTBEcjg1Y3d1NnFXQnhmalZ0U25aaUxHUllMaG1BMUQ5MzFScFl2?=
 =?utf-8?Q?erczP4fsmH//SoS/7uXmjjwrg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f567cc4-79e9-4e33-b730-08ddacd5ea09
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4262.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 13:01:31.8047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ij4+cwi8bn9sD3Z6P8yzaM3/DWQhtj62qZEu8ixfNSdVKWw2+Q/Qjm/l2UmhcmJ5LtHxIj0Jxeqnmrgj7aDrkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6718



On 6/6/2025 8:39 PM, Ira Weiny wrote:
> Paul Moore wrote:
>> On Thu, Jun 5, 2025 at 1:50 AM Mike Rapoport <rppt@kernel.org> wrote:
>>>
>>> secretmem always had S_PRIVATE set because alloc_anon_inode() clears it
>>> anyway and this patch does not change it.
>>
>> Yes, my apologies, I didn't look closely enough at the code.
>>
>>> I'm just thinking that it makes sense to actually allow LSM/SELinux
>>> controls that S_PRIVATE bypasses for both secretmem and guest_memfd.
>>
>> It's been a while since we added the anon_inode hooks so I'd have to
>> go dig through the old thread to understand the logic behind marking
>> secretmem S_PRIVATE, especially when the
>> anon_inode_make_secure_inode() function cleared it.  It's entirely
>> possible it may have just been an oversight.
> 
> I'm jumping in where I don't know what I'm talking about...
> 
> But my reading of the S_PRIVATE flag is that the memory can't be mapped by
> user space.  So for guest_memfd() we need !S_PRIVATE because it is
> intended to be mapped by user space.  So we want the secure checks.
> 
> I think secretmem is the same.
> 
> Do I have that right?


Hi Mike, Paul,

If I understand correctly,
we need to clear the S_PRIVATE flag for all secure inodes. The S_PRIVATE flag was previously
set for  secretmem (via alloc_anon_inode()), which caused security checks to be 
bypassed - this was unintentional since the original anon_inode_make_secure_inode() 
was already clearing it.

Both secretmem and guest_memfd create file descriptors
(memfd_create/kvm_create_guest_memfd)
so they should be subject to LSM/SELinux security policies rather than bypassing them with S_PRIVATE?

static struct inode *anon_inode_make_secure_inode(struct super_block *s,
		const char *name, const struct inode *context_inode)
{
...
	/* Clear S_PRIVATE for all inodes*/
	inode->i_flags &= ~S_PRIVATE;
...
}

Please let me know if this conclusion makes sense?

Thanks,
Shivank

> 
> Ira
> 
> [snip]
> 


