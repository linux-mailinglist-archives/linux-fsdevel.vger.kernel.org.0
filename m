Return-Path: <linux-fsdevel+bounces-18880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A54FD8BDD50
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 10:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B313284432
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 08:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9A214D42C;
	Tue,  7 May 2024 08:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="azktQBJK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="az1rdJm0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12B06E61B;
	Tue,  7 May 2024 08:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715071316; cv=fail; b=jApjZy+EbvTyqhy9HiXVp/RjSBfSyz7CfveuUJvlkUSYMVzJ/hnSQPgX23t0cOxuLGr3Xwq1yVdej+1v14IHKmh2CsB1MkKfR6QpU1bH3+CKKfOgvl5yHT1XUZRIN8aKOTYoRozNzHKHpJ4lZZqz9oAXKfy+lnXYuagmMr4qS+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715071316; c=relaxed/simple;
	bh=Hk7yfvrVsxhKsSaPZpxgtCzbYTf6uDilkoYQXyMVFUM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W/qmwXCDsmMMJ9R/ymMoJd8p0GzH1oDaQd9/PI8nH4gkB3AIOWEbWEWetctelKddL1gxYbLn4z4oV8emEb8Y0/nAj6i2U9+q0tMmhSuaD0DEXlrk5b5ezbgADXAGObyzlFGMNennWhoaiaSVzReJabDY80uNwNQQYHbBNZj5dfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=azktQBJK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=az1rdJm0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4478T0bs005006;
	Tue, 7 May 2024 08:41:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=YlEmjKIwKUDUZI8Hbi6oAUx+dvVlRbaRcTocoStFvoI=;
 b=azktQBJKeYUoVaUJJo3n9YWns+3kp2tHnYO9hxhwrynQza0/nfJyQCDwPND5gLUeUxZa
 xxEhzluhzHPMm4EVIkCmwBpeqVbaYL9/nYBlJJGohexcDrarXnVNm3++ygjP28YUB0rJ
 uapyymPD4DfFlGgBhNo5ayo2lFUPHC4QkGENWYvkG1zHKB7T5r6P8fwpx4vFh0X89L5O
 e1BwfPpIJWArE+RfU0CyQ0NScRi1+izhJDxfOAIkUlugoeHpeaGppY/bGJHxXvP3dAsO
 rdeK/KWhbVAY4fs4zpsNMn+Y+KAqNG4V51d8dv01+hRWJ9wHlIsiVAj1itzGUpzdwMhX Og== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwbxcvfrg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 08:41:20 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 447769CD029239;
	Tue, 7 May 2024 08:41:19 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbfcxcw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 08:41:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dKy7J5Gu2KoJEe0eRZKiROUgdEBAk7NduWgrtW+IdT794PEolIhVNxU3O0H/uLyrObNamWJfa6zWHuE+uZ7OufCyyIefwrL6gJtMdm9QuduZxpDx9+yg3gfwHkoXCliWVI2JPHJy+fMxeRTf9qGo2QON2PbjWatYmE9u09eZNQdxXFeQnzvLvEL91PBellRFOBrl8v1pD5f7O9V2+xzqAHcfC7AV9KnSIVKfkfHPxW8BVM5K0REjAD6wnxp2kCoY/HAcMLYw4wbuOy+CNkfGzhqrobtNRBKJy/F561MTb6Scx+MI/SLCXbd1ECoBHkaxjhuKf0oAPzDgUKksLqx8Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YlEmjKIwKUDUZI8Hbi6oAUx+dvVlRbaRcTocoStFvoI=;
 b=WQnSDlKoTojCVXDuulsPuEfrP3QVmetGjDrRn/JF8651GZPSi2TbFTqHFctHbBTLtQWD1zSoDEfYkTY2GgNBG98QXZ/gjBgnecsLZ1BGB61bd02bbQS/1yUTqXN87823O0bPRDoWCXGIw5ih3fE/CFISLKX0OGlhsccfJsJ/5inQqxHfd3bD5mzpjcwNl/LmGw37nVRXS+GLgX6OORIXTaavzGS1wEsChShqr6D2Q/FC4cHmL4WDeTCy7xTSFIg2wanhRbVRirW2cS8mfleQJ+Dw2qluw0+sH2olHlimqj1yvPJGNapqGZD4RcLQdF29HG/i2LeMk1J+wtd94cCXVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlEmjKIwKUDUZI8Hbi6oAUx+dvVlRbaRcTocoStFvoI=;
 b=az1rdJm0byt3iPAI/B5KlSbIUZzD4QInjPkiL9hbgC/Uvy/gquV+gsxNM1e7nFTCrjLfU69YGPFHBq12Tm9GrAGRu66JqBIJokDy1H5cT4Ci5PZ5KxfGv06noquAbE0OiKnDC6Mzza5BUs+nM/ebFCRrynOk9AY1GSqAkHf6em4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB7556.namprd10.prod.outlook.com (2603:10b6:806:378::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 08:41:16 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 08:41:16 +0000
Message-ID: <b3a3e9c1-91ca-4c7f-81a7-03f905ee0bd8@oracle.com>
Date: Tue, 7 May 2024 09:40:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/11] xfs: make the calculation generic in
 xfs_sb_validate_fsb_count()
