Return-Path: <linux-fsdevel+bounces-54163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A7FAFBAA2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 20:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83B2B189453E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 18:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6E8264624;
	Mon,  7 Jul 2025 18:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n3lwR6Pd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="d3hzrLzH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D7718DF62;
	Mon,  7 Jul 2025 18:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751912818; cv=fail; b=rb3mbf1BX06U/Vohwd6M/FbVNgCKwig0UrstCCBPFDoTQPNDY/e37fW7DfCb4GJ7wRWMzoLrGEzDjWx6XusBCyPwPE0fL3bynAyuzOKkBzY7nOQk2CaYmm0wdAUiY5c/CZf0WoFFaDo1pzA8DRAx2gI38sRPWejOvV7rpaFY8S0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751912818; c=relaxed/simple;
	bh=WF1qtU2DMIHVJvbOyZ/5ZjRbI782KMuatjqIN8d6qIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aFnFkzQfB9IN1q7YDnLQnnf3ZC6sXsBuT8ArgAVyXimAus8TLHLLRQxwoKtIk8/cM32x8jWs87JMg0KiQ05ZqcnnKeEER5fvo24I2J7CKDhA+eJKWGQXESk0GhDrvvQBCayyHoUZrDS1mTfem6nyo/vExjL8H0MExcuDXUuT6qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n3lwR6Pd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=d3hzrLzH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567I7D3m020665;
	Mon, 7 Jul 2025 18:26:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=RFdvINrBPi2tAHnCKG
	XEzSjEgASWA9MbvEdxZisTMzM=; b=n3lwR6PdU+AonZ2f061DM6XBTMr8IiFRsr
	8pc7XUZfln9qEPzMZFrtPUoVGYrpjAu6Hs2opPQScBEhXf755GIW3YA7ny6yMA/J
	OlLeOPgiXbptJHncd2mD6Q5J8lxBqSH5gMkqQYnggxL/ApISQMs1uLdR+3Uo7R6W
	2cBmGrENhXaTuU9/eM4HWyaUvtoDBmvmn0bqdgx7CeOUVok90R6LIZlJSU2zTj1a
	w8WP1ogIT8I4yN56wwxXIU2q29/9TbFWmtN+myLZ64uZvobRcTDExWKYJgQg1ZlD
	HirvFthDj0YxXZyuV+eIkC/1vWPt5iwtWWArveWEFJQwov/MFJzg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47rk7tg13t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 18:26:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 567Gc8CO027079;
	Mon, 7 Jul 2025 18:26:23 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010060.outbound.protection.outlook.com [52.101.56.60])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptg8k0fy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 18:26:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UaULEml4FQw87qVKMfCszlnQvs5hcctqlfSvaM3JWfl+MnoSbr9ite4HXo8hsv7EuPJ6efZqCfqpOMcvipJlBg7wEgAzSl2n5dbuyr/rrb/MZ/9G4UJc27Q3KstI5D5qmAi8r92a5EDHJ4LhiRjxzWcQtFke5eONBdMSY5c4cEXCRXY55tFo7zcRliQzrDbFbETFMfCOYp1dOwunR3b0nmd5ZjhOkJIJ+z/mFB1pq9eF0HcC6paSQxbxtuHCcv3R7jUACz8f5ZgKgwDlZ91OgfDkLJgJyYlj6zboP5AsdwYrxcX2h9+QJ24Tx34dK/+l2PWwTEelSMHRwn+hS+gGWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFdvINrBPi2tAHnCKGXEzSjEgASWA9MbvEdxZisTMzM=;
 b=XK/p9zVsyS3MevVo0Kd5+QKHAz7az31f19eMA5UlrGpYO5JXJYdnmWxJEB/rRU5D5rgrmDonAlq1zbLpxM5zkWRMKZs0FninlfC2dE97WmKNVILTYe+MlG99cKV0GgHAVPuaj+myrlsItdu2pPoDkWENjQ1BkqEzc0JtPyC0MV6W5+coBzZbVwoG4mpmiVc0L5MIPCPD+f+ACXellQ6HTnYVaBlvHlOKpw8BiBBXau6lwcnFoymNEmsgTqICwu2l0upPnr13s24z+aGzVNOFNbp+bhO0OW/c/xjMEK8ylHFHsOfm2qxdIdDHPFrhN9jJlRB48UJAPQZjDAgFm/un8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFdvINrBPi2tAHnCKGXEzSjEgASWA9MbvEdxZisTMzM=;
 b=d3hzrLzHHULC3uTO0FVjOkifY9UVKWj9q2/uXj0ajbUpPY8NOAgsVYH3swh3t0/Q7C9/TYiu2EJrLeh96yk5xIOGZBUk+8jeT4wT9WUldimZqdnqLCt0PoH3C2F4lmD9x4dL90grbmp5EXWsnnuqwZsoBzJI9nV7CliJqOSy9Y4=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by SJ0PR10MB6399.namprd10.prod.outlook.com (2603:10b6:a03:44b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Mon, 7 Jul
 2025 18:26:20 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8880.015; Mon, 7 Jul 2025
 18:26:20 +0000
Date: Mon, 7 Jul 2025 14:26:15 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, lorenzo.stoakes@oracle.com, david@redhat.com,
        vbabka@suse.cz, peterx@redhat.com, jannh@google.com,
        hannes@cmpxchg.org, mhocko@kernel.org, paulmck@kernel.org,
        shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org,
        josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net,
        willy@infradead.org, osalvador@suse.de, andrii@kernel.org,
        ryan.roberts@arm.com, christophe.leroy@csgroup.eu,
        tjmercier@google.com, kaleshsingh@google.com, aha310510@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 8/8] fs/proc/task_mmu: execute PROCMAP_QUERY ioctl
 under per-vma locks
