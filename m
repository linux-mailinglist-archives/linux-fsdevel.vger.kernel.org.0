Return-Path: <linux-fsdevel+bounces-21604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE06D90654C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 09:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E9A51F214CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 07:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40BC13C69C;
	Thu, 13 Jun 2024 07:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gBnMj8hw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mCa82zmR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1045A4D5;
	Thu, 13 Jun 2024 07:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718264194; cv=fail; b=eocXWZ+E6qt63cA1o6lPM9J0NpK7kSPwqY8neulWBEOPGYCZ3Uoi+gRQw04sl7xzhnvCqGnHNcuyWrgVkTa0H9LffVLaMpAeM+J9tXiYV7ZyxMNCyk9dARalMj2a6FtAeMiNUrPurjbtgC8ZkksQM+ocvM+4K6a3ThAY+pXQhYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718264194; c=relaxed/simple;
	bh=RB0J3WzDvRbeGYe/agpGT7EthiRQAbNaBAWaxuJlNrg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p6LigvZtodFOkzAEPgz0fa3t3JFzfwlkPBARLd+UWpMHueK6HVLb1H0flkjqfHvjGIbgUtCR44BZ8BftBLq201AjmBfbiWZj8KeYBQQN4lBFSl9fLgNr8mBHNC1tofwvu9W7ZUIyWVLNMnLOdHEIm9+1yUhX2YJOO8bWFYZ4Bl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gBnMj8hw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mCa82zmR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45D3Cq31025640;
	Thu, 13 Jun 2024 07:36:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=AbbR4boYKBQza2BZcFwer48zIv8WYZqKKlyYtwxRScs=; b=
	gBnMj8hwFjwcWacCZ9d1SwNXwKQSmjVLXE01aTUQe7I7Zs2v+UaQt2BxmQYp9u5h
	AS1AfN6ofOVN+/JhZiJ1DhhZnEGKoVZKIsHvns1JYsr2kP5Aj0tlh9aq480e3F1b
	u7ka3ujopJQl6YdIpQlSrUVvF9WKohi64MF3X9MTdZD/fn+Wcr8L87Lo5UY+/Rp1
	bmGphsVq0OCGco2o/XmnjSJ3ki6ByNe+bryiH+XZ6t2K8cZ/wcUgr1AiEN3BFvXB
	R19EwAX10ToiRviXiHdmj3BqjjZ3EPa7EoOQFc1oTVTFlf0zDYQFKJlVc7DgmRTn
	ieAn05WWBRqeDPDLjkOw7w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh3p8v4q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 07:36:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45D7An64020457;
	Thu, 13 Jun 2024 07:36:02 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yncax45tu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 07:36:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=atdS2LH2Gn2JOzV5OkBXOhWHp2Z2NMVi9/ts0G99TleU/MJlqboXUMe8y2IXUkydVBZmb8YuGYBcpqlk0k48h32h5tzGoILfWWiQcpernaFaq4tdNpp5UBdNHHQTYJ1PZ4KI6xeHHJm5cdNM21vT0w8MHB0VrVsVXG2TaPNaVWtLX09bi09w4JZgzcLLvJT2RuSiDcUXXjDn85OxIA4BupOX4Flm7o2UESBc0JGqS0y4/6zHu5xL0cX/Px7E0eZN6CjH4hRdAS3YoOkVH3i+jm9c4TH0YJ5xEZ2Kgy3SlXAW081WhCklPJDxxBGMeUFyOofT8J1OK//7gKIi2hOXkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AbbR4boYKBQza2BZcFwer48zIv8WYZqKKlyYtwxRScs=;
 b=Jk0fgNGTblTxxz3Bxn8CRIKcRaQ1P/G+YgcjioI21+qs3H9CWv0GtHc034gbaojozc0oUqeSvZbgyMDxeGrqYOVHaiQqQszxEv8zyo7e9paH5X1VhCSFRXcm4XLjLAe3LyyU6V8PBPRO9BHuacFN/h4OX0UBFHAdd9EtYqoxqUL09SWLt/ahPfyG7Uo9mLBFFT30T+kMe7t59ElB5cYDTTuGwQC6bfR1vOojkzhH2YBwTXdzgge939ZekYzaKhot9P9igEtyL3trvhYitknkjUjvLlsTAv2qfYT2CjtclAzWQw5/eAb2VzuELLu9hKVUYGHxWyyJVEPfqGNru7T84A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbbR4boYKBQza2BZcFwer48zIv8WYZqKKlyYtwxRScs=;
 b=mCa82zmR6xLgGKRfwC9UePlD79qAYKc8YegycKqQf8Db8OLX9FNQXLYSery3I1QLjJbAajBCniMdcSv9df3ZEiZgw8mblDqhcEhrj+vnlnt0LK3/2bFSwW7Xb0Zas0CWm85D4QUnW7/qjVsSE/TEQuGftSSTKuSqCv/OZaX+BN4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7281.namprd10.prod.outlook.com (2603:10b6:610:12e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Thu, 13 Jun
 2024 07:35:59 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7633.036; Thu, 13 Jun 2024
 07:35:59 +0000
Message-ID: <a123946e-1df2-48da-b120-67b50c3aa9f5@oracle.com>
Date: Thu, 13 Jun 2024 08:35:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/22] fs: Add generic_atomic_write_valid_size()
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: axboe@kernel.dk, tytso@mit.edu, dchinner@redhat.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.com,
        chandan.babu@oracle.com, hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
        gfs2@lists.linux.dev, linux-xfs@vger.kernel.org,
        catherine.hoang@oracle.com, ritesh.list@gmail.com, mcgrof@kernel.org,
        mikulas@artax.karlin.mff.cuni.cz, agruenba@redhat.com,
        miklos@szeredi.hu, martin.petersen@oracle.com
