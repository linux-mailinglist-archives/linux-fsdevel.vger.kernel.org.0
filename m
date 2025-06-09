Return-Path: <linux-fsdevel+bounces-51050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA668AD23B9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 18:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F34883AE66C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 16:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA5221B9CD;
	Mon,  9 Jun 2025 16:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C6uKmcR1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wrnrRBrm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DBA21B182;
	Mon,  9 Jun 2025 16:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749486158; cv=fail; b=hYmmO7aARvWmdMaFmFKSLREUzewaZgWjD8dW+nWsbOZZea3ZKCGrL5YFt8za5HOes2U5VRDfo3DI3ZjLfxCpLDezl2plG+lZ2VwbOzLr/UKHtjg+IMJyKkp0GN8LPDzUAQWLqTY2G9ULklNfkx2E8N/tfM830FU7d6JfNLQLei0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749486158; c=relaxed/simple;
	bh=5MYjXQZ/cyyl6yOpmV4uzQVdZL/UpjF0HWoYsY/9SsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CoS774zpsuJVXUfIMOZwFnACpWl6D95F1U1etajoKcVRbm+GzQkXvUQfnjRAw3ByXZ6dPvPpXmAn9EXPd+1A/iV29nwEsBDdO/5A9UlzBzcLw77Z/goNZIUQPT+Aj4rk9QvHxFwAUAxYsu9aIhJasKzPgo7ku5gynIJ72oFd63Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C6uKmcR1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wrnrRBrm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 559FdjZU030905;
	Mon, 9 Jun 2025 16:22:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Gb6j/adAPjUlxwtfIh
	TySwfENRzz64ur1rTlQpFmUh4=; b=C6uKmcR1TsAW7XnlMxgu3nqKQVqvZw48f8
	Mel+PNa2yxsy3gfgd3Cb2HwU0zDqh6Ky/ah0aY/nbX8b4v9SzfYTEPrieNXUccal
	QoMjY93+x/jWo3ZHEzS+wsqHOdeBVbeKLdcysNcyuiN60Chfl4hW7bS79+IzjbWP
	/YxuJylFo5XPszKKVDaVnmFbXccv2KY89QVAYgXu0LvwXjY0OoXjbn+C0wSTl+xr
	P95y88T7jAx4H+N6MbumdG+DEs6lVa0VCU2eXBqCcneP7aDuaosecG2Y6rv6G3Dc
	/x49MpAkDXABZPnKay/YUoRmHMIzHwHKjsDlWI4U0G/Rq3muPp7g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474d1v2gs6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Jun 2025 16:22:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 559Fn9CE031941;
	Mon, 9 Jun 2025 16:22:19 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04on2073.outbound.protection.outlook.com [40.107.101.73])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bv7mwah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Jun 2025 16:22:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=logAAPGj3iIf5F0PPxkGX8UTQFZoEjCAFXN9Qvs9J7T3GhKA+3H1QRc/Kyvgqw5uOPl1PvdIWwDcU0hbKl9NUxLzWGY2cC3HVd0famTDePtVzARMLDlZ+vkOm81wpAC7THfLfa1R64EjlEXxZpznhVpDSZ6i6o0qRmINQqi3qd4fVIgmKBZED9M8m0HRAMK7X2Mu1auuG5Kld39sLDd7rVUlV1xxwbce9zNZlCw+eDnqWvpMbBkBIuruXL2GrrzW3RAMVEQHt6+tqyJbzfZJeor3mZ8ZdQFTVz/SGq2GM0EezMhXruuIyINuAP9H8R8l5cMMmsfSUc/cyNLLq6lsLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gb6j/adAPjUlxwtfIhTySwfENRzz64ur1rTlQpFmUh4=;
 b=gvMYrjkf97CUx87ovXxeifGWtWKNXE9MdVqM5jD0EoTOVbVYUJLCzC962hggjCiCVejUqsWD+eV6ZkZJqNY0JN8L2epW2wkdHslLBcZOluKXQ6H8PRFEXGCB41zkZ5GdXoz3rS2WFTFhIF82C/lwrmrlbYTRonlp3ANVgWXapDN8nBtZdM9e3UJGNJ0kHWVrEsKvkWwtZh2mCzcKZzGkIKD+wIF1J56AY3qzjfbw1gem2QfYAjWEoSxP8xexcyGSHeN6/OBtqhNdvlfkgo2zrY08MUrGDDDzIo5ClxSQjSxlltuMJ8ES2xlM4ckeTvcDdlpTLnLX2ezFmAQ/Kk/0PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gb6j/adAPjUlxwtfIhTySwfENRzz64ur1rTlQpFmUh4=;
 b=wrnrRBrmnJ2xjh04NOH7tz/i2hHdzwSkbyAGu5jugCRFx/SKU8d8fQpuDKbmMlOQW0hK3MAj8BxvafMr9h938p6KY/QtAreJ4KXVUoOKQaS07dDLyMzuiXswKx87xXoqemWrfGeN8SHBFdnOqK8iidXjjVsAfE2N8gWUWtPIstY=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by SJ0PR10MB4656.namprd10.prod.outlook.com (2603:10b6:a03:2d1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.27; Mon, 9 Jun
 2025 16:22:16 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%4]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 16:22:16 +0000
