Return-Path: <linux-fsdevel+bounces-22243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C332915154
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 17:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DD5C1F23002
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 15:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23E019B5A3;
	Mon, 24 Jun 2024 15:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Bu+Va2Dv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="s29XrQ3F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D17919B3DB;
	Mon, 24 Jun 2024 15:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719241479; cv=fail; b=dNOUKllDask6XGI7oKhiPyKmV51OtsisgOYDd3MoP9v++dkwgtFkIALhZah/xWVycNG7EK2UBupo3kRcKS+pWjBZDKskmAaKwb/dTBnxKZGDDTAg2WpGyVqhG2dOnNfD9Hot5qSzVdb827/2NzSSdMd5OhzGRC4AqBnW1YtIpJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719241479; c=relaxed/simple;
	bh=uCfglO/slurqXYaGsLE4t+Y+PLXy4GAwX5+znML2sKM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G2p86CAYzgx4fwT3r4Shk70OgPACcDhHOZannv0BJJg1aEqheP13y5pUpjYbuWEyCjMSGstgTE7lhp9nFXqaPf6LVOEtpOJsbSaQd/ZIOKYVcHzunlNDJv0zlVbliGTJVnrZK1vl8Ln+exMpcKKjVdxYFxpozOxOmhmyb/C9ers=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Bu+Va2Dv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=s29XrQ3F; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OEtQrH012566;
	Mon, 24 Jun 2024 15:04:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=D2bhk4BFD3hA/DVrYlYnoWYqPhnD7wiFtvvtzM68610=; b=
	Bu+Va2DvC4EAB0432VOVoKCCFAbI/JkzeOORX/WDZ6hfLbfFj8c2Y/h9dUhlQife
	0IDGwpzgjKuO15y9wKz+gprhzdrpc3fwDtBntDLK9WE6VjirKN/UVViGJb1SWXhW
	U0Gc4IwzG7vTvpGVUNsDIpVgS25dsqqPGUVMmZUMI1U6CKGgnlKq28CBzci4li1C
	LaKZFMNyutWJwZ+fuOYSTAT/B8Z1l8dXadHja/NBtMASJSkdcA5ZsqlcroXktyQx
	t3Ss0yn1EMpJkW9ErdMljyuKfY2Ylp2kbuEfKRoEo02LtcbrmX0qjQj5mDup9Ohi
	u86vBOfDtZ33j9IvD9v51Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywnhatx2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jun 2024 15:04:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45OE1tih010741;
	Mon, 24 Jun 2024 15:04:25 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2cjg4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jun 2024 15:04:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C5sPGJ++RVBq1C4vs8L/feomMVRMKngOsZr+j+6ro6IZUNJqSqRQdOpnaOsthjwQDFVUZs9fYcG0vPccrmE4ltbGATrCcy5bf3rPI9oSufV/8AtY9AsNLe5bohKrzSnzKgEQRDnwnPyj+fdeJpSxH+yUh5766q4JIuCJCJAHp5eWReDEelqLLK9wgGirmxltv0GU3Sk3JbyHJ8CWofIB4Ie6RwPqZlqQHjtS3LVkTjsTP65zriN5/7dY3znlaH4q8HGpH8eiMNvif9DMUDsJ0S/5Rg3gUbemiy0PQEyYJIBzpmmTBfHbQqy4tqkL9PsMJFqNGFyV7S0a/ZdASoV9PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D2bhk4BFD3hA/DVrYlYnoWYqPhnD7wiFtvvtzM68610=;
 b=XyRSRZSrzn2nOyqXDexcHycOVBqCg8huzSu+1IHNGs9ewS3v2wNfQ5eT79SNlZuOFK3v8wCquAz0emS0qeFeTT9KlV9GglWhvESvsvXvFrubB6Fh6Tkf+JUPrvu/Iq5IJJKFTIJe2J0A0OjJXTcVdfWmYUnlW4EYmGRUq5Jy1q6qxJNtrlMFj2tvx1upVCVHmnZ3iG97cEC/4NYEBDymZcZjqWw2KUP9dq5QH+ON0ZskapTf7kHdxuXDziYFaBKXhcwq7fPqTCFJFARLDNAKVtt8LLWiEsdVY9Cty9g0kU5tW9B1fklHV1LGhVcd6Kpdh8rv+3iNb0b4yQd3HV1+HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2bhk4BFD3hA/DVrYlYnoWYqPhnD7wiFtvvtzM68610=;
 b=s29XrQ3FCUZ4XCS3Y2201IZq9hrXZDkO4zho5I59Th/CPPc0B4DmA7kXNPs8pA1kI2QX184exabtQ/hh2VOj6rWHXRLl3yspD4MCY54KV6ZpuM+kQ2XJccdYxOmfoB6MY7etDqNAtgMPn5elG78DmoFyOLFoCzq0Ar6y7nBY0s4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ2PR10MB7111.namprd10.prod.outlook.com (2603:10b6:a03:4c6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Mon, 24 Jun
 2024 15:04:22 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 15:04:22 +0000
Message-ID: <f0fe2e28-3a08-4bf2-9446-5d93aa961e07@oracle.com>
Date: Mon, 24 Jun 2024 16:04:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] xfs: Do not free EOF blocks for forcealign
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: chandan.babu@oracle.com, dchinner@redhat.com, hch@lst.de,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com
References: <20240621100540.2976618-1-john.g.garry@oracle.com>
 <20240621100540.2976618-9-john.g.garry@oracle.com>
 <20240621190842.GN3058325@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240621190842.GN3058325@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0150.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::10) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ2PR10MB7111:EE_
