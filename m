Return-Path: <linux-fsdevel+bounces-29447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52119979EA4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 11:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FB402814DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 09:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCAE14D439;
	Mon, 16 Sep 2024 09:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MpTzxp5Z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LslEI/91"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E6814B07A;
	Mon, 16 Sep 2024 09:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726479908; cv=fail; b=MQmXHKiR2Z7OHKGqMG7whLsnX6jAxNHRtxY0Cq7/2A0jitIVJmW/+isELw5IVIkLGhBDFX/SkF/PQojVnT3iBst2LWWxzifRl7D8AXaDBEkgyuMhJZ93wyylF/vyHsGCurWLC3BE7PP77Zhk6pfvVlzsgpo0tQqtHwOnISMu2AI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726479908; c=relaxed/simple;
	bh=cPlncL1MrOhBtV1sKACe5+Lt0P89QKWcCZG0n45h3hA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KOXFd6cgtCC1Zo/oA8W/oMqDKhYoJSm+mS7ZmM6dj76yHvKSkLg0oGpy0O8p6x9dSGleGaHe552ArYbyvUBqx0pqw2gRkRkn6H3Ta5/vBdzxTWxXIcNJX6PqBwyGoAStm9jkU/i/DoiAo2lq+kEkJ8LXn0ifPEZRKG+Hl3nmIFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MpTzxp5Z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LslEI/91; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48G7tajX007881;
	Mon, 16 Sep 2024 09:44:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=Fj+ji0SmZOTjXKMjMUzJ5QeEFTIAPPE/J+PYLG+F9GY=; b=
	MpTzxp5ZvxgraHT9dyQxeYaOpLKxS0/6qbj2m2lKoYhY2f61L9fb31R0dW5jt1x/
	JPWkF71U+9JChUFCBTj7Ao98gcH9xmwKbtcgHZUDKIjrkGaWqCIWsu1XoYOTD/Sd
	qmgFQ0BR/y+bYKZPw5Hsrb9lZqfZ4KNGfN1Yw4UnjcxxHA0IBCIJ+VJ/6kL/unyq
	sXrN3qGyMRb5v9KSkw8H6/+xQFXCT7Bm7eWfzNDnI2/P6yTARa35+DvlIrpyXCJ0
	w/W68zy1IyVzaj/vTowwFYzX2guD5eXFn5YyZsjcDxTKEecYu2qtnFXmwTm5fNVv
	XHwUaD00T2elS3XKEOIwgA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3nsavfn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Sep 2024 09:44:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48G89WkK015658;
	Mon, 16 Sep 2024 09:44:45 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41nyg1mtja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Sep 2024 09:44:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ysd1NbWlQJab6smhkpGX7fmydbzF9R5IhTmNhIWr4CE0kwV+rf+DkJbfoHDwcpIvyl9xYMIBFj4Bg9kJWT6v70nWsId6apvgBbi9arAEbZX1++6Qf9QoMlRwqU8Jeoxtr2qZT2qyeUNCXJootMSCDZDfCkAGlcHQHx69UAyEDNZUX7eh/RdNiQdoyCItDYLIcAoLiqOnZDyhVZOInu6EeeR304wUmjb6kZnL9am1ufEpPG9IfzeYBU0j+HUSaimkwoB7i7OP0vz+z0oWnVFUEy+IxKWFvFAHe3T8kyNNHAHDyTfCAVxeIyfggkQVO1t5ylU01qmCEITL15kANzomKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fj+ji0SmZOTjXKMjMUzJ5QeEFTIAPPE/J+PYLG+F9GY=;
 b=jSRvW8XiD2XjEGVJFOchuuQIKWgGb+Mv9vtnq9wwHqZ2IVoL/KFwzMz0BZLOjQF27Svj3djH4v6Hot7kMdznKp1qbJ2AQ1BW3/h8SNtrGUdqSWuh6uOgMvOUh0G4DTD4ejUS7k6opd7SbLRXhbjFol0K1xcnqKehc9wstX/kY6FDQ0pvGmbhtTu5c73QSCUKgR3fyBdXmpafjrcqlaasvvVlE+r3osTeLzqn0AVrs37PUUHasgrGWRWUelX0m7TwoX1xHrFXbd5lUpqfvSZ7VJkoFknGHTbrZmmK8vX0uTq9YxawvY8E1pf9hyJu0/FDbVadSyUiUerotgVw9ZQVGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fj+ji0SmZOTjXKMjMUzJ5QeEFTIAPPE/J+PYLG+F9GY=;
 b=LslEI/91UaiO2cEYyB53vmovugvyGu7ZD5Djb57riMdAb/cpLEsr3bZpCiv/DCEDv0Dhrn5ZZAJ4l8L9FwgqyICqJlQk/w5NHP4hu/4EjGah3ApeqcPmhyG0Wgf9ulyPztjPhSwHRcrKyPt3dc6GeJz/F64tWBDYQJOcy6M7wvA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BN0PR10MB5175.namprd10.prod.outlook.com (2603:10b6:408:115::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.15; Mon, 16 Sep
 2024 09:44:43 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%3]) with mapi id 15.20.7982.011; Mon, 16 Sep 2024
 09:44:43 +0000