Date: Mon, 9 Jun 2025 17:22:14 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: kernel test robot <lkp@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: add mmap_prepare() compatibility layer for nested
 file systems
Message-ID: <cd7e57a3-bcf9-4747-9a8a-4053af663785@lucifer.local>
References: <20250609092413.45435-1-lorenzo.stoakes@oracle.com>
 <202506100000.34KZcoZ5-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202506100000.34KZcoZ5-lkp@intel.com>
X-ClientProxiedBy: LO4P123CA0196.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::21) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|SJ0PR10MB4656:EE_
X-MS-Office365-Filtering-Correlation-Id: 7413ce7e-a130-4b80-3ab5-08dda771ccb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N6zecW1B93n6DwHbE5nEqwynhPNJkbC9txWgYnvULhal3h33tSYSHj3uT7ks?=
 =?us-ascii?Q?sQxg035yuq+97Th6aUlG2Pn8HUfxeeKeuhtv7u/Rc4fkrjnKC2Rqw1yiT0Kx?=
 =?us-ascii?Q?ybliwbcVY4Xe7uvDsYmVMuQgbsOjHPaJSF02A/Uw5cocF8wzl4IpAEFayjnE?=
 =?us-ascii?Q?3Ee+Yk18SFJQ7L3W4DgArSr/wIhJA3KYmGcZSyyquLnYtRkAzawetilW960a?=
 =?us-ascii?Q?MJzdsP4hSb5u8OeAcnE44q4LwQNd9Fek5L9ibeGeJHdk6UpZpVskPhKOmIFY?=
 =?us-ascii?Q?1oPwnfcDfyv+h7JkK160cAQ/j2aw31sJqYU3cGe1gT8G93TODrWQz7mEOY6n?=
 =?us-ascii?Q?B2YeIt2F50ZgWwGAE/VtIfjIfe/A+QLH8VyMRqkeOr/nuutMCgGK7d9VmAH/?=
 =?us-ascii?Q?k3mGnuhsWAPbgC6qTTxVr55vjXXzthFkoKfBhdNHxw/2VnuaVddMUikSLEgr?=
 =?us-ascii?Q?e+GnSOqJbonHtNDLc1Ff3ehdRfpclO0EeFzBtynvn7N0pMsecWDqI325YLpO?=
 =?us-ascii?Q?u6Ry6ASbT7wf7WnWYK1G5jn2r+HkCGnFP4YISypfkUq6Ib8GYGTsaa5wcF9b?=
 =?us-ascii?Q?Xk5sTraYl5Jws3/xoG4bXuYzF+EFdZm2kkvYivPHEc7XFtLsRAc1wpEnSfXp?=
 =?us-ascii?Q?fJKtmqOmytChdGQJTzgtLyxXcye930UT4+V5t0c2O251ky4WWyKAjBYsTVBB?=
 =?us-ascii?Q?jkC5BUUhNfVE+jPY1yxYtq3FMegyL7HvC+bQrCT/GbPvmAmPdNWmvBfQpvVG?=
 =?us-ascii?Q?FcaVfmtqJNsnZLQe0qJumPvqQ8STz3kJswMgts7aCEK3PaHqF+pXkjOpfOyA?=
 =?us-ascii?Q?Tp3ZBGu4SJKbOxMKfQKHcYIiEQmb6UJhSlPTjbRBjuchdJm/mqrW+hljMrhy?=
 =?us-ascii?Q?C7MSXAtabfDRyak775v8z8BWDsywp0dCKutV51qpauzt0lfv2JZvMDOICzhs?=
 =?us-ascii?Q?VxjY/lSqlRVInr3oomTPHZ565IQqn40Yv7nR1fkR2M59Qo03T5Ahz84U7nGF?=
 =?us-ascii?Q?nGmNCo+cuAILDOt8OfZ38hATTazFd2jDXpZhm2cw56C1CxqguVrPRyfI8T2A?=
 =?us-ascii?Q?UZs+y+mu4WVQVFykZlwD6pAp6DSaXuO2enVPRSFGHK2WYn+t8y1KmbG+cknC?=
 =?us-ascii?Q?Bq0gu+6vQbGHTmz85GDithra1A4T06ANz7IWn2OvbifA8EroEyqUZXGHZ+6c?=
 =?us-ascii?Q?1Rp/w0T7rB+83bgHy2GXc0A1H1naElIP68sKiLSYw5sxAa3uiDeNrt8LyThN?=
 =?us-ascii?Q?nR5SQx8zRxcKhllt3umHu/RyFHgEZhK3YBd+FXLu6H5xk30pwLRM5r9xAq6m?=
 =?us-ascii?Q?2ioLMpZve64jl2Qsqjz3lRKCb3HRkhdRsEZLN0NGn13eNYAs6ESnHPrGN8CW?=
 =?us-ascii?Q?Em6LrL2x/8Ga+W7ic/ZezkC/u/w8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8PCS1TrwfA/pdRp5vxn3arbho47M08IjmdyXJiCtjYBKyjbhKIVORUQViDeP?=
 =?us-ascii?Q?TSlDkxQdnj/2NNQH0NTS4F8G/8beumalQVYEcD1pT7bFf8hH/kEoGnqVLxvW?=
 =?us-ascii?Q?J9azdM+ZgFRl3thHkUNosl/+vsuL6/dRI5mcalrRVqqe9OjdeJm15ci31r9v?=
 =?us-ascii?Q?ayPi+XjXGS4rtpC1P5T3+gnRnJXzhMQi2uPBdJN0PHVQ4PtSTdw1/fgyeyG4?=
 =?us-ascii?Q?ajpB+nawtsbNrRaOPiaK3a4/dB9WC9/9ADuPeIEk8aM+Z4v/R9s6qinr6Bnh?=
 =?us-ascii?Q?3gxWcm1FLuP30Afv8w75SPuNc6cvyK50XAkI7QAUIlYpJe8X1lojTsyarDw8?=
 =?us-ascii?Q?wFG0cdnWOG1nb4vEO8lo9GeJaEUKaIIFg5dZJ1abLxAZUoicZb2Qke9aKt1n?=
 =?us-ascii?Q?6I97TgrdMXKe6kMPmb8WVuGlvoWS+ecFxoCYS8QbcvTQUmOpmlGFcDLUPjRC?=
 =?us-ascii?Q?BRurHHKzevfoeUa7vk7fyVWTrkRuCCx2iRZTd6jwSY0L+/s/sHSRJSHQ3IYq?=
 =?us-ascii?Q?Ww88Fd9f4BbDSPc6QaLRetZN8V4HHNDty/guz7fXR+xgIZoFJLgjqgwoUbVO?=
 =?us-ascii?Q?J3A1AoOKVteAGLtzZ2H6XNP90/rjuYkKd/+AgCbFtxukOeVvQRS2oc0TH1LU?=
 =?us-ascii?Q?CZAq2nEdqjYBlCIzZTJ/Y5PwikpNegw/8qb9CCpT8ymrRsRVFh+a8h6h9Ytg?=
 =?us-ascii?Q?dEFsEf8sJpEgq4GCvoVcFTPTGPh2Iawnqc2X6/p/NsC7Wt+j1ph1exfFFJ4M?=
 =?us-ascii?Q?n0/8cx+T5tAE+XCQaGERsZcUjKgXHo8mCc8Oya8Vka3CWnVak/NVElWYE3y7?=
 =?us-ascii?Q?GGRxp+/o8TqXxpgBAqDKJ7k3t9bwgYCxVK0CHDvqQil10G+jcxxLvsRV3zJI?=
 =?us-ascii?Q?DXEBzO2gmH1dknPVfj8UcNMV1Ed8Z+9YUqD9FPK4B5WLoa7Wo/p9RcQnvT6Q?=
 =?us-ascii?Q?IxomJ0YpSrd8gNPNeTcSNsxjnCBXwCSJQqA3moowtWuwzfrWLruVHHaHZvkz?=
 =?us-ascii?Q?tf8CVWLUQuA3HcgDjFh9tj+PvJya6BiVgrJiLlGtpym7liDGguCqL5f8dbwv?=
 =?us-ascii?Q?rMymtJMYTOStmKHkzUOx5PkA9LGk2utbLjIKA40jur2eNn55Ey5SqdSyQsc1?=
 =?us-ascii?Q?WcXOLzvYAE5evs32bI9nXtdVlpHJgOu1LKdtjgpnHiKCMwMTIimBwXMObJwY?=
 =?us-ascii?Q?8ulf7M/R+ECVpA23BjTSC5K9LO1AG5jXbU2tIBRkF+B/ghitvHnF67tbhJ7z?=
 =?us-ascii?Q?fSJzk1rL9YmH259bzCumcWb3u4EG1L5KmaVjUSq7BAAY3VsrC829p0BK3PQK?=
 =?us-ascii?Q?ZPtoKzlAH7uQO2VvM3kdl90U7wRdv9wEUhxIXPffv5a3shMXPkNWIeCiSGT3?=
 =?us-ascii?Q?F1rbTybrqP8lozwIKC4AgDJ6ExAKAtVFke92yhPU8bi7RadP9P5vWNhHN9qQ?=
 =?us-ascii?Q?piqaKO9/3tIGXrcVnsXTPQXDJRxzdK7HcnUGvT9wwXM8FfSFtxQfEs4IlNs9?=
 =?us-ascii?Q?Ah9ceul99CR5MhPOHYGRnPxBBfWWX7Npb0NLbSrSpgvMzt0mMC8iYUH1HL0S?=
 =?us-ascii?Q?JBN2sK3/jgOKcjxBulWcglAdjz7XnJNiM3pEiXylAatOHZ6Alr7Rrf12qA5u?=
 =?us-ascii?Q?1w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	luZGHqJmX/2hCes+edEMeTE4qJ7TYtvIBXpn8equLhLybh9TZfapeDm9b3SDCJ3tsiYsEEb7MT7ptiG84DlD0g+tqj7k4bpJS+Pb8HT6t4zAuq8XXNlJU/skoe7MVJ+/vOq4ezEoDeJTFJ2A49+uMA9cGYKyAUbZWMiUDjeSZquM9/aSUjwUzNpycbW0jrxi3BjiWWSCl6OpGFL51BWsTQy9omvQOmvhOGF3pdMbql5il+DkoswdjeJaYwDJs7dtWvKaT7JtnMBcvMQE5akyXsgEcRcUqNZuxnXO9nQbdCYkRTReoMvN/0FVT+pEilxpsWRHS97y6wA9KoZ36v+lUH80uK78b8LpL2+jGHh6H6v384T174TrVZcE+nvAoTZYDr+Ug4jrc8xODb3r2Z67Y45ftL5bL9+j3Z9NHe7mzZDJZ7WNGmui+sH5m1U9ZiDbqmQdg1mTVPISk5Yhi6XZHyVMIwZ6ULgaRbhqSleo6+gvEkQ4IVLCKesU9hPURvef1mVFmoNA+Z567a+gRhWBrDTa85E/5RTBsE6nUBBgCuB4WY6V6oeq9BmpYwVsoCfWvIEaI347f2mKiiXVRjOQ5yvOJ9alvzGmeCDCZv55QCQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7413ce7e-a130-4b80-3ab5-08dda771ccb2
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 16:22:16.4511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lu2SO22gUw70swzAXodFJ6H+mO0H3ZcAn45TifkesoJbONZX5K13QLRve/X2iT4OPDBk/8nvEsPRkgF3zSLmlvfK07dsvo5wWUuVsW+i0N0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4656
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_06,2025-06-09_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506090121
X-Proofpoint-GUID: gEm_JMFXcY0_vOVU09exM1FwAMxmSke6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDEyMSBTYWx0ZWRfXzuMU/sUIietO 9Pwg65iaM1Qw9UnToc14Fva+0BAzPWLzr00JqA7ZYQXabrHDB7RVCE69nP61rVPH5Hxu1oqD/B2 9p1UH7TUgic8TtEJOCj588GucGGSJhB/eFjyPKQv1SCUp40dY0UmECctdQEOWAzVEHcW+bYXths
 U5y2gq4Q+v7/4pgKFQlouSLfMTpK7PcVHlLFlJHo+oJGBdDfErujLQABVNQ2GbzrXCmkUfmI06u 2hKScz7ThtbjJUZqy33cYsBIdXWg8v6MOK9y4FpEYTN2f3T1AzzQaR8I0gKxvjHOCjoGb4nUGS9 sMsNnv+49W5LZUI6PnDtMUYb6CVEXRruk/rZ65IF3SBSrLwemDHmkZztpnJW5H0cz1ddCEGiPjC
 BCP3XAqvlejjb6OPIJcNr9px9cObr6ZHDKy5iR04vqL2WCN9+KdQIzSSTgpXgwva0eqeUCyy
