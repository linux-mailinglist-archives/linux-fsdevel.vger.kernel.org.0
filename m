Return-Path: <linux-fsdevel+bounces-13879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 940D5874F5A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 13:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B455E1C23A12
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 12:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A8312C52F;
	Thu,  7 Mar 2024 12:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VF34zE3f";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="m6SxWlDV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5036D129A7F;
	Thu,  7 Mar 2024 12:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709815401; cv=fail; b=l23KVXvqStGa2kWGtiXXfUCkGXk8ng5AY2lRzAZgaWXSKQfDTiaVE4uFzJwBSaZh/yBjAfsSG0PD3fXA8U2TYBtgHJHxDmbzyagsRZiKToqeIIQGmL4s7ZcrD6FkAilvCl/edjuCBAY97Dk8XMRvHELEjF0KQYWB0jWQFMa6E+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709815401; c=relaxed/simple;
	bh=yuANhGeEVkmmcjHlSpXhS3evrMhdZNvjKkcX/yIW9Rg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d0xW5tndewRkzuAgvAtyWQufyg7GXZTDJd6w0/UgHmTrBpnd5CuWuy9sB5PQJm2JJEEU/bdXyrIyimVuapqgorOWZyxIpOdzP1k5Y8XwVIR4uf1VJFjQtCbHCvOsmYFHuc87+3W2XegtMWKPyBMqW4V8jIswqfJ49DCuSByS7Mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VF34zE3f; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=m6SxWlDV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4279nU0Z019341;
	Thu, 7 Mar 2024 12:43:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=MJaTBJNOYg3wnoi14K+fcdfCN4QghyzFd5Bhu2alYlc=;
 b=VF34zE3fwiuRfHnz11XFWw2ngX5Ma3alyyX84c86KG+WfK48cPF+SoA91RUHUW1QsxLs
 ur8bdbAOWYJ0DgsCpF1oPuA9kpCbR4/80yHkRXeMhrSf19QP/9k8k+c+2B9gAj7bJHL9
 n4sQMHDeCdEEhHNEFR1PlAl+y9OE2q23MnorGtsPloIYhTbkV46lDjtRKL0NGLwZZ0ps
 tWtuGp/XLWbjkcGN6jOAYCuGQdDld22potUFGiYzErXH5Ac2yS7x3EWyb8oJ1+xyHO1s
 F7U7EV1upjubt6LCuBpye0EaaG2zHFMhn6W8I1STWUXXrltXmwm4MMzV5YbZtrnSPToP 3g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkv5dm0rr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 12:43:06 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 427AZWno004904;
	Thu, 7 Mar 2024 12:43:06 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wp7ntqueb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 12:43:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ICEv8In9z4qUf8/CExXWLcgHrc04x5x/2N/MeIc3HsJ3vA+Av5Jwz4ivYBgjSERYIoI19ILaaTRIh6tt2DFU9WvFMaO4pXv26q4V42y66EPRdk75q2F4rai04redo942NPdV7PsADarpU+LKL4JZ63Rt49dpiVJe1v2/T7QWzPbyyq6EoAZ/Z9/NBKrLTC5bgIpi9Xvd3NlmOCztM+wVtfcXehOhvgXZvGJgH6pqg5IBTIBoBH9CuuDSBbHM369beIxbA7dUm0nWncL3EM9Fel+yNBB9hf/DZK3m2KBewkVgz1hdyxhy8EH7eiCt/OfCMHEdD14VVPWysjVnswmcgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJaTBJNOYg3wnoi14K+fcdfCN4QghyzFd5Bhu2alYlc=;
 b=Cz5SEki7eTZUVRWhGqIOwtl59MINVar/hMG0FEfDO02vtpBwjDwgSlzLDHHtVglHMJG0i+9ccO0YTSzJq8pUER1Rhyoh6Ghvgl/Z3FClQOV4sKTHBqzaak7H+K1tfaY2xAIZk8LUYIpQe/Szbe7mIoVlXHklt2MNcJ3N/uo47jjOVfEM7++gHXIenE7bnEWb1BzrSLJGh0n7tXLw11ki+MAPbUzG8VyR5rUCSi0eJcjyaRsF0I0UdbfoR38h6jcSIDQ6KTPwlik19QRZEW9/jDX6XxzPfIxxEXHah49bPoFRntDnxFdMXB1LPLn9KCLvZ6vJanw29U+sG/uyXMPMzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJaTBJNOYg3wnoi14K+fcdfCN4QghyzFd5Bhu2alYlc=;
 b=m6SxWlDV9ckeV4sHPf/Y+sqAQ7/hA+Gybw3oAyufaBvX3tUYKZvNWgNjL8QAeYBqKOrFtRp1Ec/WNPs2SQ1CJFROLgMsWGwgTfjNDJxhh/lGl9RHXqNozuxXJsBGugyms/RvtGC7Ylf1YZEomyuh67t2ZsfeDS9hBOHQi1sDSBg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB5995.namprd10.prod.outlook.com (2603:10b6:208:3ed::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Thu, 7 Mar
 2024 12:43:03 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324%4]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 12:43:03 +0000
