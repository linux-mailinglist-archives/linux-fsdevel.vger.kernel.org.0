Return-Path: <linux-fsdevel+bounces-62127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9F4B84E31
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 15:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9B0E74E0554
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 13:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A5030C0FE;
	Thu, 18 Sep 2025 13:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mPuL0oXE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IkI9Vffw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9199E34BA33;
	Thu, 18 Sep 2025 13:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758202974; cv=fail; b=s9Q3aSzldncW6FJvY3lhuyVA/zQeCIlPqm5Dv26y+L6GbzNtp/bOSi4FCGsCCYl/N9Mu8tjEpmUGF8EhsRs0lARuXH0ZrMWBvnezlUUcsNKZvQdszAI2D/kpAAIP0dO92EuO23/PqXR7zL3A30kqphaFoy9qsR0eYVu3JkOo/Sw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758202974; c=relaxed/simple;
	bh=p/2IeZwQLet3B4dpo8lPLePiFm9Tm3N5j6wI8o02Lig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q+AF/Q1VLRh5aaD53RqvBAIPBN4SOCE7jfLREL7BEa8c0lh0zRoDYNWAwqjy6rkOxV2rylMgDoSXNnUJ4uvJHU6NFI7UAxMoYOuY8qq6bNDPfdaITmENGINmc6Yxk9BzagQ1i7DW3WIS0iGUsirtfVi/sd2c7bzTWxgoRYUF7aQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mPuL0oXE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IkI9Vffw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I7hNXI029860;
	Thu, 18 Sep 2025 13:42:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=A+rWIN/nxgMMDSAEVk
	+GW3qA5L9vqscNsTeNZHNZlBM=; b=mPuL0oXEEwtq85y7Xx+oH8q6/j3yjIEKwL
	N0+jL8qMCblgphHC7YSSUb7a2AmuA859BYG2pOJbfyn8n86PYxvs0+meSY5SREAL
	DsRwPshhtWS7dSyQJeXbVhFiISOgtdMgvCtwwm4CnhvF/bz+8VfloyIbT75OfVOz
	lpeH58di4na4duvjRnso7BbcomRMBdjJr5PH2PtGEZ35UOMnFQu9lo9r2GgydeEW
	mG3vZGqjV70cSj5QTa3wdZRF7QDhKWwHGh+SVst59xuDkK6JRxNL6l/MoMz9hjeH
	6QUhggxGpVHJ87shyOAg9uSfdP7lAOIDWwPUU1TvolnYmjY3TZSw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fxd3fqp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 13:42:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58ICDnUn028744;
	Thu, 18 Sep 2025 13:42:28 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010056.outbound.protection.outlook.com [52.101.201.56])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2f598r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 13:42:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kzgugBU1Xw8TrMVVkwWnMeOazAFQ/SwWBOWWd+FeNRMqucaFBxALIUd1I5USqhoUve5MJp9zZ6yPmSXLvJi0Q6hwfYqX2UqTIIM+d5eaJpx2OCSSUEzYnUG9tVxQnUT5LAnf2zSzw8HDsrk0jGe9/s0PslwB0OAaVof8u+hCWVZD30oOXJ1DFRy3QkYhZnRIJ7CQN7WwKFgaWsRC8Mpo6fza93AiXf7/rGbUtxD8K0YFUyhPLWjKIYRSNGVAVIvAsV/9C2+OlqrRPB9dxpXwar2XthhXFQQ2boi0Z6VxX5TQlhEA/Xo8MRd1/V+DxrWxxTzEae/13po4xIDoVij3cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+rWIN/nxgMMDSAEVk+GW3qA5L9vqscNsTeNZHNZlBM=;
 b=L7wcazHRGN7kylOcJZHPpmf/OOC3MLRBVDVJEfItURklJuAgeradQuaKKo6jdH6Efh9Wo7XssQMKcsYB3xV1meFXXqIQd8L/vyx5YodRUz2kI2FWJN02BbehwOp8hZ4QZbV//JxTpvGCTp4WQ2/Su3s4+HSktZg0mdns7RtJ8Pk5Z66d0LzOnvb21qCn46UBB7hu3Gbx0Z72S0vZSs0Dd/48E7J+pZqr47yPi6jihqeIrS1vYI3xtQJDcgw8v3+zrhGJdSzKZXz2lo5u7rzAxmG7lDtzfakaZFyQGoUCEVA5kuSKpfRr8XC5yJP54VYOzWMSYp5VqTlIlVDUtR6I+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+rWIN/nxgMMDSAEVk+GW3qA5L9vqscNsTeNZHNZlBM=;
 b=IkI9VffwVy2hCC1yMEkuijR9lNzYVFEGJ3xuCPOPz5o1sQ5UMvwdnMCK02N2g9aDFB4NgtM4YV1pvTzBPCMBoKfIrYz8YG6pD41qNrekrcBjc760xoEcsKdlhxenkjVE5imn1v37v+wG4C6kDnzOqfweU5pDH7Iby9wm8Thq+js=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB7005.namprd10.prod.outlook.com (2603:10b6:510:281::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 13:42:18 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 13:42:18 +0000
Date: Thu, 18 Sep 2025 14:42:16 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Kalesh Singh <kaleshsingh@google.com>
Cc: akpm@linux-foundation.org, minchan@kernel.org, david@redhat.com,
        Liam.Howlett@oracle.com, rppt@kernel.org, pfalcato@suse.de,
        kernel-team@android.com, android-mm@google.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>, Jann Horn <jannh@google.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 7/7] mm/tracing: introduce max_vma_count_exceeded
 trace event
