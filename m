Return-Path: <linux-fsdevel+bounces-2817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 884537EAA86
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 07:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B382DB20B53
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 06:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA9D11CAB;
	Tue, 14 Nov 2023 06:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TJfUYku8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="p2ic9Vla"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F695291F;
	Tue, 14 Nov 2023 06:32:35 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1373E19B;
	Mon, 13 Nov 2023 22:32:34 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AE5saLD029488;
	Tue, 14 Nov 2023 06:32:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=m2knfxD8I7TDoGR32GYsDh6hYMhnhXxRU9tsgTKWpcU=;
 b=TJfUYku8Pa53kaZxLol1YnVyq8CiRpoUxCg+GKD8Xqvtk6tZHWF1QWP33MzibncLNSES
 4u9EqcE1b4SmjsOC0avUMqzIxnXZw61FaU0quOYN8Ukezv9BpeZVgEene/iAskEAmqgv
 /fAAqJvf4jHLDhBdeyGp3IBj8qRBaoDsrIeOnksWDLf36SBwn7Ln/FjHi2Y8+xfl/feo
 j2oaGFj9Eou0Q9EX0wsORSp+zCE+XriJy7dvix0cC5aJtwzHY+HiRTzhE5y7J4raCiDo
 tMnnetZFnNdDLu2R51o8Qggf7fxL2pKBqkcoIwaESKKYBytWd1GbhMcgnwOqgi0jmR8C Sg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2m2cejt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Nov 2023 06:32:26 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AE5v80P014931;
	Tue, 14 Nov 2023 06:32:26 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxpvha9s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Nov 2023 06:32:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=icabnY5Dxzs9rnbY1saiu6KFs53WHziDUgJLBqV8X7w7mK62NLPPIkunPIb5Gu45J2hbNXWhG+tyiN+TTRmFGdQFmq05vV2Q/QKmXOWGb8rt0cFAF40IpKQNLDQpG5CKlNhRQq6CuIionaPYLFC3MOuM4ytLpDMjnm97nZ4XzeSYf/j1kfgThOTxnDNG+w0T4n0NPENzKt66k/qB1dWGGtaSEt9c7Hte5ik8DWwSGkG0FTSatOFBSn3WrivbDSkjnZOfoydOVB+7VtKO/oM5gLdgGOOUHBteNQCnHXbZjrweKIUlwiaIi+C+dq2Z8II6x8Nf2wkODcFTrp5cLQ1u/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2knfxD8I7TDoGR32GYsDh6hYMhnhXxRU9tsgTKWpcU=;
 b=PYvnuxUxCCgN6Qs4mFqyB2kVoxa1W0dNa2AzdCFUZ1HNsBPBIqllVZyXRfWgGL+vJO8qN6Z7BrIL57slyXSGFbAvndeL0p+FwFLTa/8XSAhu9Eub0Z4tEpBR9plxaz8Z2teCWHh3hNdzdANoqcYbLbuUPey8Z0DQt7HxOXirJsn+Nu8J7a5gNq3X7GBuG7gQ0oKo3RPw5gFzJzj1yk1Hz5SbN2bUV90CBZ8hE5YElLyGkoSyQqa5W3NnlfjUPYhSw2RmCajfnnrKAimaxtrqRS6GQ2lVCNADJc7EOgoGIPJAKYPg9ANAEWM97+q0laPhw4qRD+Go6jyM3OlDQOHXqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2knfxD8I7TDoGR32GYsDh6hYMhnhXxRU9tsgTKWpcU=;
 b=p2ic9VlaL8GDyaUsFdeMYWFaAYSGebqhoXC/zjxN+YA0n5T6c/vlfK7S64zRqDVMsnTBjZ8WTdERbVSwxm+cbo1ZoqlbTQzQE0EYAHYJgc5sK//qHBRGWq6lsV4AoMN921IrDSHPBXPDfdPsMipy55m5kfIOlkuV+wX1UfdUSZ0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB6076.namprd10.prod.outlook.com (2603:10b6:208:3ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 06:32:23 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::50e0:d39c:37b5:27c1]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::50e0:d39c:37b5:27c1%4]) with mapi id 15.20.6977.019; Tue, 14 Nov 2023
 06:32:23 +0000
Message-ID: <f6180d3c-0bbc-47e5-b098-6f1210c23be6@oracle.com>
Date: Tue, 14 Nov 2023 14:32:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/18] btrfs: split out the mount option validation
 code into its own helper
Content-Language: en-US
To: Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, linux-fsdevel@vger.kernel.org, brauner@kernel.org
References: <cover.1699470345.git.josef@toxicpanda.com>
 <f30ace3052a298c6536453fed66577c308c72d2f.1699470345.git.josef@toxicpanda.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <f30ace3052a298c6536453fed66577c308c72d2f.1699470345.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0198.apcprd04.prod.outlook.com
 (2603:1096:4:14::36) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB6076:EE_