Message-ID: <0e9dc6f8-df1b-48f3-a9e0-f5f5507d92c1@oracle.com>
Date: Mon, 16 Sep 2024 10:44:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/14] forcealign for xfs
To: Dave Chinner <david@fromorbit.com>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, chandan.babu@oracle.com,
        djwong@kernel.org, dchinner@redhat.com, hch@lst.de,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com
References: <20240813163638.3751939-1-john.g.garry@oracle.com>
 <87frqf2smy.fsf@gmail.com> <ZtjrUI+oqqABJL2j@dread.disaster.area>
 <79e22c54-04bd-4b89-b20c-3f80a9f84f6b@oracle.com>
 <Ztom6uI0L4uEmDjT@dread.disaster.area>
 <ce87e4fb-ab5f-4218-aeb8-dd60c48c67cb@oracle.com>
 <Zt4qCLL6gBQ1kOFj@dread.disaster.area>
 <84b68068-e159-4e28-bf06-767ea7858d79@oracle.com>
 <ZufBMioqpwjSFul+@dread.disaster.area>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZufBMioqpwjSFul+@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0278.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::26) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BN0PR10MB5175:EE_
X-MS-Office365-Filtering-Correlation-Id: 7af44906-7d7b-4f86-e9ac-08dcd63430fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QUhFNXFrbUlvdXU3c2lsWkV2U09YVGxQWHIxdEIzSFpGbVZBWEdLcnMxaTht?=
 =?utf-8?B?N2YzTnp3cjh0dGpTUS9CN291eVo2OTdXWkNxb1JMMVdnNEMrTVF3ZEJLVlhU?=
 =?utf-8?B?SnVSUnYvSC9iazZIZER6TldiaEdCRXROSmo5RDZCS2VvMVpQMDNvNlFpOUJK?=
 =?utf-8?B?MU1yNlI2Z0w5Szc2aUI5OUZYVW0weFk5cGE1aGlrdUZzRXBRb0JMN0hUVE1U?=
 =?utf-8?B?RHBHbno0SVNlUVhBRG82dW1BY0Vxb0lzdEQwSURaLzQ5TG9nMzZybmxvS3Fk?=
 =?utf-8?B?dENxUWxNdFRUOVcvazNsRzFRU0ZIMU5pbkVZZEE3aG8xcW0yb3J5WUJ4RkhT?=
 =?utf-8?B?eEdjdU5VRjRFUzUzekxkNVFzUWRXTHpmL0ExdFB6RytWdE9sM2JydnQzRlpw?=
 =?utf-8?B?U3ZYRHVINGJxczlWVVp0ZTlTZ0lHUTB6S3U3VThEK042NEsvVmMxQ2p4OVli?=
 =?utf-8?B?eWhESTlyY0YzMGVVTGI5ZHEzZEFQV0o4MkJ6RGVBLzlsbU1OeUFJdmpDS2Zl?=
 =?utf-8?B?M1dla2owYVExOXBGYVJ4dHdxMEx5dDRMaWxQMlppam4yZ0svcXZ5UDBmQ0hr?=
 =?utf-8?B?UGZ5MEhkSG1VZzZVWnlRcHVKQjIrTHkyRG1kWGc1NEJ2bFdzdjVJdm40VFlt?=
 =?utf-8?B?NHViNXpISGduV3VEZktFMWw5MXFRU3k0YU1ybnJtd1A4M2s3QnFCSDBXSVlD?=
 =?utf-8?B?ZmdUREd4TnJFdWd0RzhVbTJIRS9rV3lIRzM1NnV4Qjg3VGhhdmZRMFNZVUgr?=
 =?utf-8?B?Wm1sc3puM3E2SzRwQ0kxYk8zZ0x3STVjbk56MkpMN09FQkZneGQxYlJlYSs1?=
 =?utf-8?B?eHhwNWJ1R2FsVFNndHVMai9nZTNjTWZ0ZEZzTHI3VDNwejdhdmtIS25XSFFT?=
 =?utf-8?B?UlZ6NGZ5dGttSmhXcGhQc2d2S1pyNjE0TGNnOU1ZZ3V6TnpsVUNMN0dJeDI1?=
 =?utf-8?B?ekdyYjRYdFlWVjZ3RFpOQmVFOFIxOTFGZFp1MkdpVFFxMS9ZTTdaUjRRd0lN?=
 =?utf-8?B?OFYxN1lLUmVTVE90ekZtZE9GamlreXVTRVFvdFRTVy9LU3c2bDd3TUViOEJY?=
 =?utf-8?B?d0dadFdXTk5KYlVwMi83b2U0eDhCL3hKbDFXZkF6QlBjVDZDb28yWkZGaUpm?=
 =?utf-8?B?dFNSbzBmZWtCbERIVHNjN01zZ2MwNCtKd2JyajBNTUc3VDdocmlIemZveTlI?=
 =?utf-8?B?WG9LZmg1ajA3bU1YN0I0WktTcFJYRXJQTDA5YVEydGdlZTdIZzdJWk42anRa?=
 =?utf-8?B?bFRzK0h3b016WnV4NkdVWE8wRnRvZVMzL3dqWGtmZmo1OFhUMTVZNTFMempi?=
 =?utf-8?B?Zzc0SUJ1eWZJUlRYK1l5WGZCdTN6T2VZcVpyTG9XeHJWVDFHWi84aEFKbTRZ?=
 =?utf-8?B?alV5Z2lFNkFoUnNDa1NyMXVMWHBhT0JoQkZqamtOaU90Z242SzFBMzdBTnZ4?=
 =?utf-8?B?aDhuTDlCK1VCazRueklRVUVVWU9OQ04xc2JTWGRXaUpaZmQzc1pka0c2YnhN?=
 =?utf-8?B?VnJnSTZtdE81WmpyQ09SdjVQSFU2cDh6U0RaY2RpV0FSZFVNZkkwd1pxdDA0?=
 =?utf-8?B?em42N1VaWk5mZUxOMVZDME1DdEJiNEt3dkVSYlM2TDBtRWF2emxvOXJXWm9M?=
 =?utf-8?B?SjYvaVJUUkphRzIvS2RsdjVQTGgzejBIaDBEcTVvZUFxZUNQYktxd01uVlVp?=
 =?utf-8?B?VS9mZkR5M2ZKSjJ2ZUEva2ovM3lXeVMxS3pRWkI4eW1EdStyd1VaMEpBVzFv?=
 =?utf-8?B?L0UxTzlXRTBmbmhkQlU5N3d0T0lPTnlnOU1FejNkb0YvdERGRklVbG1EQlJQ?=
 =?utf-8?Q?Q1z88cJarJFRpImn1kB7u4/perZl+fLAH9GeE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlJBQWcwMFZjbkdSek9xNFZGdjJuZzBKK3pNQ29tU3NSeWQ5RWlkTytSb0t4?=
 =?utf-8?B?OTNHczIycnFtNENiaDI2SW1sYXkyYm5rS0dreGFucWZtRkJ1Rlc5eDVmOFc3?=
 =?utf-8?B?MUMyK1d0WXk4MkhtbWR6OGN6eXJsRlBqY1JQZDVOVnY1bko4bk1ld1V5TVJv?=
 =?utf-8?B?MExIdnZrUWp6UllubEYyOE1uRHpYSjFVTzU4UEdqbFBBaytYV3Y1cGwzRHBJ?=
 =?utf-8?B?TEVMWkxtSXRGTkt0WVBpeEFiUERXY2FTd2VJbXdMZm9pRS9EalAvUkp3azdH?=
 =?utf-8?B?NWFOTVM4THA1eFErclpMc0RDUWppMXRRd3EwWkhjTFgvNllCei9kc1psQW5u?=
 =?utf-8?B?M2plbzBTc3MwMHFqMVJBMXdvUjZjQ2tobk83aG5XRE9Wc0RXVUtBazYzWUdz?=
 =?utf-8?B?bGorZHNzRmRpNS8zbXlUcDhoaWF6cHU2MVE1NXVNS05CcC95RFZWNzRXQ3pu?=
 =?utf-8?B?RWZCM3Jya3NQcm9UM3BFWHl3SUNweWIySmZIa1lhRWhaNEthUWo1QnZCSW5I?=
 =?utf-8?B?T3E2QlhVd1k4b0Y0aE1vRXArNHNpcHhPRDRYWDBoWjUyS1Q2T1BTRHFiaG1T?=
 =?utf-8?B?QVB1dGVuNStkamRBb0hvdmo3UGROUXBnTXZEUXR6N3NyMU0rQVZqMmdFS2FV?=
 =?utf-8?B?c0o3cHVRV08vYm1jbDVNVmNqOXV2QlIvUDFPY3ZqSWdSalZiQTFWYUtxY05n?=
 =?utf-8?B?OEhqRDgyQ2hRNW9FNEU5SzRWSHNsaExwZHY1SFNpeXlpalI5MngxengydmY2?=
 =?utf-8?B?Ym5lYkFnK3R6diswR00rVC8vTVQ2M1RNUlNwdmNXQUFLNndMNlVOaUZRQSsw?=
 =?utf-8?B?c1YyZzJML21aWGM5TXMreUVScE5haHhCa3N0NDc3bWZPeWR4ZUNQUGpvOTFQ?=
 =?utf-8?B?ek1KWVRKRTRsbFFmZGVrQmZ5aFB5cFFTancvTEFpUTUrTHlTdnVRRFpWV3VJ?=
 =?utf-8?B?dG5zZS8veEx0SlkrY2pkMHdpNkxScXkzMDVqTVI2aWtKSE9Gdkp4bE9kUW9u?=
 =?utf-8?B?Tm14RG91NHdndm1UOUNBaGEwU1c4SVE4RWlOK2dIV0cxcldud0crZXpLNW9Y?=
 =?utf-8?B?d3BKZmMvN003aHgwaE5sSk5yMVlycmNTeFdMU3A1OHFoOGQ1bEU0QlVWQUhj?=
 =?utf-8?B?R0gvQXhmMWg0dStiNjBBNkduekRRSjFkRzhpUjE1Vk9Id2xsdmFHWE10elVQ?=
 =?utf-8?B?QkxmN3Ftc0E0bmt1QWpaWm55NW5CeVcrdkppeUJqWE8xQ0tUOC9ZNzFaNzFM?=
 =?utf-8?B?RnBORG5yMlF4TGcyb0dSTG5FL3U4RXd6ZXZ2TU8vamU3VkF4MzlrRDAxQlJG?=
 =?utf-8?B?alA3MjlBakxnZWpMelBJK1lySzJBWXRrU0dXMi9IREVLUjRnMU1qS3pnWUxt?=
 =?utf-8?B?eCtPczhzK3l6MTM5T1FLbFFGNzlrS21FV1pFWHl3dDd4VWhTeVJXNnBnbHI0?=
 =?utf-8?B?cGNtbkhaWGZBTHdhT0lkL3JXTXNCSjViZGhzbkgxVThFMC9ER3FldkZkVTF0?=
 =?utf-8?B?NG0yeTduazlCWFlYWDBsSXpMeHM2Q1FqdWdoK3RXSU9GVVUzZWtKRTZBdVZt?=
 =?utf-8?B?ZTByZnhTYjhFRmYrbUtrM29EbUw4NU5weElDaGtiTWVmY1dtYnhySkh5Yzh3?=
 =?utf-8?B?OUF5TlFlbUczS2Z6MU1CSWlvbmZqMWtCcXBscG5GUGM5bERDTGF0L3o3ZkhZ?=
 =?utf-8?B?eDVKVTBtTVkvQXZiNkF5a3NkOThtS3ExazdScnoyV2JqZnR1enhQN0c0RWg5?=
 =?utf-8?B?VFZwZGtEWFkxbXFsblU3Q3lJOWRhVWFNdUZkRlQ2UlJURVZpYzFzTHZlaDJN?=
 =?utf-8?B?Y3lsaEEzS1Nhbm9UL25POTlZdkRHM0o1RGRLWUpGcWhWalplMnJRSy9YUEFy?=
 =?utf-8?B?SEtmdmZ6eXFFb05MeTJseHkrTHJ4VitKTjdpWU9rVkhlWnFnY2xieDBEd0Uv?=
 =?utf-8?B?YTdTL3hML0ZGYUlUNGxoQ2lvVVp5SUJ5Q1oxR3NINk02aWdDbjdSMVZtbFls?=
 =?utf-8?B?N3l5WDU3clViZnVRYk9ObGhFem5oQk1sejlJK2JrTmdPczlURTlUTjhSZ2s2?=
 =?utf-8?B?djNScHJ1MG1LTUc2YzMyS0N3OUs4RytPWnFsdkZiWUJrUytkOHZkVmVtZHpj?=
 =?utf-8?Q?SL/Son3wD8/utDstCUTXmSA5w?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	v2SIJ7wanrvb1cev+KORjkkoFYHjs8WcOsysW9E6noXkXTbuooSpT014OT4jThkREBc/lwZeTBTkj7mEOzRLsAMS+9iblDvRtB6xcBxOGdVYbXN+blawPJv5nNmNrUFpyBj+X+KayjpLHm67r13Yyi2VCLy3pAwPyBsZprModDCclt1UKf0iCskXpesGqft/c7jxcaGhGXZR/G+6mp1oLRJoZwaFrSGSal1GnlmG/kAIoiT/ykwZHRxbzl37lR0hJQqe1VkqNTBqJYC0J3oKFaxysCdkQ9SnoBMPz5jUIYkxN5NauWXHNnG45iYdkSnoZzQZ77aP+bSC95bImTbRxlByGr0NLFgRokMoez8/CKzgju/G9kwT69zoMMIriTgmbdITGtF1amYOlIjh4pCWZTo0Gx5ezmUgvvmOC5Ea404WjHCF7ksrlc2/TjBmaLykdjL5+87JRgLGaIMM4QGlCq+OHqEprCu3J5y0psoP2JxJBRQNklLiU3eKU3VvnQyrHmzPQBW7iXqEfu2o0ghpYpD6vxb5xXrHxOEkW/FLEIDlleio3Z112jd++cicAcGgTTopQfmywqb3UTZfv+dA5UDXE/VrqHZZuFv+UeAr9Dg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7af44906-7d7b-4f86-e9ac-08dcd63430fb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 09:44:43.0490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QW6GIG4ZfOWWeiBqXrsbldwoZq7EXdwonu3ijk2mgva3hMrs3yGgb72sORrOOw3ECnDr/Wbp4/lKUDLITbOz4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5175
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-16_06,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409160061
X-Proofpoint-GUID: AqLsta_iZAgKUXIhUoH-JUACNARGVURL
X-Proofpoint-ORIG-GUID: AqLsta_iZAgKUXIhUoH-JUACNARGVURL


