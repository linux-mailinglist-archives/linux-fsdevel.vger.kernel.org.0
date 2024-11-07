Return-Path: <linux-fsdevel+bounces-33912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE939C092A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 15:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 922331C23767
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 14:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B5F21262E;
	Thu,  7 Nov 2024 14:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bWGU3Ddm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fn6FjDfu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D022DD26D;
	Thu,  7 Nov 2024 14:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730990743; cv=fail; b=miVdRuYMpFEktqUzRhaRzYo6L+nLtfaSLVKauvGfzBUbNJ3fs6DJCo7cQuQJ8FhK6BYqaFaueqwd+58JycLotovszvMaTliwgXXWvUxSdGcZppFralzutZL4p+kXDW6T2NXhZGsMOCWfnAoQ7xLfXJWnwPWczgtkKYDiTZIiOuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730990743; c=relaxed/simple;
	bh=1v0eDtAoYM2SNRKFVLy5AA2TBcUpvbPbqQgaO61V5eA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aMLRLkQaylOjIqqrndb49t6/+xoD3iuA65a5p9B+kiDEOjyH734uIIZdpa1Jx8rp7OVBmkoib9veu/gmv/k80MmOEiOGwDwpGL+97Z0gxNyGNQ9gAYZ4xnJUt1n/S5hrCn8m4Yb4x+BSxA17zeAcbQEKDlD1UYl1gpHAR2OvecY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bWGU3Ddm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fn6FjDfu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7DHa0C025085;
	Thu, 7 Nov 2024 14:44:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=3F1RjXuxhzHFGS0RRhRByyivHvg/iZhQ699VlUGCFAw=; b=
	bWGU3DdmkkTDhxRZ0y80AhG0ooELEjeITuu/CSuZ2kZMd/nxFR1QUuPuGoFU6yML
	sB1ZYuZgh8Jc4L7TnezP9NfxrpPZFh7w/GooU8wxZkBLQ90RrnN4l2CCfktbtKgB
	zTyUrwFLHyPxBZ3vBXzUExQdB7YOYOCqoW8RDNmTV8D6XqRMcGh5iNACXA+gebf6
	Om1HwyqSMScNoy8c8MwsrE2+TuUxzbb8B0QeaRhs4NUhjzC/CSE6vQBFryNR5cvt
	AQbm5kN+OfaREOxrQa8Bk3vlG6qQ1IvUdNf4Cjf6lP9YhnxJeiLOdoVRTVG1w0a9
	IgiauR3IY51aoV/wPiiZdw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nap02p1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 14:44:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7D8xE6031461;
	Thu, 7 Nov 2024 14:44:33 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42nah9tjd4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 14:44:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FKMxGeD/y5W0YkXMsmCFaCVua3b2MCb1MMSO/Zl336Nlywz5yfHBUnBjZFve7ea80ioOIp6WaxvcXB1BZBrrP6BIuhJJIiXFkzicAm8hIcsdM1Sb9iHWDSJ3f+sVS4rDfRFAeJgUu0qgVmw7dHxoYj2ZChLEefsiZJ4LNBMGxPrjVqVd0enG5VDeC28wDN2CfEXJODThQoMWRicV88dh5/eJTwKAX4shAd8RW/7yqVLsEOj+XU7J+JKCyhgkyEND4eFIwFk0KVPDG6k6CP3DoPYMup8w/jEjGq9IjXKWhHecIt3gz24iejIf4MQPcNWMUVt6+Hnp54iZS1CM9MzJqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3F1RjXuxhzHFGS0RRhRByyivHvg/iZhQ699VlUGCFAw=;
 b=zDnDkPcPUk4UPheFTHQI/Mc7e5qTmuwuHq/rh7ok6nIxfDbIgkHpBWoSOLsO7I3IZ+CfMA4RbrdDPPMwoMnJOulbcYr66f5bFkX8wcafDROaEgONLeY4nhPs+m3PcINNw2wUVOPDnUj1iasstgmfXsbWNeCqMo8RFXT1vxNxOuQnYmRrN739T1V9E8tLWfuHC4nwso93vY5QSaNGwOJNoSPHVnVQwrLlnsixNVcxxr3ETGsTTzVtfO+hqNPb9vmei8eTzBf5tl3bjJGhqknSCb6U1x43KBj+Z6m3dv6q3yV247VLjld5ATTuKnijzpsgtw7p6lOA//SvvgnYdUniAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3F1RjXuxhzHFGS0RRhRByyivHvg/iZhQ699VlUGCFAw=;
 b=fn6FjDfuHnpUFr+1p2eMK8NmpLK3guRzNovoNNfkPB7EAjJFRE8HqJdunRUN9lQdjfcQRyiDI0N0a4OqB4WV0vfBcNzCx6/NBFReqCu09XnCjP9AH+VpX0ueNcK4rKG+TncjDBsjbQaQrRU/0HCE1Ojst03MAWgaRwRVCm99yQE=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH4PR10MB8049.namprd10.prod.outlook.com (2603:10b6:610:240::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 14:44:27 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 14:44:27 +0000
Date: Thu, 7 Nov 2024 09:44:24 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Chuck Lever III <chuck.lever@oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-stable <stable@vger.kernel.org>,
        "harry.wentland@amd.com" <harry.wentland@amd.com>,
        "sunpeng.li@amd.com" <sunpeng.li@amd.com>,
        "Rodrigo.Siqueira@amd.com" <Rodrigo.Siqueira@amd.com>,
        "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "Xinhui.Pan@amd.com" <Xinhui.Pan@amd.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Sasha Levin <sashal@kernel.org>,
        "srinivasan.shanmugam@amd.com" <srinivasan.shanmugam@amd.com>,
        "chiahsuan.chung@amd.com" <chiahsuan.chung@amd.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
        "zhangpeng.00@bytedance.com" <zhangpeng.00@bytedance.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
        yangerkun <yangerkun@huawei.com>, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH 6.6 00/28] fix CVE-2024-46701