X-MS-Office365-Filtering-Correlation-Id: ca5a6410-b161-4c16-3c3f-08dbe4db760b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	msmxqxGgHRq31mXh68HofQ0hJRvDfiCw1ppDjB8g78yaEdaqR82z6lUh9Oj8j9ySI4QN2D50TXRSvhgJo6UvMRBaHlU4nA1y9gtf2+NZc/tVj4UWfjAshyky7gCyJXqMpJOXRBGC5mj8GrmMn6cMMXqpAJbYkiV+HvX9HQ81ysN5VYTUISoUmxqL1xHmFro/M87NkJ8LEVweOZrkp295CZY8gwwyrfThZoL108UP0nyctUZPU+eyJDEZewGVSZWhNgRtLAB55f5AQirPUaVNay5+sayd2Br1E0Wj4qr51+4MawMWAOlKzYzmkIaTFGunsaoSKnCUbtTa/ln3Zt+U5F/2jyJtNk5/0bYa6nWqOO5PFtgjHQs8Gt+Ka/Dgk28D7rx5mMa+5eNi//GcCH0xIPvzuSvhyOcsUQ9GE5usrfHM/tF8RDRNKyCuVmOOtzIbQbhDsLsfsQ47NIy8hkgytd+s/cKNeSUbch/7BT5heH9JqjnxyYVe0LLEhMnhiK4lf5c9+keS2zClSnuftlls9CM0H/sKkvtut0+exh7cT6QGsDzGdOecIDtND0wguBjhB5vu9hewLp6IPONzxV9gJrvbV2z90enq2LkEyIN+Nnq9N+DApL3CPGs7ifRD0gnzMorAOp5wJFRZbD829H3vXg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(366004)(346002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(66476007)(66556008)(66946007)(316002)(478600001)(6486002)(6666004)(5660300002)(86362001)(31696002)(41300700001)(36756003)(2906002)(8936002)(8676002)(44832011)(2616005)(83380400001)(26005)(6506007)(6512007)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?T1MycXdjR0R4RWozQ2JldEFvQWZ3aU9PV3k5Y254Lyt2Qzh2ZWVXb0p3WHJZ?=
 =?utf-8?B?YW8zdElGVldqbXp0Y3ZOM1ZoM3VKOE1iMU0rWVhIZTI2K2NhbjRoaEhGdC8z?=
 =?utf-8?B?WmJZUHBDT0lVZTQxcDFIdnNXMU0wZmltdFQ1L0I5aWVJWllhWGRZaHp0OEJh?=
 =?utf-8?B?SlM3OURwRGNmS2drZzFDdVkzZXVFR1k0Q0J2YmNQTW1mb3FoZ1Y2YzNKODRN?=
 =?utf-8?B?cUk3ejNSQldVOTd2TGVDL1Z6cnBMMDYvSEg5NktGRVZjNG5oSkRUeGFJU1d0?=
 =?utf-8?B?Y083WDIzUjBPczNPNGdBZ2xrRHhFZHMwajVWc2RMRFUrcXdZNFJGckVKSGpY?=
 =?utf-8?B?ZXJ6UlNTQytHdWowdzk3TFhRWWhkVkJjTW5HRHExeHU0VHQ3TzdQOTlZK0Jl?=
 =?utf-8?B?QkZVSjl4SU9VM2V0cDBrcXpITk9MM0dNdVNqZnVGdkRHRVhJZ3BhTnVqMUZP?=
 =?utf-8?B?STdJK3c5NVhJTmxjUXRBWTZwTCs3QndQMkRSQzRoWkYzR25PZFlOQnFmZVdE?=
 =?utf-8?B?YzllOVRwZXJoUW9PUk5JLzdVT2ZreE1CVnc1NkZJVEdaZGQvQ0lyQmoxOEZ0?=
 =?utf-8?B?OHp1M095WVNjRGt2UjdrVHVXZzkvcVpnYlBCb2QyZnVmUXM3Uy9IVjFJL1ZG?=
 =?utf-8?B?Nk5YOWpoSTYzdzAyYW5DQk5FVTBXZkhWODU2TktFZGhnV2hteCtrMHRmaG0w?=
 =?utf-8?B?dzhtNzRjU2t0TG52MWd3L1pYK3VVUmxwZzNFZEdXTWhSZWt5UVpiaXFTWHBa?=
 =?utf-8?B?azdlN01QSERmMkF1aWRRZXo0OE05ZHRKN3VScGh2blRxZVB4ZFNvM3BTT21N?=
 =?utf-8?B?aTNJbmwwSGdrTXRDcXV2eS9NbWJ5WXJpOHdFeHg3ZVhubHRqa1RoZmRwSHJx?=
 =?utf-8?B?RDhienVSQlU1bmt4M01yeVN2bGw1NEF2UmtnYWhYUHJSMGI3Q0RNQnp6Mkk4?=
 =?utf-8?B?T0t6bE14elZVRGpKSVowOWVzK0pmUDBoKzZ3YmNSbmV0UkVsdHBHUkQ4eEV1?=
 =?utf-8?B?L3FwZy9nZXVJSExaaTQzb1NuV09RdVJTZXNsWjRjOGQ3QkE5RkdZWVRXMkhn?=
 =?utf-8?B?b1NudXFIQ3BBL0x2Wk5WNkMyR2ZzMExGSlpGSVJYalhvdU9JMXZwalg1cFRU?=
 =?utf-8?B?ZkE4MkJQTi9uS0tVbWsyTTFuZDlZb250YTBnOHpuTmdBZCtIaXZxTHg0QWZk?=
 =?utf-8?B?d0huWGFNUmVaUXVham10ckptVVdjZ3YvYVRIZXJuR0VaV3hGWkZaNThBVDZm?=
 =?utf-8?B?czQ2VDJ4ZElKOTZtOVArYWtYREpxYmZ4ZHZrWE45RzlUblhTZTBUbVNTVjJI?=
 =?utf-8?B?clJKaW12U0YzRVZlODJCdmRGOGprdEdrZkQ0c0J5cXFESFJnTlQ5YitLOXdZ?=
 =?utf-8?B?WkFKVVFSeHB1V2lHT2FPVW8zSzlaeC9Pb0txK296dlFnY2tSMGdDbTk4VWZm?=
 =?utf-8?B?QXhjM3dRYzQweEY5Y05JK0tubWIzemJpUGp1eVNSTEJVRzh5aXdYeCtUSUJZ?=
 =?utf-8?B?UVV1MzJsSzFWZGNGVTVMZUNidUZvOHhrK2l2RFR2eUJrSGYvL3daNWdPbTlW?=
 =?utf-8?B?SE5DOTZQZEJEQTBJUHlpTTBqcTNqdzFaK2dCVUxQK0ZDZDY5cEc1OVVRaG5I?=
 =?utf-8?B?NlY3Z1MxTjZpdnhvUFlldUhxTnFiaVVzcGJlUzhaZG9XUm9MQWhNTG0xSDNj?=
 =?utf-8?B?QkIrY3pPckNxaTZ6V0g5aEVFVTBzZXh4cU4wdGJnQTY4UEZxc2VTbXRjUWlS?=
 =?utf-8?B?RlhGcGkwaVVFTmkrTzJjUGFsVzFXamlqSXRrZlo4UlhjVFNHOHd3MTBpVGdS?=
 =?utf-8?B?YTVxVnB0d1JWazhkUVNQQmhLa0llL1NWejE3WFpHcXRaS2hIMkVCVHI4clJY?=
 =?utf-8?B?VVMybktVUk5vMEZleDNuRk5lbERDMVpXM3lQZ21wRHJ1VXFzWFlNa1l4ZHlY?=
 =?utf-8?B?eGo4cExNWmY4UjBEdFRRQncwQ2JrcktiTlZ1YllOOVZqUGdGaG1TZ0xEbS9B?=
 =?utf-8?B?RUdnY25mWFJXVVFTYlNiVm00NDI3YmlBdmRLVHhzQTI5bitqamNXSldkK0Nn?=
 =?utf-8?B?WVRZVy9WeC9zck5MMDFFVVJOTmNCaDFqYnliV0FxQWJIbDhDZHFrUnVWQjla?=
 =?utf-8?Q?E6n2BuQEzf3z+bUPPV4xjDSp3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	VLewwEfj2MLLbQMohNHMYgxunNU016YjYVxuf90NuJqIRWq2drubbm11w7A1Aud9lEMXpCCvU2JN3Bsr0J09KO43mkrI2RApbcog7qg8/3sJ0UEso46ffEQN8z7JUXGcSglEdEzMiZs+jC2ERpmoORFPNd6vzTyPb8ZMBk2EMg3VDF1FIf2gG5MBOrVtVzfUQpkpSBQDfgb75EyKqVxvWkpTl3cx7Q7mCzwEtTh1FsFIO4rCWsVMZDZWfO2+WLcFVdKCBvJcIdAn8KJ/g+mZ71rIP5UEOCACQ3pCg+bRXs6e4l5/pSa7PV7T1PJxskOs+Q1m7Az5/vL++TUtHnh9IOCEP7msP4Km7zsF/7rno/gJ6PyrpQmiJ19fLfSeW+kDj/g+nxadGdxrCJFDznkI7MBjNbg4Lbayi7OfPigwMBKgcN9bZGYPBQwML02/mIuZ4MIc5QdVPzFgCYHKz5Eoyeu4RljMUtcm26MsR7DfIEOhS8oOZi3QNoAzqu/ByFr37IALQxmtNUu6dASoAzwUHoZIjYmscQ9VDnp0CrEm4g932/0Bs5CUoNQYDR2TSo/l+P6eMmrTipupMNF8H2Gay+OTAiSxdXVUrEME16eqYJ4uiSWecPAv4Wor6bG0+vyMoKSfMBK709m6lxocgVHiBr/e3RhgQtCQyjqflnRxAHSVfFIA0zolTSFd71MXjcHtpcY5yGhTeA9p0FPK/m+mvlqnB5DgjnMLjGJR3qgbqhqVkyVWcMe7q3TcB7r0Bh1Igz+EE14NG3VCbO5LybTpmlxKq/XhRDUA1k9DQoDsLQ5e9XivWkmDWoNKXJyhuFVWYcgkKlaZ9C5HKOlL2/H6A0BbD8YbwzDwCZgT+RWiVXQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca5a6410-b161-4c16-3c3f-08dbe4db760b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 06:32:23.5681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NBuFQFsU3y5yQv/3OBkIjxu731sBiHjaW96cu0wZK7m4s81FCfofk13xB43q96jZO9rztoIpniyT+UiznODesw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6076
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_04,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311140048
X-Proofpoint-GUID: loXylmg4h-Bah0vNeoRwzTtimaqLkrII
X-Proofpoint-ORIG-GUID: loXylmg4h-Bah0vNeoRwzTtimaqLkrII


