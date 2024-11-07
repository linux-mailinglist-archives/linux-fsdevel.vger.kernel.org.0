Return-Path: <linux-fsdevel+bounces-33911-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E61CF9C091F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 15:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A06CE1C230FA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 14:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DE6212D31;
	Thu,  7 Nov 2024 14:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UQXlKhL/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nSxvX7dh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A0B1E049C;
	Thu,  7 Nov 2024 14:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730990581; cv=fail; b=nlZDfrcJqc6If6e1tXualPcWdhErbVLbqZfOlTn5oTN9YTODjmkPRDkglUJ8F5bHZH9qF8Bhdmc4EvKhIvRVUdh4/HygGB408pYa5LgvJ8EUDoIaLofASkcukMfriJ9Q2A3AnpXWpqnPXUv/hEQEzFrrVBwFiBh7ow7OBvgvosU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730990581; c=relaxed/simple;
	bh=Q8R01RXGRQlU6xNgY1StZzp8K0LE+5m8Cpuh5+S0Gag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cLOzBF4ia0i+mI8JDPPgt5NU08gQCTCFfPO4xX4rCmywFH24vU+/EygMNyZj3Qg0WXDoopT6jEP2gOaXszYiMnfcSdbQE9phqaJ2KoMBaFPdgAWHcQrXH2AE4IQw0VI2c4b6MgURnvCXOhWuivJHzhAZULEW+Un281IOXz2Gh4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UQXlKhL/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nSxvX7dh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7DlNCA022889;
	Thu, 7 Nov 2024 14:42:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ayJHAg09b4e8LolXAmxGnynhXat2Q03U4FEkv5xq72Q=; b=
	UQXlKhL/z/T0bAjmh0BiRdPwoA3MfavyUTC5jplw2sYkZvWa+FCswZ/Pkrc8Z9Ou
	Llx8us4LlGBMqgMLg2uIP/UOwIA4bLJH+Qg3W68A9VHHXys/u91PH0AKBXA+d3RD
	+0TcevATh871N8cBsQ+DWgSiU4t3C34MidcNr8ZepaxQMBrR4puH/FO4qj82Oj/V
	F2IyFiLrNhoS/eNi+plegeP2VOQrMOqHgWhQrAtFc6Gr5vj+0wEfRV0iocbvzlRW
	4XVMKSPbxH3XrXQV5X0zl/pQIWd2hB1b6PPcyoWlgqxGrARToKLT6bdVQVqZDis8
	93BLuQu6XX6CwlLyPgYY9w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nagcan53-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 14:42:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7DpKLv009741;
	Thu, 7 Nov 2024 14:42:06 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42nahgdykf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 14:42:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l7ijI9PfO7rPxsHntAgTvE680c+MLuzI8Ziwjy3oRorlgLRDpI/aU6mUtOAYLt4OaEo6AvvLOB6GciidxeSY1JgtMM2TNOfmursfcspzGBsgO0YCJV6K5O4ZcEUogki1fG+7bDDnOo0G7dss69fDEK49PCIyYjQZtW2nWMYV+L+gCrPB2dAwy4ZfC7SIDPYGxpfFnbtkayPAk0Q/rl3vV8CetnxLGAXQXxd0F8YOAsPBLrOLlpzF/20jjR1GyLDTXcE8zTzGeQHqBBd8RNIQqaxlxXuM8zh0IGRLHpHRmlo42dTEFmv3aMvcwKSM/sZuFi/jdhcylGw9zd1hDbXcRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ayJHAg09b4e8LolXAmxGnynhXat2Q03U4FEkv5xq72Q=;
 b=JyIBSJp/p2iXR4SDALItaoCcXe5DsvQTT2xjldOH3tyKtZF2YWNAqSFhRSfoK5kSQ+iqd5bploVvprD5yMBQ8TzUHB9WemXK124tr/+JmJX2kq4h/lZDt4S68iyV/YbdntTwdAXEOYhuhUmrn4mZZFL9UHjUCGmGp1lwycB1B4lNTpFsqYQX5fOrwtjYRu2Q9elAy008AEaAUcN24WMRyClqR97TTyytKsq/y9YvQNWcsDvhiRs9osToY4GCXZ5Ae/rVoWlwUo9zRJPrPgj3B+E3SW+FLY+S9SLPH3YbzqxxAiIwYYKUa4mX2rj/iMCgxzJCQbA1DUC8IdSsg8/hUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayJHAg09b4e8LolXAmxGnynhXat2Q03U4FEkv5xq72Q=;
 b=nSxvX7dhcPs6j4i+8ucFgcs26XZG1we6G86ogpBdEgGcu75ANY0NiqFJg7inS8rUo5+oS9y9HadYs5Xk3H+GgMo/udMw1Gb2iggn9voDApOZHctRPHuoIIMrAVmsyf7EcVqitSDXxrkEQ6mQPwgsl/Os6WXzhQtk+2sbgxXOYIk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO6PR10MB5791.namprd10.prod.outlook.com (2603:10b6:303:14c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 14:41:58 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8137.019; Thu, 7 Nov 2024
 14:41:58 +0000
Date: Thu, 7 Nov 2024 09:41:53 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
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
        Liam Howlett <liam.howlett@oracle.com>,
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
Message-ID: <ZyzRsR9rMQeIaIkM@tissot.1015granger.net>
References: <20241024132009.2267260-1-yukuai1@huaweicloud.com>
 <2024110625-earwig-deport-d050@gregkh>
 <7AB98056-93CC-4DE5-AD42-49BA582D3BEF@oracle.com>
 <8bdd405e-0086-5441-e185-3641446ba49d@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8bdd405e-0086-5441-e185-3641446ba49d@huaweicloud.com>
X-ClientProxiedBy: CH2PR19CA0026.namprd19.prod.outlook.com
 (2603:10b6:610:4d::36) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CO6PR10MB5791:EE_
X-MS-Office365-Filtering-Correlation-Id: 597d2635-a94f-4616-7561-08dcff3a54e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RFlhNWRaVnZYQkdUV2I2SjlBNU1FUUdZWlFDeXZiaW5ybFZENnFzV2lkZU1W?=
 =?utf-8?B?bi8rb0ZwZVRYYkNieVlWMTlCNjFuRnlraVVqMjBMZ08wcXF6S2RUeHBHYjFw?=
 =?utf-8?B?cHk2aXYvSTZlYmNhenBxbnZEOXNneVlseDhyOUNaRXNocXozdWplUGdGTXMx?=
 =?utf-8?B?UEdFM3cvaTZ0UEJlOENTTmlzOGo0eW9YY0djZnR2TEx1V1NxK1lPdTRwUlM3?=
 =?utf-8?B?dE5HYy9EeEZqa3Y3WmdBWS82WUd3TVUxemF5THg3RSt6TFhSdDJxYUxaS003?=
 =?utf-8?B?dU9nVGJOZC9mdDdxd3phRHlRWnBJdmZDcS80Q01DNTl0dFQ2aEV4ZnI1a2h1?=
 =?utf-8?B?TmRZbkN3VnkreUdOTmNzZThnS1NkZ0RzcGR3YUh2MThyYmZUbmp6THY4bytk?=
 =?utf-8?B?VzljRDl5RFlaR2RJamw1RVpWVTZwQXVTMUt1NE04bTZOQWV0NEhpZTZWRk5T?=
 =?utf-8?B?WGVEVVZBdnNzQ2NoYTVteGFUZzlOUUkyeFAzdzNncGVtZEt4VVhjN3BQVU9E?=
 =?utf-8?B?cStSczhTWGFPdTU3R014K3U5Tjd6ajFrdUs4cytObDlkTkc4YjM4eHNYdTVo?=
 =?utf-8?B?azUxYlVKaHVzUzNJSHJyTEMxS2YrRVk3Qi9waExzNlRWdEJvVURhQ1NpSHBW?=
 =?utf-8?B?U3FPUHUzVm50NlJUZmJ2SjBwZWNyMnBQczQ1a2JCcmVkb0dLQlpDc3o5cnZS?=
 =?utf-8?B?bWFBS29jNkdPYVBLdVZ1N0FjT3FzeVRnRVZ1OXNGTksyL1IreWhnVmFobWJj?=
 =?utf-8?B?NG9xOXo1cGRSSnIwQjljT2ZVdjQxY05mNjlLUVdzWGVwaGZMTUlVUk9TRE1m?=
 =?utf-8?B?OTJUaFdzNDh4dHlZQWFUNTRvQzhQczUwSGVMYnQ3NXJ4U0ozMnBWeFNDcVRl?=
 =?utf-8?B?dUJXYXkyQkZkVzdpeUJxTVJaWTNVWGp0b0lYTUxDUjlUWkhzUTZzczhGYXMw?=
 =?utf-8?B?cjdReDhSeXArUzZ1OWpDTWdxWXBjc3dBdS96VkUyTUNkRmIrNU9rN1lZZVFv?=
 =?utf-8?B?UlMwcDBVZEc2Q0NGZFp6c0RWU3gvRVZSZHkvQUlZbVRwMEFEdGJIaTJKRk9U?=
 =?utf-8?B?ZldmM2E4Um93cVB5NEFXUkw5TlhzeS90TFpvRFhiMTlLS3dGaHo0Vm1OZG5p?=
 =?utf-8?B?RW1Uc0kvMldUNXkwRThMWS9JbHE1UGxTRzlxR2Nyd0Jma3lYbFpLNnhCMi9x?=
 =?utf-8?B?cHU2NXQzaDlRT0V1K0R6UmU2ei9waXRsVVpaZ1FnejA2Njc3N0xsZG8wN1Qx?=
 =?utf-8?B?STV4K0k2cDRQU3RiVTM1WlcxVzB1cjRWMWJaZlA2TzlnSkN4OFdINWhiaXpQ?=
 =?utf-8?B?MDlTZHR3SHNtZS9oYk5tVTh2Q2hIOGd0Y240N3lBazVEMDJBK0VCWTdNSkhw?=
 =?utf-8?B?QVM1R1RlNTRhOHIvVXJqelY5VXNQSjFJNnN4NjBJVjQ0N3RnUDJqZUhST0hQ?=
 =?utf-8?B?cUxxb1Qvb3hSKzhualQ5ZjlhR21TclRwa3d2TmR0ZHN1OS9BYWFCOEZwVG96?=
 =?utf-8?B?VjMvVDVnWkphY1VBUGhhYzdCWXlFb3dlMmhNLys4WkVDamNPYjJ2NDh0VU1O?=
 =?utf-8?B?Y3FaRkZ2Z3BuT0dPWWJUTVdhbmpTMU5lRmJ1Nm4ydGxlMFI4NVNKQy9MODlS?=
 =?utf-8?B?b01jTy9nSTZzclNzSTBlZ2JjQjVmdzVzOHcvQkE0RjhqUkpTcTF5Q29ORmkx?=
 =?utf-8?B?WENURmN1bncrOVJKZ1RsNnFBUndSOFF4RlJtOTNIUEZaWHlweVZXQUV1QTIr?=
 =?utf-8?Q?98ctCwSwLE8pWsmjTBhI40hGEa1A0gSx+q+QhCd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVhFeE5tOUM4OVJlU1dmbEQ1c0JIbmkxL2ZTT0x0czhEN3FzN0VDdmRGa3Js?=
 =?utf-8?B?QjVSSkJyV1BkY0swakdNZlhiZzFzbm9mbjFXeFVYRlphYmpGZmIrVE9IV3JK?=
 =?utf-8?B?L1RRT295VUpSNFRUMTN4aVB1aVNwamhBczVYbmVraEVSNzRlMmlZN3gvZWFV?=
 =?utf-8?B?bTdFaW5mN29HVTQ5ZUNTR1F1TjJ5VGtwdmVUSGZQTHh1UjRtbS9NQzIwNDlZ?=
 =?utf-8?B?eHZQRG00SDVicnBzQU9SYkpxWnoveVJBcmRrSWRGTEpwd0oralBzbnBVcjdz?=
 =?utf-8?B?ZGE5Z1RwMDdNL2pKblRRd2h2eDBnSVZqUDFzQ2ZGRkhucjR4c2NlalFCeUlG?=
 =?utf-8?B?VWtCODh0UGlLbjlQdjBQRDNBanZxZk5kQUplbHdqMzhyMFFtS0o5eXpibDdN?=
 =?utf-8?B?OWIyRjJSS0toczVZUUdqQ204T0tDdUdwdGEwbXUxQWZMZEd5YzZ6MTRsOTFt?=
 =?utf-8?B?aHRBVU8vSWFhQ0tBTDQzUHdYYjF3djVZOTdhd21hb2h0Zm9GWEhzdVNpUlF2?=
 =?utf-8?B?cFc4b0gyNC9NQTNtV2hJc2J6MnhmcWlCcVNiY0dxYlhiRTNEdnoyb1pwYTds?=
 =?utf-8?B?cXBGK2U0QTBGQVFKTk1IeGJ2ZUJjMnJ5NGcvdk51S0RNSGYycVpIK214cFY0?=
 =?utf-8?B?SldaY1NlTWNFa2NqOEt2V3lYQzZmYVFPd21oeHh6K3prK1ZEaUFrSW9kQnB1?=
 =?utf-8?B?czRpUFdXVUdvOU5ZdkRNRnZRUmRSTjR5alk2NnBVd29HandibXpaZERjWHpM?=
 =?utf-8?B?ditQcU1zOTd0d2RtUk8xZE82eFFpRlNlaTVMZ0xkblFTZkNFSys2dEpRSGd3?=
 =?utf-8?B?WHIxK0h2UzlqaFdoQlNGQlFyRk5sZWVYYmxSSFVXOEt4bXl5dm0zRmNQTzhm?=
 =?utf-8?B?NzBadlFJSnBpSm95WmxZRUxzaE9aOU5kWGVQTS9IdUJ2dncyUkp0bE1DWlMy?=
 =?utf-8?B?NjhMYmdqUnRGS1NQQklhY0lYekEySHJNcnlXTGluS0NDbm0zVFhnRnRJRUQr?=
 =?utf-8?B?aEZab2RmR1RqZko2SjJsNEN6OEJ3MEJ2bWhzYTJrNCtPV256R3RFTFRjZ0Fi?=
 =?utf-8?B?ckNtSnVCVExNRmJCTGxUdkUvWGFKUlZXako2QlZlNkFwTFBuQWNCRW9VTjNE?=
 =?utf-8?B?UkJ2Yzk3SU56SXFBMXkwU3k4eDJBYVg4OUFVZllyajhNcHcwaklkYXRtZVp6?=
 =?utf-8?B?aU5kTFNvcXhMSmk2SDJ5ZGFINmRpcnc3V09JdkNtUWpLUllOYWxrWGMxS3Nz?=
 =?utf-8?B?aDdiZVhHbWc5QWl2UTFtaTIvQnFlYWU4R0c4QVFaQ3JqUWM2L2plV01mQktO?=
 =?utf-8?B?TFhRL0Y0K2UvODhKNkp6THVpZ01UK1pZZDBSOTZFNVJ0dDZzZ0ZqSnAxNmJY?=
 =?utf-8?B?MG1ISkhFaDVNRCt3SGdhcnhiclVDcm4yOW9wT0k1KzNvZzR2amJ2OWp0YVZ6?=
 =?utf-8?B?TXljTG1pQnZ6TjgreUg2YVVIWTloSXJ3M21PRWZsdFQ4ZUt2eHhpU0NoTDk1?=
 =?utf-8?B?NXd6V29DTHB2WTRZM21USVhyOHZDWWl5NjZ3QStxci9oTnJKaWZHZXpnaWd6?=
 =?utf-8?B?cm5EV2RlV3FHNTR0ZUNjSWE0Nm5SWHNEVUkzUzBGdWREVkdScXNnYnV1a2J1?=
 =?utf-8?B?NTQvS3NudmlGZGNmcHptK1VVUG9ETG9XT3pJZTRIZWFZZ0tZdWZtRWdCdmpB?=
 =?utf-8?B?Y01QL3RlSXFnV0ZvV1VFOUJRcFRuTmYzaXFSbUxaTk8wc1RTNnlzbWpsVURE?=
 =?utf-8?B?ejl2NmZ3SEppNGw2Z2tYSEpzVzlJb1ZJVzF2clVrdmtpL25OdTBWR0t6WDNC?=
 =?utf-8?B?czNmNHcyUWxMNWhnU3RETk8wMUwxQnpmNXF0bmgrdGozdkttWFlYd3N5R1NX?=
 =?utf-8?B?azF4WUhDUEFvREVFaTU1T2lNRE5SQ0pBTEV4ODgyZEpBMTlIbnBjbG8wamg4?=
 =?utf-8?B?YnFWY0lPNmJ3enRXbkdMblpRRXRlMHkwMjY2UkxvVXdLOEtjNHdPL3FvaTdD?=
 =?utf-8?B?K3VaNkNmcXBFT1VlRXpPQmhOL3E0MysxZzdqVTdCQlVaWVpvd3BOUXg4Vlgx?=
 =?utf-8?B?NjQvRzBMTGsrM081QUc5ZTZ1RktIazFUVXlIdURaZFk4N0N6eDN4eEQwamVC?=
 =?utf-8?B?V25JMnRkelFBMFJZNU1GWlpMT3R2Q2cwSjhpRlVOV2o5d2xQdnMrald2bUFt?=
 =?utf-8?B?VlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yPpoyIfr20dP+5Q7wkbM2df96mrQaRwjLV/vQpMikPao8PXcbPkC/YXNLsmNCIkrbvBvYn4ilWhEL2aRXt4W+9TiTLW/VLHJAdQ2g/6Ki9GpTL0Z4XNgF9AHQfiVkqIfEEP5NVhmV2hFxjsKfINpcOBrAIYuEZfVIK62li+jb9l/mDDTr/a7g6nJvkq2gCTyHD7gHFH8mqnYw6+u68XWYRC7rgqGjJ7AeNoRVEFdaKEE8vRizufwSrTVBC3i1f5KycduJLF2aa7e+GudGRLY9FGjhRYUEsFd0W+KSj4HHwd9Veb5fv7iIsNLuIgUPjsWsfxpTan9lHD4XVYDjRCLnu3S7hx+VadRhJJHb+0Y2jF/4bO3VYC0ngFHwMe/+pN3TpWETKCsAHppJlY90BBKj2KC3yqruiysZ8OfvpVbk7S44E5qZZJiLO5lbGsta2WJCrFj9zywZIerI6exWXGZfclL4GXifQVozYCOD7FeMbqfoFQdxCCVC+yumgULMISvNvMEb37napKN4+c4DYRfqT1vUlkMiAx6+SNXUFF9oe4Zel9TRmWhwAuTjG0eqbgzCj2s7KVVRmnWDQ7TBwbOyyOBm0vlpKSw1RibBGOmB9s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 597d2635-a94f-4616-7561-08dcff3a54e0
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 14:41:57.9090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8mRg/y373FKXgW7Ub5cXKO0ZfbaMNWVyEJ5vwYPiOiFvRB0atk7/fqXAohspw1nS9OgM/Gq004Qt4WZffj4vRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5791
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-07_05,2024-11-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411070114
X-Proofpoint-ORIG-GUID: hZYiIhXhDb3V5yTU9JsSFr11CYO_gHsn
X-Proofpoint-GUID: hZYiIhXhDb3V5yTU9JsSFr11CYO_gHsn

On Thu, Nov 07, 2024 at 08:57:23AM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2024/11/06 23:19, Chuck Lever III 写道:
> > 
> > 
> > > On Nov 6, 2024, at 1:16 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> > > 
> > > On Thu, Oct 24, 2024 at 09:19:41PM +0800, Yu Kuai wrote:
> > > > From: Yu Kuai <yukuai3@huawei.com>
> > > > 
> > > > Fix patch is patch 27, relied patches are from:
> > 
> > I assume patch 27 is:
> > 
> > libfs: fix infinite directory reads for offset dir
> > 
> > https://lore.kernel.org/stable/20241024132225.2271667-12-yukuai1@huaweicloud.com/
> > 
> > I don't think the Maple tree patches are a hard
> > requirement for this fix. And note that libfs did
> > not use Maple tree originally because I was told
> > at that time that Maple tree was not yet mature.
> > 
> > So, a better approach might be to fit the fix
> > onto linux-6.6.y while sticking with xarray.
> 
> The painful part is that using xarray is not acceptable, the offet
> is just 32 bit and if it overflows, readdir will read nothing. That's
> why maple_tree has to be used.

A 32-bit range should be entirely adequate for this usage.

 - The offset allocator wraps when it reaches the maximum, it
   doesn't overflow unless there are actually billions of extant
   entries in the directory, which IMO is not likely.

 - The offset values are dense, so the directory can use all 2- or
   4- billion in the 32-bit integer range before wrapping.

 - No-one complained about this limitation when offset_readdir() was
   first merged. The xarray was replaced for performance reasons,
   not because of the 32-bit range limit.

It is always possible that I have misunderstood your concern!


> Thanks,
> Kuai
> 
> > 
> > This is the first I've heard of this CVE. It
> > would help if the patch authors got some
> > notification when these are filed.
> > 
> > 
> > > > - patches from set [1] to add helpers to maple_tree, the last patch to
> > > > improve fork() performance is not backported;
> > > 
> > > So things slowed down?
> > > 
> > > > - patches from set [2] to change maple_tree, and follow up fixes;
> > > > - patches from set [3] to convert offset_ctx from xarray to maple_tree;
> > > > 
> > > > Please notice that I'm not an expert in this area, and I'm afraid to
> > > > make manual changes. That's why patch 16 revert the commit that is
> > > > different from mainline and will cause conflict backporting new patches.
> > > > patch 28 pick the original mainline patch again.
> > > > 
> > > > (And this is what we did to fix the CVE in downstream kernels).
> > > > 
> > > > [1] https://lore.kernel.org/all/20231027033845.90608-1-zhangpeng.00@bytedance.com/
> > > > [2] https://lore.kernel.org/all/20231101171629.3612299-2-Liam.Howlett@oracle.com/T/
> > > > [3] https://lore.kernel.org/all/170820083431.6328.16233178852085891453.stgit@91.116.238.104.host.secureserver.net/
> > > 
> > > This series looks rough.  I want to have the maintainers of these
> > > files/subsystems to ack this before being able to take them.
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > --
> > Chuck Lever
> > 
> > 
> 

-- 
Chuck Lever

