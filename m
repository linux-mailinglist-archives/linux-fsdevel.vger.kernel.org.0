Return-Path: <linux-fsdevel+bounces-17650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C218B0DBD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 17:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 448101C23C42
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 15:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DD915F3EB;
	Wed, 24 Apr 2024 15:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CNCykKar";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Bf1M74cd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC6315EFCF;
	Wed, 24 Apr 2024 15:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713971785; cv=fail; b=cY3JF0t+TOXCB68Ll9jx8a6AFPQhwNe/865nCjUud+X6+21VQ2yB/d7insrqRF+A8vevgwlAEoeBaoHQZX9rQ242f1bOg8iDtOyWBCrghQeNkYGuvlXDg1c/8LcnSHuv9gOWXL0Oj6178JAT3/McDr/8JJqw1+zlkVgK4u1ORn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713971785; c=relaxed/simple;
	bh=KcU6N9eklL1BLgQrBwJ8F5t0cmpIZXjdwviUBHs+0mY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HymHmHfFj/KD/et2YyQy4VAu0bM9K71ZxDXxHvUyvFCPc2ni7Fl5ViW2d1kKL+X5Hi4jrHaJoLkIsdTsw+G7z4uhdLdisnTV2SWkZt+A/AqpRu5WfgaYtE0ynz4w0NjxZvlGqZCi/S5vFy4RtAFqdDsEqlw1KQ1yJ1uiuFWolBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CNCykKar; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Bf1M74cd; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43OF9rnc010172;
	Wed, 24 Apr 2024 15:16:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=jK4YXsVF49Kdn3zxQWKAKgCSNog8wnl3y4Knbv45xpo=;
 b=CNCykKarKnUawBPUeq+i4cQ5F6dO8jH8iGuT33IWTEIX0v772XsiKjVdyNgkFsDgrwjf
 pKlFbrq8Y8vDBa768fSmTtbp/lcosR+nZ7akHI10tUcyB4ngVMnhM5FstIBxud3vFPoZ
 Yx+0/AKa25CoBgmASPOcr4cW60ISMtcApUu60w8Lcr6qO9ZZUBvZ94prDD89hSZbsEHj
 phnkJxCxPNOFTfRBg4qRe0QbCFCYwWqpmSrWLMF+S/Y9qGV8V5ERiGkIstEZw0Pwn5XH
 hhJfvcLUbu5BBGnhrDvP6L1fpuFMPPq6MMlTcbPoY/w0oJqNjjdR87hlUMJFysm0j48P UA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm68vgw7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 15:16:07 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43OEx1pr001912;
	Wed, 24 Apr 2024 15:16:06 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm459jj9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 15:16:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibTWnNjcYXL1VsHmgYBvAw6ecKk+jh1/ed3okKH3y5mGNwFZzgr7PvpGWQb+uN9WV0K5OvOrstsFYbH4akuNsbtlR4/ny8OBK30zFEGUUfUy/PweiFGIXhHJmxDRF/R/EhYcwJmrHpJf8eLnvvE8iY88z4cVDDzLLgN+2KZdo8TDdoQoLoIxTmvVIK6u7WAplpgL1scprrwG4yBhE/CNG8s2q1WSbdLyo25xzbF83M88XGkxnp6R9ajZotSYcBT59Rt6JT4UaLRqpCQJPS4AATLuS+d9TEMUTqm69nkAdA6NqToC+1B9fnCoHOyEZRywwQem3NIgu4UZrFSCr9PMnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jK4YXsVF49Kdn3zxQWKAKgCSNog8wnl3y4Knbv45xpo=;
 b=naYJ0NOeo+eLNzPw1UYBrozxsmBTobZoYIGcjkMA2KFky+D8RoDo6+3fmd3LE1BIthe/LUY1sb/EulIFq+uJSEfDw781oEZB0byUcCezM+zZcXizEu79DQ6o7JAwtFuVkXzjkmxnEL+hBEuGOIRI/GOS/YzJOnFYvgxwjUWzquIUDslPsXjWo12X4PZUHssiD1UI7euSjT7boeezA1MPPipZ+SnXyYhNOfQSCTh5I83numDFURQzFS3VOQz9xLpo/OkhlzNB2nDcqgbpazrKCjGe1kxsDDgatAhdCOPtdZdPprZXLvsLL5r73O8zdlDf4FBjb0EGvsk60zcG1IHHRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jK4YXsVF49Kdn3zxQWKAKgCSNog8wnl3y4Knbv45xpo=;
 b=Bf1M74cdPO/KbOPC/CnH8xRrki32FbCAMqKwefGWkog++8pScCHz1Dpt973M4t3wE3q5yR/u+yt89pC6PJFn0pPMZ8ciuwamy3TeHwyrg9GosHHuQf8fQcoHu3pp2+xxITJ49Sa77f/b+eOLZ2diHV+5OQZfw8Sy1aXMeKySvKg=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH3PR10MB7260.namprd10.prod.outlook.com (2603:10b6:610:12e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 15:16:03 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%6]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 15:16:03 +0000
