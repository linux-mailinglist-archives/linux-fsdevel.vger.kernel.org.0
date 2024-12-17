Return-Path: <linux-fsdevel+bounces-37617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D829F4603
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 09:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0E3C1626EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 08:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5703F1DB37F;
	Tue, 17 Dec 2024 08:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AWgKN8fV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QiU/gDdA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E461CF2A2;
	Tue, 17 Dec 2024 08:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734423828; cv=fail; b=TLXoc7amU/5jMWCms5S71gOC4YX+yS7H08CzeyD015OFU2KsdVZEAbY2hCOPqC/BsVNVKNzayh7ikTZjFeANxrAyDFDasYSL4XnST1K2vksC3u1UXd9p9NLCOBBmSizlQC5+flERv2689QzqACQOdlKaBSOHZLyPgijehrDrK68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734423828; c=relaxed/simple;
	bh=FT3j7F2RyA/cQho3d5OKtD1wBxKPJLup1LlqkxNM3JM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZXS+cYnvFUi2gSEX9/Apqn6MnXuNxd5HwoK3Q9BwrXakkaEX+iT6PHEVfViraGxO1veqF8Bj23gzEtPn3GFFYFy8vZCXUOgv11y53EfHqI+qzAa3CGXP4k7V9ccvCb7cSiS791uS0yXWbUykxEW+U5G1gvVHhpUkh+QKk8KsdGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AWgKN8fV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QiU/gDdA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BH1uJ4o014394;
	Tue, 17 Dec 2024 08:23:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=FtLqYTlvXnnQZekEJP0y18lh5JZI5j7F4aUXxwdFXrc=; b=
	AWgKN8fVbDa16Td+Oa/1Dy3xVHpTbJmGuLwbFYv6BunkOjUr67r2Rx5faMl4bdye
	i2cyDZwMEERTfPg47Nr/kR1FQc9K2pcxE9a72DHJ2aT5T/rfBAMMT8D6ykSufbxE
	+TKnsA3IDTkzCUU7DBQ9DtQBBJqf6ddXuiq95wWwwlDPehrvFL8ng0Wc5gWhBrfF
	8fuTXHW6C3DjGPBMweZVKh39vJyfLu0peBsNo56Yx7PuUEA2kPr+VH0RKF0P12v4
	AKhRv+/vDGNhYIHP+wVOpXmHHpoFb0On1BOxSQLGSsAC22oU/jUNUMlyJXeH6UH1
	oFKWcIqv6q5+xtEMPUE0ZQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h0m05n9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Dec 2024 08:23:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BH76CLM018341;
	Tue, 17 Dec 2024 08:23:31 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43h0f8ctwq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Dec 2024 08:23:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DYlQxOjWA+qwrl+jjGSSAoLEwIypguFKPuybf8zjvY7PW/MT8WDx6RnX/mOHWdD8b4ArphH18P+qhB89elAcJ1lxqb44yNCJwDlGya153FScQ3wlc/bCd4FUWjPyv8JTuZ1m92QxXFnZNLap4hN6L+iOV2qlsyLbPsdDpZPIs6saVAJ1/r3F5Pncaz0bwbGK83qW9dDEH+St4u7A5nKNCL1LM6nhCrwHV8NVkrXnZRjdrMImq4lNNG65k8VhQsRWmpoXpOa15NKHHURlm2hsLSKtH+hzMGUvyT651S4f555hMfx+9Y3fagAAvvDAN25GHY3QX4pLhoptkig+dC+lSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FtLqYTlvXnnQZekEJP0y18lh5JZI5j7F4aUXxwdFXrc=;
 b=KL4I1OOswsodvhDLyQcEBpmRFSgl+L/9jc/57i3CAh8gfthUZG9SUSUawFFaJdRWhetZ3TcN2sq/AtO5fiVPLEGDu7tT/hsTwSuutV3gfG8fa6Rx22C3nbQv3qlpaxt63L0lC+YMXhIaybRoT4Q/Be7Bge9q2udtozL7famIS5IxZZnDnd/PIbzeCNMuAIaV651R4t0rQ7yF4GcCBEDsb55/Pvl+9H/uKcprkZWQbt+RB1eiWCOmhY+3ENColxOffvi/wBNx/HvV3P1MrJ8dCSeXuYgUYfkAEyueL8U3MK+FYkYlgJ/NEdXa3yS9J5laKDF0KMtKAuBuEfwoqVhmJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FtLqYTlvXnnQZekEJP0y18lh5JZI5j7F4aUXxwdFXrc=;
 b=QiU/gDdACrUjNUV7OkHWhCo4oHmKiGK+X1yEC9cqmZzLzGC5AJ8/NRjygqtCNPe1MkSBvM9ztq4StDt9GzYZlOgbF7LusUZVynEIGB40MGh/dfSWVtJVBR6g2zupc1rWcq1cCY4YP4i23+c++UCID8UmBa6gL8BqarhYjr5stDY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ2PR10MB7653.namprd10.prod.outlook.com (2603:10b6:a03:542::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Tue, 17 Dec
 2024 08:23:28 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 08:23:28 +0000
Message-ID: <208f2e70-19b8-40a6-bd68-05c0798cb481@oracle.com>
Date: Tue, 17 Dec 2024 08:23:24 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] large atomic writes for xfs
To: Christoph Hellwig <hch@lst.de>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        ritesh.list@gmail.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.petersen@oracle.com
References: <20241210125737.786928-1-john.g.garry@oracle.com>
 <20241213143841.GC16111@lst.de>
 <51f5b96e-0a7e-4a88-9ba2-2d67c7477dfb@oracle.com>
 <20241213172243.GA30046@lst.de>
 <9e119d74-868e-4f60-9ed7-ed782d5433da@oracle.com>
 <20241217071104.GB19358@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241217071104.GB19358@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0143.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::19) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ2PR10MB7653:EE_
