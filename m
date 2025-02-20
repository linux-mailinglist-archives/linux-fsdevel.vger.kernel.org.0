Return-Path: <linux-fsdevel+bounces-42148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE78A3D29E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 08:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AD693B6EF7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 07:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870CC1E9B22;
	Thu, 20 Feb 2025 07:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BQpqrndY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VpoD3iDa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453C31B0406;
	Thu, 20 Feb 2025 07:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740037733; cv=fail; b=ah+pelXKoqxrvYCxp4rbHnSpD2myCYDuzYmpIkMxgDFfpD8xsEpgB+0avBFD0noFa1F4Uj1aeXleoYf/7IuS5wjODerzEKxMWXfHgMuVdAAsU4vO1cqaII2hpWMqDOpmwyVIe9luzsDLGmf+6mIGpVj6/dy3B0xdsKB0DznR4II=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740037733; c=relaxed/simple;
	bh=MrF9L+2si4gOLaEwrmZ96koCO0VOfe4yUf5uaaTOBs8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WYbXlC9n0Z+Sj1YNmquJwEe/NorqI2y9+pDGujiY9Oc6wegE1HUpSHb69G4+4XMRf8GzSlhB1bpK+wS59OdohN9/VKRU7IZ8/H/WmSPJf5BSAnAV1yVLL+afDSrfyLED6eIqvv7AcOwsHG5m8fOGuTSflVAMsp3EgK5Hq2tghBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BQpqrndY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VpoD3iDa; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K5ft1S001785;
	Thu, 20 Feb 2025 07:48:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=J69a/tIiY9gctRWXkFWZ0K8xIm3arY5gTxRhW1IdvEM=; b=
	BQpqrndYNilrawTUXMlJBgYH/jnTDA5x+CJbfuCx+NcvE4cH/WuKG0KIHJ3stqsK
	RxiIbslHyNX0N+6o1l9vLkZc6yjJHQhViIX/bvfccQ4T15w6kCz3eWPtfgGUQLHl
	VRn5blXpUZBZHhHmUqOTpVwQ1m3fSGNsd9Jj9ObDV6fn33UfAsb18vmIo8If6Wtw
	TTVEkefnNDeALuV9n51rzIn+l1Y9uPJ6REcyhzWhpDx6MZnvpXe8CJlwGh+r7w37
	dL/uQOj1hqrzcJbG6dEn2OZ6YcUikyTq2yosqqzm5FhcCmQ/O3bF/7fRI+huRnrw
	v41kWXjcZWfszlLsgxdlZg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w02ykjan-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 07:48:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51K7Q9fb026469;
	Thu, 20 Feb 2025 07:48:34 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2047.outbound.protection.outlook.com [104.47.58.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44w0sq1xvy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 07:48:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YLR0b0q2q9OeWr4iJMGpLLhtX9AOEryhwkt84g/ndcgJnVKyil12wKp0wPU0fJiTZ839Q96GHZcHJtlfqo/xkhTjwQ+V5nd8tIUOB5bJ4FUCjAvrafXW950xvo+xdN1IMzwFqVOmz3IR5BCHT+7eWRGJkdl2GXhoGcSn0x+UM6BBvbXj7O8e2/u+9x6QtkFyCuwQQ3VBREb3aWV2jZabyqMhDjcfIWTvpYYfC4JcueOis34lIQ6nIF+jyO74ByBTLMY+/WEApgVjDUSWUzLhgeBtoWGPthlzFWdf1bbv3dm8SzEflzsw93MT4bBVb711VKUMO0xXou5339kaL/WLrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J69a/tIiY9gctRWXkFWZ0K8xIm3arY5gTxRhW1IdvEM=;
 b=uhmwk7JJbBFn2FnmPfd/ubl52fl7rzR7Z7tQIfUQ+Kq+ZW+XfFLUOUv9dYdKO2dW04/hQoHYUBh9CdtNnnpHgFcWEQL/hva4TkHQTv5/AgrWxX2W/ZwivvR/9AO1TwJW2Au4JkicqPBpSFc2Nv8QR0DhCBwE/qVvzw1qawUysCBGVfHklIQUggJHXuSU/SLv8ck3XqQwr6h9w7+ckLBao8sV9xtvrYqWji8IRwrUbADOgnI5vqerwIcpAeYF8vIqE6aW1YiEbURh7IpmZ76cDuX1M5BomtIbeHBx96yw1qwcu9ZvbdG2rzCzRHyRew1jvSTZu/MyByZqOK2hdiTLlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J69a/tIiY9gctRWXkFWZ0K8xIm3arY5gTxRhW1IdvEM=;
 b=VpoD3iDaceeDg3Cw6WH/j4QwkO19VNiUK70+z8/tmdSX42YLLEgYskOQdTggGJhyjuR8f2UNMTBeXYrWeAoo+y4RzFxrH0qCoJDwMRqMZlf82SRS2X8Wv4KgE1WxhLT4vMyjl885cTvPa3ks04+TZFmqNnDqUvlmfh5ptFqr0Wk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA2PR10MB4604.namprd10.prod.outlook.com (2603:10b6:806:11c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 07:48:32 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8466.013; Thu, 20 Feb 2025
 07:48:32 +0000
Message-ID: <0f983090-4399-4cba-910d-299bf5e0da2c@oracle.com>
Date: Thu, 20 Feb 2025 07:48:28 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] large atomic writes for xfs with CoW
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org
References: <20250213135619.1148432-1-john.g.garry@oracle.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250213135619.1148432-1-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0606.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA2PR10MB4604:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e7f03ac-ed84-4a58-89eb-08dd5182f8d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aldJUmZaYjVYa2gvNHlFSU9PU0lyUnRmR2ZsOHZYTWoyakJGTHQ2K2pST0tY?=
 =?utf-8?B?d0R4enlJK1lpWCs5dUFOcUZJZGFDd1lVNE9sSy9YV2I3RUFoNGttTUdVNHor?=
 =?utf-8?B?MzlZbXAyc1VKWThnN3EvOWF0d0VnU3M0dE14ZWFWTUxDaUlPUFdsS3Y0em5n?=
 =?utf-8?B?cUNqRnJodWVVZG5rZTNDOU5qMmNML05ieG5XVzlNbWd5VVhtbnlEekp0eXlN?=
 =?utf-8?B?b3BydFVGeWpGZ2xXS2J5aFVEQzRvcjRPZDFlVFhib3JlQi9lY1I0Q09YZnlN?=
 =?utf-8?B?d2RNYWVmRlVRSTFYelVFR1FCaytmbmxJaktzQ0k1QmhmTEtpOHQyckJhcGtE?=
 =?utf-8?B?MzIrSGZMS1R3WHM3bWxoMzFCekhBSno2ZWlWNnROUlIyVUJaT1U5UTQxUFdI?=
 =?utf-8?B?cEVNcnZzZjlTMHlydk9EaVZYRWJhaVI1N1Z4Z1h0OTNpNlVUUjhOcWt5OTI1?=
 =?utf-8?B?eHhYNGpoa2gvMkx2VnZUSnk3UFJ0a3VTbmlOT0tzZ2VEL29FYlYwajlNNkZ1?=
 =?utf-8?B?cjlpTGZRTjdGTmQxQnk1eXlJbkh6K2RQVnk1L1lZUTV1eXdUd3FDK29odkZK?=
 =?utf-8?B?TmRZWm13ZGRZTUlJZU55MDgrc0wzUFFvTStnNXFtUU9XRTMrOVlUSit2SzBV?=
 =?utf-8?B?NTJBWThyNS9nTnlLanIyVXR0Z3lLZVdNTjZ2dWROV3lHUUdRc3M0cmdLbHly?=
 =?utf-8?B?UzVTU0xNYW1UUEN1K04vTktpdjViNGh3T2FHWkU2VitjaWpTQ1U1bkoyYmky?=
 =?utf-8?B?QU50TEk5Q21CU2gvRUYwenVjUklMTGRPZ1NyZEZzQmt6SW5EK09SSi82aXlK?=
 =?utf-8?B?YkZ1SGhSamkrVXBNWmlkcFQ4NGFldUQ3WFFvZk5xVjdnVjBVYW5IS2NMU3M5?=
 =?utf-8?B?TU9mWC91cVdBc2pIeVVTbytmRW5pRUhCS3JpT0FOaHlvY3MxMDRIOUZkZ0J2?=
 =?utf-8?B?bWJ6dW82clpOd29HQkIyei8za3owLzFyZ0NXUnR3aFdzRTIyQkR1RWdIemEw?=
 =?utf-8?B?b2V2cnFDdmxXV0MrMHhkVktpM1liSXpiQ1ZienZ2dllEMkppSlQ3a1NKNGNP?=
 =?utf-8?B?MXh2enNHdk05N2dYc2w3ZTJMWjAwd3lIRklhZXV2SGhHdmZ3VDNCdmlkbFFL?=
 =?utf-8?B?OFV1SWtrMmQ3MnFLS01tZXZESmRZUDRuYXd6ZytENHBCSElhRGVnVS9nbEJl?=
 =?utf-8?B?NkQ2Nmtsakx1eGFHQndGT3pUQWJNcmFXeEU1MHJMY2N3OEM4QnVvNmxzLzds?=
 =?utf-8?B?Z0F4QUxjZisxdnFlZFUvRzIySUxBc0tJTk5Nc2dLRFphL0pML2V0TjViNlRP?=
 =?utf-8?B?MVNEUkVqOUdyL25RbDdWSXBteVpQeVdTTmhsRTVkSCtGQmVXZmdDNG9ZeTVI?=
 =?utf-8?B?ZjJBWEoxL2cwcnNoZ2IrV0Y0MXM1MjFIZkJwS2xldm5QWUl6WCtrems3bnNZ?=
 =?utf-8?B?KzlyQlNjMEc2QzY4NXlNNzl5dEcxVUozVlR2cXFoWVB2VnJPM1NTeGxVRzVs?=
 =?utf-8?B?WVEyVWEraC9aamlpUDlVK1pod0NVV3RVdk5WLytSOVVFalg0OHY2cU4yeHhq?=
 =?utf-8?B?VFN6c0RwWFllVU9FL1A2MUU1RDFoeVR2cExSQmdVMXJ6ckVmVTZOM3FQajZv?=
 =?utf-8?B?di9ZWGFVcnBmaG1VcVd0c2txOHNtTmhKUzVnNDlUWjdCM2hpV2hpb0RyTWoz?=
 =?utf-8?B?bkE3a3hibnpXZ1h2cjRFenNCZEI4YkhndHBoc3lyWFBlTit0cE9wdGJUVE52?=
 =?utf-8?B?eThCdmxKQ0E3Skp3NDlDSlpGRGVEaFhYNE9vVGdSWkJ5THNPSnZKWHFSUE14?=
 =?utf-8?B?UjBqN01vUi8vYkVJQnF2Y0ZhQU9QdzFIY3REN2o3cXkyZGlFRHZ2VVIzeEUr?=
 =?utf-8?Q?+g4Jj9I6fQ/kG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MDBCS25QS2lmWkpob25BUklzOFBoNUJXZ1AycGd5dThoUlQ0clV1M2Ezc1px?=
 =?utf-8?B?NFZUcjh2N1ZTTDBpNVYyM2pHck5JQnJ6dEM1a2Z4ZnByWWltSG8zMktrcW83?=
 =?utf-8?B?T2Q1bC9UWWtVMUVnWm9aVzhYYnd1RVYvT0NhQVRoMzk3TjZkMTE0TjR3emJk?=
 =?utf-8?B?aHl4bUhYZGRMYkQ1akZEYUg0cVBQZTViU2V4TUhKTURFV3BVNHpWYmtvenJ5?=
 =?utf-8?B?aDJiRnhuODVFYnl1WWZhZWFybUgvTXVjSDA2NjdNUEcwZlRVdGpmV0k5amxm?=
 =?utf-8?B?YWtEYlM4dkNhV0M0clRrRVpTUHBZa1FubklmUHFIb05PMVNtVE53Q2dBbHkw?=
 =?utf-8?B?RXpnV2VHTmZtVVZJcGtsalNjVnA3ODBrZWc2UVk2a0lYMk9iMHpsWXNscEl4?=
 =?utf-8?B?a05FOXJOeTlzRUlaNTU4N2IxUkp6R2xVdXhUTUhWOWVOcHBkcWY4TWVRWVI4?=
 =?utf-8?B?YW95eTlGL1pkT3dIaFQzMmZtNHBHVXBmRmI2MnplZVYyMjFPSzhJU0xVLzlV?=
 =?utf-8?B?Z2ZGWDhMcEJLSHJpbGdjOWdxTStvWFp4Y2U4N2paVEFlUXM3YmZma3J0b3l1?=
 =?utf-8?B?eXdoaFJ0Y0J5cWsyMW1hWWpXdzM4WjZrMjFKSHBsaHQvR3RuazVqQ0lOdGl5?=
 =?utf-8?B?TUY5QndqanFoQlVLM3FLb2hkd3ZObU54bGUyeUpBbzYrNkRJWlY3a1dsbWZj?=
 =?utf-8?B?N0pDUkpQYStqc0VqMEhRcU9zQUgyVDJjNFlhN0tKUG1wc2lpOHZTRko1cVY1?=
 =?utf-8?B?dFhiK0RWS0loY2hTdlo1NHdOSUdwV1NXcHFEdjN4bDRqWWlDT1N5K3pGSzdT?=
 =?utf-8?B?UkZWNGVpRTdWb2plVEpUY2ZVMm1nd3pMMDRVU3QyVGszd1hWemNjRGZPeUYz?=
 =?utf-8?B?TkFndHU4YmJZbnVDQm1rT01EM0szeGIwdmFtS3VkY0oyckd2OVRZTjRkaU0v?=
 =?utf-8?B?MWx1Y1Rmby9TUitnY2krbDVwR3FpaHV0djRBMkZvTG84ODhJU2tXTFNsanln?=
 =?utf-8?B?TVl1SWdvZThUVWJsU3h1S3hqRzdQcUZENHROZ2ZUZEJJZFpwZVZzUXp6Vi9H?=
 =?utf-8?B?NEg3c09WUTA2UXdZT2x0ajJQYUVUdklGaE9MTmNJbTI0b0tSbzBwMVp6Vklp?=
 =?utf-8?B?TEZlQkhIcnFsQVUyNlVrMHdZS0lCNlRPcWVoUDBPTHUwUDdaOElIekxxaStP?=
 =?utf-8?B?ZlZwVkJyZkE5cFRzV09qWGpSMEFESjVHTXpMWWhuQmZSODd4ZVVkYWJPRW81?=
 =?utf-8?B?YWlpSTVsSW8vOFdHSkRRa0FEWmNuU0V4dFBvdWovak1HUHVFdTV1Z3U1ZnFN?=
 =?utf-8?B?UGdGYzl2ZSswMjgyRGllRGdrVW55VCtaN2ErZHZoeXpySmhyNWY3YVpDRnpI?=
 =?utf-8?B?ZG54TnFieDlpY21oeWhqUWhEYnZRZllwQWdEN2RjVFhsenJzMG9jK0hYT3A5?=
 =?utf-8?B?dmVheUROQXRteXZMN29kTDRsWTR1THVtTW5GRXEzbEwxYUlsMjNzM2RLVU9q?=
 =?utf-8?B?R0h4QkRCaDdSeGxsOExVQUJ6Z1BYVG1pK1ZFc1RBdTVVYTlaYXVrb1FoRHZT?=
 =?utf-8?B?ZlErTlV5ajB3T0tkTFgwcnArL3VURE9ZcExMalZXblZvKzJLTHJBclF0TWJS?=
 =?utf-8?B?VExQblZoM1JkRERTK1ZGaUFma1V0MzUrRllUNkdzYjlaTFptT0VyNkszUTg3?=
 =?utf-8?B?T1I5Z0tUZmZEMCtpRDJBYlVIbmYzcU1wZU1ZU01BRXJERWlNQTNTU0RXUXRm?=
 =?utf-8?B?RjNoOXZRaXBCay9xQkp3SWljalB2S3FXbThwN1BYd2k5U0ZReUZrelN0cDNo?=
 =?utf-8?B?L1huRzl2c1BiOEJRNTlSbXo4dXM5RUVqbGVTcU12YlYyRUhwM0ZEcDRucTB0?=
 =?utf-8?B?YmhISzVFdEJzZ3ZaOWQ2ZmVudE1PY0hoWmQyTGJRUUVwUGVPQ05kS1doYXBj?=
 =?utf-8?B?eC8yR3h1ZE05M0ZxMlZZWmFYNmhIclV2eTg1K3ZwSUxINFhWTnh1ZUZyTUJM?=
 =?utf-8?B?bktzTjlTblNQRENESFEvYU9IdWUwOGlQRXlaTkJEaG5nK2MvNjlWcm9zMlBv?=
 =?utf-8?B?Y0NVRit0d2tUaUZhNHdONzc4SmZhd2QyYWpVQ1RGMFFKRkwrYnZJUHQrQjZB?=
 =?utf-8?B?MlZabE1RUzNnOWNWaGdVZDZmVkJzdUFSVlJDOWdUUlBwYjlwc0lrMWhYVDI5?=
 =?utf-8?B?MkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QySbYmto8d4sbE6UHldq/dGw0oGILp0qqLCr46Lx/rOkON3K+JgZcH27ehtvyemMWhfDce1KUy9xQ/2doqnbyvfvl35fTXOF7U7Nrpc8NlrBCjC9f6wL8nnZm+6H5KEdHkjUQzvCTtl3z+RcVajmhlsJZ9kLUO9rVksRGsAMtnbcXf5iR8iE8LzzkgY89FAMDart/NIHtGeRO5lC0QEx42G1hdX2SzIk1IZl4zShr0G91LCxdgFbZttfm2RRYifxXvCjZpYYdtXGurQD1yZNtXtU9YdcZMePee/jSBSaLVi8bza85kbTBb3gyMm2m5fhzCTG/Hfov6mYi2cdwTN1OsPgdfkw8mOB24tSPZa/qmRPpAZnJxBgevyBvB+dNY60vdbqCH+fzIHSTTZVPiBKpjcOsTnGlehjcpgoqwftRh9UVnc32krXHIdvzEuC7DRgdt+RDG2NS/jdd9Ao3viP4xhYLOMNsUWd3qQJndKV78Qa7BOoMU4Q7CW9cr29GIAIEWacMsHfMsEj/1itXTIqguuD+4REl5IO9pfBLfANuSlzew2nyNGLUmYVx2ndVz8HGDwyRfGxFQX4NvTvMYw65FVeU2EdqBrF5C/FKPrrXn8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e7f03ac-ed84-4a58-89eb-08dd5182f8d4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 07:48:32.2072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ReDpenvFSsrs0Px4NOKyPFqX8tugdNI3V0CP8RZDtxkDva7ZkCMHMy3BOHemkbiXQ4EtElkOe4ozN8c4rzYBaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4604
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_03,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 mlxlogscore=978 phishscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502200055
X-Proofpoint-ORIG-GUID: yMpVGOGMMnVJ9ltkvR8sIHvmHoHqQjck
X-Proofpoint-GUID: yMpVGOGMMnVJ9ltkvR8sIHvmHoHqQjck

On 13/02/2025 13:56, John Garry wrote:
> Currently atomic write support for xfs is limited to writing a single
> block as we have no way to guarantee alignment and that the write covers
> a single extent.
> 
> This series introduces a method to issue atomic writes via a software
> emulated method.

A gentle ping on this one... thanks

