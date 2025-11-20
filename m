Return-Path: <linux-fsdevel+bounces-69274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B513CC763B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 21:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8F90C354257
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 20:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E391B313260;
	Thu, 20 Nov 2025 20:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="MzdRO598"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11021107.outbound.protection.outlook.com [40.93.194.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6F2305940;
	Thu, 20 Nov 2025 20:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763671714; cv=fail; b=FyGeebyxPIvKMC18/K7ZjlyqXXRx44H2o2aVlFHkwOKPBa31+N1gdZgGisCMF6G/CqzHW90ec7YBspzCFUo86XnFLzFvHP28FSg74If/NieEFvKZ/EbhzToVcYqJ0vkEqDfATfI9mA08Lwgh7LzjpjH+PI1IRt7bfwQCUPU1aFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763671714; c=relaxed/simple;
	bh=gobMV9eV56sfmJwSBIvnCYWDGP68yivjBAUo1o0tgZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z/k+Ij5yKV/OEqHfrx/mrBAQM0U/bsxG2PuOXKCgq/YvyL6vs6J4+6UyPaumOdUZow0jKZTG37SA1MAegOMe3808f/GW59ktcbvdSO1S8+o+lNwB8Ks1s2hMf/WUOC9iurplClf7B56p93h9mRQG6Sj9wPd3GjZ0js9PhSGSrcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=MzdRO598; arc=fail smtp.client-ip=40.93.194.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oYJ32RFVIIA/w7k7Vd6Z363Q90BvP2heCPn7Cl2NBqnFG6NcRF97a0B3e+WPZBL5If3/2actWDYEb9eUoR6BfpPCLWLNblVXojvs7P3TZvxljkh+ta6u8gFIqEcGTBQZivzBY0cAlsrkLhEnO89J2u/JcpB2zwf/49El2cHr9sETQiiKT11ehXORRdxO4UPcBbLt1JIvJSgEL4LMAEoyCecZZ5ybOGo2PAo+Vr/lRku97hYaCBqptpwZw60h7LPO80q/Bobl6vNv1zb0mJC27Fx7cwtQWnyuuCew7KqNyPlWwM8M1KSZBfovCRyANzRcxNZXE8GCQPGGpzfbFud+Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rGSEhdM5YCAuXicLRDmV8GJI0Jxk8FE4McRpmkZyfU=;
 b=AEt6w3TTRpPnFVoBPC9UbWsGR9zVSu9GhfGid8j6QpDztR4RGI87ANI7NRca6G6CDVfS9hhootkJzauugZdQ20yDxbXL7Ial/UPVwa2hwiUbWVWrRNq6+IOVZZmowcHaKq5BX91wHoRuclZgX4s4p+qZ56jqHzSXhKF555Epv5nF24NJ+3Xf4DwpJgFWBOupznsgfMQDUwC4u9BGPOu8vIHhvaMsAt9H9SCN1OATg6ZLSiHIPaB0HxOCKTbyrJe5936DiqPbmyKToSjcVI/3EqWs5jRBYSWC9RgPpz/fXM/yCWWpPEtt8esiuHuDUlCHJI25jmDeHJ+gY/2SsWOA5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rGSEhdM5YCAuXicLRDmV8GJI0Jxk8FE4McRpmkZyfU=;
 b=MzdRO598iY80PIxbJotPB/EswcHLg9YGxPqon/cHCDsJlmzE9O5HgEA4llbG8rH/+IzUv1xQWQSU9aFCMLNeqpTXLeCZVbDv0f8KWP62g0Ol7+arIX2wAi6YlZagsE7yKQNs7/kzvqdLQROVfAHpds0nO6UymPqps7v7hDzoH8k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from SN6PR13MB2365.namprd13.prod.outlook.com (2603:10b6:805:5a::14)
 by BLAPR13MB4660.namprd13.prod.outlook.com (2603:10b6:208:321::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 20:48:28 +0000
Received: from SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d]) by SN6PR13MB2365.namprd13.prod.outlook.com
 ([fe80::9127:c65a:b5c5:a9d%7]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 20:48:28 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>,
 Mike Snitzer <snitzer@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 3/3] VFS/knfsd: Teach dentry_create() to use
 atomic_open()