Message-ID: <385df771-961c-4fc1-971c-81314c231f5d@lucifer.local>
References: <20250915163838.631445-1-kaleshsingh@google.com>
 <20250915163838.631445-8-kaleshsingh@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915163838.631445-8-kaleshsingh@google.com>
X-ClientProxiedBy: LO4P123CA0127.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::6) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB7005:EE_
X-MS-Office365-Filtering-Correlation-Id: bbc31232-8b0f-47b4-aa7c-08ddf6b92fbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GhRmvv/bv+C1VVDXemBnn+EsZcpu86Su5+Z4tiVGir1kwAw1Nd7MBAsTtDCg?=
 =?us-ascii?Q?gtmzy8HZSZXBUr9ERsjR64M2x4F08hCL/kb4lbnAGql0ZxmxwwW/GS3KaIQr?=
 =?us-ascii?Q?4Mkv+iVkAEmJ6kJUK/F6Pu+W5yTe7e2loidFX7MLGebYReXekw1eqxmbhl52?=
 =?us-ascii?Q?9AS1fi6miqN3Os7rWuH4503zSMIkF4sRx+3pPe+gIVbrMYCJKF/1Q/waUmSf?=
 =?us-ascii?Q?3MV2axzktRlQqarZ+NpgvYzlInSoNjkAEOMDPCqMifHbratPGiH/TEe+ajcw?=
 =?us-ascii?Q?zv+7uo25oPX5aS/xO42QfInhZOYuVGaJ7qSdbjN3YPgJzVVqRvMIddLZ07ih?=
 =?us-ascii?Q?S7ly0VWkecmnGvh87VqDCkk3jd9ibOSUbmy2OfgYqD68GeoDiqLlHrVLAyRg?=
 =?us-ascii?Q?lELOUtRu90Myste+KqctWEwkb5V7ztK3mzUq4i378k3QDfQ4X82smb0CjR3k?=
 =?us-ascii?Q?YzMr42I9/FhnxabVXSgAAcSFLgUTjXTD0HdXXuHyPVjMhlHcI30syWcNfHOb?=
 =?us-ascii?Q?Mn6Y5Zj9Xo2up2d+oegEKL/SD+AKZmT3yHoWDHC3CpplX0lov31igYzC76wX?=
 =?us-ascii?Q?nsO3M6PQBrf4akhy1lVXPSKSpHV0A7XR2S/0qqmgclFyg/MtYaA8/nB1Y404?=
 =?us-ascii?Q?fTOfBdXcqo9Stt4tEUdBO1ELuTFo4MaA+dsI3xLplE7xfXVf87q14+oHqXqM?=
 =?us-ascii?Q?CYyjOd0Ne4hZzVQXGmjdITjNNB6A9p0B5pddQkA3JDa1m564SqYsbJEQhGHg?=
 =?us-ascii?Q?pMNO67pH9Cm5AO7WxNq0dURwQ2p+f+z2nsqFalYxsekb3xB23HB1YrSlIFfd?=
 =?us-ascii?Q?geUa40VfmrHcn8Hqt0cugTmsNGkHmt/WwPy071I1XznyARX3XvFzhoaROAtG?=
 =?us-ascii?Q?FK20eRskC5awbcbunyYbmy4WNpru/JT6xk8dvf7eq5/loeLboLp8BnxiQP4h?=
 =?us-ascii?Q?PtcE3z5A+JDyP9d0Qj+0oOd9h8lJ1um1kq3zrsxM0mYEllEmc7OR+byE4S4X?=
 =?us-ascii?Q?0oTZf875gnlL9TUoFJLnQi6yKDIMyYbGIGwCi4Cg8feHWcj9TCHdWVa/EyUO?=
 =?us-ascii?Q?pxrbXlhRlXf7Vi9JG0g/cLzBMhYeoKlJutPNqVwBjAH7r2KG7JHVjqR1p7Nb?=
 =?us-ascii?Q?CrF7JnyBJXBucKgTH50TBNq88r3N8SSDChUeTVNv60BhcCU742wEAYgQjuoq?=
 =?us-ascii?Q?0BFQtqLUU/+UCuNQ872pEIgvJ52CHr2K+NoMRmN7j19Pfr2yk3Rvxme6Dqts?=
 =?us-ascii?Q?i+w82BmF9la1he8HMIzhEt+LnT/0NibUWsEqunquBMaYefQRJD0PyuBogYCR?=
 =?us-ascii?Q?VwRs7uLdxw5isUDOlaHCIm0alX4yS7P1JVof3ArlG2xf+++VRSHgS9uAV0rg?=
 =?us-ascii?Q?fWFoG7XgniZcqX5CM1SVkqsbo7aIsCyPaU+s5ZVwgAgclwY//SmWWGwfRf1y?=
 =?us-ascii?Q?rF/En7pREXg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kixeuwjtk3BonKZRbAnPXL2ECT/lZYb00FgWr8y7WwpWGd852mpeQvyvilWC?=
 =?us-ascii?Q?xLc5ComYgZMaLsMkldLAOCLI2w8xbVxIDFabwDeSUVVtp9DUvIvGax2fBCyg?=
 =?us-ascii?Q?nDbNsv1skccLWrsz7PWlDs1AhveLDORHNrg85x8PyqMHL6nkOx+qUgO0Pb3g?=
 =?us-ascii?Q?p1ck8Rq0Kp2eWC4TJnmkYxwKWs63hCEtSy5KDcFdPJuxeY62YAVAOU3IwQmA?=
 =?us-ascii?Q?fv2jczdIeS4fQVJqEPvTPv2SvlTflZ0ssTnpcuQ6E37iFkGfWluxDRhvJfuw?=
 =?us-ascii?Q?TQZGIU1hsnT4j4R9UV/prKlb5pCftxW1fSk0LeUz3k69JI6cLvOxJ2Ruu/gj?=
 =?us-ascii?Q?rNbwFi8uHqm4Wobf6Dy/Kxeeu2YvFzlIQh6P+tvZy38TBfZNR0Mo9SOzjy+F?=
 =?us-ascii?Q?976AYjXvytwjYINiMja6P2rGjUeecu7b5D8xzh7KaaiB3tD50D3lKLyWk/z4?=
 =?us-ascii?Q?m5OOVHoSY6IIbO4XpRC9HeopuvezwgHJSqn1tS0PHWzL5bNQzqrcF9C/mEOT?=
 =?us-ascii?Q?kDPGW3FS3M/aUd2DN1BRHuxQqOyH0nlpm9mSj1Qgbq979bq6zVnV3wpnNA0I?=
 =?us-ascii?Q?CCOap81oulI/lY9VJMnWGUCX4bkLMRqoyjcoWIErdYtPJ5VovWZpVOslvETt?=
 =?us-ascii?Q?by8Vd8n9T7R9C24f6OYjTqjdNF0Hy2NK4XRRpLgvTM/gBbI7GdMdTCV1m7yM?=
 =?us-ascii?Q?qh0E2608NckDbe45kE5Q6JQhkPCawdOch4G7sze52ebWjB1cGr0aTNdRi9MB?=
 =?us-ascii?Q?+lP/D8tWmgUHHjO19cdOr3k/DEtFu22vlME2uSULKsaL8dadobLsJJrTjzD8?=
 =?us-ascii?Q?+kLUZfAn1Rt+V108C3GTvrpeR4gA5lNrm9mVgxxQYg4Y3eCp8Hs0HgZ1z7mB?=
 =?us-ascii?Q?MQq8XfNtr1sLyKh1SLIBeHJrL6vQXoqJCQ4mdjDFTE0h6DP/q6IUBzylc1GN?=
 =?us-ascii?Q?rI+Zf95OI3pdaN5LJ/XWruhPNNaTnnsAQFcNUTUa6qliRQawOuhtTwveBUX4?=
 =?us-ascii?Q?hpyfRnWgPi0LtFOBxFigyB3QDFd03amtRat6HUu32vjkF8cTjM2WJ4Vmd4EA?=
 =?us-ascii?Q?k40qWAjdOisoMrNDUyInw/bR1wIjzXHLKNZBhD1gQYeQpWcyohKrFnSLNFvH?=
 =?us-ascii?Q?53CgOhRViwKGcq0BVXsbSSqn1gf7v0CxIDnu/VrNPgXPmQkmWLELMmE+04t5?=
 =?us-ascii?Q?cB1tc6flf6NysTMinZ7XOwvfntanWw0RKbiKVXJdfqV7qSDcJkjIHFC96pjj?=
 =?us-ascii?Q?9dj4uYLX/HyPZtuiUjlgIVLrge3COAWJTYw40crSIRJ7qZ3USMQpu3OtOlXL?=
 =?us-ascii?Q?6mfLCA4+Um/z1B0c7Y8nTzMilgCVDpNi/G9MYJ9ijrLUxZ+WQi2pgGVpV0CK?=
 =?us-ascii?Q?b1xEQHSVxxjO9bioiJDW0yC0mKPJGHN3EYm6r21yrceNZcJIKTzqrynIqkS/?=
 =?us-ascii?Q?cLbeW++WlmwqU02XrtLDCRjqdL2mFO/WPpgkKXlWqBbEkz9EGiWmsNgvtMZo?=
 =?us-ascii?Q?i4ZrbnA3ktHAD0MwCNPjqgA7QJmKwDtFE8lFpy0QzkBirYZhC9zRwTkSxGih?=
 =?us-ascii?Q?iSb/nMCD4OUfYXdvlV9JDKRApNOOy3KNcT07plNZLxtk5bDkwuADEKAt5mdL?=
 =?us-ascii?Q?HQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mKaQZCbrfFizh4sCUJSeAmfGE+eMhtOsaWa/V4DFSZCX4j1yi9tOBni3t89+EacJSa5GzGMEz7Pv8Bo+l2pfzB03JQeOuNh1/Yu0XR1IZJx9lL5TMwS/dZ8MmyyeJf21wf7PIJ4YWIKn+OpLYivTy8OJ8vU48CgSe8gcpEPi12ocK3pwmW1EM4q6YNW0QB6IGHvWiXZB4JWCa3ug3skBFnxyWVdUecGOXsAknWTEjy0upQkqu3y6KlmE/5+CWFg0AXhZI6NQNKUtpQ3MRbHpD88YZzEzJ6Oea6UyDK0n0BydnTrbujHPmtoiEs00XambQBPl47h0WN1mvdeUPnxLwMk5Jw9gN08avmnhnaeVSZIZnu4GebYFgCTV+4gtLGttZyll+I8fQw2NgSCvvjCkBLHI9TZ0rpUNWBlv3dKsDI1Dtj4Li3s7jDWg1jYWranOC2m/u5L3bu5sJUc+v2PbwhesolRBwkKz0AIMuCr2t2BDOb0RBrkxwHWJEGO8lYkAb4IoY7xKyT0xrQ7ENrLwGewegj/8PYF77arjZRMQ1NwxrkpTYDY3Wuj9eO46bwsHlyTkjhM8L5xo5foH6fcbel6V1pAA7I5/lUhIp952c80=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc31232-8b0f-47b4-aa7c-08ddf6b92fbc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 13:42:18.8437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FzCnrHqRCIr5rkA4sDgdSXywJ4MVjiSHgrNSqxrstfrUONiYVXdcVKk22rb9OlhzqItOZU4WqwfpvmZ+E5/nY91LUmmnD345rslXchbvuV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7005
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509180127
X-Proofpoint-GUID: NG7KF266I5VjHdkUSdu7kKFVW-oua8W7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXzwZbGAIIM3eD
 IJRFOvBaZzCEcvPtmmv0sb2d+eNzPZnklz/PtUOl55tS6hWn7ZNfPHYxPe2okW3Teps6NWLro4r
 iwzFmm+Tg4mk8jyrV5QnBnlRlWcvK8q6CCH3YQGyoXcvIpc1FYPdSubi/wFMDdhn1I/3lDZ5jsW
 cHfjYph7B6dTLDSqtGpeFrfTFnrcQtJCnBEtCoOz2Eea41TXnMUdII3QEio+0kV46+Ik9VQfa+a
 +jEN//av8XSoOhAGRXmXrr+IDnAx29KuYaIgxNFVwCfD8ppoJbyIQmHU5kUjizQpYXPi2/6WrxK
 GdeLt3iX1lcm7ZSXRabyXb9mSSFBW/+XiX8hIVamSxx3H6CeoV8LrXOFaCPtjge5bvQHxUcyBLz
 hdZCVCFE
