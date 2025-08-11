Return-Path: <linux-fsdevel+bounces-57334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D116B20869
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 14:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD8A87A9A56
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 12:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985E72D3752;
	Mon, 11 Aug 2025 12:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lQNXDl/G";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yYLJKNME"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A302BEFE9;
	Mon, 11 Aug 2025 12:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754914161; cv=fail; b=CwuKEjj8ZZwfVQuSKQ44r6nj9lKnOJpCvyRVxLWYuJjHU++Xcj3c+TLvhHowjt4fuHDFKbh0/pVVU+ZeExk+nEBeN345O8EzMTUvJ7eAKNKqMh9hpmhjdHBnLXKADm7oVdf5zUWN45SiwINh6PTVkC7GD0tMPD0Gg06D2/KmT6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754914161; c=relaxed/simple;
	bh=mEGu+8ouoC/nszKMrCGy3DnzTkNGwsLYGI/CAQoH2jg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DPueD2nUi+84XdthMVOrJJtfMo6J3cfrbadbFm28g0wkQR9FbdXzkkR8ZYZ0eWlz3hKOLGRP+pusHi8qhrVavHpKQolE8eLtyNyNkuUdqijo1lA9Qay2dzTJEixLbw/pPpcLhUVKTU6wHcskXm+yrbwQtwjX0BVGQXHMD6+NCDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lQNXDl/G; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yYLJKNME; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B5uFdb005020;
	Mon, 11 Aug 2025 12:09:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Mo+qHe7tkXsyaRNo4fAO4WyuYMd+oAsZQO3iPNooVt8=; b=
	lQNXDl/GACbMAWmhjOMrY1sGwSDIyHTeFxCcd/lATM11zDXbV7LQ6RUx23QIcR04
	hm95QhIH2wjGJty44uRqqQLyk0ujeuom1BTDRGOgAvkW44jYKDvMwVYAbYPrkDYR
	k9RBhSnEzitqXmXoJnoDFRgRorxzAqNvDPEAcetPQFHOR3WRklaQiO/EbDTh70+7
	reDZCAAoKtXxBC/F/QrfRzkMWM/fF5tCfo9VN+NIjSPegYEvaHaZG7Qrb1xRI15Z
	mZ6mszScZvOB18yCQWQ9vE0kO/EGf/QkgUow1RkJbpmDyLQYAXv7l4bjZoB/e1ch
	4QZ1hYJMIFZewzuNLkwWqg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dvx4aber-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 12:09:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57BBA98R030150;
	Mon, 11 Aug 2025 12:09:04 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvs8j520-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 12:09:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HWBHZgT4PKbGroA6mV9TWJ7IGrK5D0nM+kOuhRrC1Rb9yoC5afelHsUb1siudWwIWFlr+LlpQlR9T0XR1HWI+9AL50YmeY4HecxdWcywgrkBFdL0frxrUHge4V720gmksHNzvYC+m4M+e5k3b9SYuVM6Z/kBmXJDX1uecEJHM7JklKRomZjowHq1btAdRwq+1OZ/lpeblAu9fwEXzXc/svg2LFdOEp3RQOMu5NSuh+CjWZ5wuVjkFHlW59DSCA+0xjP2AVTVScnIHYoarmwbAtLW3jJ2S6LHqbZa9ujliZhoEIDe0BGBVk1hYjh05m74ut5iLfD9Td5Izx9zuPtqlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mo+qHe7tkXsyaRNo4fAO4WyuYMd+oAsZQO3iPNooVt8=;
 b=Bq2vZsRO98X4fSsrx9eUa0A30MUwLhVuuyoR0qsOa9NsgxoFMo/iYdq/a05OI2HIR54pH7NrPgPawzLZNk85XByVRrQ3Bwgvi5Rb7N0B4pXDjjkA2SDs2wk9mOsfBrnENdoCTwPwecA3iX4ckmRXT3PF0ieB819LbGup2QH+VddJbTyuOGmIABSugJ1Pd8COl/ERlkSw45jLLVTUrqCNvH6uTwMeTeODk3mLnSw1dLl+fwt6RRJ7axsSI6NwZlnS+xIZss0h56Cgd4kzJPuRAZNfz25sWwAekVjm74BiEZJBEW/SBq/Gyd9mmWyKJBXaHlgYGn3Jx3LPWjm+ngjW0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mo+qHe7tkXsyaRNo4fAO4WyuYMd+oAsZQO3iPNooVt8=;
 b=yYLJKNMEJDTlXzsjWkDCNw//LJ2RduwlCvTJTRX6zS0f/wWjxaHlKOole7swq7kJfDWWkfPJKh7AUkeDuEmtsbfwaR+UKWpzNP+GUvK2KMygxHn7fCTvqovQlQzNS7jOQh8G3djYejRPc1ztRmInLYIwhDMbumqyIZtDgowJ6vE=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by BN0PR10MB4997.namprd10.prod.outlook.com (2603:10b6:408:12b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Mon, 11 Aug
 2025 12:09:02 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9009.013; Mon, 11 Aug 2025
 12:09:02 +0000
