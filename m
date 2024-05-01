Return-Path: <linux-fsdevel+bounces-18425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FD58B892C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 13:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B17EE1F21997
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 11:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890F36518F;
	Wed,  1 May 2024 11:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Jt6CWzrJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CyPlnxbg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B808155E6A;
	Wed,  1 May 2024 11:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714562715; cv=fail; b=Rb3x0GdByJIY5TpSCSPXy9Hy2CBjs0tjvGuXO5hZ1k2St7YA4e2RHn7sobLmYGT13GIG1cTLvHhAhfGDKCIFvgvXtL9/D91O/7X23BtJsCN4WoiihVGoYHkRQPO3jfappP6kLlN/kNY43izRlUn/afxJCLqz6R4xpmAJRhzrW90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714562715; c=relaxed/simple;
	bh=yxqeWTxfjn0ibDyXO0LsdaDR+naRtIknStMHbS6wvZQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Fk0Hkri6bsUmqfYHAia4MbJzyiaGOSYEC8Pt8+A8GbhkmWRLayXP3o0Quj226pNjvte8eD/1WbAh0oGzr7gXS7qSTmCIuWpZ0f9bMHcadBmnPZh9IC5yn+fz7DrSzUt86h4vXZ0vyFAeJIQnhX4QopzA0aiGv14hbkjYzP/CgQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Jt6CWzrJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CyPlnxbg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 441ASNTA022925;
	Wed, 1 May 2024 11:24:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=gqew4hNhpYqCwfC0ibyPkqzdFJFh/K+Ex3sXqQ/1oss=;
 b=Jt6CWzrJ3JvBRH7c7H/ZyJIr90a5Gk5sJanxFC158GVSWVnCxEa/MrbedyOPcQdD2dvu
 ggWVn9nt5FC/CAb2zxU2PQpV+SlgTd1pU5XaI/2AqbyPhJ8sZc6vDScjZAeBEN1OHGS7
 r6FvFgOgsx680Y+7MAcf5QUB+c1OBgkSoVeod9RO3MSxhCSWfUn0jOPVUL7AQCUeIfwW
 3TQFYjtQd0MYb8VOFu+cgJvvxNaFz/qVeaNA/gldwcJg9UqL2p0SUEsHFY8N1i6rUNTa
 lgFtJD6pS30Hv258cywct6yctn6cH+xTsdzD98AVizlQqaxSfH4LXdiopyM2fze7rrFn VA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrryv70k5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 May 2024 11:24:51 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 441ABJnm008552;
	Wed, 1 May 2024 11:24:50 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqt98m81-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 May 2024 11:24:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkt6gOwyr0JPxUP+evLGOayn9wj+CJvp2P+a9Z8vtEc3egdVW5JHWvlNrV/L/C6loN2IGl8oq/DOWDo8/BlXkH94FrKHs5bOIZR3Sd4KrDwT3QFi0QHBZcygXMhqlk1hbaokGGTTC8WSia4UyjKgnVGYKWXj3BC53zDxa1IPHVpNzK7wTvDsFcR0Ep+DdAjTVEj6RIg8Qr+AH8U+qOdD3BQJ2OHWm2vudOGQJ6mHOt8fU+6D0h5v5G7aLgn60mVl3AhkgeykiEt3Bah9w3M8t/mn1NYpxFCcLVzssteHXDCP8yGnkwt7scuwDn0csJE5h0DH0ciP6aOPzI58F8zGMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqew4hNhpYqCwfC0ibyPkqzdFJFh/K+Ex3sXqQ/1oss=;
 b=Gz7kGv2BqQelJySfpVDpz9CxeXp4W8XzLdsWp6PTmt9QmukKVRdmWYsJvXSUxooaS3TfneCBNgpycbSATBmc+JUgL3PF7BjH9rECPII2KnV0vDLSglW+wEUzYCHaNlmxa8+iFlOlVRMSh1kzhVdKAE1W4k3wfttVTfgWjcDRPWlJ9abOuaS5VbZ7lkPZ6naSXUrWPo3DXe1zs+5s4+L90auVHDlt19NFvoKIsbTlihClTFeXbFp9eiyQX12t08ZsKH9WAcbxUAS64+E9TrexxS4Sy8qKlnpcA2l8Bk8dhKP9FuDVSJgPuS9CgSzKk+Ln1UUPdIDzyVV3DKiMIXCFjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqew4hNhpYqCwfC0ibyPkqzdFJFh/K+Ex3sXqQ/1oss=;
 b=CyPlnxbghscBebEYMmCxukKy9RUG24YMiYXvXlN7xv5a+OzLf0ZTCQPGvMgg74dfl6fgOgUzgLizT8RtxMpvh8w9v+snMzxw8iN4NKMMOSSoNzYWLLMyFFNsnauyZww+18bYlL2vFenfunRxnRYS2ke6R6sH3GYR6wX74qTVo04=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ2PR10MB7618.namprd10.prod.outlook.com (2603:10b6:a03:548::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Wed, 1 May
 2024 11:24:45 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.7544.023; Wed, 1 May 2024
 11:24:45 +0000
Message-ID: <fd036daf-8a7b-4ae1-8a94-0998bc6adaa5@oracle.com>
Date: Wed, 1 May 2024 12:24:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 12/21] xfs: Only free full extents for forcealign
To: Dave Chinner <david@fromorbit.com>
Cc: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz, chandan.babu@oracle.com, willy@infradead.org,
        axboe@kernel.dk, martin.petersen@oracle.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, mcgrof@kernel.org, p.raghav@samsung.com,
        linux-xfs@vger.kernel.org, catherine.hoang@oracle.com
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
 <20240429174746.2132161-13-john.g.garry@oracle.com>
 <ZjGSiOt21g5JCOhf@dread.disaster.area>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZjGSiOt21g5JCOhf@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0254.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::26) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ2PR10MB7618:EE_