To: Luis Chamberlain <mcgrof@kernel.org>, akpm@linux-foundation.org,
        willy@infradead.org, djwong@kernel.org, brauner@kernel.org,
        david@fromorbit.com, chandan.babu@oracle.com
Cc: hare@suse.de, ritesh.list@gmail.com, ziy@nvidia.com,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org, gost.dev@samsung.com,
        p.raghav@samsung.com, kernel@pankajraghav.com
References: <20240503095353.3798063-1-mcgrof@kernel.org>
 <20240503095353.3798063-11-mcgrof@kernel.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240503095353.3798063-11-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0134.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB7556:EE_
X-MS-Office365-Filtering-Correlation-Id: b7f86add-f118-44d7-37ea-08dc6e7175bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?KzNwVmVydDUva1pKa1p4M1BYeG9teWd4ckhyZ2tGQjZNc1pRT3ROK1ArQzd4?=
 =?utf-8?B?ZTZYbHNoRmhzdnBQTG1NR2xGWkkrcS9mbWNOWGJqV04xRXBTK1JDWHh0ZTVF?=
 =?utf-8?B?SU1FZDExRnNXNTRPQkNtVHhKYVdkTHVQdlJoQi9EUWhkazVEWjZoMVNzcUtx?=
 =?utf-8?B?OTBHWE00WDRoSzAxUERJVHBaUlNNcmlONnRiZkw5V0FYUGFPdnpVS0VUSTVr?=
 =?utf-8?B?VVFacmxPN1RodVYyaDN6NW5lbkVlb2tBVUx2c1RmTFZLVnNkYVRYOXFNTW9T?=
 =?utf-8?B?UmVHRG1QVXJDVmpCclhsNkFjNi9pS29tZUdveHBJVW5lR0FLVFlHa21BWExK?=
 =?utf-8?B?OHowSTJTOElTYk5vUDlWenZRS0hSdWRxbXYyb1IvdmZUbEcvM09yZk9aRmJq?=
 =?utf-8?B?MHNNa3FVb1FsNWwxQW4xK1IzdElBZGFMSC9kTFJMdGFiU3ViaHh1ajdLRzNY?=
 =?utf-8?B?ZElnNGltN20xUU1mZUJ2YU05TFB3OW5TWTVlZGJ3NGNHYWJFc3VWSFVodUxz?=
 =?utf-8?B?RkxQckU4R3loenIyYm96ZmFHN2tLOG5oSXQzc0FVUHhlcWh3ZmpaQnB5dUlF?=
 =?utf-8?B?dk03YWxXMUtXS0NSZ0toaXdmUGM0aXBxOThndStrRk9DOGFNNUZKZGljMDZT?=
 =?utf-8?B?d2o0VG1QMS8yL0wvTURhdC91ZDhQZzdKSDFWeitLeEtYeWVtWW1mVXlVb1JH?=
 =?utf-8?B?cEpmcTdPWnpDZW9kbEtBeGxjMUZtWkFUL0JvYUxrbVZzQ0lITjlXOERJZjJS?=
 =?utf-8?B?VEIyV0hLSHlTSWhzRzh5dnRkejR5TXJLNTRZcTFVejF0TFl2ZGZIYUp2aW5a?=
 =?utf-8?B?bnBxcEVtemN6eFYwYVBISDVCYWZkNjFqSVBRUXJEVmNMdkN3T2hRWG1TTVl6?=
 =?utf-8?B?NkdCZWNpNFFxQlE1UkhvTlhNdHpDektsd2NqdTBaTWpjMUwrbm5aaWhlRTQr?=
 =?utf-8?B?N2pOa3pjR3VKQWp6aitGZGRzMEZoNFE2NGk1T3VyV3NkMDBuZmdrMlQyZFkx?=
 =?utf-8?B?dDJSTU9IdzhEZVhZR0YvWjZCdXNaYTYwVEtqVFNJYVlwMnhTMlVrVHVveVgy?=
 =?utf-8?B?MVY1Q3FlWE5qYm9PdXFEeW41Vlp3Ym1uNkU4MVE3NWZINll1NHc5aFJUSkRK?=
 =?utf-8?B?NEw4eVN0Rmk3RUV0RFQxc3U5WWlzVWlNa0pITzExa1U1SEhYcm92d1N6MzU3?=
 =?utf-8?B?V0ZaQ3k2SkVLcFBEZHZpSzdRWEd5ZGpsMEtnYm14eXFBcEdlbEU2YXpORi84?=
 =?utf-8?B?Z1padDJ0YllqM2NSVWY0aHIvUVdlem5tNGlieW9QYkllbUVRNmgvdU9WdUdM?=
 =?utf-8?B?dVFMclQxeEJWbVZ1UGNCaHFlYUN2R3oxRnY1OGE4ZERzOENYSWxLSFpTaDNs?=
 =?utf-8?B?Y3Mva2dhZGhFdkMzRGx5ZzhFYzg1RFRUNi8yY2djTmlFQ21jU09aRzlHWi85?=
 =?utf-8?B?QnY3ZXZzL2J5d0NIb3lhSS9Ua0JoREJaQVZSM2w1QkdQQ0Z0eUxRNjZsVVgw?=
 =?utf-8?B?MkNhbWlxSjhUU3Urci8xMmsrenVWMDhVZnlWN1JJRWNablFNSjRRcVhkTFRR?=
 =?utf-8?B?YzF1cUNQYzRVUWJNaEYyUy85Qjh4aFRFV0d2OEZOWlZxN1dIQXJyVjd6bVM1?=
 =?utf-8?B?cFhibitGb3RBc3gveDJReXdHMzBUbnZTQlNkbFpMRTZFcW9GeTlDK3lUQmdU?=
 =?utf-8?B?SmsycFJ2S0IrQnNIZTNUWjZkZEEyR0psSUMxbnlVcm0zQm1odmxIMEh3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?T3pJVTJoT3VVRGY4RURGSnd3MDRoOFZQb1hQQnBFWDhDVlhWbngxUzNBQUJP?=
 =?utf-8?B?QXNHTk1EdGlQdnhtb1VmWk9pYWJ2bWFnTS8veVh0N2ZlRk14MW1KS0xMS2Ux?=
 =?utf-8?B?N1NTT2YxaGZqRmEvK1VXcCtpbHBqamxTK3NaQjBodk96aFQxVkluM0U0dFgz?=
 =?utf-8?B?ODdONW9kZk5pcXVnUlY1Q2IyeGtFVkFKUUhWQjZOME03b0RoL01EcHVvUXY1?=
 =?utf-8?B?eHBwS1d5anlRUGNqTlJ3RGxGZFIxRWlPVnRvTFhpRHRJYnNxTVFZNHBSaEhq?=
 =?utf-8?B?c0JiNTdrV2ZtRTVIVno5dkdtT2h3OVJDZnB6bkM2RHR3T3NCMHdBNUp4anhK?=
 =?utf-8?B?TzJSdVpzdWc3MUJPbDFwY3RpbktkSVB4bUJaVWtBQWZhWjBDbzVXOEFJWVJP?=
 =?utf-8?B?dTRCM3dxZkozVFRrTlBtNng1L0xPY1dRT01EdUFyZDREdlBrZzFMYW93QjY5?=
 =?utf-8?B?Yi84OFI2ODJMSDBtNU1DQW8vM2llSzhsWTZ5aHhFcmI0MVc1N1AvRHNaMlIv?=
 =?utf-8?B?SUhZbUpSbWJ5WmpCVVRsQktCSVEzenJac2JFMmd2RWt5VmNZUDA3TWFUOHJx?=
 =?utf-8?B?S3ErU0tTRFFIakpjV3NoL1haZWVLaXcxUmVMMEJHVGFoN1hNNFlWYk9rcTBX?=
 =?utf-8?B?V0VJdEpPeVdZR01XSEtrRnFtazVyWjFJUDJGbklQUG9zQnpEUkZMT3JrSnZh?=
 =?utf-8?B?SGJUZ2t1M3Fza1FSUkNwcmFwRVcyaFVLbTdaSVUxY25nZmFEMVd2bzg2UEY1?=
 =?utf-8?B?b1dQTW1ocXBxODEvdkNQcVh2NGIxWXY0bWUxejE5dVE4dG85cGZ5bHVsVXhs?=
 =?utf-8?B?dlhvU3ZYeUNxRi9qVDlBZkU1MTB0c3pWb1ZSOEV6d3ZRTXdtUmo3WlkvbGZt?=
 =?utf-8?B?bGVmNDN0bGE0K3B0TXkxYlMvWXQ0NVVMMW9nc01iNjNob2U1QjJZVEVtd1JO?=
 =?utf-8?B?bEQ2dHpFOTdHR2hLRGE0b05EQlhOeVozYUJSVWhsZTNIQWVkeVhqSlpvYmV6?=
 =?utf-8?B?d2ZCN1FsZnBMQS94MUM0OXNyS3lVQ1l3K0dBRXNRd3NNK2hFcU1QU0NpRlBG?=
 =?utf-8?B?YkpnUi9POGllOXBDcXRldnBRTnhqQ21VQ1A4K2dudDRGNHAzS1hValNMQWxH?=
 =?utf-8?B?dmxiOHpWY2JPRzErS0VPd0c1YzhWNGRzcmE0aVlLRzUzTVBJM2dETEpBSkdN?=
 =?utf-8?B?d3BlZzNHSXlSQkpQS1FKMytSTjIvelZzRTNXSDN0NGllSFJqWU4zMk5DRmFY?=
 =?utf-8?B?QjRycmlVN3VwdldobXRUNkxxSzg5alY3eXBhdGJJT2R0bktyZ3JiRHcyRlZJ?=
 =?utf-8?B?bTh6UTZsY0tEakI4NndCY1RlUmFkdzE1UHI2WTRpODVLTDZidDloTjQrSHgr?=
 =?utf-8?B?bHVXUHNodEt6NTdGUXYrTkcrK3NwUmt2RXRvRDFVMFpBeVVhNjJVTHJPODFa?=
 =?utf-8?B?M2FIaG5za0p3c3ZPR2JYZ1NzOUtvbC92UW1TSndZeXAvNmJnQWZ3VXRKMm1D?=
 =?utf-8?B?VmRYYk1WSDRFSGRZYzhVdGVqeFFqc3ducTJ3YUwzeUNQS0lZM0ZHRm1URUlP?=
 =?utf-8?B?algxdXJYUUNBcVI1Y2VFdVkwcDdjS0pxSXBWMXRiMWVvTWZuMU9HUmxSVkhk?=
 =?utf-8?B?aEgzWUdQdUpsVEJSdURFY1JSWGhjUGdUNnRoNGxENWhYaU9QTXpLUTVta0hH?=
 =?utf-8?B?WWxZbXRSVWhHaWZpcXlrTWRTTFZkYzFlMWcyRjBJcGlZaFhIdThPSmlLUTh0?=
 =?utf-8?B?OGNLZ2JYRXY0QlZqa0RiOWxvVU1MWjNTZ3hEN2t3Q0lWLzR3Mm0vc0lRSEJ3?=
 =?utf-8?B?dXk3T1BNejljelZGT0hjVS9UYWpGVlRuSVVVMG5GWEdycVRuMkdudFM4SFY4?=
 =?utf-8?B?UFBxV1djUTlhbWNlcW55bXJIZDJFVzRLWnB2NUk4c1IrN0ovanhxNHZTQ2R2?=
 =?utf-8?B?TlplS09xYVVNVlBjRUlTR1gvRW5ZbWRYUm9ubWc5UzU4MGMwc1F0a3A4S2VG?=
 =?utf-8?B?RUVXaVZ5T1p5ekIrRzdJY0gvNEtZdURSNWQ0a2xBTVBCQVp4Q2locFdOMUt2?=
 =?utf-8?B?VXpWL1Fjajl1RFY2N2pJQURtcHJENzNCS2c3QWw4Vk02Mm16Ymc2T3R2RnZr?=
 =?utf-8?B?SjAwN2NGaGVGWFROWWhOSEk5QkZsM3crNjN6YmRMeWR0bmhOc1ZsdWtFZHA5?=
 =?utf-8?B?TWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	h0o97SU1hSyP1tcErFiv56FSsDQQA3JC7AZPNASBRq2qIm90KDA1nvNGzGmXZ+dz11hIwY7BofZxAaXbkH5Sd7aBk+tBvEkbK4OWtAYL92ck6J8ZOk+K+rRW7NI4QpHRH0Nca3tHDwdHP0kk5yWZr1QG563Jk1C5B0nIyrckw0fdJ2+XTfYe3GMcCkmlwkvM/TyFZmpniLtIAXHoGMDUHA7o7fNnfCGzEe0WauBpwPOYpzlU9LZoMgUCK4I19u79FjsCkWLipOhmXqqmfcDUW4y5qgil9zv1Vgm5dAzyQ/oIhVY3xmNIkiemawYk8WaBa3t+9wf9AxjwET7mSUHGBXdvrUTJduyLSuBl1b7Dluu4a0MpHlzabIbI8+1+CVvGmdB1RJx69zwri1CYO1kuDTWJsSl2pAK2TDmw+lM7fL9RsyCYBvG4C8WBuo+zSVyIJQbeC6DrKpjrbHhpSd84Cii+YIhCAzxoiqjBbdfaku9q2aBWSGQ+KQ/ftWqeLizqblS3UXzov4/YybNKp+d8X0GI7Uj+Pd8Abv+Cd8b47PSJmmIFDbFdkmdAbmHts3N+fLV03Lzl7Lz/4x3dyKE8bsTOqBJRinwYIVioIzmL9HI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f86add-f118-44d7-37ea-08dc6e7175bb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 08:41:16.8250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /NqlN5gtBR2v3tD+uLWCfDvaLz/5b7e1hsy7eMrCco1DsTnQKUKYpz45xn6X2H2csC3x7Uoe5AqT1ZhX0rqPyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7556
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_03,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405070059
X-Proofpoint-GUID: vpzFSrj21_m3keQtLc6qYFDgkhumGCoR
X-Proofpoint-ORIG-GUID: vpzFSrj21_m3keQtLc6qYFDgkhumGCoR

