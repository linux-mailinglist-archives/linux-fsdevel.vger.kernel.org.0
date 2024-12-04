Return-Path: <linux-fsdevel+bounces-36502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DA99E4644
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 22:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AE8A165E9E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 21:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B7619007D;
	Wed,  4 Dec 2024 21:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UB5Xdj4V";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aKbCHktF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EC018FC75
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Dec 2024 21:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733346387; cv=fail; b=Mh5psNiVsqhPokd+4oFP1TvAFDTWhHcjUdTYXNO4s0OqPv7vSdPIFPkCywe+w402fkGhb1xwUBefg03u1osm5qeEaEt1hpkFYZk9ir1N/RhW3aQh8zm8KYhNlMHZBbaqT6s3tvZxALWbiyb+TRi1HnILEgwVKM4yS0+rH5v2uzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733346387; c=relaxed/simple;
	bh=QUJPbUaqX6EBBdYRvFyiXZvE3z9vTpy/Lr9GDocZioQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GQ2s900Ne6bOBH1AC4iXbvQpMKYZSdrsDSnJOHJQ5S2N4YIM4oj8vp2Xid5R+4wy/XV0hPWTUWYFC2Aw5g9TmTaRUwoXS8kOYbOSnSZPTzOe9WAgEJny91sBraifGz1wGlCk3/m6cBjpwDNOMRImKV40z4cBJ2sChSZaoPxAT3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UB5Xdj4V; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aKbCHktF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4ItsRs008787;
	Wed, 4 Dec 2024 21:05:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=XF6g4s18FuDWQNTuJ7gbq03Ock7mTnpJihRFNbGwL4U=; b=
	UB5Xdj4VnFVtqbqWxm5rYhc+KEurV7eF0im8n9547UWqQMlfRKBIVAs1PKanJcYF
	8Atie3Vtkh53VYpz6/Rcv62YWOKDs6pLVlpXHws6n4TcA6zTLuDsnBfLKB2edeh7
	+uSEP1F/w/5C0RplpdtfKjWj6Xp6A3bJSM+Mj6HorcvhmFgUuvlMrUTIxXpS8vUF
	zlCSAU+wndOzuA/EOSmV9zdw6Vb1xcT7oDiK2jf6ha87j4uLSmbwQjAoofXra7Ik
	ftNiH8pstNxZyMk3hAyfinbVB5pKLwfzTmKgX8z3nLEKOrYSdhZEpie2dS1AKFDR
	be8RgQkf5qaaALtJcg7HXA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437u8t9h6c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Dec 2024 21:05:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4JbaOY001458;
	Wed, 4 Dec 2024 21:05:55 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 437s5a0f2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Dec 2024 21:05:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vgTflY5pE3UqJEoT9nyXKwdvJi9qDKW18R+F2MdlPPLXe4IF5rw1eeIyLejZwYYOPTxrl/U48U8D+Js76KkD9hW2dQv1Zr6Tztdne2wsdTlfGR+h0QmH49hrWyGm0X34+ioYiwvW4XqIBcPd/3MUjZEjbw64VGpjic9WizaTIpUw68mwHgmXj8jqVzPu8uvlDHcVGYZHRv+P5DcncvjwYkL9gw7no9QuYhF1nqdrcvb7GaL2IvBCbpfwFkfb34nqAqRrfQtrHUkwy534jznA95b1nHEe2JQG7etdBzNVn0NAo8Sx333kG9pbAqj/DH3Z6QqLW6tFjxVEHFRB3ftORQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XF6g4s18FuDWQNTuJ7gbq03Ock7mTnpJihRFNbGwL4U=;
 b=dz4/mATeKgoXsCPJ82ysgD2QG+gBmh9y1tIjainn9putpV6LG0lpi1L4gvUT/Z85/nA8IIPzPYIXGSWAG6KakjM0Mby/ObRfsmHw7uAulYE9z6q3NTRNz/6KZFgKTqsayK7rZ8QPJL6xIz/0tptLMxzQTSaZhPAhQF2tDdalh6q+kBaJmZ9v8ArHUISadfkQaXyTTfFj7KrrfPvDD/vLMkKuN7kL8pvMh3sv+WAwJZnrKFIWJJl1zvTMvV2kaP6PzrwBq3vKu2t4FCNK/0JRPcla+USHsWqEgc1YoxvtEHlyo1bplcU3LhvlAttnJhJ86IuLcFO0jfpQqZ2ri/Mbow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XF6g4s18FuDWQNTuJ7gbq03Ock7mTnpJihRFNbGwL4U=;
 b=aKbCHktFtKhmfdrsbuGjYDW+cIejH8Anhp8gj2b8OCyvrAZBFvbk/edrR4PWI5PNxiM9FgwQyyN20VGF/Wx6Hxhvu1Xp+79xMDlVi3IBzCw6KLCoBo/Xe32qnw7p+bIpieDGoVxdvB5zWlDfHO+1yAOREhX4fnYnKEXyCprfVAk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB6111.namprd10.prod.outlook.com (2603:10b6:8:bf::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.19; Wed, 4 Dec 2024 21:05:53 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8230.010; Wed, 4 Dec 2024
 21:05:53 +0000
Message-ID: <5d1e7ea8-be4c-4906-a1d4-835fa46da605@oracle.com>
Date: Wed, 4 Dec 2024 16:05:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] libfs: Improve behavior when directory offset
 values wrap