Message-ID: <epkfxxakvk5bsiucbfvrdgjcndpzumabljuginymvviv5edpxg@czr5gtkzxjyb>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Yu Kuai <yukuai1@huaweicloud.com>, Chuck Lever III <chuck.lever@oracle.com>, 
	Greg KH <gregkh@linuxfoundation.org>, linux-stable <stable@vger.kernel.org>, 
	"harry.wentland@amd.com" <harry.wentland@amd.com>, "sunpeng.li@amd.com" <sunpeng.li@amd.com>, 
	"Rodrigo.Siqueira@amd.com" <Rodrigo.Siqueira@amd.com>, "alexander.deucher@amd.com" <alexander.deucher@amd.com>, 
	"christian.koenig@amd.com" <christian.koenig@amd.com>, "Xinhui.Pan@amd.com" <Xinhui.Pan@amd.com>, 
	"airlied@gmail.com" <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Sasha Levin <sashal@kernel.org>, 
	"srinivasan.shanmugam@amd.com" <srinivasan.shanmugam@amd.com>, "chiahsuan.chung@amd.com" <chiahsuan.chung@amd.com>, 
	"mingo@kernel.org" <mingo@kernel.org>, "mgorman@techsingularity.net" <mgorman@techsingularity.net>, 
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>, "zhangpeng.00@bytedance.com" <zhangpeng.00@bytedance.com>, 
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux FS Devel <linux-fsdevel@vger.kernel.org>, 
	"maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>, linux-mm <linux-mm@kvack.org>, 
	"yi.zhang@huawei.com" <yi.zhang@huawei.com>, yangerkun <yangerkun@huawei.com>, 
	"yukuai (C)" <yukuai3@huawei.com>
References: <20241024132009.2267260-1-yukuai1@huaweicloud.com>
 <2024110625-earwig-deport-d050@gregkh>
 <7AB98056-93CC-4DE5-AD42-49BA582D3BEF@oracle.com>
 <8bdd405e-0086-5441-e185-3641446ba49d@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8bdd405e-0086-5441-e185-3641446ba49d@huaweicloud.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0417.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::21) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH4PR10MB8049:EE_