Message-ID: <7627khrus5fhihfbwgoz7wqsmwchimecrfksg4smcfnhe4g3ax@crs2h7n52edx>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, lorenzo.stoakes@oracle.com, 
	david@redhat.com, vbabka@suse.cz, peterx@redhat.com, jannh@google.com, 
	hannes@cmpxchg.org, mhocko@kernel.org, paulmck@kernel.org, shuah@kernel.org, 
	adobriyan@gmail.com, brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com, 
	linux@weissschuh.net, willy@infradead.org, osalvador@suse.de, andrii@kernel.org, 
	ryan.roberts@arm.com, christophe.leroy@csgroup.eu, tjmercier@google.com, 
	kaleshsingh@google.com, aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20250704060727.724817-1-surenb@google.com>
 <20250704060727.724817-9-surenb@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704060727.724817-9-surenb@google.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT4P288CA0090.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::23) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|SJ0PR10MB6399:EE_
X-MS-Office365-Filtering-Correlation-Id: b7948521-b013-4e0c-4ccc-08ddbd83c538
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4LzBMAMmMBhUc/++261P6biLorWKj8uAVSHOVtGPXBt7AgeBYlRiDr8Jg7mw?=
 =?us-ascii?Q?slHdKEVwYKbSSzVKDwD5sjmtVuKU37bGGD2hfbuP0qhhYovlciC8ewO39xXr?=
 =?us-ascii?Q?9eGem1fWa4vyjOzxcPYrGLG/arPuBCM5jeJRbWQTG0OPr4/pQYOKM5gLXrVt?=
 =?us-ascii?Q?0htkDW6yYN70z8DTFRES33ytvl3W/SvMRDvgffri5AW6o7Ldi9VIUhabbzAw?=
 =?us-ascii?Q?xafpN/Hvg0VW2AwpocBtjxUHdYblcOQvMCi5JUnJVX8k81DlHa1XFLsXC+Az?=
 =?us-ascii?Q?meVwoBzbFNFfNgGWY9RsKj1F5DFkbdfV3EgdOTY9WxOaxtP7EJwmIBpaRn0u?=
 =?us-ascii?Q?VQAjHwBtXdiybdpDeqmSisfUm6sMwdTx0U4ppOljl8ARcJq2YKnp+rv1dq4r?=
 =?us-ascii?Q?OhBQKqyUFOgYGF0jD1/XxmgGvn2blNQfwD7+XuJw0TY5GHAO8f2Wrfm3gp2T?=
 =?us-ascii?Q?tpE8zh6sK8XDTs9MyYY0gVvemUzgEb9H5BTczZYbQZrYZJ2cENBkg53iOVEx?=
 =?us-ascii?Q?g9sIVdDvbitskzYZd8qwK1H/MUCdSlJOWa3XjL9YO0Ok/+MbifdmO7AOQt8G?=
 =?us-ascii?Q?Y7iB9cbCWQXo1jj5nAtAn6iuaMj0DAeaNieNV5JzFnKtDU8bp3VJzOvfOVNp?=
 =?us-ascii?Q?2dfEQQsCC7f5DRDMNpDfTbq+IGq6mDnbBgdCTYV/G/f7GXJYKjYCifN53Oqn?=
 =?us-ascii?Q?Wy2on81YILZQkYjBxm8vJcExeeycPtfLhtFMsbq45SWSmMJECbXD8nXum8em?=
 =?us-ascii?Q?v9JlxST4PMJQBU6fOc970b0NbdTP41O75fgNd6rOxgD69ZHY/PvAEkjkmmKX?=
 =?us-ascii?Q?Ea2rnwtX4ZwDmVFTWlQlh+eqjzsCEgcz5Bp9zc084/nPEWN64NPBUawSGcLe?=
 =?us-ascii?Q?m/FpPSQOcGCoGWUsL+vF4Z4kFSe//fVviXkYR2Owsy1/kLRHM75wbleY/s3l?=
 =?us-ascii?Q?okIqm9s/4FEsBxzHio8Y/Tos7zO/v9jSKE/N1AWQt99K397+f2IKObVkZJeE?=
 =?us-ascii?Q?TolAe9rnLQBU+D/GyGjfWjStvQebn9MhPZ4jPZx480Vgmewd83D1su7mZdbW?=
 =?us-ascii?Q?YF5ijAx3uhdq3EsKiQ/XjlBZ0KVufXDFExeKqiE4fcbhiy/gx88JUFyWll1k?=
 =?us-ascii?Q?gEOx+A0o/u7DFAFVDpth7Oxv7xhCf5cANHqzcO9L5f4nK7qsd/ys70e6bSoO?=
 =?us-ascii?Q?m9wjbkFJU0zAyGynFoDVMMn/xHy6PwA8mdbhn54v4VXkxWGozT5Rrqz8Mrqa?=
 =?us-ascii?Q?BrIdoYAOSDPsejIgr6DIwQorCS8HCu3AqgUL/QBEp1fqh5tX65cTIVXwIuUU?=
 =?us-ascii?Q?bC48kBiLejecm7K7aC2WPZ334z9YcBuXG1rSslhtNo41zuuMUcbSihWpGfKe?=
 =?us-ascii?Q?oPUfi43pjOByDJi/9HVU5rjpONNyj7O4WIZLm0b29OdOW8p14ODUmJ/FzA3y?=
 =?us-ascii?Q?RuXimaGfZsM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i9qrqa9LWZWzgIpzTuy+28tckJiZfYdw1bhp7O012CMSjm37ETHKks3n7cZq?=
 =?us-ascii?Q?6BTNpPWLAWY8WLC+1D5Gu1WBxL6g3jybyxlYKIonBBmEuSYxfN+TOF1W7ccj?=
 =?us-ascii?Q?5R4ONvt2jQheC+TTGJnSYzrYsvhr4IuAYZ93vWz4UVIlVMH5paH25AQKHZwz?=
 =?us-ascii?Q?q2FCZQi08vVmmAdIWThuVHp/AMRJ6591vVdHqipcTsMNCkc0Kl+q+bHyPmbl?=
 =?us-ascii?Q?2Sfe0iWfKX41cb92fPpq8qANVZe8aG7okuGgY8V+9Upmu0wmyhWRmriK9nSw?=
 =?us-ascii?Q?zGnyd5QjAO1Xr1onds1dtTJOJPODTMqc9UYMLAdESOthW2OorFr9QJmyFe4T?=
 =?us-ascii?Q?VT0R7yQPqpJ7ZtB0uaEq8VBc24DTsKhqoMNNjaR6cro75Eh6NN19qSWNT1Mi?=
 =?us-ascii?Q?KZMLzW5z/3q+L8tZZcsswkMymWCnM8ef9yuQBxfGIOQdHr7u0C2De34Ar6DI?=
 =?us-ascii?Q?u8nHpqSm4TE4ym6jV9cKYY085q3377qOclvJ2dV2E1daB+YotN4tjbRh+/zP?=
 =?us-ascii?Q?lqKg1AJq7jqSfL+gQthGIXcbNJZiR3/6IVoDS7iqhWMoJbeZecJqtoU6cvn4?=
 =?us-ascii?Q?esulW/ekWO3W8l2C3ztoEa5qRZx03V+Sl0jqLWJfvgSlE+UYLP5cAO153DMY?=
 =?us-ascii?Q?3d3SP7cuGoO/SXj3BQku/1V2KuWGqHObcfC+IB/6dr6TSoyfJVUkSabdiiXR?=
 =?us-ascii?Q?eKrnMMnCvNk824bTDMlEIlkm3LkZUVQqnnVIn/v/AUF2EX2E97fhW4ysO5Ym?=
 =?us-ascii?Q?8HKUu80WPaPn9uP0MvkEpEgNFAjylrqkbQqSeQ2nuefmRJtNMedNAUx/lV46?=
 =?us-ascii?Q?iiV19T99VYiPDMHYvuFV8CZk1XgejqVCVpRXkq7YEodU5roakPJwou8d677W?=
 =?us-ascii?Q?Hkibamf+Vr/a6vQdLnNsVStxhs/4oukBJKkCzUvSkbemhugtFITPQCDSVXyi?=
 =?us-ascii?Q?L9LZAby9IJP8tFBSjKzOLEy0EPqszvLoQS7ZHSOTWNw/zdoNsExIajqd3Xh6?=
 =?us-ascii?Q?0TFbG/YiV1Pd/AgMcl7kYl8Hm0Fe+UFfhtvs07SqvY+KQJkbgGVeuOIOd+Xk?=
 =?us-ascii?Q?lh1AozqHG713IDRYUSehXDVRTCCUkt93a3yNy6bmaX5vtrigS5JZFCUlRJ32?=
 =?us-ascii?Q?/73hQDO6yIK/6sQkYcSmE19UvzTpyPy3JjHe+Q6x/KbJXsjX0DXLcIbo5JeS?=
 =?us-ascii?Q?l1MAolnjGFYcWerfbfY4Eqp+RA/DSYOcfYQnb+tgLWNarJKqtmpDv4DNB9Nt?=
 =?us-ascii?Q?HnBf9lxT4gsG49HSKi5DHUK1stYa4EzL/IPE6tIWqVy3d2HIAvp0NzRLlcLa?=
 =?us-ascii?Q?RepXdHqVLi+wo/lvfmd7WVsy4exAPHC8IemY46wbDMKiKSSBxLNPqUlKTw3W?=
 =?us-ascii?Q?zFCHIZbTS+9DrhHKtRkbzY7c4us1pWqKagnYWVTPUwHs2ByUdlewCaFaqYt9?=
 =?us-ascii?Q?FxGItfK4lvfW3L0s29HanmduUzXvvqirlIiGK+Ia1Y3B25guJ0DSGjauEJ42?=
 =?us-ascii?Q?Eb6eA0HB8+iG41fgkdbwsR7XdENut8ljXpW1mxJX8pZt5TSIv7a99yI58Wfq?=
 =?us-ascii?Q?1c+hTGesWkrVjke3qF5oq2QJP3njShZNKIZKdbhX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	G+939aP8rpA82xX2UYmpin9n1oFfU5vlWwAGkT5uVYWXgOus7t8xQiPUK/P+Nnbh/eC5JJf/kpH7Jvu/bkyP6+MhHvB5Or51h7hqtKH84LTFMUHe9Ijdn6e9TofA/0+cd48Vqpo+gsoeZYOYvSmNutyXpivoc0SvuUS2l27Fed0ZfukYkLs83Cgk7JSYReRrAtJszmFd96VEBGMkQCAJ0GoIHm2BXGbvw0VsiLCwtTcnOxRLwFTQLW4URx4HKWkg/B+Pe0LbtJlMG4Of01ZKMMIAD001G3ksjlPsbsIuQ5tihuwuV3WbQNEPmC6BDeo5xH2nKfkvdu/tWRYLhMHDNhJoyOeIUHQBNKJLGjrOpZTnhoWG3hsyqAWg/PpVPrFjfjANiF5ClCByZ9VQYKbM6ip+4wMnoR8+XUGZeTbSFVKG7J4e2ZxFDvfCDQL0ht4eqkUDMA9iOzSXjsbdpSjrNeN8uIyZ9gp/oixoiW3T9BuvqTnrGte5L0ZRZ1ZX8ZJQr9gSRFmx6NiUM+Lb/+61F+tedm8JrpwENH8xX1Rg4UMV1ng1beShzaO7+XgqrVJfsGNXL5iL2Ymt7HOWOS9XwSZpXM0zNoyNHZS6nK0xoCU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7948521-b013-4e0c-4ccc-08ddbd83c538
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 18:26:20.4778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V60rG2WLAb7me21v/2NGA7zyDI7C/F03Hr4zO1fHhH/XeOT+5MtEaQsiXxGAQkn1dy10gqJvipbJZ4GSyODG9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6399
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_04,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507070120
X-Proofpoint-ORIG-GUID: l5YRYGCUI2GkGKjMcrvntZbD_fDtM0Ph
X-Proofpoint-GUID: l5YRYGCUI2GkGKjMcrvntZbD_fDtM0Ph
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDEyMSBTYWx0ZWRfX8C9Rd6ehNxTg IQ/JC9Fdji7Ipi12WUySopQSxFM6PDA9xLB0ru9GSltVjaPLeV66mO/KyCpQDSGtSbemj8LoFUs Lj3D8HNG2cWOdl/OWi/L/GkcBDV3XC60VM1NLWy//X1xkmO2Xr5pPzgUxipb113DwUauEowj2is
 VhkXVwIWXR8Hcyvwi+bDpoYbSsrguyz38qIhUcDXGwhg/3PmnnsejbDlbMaIYG5QQZDU4wDqjd8 XNRaXwB10RETScJj+/5DokzFDW15CH96cMGCXyFYUCpbi0i6FfvbQcp+MofkzdT70jMygKl3K1W SCq4a/xM5K54OQAgtIhaRw3QhM8xMCzGlFqKpChwkKSmTF2Sp0l/lOO96x6019iPyNUVG2Gnvoy
 vOGiLebMKPxOGeUqSVJcxVmsKe4XThf6A/YNdEsK8bjKFHIzCLwSpwsbfWlDvzCjmTnD9BRm