>> * I guess that you had not been following the recent discussion on this
>> topic in the latest xfs atomic writes series @ https://urldefense.com/v3/__https://lore.kernel.org/linux-xfs/20240817094800.776408-1-john.g.garry@oracle.com/__;!!ACWV5N9M2RV99hQ!JIzCbkyp3JuPyzBx1n80WAdog5rLxMRB65FYrs1sFf3ei-wOdqrU_DZBE5zwrJXhrj949HSE0TwOEV0ciu8$
>> and also mentioned earlier in
>> https://urldefense.com/v3/__https://lore.kernel.org/linux-xfs/20240726171358.GA27612@lst.de/__;!!ACWV5N9M2RV99hQ!JIzCbkyp3JuPyzBx1n80WAdog5rLxMRB65FYrs1sFf3ei-wOdqrU_DZBE5zwrJXhrj949HSE0TwOiiEnYSk$
>>
>> There I dropped the sub-alloc unit zeroing. The concept to iter for a single
>> bio seems sane, but as Darrick mentioned, we have issue of non-atomically
>> committing all the extent conversions.
> 
> Yes, I understand these problems exist.  My entire point is that the
> forced alignment implemention should never allow such unaligned
> extent patterns to be created in the first place. If we avoid
> creating such situations in the first place, then we never have to
> care about about unaligned unwritten extent conversion breaking
> atomic IO.

