Return-Path: <linux-fsdevel+bounces-39325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAA7A12B1A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 19:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 702851677D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 18:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790161D6DBC;
	Wed, 15 Jan 2025 18:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="koQe+zM4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LGiN2/pD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6AE1D6DA8;
	Wed, 15 Jan 2025 18:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736966612; cv=fail; b=Lj75GgDPu9P4Czck6jZJM12j+aQwwygVpo0c1T5j0mbTsp1jw5zkBjN2q0ISG2hTNWW7uREbqsyx+ly4BlefJEklw3QyjrKpi4/GMSBJ3N8kbSuJOEpjmAy/R8jz9jozGnfct3n7sWUY2XlMsj5IPXsYHZi4+Sla42llFlk42zY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736966612; c=relaxed/simple;
	bh=uX0vF5nOE5CLIQQhGc8a1TbEaXmdBvd3yKx2Df5Nycg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HXOwoHDzW/BzvmOQaFo1/ourUO5PwM0eASi1L5+ZeseORUumbZDBqNgpro5o7WU8Gc513hm7Cv0N4j6CQRnvPxmLlLvx45ZREyRm1Vrh1YNDNcCSB+GPreUBz61Tv9h2yJvvTYXD/UtYEGEgQoK/CkahaEYnfRjqSayW+yaJjUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=koQe+zM4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LGiN2/pD; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FHtkvr001706;
	Wed, 15 Jan 2025 18:43:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=qLszOsYTe3I92stmtvW99h3HJ4ya+H8xepCGOn76JEQ=; b=
	koQe+zM4i2N/Cs2M6ka5MwEivQfPTRmdBDNJY7VFIdp26CA/WIprm42z+zZ16PuD
	JOXW1ldKrnj+b4RVvYVxxd/PI74tkeRp3mut0izy/qdMS8gdq6fotaAfBKK/cOXB
	j0fXqAfjBwO9DT8NwW4yaOjwXyh0yWfu3vW+uENG3kvZMSw8ZMkwaoQyXZkQp3FT
	Nw07SC21uGnBvZO+UK7wjuCtd51VblU/Ar2D/axsSVWYzshDqY5NY0B3Z/xaHOqH
	LHMNv1BY+f9PLw3Rh2A1VkjmoA/nLlnaKnhhD5Q8ap6JJGkkNRJgG163IDboxraM
	gIAAokR2/yyt8VIrZcKPSA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443f7y8p3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jan 2025 18:43:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50FIUe4J032054;
	Wed, 15 Jan 2025 18:43:19 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 443f39u51a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jan 2025 18:43:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d2EJCpXglYqqG1qrTW5RPLmc0r4srmGyOsYuRmrmIPM5y85+4dH3kGsfj8rXZ/iz7HEMpLRVu9MDayRO6Vcn4t+oGi/ludd6+XNDArTzTQNZNDzGaWs/bsuptz5XJvFcpSCfWfMp+IIv89Wu/W7oPn/ce5ssA/rjV3JOYbmRmQlHXZm2wwoLzQ9W4Mblo9RyqGQ952276rL6qH9vE0yjZWjFAHWwNYKf5APn0c/MMWaubx8hWwIeoI0n8wDIdpvdJQbq9i8VWQMHp8tk4TMotbyZ1iyK2UdG2eTPEbBmoh0+MZLTzaduDG/Ybmi8xg+rpdpFAr/jm+3F+dwOZD5trQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qLszOsYTe3I92stmtvW99h3HJ4ya+H8xepCGOn76JEQ=;
 b=pmL/roebr29oy3fR5qt1OiHSZ9nzYMjMWIE4xnSw4Q/Ie9wy4ke1K4lb6DUFXlVBc9EfGROVJWetC2GkxF9ay1MBXCQMN51oLrzCl4vD63uQkivBpzRoiQgM7t5fFrEcerJW8ewJ8tgvVMIC/LPNwMqNSU9rCYo5E4fU6UNuBVO/kHhVuZbj81ABFEEwobl28kU2mfl6vyQnm05T9CLB7hzgB7VZ6NbYYwVHgOHfAskI4JA3iDomEE2eQUU49ioETpPkPa4WSlRxVc8HeHwGb6cJjfAw67x7Tu0d58O5w/fctYAZLk+8zh186q3RQvR7NDsYMW4gePTIVilI79OKyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLszOsYTe3I92stmtvW99h3HJ4ya+H8xepCGOn76JEQ=;
 b=LGiN2/pD88+bTD61fXlVfPsRdo/fo6nILMCELC+E2eSzEiNjhwjPV7STaumU3Kh2ROfvMPpumyq4gBSjMh6bCRJ3yL4fOF1QVDAabhoGXuLyijXNGzzHs9LEcZMrYqg59V/LPQEowzov6RI6ef9U3X+eWEB1VT5G52bX3J86BjI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH8PR10MB6503.namprd10.prod.outlook.com (2603:10b6:510:229::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Wed, 15 Jan
 2025 18:43:16 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8356.010; Wed, 15 Jan 2025
 18:43:15 +0000
Message-ID: <fa80c96b-91e6-408d-8ada-751a992d677b@oracle.com>
Date: Wed, 15 Jan 2025 13:43:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Implementing the NFS v4.2 WRITE_SAME
 operation: VFS or NFS ioctl() ?
To: Matthew Wilcox <willy@infradead.org>
Cc: Anna Schumaker <anna.schumaker@oracle.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <f9ade3f0-6bfc-45da-a796-c22ceaeb4722@oracle.com>
 <Z4fO2_WZEO39jupG@casper.infradead.org>
 <4c59eb2d-132e-40d9-a2cc-1da65b661fd7@oracle.com>
 <Z4fgENA-045TFLOh@casper.infradead.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <Z4fgENA-045TFLOh@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:610:52::15) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH8PR10MB6503:EE_
