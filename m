Return-Path: <linux-fsdevel+bounces-76626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8ExjD+g0hmneKQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 19:37:28 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD4010207E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 19:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2758B306EC9A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 18:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF15942E01D;
	Fri,  6 Feb 2026 18:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a8uUjfo6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="I/bHE8Ju"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BE642E010;
	Fri,  6 Feb 2026 18:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770402540; cv=fail; b=HtF79PSlWVnatr56mjlWqQDPUST6zxDjuWhuPMPN4YP1YP6WsLAbpShkhoQepc5cfmgjXI3bd5haI+aFkmNjVF4hDvP8uOJHXGG00wxDTHFvi5Ew7ByX1Mt0zSSoAOelu/CfvWM5hTsgjxvAqxpzVLvFxDWndg4SbpKqo1A7mO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770402540; c=relaxed/simple;
	bh=2MG/RWYQS3MBJ+CifoxfNkRw94RkbEUDHzRCbrww/TI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VaoT8t8O07ckGsGIt0M8EjN0tAacovwt1fQXhQyEjMDBIgIoJfR6Ff1g/I+2rOXicX2TSgzx9KCk+9r28nzImsuFSjzrr6vmuPC8wiOpw/zRFDI3pzUuFimj0AHRD97713mnNMV6rYQ2o+yKoBdFAUP8lQqpEWXgPtBqxMO/K94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a8uUjfo6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=I/bHE8Ju; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 616EvFsi3619865;
	Fri, 6 Feb 2026 18:28:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=gCClMRWruB2tD5+NkhNyR8OjmUToG8zkimZj5redNok=; b=
	a8uUjfo6JEVQTrA2XyG86nCb0jRgjQR8Mtl5tgn1c8uRPxaG34sxdv2da2SQTDvD
	kAPyZ9TCnCeZly+ghRhaVuLJmQdUfc/fAC083h9UH6MBoTSJFZX11DTGRgbJXAUc
	arGB/Ta0412vM1xqPb0Boek/bH7WMb28dBXLOD4Nh/8xy3NR0OlP1Pyh+fVQNuRQ
	K+OIJIuhnQZM+pS+l5J4mcw/5D9XgqDi3V+hVfZJKR5muZLkX+MDsHCmboKj+zl7
	PGqSR7uJ5AQ5o1Fg+xw+3mJd2SpD816DPUPHAFMBn8Ee4kbhs7kzaFDdmF2FsdBJ
	y2OIy9uGAe7hnhm3syw5zg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c50sg9pjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Feb 2026 18:28:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 616H6Yac030627;
	Fri, 6 Feb 2026 18:28:46 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013004.outbound.protection.outlook.com [40.107.201.4])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c186ewsdp-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Feb 2026 18:28:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ahEjhm52wEarlgbaDvetAfeVgxrXc+kfaejzPm//iIqHEQpLgk1l/wL+tt0MfFZ5DgKA1yChQLlgV0fpEdBdUGOQOWuHO1v4Yli6weYfPqfzsM1waTaEnor4bIzgJouJDOUU0nj/Dfnm8Kh90MwybwYospwuEulOV7umNxs0waqoxXV58Nljx7lO9U4BTxaW3zPjBCQvRLmoMP/GumBtUSuWAHVYR5JGyk5Yehp6+pCNBp0wgufSaeuCu4QrimXxI1p5qt5lU5RlezwE2WahINnCkV/PQwLiuWhlk+MLVQAOJAgSkAv+wM22yKuSt2WQWsOXTnEnJBOyhPlhsoiYKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCClMRWruB2tD5+NkhNyR8OjmUToG8zkimZj5redNok=;
 b=nfMso5fdTv29lFCnBC7voGXOiRSugCMFvNkatQiNePgQHaXm/Ns1lcEB13ItfQxUmqAGCQwnO35+o0JQOJ6ZGRPGLM+saEH2qJ9WIQNiNmiC1mFDfVYs8Irb5Ene9niMI0xCPIFJrkxscMZUlyvC34EV5zBTyftu51/6nOKY3oatE+blevBL5+BmKUrYJHu8LvkbzKsRC+UME8txd9S4flGEMM/3UILF8OYm75N0mmklWbpgGbSGh1ab5SxcCICSb6xckW6y+MqRf3FsLBLgQ06qLWpKmrMMt0ndWn0HVBtws2mL1Yja4QGvCckJRmpAo9vj88HZo7cNXo7vvfTIGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCClMRWruB2tD5+NkhNyR8OjmUToG8zkimZj5redNok=;
 b=I/bHE8JuC7rZgrUR5F2zqWnVc5mSB1y3q67ezdX96W0ZgOP/3enYxJqpy9iFOU9/FGUbdJQZBChrZbx7exHYvy0tn3KFHGwLWNObFrVaKBVOFQD4x8B7F/Rju/sKVy2OHLv2KE7vU0dTbmVJy2YwxkkWM+KBlVx+S1dp37kUBQQ=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by PH7PR10MB5854.namprd10.prod.outlook.com (2603:10b6:510:127::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Fri, 6 Feb
 2026 18:28:42 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163%6]) with mapi id 15.20.9587.010; Fri, 6 Feb 2026
 18:28:42 +0000