References: <20240607143919.2622319-1-john.g.garry@oracle.com>
 <20240607143919.2622319-2-john.g.garry@oracle.com>
 <20240612211040.GJ2764752@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240612211040.GJ2764752@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0006.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7281:EE_
X-MS-Office365-Filtering-Correlation-Id: a0f7b321-5df1-4aa6-626d-08dc8b7b77fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230034|376008|366010|7416008|1800799018;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RFBVUnpNUE4xR3VyTFErdG5aMU1qZEJLQmtubGl3MUJrcjF2SWpBbVhlZENp?=
 =?utf-8?B?ZGVOby9pamMwVkpRUmJvUitEKzRNWnYzbDhQWk1iT1poYkNLVnNYbmxCWHhB?=
 =?utf-8?B?aVk4UjFSUi9WKzVncndNYm1jdlVuZWNYNUNPZVBoU3E5cEZPbDlNdjFqd3Jm?=
 =?utf-8?B?YTdaeDVSNm1reGxuVjErWlFVbFRqT3ZrVC9Td3RHRjJSdlY0RlRMZ21heUd0?=
 =?utf-8?B?WHJHeFdVZm1mRnVpcGFPQnlOUEhHcDdUaHF0djJUaGFHUDQxcFpsd0lRRWRz?=
 =?utf-8?B?RW1BOEpSNWIzK0lIVDR6NVF3VDJqK0Q3M0lWeFN0T2g3ZHRURmpuZCticTh3?=
 =?utf-8?B?aSsyMHFZQlMyMnY3RHhCeG00VElSNC9qWnVWTm5EZzFFMEJRaDFUMnYwTUF6?=
 =?utf-8?B?TlcrYkVKSWJkcldKUFZYR1RLbmE0L3FGd1FYNnNpb3Ayc01Cb0JFYlV0MjFq?=
 =?utf-8?B?UW5Ka0c5TTJlUGl1Z1k2clRySHJBS2FQQzJmdG9zVm9zekdrN0swSVFPREZu?=
 =?utf-8?B?SVkxeDYwOHNwcm5tSGlqZS82aTU0NWp2ek12ck8xTFRsQ3VLalB3cThSS29i?=
 =?utf-8?B?Z2pwbGxoUlBoR3NqNFNRdUMrSUIwWnJoallEZHhJai9SUDRhUVd3RWVkMFpO?=
 =?utf-8?B?Q05ycVlwV0d2UFBMVTZqN281bk1WU0hmbXJwekcxMUdDVXRjR1lwS0wxR1hu?=
 =?utf-8?B?aVRQR1RpRWJxV2lRRlRGbTJ4QlFwQS9IdlU2aXU5TktDZ1FpTkc1elhtc2Zl?=
 =?utf-8?B?Um1ua0U3VzljeXBSZVJqcHBSRnNqRGgyek5RekF5V3R2dWZVM3lyL2l4a1Vk?=
 =?utf-8?B?blQweFFuempWY1g0bG4zVUNFc1M5OTMvdFVhN0NEVlJuUEpjNVpMVWVuVFox?=
 =?utf-8?B?bmNhS3NZN0lPRWpkU3QwWVdVY2Vra1JJUXcvbVNWTkUyaXBDWUJtQ1UvYjVm?=
 =?utf-8?B?N0hjeHhTUjg3WEJXNkNYNW55NWZFM3FnbFg1eFdSRlptRExGODRNcHlQajRw?=
 =?utf-8?B?ZUF5VlNaOEVoeGE3Ym1yaXp2T29rYXpESkJrMHF2eXg2Vzk2OGVIa0RiMmFa?=
 =?utf-8?B?V21CQnU3eTAxNW5rc1ZQTzQ3QUZONkNxS1g0ei9sM2ZSZW16d3Babk1YS0Fq?=
 =?utf-8?B?RVNCandTWHBUL1RGNm5YNjNUU3lHMVZ5MFYzVTI0ZnkrZU51UzRMVWlkMC95?=
 =?utf-8?B?QkFHM0taZDY3WnA5c0EzUThKano0YzZJdm94VE1Ld0p1K3Fib3J5ZEZMNTNS?=
 =?utf-8?B?cklkYzlKTWJ3UFVQQUVSakNINmV1S1ZOVzNNWDBhcG5MbFkycXFheVkzemRP?=
 =?utf-8?B?MjZQOTkxSjFWMEZkQWRqODR1YTNpc1VLeUNTcVFIMkdNQUs3d3VkWVRRdWpG?=
 =?utf-8?B?M0VLQ2tqZ3NrYndkWWFqM05FeDRrWEJpYWtlNmhiMGpmZmt5QnhYYUUwS2xz?=
 =?utf-8?B?SlFNYm51U3JrWHVKWFF6UmlLZVlXQVp2eXkzWFBxc3AxNTBEOTdWM0pCR0Fq?=
 =?utf-8?B?VGhPM1BSQ3JKS09GSWFSNHJVT1EyNjIyNDM1SCtpM0syR0hCU0lDRmVteVhX?=
 =?utf-8?B?eTRYTkRjblNpbUpIVDFodGZYdTBQV3hxZFVubHlUc0VuTmU2NW5oRDNES0Rh?=
 =?utf-8?B?NnVFbFFVS3cvVWhqY2lxUlZyZVBsRVFSbVQzQzluV1VLNmcrbG5TUWFoNnhr?=
 =?utf-8?B?c25UaUxyZVhRcDd2SzF1KzJYa0tDYnJoUjJiT0xQQXBhZkcrVFMxVEVvYnNl?=
 =?utf-8?Q?RkIBnhfcJ6SmFmOmEMjBkQ3Xb+ibvYnI3ZTmqhi?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230034)(376008)(366010)(7416008)(1800799018);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MGhVZ0t2bzNEcWZiU3ZxTnJ5OUd2M01FUExOT2pDMmFZbVhBcnFyOG1DRFBl?=
 =?utf-8?B?cVlISVFrK1dZdDR0NWlSMUdMYllDTXFMbDlHMUt1Lzh3eE41WGRXQ2pLVTBJ?=
 =?utf-8?B?VDFkV0lGbU1hSHdzbXdtRTJwSnVOZUkrTUwwbjZOQ3locktZdWV3Nkt3RHVB?=
 =?utf-8?B?SVk3OSt5b1d1MGVsREpGSzUyaWNUb1NITE5IYjlXVVBvVmEwelJlZXJnY3M1?=
 =?utf-8?B?WGZReWZQUm5IOXZmTzZEYjk4MUZRTXZJNVZHTU40Z2VQdXhLTlVaazNQUWd1?=
 =?utf-8?B?cTVIMzR2ODFLZlBDZ2RRcWRPNFIzOGxQV1FCLzRRbE1wNE5OWXNQeVVQV3Jl?=
 =?utf-8?B?WlByZU0wOSs2MDYzYjhnTXhJMnFrVXZmVVlHT3FvZ2czUEZqNTR0Sk1ZREl4?=
 =?utf-8?B?QXU3RjNEaUpIbFg3NGFhelViQU9LVHJKU09NM2NwUkhkcm4wVVVqRHZuczQ3?=
 =?utf-8?B?Sk94OEtTb3dmbUpvUjZ2WXEzcm5tclREKzVNcGFPNGhxaVZmZFVGWXJhMDMx?=
 =?utf-8?B?SUtkdVNHRTEza01ucUhCWVdXbE5Oalc2b3JIRmphQWZzbjY4Q3kxUDBwSHdw?=
 =?utf-8?B?L1QwNHVGSlc5MnZaWHBldURza3VzQXR4SXdFWGVKS1lvZDdYdURONDBISmNF?=
 =?utf-8?B?K2F6cWE3bjl1eEl2eldsMkpVUEZKUHl6aHdEUmcyRE0va2tyTTJ1Rk1yWTRw?=
 =?utf-8?B?SnlhQjg2SGltUThRS1ZoZjR1MnhzelMwNzhSenpVQVBrbGhTeFV2c2VuRUpl?=
 =?utf-8?B?UlBoeXA3VG1UN0pYZkYyYzFobG1SK1B4TUxwMlRMTVlnWDlJdkJYdlpBSnBo?=
 =?utf-8?B?eDQxZkpMM1NpcnZ2QUN1KzR6K2dtTzJHVTRyL084MVBhdFFHTTRBM3BJRGdO?=
 =?utf-8?B?bFdqeC8zd096Y1dNYkRsNHhoNTVTd1ZNTXhsN0JkU1BtV0o0c1phWEphekhl?=
 =?utf-8?B?cWFiSUxPSXlra1UvcVFnb2xUS3dMdUlOQ3hncFZpbW1WbnpPSmE5VExzSUFH?=
 =?utf-8?B?R3JzRkwxdUFlTnkzMStYNXNOQlVuOHFDTEFxVG9rU04ra1Q3clpNNUFDN3BW?=
 =?utf-8?B?RkFvY3RVTDAwcDJ4U25tSlUvTjJvRVBIY2hvNXo1aE1QdE1XdTVrUnFwNEEv?=
 =?utf-8?B?YWcyQ2w1Yzg2RVRBd0pJMi9tNzVMWWFGUzdrYUsySWlFVXpWNnN6UG8rN0tT?=
 =?utf-8?B?WThkZzlXVUVHNWRrbS95TkNGUkY0cXc0Z3FnN20rWElQUEhMQ1EreC9KSzM1?=
 =?utf-8?B?Qk14RjI0cW81ODZrYko4aEtHTGlDd3F6aG1CM005a1BJaGJWdXUyRUNyV1U0?=
 =?utf-8?B?NDVXbm5xSWZ1ekxkY2JQM05qYU1ZazEwanZJWFNXSktzMmV3Q282SFUrNTlt?=
 =?utf-8?B?SHYwVGt5T3g5WDZQQ1B6eXltVWNEeHJ6eEtkRzhJS1VpeUxlaDM1d1Y2eDJY?=
 =?utf-8?B?dkJ3K3YvTEs0Q1ViQ0ZobWZjZytZV2wxZ2hNMGFjWjVYMVZxWEMwbDl3ZGR4?=
 =?utf-8?B?bGNDZDhvb3BQYWJiMlhER1hhWURmSEF4NVh6ckRRbzQxcUZuaXQ3M0J3WVJF?=
 =?utf-8?B?d3BZenI5ZUpnK1l0UVZaNUI1anRmVmxhSEFyblMyWnMxdEY1SEZ1VVpULzRl?=
 =?utf-8?B?NnJZZlhVVDFaU2prQzdwRDN2VUNqUS93bjJWMktsWmxrUVJVckdPNFdqQ3ZV?=
 =?utf-8?B?cCtYN2tkelFGSXBGd2NlNHZGL2NGc3NXM3Z6Snp4RUZ5dXNUcitvMnEvakY3?=
 =?utf-8?B?RkRVanF1aHloaXNac0NXN01oVHpEdFhNSXV2U3FEVHR5VE41UVluREFtVjFF?=
 =?utf-8?B?Rld3VGtZRUVROG5ZYTh0NVpndjVHTUc4V2pPNllDVmNPcS9QenlYaGwrKzZC?=
 =?utf-8?B?MFh1RlhER2lHYU1uR0gxcDQyazE3VG03RmRaaW8rdXRSamdLeGxqcGpidzVm?=
 =?utf-8?B?d203NXFVamdhcG5aa1BzNGE0S1BQOGV6MjgzcEJXUWNHZW1maDlraHhta01m?=
 =?utf-8?B?V0djSHc1Y3E0bDFobkoxTVVJNWtSZGlwZkk3d2piOVRNOU9JR2diYUFGakMz?=
 =?utf-8?B?M3pCdGtyNEZRMmdlc1RieGZ1dFlydXJjWGZhVDRKMWVPL3R3TUVlemdJOGdV?=
 =?utf-8?B?L2FveVRrYWI5TXlGNU9ERDh2NWtsY1FLZ3NyQ05GMTN2bEhwNFUrMlovQk1z?=
 =?utf-8?B?Q3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	3IbGr7tu9ZnXCCIPecnb+wIQY/5bcIiKdN9rx4ooDM0JpSfxHd5pk8erSXaTwTWBty8jgJjsCjtJXuJuuf+HTUX3J8AH4rBEGuwWWvPZYMVmdB6fgZJwuQv207/fnGzvX9gJJN2XSfJgtjdupmK9sLEcTUJDKXEZFRMEbh1bEUA7qM1/r4/emtCyILzI/WEq9uIJU5e+1H4gREoAa5C0Raxw7sn9ZdLxxyl/xEw+r0C4E1ApplnB1ECJ3c6nEy1Esmf8ca0cod01r83R01H0/JepAGIQU/E/evGqoti6kgVGRL+TzNMsBAHB88PRV9dUUyO4BcHMqSE8w38lERGsppeyA/ne03Atz0I42kXSORTKKzciS9CYHzZXJFU4oJ7eXf5RYFADtPDgyJXq4DxV97pj65IRhSzzEsVYb7KuGqj5rBdJZ5mpSZY2P3X91VTfb+3n2WEigxozg30wC69z9DF9Fnm7OmTtwgLAQ/ORm5H+osaDQWLTDndSIXtA3Amt1OVeZ2f+5bO4E6DtpU3ESH7ixlF+KvnLZMVpBi3c9roFtMEWG/xWH8WcatmOWfdTU4lPpg6KKiQpUuWYc2um4qwtKDZA4wepMSiCv3VUHGc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f7b321-5df1-4aa6-626d-08dc8b7b77fb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 07:35:59.1878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6fIedIVdLNgI8vM+QMRKXeNi0VZCf47vAXwIfvKFG/AtZ28IgLvNLhOiRcPJEWBwm03docquJDhGUqCxOPUSuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7281
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_12,2024-06-13_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406130052
X-Proofpoint-GUID: oT1V4b6qIsXEhX2wg7jWTMjFWuWuRI1o
X-Proofpoint-ORIG-GUID: oT1V4b6qIsXEhX2wg7jWTMjFWuWuRI1o