X-MS-Office365-Filtering-Correlation-Id: 6941e79d-8592-4bc8-dd7e-08dd359478e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RG1oakhHM1pYVmFUU1VFR1Y1WG5zdk1xMHhjd3htaEcwQTZWSFJjcDE2VGRa?=
 =?utf-8?B?Z1FWcmwva2lpMW9uSG9yM1RHdWlXWVBmMFlPaTRXdjV4Wm5HTXNqazQ5SEJR?=
 =?utf-8?B?OSt6bXhHaXFkbGc0b3hQMmFhNFpLaUlrUHI3a05vakxiNTJQYkY3WlhnanlJ?=
 =?utf-8?B?bm9DNGU2UFExSlRIM1BvWGlJVUZSdTVOcjZDN2pNRVZVYnN3OGFmclZMV05I?=
 =?utf-8?B?SFkwS2VvdlZIWmpHV2xaQitBUUlWc3BjbE91WU1HRHIybmtEQlZEc1cyZ0Ew?=
 =?utf-8?B?WFlETy8zeWVmVzZucG56ajZuZEFSU08rVzcvSmtHTk1EelhxOEFBeXFVUkRF?=
 =?utf-8?B?TWY3TVJ6NGZwWkY3WktwaDNIYUlmRGMzZ3gyTHkycXpibTJKSXc2aExTWmYr?=
 =?utf-8?B?RjNQOWRZbG5JT3FaU3BUU0N5S0hGVzgxNTd1dlZjSTVkcXVQQkxvMUJvRElT?=
 =?utf-8?B?OTFiUGZmaThiNmdZTjFlZmQ0TXR0VEt4VG44eHh3dWI4MUx6Y0RXZ0tPN3BM?=
 =?utf-8?B?UHNnd1p3MSswRVVXTEVIVDg0ZUU2WTRDOEJ0MXlZbkt6NkNIek0wNWlWaVln?=
 =?utf-8?B?dGZJMUFTWXJTYnY2L2RDNGlYbzNsYTV2N2pBcS9kTjF6bS9IK09EaFlhV3h6?=
 =?utf-8?B?QzQzRkxxUVNTNEcwOEh1S3NwUGE2VnBrYmc3elhETVFnWCtsaFlpa1Q2MytC?=
 =?utf-8?B?VVdKVVZnSWtxcTh2UmNGUUh1ayttSnlGNlVaUjduY2Q0RTVhOFBSMmJTUDNy?=
 =?utf-8?B?dVRuZUxnUnNhb211WXZTTjVWNnVUQUR5Rm1SUTNCa0tBajA5K3ZBNjFvaDBC?=
 =?utf-8?B?WEhXazdNQkd0ZnFNRmc0WVlJMHJ3dXg1aXlUMXJab09rVGdSeklSZHdQNjRy?=
 =?utf-8?B?YVZDSm9IVCtrV2dkSEV5SC9mZXd5TDIzSk1KemZibG5hUVZlK0RaOXg0bnpn?=
 =?utf-8?B?YXRGRXAzRFJsWkxaYTkxTXVQSDRUQ3BNdWk5TmpuTjBnM3JHanpzNWlFWTJS?=
 =?utf-8?B?T1FjSVZZRTJVbDZpenpNUEphN1dyT2RIdE8rT0NsR0YrclhkV1Rzb3ZpSjJL?=
 =?utf-8?B?aGVWMisydGZ3aXI0VTlIZTZ4NVAxRnNEd1ArUyt2UU9mcU9scjNvaWg4Qkww?=
 =?utf-8?B?Nlp3MnVLalllNno0RmpRMFVhKzRvOFAybUJZMG9SNXIzME1TRDNqOSt2WHJa?=
 =?utf-8?B?SVM3bjNmWlI0R1BXZStwOXJ6MDhPY0s4ZU9zYnlUWXhHMnJlK0RzS3E2Nlc1?=
 =?utf-8?B?dHVIaGJpVTY0M0t1aklzbWRIU01VTXQ0eGU2QWRuMlY2SUVLRGp1R1BVdVhU?=
 =?utf-8?B?UTVDRVNUbWFtT0QyOHBtRFJ3SHBQT0pPV1Z2NVdnRzZjTXgzLzU3Tml6S0gw?=
 =?utf-8?B?U3ZIRUZYd2tRdFpiL284RTZnd1NlaFc5bnhMRGRWbnZXeEtDRnRhejZ4Q3NR?=
 =?utf-8?B?YVRzbWlMeXJmbGpZTW4wOTdEUllnb2NNVnVUTlRKRnpJT201bEN6bGZRUkw2?=
 =?utf-8?B?T2ZBUVFTdFpxOGhEUmt1WnZoSDAzeXZVVUZ1c0pwTnRIWlB0d3c4aCtXV1J4?=
 =?utf-8?B?UnZGOEJVbVNvMWN1emMzRG9nZ1BYSFdxRU15SXUrVXp6SHhRZU9Nc09WV0pr?=
 =?utf-8?B?R2dwZDk1WDhjdU11aUZEbDZscGpQTDlycTBrbzhCT1NHVUwyOFppNVBwNWFs?=
 =?utf-8?B?ZFYyejlQbFdmMHpuQ3JyMkR2N3Y4U3JBM0YzNHdqUDVObitMMUJiN2F0ZStD?=
 =?utf-8?B?SVB4SHRtN3g3M3pPM3BJUVhqcG1JTXh4UVZCTDlWU3RjMFhOTlMyN2RoSThR?=
 =?utf-8?B?ZXNaUWI0WjFaTFBCNXBkQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDRUN1A3MytJbEMvbElMVStYRnBkSzR2Q05pelphdmxtSDlLNDMzNzByNG5K?=
 =?utf-8?B?N3pjaVJSQWtPbXJ6eklIYm5jRmJ0eFc4Z2piVmlBMmN0RitzOEFLcXpkalJV?=
 =?utf-8?B?dVpCNEkrRERtb2dlVmVrTGgrd1RHSnM2STVRbUUxdCt0ak01ZHRWRmRVdjFK?=
 =?utf-8?B?VHdTcXlnb0JkQmY4R2I5WU5EN0ZqS01RYWY5VU9DTk00S2ozV0dkRkU3ZjNF?=
 =?utf-8?B?VTF6VFFuUWF3MDVZNTZhb1draTc1U0dTVnVXejFrWm1CaXN1QkN3TTAycnlL?=
 =?utf-8?B?SzhKdnZZWXhaZ2N3d0IzRFRqUTNTMEF3L2htRkFMZ1I1dEhBelRjRnVzR2gy?=
 =?utf-8?B?Yy9GemRETVpKWW9JYTdvSVhsVnNOUFpOMTlyL3NySHV3Y2ZCelhsTzIveVI3?=
 =?utf-8?B?TDN3UGJ5eWxMekpNbUkyd0FvbFFlY21ZVTdCUENYcTJBOGp2c3ZMZ3Z2ZSta?=
 =?utf-8?B?WWNIUTVmQkp5WE42a0tFYTcxRE1ubmp6ZjJaZ0hEMDVuRmJLWjBqY1BMQ0lG?=
 =?utf-8?B?NDljRlI4cGQxTkV3MEFETUowbXljb3ZuMUZWT3VrZ1BQVXp4VUJTNXNPZE1h?=
 =?utf-8?B?c1ZQb0hvUGFnd2RqbndydEE0cEx0RmtYdmxac1l0STh6WlIzNUxKRzJZdHdm?=
 =?utf-8?B?SnRqRE5jZVVDMG1VZTVKMnExYUgwcEFmNEdjZm9iRFRzUHNCcE1RQnk3b1pD?=
 =?utf-8?B?cEVVWTV5K05SZWJtVWJiZytVcVNHb0QyTXkra0daVHJ5VlVoL2ZLUmNENEVM?=
 =?utf-8?B?YXM1ZFI5dHFhV0FSUFQvK1Vha01zRWh0S2VBMGJDTGYvbnh5cnhZVHRKeHFP?=
 =?utf-8?B?c3dEYTUwWTVjSHJEakpJTW5xOW9rdmVVa0hBSTl0bUZlcmEwTVduZHhWWjYz?=
 =?utf-8?B?cUdXRDA3a3U1c1kxRUp4dUxMdTZUb2Z6NFVTaThOZUw0Wkp4VzByUU92M3R0?=
 =?utf-8?B?NTE1VFJKUFFhaEJ0T0lvV1ZwaDIrL2JBRzErL0VGenkzM1RZSjJoc0x2cC9l?=
 =?utf-8?B?dFJPK1VVeEhrS2JnLy8zL2o4SnEvZkpvK25nV3d0Qnh5bGcyNUZJbGFqV21Y?=
 =?utf-8?B?b3BYRGhTdXFCNXZSa0ZjRlJvS0lBZjYxN0ppdjY5WWlzQ0xWNld4bmZ1aEdt?=
 =?utf-8?B?UWYrcXd3SWhFeFpVbDZUL0hJTklGWTY1aTlIK29lS3ozQ3hOeklzZnFsTW5t?=
 =?utf-8?B?WUtYaFRZSlZHMm1uQ0FabGtkU1JnL1dGeUpCN2EvVERQZWhjMDdkQXRmR2wr?=
 =?utf-8?B?bHRDUkg0UE5ELzdsaGY4S3ZBMkVzYXV3NEFueSttcjRsK2t2QlM0U29QcHU2?=
 =?utf-8?B?Si9QL1RId1B5Ti9iUytEVTZ6NXhXbDh6aU55OFptVHBxMjg2bnRVNlNwdnpQ?=
 =?utf-8?B?b05HT0NkMUo5V1ZJRjgvakxIczkyYkpWY2E5VmRNU1FOR2JqbndlQkFpUlM3?=
 =?utf-8?B?c0tHOW12TUlrREhMeXNFTnU1MlFZSmxDT1BzZUcwbk9SNm9VZytobVdmVHNz?=
 =?utf-8?B?WmxEQUdRU3FRMS85SHFOdFhrcTV3dndXb2UzTXpCWU9ZRlc2aXNNai8ya0VO?=
 =?utf-8?B?Q1RacUxZdlgzWXFkSmtuSE9MbFQ1VXUrWDA0WVhGUTJ6T0NlN003cTNxSzJ6?=
 =?utf-8?B?UTNQRUtOcVc5SXBiL2tmK05KZ1FLNktFUWpiQ2ZCMmttYlJqS01SV1pwMWls?=
 =?utf-8?B?aExEQ3llV2tFTlA2QVozNlFDUThSeWdJUVNrTXZuMzdBeVk1Y0RHeXBqVXlV?=
 =?utf-8?B?eFVDNlJMalhxZzFhSlBndE40c01mSUFrSldIVnpTcTZBY1VlUlVpM3J0TVhr?=
 =?utf-8?B?QzhYSXZTK2RaeVhsL054NjRaT1RXUDVTQTZWVURadzFvaHZ3dXAyT0hjeXU4?=
 =?utf-8?B?SjFrTkRqRlJIRThOYWttYmRIL2hNUmpudEZxR1l5Yi8rS2o0SEV5bUxSZkNK?=
 =?utf-8?B?ZUlIRkZjTlAyb2pNZXFzNTJjOTM0UmV5RGIwcGJpWmxKQ1UzcXFDYlBPRnRU?=
 =?utf-8?B?R0loaThvUXp1VFVTMktOWnZESmlOR1NBcU9TL0hrQzNFNUIvd2k1YnlNN0Ri?=
 =?utf-8?B?cEZORlVTNCtIeDIySHQyOTI0d2VvWkN5d2oxRlB5N3ZNWDl5aVY2Unc5Q0pE?=
 =?utf-8?B?T1hqV3pyZE9xbms1N3g4cWZ6NnIrL0tEb1hNK0grTGVUcVNZZ1d3RWF5TGFL?=
 =?utf-8?B?YWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KQQyKwdV9MA/LMfFVCmwlocntNzGJsqNA5nZJ/p7gV4/y/dhaQ7QxwUhd5qxhOf1p7Qt7KOQiepRBgQe7iUonQjdNfz1FqfZDi0DvldGlR7V6VOI1Xy52pWaX/asW2BXcvGGYztJ4j/Y5wKSyJraesWf359Vkl1Ut4k3oIlrkaE0O3FNbVFLMfDvq0VmAj1x+HK2+9XgzppuYY1N3Jm+/6JydvKGWIzhl13uD2FdYS5CDjguW3oRfLyVIDnQHaGyIEu24P2Tj5knaifMwUqpZeGIBGh5E8s7VCWbiRy14LgK2kl/oxsAqWKFTR/2/jMMz8rwW/uIUzk+wOapyiKoWiHevP9r761gIqzT+D3JqQ984PlPBKYRmZOnTo6Y3ICx8VZsAYER0IZN0ida5Biz2ETGhEUFSls7a1SWe9yHCIRf/MxMEv+cVTFeRUyXN4ZaCOS8c6ZUS3FRcl26wJ8YaHXprwbWzUKS1SDibLYpLwUoLaVRDnziAjBbVs7RmvFcJ2nZDb77FfWQTbc9Ot8wd12gAGSqCQe2Cm2UFhosPJRB+ypHt3vHU2KpgTQUJ2cGUyz73+QQCvCUW3AMCtDUHvRNQpRkWbgyEYUIwmua9r8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6941e79d-8592-4bc8-dd7e-08dd359478e5
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 18:43:15.7538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p5GqyWsD1obV/x8trzhZMehQN8YMx6JOmRpbA3VkXEBJ1h5Id558StR9BWHZddw614XkpQayoVLLVnvwzHg0pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6503
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_09,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501150136
X-Proofpoint-ORIG-GUID: hI76r403THmSrmCBhJCJDPky2Hh1lScq
X-Proofpoint-GUID: hI76r403THmSrmCBhJCJDPky2Hh1lScq