To: Amir Goldstein <amir73il@gmail.com>, Hugh Dickins <hughd@google.com>
Cc: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <cel@kernel.org>, linux-mm <linux-mm@kvack.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Daniel Gomez <da.gomez@samsung.com>, "yukuai (C)" <yukuai3@huawei.com>,
        "yangerkun@huaweicloud.com" <yangerkun@huaweicloud.com>
References: <20241117213206.1636438-1-cel@kernel.org>
 <20241117213206.1636438-3-cel@kernel.org>
 <c65399390e8d8d3c7985ecf464e63b30c824f685.camel@kernel.org>
 <ZzuqYeENJJrLMxwM@tissot.1015granger.net>
 <20241120-abzocken-senfglas-8047a54f1aba@brauner>
 <Zz36xlmSLal7cxx4@tissot.1015granger.net>
 <20241121-lesebrille-giert-ea85d2eb7637@brauner>
 <34F4206C-8C5F-4505-9E8F-2148E345B45E@oracle.com>
 <63377879-1b25-605e-43c6-1d1512f81526@google.com>
 <Zz+mUNsraFF8B0bw@tissot.1015granger.net>
 <CAOQ4uxhFdY3Z_jS_Z8EpziHAQuQEZgi+Y1ZLyhu-OXfprjszgQ@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAOQ4uxhFdY3Z_jS_Z8EpziHAQuQEZgi+Y1ZLyhu-OXfprjszgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR08CA0027.namprd08.prod.outlook.com
 (2603:10b6:610:33::32) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM4PR10MB6111:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bb08ba0-c631-4682-86ee-08dd14a76fdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a25ocTZ0ZjhUSmdDN2Z3MTMwM0FzWmtid2JCVkd1OFkzU1NLbWRrUFBDZFFL?=
 =?utf-8?B?V1VOdDJ5d3RNaGY0TlJTUk5ZUStKL0J2SEZ4SW04cVlVM0p2bXJCTGpEdzha?=
 =?utf-8?B?N3VJMUJhTEs2dENTVjhVaXRkQW0vVW1CUWZWRXlIUjBCbVFIaGVWQVNSS09T?=
 =?utf-8?B?QVQ2empvT0RBeFBoM0d0Rk1MVTFQaG9oTWtoUERqV3lpNWl3dEZ3d2p5N0VY?=
 =?utf-8?B?RHd5R2M1NEtGd3VmSk9XditOTVFnRytuWkV1S3dKdldiOFNMOU56OXZ3S1BN?=
 =?utf-8?B?cC8vNmxrTEEwWVRNSzZGbGZaU2Y4L0xxTjl2TVJRNzNoanBMd1AvZ01XU3RG?=
 =?utf-8?B?d1E4eUN4ZWJ4eW5aNHZxZ0NEWEZteWhnNCt5d3NRUXJZbFpGWXFmZzJORWpN?=
 =?utf-8?B?VjZMQWswNjR6SHhkdFpWSXN3ZWR4VFBZQ3VjTGErTkxjckNmZUorUksvOWlH?=
 =?utf-8?B?YzFXK0hLSnVUV3ZBUUNtSFl6bFFkT1NKL0JiUGRldjd3eWtyamlFN2grdERl?=
 =?utf-8?B?ZVRoRjFOVklMS2Y2Z0hUa0JwRUNBRUtXdmN5MG5xUDNWc0xIY3ArY0w0UGRU?=
 =?utf-8?B?TUErV3ZucGV4VkZMWHVUWVZmcitQY3pMbHd6SXVlTHlwU2k5NjR1am5BSmxp?=
 =?utf-8?B?YlNiL1lHVkR0L0t5VTNuYlFmNDVDd0VLb3BDbGhLc0FTNGFmOUU2alY3aDhL?=
 =?utf-8?B?QTBQdjdkbWc5aTVaakVObUEwZHBXSGg5dElpZjFhM2N1MDllNGdtaHJhTXlr?=
 =?utf-8?B?TmlaM09WSTVnZ3FIYTdjRE44b0k5c1Nzd2ZrVFBOaStZVUdYb3lnVVNleW5z?=
 =?utf-8?B?dkV0UXp3ZjFic1d4eUYxUEdNVXBBVGNjMGU5dGZ0ZElucXhBY3NFNjA0dEVX?=
 =?utf-8?B?QmtwZzlJZm96bVpqYmc0Z0QrMHppRFBETTlJeWc2dVhGS0ZmWXdhMGhkOXg3?=
 =?utf-8?B?UWhYamdMejFhR0V1Wnhic25yVmR0YlZMVFpqODNDREFzdHZWQTl2NC9qWEJn?=
 =?utf-8?B?QXI4Wnd4NEdLZUFXUitCQ0ZEMHM5RnVYQWpQWG5YTTFSWTNlTjJEYitHWXky?=
 =?utf-8?B?R0l3L2ltN1AwL3M4TE5xZUtCYkFYWmdGMzRwbEZyT1ROa3RTRWdnclhYNlhx?=
 =?utf-8?B?V0RmSVFuOHhmdER1cTlvWklMR2VVUWN0ZFdPTWkrUzVobmc1V25DUEp4OHZF?=
 =?utf-8?B?bldraHdlL0xKaVVaMFl5TmdRMVlxSlJodDVyelg1eTZqeHY5ZzI5VlUzUEVr?=
 =?utf-8?B?Ri84b25QNGsrMGJhdE0wWXBkSUt5VWFHNmgxV2QxOHlsb1dZdGdDbkxLeW40?=
 =?utf-8?B?d29UVWJ0WmY1SzI1ZVpPdHIwbFBIR2k2YkZ2Ny9rTDJZMTJmSFZ2SW5IbkJH?=
 =?utf-8?B?elpZK3cwcUhSVmJBWnBjRGlKODdWL05iVUdPTmExeWxFNTBGb05DRHZvUXlm?=
 =?utf-8?B?dVdwczAwVHR0czZqSzNtZTBaSTdteFR5M0NoWUhlM1lacE1jb0JvQ0IrRkVH?=
 =?utf-8?B?cnJwWGxDWTlpWEhNNnpkdFFwVk11cHJQZUJTTEpOSkZzb1o1RGJ3RUEwREZl?=
 =?utf-8?B?YkdkS25ya3o1ZUlkanMxTnc3RUlWVlpTU01kcFd2dThWcytQa3hKUHk3R2t4?=
 =?utf-8?B?ZXFPK1JHOWMyYTBadUp2OEhsZHdtUkxCZ0VnY3FVVnJ6cUlvNTVlOEJVYW9I?=
 =?utf-8?B?VnR6Z3VhRU1IRzJWaXY3QmxCOHVRUDgyWnZPYWQ2aVRqcjVaODI3VGtlRzN1?=
 =?utf-8?B?clJoQnhvTTBFY09JNmhaSTJ1UkVSTFN2V1EzVmlHS2R0YnErOGxLMkhaeXVM?=
 =?utf-8?B?ZVJVWVJtNTRlemNFK01TQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzhjQ25CQ1N3NGp1YWkyNjNmcHFCSXFqUEY3T3RLaUJMcFp4c0xPd1hybTdS?=
 =?utf-8?B?d1J6eHZ2VmhBZUJ1cUJjSkcrV0V5UmRkdnp1UElmaGZtWHBJakJHSThXOGFV?=
 =?utf-8?B?R0FteUFwR3dhZHNhVTVKZmRlVFZTVUFBUzBaUVZwbHE2TDAzNmdrQk1TV0xJ?=
 =?utf-8?B?SkV3Wms5SWtqZ1l4SStmMkMrRXE4eC9JZzE2UWxyS2hySUFTU1owdXNZNkFW?=
 =?utf-8?B?UlgyOUpvTmRweFE4aW5XSDB0RGU5eG5LVDZ5ZUpENGE4dlovT09ab1V4MS8y?=
 =?utf-8?B?VGpLOGh4WDAyU3czTnhjMDkyRGpnVkVQeFZiYXE1NVhPbDhYK0laVWFQU0R6?=
 =?utf-8?B?V0FkVXVjRHBiQWtZb1l3dk12eWFtT2dMOGJuRHI2b2NkMHQ1ZlVxMmlackNi?=
 =?utf-8?B?REx6YXpWMWhVUmdXSE5aR2NPWSsxWGhUbWV6WEVTaG5KL0dhVmFFQUhTSHJQ?=
 =?utf-8?B?VUZUMG5rM1hGR3UxV2Jwc3lYb0tLM0R3d2VGS2FYTUk3dTAwMldLbndrMENn?=
 =?utf-8?B?blRUd3ZCSUcxNHFzZTBtNkdLZ0UvdUZtVmRTMFkrc09LYlNKVGhQUmZqY1o1?=
 =?utf-8?B?eFEzdHh3RXptTDc2eXE2L2xlakFta3R5ZXdpT2lDZUVkcTVvV05JYUw3OUx1?=
 =?utf-8?B?STJrR3dYMmJXY2tycFdnYlBBUzdoWURFWHI3SVh5QXhobVV5WU80Y296TVkr?=
 =?utf-8?B?UmNmQXBIbmQ5ejJSSzNjWTltUUQ1NnJIK09mNTM4ZkwyNGpKMVI3d0hjK2Nv?=
 =?utf-8?B?VVVwTUVpOFcxWUhZQXlDbjNZbEpSVzZpNW80V1dNTjFUeC9yQm41S0RFaW1r?=
 =?utf-8?B?aUIxR3dBT0NrNW1tak1EZW9NK1RQMjhJc1BaNUJLazR4MWNqQ2FNZC9ySDJh?=
 =?utf-8?B?OEswNTF3MTdBdjZZS0lxQWRFVWtDbjk5dnR4RXZ2Rk1UdmJ3VlJmUC9nZnJV?=
 =?utf-8?B?NklJajlPZjNUOFg2d1ptbUxTQ0tMSERqNnc0cEhsYTNVakFRMTJQcE1mc1VT?=
 =?utf-8?B?S2RnTi9hSXliaVZqLzNOTDAvWDFXalMycDZoYUFacUF0RFhCZmR1NGUyR2xG?=
 =?utf-8?B?a2hPNms3U2ZlcDJNMUVjMmpKU0tNK2Y4elF0clBsaTk0WjFkK3p3Qmk4dU1C?=
 =?utf-8?B?VUI5eWpSZkNDbXFra2ZQdGxwT3QvaE9xTGM5TmRJRmpmMzFjSlJveEJXZlFj?=
 =?utf-8?B?TVRnYTc5RXBZZlpqdGtsQWtlTERBMWFkNTRQSVlaZ2w4cFVlTGFicCtMbGZN?=
 =?utf-8?B?U2lSSHdndGVQVlR6RTBjelFrYzZNUW9VK0N1aTVTaVl0Z1Bha1NGcllIZy8z?=
 =?utf-8?B?Vy85S3g5MkNlY3YzeFM4aUlPRlp5dEFIaC9WZzRqalZRKytCUnpIVlFWTWYr?=
 =?utf-8?B?M21zcW1yeVBFNkJEWVN3WC9XVGRSdHlJWEp2NUQrbGJ4Z1JHSGNFR1BRb1hl?=
 =?utf-8?B?YUhJblhmdFRWcm5DbzlRZkd6YktHOWlvbHZ6OXBVNVFPTVpjdUVwd0ZyZzdm?=
 =?utf-8?B?Qkx2bTloL1RLdnVwZ3h4LzJUci9uL0pDRmJUbCtLU1NwUnpkeTFJL1NxTmpZ?=
 =?utf-8?B?anIxUFM3U2VURWxtVW9iV2ZqQ3ZzNHdyV3ZGUmRQNXZVb2g5Y0VHNWlVdVVK?=
 =?utf-8?B?dFpJSzY1Mk5pT1hJcHdweVUydmo5U3hYUmxiRTJmYjIvdzdsS0Z1L2hvRjJL?=
 =?utf-8?B?RmZYZCtoWXVCa01xSGFEZ2twMEJibitVUjN4VW1FZkl0MS9SK1BzSXVCaC9w?=
 =?utf-8?B?T2t1bWh2aWh4bDROUHNNd3FsZ0lQU2dPVkp3RlliRkFGK3FWNEcvMlZBcm85?=
 =?utf-8?B?S0V1QVRZRTI0WW5HTmZaNTNvdUhYdDdYQWNkTTlncWFDeldZR0tWNEdwRmU1?=
 =?utf-8?B?QWV3V0RWRHhTVkV2K1hwNzlzN1JEeFRCRS9NbVJqR3VTUGZzdmNMVWs2KzEw?=
 =?utf-8?B?SE5BRHJXUXhVSUp3MTZsa1RHcDZwQi9vanVhSFhqSE1VdjZLTGJIMHdxeGdI?=
 =?utf-8?B?YmkzTkNJYnRuL1dVN3JDNEUrN0ZpS1dPUldhZGpoOERhUVJBcnJ1eFl4Qzdi?=
 =?utf-8?B?OVZRSjJFMFl2K3ovV1FHbkxKdGFPUk4wRm5hbVJMZ1ZtYzl0SDEvVkJtMitD?=
 =?utf-8?Q?Q8iN8MNoJcinHEs6eBpeYcPtz?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kUmzN8XoYM9xNZybziIcOkELQm/3Lijm5O2YEshSIMF6xtd1CgwmOoidKEohGsKlv2lBiiqZYo1E6pUHz9k43YpPoKKK3h48NUppKppEDL7fB0grB+diQaVTXTvn03t5Ycv2bTCDp+dUc8SXoj3So7p/lnaWzxprbMjQrz0542XlkSiHJu1gPmAvxF+3KXmMCheNK5UyI0gqL/ZXotHIVtmZ/R+uKMS+Cv0bcvZ68H8uj6xr/pPg4hWzu2EjYzbEKLY84LV+zv71vF5a+Anw7rIK4CPixHu9EXn13EignDXk6yt2gVkZNw63SSzjoU+D9ElDifSg25bn2D205+LJDfR8e9deJsKd9+z5F9hXa47LECVJoTL+A4XpATIDieXQ9ZDH8iGPUPBDQz9d5KUgzEzW9SaJHi19evPWk+itR4H8HXDkNcdP6lbSU3iD30LUch2D651N/wwxyE2PbMjX0YVbNqCmPfWVHC0zN9S9dMXQnbRqH4jjIvBaIDr7BusCzK0P3SC18uPc+tRSCasLnLc098AFqUC0YeBLecOoIOCVrAtlRk/ImxJ14UFNEU2wdPlskEOjQPLlZjU5PVra/VXVyA0R+C6bnDYuY15fn0o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb08ba0-c631-4682-86ee-08dd14a76fdf
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 21:05:52.9910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sxOJ89/2/SJR/MiDDyGaFKW+1usr8jdRZfsFG0ogE9egAzjRsKhuiHrAnlBoDdv7CP/UTXngPqH1WTbChvUiBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6111
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-04_17,2024-12-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412040161
X-Proofpoint-ORIG-GUID: NZuT6CtSUQaapQcVqaVXvIHHVA7z4L2V
X-Proofpoint-GUID: NZuT6CtSUQaapQcVqaVXvIHHVA7z4L2V

