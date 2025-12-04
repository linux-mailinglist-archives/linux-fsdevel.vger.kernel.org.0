Return-Path: <linux-fsdevel+bounces-70690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 213C5CA4304
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 16:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92FD0319BCA2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 15:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7382D7395;
	Thu,  4 Dec 2025 15:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="TFaPNm5o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11021127.outbound.protection.outlook.com [40.93.194.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8486C26C3B0;
	Thu,  4 Dec 2025 15:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764860835; cv=fail; b=la0cdIyWRjJ+PjyuYsi0DcysB74ti4kw6qM2E6fllFzTE0yBGDgP+kysvEJmRO7MF73/bQMWhraaE0dcwEpoUGbz8rF95uhuEedJ00x3A1mQA23Mvle53l4ogNVkIs9wjdUeWvKd8phRSUCAr+/OT3/wNvYK4VHOk/xJejqkEPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764860835; c=relaxed/simple;
	bh=dX77E7827xttw6x1IbQWeUlKngNtf+zC8P1lK5PA0CM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gQvvkzv9/5qqGjDJdCGEiPK2CSiYC18GFnACxQQMrZhn3uWSC62ZbxWkmitr5WtvdC8eMwB7VRe2rQsytowCoI5csmEOo1BlS7ZMG9SNIndPIAuScSLyPud8wMz6IQzZWOVXeRR2fqyAfSkyuq6gH/+0ZzzidIjIwsPbkYZvfjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=TFaPNm5o; arc=fail smtp.client-ip=40.93.194.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yEpthyroXWmPlvsv2SzRI0nD/dGpE5oxUnKEuymqV/hkCIv5vghpGTWoo5NPL30KyYDjYnlhBKg3XnOcxbFCLHvoUXRDyfa1MojaZd/wqC0oETlXbQuhfMvsPFFOyY4fw654a1tmABR1XobCEQt3+LsXNwIyAeLc5Q8PzqF5ZelT0StjlZVnSLDiq+tfmrTKrVcZ0u2WCoTOMONfHSLSM4bzlbC13Ne8rePML6rn6et1Y6BRfxAbB9diR6tW43jncT2MwtsauL1Q9Yiyw67/tOg+s8NwqkpThe+xapYEd01T3mBcQZLRQA6G9qKVO102Knp05gmwvWsvYSTYrbjTTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNrqJoXNtQwD2Z7hdXi1T5q/YVuzq3lXiebVCOl5waU=;
 b=tHSYEoRuq2COP6L/nTHxW7Z904pa/ZjBlPiacEQud77H7eHTOJof43Dm5oQT5B38MB6LKq4yPF7vS7Rse6m+uVR8kuV/8Zwy68xIgpmO7dvepEamLqfwkHcBCbRxgXPhQrYAsE/E5s7M7RYTOm/+ZXQmbjqvLn9FbGVhMUDSfudYigZfZ7J5olARU9LFBvatvDR5E3Pxq1eOqHpq/tCmT3Qih1JuJOblrTLzbIiIb+pI8AanleUsbUkZZW3ZBvKRiBSdPUhRR936lLqWVK+QL4sg0lU0a5EIOOO9bS7ddIRbg5iNxs5MvIstDdw/Dv+VfX1PrIOtVI0mdxw3U4KHQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNrqJoXNtQwD2Z7hdXi1T5q/YVuzq3lXiebVCOl5waU=;
 b=TFaPNm5o2VnEGjphF+TcZ0qFDRtOuz3J+MRcKjbpAHMBh8uLAK1vg+aC2KTuJJRn0eQ7xFJBKgQEbx7Ti3yXKeqrJA0IvkRl0aQhjpCdEaIS0IKMHls6fqsbiM/i866INbajFGUs2xEJoHQfLkEfDtkln6M/GNRO0LnKF7tYR2M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from SN6PR13MB2365.namprd13.prod.outlook.com (2603:10b6:805:5a::14)
 by CH5PR13MB7642.namprd13.prod.outlook.com (2603:10b6:610:2f1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Thu, 4 Dec
 2025 15:05:56 +0000
Received: from SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d]) by SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d%7]) with mapi id 15.20.9388.009; Thu, 4 Dec 2025
 15:05:56 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Chuck Lever <chuck.lever@oracle.com>