On 1/15/25 11:19 AM, Matthew Wilcox wrote:
> On Wed, Jan 15, 2025 at 10:31:51AM -0500, Chuck Lever wrote:
>> On 1/15/25 10:06 AM, Matthew Wilcox wrote:
>>> On Tue, Jan 14, 2025 at 04:38:03PM -0500, Anna Schumaker wrote:
>>>> I've seen a few requests for implementing the NFS v4.2 WRITE_SAME [1] operation over the last few months [2][3] to accelerate writing patterns of data on the server, so it's been in the back of my mind for a future project. I'll need to write some code somewhere so NFS & NFSD can handle this request. I could keep any implementation internal to NFS / NFSD, but I'd like to find out if local filesystems would find this sort of feature useful and if I should put it in the VFS instead.
>>>
>>> I think we need more information.  I read over the [2] and [3] threads
>>> and the spec.  It _seems like_ the intent in the spec is to expose the
>>> underlying SCSI WRITE SAME command over NFS, but at least one other
>>> response in this thread has been to design an all-singing, all-dancing
>>> superset that can write arbitrary sized blocks to arbitrary locations
>>> in every file on every filesystem, and I think we're going to design
>>> ourselves into an awful implementation if we do that.
>>>
>>> Can we confirm with the people who actually want to use this that all
>>> they really want is to be able to do WRITE SAME as if they were on a
>>> local disc, and then we can implement that in a matter of weeks instead
>>> of taking a trip via Uranus.
>>
>> IME it's been very difficult to get such requesters to provide the
>> detail we need to build to their requirements. Providing them with a
>> limited prototype and letting them comment is likely the fastest way to
>> converge on something useful. Press the Easy Button, then evolve.
>>
>> Trond has suggested starting with clone_file_range, providing it with a
>> pattern and then have the VFS or file system fill exponentially larger
>> segments of the file by replicating that pattern. The question is
>> whether to let consumers simply use that API as it is, or shall we
>> provide some kind of generic infrastructure over that that provides
>> segment replication?
>>
>> With my NFSD hat on, I would prefer to have the file version of "write
>> same" implemented outside of the NFS stack so that other consumers can
>> benefit from using the very same implementation. NFSD (and the NFS
>> client) should simply act as a conduit for these requests via the
>> NFSv4.2 WRITE_SAME operation.
>>
>> I kinda like Dave's ideas too. Enabling offload will be critical to
>> making this feature efficient and thus valuable.
> 
> So I have some experience with designing an API like this one which may
> prove either relevant or misleading.
> 
> We have bzero() and memset().  If you want to fill with a larger pattern
> than a single byte, POSIX does not provide.  Various people have proposed
> extensions, eg
> https://github.com/ajkaijanaho/publib/blob/master/strutil/memfill.c
> 
> But what people really want is the ability to use the x86 rep
> movsw/movsl/movsq instructions.  And so in Linux we now have
> memset16/memset32/memset64/memset_l/memset_p which will map to one
> of those hardware calls.  Sure, we could implement memfill() and then
> specialcase 2/4/8 byte implementations, but nobody actually wants to
> use that.
> 
> 
> So what API actually makes sense to provide?  I suggest an ioctl,
> implemented at the VFS layer:
> 
> struct write_same {
> 	loff_t pos;	/* Where to start writing */
> 	size_t len;	/* Length of memory pointed to by buf */
> 	char *buf;	/* Pattern to fill with */
> };
> 
> ioctl(fd, FIWRITESAME, struct write_same *arg)

