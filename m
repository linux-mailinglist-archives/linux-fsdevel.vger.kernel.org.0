Return-Path: <linux-fsdevel+bounces-41678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AF1A34DAA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 19:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB526188F2A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 18:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABDE24501F;
	Thu, 13 Feb 2025 18:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zuwFnwCQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C7328A2DC;
	Thu, 13 Feb 2025 18:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739471237; cv=fail; b=ray984LtbjBkx7PHR84VxwE6BLA3cDvnorH825OWWk0oO8NIChuq+ctq+TMasgmBgXy+20W5yLDC0vO7ohf6cNrn+uupks89wQ/NQzPk+gQu9f0oOIs2/47U3UNlfbCtxQKGk0zlgImTGMM60y6/DRNXt6Cwvb99Pij6AiXFxA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739471237; c=relaxed/simple;
	bh=y59wlxOKHeTQsKs21Xf8Hlb/Y8KXo/m2n+2txbmisak=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AFlmez1ip1C7vxLYq9Q/x3tdGzWAIQO4fkkX5eop8nQTG4n0/cIiFBMlbnViJOcTNfvckLvG4ns4qM1mXFdBiObxVlcc9wuNmwYTXegnvyzrnTEuh0Ywhxnv4GoGUwWYmdWARglzWy7JpyBmQzuFxZoH+WHzCLxrp7BjfE3ATzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zuwFnwCQ; arc=fail smtp.client-ip=40.107.237.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EKy8xwSDODFi6J+pAnwzhAizwgVERlH6xIgIMnuwtU9PqdNGS8j/ZboIj2Mek+wtJrAc5zvud+FYPHgFStW8ecEf56+i4zHE+amvTBiKZoiN/ZJvLBlRLdS+Mp0AJAlnu/+r6Rdm9ObdIrqs8M67LiqRwI34ODqgpxuDljxv+GRsT/wMnJ8UggNsS+BOTMzocDD8DJBuvVHNatwxaK4q4TtT4XPwzwDpwa3hWuVk2zdHbMiMluq9Iy3j7/Mtbcm5ggJMZqVUSULLIaNYFw9cCXXKQULFmFIMs8V3rPWjCyAu90ku4Q4BRtD4Mv0PNI6fylJNs7vJVcaMjgdlCf1Vng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CrHYkJbs6zx2ZvNskD0Be9wi1T78SVHay5UQZU0GQ6M=;
 b=GRF/xvo3cNBjWaNeyirVBx4IxtsJ/hkeqyRPAb2IYhFnwJNcCy93X4CGzELXHx6nvSWtZVfZBofKGsTinxwG9BSKQQARSqB1+G+YpDMYhgX2VzwL4dleSCot5Kk4rjqn0bZld6qzH3MEi+djgJ2Ir6+hqM2OcnFEiQhegd5pjilkwO8ZROgcmoeeuDuL9ihxbvLp64lci8Tjl+rpcVdmpt7CUMmDyNSO07eb+7jQW0i4M5SHhuNxV84urRz1GllJbyH7HFt+LM40FEPElJdE4yOjLAiwygyQ6HEw/Hq62arCXpt90l91aWWy6KOvi6aCEVZs7QZxn5suJeNY1iNhcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrHYkJbs6zx2ZvNskD0Be9wi1T78SVHay5UQZU0GQ6M=;
 b=zuwFnwCQ3msiLJP+3chke2kB9Efc+inkvL/EGZzIjovEyqDrjgLrmDj1dvp3MB6fIGqlh4qi189utrdsR49SS4LcfXWhd5Ubgb7qYzkTY6ZGPqjPk7H5NwXcF/kpTUJeSbXrzFb20Pmj57+ghkSCP4CVrmJx/U8dojvDQPeWgBg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8)
 by SJ1PR12MB6026.namprd12.prod.outlook.com (2603:10b6:a03:48b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Thu, 13 Feb
 2025 18:27:12 +0000
Received: from CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870]) by CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870%5]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 18:27:12 +0000
Message-ID: <d504979a-3f25-4a57-9632-5c17cbc2acda@amd.com>
Date: Thu, 13 Feb 2025 23:57:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 1/3] mm/filemap: add mempolicy support to the
 filemap layer
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
 willy@infradead.org, pbonzini@redhat.com
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, chao.gao@intel.com, seanjc@google.com,
 ackerleytng@google.com, vbabka@suse.cz, bharata@amd.com, nikunj@amd.com,
 michael.day@amd.com, Neeraj.Upadhyay@amd.com, thomas.lendacky@amd.com,
 michael.roth@amd.com, Shivansh Dhiman <shivansh.dhiman@amd.com>,
 baolin.wang@linux.alibaba.com