X-MS-Office365-Filtering-Correlation-Id: 575c85bf-63a1-4c13-cb0f-08dc945eedc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|366013|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eGxjRHpHSGZ5a0VEcU9LUTRYbXoxcXlWQ1AvRDQwNzB6UFYxSDZKSVBDRjJE?=
 =?utf-8?B?bWRxMVpxbGpUV0pOdWdCRmM4NDdyLzNpOG82L0NnZ3FidzROcFZQM0JwUjN1?=
 =?utf-8?B?ckk3d2FYZGtCNWdWODlmb25tNmdoOUppNkZINDhVVEc2c00ycEpjeGdCZmR2?=
 =?utf-8?B?TGViUjlybjFQenludkUraTlWQ05kLzR4M3FsUE1UQUhQR2p6WmNNaTZXMkcr?=
 =?utf-8?B?QVpjQ0k3anNRY3pTQ0V6aklJcndBUmdCVUQ5UXZJYWpkbGt4Q2JBOGlTcFk1?=
 =?utf-8?B?OHdBNGJMR0I5RzBmblVxM0JFRWJHTXljZTNSQXZVdC9NZ0M3NFVCQ1AzZkNM?=
 =?utf-8?B?c0lLUEd5N0JaN3JkT2RpYnBUMjFkT0RrQjd0bmcwekpZMndwVEhqSmhzZnV6?=
 =?utf-8?B?U0E5NzgvOEJKMXNQQlpHVFpkWFhTM3psVjlFWEE2STFnNzlzUTVzT2x2TDFI?=
 =?utf-8?B?U3R6L0Jzam00QkgwKzRjZkYxMDdNZTV3TWVZZzVFaWdaaDg1VmU1bkxCN0g2?=
 =?utf-8?B?dmVLMEhkWitoRzBSWi9pNzZmeWRnclpZcC9CTUtPdGZFYkdnZkFVVHdUbjNa?=
 =?utf-8?B?TW90NEFjZ05heHJlVEc0UlVGYjdzUnRVem9MY0ZuZHVRWGZhVkg2TTlnaVZV?=
 =?utf-8?B?YmpZQlRoVlBNczFaZ09VTUc2eE5lTnBrZ1JZUjFjc0FVNm9ONndJSGJRSDNu?=
 =?utf-8?B?dTQrN3FvK2VhSUV1anVubU9ONFI5Z1hJektobTd5SzRCNzhpb0JoWWRWTWtj?=
 =?utf-8?B?YUFELy83NmRqMzJkWXV6cEswNlJkWmluNHNZeGlFcU9TWmc2MFMrWFdDU2FP?=
 =?utf-8?B?S0dpTFZTaGpCdDA4WVFCbkVBY0EvT21DWkNQNnE5ZjRGYzRoMXE3dGljN2ZM?=
 =?utf-8?B?KzNYV3pENC84UVQ2WkhscU1ZSHdyd01Mb1daT0xNUytVNkQ2Tm9Gekc5NTlP?=
 =?utf-8?B?MXVMSmdNb3BkaUhpeXpNdjlMc0NJVTJUd293TVBlRXlQOFkxR080N2E3amo0?=
 =?utf-8?B?TERiK0pKV2lsV1pPOVNJWSs5NzhKOHdYaGVEUDAxME94SHFKTGNSeEczYVdD?=
 =?utf-8?B?aThiODBySU9jNkJqekwwS3JKckZEZlRaTk9uZmJjL2Z3REtYcWtNRkVCdGRT?=
 =?utf-8?B?S1hJNS81UnVTMENXVVlsc253NWkvakFBNlBlQW4yNkxzYks1NlRIRkd0OEZQ?=
 =?utf-8?B?ZzZOak1oRm9weDZVd0J4Y28vOFRKQWJTdVB0Q1dyb1E4emN5VVR0S3E2a25L?=
 =?utf-8?B?NDJOOVZ2ZUVxVkZlVjBKeDFvTU1jNktMRzVqNDJsYmZPN0QxYm5JMU82SzhR?=
 =?utf-8?B?VUEycTFkdW1xbWhVcS9oVzlkL2haRXFNUkNpRGU1UHlxNlcvQjdBR3dEM2l3?=
 =?utf-8?B?SjZiVDBxdERhOEFYMmx1ZUxZUE5zQmNPZXVseWxCM2prZ25QZGxTYU1qeDdK?=
 =?utf-8?B?VlI2dEdxdmpkY20rZi84YzN6Nmt4VmlCZ3dJYUhSaEo3d3g5NS94cTJhcnRy?=
 =?utf-8?B?ZVBJZnVxaS8yb3hzWUhRNXJ2VWJ1NldUSEZ1YkFWT3dBN1BLZUNSVGdTcFBH?=
 =?utf-8?B?Z2JENUVpL1dQL0FFVTZlYUxNN2ZJNGNmZzBJejJ1ZXVyS2FzMWxrWUxJaDRy?=
 =?utf-8?B?UE01NkRTNVBtWWJMOGxZMXlwTGVvZ3BDTTU1OGxmam5MWlFoZ2FjVlJhNVJK?=
 =?utf-8?B?U2VES2F5RWVybUJZN3ZENTRGdzN2a2Y0YmlPVDNlVzVDaGpneTE5TGx6RXN6?=
 =?utf-8?Q?NlhNqVCV95V47Fiyy2pL/XP7eJSUcZ6GcwrWWJK?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dld0UXR1K1lGT2xLVHJkVUhoWk1zUlg2dVUyY253eVdQblRzRW4vZm9DUyta?=
 =?utf-8?B?V3RiY0t2bkRtUVcxMWppVENFTjFMVzM5ODQ5RS9LLzJSVi9ibUkrZ1VKMjRQ?=
 =?utf-8?B?b3pCbXNpMUZLdEJTTVhVek40N0lxNjFVc29TMExTYjgxNHhwaUhjMzkzdU9I?=
 =?utf-8?B?cjhLaVRIL2sxTGsrN3NmeDJYMUdhZVVIendDdG8zQ2ZnNDh0M3o5cWRZaGNh?=
 =?utf-8?B?d3I5YXViRnZMSjdzZE9JellFNTFieTg3bHZIR3JXbHZaVm95TWMwakZhcXdL?=
 =?utf-8?B?TUxmVCtuTFVsZWY0bzkwVnlzRUtkbEthRXlEYkVJLzBydHlCbGp4WUJvbjRR?=
 =?utf-8?B?bkNlR3VzaGtqL1k4MElNL0g3ZkVvN1FOSWVSYTN1VHhQT0hlUHB6S0Y0cXht?=
 =?utf-8?B?Qi84Ymo4Sk9EMUhwNDFLY21TT3luRk5Ram1IbFB3SEpVRGN6TmRSdnZLbHF1?=
 =?utf-8?B?Myt3WENUc2JTM1lCeDFHeWkrQ1FnbnErcU15QzE4M05ES0sweURzbmhsMlpL?=
 =?utf-8?B?dHN0ZTkvMUNtRld4SkpXKzladlp1OWR4Yjd1cUFveUd6N3pvVjVZZ3kwSlFk?=
 =?utf-8?B?YVFpK0c3YTErLzVkcUF3SU8rZTFWWFFvVFhNL2JodURCbFZJN2JDY3dFdHlk?=
 =?utf-8?B?YWQ1NE4zWHB1ek1rZDc5MEVoK2Z5N3RuejNmeTVuTjZCWExIaVVheVkzQXBl?=
 =?utf-8?B?RVdKaWZqWDVRcHB5L0ZMenQ4dUR6a3BURWNEQlhNYXl3T2FuUFNQUFF4Z1l0?=
 =?utf-8?B?VVo0NDB4Vk5EWnk5RUNGeDFPY0ZDaFlCT2JxazRIdFk3aktyd2VlVjN3Rmlz?=
 =?utf-8?B?L0dtUTdhRk9XWjlrQUNGdTZKSG9oaFp4QlZUR0xES1ZIbDlvbnhacUgzRkZ1?=
 =?utf-8?B?eFlDUVp2cy9MNHc3WmhyaUFnRUw1N3l2dE9hekhwbkNqcDVFelNJTVB5ZjdW?=
 =?utf-8?B?WnE0YWg1cnFCcW15RnVzSTZRTjd6OS9ES0VRdVBTUWRGS0V2SmlDenlPcTRL?=
 =?utf-8?B?NFFQME1FVkcxd09GbTdCbmRsOUhhOEdlTHRGSkxGd0xDZUNjUjJGN1o2MU1U?=
 =?utf-8?B?VEpzRjE0d0dKM3FmMXBBb01oVDZCb3FYZ0hqOGJDOXhBaDZlUGVreC9lNlRO?=
 =?utf-8?B?RWlORWY4bk1DcmJyN3pnd3pOSTg2YkVRRThMT29sSk83NWNlUGNaMWlHaGx1?=
 =?utf-8?B?dDJkV1FEU0tzVkR4Yyt6OTVGQTJIS2d2NkVHb2w1NWdreHlEZFUrQmRwSlRz?=
 =?utf-8?B?TE5uU3RYNWNxVS8yQ0hUOFdmeWtLaWwza2ZaaXVabzJZdXpNR213SmtOc3Z1?=
 =?utf-8?B?a09qZEMvVWJYRVhEN2EzUUJFd3NBVCtqOGE5NnAzb095cEFxaml4MGZCeXlq?=
 =?utf-8?B?dnorOGFzWlluNWZPS2QzeXFoaWNzbkVwSXZEa3Zld3JLVDNlbDdvODV5YWp4?=
 =?utf-8?B?all2K2lmazVFL24xa1ozNHZpaXJyeGgrV0RxQ28xeEtXZWNmQU40VStkc1Zn?=
 =?utf-8?B?NFJFQ0dKRnprd0l2eHBhUnc1VThjTzRVMnpIYTBrYWRZT0JuNmFzZWgwV0tC?=
 =?utf-8?B?V0YvZUFmbHdBb3hXb3J1OEsrbWU5aEdISkZUSkw5TGxSMFJyc3c5UERkNWND?=
 =?utf-8?B?ckM2dzF4R0ZyZHBKb3N6ZUU4cXJFTFI5Uyt4bnVjbVlKSXN1TjRpK2N5VXlC?=
 =?utf-8?B?NFREdXR6NG1Pb0E0NW5tOCtYeEhVWFVKSkNsZmpuN1lyQTVzTkprZ0daMUZw?=
 =?utf-8?B?eU1YYUlSaEFIRkRoY0hPL2J0N095WEptRlJJdjdEc29xVHp5M3p2QUtENEZL?=
 =?utf-8?B?LzcwWEV2a3hQQ1lCNWVWVmVKUndhTHpSTWRsMFQxTE02VWM0cklpQ1FxcEhK?=
 =?utf-8?B?MTRNSXBURmt5U3dUZ1B1M0lKU0kzQmdkRkx6NEJnRGxhKzBRN3VrRm9zbFJX?=
 =?utf-8?B?VTJmTlpoM25nSHJneHI5bUg1MXFmZmRMTEs3VjNGTjdMVVo0VFdvM1dIdCt6?=
 =?utf-8?B?YVNmRzdLRXdYaitSMjVWMzV1WWJjbklSa3UyckRvTVlHbUVMMW5WT1NlUUhk?=
 =?utf-8?B?WUJJMDh0RE5WUXh3ZmdINHZnblYvM1BzTUQwMThPZWt3Rmc5ODVzWDAySzJx?=
 =?utf-8?Q?Pyco0LGhX4MoszYSGA89c3462?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	9YZjBB6R9LEq4I4yHKS1Cu4RXFr98uM7I6770t/Fj8GW9vpZLBgIkiLkgkwzg+Bd34FjON04H9Yi89cPDSuMyDoXtMc8sO3hW1b0lzE2iLq2Jo1yZlAmxH3E/AyjIYYwtOPdKDKu1rNVhsNweOETyq177iRXFuqslIHixxG2FsRlUdjPba2OwRzfvcOkxR6PehYAPWGD8GKRGC5P5wlz2eY51HrYzc32cgS3nviaNLbkBzuDwT6zKp6Fu4t1OwUyFhb2f2nHyKlq51JBBoxlqeIjJQFCfocTtDKm5xuJJDO/FlaIlKdxG7lQactTjsgrCpNXsbE2lNBvaCYWXwKtACnxsH3y5ShRRSWrSWGZ2wJ9gd9PEorwYWZpR5EY9TY37KdiOBIMX9mK9Wb2epO8aotF0LDI9REHI+zGzWkbUwZxWqrs4oxOPKIJ3RjGJw5jG+o3bYGAbUQP/12XVAlExKITagYMNedEEwwfjQ9YPke37ngxo6lP0FjG9pP4VK2ioZIHWGUOYilZes/PYm8uVsKsUCyj9sGu0x9CzrZ7R5PPi940VAHMdIAfi7NKEm4hFUW5H5e6IUncNoDtzH1ciKPd91TOeAbfRyoUVlj6XKI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 575c85bf-63a1-4c13-cb0f-08dc945eedc4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 15:04:21.9480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7PJPnHTUFOXdAruSpS+QDFa7+L0qviUrbuN5Iw02Upb43+iTa4fXPG0mIJz+8hrCj4Sv6hXo+coZk50XlZC8XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7111
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_11,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406240121
X-Proofpoint-GUID: pMOFRNeDjf7t4Q6XYbYnqBjJpKEW-qu4
X-Proofpoint-ORIG-GUID: pMOFRNeDjf7t4Q6XYbYnqBjJpKEW-qu4

On 21/06/2024 20:08, Darrick J. Wong wrote:
>> diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
>> index e5d893f93522..56b80a7c0992 100644
>> --- a/fs/xfs/xfs_bmap_util.c
>> +++ b/fs/xfs/xfs_bmap_util.c
>> @@ -539,8 +539,13 @@ xfs_can_free_eofblocks(
>>   	 * forever.
>>   	 */
>>   	end_fsb = XFS_B_TO_FSB(mp, (xfs_ufsize_t)XFS_ISIZE(ip));
>> -	if (xfs_inode_has_bigrtalloc(ip))
>> +
>> +	/* Do not free blocks when forcing extent sizes */
> "Only try to free blocks beyond the allocation unit that crosses EOF" ?

ok, fine

> 
> Otherwise seems fine to me
> Reviewed-by: Darrick J. Wong<djwong@kernel.org>

cheers