X-Authority-Analysis: v=2.4 cv=cerSrmDM c=1 sm=1 tr=0 ts=68cc0c45 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=Z4Rwk6OoAAAA:8 a=20KFwNOVAAAA:8
 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=iNXwxGti1rFAzIZLLWQA:9
 a=CjuIK1q_8ugA:10 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-ORIG-GUID: NG7KF266I5VjHdkUSdu7kKFVW-oua8W7

On Mon, Sep 15, 2025 at 09:36:38AM -0700, Kalesh Singh wrote:
> Needed observability on in field devices can be collected with minimal
> overhead and can be toggled on and off. Event driven telemetry can be
> done with tracepoint BPF programs.
>
> The process comm is provided for aggregation across devices and tgid is
> to enable per-process aggregation per device.
>
> This allows for observing the distribution of such problems in the
> field, to deduce if there are legitimate bugs or if a bump to the limit is
> warranted.

It's not really a bug though is it? It's somebody running out of resources.

I'm not sure how useful this is really. But I'm open to being convinced!

I also wonder if this is better as a statistic? You'd figure out it was a
problem that way too right?

>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Pedro Falcato <pfalcato@suse.de>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>

This breaks the VMA tests, please make sure to always check them:

cc -I../shared -I. -I../../include -I../../arch/x86/include -I../../../lib -g -Og -Wall -D_LGPL_SOURCE -fsanitize=address -fsanitize=undefined    -c -o vma.o vma.c
In file included from vma.c:33:
../../../mm/vma.c:10:10: fatal error: trace/events/vma.h: No such file or directory
   10 | #include <trace/events/vma.h>
      |          ^~~~~~~~~~~~~~~~~~~~