X-MS-Office365-Filtering-Correlation-Id: c39232b4-da03-4c17-3bd4-08dc69d14d9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RDhFcFNCUmNuWmJTV2V4RFhOaElybTgwYldxOC9qdXdCV3QydmhGcVVRdVZz?=
 =?utf-8?B?bWRBSjJUM1R5VTlZVy9CT2dCTThjYnI3b25lTmE3Y214UXpRL3FkQnlWeDM4?=
 =?utf-8?B?c3RrU1V6U3Q4T2h5Y0RIeWVyL1owdXI1VXFrTGhIVUdWUENzL0c3dUV2NXNU?=
 =?utf-8?B?RXdJSDRhQnoxL2NPWUtHNnBCd2J6OGhJRzYwampBS2VtaU14Qno4eU13Rndt?=
 =?utf-8?B?dklNU3B1WkZjRTJzWitJV09RcHhIUGZGTVQyRFgzVFVqWk0xdERBTUo4Qzgz?=
 =?utf-8?B?Rm5DSm5DVGFYaTBoSTlyOE1ITGxUZ2lRZDViNEd0bndSZVhyeXpubU1rTFd3?=
 =?utf-8?B?aVQ0aHpSc25iNkhRNkRnQ1RjZ3ZYakQvZGVXYmUwSHpvb3BVVFVYc1hEWG9S?=
 =?utf-8?B?N0tMTHBPTUlXeG1MN3hDNEpGMGdPQktQbWNiV0FuVDU5UkE2cSs4UWlsWGdI?=
 =?utf-8?B?QmlXMkdSTTBtL3RBNzVNd21LSGhFK1BDYnFWOWR2NW5tRmppRzBkTEJxd3p6?=
 =?utf-8?B?VXJub2hSTDNGT0sraVg4L3ZqQnVLZlEzQkY4NnpCK25YQTA4MWNTOVdHMGJl?=
 =?utf-8?B?Qjh0TDRZMnJkUXJOV1dsSnNQWHZnWDA2WTltd29lNUh2dUFuVVZYcHFCY2hY?=
 =?utf-8?B?MjN6WFUrLzlNaisrWDArbkp6dy85VWJFNnRjS0s5UGxseExCTUdiak5zbTFh?=
 =?utf-8?B?QXIzYjVrKzJycnlqU2xoaHZCejJXWmFiRExDdktYL3dTbmtLV1Q5alZTWCtY?=
 =?utf-8?B?L1FRTzNhc01yTnpWUFdhL21DQ09uM2Qvb2tXS1NWakdlTzdqNmNITmIvdXc0?=
 =?utf-8?B?dmJ1L3Jmc0F2c1RpK3lkbnR6STZGRHN1ck5BOGtiS05ZTUtXNG9HNWNCR2xq?=
 =?utf-8?B?NlpnVy9wRFpMRWVXS0VUYWVVZWV1VXVBd1hIbHN6MEdjRDIyZXRaMWg1aHps?=
 =?utf-8?B?RFJvd2xnTHdwY1Q0STJTaldISjVGS0IzcW1iUTRzNEw2QThudzI5ejJVczBE?=
 =?utf-8?B?OHNabVZGMlJuWnNKL2ROcm1HNEhXZlIzOERJU0Z2QzdWSlpIZUpjLzExU01L?=
 =?utf-8?B?TEFGMmJYY2RpTzE4WHhSbmp4S29RR3NGN0d6Sm1sbkVod1hRdFAySWtWcGM1?=
 =?utf-8?B?MHpZdU9GSGR6QlFrY0twNEk4T29FTDlJZVBTOTBMVWxRejRaRjdDMVB1Z3U3?=
 =?utf-8?B?S2I1MkFIcCsxa243dnNKSmQ3YkZvdSs0eXFMMFJ5eVRDL2JBWCtHU1FGMlY3?=
 =?utf-8?B?ZGdIa1l5M2V6dFhwaDY0aEZMYnNMbnhvUmJEUXdUcXoreUxxRE1VZU1IQWdP?=
 =?utf-8?B?RVZvTng5K0ZHbHFMMitBbDhxUFhpS0I2NjVTTmcrakIwdVN6S1dwMFJDemhB?=
 =?utf-8?B?SThvNlo4RGZiMHJ1Sk12dHZIZXh6RzNNUXNqQ2FmOUp2OFJuekZiSkQrOUdw?=
 =?utf-8?B?akxhSTdwcWVPZWRUT3FidEs2MDZGNmx4dFZFV0lvNFFJQ0ZhWWxSWnlpVnJ4?=
 =?utf-8?B?VkRkcEJVb2l0RVpsVkFRQUJBcXBENzVGMDROVnVrOGMvU1JEK3ZDV0xSdFU5?=
 =?utf-8?B?M1hnZXFiVS9JZDFCci85VEtNa3cxRkpGeVloRzhndU1pTEFFREFXcWY3Z2pz?=
 =?utf-8?B?Zm5WOWhKR3FzRmVpN1pwOXlQaktCL3lta1JvVnVzMVFJc09DQ1cvOWtXYmpW?=
 =?utf-8?B?cWVuS0JMT0F0WWhLU2lpbXU5Z0pTYXZiMTBlQmhNbGM5dkdWb1BaTHRBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dURxdXA1dWdjVEZZSGptRjhWcElrZ3NLMy91bis4Rm04WkRSRmM1ZnRYck5I?=
 =?utf-8?B?TnlpdEw3MlM4SEpCV2xWdjR4STNmRzN2QjdSYUh1TGM4UnRvemtMa3hqQlBK?=
 =?utf-8?B?OGlJaDlIdktka3lIWU9KYno3NmpNS2xURk4vSThiTmp3eEtFY3UrUVhDMEFr?=
 =?utf-8?B?dk1LSnAyQlNVTnhuRFNDdkJVeUtvRXJEYTVYMnRjVXVqcUp0dmY0dzFvVjdH?=
 =?utf-8?B?S3A5azBJT2RZcXBIOEcycFNFamNhTzBWb28zUnE5aWFjZzRla0JJd3pNSk5M?=
 =?utf-8?B?N3NNSnFuWHpXSmRiZ1ZtcVczUUs1ZXZzUTg4NWNZeDl6N0JJTGZDS3RVWnlU?=
 =?utf-8?B?Q1Z4cTRZZjJUL05xUTJMTFowSDZ4WjF3eUo1VURsMFJuUU5uelZxcUVqVzFO?=
 =?utf-8?B?dXhacDhNaUVQeDl5enZkY2pnejVxaHpKbVBhdSs3dk40ZHFKRUJRYmNHb3Zn?=
 =?utf-8?B?VkhzZXZzRm9mbXpvMURzVXFyb2YzcWxXdEs3c3hEcjNaUWFrZW5FaEpFQUZ4?=
 =?utf-8?B?U3Q3TVVhamwrMGFEMml3bjZ6TldiT0ZUQWZqVEU3V2FPbUwxRGFyYlRxZHBV?=
 =?utf-8?B?bVJab01VZ3U1dytqWXk4TjRMeEVLTUhqYW5BT09Kd2NTenczMUFEWVpGMTJj?=
 =?utf-8?B?clIyMzcxSkZKd3hsbjgvc3piV1Z3blBEVyt0em4vV2FFZGJJMXhBQWtYQXJK?=
 =?utf-8?B?Mjk1OHJhREVSUE9YbmR4S0E2N2ZMTDZvTnVZT0NjQ0MrUGI1TVk5WnhSL210?=
 =?utf-8?B?U1JkenVnZFE4ZkN1L1lzL0d1NitucjBXNmxML0FpcVN6NjBRNm9GNHFDZ3Rt?=
 =?utf-8?B?L2Q2b2JCZ0hmV1cwcEFLNS9uR2syMU1UWi9tRk9mYVFnUnhtUjV2emk0VzlV?=
 =?utf-8?B?WXFEV0E2bEF1OUcwQjBaQndYOTBGZkVuUjZrYnhCMlpnMHVaY3pBbEllNjhy?=
 =?utf-8?B?ZlppU2tRUEdSKzhzdE5ma1QySkhtSHZ6dnVGZndqNU1QWWs4bDVxMjV4TWdE?=
 =?utf-8?B?QzRyZXh6bC9JZXFHMXVJbm9EVGZKbGEydWkwaHBPZ0ZtVGNqZjhiUHA4QWdW?=
 =?utf-8?B?WjFLTUowNnZpZk8xV0oxWWhnRmdFemZuaXBYaU1ZU3JMMGJzSVZjaHNUWFhG?=
 =?utf-8?B?ZEgrdGNaVTlNVFZiSzgrOHJWSCtkamFoYndVdXA2VU9maXNiNS9ZTWE4cWZ4?=
 =?utf-8?B?a1dzMEx2aWgvWkdYbTlBN2ZoNm13V09tZGlZYy9ha0lqTTVDL3dZME9nQlBh?=
 =?utf-8?B?bWxFMVFzTHI1WXp5ZzBGeElIcGFtQ3dGeXZSNFZOYnpXNHNtWThBR0wzUTlu?=
 =?utf-8?B?NzFCd1Z4Q0NQQTNPNkt2QkxVRTcwZjY4c1l1WGdTbjA3cktJS2FkbTllOFNw?=
 =?utf-8?B?UjlQMldheFpHRjB2ZCtXUVc1RDlVWWRPSWdFOEFOWDc5T1NqalhiNm1aOFRr?=
 =?utf-8?B?NUh3Y0RzZ0kzQm53Y1ozVzVuVDZIVEw5eXJ0NENLSHBkV2V1aXpEL0NQTi9q?=
 =?utf-8?B?Q25jd1Fna1dTdVBUTGdHOW90TE8xb3gvNmczd0NYQmgxRUExaFNTQ1Rlajkx?=
 =?utf-8?B?QUExVWY5eWlhb0cxMC9QdWdEb3E4ZWZKMjBPcnNOSWRrTldqZDA5ZXFaS2x6?=
 =?utf-8?B?Nnp6U2dJRFFRSkNEVVZDNkpXYVFZZWpaLytlMExyR0hZeG9EYmJtYmk1amlG?=
 =?utf-8?B?cm1oUWRUeXkyNWZJcGFkQVR3cDhUY2pRa0dQbjlvQXQyeEJvdWFPTTdRNGxx?=
 =?utf-8?B?dVRYeDVmcTJtMFFQN0Q2ak1PSXVqbGc3NzMwb0d4Y3NLZm5JZFdJV2c5V0dR?=
 =?utf-8?B?SjYySE5RalkwOFBtcm9ZMFVHUmdidnZzaGpISmN5OUJ1L2lUa3E3S1JLQ2wx?=
 =?utf-8?B?V1RNeTFrTlBOQUlxclI2MVY0TFhtNlUxZjdTWmd3YXJSUStWS25sT1ZsaEVJ?=
 =?utf-8?B?OW5Ya2I5dVQ0WWp2ODdJeUVyRmMxS1F6eGVLUCtLdXVCOHVyMmhocDBtWkMw?=
 =?utf-8?B?d0trelRMZFA3VlRzcjdzU0Jta3RMRHZFOFRyRnBjK25UaTlFR0duS3I1Skd4?=
 =?utf-8?B?WlhrYm81T2h6VlFxdk9ORVRPWXl2aTl0U3JIblEwQ1BpV1BQak9qdFBBUVBp?=
 =?utf-8?Q?OT9DFz2u0wwKsnQRkX8MeE6c0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	F9HDO+w1PVAT46Dl3ZEIlgo5pGeaKGvLTxct8E/xdYT2HMcVwwnvTiN2OiH1gk5q0pHBGsKsENGEgKKl1LJDrCB9/TPx9eJdqxuB0Sf8GXZKp9FEiTZtC5MmbOECNB1MDLfgsIGbol62NfI8+N9T0WgmIdjBWL15gkOawwZ6jx0QRTlBHVCh8MgaBe+m3DbTmR0KxnwA4gL5dI+TOKZgtPoDM9tYKYnll13qQYJouUKaAgL9ssAFYAin/TWWLTELkuA4L02+5iUIgwg5SE8Jxjhq1Gt3D0aUcAXfbYAtThPSkjwQ3CiD9VrkwsxP+wKgutqRJUvL/JlJ9NysXaFeWBvE6i8ZRKXvr19tlVi4qCGr5LhJBCvFt0fdVAMpLtiRGy13HDVhbFRcKGCsTt0vqyHbRZ8Upigh4sxSiiD1L70idJiNyX3O1fXLEfa/+RTmck5zuLp+VyKQX8WLMfBkdPs/u2xUSo/kMy5wLkkzcnqR3DI0YYgEesl0FhygI3Qm8MowUnG7bT5uNJzZxbymCRvLVQH6dKqnGHshniWqOxJxhx72oNe6CQ2knUlMadbKpVeHczgUVeZdyPwO6L1wG/HTKY93JA62EOtPelez+bY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c39232b4-da03-4c17-3bd4-08dc69d14d9b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 11:24:45.2800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qBfVx8hhAes+Bh/zLVKqfqMbmTn0Mzf5qSxx00e47f3thN1OaJ1aXKUcNMNeE9zEZRJ43rk9ByO9w+9Zpltw3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7618
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_11,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405010080
X-Proofpoint-GUID: x0dX-TmeNRNZ39YCnKp7DYMHIQCk4D_j
X-Proofpoint-ORIG-GUID: x0dX-TmeNRNZ39YCnKp7DYMHIQCk4D_j

