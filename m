Return-Path: <linux-fsdevel+bounces-31053-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 352399914FA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 08:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB7921F22783
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 06:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA9261FD7;
	Sat,  5 Oct 2024 06:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kLR1S7OC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rWwknNv/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23182487BE;
	Sat,  5 Oct 2024 06:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728110723; cv=fail; b=o9wccrqxZziPLOFdR37hv91uxaDz7lerU9zdHX7Ta84/VjAswPSJFa1MHA1wTJ4AG8s2t8Pxr245BsZ7vIJJpeUtF0C/F8BlXqG0X22mR7mnbny5+uGMbKfvLytbHT2MddfCw+0o4yBZCQyMcR5nvxUFmSJgN4YJ4DqhQVAWc94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728110723; c=relaxed/simple;
	bh=BcucF1AUuMSdm2iFdHU/f7vMUFhEeCxc0IKna/zFlhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rPLnk3d4U2DmluC9jgdxKT0qONkB4empOo/9lLKQhWML2dYRXjCsJz48Hy5ctigA3Q2J+AVNIRag9ZxpVngwRJFKT91JFexXYOH+HrecvUOIhe5Y/TJSQCh/CnAUjN+wmnscEdGwXN+ODj3jnPBQOBn299eAmvrpdJrYr+AmVUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kLR1S7OC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rWwknNv/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4956ECJV012492;
	Sat, 5 Oct 2024 06:45:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=BcucF1AUuMSdm2iFdHU/f7vMUFhEeCxc0IKna/zFlhE=; b=
	kLR1S7OCUBlUHuVdM/8FsG/6jWbnLvvXOl7mbHWJzt02rL58C5FwkPKW3O75mMrD
	wJOZUTdSswQvnB3JropL3y+UFc79rOnwjDKT32YMSFFdT4jxPctJZEVWUC7kfAOb
	0oGMCLyPnJu46bF8EacA/T/K0DMJG1ECuoL8k4uzzdMJhM/CVFIMymAZRbnj1B0k
	OORafupqVs4f5oimQsQI4kD101QGWDQEFJoAmldZ34xy9A74vFYzS50Gqv5r/5Fn
	OwraIvOCjF9puCIIo6g4twBdw9E+zkxCWKiY68rDTKaau7vfyonMxffd+v3U91D8
	UI96n1S4+M2b/MKI8wkRHg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42300dr0hd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 05 Oct 2024 06:45:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4956Y1ec011530;
	Sat, 5 Oct 2024 06:45:11 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uw44cnw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 05 Oct 2024 06:45:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MONn+vjVlXYEte8oGKWVoqVcVkc/+hwJwGcEBv/BoeNoWEMFFvAqY2c6ct0h2M6neYcxzgJJbtPFT1K78p0A5i56T4A8mcf+O81i8iZjkCqAaF4tfZYS7jhLWlK2zVAgm861LrrndDsfo42fs+Yz9miw5CwMxpVAawvqs/+2tOOEJBHNTfSenTa7dxwmzpQjt2kk0IPK6MrIRKN6oONcCuCjOnDCEf64CixHamp/A+KyRSLJNyvwTX+NVGnNYUead9YRtBxPIjQvRdBm7FH2TmtWSve8eoNpwN4pzJhFicbvbZRjYs1AGgiZjPMw7OcdeeO7MSzq6LUVxAl6Ozm4JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BcucF1AUuMSdm2iFdHU/f7vMUFhEeCxc0IKna/zFlhE=;
 b=FgNmKJgUUubszNUUlBx/wOu4TnKweORxrVK7pKXSDlCijQVhpdRwG1+Uyvb8nsHHwa4gTT2pBapl2w5GJKDJIp99IDiGOG9LoMXaVWiXm2wAJLC+suxjpvZ8kyGQjb0IGctZZ0wHRhQMtPZN1l2PBgxsGfRdlmwZidf3XUTsBPfVPQ/ugqBwVvVNNeFQWptEm07q2eBcIor15k7HLRXN8aIIKu5NxKCBO1XimFSFcv8NOiuH4Sl9Lcme1AcVVAR6rMC7BL2PKSfHV1BOu0Kk1SXGS7V3ThCiS1dgacXxRrwNWE23AU0zIXvo6FvyDGd0EdBxxX53klXx5yVe5YAUpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BcucF1AUuMSdm2iFdHU/f7vMUFhEeCxc0IKna/zFlhE=;
 b=rWwknNv/iP5dmODkbkXn5AyoQR97I2vyH6deyVrrTH4hOuLp6y797mc2Bd0Md6V5CGH8Cc/4ykaiiR8mVwifezZK3l/iNDi0xVBROxQHH1zWS8uvAIQNvssUnRq8YxAA57V0YJMLQhW4BMnpnvB7SEzcSmNf0m3sHEAEvj94KBg=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by MN6PR10MB8192.namprd10.prod.outlook.com (2603:10b6:208:4fd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Sat, 5 Oct
 2024 06:45:09 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.019; Sat, 5 Oct 2024
 06:45:09 +0000
Date: Sat, 5 Oct 2024 07:45:06 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        linux-fsdevel@vger.kernel.org, Liam.Howlett@oracle.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: 6.12/BUG: KASAN: slab-use-after-free in m_next at
 fs/proc/task_mmu.c:187
Message-ID: <47b6ee29-f4a1-45d4-bc32-72b4e2a9afb9@lucifer.local>
References: <CABXGCsOPwuoNOqSMmAvWO2Fz4TEmPnjFj-b7iF+XFRu1h7-+Dg@mail.gmail.com>
 <CABXGCsOw5_9o1rCweNd6i+P_R3TqaJbMLqEXqRO1NfZAVGyqOg@mail.gmail.com>
 <f6bd472e-43d9-4f66-8fc2-805905b1a8d9@lucifer.local>
 <302fd5b8-e4a4-4748-9a91-413575a54a9a@lucifer.local>
 <CABXGCsOsZ5TyEjSWTk6e=FU30a27N4J0gqNCat65gweyKPtZ_A@mail.gmail.com>
 <CABXGCsPnsZALwJSLtJN2guTfN8b2LcdZ79Gq_VzpwTKUdfY3nw@mail.gmail.com>
 <7edcb18f-8877-4c95-83a2-1c5090ffd1a3@lucifer.local>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7edcb18f-8877-4c95-83a2-1c5090ffd1a3@lucifer.local>
X-ClientProxiedBy: LO2P123CA0008.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::20) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|MN6PR10MB8192:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fc7d68f-cd24-481c-cc81-08dce509410d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S09ONVV1Wk5oa0hHenJOcUxMSmk1WDNlYmJla0lXNGhWUWNxK0x2N2x1T3Yv?=
 =?utf-8?B?QlhrN3Z5RHQveTcyZGpUVWVhUElQN1BoQm9EUjRweW5KSi9QdnVwVXJiaDh4?=
 =?utf-8?B?OUtlYmtPSllKb1VkMGNmUnoydmMvbEVoaENPdHNab1ZmTWhlOXdOeDFZVEdS?=
 =?utf-8?B?YTFkS0J1TENhejRJbVh1NUFnQ083ZVczamJIVENXT01jOXFYMHhGTnBvYWRH?=
 =?utf-8?B?RHNGdXJyZndpckFrMVM4QVl1ZHFueXlkZTdWYkw3SnFPZ1BUb0RSbEx0ckVQ?=
 =?utf-8?B?QmhOeUpMd3h1ZVhEMmZGMnN0YTlRWkx1cWdrdGU2YnNBelh4MmM0QkxudG5m?=
 =?utf-8?B?R0hQS3l6QW1lWnlwTkJoeGwxSkozdlQ4MGsycG95dTFYN2YzLzY1YlZJNk00?=
 =?utf-8?B?dFYxTGc1NHUzMnVPYlVVUXAzOTVqUTVRSWJRdjBRMmZmTkpaQkNQMXJPUGVh?=
 =?utf-8?B?U0NhUTAzdnFYYXJaMFExL3dSSDJKcWozOXBGOVZUSFlOTWtaLzI1RUVUamZ4?=
 =?utf-8?B?R2ZlZTUzQVFOenNVSVNvK0FxWlFEQTlxQ2VLMFBlUGNzQW1GU3c2WUwvM1ll?=
 =?utf-8?B?TlZtMUxoemVDdktUdWc1NGNPWm5BNEVmMlZpbW5kUkREZ29nWGJhUlhZNnEr?=
 =?utf-8?B?andQdjJFWXc5RjNaU3k1UTNtYzUvbGE1Yi8rcHFDZTFUNndueXp2RWk0WU1Z?=
 =?utf-8?B?alAvSjNIbFQ5QnY2OW9JbGh1SS9IYmJqNXl6Zm1qZ0hFa2VycmQ0aEtReHRY?=
 =?utf-8?B?VDdESUxFNDNpRUNGSEo2YnlkeEJqWVZudlhYZ1c0c2tvVnBOZ0JDVXdGR2tw?=
 =?utf-8?B?RE40VzltQTAydTJ5cTVVN2VNSjc4bzRXY2VzRlJzdHJsVnUrdVhjdThBOXNW?=
 =?utf-8?B?ek5hMFFnOVl0RGdkOXYyOFFBMFRCVC9md015TUpqNUFQaDJhSmxkTG5DTkdz?=
 =?utf-8?B?enYwb2FKbUxtbjZqcEFQV05IUWQ5NHBEVXJ6UW83VEFJSXRSUC9WdTFnbGg1?=
 =?utf-8?B?d3lSdVR6MVM1bkhUQUkzemhGUmNNK3YwZEE0REltaUVyYzRFVVo4UHpEbFRU?=
 =?utf-8?B?SmhtUG5CT0lBYWErTDc5Sjd0QzkxbUEvdkhhd1FXWkRkY0FOVEZ0ZlZ6R0Fn?=
 =?utf-8?B?MC9HdTJKa2gvNUxDa21BRVdtZkwvbGZkU1F5Qk1qLzdDTDd5THNVL1NJdVFU?=
 =?utf-8?B?RVJyUHVWRVJMNU0veDVuOWV4Slp1ZVo2cXNHQXdJWHdIZTJ1OGM3QW9WamFF?=
 =?utf-8?B?Wk1rMTBJRGxEZWRZakE1dUl5WG4wR3gxdFhaaHNpTnEzQWw5OWRuMlJ0RUZp?=
 =?utf-8?B?VmptQzdLNnpNREJQbGowbjI5MVZlYS9NRURJaXFnUHJHbk5ORkZjL0tXalU1?=
 =?utf-8?B?TzhRTFRLd1VTLy9SWEZVYW9BTzd3V2loVE51YkJGVG5TZ05xeVRlVWsvdVo3?=
 =?utf-8?B?ajhJbUZkZlJoczVwRW5pcnBLcU1PWVArRkFVcjhWL0R6Ym5CcDFxSXZjK2FL?=
 =?utf-8?B?TmxWU3llYURXcE1XNi81RWQ3eGdUQkMvaGNvL040YXA1SlYzUE9Pb3drZ0Vr?=
 =?utf-8?B?bXROcDBOSkhscC9jNXNLdUZUQ1F4ZEkvZlRCOU04TEt3U1BIZUJyYjNZdU1n?=
 =?utf-8?B?T1pOamQwZWQ4NTF3WGdhRGtubHdmN0ZheEluSDlxdjBDZ1JHSFRkMzNJaS96?=
 =?utf-8?B?M255V0piczJzcU91TDFxbnNzWHNOclZJK2NudWRRcms5RmFHUDFDUlFnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzZuUTlDYUpLTFJpNXlEYnRIOHIrc2F1MUFsTkdRSG9QUHpseDJ0SnI2QS9X?=
 =?utf-8?B?UUNMMlBJQmtsN3Vycmd3MjB3YzFIVmw5eW1QUlNINXlQdzQrOEtidXczd2sw?=
 =?utf-8?B?MUpFbG5iWEMyVXpwZGxhNkgyMThUeHBaRGJxa3FtVWlnQkRJYUZCajBVMjUy?=
 =?utf-8?B?N1Q2dDg5UGFNU1RZRitWdVB3L2taVFM1b0Zqd0NDNFlFUFlQQlpkOFZtaGFp?=
 =?utf-8?B?RWZWYVVsR0VLVE00R2VtMHUzMU9iUmNvQWc2L3hqbUtjUXZFWE42ZzFDcGpH?=
 =?utf-8?B?MnoxMDU0amdZVTdEWUdkYmRobFVHSnlMWm9pU2g0WWVqNnp0VkgremtHSWdJ?=
 =?utf-8?B?VXhjNGhFMFdvSk5NUjh5QkI5TXpCZkp5Rm1SNFhsMXZuakRxNXhJRld5TzBG?=
 =?utf-8?B?Y3pVNjBnMVJqbTFHczVqT2hBUjE3Yko5TklZOHJCOE1EdzlIWXB4MEJ4U1pO?=
 =?utf-8?B?dit0M29JTHZJUlBmMWlUZDMzTDVzQklZb2RQODFOTTdsT1BGeEl0YzM4TU9v?=
 =?utf-8?B?WW1Sci90UnNMeE92ZU03RWY5UGt2c2d1VytHdC9aY0hJNFY2cDV0VzV4K3Va?=
 =?utf-8?B?MngzVnlDbnFWcWJ1WjdSQ3lZSDVrTWRlc3VONE0yUk55aTdkZjZWejF5bkJK?=
 =?utf-8?B?R3luVzJkWkRTakJWTXMva2xvUHRZazV3V2p4bGh1a0FtZ0d1UmpnOVI5UU9L?=
 =?utf-8?B?NkdMekZBNVhZYkRmQXZyNWQ1YVNQMW1SZ01HVkpIT3ArbDR3dE1iNGR4L2hU?=
 =?utf-8?B?YmhPSEd0VlVEd3BBbTUrdmZrSGlLU1NFT2RaUDg5TTU5MzF4TzIyengwNndq?=
 =?utf-8?B?MGYzSkJMSjZlK1U5bmxlRTNjREtsN1dEa2ZPSHlkOWgwOFpDR05vdFNKZUxT?=
 =?utf-8?B?OFk0dWYvS3RSbExsS2k2ZWNMRkNEcTFWbVhhdHdXZ2g1WHpxMGpkeUhhV0NZ?=
 =?utf-8?B?RU1Ec1RsWFI3TkhBRWdmTUJ0Y053YytXWkxXSVUrdzBkanMvSk52c0grZUIr?=
 =?utf-8?B?OVpyZ3J6S3p6ODh4N2JGREdWZ21ycUdCZEZSODRGalY3MXpOOUdoTTJlRDRn?=
 =?utf-8?B?UDBMdzcrV0twdXl3QnRkejVXN0dSY3Y2bVZqQXlCU2pSZktRV0o4WVNRUDVt?=
 =?utf-8?B?aGc5TjNuUmIrMXNZbkcvNHIxcnlFdmVRR0VPZzFWRlBUSE5UR1doUWwzUktT?=
 =?utf-8?B?alNXVWZvVlh5QmIwUEl0d3ZVOC9Jamc1MHNNd2xxQllGRERVZ2hqVXZMRDVh?=
 =?utf-8?B?WXIwVzArRG9adm5vSERCd2s2anlJbjRDUTFwK2xPVjdWVStGbXJ6bmF5S25H?=
 =?utf-8?B?QWNRN3RJRnNZSk4wU3FqMGc0ZXNQQkUvZnVtOEdlSmk4M2VoSFdueE91ek9P?=
 =?utf-8?B?bnN1WktaeExldUpCU2dEdHhCcnZDdVlBQ211L1J5a0NxWW0xRE9ZNCs2eU42?=
 =?utf-8?B?NW84alYyRE14QTVPK1F1eVVCdkJTT0JEUG84M0xsL2JZeDBYQ2R0TVk0YXcv?=
 =?utf-8?B?elE2OEZQSUo3Mzl1UXJxUG5abHlOK3UyNlMrQWJmZjhkM1I4dE1ENUpnKys3?=
 =?utf-8?B?R1JJcm9Sc1liWVBHTEd5TU5yc1pxN2M2TWNDbzlQUW9XbElPWi82aXpEdjVQ?=
 =?utf-8?B?dnlqUkpOY2xkZW04WENQTnlvYmxYb1pzanNHVGtaQzd3b25vSjl0MkxvY09s?=
 =?utf-8?B?SHQ0VEJpc1krOVU5Tnd5WEFqeHJkZGxveEhoNWpMaXFjWks3UkJaOVlrVTJO?=
 =?utf-8?B?N3M0UTRucjVzbDlVdXpHVWZpNlhwdndqMjAxM2w4dVhqZG4rRGY0MHg0YVFC?=
 =?utf-8?B?QUw5eXhUOWg3cjh5eTkvVVdkbm8rTDF0YjBhRVFxK2xXMTRvcGhzWGd0TENs?=
 =?utf-8?B?aHpnb0lYSlNRM0V4NlpKNDZ1bGxPYVdsVUozUTMrUVpBakZtRWFQck9oeVNB?=
 =?utf-8?B?aG1uMktJdk83UGtNaWRTdDZlaEt6YmluQkZQeXYvYSt5c09mR0RyY2RmV25z?=
 =?utf-8?B?L1JNczQ4cWJBZVI2dDBtOU91c3p1V3hXdVZzQkR3RzhTcEJOLzB0SnhYdlFS?=
 =?utf-8?B?bGRRU1UrUUxZaUZ4OXd5T3lVRVRybTFSUno0dld4REVIVk9XekgxN0tueU1t?=
 =?utf-8?B?WThvZUUyTGp1aWkrbnBWeTZRdFQ3ZHh0aUdxK3BDMVVuRVErM29PdEYvck9Z?=
 =?utf-8?B?S2lySUpld1FLanhad05OWnh0eGkrR0F6MWZoeGR2dU5rMTRXREdSUndXNWhV?=
 =?utf-8?B?THltOHJUY0JhL0FnbGtYUW8yc0J3PT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zxEZUD+iIKuf0wXp6F0ulG0C4hCBYvjGOYJE1EpY/k/p1mVwE9OqHo+OGROVFR5ToX+WIxg5gaIi+bH27ImLDuGQYA2QODnoLNULZ/1LAwBVupPTNPQvVICeFlvOENVD/yo/nnbxjXBOyNeFcmbdX9WgMSzQM0LF7C/MaluBvC5fwJP1H2tQ0VM3QTE1UdESYE0Eu4ciVbCdVj54pHf5L1TrIs8HZ71+SoAuvSYKUE1JBrV1cAzMBiOhbY0jWqWN62Xed1L/ZPL0PCvCt0jjkYGcKG91eR1Z2k2TRVinelzv4+pMSJUM9MBHB9og9rUd45jmVhDMQYO4ngCE4d5fBm0htGCayR9qd/omBmh8O1Dw5xAOS8EPNiFeAdstHd4uK5OndWeL27u9G93TlkJ1j+yji3FxXUQxkz4aNsD23cEwkr6c0EciKy8+6mgOj+0bfxTwja+DNgfxKrrpIhcT1RKbct/tJ36ccYNzZLYLRMNEwDUbk+USp16ofC9a+gGX+XJVBylDvh/O6JomwAnPOI+ln9M4Xo+CEiVkH1yR7bR0IXb3JYhQ3sqGk9MCeNvuAi5+q0GVfd4DrY4kjDDezgEiwdKfCyQa7bO65Co32Zw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc7d68f-cd24-481c-cc81-08dce509410d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2024 06:45:08.9694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bmzRaC5Eq568c14H16le9WEYp8q+71NiHotrWdPKXkpwb3jWcRpQDmGwJwJ1DXKAZP5rIeJWfGHYcJc/uSo4fQZyRJbKA5eRf9rXxQkxzbA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8192
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_06,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410050047
X-Proofpoint-GUID: 3Na02Y4INTfB3l6_YVu_m5bUHaJqrtV6
X-Proofpoint-ORIG-GUID: 3Na02Y4INTfB3l6_YVu_m5bUHaJqrtV6

