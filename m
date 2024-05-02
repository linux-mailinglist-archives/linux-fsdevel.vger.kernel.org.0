Return-Path: <linux-fsdevel+bounces-18491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 817658B96EF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 10:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2F74280CA1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 08:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C254D5BD;
	Thu,  2 May 2024 08:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QBC8tP31";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Uh70MEW7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4275B25634;
	Thu,  2 May 2024 08:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714640178; cv=fail; b=qWh5aGeo3qCGW1NIILMUAVxG1rT7gcnT8wvKdgGBk/lMlgpsVMGJY5pF+4RsUBT1/LdrOh4I/MpyCh9ZgO5judcHDWYAv+iLJir8P6MAy93pF7C2A/OPpnIjA+wDtOGVtPCxTlRGTF8+J/8zNqI6OVK0sO0EcgTLE7eJKdDzJ3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714640178; c=relaxed/simple;
	bh=6qHIaRiS8MyiLb06iSzykFHRQ9w79ItQ5sWzhc2stQY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Hjzkp9GxOt8XKjLADwt6yI25RB6uoJd+SJmp484m7EMdW5bzQkawTCUvtYS2HxghnKEG0FhmpkiWph1bYDWDHvBhtXvkeRb5VEZlQy8UUi4I4ElwtM35AzKOa2WQeRoay/cPJwO0TC0Il4IUQO7N34kDepCqsdVDSAAwGkVK+4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QBC8tP31; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Uh70MEW7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44284i7T029899;
	Thu, 2 May 2024 08:55:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=HmXmyTJpQxaWqOgRB+LHYLZKiNs00GoOij+RYezuync=;
 b=QBC8tP31MU5ySBzwOs6rymzlGz7CMbzFPgLzx6gXQUzmZmV7PbXGDsAoTUnf01ZtdZNB
 XHPCoOih/fc7VC6pQvbgL4KRZZekE/g7dCyGGzVJQiRX7ONfrC8R6VqETP/2nhrI1Wmc
 nQHHgRcWPt388Ix5gzA1mMqzUuDllzXqkCCvjzMrYw92+wqEzzEwltv7qRmPfzM2wCTn
 Ze0kyWcUngATcMC6hJVos1EDR5s8td2g5bAjXceKeiDXbLri76hpEafrvLg6jTjXWU4u
 xBdpeO+3K5Sm2sJCeZRFQE86aBYlQKZBMDj4n85Uf+gbh8SLIIaJZuC9IGHR1SWqLRkh Jg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrs8cw371-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 May 2024 08:55:52 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4428oDdh019897;
	Thu, 2 May 2024 08:55:52 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqta46hd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 May 2024 08:55:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lxXHa/MrxSzewv5Yy6HMrWmg9jSsuGSzEz9HIcFlytJ7fJu0O52gObfahUokXK+CjQq4XTjcjdZk63fKQUAuLqN9piEXrEgNP4XPb71/1VUMt2brekeADUvuhFmE83sAp86axCDeSSpRM0V7WBnBiwKkT27G/mKxwJzujw4uUqFcKGGH+9CMJ5y+fEmZNNVs3V4DJ69lV0IM1XKeE5WyodYAMpjUbR4EZ+J789c8spIdA0fsmna7NIqtXhoyRFqQYgYnNuoAxIPrMuvKRK3sXUJ+exSThwrINxCnFc8cXK5sizGkm6vMgnN5g5cBJCNEqPtX+k4hzPle55DAGGBqWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HmXmyTJpQxaWqOgRB+LHYLZKiNs00GoOij+RYezuync=;
 b=HgOi1tI1YMhC/xVpyihCsO1BXsGXB5B+VcMsAvbqCRcMdchAviyCrwceUhxVoK2YmF3ramTRVEBkmQJjyXiGMuuO+VB+QGAXPp08aqI4kFWVSaOEl2/BvPnsGJhGyvEqkKE3r/cYxRP6UbaXV4WvSLckv0BoU0p+uLQGXyNokDHnVdJ1noQTEtQxIKxsmE2fx+n0LSDcD+c08byXR9Hp53PE7P3IkTFYqP47smlBOPUvmEqCwrLQL7R1Ni0+ncFMP+8LcUuHGdhi12MNoYSbDY5JsZqqpoX8zT4vXBDCrD31+Wx7bE3MKOPWoSx3ciMXh25UEMdj8rJ/wRmqxKlM2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HmXmyTJpQxaWqOgRB+LHYLZKiNs00GoOij+RYezuync=;
 b=Uh70MEW7CfLbfJmprP7kq08xx0WeuicbG8UXX5dehT+uCL/HtVpEaIjW4u0/Q84BSBZO62hqMMyWVU4Klwhjs59l7WM16SYCzMsGiuap9htY4TDOM396iW+qaG/5ogVgl5MzoS+PQolbM+TOhwwYhqO0L8jHO7iZYEQzTJsGNyU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB5579.namprd10.prod.outlook.com (2603:10b6:510:f2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.25; Thu, 2 May
 2024 08:55:49 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 08:55:49 +0000
Message-ID: <d0f55fe1-0868-4797-8fa5-1f60f9a0058c@oracle.com>
Date: Thu, 2 May 2024 09:55:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/21] xfs: Do not free EOF blocks for forcealign
To: Dave Chinner <david@fromorbit.com>
Cc: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz, chandan.babu@oracle.com, willy@infradead.org,
        axboe@kernel.dk, martin.petersen@oracle.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, mcgrof@kernel.org, p.raghav@samsung.com,
        linux-xfs@vger.kernel.org, catherine.hoang@oracle.com
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
 <20240429174746.2132161-10-john.g.garry@oracle.com>
 <ZjF2jjtsA/C6ajtb@dread.disaster.area>
 <833f5821-a928-441f-848f-3a846111dcb7@oracle.com>
 <ZjLoJ4FeSbsb/hch@dread.disaster.area>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZjLoJ4FeSbsb/hch@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0003.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::8) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB5579:EE_
