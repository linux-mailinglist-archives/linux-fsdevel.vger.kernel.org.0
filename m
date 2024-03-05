Return-Path: <linux-fsdevel+bounces-13616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDE4872058
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 14:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C31571C23B7E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 13:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736A085C6C;
	Tue,  5 Mar 2024 13:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZnCVR9c6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pV5me1o0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF6D5915D;
	Tue,  5 Mar 2024 13:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709645821; cv=fail; b=kQF++NBGTzVLnmWe6erCFYhjgzZ6LTBponVYNt0244k5kQrRZ4TV8ukl432VRajn7+qp9L7wykQ8KaNdzqNmJcr6iYqtoiCKuJdVqOKbFnucDhZUVAG5ZT6sviQ+Y4/DE+PKVYrQ6W67OXPzR2n3J4akn+R2APooFE5XWLi6fk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709645821; c=relaxed/simple;
	bh=CqoKPpzco8XO2MYA8N71m0Hze2RISTl//efZidlCHpc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T/E5IxvAv0tFX38CT2v+/LrZK1FpQdwkPGYioQlvQUvTgoOky5AbVUaGXyjYnthlwgxPQ1R7JdqP0UWuAm6PHK0n1zqYMBoUAfxuxbJD3xUuhy6avLKqNDGdDvTLqynyjk361jDN7+LoCzk0D0GWwAJrIyLPBT5Jq3B393BDEkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZnCVR9c6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pV5me1o0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 425DalJB024602;
	Tue, 5 Mar 2024 13:36:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=buQLU0fJ4PP+Gxlw5rFF6qMhqGeFsH/h5JW6q8Uh0h4=;
 b=ZnCVR9c6jYLGp6K8d4XLmxaipzYgXd7aErQL1Q/V4BHExKMoB6/qD+Kkj1A8jyuOMqWO
 mDCwl7+00qajyfufwBbv/slThKImy9FpuKngXth7jcBQpGmZX5JqjDim1YwH56RCcry6
 f5H0KMGRBER0Y3pLlE0gNbexZGvHRbZhCqWLv0KRZA4E7jakV6vPsfSj/H2IAtX7eirv
 eXEV4j8OJRMmVKbQx1e12+UXjHOie22exVandKip2L708kyJKxdd08acRXlJsabtXGWy
 JWw23NHqGmZ4Pm5HDuXn3NCp3Op1fYGpJwjCVV2Hq1GuDS22mZdgaqD05jVX7P2LCP+M ew== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wktheeayh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Mar 2024 13:36:46 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 425D1p8a027533;
	Tue, 5 Mar 2024 13:36:41 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktj82bn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Mar 2024 13:36:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ewOgLEKMO59OnVx+Vl9bqwovGi26AzbpSDwX9OHzsndK0BYlvtXtuLwIiMERxZYDloA7vzci+lBuhbMIYB+yrYGoB4dvOey8NbEt9hdM1WgPyc+jiAnYZ09L/CvEssqxjLdCTVe0KoFjz8/iwiSA0fF3JH/MpSEEdN27NOMkkQ2B/U3woTFNVjm3m5fRquAoTSJOGtIUvEwZkMcuLzsHztDTo5eVPIbiOtrIpICFOUKE5Gd52WfZm16uO9F1JVvKpkVB9UNRan1wOYqIUKiiX18cG7fJZpL/Xdw36BXmVbrJdHdt1efQD3zZGbr7h1DfF8vbbqV0hKrM5Qt02q3piw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=buQLU0fJ4PP+Gxlw5rFF6qMhqGeFsH/h5JW6q8Uh0h4=;
 b=CGp8Az6ECJjaaRNGjymY3Sj92lyvjZRslskF9Wojs8A+qEz/X4Y5ENR7Y1i5REv1FklM08Gg2azxp3gsNgXUJmbcSLIodW2dYnMu7PTZWm9wbttv9ItcfjXqIAQrs8T0w+N8thwO+LQuw1qw8jGNFTlEI5VCSg/Zl+1dLtNBJx7Q4GSe0JAYaU6fSHO4iKA6vaJ5Te7nP7wcxNxsCW/w7EbEXLEQs8Lqp6k1Pw2I5whBE2Sw3PUuTO1IrE0lcf0Ft19pSW7xP3SY8lxH0HWZXYAicbNMCEa1WWPo6n4kNqO3QQsc6QeEPIwBRS9uDhx3GjyYP2qz2rPD/ypuGq8kvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=buQLU0fJ4PP+Gxlw5rFF6qMhqGeFsH/h5JW6q8Uh0h4=;
 b=pV5me1o0F2GmHZxJXfE5cpTb3uQm3mX/CNA93QtngGzO9cQmK8moz36/iITA2JauOkZjqE29tQWXAOlzYlU+OXdn4sU2QwgJPCnhL8RpVF+gdiLHe2DXm6CVfSMmmXfz/RyURLgolL1nu0BA9rrXmiC6rRQTYOS6RGyehcLlEZY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB5847.namprd10.prod.outlook.com (2603:10b6:510:146::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Tue, 5 Mar
 2024 13:36:38 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff%4]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 13:36:38 +0000
