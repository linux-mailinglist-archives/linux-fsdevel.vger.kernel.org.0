Return-Path: <linux-fsdevel+bounces-60187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F80B42886
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 20:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B1F1684A48
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 18:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306C0362081;
	Wed,  3 Sep 2025 18:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="krB/sn/0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vXSH8azg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFB42D77E7;
	Wed,  3 Sep 2025 18:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756923125; cv=fail; b=K3gNT8rlcsanrKYgbMzS49l0Vj+oUs9vWQBkobkHLVvELPi4uWzzpIaWnjxkHbyJaPWHIbESUbdC8Y23bTeFBS2NpNlMLBCx57fHn9IatY5sxhz3Ilb+ByQmKFcKgm2SCnFggHxFRv2qzXE5Nxpy5gp5aR4WSKxt6bEfXflD67Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756923125; c=relaxed/simple;
	bh=UEwD1ZWw56npkxhWFFkB8ej9LrTpkgfzalWbCuFDLaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dUyrhh8/IDRcdVGR/arXNAXIuoNA2Z1RpvAKZ+ua/OKLmzSFkCZ8Tas7mxpzMLsGDuDDZIKgQSm6mkHPnBOFlNURrFsek4I3AQtLCuBnOabuPGStJZX+XwGehn4iJZdvdIYm91PT8Ejb1LkVwkamY5Yp8mSC0tNRjAOjnSdZupc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=krB/sn/0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vXSH8azg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583I01BK029384;
	Wed, 3 Sep 2025 18:11:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=vJsAJdldDUc8pIypUi
	EYGTX3PnSRfOaVVusJSG9MNxM=; b=krB/sn/0/Cy2vsSb7yShBL6wpvloBiknwS
	sAQDgYpdfgK2pjlDFC4bXhbElXMndFcCJzkP03JhyH8n9s60OlWOqYy+aYMKrZtx
	3UjPgPtOflOypG371UtvRrXd7DDpS7hDEYuoxLec9zt4LOTYyLUuupo+Q+ip3tiE
	8yN/LRO897oRGPgTMdu0+l9gzzHV/lk48ba/fhg07V/SV5dSs7Qo6GikV00YkscI
	bB6691fOJlNqdmxA+EcAAdC52HnLwwmMQWq/XibscTu312CggR0BcP1t931gENof
	lNGgx4Hw6jr9okoLuJtjv7NyqYGPRShsKmrEItCe3BrFRz1Nt3xw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48xtjeg0xg-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Sep 2025 18:11:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 583H5VFO036265;
	Wed, 3 Sep 2025 18:00:34 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqramewb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Sep 2025 18:00:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PSbGa7t8H4KwYAUltaJiE/JleiuGDqJZ5OCbiaBCJqpLFU9RyAvMZvL7qEq+K8GhYTfnaeEJwpcc8hnJ0L+oClzvtb6jN3lmPvHIHdrgtEs6j0BL09lZhPlV/tKWdod7FJoYNp/YfyLOLLVrzYL2TppkokK+YWMg4yrhIMx4/ht+ib4NMXDAEGvz+VrJDlC0tT0YiDKW/iKj8L5E8I+mGNza62VjcZgozQqNdYJRSX1ElYeR3pKPT4vMm81Ajc5pfE5oQ57Ql8WclSjuGvjQwlc+k76qfLkyuFtnkmAqhYOYOyc7q0rYelYDwdSXhCnUF+9OfXzFJ1FTrjXYieKNkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJsAJdldDUc8pIypUiEYGTX3PnSRfOaVVusJSG9MNxM=;
 b=Ac8hwA3AlH172DgF3YuqdqkJ51eTWInmUD/mpRUw0X+LlWhWJ/HxLlRnlbn2SPH+1bMLhR3u9bJAL8WXfVut0gYZq7jKGS/fdQWfdDVtDuxN7jCJoGaTCg7TWOkukoJ7ZHG2gIVrXOkrd7JFi+UKT3K6D62KMRc5LiuPF0vyjkwY53SYZa0x5WEN3ZN2qTSF/KBZeWfMKcMB1/qtYrmVfnvwrU6+B1Z7YkYb89uV1iFkkN4JlIPC1pEvQTpHl0C89xHXllfdWJXC7PMs5F/m5YBgzNkIzpLA+jFGOGIPv6/fJy9oJLYo7e0hV62Jo1f6+BLcmvgayeM/BcLAVDbiYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJsAJdldDUc8pIypUiEYGTX3PnSRfOaVVusJSG9MNxM=;
 b=vXSH8azgmH9fKEfAO4XaGKcXdIn426CStPrbsw5d4MthGSOvDz0cT5s8tTxdiOAN/Fb9Ad3ZDGRIHteex7qsP/znDrcwbAM03SKnKmVhFoCPTFv4GKb3H07y07rfQNU8okknUNdRt+gJhV1Lhnb8/l+Q0Vhuh3yJAIMbdsCHuXw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA0PR10MB7326.namprd10.prod.outlook.com (2603:10b6:208:40d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 18:00:24 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.016; Wed, 3 Sep 2025
 18:00:24 +0000
Date: Wed, 3 Sep 2025 19:00:22 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: kernel test robot <lkp@intel.com>
Cc: Christian Brauner <christian@brauner.io>, oe-kbuild-all@lists.linux.dev,
        Andreas Gruenbacher <agruenba@redhat.com>, Jan Kara <jack@suse.com>,
        gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gfs2, udf: update to use mmap_prepare
Message-ID: <b0c0d2ae-615b-4991-844e-c000e6fae4a1@lucifer.local>
References: <20250902115341.292100-1-lorenzo.stoakes@oracle.com>
 <202509031109.QugeBzTq-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202509031109.QugeBzTq-lkp@intel.com>
X-ClientProxiedBy: LO2P265CA0336.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::36) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA0PR10MB7326:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d46d371-6945-4996-fe02-08ddeb13c1ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QWXk2v1TOOyZalfWVqMGm2HSRC3j+S1VdhmUjqv/RRUdruW5DgS+IQXg8H3R?=
 =?us-ascii?Q?68UQx1QSdLV2BSMMWjchdAI9D+u8mRIXI1gx8gBIhzhC5S2IgafKOz85ddg/?=
 =?us-ascii?Q?xWWd2Qya+67vVY2d9d1nKtGv8YmGQOBn+Yesc+TKaN9IxY3qFkQWZGP2gIff?=
 =?us-ascii?Q?S4B3pQVLqTfuHBh5e7/cr3bwlq4APff1q6Cl9LMrlsqyaTl+pQO8io7fD6c6?=
 =?us-ascii?Q?8IKFgLhpycgjHmcDIsoao5i1t0gnZ1DZ6yaZUtkiUYkmIkLXAYrOcAI9wqLF?=
 =?us-ascii?Q?6I1NjnqMCptT36d26m+ZJ6JGz84h9AlHiXQmwq57ar/P6Im4Sdni84gTozsf?=
 =?us-ascii?Q?PMVqI4zUdvxB9ftvngoCQpzqYbX+6ZXkI2JY4yAuGgznjHJdRpheoz++NviS?=
 =?us-ascii?Q?eQ5MBH8TfQregSGnvB2HbtJsl8ccojnSytljPKZr3AVWu6XIhr1esRYdwmKo?=
 =?us-ascii?Q?B8LcmD5GpjRjxw39xkxhGAwWbKCRKEO6kwrDrQZAk5Iala4f93VPthmTmkYj?=
 =?us-ascii?Q?9lrxomNT6CRt42es3tMFDCiekjIUtmzPyVkMO2z5YlKOyI+qGX2HDhTkA/Vz?=
 =?us-ascii?Q?1LbtMqkprhDODq9PM4Iw7EiIWAzS8qh5e8AxPl7YJ9psW9yiNjnlyLeCiNGe?=
 =?us-ascii?Q?Qe+ZR0IOHdYeJJcfLp0HRnat2LcaM+ahADnwScetf8vvMFdWVZiyhrr22pkG?=
 =?us-ascii?Q?O0quEp4Qj1jFWYVr73EjuMrrkUObvJRHCXkTjavtADuE6vlZC/K38ErkHpHC?=
 =?us-ascii?Q?hghXaXDTcdWiTj1rLvPM+BubLvzDHN480TJcnlSo/quH0sU8PC1nKqMAGz+u?=
 =?us-ascii?Q?EwSM1GIF3BpvyWYfUWAenhiy3sztjt7ergxe1uLNysjShBJ3UYuT11l8bXNb?=
 =?us-ascii?Q?hozypt2ZOiAvWZQ373SFfeUBxdPH9xNkMgh1OmR9UETNmt0bA01Y58rDVt5p?=
 =?us-ascii?Q?pDB+VFywiY+CRJ7Imkg3L0GgkW5p+b0hUIrVCaaCgx242h5aArjvePcFF9NK?=
 =?us-ascii?Q?Ya23hJJqamVQ8mBKV8Z+Tqk8mhm2kK/+341pLY+yK+mik31KBqhz6ywSOh/g?=
 =?us-ascii?Q?Jpv7ZWmAFmf1ooftVyZmj9IPf5GCGb44zop6Srl31C1oBYQRHjbsBhIaVhym?=
 =?us-ascii?Q?fSjGLPOZDR9vl4LadT/F5w7/A7f701SCLSoWW5HAQBevR315eKfgOXSqSY4K?=
 =?us-ascii?Q?5TIMHpYtdZ0Nd1HRpeIhSd0VbAWqJ3MBV9mwnIee0SkyXBLnHZRiyhkhYobx?=
 =?us-ascii?Q?Y2O3Rr4DqjQXnGSsofxzMQYvusfMLBvfE2HQjtwXW3R6rtCZMfk7PbUCgK3v?=
 =?us-ascii?Q?hlchSmt/tSQxtzBQM9cAvNWuUq7bp2VlzueKTNnYnATLGXf7Cg3dWpgr8SIE?=
 =?us-ascii?Q?cidhUm6r25zod8dRoYM8/8V7Pn2S?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qta1d763BT4eUnwFg+SxYAYGtx57xXGxDnfEXGYT+2aHPI2teDFJXbcI/YC6?=
 =?us-ascii?Q?TjfV8/kKUfeSPhthCCZNPjRHkOcQTvuIWQXQR5M1Mg8C+0lCOjUyf2yU/Qth?=
 =?us-ascii?Q?eC7aL7ZVPFHtSMFH37rHwvjfQVKHxdnG8ZGnOxmQcnujmslTUgVPk2AHYbnL?=
 =?us-ascii?Q?EX6cs7UfaNcceChH1Ph65u8Smat2ARwQ9ZwYiWq+q8moa4u5bZYztq0Q95sl?=
 =?us-ascii?Q?56F0ykzxv68TUBag9oLywE+2Y+pe67gJQNkCF2lwOS9l/zan1zqSyeB3RbDj?=
 =?us-ascii?Q?my0Jex6PwGJBhq3d6qhhftyVU7TnlWXNPOMtiUeNFAuUEsseNlI/QB7pZXoi?=
 =?us-ascii?Q?ssWgPVeqccHTke3ZEbCdMJA0rbg1Q4D8QnJJmZq2GKUPaDcndUmUqRqki/R/?=
 =?us-ascii?Q?9XYxdQfsMagwS69ahxFKCwecxwPAORhuIwzHGZ/PetoYcGDzC7PpQIXdNsc1?=
 =?us-ascii?Q?RfYdBFF3YduZvV8ojJQsVW+nJzPNjpXykX9QGzvaTPWHXyQ4eCYzjOiyiPpx?=
 =?us-ascii?Q?0KwJmyX3lGLQjK49V8cffvF5kljm2T1r3ExCSR4ShIuctBqTwXxDbNmL/S1d?=
 =?us-ascii?Q?TO59hrxcD6GEVhYPc/hkODhZUHZEKePI39ZqLTnmX87CKR1h7SgEvEHl4yFz?=
 =?us-ascii?Q?4E2vEIfMJ6cNROXWKtzIsYMkiG6ASjzuphrS6axshecHTgYFPEIPON4RDF82?=
 =?us-ascii?Q?AFFT0knY6NL2PcXY/wS5DYh3Wndm7I4Jwrr4aQnaVcrFYyOqf+U+30e7WL2q?=
 =?us-ascii?Q?9LWBIgFza9p/oIlQpshnK1TzA76cSmqFj8Izdgvq2yF3sqCa6PAN/pPbd/95?=
 =?us-ascii?Q?LNmuoq+5+a7Fgk0TbYTLFQruwemX+gUgOnKuvAkJSbYtAeXhQCFYgMfHISIO?=
 =?us-ascii?Q?VNABXm5WqtVrOTKXDbEl38vF7gCR1lKzwlwTE4hvGeoVKRV/RJCu3OV8Kmd6?=
 =?us-ascii?Q?OAktbuqKv8hvQzVSHfZvcw1PRR8qSykvoY82/Wx0oGQ4UvmG7PGq+VhgYiDB?=
 =?us-ascii?Q?6wwL4zylztOjl4mQ4y+DjJFuCSqZ1cxBlG8wsRyuj5MOBH45mIE5gfJt4sFo?=
 =?us-ascii?Q?m7coZf6kNC2TTo6G93XXOwCgOhy2FmOi+wlkZJ6AP2dbBXtInn9ZiqMUYXUO?=
 =?us-ascii?Q?uNoAWfTpuhguMarl/bOwCJUuFimcvLQyC/jI4c/VhCgfLr+/hIZFyKtSDw81?=
 =?us-ascii?Q?QsN2p02pNKyfzGYmbzUQXECtm8ci9C2+8NN44M/w2Boh4cKZD2lLaW2+kZFz?=
 =?us-ascii?Q?FajfWm0XIEhU0/rW2BTgTMKr2X5n7QpBq95FxJY/AZR8munk+vl1YmaSdOoQ?=
 =?us-ascii?Q?64mi4rSWcc6xX3mab1TFuqPw5BGIX4+PboAClBGG3jXE6PXjFnBhr2ftTv1Y?=
 =?us-ascii?Q?ZNt9hCL+rvpGLif0ZNe1c68yrp0FXWmck06YXB9ipLMrSxTF1bqjQvaX6mEw?=
 =?us-ascii?Q?r/Is5beelPP8I/pv24oxjz7Gw8hVxlv4sMZ18KsP8QDW38Blhc+kSaF75JQc?=
 =?us-ascii?Q?29gPPHMBEjhuoIXZ/fapH5Vlo1B+Cb+WlbGppRHMV0fuOnCwls+9SttKYwPh?=
 =?us-ascii?Q?2Mj6gp4DInk1aecnSqPlJzglzK4JiXyx7XAtTPLF7pcz3NZDVlW6K9aHT8ZT?=
 =?us-ascii?Q?jw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	su5/Qzs5qFVhM4nBAr3ngsu3qxo6Kdhxuu02XrgRTWfVz3ED8vZ0LR0etpqFzF5fG9rLzrSwG/tFB8HYEMDVdmW5HWVUjz2a+pQqFMaBOXyVe42V1XggHERjFDS/jmonSolyOSrQwieEqL0nQKzFXSFVyorkfIYF0MDMnkPYPJISZPvdm+HO4kHuZKo4WSpHBGTU4GwdicmycHOSlX1mXAc84WlE3+p+X6lt72bV40i04htTQPVlZviEIabtIfvpmUOJnqpTaXvG+2VS+6NgGxvvKuKoDpv7gBYRdOROG/oyflseUAyUo+h4lHexHlzT8dpz9mQGVmK2ffhfHmdOK1OIFwHPx6m/QAk7A89Zxyr/XAiFQ/Kk7cBXUDkvDWvAsPqb8aUYudwcbOg20f+CnUHmRagHe2ioM4zzi4asIsS48sMW0XeygHpUSztzZKG6ygxhirwON2Px20hiUGAQEHjUdIAF9XLn4afooQjLEEXmnmhSvZFVpH8sU2SU8yT8glcZrTA1DnMkLjnY9AIOv5BRyOdG3BAAqXbBYIEmiHxY201bTDsjse1PZHbJia4MS8G0YLkoOH25MZEqC6bnCZkO5ToUYTKAQSh68NnCs+c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d46d371-6945-4996-fe02-08ddeb13c1ff
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 18:00:24.8816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7eGGmIpQI435EK4W9b2+fvIQDXEX4daojXp3QEQ8jaoagpnyfVDsb8lY2/mD/P06tKRqGN1onFEr5KXFFcZ12WIzxmDHEpVYvSTCb0VwR2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7326
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_09,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509030180
X-Proofpoint-ORIG-GUID: jPz1rfBH8k2owH4ueYU2731-ZkB4vyFE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDE4MSBTYWx0ZWRfX3no8pGeXq8y3
 7cT6vZtuXfDKWIe1ozTXD+N0/3dUC6U9XZEnrXABpsQeHGUoT+6n4cnZO60OC5Nr0r4Q8ymNX+X
 01dZRgSzhT2s2Z/zB+L5YD+zohW/V/SOcObFfF72kxzz5USfjW7DG6PJIB3eHGShMmRC9n4AQ/R
 QC9wQYmscD0gZTfU6nFDKuaLgnZ5QiS3bNZyDngNkmPBJb3SQwsicjr6mIpLbr2KVNNPfW5Sc8l
 1g0XSaNl2UlcSBSf0/5T7DV95AR05m6cLcdXMd/IcGuRYLWNIjj+YzF2pqmC2IARvpzceglIhMk
 zBEfdgdM+3dJa655qrLD5YiZbs0qtFefFpvzkwWWvAt3q82RxWgjYzYcC7kF+DfSPR+Cv2yPoPA
 +vJZdSEO