Message-ID: <6dbb5eac-1e3a-4d2d-8e74-38f6aac1b06b@oracle.com>
Date: Thu, 7 Mar 2024 12:42:58 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/14] fs: xfs: Support FS_XFLAG_ATOMICWRITES for
 forcealign
Content-Language: en-US
To: Dave Chinner <david@fromorbit.com>
Cc: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz, chandan.babu@oracle.com, axboe@kernel.dk,
        martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, linux-block@vger.kernel.org
References: <20240304130428.13026-1-john.g.garry@oracle.com>
 <20240304130428.13026-12-john.g.garry@oracle.com>
 <ZejjjaTFPi+qEDgS@dread.disaster.area>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZejjjaTFPi+qEDgS@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0005.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::10) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB5995:EE_
X-MS-Office365-Filtering-Correlation-Id: d09bde67-c90f-4b83-6d73-08dc3ea42153
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	8RU4MPNKEoFyB8s6Zmod6a51RpxvfrS3bG4cuEqbzuWkypf2MQmhFcSDzwz7wIHunYUVuhD3+Lw430B3ax7Ba6kKzs+Wm7K0gFqCPZdOyPuDdqo/hLwJsaOlmKdq7LZxjI26V4Ngh8rWG/D0+cV4OOe/ymbk0hBtsQw2A0DNpq8eXykQrNnZH/3B7BeDQVMufJnUv5n0oEKigCA5hwmUu8QqiDzqyb+VtXLGEwvj7OqUCocVCc3723YHIRfetqxx6tNEQj8NGNhj+Q3cLA3dHMbvW2ye3MNhG8zAm3V7wnY0uTsMvNDn1zGpveLvXYa8EvRy6hW0/xLqxz90ORya9O3GB9ALK8RJFfnKWoc6l2e/vy39bMvKGWAISmWHugZ5xHwzeuDCIJocKBB1dGIDWDS6uv0gZrmnZtM2mRsSk5UxvQFztwXBT4DIS2WMAoleh3xgI+I4rX3WmoICckqt50yjzA+thAr+R82QXh8+FeRl80pZb57H+ibJscKcuRpSk4tkSv7NvUpOt6FRXFdham451yRiRvlheQnjBOZktiKS21yI44nWc8uG9emq3e2De//REt6e7osLZq2gn6oDG2AIdDfwuUiJWtldY8qi5uZdfdsR/+987iloFRtmCE6a8ylPUp25hUzC2NRyyCyFDWbqpYacvzeti4BuF6LSMkE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dkNHT2t4eWdNdXJSMFdkVnc0bTNPRXJnVGNoM255eGsvSmVBNkUwdkVTdHA2?=
 =?utf-8?B?cVkyc0d0QzdPWGpCbEQzeDBkR2U5b2txVFZITFZxTTcyVHJldlVnR1kyNFNl?=
 =?utf-8?B?UzY4bFg3SWZESXdFUjVVZC82czFMUE50M2tRNjZESlJBY1dEWGN3Z2RNVHk0?=
 =?utf-8?B?OWJTcG5zS1YwelcwZWVzQmt2Y2VpMkRrRVBrbk5Tem92ajZ5Z3Yweks4U2Vq?=
 =?utf-8?B?czFQS3RIeWd6ZTAwZVJ0d2R1Q3ZEN1pIbWlDNkZzcDBSQlNsNFJBamFGT24w?=
 =?utf-8?B?dEFnWjlYUWxXR0R3Qi9CT2kzSXhnNUVQb05Bc3JlUFp5d25JVERTUjZSZU13?=
 =?utf-8?B?WHZwa01kZ2hKSWpVWTVEQWFraFBBcEtZbDdITFF1QVVYbUgxMXQyaEVBOWVa?=
 =?utf-8?B?MnIzdm9lUUo5R01yQ1I0aUg3OXVuQlJZZG1JWS8rdEFZOTBnaHJCRWYvZ3Jy?=
 =?utf-8?B?ZGh4N2JmblIrbGFJUVZKb05lb2lvQm1WN0JUZlpFb3h6UlR4bXhNaU9BdnEv?=
 =?utf-8?B?eWgzL2NqMFFaYVk1Z3RsODBPeDg4SFpacmM0cnIzbTdkdDJnbXhGTjRlZSsy?=
 =?utf-8?B?bjllZFJweXU2NTZxNmROcFo4TlNrM3V0ZGFsYUJBTlpFbVZmZWtqNU1DS3VW?=
 =?utf-8?B?UDVMZ1F0UlA1bUtNUmRzM0M5T1ZZT3BBaUNFTXlra2hUdnBiQkppdDhrRTRs?=
 =?utf-8?B?cG9ibGg2V2xlMy9rUXdmR0R0QTBOeHpOczB6NXIzMVBzTDlSS0tnRHBWaG1R?=
 =?utf-8?B?ZXJ1YzB2dndJemlESkNjbHVpSndTK3FDSFdneHlqTkhzb1MwcDZwL1kxZTds?=
 =?utf-8?B?TWtSaThRU2ZOWHM2bTg3bDJRZ0VaaTFkcXJvNW1ySEpqTlUrUHV4WE1ENmdC?=
 =?utf-8?B?UW1HQXQ0RGVHZi9zVjBJUU1YOTRENlJSSUF1Y3hmelo5TGsxbDBwV09RSHhj?=
 =?utf-8?B?blVVTC9uWklwNGVxZ1VDRVFpd2FLV3A2d1RTVmZ0elBYTXJEbmNpYXlqQ0th?=
 =?utf-8?B?dkpJaFVCL0F4YUNESDFJS0VmSDJWeEhSVU9rR1NFbHBiYXZtRTVGRUFKT3Ji?=
 =?utf-8?B?ZU1DeGpVRmxXTDg3bUJla2J3Z1BvODVCWnhPL2VyKytuVHg4NjBLUFN4Rm1m?=
 =?utf-8?B?VlhESDE0UzUyVDZUeHdEeDdnRHc3T0dwZjNRWUhVdURLTVBSUjZ0aGNVaTFl?=
 =?utf-8?B?ekZIVEN3MVViem54dXR2b3RkRmJna1R1Wm9hazA1ZldyY0VwZks3VjVYRmF2?=
 =?utf-8?B?VWsyczJua0NycjRPNGFxa0VBTS9PUWswWWZiTmxTelp1d2NCcVU3aVI3ZWwr?=
 =?utf-8?B?N0F2RG9IQXl3VGFFRi9IL2hiTmoxMUxqMEEwUWNrMndpVS9tUlRuZXFvQUtM?=
 =?utf-8?B?aExMR0NSTlBwVEUrUGtqRDhYeXFBMGZtZmNSQU91WHNvRGR5R1FVbDlLZEJS?=
 =?utf-8?B?MWVuaVFmZ0Z5YkFxay9iTEtUTEc0QlprSVJVWkpGajdsZEgxbHh6RXl0d2xE?=
 =?utf-8?B?U3dsekxVTDczcUFwL1l0TDRlNnFMdUZZN3JXUFpvNnQ3d3BDWEdieEd1ZndU?=
 =?utf-8?B?ZDlpY0t6bDJ0c1NoK25GZHlIajRWcFhDb0krQm1TMDc0dlIxcmkzMmUwL3VY?=
 =?utf-8?B?Yld2clNKS0svNHpBYUJia0NmemVEYmRVdm82akxZREx3RFNlTlpBZVZQNHRo?=
 =?utf-8?B?Y2ZLMnBoSUNnOWh4c2NweVNUU1A4NmdDcEZtNUtGaFlyaWVMQzk2M0FseWhG?=
 =?utf-8?B?cVFoclM0elY0MFJmcDhxUGpEM2MwdHhOYUZmSHY5SjVOQkIxV3dTbmtwNDg0?=
 =?utf-8?B?MTNubDNLcFhuVUplVnZsTWVwNFJqQ01BSnVJUlFDMGdoV0t4NmY1bFBLbUVM?=
 =?utf-8?B?YjQ1TmNOSktNMXlXaVlabEcvcGp2VTVPRHVzLzZpcTRtSXpkdmFqWTZTWEo3?=
 =?utf-8?B?bWlBeDZ6ZmRUZnJ3ZzRJUm1LY3N4ZTl2K25iQnk2T0x1NCtvSFVxTkpSOXMx?=
 =?utf-8?B?Mm1YMzF2aEtxSUZuV2xsRGJBWXpwSC9qZ3kzbUptdlVuQkVxUHdYS0FBQjVC?=
 =?utf-8?B?akNlaWFIUWpiUnRTd2NPQ0xySHFQS0l4eHVZWlZaS2xJSE9Kb3g4aHpuQVBv?=
 =?utf-8?Q?hTL43mkn5MBm8D7dAWQln1APn?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	IlUaL2AAH733bt3Avcn0h6SB7nxRnEVyIsDUmt7r/U6Lhbpt3AS762OYxw4ipdquqaJP4c1RMBpZU6mKL3zc1rPncvQVand8sXvjnLHNioR/rPX9ZoppZAiyZyNk61CvX73uqXj9zqX63qP3MZUYhjIMY/ZRPeqP9Cxshshxbd8BizfngTpaJW/cP9kuXlx335CqgEw461rk+q0/8Sc8BzJLOECcafyZHZxMVSeR6LNAs4+53/V6XVQfJPgM+t1wa1Lkg+BadhxVrkK6LKFZZ717wWyfYTw0D2oTvxYZvNC/1pJS0dqAOsvompeXxT7TL79Roe1EfEtLV8eWLucR+PgShXBHUSJ9ae0lSR5YbkXAW1HS8CdUrZI6Jrf1mg8qLrMtvaMjOa7RhvmGWsL/Lc5hPe2fz6WTpWI2EgQ3BQPw6/mcaym/S+akP5DhkHJTg1q3LRe5mJfRqMX197KS1eGWZg2Oopbho9rCWG0BCk3EHp9DfKxUWExlfFgzLNQC9l/oovRJaYsWQvVr+zEImCi5dY6EbrZg3o1M6UoByCONdXpwUECgMQ4nB1VmByHr5uX/1nwhR8YCtYuZrpmNip8m2yoiJ7zoHaOVt3Cz4IM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d09bde67-c90f-4b83-6d73-08dc3ea42153
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 12:43:03.6302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 79H7r1t+qajILkBgWTLmH3CqElF/QRi+/xeU32Dupy/0yePS8BRBHH/BZEIaKlYOtEkNEcS7YKePQ44vBZKhyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5995
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403070087
X-Proofpoint-GUID: F7K6I1vSzNd7SLnXbgCZ0MqhSJcboqxz
X-Proofpoint-ORIG-GUID: F7K6I1vSzNd7SLnXbgCZ0MqhSJcboqxz