On Thu, Oct 03, 2024 at 10:52:03PM +0100, Lorenzo Stoakes wrote:
> On Fri, Oct 04, 2024 at 02:25:07AM +0500, Mikhail Gavrilov wrote:
> > On Thu, Oct 3, 2024 at 1:45 AM Mikhail Gavrilov
> > <mikhail.v.gavrilov@gmail.com> wrote:
> > >
> > > On Wed, Oct 2, 2024 at 10:56 PM Lorenzo Stoakes
> > > <lorenzo.stoakes@oracle.com> wrote:
> > > > We can reliably repro it with CONFIG_DEBUG_VM_MAPLE_TREE, CONFIG_DEBUG_VM, and
> > > > CONFIG_DEBUG_MAPLE_TREE set, if you set these you should see a report more
> > > > quickly (let us know if you do).
> > >
> > > mikhail@primary-ws ~/dmesg> cat .config | grep 'CONFIG_DEBUG_VM_MAPLE_TREE'
> > > # CONFIG_DEBUG_VM_MAPLE_TREE is not set
> > > mikhail@primary-ws ~/dmesg> cat .config | grep 'CONFIG_DEBUG_VM'
> > > CONFIG_DEBUG_VM_IRQSOFF=y
> > > CONFIG_DEBUG_VM=y
> > > # CONFIG_DEBUG_VM_MAPLE_TREE is not set
> > > # CONFIG_DEBUG_VM_RB is not set
> > > CONFIG_DEBUG_VM_PGFLAGS=y
> > > CONFIG_DEBUG_VM_PGTABLE=y
> > > mikhail@primary-ws ~/dmesg> cat .config | grep 'CONFIG_DEBUG_MAPLE_TREE'
> > > # CONFIG_DEBUG_MAPLE_TREE is not set
> > >
> > > Fedora's kernel build uses only CONFIG_DEBUG_VM and it's enough for
> > > reproducing this issue.
> > > Anyway I enabled all three options. I'll try to live for a day without
> > > steam launching. In a day I'll write whether it is reproducing without
> > > steam or not.
> >
> > A day passed, and as expected, the problem did not occur until I launch Steam.
> > But with suggested options the stacktrace looks different.
> > Instead of "KASAN: slab-use-after-free in m_next+0x13b" I see this:
> >
> > [88841.586167] node00000000b4c54d84: data_end 9 != the last slot offset 8
>
> Thanks, looking into the attached dmesg this looks to be identical to the
> issue that Bert reported in the other thread.
>
> The nature of it is that once the corruption happens 'weird stuff' will
> happen after this, luckily this debug mode lets us pick up on the original
> corruption.
>
> Bert is somehow luckily is able to reproduce very repeatably, so we have
> been able to get a lot more information, but it's taking time to truly
> narrow it down.
>
> Am working flat out to try to resolve the issue, we have before/after maple
> trees and it seems like a certain operation is resulting in a corrupted
> maple tree (duplicate 0x67ffffff entry).
>
> It is proving very very stubborn to be able to reproduce locally even in a
> controlled environment where the maple tree is manually set up, but am
> continuing my efforts to try to do so as best I can! :)
>
> Will respond here once we have a viable fix.

I cc'd (and tagged) you over there, but I have a fix for this problem, do give
it a try! [0]

[0]: https://lore.kernel.org/linux-mm/20241005064114.42770-1-lorenzo.stoakes@oracle.com/

[snip]

Cheers, Lorenzo

