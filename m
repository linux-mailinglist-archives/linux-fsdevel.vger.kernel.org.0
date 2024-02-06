Return-Path: <linux-fsdevel+bounces-10506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA25E84BBA1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 18:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60280283228
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 17:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF1E6FB1;
	Tue,  6 Feb 2024 17:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d/Jvb7L1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cPSxYwzH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBFF8F4E;
	Tue,  6 Feb 2024 17:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707239281; cv=fail; b=a8OxVxoxesq1EefYKmIaHq9drx/piUPt2aU5OpGF1rTgT+kGRqA6+5t0MjAejzx+KW0xCgdiy44Pco8SwUroWr5fXEfmzztg0bafvTEMlc0wEp6IxVIk2PVK2W9S5YzEk7VhxazGY178raGRaeBl7Ft6e1uMigeCDyIUlGBZM9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707239281; c=relaxed/simple;
	bh=++9w0hgzlt+rzBuGZy1PvlaQ/mKKAx0MMufLPZVXxws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ezx+7WMHYxpqp19iKgcvxSlX9yf1YmdsPXdU0QGteZ3/sGZ0tsP5u5+QSDkhJtRZlYgZLuH1RlgN1aWU74sWUZ5R78nASYlwMFSIWRjLBreJH822iIl3K72UBCMHQGkcDwqUUKHoIkPSVmREEYBZ1WXEwgcBHsfdoRjNE+TH1C8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=d/Jvb7L1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cPSxYwzH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 416GEEhq003336;
	Tue, 6 Feb 2024 17:07:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=OIZ2/Vdbnuyf2BDTvGcZucol+RdXPAIeDogmhRFl70Y=;
 b=d/Jvb7L1m8IqACqSlarn2R9S8wNuOlWFkb+TJK3m0gj/p1Qht5N/FnTGZAijY7dxrhH7
 EVXwZTxXhOXNbZmXQbBzeS+tV+rszF8TfGlsHj9uEwwtgRDfl93ObJeJho4vxhMbytwZ
 pvTVnVhuggHFxx210L9q1ZMmIFBwgWVaa46Q0ShuLBCCS/5KFZo/6nQdNeRD9Bi5YoVO
 G7MBzxXSwZmUCNjVmG6dWjM0+UomP7tJpLRTDBrLRDvN1W2t7u6eA5MUxUUONh2e1gRk
 zfp7HYYYe4lHvQQtuyMJx2QQTk4WIPw9h0O++l3Q3w4SBLYqwxmd3z4alGI5cqlgS1Rx Cg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1d3ufe15-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Feb 2024 17:07:35 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 416Gl75I019727;
	Tue, 6 Feb 2024 17:07:34 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxdw192-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Feb 2024 17:07:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jAe8z5kpL70+Dp+bYWJSzL0Ykz2dGDSV74WvcvSVxi73Q9dv0TzN/mDyicdGHsBp4vew3EMrJo+htAX6ltpIa5yLr9wtV/Y2s+yTzdrLFJQh1LygAeCyP0Kj9VSAbPqjdEQZg1Eizh764KbnKFggiU2tkHkhUWAiT0hNR05fF6h5YTIVNDre5os0kV2hWhFoa5OEAWWmwaA29hkuOFBcJdHLoKlcEWitP2Xn6NTVRkSH5Gc11mj+hXxUwV+7c8DfT4HvRgXF4ArLFQAphOBEMnUhX9aHa29JFMm1MOPhyVt+qHIw20aPsXx227VHkLz2zUAGIrm0I1SEJKsdEkNRWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OIZ2/Vdbnuyf2BDTvGcZucol+RdXPAIeDogmhRFl70Y=;
 b=GCmwAM78fawO5Kzfbx3XVNlmr4kxJa4Dm/f3y3DWeNntXwO8gKvmYKS4TbdBzRyGZtugCdr5IUQPdwhUjo4F9iQE8AOEhUvzhPfa1xjBpHHp2eLK0OGt/AR7AEz2fnwqAy8iUXvf/M+6DyymanBrZxOgJEmdS8nudeAAlOI4B+6gN7K7JMupIZ0JuM9n+FK8K2W++bR8+N2Wg9n5gWWmdzd8sBsx52XwtmXaYCSnRk760tFlFm3eXstMAwYilHygVJGPZc6nenRJPHcfQOtqCykRVp51Z8Xgf8vx1uPwAjXWxbrJEIPiIJiaZbPftUFjVxF9E8Wfc5Mu6KAQ48VNrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIZ2/Vdbnuyf2BDTvGcZucol+RdXPAIeDogmhRFl70Y=;
 b=cPSxYwzH7Qt4mx0AVuQRZ3DGsb63AXe5hOhUGp2R459p2uK4AYlfla1AmfZX1OUkCdW+qLi3U+OdGoCKfnRzjJJsEaD+ly3W4v67pHWZJ9AMJYa1HE66JKo0djYU23QF/wTDa51ObuuBMXrgbhVwxCKHONEqixOvQk9TEZ3sjGY=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by LV8PR10MB7774.namprd10.prod.outlook.com (2603:10b6:408:1e8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 17:07:33 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 17:07:33 +0000
Date: Tue, 6 Feb 2024 12:07:30 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com,
        david@redhat.com, axelrasmussen@google.com, bgeffon@google.com,
        willy@infradead.org, jannh@google.com, kaleshsingh@google.com,
        ngeoffray@google.com, timmurray@google.com, rppt@kernel.org
Subject: Re: [PATCH v2 3/3] userfaultfd: use per-vma locks in userfaultfd
 operations
Message-ID: <20240206170730.6ebxhl4jvvfmqjoz@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Lokesh Gidra <lokeshgidra@google.com>,
	Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com,
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com,
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com,
	ngeoffray@google.com, timmurray@google.com, rppt@kernel.org
References: <CA+EESO5r+b7QPYM5po--rxQBa9EPi4x1EZ96rEzso288dbpuow@mail.gmail.com>
 <20240130025803.2go3xekza5qubxgz@revolver>
 <CA+EESO4+ExV-2oo0rFNpw0sL+_tWZ_MH_rUh-wvssN0y_hr+LA@mail.gmail.com>
 <20240131214104.rgw3x5vuap43xubi@revolver>
 <CAJuCfpFB6Udm0pkTwJCOtvrn9+=g05oFgL-dUnEkEO0cGmyvOw@mail.gmail.com>
 <CA+EESO7ri47BaecbesP8dZCjeAk60+=Fcdc8xc5mbeA4UrYmqQ@mail.gmail.com>
 <20240205220022.a4qy7xlv6jpcsnh7@revolver>
 <CA+EESO6iXDAkH0hRcJf70aqASKG1eHWq2rJvLHafCtx-1pGAhw@mail.gmail.com>
 <20240206143506.6zsj2gktu754gvl6@revolver>
 <CA+EESO5H_f-APVpg1wgJEHjcMd4ogRUX33j8n=_nz4uTQW78uA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CA+EESO5H_f-APVpg1wgJEHjcMd4ogRUX33j8n=_nz4uTQW78uA@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT3PR01CA0072.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::35) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|LV8PR10MB7774:EE_
