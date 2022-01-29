Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF5B44A2C95
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jan 2022 08:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245315AbiA2Hnj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Jan 2022 02:43:39 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:41282 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239887AbiA2Hni (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Jan 2022 02:43:38 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20T3C2Eu011532;
        Sat, 29 Jan 2022 07:43:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : message-id : date : content-type :
 mime-version; s=corp-2021-07-09;
 bh=4Rsh15HwW3oyXJIW0eAcMk7GpKYxvo5RXceTQ+UyHU0=;
 b=C21Dw+eSXxrzpg448dP5j65rQ0r5aQAC/iR8//rWLOLtwWvkF0eeZLmGBbJ1yUEtBGZm
 lG3OFsDQe1u0w1wo+9aB2mVo2BXbB551n1OjhdfMrA78cDL9RXB81Gwz2PETSfXxbrcI
 XuoAexZWYPA2J+u2k1+MWGdM29E/RyUOmQ9uEeUFxy3wK1wdfOzHfdVMRFJBRvrVAtwC
 RPVXNTJ6eesnzIjRnkmA06UMi2ZcP/3d4nrDAujGdyJrvobplrR5VkE8RAkXleYvrUY0
 VEV+JLJDO1hCdP/0nN0iStiJHkjzzp2G3sB8XvVvoebiWXKJx1jLoBaClSVdOGMLwqyK JA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dvwfb09g7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 Jan 2022 07:43:35 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20T7VT1g114769;
        Sat, 29 Jan 2022 07:43:34 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by aserp3030.oracle.com with ESMTP id 3dvumahe1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 Jan 2022 07:43:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNdOyM+m82CVdvqsLWS2104ocnTVMPxv3Hlslajhp2Pogej13UPpR0HqebQGMm7YoMZW58xSiQ1LYbTLkjnGY2OMSqg5Tiwx3QZv9abHmRGdUsqthHcCH1V1j8xRiprQFmA9WnhSmu649si7wDEx9rq89Yn5J79N3wB5ZK0rfudAg+EjpgJb5hv2JbqLd0y9bKsqJqcntTdK1Ze4uCX+Og6r6SsERfZccL5d+Hx+ciM3Bi+9Hfak/8tB0vOybks+0NaB3X19TbMOvDErENDQGwqrppG7tFQqmvP3neCNElCiL3aNRm3w/Rqpn9Kq4RymFPo7pXjc5kpRtQyfz4NvLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Rsh15HwW3oyXJIW0eAcMk7GpKYxvo5RXceTQ+UyHU0=;
 b=ibxUUOb4FpJgQ2Z+PaZkvtY1qKhu5vi1NrREo0OYRMFBKRqKkd9ud4WA4xlx3YF9MvIH5AhFrG9wOdikxNYU3Z5/HA+GQWFzbM4yVUXJK6eygWGgYj+RY1OGmaW1ldP3Z5aHDHg3gQECp/0QoNcjfo7ZurDD+VPXwrbU5R4BkXAER8CTM2rZzFhvIh+6cqfCl+ZkKyC0y29ySds6HJSj28HNredxc4/8/tCiYJFc0tQL2EV6hJMNk5N43BAAdmqedS0ni3qnnlhZVvmKF4MMxbXndbFOe4naHZWd3T8U6fSEA5hyjr13eTjBaKD5+9nwJe2RmtONULKfbMomrLYzxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Rsh15HwW3oyXJIW0eAcMk7GpKYxvo5RXceTQ+UyHU0=;
 b=es2tcp7wa2/GSFzdoaLVYYBHa9Jxv4UR/IRz3FCFSeectdTaWjSuKIMOlOcYNJTEjsccuj1qz60vwls6zGRmStNAiWGPCO0WTwa7S8vFLP95O0+D5cmWbaQ1gEVgr9qlw6QDnRKs4IajKKRmCn4rszQrNygKRSLtKM6ejrVEauk=
Received: from SA2PR10MB4587.namprd10.prod.outlook.com (2603:10b6:806:114::12)
 by CH0PR10MB4987.namprd10.prod.outlook.com (2603:10b6:610:c1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19; Sat, 29 Jan
 2022 07:43:33 +0000
Received: from SA2PR10MB4587.namprd10.prod.outlook.com
 ([fe80::3d38:fa18:9768:6237]) by SA2PR10MB4587.namprd10.prod.outlook.com
 ([fe80::3d38:fa18:9768:6237%4]) with mapi id 15.20.4930.020; Sat, 29 Jan 2022
 07:43:33 +0000
References: <164316352410.2600373.17669839881121774801.stgit@magnolia>
 <164316352961.2600373.9191916389107843284.stgit@magnolia>
 <87k0ekciiv.fsf@debian-BULLSEYE-live-builder-AMD64>
 <20220128222300.GO13563@magnolia>
User-agent: mu4e 1.4.15; emacs 27.1
From:   Chandan Babu R <chandan.babu@oracle.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] xfs: use vfs helper to update file attributes after
 fallocate
In-reply-to: <20220128222300.GO13563@magnolia>
Message-ID: <878ruzrnqd.fsf@debian-BULLSEYE-live-builder-AMD64>
Date:   Sat, 29 Jan 2022 13:13:22 +0530
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0120.apcprd03.prod.outlook.com
 (2603:1096:4:91::24) To SA2PR10MB4587.namprd10.prod.outlook.com
 (2603:10b6:806:114::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28860466-e541-4765-fc09-08d9e2fb0ca9
X-MS-TrafficTypeDiagnostic: CH0PR10MB4987:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB4987D6E351D618F3D5800A7FF6239@CH0PR10MB4987.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wi6BFqu097bLOYRsFC+g6Bv79Bywzvezv2NYufnw3QKbeYU1yyhQ4FkoYPyAJYukPa2ieihwkg052Fc4+Vg3gTBrmADfx3CpuO5YzX1y5r6TQ1GwA96ckXXcgyTbPZ/ikQQgvD2osm8nry9tEszxqsMHt0A+saHoGk2EFLqeC0s82iXcaJ2JR3oI7eMJh6xmpBwJxy9nM0n/0MWcRnp6TdX6Vxh861I5oh2/dM7uHJIhyVPTsINehtFZCO72oYklRNaC5W2TWSHo+nLwn3AL+3Dzm1xi06N9hLQIjbczN0vKTrFFKEtlF5ha6g2VBlPQTUr6+Gaj+qjuHbubdkwxHak9M7zKwiyS97rijaiGC3kk6Xp327u86PFj3rJvUZWdYYYbzVW729xM1ZOgi31vCqkwFoGFXVhZSjhlwuiSQNSkmQe2J8zs0qHp/uHot+uVh/1GdilNp0obwbI3QMJvz0N7UtvLMC/tF+8gg6tPbiF4UP4H/bEenfnn0W3IoKzV4EoC7nUmF0aDkZc/kdVF860T/SVwwhBLCAyLmkNeI4fmdJeIef4Q4ZWhSd/sEqeFejv8GuUQLlOT0bYCjkryzhhSxrtWBs693wTqhghptiQyCZ6tU4P0G+NcKowBmViSoI5ez2j5CSguHSxHA6YWtG7NhNRerOdj3yxKiHHd3gM6u7qaf8fXI28YXO9RsFpblmeR/t+aHT313jt9/7wBcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4587.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6916009)(38100700002)(38350700002)(66946007)(2906002)(316002)(8936002)(8676002)(66476007)(66556008)(4326008)(33716001)(83380400001)(5660300002)(86362001)(15650500001)(186003)(6666004)(6486002)(508600001)(26005)(6506007)(6512007)(52116002)(9686003)(53546011)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iFCT4Lvu7nNlgpZekAQtF4ySRb+AHy1pRKkLt2iQRCq5KoKZWWZv9ebHiSKv?=
 =?us-ascii?Q?v8NewmJkBorsm4suPgIC6YMDIkNtRlTzVx7RIx8T3IrSWj1wlZuHloBJQGtM?=
 =?us-ascii?Q?9AaT8/2xEGVKYvw4SzOMNYWTaPPhHirv/B130Hmf4qW46SVKa4pIfnjcUxXF?=
 =?us-ascii?Q?TF3zxxJake666TEexj4dMMAEri5A061BVv7IfcaitZ5OEHw6KjBtd7EHrvMg?=
 =?us-ascii?Q?LS4DNmgpXfjs+HXuh29yYNl4zbhqWxCbdyTJ9O1xPztoLRVNfpcWrEOMc2TM?=
 =?us-ascii?Q?vHMBZugCl9K+5nTnRJMKwUkQMVWOY3XEcb0ajNwoAefh7gYCLKHytdiqfghz?=
 =?us-ascii?Q?Ww+/YXnyknDAodu1AC31af8xv13CzYJHNM7FbJqNRnlq/WNggqfJNVxVKvM9?=
 =?us-ascii?Q?qcj/LLpu1sO+5BbKG3BqC6Y6YwiPe/moIPTM4+bFZwMf53qRl079pfGj807a?=
 =?us-ascii?Q?t6XzhNcgqXCbAeqQJHrVRfagJ9r1S6RNWpiVsAmx6gvXs0OLoskDcBp7zBT8?=
 =?us-ascii?Q?F9Sw4lm7lstBB0gY1cuoHSAY5W2dHxweUAFY6S+fKOKKVBKguHcJ4huL6kE+?=
 =?us-ascii?Q?TLh53nwsKZ3b60AcmI5qsk+ZcCDHJd3jpQrYWWazPGk//sXOrR7hJyhngoPB?=
 =?us-ascii?Q?kN8JvZkXNKJGpCLCVDwj6FyBadh2nSYJFmtSuRkJD4uVtFDw4Rwk9GdgwQGe?=
 =?us-ascii?Q?KQbAUn8onFjOEliEETFincc5I8xjZCoO58M0BB3W9OhEzpljIqyOVImevqRI?=
 =?us-ascii?Q?dNdbsKfyPWbLsQciebB7O6HVkbihFeqpADfHSkBzqRSCKpIJh/sWadAg/Due?=
 =?us-ascii?Q?S2Vuq5xIAPNfKSZG8WL3sQnX3EOaqxDIJMCvw7rKUP833ZJc0zdkWgrkhUXa?=
 =?us-ascii?Q?MXhnhiXkrsYg08iGgaHeqXZQQcJ4Q/96DzRaoeECaqx3vGzNybIlhYfgfo4l?=
 =?us-ascii?Q?wy78hBJ2bEsvxg2hvY+tF571iXe69Lgofu7wXe6yVyV840FsncnaVn3n6PXZ?=
 =?us-ascii?Q?tEdMixCN2ZK/jwfrKQC2A53Qx3LFKpv6N2HfqDIeWYTyCmyhtXFPC5ngocEy?=
 =?us-ascii?Q?GzOhVycW7UTlbqgceLnT/1dGwHXyLtyA19JuUUevvc8j7tUCcd2oiGrCUoC7?=
 =?us-ascii?Q?1fLiSXSfuv2ZXONkZvNctT0AoJ5RfxqrWGwHYIMkmoPqaVp8HoTi26+6iPIw?=
 =?us-ascii?Q?YBs7j99sMHNjR8f8upyt83pSiUqBo8XcHguH3K0IqfSxCcsvIFnnrQWyyd7c?=
 =?us-ascii?Q?jHM2N1NGWhETf0IQLP+++1ITVlJEFf+dDZ+8QXQaMHQHqpYCq7LfYarjomrc?=
 =?us-ascii?Q?OsnR1A8CxD/SMa9GEp7kaq7wCvZLTbgOCi7eaj88/Ujxzg0kanGK3YK1lv1c?=
 =?us-ascii?Q?VaniqnF9EJdNMNTN1ExNLCX+6/1unrxodxnUNX9pdEdU8qETf9sNiVPsmhYS?=
 =?us-ascii?Q?aehjYTbC3B+PWTFVABa0tpPG0vDtiSu4cSWsYz9fMB2lcRbM1GCvp7VHNKQQ?=
 =?us-ascii?Q?EEEXI6Na4NFmpJOx29ALjdWJwvE+eGW2pYjU1D9HnXKGJl5o8DsYPOdCHlio?=
 =?us-ascii?Q?zb9CmUfcS/umQgCHFsX6erZloBclpmcojX3ZavAchZZanOBZgg3UnJp7ESrT?=
 =?us-ascii?Q?T1LAnEc72i/0KKiezqw6A8o=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28860466-e541-4765-fc09-08d9e2fb0ca9
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4587.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2022 07:43:32.9583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3p4hneHObXTA93t03a3gSpJsRmwfc5MfuCrEY4S8R0cWcfR4KsCLyul3s50zESHUU3YfbF4mCUmLxZTKEg57zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4987
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10241 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201290042
X-Proofpoint-ORIG-GUID: ydoPp3unixYNG3xaT4NtZgr9q6egKuOH
X-Proofpoint-GUID: ydoPp3unixYNG3xaT4NtZgr9q6egKuOH
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 29 Jan 2022 at 03:53, Darrick J. Wong wrote:
> On Fri, Jan 28, 2022 at 03:02:40PM +0530, Chandan Babu R wrote:
>> On 26 Jan 2022 at 07:48, Darrick J. Wong wrote:
>> > From: Darrick J. Wong <djwong@kernel.org>
>> >
>> > In XFS, we always update the inode change and modification time when any
>> > preallocation operation succeeds.  Furthermore, as various fallocate
>> > modes can change the file contents (extending EOF, punching holes,
>> > zeroing things, shifting extents), we should drop file privileges like
>> > suid just like we do for a regular write().  There's already a VFS
>> > helper that figures all this out for us, so use that.
>> >
>> > The net effect of this is that we no longer drop suid/sgid if the caller
>> > is root, but we also now drop file capabilities.
>> >
>> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
>> > ---
>> >  fs/xfs/xfs_file.c |   23 +++++++++++++++++++----
>> >  1 file changed, 19 insertions(+), 4 deletions(-)
>> >
>> >
>> > diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
>> > index 22ad207bedf4..eee5fb20cf8d 100644
>> > --- a/fs/xfs/xfs_file.c
>> > +++ b/fs/xfs/xfs_file.c
>> > @@ -1057,13 +1057,28 @@ xfs_file_fallocate(
>> >  		}
>> >  	}
>> >  
>> > -	if (file->f_flags & O_DSYNC)
>> > -		flags |= XFS_PREALLOC_SYNC;
>> > -
>> 
>> Without the above change, if fallocate() is invoked with FALLOC_FL_PUNCH_HOLE,
>> FALLOC_FL_COLLAPSE_RANGE or FALLOC_FL_INSERT_RANGE, we used to update inode's
>> timestamp, remove setuid/setgid bits and then perform a synchronous
>> transaction commit if O_DSYNC flag is set.
>> 
>> However, with this patch applied, the transaction (inside
>> xfs_vn_update_time()) that updates file's inode contents (i.e. timestamps and
>> setuid/setgid bits) is not synchronous and hence the O_DSYNC flag is not
>> honored if the fallocate operation is one of FALLOC_FL_PUNCH_HOLE,
>> FALLOC_FL_COLLAPSE_RANGE or FALLOC_FL_INSERT_RANGE.
>
> Ah, right.  This bug is covered up by the changes in the last patch, but
> it would break bisection, so I'll clean that up and resubmit.  Thanks
> for the comments!
>
>> > -	error = xfs_update_prealloc_flags(ip, flags);
>> > +	/* Update [cm]time and drop file privileges like a regular write. */
>> > +	error = file_modified(file);
>> >  	if (error)
>> >  		goto out_unlock;
>> >  
>> > +	/*
>> > +	 * If we need to change the PREALLOC flag, do so.  We already updated
>> > +	 * the timestamps and cleared the suid flags, so we don't need to do
>> > +	 * that again.  This must be committed before the size change so that
>> > +	 * we don't trim post-EOF preallocations.
>> > +	 */
>
> So the code ends up looking like:
>
> 	if (file->f_flags & O_DSYNC)
> 		flags |= XFS_PREALLOC_SYNC;
> 	if (flags) {
> 		flags |= XFS_PREALLOC_INVISIBLE;
>
> 		error = xfs_update_prealloc_flags(ip, flags);
> 		if (error)
> 			goto out_unlock;
> 	}
>

The above change looks good to me.

>> > +	if (flags) {
>> > +		flags |= XFS_PREALLOC_INVISIBLE;
>> > +
>> > +		if (file->f_flags & O_DSYNC)
>> > +			flags |= XFS_PREALLOC_SYNC;
>> > +
>> > +		error = xfs_update_prealloc_flags(ip, flags);
>> > +		if (error)
>> > +			goto out_unlock;
>> > +	}
>> > +
>> >  	/* Change file size if needed */
>> >  	if (new_size) {
>> >  		struct iattr iattr;

-- 
chandan
