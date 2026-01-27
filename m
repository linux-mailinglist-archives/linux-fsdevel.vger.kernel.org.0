Return-Path: <linux-fsdevel+bounces-75608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UF22IxfMeGmNtQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 15:30:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 054D595B84
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 15:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A9EB30C8087
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 14:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183C535B62A;
	Tue, 27 Jan 2026 14:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TMjQ3nsa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GlAid7RZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5324B34B195;
	Tue, 27 Jan 2026 14:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769523942; cv=fail; b=CWtFUbGSb7yF2M46hiCc7oDb1jJWgBxM5YkD06zZLXbBKUOgZLEKR8UQc0PWZyBVeg1tfXHcKlzwUD2eYH/fiFZTkEQ4+rwZWAy/f2FvdvcjnVqDkg/VXoBc7BqfI29T4zdCczJP+7mc880JqJkinmCUuqvsoUw/921vdDVWf4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769523942; c=relaxed/simple;
	bh=s1wztSgneCqy5lpL09T2jWbzuVBlXKqVrfhrpuWvIoE=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=pBuze+KlINf2fwPtkJEaNyZ1vD/td92BIf+aIhtGGTiao4VNWZCu61Lf6DwphznM/XhGhT7TxmKySNEx6BQawu1m8ETBG+9JOnsqsq/hGZScD2TlBdlL7sByGqpjYxrHUq6zqauq+X7hZhTS1TRn4qhR63yT74URHNwy0sco5C0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TMjQ3nsa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GlAid7RZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RBEKXU454949;
	Tue, 27 Jan 2026 14:25:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=pTtWxYaXThpILoW5Qw
	qdCiFcALyZ0BugQV+kyXMaWyI=; b=TMjQ3nsaBVXdOxVlbYdL/l39r/eLxDjxcA
	tX7A+BkyMRmKmOeW7H4WoWONUQJECG3Sglpeaz82sbQNkGhPjQlRoLj4jxnQHYFV
	aqOpIpgNifGcchqvHcKi614eZROd/FdcdKlqxjSUpACGyJy3Qr/l1QLPGt0QxZb6
	2MC788FuxfG8pSP4ewTe6WKQ/5v5FCOoAnt9GyoAHFfRHqJqeKnpLYwCYOJKdOCk
	Ubl4lYsOuR93TKCKHbAPYNV3fgTHWE6UbOWc0/c+7vTSkMXPnMM5c/7yeomAdiCM
	tDhCfJdrL8SlScv+mmfL4RBhNsaT7HekYcOzTdbQxE3i7oAkzCsg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvp4bv4fh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 14:25:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60RDg9BD009970;
	Tue, 27 Jan 2026 14:25:30 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011000.outbound.protection.outlook.com [52.101.52.0])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmh9g3th-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 14:25:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qzyYsCsxY9cF6ympi6sxJCuSo3IWE9dYzLMfkdOdws3GK09g3UTsa5yOqvJvq6f3dwikvdQy+oNUzeKWzH1CypIJOSjvEXggUz+Setroq9YC0EIkFxxi6VA1jpuQ0FhF7n8yJqoSAQeUzcUPM9Bbrgtmw5wTOry/TVR3Pe8fWI3DaILt+mRlbzKJGUzmiBl8U3JT9Pq6WhJrWFga9hGP3cW9cxLzrhvSYsrbjzerajor3qF/y48fo8pK2+IBUOWy2mUSIqPrWozdW+alQnOTtnpyg40HqFcb794Sx1mRiv7dUYmCFXC/fLaDOI7DLEg3/bSBhE+yK37AmvYedbM2pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pTtWxYaXThpILoW5QwqdCiFcALyZ0BugQV+kyXMaWyI=;
 b=t1Wv3t7MWaRaQHfpv6CmlfzYjJjyAn1XR7zvXO/Yd3BlcX/9CqAxJRJOT/dJ+7MqpQTw1LatEw86X9IpjgXeibmOhTqF9VY5UDhUKORwE6Wgl1Q16oJF1ELUxLPN+YKrPeW+OsVnwSSvo1RvGDj8yHCFALB6S8SErll0p9DTa64XCPN8z9pgmi3X/3j2W4fMdOfC6dkSEJN1HwtU405ASNovR3HtxWTku29jF2lg5qGrvbtvqmTDVAl6WdJwDgdZvcufAiMkSZGLxHKSt67zjs+mzdByHk5ngdh8+tVz9STJuoh+ZUERHZDmH751xf+NB7nAcEaUI41bFUVx5s6xzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTtWxYaXThpILoW5QwqdCiFcALyZ0BugQV+kyXMaWyI=;
 b=GlAid7RZFeuZrCDMt5dHHGd4+HBE+VXKm5FLAgUCGWxfKJVUL+l+RvP/CVSF1NmQLZjxK1I5xC2759MtRvl4BbJxcDNQn5Zej2Ot8boYxLO7awGNgYTTeGUODHxC+LAYudkkTNU7bGQEQwhhq6fhnp5XH2boX0yMueyHMBRQaHc=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by SA2PR10MB4809.namprd10.prod.outlook.com (2603:10b6:806:113::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 14:25:27 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5%6]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 14:25:25 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>, Qu Wenruo <wqu@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Anuj Gupta <anuj20.g@samsung.com>, Damien Le Moal <dlemoal@kernel.org>,
        Johannes Thumshirn
 <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 03/15] block: open code bio_add_page and fix handling of
 mismatching P2P ranges
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20260126055406.1421026-4-hch@lst.de> (Christoph Hellwig's
	message of "Mon, 26 Jan 2026 06:53:34 +0100")
