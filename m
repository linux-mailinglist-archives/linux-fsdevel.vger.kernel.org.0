Return-Path: <linux-fsdevel+bounces-10333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41066849EA0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 16:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 654CE1C22422
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 15:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2ED2FE2D;
	Mon,  5 Feb 2024 15:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F9/WTyYD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="F8fDjOBI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D2D2D050;
	Mon,  5 Feb 2024 15:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707147717; cv=fail; b=KUdW3Q4GxDILTGcaDc/CYItJvgCMLDwPsKI5nJqHWzw7cIYkGviZAh5770Zc18AtIWGKofgBEP6tGdCHCM4gfskel5S5fH+nBNL7a0v6fEFFLaXkJoaOeLXAa7LlbNN3y+Urxl2QaqEHBTA5IOeDJIlbB+HwgJA+1WXoNoDcRfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707147717; c=relaxed/simple;
	bh=tqV6pRQjlUJ/zXjg1dPnLCUyFD2HLc3OwqS2m+ftvkg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kEJde+IuH3oe/jx0/8w71D7QGreHeD5IewBBOrKnpdw83r2BY7MCIXRAWk6CyIvSlM+eryfqqxP5j9JJz/QHhQA1vdMh205OSyhNLYflc2AaTGTMFbml44SSLl5bCCMF6C3yFrPM2jGxWFJrLIo0aa/XaKrRdQL9lPiien98DUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=F9/WTyYD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=F8fDjOBI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 415DWKFi011012;
	Mon, 5 Feb 2024 15:41:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=7nAUmhWlbrw9qSW4QLRwwPVVthjmgF+hXj5XL6dA8AI=;
 b=F9/WTyYDT9fv0t1CKiaDhCHLUwJikwU7suoA2iMT20PD9m+hPedySShddWmnhMGc6ync
 tHYqWCEMBg5GbOkOaxagd8ZjOPo1IiRVSSOv24k925/7Jh3ca+bfHTRKB4XG5XPQW8fO
 2290hiLdFIyXhhwJmBp22Ji5pd0UE/ADkNUioPxR+QJ1G2dxv9Vd0WCn5YdYDK78DwJL
 6cFxOvEfKqJUe5e4l6uiqi9oRaEgTMEECXehbe8iaQ92bRbrP35NG0c+JgPCvwO5yO1e
 kfbM6MehuqwoY3baaMhk14a+DmYk5A+o6EgwpbjDUfKc366xUNJlX/PgmlcUqGKJnYaA Rg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1dcbc55h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Feb 2024 15:41:29 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 415FOVdm038437;
	Mon, 5 Feb 2024 15:41:28 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx5n47h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Feb 2024 15:41:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PuB16X3N6u6P2B4+liR9fK81nB5jbblxJmsKEUzqccjge5s+0mL9SUXmSlVeV20hv9L8MlRYnsNRr9VmcL8iBG6IyP68FziImOl9gs66Sfvvp0tzKxgQVGWKNDiP0Cl9sWs8sKpdIBtfPmd7MtsRpkwcvstc1ocHhx3tKsbe5Mg9WG1SGJD2Up3TEU/o83yv14Atl2SxeHq/9xw1bZLBBtZ/SnfqFOsprv8yvWYSXV7TCb9jM1VN5yUN5+/NDbN4ZKlDhj/5CziyhpRsBUZuOHHg1r15ayvac2o9V+7wiChIOW6RMzFS1yHSt0dVP1/taRaEwUqQjd57gP05EshMFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7nAUmhWlbrw9qSW4QLRwwPVVthjmgF+hXj5XL6dA8AI=;
 b=P2L3w0aVlnUziZ1z6BvTw7cB3pYuHuahewmDOMkPqLXoa5Tz2OdsBDducQjRXnk9vvfAsi9foRL7gIi3n17tImRN/EqSO8QhK4C7bkGrqBOgfm+yORo40F30F8GY0th/c9PfFMeiKhc4982agpANivMaBTOFPnHhkV178HHs4eCeQWPRVPbM2QqJ3RZ016cuKshAm1VLz5Cx8J2vfkpesrzVEVDLsugUdRH6b+L1kHJz51bGli7zoIxLQWNGeg0UgShJa0lgEv7IKF6r+bQjnHXgNSMafuNTBWld7lY22s4zZMizYLUa0URPTQuWDY3nCcdDTGvnn4JvPTUbHo4ADQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7nAUmhWlbrw9qSW4QLRwwPVVthjmgF+hXj5XL6dA8AI=;
 b=F8fDjOBIg8tCoOiTQRDC4qlMH5fFiYnb3iQEFIVQn6ahix7zLEp8UN+dCLcbzRBUfCv5FJSa8K9QIwwBTt0JpCWuNWnSzAfmuyta0U4zIQob0c1kCEVLKH6cpenne44sLU1LGH0eidZo6eU5xxe+B8R3CfJ35A78a5s6WBJHflE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BLAPR10MB4849.namprd10.prod.outlook.com (2603:10b6:208:321::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Mon, 5 Feb
 2024 15:41:26 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4%4]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 15:41:26 +0000
