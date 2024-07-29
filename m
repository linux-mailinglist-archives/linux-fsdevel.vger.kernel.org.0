Return-Path: <linux-fsdevel+bounces-24436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 314B193F488
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 13:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A58041F2226A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 11:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B7D1482F3;
	Mon, 29 Jul 2024 11:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Fmh1MQWV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="F0sovX24"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7356147C60;
	Mon, 29 Jul 2024 11:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722253898; cv=fail; b=feeuXxUmGukEY/QUsxmgPrjC+Demm8BWi6fob7zLN0+mbAh99bYlrOeybKHbm6vdlRulgTmJkaDnbrCmjnPoxmN8/G+Db1zbVa6482iPMnBuNveH9je562a79RLXTc2eCpyiVYnAjhttzWCreXj2JT0DoiMG/Lg5VQwK2MjSQhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722253898; c=relaxed/simple;
	bh=SQwgd9K3Hgg1OKv8/IXrezGsWaKUwYTjImKl1oIXXd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WspQoUr36AwREJFd4J2LP+4B68Zq95QdIOsq+mYb8qH5g7iMpWAXXSStyITVFMJBAfMWVVwABy71NkfRKiKEgGXAS7gV6BhBdlwalkhue+JKDD1Ug3ec/J6o5oytC/QEeWDRzrnWEFW5pSjFqzwLb6fVwgXCCPNku3JALpJ33r4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Fmh1MQWV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=F0sovX24; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46T8MXQj018370;
	Mon, 29 Jul 2024 11:51:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=vtagKAB+jqdkvRh3KbQ+evz67pMUQYm9LbDMk4fOdm0=; b=
	Fmh1MQWVu90l9dEArjzc+FKU7v0wRZC19cGZwBESiRD/KgQV2owzB077FhLhiUXE
	X2eXfsVKbPd5uWfUks4sC0QLW7i9XsrvBnMIGoHlm8id7JqtIGycdq6OyDkoRAe2
	hKlok+AUfr4cZHfjFJd2kfomueKb5PihJfpFtIk0SRPXE0X3J6x1FZyY/GComBDx
	JHSo619z62GZ4vFno7i5pGQDzIZyBfNtyK2IXEmzafwJlJsu3wCD6HPCutn9FUB/
	jHb+vgK7y4zL4IL3Wvb0nfUD7N3Mh852WKsfYcwmHdRvf2f3ildf5ZL/WSj64MFe
	v6RuwRNgNVexemGvvmhS/Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mrgs2be1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 11:51:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46TAT2fV009336;
	Mon, 29 Jul 2024 11:51:17 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40nrn5q3x5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 11:51:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eQhSzIvYEXNw+xiYlBOrBtn2FTGEfsby7wlFyMSsSABF9Z26rnWAXsvL1+pNnmx8sBrpvVTMB0aKbILmfSff84XFtCXRlZ0/PG9BR7xa6ZSxbWvvC58zIldOQxlITYC27mC618lUtUNNJhskXPa6INsuXLrEbnUpbv+073Rvsw5BIslvupK8hEHyLfxrW7bLXlM2OHgiz4v/EjGTTqtePWlFzE3oe/krHJtKQp7j+jlluREtzr4EknW4NDstWH2MUhMA1CGQQ5b8pwNS2YKEl2S1Kg9fun1c7PXgEmpdAYgWbhJ2j3HMISBsf9yBXGweST8LlK+48EJyvIH8/HgHzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtagKAB+jqdkvRh3KbQ+evz67pMUQYm9LbDMk4fOdm0=;
 b=VIYHnM/LHczIS0afGh1oq2ZKZ1k9ouCHvLytLO+W1mfCIZFgl1Tg1T00gN8p2W+s38Ea2meEVhEq+oJU5wFeZ3Q4KXNTe9lzuqIm/no3gbEmJvZrI9CFxBRs4MgqtnqF4L0m2/7nCRU9QP2L+Okpab6ybLN7Sa0YK0xOkmQMBtuxpMFUUGvYgtgLaUteEbiGl7vOeDCz+jH9q+wFXK5EPFJLJH5u0BSacF2g/cCPFU98J5ymM/mNNxJHLQdrQPLbusDOTZXf4aDy1wRMsfyYk3hzmwHOcMj1w+3dpiqU7DjJHM6/+5hzCqzj0jQm+zU+CxLpn76YkrMYlCwh9lhsrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtagKAB+jqdkvRh3KbQ+evz67pMUQYm9LbDMk4fOdm0=;
 b=F0sovX24lbpPZMxJu86BazMhDJPSXHGoJTpEvAFIns137nMXiMVDh0IcsFEdha2bg9g929XWd9lbDsn5YU5odtFzruocGqe5Bt6DiHmHcAMll73RtCH+B9lHmfkfuIAocWU+eoQIALEkkrEJLp1/8/fzrCsIh3Q5Gk6Uy7p8QDY=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SJ0PR10MB4543.namprd10.prod.outlook.com (2603:10b6:a03:2d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Mon, 29 Jul
 2024 11:51:15 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 11:51:15 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, SeongJae Park <sj@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Subject: [PATCH v4 5/7] MAINTAINERS: Add entry for new VMA files
Date: Mon, 29 Jul 2024 12:50:39 +0100
Message-ID: <bf2581cce2b4d210deabb5376c6aa0ad6facf1ff.1722251717.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722251717.git.lorenzo.stoakes@oracle.com>
References: <cover.1722251717.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0020.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::7) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SJ0PR10MB4543:EE_
X-MS-Office365-Filtering-Correlation-Id: e737227f-01cd-41d9-8f9a-08dcafc4c02a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ckmdw+ta03VNovktXHsGEpjEaWwJNSFzBJclcENL+HZjm4VMWeohJhzSCJpX?=
 =?us-ascii?Q?p/w0su5FdYKuLIZXBVxUzQpEmn90dE/SdqTs8AVk+aUw1pjIirq5KjBYxqO+?=
 =?us-ascii?Q?bBXnZj3rYdmZHWDXi4CJy6Bu4PgQLcYJ+9JBL2675rGuYMOEepXcMMnW/b4y?=
 =?us-ascii?Q?XANr9CnM5Nmj+euLXMq+EiIvilmAuxyEVjAJRoJ646EnpikS3avhi7iCrGBZ?=
 =?us-ascii?Q?OCTiQ+VKJcnaTdkHzjbXOBNVySHIWRlMwzdRxUn7/aZQAF/JBt5IEvVF/mAi?=
 =?us-ascii?Q?5Ykd+SVLL+JbzSc9NZI6df/Y8/hB6t4P5krBKZaaMsCGh+QAqDcJqH6F5bR0?=
 =?us-ascii?Q?nbh7vu/cnYDzgBcGw2fE6egg3R0n4puaL9k7/DtcTM5x0O5NQmYXpLf0G2DM?=
 =?us-ascii?Q?Nv0txFejX9l7Gf9ENAZysghViiuc7O1vPrD79sd6/o7ye0IaToxXCE8u6OMR?=
 =?us-ascii?Q?R/23N+Lu5UYjCJVdJOxNdbJwGudtlYb04z55DQKkHgHYOIz09O0N+TeynjG+?=
 =?us-ascii?Q?45xv7ERSe80nNMLlepoFBL9GE9PbQJTXBEmM4G1v8sw55Ufye5edVPp1NZZo?=
 =?us-ascii?Q?elJEvC/wP9EySScjz3sggQopa7fHCRYUbwmjg4ykFr+RSCbV4k8h61Uf06hU?=
 =?us-ascii?Q?9JlcGkmsga7iu/dA8RtDOkmHjY+UcwT8srA/8MBQbXk0GO4wVaZ0fcLt4wTP?=
 =?us-ascii?Q?KlfrU+S8DULKDFfV1LRiljnBBwSqlvAjAlxquZD2XzRb/+tg822KhF1/V5lx?=
 =?us-ascii?Q?QXYe1aqR69soB6UpAAKkHtI6bX4pDd6CexkHzFb33QxcULziRgNIb1y7Yg/N?=
 =?us-ascii?Q?gfdIFKyjwQKReVW7kNVAI1t63mNEJIaY2FWxb+fNHT8nAQFJf3dkYHBBU0uN?=
 =?us-ascii?Q?qotDsm3DgCw6AbCW83SVZD8J4z2BMejoT9N4d4Y4CHGWfrCnp8iacMk/1W13?=
 =?us-ascii?Q?chbmDiiXcuDA1KNmc3dB0drsEMfZmakI+eMUJ5FCIhvnhwmPX/1pOmOtmZch?=
 =?us-ascii?Q?CtReiM/HTLSyOylFAuS8T+gGu6T1aXxSg4XgmqT2nqoYhdV6iobHzGYR0QNc?=
 =?us-ascii?Q?6npyQd/YxM9/zv4Rb3FF/idJqIx9RhyVAd3m0aHBt2xLw0deO+fn1560Dul5?=
 =?us-ascii?Q?t4oarg7/uqfpzX0HowlzZE4PKbry7yQ2S+CpLBkrcc1Ju6QbWpHTAhmHKMdI?=
 =?us-ascii?Q?2ARCX+j8oE7zHnhuLOfM9yThm/2XLUs5G/DJeyhPpWfeHQMhMJSI6okJ3/pt?=
 =?us-ascii?Q?zLmC1pa5Ee5a+fgqQDg/qNNA8Jwf5TvVc44YUAlv0w8ti7lOjnv4EF7MfROP?=
 =?us-ascii?Q?z5Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tiA8oxlGf68JMn/cT4ef8+kUx8No+Nv7GoJah+LBq6r1Cn8gHi0onZA9Wz6O?=
 =?us-ascii?Q?hO25XDawHytJ4C58vxFbsQpOwoq5HJutQniGoBCZcxR7IwREVpEW5/JzbpAx?=
 =?us-ascii?Q?WjXQ2qEOSqQ7i59pXeHCvDoNMRvSBa3PyvDlJXLothlTMDbWJsKaRSWLSf1G?=
 =?us-ascii?Q?gmfuzXnN87HBRGIFvTQyKoNsErSfdVPJA9WYIHvbJDxihvZ/xlqdM9KNKsrO?=
 =?us-ascii?Q?10tv7JV3HZyY3Ix6aB/Lbqfl/OqoMNNDYVin3MgFkrVjRXYlkGovicmGQcFr?=
 =?us-ascii?Q?NPxwEmjgbwJTVPwkiAt97V8ijfFjYeSoXZ6oKzOvW40hQBOpNFvBujvXXQn3?=
 =?us-ascii?Q?SZf5dgrvfMrJHMwmDeY1QbRXf7AZ92TnNXqNvRvXZFu28+JiCud/0MhcYpni?=
 =?us-ascii?Q?ViCRHedM3uObb63/09K7xMqz5nh9gesqilTnDS94Zu0DoJWWEAe0h191rCJA?=
 =?us-ascii?Q?7SyAA8sxATJhfrCOgFR/LumU3y6FMgZpToc3tjm3dxcO8RK26arEOU48AmCP?=
 =?us-ascii?Q?XTuT1f70JBscGN5f1qzeeeXrwwK7oi7hJqt5Ovk6p1K4R03sOU6iJCAr0uTL?=
 =?us-ascii?Q?ieUu8jTPZxshyiOpHnn07UZ7Xut7g9jaMlIAfP7db5bMEnsUzT1mLQ11SsZy?=
 =?us-ascii?Q?UYnl4A8s5jq9xbe86UVSUE0D4+Om+8nBOZ0Ly7A+D5VepzQMkjDQsitd4S43?=
 =?us-ascii?Q?2IEuh5zFOlhT52SVnosWmwwpajlTxpOHR2Se2Hj/hM4EByyopl4OvhhR1vfr?=
 =?us-ascii?Q?eEGZeBvGj0hJVGeD+yHmnqWnV8Eys9736N9ojaqqBFJ9yb6IW/WMER0Gb/YN?=
 =?us-ascii?Q?B5O3X4OqEFNIgC+ZZrYvivdOwkfm5ZVvQq9uPGYEshp83KXPP7UP1Fvzihei?=
 =?us-ascii?Q?PQu7LXhY00DwBAKmhoq39g53dNepb550HQOW+qyfq+Yz3GlX6a9ReM7S9/GE?=
 =?us-ascii?Q?0rEsNXurn0Bm8g6So4kQMzIiw775ULvlWZwPyBS5Oc/nZdn8wGTtsCmslgpP?=
 =?us-ascii?Q?r3rf4KF9L4cJgPBEFG6oL7hedHGW570wkBU6jaUYdJTKIdpvLwGXet+Uatlf?=
 =?us-ascii?Q?twXOXL18RU6Oz9YVxfiwXxh01ayVi+I0w43/aE2nCorcyA1Aj/2b2SOIZ/45?=
 =?us-ascii?Q?bY5fwLwWLsNTDfIi14DxkCOD8yJkMQJIaK6NPpSX1OU/kmR7fVA6b2T1PvgA?=
 =?us-ascii?Q?rz4ON4LRcVeMLdgH55yK1NIbKpv0jgU5eqc0oKwkhRnNKBhPYusvD+TN0ZFJ?=
 =?us-ascii?Q?or62Rf/lEubMTHMGmBN6dg7QYfIpWH2O1jPQNAicqPPbQnnMrxpalYAc33iA?=
 =?us-ascii?Q?1yYU8BSE53OwORR6rMKxJycRjGsIoegA7iI+I0zoXcm6YXBUGl5lpcGuRUis?=
 =?us-ascii?Q?uW+CfkPuw5j49WtoG7QbbkZzoaCDognRUv+OoWmo9sJ6mUg+1awMFQBMht2J?=
 =?us-ascii?Q?/17vkxyrOmRuPO5bHoeQicV8xO1yPMSElA9fn2zUYJ7LxXshZakogCZX4nUa?=
 =?us-ascii?Q?k7Sqkzx8egl8cGKC9y7SMO0GEEIBfc+2C475JF/CVSJixETaHq51vcIvAwIO?=
 =?us-ascii?Q?FKaue7zrsPpxjvesw4gUt5lcoKiWammRvbGQCMnkFfqqvVS1wPYWK7H3q45s?=
 =?us-ascii?Q?lg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	E1pkXLPKfO4QPnloqh6sdCl51Fs1BmJazEo42rLt9j6MFwHnXJmJW7mbE50v4gjiPmCmWVze4zS/2ipkQHzVNVJzwA5sjkNWkvmobbngDclznk4qQvoFtFTNtI4As79A0h6E5VgUrcnOMB93mSXf1hds4K4v7s0LIpW5BlouUnH4eLHDjK3QTLkonSg4gAbXwXaCwQdyPqyVP6BzpDVsv5hQUNYQLlUScdPA1E1lR/mk005pzz8PIQScOR7vmI0OZSAtvYh+BrIi+qKB1iDPYTJH0VEZlDXuDdWxaKfQObdGSJy6UPtHaEvQUK4Jc78Ppg0zmKG8K9G8sdaLXaBjuNgGVy+TGf7AntADp6TWzGNThzl0gEva12yphlZsesf+IUL960Esr6pZ0ZvWFj7x/NaB0vxNduFim1Tc8TbU1VD4vg8pTxqz7bIpTUce0UMeJgDQxPN3VhhvhP+g7+4cmCNh7NQ2SEdaFj3ICFmkcdGuAdIb2amNU2ob0glGGn8Z6uBiK8jpoF9vWb+ipfJc24bApJ5STLiTmfKOYXLi5w4Q+vDR5tg01niuZ48XYe+JGnrOXnGZuf5kgpyLksWWIptFllH0PITom1UqnMJuriE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e737227f-01cd-41d9-8f9a-08dcafc4c02a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 11:51:15.3160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TA/V+jWv9rtnN95pYeSWGeXYIs00fQbyYBwg4ek0dBCVeHJQZnfGd/LKj7KFx4N+AVyEDCA1eN7xqKOSqQJeuqqY75z4svGhr0B5UFdPs1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4543
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_10,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407290080
X-Proofpoint-GUID: 9dpWkUMMmvC4vRGBV6y7baDGWsQaK3m3
X-Proofpoint-ORIG-GUID: 9dpWkUMMmvC4vRGBV6y7baDGWsQaK3m3

The vma files contain logic split from mmap.c for the most part and are all
relevant to VMA logic, so maintain the same reviewers for both.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 MAINTAINERS | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 42decde38320..d4cc9f832d49 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24383,6 +24383,19 @@ F:	include/uapi/linux/vsockmon.h
 F:	net/vmw_vsock/
 F:	tools/testing/vsock/
 
+VMA
+M:	Andrew Morton <akpm@linux-foundation.org>
+R:	Liam R. Howlett <Liam.Howlett@oracle.com>
+R:	Vlastimil Babka <vbabka@suse.cz>
+R:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
+L:	linux-mm@kvack.org
+S:	Maintained
+W:	https://www.linux-mm.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
+F:	mm/vma.c
+F:	mm/vma.h
+F:	mm/vma_internal.h
+
 VMALLOC
 M:	Andrew Morton <akpm@linux-foundation.org>
 R:	Uladzislau Rezki <urezki@gmail.com>
-- 
2.45.2