X-MS-Office365-Filtering-Correlation-Id: 3353ed12-408b-4b96-141d-08dcff3aae38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZysybHhVemZCSzJJZHRKNEx4L0o1dXZBNVdla09VSUJ1OFVKTXJBQURRSFNM?=
 =?utf-8?B?V1hWRzBET3I2ZitSMjdMTUhubTJMVFlYWVNLSTFaUWo2NVdueTdaUkwvcTMw?=
 =?utf-8?B?dlhrb2JRWkt5cjVzRGJpajdFbDZYbGZjS2VGL09yNVZoNTdyVkE4M29xV08w?=
 =?utf-8?B?SkEraXFBbzRDK1c2SkZyakFncjFCNzVrUjQwSVl5MXVkZ1NaVUpiYXZ4MjZ5?=
 =?utf-8?B?Wll1c2ZmdDNiaE1zQzN2WmhqeXRNQjFYb3JVelBPYlJEYUpsMWY0TTB1b3Ey?=
 =?utf-8?B?ZDBpWU1zaTZiRHBDMTdLcjJyNHJkQUhQMVo2ZHBlaXFUWE5JUGVjNENuVktD?=
 =?utf-8?B?eDVKdm5WVUx4RjlrT0o0bHRmclVISS9BWjBFV1VTaFV6bGxSellteGJrWEx0?=
 =?utf-8?B?T0VDcTRhR0JtS3llZzNTL2s0M1VNa0NlZHVvTlc1T01PcFdIQWd2eVBQbGxk?=
 =?utf-8?B?d0F1TlhqWktHN2RiZG5uY1M3MkdwS0JqYVlsMlBvYW1RWVBzVE1aUWJIazNn?=
 =?utf-8?B?UXJtcU8rdkRFWjJkWkdwZUQrdG5UOUxIMXB5UDZSQ0hhZFZoZEZUY2RZNjlT?=
 =?utf-8?B?dGFzSlpMRTl6WVE4OUJ1Vk9PNllEQjVlZkEzbm9rbSthTU9QNmdlcXFIb2gx?=
 =?utf-8?B?WkZta1JsclhDcFlLMVNUdmthQjB2OXNBSVFsVDlVa09hQ3l1NHp5Z0ZQOFR6?=
 =?utf-8?B?bDRJSlYzTmR2YmdXTHNOM2FhT2M1aTVjUmh2Uk12Z2Z2Wk1OLzhCS2YrWTdE?=
 =?utf-8?B?RXhTeTV4dkdLTnUrdW85VmNyeGZYUm5uTThNRjBIRXp3YTFSQnpaRkI1S1dG?=
 =?utf-8?B?QTltblVmeEx6VWhrZlQrMU1RbzhWcmJkQUd3eE14Tm1HZnBWY2V4U2wxRHF2?=
 =?utf-8?B?ekJQT0o2ZENmUjQvRURrQkVLaUxPaTFtUzR6TzN2c25pckNGdEZZanc0dnBN?=
 =?utf-8?B?L1d5WmhDNVlFb3daRnVCdkhVVGorQmVEeEI3WFNZUVZYcTA5WS83M0tFdzAy?=
 =?utf-8?B?MDNTNG9LSDJTaWRmeXl2TWtEbTJ5WDdlSk9kUFVFeGhoNFpIZk83ekdJNjZh?=
 =?utf-8?B?RGgwM1ZqK1psUVVEdTdNZXpaUG5LNlA1ZHdoL1N3MXA5cnNKQ3RYMkROTWJ6?=
 =?utf-8?B?OGp1THpjTmZBTys3YlRTMkxUS2xYZ2ZnRzlPQUFSVm4ySnl3M3ZreXpZOEIz?=
 =?utf-8?B?Q0poOVpFb0MrbnJWUi9mWGJCQS9HdjNwRVQ1d201aU9scXoxT2dkbVRSSWxi?=
 =?utf-8?B?QXhUTEZRT1lEeXdEVkJZSzJMSCs3M2V5bEhTa0Eydmx3Z1NUZWxwa3AyVWZF?=
 =?utf-8?B?SjlOaDQ1TjhqbWpuekxueWcyZFNoUVE0Y1ZXMFhPSytUZTZxSVBCSzhZMmNK?=
 =?utf-8?B?dUFRM3VBOUVqTGNBZ2dYb2FUcFEwajErNVd5VWc5aEdxY0NqeGVxR28xTS8y?=
 =?utf-8?B?V25zSWNUMmJZUnJxNzg4NTlqSWZyUTlyWWNvRW5xdTB6eFJYK3ZEUzUwejU1?=
 =?utf-8?B?MnNrUmIvdUIrSGFyL01zU203ZGRzdXYveENDY2lFVnR1bmFtOHZad2xBVVNT?=
 =?utf-8?B?VWp1bnhSNTZMdFBZa1pvMFlJa2FVZ1R5ankyZDhtVkdRbm5IWGhUTStVYmpW?=
 =?utf-8?B?aXl4a0xUUzN5ZUk4Q2o2aDNLekxpMWZOVmhRUGIzR2hWZkdMWGtYbGdCU3lV?=
 =?utf-8?B?SE41SGJOcVJJUHp5Vmx6NGladjBOeVdFTFE1K3lkSU9CVHpvc2hjRHBvQ0w5?=
 =?utf-8?Q?dnKH36S+dLRDooEclvFhLWhTMn1RD2jsTI3RNNR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K20xTkFpZnNzcURnMXJvenNkTVdYdFlGVVh1SnJPSnl6TVVOQUxJaWJMT2Zu?=
 =?utf-8?B?RWkvQ0hBbTlaWDFzeGZpZnpEZE5iU3NmQWFFQW5mNnB0b2JHcmRtak1JbmVy?=
 =?utf-8?B?TGNqM3J6YzBFSkxQSGNjb1plYzFPVUNMVHBjem9tcE0xZzhJbDVIMzlJZFpp?=
 =?utf-8?B?Z0l0dnFRSU1qenJhWVRzYjc5SGZEQUs5U0hjV0R3YXNXSDhScDZxc0Zpby9k?=
 =?utf-8?B?Y3V3b2RWWUNmaFpJaVhTSXNhVjIvZzQ4SFkzZnZyVmJIS1Z4TExSZVJuaEpn?=
 =?utf-8?B?YTk0dVpja0NiTnlzQnVqdGlHOWdqZVhUT3lyVHdrYkR1Wm1UbmhjbzduclNs?=
 =?utf-8?B?SkZTVE5PNWZiOWV3SEVtekM2bEVIL2FMOGNZOEVjZDR3aEw1a3VTT2V0QjZv?=
 =?utf-8?B?bnBiTGhaQnVMWG1oeDJDTkZpdll6THlBa2JzTEp6WW1CQVMyTmJIbVRyVUZD?=
 =?utf-8?B?b0wxYW9rN1ZTRHd1NCsrazYyOE1STjBwY29jZy8ydFRUeDBuaWtWdU4wUVdE?=
 =?utf-8?B?YjhUMDRmRnVXdDBUU2pFdlExMGxKYllGK3ZCUk9aY251VmhwWHBicGFGTVlr?=
 =?utf-8?B?VkdrNW9kNmFOQXlibkdTSml3TFlGWGtiVGJJUXJaQlBEMmJvRS9tN2VWQWNH?=
 =?utf-8?B?Nml4akFzS2VSQ2FpZmluNGE1SVJUeFMvVXNtVWQrWmJEQWE1NWg5VWhlYTRF?=
 =?utf-8?B?RGc4RmQ4TXU4SEJ0N2ljU0EvY2IrYW9KaGQ4NERNZWdZVGFwMEkrRFQ2dERw?=
 =?utf-8?B?ZU04dFZBNGZ2UXprU0RvSU5Lb3pEb2gyR3NGZE1MTUZhU1ZNdzkvVUhVQTZQ?=
 =?utf-8?B?ZHRMOXNIKzFsMjdNbnJzcDNYZDBwV3lZVE1IY3BtOFZzYUxvSEM2eHAzR1V4?=
 =?utf-8?B?VTl0NVVqcHhRQ0hFa1JMWEl3VllqZVlzbHpzVmg4bHVGNE5qN0FqcGZ3bDdD?=
 =?utf-8?B?R3lub1BOZjJsZjhpSTlXeW9CN1FXcmlOdm1sdzBWRExCSDZrM2dpZGVUcXFZ?=
 =?utf-8?B?SzJVWm03WnRkSTB3WVh4UjdEdXpjeHpTY011VmJFWEpNNlB6WFB4T0xSNncw?=
 =?utf-8?B?WW9INGRpTjdGNGVvSTQ5RWd0bCt2YnJUVVRiM1hWdldYUmVwTmFDRTdTWDBB?=
 =?utf-8?B?SW16SldXZEYzdzFoUVgwZG9VTllocmZvUmhLR1J4M3FEa0RQOTZ0bHBkWUR2?=
 =?utf-8?B?cDZNZkVBSTdaRU0weDBTOXdoM1ZnUk9iVEdES05mZW1IVFBhK0pOMG9Za0E5?=
 =?utf-8?B?aS9wdUhEcGhLYTdDNmV0VFdNVTBGNlJGMkJ5RDcxL0pBaUUrSURjWXVKS2tO?=
 =?utf-8?B?MHYyUmNaT0wyQTZNWXp5bEtualN2MG9yblhZaUdzZXdkQWZzZ3MxNmtlR0RJ?=
 =?utf-8?B?cG04ODlEN0ZiS094aG4vdEhZbHJHQWtYc3Q5ZFpwTkY0K2Z1L3JGL1Rhc0g4?=
 =?utf-8?B?b0tpVXhFRGRXWmN6QS9NWE52L2pKRjVPTnVKTGdLMSswUDRHYjZ3Y1FYcnRo?=
 =?utf-8?B?MXZEMDZaaTFlY1BxQlA4YlB4T0cxKzRpOXhyRExVV2xSZkxGaTczTldEbmx6?=
 =?utf-8?B?QUc0TmE0cERVRHlXeS9Wcm1FV2hnaHI2WERHdVFDZXNnTlI0Z2NzK1JDZGNJ?=
 =?utf-8?B?Mk93b0VQUVJ3b1hYQ1NuZ01qYThSeHlrR2NPYUkxOUtmcng0a0huRi91QkZQ?=
 =?utf-8?B?OG9uUGRyTGVveDdoUmdPWmkxK0c3N0R1QTgzYnhLdUdIWG4rdFdKNDRmWE56?=
 =?utf-8?B?aTErU3lHSjUreTVaRXA4NmtKZWFrTW9wNU16TmNCM0U1RkdPcXZQK1ZkQ0M1?=
 =?utf-8?B?MzgvejBScWVSelk2bzJwcHBWcVl5c2ZvNklEWER3Zjg0T1Y3bkZIUngvN0d1?=
 =?utf-8?B?akRTZjdLamtzbjZPZk9oeXRvajFlVFQrNlVtZmZDR3loMnRSTVd3bE50VEtz?=
 =?utf-8?B?QTVUUzFBVk1qZjdmckRkODRjYlUrN0kwQTlrbWcwbjI3bFJoekV2djhpSXlv?=
 =?utf-8?B?KzFOcWlwVDZDZFpza0hLVk1kZ1ljRFh6M1o0NG55TkV3WTRxZ0s4K1J4Y1Nh?=
 =?utf-8?B?M0tFNE93cTZzZG0wT2V3MFQrSXQwNVdRS2ZsSHkvUHVnclJTUGpQY3puMTZv?=
 =?utf-8?Q?EFYans7qqg5fGR1C+XrQD6pQx?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GIetk7smwAK/nWxxeXVh04ny4x29QM1fQ8Ei8XOCGxtweAzzmMiDPZuLrPwjdxpXV/sN/Kho3kTb0cuA80m5vh0/zhX8oCh0b8jBgfeOvruSzq38J7geu+Fq+BTA26SC9Wa5hsOi2vljk/eGJnEA11H8cpvpucw0KdXoWdo2LyNb0IFMr8TRgIdxb4RHgdV/EnuYSS2yJVYA/14gDt5ktmWjKuQEGGbeeiOPrrhLaogUYCwVYGMG2GWqWBge69HfPR5i299+8Z4OJKqsrdwE5TlDDgRabkOc+TZen7GDWXbHTzl09+mgFrzvixLq1Dhjitku/ujqBlnA5Chu4wz20UdWDe0sB/Ov5vnCu85qbpWnw2Zfn2v2+i6XmSgB2xa5wYBoZuRUApDR6acMuIGB3O6P1Yfa5oSvv3aImChQaffnetixDNA8yQBT5VY8oCTb3YRQpmGVJEh8aflgEuHfWCdMgFbmFFIM0COUAQkeK87jLwgDYhQdMtNYGtBKPDnV0cCYdImzxw3X7onSuyKtAUSRorc9D8HNuK+reFS9tJDhbn4pUrKXyrGYz7EWzJpLgpCKA5+JBa8GPGjfYNZls7Hk1pg8G2JbvIgoQthxCbA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3353ed12-408b-4b96-141d-08dcff3aae38
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 14:44:27.8094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1MaI0Qn1ZQzV5iU4L4G1q0Can7mzRe8FrU2aRWtB5fH2v9Osh8mCzpR2HA7DcKgs3IwtWDU+1MJSEsXG7s/I5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8049
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-07_05,2024-11-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411070115
X-Proofpoint-ORIG-GUID: k84hdgpxQbDeMH7bIF0CJmo3d_1C6PoQ
X-Proofpoint-GUID: k84hdgpxQbDeMH7bIF0CJmo3d_1C6PoQ