Organization: Oracle Corporation
Message-ID: <yq1y0ljt9o5.fsf@ca-mkp.ca.oracle.com>
References: <20260126055406.1421026-1-hch@lst.de>
	<20260126055406.1421026-4-hch@lst.de>
Date: Tue, 27 Jan 2026 09:25:23 -0500
Content-Type: text/plain
X-ClientProxiedBy: YQZPR01CA0115.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::8) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|SA2PR10MB4809:EE_
X-MS-Office365-Filtering-Correlation-Id: db181565-6b60-4bb0-8093-08de5dafe996
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kh40FuZu//turg+hYilpD+M+2LFYdRf1Bqi1rGCZhMvAdCzcZ680JnWMGCvW?=
 =?us-ascii?Q?fGPSKpIsv7Ear7wAz+ssELn6DdDkeAVQ/pi3DynM0Dub/aQy3J/C856Jsz2H?=
 =?us-ascii?Q?EKMlJKwpReITbodUTLAHWbvNjMC34661zSKUtBOCxJiy0HJIoLLABFc2e2n1?=
 =?us-ascii?Q?2spKigHCtQzjEdMujbEpL/JLOoT5rTPZZM9KqeLk6OpZYTvfyW7Am33ja5DZ?=
 =?us-ascii?Q?1EwF3e9B+1aWBol4bgRW8aU5yVaRhtjWCMddXRFYQEAK+3Ssbxc3yX81XV+b?=
 =?us-ascii?Q?tWWwSNhPbAXMgNGw8IYRc3576FlLIoaLd+1UJy9I0lR84UOnoazkxNGWv/yN?=
 =?us-ascii?Q?5gaH3swLbdAGD0oapAeH2dkWLi/PGF5ELKRGHyMz94dNZt+nMbKb1+BKd8jE?=
 =?us-ascii?Q?W/XoCb86sVXvyxd7Tq1e6Rqkgr06t9rBqOTBYuHzAThWqHWFiFdV+upvA5Lj?=
 =?us-ascii?Q?WZL1I1FO9vBgKFB7P8Gf2wrGuG9UM/rtUTAS6dXSi/a0Gff4IOuZ2DtS5AZW?=
 =?us-ascii?Q?23JGvmIeXqWmla7YEJOSf7/27mU6YM2I5/Mlvgmsk1DRkaW6pcj9Xw0lYbI0?=
 =?us-ascii?Q?5tg9aSo6niRnGw0At3dRfe+DdEuCS+BEm0kQA9GdQPe1HXUbtifh/2+CsMqd?=
 =?us-ascii?Q?dGskxQPFap2LvL3cUfoqLI9gXjlBz5zeaK4Z3uxBbU/euUoVe9giHUR/t8Qa?=
 =?us-ascii?Q?vZ6pyBDZh6L7e+A9H9xJJlL0l9DzEyeoB5gdzgMqO5lpTf7icXzi5ZJHcLZI?=
 =?us-ascii?Q?mmINvpWakQmo1UnYhB1wWFuZw1i05+/wpUy5+2NeQR9xZF1tGfnp9Bti2bJ1?=
 =?us-ascii?Q?CY6EWiNR23gox6VO68KtyQzeSFjsGmw7DjkOkSmEfU6B34ufyzM7l1YBCnSX?=
 =?us-ascii?Q?BjNHVOiveUxGCaxZup5swM5qVASDelqF4JrWzXjduD9afnjwJsL5ZVgkJytN?=
 =?us-ascii?Q?9IYGCdYjvpd//tZkCkeVh0lYGNKgbGXjkY00yr9SzVpHJjNvBlA2b4rXh11o?=
 =?us-ascii?Q?mFpcW0Qm+ZXixlmpg/gmCVXYxXvo4nQLicSLG0tq3+V5VMKvEsIukXY3gMwJ?=
 =?us-ascii?Q?PH61ejKPJPK819keHid02vUB+arf09PR8GOinM4ENUVuhuczaNEBhJkdWSLC?=
 =?us-ascii?Q?9gs0n9fcq2vsKnvUdBVxWm5f3xNcQ3ONoA6tyqa9BUyrUrkpmRPsfuTDantd?=
 =?us-ascii?Q?3O4BhWRARuk8JBKUcqd76Q4Ma9WRVCbm1OwSbQa9U6Mh3i/ATSNWXMcqoS43?=
 =?us-ascii?Q?2iHKWd6zF89vJG8J15t58XGvO3SHudIMywSLd2VWlP9TzRex3lriF45FI3/e?=
 =?us-ascii?Q?Ex42PAYHmA7f6581N+n9SBLkYbv5x4t2Z8EJnU6f5pVJtqv0lVs2kS9BLAIK?=
 =?us-ascii?Q?AWriOQ+F97iMdWtddAbY+2ODZPPsXAOO+LRgFc0/lMNUJXSbhNHJvOePKIcu?=
 =?us-ascii?Q?I01OyYvtToI99SkH9Rhja0xX5shk4PlmBZiIvqLwakpxz2FjyiAzujcyavAj?=
 =?us-ascii?Q?QY3/DOYnTXU+k6oN1fNl86CzGewxU3WmT1eX0tCrClts9+rUBD2Un3D6RQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KgO7fha8MOo0kqW7JnbJiX2Epl7KwCnF5jQf7IbRJMBLxui5Gj0arU7+SZ5z?=
 =?us-ascii?Q?B5BMZJ9r8N+PfebZcAPVOKceoTkpTtEqIThLBXLVWSfqJ+qwNyRgrWqv3OCc?=
 =?us-ascii?Q?7m5/iGWL9hKXgFucOq4pqlQwl1VE75sKfmWc3sm8hEsCfjdkNURpkI92wvN6?=
 =?us-ascii?Q?iPpyddFLvFDffVZWmRPC0gyQMjuFeIszzDjosBw3WHwz1qRmB4hMzXG/qdQK?=
 =?us-ascii?Q?tN96vEoRdrEjWnOVlU6+bq7NnTRZp/syEJ2HIpqC6Whbk9mlxDKgkkaCNgGx?=
 =?us-ascii?Q?KXya6IAMqnrlHotGbAWIc9UWLQ1gar4siJ0sZgwCYrJFUAAd22ZuRZcy3LRE?=
 =?us-ascii?Q?Ddd8ly/DXnkrGj5s9OsDXAAvy4hX38Lurq9HYbrIjO5EBt4hPkJ8nrdTFCsV?=
 =?us-ascii?Q?koZXt47XUW+Q98Tj1kyPnLftw8GjnIyZM01PNRrObpnOl8Nt/ulZqS85WUn9?=
 =?us-ascii?Q?L/IgyIlNNpNMxADy90ClRdJJN1TakhpEm/WXxeTRq9r4Tl47SpVGs/wnsEK5?=
 =?us-ascii?Q?JOTEho1P2xXBestdI34N+ni8YFd4Zsd8eLcnZ4xFzPW87sWVhzZV2mCRKWx/?=
 =?us-ascii?Q?T9D3OwfuYgskJThwBmv7bwJ8FPeAb0gT71etKfFtkSA6glwlmZBtUqCcKdEv?=
 =?us-ascii?Q?QxK354Mjefv5vPlRPznOnP71yBEYkYZXPY/n4Ue/cju7Na1Pt1xFxmUTx1hS?=
 =?us-ascii?Q?fpm5BTLj8+1RJ5/LpXBD4HQLLXX2YdyYbKH0G6gmlI3fj4kome2WDxsTBPBx?=
 =?us-ascii?Q?BD9mv2Cshr/djRG/Tew0ra7bczziwe8CDtn3oCkqFF4pf5sVMn5iT1+EbG6F?=
 =?us-ascii?Q?LT7DBYlONLw+PxNJewzlk9aklxyhtoNzDwvCjS0gEpo85fn5tVNG2MN3bYf8?=
 =?us-ascii?Q?C1TfSw4JJzVw0hLAi7f75asZQH1jxPMHNvy1zd/TdPOlKUzcXdS7FhxNxJ3i?=
 =?us-ascii?Q?zXOLvHwGPJSFiXLPasupEi2NvrIRYuGySrEFWHDxg4mruY2TAklyRXPuNUaw?=
 =?us-ascii?Q?ZUNH2UXS/5AVGeqC+pZLoXEJpF+JSjCg2mt0td7YNVb6tO8+//uZZVX3AOn9?=
 =?us-ascii?Q?zSz749eyhchZnQYmBdl5XsOzdzn19k3QPb1++lPGRmMthzpFheFOjPUj1YMf?=
 =?us-ascii?Q?hc9QzWqw2aahQvs8cTHPLaxCtRCW63e+QU9DaWRy8BzTRydpPuEWMVekEjUi?=
 =?us-ascii?Q?Z42ydseHdNIYSZiHOrWA2yTAl5/qR4B4m224SyoATlec9x1Jwjmc7lM/QGF7?=
 =?us-ascii?Q?HwpSvDed9I7+Dq9QsyP4SbzM6PnDLXURhgzPTv+vCyppt3f4fSLN4ZhO3+jr?=
 =?us-ascii?Q?NmArV8p4gc/qCxqO0ZvZlspD3G1ZIVyIGlXb1+KWkbHD/b9z7DqGQDuS68rh?=
 =?us-ascii?Q?+iT3FY+ds5eFhAlBnUqXIf5jnyelg2WDMWOBGZ5dTsTEE/dbbTvTwkxPvYJT?=
 =?us-ascii?Q?QjU8yO4YyhfgWPkPZlT85n7N/NaY2vKUWJ9RSOJ4uLRAr+ZVUkT7y8tdER87?=
 =?us-ascii?Q?tCnEFN34dctFbdLZrlXgtLsQEgI5Pu84bTk4brDZc3Ntmnkq27WWlw6aspnQ?=
 =?us-ascii?Q?m0y8lQp9VZnu5taXiAPXELRvjA8HNQcpPyaGQIAZyDry23FVPzlPVdf1i/gn?=
 =?us-ascii?Q?0YQGJyCWLGvay5XclGTUZb9z8Lf73HxDRihJntjfX3MZ3xmwNXq4trlqxlsr?=
 =?us-ascii?Q?Aa0lj9Fr2dE5dE7ebGDesj3hpKSY8yt8YOalHGmjtlEPOkVkmKJkkL3014IP?=
 =?us-ascii?Q?IF1cExzoasMUgmbHJha1stWa3yJmcI4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BbGv72YVKHk1yibWcJy+LjKHnr/WlQEKHlG3eKDMTPZC6d3k2Wi+YV8GvP6vBWRBNtnoi/yOR3g+17veJVbWPOQxlQU1TtBtN86L8XGRwyAUuWW9fOEwdIqeQJ5F7gBgWlbbe4Ju8t522Da5jQC7UCUG4za4OMIm0hTlfCGWmnkQ0domPkzQQvG61euJS3kSnL+51H+qzjeC4YW6d7s0qMNft8ExAuvK4Er1YmVMS0wRK5O/4JKNS0BrbVDiB5j5PE1XoHPKMiqWr2A+X6/6pEPbdHPCD8dk9U6DNZYx2AMtVECOP/vn4w1zlGNhKfT8z7ZGwNT+XxUNIdO4xF7HJ1Z6wkm2dbCofz6m0ywWxmeFVI42+PIBYzkHy9jDVzr1VtsexfpB3aXersLaxAF+j4E1vwuv94xOiA+F1D1V0j0jjV6lLp+iBM553v0h33ICnhiYW6glFmVUkGOikk2QqUlfBoRr2G4+VplD9H+7iTWeNxkVinC05XksRtD5JLOSXBh7hWQ7maGQuw5g9vDrCFuPaGHTIIgZIJPwGQ9jyYC6TNuueYMmQrGZpXF7t+1kJwDHcsMWchYT7F5Ow/vcXQHe16xR5Bs24Q+OGXsnqTM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db181565-6b60-4bb0-8093-08de5dafe996
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 14:25:25.4385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DFmHJ70yZvvNGAYos4OLSoCp0H+lDzdakffBbBU7/sfPlJ7vGDYQScVuPMCncOpAvG8S6v2X7oZwyvIym4p3neuV/1wB6XfVZ1X05U7Fqjk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4809
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 spamscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601270118
X-Proofpoint-ORIG-GUID: qPAQEimDX5JCbwx64eN1r1BDBfD06JIM
X-Authority-Analysis: v=2.4 cv=StidKfO0 c=1 sm=1 tr=0 ts=6978cadb cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=8hAP0e9KD9asXglEg90A:9
X-Proofpoint-GUID: qPAQEimDX5JCbwx64eN1r1BDBfD06JIM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDExOCBTYWx0ZWRfXxQgHqcMZYcrd
 EBk7gkgN7/LZOuImbYR5qs2aciJfRcsU+63y0FbhrBkuLaV1JZJY9hWjh4+pnH1wyBug4y9dHnP
 NPQyw4sr/l6NHDlE+UXi8XSSGBDLmjwlDwlPuY90ngoDIfRq+GhU49YbsNsdfKHKaPac3ssD5y5
 0tod3b4ogpMGF/+N29Q26nis06/puGCwegG8dhiXkwKIbWTQwyxy2AkjS7Pkk9qQYxHKUgPoJLO
 KEAv0gWyjjB90BTX61JFZP5V8SAANAMvmv0Uw8/f2hLVax+2xh9DbhWF2OhAbTUN02i2HRw1imE
 W0OG/k6a8d7irwZKpJ0CWyEYd+MzfwMmk8IWOhMV/RZr1vCW1PtyV0sHELtQbJwU3frVPTrOKDn
 Dpi86eCQGAF+2oE2rItCZ3quRKNYugtg4ag4G+SuQkgOCZq5ygbFjPAC4AELPzz++kzVOzoVc1f
 4jOdNmSHQdL2qqtjNSA==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-75608-lists,linux-fsdevel=lfdr.de];
	URIBL_MULTI_FAIL(0.00)[ca-mkp.ca.oracle.com:server fail,sea.lore.kernel.org:server fail];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.petersen@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ca-mkp.ca.oracle.com:mid,oracle.com:email,oracle.com:dkim,oracle.onmicrosoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 054D595B84
X-Rspamd-Action: no action


Christoph,

> bio_add_page fails to add data to the bio when mixing P2P with non-P2P
> ranges, or ranges that map to different P2P providers.  In that case
> it will trigger that WARN_ON and return an error up the chain instead of
> simply starting a new bio as intended.  Fix this by open coding
> bio_add_page and handling this case explicitly.  While doing so, stop
> merging physical contiguous data that belongs to multiple folios.  While
> this merge could lead to more efficient bio packing in some case,
> dropping will allow to remove handling of this corner case in other
> places and make the code more robust.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen

