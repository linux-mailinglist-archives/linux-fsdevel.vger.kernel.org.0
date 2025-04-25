Return-Path: <linux-fsdevel+bounces-47350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE90A9C674
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 13:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B0EE17B2A9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 11:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996F123DEB6;
	Fri, 25 Apr 2025 11:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Rl/sV/+J";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Lo6xXj+/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C260182BD;
	Fri, 25 Apr 2025 11:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745578854; cv=fail; b=EPEzwU7lQHAypFNqEgH2K3Ut6BgcV3v3CVhDf/jF+wl5bUmK1TGnzAcolUzYPJPoOT9GOfachwD8/gdBHZEt8KmvWRim1kl8SUrqsP4m9oqNy7HOcUR7s3wC6XTuV0DrboVySABy2lwY2BSx0FrmfL6SWQ7H2fsq33vxL5vhmW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745578854; c=relaxed/simple;
	bh=ibZ2DgnLNQmh0J9YfvL4q5uDbLjZTmCV6FR1GsORTZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QYxl4UfHumxyEtRs/YLseX1YU0j+8/j6vP9hoboRaSmbw4asjoeLpwceEX6Jlg0lk1RJfbQ76ZFASF6BC4aT886v0bt4M3TPWU1AaBlWj/7Wa65fTyc1AwfcVZd07P7+vEPAbwJZpO9LSDC1Po5dpJDyQ3XFX4uFbsbkgFw/XnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Rl/sV/+J; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Lo6xXj+/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PAXu51005447;
	Fri, 25 Apr 2025 11:00:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=hV0d3Fe6uvjWsItO8j
	Fbo7IXEJLwL1sRrTOC+J7JQmE=; b=Rl/sV/+JCNbvbc186Jicsr0R2KvjNBhs2F
	fscqhjzBs3WrBMAND374TkQQV9zA4MTAbGR0rY3NwNxlMLkNlrukFU6YkWl0iJGF
	DroPOTsEDO7aqEO49nTWj+VrXTRsPWEUUKYaPJoGPaCAnQc5EZTy7oLNW9QtfEh7
	QiUE3kRmPItFUlnlCyKJLh5UNku2TRLU5tnewF7+0y42fzo/ucvQuGy6H/F5Io0R
	KQOMI2GIOWpVrH8jHlZQDb264HinIen4w3u8L2YxG0tt326MHADhDRC8Dt2XZIoZ
	Kc29WHh3uLg2rBBaQ+Aik9Q6rvjG1YdHEnSJLloAMeLoMspyWlnA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4688qn832h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 11:00:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53PA4q33025167;
	Fri, 25 Apr 2025 11:00:35 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 467pucmj16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 11:00:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JWM5eIYNJT0e5bWxqboljcX5TCBW70QtdDa8qpiFxwGT5/oza8XKYlgrfTyKg0nLX55EvJYt7jvAnLQ/N+skXXdgilW0Vl1cLiHdbvLjZL1DElLrdmAk0xZ9EcLPQ9Twv72Axt1PZGlrrW3b7LJyjrJJJG2eM8ePTJp3WW2fMsezFq50Z/NVH7oJ81CAQziyorhloAJHEHscXUV4z4K492c222gywLW6pCHx/yohOqKYte+QQYNGpDphtzOoyFCpuwClsn/zsXV82uXl5vZGzmeNYntKKfbcImbKITv3MfYkST7bqzhaqvMaMU0ba1ZW61S00bBlh2xxGNxsqRiYhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hV0d3Fe6uvjWsItO8jFbo7IXEJLwL1sRrTOC+J7JQmE=;
 b=xHqpr09+tbxjWMhumc1wQwEbppfX+eoVl34Qn5+2U09Qp8YhTkR1Ji1maj+TwZRKSY0aea3TZEcGe2yXGSlaz3TjZpTmPNX+XB4rGq2UDR9r9vKjYS218Euvnu0ImhZ9/F2h0eNDZ/+i4xHRsaqp+Lw2ybO1jmhbmgdhRk6sw6KzfqQh5SwKcbAwvkxFwlMmR+bhdRj1/TyS/QNECQ5ABELoxYgCvj3UAlOi96dhN0JEXUCozvAhj2DHdVVubQpscWZB/mjyGyPu+qY7XzPXJpyucUucHrUb4Lb/Ac3vRrox3yN/fOMd3wdmSVVumtazaJR+IHqSSuZZuEGfNDY4Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hV0d3Fe6uvjWsItO8jFbo7IXEJLwL1sRrTOC+J7JQmE=;
 b=Lo6xXj+/kpzqOEH0Co1o/SMPrMdXOFzG9cKvuE4WahgrzX//gP6NNPvIofQQtNGb/QUZShBK/mAykzO2eNfRHHly8OAKgUwElT/vLGnWg0owYW0hqncmqLzo9S7J2m1gZWLggClJt0+o4ESVbBth7/2YrH4hyLs5eP2r7vFTZ2s=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by PH7PR10MB6227.namprd10.prod.outlook.com (2603:10b6:510:1f0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.39; Fri, 25 Apr
 2025 11:00:31 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 11:00:31 +0000