>>   #define XFS_SB_FEAT_RO_COMPAT_ALL \
>>   		(XFS_SB_FEAT_RO_COMPAT_FINOBT | \
>>   		 XFS_SB_FEAT_RO_COMPAT_RMAPBT | \
>>   		 XFS_SB_FEAT_RO_COMPAT_REFLINK| \
>> -		 XFS_SB_FEAT_RO_COMPAT_INOBTCNT | \
>> -		 XFS_SB_FEAT_RO_COMPAT_FORCEALIGN)
>> +		 XFS_SB_FEAT_RO_COMPAT_INOBTCNT| \
>> +		 XFS_SB_FEAT_RO_COMPAT_FORCEALIGN| \
> 
> Please leave a spave between the feature name and the '| \'.
> 

ok

>> +		 XFS_SB_FEAT_RO_COMPAT_ATOMICWRITES)
>> +

...

>>   }
>>   
>> +static inline bool xfs_inode_atomicwrites(struct xfs_inode *ip)
>> +{
>> +	return ip->i_diflags2 & XFS_DIFLAG2_ATOMICWRITES;
>> +}
> 
> I'd really like this to be more readable:
> xfs_inode_has_atomic_writes().
> 
> Same for the force align check, now that I notice it:
> xfs_inode_has_force_align().