OK, but what about this situation with non-EOF unaligned extents:

# xfs_io -c "lsattr -v" mnt/file
[extsize, has-xattr, force-align] mnt/file
# xfs_io -c "extsize" mnt/file
[65536] mnt/file
#
# xfs_io  -d -c "pwrite 64k 64k" mnt/file
# xfs_io  -d -c "pwrite 8k 8k" mnt/file
# xfs_bmap -vvp  mnt/file
mnt/file:
EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL FLAGS
   0: [0..15]:         384..399          0 (384..399)          16 010000
   1: [16..31]:        400..415          0 (400..415)          16 000000
   2: [32..127]:       416..511          0 (416..511)          96 010000
   3: [128..255]:      256..383          0 (256..383)         128 000000
FLAG Values:
    0010000 Unwritten preallocated extent

Here we have unaligned extents wrt extsize.

The sub-alloc unit zeroing would solve that - is that what you would 
still advocate (to solve that issue)?

> 
> FWIW, I also understand things are different if we are doing 128kB
> atomic writes on 16kB force aligned files. However, in this
> situation we are treating the 128kB atomic IO as eight individual
> 16kB atomic IOs that are physically contiguous.

Yes, if 16kB force aligned, userspace can only issue 16KB atomic writes.

> Hence in this
> situation it doesn't matter if we have a mix of 16kB aligned
> written/unwritten/hole extents as each 16kB chunks is independent of
> the others.