X-Proofpoint-ORIG-GUID: gEm_JMFXcY0_vOVU09exM1FwAMxmSke6
X-Authority-Analysis: v=2.4 cv=d731yQjE c=1 sm=1 tr=0 ts=68470a3c cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=i3X5FwGiAAAA:8 a=QyXUC8HyAAAA:8 a=7-DAgsRmBGs_Ql8JzX0A:9 a=CjuIK1q_8ugA:10
 a=mmqRlSCDY2ywfjPLJ4af:22

On Tue, Jun 10, 2025 at 12:13:08AM +0800, kernel test robot wrote:
> Hi Lorenzo,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on akpm-mm/mm-everything]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Stoakes/mm-add-mmap_prepare-compatibility-layer-for-nested-file-systems/20250609-172628
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20250609092413.45435-1-lorenzo.stoakes%40oracle.com
> patch subject: [PATCH] mm: add mmap_prepare() compatibility layer for nested file systems
> config: arm-randconfig-002-20250609 (https://download.01.org/0day-ci/archive/20250610/202506100000.34KZcoZ5-lkp@intel.com/config)
> compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250610/202506100000.34KZcoZ5-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202506100000.34KZcoZ5-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
> >> ld.lld: error: undefined symbol: compat_vma_mmap_prepare
>    >>> referenced by shm.c
>    >>>               ipc/shm.o:(shm_mmap) in archive vmlinux.a
>    >>> referenced by backing-file.c
>    >>>               fs/backing-file.o:(backing_file_mmap) in archive vmlinux.a
>    >>> referenced by nommu.c
>    >>>               mm/nommu.o:(do_mmap) in archive vmlinux.a
>    >>> referenced 2 more times

Yeah of course yet again it's nommu doing what it always does - causing
maintenance pain for little to no apparent benefit.

I'll send a fix-patch.

>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