Message-ID: <aed79bfc-e3f8-4445-84c6-98055b76ff8c@oracle.com>
Date: Tue, 5 Mar 2024 13:36:33 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/14] fs: xfs: Don't use low-space allocator for
 alignment > 1
To: Dave Chinner <david@fromorbit.com>
Cc: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz, chandan.babu@oracle.com, axboe@kernel.dk,
        martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, linux-block@vger.kernel.org
References: <20240304130428.13026-1-john.g.garry@oracle.com>
 <20240304130428.13026-3-john.g.garry@oracle.com>
 <ZeZIB0G3zjaq7dWK@dread.disaster.area>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZeZIB0G3zjaq7dWK@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0044.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::32) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB5847:EE_
X-MS-Office365-Filtering-Correlation-Id: edff7cac-de42-4562-3f71-08dc3d1948a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	YuDBQ0lh/qG8bieHWDFNZQJ+8uSlgVQrDxHNmEhG9XSqnCvJ+3Ohpush74w2GdILTsqq0J4OZ2VcM7RpE/m7uzcW1PEM/fag/eOtiBBIYJ38JuScBCr11SA46epBG3SfCct20MAvNdtqoRv2HFcJXG6IXrY4fAIcMQ5bb11XzSZJpYmp2ydSLdJ8iN6LYmbBQoT9Td47OWAf/Xy+0hio/UlotWPi8heSpbMuQZuVQHd7V6Y1yecmv4rAggpuSHbkIAylpT0b+TPSM+f8V8RBUWlVVfJxhcaFD3nb5KHXMMsZelAlLAXQLaW8fnqvLF8IROm2XCSTXOY1MwC1rAZ0/NefXgbO5vvLkmIzPObb8noVOAQ82fVleRd4nwppujiut3VC+cD7/Bc6OuwDFDRiB3Z+75msuhQt2wrn6dI1yAxqZnTqdnY7fgxi6Jpkv7OScJHW6oSeaGLTkZeOx+uro7Jzve620nz3baoExb5ngodzNWkFnVZ8LR9FzNScG/RTxmFqnRCR9Mtl81hbj/Cu9pXCM8nalUUq7FP87hAwBkyYSLxdcIGBJO9oktulWkxmlkfDFDPaox6jylVj+xOiZrerSL14CGZ9k6syWHa45mbVawcYwWdKZCL0a5rv1wpajxrCUNbjESdrCY82oQubVehexcFj6vac/6bctTP5G5k=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OHdKRW1JSmJDZDdLaDVOS3FFMjdSMStoakpQVnh4T1UvSE81Rk5lUW1YTHlz?=
 =?utf-8?B?SksvTnRubVBibWFENXBpbWorVVoxM251Q0hKTVBNRmpUaGFCQU5MWXo1c0Zn?=
 =?utf-8?B?eDVpYm1SS2I3SGhLOWUyaVEzdWgxVGhTeVQ4T1Y5dWU1bjlucExCT3p2UmIw?=
 =?utf-8?B?RHVaWlBBdHJveGtCaGZlcU5mV3lwZFJiNWtVYU1id3RzNDNFNjd6aUdpUEM0?=
 =?utf-8?B?TnRxWTV2cldJdm9lVEtwOFd3aFJVaFFXR3U5R3ZENTRNY2Z6bTlXa3haYUFy?=
 =?utf-8?B?Z0xTMmVLMzNPdjNncmJXK0RMaitCbFZ6MkplbXpaUFNvQmZqOHhMb24zSi9Z?=
 =?utf-8?B?cUhldi9MdUpFUStMZ1dYdlBlNUtuL3dzcGZjdHczYVRVK0U0RURDdjRFeEJK?=
 =?utf-8?B?WDh1b3RJRjhtTHNqMVJPdjd1VzV2dUt6bTEza3RwbWZLU2RZWmhFWmtsVTVZ?=
 =?utf-8?B?L2dZYkJOamJia05xaFlSSVJ4YUYwcWFFUHkwR3Z4TzFaTnQ1TGVyc0hkZGxp?=
 =?utf-8?B?TEpDL1JFOGlmM1JLUXdQUm1RN2UxamhNa2E0NzNvNzQ5QUlvQUp4Rnlsd2U3?=
 =?utf-8?B?blFxbFh1VlhMUG52WVc2MUNaM2RIWDcwV3BuYktCVDR3bWI5RlllOXJKVTJH?=
 =?utf-8?B?ais4alZTUmJOM1hSVmNKTnNVTWw4c01sU09TclhqMVozaW9MZXMvaDVGL0Va?=
 =?utf-8?B?Lys1amlkdytsb1dCOExLZHh5dmNIakV5Y1FUYWFkZzVWTWFkbzBWK0NqSU9y?=
 =?utf-8?B?L3FyVi9iWWw5UFlDQ1FKSEM3RmlDNTlrQnFKSFBkMlFidURSb2VqdThIWS9X?=
 =?utf-8?B?RUZWbkk2eTEwU2NyR0JlaGNJWWUzNFplN2JVUFpxWlNNQUEvRzF3bm1wQUZU?=
 =?utf-8?B?Sk1MQzYzZTNuWlNiZnVHdm9UQzh3NFpDUUtWNXRLSnZPcHYxMnVKeTZnNjEy?=
 =?utf-8?B?UjA5R2hOYWEwclFvRGJaZ3E4eU4wOFptMjhIZW9Ja1UrcHNFQVlkN0tkTjRk?=
 =?utf-8?B?R0dZMWJnQTNMZi95VDN2cFlDMlgzQ0N0Tzl2ZUs5NVVQU282U2NiZjQrTTkz?=
 =?utf-8?B?ZFlHblhBbUdzRlIwbUs2RDRLVG9TVHp1L1dIT2Z1Wm4vczNXK3dSWCtRTk1i?=
 =?utf-8?B?cXpVaVVGZzVVNUwvcGUwNjRZMGdFWWlIQkxTTy8wNEpIMkhRYm50REVkL3oz?=
 =?utf-8?B?czYzcW5hQkFSYWJ5d1I2aW40SWI5MEJmRWV6cWZpQkFoUGk4KytlcXVUVDcv?=
 =?utf-8?B?MU5OOUpWaStkNlljT1dSWEVvRFJSclF6QmdFTVdLUnBPeDZ0YXh4MUdLbC9v?=
 =?utf-8?B?TTNpbHZuSVhONnhadm9JVmlLL1Zra3dCai8wTmFrU3Vnb3ZzdTN2a1N6aEFi?=
 =?utf-8?B?WitrVzZ2bGVnQ0M2SGJ3cTJkVEZrV0daU1FqOE1rdFJxRy9sYlhwV091bmRL?=
 =?utf-8?B?RGQ0djVZWVMvWk5RelZWSFFwdGpVWFZia3FDUTRpc3E4TVFjVmx4SHJoUEFl?=
 =?utf-8?B?WHRJLzhYcFpDWEFjelhOaHBYT3NXWTZURTBzaFpPN0NEWG84ZTQ2WDRrSDlI?=
 =?utf-8?B?OWdLY1NiOU44eXhDNmFXQXgrRWpEZDhqTHdGT1dKKy9RNVpMYThlV1ZlcmVj?=
 =?utf-8?B?dXRuamJ0RWk2TVpybHBCRjd0UkpKU3krRmFUdGNIWGtJUURvUDMvbXZJSitz?=
 =?utf-8?B?TTBmbUhta2pXQ05ra1ZvTDVuRGdCbWZ0TXc2V1lFa1ZsdWhrek95bllKd1ps?=
 =?utf-8?B?T3hBcTh0aE01aFcyY3JKLzUwTkNyc2lHZFFRU0dRNWJibUpRY3BGWlV2em1z?=
 =?utf-8?B?aEtJTHo4cm9YWHpxd1A2QlVla25IR1M3ZmpSUG5OanhOOGI4K2p1d1BxbjZw?=
 =?utf-8?B?RjFpZysvcVJYc0svVFVMcy83SCtaTnZQdHhEOFFYbzJGSTNZQURGVHM1eVFU?=
 =?utf-8?B?cHNWV3FJbisrbEZqemtjcTkwa3dWWVVrTklOdVBTYnp0KzQ2cGU2aWlrTWxD?=
 =?utf-8?B?VHhmVEFueG9iRjF1anc3djg0VnplcFBEemZkUUs0MVR4YkNSejJieHJnYVN1?=
 =?utf-8?B?VjFlcVV4YjRuRUtxUVkzbXJMbmprYW9IUjRHZDVZRW5IOG1PR2h4bHUrbUFQ?=
 =?utf-8?B?K3BSTERqQy9zZEYwZ1ZQanRUY1FsdnluM2FQOUlxbFlhdW52Zm9CUVZNZkZ2?=
 =?utf-8?B?OVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	QnSVvuccjtRLUJnkAaHtNBcBUTZA2dWRlPPk6A5Nx4NCCv12HDzjBXBgFtSdcyiRAneJQEpRpkvtlQGx3RyEfm+9B31sbBWgYEVYfJI3uI83b49EOTaTKoc+dytrNt+g6ljMAxMMiFV/EzDE8M9KYU43fjac/ovwTEvs92r3bBBTQTLcOZ38lt/XSDh96UFZv92Hb3jBqc8HDfdZnwjRhMwA5xoH3PRa6HzMMHqE8FvFc3/XZ1S6tR+SHTLm+UDB6LZjUfgfsOvIn8pYFq4M3mm2NZGydfyGx1zvduWzVGzsHScXcCrkQF69ePTi5YaHXPula/9BDvVSeM7kvCKP4ywW5WeCGlK1NzeBu/1mCxznGZrJZTgAIjSnWr++7865Un5UKoGogwXl8QSA7SOU3lNExcFUKxozcRJCJRjMP5SxpDk8+KsKDAa6iOvzmBLff0WMM4F4x28h/hiYvxyW6n/8dcEGdkbpVvEk9DCbdiu+RvEjXhWNrtYb23Ay+FcHIbB1dmIp4utQuOtfYpm6/pMCw4kGRDVbII2dGY9c65JynEJ3Tx9jwAc+PdP3/W4bwVwRRaMYH5ZnrLNslhoYIMEtdOdNPNKFnfJrcL8SFS0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edff7cac-de42-4562-3f71-08dc3d1948a4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 13:36:38.3784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HVOdC16sofjB1MaSyxf5tpe9W56eCxuIgARGA9Iw5guQXPPdJ674cTn+wC40SolRJEn5ZuddMqtwBywFlAfHAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5847
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_11,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403050110
X-Proofpoint-ORIG-GUID: IxR_v3emWGqCdps_q8BZZTYIw8gtvxwG
X-Proofpoint-GUID: IxR_v3emWGqCdps_q8BZZTYIw8gtvxwG