Sure

> 
> What matters is that each indivudal 16kB chunk shows either the old
> data or the new data - we are not guaranteeing that the entire 128kB
> write is atomic. Hence in this situation we can both submit and
> process each 16kB shunk as independent IOs with independent IO
> compeltion transactions. All that matters is that we don't signal
> completion to userspace until all the IO is complete, and we already
> do that for fragmented DIO writes...
> 
>>> Again, this is different to the traditional RT file behaviour - it
>>> can use unwritten extents for sub-alloc-unit alignment unmaps
>>> because the RT device can align file offset to any physical offset,
>>> and issue unaligned sector sized IO without any restrictions. Forced
>>> alignment does not have this freedom, and when we extend forced
>>> alignment to RT files, it will not have the freedom to use
>>> unwritten extents for sub-alloc-unit unmapping, either.
>>>
>> So how do you think that we should actually implement
>> xfs_itruncate_extents_flags() properly for forcealign? Would it simply be
>> like:
>>
>> --- a/fs/xfs/xfs_inode.c
>> +++ b/fs/xfs/xfs_inode.c
>> @@ -1050,7 +1050,7 @@ xfs_itruncate_extents_flags(
>>                  WARN_ON_ONCE(first_unmap_block > XFS_MAX_FILEOFF);
>>                  return 0;
>>          }
>> +	if (xfs_inode_has_forcealign(ip))
>> +	       first_unmap_block = xfs_inode_roundup_alloc_unit(ip,
>> first_unmap_block);
>>          error = xfs_bunmapi_range(&tp, ip, flags, first_unmap_block,
> 
> Yes, it would be something like that, except it would have to be
> done before first_unmap_block is verified.
> 

ok, and are you still of the opinion that this does not apply to rtvol?

Thanks,
John



