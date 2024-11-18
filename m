Return-Path: <linux-fsdevel+bounces-35080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 129E29D0FBE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 12:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0BB5B26715
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 11:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D429A198E86;
	Mon, 18 Nov 2024 11:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N86G0kaw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FRJCbpwx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50117195FD1;
	Mon, 18 Nov 2024 11:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731928686; cv=fail; b=cRXcai1j04ju8KsxyeFWZT6qcdNboCV7LxdAqgdcAZGEwHYhkQ3BK8UkMsnSgIdl2MIdkUnMCK/ZCVK7Q1YHn0jcCHUt7Qff7Ip/fv0Y15oKVnEzT3+5/cHxynJe+6B8+0ON3ivK/PqvlUO6fKGWG37Ek8hjhwMy8toVGciLidY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731928686; c=relaxed/simple;
	bh=jxNB0haTnK0RRkVhv1fUoClJg/7Ws25gP3zRHjI2FZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bMrcCiWKXIFHV0tsDRFiRPo6pGkffGezS3KPWRgnjLX3LVNYrp3WZj0ZNMwRZt7+u1WcdmlwiNave49FhMzwPVwu6jnYQnR4jPeFf3ZH0MbtvoNZC06cCgs7u87g4t5CRdVz4ZesREMxodFa0soKvBwiw92iKqUwZikd7goN9vM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=N86G0kaw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FRJCbpwx; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI8QdY3012283;
	Mon, 18 Nov 2024 11:17:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=WlFXTYRR9oJ9f9SQnm
	thTXtRRGyxMeypvm3ERN9u5Aw=; b=N86G0kawRo10EFKs+BJvumOcv+zIuiqSsE
	3A1mHHtofloxyZpnpiUDMbJxwWzeQQJvYfru737BvaC0y2P1qmywk7DnVrZKIldS
	bE7pe/qn0/NaDzhd5Bw19zCb1OguOC/AToggDFnzGcQurJ3lLxS38TkpxRI46BjT
	Zjb1hHVVlZ4iEwgag34cD9B26zgF9w8fHJen5Kj3swYzCI/XxWFhbA1wpuQj16Ds
	8I4WXh2gqQIzEvjEMmyHZWU9w6OXr+OAmwe4/2etjzfY6h68WsQ1pW1bsKFxjDVh
	1mmoCDVSF+5auMZ8D775K/KOaJ3vguZgVz+nRilZ6hrCxifoj5nA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xk98jcq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 11:17:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI9C2sh037319;
	Mon, 18 Nov 2024 11:17:25 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu6yqk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 11:17:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tdgdxtv+cNA+ltqgfEasAqSGQeBetWhS6XE2ON2utCt/VXCNytXErcbS5zlXCD7MIStYC7sVLZXw09/l6Er4URE0pNsVXSVGldPONoWZrbxKbGYP7vafGvxKSY9H8GjbiLtUyempioeVh29DN76mA50WcmloNkGKSsa5UZdgnvmDrFjZBVXGx64fq6Q0BublQ6vw28mwl/0k/L/M3ecUMLWaTMoGvxqF3dTLlHgvZTqPbzIEIxPvq/RaL05B22YwN/n0jD6kc4vR1IoQj7fVCrLs6nW4SPXM7QSY/lKu5ZOLLBA61rVNkk+ppS54yCRgHWs2on5at8gVvRqOjy2VXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WlFXTYRR9oJ9f9SQnmthTXtRRGyxMeypvm3ERN9u5Aw=;
 b=wES3AgRpCD28W1sT7O31kf2x58dT1x9/YEjAfgoWGuIRG9QY/gwIvNoPWu1BKIM/WCim6ClLeIo7FsE+XRxs0nFlY1Ji14B5zCp+zQJ6Ea0zMsTgl6exlyzFTkPk7aPF0pGRSKxUttUagM95FmuFI0slg9B4njFEAWaelfCPtZn8VXiV0E63dnsVZexh5jOFHxsSKBfKw99fgWsjLRAbG6mKTypVbO3XKg772PLqTuD05bsK9lcJh+hLPxik2yoS1xa/JitGDJnSGeiVl6VUF3RzNRfU+mlnZ3v0aYIz442OI+ZR5rVyd8ugoKA/A7ZvOiGvd2acdUQRwp2bgp2UZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlFXTYRR9oJ9f9SQnmthTXtRRGyxMeypvm3ERN9u5Aw=;
 b=FRJCbpwxI4BL5+yrUW7Ha5f1qIxwgWB+Wpw9Ud00nsq+XHjyZ+oSRoCSkLv8ra7WHFr4ydD4yW7KBbb+9g0xq9LZVpOIAFbzVSJjTEvUjc8dk1vGmjIUe3ZtXGa+1G6ip1FbUdZakOk04kiUFiIxIrbwvbSHTROgiVeH8dZUwqU=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by BN0PR10MB4981.namprd10.prod.outlook.com (2603:10b6:408:12d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 11:17:21 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8158.021; Mon, 18 Nov 2024
 11:17:21 +0000
Date: Mon, 18 Nov 2024 11:17:18 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org,
        akpm@linux-foundation.org, corbet@lwn.net, derek.kiernan@amd.com,
        dragan.cvetic@amd.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        tj@kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeel.butt@linux.dev,
        muchun.song@linux.dev, Liam.Howlett@oracle.com, vbabka@suse.cz,
        jannh@google.com, shuah@kernel.org, vegard.nossum@oracle.com,
        vattunuru@marvell.com, schalla@marvell.com, david@redhat.com,
        willy@infradead.org, osalvador@suse.de, usama.anjum@collabora.com,
        andrii@kernel.org, ryan.roberts@arm.com, peterx@redhat.com,
        oleg@redhat.com, tandersen@netflix.com, rientjes@google.com,
        gthelen@google.com
Subject: Re: [RFCv1 0/6] Page Detective
Message-ID: <a0372f7f-9a85-4d3e-ba20-b5911a8189e3@lucifer.local>
References: <20241116175922.3265872-1-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241116175922.3265872-1-pasha.tatashin@soleen.com>
X-ClientProxiedBy: LO2P265CA0501.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::8) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|BN0PR10MB4981:EE_
X-MS-Office365-Filtering-Correlation-Id: 22e32415-99c8-4a0d-6a52-08dd07c2922d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+I8Pvet9DP0MGca1TZYW1Eng8M3vu3wIFvMD4+7YdCIIMTVh3rlIp/k8pRbY?=
 =?us-ascii?Q?aDt1aWURyCmVTMZ6cWQLuJAdeyLf5Bb0wV6SYVCEYdvnUx0So2zKvCs+SUFp?=
 =?us-ascii?Q?JeOqjIUoccDZXSwETpSqpnz6FXqh4LGiBm8AeM3DatQaeBGx3+75+aci2MGW?=
 =?us-ascii?Q?koq4NfjsLRYepbdiF+jlwu7WC9yqUu7j9KkAb9Jg2SqVXeixgldnndSqVX1U?=
 =?us-ascii?Q?Vdo6Jnaa8J0YvhRRtSWHrjr2iH8ssnxpxgVy+W7ksc10ZwLPpHcFICs10aNW?=
 =?us-ascii?Q?qzr7bvTk/8m9vhmswlfBaswATtQYyaa708xKsnMsURfQ1gjtTDJdvhu0fLNb?=
 =?us-ascii?Q?BIutoR1DwuTW3zoQUgS3iqFZF41cuqOhQtolVGB+E52dPGShWhe/uBqpeBjh?=
 =?us-ascii?Q?pmwmVolkD+eysWpZdJO0qZWbBXVghtsdgBD8lJCZEL872G0RYW+G1nDXU3Yt?=
 =?us-ascii?Q?giSQoQNdsM/roVqmgNrNDV5byPxa8DAIubSTJHPnTOOqBxvdyyGHI+AYoMHb?=
 =?us-ascii?Q?wkDWXjaXGtnRFeVi0iMtAzuPQBfeKRtLUTNlmOX2BC9PmcISjLSaOTo3FyMJ?=
 =?us-ascii?Q?EcOinSaFv+LyPIv9PFEch3Jw0phAu6GIcPMoR8SP+6XINfigCZJBCgZQnEBx?=
 =?us-ascii?Q?aJyXdt+i6MJSD/sq1yRFzhWpE1hXoIfWMSeqBVYHa2c79du8ZroWgtdm1Bou?=
 =?us-ascii?Q?mqFnRxjXlY7XWR3h73TFxIDv7bnFFlRFwFBXHFqOoG1JnUQUQHwUbp/F3IlN?=
 =?us-ascii?Q?UpPZizmwScNm4I4rDzUjHvEem+By7IkvsTnTfoWQs1Z7Jx+WBYiAYmDuil++?=
 =?us-ascii?Q?mz9HUgj9+XQUkcmpcJ4pzhk2UQiQ4IMZzF7l9zwP9bnEBGs7RzGScFTRm9tg?=
 =?us-ascii?Q?EVUnF7iMgdzZX4oTmHdxX2jOycvgVgpjPmGFOWAuKjAjGHVIOqBXfWunVUxD?=
 =?us-ascii?Q?vR+xOAqruAvPy4DEdWAXYxJdpGiMOFkhUcix3qRYyt57TODQSp1p2gkeALBU?=
 =?us-ascii?Q?CULFDRUilwx0JJexaBIFcJd8+02CnW6nupXTfF5o4ycQRVt/l7LQWiSYIrs7?=
 =?us-ascii?Q?9yyvTveZosj7pXkgSfjSjqey+1iXPpYriE81pOAmQMac3qnGtWhVcrnOP9Ze?=
 =?us-ascii?Q?e56wcSfV5+6ukfCITVYIHCJa4D5J9Y3EgCaqgdpkAlfHNx5E2YJrs2YNBYjj?=
 =?us-ascii?Q?Z6LVpCqDlzeuTD+GxgjJDDIQoW3tUZOlmnXh9cGdyOrqF5CTYURORG1BUEGk?=
 =?us-ascii?Q?mZphGWoZIgtzv9QlAnjEuXpJTj1j/aeIi0swZbwjLkRylQ2so4f+tljHn/GJ?=
 =?us-ascii?Q?gt7Kcz88TuuUu6TQa4yLdNkn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wfRtSK2w7Mr7eY0Q2kySBTru3qmCf6fVbz13qqAXTVm1O/UT4P8eLmg2mUIP?=
 =?us-ascii?Q?/pKaM9cNUrXmZepsuGOr/9LyeO9fGJ6gGcPGdQ2SmyeiQf/pUw7J+23nZb5y?=
 =?us-ascii?Q?j6DLCE1K1KHqIMNjnyWQnmkfWE5zI32tqnQWvcNdDGKdbjNF9SZ+guP9WhP0?=
 =?us-ascii?Q?8zPxMvoAmEQtGj3FbfMaKdO39FPVtbdEflBjT90j10GotK8JRDceLUPsLKO0?=
 =?us-ascii?Q?yoSFslT618tYSBcqfXsnLBGJQthxU1EEwBNogEhmCBXb5MVgzdn2c2qstFiW?=
 =?us-ascii?Q?wL0Fw5YP6rSczz3kTv5nkOaQ45/6/bnE7y3qvhfxP2K3+eDvEAr8oexkXKgl?=
 =?us-ascii?Q?I3ixsh9CY4mCGkqrR+kdVQu81mW3Aa1LWN9NJxYT6qOPV2OTTusebcYkm7qz?=
 =?us-ascii?Q?P6axNTbNnnO2shCSvb4SG1+/MKxH0fYW9r+d4i92KUcb2N965DcAixw78CcN?=
 =?us-ascii?Q?9FgB/qvHIcfiY0OqJtDqo5t+xSnNLzWaZQbeUkcBz4PQsCY6gi11nkwb2f7d?=
 =?us-ascii?Q?GoKmldJCyv4/XnsVeS06hoNl7hzFULJNsJqdjGCrf8GHMqh2kOVVnwmFR7jk?=
 =?us-ascii?Q?IZZXPGQYBz1fbseV/b0nhwbqH5J5aizZnM6q+aWgFgmPMCyQV/LZYcRlDBYp?=
 =?us-ascii?Q?79KGb58AbtErdBdKGjJLX6+ZX00fHl8IqrXuzxv11R4W0YGhhdabLLwyrLcx?=
 =?us-ascii?Q?LrwkNjPyC6fANryCw/4CVMGC/6Ehsa2Q4E9gKekTxV9ou6p3LIhoUOSdBh1D?=
 =?us-ascii?Q?+PABXjlaUJbowxFQbjPx2dlClQuyTIBJwNoHDqbOZGKnSbEIARS1/Xtb8HP0?=
 =?us-ascii?Q?ZnDlEe1udh7cD+F89ztc5btHhNtP+5my2MmTUyEBD8gz45SONEfi9H9w3M6n?=
 =?us-ascii?Q?MlpXfVX4sWHodq4b5p+eVcXmCmnyd7VP35MH6SkFoAP+jTRA3Iqprr1/fzlh?=
 =?us-ascii?Q?Erv7pHTs69eAfGdZmUzUw71Vr5FMDiu18eqOePTrozenWZhGGNHKmFzxfUNg?=
 =?us-ascii?Q?ooa99wdtNl1alZrvwLhcY4a1ILya0uGgxgEgx1vOBPUJe8fPL0kVdyCJhFVr?=
 =?us-ascii?Q?NagOPwt9IUq9trhvD4OPTsmAZhb7ClObzHmEEd5AmLKmI9Pmgjn7JniqPLOl?=
 =?us-ascii?Q?SzpTev0wqIPLZ1dh0T/MlwxBpWgSyzI80j+nl5O7+B5t+kO8rfx0RoBqeRZa?=
 =?us-ascii?Q?hnTWdzVQEGL5xorX/3nvg1fU7TZY8PYJT8wx/uMRP/z/0eh7DFF5F2HoAUud?=
 =?us-ascii?Q?ZJjjtNc0gu+cvtH0af3CYOo52n3PsgpuxjpEPRYmM/R714JLt6MbD50aV+95?=
 =?us-ascii?Q?ORv8QQJ/IRb3oBgZPr2I3QQhwn/88XOCMNTY38YT3O5HoooEw142RqN9N+TG?=
 =?us-ascii?Q?iEqzemT6HqRM9ktYySJ7yKFRiVR/YsjuC5AYlSu0L6Xs3Pq5O/5ybmYbYmn7?=
 =?us-ascii?Q?h7NkJJ6wJPHTKJQ/SLBb7nwLJeFn8PZN0PNy46eESijNujvz7QPB7A1+FhAk?=
 =?us-ascii?Q?OPU/B3JlYE7h4Vcrp9f9tdRvWMNj+T1JYZ2zB64QkJMOtm+s0lQXQfqLwzMW?=
 =?us-ascii?Q?Ue3+qAi3VOaWifZjEt6pZRyYX9Id/jTfx67tlj36Qizga/Cd1yNSt/P3FG73?=
 =?us-ascii?Q?jA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PekywnKr98E8cp/iQPrfun862R/A0TbZruZci/ncR9+tyWhEwEe6e2fkBm8wu2KaxSGhbV2rEz/R3/WoxG4Ep/Eshdh4CVvxas9bEc2QFOmPfXuCims/QJ0V7gxGyIfg/yNmvtk96x1I6WWQpilPhnJZAMZs6UlqjqpLg1HyJABNJJhrfHf3bhqXsV+jUey0CW9V2swtHtfFDs8aCVDKhQIGdAC5fIkzBoZbHwfKGHaCsnTtiCWJ6CpNcMUES5pApXVaNFQ6bmr2gD+Jwk3XpUCSBiMj6eodR8aYuO5hlFMFbMVWksbOYtk2/uk07lfo1Zmf+lDCqnTpT+1NrbgpGWcResUF47rBsV4SI6mSWKVgzl6gudJuHcOveT58U0c2ClIFZNE/Zn0Ds2xIc+Dq1S7qB7FQ4oZCRiA2YQm8q+ZY1mLdf7oGFkbyYl3u2wI3oksmbvtR4SlU7K+lAQT7ouzpy29QF9DdKn9DAc7N3Dt55epT61PDZDesdseGo/tDB4d1oapgrVAzDdwZrFtvf4FgTe7iHDk/uHzvlyObp9O0BfeZlDK9V0bRm8p74BecgGr5d0YUWxOCuga9Leg83Svod9Ua4ZgP6+igeE51Fx4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e32415-99c8-4a0d-6a52-08dd07c2922d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 11:17:21.5495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PEmChPdP7r02/upVnqUH8lLj8yZQVtjFvNKrlm1OjO0+f3tIsDoIxg6/gyJ+YaxeoC6xNNqz8AhmK7De4X9cSm4a06Bu0nnX9OWpM96UPGQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4981
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-18_07,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411180093
X-Proofpoint-ORIG-GUID: bYf_h0YKlS1upQ4wEpvWGuZ0oXMNqAyI
X-Proofpoint-GUID: bYf_h0YKlS1upQ4wEpvWGuZ0oXMNqAyI