On 04/03/2024 22:15, Dave Chinner wrote:
> On Mon, Mar 04, 2024 at 01:04:16PM +0000, John Garry wrote:
>> The low-space allocator doesn't honour the alignment requirement, so don't
>> attempt to even use it (when we have an alignment requirement).
>>
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>>   fs/xfs/libxfs/xfs_bmap.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
>> index f362345467fa..60d100134280 100644
>> --- a/fs/xfs/libxfs/xfs_bmap.c
>> +++ b/fs/xfs/libxfs/xfs_bmap.c
>> @@ -3584,6 +3584,10 @@ xfs_bmap_btalloc_low_space(
>>   {
>>   	int			error;
>>   
>> +	/* The allocator doesn't honour args->alignment */
>> +	if (args->alignment > 1)
>> +		return 0;
> 
> I think that's wrong.
> 
> The alignment argument here is purely a best effort consideration -
> we ignore it several different allocation situations, not just low
> space.

Sure, but I am simply addressing the low-space allocator here.

In this series I am /we are effectively trying to conflate 
args->alignment > 1 with forcealign. I thought that args->alignment was 
guaranteed to be honoured, with some caveats. For forcealign, we 
obviously require a guarantee.

> 
> e.g. xfs_bmap_btalloc_at_eof() will try exact block
> allocation regardless of whether an alignment parameter is set. 

For this specific issue, I think that we are ok, as:
- in xfs_bmap_compute_alignments(), stripe_align is aligned with 
args->alignment for forcealign
- xfs_bmap_btalloc_at_eof() has the optimisation to alloc according to 
stripe alignment

But obviously we should not be relying on optimisations.

Please also note that I have a modification later in this series to 
always have EOF aligned for forcealign.

> It
> will then fall back to stripe alignment if exact block fails.
> 
> If stripe aligned allocation fails, it will then set args->alignment
> = 1 and try a full filesystem allocation scan without alignment.
> 
> And if that fails, then we finally get to the low space allocator
> with args->alignment = 1 even though we might be trying to allocate
> an aligned extent for an atomic IO....
> 
> IOWs, I think this indicates deeper surgery is needed to ensure
> aligned allocations fail immediately and don't fall back to
> unaligned allocations and set XFS_TRANS_LOW_MODE...
> 

ok, I'll look at what you write about all of this in the later patch review.

Thanks,
John


