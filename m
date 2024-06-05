Return-Path: <linux-fsdevel+bounces-21069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF518FD381
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 19:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB5651C222CD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 17:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95155191490;
	Wed,  5 Jun 2024 17:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DgHoz0hF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oh6Z/8dB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158A361694;
	Wed,  5 Jun 2024 17:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717607031; cv=fail; b=p48CN+KlaAc/b/Z8A93wf+wkbqTx7gX9U6gw9v/2Z8oRn2t4NTNIFTpTIjLI8aOHwdmgm8ulzUkbIm0+i0OvcpfG2cjayP89XelLoDVyI0ficMPthC+nTKwHs/0ktFPMgcrVM6+PXVbbxXgrql+S1wZKVrVJNzWB2GhlnswMi58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717607031; c=relaxed/simple;
	bh=ouaDZg9soh61ampVOSpKd9hjidAJ5EL+7IoQCoA03t4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kCS0Z8CiputBYhRU66rQrPQmW5a7rFXcL3LJzwLN/XTCoQq3MzucRj6WfX2egRG3bSdTZZ7kYx7e7L3fWpfVKxwvsCSZxvZIPhVMftJtshwlA1bGlWkSkR/mDL25Wwl2vWLdWg/CcFFCoIEJ+6SR1tvNkV0NM1SiBipC+Vbk7i0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DgHoz0hF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oh6Z/8dB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 455C9ih4005263;
	Wed, 5 Jun 2024 17:03:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=knogQTChe1ksDec7fCzmv3UpY6znBUZctN+vi4ALhlU=;
 b=DgHoz0hFa0I4NH31C+p1MIUaegkp57SevBkL5ekEWpzInRhk0XVd7n6okuvsoeStc/b4
 4PMcXmMh2Ki0uGugk2pSnLy7b9bibRCGW63SdbsKZZ07aQ6bvpjmchdC9UCg6qVjEx4L
 lWYVDY/6MQwyYLJREWbY5mV18nW7vKlN8MWyBZaRyHjV0euOiLcYNnWTzM8tGC5sQh+0
 KBSmT1rbURoWNm04M0TmqJlgwf8xVteoMLbrxxozZd2AR4bkwy7g7SXRVp5xp/FVLztd
 FQ4oSXwU1PJOfv7ZvM42dgljCy+YbkyQtGEKAWJbIlPdwHNSoTjhKzMAzJv5NcmMrZhg /Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbrs9t88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Jun 2024 17:03:32 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 455G3jdt025099;
	Wed, 5 Jun 2024 17:03:31 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrtaaycq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Jun 2024 17:03:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TyVZwTroLip42VTIUTWVQ/EB3BSuDzyFM3JPmYIX/Wr7eGRBvVeb6z6IhsnK5jZO8Setgj+7IrQxjcSj+qx+XUlOuKh2Cl5iF4BJffMpI1dYJgHGQBbgNab4jFYp11l06X6vkQUcQKuqIniE6H4i0JYF2w/7MHCueDtsr902jTlrocjzI60VW8k28XllJe3fKbDTlT5gdZ0BGmtHhp5Y8zls4YMNfiTTdZ/sVnW38L6XPg4nsGDt/RED3mHLm7TC8XWhnztFZyUr3uAC3bkCcR/n6fQkqrniFLalzlLcUjCJKrw6SKdSThce86khtgLfHjC03YQAOfu/I0nJ4O28Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=knogQTChe1ksDec7fCzmv3UpY6znBUZctN+vi4ALhlU=;
 b=YooLHRuktkMmOTdmgrwjxQ4SXlytuAclCC0aIhjJLm4C0Uf5wHHdzQ5+pIfWrChnue7lYooS8DKQvZmCKSXeTQ5J4yftcxs1HEK2uVbr3Sfm5YvrP1VbORqRUFAeHpYOV8Gym4dEGrfeIEvD1R9PxoS8v6lFXeBpsMJ/p7E3ZiBfGNTyumxMxRGixBNWlECtMkfPF2D7yss+BBmDEvJL2NCopaGLJAqjiewpuYLkIs5n+ztRKwx3TRT77//jhJU6DRCSWv7G+sR3fkjgcYZlewqqwT5Z1kqLeTE4y4Z7HBYJKw+tJFDnj4nKsGEd0TFe1aiIe3018xW//ILX9sBsKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=knogQTChe1ksDec7fCzmv3UpY6znBUZctN+vi4ALhlU=;
 b=oh6Z/8dB4Fnbf1AEwP0MICSd/woeHy9H2yha03waKmy8WFVXnlwfkx9wsj2+TtoHlZhY7nAkbfLKrgLFXLp3TBQHRjjBsGBvBZEOeh7xNTBAI7JwlTWuU/MHIaeAHjrYk9/f5SO1wJfk/zkRJOMJLMqJH7BGuCuJOFtAU28NPjA=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SJ0PR10MB6328.namprd10.prod.outlook.com (2603:10b6:a03:44e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Wed, 5 Jun
 2024 17:03:29 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 17:03:29 +0000
Date: Wed, 5 Jun 2024 13:03:26 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, Andrii Nakryiko <andrii@kernel.org>,
        linux-fsdevel@vger.kernel.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-mm@kvack.org, surenb@google.com,
        rppt@kernel.org
Subject: Re: [PATCH v3 1/9] mm: add find_vma()-like API but RCU protected and
 taking VMA lock
Message-ID: <5fmylram4hhrrdl7vf6odyvuxcrvhipsx2ij5z4dsfciuzf4on@qwk7qzze6gbt>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Matthew Wilcox <willy@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, gregkh@linuxfoundation.org, linux-mm@kvack.org, 
	surenb@google.com, rppt@kernel.org
References: <20240605002459.4091285-1-andrii@kernel.org>
 <20240605002459.4091285-2-andrii@kernel.org>
 <Zl-38XrUw9entlFR@casper.infradead.org>
 <uevtozlryyqw5vj2duuzowupknfynmreruiw6m7bcxryjppqpm@7g766emooxfh>
 <CAEf4BzZFpidjJzRMWboZYY03U8M22Yo1sqXconi36V11XA-ZfA@mail.gmail.com>
 <CAEf4BzYDhtkYt=qn2YgrnRkZ0tpa3EPAiCUcBkdUa-9DKN22dQ@mail.gmail.com>
 <CAEf4Bzbzj55LfgTom9KiM1Xe8pfXvpWBd6ETjXQCh7M===G5aw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAEf4Bzbzj55LfgTom9KiM1Xe8pfXvpWBd6ETjXQCh7M===G5aw@mail.gmail.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4PR01CA0113.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::25) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SJ0PR10MB6328:EE_