X-MS-Office365-Filtering-Correlation-Id: bc5c6ead-8be4-41a4-d2ff-08dd1e74158a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3NNbTJPNlI4MDRRWkV0bWxjZklvR0FwTkJVWWxuOEZFRlpWMWNKOERQWnVk?=
 =?utf-8?B?YmVrQW96ckZpNENyb092NVUrMFRIdkc3UHMxWTR0TXdOWEUzbGxqOUtZQlha?=
 =?utf-8?B?dWZKcDJGeE9PYkVYTkJjdEZqTC95ai9YUEF5RGJseHIzazIwK0ZUKzBHV1hj?=
 =?utf-8?B?bVMvWXBIQkQwQjQxTVpUT3pGRjNQT0x4TGVXNHQxUGRRcGhBZjRpM3dvSnV1?=
 =?utf-8?B?V09oQXUxU21mWGFrLzdXRHN4bWgyV001NzE4bGRRMmNvY0RueUN5TVowYUlp?=
 =?utf-8?B?UnphZTRRR1R1Ykh2RDRMQUVOVEZPemtGK2wwZnhDeTdGTnRlRFNKUnZXam9n?=
 =?utf-8?B?ZUt3RVVWVmFZUkRkTC9STWY2VVhOODVwUkk1SkIrR3lWQnNVRVJXbXNVSHd2?=
 =?utf-8?B?OC9EMTZXL1lBRm90OS92dE9ZSVptZnROL2dEZm03c3hDd29pd1B1SE9KVjI1?=
 =?utf-8?B?MEl5Y3pUM0dhSy9COGswS2hkeWNNUU5VOHBBd2V0VDZZMk1QN3RXeWFXcnpm?=
 =?utf-8?B?S1ptK3hTLzBBbFU2OGhTdVAzcW5vWnkrUmMwbkd3RXIzanF1N2JYalg1NjZM?=
 =?utf-8?B?WXhDUmF5U1BYbkQ2bW5hUUp0cXNYUjU5eTlPd3NQMlhZWFpTWmgxdVlPUU0r?=
 =?utf-8?B?OHNjRVdjclJpanJSWC9nYVpSdVJFZ1JYYmpyV3BiU0VkdXBTZGFYVmpNSDIy?=
 =?utf-8?B?YmRzUGFMNVJRdmphbzZrMElsTU1BdmY2Nm5ScmhaamV4MGRxQ1JJai9tR0N5?=
 =?utf-8?B?c3NaTi9jUmQveFE1UlB2R3hDNDV5c2RabUNXQStaZGcrY3BWM1oyNnJIMEF6?=
 =?utf-8?B?VFpTVExjVHN5RzN4STBHVmp2WmtrYndMU3I0TFQzRnlma3krMUlaQXpDNWZs?=
 =?utf-8?B?dU5mZGZFYUNlUFh1bXBKVmRtNWFZY21IaU5GdW4wSDVyTnh6cG9zQWxkbTk1?=
 =?utf-8?B?WnVGMTRKZGhlVG9YczYzREpTbFZtU00vU21TdEgzSmJWQ0IvTWN2U2pCNmRP?=
 =?utf-8?B?NHcwTCs3YnpaQUFMRmdML3RUMjBhRzcrN3JtbEtoYzlhQTRDU0xhcTdLcTJE?=
 =?utf-8?B?akNNWWVsb3BBT3dXbTA4anpXRWUvdzVHUUQySnJhQkp4MnIxam5jejY5eU5s?=
 =?utf-8?B?SForbEZ0RDVBbjhCQXZ5M3V0ZlJTUjVNbFhVQThuOE53ZlJnNG9DTit0SlVO?=
 =?utf-8?B?QWdjdVM0bW5xY055WGUyTGlXK1VMWTBqb0xiVU9MaHlCOXNBS1hyN1NoZWxE?=
 =?utf-8?B?aTJCOGZ4MTAzVGdNL1I3dS9nbk5uTm50eCtKb1E0MFIvWHlJcjFuVVgzaU96?=
 =?utf-8?B?c1M4NlZXbmJVVWY4UGQ2b3QvZmRhWFhDNHU2ZzNxTHpGUU95cUQ4U080ZHpG?=
 =?utf-8?B?cFRPc3BWS0ZadzJjV3pGNkRHcEh5Mnhhd0hYZlpleWpOVHBhc1ZtZ3dkSXdQ?=
 =?utf-8?B?bDVwK1hMQVgyUkZEaXUzS0x3Z2F1YURzSmVDV1ZYNXlhTmVwSDkwRkw5eUd4?=
 =?utf-8?B?YnEvMkJSOXNrb1NndXJ1U2hUYU5oS1ZoeWdlSDVKUkMwczYrZWNQUUpIMjNY?=
 =?utf-8?B?MWJybzNMbDRSaHhxWXFpYlZxK2xUZ21iN2JZSjdlTWdGVkJJNHlXWTNCQUdM?=
 =?utf-8?B?Z2F6bnozelZIWDdNWG9ROHlQTmR2NUZldklKZkd1dGQ0TEl0Zk5KZ1VSaHQ2?=
 =?utf-8?B?ZkJnd0hIWWJPSGpPTnJ5ZFFmbWFKWWhVbmQvTGMvS0UxdG4xUi8zTWdKQ0NT?=
 =?utf-8?B?QldGT1FuMmg5R2tLT0ZpbTVnUGVpOWdYVWNScWJWbVFCVHIvWE9ab2VsL1FB?=
 =?utf-8?B?bXJROXF1dUo5Yy9OVVFBMlRQNDB0Z2FMdWlUSkxtVDhJRUZudmZYZzlWSFp3?=
 =?utf-8?Q?xknuLLJyn7uAG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVk4b1JKb1JoSXVNOUppZGx4TVl1RjNpMmZuOVYwWFRja3pmRjlWQ01uT2Jq?=
 =?utf-8?B?Q3V1dG5DTVpwZVBGeDRGcmx6aTVEZERNemt4T0xxTVN2U2doOU0yOEFSTjhY?=
 =?utf-8?B?N2lrd3NHRmVacFlsa3ZuazdSZC9PQ09pT2IySk92R00xWmtzMzR5dWRqWm1B?=
 =?utf-8?B?MzBkaTZHY3NaTGJXUEQ2Vk5teC9aZlk2N1VibmQ5U3UycXRZTXFpRnVVM2NI?=
 =?utf-8?B?eHVpOWR5NVdHWjRyNFpabFVDS2F0Z0lRSXZLdjhwMXhlRnFBS3lPbk1XS2dO?=
 =?utf-8?B?TzRsVTFqQzRoL0N4MU9seU92SmhNVEl5MHR3T2crSEFvMjN4R1JlQzVTdXFG?=
 =?utf-8?B?YjZYVWhQS1p6MU9sUk4wcUxkWWEwV3oyMndWZ3ZaRmZOMUExbVVZb1hyMGg2?=
 =?utf-8?B?b3NwZFE2b05ER21ZM3QzQjZ3RTVqNkxBcjdpdWszM2lESWsxb2dYUlNMZ2xG?=
 =?utf-8?B?bVNwVjg0ZEJBdkxPT0FibCszcHFDNjZGYVFVVG9Ua21DN1IzYWxjM0FhN3F3?=
 =?utf-8?B?bUVKa1FjOHkyblJqc2VGc2tKeWgwSWg5QzEzbkRxdnBySnBsMTVaSkpCWjZN?=
 =?utf-8?B?cWlPMVVlQ01kL1J3UEljZzJzbThOSnM3U2VEclFQMFU1OEpsQVFOZldQTlpR?=
 =?utf-8?B?bzVMSmhOUzc4T3Y5ckQydlk3Q2tIcWU3NXcrZVpBb04wbFhMMHZRMGNVTnFY?=
 =?utf-8?B?c0hxd1Y4dFVDaEVzUlQ3dzREck5wVDJTeE9oZXdBZlAyVHgvV256OHZiUnAw?=
 =?utf-8?B?MUFUVkVjc2J4TGZXa3plTkk1cUdLdjhaU0JQSmRNZVBxRTRjTW5IYWh6T05Z?=
 =?utf-8?B?RFY4YzBxVXFkb2JDMVJxbmthaGkxUEJtSEQ3UGVFd2VLRkFTT2ovTFVYMVg1?=
 =?utf-8?B?aVZ6dnZYUDAvUTlJYUxSYTZKMlRPS0ZLNS9nMG4zT1hKU0FLQlZRbGRubEVJ?=
 =?utf-8?B?RldqU2R6RE53WTVoQlFMdkRQdE1lcnZuaXhhY1dPL0NNdkEweTNCS1lLRlZ3?=
 =?utf-8?B?Mm45MmFMdUNyamJyejVnVFZlbXp4c3hod2h3dHpHM0NaRmd3enkzVzBwSnRW?=
 =?utf-8?B?eWxLN1k2aFdqMmJtQlhOV1p6Tit0Znc2TW13ZWlFTkVZTHFXcFFvTTBvNGFK?=
 =?utf-8?B?N1RqTHNIem1yOUUvNzlSN3RObTZwQkFRSnEvbm9WWGJucC9kdTNsaGowTUti?=
 =?utf-8?B?M004bFpWcG1UUmlDb1N4aVJ3c3IyTStqQmppQUN0cWtvWlJtT3p1dDBoZHJm?=
 =?utf-8?B?RkFrQURhMUtWQ01wakQ2S1NFeDJqTk5SUkxGWlZUQVBlclRKcDc3N0xKQzh6?=
 =?utf-8?B?TUZtejA1UEhEeW55Y0RaQS9YMVJlZ1o0dlFONDZMN09lY1N1eDc0UXUzV3d5?=
 =?utf-8?B?TStzbEh0eHhNUW4xZXoybVMwV0VCaDY5MGV6TklLa1dtSzl6cXdzQUZCejRP?=
 =?utf-8?B?V1dJaTJockNtS29ZVFBlSktML21BSldHcHNJYkxuSUdYTTFrVWExSkVLeWhJ?=
 =?utf-8?B?eTBaNUNjVkh4L2lXdmxKYy8xSStNS2NsVXBENzJrcXRZU0NPU1YyZThQcHFP?=
 =?utf-8?B?cklCU3dmY3h1TER4TkNWbjN5eDVRRGRWRFNQeGxZdXJlaHQ4VVlEWFBxdllN?=
 =?utf-8?B?RGo4aGc0R1EzWXovV051ajZGWHVxYitIMVpJUjRrU1MybE14bUc2YmpuMDN5?=
 =?utf-8?B?NjdSaUJWaGNJWElLZGZRQjluYkNBM0VIRWdpVDFodFQrdXRZZzRNL2ZzL244?=
 =?utf-8?B?NXJBU3lGRElFdzJXNHljOTBTMy80ZWtIRWdUcHgxdXN5cUQwbHR3RHhLRW51?=
 =?utf-8?B?TUV0R09lUmhWQ0diMXByZmExVDhXNVovMXFLZUhJNDJsdjB1MzJ2RUtoSk92?=
 =?utf-8?B?ZnFLaU5tQ0pldWsyUHR1N2ZFc3R0d080UkN4WE5sZE90ZDUrOWJNSVRseUNW?=
 =?utf-8?B?M1Y2dWQwNlBSbklGVmZEbFFvQVlwczN4KzhOQzZmc25FbG9GMlVGVnpOcXJT?=
 =?utf-8?B?UkcvMHBDaXFYRnlkTDBYUUVyRmdMOGVDZExzdHE3TTFVaXBQUkF0cG5ieERl?=
 =?utf-8?B?WDFXak0rRGMwVDExTXhoNU11bEZ3SmxOME41TDVVbmdEWUpibzdML2xpa3Rm?=
 =?utf-8?B?cmZLT2tqa0tlQlAvUGVVclRZbmwvV25oNG8vUEtBb20vWmhhL0NKbm84bG1u?=
 =?utf-8?B?V3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	J0EleiL7CIjgPxE3wm/5CDcj/mKCzyhusqvZP8QXxpTcSYvzS8xyPlVV2Eim9hNlSUFQe5EKgiw2W5JkLy0QlM43yfugbI3OP/Sk2EAu8l/pir/8AoGbkIo2hGZCqtd1PVhWUKe+JiF1c/jpd4ot7fO7iv1M/DuhsbuPKnLW3BkCi251YwhwsSSNQMpEZrj8tQ6U2BCw3UJBIjdKUcmsxkkFvhIKBVqQR3fYDdSOsk2pq+I04B5MLHqOK1Mm2rZtLTcVgZ3fugiOk9Qc6jruDA3tfVOcDycigxJW8W0Ufipu0OklDb05X0vbCbwnl6isIrJeGkQiRdAHmyrDVtwDcyvfsHcEVdEngGIt8HpKEZvpA/ZUsN3lcOIQCtkY+wTkNKbDBLgCxkvh9vrDeVmy0ZRAFqT4UHXFxnO0LXC8/XbF3MlxpMOcZvdNkHyiLn4HW5nD4vihtTQ7WnZDpIF/KL4uwTBMUBp0TZpZhSEPYzO6AaBlCkRUCkW5GUE/MQwgMVO7AnFjnyKN1QS+nrLoGf7w7CRDQ15IYfIfpEJuNlC2gjnX3JKAXfSFcQ5xhfkS+9BZ+4X56oWQ+dSaojImpnlaXLK9h7KJfIowVoKgGNQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc5c6ead-8be4-41a4-d2ff-08dd1e74158a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 08:23:28.5020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p7UrR2k5E/vn8CgqbvPjQI436mklGUKEiOI2EVzGkEw5Z9qbCjBsMi4wIIGGpQiTQDTFGsUGxV57XK0+uMkdLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7653
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-17_04,2024-12-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412170068
X-Proofpoint-GUID: 2Jla19fA4Xl0joeTNSK_qQSatgCOJ09h
X-Proofpoint-ORIG-GUID: 2Jla19fA4Xl0joeTNSK_qQSatgCOJ09h