On 12/06/2024 22:10, Darrick J. Wong wrote:
> On Fri, Jun 07, 2024 at 02:38:58PM +0000, John Garry wrote:
>> Add a generic helper for FSes to validate that an atomic write is
>> appropriately sized (along with the other checks).
>>
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>>   include/linux/fs.h | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index 069cbab62700..e13d34f8c24e 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -3645,4 +3645,16 @@ bool generic_atomic_write_valid(loff_t pos, struct iov_iter *iter)
>>   	return true;
>>   }
>>   
>> +static inline
>> +bool generic_atomic_write_valid_size(loff_t pos, struct iov_iter *iter,
>> +				unsigned int unit_min, unsigned int unit_max)
>> +{
>> +	size_t len = iov_iter_count(iter);
>> +
>> +	if (len < unit_min || len > unit_max)
>> +		return false;
>> +
>> +	return generic_atomic_write_valid(pos, iter);
>> +}
> 
> Now that I look back at "fs: Initial atomic write support" I wonder why
> not pass the iocb and the iov_iter instead of pos and the iov_iter?

The original user of generic_atomic_write_valid() 
[blkdev_dio_unaligned() or blkdev_dio_invalid() with the rename] used 
these same args, so I just went with that.

> And can these be collapsed into a single generic_atomic_write_checks()
> function?

bdev file operations would then need to use 
generic_atomic_write_valid_size(), and there is no unit_min and unit_max 
size there, apart from bdev awu min and max. And if I checked them, we 
would be duplicating checks (of awu min and max) in the block layer.

Cheers,
John

