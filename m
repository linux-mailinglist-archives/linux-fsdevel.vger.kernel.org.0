Return-Path: <linux-fsdevel+bounces-27880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFDE964A89
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 17:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28A7C282359
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 15:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB6D1B3F10;
	Thu, 29 Aug 2024 15:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R3XwEXA3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Z4InhzCK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D1B1AD9FA;
	Thu, 29 Aug 2024 15:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724946580; cv=fail; b=cvqcO/MYnLVPWOvpZSH8yiLPILhko4HHVLBRGkVrh9NNU6fUt4bKvvukJ9f+i2cpOthHk8xxRyQR8uW0fbiiFfGYfF8gP62zDo0Y7xoVVpNcRI0BU/aYbakFL+vrNfwtILiuVxUCP8rKmn5NmTPVdr3mBepFSJWYTzV/h3lIN5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724946580; c=relaxed/simple;
	bh=AI3k/GUC5zT3o2UHppmrPrbLjiaoPTwXExG3jmz09iQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uBLpI9QX7iWlI0vLDcVTzCGTwLJeeFdnxaJuuNgwN7WaDCHSBJOUODANDAHJQ8AHsoI5vOQ2zlKbKI82sVEVuamEXh4gBmDMK41H/xWWvlqhUt8rrbfdaZ/98LqMmI5b9BluVlQH9XmlByj001neUs/L4sTAXn44rOcEiThHhxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=R3XwEXA3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Z4InhzCK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47TEAJZl010915;
	Thu, 29 Aug 2024 15:49:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=gMq7DmsqEKmIqBe
	kDcpzRSJneLwxsZ8CQ5bt0ILVwHk=; b=R3XwEXA3sSlYjaHhUBRtXE3SOmgco94
	4zPyXignDj7s5V5v/Ge3Yr/kBK8P+Sc6VgPMAASt18esWnkPj8N83BjS4OLTP6/U
	Sy+6G5nzFs++Y4q2dBc4TllZ9spKRvVNElkqUjk3q/zqMyMk0rlzcE8Z0EWB/DAv
	Ka6Nj4QSj+LU6vlVfzNF78W51og/cFWoKK8ngoOvj0kOnVzVh5qOXSsz9jyqZJbd
	W4qSVbAWopyhO4Lu4JHfK4YI0+4sFlLrjex5aHzZeToRYcJDgthz9n8hwTk6U+HE
	O0KDuH2JFThuX2tLOrqDUCra8nMGQGAduAmA0m6SY4M2nwfPshWFBTQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41arbt0jgw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 15:49:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47TESx7T016852;
	Thu, 29 Aug 2024 15:49:30 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 418a5vabve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 15:49:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sVlFxMvKqVo3bC5wkthQNRCWU1ejPXeRP0+rmvOJbWvcCcQYFLVWf+uM/RUM5UAE4M/QkE9M7/viPdayvq+ukDv5Bi614NHKbWZdTKl1Qsq0xGg60K+ZEtqv8LkuwjOdEgYkBMK0bsWXQQoFcAktwz932ePRffD+t1W9sOPLnDNiDSmb4sc19oZfRik6C8b+2IWhLhjDaCZQYo8fdtM85J/sqPDR3scSlYz0dN75WjiUVq9UDUkHpebRU4P0GzQOZ8NTsTqndRgLGUgRB2z7WPVZJU3thXZuXLBTfXTBoqNzh/RcPc9jThkfOWVxnJHehxlncGsU/UXw0yNhIQkEyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gMq7DmsqEKmIqBekDcpzRSJneLwxsZ8CQ5bt0ILVwHk=;
 b=e6Y6mOKiJAc1vB3BsUDnjz/57bLAggWn/Uvyl2EbAfVou7HkjfBWmGMVEcxmZYEwosaI5HnR3WLMAkCS0ZMB5K7FcRB2vRVUTsSpnckfa0Npeeqgz9Rkss77wOAR8ziPdlvKLYEHbQKPTZ02emscYTs4P/tymg1sMgeyFA5oSLjTL5/vIrV5O+IwXG7sOcOvQ7LF60OFgNTYap1BjB7HuNE58o0F5BWvuIRyI/yDdUmHXCslpreg+ANMvAuz+toBSnlKbhjhFU2BCLE3/rd9/99a8IVT+UwY55wtI+C4aj+fRyMh9jW1eBreBnwQF0Vm7i+9Mgfcv0i1J52vy8NJEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMq7DmsqEKmIqBekDcpzRSJneLwxsZ8CQ5bt0ILVwHk=;
 b=Z4InhzCK8buN2HrNf73EmG9zSn4H+Yc0cfkzRAZA46ZffduYWE4Hy/0/4M8uds4r1Ob744QNfL5CAG5cEcoiujHsWUSXEVVZIfGFYpPGrVjOqK2gbOaTj4A5eTeSCVZJcc/CJ9GIZyeEvdaqfWN/+PWCHsazEgaE+i9r6PcOa2o=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7341.namprd10.prod.outlook.com (2603:10b6:8:f8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.19; Thu, 29 Aug
 2024 15:49:26 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.017; Thu, 29 Aug 2024
 15:49:26 +0000
Date: Thu, 29 Aug 2024 11:49:23 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 10/25] nfsd: add nfsd_serv_try_get and nfsd_serv_put
Message-ID: <ZtCYg3DWS4xS/X6a@tissot.1015granger.net>
References: <20240829010424.83693-1-snitzer@kernel.org>
 <20240829010424.83693-11-snitzer@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829010424.83693-11-snitzer@kernel.org>
