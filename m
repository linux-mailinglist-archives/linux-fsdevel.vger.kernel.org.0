Return-Path: <linux-fsdevel+bounces-69009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B74C6B429
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 19:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B3BC03661A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 18:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9F42DE1FE;
	Tue, 18 Nov 2025 18:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="XgdFi+PX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11021091.outbound.protection.outlook.com [40.93.194.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2722D9EFA;
	Tue, 18 Nov 2025 18:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763491200; cv=fail; b=DPFezigv6J5gIADnd/kwgCYKWn5Sa07Lmsn7E/GQQ3KJdI/C1Fluuhb2rk/O134rBbDJZ7AdcJ9MggqvuxuYnmM1IEnSYIdsJGUPdqguHT+zqgNnxoh93k4L6QfqMlLdsYe1EQbDcyLvxggniKjjyH5VPmZ2ChMIv3OMc8rO5Oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763491200; c=relaxed/simple;
	bh=m/Q/5KtjimuNaVrQ3e47obagcAYMNAEfm8p2aaZTREg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VxnNVhA0AVPvcCZLo55SNJlE3R6AmNUStC8k6hDiJwp9CHSP9kpw8S6Mvo9VuVNnsLvWKBN2VaoxedQJTIyhR2rKZMDGHXT1ao1ort8aXjSF4/uGLkOOW5CvFNhpLe5pk6RA0iLQh5XsDZPPsY8WvSbES/EGwvqP3yl8pXjfGaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=XgdFi+PX; arc=fail smtp.client-ip=40.93.194.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tOuNnm6N1mkmAzR2bRYzm8KNLS5kkkdsmgnammQj5G0xdx1eVI7cTaPWFpynfCAstARJnnjHPXEfYOTfyINEX/IPIFFf2cN7v8m2aT1X/Jte2NDYmLE7EaN7PahL1PvUfSzZ3e5n5XvlBLB2w+F+ZPbuYXaZeyhewWPWGjmhVRP6HKcPnbmcR8A8txEF1UrHxwYKhhlo3sxcL3AyN27LDeSPETxcza0fAuyFK8IVLHCGI0G8ClggRI/RS6vT1GsvWFEkpc8hfrLW8GxbSjmf0gLWlsUrzpilm43wGwPt/TRbO4TUxOyGrVTFvlUrtTBXpvo2y2nFi8z8/5/r//BVaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EqxmavjKab8fyJzi8taDnn+RbKsk48W2IELV5s45SCA=;
 b=w4BqMPUgLxfocgwaCVB7XEuPFNOOzZ/0FcX5zSZ/zlJut7bbT540eNfehn4ne1LGK5+NupA2BiIrgtqCf9nLy5f/3qFLHgqsf+xfgs1RywYEwUKthN3mpyn1tD5lib9rvyhjz0NHSZrKvLt0njj1T/tzjSjXxq8L2WfK33N8XKiAK2L5YX8U9Vo9xpQVM+EgT4NWT2RfncTlPaiRU+DSone34tosolqV7x5ttl6vphMH4YcN0RQZRzoCn9P9yMYP7RGpIBZlioU5TTq5pa2b/l64+beb8NI/LyGVCIMqCtujbeM22Ll796EJd2UKfQMU2xXeABsQMgJluEY9R8crnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EqxmavjKab8fyJzi8taDnn+RbKsk48W2IELV5s45SCA=;
 b=XgdFi+PX6d4GZXcmInJuFkB5eRH2Mb1kVutrwqHz+WtJPcwNxKcKU0Ue3KMeLvsH/yirUid8imLmwVXQ3oH3BWlf+VHxh7/pJ/hH/QueeD8B4m0d10shVNlfZGq6RlBrgv4xaGYdRxLUTM4p1C8xrD3XzDZJYCRcqub9feMNjls=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from SN6PR13MB2365.namprd13.prod.outlook.com (2603:10b6:805:5a::14)
 by PH0PR13MB4780.namprd13.prod.outlook.com (2603:10b6:510:79::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Tue, 18 Nov
 2025 18:39:55 +0000
Received: from SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d]) by SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d%7]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 18:39:55 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>
Subject: Re: [PATCH v1 3/3] VFS/knfsd: Teach dentry_create() to use
 atomic_open()