Date: Wed, 24 Apr 2024 11:16:01 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: akpm@linux-foundation.org, willy@infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, djwong@kernel.org, david@fromorbit.com,
        gost.dev@samsung.com, p.raghav@samsung.com, da.gomez@samsung.com
Subject: Re: [PATCH 2/2] lib/test_xarray.c: fix error assumptions on
 check_xa_multi_store_adv_add()
Message-ID: <dodldgslvisjrqfnkki2ypt3qejn6gb6l25eewv2euywho4unh@jlbkllb6l3ct>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, akpm@linux-foundation.org, willy@infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	djwong@kernel.org, david@fromorbit.com, gost.dev@samsung.com, p.raghav@samsung.com, 
	da.gomez@samsung.com
References: <20240423180517.256812-1-mcgrof@kernel.org>
 <20240423180517.256812-3-mcgrof@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423180517.256812-3-mcgrof@kernel.org>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4P288CA0050.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::8) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH3PR10MB7260:EE_
X-MS-Office365-Filtering-Correlation-Id: dcfa3248-faba-4c0a-a9a1-08dc647174ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Tg0bfkMqjNChs+dQUn/BlvwUcA0qPts4tGLMoIzl9gHkzQyJyv9XZlro3smF?=
 =?us-ascii?Q?zvMBxv+7xUFVK0AaA6JKZug/BXq7YrA5PM/ob/g/AtW668J+ikDQ43pReUI1?=
 =?us-ascii?Q?Ybgkd2UlGx5vHKC78m0x5mcwZ/zsM1p4oM+0CY/SBC8xa3sJ5K8PXr2SyPUT?=
 =?us-ascii?Q?BfkAzmvKeSpI9fQeDjNBObKNNAZ4O4/Nsa5+7dKUZYHhe2UUEEJBc/9yqmK4?=
 =?us-ascii?Q?6gkjaFNXhH3ogAAQZ553CPtaBhq/Zrbo8WKqTdZs+pHzjfx6Aj4SY2CHdgUz?=
 =?us-ascii?Q?2LKvbIdI2O0Hzbx1v5y9nnhitVfDvyr5ZN1prVM3ZEEhrHB/flF1HFefI2B6?=
 =?us-ascii?Q?aVgR1T0qCdtgxEvkoPRj0Ugjdn7vdFMVoNaWct7NVL1wAx+LmJSzYPN3m+oK?=
 =?us-ascii?Q?TqvbtDS6iLGcyox2+JhvTfrzq5vLbcTiJx5NoFzkbL3UwpbFA0Q6pEdSfeem?=
 =?us-ascii?Q?IilC2YStqCTpDGCDYw0inZtEfmRZ7NeuAKAFR3e/wbJ6RTWiJN6FHpbyXuyL?=
 =?us-ascii?Q?HFNsJtuUo2HgrjG6rEDmWEppfhIuGMnPsJFmjM7RRCMDEMsNJsXxYtlovOB5?=
 =?us-ascii?Q?RP327YmiJXl6TIN6JXOXkK2nJFaq8IL1ruCHvsutebDgMAcxrHf/E/IqidJ7?=
 =?us-ascii?Q?1i1x4eKOuMOJmk1fbo7GDxY+P1RlkQzrlXiAXUGDgbp47TcHObzpJAyHGZYN?=
 =?us-ascii?Q?m3TK54BCoRvRUCu9rcBLQskgFmkwjiCurEVyhqKLuQE9T9cn/ZxZCiUUQJ9j?=
 =?us-ascii?Q?SMy7sWdlKdBFztNEN3fdqd5QCe2l2B0M8mtDrcXr9W2FkRT1FGLPifATnrYh?=
 =?us-ascii?Q?2pj8kJE9XJQkVAo8chr5kYuCSnOYmQzP/AUkAzagfgOayEenaZlEBvFgaFjx?=
 =?us-ascii?Q?KRPwP8oj6eV317SWTRM6L/1LpQ9cPv9xG2e8sJbgvmCnQtIF2EfAvO7I+MY2?=
 =?us-ascii?Q?+sckBj0aG/qsa50oWl9RVFO2a4fWQNj1n5P13l2vk26kDyFkJTwNYqgYjCgd?=
 =?us-ascii?Q?Dv7btU3bU9qFk1o3j/o8KkixU1Ool2y6SVZMnM1/1Lvibrf15JlZkXZeEIab?=
 =?us-ascii?Q?Kxk3fX3/Mk3ZWEzT4XLHrBSg8JCek4/pzzqorAS1ePGcUor2rlk6od9GJwYP?=
 =?us-ascii?Q?ajG7LB/77qvcgRqkb5MdOsQlsRk6mwqoaMkze5xOHVPvbMpIFD3ysNwXxHA0?=
 =?us-ascii?Q?IYFfiEI0CBdCpZ6oDeB4Fs+FvJvy5eIzi+Sbn2qDMtVlGAFlPDQEBnDD0ptR?=
 =?us-ascii?Q?hbAk5bMv/3zdoUDlSC/SbyZHBGe66Ee5i70HfSNnPA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?WYpI59ZYB3Ef4b4tG2CIlOHvWzOpHnuzibMoVo3VmvMnJGx+InsG8aGZJTe9?=
 =?us-ascii?Q?fQnsBM32HLu+DbN6JkCH42N8WAYEfraj+b1QGdlZSm1uck8/5JaVUAbC7qXz?=
 =?us-ascii?Q?cS0bp8CmtvHF/W2QfA8bcYzjnoZrqSL33yaV5tY9NtklGcsdFHj6LOjHLNaB?=
 =?us-ascii?Q?LTIlONIoCVVWILXyk49unMOUsChb1HhO9DiVa5y1eIG71hzEsTrGxxdANGLl?=
 =?us-ascii?Q?ncZl5KK1TeFtB4S+K8YTIx8yICPSmZCI0ay4mWdUyPYZ3K8+JYmBTFtOA7Jt?=
 =?us-ascii?Q?ygkgrgGv7v8YySXretjPAucb4FsV8jKCXiMvFs7HZzfF05liY5rNlbmSPjuB?=
 =?us-ascii?Q?vmnKLtOj33QQjFtFRvmpZhflZ6ZmexZO+vIoQatmYCckDQimOTXNZrZS69kT?=
 =?us-ascii?Q?HRI1SnApHsIjJGzKeYNtRN/5q2QKRH3pfeU8lPVWzzG0cQkJQWQrEHPZ22IW?=
 =?us-ascii?Q?qz4KSctjAy7vQaNOo7pogVyreURumwFpSSKBNe0gRgQjd5YrmDYlAPP/tJdx?=
 =?us-ascii?Q?f3/Grv+Dl83N6N871KczYIbyAUfzGwmqWT6C9hPwganhLIU2SstMVIIhm8TP?=
 =?us-ascii?Q?yoh9GT2czFsEIDS3b+s+njgIH2ZbWMMqb/zHM2v6liUAy+ov9kkzj3rDUvHp?=
 =?us-ascii?Q?PJiZ8n2QZSdonbAEbEl+5QLR+FFpofil0+D5Q9+/1EIQcpz8jptB1aGISn/6?=
 =?us-ascii?Q?vmzjeL3Ts1pnvjKCevck10jTDTqMy4qJfyYQiTgs0vA1H2qgnZ6E8TK+Uumr?=
 =?us-ascii?Q?LCWYtcDhPsuLPVk+GddwOBov60iRX2gmuZ3ZhMVx9BgMyehMN/xvvq1yO8Ql?=
 =?us-ascii?Q?VTkyvnAT8CFAR3EGxmIfBGYaz2QLx5PaUbgrVCIkQjwVdgIfI5oybUBZkacg?=
 =?us-ascii?Q?ITg9SX+RFuomYwWZvl4uY1OE8ODNIn8HvOkzkdAzJ7coxQOKS3OONx6Yl1nK?=
 =?us-ascii?Q?rTE0T0K6j3z9aqrykTLy4ogjSg8Dj7VX5+mWVPECaJBFqpLWEkyCxTqOXtyB?=
 =?us-ascii?Q?hnvrl1u9shWmp3pNy2SEKLOSRh3QeB6xYRzs1WWZKafC44Wj3CxLwIl3GRlc?=
 =?us-ascii?Q?gqCvEAsbEGCWEqDfmiLUEvQQlmY4tRcZC2hWBtjPMYI0neVLp1QU+mVfAiBP?=
 =?us-ascii?Q?vVo/8rRj9o84Hf9HxaDCKA04z6i7A7Q2aADpYwGVhq6ONCxEXcWDozkTsS8w?=
 =?us-ascii?Q?c18rzzbmIm+CpEKJlBdFTgw7pvMFdJvQ7j2JrfI/9fMTShA9sCP1XtLxWQyI?=
 =?us-ascii?Q?NRz/dEgCgVrZNBQfcyvr40F35sBhxm+rkHguJMWzZe5af9h3r2+S7AZrA5Er?=
 =?us-ascii?Q?gDACgp2tUk7wicfezjYkxQDR1loZXpL+tR9vI7KMQaiD7ElwOeS75koz+g1z?=
 =?us-ascii?Q?IAmt7iCh4IAuD/jc9+DT7x4i7/9u6ND/WkTHRYYsCLHBhJjH8ahBvrlc8AD3?=
 =?us-ascii?Q?WHmQkcjaKbXgogvBkg0TgTcPuh7P4LiCcI93x/qynEbBCfrqEfA1t8IWk30w?=
 =?us-ascii?Q?BGzKXvrbBVKHBzvI9vnY7b27KBrTbYXcf+01QD6I0mTAFVN7ilsBH8oTnxJy?=
 =?us-ascii?Q?ri0yyJ+lmDXlVtC6hlOLILTvmlQHY8cBh4xwTZRtsddCdmJWoCz+9WP0G3TM?=
 =?us-ascii?Q?Ig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	U3gNkXT3pJ++0ShUwXHeGqQOJvcxjR8uuhR9qHo9Fygckn3QkTqeU1FDLHJ0fzMS0xQm3XMfogv8m7GtoS55LsPkIyYvA+7/4DYNqeJ34cUEpzZMfOvpZEItF1DXye83dXYb0kM4TO6ENJi7fTtk4LgQ374Q8pjVxxAGnFFNFGbLpDHTcBL3HAJP3n95jvXJWPkI6new2n5IZ9GJPb4oiNdybRZdCuA8Ck3cBwKwbMBLLwliEpAjZ+OYpcWQkR0rZxJ1tlB/dbhke69iJpbXjwAI4Y314Q0ntwQNNe7N0Cm6qAWQ+MJy4NxKVzE++6fiqgPycRA8LySg3CLSLRbcSJYU5FTaGfZzFa+PO5V+5qlj3sIi5s7ZYUzRZxJtsIJtGB3bPOX/Hofp41Zgy6Tn50UmyMUB5QeoBDT+TgGQV3uaQl48WePYH+ZXpIV+iZ/YqMRuPn15SosO8LVCCY6BEcZJ3Kk5ayJF35ttARQpb3eE8J/Dn8y9hN9CGnVJ0ShJCgz6y1FpAPtGV0381nm/KzvvuwtXzPEaAwk14ObeMiC4oPCcNMQal7tWeeiexcVK6WgHhbPTEouLvj78ChqBIZuUs36y1tJ8sC9K3U0W3Fg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcfa3248-faba-4c0a-a9a1-08dc647174ca
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 15:16:03.4642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FM8A/yS7rBCnkjLSmjO9XQ8byXQoe2XkvFEqA7kpIUeakhZ9Kis930XVU7LgVt+9Bx0l18zKNoEW5lF3eEz7CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7260
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_12,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404240059
X-Proofpoint-GUID: m1B2XnkyjOeJO-6jqu-Wge8H3k0D5T4T
X-Proofpoint-ORIG-GUID: m1B2XnkyjOeJO-6jqu-Wge8H3k0D5T4T