Date: Thu, 20 Nov 2025 15:48:24 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <845984BB-7A05-4A4C-8EAD-C28C93D43679@hammerspace.com>
In-Reply-To: <b718b3c2-d19e-42c7-a29e-5e07319e2439@oracle.com>
References: <cover.1763653605.git.bcodding@hammerspace.com>
 <d7405b554e3b12a037dbce4b9db29394d87183d1.1763653605.git.bcodding@hammerspace.com>
 <b718b3c2-d19e-42c7-a29e-5e07319e2439@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: PH8PR07CA0033.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::20) To SN6PR13MB2365.namprd13.prod.outlook.com
 (2603:10b6:805:5a::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR13MB2365:EE_|BLAPR13MB4660:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a514b28-55a1-4d2e-67aa-08de28762887
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sbL9EnSM7K9FG4pQ1WlptklHgRQHu1jCwTTVZwIOxtZGw7Vr3t/LttUGFQNz?=
 =?us-ascii?Q?0lrco+aOEy6VkTutosU2q6fmrD8OXjAHz/uOTCrThDu8gRt2vJCVe98cFyWx?=
 =?us-ascii?Q?wASvYH31yaEpXVeFLG9ir+7evLKfLeli1M4O3fBkmk7oYV3wsnwWjX1HDbdh?=
 =?us-ascii?Q?a0z3+hD/NZwy6jmgcc30WGbYjC6Q7UknbfWERfA+yE+a8Ri/sMl5hxQbRBz/?=
 =?us-ascii?Q?ArUi7zFz5kBdtNrcaPcm2TjRLjHf+UQr/rrlhGSsseODkEa0ln9BoUxqBsE8?=
 =?us-ascii?Q?wuILnX+PXHJ8scwLEBApt2//CL8clKIb3rH7LXMOHmkiZW04hzPM72DuoCAD?=
 =?us-ascii?Q?7mo+8aA8d+m3AVOGLFH5MbpYnRscBru1rONC7gCz6pWGcUQDSptDoivta5dQ?=
 =?us-ascii?Q?yL6WorAsdSfzOdeJZj8Te1y8hZAA65vKfdMCJgblJvmTHFCYaqAx6trviPdS?=
 =?us-ascii?Q?D/LsO8dkv3jatJVTjdNbdeh87CC1p9p+6mDrou/RCVmBaA6YTZKjn4c5jLca?=
 =?us-ascii?Q?wz7bnqtEbu+LGSB3YQbsMdOXyJivO5EXsBx8APw8pumvnpnlVnPomvNSTjuO?=
 =?us-ascii?Q?cfONH15e9vKpa8Ah6LqUQOzP+bBNX3h5EWaiEplBmb/ej0D61tBDN7FBSmH2?=
 =?us-ascii?Q?UEM3oNjwR1x2zkLv5RglMzteTlsGKqEA4QjKZQ3fJZjQOzHqmXnfx+FjueVk?=
 =?us-ascii?Q?Uwn+fqKTi77TykyivEPd2lYtxrNKXIDBKcYYnq3N0rMZYJPZ2w8bBNDEkMTx?=
 =?us-ascii?Q?8STY9lV2rJEq9QKCXeSDLfe8uJFu8dUl79VEYQdhi6lrFUMi6Bl1b938wTBh?=
 =?us-ascii?Q?EsqR3S7SZfYnf+hQcgQ9P2+BHTebZn+31yV+iuhwKi34LoVPXkhicYhPG9Iq?=
 =?us-ascii?Q?5ANeNAw9r+Boz1XmOO8cpbq3pRqGvyDVBOMBLA9sZafmpSS9wSHBGjLdu7zE?=
 =?us-ascii?Q?H1QNT9qlmp6PAeAQCeHCKIfQsNeFGP9xpK9f8QIV3gbfeAdzhKGAcfsvjNDt?=
 =?us-ascii?Q?KQHzf0ZKnSCQm4dreTJyi8obVeg9V1XUhqVLfzpkuE7ip0sD4inFYjKwmo2K?=
 =?us-ascii?Q?GMgAKvvC5ZScuY64wedQSCb7DAT2E7OGJi4htsfhwmnACrfz4brhD2T0cUUG?=
 =?us-ascii?Q?A6OCnNiUx6ns1/OjZYVb5oeRJY8EObM1p+qE79aj0AqYw/jTn0x0xlC2mxdz?=
 =?us-ascii?Q?ow/kHZUTLCkDe/fa0MRbUNifGnUKK0daMtpF7kwwMhi9L/OhjVNSsJXh3KES?=
 =?us-ascii?Q?GSv4Rb2R3fKSUADjiXE3dMujpx0BEFCzTYA+oxFcwNhyYo9MGiGFlUt2JoZ9?=
 =?us-ascii?Q?p6pcMsM6v0X11uZm2/39bxHflIFFtcK38QpxGqQGJhfAX/EEHGGzKmfAA8nu?=
 =?us-ascii?Q?vdXODLP3Cgsn/m+uNCOLWz/IQEBYeS/Dj+2HuQTGuyUBvBXVtd7uxIBsdj5V?=
 =?us-ascii?Q?3cKUj/6jLutPsl9OQ88AWNG0Z8Vm3Df8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR13MB2365.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uiKNqMchE+ZS5X0BN/DMmwztTTFZDR3TW8o1F+gFkswirCtonpV9DJvtswML?=
 =?us-ascii?Q?O+0Gr5vTlfMkBto9O2mfiZgrnjD9kYihUe2eBWn010r0AJ7+8TcxnPgZ5qbW?=
 =?us-ascii?Q?YO6q3zcwPqcPd1yG6bNEIpEOrY5Gmqo+eL7kjr1ZXZP3WDrQOikO51IrC3X/?=
 =?us-ascii?Q?5T78lwxLXccZUZotLUSbJL8yarlusGeafGFUhBsmDYhyr+urT4khQ88UIzf2?=
 =?us-ascii?Q?0CRra65V74Sq+/Q1MCe9lV+9N6UCy9HBHVBByU3wHjsBVRSowmRMC2VmARpU?=
 =?us-ascii?Q?hLXRYJNYdihosW0RAygHAzThe79ognRzA+DlgZP/6HoeXOjuFm2NoTPKeJ45?=
 =?us-ascii?Q?urW9bTNkVRMZgWeHMJ4VNY9NuOO51u0UZLXa/vq+TQ8c2tTTbtr/XSKMjLk0?=
 =?us-ascii?Q?wsNwdrYxWCyO+raSceAVZmlKlBLhoUdBi66Q77he5yNhGSYd/OLyWtAWgw/Q?=
 =?us-ascii?Q?F8QMpjFuVezJirynHqguq3guQ5iOyWrXE9r6G+kEOkWtP425hREH8Qo8FVzr?=
 =?us-ascii?Q?UCYlKvo3WfasiMBnkRR4HTI4G8tHxj06NlVPoxoSkb44mxIXqxPbrwU9OVSi?=
 =?us-ascii?Q?zGDw3p4YJcZj2Ayi89kXrbNTV0Cgzh0Q2UTrUPzxualg0wABgW4hRuDcq434?=
 =?us-ascii?Q?LBaYKZx5HDjY64ADzkobhqr+daG1ABJnl/dlA+qA5ZmQ5ttT5xJHpTCvk8MR?=
 =?us-ascii?Q?fPQtSefjhTPjEEbkBjjEgLJaOrDkfcCy6VjNfkRyfPPayL4IGNPCS+rqzMB8?=
 =?us-ascii?Q?7/JJ7KFRv5ilgsvZM5jjDegJU2acVOcoyo/2QvUYXFhbZP9TIi0EiEzhNlFT?=
 =?us-ascii?Q?6I1FpiuAHj5eGWCg2izPiWvIyIQ78J6/5vMrgsBMiqkDhsyng+G+zPhxp4J1?=
 =?us-ascii?Q?5uTGjYMSK0LjT1+d7mxsU5itYSiJM7EFQJD46Ifr64t1WV0E7VjTWcNNGEHu?=
 =?us-ascii?Q?1sgVxGlSEO8tWX918AUYXmb060x+It6EPFsUgnj1RoAn6KVDLtraSiiWZuIt?=
 =?us-ascii?Q?g4Dx4g3HPutZCyspterY6kaz1GwDXmoe7vX26TLT+8aKrU/ziF5tUuqSgO3D?=
 =?us-ascii?Q?27Lgw97pzgR2lWcwY1lY8F92fsY7H0COYKzRg7Q+/KqURHOj1XL78Qrkx0+o?=
 =?us-ascii?Q?J4AvQd6MmCw+te2yGlgntI5LXI0vc/NbD1JpgWN3H/rRTzmydF6/v1ch94dP?=
 =?us-ascii?Q?iXW46QxCrLYQMh663ZhfoyZYxj0uZ9QejZNTrEHQF1hADdl3hqpP4eSYBX3X?=
 =?us-ascii?Q?GbLVkw1St9bbaKwBaieaYQviwcsr8AVihmJFjMdx96x1BksKTSLyqf32Aahm?=
 =?us-ascii?Q?y9QZe/MtFan1vEMA0hzIh02qcgIvkEzuvDKg+qIihpZPAAOT8saGBa8ciKvP?=
 =?us-ascii?Q?MsKT9gCv7PsTtwSOB2fWPQBPtl/phY4sHYSourkUnH4GRJGMeDa6flo3BDZ1?=
 =?us-ascii?Q?SXB8Y8XRh9BBNr9akqhNHIRSABVqX3cxYLDR+MN24oaCSLx7L0WjFTr6c4Om?=
 =?us-ascii?Q?MqhhxMr9WpRI39BwBGmXvZqDsIq64ZLgQWxB0ZsNxCt5opMKaX1iAnDy5eRJ?=
 =?us-ascii?Q?pxcpTwnapI+4LxzfWUZY/YgRSR7N+XUKt12fnCSsZNVpH8WgGVXEm6BRUzgI?=
 =?us-ascii?Q?1w=3D=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a514b28-55a1-4d2e-67aa-08de28762887
X-MS-Exchange-CrossTenant-AuthSource: SN6PR13MB2365.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 20:48:28.5378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Srz/Z/clfat2UormkN+5snG+p5kKtIK7Gx+uIL1EgI1W8KoyyGnbytPlgtIu6v3dNOBdgQAlY+YblB7VcYIkeY8JSPrNr4YFjZcD++/NcVA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR13MB4660

On 20 Nov 2025, at 15:09, Chuck Lever wrote:

> On 11/20/25 10:57 AM, Benjamin Coddington wrote:
>
>> +
>> +		dentry = atomic_open(path, dentry, file, flags, mode);
>> +		error = PTR_ERR_OR_ZERO(dentry);
>> +
>> +		if (unlikely(create_error) && error == -ENOENT)
>> +			error = create_error;
>> +
>> +		if (!error) {
>> +			if (file->f_mode & FMODE_CREATED)
>> +				fsnotify_create(dir->d_inode, dentry);
>> +			if (file->f_mode & FMODE_OPENED)
>> +				fsnotify_open(file);
>> +		}
>> +
>> +		path->dentry = dentry;
>
> When atomic_open() fails, it returns ERR_PTR. Then path->dentry gets set
> to ERR_PTR unconditionally here.
>
> Should path->dentry restoration be conditional, only updating on
> success? Or perhaps should the original dentry be preserved in the local
> variable and restored on error?

No, we want to assign it and pass it along because there's a conditional
dput() at the bottom of nfsd4_create_file() that wants to know what happened
to the dentry.  And that conditional dput() needs to be there in case other
paths error out before we get to atomic_open().

>> +
>> +	} else {
>> +		error = vfs_create(idmap, dir_inode, dentry, mode, true);
>> +		if (!error)
>> +			error = vfs_open(path, file);
>
> Revisiting this, I wonder if the non-atomic error flow needs specific
> code to clean up after creation/open failures.

I think the fput() is all you need here.  I have throughly exercised the
non-atomic vfs_create() failure as well as the vfs_create() success then
vfs_open() failure paths in my testing and development.

Thanks for the review!

Ben