X-MS-Office365-Filtering-Correlation-Id: a1eba981-57fa-49f1-33a0-08dc85816c1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?blFKRHlac2hWaHVuSlUzSmN4eTNmSGlzVHZHWHpkcFVnZmtGb0ZVazJ6YmZC?=
 =?utf-8?B?M2xHdjdKSzA0ZThvMTNBYlR6MU5CZ0ZONlVjNm5GdTQ5SjVXQUs2UE9nQWRR?=
 =?utf-8?B?endISWRUMmp2OHZlbkZZbmp5aVMzUmU2M2lSbzk1TkFqekk0Qy9zSWh6dlFD?=
 =?utf-8?B?d0kxWDA2RnlFbC9ibEhaQlVxaU5BelJlWWlFVXNzaVRGRk1kSEZXcmNCUytp?=
 =?utf-8?B?Y0pRcHQ2eFAvUVBkU0U2UVhlMnhrOURTWjhNQmgzOHV0RTc1UlB2cGhqVHYr?=
 =?utf-8?B?QXZLYUEzcUxsMVhOOGdtTmhNMkRtYkpIZlVXdXpLcGlxRmtaSWFsdkpDUUpI?=
 =?utf-8?B?b3kvZERwcy9RUmloeFY0L1h1STJUbitER0wvd0dyODQybTVHQ1JEMVJUWThq?=
 =?utf-8?B?VHhsMDY3eStuUmNRejhNTlZwbktzcGZwaWVpVUxoelMvb0ZYVDhhV0xzajUr?=
 =?utf-8?B?bUxaNk5PNERyVWRwM0h3T05hQkFmb1A5VVpwdjBudEZKMXVmRWxMRUhKL0Vm?=
 =?utf-8?B?UkJOeG9yOEpieUkwTzdnV0JIbFRGN0d1eGRyL0ZuNjRFSmVBZVc5Y1pTRFcz?=
 =?utf-8?B?QXVQdGNYWW5qVk1Rb0tia3huNlV3dmYza0ZvS3dkTXV0SFRKWFdiZmNpTnZX?=
 =?utf-8?B?WlBTeW1XM2EzNjdLMzFER3JHcEZCb1doNVFOMlBJU2xJbkFrYU9IWWRndmt0?=
 =?utf-8?B?cHFMa2h4a200eU5od0Yxcm12UThiV1ZtYmtYRlhaRCtuMnd2OHdnWFFaVmNj?=
 =?utf-8?B?bktLNzZyWEdIVDVvNTJWcnVVRTk5UFdqMVNMR1JRTnZtckhKb25NVjJzQlBZ?=
 =?utf-8?B?Uk9GVW1GQkF2WUEwNWEzRG5ic2JDY3dPclRjTEVJeGJlTURpa2lEc2t0NXBN?=
 =?utf-8?B?bkdPcHFNaktab1lRTDIreGZtY29pUWpBY3MxYm04enBnMXg0T0k5bXJGa2Zr?=
 =?utf-8?B?VkpMVzhWTitLY3d2YmtlbGNPVjVFSm5iT095Umcxd1kzOFBVZ1lTTGZrL09p?=
 =?utf-8?B?QXc1aFVsbTBiSWZIUkdEbTAyVW1MYWlWWkxQdUxkS01mRENwcVdNV1B6SVRT?=
 =?utf-8?B?cklyejhNbHkzeXgvS1RUUkU2T0lxQ3ZWVGV4dTFLY3dqS21IbUFQaFAxc0kv?=
 =?utf-8?B?bVl1a1lPN2VyMVlhUTN6SmdPcHR0VEJkaDE5WEs5bGg4YWQ5c1I4OHQ0Si9W?=
 =?utf-8?B?eU1EZkQwVDBrMUlyVlI0Z1R6SGZnbFEvcllNcGFRTk9sV1pDVU9lc0FPT05k?=
 =?utf-8?B?Q0pVOFVvNlM4ZjFtbkpaa0p6eTk4RFZHYzRJRnFpSytZZ21KR0oyb05CNmU5?=
 =?utf-8?B?dW1ZcWkxdmo3Umw5Zit0cnczZ1FEOEtYTS9xU1ZaLzduRU9iNXd2Z0lPbDB4?=
 =?utf-8?B?YWd6ODJ0WCtramJ6cXZTVXUvZ3Vwb0Y4eWE3aUVNb3hzbUJsUjBaV1FGOGdt?=
 =?utf-8?B?ZkJwZzZOa2FlYTJhZ1J4UUVLYXhENmZXTFViditzSGlxeE8vQy81Zkx1SnNZ?=
 =?utf-8?B?SzRkaG9JZFRBT2JyVTB2VlhZUXp6MkdSOEp4dDRmeFEzN0VBaGt3VDFuWE1X?=
 =?utf-8?B?N3dFRDVPbTNOb3g2N1EzTnBxREdGeCtnQ2V5NFdKbVprY3RiYUNLcDEwQXNR?=
 =?utf-8?B?ZWxWb3Jzd0ptVlJJYVhOTGhjVnF4aFdLV08wMzR2VzVHU1dnOFhUazJrV2Iy?=
 =?utf-8?B?aklwTTNMcEx5N3JMZk9ucDNtNldWeEJ6dCtCd1RBVlFORW9ET0hvMU5od280?=
 =?utf-8?Q?xxHZ/x2fh90T8BR/ljWRdFsW7eBFlR0fG8CITNU?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Z29Db0tKYUZScU0xYXVjK2E2bTlLWXJqNnBxL29CZXNYcDdQOExyeE94ZEJw?=
 =?utf-8?B?R2hOWW8xVXZZRk5TektaM2xubloxNFRNVDcrKzlJeEc5TnR1Z01ZbDZObUxj?=
 =?utf-8?B?Z2VhREh1QkhUUytnL1p1TXpveWQ3eXBLdnpmOUpEamtURXNOcEJ4QkNDOVJ1?=
 =?utf-8?B?VU5xejlCZERxcWRQeUZldmpQQU1LaVlqVXJRTmNJYjVCZVQ3M3JXV2NwNjBn?=
 =?utf-8?B?WjNEZkJKclE4VmZScWtjWkRLWGtxc2VwdDQxTERuNjduT0haa3p1QzdvbWRX?=
 =?utf-8?B?dnowWVdyOFBDOWl4cTFGRUwyTWJOQVBmM3FQeTFnV05Pc2tFZXB1b1FOQmtU?=
 =?utf-8?B?VlI5K2IrSEFxaUM3S1liNEV4RDRERTNCWjl5RVVlaDFkNmZENXp6VjExUjNP?=
 =?utf-8?B?WlBNSG1LUmdFMEZhTExNbElTVWJWeFR1dkNpc3hTRVFKUmswMW5LeUtTenJt?=
 =?utf-8?B?RllJTG1pQmQ4MGNEdzdJRjhtQW5sUmdPd0tWR2FxNm1ycXNhNlI2RlFWUUNU?=
 =?utf-8?B?S3VzRHhDNnQ0bzZFY1Q0VkhhVmRtSW1IQi9RUVc1bysvL2lHeEd2dGlZWXpm?=
 =?utf-8?B?WW50dnJMUWZNWHpCZkxXaTRoVmt4TTBsODQ5QmVBcUx6ZmVBUkxTTDAyb0ZK?=
 =?utf-8?B?VWljcnJrWGJETUZWclgreVgxNEtQVlk4M1FvZi9nREkxclZQMzFWNXVnVDhr?=
 =?utf-8?B?cmgrMlJjS1k5U0RTY0I1N1czMFNDNldTTlZ3TEl6NnZQUGt5Z1hwYSszME9Y?=
 =?utf-8?B?SVZ2cU45Z085RUFQTmJTYVA1bEdKUEUrWFNkaVhPV1R0MmNQN2lGYzg0L3VJ?=
 =?utf-8?B?V2p3NzcwbDZHQ3BLVWFaUzhLcDJEZkdVcU1sQXdMYS9QQ0RNbHVYTkZGOE9L?=
 =?utf-8?B?bHlJSlBObXFuWEdaQ3VnMmR2OThkT2pMK1BtR2hkMklZc2hFd0VsbU1qNjNl?=
 =?utf-8?B?d0Q2bm9hYy92MWtQRG8yUmJYbWp2aTI4WnROSG94eDIxNEtqd1hWQyt4MW1t?=
 =?utf-8?B?M1N2NXBpQjRPOW1USU5IQkw4aFgyYVYxYjhVS2MvdWdxMzhmRGFHNmF3UlU4?=
 =?utf-8?B?Yk9RNEVWOC94a0pXTXEvL0Q0NGpSekRoMUkwcWRKWlpiT1ZFeDRpZTA5cnhs?=
 =?utf-8?B?YUp5YVdJSkdZZ0pqd0c5aU5ZK1ROUER1N3J4dXZMTGJCYmVTdTdEVERLTXBJ?=
 =?utf-8?B?SnA2a29CNVpjZHp2ODcrektMbXo3OXBRNHBlSEFLczNYS3RVQjd0MXB2Y3hn?=
 =?utf-8?B?UlpkYkl2cXY3RDFXNnlRNzJ1cEpwTXM3WUxQUmh1cjZtK251eEFaQ3NxdWVh?=
 =?utf-8?B?M2dWZkdCcUk5M1NuZ21KdGN6NHdtYWhadnh4aEJReXFpUTdOMzJaVkV3UmZr?=
 =?utf-8?B?eDR4UVZma0VTVWxCSEJwM2pla1FEdTBGcFBPeXJsTVpRK1V6bHdwZUZJTDRD?=
 =?utf-8?B?NFBvY3U2WWV3VGpwaFRFYmZKMXZEL3Rxc2ZIMzlZUGpycU11dDg3SHgwWXlD?=
 =?utf-8?B?RS9YVVcvU0Y0UjRUU1BUby83ZFgwZDU4Y1VoaHg5eHJKOG9iNEY4N3NITDJs?=
 =?utf-8?B?SnQyNXkrSXlPNTFFV01PMmQyN1ZjQnNIbjU3TXVPZUNuTXliME5lbHJPZFJt?=
 =?utf-8?B?aFBaTi9WQnRjZFFuMXljdzdwLzVpNnplSzNHczBsOGJuME9kSDhTZG1CN2JU?=
 =?utf-8?B?dWZhRzhHODdQL29icXR4OU1Ga09vZDZudVZhWGZxWlRtUmZjV2dkeGlCZXVE?=
 =?utf-8?B?SlpMOVV0Vlc3Ti9FTDV5MHI4WFcwcjlueFVLazlVR1JDeFBRczBRT2RrT3dh?=
 =?utf-8?B?WU5GVEV0dEZDOFFWdDQ0N1VPbG5EYTZjRnRtZG1WdUtWZFl4U0JvU05XZ2wv?=
 =?utf-8?B?akJKRVlmbE9pbHlQcDd2c1cwWFFRNXNoUjh4Y3dSU0JjczJtMjZYSTlHVUhQ?=
 =?utf-8?B?MlVCL0JyS3J4R2tBc2NOakM3aUFxVGxGOHVUS1BUa3JhTnBHdUN4UzdFYVVw?=
 =?utf-8?B?RjlSL1dQMzYvYUVkR3NCTG5RYmJ1VVdWT1pDRlpMeEQ4ZjVQakpSRVhCVDBY?=
 =?utf-8?B?dHpoTUhvYWhxUE11REplNGpuSUs4YlQwMlV0Nllka2dDeklwSnlVVXRhMU90?=
 =?utf-8?Q?e2TUqFsRgf9ZGuhu7jxELjjQn?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	nKz9gIYmAgmCPyvkY+uJsaX9d+xoAHV5vGsZvp6rqbyaCzc5OpdJzDtyoZyo+rs17VB/Ddw7YjILEaFIMQTmFlSGOTMtBfyqF0xazTckXNJpykHxdylKDOg+0PsrdK8CVWSbPAorQUWE1h3BhfxB03XFRmqerhz2S9WK4z650LrKWmM/SPkq3GLRR7hrX0vmCoVH1mgB1RmfNEBDVTJicQLUkezkFJbr8/bkQBPjW75fh1xBaUcK5cncJd7ojYWTXWjpHKP5Gz76HtHsc9/AfLCGN42QncNmefrBGG5dFDDrAfAj/GR7EkJ/rtrWV4MQ7j86hsut309UtiAHoPQlGRVt8UwE7KI3S+b6+AiwB1kj52AQqQzkbzxsQ4AF/3QuY49XRJ41q4QRizf55zF3P6LWvg3Wwur8Q7JuD/3NaOhtVJRwdU1xSQ20eWQWPLW3W3dtBWBOvmVGouKqc0yU9BWsUXqLCdwqYbFgyl6S+hHaMSLT1YJD7ZhOI7T8zfUUpvaomPXljMxQvtG7a21fjuXnXZ4Lhi+sJHbOkex3yzRcdDHnl4ccXS6MQic0oPWUCtlCrTZRTeVg9Y/XWRM68fv9hffx8ZbUWLO4plqdQJU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1eba981-57fa-49f1-33a0-08dc85816c1b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 17:03:29.2173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EriCRQBVWZIJoORrbq/jruEBCWNwq/cTLGyCDlwBqowZMXEFRFCMT86pl473Tv5/x1RcpP+0aLxtvrWUo7CnMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6328
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-05_02,2024-06-05_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406050129
X-Proofpoint-ORIG-GUID: 4rGeTEixBOLcx4Or4xTU-11u0p00cTRo
X-Proofpoint-GUID: 4rGeTEixBOLcx4Or4xTU-11u0p00cTRo