compilation terminated.
make: *** [<builtin>: vma.o] Error 1

See below though, you've included this in the wrong place (I don't blame you,
perhaps we've not made this _very_ clear :)

> ---
>
> Chnages in v2:
>   - Add needed observability for operations failing due to the vma count limit,
>       per Minchan
>     (Since there isn't a common point for debug logging due checks being
>     external to the capacity based vma_count_remaining() helper. I used a
>     trace event for low overhead and to facilitate event driven telemetry
>     for in field devices)
>
>  include/trace/events/vma.h | 32 ++++++++++++++++++++++++++++++++

Do we really need a new file? We already have VMA-related tracepoints no?

Also if you add a new file you _have_ to update MAINTAINERS.

>  mm/mmap.c                  |  5 ++++-
>  mm/mremap.c                | 10 ++++++++--
>  mm/vma.c                   | 11 +++++++++--
>  4 files changed, 53 insertions(+), 5 deletions(-)
>  create mode 100644 include/trace/events/vma.h
>
> diff --git a/include/trace/events/vma.h b/include/trace/events/vma.h
> new file mode 100644
> index 000000000000..2fed63b0d0a6
> --- /dev/null
> +++ b/include/trace/events/vma.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM vma
> +
> +#if !defined(_TRACE_VMA_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_VMA_H
> +
> +#include <linux/tracepoint.h>
> +
> +TRACE_EVENT(max_vma_count_exceeded,
> +
> +	TP_PROTO(struct task_struct *task),
> +
> +	TP_ARGS(task),
> +
> +	TP_STRUCT__entry(
> +		__string(comm,	task->comm)
> +		__field(pid_t,	tgid)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(comm);
> +		__entry->tgid = task->tgid;
> +	),
> +
> +	TP_printk("comm=%s tgid=%d", __get_str(comm), __entry->tgid)
> +);
> +
> +#endif /*  _TRACE_VMA_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 30ddd550197e..0bb311bf48f3 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -56,6 +56,7 @@
>
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/mmap.h>
> +#include <trace/events/vma.h>
>
>  #include "internal.h"
>
> @@ -374,8 +375,10 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
>  		return -EOVERFLOW;
>
>  	/* Too many mappings? */
> -	if (!vma_count_remaining(mm))
> +	if (!vma_count_remaining(mm)) {
> +		trace_max_vma_count_exceeded(current);
>  		return -ENOMEM;
> +	}
>
>  	/*
>  	 * addr is returned from get_unmapped_area,
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 14d35d87e89b..f42ac05f0069 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -30,6 +30,8 @@
>  #include <asm/tlb.h>
>  #include <asm/pgalloc.h>
>
> +#include <trace/events/vma.h>
> +
>  #include "internal.h"
>
>  /* Classify the kind of remap operation being performed. */
> @@ -1040,8 +1042,10 @@ static unsigned long prep_move_vma(struct vma_remap_struct *vrm)
>  	 * We'd prefer to avoid failure later on in do_munmap:
>  	 * which may split one vma into three before unmapping.
>  	 */
> -	if (vma_count_remaining(current->mm) < 4)
> +	if (vma_count_remaining(current->mm) < 4) {
> +		trace_max_vma_count_exceeded(current);

But we didn't exceed it, we're guessing we might?

>  		return -ENOMEM;
> +	}
>
>  	if (vma->vm_ops && vma->vm_ops->may_split) {
>  		if (vma->vm_start != old_addr)
> @@ -1817,8 +1821,10 @@ static unsigned long check_mremap_params(struct vma_remap_struct *vrm)
>  	 * the threshold. In other words, is the current map count + 6 at or
>  	 * below the threshold? Otherwise return -ENOMEM here to be more safe.
>  	 */
> -	if (vma_count_remaining(current->mm) < 6)
> +	if (vma_count_remaining(current->mm) < 6) {
> +		trace_max_vma_count_exceeded(current);

Similar point here.

>  		return -ENOMEM;
> +	}
>
>  	return 0;
>  }
> diff --git a/mm/vma.c b/mm/vma.c
> index 0e4fcaebe209..692c33c3e84d 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -7,6 +7,8 @@
>  #include "vma_internal.h"
>  #include "vma.h"
>
> +#include <trace/events/vma.h>