On 11/22/24 3:49 AM, Amir Goldstein wrote:
> On Thu, Nov 21, 2024 at 10:30 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>>
>> On Thu, Nov 21, 2024 at 01:18:05PM -0800, Hugh Dickins wrote:
>>> On Thu, 21 Nov 2024, Chuck Lever III wrote:
>>>>
>>>> I will note that tmpfs hangs during generic/449 for me 100%
>>>> of the time; the failure appears unrelated to renames. Do you
>>>> know if there is regular CI being done for tmpfs? I'm planning
>>>> to add it to my nightly test rig once I'm done here.
>>>
>>> For me generic/449 did not hang, just took a long time to discover
>>> something uninteresting and eventually declare "not run".  Took
>>> 14 minutes six years ago, when I gave up on it and short-circuited
>>> the "not run" with the patch below.
>>>
>>> (I carry about twenty patches for my own tmpfs fstests testing; but
>>> many of those are just for ancient 32-bit environment, or to suit the
>>> "huge=always" option. I never have enough time/priority to review and
>>> post them, but can send you a tarball if they might of use to you.)

I missed this offer first time around. Yes, please forward these.


>>> generic/449 is one of those tests which expects metadata to occupy
>>> space inside the "disk", in a way which it does not on tmpfs (and a
>>> quick glance at its history suggests btrfs also had issues with it).
>>>
>>> [PATCH] generic/449: not run on tmpfs earlier
>>>
>>> Do not waste 14 minutes to discover that tmpfs succeeds in
>>> setting acls despite running out of space for user attrs.
>>>
>>> Signed-off-by: Hugh Dickins <hughd@google.com>
>>> ---
>>>   tests/generic/449 | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/tests/generic/449 b/tests/generic/449
>>> index 9cf814ad..a52a992b 100755
>>> --- a/tests/generic/449
>>> +++ b/tests/generic/449
>>> @@ -22,6 +22,11 @@ _require_test
>>>   _require_acls
>>>   _require_attrs trusted
>>>
>>> +if [ "$FSTYP" = "tmpfs" ]; then
>>> +     # Do not waste 14 minutes to discover this:
>>> +     _notrun "$FSTYP succeeds in setting acls despite running out of space for user attrs"
>>> +fi
>>> +
>>>   _scratch_mkfs_sized $((256 * 1024 * 1024)) >> $seqres.full 2>&1
>>>   _scratch_mount || _fail "mount failed"
>>>
>>> --
>>> 2.35.3
>>
>> My approach (until I could look into the failure more) has been
>> similar:
>>
>> diff --git a/tests/generic/449 b/tests/generic/449
>> index 9cf814ad326c..8307a43ce87f 100755
>> --- a/tests/generic/449
>> +++ b/tests/generic/449
>> @@ -21,6 +21,7 @@ _require_scratch
>>   _require_test
>>   _require_acls
>>   _require_attrs trusted
>> +_supported_fs ^nfs ^overlay ^tmpfs
>>
> 
> nfs and overlay are _notrun because they do not support _scratch_mkfs_sized
> 
>>   _scratch_mkfs_sized $((256 * 1024 * 1024)) >> $seqres.full 2>&1
>>   _scratch_mount || _fail "mount failed"
>>
>>
>> I stole it from somewhere else, so it's not tmpfs-specific.
> 
> I think opt-out for a certain fs makes sense in some tests, but it is
> prefered to describe the requirement that is behind the opt-out.
> 
> For example, you thought that nfs,overlay,tmpfs should all opt-out
> from this test. Why? Which property do they share in common and
> how can it be described in a generic way?
> 
> I am not talking about a property that can be checked.
> Sometimes we need to make groups of filesystems that share a common
> property that cannot be tested, to better express the requirements.
> 
> _fstyp_has_non_default_seek_data_hole() is the only example that
> comes to mind but there could be others.
> 
> Thanks,
> Amir.

OK, I finally had a few minutes to look at this more closely.

As Hugh points out, tmpfs will permit users to set trusted xattrs
even when the file system is full. So IMO it should be excluded
from generic/449 explicitly -- this test won't produce meaningful
results. On my systems it runs for hours.

Hugh's patch above seems adequate. IMO that change or something
like it is entirely appropriate for upstream fstests.

NFS does not expose trusted xattrs on remote files.
"_require_attrs trusted" ought to block generic/449 already. I
will investigate/confirm that.

I'm happy to drop "^overlay". I don't have any explicit concern
about that file system type.


-- 
Chuck Lever