Date: Tue, 18 Nov 2025 13:39:51 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <A0B89B6B-A025-47EB-A54B-79384ACABBEB@hammerspace.com>
In-Reply-To: <aRy0Yp-GvUrD3uJY@kernel.org>
References: <cover.1763483341.git.bcodding@hammerspace.com>
 <149570774f6cb48bf469514ca37cd636612f49b1.1763483341.git.bcodding@hammerspace.com>
 <aRy0Yp-GvUrD3uJY@kernel.org>
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0011.namprd17.prod.outlook.com
 (2603:10b6:510:324::20) To SN6PR13MB2365.namprd13.prod.outlook.com
 (2603:10b6:805:5a::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR13MB2365:EE_|PH0PR13MB4780:EE_
X-MS-Office365-Filtering-Correlation-Id: fc151313-86b2-43ff-3518-08de26d1de27
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9eFejTt0m6bALdUjvlGtPq6ZIQfI7xdDaMEy8+SohKt2nXRopd+gHGr9hh14?=
 =?us-ascii?Q?rvqqBtDIsJRvtuCa2OsJkVy0fgYGBX7edUGBgCj7VKEtKt38+95kKSPWFpQz?=
 =?us-ascii?Q?FOSVVotu5ELJsKrfNAEnqvCLJQ20SJ+TGiirygZgjE0ZdVGDbkRFDyrx9+qg?=
 =?us-ascii?Q?lhFadszl9hA619UiIVg8jdX0VGxPfNVpwwrmTe3S35VYPxwLKxgLc1Itwi9p?=
 =?us-ascii?Q?ugCXixDQ3BeePNZGWCKHalw92QbQIf8GQuL0JWG4i/5Ar30iMRac/fFRK36D?=
 =?us-ascii?Q?NdTIuktgeC/cjvhY/Gns/ywnf/uz0j1hLEA/Nolo1Z+PsZfjemVBNGLnh5Bl?=
 =?us-ascii?Q?cXVLHzQBC2oYQZIQmyaA23FK4DV4tHcz5Kjs1yQOz6Iafzcac0CAiBihaOSJ?=
 =?us-ascii?Q?B6O/lfwZgj/j4xlzDHjPNhI5s3lOI9couNYXxNVKK4oLDwQKCuAg2o5T21Kj?=
 =?us-ascii?Q?y9IkEvDzJjIBRwanTjaKp1HeLY4WuaSeSNw2Tf2WaYwYn9hOV3lz6z+Igbhi?=
 =?us-ascii?Q?yuAg+78KAljopLd2DHOjaIJRQdmflGuuRuo8ytBRmAvWonBJFNYI/01VRrco?=
 =?us-ascii?Q?XYN2y0++1qALN3w1EZkRBIkfNPPMSYYwTMeQWDZqkGS2hOI9smkG2M5v+9xw?=
 =?us-ascii?Q?n+WqiYiWXcDbAKNUxBmacsWiGx4Bvg9yrk/IKHQjUeeljXrM/CLldzT55hFX?=
 =?us-ascii?Q?jbicjTe56LoKdMuWjuS0C//zsncF3lH6Xti0B1Uy+f+g8QRoFDDaBPSjEJCC?=
 =?us-ascii?Q?tudrrrVcgqW/yx7Sq4w3fbgj7kpppUKPdAmaJdO7P8QPkh3+Va21jvFOWPSX?=
 =?us-ascii?Q?ilL21i5Dr+O83Uklc5npUKPdyUrhmpyhrSKulR6jxx1+rqzpnByRor2+KHvu?=
 =?us-ascii?Q?upAl3h94BVE4edlyZ6Zk1AZ1kqMDXeTNCrxtzgj86Sbvqu1ksSWBQJYn7S7z?=
 =?us-ascii?Q?jwEWWfuPd5clnFtH7FpYeyaNKhzIJaa2wP8E22AjRWfJW+ts80siz+SHakeR?=
 =?us-ascii?Q?bpFaCpa917mJt+AF5L/AZycwUXepWnCu3huXfc0hoUmA1DHihzyoYmXRx57I?=
 =?us-ascii?Q?FraKJlrhtUASEZwZeL9i4EZAFIVA+GF5fagNbjN6pJhtgjrH9/bhYzxDL5c5?=
 =?us-ascii?Q?bzHLakT/4UAdp6eJVbpoK8RwJ6Zqi0y8luidnaVbr0rO1PaOSpmNNmwO3JJ1?=
 =?us-ascii?Q?0L/UIbU3/DJRmOtu7Zx97sOOy9lSjaGpwuh4jvKbqB7sKJQ3Dmro6wJ60zqP?=
 =?us-ascii?Q?XNSLAVKhtXs9Jg6ler1+NVYNIgaOshvrsB3kHuUKRwVZ9PPF2/K4cwUM9MQN?=
 =?us-ascii?Q?4LeHcCIz5owsDb3pKkQkrHw/0ZUKlLXQZlh9EILB+VFfqrm6el6c3Wqh6cl6?=
 =?us-ascii?Q?R+rP6CyvzCZJl+p/dicM2PDiiU4yTT05OZ9PAXcQKWKqcAVIWim1FwQSB5p8?=
 =?us-ascii?Q?dprMn1oIudSEHEVifZhU+2pheliyDDKb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR13MB2365.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UhTxhHORAiQDWz7KXMFbU+9Q9sqRqx+NmkG4HwJtvJbR7m0ZwpKXRdX2OzU8?=
 =?us-ascii?Q?3wibzmWONJOvOqbhkmBqPEBRmk+mbFV2aoVbsVJgReRoWzuHgirThF+zeEUS?=
 =?us-ascii?Q?P+famerw4J+mChlSkFkyTHvUlKbrHHHh+ci4KbAs9tpd8w7a3pKSpZbKat+Q?=
 =?us-ascii?Q?JAuays7QLy+Nzlw1YEIzD3nO0GERKrjk8suW/MtXjxLtD3oDVrwDQwHkcEkl?=
 =?us-ascii?Q?5JGqc9w1aNCQe5gJgGGDb4AVfx7wZDfIdVlkfwgZA0HCgpDPnugd/y2i5LUo?=
 =?us-ascii?Q?B8Y+PSSnWL0BfxNkFE9a7zYwl+SxzpJUjvtVNSg9ZLJq8b+9VqfVWFstL6SA?=
 =?us-ascii?Q?D6fN9wk6FZck68eOHMu4+aEY0zOrv3ytexVSaoIDm2DsXCfB1HZodcQYokAK?=
 =?us-ascii?Q?cSY5dFMlwKjVDcMjTTjbNi64+w9YUoNkwYQ8z0mTVFcon9STlvwK8YIQmHOH?=
 =?us-ascii?Q?bS3iItbaf5kF+BF0GCet8EIMsnJin6Jgs6CRzGcqw/+VWRWgQPs+ktT6XRPC?=
 =?us-ascii?Q?pdzAQqIaM2e0UYlQYtodGSRwBJ60jibF2dd6EdH/ib6wT2D7O6O8OUL8jiv7?=
 =?us-ascii?Q?K+6SVa8zHhJSDYk/lr6DzLWmRVnisss9sLEUmNzHA24ArmPSW8MdemK221xZ?=
 =?us-ascii?Q?sdWck60b4avyPlKWio3g0c8Lz3Jwx5eyXrZqjsnl3++Wx5sAYph50toTx6oH?=
 =?us-ascii?Q?qeN5DdKXTCf0H9Ks3cVMR6B6W03WY7q79g3ObDJvdKcLTejfpXnjFUNBvSJf?=
 =?us-ascii?Q?ILZG7KJLVx8EPRl5d9aSB7ZeHftKzK7SDTr+gvBoTkRk14BPfOZN6zPKww/A?=
 =?us-ascii?Q?rSv2ZzsGw8Yded9aglNiPZkOs4yzAgvDPQxfnApsiebu/w0GyrFH2L4cuU53?=
 =?us-ascii?Q?2kp5nK958N4H1qOd09kyJcBKV3o795idngsdVPRl8MEld7zvVzv61Crvuj7L?=
 =?us-ascii?Q?h6VlHMSh1r0ClxUQAFuJ0oNTqW/P7Czb+j0uMYKoOu3A0jNZmFM4vxYIBxh5?=
 =?us-ascii?Q?nF/oz3m7cDjGCtv1KAmLUdzYObrN7lvM178NNTTcsDvmD0ENgDypRfEetNlA?=
 =?us-ascii?Q?DS79RRbGCmnTCCl6i7xIsJ8n3V7HAIGJOMVrGouPeF1WLPAZlF3TpIz2o22T?=
 =?us-ascii?Q?MRgqrE3SxcR9LMUZQir9qiAYWIhF4JeOuGHw7TPgxbs1CHg+0+Hk+q5Sa83t?=
 =?us-ascii?Q?GoOPnvXeBGSRU9Jj5YvOjfZ9IejAzT0HFXOw45MSA1kU8ZBjDHhhN6opNHCz?=
 =?us-ascii?Q?lQ9oTxd++B7h3b3Mrhtp0Sgai2SaxypQh3HTHH5a664H44MzD8cNqfTeDziO?=
 =?us-ascii?Q?AeY+JJSRgrz3YmULurnZm2SftV/TL5zF3AvCUi6qIuSf4SKanW2NmZW0BKvj?=
 =?us-ascii?Q?pwqEdT6uinYK36FUVNjj5sA6PkRLInvqPMCL3+s9q0qAfnKhy68Snvj8uK3E?=
 =?us-ascii?Q?9CwzHhEcczl939Pi2frF78KtRoGd69bGdibgbMV2wW/fr+FjnjdorF6eV+fW?=
 =?us-ascii?Q?y2XvYaCAcOnkuxBIWJ8mApwYRs2dCB3KayoHW2ko9LEk8aDjZkZrlA8lqm+g?=
 =?us-ascii?Q?O9bLImTH2zqNOhxWTuTz3fhjx9ouJ/9xVTatvFX+PL5LQNzy08RlFk9n7S5+?=
 =?us-ascii?Q?8Q=3D=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc151313-86b2-43ff-3518-08de26d1de27
X-MS-Exchange-CrossTenant-AuthSource: SN6PR13MB2365.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 18:39:55.1944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DwaBoZ0kHhZck0UY9yijQDx+3RDe08DuXLYtUZh68BWDLEn4/NPqOcdZwGZocH33ZsJ8RBxCrJKuLooc81eRoy8XY8SNJyqNRQOLw6jUFz4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB4780

On 18 Nov 2025, at 13:01, Mike Snitzer wrote:

> On Tue, Nov 18, 2025 at 11:33:59AM -0500, Benjamin Coddington wrote:
>
>>  	path.mnt = fhp->fh_export->ex_path.mnt;
>> -	path.dentry = child;
>> +	path.dentry = *child;
>>  	filp = dentry_create(&path, oflags, open->op_iattr.ia_mode,
>>  			     current_cred());
>> +	*child = path.dentry;
>> +
>>  	if (IS_ERR(filp))
>>  		return nfserrno(PTR_ERR(filp));
>>
>
> Given the potential for side-effect due to dentry_create() now using
> atomic_open() if available, I think you'd do well to update the
> comment block above dentry_create to make it clear that the caller
> really should pass along the dentry (regardless of whether
> dentry_create returns an ERR_PTR).

I will update the comment block to make it clear that the dentry you sent on
@path may be changed.

Ben