On Sat, Nov 16, 2024 at 05:59:16PM +0000, Pasha Tatashin wrote:
> Page Detective is a new kernel debugging tool that provides detailed
> information about the usage and mapping of physical memory pages.
>
> It is often known that a particular page is corrupted, but it is hard to
> extract more information about such a page from live system. Examples
> are:
>
> - Checksum failure during live migration
> - Filesystem journal failure
> - dump_page warnings on the console log
> - Unexcpected segfaults
>
> Page Detective helps to extract more information from the kernel, so it
> can be used by developers to root cause the associated problem.

I like the _concept_ of providing more information like this.

But you've bizarrely gone to great lengths to expose mm internal
implementation details to drivers in order to implement this as a driver.

This is _very clearly_ an mm thing, and _very clearly_ subject to change
depending on how mm changes. It should live under mm/ and not be a loadable
driver.

I am also very very much not in favour of re-implementing yet another page
table walker, this time in driver code (!). Please no.

So NACK in its current form. This has to be implemented within mm if we are
to take it.

I'm also concerned about its scalability and impact on the system, as it
takes every single mm lock in the system at once, which seems kinda unwise
or at least problematic, and not something we want happening outside of mm,
at any rate.

>
> It operates through the Linux debugfs interface, with two files: "virt"
> and "phys".
>
> The "virt" file takes a virtual address and PID and outputs information
> about the corresponding page.
>
> The "phys" file takes a physical address and outputs information about
> that page.
>
> The output is presented via kernel log messages (can be accessed with
> dmesg), and includes information such as the page's reference count,
> mapping, flags, and memory cgroup. It also shows whether the page is
> mapped in the kernel page table, and if so, how many times.