* Andrii Nakryiko <andrii.nakryiko@gmail.com> [240605 12:27]:
> On Wed, Jun 5, 2024 at 9:24=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Jun 5, 2024 at 9:13=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Wed, Jun 5, 2024 at 6:33=E2=80=AFAM Liam R. Howlett <Liam.Howlett@=
oracle.com> wrote:
> > > >
> > > > * Matthew Wilcox <willy@infradead.org> [240604 20:57]:
> > > > > On Tue, Jun 04, 2024 at 05:24:46PM -0700, Andrii Nakryiko wrote:
> > > > > > +/*
> > > > > > + * find_and_lock_vma_rcu() - Find and lock the VMA for a given=
 address, or the
> > > > > > + * next VMA. Search is done under RCU protection, without taki=
ng or assuming
> > > > > > + * mmap_lock. Returned VMA is guaranteed to be stable and not =
isolated.
> > > > >
> > > > > You know this is supposed to be the _short_ description, right?
> > > > > Three lines is way too long.  The full description goes between t=
he
> > > > > arguments and the Return: line.
> > >
> > > Sure, I'll adjust.
> > >
> > > > >
> > > > > > + * @mm: The mm_struct to check
> > > > > > + * @addr: The address
> > > > > > + *
> > > > > > + * Returns: The VMA associated with addr, or the next VMA.
> > > > > > + * May return %NULL in the case of no VMA at addr or above.
> > > > > > + * If the VMA is being modified and can't be locked, -EBUSY is=
 returned.
> > > > > > + */
> > > > > > +struct vm_area_struct *find_and_lock_vma_rcu(struct mm_struct =
*mm,
> > > > > > +                                        unsigned long address)
> > > > > > +{
> > > > > > +   MA_STATE(mas, &mm->mm_mt, address, address);
> > > > > > +   struct vm_area_struct *vma;
> > > > > > +   int err;
> > > > > > +
> > > > > > +   rcu_read_lock();
> > > > > > +retry:
> > > > > > +   vma =3D mas_find(&mas, ULONG_MAX);
> > > > > > +   if (!vma) {
> > > > > > +           err =3D 0; /* no VMA, return NULL */
> > > > > > +           goto inval;
> > > > > > +   }
> > > > > > +
> > > > > > +   if (!vma_start_read(vma)) {
> > > > > > +           err =3D -EBUSY;
> > > > > > +           goto inval;
> > > > > > +   }
> > > > > > +
> > > > > > +   /*
> > > > > > +    * Check since vm_start/vm_end might change before we lock =
the VMA.
> > > > > > +    * Note, unlike lock_vma_under_rcu() we are searching for V=
MA covering
> > > > > > +    * address or the next one, so we only make sure VMA wasn't=
 updated to
> > > > > > +    * end before the address.
> > > > > > +    */
> > > > > > +   if (unlikely(vma->vm_end <=3D address)) {
> > > > > > +           err =3D -EBUSY;
> > > > > > +           goto inval_end_read;
> > > > > > +   }
> > > > > > +
> > > > > > +   /* Check if the VMA got isolated after we found it */
> > > > > > +   if (vma->detached) {
> > > > > > +           vma_end_read(vma);
> > > > > > +           count_vm_vma_lock_event(VMA_LOCK_MISS);
> > > > > > +           /* The area was replaced with another one */
> > > > >
> > > > > Surely you need to mas_reset() before you goto retry?
> > > >
> > > > Probably more than that.  We've found and may have adjusted the
> > > > index/last; we should reconfigure the maple state.  You should prob=
ably
> > > > use mas_set(), which will reset the maple state and set the index a=
nd
> > > > long to address.
> > >
> > > Yep, makes sense, thanks. As for the `unlikely(vma->vm_end <=3D
> > > address)` case, I presume we want to do the same, right? Basically, o=
n
> > > each retry start from the `address` unconditionally, no matter what's
> > > the reason for retry.
> >
> > ah, never mind, we don't retry in that situation, I'll just put
> > `mas_set(&mas, address);` right before `goto retry;`. Unless we should
> > actually retry in the case when VMA got moved before the requested
> > address, not sure, let me know what you think. Presumably retrying
> > will allow us to get the correct VMA without the need to fall back to
> > mmap_lock?
>=20
> sorry, one more question as I look some more around this (unfamiliar
> to me) piece of code. I see that lock_vma_under_rcu counts
> VMA_LOCK_MISS on retry, but I see that there is actually a
> VMA_LOCK_RETRY stat as well. Any reason it's a MISS instead of RETRY?
> Should I use MISS as well, or actually count a RETRY?
>=20

VMA_LOCK_MISS is used here because we missed the VMA due to a write
happening to move the vma (rather rare).  The VMA_LOCK missed the vma.

VMA_LOCK_RETRY is used to indicate we need to retry under the mmap lock.
A retry is needed after the VMA_LOCK did not work under rcu locking.

Thanks,
Liam