On 03/05/2024 10:53, Luis Chamberlain wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> Instead of assuming that PAGE_SHIFT is always higher than the blocklog,
> make the calculation generic so that page cache count can be calculated
> correctly for LBS.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> ---
>   fs/xfs/xfs_mount.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
> index df370eb5dc15..56d71282972a 100644
> --- a/fs/xfs/xfs_mount.c
> +++ b/fs/xfs/xfs_mount.c
> @@ -133,9 +133,16 @@ xfs_sb_validate_fsb_count(
>   {
>   	ASSERT(PAGE_SHIFT >= sbp->sb_blocklog);
>   	ASSERT(sbp->sb_blocklog >= BBSHIFT);
> +	uint64_t max_index;
> +	uint64_t max_bytes;

nit: any other XFS code which I have seen puts the declarations before 
any ASSERT() calls

> +
> +	if (check_shl_overflow(nblocks, sbp->sb_blocklog, &max_bytes))
> +		return -EFBIG;
>   
>   	/* Limited by ULONG_MAX of page cache index */
> -	if (nblocks >> (PAGE_SHIFT - sbp->sb_blocklog) > ULONG_MAX)
> +	max_index = max_bytes >> PAGE_SHIFT;
> +
> +	if (max_index > ULONG_MAX)
>   		return -EFBIG;
>   	return 0;
>   }


