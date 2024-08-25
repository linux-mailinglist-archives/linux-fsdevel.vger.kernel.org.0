Return-Path: <linux-fsdevel+bounces-27063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 321A095E41B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Aug 2024 17:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A4B91F215D9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Aug 2024 15:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A97156F3C;
	Sun, 25 Aug 2024 15:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="np1eLSLx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="k1zLibox"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A4142AAF;
	Sun, 25 Aug 2024 15:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724598916; cv=fail; b=NJCWmJpwIeaYHY8V9vJwAdYcbvCun2qKzXfj17bQ7uWLPQlNV+gZvkfT/5dH8ZxcNaelCBNpLLgVcfMlXH4Zdtys5pOWsYIUDC1ET1fOK7TpBoc4qEnAjK6MNRmwsFBO1MkGhCvycv6ruztncTWNQinKgH/04NDWjYEZOb973ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724598916; c=relaxed/simple;
	bh=Oa8UQ/MCpx8Lx1oT7yuix1kUPVjvYT4kSQEjn7kpfVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q26HFIsp+kEhdHYawMyJeOqqVT8cl3ftfqd40urP+0N+9/gRE3EBXXVXOMJa6Zg6rcmqjFfNA176Xf5jKkOXhr8CuDTUba1G3cn0g65PYL5CD1BhSBcHcOEU6hBVbWkmU5DCRlanG5ZLKJjgk9Ptr/fuJxIOLv/yVHde0bv6A48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=np1eLSLx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=k1zLibox; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47P4B3Gb004604;
	Sun, 25 Aug 2024 15:15:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=fmLbnzS6+Xu1Iuc
	NSV+fOVg3t1QmPh0vCrC+A/vBF/8=; b=np1eLSLxQP9Fgtku2AT6qekddEpl/Go
	E/f7cjgTLkbCXzr9dnGe0Q376SfI5xjHtb0H3JQC5Y/BJgdhEt1ekR2j+iYAlh03
	/8cSoHpNina2rBXCY5hIkds13xsMh/FoxfYcMMDjN4R7yDskncqPn+TC0Gnqpo7i
	EiG8yC246NT8gbayGwwyq6q6TuU9HRDgKTIcRB+ccCUpyt2TnHAr23CeXgwoF/hx
	QbwJSfNHkKEMsPaW9TgnyV1LUBu1JOfUpY07jQfnyC0jam93IXG2QtVZQIz3ucEb
	JZnfwx5bOnAV/dZEITQx5vIh0f2BtnBmvRWrhORrXoiGSlJQLAKgTEQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4177np9jnr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 25 Aug 2024 15:15:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47PDxHfb024700;
	Sun, 25 Aug 2024 15:14:48 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4185yu16d0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 25 Aug 2024 15:14:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QRFqWfQs3xBbI1bChNyDiJ+Oqn1bv29BTz29uaI5zOrBpQGPWgdDZE3RZwaFXghFg5C01MMHBVReNTA40D5ds4M4tAvpRC7BGL5bwZG6DeCyarMSGKTftiv9iwohjf50eVctn+JrIvPu/qp2UmTp1hef2EPzP5vDQhWF2jf4b+8Tfck7xITGH5zU7ysowVBG+fHPNi3Jt+vAzlFL3sS4WpJVY+Yw99ZDHYx3zkR0vWC1uT/tkR3lbsaA8noEPxywv/NlqUhcsLK/4xOvznmlHSCMW8j2iSj4L1ekBZjkI2mG4TzDcMJzgkh1MxrpjPN3oG8yO/o9GuxuK4hLn//yJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmLbnzS6+Xu1IucNSV+fOVg3t1QmPh0vCrC+A/vBF/8=;
 b=bbfp8MmYLIOKwbiyXx8oPNhXkH7TvBPwJgnymUyLkwAstGFk9I1103HtcxrgN++1t0vjqVKkK8Usoj4ORe6ORH7Nwkr2BNjuOCNVkFaB14VU7A8cfrVhVESNHErHqEEyZqwRhTQRSt3WOWPj5wmX51Kv93uHIHeWJribheZeT6Hten9sAhV8dWrWMWn10J6j3jvyL/OlIsmuULeZC/UPFL1bDC3rqrhHT8BEg1hdqB5ekpsFOtxX0dZci8vTMuHiu4E10y6EnmLohWngKrmEZG//k9ox2BpUwZI8VcAByn1oruuVHL6eCbNWlqldcRP92CKbhRv0UY3CI5Kz90/SQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmLbnzS6+Xu1IucNSV+fOVg3t1QmPh0vCrC+A/vBF/8=;
 b=k1zLiboxcBIAgkv3wgcWrzsDkgOeTKb2cJyZYz2h4I3DUIBwjg8m5lo2eYzy93L+zM8WLCJlwGfg2OnJgXkzAmlEk451yeLprAiEdiauA0q0CXcQL7kKVjRv+v/Q/jNrkTfgQ/e9aC7/U6dBg3YNoTQ0V+hIlIOrLsS7e/0PyIs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5646.namprd10.prod.outlook.com (2603:10b6:a03:3d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14; Sun, 25 Aug
 2024 15:14:46 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.012; Sun, 25 Aug 2024
 15:14:46 +0000
Date: Sun, 25 Aug 2024 11:14:42 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v13 08/19] SUNRPC: replace program list with program array
Message-ID: <ZstKYpuK65llj5pM@tissot.1015granger.net>
References: <20240823181423.20458-1-snitzer@kernel.org>
 <20240823181423.20458-9-snitzer@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823181423.20458-9-snitzer@kernel.org>
