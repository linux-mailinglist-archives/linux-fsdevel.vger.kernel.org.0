Return-Path: <linux-fsdevel+bounces-66719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60281C2A87B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 09:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14F041891615
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 08:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6E22DC766;
	Mon,  3 Nov 2025 08:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y78QDuCF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GCsxG84g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34C02DA744;
	Mon,  3 Nov 2025 08:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762157875; cv=fail; b=jhTAHCscPKkagsiCEsiCRjoQKvg0hz5yooF+3s2OpsCvqM2y9Ms4jYsf4dtYEgz5AnSSm17xaUWJ+V0WjQnODLszd87WYQDlWERtMWovswoGQLdzmcy3hIA/EzSx9vBojfVcvrsEB9F+6JBU8DsUyH4VqmcJwWz1/YxEbxR17dI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762157875; c=relaxed/simple;
	bh=CdpHoUkzQ0IgNVDqYthtIGM7TQZAK+AkVUIv+q65irM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D9ZrKL+XufrrfzuDzf9GhOoBLnn4xJDRjbAWwn3ZyJhN3dvt/b6Yys+ZhzxkL+GuJq5TlZrYaPCuqG0jSvF3+S8ZJy3xH7Kqf0m5YLLZZwTdEEenncgbgrNYPRKzkC3VFEARg/BvLiGMPBOu+x+lxea9RMnG50zVPAvAIu2GQNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y78QDuCF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GCsxG84g; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A384Gl5016900;
	Mon, 3 Nov 2025 08:16:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=jChQpwT+gFg1scc07SFf9OaIVAQpxzIvbFia05iRzbw=; b=
	Y78QDuCFxP8mbdJlQ05ZLM9QeeAZpvz8rQVnwYL0x4Qr39vjnLBPhlwUYDm1mglB
	T4xVkk6W7QhlSZ1Gvz4uw3h44EP7A1GuSKnFuYIKzIlcY1Xlc5GAKwHDYwqaWjt4
	RZMdOQkhI5Y66/9sC7iZPTXuosZBEaNcx1wgNwb39I759F8wsA2+amkUmLmKw4ka
	N/UwZ18srfBtEoqW2vLyKR+Fq/Unb0kmZdDodZD+rl1Sn57o28H5UuDOJhqz/EgW
	NceMeOWVbgJ3o4gKVcekUX1wZebAPqkAkc9+4aKzruGmmvfxW46Jo9AjUL7/fizm
	5PpHNsSLSRpgKryAIhxHcg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a6rje814p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 08:16:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A361xGr039424;
	Mon, 3 Nov 2025 08:16:49 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012025.outbound.protection.outlook.com [52.101.43.25])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nhkkr8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 08:16:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bMRC6H4HD4iXXg+5bZBLcpyvVt6rFZusl4AKCxDjL/Soc/PHarCpXehWA/gVKX9CL1WGQjwHLDbA69qdc+VBzj+wsMRFmvFWKbf29lY4Qepr6yxMkmSFDgenl5JL16BZNXBDRLiWdsfpZEsu8sK0mllmINXjXWeDCARrra8fnHrA28z/FHL7DP1jFZFQoVYOTMVDpGb6AbgE9foWdmtNOH5//xkmsw5K2IiDwZ9PqRB16qB2enaFwVczq7hRqVr8RhwL8fgUqOpxYiVYCpR2DzbcuIgYX+zbuzssJ017T4Q9jm9rCgNGEngvC95GJd0fPkxi3bCDvTtocJ8z/DmztQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jChQpwT+gFg1scc07SFf9OaIVAQpxzIvbFia05iRzbw=;
 b=c3BiLxEn4/h0UiMFM7Fejp9lMNyuMo/9MRzqsBV9EnZG6FQdG8gkvKtAyJCl7yKNw2EkeT8Z1eZ/KnkJorNftTC8hrGIp5Ln2OSyjCzteIOTxt49Nju3+soAmcwwrkqbXBq5s//A3rPb8h0vh1WDnphz2PEEFcPHcNjDlaChuIdL16MbVMtYG8lVv+/r/b7x75hUXBDkBSQI4SDO9yyRs6OXYM2QscTnU79CL5Q7jkIx2Ec5bI1AeG4f42Ishu4QUcy+lGoRIDBq9Pr2Ok+/j3o1rczY9cXybdFZ8+6txca5QInNf8G0iex36nZJ45EBr+kxC7AmidyxARh/H45XXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jChQpwT+gFg1scc07SFf9OaIVAQpxzIvbFia05iRzbw=;
 b=GCsxG84gadttR5HAsxKDLW1z/czsyJMCqFJZpyrBK6d96GfFH9oF09E+P85GE7dP1g0+4cAdbt/4q22gI8LYgu4JeNhp5QdA9WFYREL1oq6rn8WYEAfVgyoCVeZkeNjAPj0vzvAM34G+E/bmkFDeSDrfZS/QIU6gIL6C/d1meXk=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DS0PR10MB6080.namprd10.prod.outlook.com (2603:10b6:8:c8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 08:16:43 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 08:16:43 +0000
Date: Mon, 3 Nov 2025 17:16:33 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Jiaqi Yan <jiaqiyan@google.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>,
        =?utf-8?Q?=E2=80=9CWilliam?= Roche <william.roche@oracle.com>,
        Ackerley Tng <ackerleytng@google.com>, jgg@nvidia.com,
        akpm@linux-foundation.org, ankita@nvidia.com,
        dave.hansen@linux.intel.com, david@redhat.com, duenwen@google.com,
        jane.chu@oracle.com, jthoughton@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, muchun.song@linux.dev, nao.horiguchi@gmail.com,
        osalvador@suse.de, peterx@redhat.com, rientjes@google.com,
        sidhartha.kumar@oracle.com, tony.luck@intel.com,
        wangkefeng.wang@huawei.com, willy@infradead.org, vbabka@suse.cz,
        surenb@google.com, mhocko@suse.com, jackmanb@google.com,
        hannes@cmpxchg.org, ziy@nvidia.com
Subject: Re: [RFC PATCH v1 0/3] Userspace MFR Policy via memfd
Message-ID: <aQhk4WtDSaQmFFFo@harry>
References: <20250118231549.1652825-1-jiaqiyan@google.com>
 <20250919155832.1084091-1-william.roche@oracle.com>
 <CACw3F521fi5HWhCKi_KrkNLXkw668HO4h8+DjkP2+vBuK-=org@mail.gmail.com>
 <aPjXdP63T1yYtvkq@hyeyoo>
 <CACw3F50As2jPzy1rRjzpm3uKOALjX_9WmKxMPGnQcok96OfQkA@mail.gmail.com>
 <aQBqGupCN_v8ysMX@hyeyoo>
 <d3d35586-c63f-c1be-c95e-fbd7aafd43f3@huawei.com>
 <CACw3F51qaug5aWFNcjB54dVEc8yH+_A7zrkGcQyKXKJs6uVvgA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACw3F51qaug5aWFNcjB54dVEc8yH+_A7zrkGcQyKXKJs6uVvgA@mail.gmail.com>
X-ClientProxiedBy: SL2P216CA0079.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2::12) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DS0PR10MB6080:EE_
X-MS-Office365-Filtering-Correlation-Id: 6853d431-25bd-465e-4bce-08de1ab1528e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkFnOFBaTkd1dlF3Mms0YktFaEVBbzFma3RJbmUwNmVjNVZRK2doVXdxb3lD?=
 =?utf-8?B?YlFrZDJOS1ZRY1ZBc210NDdiUzZqOVhvRUxaelNGN2puNUxFWVdra3R3OXg5?=
 =?utf-8?B?NTZiVDJweHVra1Yxd1MrRmp3R2RPVVBZSnhEckt5WVVXYjVDS0JWb1FEOVFt?=
 =?utf-8?B?d3BSaEkrWDZaSWJydUVUdVVCeGcvU2dURzFVMmlSakVJaUF1R1VOdnIyNWQ5?=
 =?utf-8?B?NUdaZmFNUnNORGhyUkJxYTd3R3JDcWxsMHpKWE5oa3lITFpkcFdxTllSMTg2?=
 =?utf-8?B?Q1pLY2dvYXBwVjRxNmE5Zlp6dUxIdkRKZjFTRFUwYlN3N0ZvU211WUlreGJ4?=
 =?utf-8?B?UkRFRGxqcFF1TTVGUW5oa1BoUDljUTltRXZoWkJWbDlMZ1UySWhRMHNZVUox?=
 =?utf-8?B?T0VHdW1waHhPVk5VUGRCK25CN3YwN2xnM3VCLytwV0JFQzdMYS9TNHFKcmJ3?=
 =?utf-8?B?VDE1dmdiQmZmLzVFVy9Qc0g2cVZWbFplME9lRWRpWGlxUEdaczR5YXVoU3Vr?=
 =?utf-8?B?Q0hlNjF0eUN0YU0zNVJkOHd2VVZMYUhPM1h6TmEvNXZBdDRTUVFrT1RpaVBz?=
 =?utf-8?B?MTJXWGFoN3EzZ1BOZUdBbjhpZExVUllTVW0zZ3VYK0Z1ZXRGVFYxSGZSYjZq?=
 =?utf-8?B?WHd2VFJzMTNJdGxaSlNXeXpaMlJvMlFjRDAwY3hPV1VpRkZOeEdLZVhISDhu?=
 =?utf-8?B?Zkg1VUduVGtZN2dCeC9DWWRJVE1DM0JxTE8wRE1EK2ZHMm52NkRZZ0tJa1Bs?=
 =?utf-8?B?YUZOcEV6UElvRHk4dlBxbmZtclJSd0xmU1IxMzdWUVE5Uy8rQ0VLTmFKTG9H?=
 =?utf-8?B?K2dWVWo3RTV2RlVXcmsycUxQa3Ira0JDLzJjdFI3NkVGOG05QVg2cGJiQXNJ?=
 =?utf-8?B?LzlJZmx3MHpjODA1TTRpS0RzeWRDUmZ6UDJXNGNWeGRVSHZCelZLdzY4UUlJ?=
 =?utf-8?B?R3NmdktLT0FjMjErekNkUzl2bkhid3g0VFowcTdtWkhzeFFmbnFWMGNCTitu?=
 =?utf-8?B?MU1sZlBXTnJqTVFuTkVhT3JEaHVHaFNvazluZUZyWUlITGd1VTJ2aXAxVTFj?=
 =?utf-8?B?YUpPUmJUWGI5bkRqbm1UZVdLczZCNmZUdXB6WjFyVnczUG1EcEVZU0NMc213?=
 =?utf-8?B?b0Z2SksxRmxPdStCeG5SemFjVTlINVlyaGwweWcyMW1BUndnQWpqVVQzRzUv?=
 =?utf-8?B?aFp1Y3pTdTNEOUJMVFgrU2loLzBCZkJCNHgrV0RYd1M2NkIvTmZwY0lwQlFh?=
 =?utf-8?B?aXluS0dza2IrQlJUZGdSZWZvblFwYWl2VGtrOFUxZ2RCM2w0MU1pR0xSNzl2?=
 =?utf-8?B?WnNPczdMV2k1VTZmeUtFYWNIN2NjL3JyYjluWVphRjIrN3VnMzAvb2RLZnkw?=
 =?utf-8?B?cUU1RGtJcDNnSWU5c0FRRUZLMHloTmtHcXZOV2ZmWEJRYmF5Z0E3QlZQanlS?=
 =?utf-8?B?MDdzMzZWc1lKaHdFM1BFWUNNMUk4TTdCanJNM1lNWkJJcitUYUM5MUZQendW?=
 =?utf-8?B?c3dka3dqRkw5VnEvRkpxSENZakJiRElMTnBycFNkV2RCUC94NEdTSDVOYmdn?=
 =?utf-8?B?dE5kZHhGd2IvNE9YNUdrSE1ST2E3c1BLZ0E1Ukl6RnEyT0NuRm9YcTBQUmdp?=
 =?utf-8?B?b3UrMHRHVFhMQ1Q4cmF6dUpGdld6aUtiN29IdkdSamdXNmFrQjJVUnJrMjVE?=
 =?utf-8?B?YXdoV0tmQXY2ZDdIcGZFUGtkMEdzS0k2bkhqMDAyU29QMElsU2dZNXUxZ20w?=
 =?utf-8?B?NE41OUdqYWp6aTZFQ0hGUGhwUWFxcGNIYzZhYlpCOHFiWHJuWU42UUo3TGJi?=
 =?utf-8?B?V05TNFBYandsMXdOTlEwUjRyakhFQmY3STNwNzUweW5rUlM0SkR1SksxZkZi?=
 =?utf-8?B?elJublpUWURCVXlmTGNESmF6WUxUZCtjak9ydDhJaTNCMnBVYUt6eitCVnE3?=
 =?utf-8?B?UENmc25Pa2toYUQ4QXB1YmVDTS9jV203c2MxOVNoZ0M2Yll5eVVGNGdpZE9M?=
 =?utf-8?B?UmUzdmhXZzRnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDlRS0ZPREg4N3h2RVFaSmFKcGZVdHZ1T01sQ0hmRFVNUEVIMEUrRmJqZXBB?=
 =?utf-8?B?ZDBLV2xTejhXb285dDJKUnZHa2NTUDZVRXpwK2d4MzNxWXRRMG5UV3J1ZnJF?=
 =?utf-8?B?YmxGLzA4QUNXNUowc3Zwc2tUUkR3OFErdlZEd3BFdmcybXpOeUJjc0N3dXJX?=
 =?utf-8?B?UVBJRG1pVDB6bVV1ZWhtQjlrbTBVd0hZNkdXNFBtOHNicDFwQXFRVWxKQlZI?=
 =?utf-8?B?K3RXR3JFQkNYUS9KemcxMEpKT2hTREllSFdvak5FQ0xod3dZMFhsLzhTMUE5?=
 =?utf-8?B?QXBPUGJQMmVhZ3ZjcHpVOWpzRncxSHV1RGlUaXZxUnM5UXczd2locitrSkNn?=
 =?utf-8?B?UkhoZElqcXpQNnlXaDZVaUVMT2d3YVlDNjdQMTJ5SllkTXpZb1BpeklraTJu?=
 =?utf-8?B?K1IvbFdYQkFTajZXRFNOQkNueFhUVFhKT1AvUU42aGlVWlE2bXV1cklwMkZT?=
 =?utf-8?B?Und3dUxwTzBUeTgvNExCT2xMRUNwUEdac3NCbFA4d0VEVHBFTVFLRTJHQSsv?=
 =?utf-8?B?TDBaRlZ5Z1ZZOTZDaFo3Zkw0TXVKRElKa3VaaHloWUhTUERYRVR6clJPc1Rp?=
 =?utf-8?B?cDZvMWZaRU9ydUs1czlDTmdpTHlqbk1PQ0tBeXh1NHpBSE01V0h1blhoekdE?=
 =?utf-8?B?ZlFNNFFIQ21aWXQ2dU5QUlRMYW44a01JMm52SUFZVDF2c1l3blNGOUxIWWhq?=
 =?utf-8?B?akNoVnJBRnJqUlM1Q3VUNDBWUVJSdFhvaU5hSkdpS1VHbHcrL2wvZ0tPc0ZQ?=
 =?utf-8?B?QXh5cEFpbjV5U2FXeXBLWVFlcUVIaDBuMFp2QnV2RkVpK2lYUzJiQmlLRnZ5?=
 =?utf-8?B?aW5TZmtvMFhSa2NyL0N3WnRVaDJkdkNpQzhyemVyTWNXanNyRHpmeUp5aHcz?=
 =?utf-8?B?KzhzNWw2MXE2Wks0aWRKS2lMcHBsWlFjUWJHekNCeE9jRk44bTFFdmFrZFlM?=
 =?utf-8?B?MHhtVE45L0Z5cUExQkx2RmcrWm5hZ1pKUHNrUUNhN2NHOExNRVQ4bngreDBo?=
 =?utf-8?B?U04rZDRMRVdzY3pvcjNWOFBUbWQrVXUwSDdFdTRhOE5YMHRSNW9Ka0I2TWR4?=
 =?utf-8?B?S1I3QjVHQmxwOVRpWElWZ1VBNHJsQkZPcVVZZU9NMW56cVo5VktPb3FCMTd4?=
 =?utf-8?B?WWxCU0o5c2xzVEVHS1psWFJ0bXdEQlJIT09hdWc4TkZrV0VHZUxYS2JQaDlP?=
 =?utf-8?B?K29sT0gxU2VTNmNrY2ZiS1QzS0FoY05xam1NcDA2cFU3SWtnWHdLREpCTGZu?=
 =?utf-8?B?V1k2bTlvdmk3MEhSUXFDSm5qaE1yYUt1R1E0YTZETVRWYnlIbVJzdlpMOHNP?=
 =?utf-8?B?cWRaaXY0c1pSc1ppTUdscE52UWVRTk5kVEFWa21SYVdpUkdjbG1MYklPajZX?=
 =?utf-8?B?T0tpSE9yMXlxK2xtRndPdlJsYUZHWnhlZGhGaVB2L21jTisxa3pjZHc0bHBk?=
 =?utf-8?B?WUZYc0NvY1hPRmZZYTFYWTZ4NmJaQU5EZXR2SlpLR01ZWlJNRTdEUS9aRkVp?=
 =?utf-8?B?YVh1aVQyeFZYeWRJUU84cWN4Nk5QQnpXY1ord1ZqRkhaR1NUMkNVdnErSStL?=
 =?utf-8?B?ems5dG9tSk5pMHA1cU1zZm5Db3JHVjVmem51L3RYblhyNDA0eUZRbWlFZFV5?=
 =?utf-8?B?ZVFOUEF1SkpIVFg4OUFUUVI5cURhTnczdkI0bnAyVWxRbkZuY1pKYXFCUVIz?=
 =?utf-8?B?WVB1NnMzLzg3K1NCQ2NSNmc2S0FKYlFaZy9ZSzJIT0czMGc4cE9pUWtWWFFI?=
 =?utf-8?B?WE1tOE5EUHFLRW9jSHkrdHluVlJsb2w1K09mZ2ZqbkZQbUZnRGhtb0JueDhN?=
 =?utf-8?B?M28rbmZJMVZSMnNxTGdTYWllRUJvcWdWQ2orMThaeW85eERPQ0oxRnp6QTZz?=
 =?utf-8?B?bGNYaWs2azRuUlYwTDFkTkZLMitMZmR6R0NiWG9KZXhYMzh6blorR3BrTTJx?=
 =?utf-8?B?Yll2R0VFYWZ3V0NQVE9iSk5zS20zNVZCMm8ySVFHNm92RStVMERvSnZsU2da?=
 =?utf-8?B?Y3NuR3Vpcm1ka2E4YzJBc0pVMHpJZTFYZHp2NGtuYVhpcFBta1Nwd0VmK2xt?=
 =?utf-8?B?bitwOEJpMGJuTEFKNEtKRWlPcmpYc1g5UEFHVEFiTHpnQnZjc3plNmJCdWsr?=
 =?utf-8?Q?xfpxQEPusvnCjgYR5WhzMB/DF?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	en1JtnK0r3TqY8EaEzQjO73dBly9t1UXt87eDa+GsD2xEGQg1naoWUUixGPacv1JtqUYMHWeEhi0jjDCUzQccZdGyhnM+frgWJ6t32rJHP3RrEB+YoScX/gRVgYjbXfe/R05SDEJ3XFLswt5Zrqlc5NTLqcf/Blt77qiQiys4d1AHn5VNt1qACNXc0LnTsMYt4vLwatjwh6IH0z8X7l2i8yLYSzaHoHvD1iBmSv1jmKJD13o1dAtupYJ/592TG5cedUIoZtTJru57tI41EH+PfS4ajrbLOBKG9VFwQOOThpoQTkldd5swksPAuEcOWHhmpLw9On/4xgFVt2MgAfxuLEsWzBLQH+0fFT4xaonFB/NivInUoOHu7Njka/eSP6kObzLSCOh5wWz4tbDCC9F1XjxRUVWs3hoXyZZIdQoGGVNzEkfoEWAoTOHU88mKyeOcpVsbo4vJXQFm+Ewg4YIgt1sSDAcY6ua39SLOfxM9wK7B7UFjyrS+WPED/og6Ns/Ry8tJw3u9gP6YQrblNWdcgYW9CGj9nqrN3lj0OViqlhjHP1h30Yl1U/JDcAxmzb+I7zyVEWdK+ncWT2drMTS2XLHzUZKBpDQ5X5MRb/5s34=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6853d431-25bd-465e-4bce-08de1ab1528e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 08:16:43.3806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XMqF1XmpMafD9NUdkn4519psRX07IWj/UVkOeeB+ygNhzy/1NyFwcLEMJmiA8AK4p3VX47Bk2AOY9zRRX2DYFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6080
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511030075
X-Proofpoint-GUID: mXMI_o660rnRtxRL8VNRUq77mWJ6Ojlg
X-Authority-Analysis: v=2.4 cv=EvffbCcA c=1 sm=1 tr=0 ts=690864f2 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=R_Myd5XaAAAA:8 a=i0EeH86SAAAA:8 a=yPCof4ZbAAAA:8
 a=GJNGE0ECJFVJzd6KToEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=L2g4Dz8VuBQ37YGmWQah:22 cc=ntf awl=host:12124
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDA3NCBTYWx0ZWRfXzdvbc6GlCQiT
 +LiazWVIhlSVcgsoqNk6lk37RztSA7P4N/ij/cnYo5ki+c2qthxl9DVdUbGstsRMJhQkobhAjyQ
 yF98hy/2rkO/TYeFhUlLB6oN7KLoNcLJTlNQk1qMRFibYj5mNFx1cHGlfBB09+khTdgQKtbLLSv
 CHNdNt/gKuayfJ/M4CW800EATfW4Ta5gnImzhCePqHWoP9HV3b9d/BPCF/5ja3aIcOHFZ7G/3+P
 Czi9DJ+e5+XP4KHoZPvAy20Nphw04yzm6l/zewTdPRozDd8tPumw3M8i4N5vyleaDrdI1i0FrJ1
 1MOcVSyTcA4WvCl5mu13mwEACwkkZtdT4Oz7A9NpQVSjum0GhVLBRaP0Hl57WRo/pKol4FhXPd2
 KBWibAK4QVjCJ3/TD11pKpK9a8jA6z/YuzzC+GpLJKQlz4uhstM=