Message-ID: <d342be4b-e83b-47e0-8d45-9621900e15bf@oracle.com>
Date: Mon, 5 Feb 2024 15:41:21 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] fs: iomap: Atomic write support
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: hch@lst.de, djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
        dchinner@redhat.com, jack@suse.cz, chandan.babu@oracle.com,
        martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
        p.raghav@samsung.com
References: <20240124142645.9334-1-john.g.garry@oracle.com>
 <20240124142645.9334-2-john.g.garry@oracle.com>
 <7ttdwk46hkj6ohdyq3ruwb2zkskzrpicz7dpf4g53v32nh7mgy@5g63yuoyotyi>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <7ttdwk46hkj6ohdyq3ruwb2zkskzrpicz7dpf4g53v32nh7mgy@5g63yuoyotyi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0639.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BLAPR10MB4849:EE_
X-MS-Office365-Filtering-Correlation-Id: 71f2e574-dde7-4fbf-ffab-08dc2660e9d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	z3VPemtDBrsh/NcUWlWgacjI7ueazIbCK1VG0XlZc6fhHq+HJ/4uL9l0oVi5oN1aBL92M6jysh2DbAAn3VoNSQRx3sjDGbe2YY4VJsa7sVeLF5bRiIYdXJdAf4dw5SSoL+Q60W5bduIGR1acaQnPn/m2154kJuH9FmJPPdKffy4mJYmSI9zA1mgEejPD8iR58Yfc1Mmk7NcKNCfYRBpjGT2T6i4rT0bQX3QATBFWKMxdWCLFCvW6EsTAWT3q98I6hFSCNJMUhegaGC3y1ol4XaWvvmXO6xbXPGnGxmv6Ch46yn6MnCsQAdrwFCFC8Zr2leLOlmD36bP3Dwr67afThIB0BqdHnAT2qY5iOZxCsZVilivjyo2SjzMOpNf31YnrOw8BUeLkkwyOmxx144I6Gw4/WM2ZyZAgZTXcQNgMR1J2S3a0ICkNlWjU7AzHcpgsQtgv2Lzh4jZpT/sK9z1CmuMA5Afz8+g2gSuZhMy6XcrvEmKKBtn2f2VSY9MFMjSRFwXK67liH9e8l3IEzTaREosOLUIfim8fCtDRq41IGd/xGVrbiQyfEnqPGpoCFjQiUUJecrAPigscjl93NiIvWaEBiLG3XheXUxpozKvYrhJMjvTfbEEwGZCuzWcSeoirj0kscjcXy6Zs7/WRYhCtZw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(366004)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(31686004)(38100700002)(6506007)(6666004)(53546011)(36916002)(83380400001)(26005)(31696002)(86362001)(41300700001)(2616005)(4326008)(8676002)(8936002)(36756003)(6512007)(2906002)(6486002)(478600001)(7416002)(5660300002)(66476007)(316002)(66946007)(66556008)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bnh3MlA3dVZGeGpaa1Qzem9aejBwMzRlZDBlY3JpS2xnU2M5VjlyNzRGc0hr?=
 =?utf-8?B?WGx3UzBUc3U1OFd0QXhPSVRzVUVBekcwY2dwOHBOdFlCME9KMFd2YzNTTGtl?=
 =?utf-8?B?Qm1paEFOMEhnbERORzU5S2drbGFOZHdjWDhqSUZ0cUlUdEFYKzN1cUE3aFNw?=
 =?utf-8?B?akpKVXlQV0pwL1BQV0xXcXVTdDZBa0hVaDJuYXg4aUg5c0RYa004K0RsdUFQ?=
 =?utf-8?B?MVNuUDY0N0dtcFJHeW1RV0ZPZlI4L0dRWW9vUGozNW5qS1lsNklORkRxQWpu?=
 =?utf-8?B?ZUZ1d3JEQXhMb2xIUkw0NEQyMEZKb09TWXpGVG9Ud1BhcjRoWXZSWDNTOEVs?=
 =?utf-8?B?bStOT0x6WlVaUjZ6d0IyelNuaWhnNWp4WDF1eFpZZHJjK3RFbUNIYTJxeEZt?=
 =?utf-8?B?ME9tUDdNeHQwai9DMFl1bWdHak5XTSt6SVl0OUhlbW1xK3dxS1VSazNTeGhH?=
 =?utf-8?B?eFd4WVJuVHpnS1ZhYklrZXRNL0VFSm8yZDVqaTBPNVpGdVBpOGpISFlMdHR5?=
 =?utf-8?B?TXkrOVg1NHBWSHVxaHY3NEFCNDNwZDlhTkRBNldiLy9ZLzRZd0x2NTZsa2VO?=
 =?utf-8?B?R3FpRTNidmtpYWh6UVVXdE03R1FHalJHM3NGdXErR1JsSmIybHdyYmxPYTFx?=
 =?utf-8?B?TVBiWitMUUJrOHBQT1QyRXBJSDFyaVFNWEZRdGhBWWZPTWtiTERqQjN1QUZZ?=
 =?utf-8?B?TEw1MVNtSGJkbk9iTStMYTRNMEVvenFFalZIcjFTbWtmVkJWbnhGSWJTSkQw?=
 =?utf-8?B?eHEzcmFsZ2pBN0hscTA4YUcwZUJEak55RkxvVTdnUjJqdzNGeWNjTENmVkkz?=
 =?utf-8?B?SmVDUDRUOVplOWM5bVFacFEwZjdaa3c1YXdKQVRqVWNHNkV4RDc5SDhIaENZ?=
 =?utf-8?B?RnBPY3M1RkJLNCtuZktDeVZCQWx2T1NqczdwYTRWNTB4YXVSS3NXdk5GcXFO?=
 =?utf-8?B?azVkVFUzTzVCRjRMbVo5L1BoVlNHYkpXamorVG5CTU5GMC9ZY0NYeFg4OXpD?=
 =?utf-8?B?THpJSEdPUVFqaDcxWFl4eW00YVJpYjNmQkVhZmNFc3ZwalpZSWRpNVhxWEd6?=
 =?utf-8?B?WHNpUHFKTy9kdDNoOStCR3lWU1ZiU2JIYW9KbktIYjJXM21FVTd1LzBmSVMr?=
 =?utf-8?B?RjZUWiswVmRkREhldlhTQUxoLzhPR0hFZlZpNXFzZ2ovOVZjbVZvOXBvU1hi?=
 =?utf-8?B?L3U3dmttQ2dIYjkvSlRiZldMejBBekNxYXR5cC9BQmhiYnRnV0Z4K25CTHBP?=
 =?utf-8?B?OWtrVlZNeHZZc2ZNOXRKSFJTUDJVTGtPa3Q3NzFXUG9Ob3BnWFVKMFV1Rmsr?=
 =?utf-8?B?dEdBTjdPQTdLQXdvR0M1YzlTQzlkTEtMQUlJdzJmNXdsdEZXWjNwZlVoNGhw?=
 =?utf-8?B?NFFTcjZGZmEvVmFGbnAySUppLytRRUNHUVdtOGxaOEpTNjZsY09ZUUNxL3ZT?=
 =?utf-8?B?cTBNdEM0Ky9LUmpUQldyTmV6USt4dFp1ZVRPTHNyNTF1UENmZ3kzVHhxY3Rv?=
 =?utf-8?B?dU81RU04dWlkZkpoZmxsaXF3NUxoUGk1ZUdBVEIzY2t6bHFaMzQzaGtOdXBn?=
 =?utf-8?B?NityeTlJTWtkeTI1TEFxZndMN09wVmJpbGNJZ0lKdkFiM1lOS0pnSVR0UlRa?=
 =?utf-8?B?Y1NTd1g3MnhyS1dUYWpWcEZ6VWV0a3Z2cDBPbDl1Qy9RbUpWajMwNVc5RHds?=
 =?utf-8?B?V1g1b2hXbm1qem5SK2gyVlk4Y3dGTnZIRlA3K1lyT3QrTVBtUlpnbXZ6TWxB?=
 =?utf-8?B?SXFBV1g4OUZ5YzVZdWg4N2ZHZGZ1cWd2b01qeGdoK0ljOTJKRTRvMzc3Y0tG?=
 =?utf-8?B?MWhWdkJuTmk2ZGJCSmkyK0cxbXlhOTkwOFVMSFlNUC9NSmY2NXJCbWRpRjVP?=
 =?utf-8?B?UnlUTWdxMTRoQ0tIQVErOHB2bGdRMjhSbGIzbkd3MHUweXJQYUtLQWI5VFU3?=
 =?utf-8?B?NXlPd1ROTnNhR3RjUk14T0lxWkNBL1daYkc4b3paWmlHQUFQUEhTWE5BZjNi?=
 =?utf-8?B?aHZqb1ZCanNkUU9KUW96V3RQRStIdjNXVVUrRUNxNHpScmVkK3labmpOMUJW?=
 =?utf-8?B?SUF2dFBiWE5WVUxQb2Y2Zk9raTR2NC9Fa0hOaWZ4OHhybFZMRGh5VU1RTUNE?=
 =?utf-8?Q?+Y7ooFf4bqg1oeUW6xi7st6JW?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	YI6NyD5igPc4wT1XMvGHyazc9EgsQcvSeMFh28bOLElam+kOlAnhF9B/RE6Mj0M7I1hZem1UyGGcwDfLTL3blH+d+G+mCKeFADGV+Rq2w6CBYXI8xAKcXBDU6EeLOqDyP52UYdoFlT3losYhiPGXO86O4M3+bJx68dzH9i7nZnTARnDDiYCA7pEbQoaOHsbWlwcwgPPLH4oRRbP5T+BuGdijY8CaLSaMX/Mq9F/1ajCLzJIvpoBoNMtOwvMaw6cccp26si12TcS2kEAla6JJra/l8OTbYvVp9qCIz1bLhyrkI9xra6aSXvZ3LeJYRPBsJ31L+K7JmBVuagdi4bgp3dydiWNLZHDPS84gN61/Z7C9mGHNOwyJW2vWL0Urf4vmtvfSxSHKdPM8K2w6PCqanYQW7/Uf2XAgAfXLa9zc5t9bQ03S4ylv2i6iUSLaeuf0JBfhrnp+23TneNKOd24cIN9CUhaw42Bu62h+PKumFUIiNxLt9y/6TN0CJx3k14buDBfGPI0Kjri8CbBeeyO3TAXsXcP4M51UdiAkxg1mQ/1SaKFM6SvHjj4sPtLlO03cfvyFMmoDOHYJMyt7BWZkPYF5XTbedFV8YqZptbiBQOA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71f2e574-dde7-4fbf-ffab-08dc2660e9d3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 15:41:26.4011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pi4SPKwT2/FWvQtD2r/caUr8i1rIl7jA9Afv7ZZMwgkXqQzb0Wxt447ArMuL2unxnYtHddAfRYDBT89OcwIZrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4849
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402050118
X-Proofpoint-GUID: wb5-1K3VgxCaDBQEjr3s3Zndr3hK0SuY
X-Proofpoint-ORIG-GUID: wb5-1K3VgxCaDBQEjr3s3Zndr3hK0SuY