Date: Fri, 25 Apr 2025 07:00:27 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Kees Cook <kees@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] mm: perform VMA allocation, freeing, duplication in
 mm
Message-ID: <j2yh25inlak4ra55lfpiwl2cxumrajauvuwqs56ebkidj33hxm@aob3bnwmuaei>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1745528282.git.lorenzo.stoakes@oracle.com>
 <0f848d59f3eea3dd0c0cdc3920644222c40cffe6.1745528282.git.lorenzo.stoakes@oracle.com>
 <8ff17bd8-5cdd-49cd-ba71-b60abc1c99f6@redhat.com>
 <CAJuCfpG84+795wzWuEi6t18srt436=9ea0dGrYgg-KT8+82Sgw@mail.gmail.com>
 <7b176eaa-3137-42b9-9764-ca4b2b5f6f6b@lucifer.local>
 <ydldfi2bx2zyzi72bmbfu5eadt6xtbxee3fgrdwlituf66vvb4@5mc3jaqlicle>
 <14616df5-319c-4602-b7a4-f74f988b91c0@lucifer.local>
 <80c17a17-e462-4e4c-8736-3d8f1eecf70f@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80c17a17-e462-4e4c-8736-3d8f1eecf70f@lucifer.local>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0353.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::7) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|PH7PR10MB6227:EE_