Cc: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v4 0/3] Allow knfsd to use atomic_open()
Date: Thu, 04 Dec 2025 10:05:53 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <DD342E0A-00F3-4DC2-851D-D74E89E20A20@hammerspace.com>
In-Reply-To: <cover.1764259052.git.bcodding@hammerspace.com>
References: <cover.1764259052.git.bcodding@hammerspace.com>
Content-Type: text/plain
X-ClientProxiedBy: PH8PR21CA0009.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::26) To SN6PR13MB2365.namprd13.prod.outlook.com
 (2603:10b6:805:5a::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR13MB2365:EE_|CH5PR13MB7642:EE_
X-MS-Office365-Filtering-Correlation-Id: 389e6080-3f3b-411e-7c00-08de3346a01e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mVKlELs920+CCk3Y0OMQSJDySxpXuSoxnIf7UPL9TuZ+RZCLxJyW26ikshzE?=
 =?us-ascii?Q?MauqOaujfv8yDxC64+Q65n6KstsoimIsfniuObxD2I8ELKn8tDpHssjR/LD5?=
 =?us-ascii?Q?MIUyIlPzgwb/VKIhfQnqvrrdwrX0a3SCs8/PCP/5FCSb72cf9egI/UReLFA6?=
 =?us-ascii?Q?POxKtyJaKHDeF5IMZmY9SXB2UgAC7pHB1KFlyoSj9nRaJU/hK5i2//vAdlSL?=
 =?us-ascii?Q?RMc2zhOWaXKaQQfXjF3fXrqV7OS/g7x8IzgaqrwFzyHcaEaHsqwtknsaNJT1?=
 =?us-ascii?Q?CH1fAjopFjrhtlVbrvqj/3AApviLXVvoYvSQpkB75kw2gkfo+ug9rMXJfi7b?=
 =?us-ascii?Q?z7pi8XycbrhBO72H+tt7uXzNykBQGDakJAlmBAJsJ1IXTXUmK7/+QsBjS9j/?=
 =?us-ascii?Q?sPYzhaHHBTekNcDzFyYpxuwkyQNxznuYq0wo5q+QjM52p0xmiNL6tQSvyljx?=
 =?us-ascii?Q?FkE/UoF6DNrvy7Qr9Q8hrb5tPC5PGJAVyWtVxd4vChVln5KSPmK/0qJxKCKp?=
 =?us-ascii?Q?Bgr+SbBrGCj+MRXT2OuqNGbn5um7/83dS45r8Bxk2Aq9NIHTUe5GSYK572Qa?=
 =?us-ascii?Q?2lHfOUA+AQcCsAe6GUrNLrnp+/F18+NPCWkMxmoXP+pnbRSEZL889Ol4XK9N?=
 =?us-ascii?Q?zFHKnY+z68Dy9fJptzps0NBs8HpMtIJMBdS/20awmjGYZbVyFOfsGXX+/IWn?=
 =?us-ascii?Q?ev8Frqd922VbJhxAuPZpxk/5WYC4k9uhQiI57pb1WkluN3wjn0ZVhCc+2jKS?=
 =?us-ascii?Q?eW8gODcpcq7zMQqhbqBhpm/h8guHLCsPw6XMisJSVhnMqrryPe45Q4Bnodmw?=
 =?us-ascii?Q?WRa/uWsBeEyKZQ7ra/y+fH4lAdxU6DoC7JwHZosa1TghVeBJFneyIzam6wE1?=
 =?us-ascii?Q?nkZpNQlqnimibnWu+iKMcJjlT4JKzuV+aZeGfYYCSeimPjyj8xTjz5fZyAjF?=
 =?us-ascii?Q?zAiY0L1lwHSohunYVQTJBXFfiHJR/DSnkOKQMZtOsXoBjdX4hys/RheOarF/?=
 =?us-ascii?Q?+RTpMIVWyv9uTFCRqnJRWb+PeHR5jDg9HPEAm7N97FFadc8b4WXVwa++Z+md?=
 =?us-ascii?Q?6stwZkSpdRyjsshoHpZ5u1M1qcxO8ahTVkscwo2mH/DOYRcw+HB32mmciB/d?=
 =?us-ascii?Q?XZT+6WPxEP6bmEbepR1g/5u8MTiCkpFe0Go4rocVe6PUFwr0FntZGglvklm1?=
 =?us-ascii?Q?QO9boxKTUEwrJ6UBIZGg6RUY03F/eavYD5B3cwJIRh/Gv1R8rqQn1nsNsEEV?=
 =?us-ascii?Q?rUEKoUTS+njOksyUEomAzz+mHqEgDmlnNIA7bbmQ6R8iJTTXvC+g67tKddN6?=
 =?us-ascii?Q?W5N+8M3pVVBzRCzCsPIOaQuPNLiPYuhe4YSSbEfwKcrhwzfdba4MRhCDj3/e?=
 =?us-ascii?Q?OsSFwfcQPYrAUQ3WFYPvafcpK+NMwZcvQgjQ0E2RMo+3yHZBDaVDP0S1gnJ2?=
 =?us-ascii?Q?KChx8m/yVsLiIxnmmEv3vts2varp95A8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR13MB2365.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jAOa5uFlnJcpGlCMaf3zUaThdQlJzsERmhk0zJZN0YDmLS4fWpPzItpiQPJr?=
 =?us-ascii?Q?yehe6JfDUo8mwWVn2GQPeLCheXmf2eB1i6YaWMYfVMUkLlK5vojiv+kv29Mz?=
 =?us-ascii?Q?wBP8qPYEDTHr2eGXsAE44BE35iAfJDkd5p5qlkXm5EOBr/zUog7Qav/9pWj1?=
 =?us-ascii?Q?VbkBQbiEDq7H2lmiizf73ZAtD7Zjiv6Wfa8g06tm9VXi3dFLt6g+pvuW2/34?=
 =?us-ascii?Q?/ij6FNOs/yiAk/AGrqpbm+sDKybB/+ah8Hks1bGUWvDCzDbOwA0wxIwMxlwX?=
 =?us-ascii?Q?FLgjE0ymCKhChjNjt64DQMpB76dH23gzRCXWLb4CA/O7xTFxevK8sO27CXL2?=
 =?us-ascii?Q?DDpVGmarWL6yzBVVGPCwR/+y2MT8d3ZebXLAGM9jfBgcGKdpgbmIqP5rzmnz?=
 =?us-ascii?Q?S9HwyOXr+cZepEzC2Pnf0npyJ4EdvrSaPDI2TDGO7Nvgyjc3RU0gx4bzWNPo?=
 =?us-ascii?Q?lZ3Twqe7NUUi+xxP5X/03paSWtcnSFfVhsdrQg7YVbXs18xY9jHXqfxpUqJa?=
 =?us-ascii?Q?oBV/k/bPXJzuWDOFzzIhXMC+s9yxqyrchqZzZ76k4C3zsvn8lXwEfaDk8bOf?=
 =?us-ascii?Q?ZruZ4mldJlBRitfyZAJz30eSOresHYI+1ygqLvdCvjyv91GwGJH6LGAaxm4W?=
 =?us-ascii?Q?Y2MTLnLom/TWZq8/RM4ICisQfrSTspUNrEu/cLjKMFITo6BbBpVGS+oFMc+H?=
 =?us-ascii?Q?ZTj6Lp7KaPkUZvKWeSw6hGxzXOlvV/G8/WZY7NZXOrRbEIrO/G69rGAgscXA?=
 =?us-ascii?Q?3zYL+CuFSmC+vauEYQbgg4yblogFEjas0rUF2f2RqscKzdgHBSiNw+2q0jZv?=
 =?us-ascii?Q?l/hcsf3ARr34jGVPdSA5FpC1LYlqr5VMIfXTcAfo40Vk+BcRQ8RUUJS09qHY?=
 =?us-ascii?Q?f1+3hkn7aet9RrYa/KnZK/g6hisR0NGYC774CJsgXrfUWmFKdVzNCiX+zLwq?=
 =?us-ascii?Q?vbgv/or2K8CF2cs+SrDLy0SvG7uoqgkf4FWaYiREGpsCpihy1jBbFSD4j8Fv?=
 =?us-ascii?Q?+3NLlUQHadurvmLF9iaz+1bSyX7bEqZ9wdYCAKgRLsIRVn7rcv7wykZWy70R?=
 =?us-ascii?Q?zM03mCzFcKyE62qvs/3UCNRlT0qTaB4bOOi0SZhVidaLohTI1YlSP0VSze92?=
 =?us-ascii?Q?ZybIUtVScgzlCv99E5C34VpTIK0x5VAdjck4BxsyA+A7Fo8M2vWhjfbpDV2R?=
 =?us-ascii?Q?eiYcsMo+rDgbGC6klWlgHjH5tEw9SrBiMalKrcJhcWhKJXkZPquD4d3Lxi9K?=
 =?us-ascii?Q?XJ/W0SJ7qufS/3V80IZXW6RpnoLnqhaAj0WMPVhB21WPS8rTYDAVh8fEhplf?=
 =?us-ascii?Q?R4aSeu7IJ8mYiiw5tEsOkI5pqIwFdoXnIR62B/YGcXxwVYrVlawfvvSJlbDq?=
 =?us-ascii?Q?iJRGdm3MrrYDRttwP9ebazBQonkrpmam/QgHQa3GePTAc2B3NGFT8ugWaMbN?=
 =?us-ascii?Q?ksl6p1mXcvQs8U9SwA6iJBTY1IIcpYW8uFKkLjFn1yKSYwmYt9lA7rp7Z6GD?=
 =?us-ascii?Q?2QnE/t0gBXq5XIMOHCDdU8Ru9gSUM54yQ5O9Rdp27wHLjOuifHa+bInCA4Hc?=
 =?us-ascii?Q?gYS0cwPlq3pAr0dAI+0Txvt/a3IjoB287YyWMx+MB15evnZo+0lAgjflxLUB?=
 =?us-ascii?Q?tg=3D=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 389e6080-3f3b-411e-7c00-08de3346a01e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR13MB2365.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 15:05:56.1117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D9+18IU3wHig7uXNJNTsQaHLR6uPRp7T5O0qM2EG2FRJRJ4yGPcPtEpD74gcCJ3VazxWnGxvtXDDqaEBMLOXyveIau3/6rbpsB1Vum9IPcY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR13MB7642

Hi Chuck, Christian, Al,

Comments have died down.  I have some review on this one, and quite a lot of
testing in-house.  What else can I do to get this into linux-next on this
cycle?

Ben

On 27 Nov 2025, at 11:02, Benjamin Coddington wrote:

> We have workloads that will benefit from allowing knfsd to use atomic_open()
> in the open/create path.  There are two benefits; the first is the original
> matter of correctness: when knfsd must perform both vfs_create() and
> vfs_open() in series there can be races or error results that cause the
> caller to receive unexpected results.  The second benefit is that for some
> network filesystems, we can reduce the number of remote round-trip
> operations by using a single atomic_open() path which provides a performance
> benefit.
>
> I've implemented this with the simplest possible change - by modifying
> dentry_create() which has a single user: knfsd.  The changes cause us to
> insert ourselves part-way into the previously closed/static atomic_open()
> path, so I expect VFS folks to have some good ideas about potentially
> superior approaches.
>
> Previous work on commit fb70bf124b05 ("NFSD: Instantiate a struct file when
> creating a regular NFSv4 file") addressed most of the atomicity issues, but
> there are still a few gaps on network filesystems.
>
> The problem was noticed on a test that did open O_CREAT with mode 0 which
> will succeed in creating the file but will return -EACCES from vfs_open() -
> this specific test is mentioned in 3/3 description.
>
> Also, Trond notes that independently of the permissions issues, atomic_open
> also solves races in open(O_CREAT|O_TRUNC). The NFS client now uses it for
> both NFSv4 and NFSv3 for that reason.  See commit 7c6c5249f061 "NFS: add
> atomic_open for NFSv3 to handle O_TRUNC correctly."
>
> Changes on v4:
> 	- ensure we pass O_EXCL for NFS4_CREATE_EXCLUSIVE and
>   NFS4_CREATE_EXCLUSIVE4_1, thanks to Neil Brown
>
> Changes on v3:
> 	- rebased onto v6.18-rc7
> 	- R-b on 3/3 thanks to Chuck Lever
>
> Changes on v2:
> 	- R-b thanks to Jeff Layton
> 	- improvements to patch descriptions thanks to Chuck Lever, Neil
>   Brown, and Trond Myklebust
> 	- improvements to dentry_create()'s doc comment to clarify dentry
>   handling thanks to Mike Snitzer
>
> Thanks for any additional comment and critique.  gobble gobble
>
>
> Benjamin Coddington (3):
>   VFS: move dentry_create() from fs/open.c to fs/namei.c
>   VFS: Prepare atomic_open() for dentry_create()
>   VFS/knfsd: Teach dentry_create() to use atomic_open()
>
>  fs/namei.c         | 86 ++++++++++++++++++++++++++++++++++++++++++----
>  fs/nfsd/nfs4proc.c | 11 ++++--
>  fs/open.c          | 41 ----------------------
>  include/linux/fs.h |  2 +-
>  4 files changed, 88 insertions(+), 52 deletions(-)
>
> -- 
> 2.50.1