On 05/02/2024 15:20, Pankaj Raghav (Samsung) wrote:
> On Wed, Jan 24, 2024 at 02:26:40PM +0000, John Garry wrote:
>> Add flag IOMAP_ATOMIC_WRITE to indicate to the FS that an atomic write
>> bio is being created and all the rules there need to be followed.
>>
>> It is the task of the FS iomap iter callbacks to ensure that the mapping
>> created adheres to those rules, like size is power-of-2, is at a
>> naturally-aligned offset, etc. However, checking for a single iovec, i.e.
>> iter type is ubuf, is done in __iomap_dio_rw().
>>
>> A write should only produce a single bio, so error when it doesn't.
>>
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>>   fs/iomap/direct-io.c  | 21 ++++++++++++++++++++-
>>   fs/iomap/trace.h      |  3 ++-
>>   include/linux/iomap.h |  1 +
>>   3 files changed, 23 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
>> index bcd3f8cf5ea4..25736d01b857 100644
>> --- a/fs/iomap/direct-io.c
>> +++ b/fs/iomap/direct-io.c
>> @@ -275,10 +275,12 @@ static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
>>   static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>>   		struct iomap_dio *dio)
>>   {
>> +	bool atomic_write = iter->flags & IOMAP_ATOMIC;
> 
> Minor nit: the commit says IOMAP_ATOMIC_WRITE and you set the enum as
> IOMAP_ATOMIC in the code.

Thanks for spotting this

> 
> As the atomic semantics only apply to write, the commit could be just
> reworded to reflect the code?

Yes, so I was advised to change IOMAP_ATOMIC_WRITE  -> IOMAP_ATOMIC, as 
this flag is just a write modifier. I just didn't update the commit message.

Thanks,
John

> 
> <snip>
>> diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
>> index c16fd55f5595..c95576420bca 100644
>> --- a/fs/iomap/trace.h
>> +++ b/fs/iomap/trace.h
>> @@ -98,7 +98,8 @@ DEFINE_RANGE_EVENT(iomap_dio_rw_queued);
>>   	{ IOMAP_REPORT,		"REPORT" }, \
>>   	{ IOMAP_FAULT,		"FAULT" }, \
>>   	{ IOMAP_DIRECT,		"DIRECT" }, \
>> -	{ IOMAP_NOWAIT,		"NOWAIT" }
>> +	{ IOMAP_NOWAIT,		"NOWAIT" }, \
>> +	{ IOMAP_ATOMIC,		"ATOMIC" }
>>   