X-Proofpoint-ORIG-GUID: mXMI_o660rnRtxRL8VNRUq77mWJ6Ojlg

On Thu, Oct 30, 2025 at 10:28:48AM -0700, Jiaqi Yan wrote:
> On Thu, Oct 30, 2025 at 4:51 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
> >
> > On 2025/10/28 15:00, Harry Yoo wrote:
> > > On Mon, Oct 27, 2025 at 09:17:31PM -0700, Jiaqi Yan wrote:
> > >> On Wed, Oct 22, 2025 at 6:09 AM Harry Yoo <harry.yoo@oracle.com> wrote:
> > >>>
> > >>> On Mon, Oct 13, 2025 at 03:14:32PM -0700, Jiaqi Yan wrote:
> > >>>> On Fri, Sep 19, 2025 at 8:58 AM “William Roche <william.roche@oracle.com> wrote:
> > >>>>>
> > >>>>> From: William Roche <william.roche@oracle.com>
> > >>>>>
> > >>>>> Hello,
> > >>>>>
> > >>>>> The possibility to keep a VM using large hugetlbfs pages running after a memory
> > >>>>> error is very important, and the possibility described here could be a good
> > >>>>> candidate to address this issue.
> > >>>>
> > >>>> Thanks for expressing interest, William, and sorry for getting back to
> > >>>> you so late.
> > >>>>
> > >>>>>
> > >>>>> So I would like to provide my feedback after testing this code with the
> > >>>>> introduction of persistent errors in the address space: My tests used a VM
> > >>>>> running a kernel able to provide MFD_MF_KEEP_UE_MAPPED memfd segments to the
> > >>>>> test program provided with this project. But instead of injecting the errors
> > >>>>> with madvise calls from this program, I get the guest physical address of a
> > >>>>> location and inject the error from the hypervisor into the VM, so that any
> > >>>>> subsequent access to the location is prevented directly from the hypervisor
> > >>>>> level.
> > >>>>
> > >>>> This is exactly what VMM should do: when it owns or manages the VM
> > >>>> memory with MFD_MF_KEEP_UE_MAPPED, it is then VMM's responsibility to
> > >>>> isolate guest/VCPUs from poisoned memory pages, e.g. by intercepting
> > >>>> such memory accesses.
> > >>>>
> > >>>>>
> > >>>>> Using this framework, I realized that the code provided here has a problem:
> > >>>>> When the error impacts a large folio, the release of this folio doesn't isolate
> > >>>>> the sub-page(s) actually impacted by the poison. __rmqueue_pcplist() can return
> > >>>>> a known poisoned page to get_page_from_freelist().
> > >>>>
> > >>>> Just curious, how exactly you can repro this leaking of a known poison
> > >>>> page? It may help me debug my patch.
> > >>>>
> > >>>>>
> > >>>>> This revealed some mm limitations, as I would have expected that the
> > >>>>> check_new_pages() mechanism used by the __rmqueue functions would filter these
> > >>>>> pages out, but I noticed that this has been disabled by default in 2023 with:
> > >>>>> [PATCH] mm, page_alloc: reduce page alloc/free sanity checks
> > >>>>> https://lore.kernel.org/all/20230216095131.17336-1-vbabka@suse.cz 
> > >>>>
> > >>>> Thanks for the reference. I did turned on CONFIG_DEBUG_VM=y during dev
> > >>>> and testing but didn't notice any WARNING on "bad page"; It is very
> > >>>> likely I was just lucky.
> > >>>>
> > >>>>>
> > >>>>>
> > >>>>> This problem seems to be avoided if we call take_page_off_buddy(page) in the
> > >>>>> filemap_offline_hwpoison_folio_hugetlb() function without testing if
> > >>>>> PageBuddy(page) is true first.
> > >>>>
> > >>>> Oh, I think you are right, filemap_offline_hwpoison_folio_hugetlb
> > >>>> shouldn't call take_page_off_buddy(page) depend on PageBuddy(page) or
> > >>>> not. take_page_off_buddy will check PageBuddy or not, on the page_head
> > >>>> of different page orders. So maybe somehow a known poisoned page is
> > >>>> not taken off from buddy allocator due to this?
> > >>>
> > >>> Maybe it's the case where the poisoned page is merged to a larger page,
> > >>> and the PGTY_buddy flag is set on its buddy of the poisoned page, so
> > >>> PageBuddy() returns false?:
> > >>>
> > >>>   [ free page A ][ free page B (poisoned) ]
> > >>>
> > >>> When these two are merged, then we set PGTY_buddy on page A but not on B.
> > >>
> > >> Thanks Harry!
> > >>
> > >> It is indeed this case. I validate by adding some debug prints in
> > >> take_page_off_buddy:
> > >>
> > >> [ 193.029423] Memory failure: 0x2800200: [yjq] PageBuddy=0 after drain_all_pages
> > >> [ 193.029426] 0x2800200: [yjq] order=0, page_order=0, PageBuddy(page_head)=0
> > >> [ 193.029428] 0x2800200: [yjq] order=1, page_order=0, PageBuddy(page_head)=0
> > >> [ 193.029429] 0x2800200: [yjq] order=2, page_order=0, PageBuddy(page_head)=0
> > >> [ 193.029430] 0x2800200: [yjq] order=3, page_order=0, PageBuddy(page_head)=0
> > >> [ 193.029431] 0x2800200: [yjq] order=4, page_order=0, PageBuddy(page_head)=0
> > >> [ 193.029432] 0x2800200: [yjq] order=5, page_order=0, PageBuddy(page_head)=0
> > >> [ 193.029434] 0x2800200: [yjq] order=6, page_order=0, PageBuddy(page_head)=0
> > >> [ 193.029435] 0x2800200: [yjq] order=7, page_order=0, PageBuddy(page_head)=0
> > >> [ 193.029436] 0x2800200: [yjq] order=8, page_order=0, PageBuddy(page_head)=0
> > >> [ 193.029437] 0x2800200: [yjq] order=9, page_order=0, PageBuddy(page_head)=0
> > >> [ 193.029438] 0x2800200: [yjq] order=10, page_order=10, PageBuddy(page_head)=1
> > >>
> > >> In this case, page for 0x2800200 is hwpoisoned, and its buddy page is
> > >> 0x2800000 with order 10.
> > >
> > > Woohoo, I got it right!
> > >
> > >>> But even after fixing that we need to fix the race condition.
> > >>
> > >> What exactly is the race condition you are referring to?
> > >
> > > When you free a high-order page, the buddy allocator doesn't not check
> > > PageHWPoison() on the page and its subpages. It checks PageHWPoison()
> > > only when you free a base (order-0) page, see free_pages_prepare().
> >
> > I think we might could check PageHWPoison() for subpages as what free_page_is_bad()
> > does. If any subpage has HWPoisoned flag set, simply drop the folio. Even we could
>
> Agree, I think as a starter I could try to, for example, let
> free_pages_prepare scan HWPoison-ed subpages if the base page is high
> order. In the optimal case, HugeTLB does move PageHWPoison flag from
> head page to the raw error pages.