X-ClientProxiedBy: CH3P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1e8::32) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB5646:EE_
X-MS-Office365-Filtering-Correlation-Id: 8173ff40-967b-4142-2289-08dcc518a793
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TS2pLAOV++CRVQC+VmkfIHOrGvtuHrznum639JDuOCc5SOdJ4kAhipjlqhCU?=
 =?us-ascii?Q?m7wwsEhE8NHT4QzhKao0GzML/QFhUFozRet0KmGurQ8mZMxpb9EAKjeaLCmr?=
 =?us-ascii?Q?Rar1AdriPt0lsWyb72yfR5OgG7/rdgeMpY4rbSFne1WToHprbt3xTK843E2M?=
 =?us-ascii?Q?FnGdrwl/53MNtQT0nDiYWh3irvdCB3Gqm2tMAmx3Ovous5ct4C2BVuhcWJjC?=
 =?us-ascii?Q?nw3vP6em91WsmIPEYWj4yxqvT2gKfK9mXdU/Qmvx83k2zpD0ubtqeltgEBtL?=
 =?us-ascii?Q?r/XS3EnwH8K4Z2ycaK8O3yfygYy0KGw/ue4ZCtZx+Dk2l5xbGiI7raafgPET?=
 =?us-ascii?Q?TjmJlOUf4VRZ/rWVAEiths7wN69/B4j67YlyyLY/7i3ik/9yN64gc/n1iGWo?=
 =?us-ascii?Q?TVp86g/s9Px647rwKAtKDG3Dqbn/eRBN0MG7agsAg/uTHn14bvDuHmukyn7G?=
 =?us-ascii?Q?VjprYlSzAe8ILT8kYEia2WqNq1/fgu7W5Xf4hV7a1pvH2BQ97IDv0VQF+bSX?=
 =?us-ascii?Q?NzhLVYyIqjuAbpnUuBqmLlelNSYr5+Rhly+sHoVgnj1/ddjAKE6aveSCk0Xq?=
 =?us-ascii?Q?G+lk7TsG8Td5oCeCrFNJKhtoZdSlU9XvTNlSQsaHwb1uFGUDmK9ItHm/kIxf?=
 =?us-ascii?Q?bKWHxEe9PlVDNDyVHQWsQunJkIcsKTmOF1EXPEw06zajW9ygzv7QP8Hw57yY?=
 =?us-ascii?Q?DJR99/KCeNBP+ju+BLinHC2SDGKcH9TuZ/fB5tOI20+JAIFBilxLQsyu6GWv?=
 =?us-ascii?Q?kaURKpi+heWV2kYdt+MgVaZZsnLpDzgNw3DWO1aMzIm/QVf9g4JVwOZWVLYN?=
 =?us-ascii?Q?0HWpZzsr26jscyCQg4mWEGjXxQuJWOFOQRrOAYIpnd1zuoGEMsvxR0CTG3LQ?=
 =?us-ascii?Q?hQ74EmnvU1cC2E4pAoVGx+QlDgaQKWRDO8YEGQwCc64DOmknWE6YZ3u9Fshw?=
 =?us-ascii?Q?WZ4/aKPRpJRt0lXEd9LfFdvyur2BOr6i1/uvgjfrveH1hNbyTB/6ehWhlcNh?=
 =?us-ascii?Q?1gBIewmuSrryxYIV5LEDxKkp1u2kNly3ucXcqqNWyn2y3jh6REOEAM9Nz0V6?=
 =?us-ascii?Q?zDrUiT/jEyY79pry8Tr7UR6ImUuyrw/DUsPVJ65JifBFK/qA5uMOu1+A4Cu1?=
 =?us-ascii?Q?kywETBvUZz5Car2v1ZqEn9uwat8/c3TADc3gr3NgDS7kic3JxJoBkyX2GgwG?=
 =?us-ascii?Q?56Vc/SSZS5ImIscd3awdXnZBIVV2TNshBR0RNHQc0ZT8Ic/jGlLrGVlqUUzl?=
 =?us-ascii?Q?4ONf0Yb9lpfPgH/BZWKmktQ1JduJRpge8sgOg+npNjqKe8XJNDvdxEgUtWNT?=
 =?us-ascii?Q?JLkGFd5paUP4rcVBZSrbhSVP83ZJimBHMiref3BgmO0vMA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V/ZNBtcuTKJr3LwcS+W9p7ChGnjkLbm7GwlykpuGTeYI8b2ka7NnChQTReHu?=
 =?us-ascii?Q?E9TL6hnfbZJQQkVnQjvTDbG3r6NQTwrRIH/i9jufGHcnA7ur/c+svsNDfPue?=
 =?us-ascii?Q?6b1IUm7TAuCWux2OGSPguX08cyXu2xJfgtpUxw+qBfdzeP9lGpFHYcyosBju?=
 =?us-ascii?Q?6ejoBd/ZwBJZdzi+tNy99REVneIOne49gS4cPeLDYGXYM6BFpwP7HEXloMx0?=
 =?us-ascii?Q?QPzUSCBKQt5T7jqXamgi+cQMKa7VZykrlSW0qXuhMjYdfA4lHfBjMaFbT5zu?=
 =?us-ascii?Q?gsqNUhSMeDu5xp5mrZvHQC3gQF6VEDtDkaaeC8Kx5Bg5uROdE/u8I4ociGap?=
 =?us-ascii?Q?a7HmDzRhB/Zg3teI30pI44ItTXHxJmgLAl6ipLX3z0aEP/llDdhpOsCrpqCF?=
 =?us-ascii?Q?453+FqhmBIIdsVwEkhx/AoXQwl2kajaWzeUgLRS5cEAi5qN4BOLrzAEUumya?=
 =?us-ascii?Q?kRpl8t7F9GXW5MrkkVwLFwydrjee6PaBzpWb4O2tby30zZom++P/cZzHgRUE?=
 =?us-ascii?Q?dAIzMBtETTsXsOoFEyIJEhmuHjI9bCvZkGYMYXtg3yHw41U/YbYi+wxjEFe3?=
 =?us-ascii?Q?yfOpajtRf3MCMYwvOVq7GCQ/WR21u/3Oor3isZsGddHMw8p3fyhi8o9W7Gkg?=
 =?us-ascii?Q?q98KLRgZhDe2xZaPtSQ5dc/1wLj9YipBMd7WfKDNC+T6dxvhZuH5YFkW7Ug9?=
 =?us-ascii?Q?V2bGNzzwfX1LQeM2YTfx7Qiy1YtrSS1pe7+HmTzJVDa8PQOYxV6CIHMy7Sy7?=
 =?us-ascii?Q?GW+xyEthTWz7gtEcedEu3FmS295Qak97F969ux37Ky+O0cowkkY5UVtmBySD?=
 =?us-ascii?Q?F8EObnms32vViPJT/AqLo3X+9YMAJiZ4PA7/qFmEvanyRFIQtpfwzkRUupbp?=
 =?us-ascii?Q?1yY1DYi2Dypi9KSja2VT3/7Z0awmHqBVTxO979twCAoW7RtilZxcuI54baOp?=
 =?us-ascii?Q?9ozn0/tgDjG7aRv8cO0XUXJ5sBeJW3dHxekyS0WaZQOsTQStO60kMc4E25c7?=
 =?us-ascii?Q?FWAov4JQ5oOgJuSU8Uc8t0unrjmVxoJUMuU55DJOZPb7LCzAY7eORhg4rGrz?=
 =?us-ascii?Q?HnJM9Xh0jyevAYJcbWiACfKdxpy8xR+4AGBLycAKh0PL0sFdMiq5uYyGX9CD?=
 =?us-ascii?Q?g+F/YGqdt6Q/cEJbf/wn3o23UkUFxhEVb4KhiDdOmBmPbR0NCrgK1HkWLYwV?=
 =?us-ascii?Q?Q/J94ICUKy7ocV/jIKvL39qy8HJuqsLitq1V6Xq/pBJGomGm7m0BY7n6qOHA?=
 =?us-ascii?Q?HL2T6pXBTfM4c/4Fc+RYEV8T3gcHwsixryWdLLBdS3KdFr6q6WyNWLtv/OOD?=
 =?us-ascii?Q?oQoa3xm/XRV1xKAlF+5MQ9jIdLudxvbrrWAsS601SFnBSyblXUdcgbLnesoc?=
 =?us-ascii?Q?tcHEhXxzV0Tm/js2+UUa/ERqjmAdnO/K1i3XN2QOjTCUocXTfIQV3T9nrDpx?=
 =?us-ascii?Q?rnHPo5FK3Axl8nwBKB/mPBEhoGO2G44NB1DwUKz5sKJ7B5NkT85OxZKYO2do?=
 =?us-ascii?Q?BPBZdC+d2uzl3GINFQsY89WtzzAgU89mXPxb1s4c14lb1GuXWqBCR/HO2Cil?=
 =?us-ascii?Q?mLdEehckRuj9ewy7QvzQjLzQAB6xnwub6Ov6gxxB?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qHMCv5S5V3df6zZJ5kB9JO3sDNlwyXAAm2sVyYasIVIn9SYUHlSfsBOe7maVCjUm5Mg6N+qGfEThXiRBF6iIW/cXKBMeC9/Q25m1JmreoZFAkUyCbMJck6a7CpbfkxVjSPyx8q9qApNeLbVUCAUDC7+2Nf4ieP0una84yOguB/2HczK3R/YsUEKoNIckuxUUQz5R5erPMqn/73bfQNuzVdbxgZ3WT8edampMuNOFeiXTv27TbsIKl6vuq34At1SGlJcOyuqQWtjKVMgCdSbFhM1sGVadHo/4iEH37MhmbdZf8Q2mgzaiouiyczs6GPa1KiUskSuX5ZLvIyg8YhaVNXcwPVkUnaeXxZJ0C6j16RayC52EYB2t2HTaKNebqELxmDVxZKorJHX/AzVE00SK7ornePrp+csOs9gTD71YP3l57rpu0ILAKDy9vOvIcmHzvmraOU4UAwPvgLmUOG7y2qiF8gkxVYlAnKbN7QETJEiHv5wNeiBxZvkeE9k6ziZOCL9MjIvS1tpgoshG6cHQh0tacII7ecvyMkEpWPb7AUZpo9xAZj/2a6br81L8TVwm8/5OUZtRKhGRw8wFvnNQg1UAL2CkBMWLyZFzBJ3WPkQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8173ff40-967b-4142-2289-08dcc518a793
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2024 15:14:46.2194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qR0T2ZvjsGvHzP4NEbYmYanhO3wUnkRq6j2az7YieS5kjgRT5nY0OYD3U2zm20XoETzulCaoAfayHmqxzf0y0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5646
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-25_12,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408250121
X-Proofpoint-GUID: Th-JGwMGkRbFDrtMIS8KtNnlDwXBO7_e
X-Proofpoint-ORIG-GUID: Th-JGwMGkRbFDrtMIS8KtNnlDwXBO7_e