Message-ID: <a1b9477e-0783-478d-9c64-8522f8554a35@oracle.com>
Date: Mon, 11 Aug 2025 13:08:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] xfs and DAX atomic writes changes
To: Carlos Maiolino <cem@kernel.org>
Cc: djwong@kernel.org, hch@lst.de, dan.j.williams@intel.com,
        willy@infradead.org, jack@suse.cz, brauner@kernel.org,
        viro@zeniv.linux.org.uk, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20250724081215.3943871-1-john.g.garry@oracle.com>
 <IjNvoQKwdHYKQEFJpk3MZtLta5TfTNXqa5VwODhIR7CCUFwuBNcKIXLDbHTYUlXgFiBE24MFzi8WAeK6AletEA==@protonmail.internalid>
 <32397cf6-6c6a-4091-9100-d7395450ae02@oracle.com>
 <rnils56yqukku5j5t22ac5zru7esi35beo25nhz2ybhxqks5nf@u2xt7j4biinr>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <rnils56yqukku5j5t22ac5zru7esi35beo25nhz2ybhxqks5nf@u2xt7j4biinr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0447.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::27) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|BN0PR10MB4997:EE_
X-MS-Office365-Filtering-Correlation-Id: eee4ee73-efe3-41ff-d60f-08ddd8cfdc2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZzJRS0ZNRTJ1KzlvNU9sdTNDUWVpUE53THlLQlpsMmhoZDFaOC9NMjV3Yk9s?=
 =?utf-8?B?NTVaQ0h2RWRPNVREZ2xjVHlQaHlBUTZrMU1ObEw2a0RhSm5UdFFIbklaSjFn?=
 =?utf-8?B?ZGl2VCtEQ3k3K253eU51alhTQXRRc2xSbHFVSXYxUlRjOGMxRDZLREpUOGpT?=
 =?utf-8?B?blZxdFBOUXg3ampRMUEvZVkrS1QyWWEybnJ3ZU4relZFZDhsK2c4d0x5cDdE?=
 =?utf-8?B?Q2Ywc1hPQWxrMklINTg1bWwvNU5xTjYzckpVUHl2Y1g5Ny9xcEJLbmo4WEsw?=
 =?utf-8?B?aXEwZ2pSMnZOMlgyUDhVQmhmckhZaFVoT1dDSm5ObXlBeWhmZzArV0t3SFhv?=
 =?utf-8?B?eUsyREkwblpqUHluNjR4N3hpalFkRTA3aS84cHpwSGZ3c2lLbGJHQjlra3ow?=
 =?utf-8?B?aUt0cWNyZDFqMU5LU2thTWJiaENPZ2lmaWQ3T3R3TzhuQXNtSTBOaWtyUmgv?=
 =?utf-8?B?VzhpRFdEdzdLNk55Szl0ZnIrNDQ4RFAvZEttSjVyWUFUYWpocUtIelZQK0pn?=
 =?utf-8?B?VS9USUxWMERaWGQwZlBRK1NkUXpib0MzRTJxSUFqUmZ1bnBvQTd2MGpReFht?=
 =?utf-8?B?ejZpN015ZjNyMUt3WmQzOGxDSkF2NmRuKzZJWGwwcFFDZzFueVVMNWJLM1Jq?=
 =?utf-8?B?MEFuNVVnUHN3QnBtajRzSWp3RTdqcGFYREcxV0xSVHhsdG1sUkdhYmpNZHEv?=
 =?utf-8?B?ci9wM2pBbnViRnptM3owMm11RHcrN0k3ejk0V0ZQVHZmL0orLzBjeVZDMEN1?=
 =?utf-8?B?b29YT2Q2UlErSFN1SFR5MUlBNE5TazQrN29JTHpzWXpsa0pzSzBGdHpYRkZN?=
 =?utf-8?B?aUNCdUtVZkFqeXhJYmdleXhwWG9jUUp0NVhtSkFhZHAvMEN4WnREaEh6Ni9Y?=
 =?utf-8?B?VHhUeGU0N2N0akQ4OTVRRjB4dkxveUhJb0ZvaTNWMy82Mk11UUNqRUl5Nytk?=
 =?utf-8?B?NEo4UEk3dEMxRDAzQUptUnUwWlBUWmVJNlRsTnpkbTdYcHZ5ZnFtWlRkWits?=
 =?utf-8?B?T1dtbDhTYlZoeEZZSEVKWm1uYVUreGxaaGJ6WmgzVWc2am9Za0RDY0tLdkhP?=
 =?utf-8?B?QWcwaEhNam1YMGZjaFBQY1lZOExRY2ZaOHJPN2wzS2xzL3NhcGdoZ3VySEhp?=
 =?utf-8?B?cTZYYUVReWw0dythWTZZaHZFcXArc2FnVkdpZEdETjhEOWlEY3hIQTdjcWtP?=
 =?utf-8?B?QTc2NytDdmRlUVVyZ2JjKzZvZ0ZmYWZ3ek9UKysyV2RDdnAzMk9CdDRKNnVB?=
 =?utf-8?B?M2NZeGRocjB6b2NDZEJodDRGL01wUEdFSDBWK1VvUzkvV1RsNXRXdDhqWUJF?=
 =?utf-8?B?VGc2NjFMclVha25rdGg4dFRVR1RqY2E5d2tDZWJmQ1c1KytCdW5JRmN3Z1JT?=
 =?utf-8?B?Snc5Ukl0YU81TmdWdllady9JTjNiQVcrZEF2ZzJNQUJFSHdNWHRua2VuM2pX?=
 =?utf-8?B?bFBZY3JoVTlQNlZBMVJtenExNUZORk14TzEzR1Z0aURwcUJTd2hkY09pWnMr?=
 =?utf-8?B?aVRqMktOOUR1VzYxc2NUdjJkVWxiTkRrTEVYVzZoNE1qd3FCT0pQcU4xM2kr?=
 =?utf-8?B?WUVGLzVPWWJKMCtObGJVQ2FBNUovNTE0bjNMOUhDTnhEQlRhVDB6QXVob0tL?=
 =?utf-8?B?YXVUa1Q0cWhWMFg4Y2VNcnlvVkM1YnpXRkJwa2Izdm5xMnd1NjU1b0FHcUd2?=
 =?utf-8?B?UkxsSDJoUjc4cGRXL3hIbXdHcElZMmJvbmJFTk5ueUhTNHowZXhwaDJZa2Zr?=
 =?utf-8?B?NjQ3TFZJTERtL2VabFFYdXhtYWg2NmN6NkVYWlJXL2p2cWtQRW1zRjNSQTNs?=
 =?utf-8?B?RFE2ZkRQY0cxUXM3MUJ3ZjJLSmJFWjRVdWFRNmNqaXZlaEc4L0dHMmNFY0t1?=
 =?utf-8?B?RVo4aUhpNWpRWitMQU1zVEVHNlVLanJicmJFLzJRdXFXL3JyeTR1RUU1cmQ5?=
 =?utf-8?Q?CnBEPHrsp2k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWtuaWlnMW53ZC9tREpjeDlHa0xjWjBlek1QVXAxR3F0ejBWVUFLb25POGNJ?=
 =?utf-8?B?dk9sNUx2Z3RkQ2ZlTDZpdnN4NERnSXZhMzhnYndhYzVPMTlCcklqUWwvNDZz?=
 =?utf-8?B?VmE2ZWxqajhLS1lRU0ZYdU0vVk1ZdVM0LzBrdUgzTUtmdVZHMEttdFMxbGov?=
 =?utf-8?B?UkJ4UTdpZXdjVnB1UFd0ZGxkdXRaS0xpbXRINDBwalJwcHE3UTI2ekgvZTJN?=
 =?utf-8?B?TkU4R0JucDdseFA1eG9UNEYrOW1Jd24rdnUrS1VxWnpXRFJ3Ly8vWFd3WGtC?=
 =?utf-8?B?enpMS2UwVG5QYTgwcTRFY3lrbzE4QjdRdlI5bVlmcEZTdnhtWVF0aEh0RnB0?=
 =?utf-8?B?cy9SYmNLQ0Q5c3REcjZGaDBRWjFNbTI4eGR3OFJxMXVLdGY0M3VhaXFXWDdo?=
 =?utf-8?B?WE1yVm9EYVJqQnNMVG1KQkYvNkI5RzJUYXpQNmRnOGhoUFF2MUo1ZGJEQWtZ?=
 =?utf-8?B?MXpjSVZETUx2VDN4MlhMeDBKazQrVVU0UmRSd242dU1pdmVxZGJSdGtNN21m?=
 =?utf-8?B?OGZZaktJT1VQazBmblJUNWtNNlh2bitaV1hRaEY2NzJ6MUxXKy9KYXJMWVNp?=
 =?utf-8?B?RGIyeTFHeVBhNWlQVGF6eFRHUWNKdDNvaTN0WTRQM2pDV01uUVFLQm9IdHlI?=
 =?utf-8?B?a1BuNzFRV2NnRFJQdkp5L1BoWlFwN0diWG12WTZtWjVPVjhCZm1JRzdEZlZq?=
 =?utf-8?B?VG5tNGpxU0V0ZmVYNTRIOCtodFhOR0g1Z0VGT1RzM1FCdDZrbVNwTUhNOXM4?=
 =?utf-8?B?MlBNZGNramhKc0Q3NjZ0MUp5RHdpZmgwYUcwN05RVWdLaTljRkVGSWRjbHdD?=
 =?utf-8?B?WnRwTDZ4QkhFazBvcm9WVXFjdUFLT0wrMFpDUzFZTkhiZGNWNWtUMnNyd24x?=
 =?utf-8?B?K2J6R0J2Q1psSTRHWWpYRzVLb0w2YzRUYTdmbExCTk1qeXpiTmNqb015OHcw?=
 =?utf-8?B?b29XN2p5dVJqL01DNUdQUEtLQ2h3S0xKeWh0b003QUUvaVV3c1VXMzRsM1R6?=
 =?utf-8?B?UWJFbDRMTHJIWi9QbmRTcjdHZVRtNnpCOHIxYUswdVVpeDNOL1RVM3l4dnRk?=
 =?utf-8?B?Yk1CcGpVRDVGT2dYQ0pCZk91Q2haSVZnY09yNkYzTHZrS2oyZjBCVVBuL0RG?=
 =?utf-8?B?dGxKU0hCUEl2VXBBR3RLemt1TndOTnc2Y1JaRDJUd1R3bzB3VmZuR3FidktD?=
 =?utf-8?B?UXRaUHBOL1hqclhIQ0p2aVFIalhwb3ZQZUd5UElNcTZSSWdRU3BvcFlJOTRC?=
 =?utf-8?B?bi9BdVF0VmRuV09yYWRuRkQ4NmpueWZLM0toOGRqcTAzcURaMldob2ZRSnky?=
 =?utf-8?B?R25BWitFUHFXdnltMHNQNWxwU0haa21yS0hZNHg2WG8zYVpBMXdLYVpVWHg1?=
 =?utf-8?B?Q0lNbmhBb2NnYURXV1ZBQ3pzUmdWYXdCeEpNYmp3VURHN0R1cFN6U2xsdFE3?=
 =?utf-8?B?S0JPd3B3TjRaVzhRY2gyT0FwQTdWWEV4YWFDV1BSL3E3a3pCSHYwaXlWVk80?=
 =?utf-8?B?dmxRM2RKSHR1MnlBK1BPOS82VDduSUJjaWRDQ1EyNS85T2JHSzA3VTVuTnFa?=
 =?utf-8?B?dEEyeG1IQWdrWjU0ZW1qeVZ4WGRRWU5wSVVnTGdpM1dwK1FPYjJpbG9abUlK?=
 =?utf-8?B?S0pmQ1ZhVS80Y29MWnZlYWVOVnJqUGtUa2lJcTZxU2FBOW5QRzJZUEh4VkdO?=
 =?utf-8?B?ditwNmtRU2QwSEdIcmprYnArM04rK2pkK1JRcmlYYno5VklGZUpVbnNpdmRI?=
 =?utf-8?B?aVhUOThRMTFISGhvRjJEUHI2WXgzekZId0JzelhZSkxYSTRNTXhDMGl5NTJN?=
 =?utf-8?B?bEVmazdmVGd2TnU2TE9kZFFKRm05TkpFaUEvdjIzSVI0aGdnc0RSMzhiVVhr?=
 =?utf-8?B?cFpoOHpHY3d0ejVZcjJldUM5VjZxN3kvQmlQSDl3R3Jkaml5S3VsTkNXUSs4?=
 =?utf-8?B?OUFGWW9EQUxIUmoyeWtvOFJMbDM2Nzg0VzVtZ0g0K21NOEpLR2lIcC9iVENW?=
 =?utf-8?B?UWtDVTRPZkhZYW96aEpjM3BZeE1BSmc2M1E1ZkNWTXJsempUVzJKQ1dpM3lV?=
 =?utf-8?B?SWJpbzhKcDNmOUExOXdNcFppS1FKbGJwUUtyMHdIVWlhbkNqSlZnYWtmdWhN?=
 =?utf-8?B?dkU4Q0pTYVR6NVJqRWVuU2Z3Zmc0a1A2OFNyaWtHbFNuQm83bGF3T2plS2tl?=
 =?utf-8?B?ZHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OLlRh5NzC2yqF5HAg8v4mbwwH7g72qZAwNTfDoRuwcX16gv+c78n2Nwh0jOepZYwTt5acwlyf0bThX3/VHZUomO2WHeTzNFq5dqWle5Qzv76ylOYV+3Zxmh1LO9HV9xxqbKPGm028aPnT3ksBtm3QpJWON8EiY82WG+eeXOIYpXAeapkqow1uPq/y6FVwDwOrIlekVKoaUh97/AIxpE1Hqf/VxpBpnPgg2toGwUfWwfGrSB0XGA1E+Str9PPd6BCL1wQHzr0PfbKveMRufB/+2RqKDFK5LUqsyVDxHGU8j5tRklPRHWFNwrWnzblZL4K/9KSPFrmjw6rNFAA/V80+eInsDBEumWDQF3JQGmXiYC/H3EO6RbWRAzd9IaHUEEDJvtmrEmlbLDIyDs0t9oR9ld1puXEi0Xl57hvnW7Kirwx5CPwsx7NA3xapFtdWCqtX0oPHJsYG5btC5Qx7Pb+OTg8e4LYtlyzxS2bfXJCN0qtvwwy9mTI2rEN1d3XsASQTRL+GoXDPZVcZFAkf74AoDPeX1u2VCnvvB7ALBLeLTpIa3V+OoBGj2/9H5DYGKqf7ZK8r0yfbXyXHzvF9bJ/YIkKkLQ4PJMJrdZtY5OHvqY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eee4ee73-efe3-41ff-d60f-08ddd8cfdc2c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 12:09:02.3630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I/3f0WVwhgZtERzKZGDr+PTOSo0M/adsdEjT2NxvW5qq8WnBS7A1fEDU+OQEkEmJLkhJLRE1ru8jBpAem6ORcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4997
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508110080
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA4MCBTYWx0ZWRfX1Y/OH19mXAMh
 ESLwNPjys4rlluyyxx3as2klGg+99jq6Os0US0jtt85cOjPOttZM0vFfdzCejLt0PamSbUhORA9
 hfz0SXcViiFQ2R1ieSBHuJvVo0fGXlQWMkLxn3GhIIWWRJfoK1jpvSDJwsOVlYvk443s0kx/147
 wB3dWXJJJHTTlBN75RIlpqCZuT0YsM4GI1brCX8sshgzb71wGpLvFEnHJBYajtsV69dFT2/p8Et
 e5ew0gEDaeZzCnUNUL9QgDmYrD1vjelOYBsn7yh7hUtBlNo6Epl/PD8ynMowk02yynUMJn6oGyH
 vMuQnqVaihSneQxFwoYbEABbd+Np3CcOwiXks43/HfWpQC3KVZTOyNcHcmkiaXd0TtpGtdcu2sY
 7/CcW29krnsJBStHaA+czxjbpnk4xV2jndSF05YSh/2AN+A76v+KEsI14I4ogmjFhzFQKxRG
X-Authority-Analysis: v=2.4 cv=eIsTjGp1 c=1 sm=1 tr=0 ts=6899dd61 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=bK7RU1x5TXp8LZafwXEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: td_VuiiUkfSbjNbt_JMftHNs-BnB-e3Y
X-Proofpoint-ORIG-GUID: td_VuiiUkfSbjNbt_JMftHNs-BnB-e3Y

On 11/08/2025 13:06, Carlos Maiolino wrote:
>> I was expecting you to pick these up.
> I did, for -rc1.
> 
>> Shall I resend next week after v6.17-rc1 is released?
> No, I already have them queued up for -rc1, no need to send them again

Great, thanks. I was just prepping to send again :)