* Luis Chamberlain <mcgrof@kernel.org> [240423 14:05]:
> While testing lib/test_xarray in userspace I've noticed we can fail with:
> 
> make -C tools/testing/radix-tree
> ./tools/testing/radix-tree/xarray
> 
> BUG at check_xa_multi_store_adv_add:749
> xarray: 0x55905fb21a00x head 0x55905fa1d8e0x flags 0 marks 0 0 0
> 0: 0x55905fa1d8e0x
> xarray: ../../../lib/test_xarray.c:749: check_xa_multi_store_adv_add: Assertion `0' failed.
> Aborted
> 
> We get a failure with a BUG_ON(), and that is because we actually can
> fail due to -ENOMEM, the check in xas_nomem() will fix this for us so
> it makes no sense to expect no failure inside the loop. So modify the
> check and since this is also useful for instructional purposes clarify
> the situation.

The default behaviour in the testing framework is to test the error
path, which is what you are seeing with the less likely return of
-ENOMEM.

> 
> The check for XA_BUG_ON(xa, xa_load(xa, index) != p) is already done
> at the end of the loop so just remove the bogus on inside the loop.
> 
> With this we now pass the test in both kernel and userspace:
> 
> In userspace:
> 
> ./tools/testing/radix-tree/xarray
> XArray: 149092856 of 149092856 tests passed
> 
> In kernel space:
> 
> XArray: 148257077 of 148257077 tests passed
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  lib/test_xarray.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/test_xarray.c b/lib/test_xarray.c
> index ebe2af2e072d..5ab35190aae3 100644
> --- a/lib/test_xarray.c
> +++ b/lib/test_xarray.c
> @@ -744,15 +744,20 @@ static noinline void check_xa_multi_store_adv_add(struct xarray *xa,
>  
>  	do {
>  		xas_lock_irq(&xas);
> -
>  		xas_store(&xas, p);
> -		XA_BUG_ON(xa, xas_error(&xas));
> -		XA_BUG_ON(xa, xa_load(xa, index) != p);
> -
>  		xas_unlock_irq(&xas);
> +		/*
> +		 * In our selftest case the only failure we can expect is for
> +		 * there not to be enough memory as we're not mimicking the
> +		 * entire page cache, so verify that's the only error we can run
> +		 * into here. The xas_nomem() which follows will ensure to fix
> +		 * that condition for us so to chug on on the loop.
> +		 */
> +		XA_BUG_ON(xa, xas_error(&xas) && xas_error(&xas) != -ENOMEM);
>  	} while (xas_nomem(&xas, GFP_KERNEL));
>  
>  	XA_BUG_ON(xa, xas_error(&xas));
> +	XA_BUG_ON(xa, xa_load(xa, index) != p);
>  }
>  
>  /* mimics page_cache_delete() */
> -- 
> 2.43.0
> 

