Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3822849F66E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jan 2022 10:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347630AbiA1JdC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jan 2022 04:33:02 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:21898 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233524AbiA1JdA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jan 2022 04:33:00 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20S7K2V4015216;
        Fri, 28 Jan 2022 09:32:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : message-id : date : content-type :
 mime-version; s=corp-2021-07-09;
 bh=CKu5MnOsIU1mTtgQMa3gm/BXa1FHdeqncpblFkvgQ4g=;
 b=vU6kUWUbvjPQQwxi/P8u8n8YoQdr5YLYJUAL8PCXFl6DDGKnMvo9BiouqkeEKySsjNl8
 cW/IOn98MGm/JtQRTTwBbBTYgNstOXsEGaYYOO2efyT0hYpyTcq65tDw3GwcUjMEIfiq
 mx/flRK1FklZwRcGc2q4K351KaaYi/0e5kPaLSbKqUKf6V4qCfB7bZm4/AsmJGWk8XfZ
 NvZi9f9GbX+P+Q+IhOvVRjMcbN22mL7f0e8Vsd4yOGWzbCIAaA0FiYD3HNuNEFulndje
 nOFva9igoIQEe9syrvw3qTnEdx1wc6koZmORxlFMzV4mlwmovHHyDa8GN9PBk2cKKeH6 Hg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3duvsj2p9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 09:32:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20S9V7hW004506;
        Fri, 28 Jan 2022 09:32:54 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by userp3030.oracle.com with ESMTP id 3dr72579he-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 09:32:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aw/pCpi5SPYI1W9ggMtj+nQHvZUqRro2gm28AIH+5109OnRbmaC7Bcb+PTF/iRakcolxUHV0uoKLbsxVtMkAvU0rQ4ctXKDANTX6/PHm6ZPwBD7+GwGeMQ1yXVwFbrFjXII7iAIE63B0LFZ93mRha0PlXq+KgrdaW9PHiEOl/fYxlOgeeuuv6YnGjG3VSDxVBhsgqKKX96Ft7fionGMfOfrZT1cVvW0Cj0sZb3PFx4BrJYluGNbIiGijXT/VFau8ZVd7/rgmrcPRhXvMQPUGD2+TPV6vhHmr1ScPKFt3YnpGJ2Be+/tpIQiJV43ONwTP617ESS+ipSH2hTQQsufhyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CKu5MnOsIU1mTtgQMa3gm/BXa1FHdeqncpblFkvgQ4g=;
 b=A4uCNUy2/uiVnDWqy9fYTIRK6nt/+usxTObD2KF+wgxsgMnf/JfZ4Ok2/v8vKT6gpn2JTZHxsZD2QEjMmP1nMvu9+zN5B+pAXwRrwXV11hgd8jwJYP126c+cDD2TfgyEy5GH9LGFybGEe3ZJw5TIfANGVc4lBdmn2KPzpgj1Mqh9mOEWjRezBjl044hK7WhQzXWDGP2OjIS0LCn6KGCxHbazOBJo194uq76epPA8WNA+ta0y8FkKTHjuElJSxo9WP4Db1fxjQ/RqqbFAKrf0xmJeGKMNFvD7U2kDcBRhPzTxybZg/u4K5OYkalBEu8xEtG0aMdUQAIXBQcZpgqyO9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKu5MnOsIU1mTtgQMa3gm/BXa1FHdeqncpblFkvgQ4g=;
 b=Wh7EcqKXsitFA3CCBmRITJ1pt2BVDvT//ZFOzSvi3H1FAOEpgD7ybyH6ees+9BWEsuQPx5Kk0wdPSHI9PCLkI2HC7rkgFMi0tgqx0QW8AyvBBN/SpFpwzQPEL8edPOFgBIk+G7m12e89LDGbpVv+rdIODNAnWJYDJ4nkpv9AoVQ=