X-MS-Office365-Filtering-Correlation-Id: c7db79f7-38fc-4944-c201-08dc27361bdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	UHPbVJhe+oxfeNSysNbwz95PLQWeShcUbaqKc8/taNOdB3ZWoAyCeZpnJsgLs0PP5aVzA3X4FkTSdUC1SbskPsZSceCG9TDQmCkrlJMjz9SY/++bovmZ58pTMipFLMQUdvndhECqcvGHB0vbyPetQvOcc3ir00onv5nDiL0ZaXTPee3xYFG/UIaY8LpmRNIF/ltBPu317fRoZaK/QkKL2zeEyJz7A+GekuJSGKO4buJJaO7H33L6nbLJyYlUQW/62zvyx2LcT6VqoKoVNCuSlVe0xuNh5ISRfj/iKsGWC/QAlQj75yKVZbzxF/sDpWLhfGY9rak4WoIQRTnAUXTbI3hAAS1Tn+xka4jLfCN5eSLVRxkoCqVOP4T+BQLoNVADjtt4oqvU+BPlGR2DWY0jG9fRD7oD5iywZU8dAHZLJQV4ewL+AOBvniKojrzNO8NOr4GFoAF1S7+6bhDKucfWQ1Io+m2wXkaXfXFgmxSt484euLcU2dMqZgs8kuJ6KuhdVt59GbI6ishJ5FesM+kCN4ft4x121US5S60t0xzYT1h5OhsML+jityiffRZNI7sq
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(366004)(39860400002)(346002)(376002)(396003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(38100700002)(6506007)(53546011)(83380400001)(26005)(86362001)(41300700001)(1076003)(33716001)(4326008)(8676002)(8936002)(9686003)(6512007)(478600001)(6486002)(7416002)(2906002)(5660300002)(66946007)(66556008)(66476007)(6916009)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VSttV0thUWxQVU5wN3FQVzNsQ0Q1a1ZjaUp0b2lneG1hUmE5RE5DaGlBaG9Y?=
 =?utf-8?B?S3hKNGVmRGpWVHlWc1UyMVg1QWoxWTBnZjR0RHNrTGpsNmxENGNrVDJqOTFv?=
 =?utf-8?B?RnVGYkJOZkMwcDVvZXFQMVJiTVRBVUh5WFNaQ0ljMkJneWd3ZVo1TThRbEdV?=
 =?utf-8?B?OVg5bE5QSjFvTDN6TzJiblVnTjJtRVdhK25aM2hhNUxiMHVVVTN0ZmZwY0NW?=
 =?utf-8?B?VVhseklWYzBSU0ltZy9aZVc3Q3BYY3lTVElDSkl3Yno2VWVJNno3a0x0eUpq?=
 =?utf-8?B?UlhuWHZ2NStwNnpsRWhoUFNlYnBhZmR3MnR0ZUNQZEdDaDI4cHdZemZZdTNH?=
 =?utf-8?B?dDNaS3VCd0Vzd0V4bkY2ZEJ2blVGandwQmFYb2FSQVdhSEtnZFF3di9kZWk3?=
 =?utf-8?B?dUpyOHFNUzVVVVkvdUhxanI2OCttdTB2MnIzYnAwNm1NZ1lqaGdDUDNNMmdZ?=
 =?utf-8?B?eDJzcUVUSU1nUHlHeDY4Q24zQnZ4NC90UnQwVmxyb0tlaFZsT1RnZkUvU3dq?=
 =?utf-8?B?bWI1T2dwMmMzNjh2eU1QTkZORzBTUFdQK1NReFZkM1JBRlZsU05NTHo0VEs1?=
 =?utf-8?B?TmUrUmVtZ3BqWXcrQ25YRk5SV3VOTmx1WVhxN1VTS1BqT0tkTTQwc0pYRFBM?=
 =?utf-8?B?UklIT25ZWlVjTDJPU09BU3AvWGg4YkEvRnR5RkJhdHBDWVhWUUJLakgwV1ZM?=
 =?utf-8?B?RlhoMXRiL3hpQ05Qc1ZwT04wTFBpWGJlWnNBZldpb3owNzdZaDB5NTZkWFFa?=
 =?utf-8?B?Tzl5RzFlY1FYSWtMSFR1NHBSaHo2a0EzYTlHREE5b3MwQ3MyWm9CSktLSXBy?=
 =?utf-8?B?eFlQNW9lNVdzb3hmd3lnMDhucDB5S0dFZ1Zabko3bkFobGZRWFBBaE1LaFVn?=
 =?utf-8?B?VkZJWUM5ZWx2R3d5TFpJbEwwUGhGVTRydUhuTDc1VUVuV0ZhTXVUYi9nS3dj?=
 =?utf-8?B?Q2JORE82NUNxblJjZm96cm14bGRlM0hIN3pQdmErejZLSWN5VnhFM3poRlh5?=
 =?utf-8?B?T2NXeUVKeXNRVmRlTjZ5dUpzcVh4OEJsYU5oUXNlWExRNHYyMHlsOXdMcjhB?=
 =?utf-8?B?V2VRdFNSMXI4cHkvZlR3VlVvVjg4a1JZQW96TWhXbnpKQTJodVZsdE9pTUdk?=
 =?utf-8?B?a3FWaGpJTkdwNGhoMWgzQTBsVCtoSkdibzhiMSswNjdBQldrRlZxWGdhakx1?=
 =?utf-8?B?aFJCRUdVWWI5MVBGTGMxdFZpako1VFZVQVFRV3c5YnA1S29CYXZ2dmxyRkw5?=
 =?utf-8?B?ZnV1aGk4SDVkcHVaM0dHTnd3cVhac0JRYzQrRTJ3V1VTTXNSWjFvNTZ2elZk?=
 =?utf-8?B?Y1ZBRjF1MitQeVFJYkdqdlZqemRWRDE4OXpvMzg2SkRSaHVMaXoxeW83WFpF?=
 =?utf-8?B?bUJJL0U3b0tRcDRzUGZnYVJrdjVVK3RnU0xBNHlja3ZoN1BqYitpc05uRjJi?=
 =?utf-8?B?Vk5tTTVtTEFaUnFxSkNGaTJvOU84c3BuaTVoNWNtdExFd0N2QVFYeElSL2g5?=
 =?utf-8?B?MWFEdU91ek9zN1lsYmVUSndoREtqc25oQTdvTURjYzlmbHJ1Sitxd0dpcFo5?=
 =?utf-8?B?MVZNOHdUemlITkxwTitTcFlaQUFpVm9kcXZLREc4bHZ6U0tCM3ZQRUVmWXB6?=
 =?utf-8?B?S0MvbGRmT0g2UkZSL0lsTUdXMCtCVjVVMWY5cFZpTzBWb1RDWTgrcnhxM0Fr?=
 =?utf-8?B?bExmcjI4NUZxRTJtYWRDYUUwT0NTRWRmSXJ4a1M5elcwVWV1b3J1M0cxV3hZ?=
 =?utf-8?B?WndaTFZ4KzhRb0xWUEV2R0xaZGhGeWpBQS83RlBobEhWTzcrWUJYajdFdzJJ?=
 =?utf-8?B?NWUvVjhac3JPMVhQM0hzb1JIM1FPaEh3N1ZWaGk2YTRMUWJZQlk4TW5GZHR1?=
 =?utf-8?B?YmluRWs4TTdQcUJxeGVKYk44VmMvbVU0T1UvT3JqTUtib0psRy9JVXNyNHVy?=
 =?utf-8?B?cVFoQUFycTkvS01aVVdvQ0F0YzhOVjRJNWlVdlp1L051M3p5S1hWTlZzQndM?=
 =?utf-8?B?UThPcGY3K2p0YVVUSTE5bE5QNWVTc3kzOGRlbkdYLzBPYzVQc2pvT3FDOG9N?=
 =?utf-8?B?SDlTdnFjREl5OXNtSFp3UXNYTTlGVXN2YnJJcjhGK1A1UWtpQ1plTEhJNzFD?=
 =?utf-8?Q?GM0CSXt6Y2o5x8L4bV7ieQcAC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	RQ3SH4oxYVToY6qPNeo5F8VfDTjobUhgFg7MJm09mVDclFpzA2CAdOut/Pw5VE+CKwaSkW6PxR4Eer0NVvh5ECnAwl0LOSIOvZ+QCdufZV35PA1BgEzG5CP0alA3rQMhsWM+HhWB9ISM9BfEhGSBCy6C1fliFUoPxMVX/Fa0DPidrL13JBLk4SBWqywHRSZHUAJWwEyFLW7Q57PK5rZpVEbAORgJAeKDsxmlnkDW4Cmf2X0bH+GzkqZWnh2R0b7491Ro4ZrHFuGdsGo5MozCnE5Y3QhVFtOzwdH3dEGr4AkJ4rwGUjpEpV9YanFwN6WHRv0Bx6F+ZKdQlsWVoSu0P5LJfjLpfgzzIqSK1XOCpC+jx88IC5xld+RlQdqtvqDVmztl6SyiXw4cf/m0nL8mFQAF2/BVeeHJ4w9wEXH+QDpSrVUUdJ+GBNnS3x0T7xT/TM6I/BANPzIhm+Gv5sDFVrUk0PVBteS7QxNyjznzJoosVF2JMpMflR8RCiWVk/EERcapjV6qUWtpoz8ez1dQ3E4wSEl413tSVgiMkLJEyHXSA64pTv+FImDWODmMi/63//3W0B5ju6dVLA9FUJOaYq2u6snOqM2PZriLWXpLRcs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7db79f7-38fc-4944-c201-08dc27361bdb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 17:07:33.0126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9lshYUZtHWyY3W4xd/+3hgRTO2Y202BK1/xDNbVby0lzjT75DZnq9x2kODWxo0Zj5c9WutKvSuH4/jLl9bwSUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7774
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 adultscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402060120
X-Proofpoint-ORIG-GUID: -G_yO9C7X3pEbFoiXE7BlaeXLhklgEfa
X-Proofpoint-GUID: -G_yO9C7X3pEbFoiXE7BlaeXLhklgEfa

* Lokesh Gidra <lokeshgidra@google.com> [240206 11:26]:
> On Tue, Feb 6, 2024 at 6:35=E2=80=AFAM Liam R. Howlett <Liam.Howlett@orac=
le.com> wrote:
> >
> > * Lokesh Gidra <lokeshgidra@google.com> [240205 17:24]:
> > > On Mon, Feb 5, 2024 at 2:00=E2=80=AFPM Liam R. Howlett <Liam.Howlett@=
oracle.com> wrote:
> > > >
> > > > * Lokesh Gidra <lokeshgidra@google.com> [240205 16:55]:
> > > > ...
> > > >
> > > > > > > > We can take care of anon_vma as well here right? I can take=
 a bool
> > > > > > > > parameter ('prepare_anon' or something) and then:
> > > > > > > >
> > > > > > > >            if (vma) {
> > > > > > > >                     if (prepare_anon && vma_is_anonymous(vm=
a)) &&
> > > > > > > > !anon_vma_prepare(vma)) {
> > > > > > > >                                       vma =3D ERR_PTR(-ENOM=
EM);
> > > > > > > >                                       goto out_unlock;
> > > > > > > >                    }
> > > > > > > > >                 vma_aquire_read_lock(vma);
> > > > > > > >            }
> > > > > > > > out_unlock:
> > > > > > > > >         mmap_read_unlock(mm);
> > > > > > > > >         return vma;
> > > > > > > > > }
> > > > > > >
> > > > > > > Do you need this?  I didn't think this was happening in the c=
ode as
> > > > > > > written?  If you need it I would suggest making it happen alw=
ays and
> > > > > > > ditch the flag until a user needs this variant, but document =
what's
> > > > > > > going on in here or even have a better name.
> > > > > >
> > > > > > I think yes, you do need this. I can see calls to anon_vma_prep=
are()
> > > > > > under mmap_read_lock() protection in both mfill_atomic_hugetlb(=
) and
> > > > > > in mfill_atomic(). This means, just like in the pagefault path,=
 we
