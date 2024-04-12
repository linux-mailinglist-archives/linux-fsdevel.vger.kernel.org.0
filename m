Return-Path: <linux-fsdevel+bounces-16804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE77B8A30AF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 16:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30707B21989
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 14:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A5086658;
	Fri, 12 Apr 2024 14:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bWLWG/3V";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IVTykPqS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1B28594D
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Apr 2024 14:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712932176; cv=fail; b=H8e7OJWvZjfCanceZShRSKx1U+uRQkLhGh3voAoJ+6ChcEiIaAQhf1qJRtINH7S3RtyFFYjXhl0pojiEKQR5waGJXK1xwCgc+fo4pk9iipYO3Z1bN2l/7Q/LFba+r9fK+m8XqchGuuSQQ0Y96XQBxrPT4eOOq2vPRMAv8x2KbR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712932176; c=relaxed/simple;
	bh=swciC/C/AxYgYDqMsKvYsYQkwvK6C+nwawt8+YLWHy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=biBq14Iro3Woiai+XGnTCM/atCz7ZeMzB2o83I8P+m08x3Hmrs2CupCTT0mjkxukU1rVOFZTOdEI7SIyknQwYy4oh50NGJGsZSPReLBd7U9PKj5xYl/0VuFiQMNyrYVcu8m5aYUcfJRtbpotFkHRj4p91Ii9TTb+t7r7L4a7UaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bWLWG/3V; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IVTykPqS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43CDxBPN006125;
	Fri, 12 Apr 2024 14:29:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=7VmxLbDhmqoeUrVmookBrqiRd6RLo0ppSgaMkd8JEnw=;
 b=bWLWG/3VL6LAQ3ACF8n5QaTYhaMgFDSQpYOLz41Vdj2TzyXypy9yMo4iDlaEiFZTQLuo
 +k2H7gYoQy9CW6xYzolA371dY4jGxHWbA7wmJBmAVCpqI872kCa2TPF6Eh5hKUp/tTEl
 tDNW1AJUd/Yia9Y0CPy6rTfwVFTa9hB/SzR7Kz2/nZ1ME/qA7+Onrp4znwZKv/AZE88T
 L5bnzbzhSP5D4VX2x8F1mWTbEsRnzNbdbd9BamCjAAg4w+pmJeTB5iIIzp9xWPtngbaN
 4lvg9vU170AJ23LvifE+GtY2mrHZiEOUaqvfySAk/c0oCK7yDTn3bAJ0qXd3YJdLAhnx Vg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xawacuyun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 14:29:31 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43CDHMhv039993;
	Fri, 12 Apr 2024 14:29:30 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xavuhbshc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 14:29:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BuoDuNeUvCLUaAEegS0SB76jH8VLhOGroIgUwLLPFFVIESTQu9+HhaLjDCrLleRhwJUtL0zb57qRoUeTs86Oh+8EVv8G3k5FzkkHvKSE2AN/AivH9vPIp60U59BhN+JzoZp5ByhKmj/Ofxhkj+5f14gBkSmH6yw7yeqYCHFBujzuCJubpOsW9QobTnxb5JaLYkTLhrgMUQO1WGnpUFgFmHykfBgrDnkc40tNhOa7iWSX4neD/Vf/cEDcfmLr6ocAtSmDCxF8IKkSIK8+7ggDGRG37z4inwkRnNUtFZ1G3OblIbzGeeJWOGDLnGxA2sZLbLZg687xLGQFq5DhRKSsYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7VmxLbDhmqoeUrVmookBrqiRd6RLo0ppSgaMkd8JEnw=;
 b=aCfTzEqoe09SPWJ3+pHaH6cMS9TmmQY7sdOEFsJD0/eMSHxNFh1JvumsZHex/6/4yUkGNLBOMVOoPIePi0qspibNVjJLX7S4fxMVQ3HaffwbSU5VR6UlzlzYwQluTh2jPFOy4hrxCLCjbUPBITX0CDEeODBVIROPPqOT6zeLBsuI40jSLrsZatZ8w5veRSnkAzt7jBgsIhSFxIdTz2aRIdsXeYtmlsKphDEyhrZ3grw7Czy6qj9SzjWIlo/VrVSllmOWOg/y28dvpBdg/JK2IpRLGaxUOVSTtGdB+Q1h1x6MVdcEKwT5SOKmmpbP3nUIe67gsMsfhMohRwydQ3WF/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VmxLbDhmqoeUrVmookBrqiRd6RLo0ppSgaMkd8JEnw=;
 b=IVTykPqSPptJPRR3nga6dDUIXmOetBcLtpvj889guLtzCbbN7CQR505EVX1ONbIp/pirJd17erl5atHG7q5KUtXFYH/xhzgFIfWS2dG25RPb+ipvO9SKwM000X96hmdSCr3wJNQlM2o3ocGAF0GtNlmgBDMZj0g/bnDqpx3UFE4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB5735.namprd10.prod.outlook.com (2603:10b6:806:23e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 14:29:26 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.7409.055; Fri, 12 Apr 2024
 14:29:26 +0000
Date: Fri, 12 Apr 2024 10:29:23 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: cel@kernel.org
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] Fix shmem_rename2 directory offset calculation
Message-ID: <ZhlFQ6HFF5p9qUaX@tissot.1015granger.net>
References: <20240411182611.203328-1-cel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411182611.203328-1-cel@kernel.org>
X-ClientProxiedBy: CH0PR04CA0069.namprd04.prod.outlook.com
 (2603:10b6:610:74::14) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA1PR10MB5735:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a3c4dce-2d55-4d8f-282b-08dc5afcf498
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	F8J9gKwhOcX8Dt3DcJNEVv/eEueIWiuY2uL7i6GghRmU2wDj9NmXN40iLOUOg/gpvnDPN3r3W3XhqMxlJL67DB3CnxHLSOsuwGF2nf9P5zMD71idptofuCkzpEWrig8OycYw5pkcDXEiXn2TQFKgBQfVcy9dtHh/EKWSLIfB61cz05l3MsxNXVnWDsLyQFKfJ6eN4ozUN4LzAW0HRcNjfS71xUqOd36vHpmtC4jhZ1ifr8ZjmDHoUIPuoHjxMRMup/Xp1Ei3b3nJp/2FL8EjPMOwR25GsCVqCraYEuHAem30jVyKhL/dwsH2I+CNdCIPZGRUGbk1pHcQJVbp2XyQvhjlA59CD1Kjt5jOZSLwyRkbsEqah31DblPVhY8m6p4zlaWgUzcooNteJWMTPe7QLWpIjNy9oP1jy7HCiPTdWByc1kzW/uAk8XvN//RITRuScK9qmiF9IVGp3oIR3tF6eg5TIeYZ+4eD2PeoH3i4xEPw2u8y/c4Dwsf5Sa1/b/49rIn4IsKSg77aG5co9NVk8KuUwQtTTMwodnNonrp9Xmd/i3G78kD7v0RaXGY6f+Pnjj+dL+XDQ/fcUG2QXbCPernMu8AVBqvLQZ0OBUWSL1g1UlzC8HF4sWXODXm7OV3DJJ6jgnCl2hNnpADmBY3uKZiwlZRxNvyVZn0XAXc3jzA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Sg3F1Q5jiISpYhK4lLJ6Xi3pnU+UMVhpcF7r9ZtN/L0w+8lSZCG5ugHBHsd7?=
 =?us-ascii?Q?PPj4cMERZ5fQvZ8FagxbX36JKxrOIFc6pRYeP0zLIGa4qq9tQXGCP9tUf+ma?=
 =?us-ascii?Q?Iw5yQpqC2I+ETONS+/7QBSStD6lOB6OhKjW24+fLtogckcc4Uv99/zs2I8X8?=
 =?us-ascii?Q?gdEUl7eFUQaQDoQKs7X+2hHiA0r/adu317eNq/ml3l9KP/q6myW9Q+v3mrOL?=
 =?us-ascii?Q?dQB3RZoqEdig9AYYJ5dsN7g6yRzOKK7oh/4qKtt5lnptqRQL1chpM5pYc73X?=
 =?us-ascii?Q?uxxGgnNEMcatA9LKz5Ib51rKLuPR1kFsrZbZmBBoMmP/Ya1Rq9GK2m5hYu9v?=
 =?us-ascii?Q?kpU8PcgiNLcz2ap7pTNEJajAkcMt2nRH8oZttEI47wiFNuWeGi/qn61sikZi?=
 =?us-ascii?Q?WTT1VSX7DO7bI/HKAkfs1Rs7MTHHJN8mJUvvSTgOW8UwiHn0lbH8FAZwcP6e?=
 =?us-ascii?Q?OBOGl1fHY00ZVQWLsAQgEjtMtmOmnCKYSL6ZQo7O12xiIs/EPIiztVjhHBjE?=
 =?us-ascii?Q?S8Ff7MpIB3iDZ4stn3Wf3UgEl7ooEl1omoe0rM6e45HZ/TVf9XJtCEh0n812?=
 =?us-ascii?Q?uODQJIfvqc0+nLnxCNP2dsO7DXniDx/bLv/vBQ32/I20OZ1azqa6+EVvIKZg?=
 =?us-ascii?Q?9/kHpJc+XkvhBKROIS67E+FwflyPU8UzaMAwzJKHgtUktEd2ArpvblZbUQ9t?=
 =?us-ascii?Q?IYByecqhZItrDKuGoqPsw66rcJ+0g7MBVF/7FHHbNtb4JVYMjmURvJTbDHME?=
 =?us-ascii?Q?c8Lp9E91FToTeUC+sGn2gQZIOpnffwjGh5dE9pepFkIs1zC+o1bz3LYdpwOn?=
 =?us-ascii?Q?vX+LcU6/5BKyCfHtx5fM0cs4ohQuOXsrnLTMPc3K4sNejJtvz1kmuSH9uxZ1?=
 =?us-ascii?Q?SBJcjF2sDUwLTDeYJ8x086aT3fM3CJb1MID7lgMp+ut8dMyvxms0W8MtIeF0?=
 =?us-ascii?Q?w/JTpKTtbjUSEn1hDUBvQlVP1Pwwmhs0VhkjuCyvyZbhRODPvTZ4X68mB1s7?=
 =?us-ascii?Q?3rcKsoqbsHh5W9VXps0goLv5f4yxKtiFH91suS1/PbSJqKxojGzEm+i31bAO?=
 =?us-ascii?Q?dpQOoqi5HcoLZZB+aliAiQZWhENtn+Hf0elSODB6y+QtLDv3SNq7lEcJmGV/?=
 =?us-ascii?Q?P57AbuRioR7Qrla3GTSFOnWRHyo7rMZ1WiZT3UKhYRjOiYgbWgB2UiWHe+k6?=
 =?us-ascii?Q?w17ahTCc/ccUfm1SSBmwl0XQrLndoBnzNDi6DWTpEOArBLumklMUxkYdR0ie?=
 =?us-ascii?Q?xREBNsQExbl4C0ObrSoo/H/lHFfLIgxR4gn3WPED4CfAnHdtYk63p2TPRbCt?=
 =?us-ascii?Q?GuMCjiCKJwsNYHkX3fAND4oTPS6VBgJKDanLhY0sQ3h3433YtB0NJjAhZaPK?=
 =?us-ascii?Q?crZ8Hkq/MlEtV/meAqrOcGOM6vM+Pb7ewLmmK2OCjj1/vfNA6DxKi7tmA+vz?=
 =?us-ascii?Q?411GceN2ofHtkCuAZtOu73v3xR+sa7e7h164XtkXGzDLXGU4HyezbUia/2LF?=
 =?us-ascii?Q?PAn/C1dcdpFyMc5NKpSOMhtpSOcKHIFluFxRdJ7tkx673OO4TpPSlKFr9Ho4?=
 =?us-ascii?Q?SEX9Z/1un2G6nJkFUtr0w3uuN3ziKTu3/otO86HedKyovOAS3w1pCu6msCjL?=
 =?us-ascii?Q?LQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	b9T6WKuQqASQAH430dBveVIcLYJmJh4Qyi1X+b8xr7xe22gaghUZhmzsQhHc+uAY0NITmislfBiniBC/zsYSGVcniFpMb1xOVsrsi/uADGsPJy2t0SmoZ1uiuWsxweHtJsy9ZM6b9TayOX2Z++aOf3JdXOopZuKW4gktImPbNfTo56dX1zm30hwm55qzSBLlQJmmMQMX40J1kE2gp9kngwBXCibvW9imiWNQNhjbZaMUjz4VHxGH2tsvAAX3vri/a4JdkxoSYZazKUx9QhlBKOJZq3oLc89i3J0rv2q4+4F0J+k76JvGJs7xObAtBepErgyD7I8BmNETA0eI4D9Oedik/3aQdffBGF+HZGVms4ObjcvlFN9A2r4ab9MyTNTH0uJxrTDSWu0kRNACldmRyHxKL5iUk6VLPy7TovyOVnVFP3nnLb2HhRNxk7uLHp48MoaYxJR/UwOwlhBc8iKMuxKfp1UEY3iyi9CEVL54iJUor5QO7aqs0xj+lCd+6u3o8YDiljrrsgw/QikVBGJAProHBmjG9JrbCk9MmYNsvSSm0w6n1Hwm35BYcDcUL98gYPwzJYDinh2ugH85HAm85CSDbliO4phueJ/4SOyeZG0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a3c4dce-2d55-4d8f-282b-08dc5afcf498
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 14:29:26.2657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AgyCXBF3v/LffoaSsDIJVyoCQhOQPbbWaAeSE30Sksg9W+37+Cq2WQXXrjikg22rpFkltv4eMkx/HpA2tOLTNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5735
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_10,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 mlxlogscore=751
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404120105
X-Proofpoint-GUID: PxcgddA5NHy-9dRxdgKOQpm3h40DL95x
X-Proofpoint-ORIG-GUID: PxcgddA5NHy-9dRxdgKOQpm3h40DL95x

On Thu, Apr 11, 2024 at 02:26:09PM -0400, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> The existing code in shmem_rename2() allocates a fresh directory
> offset value when renaming over an existing destination entry. User
> space does not expect this behavior. In particular, applications
> that rename while walking a directory can loop indefinitely because
> they never reach the end of the directory.
> 
> The first patch in this series corrects that problem, which exists
> in v6.6 - current. The second patch is a clean-up and can be deferred
> until v6.10.
> 
> Chuck Lever (2):
>   shmem: Fix shmem_rename2()
>   libfs: Clean up the simple_offset API
> 
>  fs/libfs.c         | 89 ++++++++++++++++++++++++++++++++++------------
>  include/linux/fs.h | 10 +++---
>  mm/shmem.c         | 17 +++++----
>  3 files changed, 81 insertions(+), 35 deletions(-)

A cursory pass with fstests seemed to work fine, but a number of
tests in the git regression suite are failing. Please feel free
to send review comments, but do not merge this series yet.


-- 
Chuck Lever