References: <20250210063227.41125-1-shivankg@amd.com>
 <20250210063227.41125-2-shivankg@amd.com>
 <76537454-272b-4fbb-b073-5387bbaaf28d@redhat.com>
Content-Language: en-US
From: Shivank Garg <shivankg@amd.com>
In-Reply-To: <76537454-272b-4fbb-b073-5387bbaaf28d@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0240.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::17) To CH2PR12MB4262.namprd12.prod.outlook.com
 (2603:10b6:610:af::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4262:EE_|SJ1PR12MB6026:EE_
X-MS-Office365-Filtering-Correlation-Id: 23cd70d5-b511-45dc-4fc6-08dd4c5c08b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SHN2R3B1RFpWaXR3QmRjV0dua2kwbE1uWHRaUjAwN0MyMTR6ZzJFdGJ1aHJF?=
 =?utf-8?B?Q1dCenFqK093azM2K25waHdaOW1Ya0JuS0hnenhCVlJXazNENlYrdTNQRTcy?=
 =?utf-8?B?T2ZiOGZEeUp5Y3laVmFhWFpLRk9zOWlYOVBqRDdlYVJwYWgyd2JPZEFTUC91?=
 =?utf-8?B?dmZzWUZtK2dmNC9UMTRCeVlhc2RoL0kzVmpRUEwxMUMzdGhyV0VJUER5UytD?=
 =?utf-8?B?eTRTQ1N5WUlGVnlkbDJNSHpuaU5obDhqbS9lU0JGZzdqakU2RGE3VWY4Vnow?=
 =?utf-8?B?QVlITDF3MUpNTXpIaXJMbmV6Y1Bpb3ZYS0xBajUwRkNwNU0vOE54Vnl0QmlV?=
 =?utf-8?B?SDRPdGd1c1RpWWxNWDlmamJoRkZVSEVEMzNwOCtBMXpzSXdoRFdiVkV3ZklV?=
 =?utf-8?B?Y2pjeVdSMGFaa3ByQTRwbkxZdXo1dUg3WklYYzNFM05lR2NNTXZMYjNtZWY4?=
 =?utf-8?B?YzNLTytYZThIS0hzSnNCdnBDZVY0RitjVGlTa3Awcm1IeEtnQXlJSzRzWDNN?=
 =?utf-8?B?akNIRnE2S0F3UzNGdkNhOWhjby93Z1lUSmRtdUN0K2YvbHU5Y1hxQ0ZyK2x3?=
 =?utf-8?B?ZU1aV1lMR0JPVmRvRW9DNjFmNG1oZUJhNmUvSUFmemVxMnliQ0RHMWYvQTMx?=
 =?utf-8?B?dy8zT1UyM1JlOXNOS2x4MjJGUjJqVDBhWHZCcW9QMkVBWG01ZTg5ejd4RVZY?=
 =?utf-8?B?S2lvMWJPYXAvWURqVFYyQ1VuUWVyeG1qL1NTSlE2UnZCcHV3Kzltb1VJZ0w1?=
 =?utf-8?B?NEtxTU42UzF5SDEvV2xCalMyYW9hYU9RZlg2ZlRnZXJ6SkQ0UlloOWJDVXNi?=
 =?utf-8?B?UTd1em9uNWVYVTBIN1QzcVoxaDcwMm5mNXdnVlREVHhQVUVmRmVrUTJQYkpw?=
 =?utf-8?B?YWx4SjQ2dUo1em9kSlU3b0REYUU3U0dUYXhPT2pWL2RkdmYrY0t5NXVlbnAx?=
 =?utf-8?B?YmFsNWE1MkRudVlSNFBwN243Y29lWHRRQzJ0YUkvZHZydm5rWUZHZUhzT0dC?=
 =?utf-8?B?VjZjL2tmVWNVVWlIUUxCZFlTVjhyMFdTQWVFQXZPRjdmTFVPdTcybW9kSm53?=
 =?utf-8?B?M2ZQb04rVkc5bEduRTM4RXFlcmF1dnNRcGE3T1hTMXpON05MeEZrWE1MZDRU?=
 =?utf-8?B?T1NmdVJ2Z0t1T2xWS3FWaG4yTkpyNTMvNkZGamdtb3Z2YWx5UHRMNFJwcEY5?=
 =?utf-8?B?YVlvTHJXaEZha1FqMzVvSEJXK1JCSWJaMURmVGFWUkMyd043UjhiS1RHalRs?=
 =?utf-8?B?NndRNUJTdDBIUTVwQkluRGV2OTZZUnFoei9tV0VESlFxMFFlRnpaSlBMbEs5?=
 =?utf-8?B?Nlh0aFBnNDVub2FJckY3M2praXU3eWRoRFZKRzMrbGZzKzNRVDZ1U0cwbnYv?=
 =?utf-8?B?UGZvZHZpMXZxVHlnekcrL2xiM2JySmRla21OOU01U0hGWFFRYnM0S2grR1R1?=
 =?utf-8?B?dGlJbWpnTVR6b01TdXZWcEM4dzc4Y1ZsaHdLMTM0SmZQNi9qU3k4elJmam4w?=
 =?utf-8?B?eG11VjFIbFAvWXQ0VEYzU3RxdTUzVlBobGtudS9YVzl6QjdYVU05M2dNWXpQ?=
 =?utf-8?B?ZFFoZWRhUnhWNDh1V05jUWdOaGdBOEVldXZ6cHNFU3hZT005MnNmbmVWblI0?=
 =?utf-8?B?M2x2aFlQNnFxNDM1YVdwQnJrWFlPT2MwUi9QeE9FNTR3TmY5Z245OUdmUVZC?=
 =?utf-8?B?eWlkczg5NGVFTE1zZHRkS0VlcGRsRUQ1KzIwZFpOMmd4NTc3cWdRekVUTHZa?=
 =?utf-8?B?SkkvWTFRaU1MNzJGMUUwY2xLOUVINVQxSjBMVFkweGRHSm5GQ24rZ2h3LzMv?=
 =?utf-8?B?T0ROeWl2ZkgxUThLZTc5c1lVZjRCOEtEMGlxV1VidlU5K0ROTFd6WTJvWmxB?=
 =?utf-8?Q?C2+JnOcIKV3rZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4262.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THlYS2JWT0paL2NxQS8yajdXWXhFSWpGREJwOGY3aFZ1NkF0ZFB2WUlreTR4?=
 =?utf-8?B?azB4OHBPaHVFV1pXYnlKM3dPMDFrNlFiUVNSOS85L2FXWklsSHhNd3h6Vk5G?=
 =?utf-8?B?V2Y0bWYvcGdsNmN6L1htellITlZtdXVjaWM2bGtNZXYzdjh4cjc5amJ4aENS?=
 =?utf-8?B?ajRETERKVC83VzUydW02VENrVUtSMklBeUg5Q1VId015MzA2VUtENGxiUUtB?=
 =?utf-8?B?WlNZMTZvUE41bjdaNExoYTJpcm5xblVNR3Fad2FybE96RTZUMG0zai9ZakxX?=
 =?utf-8?B?c2lOeDl4eWRhT0k0bnI5NWM0VnpyYm5LRElNNGhjc2JRVjY3azR4WTlndUFw?=
 =?utf-8?B?Nk0rbDRPZm1rcXNQK2wzYXZodWFKU2xSWU9EZnJ0bUZlY2ZUTzhmWUoxMUdt?=
 =?utf-8?B?Skp4S2R4aEZPTkpTQ1BoNVRpTmxSTFVzeWZjMEt0ZHB3aDhQekZ4cmJCNStG?=
 =?utf-8?B?dEJ4eXF4ZTR5bTNiSGtmRjkzNDJITU8yckFhZjh5MnVLQmlTeEdGK1B6M0pj?=
 =?utf-8?B?c0RKb0tzeHpVdldYWDEvek1PbmVhVS9xQ0RuZllMc0VrWVJVMSs1aElPUU9k?=
 =?utf-8?B?Yk93RHZzZVFtVGd0MUwwVExMdksrcEhNMmZRaStEdVU5d2tLZTQrRmc4Nm9S?=
 =?utf-8?B?RzlxY2hzRjVSVHRWMStsM0UvUXBaQ2QzQmxzZUNkNnlkU2R4Z1NTRkUvQkcr?=
 =?utf-8?B?Vlk0SDhkdmxVR1ArTjVoVDh5Q0pHOW9mNHFjVklJZkp0SFZ3bDJMcXFaVzZo?=
 =?utf-8?B?R2Q4RWowdHd3d1I1VVZsRFo2N3BDUmg4SDRiOXJJZHduNWdSVVF5STc0Y014?=
 =?utf-8?B?eFZoaVNGTU95a3lFQjV0cjhvNzFNdTNLT3pSM1pLRm9TNVFMQ1M2ekRHK20z?=
 =?utf-8?B?S0lmVEdDb21oZXIxU2FTWldheDZwbXp2UzV0WC9YTTIxcW9xbUFMcDhvQWlu?=
 =?utf-8?B?cmtsblM5bTk2TTJMV0RDT05yeTNqcWk5YllIWjlNRm8yclpkVW9INVU3OUt0?=
 =?utf-8?B?dDRCMWFpb0NWakc4aDlHVUxvcVhybERXaHBWRExBYnlwNkdMMUpUNkY0ZjFs?=
 =?utf-8?B?bmpoTFMyZFltaFJOSXpKSHV5K0xUQkpmTEFzeDZaNzVITlpJMFM0Y3pxNFBa?=
 =?utf-8?B?a2FDeU5DRDA4RHQwNmQxcWxEM0hna1RJU3VyZUsyRlRMeUgrcXFkZzZkcDkx?=
 =?utf-8?B?M3VaNE1hZHRSL0h2WmNaY1MzcTJjTXlqQzJGUDBTeWFLbVNjUUxhN29KaWsx?=
 =?utf-8?B?OFBKQ1ZnUjVsTk1Gd0MxWWhHNFd3S3NacDJoUExkQlB1Mm4xbWJpUWtpOFpZ?=
 =?utf-8?B?R21uWE5VUC9MaVlRRWUrMmd2N3NXbW0rSCtLcVcwRjIwY2RQTnloNXJnZVBu?=
 =?utf-8?B?RTdrZW5jYjBjbGtYTXEyOXdxemdzY054Mnk3ellhVDY0TzZsV0V4N1A2dHR4?=
 =?utf-8?B?MUZqMlZFcngyenlsWHY4VFpTRUlUYzFnOXlmSTRjeDAwaVA3RG9xb1htcnJa?=
 =?utf-8?B?QUVkSXdPbEdkTVpLR25GeTVZdWtUMGk1cFMrNlN1ZUM2dXYxeDduT0hzZ3B1?=
 =?utf-8?B?aXhDbjNyT1pBM1djQnN6MXpBYXZPb2FwN0VockhTOEhDL1dOUG5rclYzamFQ?=
 =?utf-8?B?akZ5Q1dOVk5MdkY3RytMWVlvNVFISXRib3BxNmI0TWxNOTV5UTMyeWZnTGFu?=
 =?utf-8?B?YmdQYnlPRG5lZEJRT2U4aXRKQk9kWWRhTWpjWWNmV1VWdHBwTnBXVnV6b3Z4?=
 =?utf-8?B?YnZkNnNUZ3VLMjdCb3NGYUxoWjh3Y1hKSHU4ckFNTTVFNVorSjQzekUzZ0h0?=
 =?utf-8?B?Yyt3MzFIYU1SQ1M0eitiYy9LVUM1NHpGNklSaFhNdHZJTDU3VHRreitCeVBk?=
 =?utf-8?B?L1lYS3Jhc2JvRWNrRUtLVEFtaG1KSXhhVFJ2bEkwdHBSSzJOdlVIOGNFVXpi?=
 =?utf-8?B?ZCtFSFlZcmpxMmsxVXE3SUcyeFFzcVFjK0FKRzU1UXBjdTZkN2twdlRaSjR5?=
 =?utf-8?B?SHJDMlBzenNhS2pwVXZyeHhJQTlCMEduUnZFcWRrMDM3b0s3UXNsNkdOclFx?=
 =?utf-8?B?b0J3a3hoQ0MxaDIzWTUzUTlURWRoQ09JS0ZmSUJqRnRZc1NJOFdBTTM3S3dI?=
 =?utf-8?Q?bIpsSIYeBUidFIszPDFKf1Usr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23cd70d5-b511-45dc-4fc6-08dd4c5c08b3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4262.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 18:27:12.7855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MVZvpxauYbT98fOPxR/3mWIaxu8igz1biuj9dpMvxyGbAfx6Wm0ArytC6S9VY3/ImO+bFTlj65Nfohi91SNMxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6026

Hi David,

Thanks for the review.

On 2/12/2025 3:33 PM, David Hildenbrand wrote:
> On 10.02.25 07:32, Shivank Garg wrote:
>> From: Shivansh Dhiman <shivansh.dhiman@amd.com>
>>
>> Add NUMA mempolicy support to the filemap allocation path by introducing
>> new APIs that take a mempolicy argument:
>> - filemap_grab_folio_mpol()
>> - filemap_alloc_folio_mpol()
>> - __filemap_get_folio_mpol()
>>
>> These APIs allow callers to specify a NUMA policy during page cache
>> allocations, enabling fine-grained control over memory placement. This is
>> particularly needed by KVM when using guest-memfd memory backends, where
>> the guest memory needs to be allocated according to the NUMA policy
>> specified by VMM.
>>
> 
> shmem handles this using custom shmem_alloc_folio()->folio_alloc_mpol().
> 
> I'm curious, is there
> 
> (1) A way to make shmem also use this new API?
> (2) Handle it in guest_memfd manually, like shmem does?

(1) As you noted later, shmem has unique requirements due to handling swapin.
It does considerable open-coding.
Initially, I was considering simplifying the shmem but it was not possible due
to above constraints. 
One option would be to add shmem's special cases in the filemap and check for
themusing shmem_mapping()?
But, I don't understand the shmem internals well enough to determine if it is
feasible.

(2) I considered handling it manually in guest_memfd like shmem does, but this
would lead to code duplication and more open-coding in guest_memfd. The current
approach seems cleaner.

> Two tabs indent on second parameter line, please.
> 
..
> 
> This should go below the variable declaration. (and indentation on second parameter line should align with the first parameter)
> 
..
> "The mempolicy to apply when allocating a new folio." ?
> 

I'll address all the formatting and documentation issues in next posting.

> 
> For guest_memfd, where pages are un-movable and un-swappable, the memory policy will never change later.
> 
> shmem seems to handle the swap-in case, because it keeps care of allocating pages in that case itself.
> 
> For ordinary pagecache pages (movable), page migration would likely not be aware of the specified mpol; I assume the same applies to shmem?
> 
> alloc_migration_target() seems to prefer the current nid (nid = folio_nid(src)), but apart from that, does not lookup any mempolicy.

Page migration does handle the NUMA mempolicy using mtc (struct migration_target_control *)
which takes node ID input and allocates on the "preferred" node id. 
The target node in migrate_misplaced_folio() is obtained using get_vma_policy(), so the
per-VMA policy handles proper node placement for mapped pages.
It use current nid (folio_nid(src)) only if NUMA_NO_NODE is passed.

mempolicy.c provides the alloc_migration_target_by_mpol() that allocates according to
NUMA mempolicy, which is used by do_mbind().

> 
> compaction likely handles this by comapcting within a node/zone.
> 
> Maybe migration to the right target node on misplacement is handled on a higher level lagter (numa hinting faults -> migrate_misplaced_folio). Likely at least for anon memory, not sure about unmapped shmem.

Yes.

Thanks,
Shivank


 