> > > > > > modify vma->anon_vma under mmap_read_lock protection which guar=
antees
> > > > > > that adjacent VMAs won't change. This is important because
> > > > > > __anon_vma_prepare() uses find_mergeable_anon_vma() that needs =
the
> > > > > > neighboring VMAs to be stable. Per-VMA lock guarantees stabilit=
y of
> > > > > > the VMA we locked but not of its neighbors, therefore holding p=
er-VMA
> > > > > > lock while calling anon_vma_prepare() is not enough. The soluti=
on
> > > > > > Lokesh suggests would call anon_vma_prepare() under mmap_read_l=
ock and
> > > > > > therefore would avoid the issue.
> > > > > >
> > > >
> > > > ...
> > > >
> > > > > anon_vma_prepare() is also called in validate_move_areas() via mo=
ve_pages().
> > > >
> > > > Probably worth doing it unconditionally and have a comment as to wh=
y it
> > > > is necessary.
> > > >
> > > The src_vma (in case of move_pages()) doesn't need to have it.
> > >
> > > The only reason I'm not inclined to make it unconditional is what if
> > > some future user of lock_vma() doesn't need it for their purpose? Why
> > > allocate anon_vma in that case.
> >
> > Because there isn't a user and it'll add a flag that's a constant.  If
> > there is a need for the flag later then it can be added at that time.
> > Maybe there will never be a user and we've just complicated the code fo=
r
> > no reason.  Don't implement features that aren't necessary, especially
> > if there is no intent to use them.
> >
>=20
> I'm not too attached to the idea of keeping it conditional. But I have
> already sent v3 which currently does it conditionally. Please take a
> look at it. Along with any other comments/changes that I get, I'll
> also make it unconditional in v4, if you say so.

well, you use it conditionally, so it does have use.  It was not clear
in your comment above that you were going to use it.  I am not sure
about the dst/src needing/not needing it.  If you have a user, then
leave it in.

Thanks,
Liam

