Return-Path: <linux-fsdevel+bounces-76655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNEkE196hmm2NwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Feb 2026 00:33:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE5E10427C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Feb 2026 00:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4AE6B303CEEF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 23:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F8B30F535;
	Fri,  6 Feb 2026 23:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="imdBa5MG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XGW1Bqpo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9341123C8AE;
	Fri,  6 Feb 2026 23:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770420823; cv=fail; b=Q/KDlTsiIm1XkwFzeG1l4fWDIdA+9UP2Pk/9rpr8cAsOJrtPC9ZlAaO73lEOr3nhpUsHPthSy6EGlaUgCpJrd5F6sRTDMbKzcS7zAj+YF/89sIJZ/5+YhTzykQ41W2TDFGF5ZYi2QbbGQSh8ODPQWtgFxH5Cqd4aIf16Ls3gK48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770420823; c=relaxed/simple;
	bh=s46JH5kl6NM6l/DHwWVxyOqaYP2LqXhPpKekgBTT8UE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NHYyI+e36HRD1sZ3oU3v6IDkQebumVxLL0CfLTzRNU6ncRqt90MvhHOOt4YRYryF0FVNuhNCK9ewq4qgldnY4q+q46DbGn6kJfpjlJUZF4ywzrgJKcBvancZnoEA+MMV9pxdH88dZ1z6w8Pkw/4k5vO6+QNWJYSLSv2yqOuBd+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=imdBa5MG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XGW1Bqpo; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 616JuvrZ4059701;
	Fri, 6 Feb 2026 23:33:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=KnCCHwyI1yUVdD81lR8VH4Pn0wehLUkGTXWHoQ3FsZI=; b=
	imdBa5MGdhF0piM6P2cpy50SfA6yjzXpR6cDRPq+v4xRL5vg1BpVEwNg3BqyKofh
	UQpZlXEAE+H/CAIt5dLS8TYmvOoTpXo2yaw4lkKIXIl5HVZOd9HeeMpPh/cjL+uO
	Y2Mq/B5Bw/i+/adCaW5nX4LY0GD+W3c9TsERckgIwZWTkhQw23KqeM0SzC0/x0QT
	JQhBw2OoHzG/g1AO+JeP59g2g7zmwVEA7f+MubkemsJhumE2aQCH6bojLg9UTmrx
	BriFBKDQYA0yLph096WdIxs/RzEjCbVRTzKlCfl1NShEruXKhobackDA4in2v4jL
	PyOYu6e89teNerpgaN8maQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c3k5g66d4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Feb 2026 23:33:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 616MFLb6040060;
	Fri, 6 Feb 2026 23:33:22 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011057.outbound.protection.outlook.com [40.107.208.57])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c55gcs98p-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Feb 2026 23:33:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=luC275QhIGmTf+fr90veb+8hYZz1GCtTng9z//Lkdus77P+wwat500007mQTgvdwvjpUmmU/gyXnrbOijbVH+0LYhfeQnJ6kk+AGt66EMs85HCmtidi5mtHt01J1pRqic47b6IhtftQFL97YMZVAuIN+sUCayfCq5GzSyOMG8O17KqzGFJJnDUkXdcUkAb+RCjz86MoZO0cmvsBXan3O8PM/mLN6rWYp2CfIlkeNkyo4R0168tE531kKv+ft1cXulihsFfByMzPW5MhoyqpIdquMMs/7G7Lw/SoHf+ZXqPZbeja7snlt2pwdvfmrZpXzdNjrsR8WiMQGOgC2UHUDFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KnCCHwyI1yUVdD81lR8VH4Pn0wehLUkGTXWHoQ3FsZI=;
 b=hI74bMpRc4Qk6lpe3AmT5pPndxBkUniU+w/j1qUpPEQ98OU+jgseV2q+7/FuAyCEku5yInJHgm7gWPoIX62a1Ml5OkTnpGPl9VWh120Eh9A/bEHRcc/WzYZAUaQN5TYbegFO5W0laglMxRwurOvI80RvSOftShXhXEWrPPwo6FrCsLV+5h2AT16ZxJmAQsp7X/omcxshHOY9I06Y58Ll0sDSLWezGSFk6HytKrceT1QqKZTjnBnjYOsgw4l119XjVkRNx1pgHTjMQQpBHbGuxZ0wEVa/gvEJ34Pi7YO6EN4oLr/5PYLAW+4fuc75mTVq7mi+fJ0rZYl6j2T/R0yCug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KnCCHwyI1yUVdD81lR8VH4Pn0wehLUkGTXWHoQ3FsZI=;
 b=XGW1BqpoHpofHHzx5zXT4ZtCA1fRdznlOPb+gVI6F2ClYXC+ldUu3vcveVBuuB+1lkADHbEn3WfAt4zgla0CgD8fqmS7V31tT50orBN2w4Jx3azODh97yEcFIVfyp+Eu1WcgbKf7v6mEmQNsDPrrY58YwpQyPFqdZ000D3Boo/o=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by IA1PR10MB6267.namprd10.prod.outlook.com (2603:10b6:208:3a1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Fri, 6 Feb
 2026 23:33:19 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163%6]) with mapi id 15.20.9587.010; Fri, 6 Feb 2026
 23:33:19 +0000
