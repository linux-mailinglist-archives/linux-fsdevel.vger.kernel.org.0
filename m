Return-Path: <linux-fsdevel+bounces-32171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB969A1C0B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 09:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9188F1C21103
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 07:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66C21D07B2;
	Thu, 17 Oct 2024 07:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BmvLQGh9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rMzpG4f7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDED1B6CF2;
	Thu, 17 Oct 2024 07:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729151700; cv=fail; b=GY+cYi62II72UAuplIwoY0RKU5qwkfN1JMJ4xRV4hGUSz+IfHH0lumcknt0vrOY2F1I+aAADZA4NHaOeF2Dgda2EDHyrSzl1aYD4LPEyoP2HMceQ/zulKDxj9eK5+qg+c6OfruNM7bkhck/dyl/EfKcUQCSFpHjOQNIv/D2PK4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729151700; c=relaxed/simple;
	bh=lOJSfA+lbh2aRnPsfF5pQAALVtxe3RV9u2S4BywJjqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cc/dwiIdb0yfwnsd2zu3gqzp7dYAWcyCP4he1AJo1BooL3FIZGyY7MLUIW6S+/+Mtqg8IC467a38B1Ls5POf8I0lSBYrVYt3U0wqWN/z2Xkyy9ZkC/1Mrriy/Vpjhb3jqWf+s7ToeKXE4VD6uEpF/oMsqxLKtWJ99oNB5wTjclU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BmvLQGh9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rMzpG4f7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49H7fcxo031824;
	Thu, 17 Oct 2024 07:54:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=kcf5we+1XlPX8dwXuj
	o9XowxPY31IoLWhUyD7Fo6t/4=; b=BmvLQGh9bvxMWJkeHUeJgOoadgO5Ek+4BT
	pKp9ZQ+I1+yjqacYvXW39B6JP6UFG7QftcuhrXEvdqxGLLYd7CEC4Z57QePXy8AN
	Eg9Bi/Zp65vvMnhXCjwNAyL0ibIeOFUkK6u3P4WviC/b/fuME7Hz+Qxx6FgjOooO
	ZiTB/GoQIcTW1jGBwn/wo+y/Lhkdeg7MtnxZyi13P/Cs6/zbJL5fdH2Djs0jf6wK
	UM5C5r4pD6+5ofAHrSub8wNFVURRHgUqq6Qd+Wkotl+qFgwoTxS1yrmttFAJKqOs
	bwzf1rJi8FR2SP+ajbX048o77zdi2yBwhyMCk+wX4UlBgyxelHkg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427hntdpd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 07:54:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49H7Ooeh019884;
	Thu, 17 Oct 2024 07:54:27 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj9vhjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 07:54:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=byJ714aW8AgVAg+3QI3GIDXLRBhpb7lVNY5FrQ9WNsCbphWDN5p/tLI5njSZulEWNJXdBg30rmIAn1jCkM/OiPZwvvkTbbIBn5Ds8Bx8eJiff5YgUzjxhmc0fwjv/raBfjfsY2RFNTyQ/2xh6GlmZ3lJTar9KppblzZyxKDLxECPjKIaIVmeKd+o3GYiqZgwW2mAM0Jnh9fbHCsvNL9rhWcXCkiJSQM245uwd9OXtv8D5cXXMhmCmBIJS2sn20GaZsDK4mSidKlhFgRnMYHJZihj5bvgFu8mBjhLzxDRSwxIagpNj3xxZhIksyoi3Oo/q+HAuuRou3P82Kl/Pd/aiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kcf5we+1XlPX8dwXujo9XowxPY31IoLWhUyD7Fo6t/4=;
 b=ALrWy723LT95vCg0HM76MJc+97Ir+ijOvbZk8Y0k7ZYItH4vaOUp+Glm0vr3I6mwWba0Sr0GRx5x/jYjsRZfgveGjcydPviqnd8xPSsmdk6RtXkA+MyC/2DjMwCb6kss5NajO2GlWV565lJ4YhuRv6TszaTz2ZZwvFPM+hwc7JahlWN7bthiZQBro56oe8y22778HuGjRWrrSXaSdP6npAacCVUIJ15l2HslNuOlrcx1CdIrq7ujfgqmkQzub89RJjMF+A2K8EGi20Fp9r9R9Zr3zm22B+wFU6az3ikEcDq19htnCl5dbdOmXm7zSAykiFl2FegWbNYOl7YT+URQUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcf5we+1XlPX8dwXujo9XowxPY31IoLWhUyD7Fo6t/4=;
 b=rMzpG4f7sOSRpJu7lPSD40kcjOiDsNIw/tW2EbeYbQ//+NbMaPLT1aVhFUsvyGRwwv2TDiWvFawlGuQdEu2hhP8wvCY6XuP9EYNDGqys9YNI6MEQSMo0jCCEwZI+DOBH3gXfmrjbM1Cpi6EriFDA3Y9SGcHXVpLfpFFE7Q+3e7Q=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by LV3PR10MB7867.namprd10.prod.outlook.com (2603:10b6:408:1b0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.21; Thu, 17 Oct
 2024 07:54:24 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 07:54:24 +0000