Message-ID: <9905f5f0-ff88-4c36-9541-8f82109e26c5@oracle.com>
Date: Fri, 6 Feb 2026 10:28:40 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/1] NFSD: Enforce timeout on layout recall and
 integrate lease manager fencing
To: Christoph Hellwig <hch@lst.de>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, neil@brown.name,
        okorniev@redhat.com, tom@talpey.com, alex.aring@gmail.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20260205202929.879846-1-dai.ngo@oracle.com>
 <20260206061617.GA25655@lst.de>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <20260206061617.GA25655@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0103.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::44) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|PH7PR10MB5854:EE_
X-MS-Office365-Filtering-Correlation-Id: 03bc7070-3be7-45bf-01cb-08de65ad8e19
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?amRCRkVOa3V6T25sRGdRNUt0dzhVMndzVFk5ZHFmeXp1Z1RPSWFsd1NZd3Zs?=
 =?utf-8?B?T3MydGFCNDc5QTlkdllLTDlWUnFuSWN3ejI4UDQ5WWVjZTQ3VDh6ZjRTT0FO?=
 =?utf-8?B?cmYva2xJenNjN1FlTzlSazdFWm5iZmV1RW1HcXQxZmY0bUhqQXFwcXlJUUpJ?=
 =?utf-8?B?S0Y0NE9ULzlqenM4Si85bXIxbkpjMERxaXpxTmhDK0JHM2NUK3RyTnNYMVRF?=
 =?utf-8?B?WENzVnhrWklBR3BTS1ZScVVjSUl1dTdzcWVLUnIreXU1QTNwVUxDUFUrS3Bv?=
 =?utf-8?B?ZFV4MlZSaWJMT0VLdDZWamxYT3VBdlcwcTY5TEcwS2VpY2E4RGMxOXZnT2xQ?=
 =?utf-8?B?WmhWMG8yNWpqdWQxQXQxZTA0bEpJUVFmK2FMMytrTk9rMWZCUEJPMUZZN3dj?=
 =?utf-8?B?eWNLTFdaUUpDSm5lT2NDbzNPKysyUnRxQURVRkVZZ2FGV2V4OVdibkQyMEw3?=
 =?utf-8?B?c2UxOVJ2OGF3MzAyZHZxWThGbTR2Zk9ieC9UaXFwNlNTQ3dwWGdTeG81Y0hK?=
 =?utf-8?B?QWhheUZyRHlDbzl3TnowZ01xZVBLbnJWT1ZUdkFaNlV2YzI2eFdSVWRkK1Z4?=
 =?utf-8?B?Vm1qMTVKU3pyalRyS2wrenVEeEJpeXhXSEZXMVI5NXpJRzhLa1R1NjRFN1lP?=
 =?utf-8?B?dmxYcUcvNFRYNis0elJiMjJFbTc2SE5Bbm1IRDMvRjFGbnZXZk50Mi9hOTA1?=
 =?utf-8?B?SVFaVFhsTWFkLzdNOE12MVl1VVJUelJJSUd2K3l2eDVuMWhMaW5EMWUxV0Ru?=
 =?utf-8?B?VGlmRytaV2podytUTGtncllVTjBLQUFxWTRJMjVoNGhDOC9DcllZRWVySDBE?=
 =?utf-8?B?UVBPeHFzSFN0RjlkMEpIckc2N1NTOThWR29LMUwrWUFCMGlsdlA4dmV3Vmh1?=
 =?utf-8?B?QXBnUEp2MHprRUhuWlhwdmFzTkRuOTk0QXE5ZTFBd1lQZGZZNGRDcUpEMU0y?=
 =?utf-8?B?WDhSWnhBN05KZ3QvWVAyMk9teWNUYlp2dFhSakpXcnNSRkhaOXVuUlVxMk5E?=
 =?utf-8?B?ZDByck9rTmExTTR1a0ZmY0RPSWxRcm55V2tkWkVnZjhyWFQ4ZUVSeHZjZGpi?=
 =?utf-8?B?WXQyeWxLNk94OWNDaDBVMTl1cVQ4SlFXRU1LMFgvQkhpOHpIRTdzczgwcXVj?=
 =?utf-8?B?VjNUaWlTdXpzWE11azBOM3M1dmdweWcxR3BUMjFrSDd1eWNneHEwUkRJMjRn?=
 =?utf-8?B?NlV4Q3VOSmpVU2pVVVQrNXRBM2xub1JSRUlFVGdDdXNnemRvNmFhbHJmVUdq?=
 =?utf-8?B?WGpxYzYrRm9yWGpMQ3cwZGJBVDhhNzB4cjRtY1IySWR6cHNGTHg4VExVVVFI?=
 =?utf-8?B?ZXpxSmFZclFYc09KdGJKUEcwcm5MdGhOeVBHRmFtUURXWnR4SHJUVFJFcWsv?=
 =?utf-8?B?UTJubjIveFVRNURLZUFBS0hNWDByRnY5V1ZyQTJldVZkcnAyc2xLclh3djZp?=
 =?utf-8?B?ajJYckl3RlhsUHIwek04Zmp1cEhMTExaR0QwNjFTYWN4TkwyVGs2dGlYSkJE?=
 =?utf-8?B?eHVBTXBXUFVIMml0alRBaXlBSnlZaVRpeENKdUQxZEx1eDhBUndKN0phWWZP?=
 =?utf-8?B?dWo4WUJabWluU0d6MFQvUnVSRWk5WS9PKzNER3ROemN4SS9GR3M5QkhIWFgx?=
 =?utf-8?B?Y3YzeUVSNXVGbDBRUGVkd0Zrd1ZRWDI2cUFweFhvOTdoZ2RKdkVVclFmYjlZ?=
 =?utf-8?B?d0VIdnlhOHNKVUVubmF2ME9MWm1lVlBVQkFJbTc4VG5USTIrMnQzdHBvSW1t?=
 =?utf-8?B?Q2FTK3hnSXJOVk15MnVYU2tWeFJqQlJKSzREREZGWEgzcStrN24weW1wWlVP?=
 =?utf-8?B?Tkg1dmNvWUludm9Cd3NkaHFJVHMzZTJMTnNYdFEwbmhPc3BTZmRqcmpyNC9C?=
 =?utf-8?B?Vm1XSzZ4SzZjWG1jUUg4dHBrNm9ha0o3MXFzbWkxeEJHb1Fmd0x6OTlMMDhN?=
 =?utf-8?B?NzZIVnkwRDV6ZkMzeG5XUXo4Z3djM0V4L2dFdXhpdzFXWUdXZCs0Tk8zclYy?=
 =?utf-8?B?Njl5clNCWlFZMkNLV1dxb1BqWnFienZLVk1vS2g5SFhRbHdCNmdETmRmaGhK?=
 =?utf-8?B?TlJvQUVkU0I4OHYyamxabG92aUJoSkwvQTc2aDNPRmVrSmN6Q0tnYk1VdURl?=
 =?utf-8?Q?rSzU=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?MDFZY2RFZ0dnMUl0c2pjUlcrMjJtZlJ0MUVGME1tVHppOXlURS80SWZEamRZ?=
 =?utf-8?B?SFpiNTRxSHV2OWZHVW03d05SNWJnWld3ei9VTmtSSnBCZWFZL1gxZ3RmSE1O?=
 =?utf-8?B?MGpoakdrdGhwUUJML3dQZVRDVFpLWHgxQ2ZDdzIrYUVOMHdOa2s5V0VZZ2d6?=
 =?utf-8?B?bGFYdHVJZkhpNmNRS3R4bjhtTldVUUthNnAvQjNvYnV5SmFES2Z2b0wxVHBF?=
 =?utf-8?B?Y3hsSGRGYlJVdlpyMmNZY3JwWXN4Vm9ublNOQ2I3WWIwQXpNKzVZOGloT21X?=
 =?utf-8?B?b2YyN0lCKzFQS1VVaTI1aEZkUWRIZHpiVnl5NnJMaDB5bnRGTkNGODJxLzVE?=
 =?utf-8?B?ZzBjbmEwSm5vdithbkNROFNxUVA4WUJNQXBYTU95VGJ4UGxNNkJWczhseXdZ?=
 =?utf-8?B?OXBueTZWT0FXYXVkcHd6YUU1c3RmT1lOcUYvNi9rVHQvRmJ4TXN2RHE0S1Vv?=
 =?utf-8?B?R0dzQkhsNHN0b3dOaW9naWt0NlZDZ1NQcUdxNjZlRThDYkdGZG9YaTRzd2o4?=
 =?utf-8?B?NmNuWUF6QThtZ0lubkJSV09uWXBuaGVBVnpaMktXcXRJbHpMZDZVTTVkdmV4?=
 =?utf-8?B?WHhaaXhSTzMxaVIwRDFoMDJKSEdrSDJvQ2dROGNIK2xuczRjZUVFOU80dnBQ?=
 =?utf-8?B?Zm5LS20wRUx0SUhnMnJLa1pydmhDNXNtVmFQeTVta0ZLQ3dxVWtwRlJnRXhs?=
 =?utf-8?B?a2tvRUJVTkZObEs2YjN6eFVjNW83Sm5YWjdHTjFPOENqdmFWQk5ONk10czFG?=
 =?utf-8?B?WDFRMFl3NVU0VmJuZUxUR0FBSG44MTN4bTgyNVNrNkZYRUM4U09mTWJ5SDZ3?=
 =?utf-8?B?b1p3UCs2djAyYlQ4Y0tuMU1DbUJuNGRRZE93QXVzWmd2ZXZMZk9jWW04RURw?=
 =?utf-8?B?QlBCWU5tQmlFbnNTY3Y2bll0aDRZWS8raXRrVXhKRDZuMytLa3dRb2duSDg5?=
 =?utf-8?B?VTlQUWxKYWNxaXl6c1dLRkxmYzNscGs4c0JqTy9GTzQ4NXUxVXBVQ2w2SUtn?=
 =?utf-8?B?OTVSOThJMmNiMncwUmpob1E1MkplSlY3dTdBcEFiNVlLWkh5bWswQzJrVXFG?=
 =?utf-8?B?ZzAyZmVhN2lNcG1pRVpOcHJCMHZaZU04T2JJUG9TT09jSzZGVFZ0a244ZFpJ?=
 =?utf-8?B?M2RpT3p2TFVXamtEY2lrRDJUVGhmaUJ4RFB5ZSttMDRJbDVKT1RXQTRmYmtu?=
 =?utf-8?B?QkIwN0o3Zk1JTE1PSmxST0pTelBFZFVtbm9RZGpMMDNFMU4vRTRLN1VueTN6?=
 =?utf-8?B?WnlRcFlxM2xheG4vbTdCc1hITTZNVTFmdzFvVTJmQkRTeG9vQjRqKzQxUFo3?=
 =?utf-8?B?VVBFY2Z2QjFxVXh4VDBXUGNNQndOTlNXOTJmU1E3cnEwMUhBOVBJMGMyQUJ3?=
 =?utf-8?B?Sm11Ni9IcC95ZjhtSTFPaVJyN002RUhjeXhwZGRTQ2ljNEdoU1llQmJQcENT?=
 =?utf-8?B?Nk1vMU9lY1hTUXd5bTNxTlMvM3lSdE1aTDNuaHQ2UndMejVBaS9uZzdWS2hE?=
 =?utf-8?B?L1k4VVdSYXpoMlhXeDRURUpYR0VHYUFEdFl1KzE2RjFZMHJPVDNSRTBHU1dG?=
 =?utf-8?B?dkVhRjZqUG5ZNFBMZFV3aXhwcWVVcVRDSGYvaEhxRVl6dnBYTDFIQXl1T20v?=
 =?utf-8?B?SVRQN2xHN0ZNYWZSWVRna0RwNFRqeG8relA0Tk1pbWJnajFaUGVtNElKUTUz?=
 =?utf-8?B?ei9OZkxSTGVqOEVjWWtaaUhhdE9VY2x1UTBTY20za0hTVDVOcmVUV3R6cm1B?=
 =?utf-8?B?K1ZBN3B3UDZlNHdFOWNON2FyVEFxczB6Y1RLNFJENXFSV2lYZDFwRXVlQ3BS?=
 =?utf-8?B?M1UxdjFzSzNCRlAzM1R3M0VWZitnVFd3R3hDREdCaGpFMURqbUxmVXI1RVJq?=
 =?utf-8?B?WjlqR05jV1kzQllZRElFMkhjQktBQk5FbHZKVkZ6R2JFZnpPMktocnkzZDNt?=
 =?utf-8?B?Y2xRQ1pXZm84enZDdmF2TmJFaksyRDZXemRCVVBaVERHSW02VUxqV0tWWGx0?=
 =?utf-8?B?V3B3eUc5RlZDbjM4aXNDeGFGTkEyVlFOQkRuOHlXT3p6bVhacUlRTDhlbDFa?=
 =?utf-8?B?WkFWQnNmdHBGb2FrV3haa2pUSDZ6R2htSFREbXJUc2VNZENFKzdiUmJIWCtB?=
 =?utf-8?B?RitmZ0RzR3lNS0w5VVhVRXl3K3lEUG03bllVay9pbWZ5dW9oVFhGQkpCSXd1?=
 =?utf-8?B?WitaZ0ZMVkNXVEIvaWJHOFBQZnQrK2xEc0dtYVVrdG91MjVpM21EUURaTjdZ?=
 =?utf-8?B?dFA0YlkwbTBkYXBqNDRyYTk1L0JuMDFjMmRVd0tkeUthOENuUHlibDR1bDF0?=
 =?utf-8?B?bmpma0lEVEppMzFCR2tYK2VVSlBFcWdNSkNVbmp0YUJITnByQlNKUT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/LXl2RFAW/ihG3BG/J29WcyDu80UJlA+OwEAbeAavwgfzwFYxTwurFK+jcmib1wnfIOF2s++5hI8QO8evHRNaCm751fXjNhN9Qyekgf0J30ewD+SiFTu3aZ2dyC6RlPY4HU7iG95+h/APJvF89xlGYOzjZEme51RSzBneuq0OC+XmQjmEVQzDjLSKQz7ZfuYRvB6jtaghbTuUqpCb9+aw+b9GsbXBH2VO+iX17m1GxNa9rGq8b3trGjPk5JkqJTi8CdoUnewA8Pueuq+OMBbzuIXx/hezfLA3pQ0OgrSBx1hA3QBmyfAN2TFbweLa8YsmMXranUONyIwPBA1s2gyBLUZoKEjl6BwFZuu7P7TaydT4vdpey1Z5DHVeMacwdvOwwwM8NMfwMkxzqLxYd51ajLPasxFA3cHihLJpyC1fSYcbeCVLEvU3OURW+RBi/o0xj4vxL8Ze8TejYj9ItBB0WjiKV+Sw6ZHfryL8szBeIHRYoXZUqE3NrQZSAp7aalg7e8hsaGt7FGztlO1KkfPBsLiC4l2QA2FraLy0MP9XXOtlH33ny03CCRKRJHqJVigoTYZzulPic/s0BE8gAhh8rBnp4PzrStuvvCAn0LJPM8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03bc7070-3be7-45bf-01cb-08de65ad8e19
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 18:28:42.1906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4obad03Fc2UOIZE4RqqfuzESJbcPrWik3EfVB48l9/JbPOWIUeo3QpjHPXw0a1DQspsCLBM3gyFAyyzbU8deCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5854
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602060136
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDEzNiBTYWx0ZWRfXwXTgA47Y/YoI
 jsnUPo4icp/oroloVBrHfCRUlFv1Jr7AHo593CfXCTTnm4gGcHLw5X0fOaEbtoq4cl4EQPcMYMF
 E5jJM3M5aVbqCKfZLuyS3qd25Fs8LeImD8Qg33TxN0mZLDuQjfsbFbF1SokqBrS7xEktNg0xWNz
 /XUD2DJVD9CdXpvvGJExT2vYtMLBQtFNy46sM0rlb/ZE4UZW/L590ZI2Dn/0qWOJVmPZOHZh8LY
 gxsxr8+DV00lwxT4ZS2qavo2dKkta+KPS5o4A2bq+xxO1yJGClIpIEVFvh4ZMWFeHQgKkdukNEv
 1TpWzWbpqny/iwL723WRhRKnDcD7NuQr1bCTzSbwQiEgC8+40N3U19BV6xIz18+gHRCEnpkdr4z
 /LYTYqxUInaTR0sTagvy4lRT3/Z/VAzjGvg+yF85vkiC7I6r9feQ02W0MJIPkuh5nLMSxYSlUjV
 /uiSDAnKJOm+kwz5f7Q==
X-Authority-Analysis: v=2.4 cv=VdH6/Vp9 c=1 sm=1 tr=0 ts=698632df cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=_DJstTUk-b4ugo7di3kA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: n026hlt0dqpWdAHuvvdilHSsOXFdGUiG
X-Proofpoint-GUID: n026hlt0dqpWdAHuvvdilHSsOXFdGUiG
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76626-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[oracle.com,kernel.org,brown.name,redhat.com,talpey.com,gmail.com,zeniv.linux.org.uk,suse.cz,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:mid,oracle.com:dkim,oracle.onmicrosoft.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: DBD4010207E
X-Rspamd-Action: no action


On 2/5/26 10:16 PM, Christoph Hellwig wrote:
> Most of this is over my head (but I'll still try to come up with good
> comments if I can find some time to learn/relearn the lease code), but
> one thing I noticed is that this mixes up VFS and nfsd code.  You
> probably want to split this into a core infrastructure and a nfsd patch.

I did separate the patch into a core infrastructure patch (lease code)
and nfsd patch in earlier version. But I think Jeff or Chuck suggested
to combine them into one patch since nfsd is the only consumer of the
newly introduce lm_breaker_timedout operation.

Jeff and Chuck, please advise.

Thanks,
-Dai
  