X-MS-Office365-Filtering-Correlation-Id: ffd152c4-cada-4878-a48e-08dc6a85a9ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bEgxOUMzbFcwTWI0REtrM3lmLzJXSTdYVnFyZFh4aFF4RFZZRlphYVI4eVYr?=
 =?utf-8?B?NEVWNENPVVpEUkhsZVV0bDdnQWI5RkVsWi9iSmFaVERXM2RRVDdLRHlONDhr?=
 =?utf-8?B?UjRST3c5T0N3a2dOcWVUWmtrQUxvb2d4UHpCd0xDd2M3emt5U05qdEM2OHFJ?=
 =?utf-8?B?TmFVeU82cTRoSUJGWWs4azB3N0N2TldPdmwwZW9QaXdQME84N29tKzAwVjJB?=
 =?utf-8?B?OUJiYk5CbDNBMEVQaG5Yd3VGZ0xrSkx5ajIyN29uUzFGR2NwN1FES2dvQ1Jj?=
 =?utf-8?B?UHhpdkwxb2c0dE1JVEdKVlBFZ1lyOXlSR3Z1MTlEMTJjTXBCamFDVSt4OHlL?=
 =?utf-8?B?N2ZJWTZ5NzhkUm5QeXJHdEtlMmNmdEFxTHQwdXp0bjRsQ3p4dVlLc1NQTnVQ?=
 =?utf-8?B?cDZJUlZuQ1dmT05RTHhSQytvV3lVaVJNOHhiS3QvZXByTTZqQ1owanl4ZFBv?=
 =?utf-8?B?RnFrdXE0SWwxanNGOVhZUTJHYVpwVWUvWnlsTzdUTkZhNnRSanVRNmJmYVBv?=
 =?utf-8?B?aktQeW15V0ExWTIwNERBK1ZOMXowUDZ5UUlIOG1TaFozVk5UUHVLaXpTdURx?=
 =?utf-8?B?Y2JWeTlnYVgxM1lDT2lxUEF1bGJlVVRDSHh5bFZDQys4bmFGYXhJVXpYVFVB?=
 =?utf-8?B?VjlvNER4RGRDSWJXSVA2blRkYmg4Y0JwclZ5REdkcGdiS0pGM3BNU1dTTXFm?=
 =?utf-8?B?S1A1UDlnODI3enJqaGpUTHlUSEpaMGMxVW80SURkQlZVYzVpTlJqTkRPKzFn?=
 =?utf-8?B?dUtGbzFtanIzY2Z6Q2Y1RzRpdnZXQ29vcEVIcVZrTEF5YVBYN1Z3T2diS0lo?=
 =?utf-8?B?eG44Y3JGcWthdE1jSGdlNEhmTGc4NlhnVE5MMFlYOS9lR0N5TkNwditwdHFi?=
 =?utf-8?B?MDYyZzFhUXhsdmtwVWZXR2F1RW0wTHJwR3lPTFBvOWgrWE12ZmRVZzZkVXRv?=
 =?utf-8?B?S3YvSk53Z2FsRmtTNUxpK21rR3Y5MWc3S2hDcXlHWXRYU2NneHZkRnFreHRy?=
 =?utf-8?B?TXhnK3FwdENZQWoxby8rLy8vMnVqZENINGhFZFN5T2hkcitQQXpOQ1oxNmR1?=
 =?utf-8?B?clFPbHFvOUZzZVFsTmVnYTlTd2ZvNEJjbHd6WEdVKys1NW1JREpSNTlXcmJC?=
 =?utf-8?B?U29WVFNQZ1hzWUpJMjVuWmVENTF6OERYT3kzakhlUjJsRkhsM003S0YzcGhE?=
 =?utf-8?B?Zkh2SW9qK0NYODlUN2ZIZ3hWMjNpTm5pVnhITGgyalZDajdJSTdUYmRGNmQ0?=
 =?utf-8?B?YllIeUcwR29pMExLRVlnb2FYSWhOMjA4a2JpckxDMEVPOW5wZ3JyTEErOUJ5?=
 =?utf-8?B?a3FPL0E5T0lsbVBpb3B3V2JlSlphQUxITUhBVVhLanZURUpHZ0VWaERsaEVY?=
 =?utf-8?B?Z2Z2NzdHc2xqOS9UeTE3OEVBYmFyK0ZJcVdZZUtzbHJueitMZFl4eEVMd1pj?=
 =?utf-8?B?SEhhcUswWHBRVGFabmNDa0ZzOXI2MjNBNGNPV2NsK29idmtOVUI5SGJsWnNP?=
 =?utf-8?B?RVhnVVoxaDNVMjVEa0tBajZtazVkQWh3VVB3d1Y1OGpKY2tyK3lCQjI3ckFq?=
 =?utf-8?B?VmZhT1YzczVYYjJlN3VHZVFJRUZ4VU9CMUZYTEpUVVp6YzZxWHFvdDE0ckFU?=
 =?utf-8?B?d2p0YmEwa0t6Yjd3QjZhdytlN2dpWnRPNkZBY2h1T3V0bnFPbVhja1NFK09u?=
 =?utf-8?B?V0UxcEFoaURpQXNiMURPK2M3L0xLcXo2K01DOFlzbFZTMGNUWS91c0V3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VVNORDdnR1VPeWZGVTR0QzgxMGhRYzhaWjRGamNnQTFlZ2VpMUhxUHdoNlk1?=
 =?utf-8?B?MkJIdlg3OXZNZlFNeVM4eGxsK1VQelV1WFMweHViL1hzcHZ4MnJ4bE9WcUIw?=
 =?utf-8?B?d1JkRHlGWFlYaDRaZFNwRnRGQ3ptSWJVUFJDNWN5VDdsY2xIVzc4RTFNTTZv?=
 =?utf-8?B?cU1ocUxFOFZuNnlMOVN1S2hBRmdsb3FDKzRxVWhjWURQNTdHSUQ5YUJ0S1ZB?=
 =?utf-8?B?WGN3MXFzTXRkQzc0UGlwb0ZoazFnZmJDVXlRM1hIdHhwTVlrbFlOYldjd01E?=
 =?utf-8?B?bm1yR0cwYkpyT0M0amJKWENVd0pSVTIxMnpLOEpKTFJDNllsbjhQYVE3bUZY?=
 =?utf-8?B?ZlpURDJOKy8vb1Evd1dVcWNrblpqRjdsT0N1bWVoN2Q5aHVnK216RWZQWFN2?=
 =?utf-8?B?NkF1QThhbEdjL2R1aURuUTBySUVUS3JsRk8veGk4TWJlUEV5VDJqaCs2Njc4?=
 =?utf-8?B?ZERyMDI5RDFGb2RsV0VRUTlTNjh5bkVvRmtyY21kZmJ1eEpINGl2ZDd4eGtu?=
 =?utf-8?B?eHd2SUk3ZDhVSlk1SlBMRFhpK0I3eGRtRVVPU3hDRW40R2h2d1lQNnl1ZW0y?=
 =?utf-8?B?aS9PamlkakQzYXJoU1d6djk4NzRkVVN2bGU1My9DZGpUTTE4aGM0NDY3YWli?=
 =?utf-8?B?ZVlWUU1XTm5iVTFJRWNTcGozRTd0bmxjNllwSGNZSDZ2c3dBOXd3Rk9HRWJT?=
 =?utf-8?B?RjlXclRVbnpBQnhsN2VBeXE1RVF1Sm5jMnRBZFZNNkE5RVBtZnZZUWlMcGNa?=
 =?utf-8?B?OEQvZXcyQ1hHb0FvcWppQVplbVdibFVMaXl1WWJFZ09SRXdFemFVa2Q0TUZ2?=
 =?utf-8?B?NHVyNTVMMjhYSUJtQjQ2cW92NHpER0cvWmM0YU5JY0l2ODhleG1XZkVOcW1H?=
 =?utf-8?B?QWZmTklmbUhGR2lpYi9XQXJvcXBnVkZLYUM5dDlxemVGY2hlQlJLOGtTdGpB?=
 =?utf-8?B?TmkyNW1JWkxXZ2VoTGhXZnZSQnhtNTQwUWgwSlBqMWl6UHR0bkErV0Z3ZnVQ?=
 =?utf-8?B?SXExUndqYldad0tjb2RwZi92NDI4ZVc1YksvZld1aXVWTUdHMThGdVprZEgy?=
 =?utf-8?B?NllWMHhzem1Md05nRnQ3SE1DY0tHdjRjdXdYelhZWnhOZDV5NEJRUHhpK3Jx?=
 =?utf-8?B?MmJIYWZkeEJ4K2tsREFQVkxjSjQ5bUJLdXZHMTBHUlJEV1p2eUwyU1F5d1FV?=
 =?utf-8?B?dG5YNEE3ZmMweFd3L0cyQXpkQWF0YkEvZTA4MEU4OHFrdmgyQnZnbm5FR0ZH?=
 =?utf-8?B?MjJGRm13c3JlaWFEbnhPTjNuK2pkeWg3bUMvMEFJbWUxUkIxMWluZzM2MzZ2?=
 =?utf-8?B?WGdOUC9mZnU2dGtIUU1IcExuVXF0em5hSndmQmJmYnZQYVJBQjJpaHlyand5?=
 =?utf-8?B?KzhQeGJCYmhCMkVEUkUxNnJkVUtLdTZaSWpwVWpmSm9paGM5MGlOSDVKTENu?=
 =?utf-8?B?bU9mMXpBVmdoYmtOWlExUkVwK1ZjNkwvSkV0alRHWnBRR1pJTnAzdS9DTUlo?=
 =?utf-8?B?dEIrVzlKZlJFT3hVN0w2eHROb01PNG92RFR5TVN6VUpHM0FBOXpvbGI0TC9h?=
 =?utf-8?B?SlRPT3VkTW0rSnlHbHZrVHBRRk1FRGZ1S2NrcE5RV29Kdi83U3dmZjYxWnlM?=
 =?utf-8?B?UzMvdnlBd0YyeHFnNXM5Y2NrSkdqU0d1VnZTUHYzZnRaUXZGdUVUY0xMdThH?=
 =?utf-8?B?WXhLRE13ZmxuYmc4UWg3UU1pTXQ5enhqenZGbmZOVnJMbytuK2xZR0swanIr?=
 =?utf-8?B?WC9YaFlZYkxlbnZWd2Y2LzRjTERQTDZ2c3g1VXlnOFpNYlNwbDVGMko0bFVL?=
 =?utf-8?B?VjFYTk93VjZXTFlabWhabWRZWjN0U2k1WS9QYS9zM3lPemkxWHF1R2VremlZ?=
 =?utf-8?B?VkxRdHNwQ0pLdmpqMUljQzljVWVBUHg0YmNURFhnNGNKWkYrOC91NmdwWk10?=
 =?utf-8?B?dU5VazdNUlMvQi8wemp4STJpSWR6N0lwWDdoNGZOZkxKVTAvQnVmV0VHcmdW?=
 =?utf-8?B?ZW1vY2x2Y0huWGE5UEcvNDRqOEdySVRzOTQzNm5tMDhtZG5vbnRHaDNBUWhJ?=
 =?utf-8?B?TVE3dzhEQkFsVGE4OVlTUGxUWklJOTIwbDBxT2JwaU5Bam9OUnV0MVc1eHcv?=
 =?utf-8?B?NjRxWDgyQWNQRlFmcXVub1pTVzlFakszd1BpbkNIQWFrMDVxdm9hWkxuNWFn?=
 =?utf-8?B?NEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	mEhNcOUnjqm+6jKfN0+/k/bMi2+urUE36dcDR2Ox1v4xPObcOiU8VF1TeW7+w1YtWxvXuPkXtsOZG759ztbPNW+K6oOZ52QPDYX5hxALExWZkLJXIIEXhpQ/U/NCVdBgrnBJRuy0hKDwX6CxFSi6Ge1eYctS3uTnyE15Jo16jtSvosFPE0SpPWrAH0LzhmXKwGj0DezerwL+qea4boWXfNpxjYevqJnWIXPLKuwlO4kBE0ZYrFse9aRFxUugurBs+ZEGxED+vT1Yqdr6iZZVEcw3mzDYv8JxasSHfH7BSbwrJWTwgA1Ot7xJDkO4P4V8zJJ7Oap0/i+8bP2dgYSB939QrfWE1U5Hc29XkPzTfxCYsrYG7zAQWXnQ51VTL87tCtisqEEFmO+ol4H113eDghMi7XKvkiGLNapG9yZP93za32D/Oj/nSsd11C6NzpzorRWl/opF7/lLqziLp4gvKp2aO/LfZ2Pd3WrIRelj0qfMIeaS1QK9bLNwetafB5pwrspZkB8F/n38gOLYbkvndCvsCJKzVGNZjrJ1xBLYrXw0ygy2vFrCS5ASDq5EOB7sJc3YGvq8XFa00rmBuUlsjgSncd5NLEKRY8aEfukUO08=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffd152c4-cada-4878-a48e-08dc6a85a9ce
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 08:55:49.4525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mnNr0AvKEWFE2EISwdZpPA+H05gVzlx1KpeA8yjEUwkrHlr7o36dab0677BWGpsgRm0jooTBTgLSetbI6kAPQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5579
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-05-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405020053
X-Proofpoint-GUID: YvBDcHkov1WjIxCqQSin9NBxMJh6EFNt
X-Proofpoint-ORIG-GUID: YvBDcHkov1WjIxCqQSin9NBxMJh6EFNt

