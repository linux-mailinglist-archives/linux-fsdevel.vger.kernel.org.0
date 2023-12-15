Return-Path: <linux-fsdevel+bounces-6184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1003F8149C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 14:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB343285F72
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 13:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387013033A;
	Fri, 15 Dec 2023 13:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dgcU3H06";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pgySJ1gY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D3C3032F;
	Fri, 15 Dec 2023 13:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFDswvn027787;
	Fri, 15 Dec 2023 13:55:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=HOcllSFDm5uBn84BTbtPO2H/8kf+UUroRWy0vVY3hLA=;
 b=dgcU3H068h1oDt/XMxzB5wT1YfM6L4ueor/+yM58q+sS3QJDHbNB4Psp+GaWrEV1oIRN
 iekcnrd7VE5weNTfC6m6nE0lqPeIRSuCnJviB/akjMaaGAT/xhFIPgE+7uiGzqNy70RD
 mA2fuSP0XndToaeAyZf2VT8V5qSu25wZgN6qY7JmNadXNrFp4bnhubQlULpOQJNzqNJ2
 6/zvuZMQM3KIumdkSza0EMEoQB3T36ivWH+sa0dVilrUkEOrEgrVpbabHyJaxL+OZHuv
 sdtrh8Z+DhexzDXmTlOYjeGaYwh2oexVud+vIn1JdbCKQALgguMLFPYP9XBukub+T2ts EA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvf5cdejc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 13:55:32 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFD3uiQ013093;
	Fri, 15 Dec 2023 13:55:30 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvepj4ntt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 13:55:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfUcUSxIasI2e6ss0q7UINiU0QNHwzNj7NumnmPXr84s9OqzzWrzEC8JwG+/JsS4VewKKYgWotp7RuVum6DSNj7WlLXcuc7iyLdc/tWt7XaKxiwphl7Gp8q0TAbSu/yNkxqB4bAy7poNe8DQQSSDx9IDgmKV0eY3+UszYCBLfUQzjkEU0L+ujlVzV2tmNugMkrMZA2NSq9fKUPrRoKvae7gJZzDZakA3eFPTmL3HZKxcMFustQqDw82hiuvrqqwtSL/A0a/8nB/JFbyq13RF+UoUPS02OQiT7iQJzAdIhHu8woY/Z7PyYkfuOdTuc54tlubJiWeuldZ4Fw5jr14kWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HOcllSFDm5uBn84BTbtPO2H/8kf+UUroRWy0vVY3hLA=;
 b=JtM+C8vyR4PH/ZNm3+EPtPy8Mx1UmlZnGEPNse6oMPcZWo4/9x0Zou/zCHCj9Y02XTvnyOK0K+yaps2HcFLx3MKQjE4TiS4VgADj1xZxgF0rY2FkbaoGkysxpVe/QhfGbP0TySfN2BPtrIP8ew1iHrXrv5zPy2BqPyyZibXGV1lY9aXybGAMy+lGQ2ooOd00kX56u8ay//HjAtXL2X0guM//jYRlf7qmNXMboM5SZYC6k0szoMDu9ndNO2Q4h9RowLLYu86UJ8O4b34zj7Cs8InqM08Uaijy8gYEhRXN4mcyDou3HA8WyLglfa2fTnbXHLj+LDitSkgjNFp0XoJLcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HOcllSFDm5uBn84BTbtPO2H/8kf+UUroRWy0vVY3hLA=;
 b=pgySJ1gYF/MfWQtD3hyyf3QdZJh3291pyyij0ywJ7+EVy4J97TJfIRBPzuFRzp2ZiVa2ZA0fM/vMiwVXkTiznEDCF2k7roTU6O+C+UxI5+PGv1hwS6cSKeQcj16hRxiGInF/hktzkRCmRju3dstfvFrhgaOwg/vpSilqbfDGxt8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4455.namprd10.prod.outlook.com (2603:10b6:510:36::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 13:55:28 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7091.030; Fri, 15 Dec 2023
 13:55:28 +0000
Message-ID: <811039c5-8b46-4b99-9930-8494f5eaa2c4@oracle.com>
Date: Fri, 15 Dec 2023 13:55:22 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/16] block: Limit atomic write IO size according to
 atomic_write_max_sectors
To: Ming Lei <ming.lei@redhat.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jack@suse.cz, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
        bvanassche@acm.org
References: <20231212110844.19698-1-john.g.garry@oracle.com>
 <20231212110844.19698-9-john.g.garry@oracle.com> <ZXu5rykouOcNOSa1@fedora>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZXu5rykouOcNOSa1@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P189CA0018.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::23) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4455:EE_