Date: Thu, 17 Oct 2024 08:54:21 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>
Subject: Re: [PATCH v3 3/3] selftests: pidfd: add tests for PIDFD_SELF_*
Message-ID: <968c8fae-0cd0-49fd-8f26-e44c7d84e9b4@lucifer.local>
References: <cover.1729073310.git.lorenzo.stoakes@oracle.com>
 <c083817403f98ae45a70e01f3f1873ec1ba6c215.1729073310.git.lorenzo.stoakes@oracle.com>
 <a3778bea-0a1e-41b7-b41c-15b116bcbb32@linuxfoundation.org>
 <a6133831-3fc3-49aa-83c6-f9aeef3713c9@lucifer.local>
 <5b0b8e1e-6f50-4e18-bf46-39b00376c26e@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b0b8e1e-6f50-4e18-bf46-39b00376c26e@nvidia.com>
X-ClientProxiedBy: LO4P265CA0203.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::17) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|LV3PR10MB7867:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b4575c6-69fc-4497-1528-08dcee80eabe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zRraa+GERdNi1wz4Bwcrj6J5lKO7AH+i9TnBSQKm1U0+Gr7fqBTI1w8BxOG7?=
 =?us-ascii?Q?tIzDnhegEB0hLYaSEU0khnTxOxgftdYljKNaa3iV6OkqplD6C0yksPOrWQGs?=
 =?us-ascii?Q?mx3Y6uh+XxX+p0WV3tPHmdeKCaet1OzLwUmTcxvDhN4pDlxRFiYUJzNI8s3Y?=
 =?us-ascii?Q?qkgu6nR2cgBKBX6i89EIlaQnBnZfyfeEYpNYsUqBU1XlJOJRAST4obzeD8Wu?=
 =?us-ascii?Q?97hvu18tivHNAdatI6B7S2+wJcHeXquqWIvZsul+6IXCF9HSaUUDoeEyQsOR?=
 =?us-ascii?Q?2K+mpVkw1LlfKicLDSCLE5hrKDsv1bgZQg3k8woyiyOYQmtBtfTSzpoa6Cx5?=
 =?us-ascii?Q?gtOkG2uHVLs9dHLmUY3wpQK1Bx3N+kC+YtfOLtLyhZjoIc2npu4WQA4QeSEa?=
 =?us-ascii?Q?WHY+elhiAcNxB5lUGVdwNEst2cNtE9u6tmQaSwuxx/4wnQ9cREVl1yA2s6QD?=
 =?us-ascii?Q?x9PGsyuGNB11V7dKG6td3VMslgZ1rgAatkY3t81Bew5YcCy012Xtt/ChTKvM?=
 =?us-ascii?Q?OwtQTxh/Jp+nvFWpt+nOOMMv7S8vQDq5i3ccgHNDgTVKP9Bl/yPBVBcOBR8S?=
 =?us-ascii?Q?mEBJZ+iBT4zZLOP+9mTcxHt9dKYp+uT0+ORI7tfDO8c12s2FwiLvRhW55ouT?=
 =?us-ascii?Q?BBsTuhS8LIVcsEFzsIgPbplcel6De9B95bV+ZrwlGXXkoEVWFsVQHKhViHAn?=
 =?us-ascii?Q?mSkh3s45oqqc9p/ugVzz0FZyXKjUOjQNWTIKVIsFVazA0harS1ioZstNtKKL?=
 =?us-ascii?Q?Ad4vX8wTkYO555zxc6pDyT4t3GKvCV7Z/CKMDqn7j+w7tkPZwC/yHqgU6Ksq?=
 =?us-ascii?Q?6+G1HgptbnTKc8uyAPMXd5Etr39Kaj05H8taMwO/1kzuPam7VjlQ7/aZcUB8?=
 =?us-ascii?Q?HxdtinDXyQUxS2fDe9fRfzQnT1awQdE/EkvqvHkGYg6eg6G4Yzm9mZbtlIQL?=
 =?us-ascii?Q?OqjyVh3Aglf05VOPvaMoHrCAEbrQGBVx9FnbAdaT1+StVGgq2niZWLh+wDuY?=
 =?us-ascii?Q?M21PpvQ9+pfYw2JtTqlfG328nxuGSBDJZc2RUuvDQ0vA90NoFCnDewoUIcQ0?=
 =?us-ascii?Q?P/tzmdZvsI7Dlj7OnCDZFHbtNTYJkYEVxkt2oAVDtaYJ+qEMvXBgfRgEyxGB?=
 =?us-ascii?Q?tX6Si8Hn5S/xNtD5NnTJfOIZ4glUSw/KKclkDr8Om2Hbc5fLjBE2vJnbViDK?=
 =?us-ascii?Q?O0xAJmLP/BAUBmWq2grZPWjTiGNaU3fH8TX2o78RJR6+AfS8g5dxcMWyibt+?=
 =?us-ascii?Q?oIJxOK63CwvSqUVdU1143TsqsL/EdGC5a7yv09r6djOdJMmJqxd59L9pCL1c?=
 =?us-ascii?Q?D8pBS7oL3OJekvDSSNBeLObE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UOV5IzHFceZQMyc7uicrEDZPrd+rAcXIl9iAzMeeoTT69C4XKNBZK1HufvM0?=
 =?us-ascii?Q?Mwy5xX5HreixDGfCwcVeB33kC2ul4nFaMVPq3wha0s9jA4E+3QxxV+NGWBi/?=
 =?us-ascii?Q?aZwqTldbg9TvtZGZBFCOURTY1HHnyqDBjnnS2iza6eCss1ZEDzcoo4+Fn06G?=
 =?us-ascii?Q?UMS6rKNGaXtrmc/cBd6gPvpzLNBgTfn23QRHrfYGPpuQ8EYIGOaLThHD+Xhg?=
 =?us-ascii?Q?3cuEW3NBCMa3rDYjcaTwHJUm77jbS8sflUwywQzYR+EWO0qmvvg9MNO7PGnP?=
 =?us-ascii?Q?89BvalC6y8Ti2JW+s8M0hS/06qdSwSc3EzwTItr2QZvmKfLZB40FY3n+uTgs?=
 =?us-ascii?Q?IZbqHgTgAWMXb946+n2mc2qEl8lURtx8vwsKK/5oJD0p1JkCbC0qo62e0ut7?=
 =?us-ascii?Q?OO8lHPEePSTeveIBb+6UmNM+9jIC23maZQbvYeTCcQrtPGjTy793io+dl9VK?=
 =?us-ascii?Q?3T5hY4HqYZOU76k9WFU5Vr+JKqTbz6zENkh0CpgTMhnApSW14+osQAow2KEA?=
 =?us-ascii?Q?HDRbOcdOdtgWE8XasMDNBd9MA8a6xeEhf1hOz19362aU6LS3/Dqg2PueMth+?=
 =?us-ascii?Q?XlKUbWy5icsie0scPl2DXTdESovPsoNaA5xcgvky3tviraJv4BQ6EA2hqCQB?=
 =?us-ascii?Q?5p7qOWr1eAFnjRWi9JBZQAkdHUfaQt0/oGST98iJNiUXb0OV627vrej2WbKW?=
 =?us-ascii?Q?pKWQW3ZjxUj0JiMdroCLR3R5EOQbgPd2QQDM8SUwTYT54Pj2CvrwVYoiIgle?=
 =?us-ascii?Q?A5UFemxj793sbwcp9ovQYdZzU9Bv059Kqr9nq5pNSHu8PvXuF9ciTbx7k8+K?=
 =?us-ascii?Q?z+vcYRNd9ZJfjYwDsAT8sQzZwjM+iUBycPBDIgcYASrDIKU/jzVGvsR5Vlk1?=
 =?us-ascii?Q?1lajtf3ffUoR0PMp7wUqrzV5t9GBrGKPX/1UhntWlk/7qzjUXucVB5GgUtwN?=
 =?us-ascii?Q?W2TMJJQEGD6VneDwjH/hmCnFrOHhpRyai0vqSw0QtvDzOI+QFC27u4rnfthr?=
 =?us-ascii?Q?dcasHSw9mFoGvy9d/vy1SVBiz3QRRs5k1HHPUGZ39aTi6mH8Yf+Eqf3MBC5V?=
 =?us-ascii?Q?98pn3cKDkQXmrxM3aRNeAggk0RxkNi8Rb2UbC5R2+w7mZAjmMJD5uGhwpN97?=
 =?us-ascii?Q?zXPhciBmZ/9A6hc2Fypy8vEw1ebOs6NmYogGkCR4PJNvFJprBuQs2c+Z2onw?=
 =?us-ascii?Q?77zKSvqcqX2IT3WDpaceG8VeeuiqvFCdksm8lShou1Sr4QbfwVisHyUmlIyU?=
 =?us-ascii?Q?djq9sqXpmAB+lEHDKW8V3Da4vcCU3NqQPsVLWtcDcoHuh7dzsJAV6GRaRSwD?=
 =?us-ascii?Q?Md95+kMSadD0DCx9oHAKsxv3jMS/ImCFVUj17KJxajNiBtOOjAZ75MNARwqt?=
 =?us-ascii?Q?jp/X3C3TfJP/CRirmoczHkqJGh1wdzwmSyvd3l10EO+iZ9YQNTAt+YNFEoE9?=
 =?us-ascii?Q?sf3OREDprqehUXQkr3TmLwpPZLozqOwCmE2oVrQBUwuVBeWXZgANM4FBO9u7?=
 =?us-ascii?Q?qNqnnIYAeqzd3wYA1wv/wEyPFI9qgKrK+u/4IxdgapMKL0IZgYTFzxFUItbo?=
 =?us-ascii?Q?e9/gEpvRP6roxtV17ygviuA3VZP9Lz8Mjn/78c90u4HaVPYF64QKbWOpTyy8?=
 =?us-ascii?Q?7Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sztP3dpEJcUMJ4glT6D0Lcb2efEnpMXLcJpifV4gdpOD8LFPssvNpN6hqRI7iCER6rOVJjX4coT0PAX9jBm/qL9hS7yObCBjswbrkzkLAvWYPEbSDbNU8Ixg8aXumRYd9TzYMtDhLCEL7uZYpI3IhikjMIEgt+XCZWtnlGz9EwC2LqsJXxkr5CU0Yrr29e+L7kmLOD70+r61MZpcbrjmklp3kdB+XHaBf17VkWDUBpLhJYB9PoXkuA5IfI2l2vOWczus2zx9tEFlhyJvZ/QP/XrSIYKISaZ8b2jhe6+VOGkbyECtcHH7sSZtE0JEShBDOA2z9bfYr/1rvfFRraC25OdzWbCGtLBILoIeYxCYZfd7/p3mqz/1zPGvFKoj1BLrhYGRM3uFnDnW/ZelAn6xSnXDAJ5Gq5F8XRnCOvFC/033yJw8BXd9mgR5hBwVgbyGsMZhZXBzNxumR6hrLtia56EnXDLEa6gqEgseOPmPqz26e1WaPz/sW1Ceq32BooCdGXKZIstoR8wPDHcv1zr1rK9NsILFPbna5p9hfKJ11lQ6h1lsRWaZL/BRLRAMDB1zJX8EC8Mp8862a8XqsG1TnYzkoxuYnyLDTZxv7ha+L+4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b4575c6-69fc-4497-1528-08dcee80eabe
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 07:54:24.2178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U7mTVwg8OeUlWrcMgamBIvOmsXTV1hvvvLWjvjSKKvGkeJSTX90WXX08OFmPhj47Lw5XCkqX4Vn39ER9E1Bn134eqcjkr0kUQ6s8D/Ih4wM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7867
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_06,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=694 mlxscore=0 phishscore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170052
X-Proofpoint-ORIG-GUID: -eXNCqBLXyOJxiN4QQGCZqLoeNzBsF76
X-Proofpoint-GUID: -eXNCqBLXyOJxiN4QQGCZqLoeNzBsF76

