Return-Path: <linux-fsdevel+bounces-38391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21076A01586
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2025 16:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8746B3A3E06
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2025 15:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C34E1CDFCC;
	Sat,  4 Jan 2025 15:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C+EjS3yc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OyGLAeZr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584CF1BD9F5;
	Sat,  4 Jan 2025 15:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736004667; cv=fail; b=OHmJriluw2qpAHRu2KFNa6QOdqsaZCtYdPUpemhZzvGOT6ZW9g9wu5jPCzzKL5g2wLwJwTSENrpUGLedmJtDHVoDcQTURO1zHBfn48z6mASEAM0dHx017vIDdRQhbLJn5y2oQkz8nKXrNLjxh4fPDGAjGirgpTEWm7nc8vulTzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736004667; c=relaxed/simple;
	bh=a623CPEMvUblv6C7jUT3td9RPIj3oycEXB98gSVaaVs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ez7JUuofDh0WSwT0cWoXwaXOTrFYeyKT16k+z31/cYvHVQPr1caJ/gmBPH+H6feoJmkIqkF2gXfC2jJ/2BBVOMTI8e8KvXWUmWDA6cM25RDvx4nWVQNOuAdnQjMKW95HxaJyrVugNJjQsCBMRgfvhe5KeTYLG7wFEjAEi1ofrAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C+EjS3yc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OyGLAeZr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 504Digqn002918;
	Sat, 4 Jan 2025 15:30:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=j5Uf9hjEjm7bLAx7fTuoWbzEfivcd2mXIV6XqpIZSfU=; b=
	C+EjS3ycBqQOmZRYSd+bxR6HLJm59NYszlMq83k9xGujzqkTGpC6CouVwXdHfOgB
	Bsf0H1OulG6/aBmw7YjxFuxl6ULMg18PkJGv+bbki4xlgVw6Q4HxRT8IU1Uk2Kg3
	CyPAyEDDi5IAWyEQvJ8/fMfy+83QzggAw91zzXg9aXZD3M+IbVSWT4QYDheL+1bF
	sluCvTqEsvIvW0WIPMlW5h9yJqwwfp7iFTVMUtyKn823+69m+D4SMqApH97tA7wQ
	mNf3/1cvVy4S3tHCXZM4OOvD83e44cikOa/8AO3MZYSAMMtylSvKsEdx289SX/HG
	41YEdhcG41z17fGv4gje5A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xuk00unf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 04 Jan 2025 15:30:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 504BfMR1010864;
	Sat, 4 Jan 2025 15:30:39 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2049.outbound.protection.outlook.com [104.47.58.49])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43xue5nccx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 04 Jan 2025 15:30:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ILTb44PVbnJWAcd9E+0biSklTVOQ/c8FHgLdxvd4VAAH2dtlWSr/nnBco9xdNrK7999t2/qGenuv08Nb40ZUKmRcCv4yifeuETaYKp1smBIQofEwppMs11doUAHV10lfVT4tbeMBtF98YQzQ3UNGGYMVK6FLif2nIw/C5KRYIXnCNaoRM+uG1/EqfqTj6NUgcBAsBqurTC4xC+9r+dt0cd3ZndNhJv+YYhGaR6YSY/YDsIsehYObkIDbiJK/kTKyIX/ITF6polrxIrbuGNivl1VJvM8kMojv2mzjIS1K2RBi48A+yyJmWBsC1vt837wlRRT065r+ueZuyYYM3PG6qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5Uf9hjEjm7bLAx7fTuoWbzEfivcd2mXIV6XqpIZSfU=;
 b=VM6mrHI1d4YcnYJTVh2IfIgW+F6uRhJl72YnqdDMNsJjV36JLss3hXz2vsHJ+rZaZPKQW+b3WqVn8Vt6+ryVThL5UAXEOFwHj7si4Hq2pbA6TPnbd2BRJ655ybOaLJN/1du+5m850DbrS4PBozP/6Bd7iFm25s7TbKoEJQMR2xoJRcnRXyYToy/qQpCVQjWp7hGf4PA8zyvRu4OUxpgSrsqtIaAhxRtzwEy0KMPLp3KKwwY2I5iiO5qrwZ9gn5eF/Di2/hSEtiRUqoz/ZrP3SAKM5b05nCnv6dhrT8CgGX5uebhkR9FfJ29nCnCRSTw8QmZ++4kTCGg0I9ewI9ycig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5Uf9hjEjm7bLAx7fTuoWbzEfivcd2mXIV6XqpIZSfU=;
 b=OyGLAeZrP6l0AhLhFJUxYqom/eIwVf2gZMWnHtTdCvd9B+fjzouuk0BXcpXRMrFZACLji+dPH7QuJP6NFEcWyk6uBGXI3EKhfenWXTSr0rChwMaVtPk9L7NWn+WmDjfRZ6XC95shPKwVh0kQU8fCIi7m5Z6lYcI97BFEJu2RByU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN6PR10MB7520.namprd10.prod.outlook.com (2603:10b6:208:478::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Sat, 4 Jan
 2025 15:30:28 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8314.015; Sat, 4 Jan 2025
 15:30:28 +0000
Message-ID: <cf0b8342-8a4b-4485-a5d1-0da20e6d14e7@oracle.com>
Date: Sat, 4 Jan 2025 10:30:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Immutable vs read-only for Windows compatibility
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steve French <sfrench@samba.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <20241227121508.nofy6bho66pc5ry5@pali>
 <ckqak3zq72lapwz5eozkob7tcbamrvafqxm4mp5rmevz7zsxh5@xytjbpuj6izz>
 <28f0aa2e-58d7-4b56-bc19-b1b3aa284d8f@oracle.com>
 <20250104-bonzen-brecheisen-8f7088db32b0@brauner>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250104-bonzen-brecheisen-8f7088db32b0@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR15CA0017.namprd15.prod.outlook.com
 (2603:10b6:610:51::27) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MN6PR10MB7520:EE_
X-MS-Office365-Filtering-Correlation-Id: e80fdfe5-e3f4-491c-068e-08dd2cd4b795
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGdVcWU4SzhzTHF4L2VxVlpkTFd3NStrcFprMkRwcHMveFREK0dIak1xc3lp?=
 =?utf-8?B?QU1oOGQzOXAxaGFtQWtpVU1PT0pGU1Zrb1MvNC95TUQvcDdGa3V2TTVGVmhD?=
 =?utf-8?B?b3kvbHhDU0VuckVhQ2taK2JwVWdWckUwV0VxSEYyM251SkZaVjVHcjJadjl0?=
 =?utf-8?B?UjZqRG9nREszdTB6TWxtSit6YW5IWHY1VFkweE51cEFsVnNlaVVFL2xNZlc5?=
 =?utf-8?B?ajBzQmZhODB5OTYrZ2FxaFVPRVpicXIwQ0h1aitxYUxhNkdtSDlkdnVicjNJ?=
 =?utf-8?B?RGVQWVVseis2RXBuQmlvckhJVGtiMXNzT3BhR1hSVFVsRitwY0cwM2NkYWgr?=
 =?utf-8?B?QS9RUDFiaGc5K20reGZXa2pqa2FPaXJNRkZBakFtRkNROGdIMVhmMXNVelBZ?=
 =?utf-8?B?eFVJZ0NMMW1xK1VaelF0cXdhYmg3Rkd3RmJnaFlRWGF0Qkt5SnhteG0wbVhC?=
 =?utf-8?B?VkdxY1JtQS9Gc3l6bmUzMWRiaUlwVjlDN2Jzd0NhYXprbEJlckVIcXBMaUVq?=
 =?utf-8?B?aEZrMjN5QVFoUzFoNTlMY0hkUVZGemVPQXFzWmRDRkhIUGFSMXNQZ1BhbjJM?=
 =?utf-8?B?WkkyVlVhVkJWVjg4eVFoNFQwdkRYaUdFWE5mc2hMc1Q4UW5pUlhmNnp4WnNY?=
 =?utf-8?B?N3V6V0UzM0xZbkU5TzV4TUl4cmZsUjZaU3c2NkhETHUyYW9PQmgwTUZzYXor?=
 =?utf-8?B?M0Mzalpnc1hjNk53S1I5Q3pBMjcxWVlnMnB6ZXErSFRIUzkyV1RLQjhLWEhq?=
 =?utf-8?B?bHd2N3czKzV2eDdDMnpiMUIwWVJoY1ZmaWN4OVZBaFMyaUpzZEtwWnYyZFpq?=
 =?utf-8?B?TkVwZUdWR3Y1dFlYbFZCR2d3ZWRHdGVkU25aZkx4WlNMeWZmSmNYdzBiOFZH?=
 =?utf-8?B?WFArWWJKOVBiOGpFanl6ditHdzY2ZThhbnVRS1dtOE1sU3dDZVlYMmphUjNn?=
 =?utf-8?B?STk4Nkg4U1luNmhwMEpkT1hhWVptdUFFOHdGTUZ3amNZazY0UXhxQU95L3JC?=
 =?utf-8?B?RmxYbHMzZEZGZExrTGpNdUtWenBuejRkbVRNZ1ljNC9tVUM2UVlMNGRGK2Fl?=
 =?utf-8?B?RzBPYjVHK0hvMWErVVhGb1hGVmhvd3Z6NDhkUFZkczBhaWtYUHJMaGkxbVZC?=
 =?utf-8?B?YXJ0YmFnQmFQU1NSZ1g0dHhKN0R6TVU1ajVzTkgrK2ZSNU1Vbmdrc1NpRGxT?=
 =?utf-8?B?TFdoMGdWREsxbElqRWZXYUVBb0ZsSTFoeldtaTdFRHFJcWhvL3dET3I4cDhv?=
 =?utf-8?B?Qm12Q2NmcHJOU3lzSVg3cTJzQmxvRVlsSVd6S1JwN3BXZTZURjAwTnd1eVVB?=
 =?utf-8?B?dGE4eklrSHRTVFdDQzl3TTRvQnk2TzVGMCtrd1l3VVZBTk5NMk41SEt6QWx1?=
 =?utf-8?B?aFI0WGFUYStsUmt3RUlmdHR6aXczNXkyaDd1Z0h0MmQ2L1h3WFJQNmZqTEFh?=
 =?utf-8?B?RUxZVXBnOWFyQy9uc2RlTEh4QUU1Z0hsdWsxMEVxYjRwTnlQai9ZdXhURkpz?=
 =?utf-8?B?MzNQZkp4ZzFwQ3ZOZTdObzRvZ3A5Z0lTbllMMFZpeUdSd2pxV0h4bUNEMmFM?=
 =?utf-8?B?WnFVUy9PdjhSdGFZUVZIbGcxNE5WMkxnMUVCNWhUR1ZvSWJkclQ2dG1FUEpy?=
 =?utf-8?B?VGZtalA3b1gzZlRGRXFoL1F5STNDQ3hHYmRvUllnYldqZjAzWWxQQTRVMUlo?=
 =?utf-8?B?Z0c5Vy81WXFlRHBKbDVseCtOVitFd1BCUHc0RVV2bHZucW9xZkg2a2tJbm9w?=
 =?utf-8?B?RmpsS2Rsck1CVHFVdW1QNEFGNmdHbXFoSVVQQXB6ZS93Z2Z0ZUptUFkvOEI4?=
 =?utf-8?B?KzM3MXhQaWwzdUtqQlpJSlA1N0JVNy9oYVdkdjM4SGNRZzNUZ1dURGJSbnhp?=
 =?utf-8?Q?DpaRrmsPsPCy2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0xKQVorZGtXY1dSMTkzcEM2YUhqZHdiU2MvRWhZdzI5UHpPS2lkNmY2cXlO?=
 =?utf-8?B?THVyQWNrOTFua0pKN3hrRWFJSGFCVWI2OFE4MWJmakVtVVBSYmNQRDJCbzJa?=
 =?utf-8?B?U20wMXUwNTJPNE9DMFhpUWM4cHF2NnMyWVh6NUJLQnpoeU85QVA0WUo4Qk9k?=
 =?utf-8?B?TkxkMjM5YTgydXhuS3pBbzl5NTh3MkVERzdEeUFKQnJEL3VZQVhCc0ZpYWZr?=
 =?utf-8?B?MWZWZVFqZ0M5SkV6Y05rN1V5NVFrczFHVDlpUlVSV1JVQmRxTGRDcVdkQzNa?=
 =?utf-8?B?S2NKMW45U0pIZGVsMGlNci9yOC8vNkt2ZjFmMGdibFA5d0c5anByWXVKNTJ1?=
 =?utf-8?B?bUhsRjRmQTlPaW1xUCsvMTdvbTVEcFd2Mmkxck91eVFaK3BmT2FmZ1hDTkJ4?=
 =?utf-8?B?RmQ4TEZMTDlPVVhKOEV0SzZSR3RvMmladzN4WUI3OE14V3B3UkNBWFhDdmpO?=
 =?utf-8?B?Y3hWTERDUnhpZ0JJOGRFWkpLQ05xMi9qVys4WXhkNzZpeTBYMUFRdlpVRDl3?=
 =?utf-8?B?S3NWZEJKWDhPeE5OWDRWa3RFQTZ5cjBRZjFzMXhxSFZPejFsQnNQVy9sV1B4?=
 =?utf-8?B?Q1hSTFpsdjJGZ0c3V2FTTHhhcllPdHZDMjg5Z2dVcEttK2VXV3JEK2dWbWtP?=
 =?utf-8?B?NS9SVTdIVng2WXZsWmlIdXRZeGlIeVBQR2EvdmdyVUl6MjVXMHBBallHZERU?=
 =?utf-8?B?dm12T2dsMkRXR1VWRG9waEMwVXFWTDhDK1F2RmdxY0VtRWM3U2tneVVLOUh0?=
 =?utf-8?B?UWU2dThKVXI0cHBLVEczZExobDNxK1d4QmcyY2o0enRrSDVjUklaL2I1bFV1?=
 =?utf-8?B?bXhhT1NHMnZpUjdIMHNha25odTlMSUpqc3VicXpoSWlPUk80TUYrZFcxK0ZV?=
 =?utf-8?B?Q2Q0ek14K0JLd2E2VHFYTC9yKzJ6aGNZbDRMb1FVZjA4WlNpbGVSR1dNeTQ4?=
 =?utf-8?B?UjhFZG9NR0psVHVLVWhnZnFoTDBLWm9RdWdJNUkxZ0dZWUhBUFdpT3c3YkYx?=
 =?utf-8?B?WEJGVEl1OGdnRzNiYWpNVFBhbDR0WllTYjY1Wi9tTzRERzlPck1HMS8vQUl4?=
 =?utf-8?B?VjdMQ3FZVkdHUVUvLzRicXFPc2g2MGpUaHpQZEwxOEl6WUdVa3gzd1hNeW9y?=
 =?utf-8?B?eldBOExCRjEyRW04YWJTVXJHVWNCbkZnVWVHUU4relpNcnl1SVZSRGwxbWtm?=
 =?utf-8?B?R0s4RktLUGVtY2pZSWRBWnp5N1NVT2Rxbi9OQi95VCtWRDRYalJHVU1JWDJo?=
 =?utf-8?B?a2Z4TUpINU1HVEp4S1dIWWRWSXBTdDlwK2thcHZxWkc1Tmd1eElGN2lKWG1L?=
 =?utf-8?B?a3lTaUNUWk5aaTJsSlcvSEphWEFMd0pJdFBpb3NkSEF5Rk9BNCtsSFhWdnZ3?=
 =?utf-8?B?Ui90N2s4THFDQ1ZNSnFZdFNnMDFDL0VVSDRFY0czRlVlbkdtdFdydEJhcEQ3?=
 =?utf-8?B?U1lmdVdtUElpendKMFdNeDMzRmRwY1VSREoyRkRoQXE1Zk9mZjU5K2E4cUtC?=
 =?utf-8?B?dm5YalhoQ2dJUXAxU0JjNHhDUGkwVENEcTBDc09jYVQwMUVOTDdmaEgxeVkx?=
 =?utf-8?B?R0RsOGdhb0dObkVtL01BNFFHTjIrYWRiVmhZOHFrUXRreEhkT2srM2JFOW1E?=
 =?utf-8?B?Zy83SkNWVVFUYWlMNFJ0STd5ajRsVVduYWtwaC9CS091SDdzaUFpYUJPdi9r?=
 =?utf-8?B?aEhFNlZ5N1htL2xobHhnTWNqTC9CalRRUWpVaEZ1NUdQYzk3aE9qK3hvRnhY?=
 =?utf-8?B?TFY1UFJGdWluV25UQnBKZ3lYakJXMGxvUkJ1TTJjZGphREtKYy92bGp1NWdo?=
 =?utf-8?B?cGRVUTBjdkhzK0JqTDBkSTY5bGFYK1FyTmhqWTVSYXVBMGJWSXBOV2ZIMGcz?=
 =?utf-8?B?OFAwMCtudjdLcUd5QkthSGNTMTJacUJobGVab090U0IyMXBlcTNhNHVibVRG?=
 =?utf-8?B?UmhTTFFZOFNxWHcvcWVOQzIxWURmb1lCeUJqbEttNGU5aU5rbC8wTC9kSkVZ?=
 =?utf-8?B?a01HTlU5WUJBeHpkanpVd3hWNHNiQU1ZTkNOUGFnYUlJRWk0VDdCQmg0Q3ZY?=
 =?utf-8?B?Z0R3aWhwTlR0YWEzZlRjOUtlV1h1a1BQSHg5WVkvKzJLR0MvSEZyN0IxdXBW?=
 =?utf-8?Q?mxPh2spTxm19fH8fLn8v/L9Uu?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kTPUMHQ0OIeL9XjMpLqf87slBx8P9Qk3rcfFXHHrjbHqhOZpzHv9wfhTDIDD1IlHDX8FokNHe+ns/IrsZpx88YvdOjQRkgtE1F64sNFCmYdi4mX7npiG/WrP/DAG2Mzs/kjlGL4BJ9Q1wbXyWAPKYBbBQD21KyShxhgG/twg9CwVOJYA7zg6dJADWHb7ZWU6YnVSbABdeYkfvbOd08m4r2RLjcS7eqFuQH+M9RL9j+m8V+xAQrTskoWbuYqSFyijYHzkWkdxwianttPhystimjUDB8bkJ2xeicAulQJdzolhCUMTuRhiPlAPag+EL/gj/xuQdfft7+S/GTPxNSl1tGvQwWmrjOROdMFHYGc8d7khPTEJZBsbjmeXym5QvrNkKtZXMi433NeSqpXrihGpTUas7gy7UjeVM4Nt5NyUAtNreIbnqQVJFli/vVesX8FF3p6M2aA0rBxLUoDm/TJLxhgSIwifT0fix4bUM/8d7GVeUpmtjCUIKBy9ugJFkZP7YqrvFP5/ptrW+0RzIuYbNysDjOzoG4V+O9azKIu/ZRdoltC7lXqUKfKotM6vcob7zofqic3DWUCclxZaXuXrPu0MsePyKQ3oBobmEJH2TTA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e80fdfe5-e3f4-491c-068e-08dd2cd4b795
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2025 15:30:28.3117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CGYMx5NT2gF6+zfzsntwrYx34z2BPX9LcNLSCElh/fhHVDMSRv4en89kERoACUPqD6h/XB+mq5qM/TvhDaMUBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7520
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501040136
X-Proofpoint-ORIG-GUID: Mqj2BX3t3Ee9L1IJBoS0POsk2WKMP7rq
X-Proofpoint-GUID: Mqj2BX3t3Ee9L1IJBoS0POsk2WKMP7rq

On 1/4/25 3:52 AM, Christian Brauner wrote:
> On Thu, Jan 02, 2025 at 10:52:51AM -0500, Chuck Lever wrote:
>> On 1/2/25 9:37 AM, Jan Kara wrote:
>>> Hello!
>>>
>>> On Fri 27-12-24 13:15:08, Pali Rohár wrote:
>>>> Few months ago I discussed with Steve that Linux SMB client has some
>>>> problems during removal of directory which has read-only attribute set.
>>>>
>>>> I was looking what exactly the read-only windows attribute means, how it
>>>> is interpreted by Linux and in my opinion it is wrongly used in Linux at
>>>> all.
>>>>
>>>> Windows filesystems NTFS and ReFS, and also exported over SMB supports
>>>> two ways how to present some file or directory as read-only. First
>>>> option is by setting ACL permissions (for particular or all users) to
>>>> GENERIC_READ-only. Second option is by setting the read-only attribute.
>>>> Second option is available also for (ex)FAT filesystems (first option via
>>>> ACL is not possible on (ex)FAT as it does not have ACLs).
>>>>
>>>> First option (ACL) is basically same as clearing all "w" bits in mode
>>>> and ACL (if present) on Linux. It enforces security permission behavior.
>>>> Note that if the parent directory grants for user delete child
>>>> permission then the file can be deleted. This behavior is same for Linux
>>>> and Windows (on Windows there is separate ACL for delete child, on Linux
>>>> it is part of directory's write permission).
>>>>
>>>> Second option (Windows read-only attribute) means that the file/dir
>>>> cannot be opened in write mode, its metadata attribute cannot be changed
>>>> and the file/dir cannot be deleted at all. But anybody who has
>>>> WRITE_ATTRIBUTES ACL permission can clear this attribute and do whatever
>>>> wants.
>>>
>>> I guess someone with more experience how to fuse together Windows & Linux
>>> permission semantics should chime in here but here are my thoughts.
>>>
>>>> Linux filesystems has similar thing to Windows read-only attribute
>>>> (FILE_ATTRIBUTE_READONLY). It is "immutable" bit (FS_IMMUTABLE_FL),
>>>> which can be set by the "chattr" tool. Seems that the only difference
>>>> between Windows read-only and Linux immutable is that on Linux only
>>>> process with CAP_LINUX_IMMUTABLE can set or clear this bit. On Windows
>>>> it can be anybody who has write ACL.
>>>>
>>>> Now I'm thinking, how should be Windows read-only bit interpreted by
>>>> Linux filesystems drivers (FAT, exFAT, NTFS, SMB)? I see few options:
>>>>
>>>> 0) Simply ignored. Disadvantage is that over network fs, user would not
>>>>      be able to do modify or delete such file, even as root.
>>>>
>>>> 1) Smartly ignored. Meaning that for local fs, it is ignored and for
>>>>      network fs it has to be cleared before any write/modify/delete
>>>>      operation.
>>>>
>>>> 2) Translated to Linux mode/ACL. So the user has some ability to see it
>>>>      or change it via chmod. Disadvantage is that it mix ACL/mode.
>>>
>>> So this option looks sensible to me. We clear all write permissions in
>>> file's mode / ACL. For reading that is fully compatible, for mode
>>> modifications it gets a bit messy (probably I'd suggest to just clear
>>> FILE_ATTRIBUTE_READONLY on modification) but kind of close.
>>
>> IMO Linux should store the Windows-specific attribute information but
>> otherwise ignore it. Modifying ACLs based seems like a road to despair.
>> Plus there's no ACL representation for OFFLINE and some of the other
>> items that we'd like to be able to support.
>>
>>
>> If I were king-for-a-day (tm) I would create a system xattr namespace
>> just for these items, and provide a VFS/statx API for consumers like
>> Samba, ksmbd, and knfsd to set and get these items. Each local
>> filesystem can then implement storage with either the xattr or (eg,
>> ntfs) can store them directly.
> 
> Introducing a new xattr namespace for this wouldn't be a problem imho.
> Why would this need a new statx() extension though? Wouldn't the regular
> xattr apis to set and get xattrs be enough?

My thought was to have a consistent API to access these attributes, and
let the filesystem implementers decide how they want to store them. The
Linux implementation of ntfs, for example, probably wants to store these
on disk in a way that is compatible with the Windows implementation of
NTFS.

A common API would mean that consumers (like NFSD) wouldn't have to know
those details.


-- 
Chuck Lever