X-MS-Office365-Filtering-Correlation-Id: 31c94e64-9b33-4da6-6493-08dbfd757eb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	UXtOnl7EqoquGc+LU+Zq8aKZjSbw+vPUMXhLrJSPNSWpY6gwZsd/0sqoYAHviWVOJubvRw7WSeqJCTUNTJZ3EwCS+/C3r8dPriXqMmqadCnN18lmFIdkTBWoF1Zj6aM2AbbxMLgTHlz6dzeiR3ZHZNHFNjtDJ5g/0kaozqvTJi4kM89cu8zwZkns7WMgoaOnohvG0Ut20Uu7gOj2IQxfuT0VBmM+JujEDv+YBRgZ4fr82JRGNRQ55ZCitJCS7Pa3RhaiHfhd3xdF0Pp4FHzyfhTLocFnvw09Q+glcdSuBuHw0bCRa5m7LBULYnitom5iDP+nWuzSTWz0tP8CHCI6PGnsMW6CQG2U/hqsdm7YT2DCpdjzWig0Rm2sIQu4bsC+hQL933/N3b/axFvMmq3ag8ub1779Sk+6eVjIptVvNeOJ1O29Bl8gioShdKrLwhins8lda89AUffzweexZwKplwTurychvWAUwOriv699sR1ur8XbD+cVqzR6iytva62OgQS8cDdlJVWrw65yZAP/D2oSRxyiU6eBLwVQ+jrs6nd5N3EcP4uuWhFz6ozlMkLHdD18DtbW+lP+OJ8ogdNvqd60zLEDoN/r9Qn+Q7BBjwUi+vhmN+m9uE2RN1l1ms2awlzujW4ykeZOVoMX9tLG0g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39860400002)(346002)(136003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(5660300002)(2616005)(26005)(7416002)(83380400001)(6486002)(2906002)(478600001)(316002)(6916009)(36756003)(66946007)(41300700001)(66476007)(66556008)(4326008)(53546011)(36916002)(8676002)(6512007)(8936002)(6666004)(6506007)(31686004)(86362001)(38100700002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Yi8zQnpOQ0N5aU1vdTV4KzhSeVBsUjlCdEZqaXNxVm8yM0hyRzEzbWxpTndu?=
 =?utf-8?B?SnlqR2ROclgvaU44WmQ5S0xtQ0hoUXhPT1ZLenJzNTdIUnVWWGxUUkVJcFZu?=
 =?utf-8?B?UkgvT1lGWmpqVENxZUlyWVdmTmVXbElOSDIvb1EzVXRucWMySVN4OWpRdmV2?=
 =?utf-8?B?bWNTajgwL2FzZkFiZGJzT3J6TFNnbDNGbVZvNnEvSWxBa2JEakk0N1JNQ1Zi?=
 =?utf-8?B?b2d5WFIrNTM1U2p4b1UwQ2ZMWkh2WG9MaE9vK3pGcEJJQlRYQSthNWRCejAw?=
 =?utf-8?B?U2g2V3NYYjBWNE5QTHU5SklBNEEzcDBOM2Vha25wMGRYZmNkc2xKNXZydlBu?=
 =?utf-8?B?NHErTVh0WlVCck5FL2xOeHoydDJ4b3MyeFZqSjJ0eVBYNlBCbTlBY0pBRi94?=
 =?utf-8?B?M1BnVlJlVndWY1NvVG1Eb0hFa1ptcCtFeU1VWk9hazZadWhIMmFPY0lYdTky?=
 =?utf-8?B?TlY4L0FJYkhWZlNPaWU0RDRDdHBmcUpTeVdzZGZYdk5odXhCVUFZUUVNUExk?=
 =?utf-8?B?enQ0VkVBNVIxaXZvRnlZQVBhdlQ3eTI4L2pWZUwyUWtodCs1cGFuQmtGR2Fx?=
 =?utf-8?B?bzZBcHNXR2tNQlNmUjZETCtIUjJPR1ZEK1VDM0loamRzTEg1Wk9uSmh3NGFy?=
 =?utf-8?B?QVd0N1RqSjZlWm5DbmVldUpPVVRvZjVMMmk4Q0kzYVJ4RVJJU1c5TDNEeElW?=
 =?utf-8?B?ekZkZEJDcXF1b0RNK2l3QkFqU0tqTk5TME4zdUJQV1VRcHFTYkFMcXdoOEd0?=
 =?utf-8?B?Wmpsbll4MDFHbFUxdGc4OHYyekJMY2FQcG1yZ0VVN0xzY0MrVHg2NVhXWmV5?=
 =?utf-8?B?TEZLbnZyRVV4a01JSDJ3M24yT0JjU3lxNk1qd08xdS9TMC9KTDg4NTVkWFBP?=
 =?utf-8?B?NTBoNVBkSTYvRnFkNnRWWUZLVm1BUFpyaVRHWWZhdzlROHdJL1g3Q0hTRGcz?=
 =?utf-8?B?Uk8zZnhLSnVRRGdYdU1VeUw1UzZldjlnczJtUTdkTlBkK3J3OGtUSVhyU1lC?=
 =?utf-8?B?VXRrRnVuRktHcGFENFdNdGthaXFHejhlMFdKNTNXbkxmYXE5Z2lzNE1rb1Rw?=
 =?utf-8?B?UTU2Z1FaTm1UWVVpV3o4WHZSZXo3MVdSdVppcDVHTlJ1WHRCSXkybEd4Tm1q?=
 =?utf-8?B?dWQwNVp3Y0JLVFplMkw1d2V2ZDNMV0NiaTdLR0tLbU9RMFNrd1dsYjRoVkJo?=
 =?utf-8?B?ZW82SlpnV3MxeVN3Vm5aVVdYZXdmTWVPanRuWjVIRWRKdkxjWUdERk9xWFdG?=
 =?utf-8?B?b1ExdVEvTEZCRjBTcTY4SGtlbnBaaVA0am5qcU5VN0srZXNzQjNkbEcwOVVy?=
 =?utf-8?B?ek1LL1ZYTTNhVlp0b0gzMXdGblpYZ3FSdHd6eWdRT1Y5dDgrblVnN21DejFL?=
 =?utf-8?B?eFlSbE5kQTlwbUdGTGhHclhCSlFRbEN1dHpNSWdIT1ZDWThJZGtHVzNzMWRM?=
 =?utf-8?B?RnM4VnIwbHpSTVkyMGtFTmVrWUpycW5Td3RDVUpxbmJIUWlWMGRlNWZ1OWhh?=
 =?utf-8?B?Y0xrWkRoZEJzUDRQaFpYZTM1M3cxN0dJZm84VTJzTUM2c0RDa0RnNWFzSnRl?=
 =?utf-8?B?KzFSNGFFYWJzWWhINHhqTGRBK0ZUamJIampLUHpkL3hGRC9MZkpxUTNwcmpJ?=
 =?utf-8?B?TlQxN2JLMzJIUldROXNjOGhqUmtHMmxydnFuVUJSSFg3WHlmd25rUWM4a1p4?=
 =?utf-8?B?QllJSlM4aXZmd0JxU1FvNTNxb05YUnRBZDZIOFJ2bkp5TkF4NGtzRzc4bWZW?=
 =?utf-8?B?WXN0YWl0QXhETENpb0hwRnNYYjNabGZ3WG13bHo5Nk5uZjdIL0dmN0s4VDFG?=
 =?utf-8?B?YWdXTSsvNTBrc3BCMzcvTHZwM0ZFOGZzeDQyOWZQUzdtOTZaakdOQWx6RTQ1?=
 =?utf-8?B?aHdlaTk1Q1A1NlE1OURaRTRKQU9iL3ZDYStxc05waXlxNGxDZ3MzdnR0TjBP?=
 =?utf-8?B?QjlrMG1ya3hBNzh6cUROcFZMM0dneVZGZCtvRnFNdEF6ZXhSWC9BMlhndkZz?=
 =?utf-8?B?WEVOT2s5YkhHOXZRcm5IYjljUmoza1hFZ0lKa3NEOWNKdlRueHc4bURvQmUx?=
 =?utf-8?B?Rjh4SzFHYmhjVS9sUEhVMVlsUW5FNFhqWjBDeThVbVVtTTBzSFFxcHNXSnBk?=
 =?utf-8?Q?HHlH5mkbBVqD+6n28MLqGA/sz?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	rV0NBfs1rpwOywVpCf5Wcggejbo3H7HvYQ7RyYdB+HxaRK9HtG2qTfGPqTrM818bvNpliaIAMF+lV5SFi+9GkKCtwWxouUrvhOW6vOUAd3TAI8ajDDomM2pWdwqvuP3XQFVkREwjQ6w7CbvUTJi1RTH8OQdk7qiiIRZWdd17Ylg3znBfDelspq3OTny+CkkLTFpPwcF3zfwuRT9fJJblpjqK5DUEaSnlqdKjv0MKJHSE0aUu+VY6IMFyYdJ7BYs5p4pkQG4X5NNGmRA3fmNXrPcVVEn/lmKxtwRj0QuAbY7/+WXTeb6EDVW6WvxV8ji/4tVdS5j3ym2KjHb4bHsPZABC0oqKnHCjOpiBxphfq983qSiOAzauKAohEAD2Hm0GSjRC1nMxhPxAmktCf5UepZcyRfGu/e9EyfexCqfzu/9Ibp7v7QEGoG5T6+yFCUkObnSC0IoLhP54bNvVRXkuEaW6ifk/1JPyWsU2eLDTZxLdsLt963aZ3/WyvbHU8Hdm00sGqwM4uxqUo/g2yNiII358Jm2r1eh4n0sGBgBKe937t0PyDFcOdWiL1Zpx6UIcsRda6LrrggpuVeQwtkx4+Q62kR8PcVy1lJWawHrcjjo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31c94e64-9b33-4da6-6493-08dbfd757eb6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 13:55:28.4774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RvWlcCNgzyYXVDq6QkqeTQ0VhfQ3w+MGYgJB3rz8+PU/KeDO00+0IVE3tPd4/uEzgXUdaa+PbsZQiMXH6U4bLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4455
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-15_08,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312150094
X-Proofpoint-ORIG-GUID: JvGzuvL4ibmtkbZAh2DlHpPb2Y_XfM0V
X-Proofpoint-GUID: JvGzuvL4ibmtkbZAh2DlHpPb2Y_XfM0V

On 15/12/2023 02:27, Ming Lei wrote:
> On Tue, Dec 12, 2023 at 11:08:36AM +0000, John Garry wrote:
>> Currently an IO size is limited to the request_queue limits max_sectors.
>> Limit the size for an atomic write to queue limit atomic_write_max_sectors
>> value.
>>
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>>   block/blk-merge.c | 12 +++++++++++-
>>   block/blk.h       |  3 +++
>>   2 files changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/blk-merge.c b/block/blk-merge.c
>> index 0ccc251e22ff..8d4de9253fe9 100644
>> --- a/block/blk-merge.c
>> +++ b/block/blk-merge.c
>> @@ -171,7 +171,17 @@ static inline unsigned get_max_io_size(struct bio *bio,
>>   {
>>   	unsigned pbs = lim->physical_block_size >> SECTOR_SHIFT;
>>   	unsigned lbs = lim->logical_block_size >> SECTOR_SHIFT;
>> -	unsigned max_sectors = lim->max_sectors, start, end;
>> +	unsigned max_sectors, start, end;
>> +
>> +	/*
>> +	 * We ignore lim->max_sectors for atomic writes simply because
>> +	 * it may less than bio->write_atomic_unit, which we cannot
>> +	 * tolerate.
>> +	 */
>> +	if (bio->bi_opf & REQ_ATOMIC)
>> +		max_sectors = lim->atomic_write_max_sectors;
>> +	else
>> +		max_sectors = lim->max_sectors;

Please note that I mentioned this issue in the cover letter, so you can 
see some discussion there (if missed).

> 
> I can understand the trouble for write atomic from bio split, which
> may simply split in the max_sectors boundary, however this change is
> still too fragile:
> 
> 1) ->max_sectors may be set from userspace
> - so this change simply override userspace setting

yes

> 
> 2) otherwise ->max_sectors is same with ->max_hw_sectors:
> 
> - then something must be wrong in device side or driver side because
> ->write_atomic_unit conflicts with ->max_hw_sectors, which is supposed
> to be figured out before device is setup
> 

Right, so I think that it is proper to limit atomic_write_unit_max et al 
to max_hw_sectors or whatever DMA engine device limits. I can make that 
change.

> 3) too big max_sectors may break driver or device, such as nvme-pci
> aligns max_hw_sectors with DMA optimized mapping size
> 
> And there might be more(better) choices:
> 
> 1) make sure atomic write limit is respected when userspace updates
> ->max_sectors

My mind has been changed and I would say no and we can treat 
atomic_write_unit_max as special. Indeed, max_sectors and 
atomic_write_unit_max are complementary. If someone sets max_sectors to 
4KB and then tries an atomic write of 16KB then they don't know what 
they are doing.

My original idea was to dynamically limit atomic_unit_unit_max et al to 
max_sectors (so that max_sectors is always respected for atomic writes).

As an alternative, how about we keep the value of atomic_unit_unit_max 
static, but reject an atomic write if it exceeds max_sectors? It's not 
too different than dynamically limiting atomic_unit_unit_max. But as 
mentioned, it may be asking for trouble....

> 
> 2) when driver finds that atomic write limits conflict with other
> existed hardware limits, fail or solve(such as reduce write atomic unit) the
> conflict before queue is started; With single write atomic limits update API,
> the conflict can be figured out earlier by block layer too.

I think that we can do this, but I am not sure what other queue limits 
may conflict (apart from max_sectors / max_sectors_hw). There is max 
segment size, but we just rely on a single PAGE per iovec to evaluate 
atomic_unit_unit_max, so should not be an issue.

Thanks,
John