ok, will change

> 
>> +
>>   /*
>>    * Return the buftarg used for data allocations on a given inode.
>>    */
>> diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
>> index 867d8d51a3d0..f118a1ae39b5 100644
>> --- a/fs/xfs/xfs_ioctl.c
>> +++ b/fs/xfs/xfs_ioctl.c
>> @@ -1112,6 +1112,8 @@ xfs_flags2diflags2(
>>   		di_flags2 |= XFS_DIFLAG2_COWEXTSIZE;
>>   	if (xflags & FS_XFLAG_FORCEALIGN)
>>   		di_flags2 |= XFS_DIFLAG2_FORCEALIGN;
>> +	if (xflags & FS_XFLAG_ATOMICWRITES)
>> +		di_flags2 |= XFS_DIFLAG2_ATOMICWRITES;
>>   
>>   	return di_flags2;
>>   }
>> @@ -1124,10 +1126,12 @@ xfs_ioctl_setattr_xflags(
>>   {
>>   	struct xfs_mount	*mp = ip->i_mount;
>>   	bool			rtflag = (fa->fsx_xflags & FS_XFLAG_REALTIME);
>> +	bool			atomic_writes = fa->fsx_xflags & FS_XFLAG_ATOMICWRITES;
>>   	uint64_t		i_flags2;
>>   
>> -	if (rtflag != XFS_IS_REALTIME_INODE(ip)) {
>> -		/* Can't change realtime flag if any extents are allocated. */
>> +	/* Can't change RT or atomic flags if any extents are allocated. */
>> +	if (rtflag != XFS_IS_REALTIME_INODE(ip) ||
>> +	    atomic_writes != xfs_inode_atomicwrites(ip)) {
>>   		if (ip->i_df.if_nextents || ip->i_delayed_blks)
>>   			return -EINVAL;
>>   	}
>> @@ -1164,6 +1168,13 @@ xfs_ioctl_setattr_xflags(
>>   			return -EINVAL;
>>   	}
>>   
>> +	if (atomic_writes) {
>> +		if (!xfs_has_atomicwrites(mp))
>> +			return -EINVAL;
> 
> That looks wrong - if we are trying to turn on atomic writes, then
> shouldn't this be returning an error if atomic writes are already
> configured?

I think that you are talking about a xfs_inode_atomicwrites() check.


> 
>> +		if (!(fa->fsx_xflags & FS_XFLAG_FORCEALIGN))
>> +			return -EINVAL;

> 
> Where's the check for xfs_has_atomicwrites(mp) here? 

please see above

> We can't allow
> this inode flag to be set if the superblock does not have the
> feature bit that says it's a known feature bit set.
> 
> Which reminds me: both the forcealign and the atomicwrite inode flag
> need explicit checking in the inode verifier. i.e. checking that if
> the inode flag bit is set, the relevant superblock feature bit is
> set.

We do have that in the xfs_has_atomicwrites() and xfs_has_forcealign() 
checks - is that ok?

> 
> ....
>> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
>> index 74dcafddf6a9..efe4b4234b2e 100644
>> --- a/fs/xfs/xfs_super.c
>> +++ b/fs/xfs/xfs_super.c
>> @@ -1712,6 +1712,10 @@ xfs_fs_fill_super(
>>   		xfs_warn(mp,
>>   "EXPERIMENTAL forced data extent alignment feature in use. Use at your own risk!");
>>   
>> +	if (xfs_has_atomicwrites(mp))
>> +		xfs_warn(mp,
>> +"EXPERIMENTAL atomicwrites feature in use. Use at your own risk!");
> 
> "EXPERIMENTAL atomic write IO feature is in use. Use at your own risk!");
> 

ok

Thanks,
John