On Fri, Aug 23, 2024 at 02:14:06PM -0400, Mike Snitzer wrote:
> From: NeilBrown <neil@brown.name>
> 
> A service created with svc_create_pooled() can be given a linked list of
> programs and all of these will be served.
> 
> Using a linked list makes it cumbersome when there are several programs
> that can be optionally selected with CONFIG settings.
> 
> After this patch is applied, API consumers must use only
> svc_create_pooled() when creating an RPC service that listens for more
> than one RPC program.
> 
> Signed-off-by: NeilBrown <neil@brown.name>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>

There are a number of minor nits that I won't bother with here, but
overall this is wholesome goodness.

Acked-by: Chuck Lever <chuck.lever@oracle.com>


> ---
>  fs/nfsd/nfsctl.c           |  2 +-
>  fs/nfsd/nfsd.h             |  2 +-
>  fs/nfsd/nfssvc.c           | 38 ++++++++++-----------
>  include/linux/sunrpc/svc.h |  7 ++--
>  net/sunrpc/svc.c           | 68 ++++++++++++++++++++++----------------
>  net/sunrpc/svc_xprt.c      |  2 +-
>  net/sunrpc/svcauth_unix.c  |  3 +-
>  7 files changed, 67 insertions(+), 55 deletions(-)
> 
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 1c9e5b4bcb0a..64c1b4d649bc 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -2246,7 +2246,7 @@ static __net_init int nfsd_net_init(struct net *net)
>  	if (retval)
>  		goto out_repcache_error;
>  	memset(&nn->nfsd_svcstats, 0, sizeof(nn->nfsd_svcstats));
> -	nn->nfsd_svcstats.program = &nfsd_program;
> +	nn->nfsd_svcstats.program = &nfsd_programs[0];
>  	for (i = 0; i < sizeof(nn->nfsd_versions); i++)
>  		nn->nfsd_versions[i] = nfsd_support_version(i);
>  	for (i = 0; i < sizeof(nn->nfsd4_minorversions); i++)
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 4ccbf014a2c7..b0d3e82d6dcd 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -85,7 +85,7 @@ struct nfsd_genl_rqstp {
>  	u32			rq_opnum[NFSD_MAX_OPS_PER_COMPOUND];
>  };
>  
> -extern struct svc_program	nfsd_program;
> +extern struct svc_program	nfsd_programs[];
>  extern const struct svc_version	nfsd_version2, nfsd_version3, nfsd_version4;
>  extern struct mutex		nfsd_mutex;
>  extern spinlock_t		nfsd_drc_lock;
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index defc430f912f..b02eaaea7d62 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -35,7 +35,6 @@
>  #define NFSDDBG_FACILITY	NFSDDBG_SVC
>  
>  atomic_t			nfsd_th_cnt = ATOMIC_INIT(0);
> -extern struct svc_program	nfsd_program;
>  static int			nfsd(void *vrqstp);
>  #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
>  static int			nfsd_acl_rpcbind_set(struct net *,
> @@ -90,20 +89,9 @@ static const struct svc_version *nfsd_acl_version[] = {
>  # endif
>  };
>  
> -#define NFSD_ACL_MINVERS            2
> +#define NFSD_ACL_MINVERS	2
>  #define NFSD_ACL_NRVERS		ARRAY_SIZE(nfsd_acl_version)
>  
> -static struct svc_program	nfsd_acl_program = {
> -	.pg_prog		= NFS_ACL_PROGRAM,
> -	.pg_nvers		= NFSD_ACL_NRVERS,
> -	.pg_vers		= nfsd_acl_version,
> -	.pg_name		= "nfsacl",
> -	.pg_class		= "nfsd",
> -	.pg_authenticate	= &svc_set_client,
> -	.pg_init_request	= nfsd_acl_init_request,
> -	.pg_rpcbind_set		= nfsd_acl_rpcbind_set,
> -};
> -
>  #endif /* defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL) */
>  
>  static const struct svc_version *nfsd_version[NFSD_MAXVERS+1] = {
> @@ -116,18 +104,29 @@ static const struct svc_version *nfsd_version[NFSD_MAXVERS+1] = {
>  #endif
>  };
>  
> -struct svc_program		nfsd_program = {
> -#if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
> -	.pg_next		= &nfsd_acl_program,
> -#endif
> +struct svc_program		nfsd_programs[] = {
> +	{
>  	.pg_prog		= NFS_PROGRAM,		/* program number */
>  	.pg_nvers		= NFSD_MAXVERS+1,	/* nr of entries in nfsd_version */
>  	.pg_vers		= nfsd_version,		/* version table */
>  	.pg_name		= "nfsd",		/* program name */
>  	.pg_class		= "nfsd",		/* authentication class */
> -	.pg_authenticate	= &svc_set_client,	/* export authentication */
> +	.pg_authenticate	= svc_set_client,	/* export authentication */
>  	.pg_init_request	= nfsd_init_request,
>  	.pg_rpcbind_set		= nfsd_rpcbind_set,
> +	},
> +#if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
> +	{
> +	.pg_prog		= NFS_ACL_PROGRAM,
> +	.pg_nvers		= NFSD_ACL_NRVERS,
> +	.pg_vers		= nfsd_acl_version,
> +	.pg_name		= "nfsacl",
> +	.pg_class		= "nfsd",
> +	.pg_authenticate	= svc_set_client,
> +	.pg_init_request	= nfsd_acl_init_request,
> +	.pg_rpcbind_set		= nfsd_acl_rpcbind_set,
> +	},
> +#endif /* defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL) */
>  };
>  
>  bool nfsd_support_version(int vers)
> @@ -598,7 +597,8 @@ int nfsd_create_serv(struct net *net)
>  	if (nfsd_max_blksize == 0)
>  		nfsd_max_blksize = nfsd_get_default_max_blksize();
>  	nfsd_reset_versions(nn);
> -	serv = svc_create_pooled(&nfsd_program, &nn->nfsd_svcstats,
> +	serv = svc_create_pooled(nfsd_programs, ARRAY_SIZE(nfsd_programs),
> +				 &nn->nfsd_svcstats,
>  				 nfsd_max_blksize, nfsd);
>  	if (serv == NULL)
>  		return -ENOMEM;
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index 437672bcaa22..c7ad2fb2a155 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -67,9 +67,10 @@ enum {
>   * We currently do not support more than one RPC program per daemon.
>   */
>  struct svc_serv {
> -	struct svc_program *	sv_program;	/* RPC program */
> +	struct svc_program *	sv_programs;	/* RPC programs */
>  	struct svc_stat *	sv_stats;	/* RPC statistics */
>  	spinlock_t		sv_lock;
> +	unsigned int		sv_nprogs;	/* Number of sv_programs */
>  	unsigned int		sv_nrthreads;	/* # of server threads */
>  	unsigned int		sv_maxconn;	/* max connections allowed or
>  						 * '0' causing max to be based
> @@ -357,10 +358,9 @@ struct svc_process_info {
>  };
>  
>  /*
> - * List of RPC programs on the same transport endpoint
> + * RPC program - an array of these can use the same transport endpoint
>   */
>  struct svc_program {
> -	struct svc_program *	pg_next;	/* other programs (same xprt) */
>  	u32			pg_prog;	/* program number */
>  	unsigned int		pg_lovers;	/* lowest version */
>  	unsigned int		pg_hivers;	/* highest version */
> @@ -438,6 +438,7 @@ bool		   svc_rqst_replace_page(struct svc_rqst *rqstp,
>  void		   svc_rqst_release_pages(struct svc_rqst *rqstp);
>  void		   svc_exit_thread(struct svc_rqst *);
>  struct svc_serv *  svc_create_pooled(struct svc_program *prog,
> +				     unsigned int nprog,
>  				     struct svc_stat *stats,
>  				     unsigned int bufsize,
>  				     int (*threadfn)(void *data));
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index ff6f3e35b36d..b33386d249c2 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -440,10 +440,11 @@ EXPORT_SYMBOL_GPL(svc_rpcb_cleanup);
>  
>  static int svc_uses_rpcbind(struct svc_serv *serv)
>  {
> -	struct svc_program	*progp;
> -	unsigned int		i;
> +	unsigned int		p, i;
> +
> +	for (p = 0; p < serv->sv_nprogs; p++) {
> +		struct svc_program *progp = &serv->sv_programs[p];
>  
> -	for (progp = serv->sv_program; progp; progp = progp->pg_next) {
>  		for (i = 0; i < progp->pg_nvers; i++) {
>  			if (progp->pg_vers[i] == NULL)
>  				continue;
> @@ -480,7 +481,7 @@ __svc_init_bc(struct svc_serv *serv)
>   * Create an RPC service
>   */
>  static struct svc_serv *
> -__svc_create(struct svc_program *prog, struct svc_stat *stats,
> +__svc_create(struct svc_program *prog, int nprogs, struct svc_stat *stats,
>  	     unsigned int bufsize, int npools, int (*threadfn)(void *data))
>  {
>  	struct svc_serv	*serv;
> @@ -491,7 +492,8 @@ __svc_create(struct svc_program *prog, struct svc_stat *stats,
>  	if (!(serv = kzalloc(sizeof(*serv), GFP_KERNEL)))
>  		return NULL;
>  	serv->sv_name      = prog->pg_name;
> -	serv->sv_program   = prog;
> +	serv->sv_programs  = prog;
> +	serv->sv_nprogs    = nprogs;
>  	serv->sv_stats     = stats;
>  	if (bufsize > RPCSVC_MAXPAYLOAD)
>  		bufsize = RPCSVC_MAXPAYLOAD;
> @@ -499,17 +501,18 @@ __svc_create(struct svc_program *prog, struct svc_stat *stats,
>  	serv->sv_max_mesg  = roundup(serv->sv_max_payload + PAGE_SIZE, PAGE_SIZE);
>  	serv->sv_threadfn = threadfn;
>  	xdrsize = 0;
> -	while (prog) {
> -		prog->pg_lovers = prog->pg_nvers-1;
> -		for (vers=0; vers<prog->pg_nvers ; vers++)
> -			if (prog->pg_vers[vers]) {
> -				prog->pg_hivers = vers;
> -				if (prog->pg_lovers > vers)
> -					prog->pg_lovers = vers;
> -				if (prog->pg_vers[vers]->vs_xdrsize > xdrsize)
> -					xdrsize = prog->pg_vers[vers]->vs_xdrsize;
> +	for (i = 0; i < nprogs; i++) {
> +		struct svc_program *progp = &prog[i];
> +
> +		progp->pg_lovers = progp->pg_nvers-1;
> +		for (vers = 0; vers < progp->pg_nvers ; vers++)
> +			if (progp->pg_vers[vers]) {
> +				progp->pg_hivers = vers;
> +				if (progp->pg_lovers > vers)
> +					progp->pg_lovers = vers;
> +				if (progp->pg_vers[vers]->vs_xdrsize > xdrsize)
> +					xdrsize = progp->pg_vers[vers]->vs_xdrsize;
>  			}
> -		prog = prog->pg_next;
>  	}
>  	serv->sv_xdrsize   = xdrsize;
>  	INIT_LIST_HEAD(&serv->sv_tempsocks);
> @@ -558,13 +561,14 @@ __svc_create(struct svc_program *prog, struct svc_stat *stats,
>  struct svc_serv *svc_create(struct svc_program *prog, unsigned int bufsize,
>  			    int (*threadfn)(void *data))
>  {
> -	return __svc_create(prog, NULL, bufsize, 1, threadfn);
> +	return __svc_create(prog, 1, NULL, bufsize, 1, threadfn);
>  }
>  EXPORT_SYMBOL_GPL(svc_create);
>  
>  /**
>   * svc_create_pooled - Create an RPC service with pooled threads
> - * @prog: the RPC program the new service will handle
> + * @prog:  Array of RPC programs the new service will handle
> + * @nprogs: Number of programs in the array
>   * @stats: the stats struct if desired
>   * @bufsize: maximum message size for @prog
>   * @threadfn: a function to service RPC requests for @prog
> @@ -572,6 +576,7 @@ EXPORT_SYMBOL_GPL(svc_create);
>   * Returns an instantiated struct svc_serv object or NULL.
>   */
>  struct svc_serv *svc_create_pooled(struct svc_program *prog,
> +				   unsigned int nprogs,
>  				   struct svc_stat *stats,
>  				   unsigned int bufsize,
>  				   int (*threadfn)(void *data))
> @@ -579,7 +584,7 @@ struct svc_serv *svc_create_pooled(struct svc_program *prog,
>  	struct svc_serv *serv;
>  	unsigned int npools = svc_pool_map_get();
>  
> -	serv = __svc_create(prog, stats, bufsize, npools, threadfn);
> +	serv = __svc_create(prog, nprogs, stats, bufsize, npools, threadfn);
>  	if (!serv)
>  		goto out_err;
>  	serv->sv_is_pooled = true;
> @@ -602,16 +607,16 @@ svc_destroy(struct svc_serv **servp)
>  
>  	*servp = NULL;
>  
> -	dprintk("svc: svc_destroy(%s)\n", serv->sv_program->pg_name);
> +	dprintk("svc: svc_destroy(%s)\n", serv->sv_programs->pg_name);
>  	timer_shutdown_sync(&serv->sv_temptimer);
>  
>  	/*
>  	 * Remaining transports at this point are not expected.
>  	 */
>  	WARN_ONCE(!list_empty(&serv->sv_permsocks),
> -		  "SVC: permsocks remain for %s\n", serv->sv_program->pg_name);
> +		  "SVC: permsocks remain for %s\n", serv->sv_programs->pg_name);
>  	WARN_ONCE(!list_empty(&serv->sv_tempsocks),
> -		  "SVC: tempsocks remain for %s\n", serv->sv_program->pg_name);
> +		  "SVC: tempsocks remain for %s\n", serv->sv_programs->pg_name);
>  
>  	cache_clean_deferred(serv);
>  
> @@ -1149,15 +1154,16 @@ int svc_register(const struct svc_serv *serv, struct net *net,
>  		 const int family, const unsigned short proto,
>  		 const unsigned short port)
>  {
> -	struct svc_program	*progp;
> -	unsigned int		i;
> +	unsigned int		p, i;
>  	int			error = 0;
>  
>  	WARN_ON_ONCE(proto == 0 && port == 0);
>  	if (proto == 0 && port == 0)
>  		return -EINVAL;
>  
> -	for (progp = serv->sv_program; progp; progp = progp->pg_next) {
> +	for (p = 0; p < serv->sv_nprogs; p++) {
> +		struct svc_program *progp = &serv->sv_programs[p];
> +
>  		for (i = 0; i < progp->pg_nvers; i++) {
>  
>  			error = progp->pg_rpcbind_set(net, progp, i,
> @@ -1209,13 +1215,14 @@ static void __svc_unregister(struct net *net, const u32 program, const u32 versi
>  static void svc_unregister(const struct svc_serv *serv, struct net *net)
>  {
>  	struct sighand_struct *sighand;
> -	struct svc_program *progp;
>  	unsigned long flags;
> -	unsigned int i;
> +	unsigned int p, i;
>  
>  	clear_thread_flag(TIF_SIGPENDING);
>  
> -	for (progp = serv->sv_program; progp; progp = progp->pg_next) {
> +	for (p = 0; p < serv->sv_nprogs; p++) {
> +		struct svc_program *progp = &serv->sv_programs[p];
> +
>  		for (i = 0; i < progp->pg_nvers; i++) {
>  			if (progp->pg_vers[i] == NULL)
>  				continue;
> @@ -1321,7 +1328,7 @@ svc_process_common(struct svc_rqst *rqstp)
>  	struct svc_process_info process;
>  	enum svc_auth_status	auth_res;
>  	unsigned int		aoffset;
> -	int			rc;
> +	int			pr, rc;
>  	__be32			*p;
>  
>  	/* Will be turned off only when NFSv4 Sessions are used */
> @@ -1345,9 +1352,12 @@ svc_process_common(struct svc_rqst *rqstp)
>  	rqstp->rq_vers = be32_to_cpup(p++);
>  	rqstp->rq_proc = be32_to_cpup(p);
>  
> -	for (progp = serv->sv_program; progp; progp = progp->pg_next)
> +	for (pr = 0; pr < serv->sv_nprogs; pr++) {
> +		progp = &serv->sv_programs[pr];
> +
>  		if (rqstp->rq_prog == progp->pg_prog)
>  			break;
> +	}
>  
>  	/*
>  	 * Decode auth data, and add verifier to reply buffer.
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index 53ebc719ff5a..43c57124de52 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -268,7 +268,7 @@ static int _svc_xprt_create(struct svc_serv *serv, const char *xprt_name,
>  		spin_unlock(&svc_xprt_class_lock);
>  		newxprt = xcl->xcl_ops->xpo_create(serv, net, sap, len, flags);
>  		if (IS_ERR(newxprt)) {
> -			trace_svc_xprt_create_err(serv->sv_program->pg_name,
> +			trace_svc_xprt_create_err(serv->sv_programs->pg_name,
>  						  xcl->xcl_name, sap, len,
>  						  newxprt);
>  			module_put(xcl->xcl_owner);
> diff --git a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
> index 04b45588ae6f..8ca98b146ec8 100644
> --- a/net/sunrpc/svcauth_unix.c
> +++ b/net/sunrpc/svcauth_unix.c
> @@ -697,7 +697,8 @@ svcauth_unix_set_client(struct svc_rqst *rqstp)
>  	rqstp->rq_auth_stat = rpc_autherr_badcred;
>  	ipm = ip_map_cached_get(xprt);
>  	if (ipm == NULL)
> -		ipm = __ip_map_lookup(sn->ip_map_cache, rqstp->rq_server->sv_program->pg_class,
> +		ipm = __ip_map_lookup(sn->ip_map_cache,
> +				      rqstp->rq_server->sv_programs->pg_class,
>  				    &sin6->sin6_addr);
>  
>  	if (ipm == NULL)
> -- 
> 2.44.0
> 

-- 
Chuck Lever