Message-ID: <623f06a7-4e41-4703-95ef-b3476fc4549a@oracle.com>
Date: Fri, 6 Feb 2026 15:33:16 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/1] NFSD: Enforce timeout on layout recall and
 integrate lease manager fencing
To: Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com, neil@brown.name,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de, alex.aring@gmail.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20260205202929.879846-1-dai.ngo@oracle.com>
 <9194ce4db4391c0e6428f97b05fcee53706fb485.camel@kernel.org>
 <6a28e81b-1e2e-4457-8bec-4312e6d3246f@oracle.com>
 <3cb09bd01df3d43293f2f443ebb6b4a10ea50dee.camel@kernel.org>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <3cb09bd01df3d43293f2f443ebb6b4a10ea50dee.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR22CA0011.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::22) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|IA1PR10MB6267:EE_
X-MS-Office365-Filtering-Correlation-Id: 42d9ae77-b2a3-4707-7f93-08de65d81bd5
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?b2JRU1BPRU9qRW83Z0s2c3IzZGpEM0ZicVovWkFYNTB3M1Q3SmhpMEJKQUU0?=
 =?utf-8?B?RnJUVkl6SmNVUVE0eEZ3VGZxbXRWdzFxYWpiQlEwWUVrME43aWFUS2xubXJp?=
 =?utf-8?B?QTdYV25uNU40TGdXYWprVDlGWjlqbmtSZTQ0eGszUnFqbE94bEVHcTFEaEly?=
 =?utf-8?B?OUUzamovb1IzWEdmL09La21WeUF6THhSU3A0cjB6UHBjdGZJVHBWU1hMZ2NH?=
 =?utf-8?B?cmxQWnBUZjFHSUprdkxqN0JXMnE5RnY1dXdtbVVkaWtmOThDNjlUSUM2eWJC?=
 =?utf-8?B?aU90SWNFNFZEd3RCWE5paDlxRm12eG83S3YyZnJKb0VBNy9VcTVOZVQwTmw5?=
 =?utf-8?B?SVpXdDBVUCtHKzU0Y0ZjRnFkS3NHUks3TmE4WHltay9UcU5uNWJVaVk5Wlc2?=
 =?utf-8?B?Vm81Ym4yNXhjM1dhQjk2MmdleGxjUWlEaDRDOXgzcWtMNGZ2d1o0UGVrd2Zs?=
 =?utf-8?B?NThkVDBubitGWjdwL2VnNncyd3NzSFREbXhYOThqT0tzMm9Eb1djZWpFcVM1?=
 =?utf-8?B?c2luZlBDNlpOQUcvMVQ2TmI3djJXbWRZWnhkYm1aV25zRGFPM0dDR1VSSnI1?=
 =?utf-8?B?d1EvMVliNHBTbWdLVW9hV2FiRk9QY0luZklhbER2QWRYRXJjNlVVVmF0bHlz?=
 =?utf-8?B?aEFLSktkN3NUZXNHY29sVFMyaWNYcHJXVzArT3Y5dklLSlFBMzZ0VFJHdWFy?=
 =?utf-8?B?R2wrYlVhZ0Y0dGM1MWdPbnZrWHZpSFgzQ3Q1UFVwMlFhOUxnbG5jUTgrNysr?=
 =?utf-8?B?TzhYUGMrZDZEVVQ4eURieW9xU3FrN2k2bHV3MkJOQ1A5VWsvckpIQjZvRlJY?=
 =?utf-8?B?UGZmNW9MMDQ5VEdhamNldDFqUk94bWo5aTE0ZXlsa2tKTDZselJjbXZ0WGp2?=
 =?utf-8?B?cG1KZDJWanVhcnA4azAzNm9ETVBKTVJ2aDdXZUtiVWJPbGRXSmdLWUZsT3RL?=
 =?utf-8?B?d2FRTUxQWHhydEg3OFd4Vmo2QnpzRm11cHdYdndoN29KZ0krN09tVVFHTjJ4?=
 =?utf-8?B?YVp4UTZRRnpUVmpabUcvYzF1dXhVdFVPNVVlQXhGQUpUWXlZQXJOZi83Rzlm?=
 =?utf-8?B?UFo4cy8ra3RyUW5qZndIM0lrMkg5Zm81RWhia2hBTExmanpiZ0NPcXMrVndK?=
 =?utf-8?B?VEthWmJlT001b2dvdHhYNEFram01WlkvbTdlVXR0YVFRMzJnV2FzNEc1Wi9B?=
 =?utf-8?B?eWo3a3AzM1M1Z0hqNVo5SkNXZ0Q3dkVxeXBqNm9SeEhXVlBHN1lkanJHUEpX?=
 =?utf-8?B?N0RmUEkyV0dYZXBtNW9OeFgxdDUvaHltSlVEWFNoS01JTnRha2hlUUV0ZzZJ?=
 =?utf-8?B?TThRcGRjMVNoY2tPMnZGZWJhZFdSMUVjSkZweXBSS09Hb1NKMEo3a29Nb09n?=
 =?utf-8?B?cGdOeWhNcDJrMUFrRmlmcjVLU3VXVG1BRHd0c3Z5ZkE1Vkc1MWJIdG5LUzh6?=
 =?utf-8?B?NHZWOC82T0pNRmV5ZFhuMU1jREV3NlpaN04xT0dYbitHYmR4QmNacVJPZHFN?=
 =?utf-8?B?Vnc5QWZaV2RUb0h1SkhEOSt3SWFTWDh5Zy84ZzAvZE16b1VvdE5IRGwyTU9U?=
 =?utf-8?B?UVNHcm54UkJhY1pqTDcxMnZ1OHo5SjcrOFE2RFpHbHBBWVpaa2dlOEdsQSt5?=
 =?utf-8?B?QXZlYk5BSWhpV0pRcmY0TVUrRDMvbmNSdFdyUzZDaFQrVTVEZEVGdlkwMzJn?=
 =?utf-8?B?NzJnN3NqanRNVGlRZ0dzQUFMbEt6THFaa2ptQTMrM01XTmdrRXFlMm91d3Zk?=
 =?utf-8?B?TEFHdHJENWlXU3JRa0QzdWNja2ZEQW42MDh2OUF4MEEwcXc1ZThiUHI2TmlM?=
 =?utf-8?B?Tlp0dGtReVI2c3d4WmFJcVhuekNEdEVZMlJ2b3FYaGtIVFdlZjc2MFVLcnJF?=
 =?utf-8?B?RXR1SnA1OE1UMEo4OTc5RnV2WHRuYitLNS9FMThUOGdianBSWE1vbmZTZm9y?=
 =?utf-8?B?aUVzN2tlTVIyTFZzWjA5TUdlQ1Nrb3lQWkFZQUR0eU9vYTY2SjJLeHVqUWVy?=
 =?utf-8?B?RlIwakJlYnovSUF3dEZLVnRhaHdRQ2dkZGlhUnlVWi9vSkZBYlNjN3JoQjNI?=
 =?utf-8?B?THY5cWFSMXNnWFVHRnN2T2FmZTBkYWVobDhRSWplWHQ1RTJnakZWRERRQlR1?=
 =?utf-8?B?UnhuWVBnckh4SnZCY0ljSU5INmFTMThSUU9XY3QxcjlFRGF6aS8wcVgwTVk3?=
 =?utf-8?B?S3c9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Ly9lZHlsNWp6RVRtcmVkeEFWYUQvaitLcXZCOFlBdSt4cndJeFphcHFJaUlL?=
 =?utf-8?B?aXE2azc5TnFUVUkrNC9rQk81Zkcra1hkeFdvak5VajdSTEJ5R2ExcmVicmMy?=
 =?utf-8?B?akRzWWgzMHV2Q0lNRVZZajFBR3Fvb3FPTHJiM2ZhTXF2eVNXdnZmTjlmSDFv?=
 =?utf-8?B?SDF6cGllZ0VERGNGUGFYQ2Ura3dna3ZtdElaMW1lQjkxOFg1U0xZS0lLU0x6?=
 =?utf-8?B?OVhVaHhPTWJNNVpUclpTSGFtWU5ZTG1kb1RDR3pkSVVweVJlM2xXa1JVaDJy?=
 =?utf-8?B?cFYveEJKMUpTOGRwMi92Y21tZEExS29KZFRDOURFZnpva0YzYnp2RDFVM2VJ?=
 =?utf-8?B?Nksya24yTkpoZTZKbUF2VVhmdmE2VkZtdlJONW9LWnRCcWM5RVBtSUFPWFJ5?=
 =?utf-8?B?Y0lTMFp6bXZYVWFzdmZaMUIzTHlGY0FQY2RDUXgwT1plb2VvVFdkSlQ2U1hU?=
 =?utf-8?B?a0h3SFpVOERIb1grSjBieTlUbG0xTDhiYmFPekpYZUtKNXFBY0xPVDg1Y1JR?=
 =?utf-8?B?T1U2S2hBdUl1eGIvYlA1MU5PZDZNdHp6d0JpV3VCUG5LRHNjSDlCT2JLMW5u?=
 =?utf-8?B?aGdvZmhJZWVyMnI2c1BYcmNOb3JOeHZzYW9BNzdRVjdSNU9ucUNPSlh4Ymla?=
 =?utf-8?B?YUhub1g3eDVpMWxKbHpZOEdxRGJCNGk1TUpPR29HSmdHNGp4Ukc1VXpBRmw0?=
 =?utf-8?B?dGJjVHB2M0dNVnNoVEdXTk11bVgvM1pNUnBSMWZ6SnBLVXRXNmtWbjQ2QUxy?=
 =?utf-8?B?V1lBbnUyaGlmZXdHb0VyNStQejBHS2JlQTZLNCtSMmg4bFpWRUFrRC9vUzZv?=
 =?utf-8?B?K1FLN3lhZWhjenNaZUJOTklxMjZlTFhYalBJZmlCQmFWZ1labFlqMEZFU3Vw?=
 =?utf-8?B?TXlGclJHRUZ6NVVmWTFrWlBEZ2s3K3BIM3VaYllLSEhTbWJtenVaclpLeU5F?=
 =?utf-8?B?RFcxRkFlNldIYXJ1VkdGYTMrRGxJR25aTXdhUkRSV0diVjAzN3FEbysvR05k?=
 =?utf-8?B?TUxpakpveEsvK0pYMlhnREFSZENMOHlaeG52bVBDZUZqTjJtQTUxVHVtd0xu?=
 =?utf-8?B?VUsvNWs4TnhPTmVaNnUxb04xVG9CamRXVW02WVhqUFBRRHYrMTl3SWx3bzJR?=
 =?utf-8?B?QzVmb1EyY2ladTZIQ29hQ2xpMUFVZU5zOVdDZGh0Wit0NEY2bU1mZ08zdGVi?=
 =?utf-8?B?T3ViYVAxdkFHN0RsUkJFQ1BGaDdQRTVKVCtsN0l2MzlKeDhqcnBiT0h0QTVu?=
 =?utf-8?B?YUJ3Z1dEWUtlSTE1eXY1d2JQSUxkSGkrRVZ2QkFyZWh5QWQrNHJQYktsVi9E?=
 =?utf-8?B?VEt0NmFnOXR4NEgrWXh4aHpRazVEVXFlWVZWdmNEaUFEMWdWby9PSVFnT25V?=
 =?utf-8?B?eUgvRTBvc1ZyVk9mL2h2d2ZiY251RFJ3M29wQzNQUEg4VmltaFZubk11R2hT?=
 =?utf-8?B?UnhqbmFGSlR1SThlUml2RS9qV1pnckdGZk1zaXJpMVI5K2RveHh1b1l4cDQ3?=
 =?utf-8?B?QkNRY2t6bU90NndQQnIyVTBpRzdIcjdQMldTSkFrZXMra2NMTFN3K3dpNVlw?=
 =?utf-8?B?eEc5QndYUWVWYWduRXNVdUs4Q2tyMFFSUmNHQUJqTjRuQlUrQWFXMHpCOVZl?=
 =?utf-8?B?MjViOWNXejRqbWVEWTJXM0ZhUHRteHQ3d0YzQk9XOFErV3pTTWZEcnBVM21R?=
 =?utf-8?B?VkRUSzcrcEFIZEwzUExpUzlxcytzQklwVEpYQ2YzSUlPRzRDVkU5SHBqMUd1?=
 =?utf-8?B?Q3hEYzRoTVIrRVY1QklBcHJNcXQvQXp5Z2Y4ZWFmcXdsV3ZoT21OcS8rWjQ4?=
 =?utf-8?B?YW0wWXBXT0U4RkZHQ0NYeXQ4dXNYUXNwbkNwa1JZclNoSlE4MUFLTVpVTWdT?=
 =?utf-8?B?Z0ZTTmE3QnN5cUtHUWN4OGFldnpsMlhSRFNyTjNDZ3Vyd1dnWDRhNzI4b0Z1?=
 =?utf-8?B?UnRHcGNNcDE0eDNNQjI1R1VjQkVBQ1VxOWd0NlVLVUJzRGpuS0pXNXYxRXNK?=
 =?utf-8?B?K25yQ0d2UXVzUmppaTRJbVRkN0tmWUJTVWVvTXV1M0tCaVVNdkVNWWg4aGVT?=
 =?utf-8?B?cStvS0FKMklvcXU1d3RRQW1QcmFWR1hTM1E2ZG5BclZnRnRpQ3FhUC9IcHFy?=
 =?utf-8?B?ejBzRDEwaS9sZll0NFZpdytOSUV2OGV5WEFPT05haVNpSXJ6SnRCNWpyejBL?=
 =?utf-8?B?MUk0U2xOSTNVZjhydVhXWDB5dzl3K2xXVkdiWk91ZnJFUTJMNVFaYU5hMFp4?=
 =?utf-8?B?aW5RZTl4cTJtZHJuYTBpV2R6TDd0bU9JdDBHRkNEakFXbHpjc21vK0h2Ylpa?=
 =?utf-8?B?L0plWDJDNWplSG5hVW5MQk52RWcwalBPQmhLcnFWUWhkNGMrV2RTQT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ODn++oJR0DESfqFCPNF1PpaCBEl3U7bFkwPrAswnzDzMknFV9TcosgJKIiP3sR2/sPMtnS0yc4ej3NQRTP6jWRX3PQwmkyR8O1i1tux9n5o+zGqq8+K54W26WUjcsFDE3tVCz7yYDQW7Nj3S3Og024LHG/517Sqp3f5AbOVvUtcFoDW9h4TVuKluVH7aN2a+WZmXce85RCk4YgcPpQlFKkMNkhkv9AB1WS6GRYpotXfmn1AIjGXAL0pTiNslk6ukHwMeAk+BTWuvDVWLQi9mwFj5dLzTCbqi43HgVhXiQFExIct/vR+H+W5kOqsqNn7a+lVPA6ZWaARz3OVMJ17rPBRTqA6BArEYt7ctIsa+Ea8ggAYpgJYQr0DKnUXu7UQKBRrt/g04OY2A6xVbxdMSJJcLf+fY5TxFFsHt7brku/eW4P6fgieS1E8RX1lohxn04My6Z79wMRQk4f+2eE+H+vsOdPbAXOeDDMU3d/cM8vnpuOT1+6zP+Wn6zvHmLZoVY0V4ymusRMEB6HF7HH3peRqIj2tMHQZVWvL1ySoFZM/5m+4w/0Bg1z0wxuS5FLNvzAmNk+zQdb08/0RRmrMfGo9OozhyFD5uiYsu0lQrWNw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42d9ae77-b2a3-4707-7f93-08de65d81bd5
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 23:33:19.0250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m4WP8V7J5HytMSAdDEV1pQSHz31ZZcdi6sAq721qO1a0TDZEIvHNXrdh38MNzeAVzbe1WMKraibD/TxBG5tUXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6267
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602060175
X-Authority-Analysis: v=2.4 cv=Jor8bc4C c=1 sm=1 tr=0 ts=69867a43 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8
 a=PO6JFFxItnpbWbqMbeIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Tgp6iDTuTeha1X288ORbRyTaH4SSnZqO