X-MS-Office365-Filtering-Correlation-Id: efe001dc-09d6-47f1-3feb-08dd83e86556
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ce+His6g/VUBBEyHHmlEMKgP9R/rn+rPgFnks+Zjkb8iWmTSduY+ELB9xjWS?=
 =?us-ascii?Q?lske1+occtKwkKUV8gwZWZkqcG8NubYo2cu/7TtrBqAeoaSb5BsWDMmU/xbo?=
 =?us-ascii?Q?g7S3gzG2OTWZKNZvOY5i4aburiUdJGgkAd3y2FTJGMxGMF92nS2KhyEv0kYJ?=
 =?us-ascii?Q?NGnvMaGfBQP5eelzZwM9CRhSbi9vAHuUbca1K0KFROXwgHBqdWNpTJ+o3cXi?=
 =?us-ascii?Q?sUt/hu7kgP8ryfVQt+XFVkPTebIYRo3ySGXEm09KWTmoBWGbFR91xsScIC+s?=
 =?us-ascii?Q?Ms28A/oYg9CQwXCALZ3HzJz/x+rvPs/35ctcLXugUeTCh7xmr7cgGJYnSiB5?=
 =?us-ascii?Q?JiNwxqo35ZeQ3oCkGUuoY4Fiwyz3ucUAU7FMHs5FD6cncuEIO/Yo2wHItmYQ?=
 =?us-ascii?Q?sSC25hOFZHwPW2sOKfHxAnkidpG7UoWNAua21jzq1O+KTgxDEx0Yi86CeRpg?=
 =?us-ascii?Q?czg8EUhHnNvrWo271Op8wWm0nBZjNWEKUOnziWwhfXAekVmr/Q5k0uup42Rk?=
 =?us-ascii?Q?QmqeRgWdW2brcLYUyaS8yCQLeVi19H66cnjjl0D2jfpy8pBDQdbJHwBLCyCy?=
 =?us-ascii?Q?Jg+lKX6onKCsAhZP6QkhWowO7idf1xUbAoijK6fRzARCBGF5J84EV56SzTS4?=
 =?us-ascii?Q?+WGKIstA1sktA8Njf/Etu6hlB1kTcZkKvRUnvHGvmAHv+jdJFwRmE0SbpTWD?=
 =?us-ascii?Q?0c9Z9UvZCLVDkWgPPD7iDG+xEsUV0/3Xk2+8EXyLNzC+Ve9wMiA24fVgyPCa?=
 =?us-ascii?Q?3j9wlsBDZf0+22W6oWdxgqu2EKAVxYYGefqDKY3Gsdq8+EzMT1neDQZUaNNc?=
 =?us-ascii?Q?a6G6bBORCAxKBKCVckm/SGABBfg/YXwvib1dTchbo5BYSGlEH7TYLk+Eg8yR?=
 =?us-ascii?Q?ZhWz1sGZd+anP6vBESH+xqJbI++aDuard+cAOYvYBT8MKVT6DzoFDPSMOU6i?=
 =?us-ascii?Q?pAsEsZZxaBrISw4SYgg9wwbjLKyG7Jj45RhBLsEFiBcGAFgOYNTbWLnqiSd8?=
 =?us-ascii?Q?ckSVKhWudXgBAcqFVNiSxv/isC1iX2j2DzLII7BjqcwnTPlgjRlG4WauShz1?=
 =?us-ascii?Q?/QAitMwgh15L9vHPWP0vSdvJXtzg04J+T2xktb4v4N7tS1FXwNg1ghkFqzO/?=
 =?us-ascii?Q?9BMcRGBUwjoMUN47bD6wPYVBa6ZAD4z778xM7OIfGyCoGgn97LfFsSTKVlk3?=
 =?us-ascii?Q?hMARIJBW2s8sQn3Gm0JsQu7F8Yq8n7V5BsVazQ/zIZLShTK0HCnwOGI4Y+Q9?=
 =?us-ascii?Q?f6Y69xxkTpLVCl4l1kSjIOUTEEveSSVR4LIhP//gSA/err1m/UeFYFAcCv/G?=
 =?us-ascii?Q?StBKK37eiw72NuFIUmSAujoFOrLzZt6abwPcjMxcVUj9UELEKLQYyvGVFAew?=
 =?us-ascii?Q?YrZE3RYOmgC1QPzwhJYzvQoJDkUkqygKqeQNeSdBU4iSjyqXOnSB2SuCQKxN?=
 =?us-ascii?Q?DyzC6Eydic0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W3iWr3OXfOOB7Q+oKiURBAb3uS/96wr0S9CZiGCDByfFcU92Z+RG5AkELY9m?=
 =?us-ascii?Q?9j6W1asnTUEOout3hfRL5QamkqdrO1nDcgyrfvUJH3Qb/PsYziotV+ud1a2a?=
 =?us-ascii?Q?Q95mp/OyDQe/0fbdfSaQ8iNqijXUAWnv+CAoranWTEBwAHfULSxfSWLVwtjN?=
 =?us-ascii?Q?jl8tfuRy+VCpTtOpFFMY+CxftWiKnIWTuiH8RYInY7Df/SKu4S40vSeL+LHO?=
 =?us-ascii?Q?gLZp1VxKjxo8NZJXh1ZtPg5Vux9GzOYG86ZG08hlrnyKe+MlE0/6Rv/clcm/?=
 =?us-ascii?Q?ksdJnqKW8R8A/uX5dvmquIUOporDMXfU1YVFEVP9NsZD/yhwhivkgsq8t2+h?=
 =?us-ascii?Q?XQ+Lsj0i4yHvZpfjyjfdmS8bI0etz/UzeTBc151muwNlu7NfeCqLRRTrhcLI?=
 =?us-ascii?Q?dZEOUuIlIX1RKkGuHK960XzwJTOjK0cKPIvGaIvaV07+Z5A4Q1yWng8yjQdx?=
 =?us-ascii?Q?GTD6JLTqsIojDB4NR5mTu8bKhJFIQEkZZUkV73nvcGzjSw9FMcv8m2hxLqVQ?=
 =?us-ascii?Q?NjoUoxdikpBE9hQnSX/qkqF7y+3Nzb0SA4SHbTfMVQW/vjRO3SVQezf4Gite?=
 =?us-ascii?Q?CNc01Pn/0Rf7UEx4ycqdLD4VF6FbL3W/hj7oAX6igvGk4f4XnFbQlxRW7lyB?=
 =?us-ascii?Q?gQT0CVZ2+VsncU5qfA46jLC7dL6hwI/mPFSAlUjbWx8u46clq8ono3lV9yxk?=
 =?us-ascii?Q?sf+ScRQ44tZlA8ugG2ZkwFrdujMTQxJAaqnzKg7OMC7d5fhRHLJFQdeLDywN?=
 =?us-ascii?Q?aTIAF8NJXoX8lgJG+rMqfpqXNM360ewISreZs6wSrlz8pUvuN1uSL1KqLpdm?=
 =?us-ascii?Q?OV0UwZaKggBCYVs2ljLk4lZYhRIb0lnYU5Jf+Vq07e6SSqicNUSvb/N2dSjc?=
 =?us-ascii?Q?XJqR118HNqsX1tdFNvhT9w77AuN/blS4hGtY0kVCWhb7KXAoKGQ8yuZPh+2S?=
 =?us-ascii?Q?t9YgJFLHdrFUMgX71oHEj5umdiiecsa9jYOkLnHI4RTOinp6gMZRhoCveLX8?=
 =?us-ascii?Q?2EZE3ociTjIS5kXhHGC3BaBKNRYUyUwVFhFV2nHfBFsTIda2T2+F0LwOYaNw?=
 =?us-ascii?Q?+SLnz+ZYd73ecB1fYKs1qFhmOMFeYeTiF3VFw6/LpHuQA8EFuBaV1C6RkUos?=
 =?us-ascii?Q?DWxk2orAXenXclBMZP+BVlE5uXAMwN4KAMpmwrNbGPs4jOcOnWLCthjuwJMZ?=
 =?us-ascii?Q?OQG6rTJ6n5sa70ylvu2ZEp2lWU2FlK+H9uPQmZ3wkGJxxoNNdP8OIz+iKtiN?=
 =?us-ascii?Q?8vcJx14qWXKjbZF1YYRMYSxf5smz6zXod3/VVB+2yQTf+SMpsJAhwTfSQguN?=
 =?us-ascii?Q?TedWXv5cozd5+mUjh+OWZJ/liBPryjS5FPkq2eNPbkhSb01Hrhx3iwXb+cg8?=
 =?us-ascii?Q?JgUnMTGgGtLm5V2sa4nis+1wGKokzBqdHI7uXe8ISoNZTXPJHKl9fESIiusf?=
 =?us-ascii?Q?vEHFQWT9jcX3yXRuvK6JKz03thzjX0aIo4yDJ9/hmFQhzg7IVc3Ek43PRwQe?=
 =?us-ascii?Q?BOxfnjg3580kLQo/t4OnZ7k89Zixxl/qc+aYT2AaxfZVu4HtaqeNkvBOyXaM?=
 =?us-ascii?Q?zAcB90VocONrZPSdb14KFBpp+R82mKAX7Cmo0zXx?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rCeXuHwNlJ/r3Q92vz2jNXHU+AYDasHS40okrhVwl4niDze+s7qruUC5yPqfbfFQJAPCtq7iCrTMtl6JBEIXKItlWxjyuSvZhDu++0dMLqPC078h9CWH8Im5whhr/7HF4GpKSEsev7oCIpzLjYuOXfgRXOVM0RKsnflfyEP4agvpEA+2RoKCu/oTg46UY+0bG1bqOWnj1LrqZTw+yQM8oUgK15zvxBCLThyUSeK65PjhnqJuSgYYFoynKDg1s1U79DDC3O6btvgWDTo3Q8DExouDBg0GUnZmTM7Emkz+V71ougOpogmpmG1AmgSZWcAeaUD39ZzHsdx/gtPZTGHoX4F+lFvAVc+1SYQbG0xwrGLkkyakVCRUWB3BNQYqY6/5uAdK75IB7I8XtxHJk8pkST3jXICTPBUpvbjZ23tIB7qWAeBJBjWv/s9Yd/FtAh4EkfL8spzHSREOBomQ8tqTAjc40Buk0eWPIveA+cLCesN1aTMB9f4B+KhNkop+oF7TvF3rDnb9a6HXuMJuosJZhbdLbQcvKXUvz46AE91OY3lSCad5TBtOhdLg9eyKasTLpv38hTouJh67MOFSy5YcQ4c3OBZ7mZk0PqSYj65gvnE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efe001dc-09d6-47f1-3feb-08dd83e86556
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 11:00:31.3415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nl4Hmeqpud/y/KHGup4HvksrCIZnfes5K05zpts/OxrOUKl+hEbtS5sPzm3hZFd0wnCjgsIN9aSKVSvFMJzuDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6227
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_02,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504250079
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA3OSBTYWx0ZWRfX9BSnc3PIEfX/ KQOzOUplsoBPqk5JQuYfQESCtkrUnBgIicmd/AbZJZ9aWKRPEOX36U185Ima9coEwPF8gegcGyQ 9QpuBxcT8C1nUPBXbxkTchUm7CobFLD2UJx1IKQ6tHAdmVwDUC35hoB1KVme/D0TAkHIhARUpQ3
 6YDek+ibMO/eRaTxdOXs3QDRRp9N9QqT0RpidK6dx/XVH5gEsxB5VBsGaoEwcZCiPDvi5IR2Ocr nwvWFlxAg7QRZC8k1tJqcxEegPXweTfN7F22jNeKTOR5wmfYWJjl3M9j7NVddTWsqRP9Nvcm+5n Df+rAShBHTEsevsWK/PeqUGMB3LWN4Gu58J1VDm8E3ZkA75qQL+54VbxyRwA4n5Rcy4Rgqd3fKN Isd+EV56