On Wed, Oct 16, 2024 at 07:14:34PM -0700, John Hubbard wrote:
> On 10/16/24 3:06 PM, Lorenzo Stoakes wrote:
> > On Wed, Oct 16, 2024 at 02:00:27PM -0600, Shuah Khan wrote:
> > > On 10/16/24 04:20, Lorenzo Stoakes wrote:
> ...
> > > > diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
> > > > index 88d6830ee004..1640b711889b 100644
> > > > --- a/tools/testing/selftests/pidfd/pidfd.h
> > > > +++ b/tools/testing/selftests/pidfd/pidfd.h
> > > > @@ -50,6 +50,14 @@
> > > >    #define PIDFD_NONBLOCK O_NONBLOCK
> > > >    #endif
> > > > +/* System header file may not have this available. */
> > > > +#ifndef PIDFD_SELF_THREAD
> > > > +#define PIDFD_SELF_THREAD -100
> > > > +#endif
> > > > +#ifndef PIDFD_SELF_THREAD_GROUP
> > > > +#define PIDFD_SELF_THREAD_GROUP -200
> > > > +#endif
> > > > +
> > >
> > > As mentioned in my response to v1 patch:
> > >
> > > kselftest has dependency on "make headers" and tests include
> > > headers from linux/ directory
> >
> > Right but that assumes you install the kernel headers on the build system,
> > which is quite a painful thing to have to do when you are quickly iterating
> > on a qemu setup.
> >
> > This is a use case I use all the time so not at all theoretical.
> >
>
> This is turning out to be a fairly typical reaction from kernel
> developers, when presented with the "you must first run make headers"
> requirement for kselftests.

It's a typical response for good reason... :)

>
> Peter Zijlstra's "NAK NAK NAK" response [1] last year was the most
> colorful, so I'll helpfully cite it here. :)
>
> But seriously...user feedback is rare and valuable. We have some, to the
> effect of, "lose that requirement". And we also have an agreement, and
> an initial implementation in selftests/mm, on *how* to avoid it [2].
>
> So...let's do it that way? Please?

I'd be happy to but we can't because the uapi header is just broken with
this test due to the linux/fcntl.h vs. system header fcntl.h issue.

We could work around it by copying the header without the linux/fcntl.h
include however...

>
>
> [1] https://lore.kernel.org/lkml/20231103121652.GA6217@noisy.programming.kicks-ass.net/
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e076eaca5906
>
> thanks,
> --
> John Hubbard
>