X-ClientProxiedBy: CH0PR03CA0379.namprd03.prod.outlook.com
 (2603:10b6:610:119::6) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB7341:EE_
X-MS-Office365-Filtering-Correlation-Id: dfca012a-09a5-4102-afbd-08dcc84228dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6rIZapaMZc78DPVfOj+FZBZDSozHdkToP0Ui50AE1fhyB91CMs5f+4TCK9YS?=
 =?us-ascii?Q?q6ewEEW7G/GA9WmGtOufC1OT7k8+UEoq6Th81LheFp3xyFBXrhIbwXzOFayG?=
 =?us-ascii?Q?Yta4baah/kco18qujRu4Y/9TOWTJqHwW6ilnixCeqryarJ/m6zp9bZGga9sq?=
 =?us-ascii?Q?Qe1HfAH4IzllUWYAoxIUgS5r8hefZTeFumx8ptxb+9XfMn9iZBMZUgl6J3Mw?=
 =?us-ascii?Q?wU+v0tjxhOtDE0sc7YjhfLyhuF7WgZYFTcutK32QjyQlu33/Fg6QtfPGKHCW?=
 =?us-ascii?Q?h29u/bb/dp1WQpo6b3fnmjGUdhQuekQ5dgJE155nbxb666ImtdRt+k6774WI?=
 =?us-ascii?Q?zpnyPcuja3KK6Jx/ER4uW40R03nH+qpjUeSkik7VMuhNtYLlSDo3sVmcKoPu?=
 =?us-ascii?Q?HXCfLr1zBl7YelpGemYhMpCS6OThMD1dvHcIuTr85mHCNBY7VhR5Yl/SvXrr?=
 =?us-ascii?Q?cGs2oOxILDHGGDA/q6tyaHkxyCkj5yhGKdp79DRB65ayyeVRe5eZm9I3ztt7?=
 =?us-ascii?Q?iHftRh/rtv3tK/R5F4j7A+C31vrPnmwvjMN3jfepmPyZmNnqbBwa6mOFgS2z?=
 =?us-ascii?Q?OD7R3j67E+gw9imkFMVJ4z1VzJe9iE2RsLVCfoyfUm5xpaPUY/+9MCLWEQnh?=
 =?us-ascii?Q?W8nKpTB6ZvOMpGI69JJdoGRw2rDx0VdqV6xBNIxgkd6kSIp86yKuFUTliT6i?=
 =?us-ascii?Q?V0tdgURD4hR9LBvZ7V1CgMZoiYM/wSVe+DinbP+YX8WK68fKgRB2iio7VIhP?=
 =?us-ascii?Q?zko9LN/3zSJ2Zf65dYhNAfwwaHO/d63pPzO+UraUb8Pi5BBDcUNB5f5eJf+X?=
 =?us-ascii?Q?bWjRrHuBdON4RQTDSWVNX1UqIeHLqINLd6hifFlPz4WlH9LY40EU3Un8RZDN?=
 =?us-ascii?Q?6Kf1Q64OuMeilmgX/aBKJ3CEj8flUpOD6n1GbmFaw/COKs5HAnld8SPmn/Un?=
 =?us-ascii?Q?/sEQJu5l6UvrMN/1YSIbc9KIi/Grl7y1ZJDUXUZAo7h5R1tOPXDwbKRA41q+?=
 =?us-ascii?Q?ZwfZ99xvnI3j0TWt8aTt4sRgAc0J/kLxTPRER1o34TshePn3A5usi8toPawx?=
 =?us-ascii?Q?Q+Y7yWiSfS8J1dwWDBdlA529KFfai0YvPHTgQiM0s5UuUAvSq6LBnLbQpQdt?=
 =?us-ascii?Q?kGfQ2LsxPS6DKo/l8/c5JnpgbK1zccg/5nbrqLXALTAcOD1KOql1NZZxqrQH?=
 =?us-ascii?Q?J/8izYH0uym1YznrNVGk9SQxqGCaKm5qjPYLk7uJdbW/9z4EubS+K54hQfik?=
 =?us-ascii?Q?Wo9V7W3MjaskW31P3Sla7JUb9yC6OUtLzI7+Oyc1ZY1SrQT4ZHi2fKGv+GTg?=
 =?us-ascii?Q?Tiu3nbBBX5PW2Xe+LremBxsI14GjYlYH9LFNp1dK26BiJg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1yRvd3XD8GT+/+ufQWquneRgKOrlUmrW2/fgBJB6Cd36QCXjUBN7p09lgHdP?=
 =?us-ascii?Q?Eo5R9P+cpfgsHV7fieWq02UvgmQv10otadKmhZ8uGVtEJiuYtARtgRITa0U/?=
 =?us-ascii?Q?I2GhYmUimZxhzdmoLn3bh9mWsOekwfL9QNcvteodEz4Wp8mjyVDoC9Meokq0?=
 =?us-ascii?Q?0GKlHtBvlnvZBa2mhjaOqS/fyeR58M3iwVie/rMXfpnPHHrZNXH5fH2P/qnv?=
 =?us-ascii?Q?X5hJMFf+hP1p4W8xFSDecRxMt5AQ3ogFhyL2/0gWYmWLAuYwQmjwG05OJE7D?=
 =?us-ascii?Q?39XbsD4+gNRBTKwIT7zL6vfiIY44Ml2tAfAcG8J8r76tfAsxXjlHLE69FpHj?=
 =?us-ascii?Q?Dl1V5mki7d71tiwIHhrTFHaU2TJSGGTVACZaCU5dXtL2jKNjZGnfGr4GOtnQ?=
 =?us-ascii?Q?a9N7PQ610a7urqtAecERO2x+iiqigZOU3IdKrvlgw2Yf351Gdzck8F4CHT7a?=
 =?us-ascii?Q?NDedupNIP7pFLRumT83uyw5emY0MrwCbJz2Hq81RRgF/nhs5Wem0YJ5DByGk?=
 =?us-ascii?Q?0fh7/4dN+2+Z2KCAS9lP65fv+6VwhLrxSRByVn6Bt2vX2AQ79RTVMRRo9Nnx?=
 =?us-ascii?Q?VLgoTc0SlpfhU1sazqCFxUh7ySOy4Krqlm2l9WreTMUB0+jTrnfyC5qoL3ig?=
 =?us-ascii?Q?PF+WMVZjpI5WQfidwHzi+YP6AxDVPnXhWbtjFW+cw/WAsb5+0wCLwIsE0LOh?=
 =?us-ascii?Q?tVVWHZ02neqbvI5ogfaGbJ9vZRrDnvEAHuaE9W1J7vHkIzpiEBuvlPWPk/pI?=
 =?us-ascii?Q?wBYLQCEBqfKxF+Jq1JIMuww2umKo6C5s8Ra183cQk9zsnDmOM2ZIJB64VB7j?=
 =?us-ascii?Q?MLtJokE6LUMKKqfkLaIIqizxauCc8nA5RxZWMEkWm3Wyts/JYW4m1eW+MRH4?=
 =?us-ascii?Q?Cl8Q6gOTv8+INTL6Go9kPhGOcTW+5A+Np+t6Z/HzTsAgXGcrXphsaSTPeyv+?=
 =?us-ascii?Q?zXxzIaNFlIOePp9hMQNr8+n9jfLWc2Uq2ZgfcbueqdIKyBfq+itTBCGVeX6M?=
 =?us-ascii?Q?1MC4HoLGBGCjzATBv9U/ydQC6/D6dj905FA1OG7b9R64NTwgMELxovriIp/l?=
 =?us-ascii?Q?l+7Pxgf4leNxx0XFe01zbuP8ukcAp6eJ53vXST/NfJBd3BnkxyqN0jhPKj4E?=
 =?us-ascii?Q?knCEl5JOkDetj6cfKRAjDf2++R9eyoHnhdQVtGDf2r+VVnn+gmLBfztsniVH?=
 =?us-ascii?Q?KI8wB6W54a6WEjpu792OnJ8hFzwWrL9SDtDDlbJp0vy8wBGjV3R6Ip1Sv96A?=
 =?us-ascii?Q?yZcOo6K/0IpHnJLIRqjy0BUS0HAKnRNZgEBenOwkM4EkecJGaID4doEh9hn2?=
 =?us-ascii?Q?tr/z0VoEsO/PmYlYtcfdHJZLGBjayr9Y2o3B9GmtRqr2Dg6L3Pk3gB3IOeds?=
 =?us-ascii?Q?I2zeJlyHjqyv1melGZ2TvsQYaNEQiFvKdC0wPpSjzfd31wx+O6RWAlv7ffcH?=
 =?us-ascii?Q?+VhwrlNwRoF5+wEPTHWlRTcnJEWw1bRwZ7q8XYBzmohZ+ca1YjVyJ2Xm5iZn?=
 =?us-ascii?Q?+qXFH4AuehO0zAJvx+rey79l1CxjopLGXm1pcKxq0DNVkTT98eaV011vtQJ2?=
 =?us-ascii?Q?2JVBUC44vtiCCf+mvd/73wiw/upalJ14T/rY7RYiSDE2jnzCk5z/fOvAz18b?=
 =?us-ascii?Q?Jw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	suPignxf6iH6vCJrG4DL1uuqeMjGSkklOKhLDSxlJf+gYpLbIA+/zbFlK+4xkhb0bSexpPsdKY8b6vDkZ2Lb5n95uf79ArAhUVq08ucuGEyejamBggyLe+zx05D9M8G5t2lny1gQKYg8uwdtlljrjL9OPLS4q1KY/XRGKPFWLBTIknDUKOYSG1P8qaRnos/80buNgYbELELnE5xqYSMQyNdM78Lmk+cBaZYAHQ5896zU9jJA/brQt/OfnrA0LfU2LbxdUgSvi69EVKdd5oAsKsbvmU7CrJze8XhAoIKZ7hkv4LpIPv+epviPQhAlFYs0rgch1XCizEI4hBnsTJn2MCt933A2/GKUpDLHKHvsKNiSzr6SXu4QEAvwa0ZxAfTjoHJhCA4v0cS3B+eCrPoMyAnkFZ266tuhkT5ReDXNvUqE/uxDxiJsu7qCjGB3Utw2p8yowsYpR7d4hwUDFjo7rpJpKui5U6dnLJqXkVb1lb6y/3Nh8ghhs9AiomvPs4aNkqqMhWnnjP5hjxzuW0wky7UHseR5syFlZaxJ95B5FP5ltj+/vKawZdMSSvx70WZU4cuVU8sXyWCHgXexGAi/62vPWEAFNbiRDL2ksyvQjUQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfca012a-09a5-4102-afbd-08dcc84228dc
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 15:49:26.0209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vinlljskmx5reSGn5LvW8kRvHrIIa7pDHnmnpLNy+3ZRpjwV8nzOe10mOuog9sKRSAo5triWZvZNMHGkvXLp4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7341
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_04,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408290111
X-Proofpoint-ORIG-GUID: eLzO24x_OdpXL4GBRVOrqaJgv06mtVsk
X-Proofpoint-GUID: eLzO24x_OdpXL4GBRVOrqaJgv06mtVsk