* Yu Kuai <yukuai1@huaweicloud.com> [241106 19:57]:
> Hi,
>=20
> =E5=9C=A8 2024/11/06 23:19, Chuck Lever III =E5=86=99=E9=81=93:
> >=20
> >=20
> > > On Nov 6, 2024, at 1:16=E2=80=AFAM, Greg KH <gregkh@linuxfoundation.o=
rg> wrote:
> > >=20
> > > On Thu, Oct 24, 2024 at 09:19:41PM +0800, Yu Kuai wrote:
> > > > From: Yu Kuai <yukuai3@huawei.com>
> > > >=20
> > > > Fix patch is patch 27, relied patches are from:
> >=20
> > I assume patch 27 is:
> >=20
> > libfs: fix infinite directory reads for offset dir
> >=20
> > https://lore.kernel.org/stable/20241024132225.2271667-12-yukuai1@huawei=
cloud.com/
> >=20
> > I don't think the Maple tree patches are a hard
> > requirement for this fix. And note that libfs did
> > not use Maple tree originally because I was told
> > at that time that Maple tree was not yet mature.
> >=20
> > So, a better approach might be to fit the fix
> > onto linux-6.6.y while sticking with xarray.
>=20
> The painful part is that using xarray is not acceptable, the offet
> is just 32 bit and if it overflows, readdir will read nothing. That's
> why maple_tree has to be used.