Received: from SA2PR10MB4587.namprd10.prod.outlook.com (2603:10b6:806:114::12)
 by DM6PR10MB2491.namprd10.prod.outlook.com (2603:10b6:5:b6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Fri, 28 Jan
 2022 09:32:52 +0000
Received: from SA2PR10MB4587.namprd10.prod.outlook.com
 ([fe80::3d38:fa18:9768:6237]) by SA2PR10MB4587.namprd10.prod.outlook.com
 ([fe80::3d38:fa18:9768:6237%4]) with mapi id 15.20.4930.019; Fri, 28 Jan 2022
 09:32:52 +0000
References: <164316352410.2600373.17669839881121774801.stgit@magnolia>
 <164316352961.2600373.9191916389107843284.stgit@magnolia>
User-agent: mu4e 1.4.15; emacs 27.1
From:   Chandan Babu R <chandan.babu@oracle.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] xfs: use vfs helper to update file attributes after
 fallocate
In-reply-to: <164316352961.2600373.9191916389107843284.stgit@magnolia>
Message-ID: <87k0ekciiv.fsf@debian-BULLSEYE-live-builder-AMD64>
Date:   Fri, 28 Jan 2022 15:02:40 +0530
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::14)
 To SA2PR10MB4587.namprd10.prod.outlook.com (2603:10b6:806:114::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 920973a2-4bdb-4bbf-ecc0-08d9e24127b9
X-MS-TrafficTypeDiagnostic: DM6PR10MB2491:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB2491EF62AE28499173785236F6229@DM6PR10MB2491.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p6B3ABrpBNUS+CH47R8healGY1mwccOj+QVebTdfsHfxBPIM1rwE4yaWNc9HX7uWYkpqFYKQwMBuVKBUsEi3d84mjIB8NfeN3X4S2XcO/fQrHTqUjZBPEswOWvw0c6uBghViNJbZWMlQCnPdfgWpho1F5jfjQxwZ4lOvnsZO2S+ER9MSCRK0zvHKc0QbmAspk3HBLZ4y54ZSkOUNlBqzt2EMObZw3GIFIoITb6TiZfDnlm3ZxHjMvzk69/PvmTRDpGep+VBJ7K7STAi45VJKObLAaLM+yVlB+CSIQ/iRfaF9X6AMWZJlcYQXWpI/N5JKYeYMp9S8UrJJswCSESYrXxpwUqT5bVeNkd1c9pqns43ProidBzGnvpXWTsyhlpDOdqAfcFU3MZUpf5B3pIndXi8utrXkY2q1SyrQ8yu9JyTTDk0o3jyMkrzbKrUYp7uJdkDlCw8fRkXoEh1N0YW7yHkQlvLzaZKa3uPRXp41dNRqxkUQsgo5OpfehifIOvQbxDIKVcz8zFUycD/V9NqE4HrAq8FClT1pSicMw6vFa2z80W1HNa9aKdG4XvwmSJ0Xx1inRK3d+e4vcKb8pc/uUzwECbVX5CfOMzmtKjT9H4LJFWogH5jB/BFyR99sJqd4RtuYo8zgSHJHbujXJZK8EZBabT1UZsdVFq+c2EuNHl8wGKQBko4TCRE8ZrGCfHyUfldNvN6xbl1tW7er51455A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4587.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(66556008)(66476007)(33716001)(66946007)(8936002)(8676002)(4326008)(9686003)(86362001)(15650500001)(6512007)(5660300002)(53546011)(6506007)(52116002)(26005)(186003)(6666004)(2906002)(83380400001)(6916009)(508600001)(38100700002)(6486002)(316002)(38350700002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PlF85O9xZwL1aAsZiZg15dbJ0pBmlIf6o0E2rdCtg9Oa4PelSbEV0WLcOuxn?=
 =?us-ascii?Q?uL/0H8jC2UIu/djaUqQXTmXTfMln9nEogkQGncP5hhF29qd59Yc03uxAEvO9?=
 =?us-ascii?Q?pS3FHJQ1sQ8grpxWtSl+RbTmN2pIAhknW9bGeMIn6xh9u5hsckBgwPV4Lbdx?=
 =?us-ascii?Q?tkWJVoine0XOce3oJIgh3gSBgUukbUe12NPTLP0nOsyXT61ehTFAjG8nYS39?=
 =?us-ascii?Q?jXC96MFZy/LMXdO9Yy95tL1yRWxP9U7BTtpbO3OzMmZmTdngpAO6gn/2u5s8?=
 =?us-ascii?Q?WK2Wj/97kR7vh2fBWeL2cmW8R28PgsQXvdevUl+MzISWzz9Q1tE3Ilc4YDBz?=
 =?us-ascii?Q?Z8CLXF7xA3kUrZLgj/Ue9d28Zjtp3xKExyWuda3wMQmyQTkOJ8Cw9JuNBl8C?=
 =?us-ascii?Q?TdE4m25NEKpOJIEj8FJ/S3zqHgBovohocH/6JytFqp2fBAHFFHqZ3TW6rZxn?=
 =?us-ascii?Q?+3mHHbft/BSCLD1kd3UUqmHPIdg/EBTMcDDbTQwwsZVIMAgYI3hA+dmXL0xT?=
 =?us-ascii?Q?wVnWXkMiaccwrC8Zu9bTSw1TjjHZ811iap8AaEfsd8VmNTxnQ6J/617vN6Md?=
 =?us-ascii?Q?0SNsMRbdYoYAOMovJDu9lmKTTrBMhKsJts9/Vq3mXUWNw2aAjqzhcxKpIlhD?=
 =?us-ascii?Q?s5/WUaf4AH+CiyYYKMcX0i50g68b2Po/pLlYhTEYp5zEmZGwjqK2/HWBJrQ4?=
 =?us-ascii?Q?GrVsx+nLOZpQdxQpUvdR7q1Zav24i/x6oE2ZT+RidjROHzWUxFJUPa5e///h?=
 =?us-ascii?Q?DXmUq1kQ+LIjluY3Vkntd9ZfzvL+SGcbsVrpQ7S50/SuB28W4fWNDVtyR8d6?=
 =?us-ascii?Q?yRFYdOTuDbxaRqNtXce0hZ6lfIjxjfvB3WYEzgD99JHSMSsi94Yge2VXo7AD?=
 =?us-ascii?Q?KYJqfuNMY5h8Mi7dWbWCwJBFtjiDZeceRUsRvYiPRIqkuQOqBeix1u64e+Cy?=
 =?us-ascii?Q?R2ACSybr9YCaB5lEIxvveyZFtO4+Duj33lYOGZHNFBSqu66iSPC496uWV7xF?=
 =?us-ascii?Q?MgvgYTrpL0rtT0OdIEtTs7eF5lSO6YAvRdT+a8xK7xhDjVQ/N5mlxLJOnUWA?=
 =?us-ascii?Q?3EMpx0OCeNZq88l07f5XrivPAZ78hVYqnkOaRHsInNroRWkzyvsSuQyuwn4j?=
 =?us-ascii?Q?4RRP8rK5VX1k+CB4nEkrvZtIYiuIsEUUsxRvv8US3aNyL0PdZZqNzg6HH04b?=
 =?us-ascii?Q?jI80fOiNwfpksPzu0DzA/lMFbuG+zcwx+3FJJn+tR9RHKgHSWlFyH6VA2rzZ?=
 =?us-ascii?Q?EO3m4Z60eAGZO9wxOXKbX6BG+CTn4+Jj2QxMdFwYNVE2eiR29azmM1lK6lD+?=
 =?us-ascii?Q?x1smxlq3J7zZS0aQpKLngvmBgeLkLdF020smdJ6eqeOFib9GvqhpEzl8Y2hz?=
 =?us-ascii?Q?06P+C4E3z9xHqpquk+qIgAYOlFNlTCdbICeJ7cPkcnh0K7G3RONGF8GPW30U?=
 =?us-ascii?Q?UZ1KLETb9cowSCkN5egTSuextEXo5If2cKp+4S55fo5lgbXCu9lynZ+7Sjcf?=
 =?us-ascii?Q?nDx3s2Xv0ZhkZnbDQh5JtvjZGjqOpydzxaYyqXM57/P16Rwt11Xo5tnCEE57?=
 =?us-ascii?Q?+9bmdacn6H/7S87+vp3jFjKdRuSAEqI6U16V7htJb/QVxpBHDwHyy5Skv25m?=
 =?us-ascii?Q?PLGJiqkF2QlvpY3oLC/SW7I=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 920973a2-4bdb-4bbf-ecc0-08d9e24127b9
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4587.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 09:32:52.0643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QZz4d4EDNYi6X14IuUF16B0ZcQmalcHLE01US47U2S+vFGT9JWSwTeO6dc24NcvzhPhZmcXO2qrA+FSb6RuFvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2491
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10240 signatures=669575
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201280058
X-Proofpoint-ORIG-GUID: I9JEtUkGLBUuuOhB38mPhrgL6JelqCx_
X-Proofpoint-GUID: I9JEtUkGLBUuuOhB38mPhrgL6JelqCx_
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 26 Jan 2022 at 07:48, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
>
> In XFS, we always update the inode change and modification time when any
> preallocation operation succeeds.  Furthermore, as various fallocate
> modes can change the file contents (extending EOF, punching holes,
> zeroing things, shifting extents), we should drop file privileges like
> suid just like we do for a regular write().  There's already a VFS
> helper that figures all this out for us, so use that.
>
> The net effect of this is that we no longer drop suid/sgid if the caller
> is root, but we also now drop file capabilities.
>
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  fs/xfs/xfs_file.c |   23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>
>
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 22ad207bedf4..eee5fb20cf8d 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -1057,13 +1057,28 @@ xfs_file_fallocate(
>  		}
>  	}
>  
> -	if (file->f_flags & O_DSYNC)
> -		flags |= XFS_PREALLOC_SYNC;
> -

Without the above change, if fallocate() is invoked with FALLOC_FL_PUNCH_HOLE,
FALLOC_FL_COLLAPSE_RANGE or FALLOC_FL_INSERT_RANGE, we used to update inode's
timestamp, remove setuid/setgid bits and then perform a synchronous
transaction commit if O_DSYNC flag is set.

However, with this patch applied, the transaction (inside
xfs_vn_update_time()) that updates file's inode contents (i.e. timestamps and
setuid/setgid bits) is not synchronous and hence the O_DSYNC flag is not
honored if the fallocate operation is one of FALLOC_FL_PUNCH_HOLE,
FALLOC_FL_COLLAPSE_RANGE or FALLOC_FL_INSERT_RANGE.

> -	error = xfs_update_prealloc_flags(ip, flags);
> +	/* Update [cm]time and drop file privileges like a regular write. */
> +	error = file_modified(file);
>  	if (error)
>  		goto out_unlock;
>  
> +	/*
> +	 * If we need to change the PREALLOC flag, do so.  We already updated
> +	 * the timestamps and cleared the suid flags, so we don't need to do
> +	 * that again.  This must be committed before the size change so that
> +	 * we don't trim post-EOF preallocations.
> +	 */
> +	if (flags) {
> +		flags |= XFS_PREALLOC_INVISIBLE;
> +
> +		if (file->f_flags & O_DSYNC)
> +			flags |= XFS_PREALLOC_SYNC;
> +
> +		error = xfs_update_prealloc_flags(ip, flags);
> +		if (error)
> +			goto out_unlock;
> +	}
> +
>  	/* Change file size if needed */
>  	if (new_size) {
>  		struct iattr iattr;

-- 
chandan