X-Authority-Analysis: v=2.4 cv=NYLm13D4 c=1 sm=1 tr=0 ts=68b884ec b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=anyJmfQTAAAA:8 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=i3X5FwGiAAAA:8 a=QyXUC8HyAAAA:8
 a=I9TJKNqSxyxf3YJhUcQA:9 a=CjuIK1q_8ugA:10 a=mmqRlSCDY2ywfjPLJ4af:22
X-Proofpoint-GUID: jPz1rfBH8k2owH4ueYU2731-ZkB4vyFE

On Wed, Sep 03, 2025 at 11:43:13AM +0800, kernel test robot wrote:
> Hi Lorenzo,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on brauner-vfs/vfs.all]
> [also build test WARNING on gfs2/for-next linus/master v6.17-rc4 next-20250902]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Stoakes/gfs2-udf-update-to-use-mmap_prepare/20250902-200024
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
> patch link:    https://lore.kernel.org/r/20250902115341.292100-1-lorenzo.stoakes%40oracle.com
> patch subject: [PATCH] gfs2, udf: update to use mmap_prepare
> config: x86_64-randconfig-004-20250903 (https://download.01.org/0day-ci/archive/20250903/202509031109.QugeBzTq-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250903/202509031109.QugeBzTq-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202509031109.QugeBzTq-lkp@intel.com/
>
> All warnings (new ones prefixed by >>):
>
> >> Warning: fs/gfs2/file.c:591 function parameter 'desc' not described in 'gfs2_mmap_prepare'

Fixing in respin.

>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