Why does the xarray cause it to overflow vs the maple tree? The maple
tree conversion was for performance reasons, as far as I know [1].

Thanks,
Liam

[1]. https://lore.kernel.org/all/170820083431.6328.16233178852085891453.stg=
it@91.116.238.104.host.secureserver.net/

>=20
> Thanks,
> Kuai
>=20
> >=20
> > This is the first I've heard of this CVE. It
> > would help if the patch authors got some
> > notification when these are filed.
> >=20
> >=20
> > > > - patches from set [1] to add helpers to maple_tree, the last patch=
 to
> > > > improve fork() performance is not backported;
> > >=20
> > > So things slowed down?
> > >=20
> > > > - patches from set [2] to change maple_tree, and follow up fixes;
> > > > - patches from set [3] to convert offset_ctx from xarray to maple_t=
ree;
> > > >=20
> > > > Please notice that I'm not an expert in this area, and I'm afraid t=
o
> > > > make manual changes. That's why patch 16 revert the commit that is
> > > > different from mainline and will cause conflict backporting new pat=
ches.
> > > > patch 28 pick the original mainline patch again.
> > > >=20
> > > > (And this is what we did to fix the CVE in downstream kernels).
> > > >=20
> > > > [1] https://lore.kernel.org/all/20231027033845.90608-1-zhangpeng.00=
@bytedance.com/
> > > > [2] https://lore.kernel.org/all/20231101171629.3612299-2-Liam.Howle=
tt@oracle.com/T/
> > > > [3] https://lore.kernel.org/all/170820083431.6328.16233178852085891=
453.stgit@91.116.238.104.host.secureserver.net/
> > >=20
> > > This series looks rough.  I want to have the maintainers of these
> > > files/subsystems to ack this before being able to take them.
> > >=20
> > > thanks,
> > >=20
> > > greg k-h
> >=20
> > --
> > Chuck Lever
> >=20
> >=20
>=20