I mean, even though I'm not a huge fan of kernel pointer hashing etc. this
is obviously leaking as much information as you might want about kernel
internal state to the point of maybe making the whole kernel pointer
hashing thing moot.

I know this requires CAP_SYS_ADMIN, but there are things that also require
that which _still_ obscure kernel pointers.

And you're outputting it all to dmesg.

So yeah, a security person (Jann?) would be better placed to comment on
this than me, but are we sure we want to do this when not in a
CONFIG_DEBUG_VM* kernel?

>
> Pasha Tatashin (6):
>   mm: Make get_vma_name() function public
>   pagewalk: Add a page table walker for init_mm page table
>   mm: Add a dump_page variant that accept log level argument
>   misc/page_detective: Introduce Page Detective
>   misc/page_detective: enable loadable module
>   selftests/page_detective: Introduce self tests for Page Detective
>
>  Documentation/misc-devices/index.rst          |   1 +
>  Documentation/misc-devices/page_detective.rst |  78 ++
>  MAINTAINERS                                   |   8 +
>  drivers/misc/Kconfig                          |  11 +
>  drivers/misc/Makefile                         |   1 +
>  drivers/misc/page_detective.c                 | 808 ++++++++++++++++++
>  fs/inode.c                                    |  18 +-
>  fs/kernfs/dir.c                               |   1 +
>  fs/proc/task_mmu.c                            |  61 --
>  include/linux/fs.h                            |   5 +-
>  include/linux/mmdebug.h                       |   1 +
>  include/linux/pagewalk.h                      |   2 +
>  kernel/pid.c                                  |   1 +
>  mm/debug.c                                    |  53 +-
>  mm/memcontrol.c                               |   1 +
>  mm/oom_kill.c                                 |   1 +
>  mm/pagewalk.c                                 |  32 +
>  mm/vma.c                                      |  60 ++
>  tools/testing/selftests/Makefile              |   1 +
>  .../selftests/page_detective/.gitignore       |   1 +
>  .../testing/selftests/page_detective/Makefile |   7 +
>  tools/testing/selftests/page_detective/config |   4 +
>  .../page_detective/page_detective_test.c      | 727 ++++++++++++++++
>  23 files changed, 1787 insertions(+), 96 deletions(-)
>  create mode 100644 Documentation/misc-devices/page_detective.rst
>  create mode 100644 drivers/misc/page_detective.c
>  create mode 100644 tools/testing/selftests/page_detective/.gitignore
>  create mode 100644 tools/testing/selftests/page_detective/Makefile
>  create mode 100644 tools/testing/selftests/page_detective/config
>  create mode 100644 tools/testing/selftests/page_detective/page_detective_test.c
>
> --
> 2.47.0.338.g60cca15819-goog
>