On 17/12/2024 07:11, Christoph Hellwig wrote:
> On Fri, Dec 13, 2024 at 05:43:09PM +0000, John Garry wrote:
>>> So if the redo log uses buffered I/O I can see how that would bloat writes.
>>> But then again using buffered I/O for a REDO log seems pretty silly
>>> to start with.
>>>
>>
>> Yeah, at the low end, it may make sense to do the 512B write via DIO. But
>> OTOH sync'ing many redo log FS blocks at once at the high end can be more
>> efficient.
>>
>>  From what I have heard, this was attempted before (using DIO) by some
>> vendor, but did not come to much.
> 
> I can't see how buffered I/O will be fast than an optimized direct I/O
> implementation.  Then again compared to very dumb dio code that doesn't
> replace the caching in the page I can easily see how dio would be
> much worse.  But given that people care about optimizing this workload
> enough to look into changes all over the kernel I/O stack I would
> expected that touching the code to write the redo log should not be
> out of the picture.

For sure, and I get the impression that - in general - optimising this 
redo log is something that effort is put into. I will admit that I don't 
know much about this redo log code, but I can go back with the feedback 
that redo log should be optimised for switching to the larger FS 
blocksize. But that may take a long time and be fruitless.

And even if something is done for this particular case, other scenarios 
are still going to want large atomics but keep the 4K FS block size.

Apart from all of that, I get it that you don't want to grow the big 
alloc code, but is this series really doing that? Or the smaller v1?

Thanks,
John