On 02/05/2024 02:11, Dave Chinner wrote:
>>> static inline bool
>>> xfs_inode_has_forcealign(struct xfs_inode *ip)
>>> {
>>> 	if (!(ip->di_flags & XFS_DIFLAG_EXTSIZE))
>>> 		return false;
>>> 	if (ip->i_extsize <= 1)
>>> 		return false;
>>>
>>> 	if (xfs_is_cow_inode(ip))
>>> 		return false;
>> Could we just include this in the forcealign validate checks? Currently we
>> just check CoW extsize is zero there.
> Checking COW extsize is zero doesn't tell us anything useful about
> whether the inode might have shared extents, or that the filesystem
> has had the sysfs "always cow" debug knob turned on. That changes
> filesystem behaviour at mount time and has nothing to do with the
> on-disk format constraints.
> 
> And now that I think about it, checking for COW extsize is
> completely the wrong thing to do because it doesn't get used until
> an extent is shared and a COW trigger is hit. So the presence of COW
> extsize has zero impact on whether we can use forced alignment or
> not.

ok

> 
> IOWs, we have to check for shared extents or always cow here,
> because even a file with correctly set up forced alignment needs to
> have forced alignment disabled when always_cow is enabled. Every
> write is going to use the COW path and AFAICT we don't support
> forced alignment through that path yet.

ok

> 
>>> 	if (ip->di_flags & XFS_DIFLAG_REALTIME)
>>> 		return false;
>> We check this in xfs_inode_validate_forcealign()
> That's kinda my point - we have a random smattering of different
> checks at different layers and in different contexts. i.e.  There's
> no one function that performs -all- the "can we do forced alignment"
> checks that allow forced alignment to be used. This simply adds all
> those checks in the one place and ensures that even if other code
> gets checks wrong, we won't use forcealign inappropriately.

Fine, I can do that if you think it is the best strategy.

Thanks,
John