On Wed, Aug 28, 2024 at 09:04:05PM -0400, Mike Snitzer wrote:
> Introduce nfsd_serv_try_get and nfsd_serv_put and update the nfsd code
> to prevent nfsd_destroy_serv from destroying nn->nfsd_serv until any
> caller of nfsd_serv_try_get releases their reference using nfsd_serv_put.
> 
> A percpu_ref is used to implement the interlock between
> nfsd_destroy_serv and any caller of nfsd_serv_try_get.
> 
> This interlock is needed to properly wait for the completion of client
> initiated localio calls to nfsd (that are _not_ in the context of nfsd).
> 
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/nfsd/netns.h  |  8 +++++++-
>  fs/nfsd/nfssvc.c | 39 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 46 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index 238fc4e56e53..e2d953f21dde 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -13,6 +13,7 @@
>  #include <linux/filelock.h>
>  #include <linux/nfs4.h>
>  #include <linux/percpu_counter.h>
> +#include <linux/percpu-refcount.h>
>  #include <linux/siphash.h>
>  #include <linux/sunrpc/stats.h>
>  
> @@ -139,7 +140,9 @@ struct nfsd_net {
>  
>  	struct svc_info nfsd_info;
>  #define nfsd_serv nfsd_info.serv
> -
> +	struct percpu_ref nfsd_serv_ref;
> +	struct completion nfsd_serv_confirm_done;
> +	struct completion nfsd_serv_free_done;
>  
>  	/*
>  	 * clientid and stateid data for construction of net unique COPY
> @@ -221,6 +224,9 @@ struct nfsd_net {
>  extern bool nfsd_support_version(int vers);
>  extern unsigned int nfsd_net_id;
>  
> +bool nfsd_serv_try_get(struct nfsd_net *nn);
> +void nfsd_serv_put(struct nfsd_net *nn);
> +
>  void nfsd_copy_write_verifier(__be32 verf[2], struct nfsd_net *nn);
>  void nfsd_reset_write_verifier(struct nfsd_net *nn);
>  #endif /* __NFSD_NETNS_H__ */
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index defc430f912f..e43d440f9f0a 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -193,6 +193,30 @@ int nfsd_minorversion(struct nfsd_net *nn, u32 minorversion, enum vers_op change
>  	return 0;
>  }
>  
> +bool nfsd_serv_try_get(struct nfsd_net *nn)
> +{
> +	return percpu_ref_tryget_live(&nn->nfsd_serv_ref);
> +}
> +
> +void nfsd_serv_put(struct nfsd_net *nn)
> +{
> +	percpu_ref_put(&nn->nfsd_serv_ref);
> +}
> +
> +static void nfsd_serv_done(struct percpu_ref *ref)
> +{
> +	struct nfsd_net *nn = container_of(ref, struct nfsd_net, nfsd_serv_ref);
> +
> +	complete(&nn->nfsd_serv_confirm_done);
> +}
> +
> +static void nfsd_serv_free(struct percpu_ref *ref)
> +{
> +	struct nfsd_net *nn = container_of(ref, struct nfsd_net, nfsd_serv_ref);
> +
> +	complete(&nn->nfsd_serv_free_done);
> +}
> +
>  /*
>   * Maximum number of nfsd processes
>   */
> @@ -392,6 +416,7 @@ static void nfsd_shutdown_net(struct net *net)
>  		lockd_down(net);
>  		nn->lockd_up = false;
>  	}
> +	percpu_ref_exit(&nn->nfsd_serv_ref);
>  	nn->nfsd_net_up = false;
>  	nfsd_shutdown_generic();
>  }
> @@ -471,6 +496,13 @@ void nfsd_destroy_serv(struct net *net)
>  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>  	struct svc_serv *serv = nn->nfsd_serv;
>  
> +	lockdep_assert_held(&nfsd_mutex);
> +
> +	percpu_ref_kill_and_confirm(&nn->nfsd_serv_ref, nfsd_serv_done);
> +	wait_for_completion(&nn->nfsd_serv_confirm_done);
> +	wait_for_completion(&nn->nfsd_serv_free_done);
> +	/* percpu_ref_exit is called in nfsd_shutdown_net */
> +
>  	spin_lock(&nfsd_notifier_lock);
>  	nn->nfsd_serv = NULL;
>  	spin_unlock(&nfsd_notifier_lock);
> @@ -595,6 +627,13 @@ int nfsd_create_serv(struct net *net)
>  	if (nn->nfsd_serv)
>  		return 0;
>  
> +	error = percpu_ref_init(&nn->nfsd_serv_ref, nfsd_serv_free,
> +				0, GFP_KERNEL);
> +	if (error)
> +		return error;
> +	init_completion(&nn->nfsd_serv_free_done);
> +	init_completion(&nn->nfsd_serv_confirm_done);
> +
>  	if (nfsd_max_blksize == 0)
>  		nfsd_max_blksize = nfsd_get_default_max_blksize();
>  	nfsd_reset_versions(nn);
> -- 
> 2.44.0
> 

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>

-- 
Chuck Lever