X-Proofpoint-GUID: OxxK0ka7iNiGYnRPcXylIw4UbNikcCK_
X-Proofpoint-ORIG-GUID: OxxK0ka7iNiGYnRPcXylIw4UbNikcCK_

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250425 06:45]:
...

> > > >
> > > > I think doing it this way fits the patterns we have established for
> > > > nommu/mmap separation, and I would say nommu is enough of a niche edge case
> > > > for us to really not want to have to go to great lengths to find ways of
> > > > sharing code.
> > > >
> > > > I am quite concerned about us having to consider it and deal with issues
> > > > around it so often, so want to try to avoid that as much as we can,
> > > > ideally.
> > >
> > > I think you're asking for more issues the way you have it now.  It could
> > > be a very long time until someone sees that nommu isn't working,
> > > probably an entire stable kernel cycle.  Basically the longest time it
> > > can go before being deemed unnecessary to fix.
> > >
> > > It could also be worse, it could end up like the arch code with bugs
> > > over a decade old not being noticed because it was forked off into
> > > another file.
> > >
> > > Could we create another file for the small section of common code and
> > > achieve your goals?
> >
> > That'd completely defeat the purpose of isolating core functions to vma.c.
> >
> > Again, I don't believe that bending over backwards to support this niche
> > use is appropriate.
> >
> > And if you're making a change to vm_area_alloc(), vm_area_free(),
> > vm_area_init_from(), vm_area_dup() it'd seem like an oversight not to check
> > nommu right?
> >
> > There's already a large amount of duplicated logic there specific to nommu
> > for which precisely the same could be said, including entirely parallel
> > brk(), mmap() implementations.
> >
> > So this isn't a change in how we handle nommu.
> 
> I guess an alternative is to introduce a new vma_shared.c, vma_shared.h
> pair of files here, that we try to allow userland isolation for so vma.c
> can still use for userland testing.
> 
> This then aligns with your requirement, and keeps it vma-centric like
> Suren's suggestion.
> 
> Or perhaps it could even be vma_init.c, vma_init.h? To denote that it
> references the initialisation and allocation, etc. of VMAs?

Sure, the name isn't as important as the concept, but I like vma_init
better than vma_shared.

> 
> Anyway we do that, we share it across all, and it solves all
> problems... gives us the isolation for userland testing and also isolation
> in mm, while also ensuring no code duplication with nommu.
> 
> That work?

Yes, this is what I was suggesting.

I really think this is the least painful way to deal with nommu.
Otherwise we will waste more time later trying to fix what was
overlooked.

Thanks,
Liam