X-Authority-Analysis: v=2.4 cv=Ybe95xRf c=1 sm=1 tr=0 ts=686c1150 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=fNb60Y3t3af3kvMo44EA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12057

* Suren Baghdasaryan <surenb@google.com> [250704 02:07]:
> Utilize per-vma locks to stabilize vma after lookup without taking
> mmap_lock during PROCMAP_QUERY ioctl execution. While we might take
> mmap_lock for reading during contention, we do that momentarily only
> to lock the vma.
> This change is designed to reduce mmap_lock contention and prevent
> PROCMAP_QUERY ioctl calls from blocking address space updates.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  fs/proc/task_mmu.c | 60 ++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 48 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index ff3fe488ce51..0496d5969a51 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -487,28 +487,64 @@ static int pid_maps_open(struct inode *inode, struct file *file)
>  		PROCMAP_QUERY_VMA_FLAGS				\
>  )
>  
> -static int query_vma_setup(struct mm_struct *mm)
> +#ifdef CONFIG_PER_VMA_LOCK
> +
> +static int query_vma_setup(struct proc_maps_private *priv)
>  {
> -	return mmap_read_lock_killable(mm);
> +	priv->locked_vma = NULL;
> +	priv->mmap_locked = false;
> +
> +	return 0;
>  }
>  
> -static void query_vma_teardown(struct mm_struct *mm, struct vm_area_struct *vma)
> +static void query_vma_teardown(struct proc_maps_private *priv)
>  {
> -	mmap_read_unlock(mm);
> +	unlock_vma(priv);
> +}
> +
> +static struct vm_area_struct *query_vma_find_by_addr(struct proc_maps_private *priv,
> +						     unsigned long addr)
> +{
> +	struct vm_area_struct *vma;
> +
> +	rcu_read_lock();
> +	vma_iter_init(&priv->iter, priv->mm, addr);
> +	vma = get_next_vma(priv, addr);
> +	rcu_read_unlock();
> +
> +	return vma;
>  }
>  
> -static struct vm_area_struct *query_vma_find_by_addr(struct mm_struct *mm, unsigned long addr)
> +#else /* CONFIG_PER_VMA_LOCK */
> +
> +static int query_vma_setup(struct proc_maps_private *priv)
>  {
> -	return find_vma(mm, addr);
> +	return mmap_read_lock_killable(priv->mm);
>  }
>  
> -static struct vm_area_struct *query_matching_vma(struct mm_struct *mm,
> +static void query_vma_teardown(struct proc_maps_private *priv)
> +{
> +	mmap_read_unlock(priv->mm);
> +}
> +
> +static struct vm_area_struct *query_vma_find_by_addr(struct proc_maps_private *priv,
> +						     unsigned long addr)
> +{
> +	return find_vma(priv->mm, addr);
> +}
> +
> +#endif  /* CONFIG_PER_VMA_LOCK */
> +
> +static struct vm_area_struct *query_matching_vma(struct proc_maps_private *priv,
>  						 unsigned long addr, u32 flags)
>  {
>  	struct vm_area_struct *vma;
>  
>  next_vma:
> -	vma = query_vma_find_by_addr(mm, addr);
> +	vma = query_vma_find_by_addr(priv, addr);
> +	if (IS_ERR(vma))
> +		return vma;
> +
>  	if (!vma)
>  		goto no_vma;
>  
> @@ -584,13 +620,13 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
>  	if (!mm || !mmget_not_zero(mm))
>  		return -ESRCH;
>  
> -	err = query_vma_setup(mm);
> +	err = query_vma_setup(priv);
>  	if (err) {
>  		mmput(mm);
>  		return err;
>  	}
>  
> -	vma = query_matching_vma(mm, karg.query_addr, karg.query_flags);
> +	vma = query_matching_vma(priv, karg.query_addr, karg.query_flags);
>  	if (IS_ERR(vma)) {
>  		err = PTR_ERR(vma);
>  		vma = NULL;
> @@ -675,7 +711,7 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
>  	}
>  
>  	/* unlock vma or mmap_lock, and put mm_struct before copying data to user */
> -	query_vma_teardown(mm, vma);
> +	query_vma_teardown(priv);
>  	mmput(mm);
>  
>  	if (karg.vma_name_size && copy_to_user(u64_to_user_ptr(karg.vma_name_addr),
> @@ -695,7 +731,7 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
>  	return 0;
>  
>  out:
> -	query_vma_teardown(mm, vma);
> +	query_vma_teardown(priv);
>  	mmput(mm);
>  	kfree(name_buf);
>  	return err;
> -- 
> 2.50.0.727.gbf7dc18ff4-goog
> 