This might be a controversial opinion, but a new ioctl() seems OK to me.


> 'pos' must be block size aligned.
> 'len' must be a power of two, or 0.  If 0, fill with zeroes.
> If len is shorter than the block size of the file, the kernel
> replicates the pattern in 'buf' within the single block.  If len
> is larger than block size, we're doing a multi-block WRITE_SAME.

NFS WRITE_SAME has no alignment restrictions that I'm aware of. Also, I
think it allows the pattern to comb through a file, writing, say, every
other byte, and leaving the unwritten bytes unchanged.

Win32-API has a similar facility with no alignment restrictions and the
ability to comb; in addition it does not seem to set a limit on the size
of the pattern.

So, if we start with a simple struct write_same, I would say we want to
provide some API extensibility guarantees, or simply agree that this
form of the API will exist only in prototype.

Fwiw, use cases here are typically databases that want to quickly
initialize files that will store tables. The head and tail of each
ADB are sentinels for detecting torn writes, and the middle
segment is typically zeroes or a poison pattern.


> We can implement this for block devices and any filesystem that
> cares.  The kernel will have to shoot down any page cache, just
> like for PUNCH_HOLE and similar.
> 
> 
> For a prototype, we can implement this in the NFS client, then hoist it
> to the VFS once the users have actually agreed this serves their needs.

To be clear, NFSD also needs to do handle WRITE_SAME. Would the
prototype server handle that using clone_file_range ?


-- 
Chuck Lever