On 01/05/2024 01:53, Dave Chinner wrote:
> On Mon, Apr 29, 2024 at 05:47:37PM +0000, John Garry wrote:
>> Like we already do for rtvol, only free full extents for forcealign in
>> xfs_free_file_space().
>>
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>>   fs/xfs/xfs_bmap_util.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
>> index f26d1570b9bd..1dd45dfb2811 100644
>> --- a/fs/xfs/xfs_bmap_util.c
>> +++ b/fs/xfs/xfs_bmap_util.c
>> @@ -847,8 +847,11 @@ xfs_free_file_space(
>>   	startoffset_fsb = XFS_B_TO_FSB(mp, offset);
>>   	endoffset_fsb = XFS_B_TO_FSBT(mp, offset + len);
>>   
>> -	/* We can only free complete realtime extents. */
>> -	if (XFS_IS_REALTIME_INODE(ip) && mp->m_sb.sb_rextsize > 1) {
>> +	/* Free only complete extents. */
>> +	if (xfs_inode_has_forcealign(ip) && ip->i_extsize > 1) {
>> +		startoffset_fsb = roundup_64(startoffset_fsb, ip->i_extsize);
>> +		endoffset_fsb = rounddown_64(endoffset_fsb, ip->i_extsize);
>> +	} else if (XFS_IS_REALTIME_INODE(ip) && mp->m_sb.sb_rextsize > 1) {
>>   		startoffset_fsb = xfs_rtb_roundup_rtx(mp, startoffset_fsb);
>>   		endoffset_fsb = xfs_rtb_rounddown_rtx(mp, endoffset_fsb);
>>   	}
> 
> When you look at xfs_rtb_roundup_rtx() you'll find it's just a one
> line wrapper around roundup_64().
> 
> So lets get rid of the obfuscation that the one line RT wrapper
> introduces, and it turns into this:
> 
> 	rounding = 1;
> 	if (xfs_inode_has_forcealign(ip)
> 		rounding = ip->i_extsize;
> 	else if (XFS_IS_REALTIME_INODE(ip))
> 		rounding = mp->m_sb.sb_rextsize;
> 
> 	if (rounding > 1) {
> 		startoffset_fsb = roundup_64(startoffset_fsb, rounding);
> 		endoffset_fsb = rounddown_64(endoffset_fsb, rounding);
> 	}

ok, and the same idea for xfs_can_free_eofblocks() with 
xfs_rtb_roundup_rtx(), right?

> 
> What this points out is that the prep steps for fallocate operations
> also need to handle both forced alignment and rtextsize rounding,
> and it does neither right now.  xfs_flush_unmap_range() is the main
> offender here, but xfs_prepare_shift() also needs fixing.

When you say fix, is this something to spin off separately for RT? This 
series is big enough already...

> 
> Hence:
> 
> static inline xfs_extlen_t
> xfs_extent_alignment(
> 	struct xfs_inode	*ip)
> {
> 	if (xfs_inode_has_forcealign(ip))
> 		return ip->i_extsize;
> 	if (XFS_IS_REALTIME_INODE(ip))
> 		return mp->m_sb.sb_rextsize;
> 	return 1;
> }
> 
> 
> In xfs_flush_unmap_range():
> 
> 	/*
> 	 * Make sure we extend the flush out to extent alignment
> 	 * boundaries so any extent range overlapping the start/end
> 	 * of the modification we are about to do is clean and idle.
> 	 */
> 	rounding = XFS_FSB_TO_B(mp, xfs_extent_alignment(ip));
> 	rounding = max(rounding, PAGE_SIZE);
> 	...
> 
> in xfs_free_file_space()
> 
> 	/*
> 	 * Round the range we are going to free inwards to extent
> 	 * alignment boundaries so we don't free blocks outside the
> 	 * range requested.
> 	 */
> 	rounding = xfs_extent_alignment(ip);
> 	if (rounding > 1 ) {
> 		startoffset_fsb = roundup_64(startoffset_fsb, rounding);
> 		endoffset_fsb = rounddown_64(endoffset_fsb, rounding);
> 	}
> 
> and in xfs_prepare_shift()
> 
> 	/*
> 	 * Shift operations must stabilize the start block offset boundary along
> 	 * with the full range of the operation. If we don't, a COW writeback
> 	 * completion could race with an insert, front merge with the start
> 	 * extent (after split) during the shift and corrupt the file. Start
> 	 * with the aligned block just prior to the start to stabilize the boundary.
> 	 */
> 	rounding = XFS_FSB_TO_B(mp, xfs_extent_alignment(ip));
> 	offset = round_down(offset, rounding);
> 	if (offset)
> 		offset -= rounding;
> 
> Also, I think that the changes I suggested earlier to
> xfs_is_falloc_aligned() could use this xfs_extent_alignment()
> helper...
> 
> Overall this makes the code a whole lot easier to read and it also
> allows forced alignment to work correctly on RT devices...
> 

ok, fine

Thanks,
John