Nope you don't do this :)

vma.c is designed to be userland testable and _intentionally_ puts all its
includes in vma_internal.h.

So you'd need to add this include over there, and then update the vma tests
vma_internal.h to stub out the trace function.

> +
>  struct mmap_state {
>  	struct mm_struct *mm;
>  	struct vma_iterator *vmi;
> @@ -621,8 +623,10 @@ __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  static int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  		     unsigned long addr, int new_below)
>  {
> -	if (!vma_count_remaining(vma->vm_mm))
> +	if (!vma_count_remaining(vma->vm_mm)) {
> +		trace_max_vma_count_exceeded(current);
>  		return -ENOMEM;
> +	}
>
>  	return __split_vma(vmi, vma, addr, new_below);
>  }
> @@ -1375,6 +1379,7 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
>  		 */
>  		if (vms->end < vms->vma->vm_end &&
>  		    !vma_count_remaining(vms->vma->vm_mm)) {
> +			trace_max_vma_count_exceeded(current);
>  			error = -ENOMEM;
>  			goto vma_count_exceeded;
>  		}
> @@ -2801,8 +2806,10 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT))
>  		return -ENOMEM;
>
> -	if (!vma_count_remaining(mm))
> +	if (!vma_count_remaining(mm)) {
> +		trace_max_vma_count_exceeded(current);
>  		return -ENOMEM;
> +	}
>
>  	if (security_vm_enough_memory_mm(mm, len >> PAGE_SHIFT))
>  		return -ENOMEM;
> --
> 2.51.0.384.g4c02a37b29-goog
>

Cheers, Lorenzo