X-Proofpoint-GUID: Tgp6iDTuTeha1X288ORbRyTaH4SSnZqO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDE3NSBTYWx0ZWRfX3bNBE+7QXklw
 iKS/Kl6i8df/LLgEpoPrc0CwvbJZH4FQN85Q9qnaQH3yY8wzATMyBEMU1AQ1i8Oc3b9a85X2Kyj
 GK2H0CadkmnGb3XhMUT7gN7nlwz+YlcuixKZBrKUy/ZYJPmX/Ya22mBuafTkHw3A+tam+N2r+bp
 6c2PCdGtW2n8gi5hhCf20G+lqmRLBWUlO5omlcRM6iX5MvM7c7G9ypvexn2FxrI+/q/gzqNeSEd
 TnJxSJ3hKMcHG4PLQczVwMAMILu08kVd9q3Kt3JHtbICca0CiSUibldgSZDIyA2RiDjbrJ6yjYo
 Y0XcOrVZUy57sCcnywCb6QTOv/y4fSi4PdCOGNjJh4/XC2B8F8ePlnmyxBdquuYseDM2WiqtvCA
 25uzpW21AtGomyOevyWWimQ46fKk3lNmPgkGbdUtmC250kMz7+nzZeD9fXQpC0h8PReEsSKTCnX
 7HU5SB+DrBtOtY5gnbg==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76655-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,oracle.com,brown.name,redhat.com,talpey.com,lst.de,gmail.com,zeniv.linux.org.uk,suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-fsdevel@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.978];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: ADE5E10427C
X-Rspamd-Action: no action


On 2/6/26 11:40 AM, Jeff Layton wrote:
> On Fri, 2026-02-06 at 10:17 -0800, Dai Ngo wrote:
>> On 2/6/26 6:28 AM, Jeff Layton wrote:
>>> On Thu, 2026-02-05 at 12:29 -0800, Dai Ngo wrote:
>>>> When a layout conflict triggers a recall, enforcing a timeout is
>>>> necessary to prevent excessive nfsd threads from being blocked in
>>>> __break_lease ensuring the server continues servicing incoming
>>>> requests efficiently.
>>>>
>>>> This patch introduces a new function to lease_manager_operations:
>>>>
>>>> lm_breaker_timedout: Invoked when a lease recall times out and is
>>>> about to be disposed of. This function enables the lease manager
>>>> to inform the caller whether the file_lease should remain on the
>>>> flc_list or be disposed of.
>>>>
>>>> For the NFSD lease manager, this function now handles layout recall
>>>> timeouts. If the layout type supports fencing and the client has not
>>>> been fenced, a fence operation is triggered to prevent the client
>>>> from accessing the block device.
>>>>
>>>> While the fencing operation is in progress, the conflicting file_lease
>>>> remains on the flc_list until fencing is complete. This guarantees
>>>> that no other clients can access the file, and the client with
>>>> exclusive access is properly blocked before disposal.
>>>>
>>> Fair point. However...
>>>
>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>> ---
>>>>    Documentation/filesystems/locking.rst |   2 +
>>>>    fs/locks.c                            |  15 +++-
>>>>    fs/nfsd/blocklayout.c                 |  41 ++++++++--
>>>>    fs/nfsd/nfs4layouts.c                 | 113 +++++++++++++++++++++++++-
>>>>    fs/nfsd/nfs4state.c                   |   1 +
>>>>    fs/nfsd/pnfs.h                        |   2 +-
>>>>    fs/nfsd/state.h                       |   8 ++
>>>>    include/linux/filelock.h              |   1 +
>>>>    8 files changed, 169 insertions(+), 14 deletions(-)
>>>>
>>>> v2:
>>>>       . Update Subject line to include fencing operation.
>>>>       . Allow conflicting lease to remain on flc_list until fencing
>>>>         is complete.
>>>>       . Use system worker to perform fencing operation asynchronously.
>>>>       . Use nfs4_stid.sc_count to ensure layout stateid remains
>>>>         valid before starting the fencing operation, nfs4_stid.sc_count
>>>>         is released after fencing operation is complete.
>>>>       . Rework nfsd4_scsi_fence_client to:
>>>>            . wait until fencing to complete before exiting.
>>>>            . wait until fencing in progress to complete before
>>>>              checking the NFSD_MDS_PR_FENCED flag.
>>>>       . Remove lm_need_to_retry from lease_manager_operations.
>>>> v3:
>>>>       . correct locking requirement in locking.rst.
>>>>       . add max retry count to fencing operation.
>>>>       . add missing nfs4_put_stid in nfsd4_layout_fence_worker.
>>>>       . remove special-casing of FL_LAYOUT in lease_modify.
>>>>       . remove lease_want_dispose.
>>>>       . move lm_breaker_timedout call to time_out_leases.
>>>> v4:
>>>>       . only increment ls_fence_retry_cnt after successfully
>>>>         schedule new work in nfsd4_layout_lm_breaker_timedout.
>>>> v5:
>>>>       . take reference count on layout stateid before starting
>>>>         fence worker.
>>>>       . restore comments in nfsd4_scsi_fence_client and the
>>>>         code that check for specific errors.
>>>>       . cancel fence worker before freeing layout stateid.
>>>>       . increase fence retry from 5 to 20.
>>>>
>>>> NOTE:
>>>>       I experimented with having the fence worker handle lease
>>>>       disposal after fencing the client. However, this requires
>>>>       the lease code to export the lease_dispose_list function,
>>>>       and for the fence worker to acquire the flc_lock in order
>>>>       to perform the disposal. This approach adds unnecessary
>>>>       complexity and reduces code clarity, as it exposes internal
>>>>       lease code details to the nfsd worker, which should not
>>>>       be the case.
>>>>
>>>>       Instead, the lm_breaker_timedout operation should simply
>>>>       notify the lease code about how to handle a lease that
>>>>       times out during a lease break, rather than directly
>>>>       manipulating the lease list.
>>>>
>>> Ok, fair point.
>>>
>>>> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
>>>> index 04c7691e50e0..79bee9ae8bc3 100644
>>>> --- a/Documentation/filesystems/locking.rst
>>>> +++ b/Documentation/filesystems/locking.rst
>>>> @@ -403,6 +403,7 @@ prototypes::
>>>>    	bool (*lm_breaker_owns_lease)(struct file_lock *);
>>>>            bool (*lm_lock_expirable)(struct file_lock *);
>>>>            void (*lm_expire_lock)(void);
>>>> +        bool (*lm_breaker_timedout)(struct file_lease *);
>>>>    
>>>>    locking rules:
>>>>    
>>>> @@ -417,6 +418,7 @@ lm_breaker_owns_lease:	yes     	no			no
>>>>    lm_lock_expirable	yes		no			no
>>>>    lm_expire_lock		no		no			yes
>>>>    lm_open_conflict	yes		no			no
>>>> +lm_breaker_timedout     yes             no                      no
>>>>    ======================	=============	=================	=========
>>>>    
>>>>    buffer_head
>>>> diff --git a/fs/locks.c b/fs/locks.c
>>>> index 46f229f740c8..0e77423cf000 100644
>>>> --- a/fs/locks.c
>>>> +++ b/fs/locks.c
>>>> @@ -1524,6 +1524,7 @@ static void time_out_leases(struct inode *inode, struct list_head *dispose)
>>>>    {
>>>>    	struct file_lock_context *ctx = inode->i_flctx;
>>>>    	struct file_lease *fl, *tmp;
>>>> +	bool remove = true;
>>>>    
>>>>    	lockdep_assert_held(&ctx->flc_lock);
>>>>    
>>>> @@ -1531,8 +1532,18 @@ static void time_out_leases(struct inode *inode, struct list_head *dispose)
>>>>    		trace_time_out_leases(inode, fl);
>>>>    		if (past_time(fl->fl_downgrade_time))
>>>>    			lease_modify(fl, F_RDLCK, dispose);
>>>> -		if (past_time(fl->fl_break_time))
>>>> -			lease_modify(fl, F_UNLCK, dispose);
>>>> +
>>>> +		if (past_time(fl->fl_break_time)) {
>>>> +			/*
>>>> +			 * Consult the lease manager when a lease break times
>>>> +			 * out to determine whether the lease should be disposed
>>>> +			 * of.
>>>> +			 */
>>>> +			if (fl->fl_lmops && fl->fl_lmops->lm_breaker_timedout)
>>>> +				remove = fl->fl_lmops->lm_breaker_timedout(fl);
>>>> +			if (remove)
>>>> +				lease_modify(fl, F_UNLCK, dispose);
>>> When remove is false, and lease_modify() doesn't happen (i.e., the
>>> common case where we queue the wq job), when do you actually remove the
>>> lease?
>> The lease is removed when the fence worker completes the fencing operation
>> and set ls_fenced to true. When __break_lease/time_out_leases calls
>> lm_breaker_timedout again, nfsd4_layout_lm_breaker_timedout returns true
>> since ls_fenced is now set.
>>
>>> Are you just assuming that after the client is fenced, that the layout
>>> stateid's refcount will go to zero? I'm curious what drives that
>>> process, if so.
>> No, after completing the fence operation, the fenced worker drops the
>> reference count on the layout stateid by calling nfs4_put_stid(). If
>> the reference drops to 0 then the layout stateid is freed at this
>> point, otherwise it will be freed when the CB_RECALL callback times
>> out.
>>
> In principle the stateid could stick around for a while after the fence
> has occurred. It would be better to unlock the lease as soon as the
> fencing is done, so that tasks waiting on it can proceed (a'la
> kernel_setlease() with F_UNLCK).

Good suggestion, fix in v6.

Thanks,
-Dai