> +static bool check_options(struct btrfs_fs_info *info, unsigned long flags)
> +{
> +	if (!(flags & SB_RDONLY) &&
> +	    (check_ro_option(info, BTRFS_MOUNT_NOLOGREPLAY, "nologreplay") ||
> +	     check_ro_option(info, BTRFS_MOUNT_IGNOREBADROOTS, "ignorebadroots") ||
> +	     check_ro_option(info, BTRFS_MOUNT_IGNOREDATACSUMS, "ignoredatacsums")))
> +		return false;
> +
> +	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE) &&
> +	    !btrfs_test_opt(info, FREE_SPACE_TREE) &&
> +	    !btrfs_test_opt(info, CLEAR_CACHE)) {
> +		btrfs_err(info, "cannot disable free space tree");
> +		return false;
> +	}
> +	if (btrfs_fs_compat_ro(info, BLOCK_GROUP_TREE) &&
> +	     !btrfs_test_opt(info, FREE_SPACE_TREE)) {
> +		btrfs_err(info, "cannot disable free space tree with block-group-tree feature");
> +		return false;
> +	}
> +
> +	if (btrfs_check_mountopts_zoned(info))
> +		return false;
> +


<snip>

> -check:
> -	/* We're read-only, don't have to check. */
> -	if (new_flags & SB_RDONLY)
> -		goto out;
> -
> -	if (check_ro_option(info, BTRFS_MOUNT_NOLOGREPLAY, "nologreplay") ||
> -	    check_ro_option(info, BTRFS_MOUNT_IGNOREBADROOTS, "ignorebadroots") ||
> -	    check_ro_option(info, BTRFS_MOUNT_IGNOREDATACSUMS, "ignoredatacsums"))
> -		ret = -EINVAL;
>   out:
> -	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE) &&
> -	    !btrfs_test_opt(info, FREE_SPACE_TREE) &&
> -	    !btrfs_test_opt(info, CLEAR_CACHE)) {
> -		btrfs_err(info, "cannot disable free space tree");
> +	if (!ret && !check_options(info, new_flags))
>   		ret = -EINVAL;
> -	}
> -	if (btrfs_fs_compat_ro(info, BLOCK_GROUP_TREE) &&
> -	     !btrfs_test_opt(info, FREE_SPACE_TREE)) {
> -		btrfs_err(info, "cannot disable free space tree with block-group-tree feature");
> -		ret = -EINVAL;
> -	}
> -	if (!ret)
> -		ret = btrfs_check_mountopts_zoned(info);
> -	if (!ret && !remounting) {
> -		if (btrfs_test_opt(info, SPACE_CACHE))
> -			btrfs_info(info, "disk space caching is enabled");
> -		if (btrfs_test_opt(info, FREE_SPACE_TREE))
> -			btrfs_info(info, "using free space tree");
> -	}
>   	return ret;
>   }


Before this patch, we verified all the above checks simultaneously.
Now, for each error, we return without checking the rest.
As a result, if there are multiple failures in the above checks,
we report them sequentially. This is not a bug, but the optimization
we had earlier has been traded off for cleaner code.
IMO it is good to keep the optimization.

Thanks, Anand