[+Cc page allocator folks]

AFAICT enabling page sanity check in page alloc/free path would be against
past efforts to reduce sanity check overhead.

[1] https://lore.kernel.org/linux-mm/1460711275-1130-15-git-send-email-mgorman@techsingularity.net/
[2] https://lore.kernel.org/linux-mm/1460711275-1130-16-git-send-email-mgorman@techsingularity.net/
[3] https://lore.kernel.org/all/20230216095131.17336-1-vbabka@suse.cz

I'd recommend to check hwpoison flag before freeing it to the buddy
when we know a memory error has occurred (I guess that's also what Miaohe
suggested).

> > do it better -- Split the folio and let healthy subpages join the buddy while reject
> > the hwpoisoned one.
> >
> > >
> > > AFAICT there is nothing that prevents the poisoned page to be
> > > allocated back to users because the buddy doesn't check PageHWPoison()
> > > on allocation as well (by default).
> > >
> > > So rather than freeing the high-order page as-is in
> > > dissolve_free_hugetlb_folio(), I think we have to split it to base pages
> > > and then free them one by one.
> >
> > It might not be worth to do that as this would significantly increase the overhead
> > of the function while memory failure event is really rare.
> 
> IIUC, Harry's idea is to do the split in dissolve_free_hugetlb_folio
> only if folio is HWPoison-ed, similar to what Miaohe suggested
> earlier.

Yes, and if we do the check before moving HWPoison flag to raw pages,
it'll be just a single folio_test_hwpoison() call.

> BTW, I believe this race condition already exists today when
> memory_failure handles HWPoison-ed free hugetlb page; it is not
> something introduced via this patchset. I will fix or improve this in
> a separate patchset.

That makes sense.

Thanks for working on this!

> > > That way, free_pages_prepare() will catch that it's poisoned and won't
> > > add it back to the freelist. Otherwise there will always be a window
> > > where the poisoned page can be allocated to users - before it's taken
> > > off from the buddy.
> > >
> >

-- 
Cheers,
Harry / Hyeonggon

