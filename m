Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 082F93897F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 May 2021 22:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbhESUeJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 May 2021 16:34:09 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:5248 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229379AbhESUeI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 May 2021 16:34:08 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14JKQoDj000596;
        Wed, 19 May 2021 20:31:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2020-01-29;
 bh=4R2KSIolXxWtPfnOaUJpw+H5nEoTtcLOw1VwxoScZnQ=;
 b=qT/MpejsxOPGGjDdyqQ+S+nST7Z21SbweWjjDp/wOspuZ7lw/pz1l8335j19JsdP9rRy
 ALeTiCuXqDt7ShqlhkECb07tpzayvxMRMh7h7Yt0T6nM2CK5a2pTTrRE/8Oh/jOH9xHO
 Pcm7CBtR/CnZ6KQ/9ibUxKWhoJzs59PZ210u1GH5YL0vLxQrzHhtXkqJrXahM9PWO0Ya
 SP96M/GwL11vCIBhJ6sqd71Sx2feRo3PMM1QTKMBCUkzXci06Lf50ve5oLJAhDhlc7vx
 QVqDTgM6dLmWupNZ7q5PFFcmMBWCJcOhknIvhyU/QzuEuwxRcdvL+IQ9i2vkFlpvt6rO tg== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 38n4u8r4wy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 May 2021 20:31:43 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14JKVhM2080708;
        Wed, 19 May 2021 20:31:43 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by userp3030.oracle.com with ESMTP id 38megkta9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 May 2021 20:31:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAiNwGxAzR45XMJRxX9XoRFjKvzYLOOqf0KabWOXLziGjmsb/1aCnIIHnjrHhTn2RP/buDC4V4KrjIAuQWaMBrs20359OKlkzdlBfE6ENJ846S04NeGRf9SZiebO1gm6KEmbrNnvfny0f5u5zQ7kZnl6K3f1p7S6N+OI3l1k2Nr14QF9TBniCN3h0QCzCMP8ezxeEvlNOvsXvj4KTFJMhDGrHi8Ys6rQQ98tdJSudh8XTGSlSUL2owsOEh72m5OhD5oFYsn8FuYaYIQ+rrDquhCPz1CVVRG+Wt3Xtg+9DqcZzpYIzEGX04A/syU1YfL7xycF+YhUpu6p8IWHsm3lBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4R2KSIolXxWtPfnOaUJpw+H5nEoTtcLOw1VwxoScZnQ=;
 b=ZG9Vw3+qRMzNEZmN4LkUqEpQOqxDcGOQByFQRUWJ/hSWnlHhl/NnsYiYWdutsos62VVJ7UVe+dCM/OG9mOagdjfYFJXDn7t+zWHkOYAUZ9LCRS5xPFpKVWKI99164cHrgaqBhSyvUqkRlHznkKrVqegZ3prNEnMERKTFOgqA0nG+MiPZ3u0rEsjkqT2oV+AoVz2LT13R7v+7VE82VRcyWcga3LU5SgdOnxHijPMbZrRVP++s+F4fzyzMWzOPU921ZkJ+ERBODJXxD1RF6Hj5W/1UssKSNeEoeD+H+lHlz+ihnnl0UIf4Ra0XqcX+BmpLX4sCFuAJfpfM1UjBazEfvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4R2KSIolXxWtPfnOaUJpw+H5nEoTtcLOw1VwxoScZnQ=;
 b=x8wGQ5f5sfTZLM5Yv3Bw8mGiDOHM/yblw4DyqNSelUoXQzQyuEVujg7CD3ddt2Ajvt/SusL2iMLa8m1rISB+75behYJ+eMVl90ikX0RCsWdYw4b0vFWNASisX/cySuq/sJmjWyIPzIVVEVGrTBj3PM0dvJ1aJYYVsQLYDAK027M=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2823.namprd10.prod.outlook.com (2603:10b6:a03:87::15)
 by BY5PR10MB3971.namprd10.prod.outlook.com (2603:10b6:a03:1f6::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 19 May
 2021 20:31:40 +0000
Received: from BYAPR10MB2823.namprd10.prod.outlook.com
 ([fe80::5cc8:7154:975d:b2a2]) by BYAPR10MB2823.namprd10.prod.outlook.com
 ([fe80::5cc8:7154:975d:b2a2%3]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 20:31:40 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH RESEND v5] proc: Allow pid_revalidate() during LOOKUP_RCU
In-Reply-To: <20210416011638.183862-1-stephen.s.brennan@oracle.com>
References: <20210416011638.183862-1-stephen.s.brennan@oracle.com>
Date:   Wed, 19 May 2021 13:31:39 -0700
Message-ID: <877djuo47o.fsf@stepbren-lnx.us.oracle.com>
Content-Type: text/plain
X-Originating-IP: [2606:b400:8301:1041::18]
X-ClientProxiedBy: SN1PR12CA0086.namprd12.prod.outlook.com
 (2603:10b6:802:21::21) To BYAPR10MB2823.namprd10.prod.outlook.com
 (2603:10b6:a03:87::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2606:b400:8301:1041::18) by SN1PR12CA0086.namprd12.prod.outlook.com (2603:10b6:802:21::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25 via Frontend Transport; Wed, 19 May 2021 20:31:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 388145bf-6791-4bd2-2f2e-08d91b051b9f
X-MS-TrafficTypeDiagnostic: BY5PR10MB3971:
X-Microsoft-Antispam-PRVS: <BY5PR10MB397190AB241975C6428C4748DB2B9@BY5PR10MB3971.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: miuKpK/R//rrUX1W4O2FT4+QoxKxo7U18XCgIdTICjdOqCaX/Z0sdssVAIBPwz07J2X80Q5YB49yYjm34iwRD3iV39rlBftMMV8n3xQmDr0UomwLGOO9I4tKAQAwhGrj9r9Fz88eiPi7zHgzAPBbSLpLXOJ/9K2cquGpna59eLyRLcCMc3E1glRUJSh8Osn3kcAxEy1bUUrn9VB4EFhIup/M4i1bfnv7lntvDGYGqDVK4rBWX5Jn506nGrq/6k4TjHd1MugAed4mKTbvXEXAkwgk7KVRgHS/zA+YRomWvzi/J5YXgTQU5DGpPPVzdpl/xUWZD7HUDXSoVnmraKLsegLPJM3htxopxwHRAz5W5d3eQuJg/oXuHEZ8OgFcR6holUMPKjC3McIYKm6Y0IgA21K6fEUqARAwLcEFnUsmC1TxTzXfmM6xzv83g2i1qG4kAobjgsIaeBvBhaicZttKNGLhfZi0Lu3E1XupTzWgGcqYaM2yYgLuzftcV+ctgedBa7PG823uaZQ8XA5zrmw+/AD1CRMiF+Wj0WZ+3Jz2VA7Ip6sEyjthWjU3T8UbU31T71fR1/ZVe2xa7MBvvFyX/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2823.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(346002)(366004)(376002)(396003)(52116002)(66946007)(66476007)(66556008)(6496006)(2906002)(38100700002)(4326008)(6486002)(7416002)(6916009)(8676002)(8936002)(5660300002)(54906003)(186003)(16526019)(316002)(86362001)(478600001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?67jPhPpbjBrnOWE2ZAZMsnid/algZw8qWyQ7WNtkjmGR05Mz7hcj49eTtgVL?=
 =?us-ascii?Q?ZlhpzOVJ7huOB0retp2YbSd5cClAYLfhikPVGwD0HlJ5J14TAFsHQh9runNa?=
 =?us-ascii?Q?Hc/dx8ErqyoTzn8Rv9DGrsNcrZbtTyh6tf2HhBFr0y7JSsP1m2f2VK5WxpkM?=
 =?us-ascii?Q?4xfNw8njorxUJ9t/CRPr+LZFpIbOe0swRsrCfrlOUuvprev2zEzUEEw1Ss/0?=
 =?us-ascii?Q?IRFoWsgtnnrPF+rD36oUvtRWIi574S3nlebxOP7Tvd4W4XK15LcO2bwySwzz?=
 =?us-ascii?Q?V0vWmib8S1WJthaVM0EQrA3GPUxmAsL5ruycHA6UlKtf/tbsvN1UXbgasIKJ?=
 =?us-ascii?Q?mEgStdtpE8qar3H0oWt4+8Cb+w+56ccrDXYFOX0PN6PgQRnay3xTkkIYzED7?=
 =?us-ascii?Q?J1CXaWmIDynaLQf16h0zadv30yucenRAMP3mAKky7cJ4LAGR4mR3OHOe9bmp?=
 =?us-ascii?Q?d4WvOpe6SBFVVgm10ZSTgQnC4LLrLQl0tWBKU0bnJP43jbKygTuzgP0Plo5Z?=
 =?us-ascii?Q?/e8chdIL+W78zietypz84/z4O4lsxvsZJQBjtDnAsT+0FP+rV5KiWtOvVKSX?=
 =?us-ascii?Q?epr2e/70kcOkLBMkBv8G96naYqADDQlPN0z67esleSXEmH6oIl9M3YI13/O+?=
 =?us-ascii?Q?3RaMQjQ8wqu41bmocmfoII6UTghm4OZILVCYReGkIxVuf3wVip5kIOPwf1Pf?=
 =?us-ascii?Q?yJwLfoXIFoQANeRMXNNyRnfPDNATISxvyhvJH19oRYVO7X276CWVdxhMU5yV?=
 =?us-ascii?Q?eeR+nQnQgdEEjtLSY3I+sQ9ex4uoR5EOiyB5arxxgrJj3nCLwcc8vop8xU2F?=
 =?us-ascii?Q?SrYSQtg5iUwprvM7Q7ULr0GD3wdiQJ3edTMwrIGBrMgHolf9zrZOU2aX2DQH?=
 =?us-ascii?Q?Bi1SZJdGl3Cy6Mwa8SD96w+AmQjtFZNeYnwX+TG1DxV9xtDcdHrSiUs8emXC?=
 =?us-ascii?Q?ujYsuYKxWkshFXrHojA7zL0EaIZGcPq4qXoHZWt/kKed5fYQ6XlVVk5vXcWt?=
 =?us-ascii?Q?aeClzk4GtIkliXkNhABQZY09Xo90HOq0PU42MAYWVVXLdXWJjj5ROc+sSDsm?=
 =?us-ascii?Q?UCNPESKmTWgat7E5rrdiKZoihrgusCYhbASeTrWFPcRdTJZMLE5r0HeH0bwG?=
 =?us-ascii?Q?c46MdpldfKhUdDXCL23WtynbQMNvEF3NnxfixkyW33LZepWbq8SR9lkhVsZb?=
 =?us-ascii?Q?XefK5BmlerEpnsc0hlWjkvJigpgyrMTjVfiPFH2fswrswHprL0B5O4kXYYSa?=
 =?us-ascii?Q?z8/ImmjDKrT6EXwGvY93wV2zu62RI1rxUfX2RqCq6W6YXy57FA6qtCwFPIvF?=
 =?us-ascii?Q?NHF0Hl1WVzWPo/Px4m78+17gj+UktxtF3s8T9sVlZqIPnw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 388145bf-6791-4bd2-2f2e-08d91b051b9f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2823.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 20:31:40.4837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GLB9iKbHnUyuFFBT81FwiqF9S7tl2vdDY+bPe3YlOLbb+nEReYb79ezlrKrh+VsxqSM4lQ7DrucE7ZLK7v8+Zu3H1HyA3AKt6tTX5Wh/HDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3971
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9989 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105190124
X-Proofpoint-GUID: KAiYW4tjYUGMRUjNWhKVDpqmjuDZmhDU
X-Proofpoint-ORIG-GUID: KAiYW4tjYUGMRUjNWhKVDpqmjuDZmhDU
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Stephen Brennan <stephen.s.brennan@oracle.com> writes:
> The pid_revalidate() function drops from RCU into REF lookup mode. When
> many threads are resolving paths within /proc in parallel, this can
> result in heavy spinlock contention on d_lockref as each thread tries to
> grab a reference to the /proc dentry (and drop it shortly thereafter).
>
> Investigation indicates that it is not necessary to drop RCU in
> pid_revalidate(), as no RCU data is modified and the function never
> sleeps. So, remove the LOOKUP_RCU check.
>
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> ---
>
> Resending this in the hopes of Al picking this up, or else more feedback about
> how to test for RCU-unsafe code in procfs.

I just wanted to bump this again - I'm very open to suggestions of new
workloads, configuration options, or selinux configurations which could
help me verify this is fully safe.

Thanks,
Stephen

> When running running ~128 parallel instances of "TZ=/etc/localtime ps -fe
> >/dev/null" on a 128CPU machine, the %sys utilization reaches 97%, and perf
> shows the following code path as being responsible for heavy contention on
> the d_lockref spinlock:
>
>       walk_component()
>         lookup_fast()
>           d_revalidate()
>             pid_revalidate() // returns -ECHILD
>           unlazy_child()
>             lockref_get_not_dead(&nd->path.dentry->d_lockref) <-- contention
>
> By applying this patch, %sys utilization falls to around 85% under the same
> workload, and the number of ps processes executed per unit time increases by
> 3x-4x. Although this particular workload is a bit contrived, we have seen some
> monitoring scripts which produced similarly high %sys time due to this
> contention.
>
> As a result this patch, several procfs methods which were only called in
> ref-walk mode could now be called from RCU mode. To ensure that this patch
> is safe, I audited all the inode get_link and permission() implementations,
> as well as dentry d_revalidate() implementations, in fs/proc. These methods
> are called in the following ways:
>
> * get_link() receives a NULL dentry pointer when called in RCU mode.
> * permission() receives MAY_NOT_BLOCK in the mode parameter when called
>   from RCU.
> * d_revalidate() receives LOOKUP_RCU in flags.
>
> There were generally three groups I found. Group (1) are functions which
> contain a check at the top of the function and return -ECHILD, and so
> appear to be trivially RCU safe (although this is by dropping out of RCU
> completely). Group (2) are functions which have no explicit check, but
> on my audit, I was confident that there were no sleeping function calls,
> and thus were RCU safe as is. However, I would appreciate any additional
> review if possible. Group (3) are functions which call security hooks, but
> which ought to be safe (especially after Al's commits: 23d8f5b684fc ("make
> dump_common_audit_data() safe to be called from RCU pathwalk") and 2
> previous).
>
> Group (1):
>  proc_ns_get_link()
>  proc_pid_get_link()
>  map_files_d_revalidate()
>  proc_misc_d_revalidate()
>  tid_fd_revalidate()
>
> Group (2):
>  proc_get_link()
>  proc_self_get_link()
>  proc_thread_self_get_link()
>  proc_fd_permission()
>
> Group (3):
>  pid_revalidate()            -- addressed by my patch,
>                                 calls security_task_to_inode()
>  proc_pid_permission()       -- calls security_ptrace_access_check()
>  proc_map_files_get_link()   -- calls security_capable()
>
> I've tested this patch by enabling CONFIG_PROVE_RCU to warn on sleeping during
> RCU, and running heavy procfs-related workloads (like the PS one described
> above). I would love more input on selinux/audit rules to explore to attempt to
> catch any other potential issues.
>
> Changes in v5:
> - Al's commits are now in linux-next, resolving proc_pid_permission() issue.
> - Add NULL check after d_inode_rcu(dentry), because inode may become NULL if
>   we do not hold a reference.
> Changes in v4:
> - Simplify by unconditionally calling pid_update_inode() from pid_revalidate,
>   and removing the LOOKUP_RCU check.
> Changes in v3:
> - Rather than call pid_update_inode() with flags, create
>   proc_inode_needs_update() to determine whether the call can be skipped.
> - Restore the call to the security hook
> Changes in v2:
> - Remove get_pid_task_rcu_user() and get_proc_task_rcu(), since they were
>   unnecessary.
> - Remove the call to security_task_to_inode().
>
>  fs/proc/base.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index ebea9501afb8..3e105bd05801 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -1830,19 +1830,21 @@ static int pid_revalidate(struct dentry *dentry, unsigned int flags)
>  {
>  	struct inode *inode;
>  	struct task_struct *task;
> +	int ret = 0;
>  
> -	if (flags & LOOKUP_RCU)
> -		return -ECHILD;
> -
> -	inode = d_inode(dentry);
> -	task = get_proc_task(inode);
> +	rcu_read_lock();
> +	inode = d_inode_rcu(dentry);
> +	if (!inode)
> +		goto out;
> +	task = pid_task(proc_pid(inode), PIDTYPE_PID);
>  
>  	if (task) {
>  		pid_update_inode(task, inode);
> -		put_task_struct(task);
> -		return 1;
> +		ret = 1;
>  	}
> -	return 0;
> +out:
> +	rcu_read_unlock();
> +	return ret;
>  }
>  
>  static inline bool proc_inode_is_dead(struct inode *inode)
> -- 
> 2.27.0
