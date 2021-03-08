Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCB833154E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Mar 2021 18:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhCHRyp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Mar 2021 12:54:45 -0500
Received: from mail-bn8nam12on2077.outbound.protection.outlook.com ([40.107.237.77]:17761
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229730AbhCHRy0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Mar 2021 12:54:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SlkCUr3MLntx8OAAUwT4maaxZr7Bh4eYOjJQRsHP5fs/SEORNOaxhZq8K0+X555gAm4vPzVoBmMlwAN0Ad5ArOhaPjEVHgo69i2TmPdMj7aaux5qL9CU0Kcm5gy5I59Yr2y8SAao5DoP9BsqxlZfwgpeAL68nqOBUxDAzSZ/IzSo4NOpgP/e9p6wJyC/GZYIIhJx84I3qvwvsLF9/25NzAkTIup6ldj2eq3h77HZv1iLX4ZIKbU/a56XKRK6ayLBo9zlvtRgEcqT8YP2K6OjGAG4H/4WpsoEl0IQWkU0BimRKYEiKbGVXKXPzJlQco0ATI8nolIyNlzaNncjTWPQRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSEbqhBJVeMcDfdQ5IdWqLMvPU0EGKiVsxP2Div/l7M=;
 b=Wssy6+KuLyuNcj9zAgkJF0DjrCnqBcFN6koLDrBfVg3EsbqI0cd4f3lSaj31jhZWkx61/K29/Cyt6v+fbUMa89NJuuo6j5k/k0VwbQnCqXUCvMYJ9JI20mjaAR5IqsFYJPVnzFhMB0HEt+4L9AAtKX8A+Het2oaklvaa9fDuKLyOjeLuWSUv6OQ7NcjvRUnnJjL0nn+Wv9KcYypJ+s7s7VaJ3hnWRkMlNieBlQXyUK1yyQM1VdxysIXB54HTlc2G8LX+0oW98j9mRxeelcZtTUYMcykMm/uP0zkS+ZQKh6XbkRT3ygbZaZM/5+hjGNuGbyXDtO5qAqcs3QwtCEW+TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSEbqhBJVeMcDfdQ5IdWqLMvPU0EGKiVsxP2Div/l7M=;
 b=aK9xchTf1ifryajrzRy6WyiTCmXfdKN+1pwmsBsQSFx7Xm3vxgKGVvoUahWdbqh2dZ77G6U8BvLxBH1N6AbSuxE7j2fNww3GOK5d3AqMJXLwQXPCwLIv/G1VXW4L/H6Zv604rbZD/Cf26PgMGtVPRYIlQqvUj+z03e3W8FKVHlE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4191.namprd12.prod.outlook.com (2603:10b6:208:1d3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Mon, 8 Mar
 2021 17:54:22 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3912.027; Mon, 8 Mar 2021
 17:54:22 +0000
Subject: Re: [RESEND PATCH v6 1/2] procfs: Allow reading fdinfo with
 PTRACE_MODE_READ
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     jannh@google.com, jeffv@google.com, keescook@chromium.org,
        surenb@google.com, minchan@kernel.org, hridya@google.com,
        rdunlap@infradead.org, willy@infradead.org,
        viro@zeniv.linux.org.uk, kernel-team@android.com,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Michel Lespinasse <walken@google.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Andrei Vagin <avagin@gmail.com>, Helge Deller <deller@gmx.de>,
        James Morris <jamorris@linux.microsoft.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20210308170651.919148-1-kaleshsingh@google.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <a51dfd94-185a-63f1-3dba-84dcbe94cb56@amd.com>
Date:   Mon, 8 Mar 2021 18:54:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210308170651.919148-1-kaleshsingh@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:4feb:dd51:df27:4444]
X-ClientProxiedBy: AM3PR05CA0116.eurprd05.prod.outlook.com
 (2603:10a6:207:2::18) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:4feb:dd51:df27:4444] (2a02:908:1252:fb60:4feb:dd51:df27:4444) by AM3PR05CA0116.eurprd05.prod.outlook.com (2603:10a6:207:2::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Mon, 8 Mar 2021 17:54:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 697a8868-ee23-4251-cce8-08d8e25b3488
X-MS-TrafficTypeDiagnostic: MN2PR12MB4191:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4191EA05F7AB743B4E588F2083939@MN2PR12MB4191.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ue4SyN5xhLfC+6iFQ01TAqK8lITYfZVkKD7ZqsxdUXjf4WZA2EvRqS+ogX1PF0z8wIoJyc0qQv1820jablt6SI95xPQqtqVxFKzuOvuBT2yZkLn1WUYdZee5XbNFIip+wd20i6nUm2FLQx7JhQRj6jNdqiMAQCPkJGK2CPEIu65pTT0D2kFn/dGtT326NNd2VmQYMrAYt2Rs1QI+FE02rt34NaMvpuGaVxX2qj7EKF5LZIdV8PcOgDzl1LQzzUt8VupDEeKrGGNDkETcxTgX7UblhjhJebMlCnabpL+7zYt9xIFPbdRn6WaL3mtjUHbWKU/aBK+zIr8EJpbwa052o4+5UeDNxifED9iI70E9O3ZnkgW3/bRKTj8p4eZ95ICZS8KEPYzbBU2mkVVs7qMOQbdSIYm5f+F+R5NyZlVKGPjSHre7FUVR7Q5se2kXUU2vcThH+fzAEf0dKZxHQU7Fz2UemD71yT+vJ92JrZExxtHY4TyJ4F/XJx/NbYrALrFdFH98/sTBhwaeamx8JVKnmW1LcTVMz/6wJ5GoZPc/BB9YnniWW3QlvmZ2zvqxBdy/BQywg3hdBes5LpyH7jTPq5KjDV6g8+OpUkAtjYtiIbsCjoNvy5757y8SLeR3hBDbbuKKknUtKucmAb0WdGt+17A5iPGjlR6bnrbF0Kq4PRm98TazUpQBmLjpcF/g1DBAiJoIpY1jFfIppakH4iiLUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(6666004)(86362001)(6916009)(2906002)(6486002)(45080400002)(83380400001)(16526019)(66556008)(66946007)(66476007)(478600001)(66574015)(186003)(2616005)(31696002)(966005)(36756003)(7416002)(54906003)(5660300002)(4326008)(31686004)(8676002)(316002)(52116002)(8936002)(34580700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dENyYmx1Z1M2eCsvcXhYMm1yWjArWEdSOUJ2a1R3VGQwZHp5UXF1RE1YeEVq?=
 =?utf-8?B?TGgyZ3pNUE9YdWRmMXpIVkZ4dkhxZkFFUDkybzJ2S3hsMkltVlh3bmlydVpC?=
 =?utf-8?B?TGo3Y3RsemxxWWtUZ0dDZlRram5ucXFmVGdldllYZGtIczVCbVRCUVVnYWhS?=
 =?utf-8?B?MGVDZURBUVFkY2FJZDFEWE5tTEN0N3NYWHNEUjdvakpGUy85ZjI3TC9lRElr?=
 =?utf-8?B?RXVCSDcwWUk5aitLRFpyd0JuZGg1SDR0K0w2N1l5RGFXWHhWdkRmOWF3VGZS?=
 =?utf-8?B?UkJhRVljT3VWVHNzbzU5WXNhd3JSWTlEZzN3QTVlU1k3N3JraVZmdTFjOVJG?=
 =?utf-8?B?TU5NYm1Bcy9SQk0vOFBENUVOaEhmdlVzUThlbjZNOFAzYWVlK2hid1dOb1Zx?=
 =?utf-8?B?RkNZTjJKSkcyL3ZnZHplZWw4b1Jac3ZKY2haV2xid2F0YmtaT2dnbmZUOGNX?=
 =?utf-8?B?SnU3akVyRWtMdzA0R3Z2WjNtT1RZdDdNTU5yNkJRdFp2eDZjTVVuZ3JZS01V?=
 =?utf-8?B?WkRZZWZwa1RvNjFEemlDcmFFcHEwVk9TYlc5WGp3M1lNNjh1SXhHampyMVBt?=
 =?utf-8?B?V0lDVmV1eVBmS0xlakk4cC9uK2NMWU9YOTlaWnhYdjI3MHdDTnZQYUZPbnQx?=
 =?utf-8?B?Zyt1Q3hPUkkveUVnTjVJbUJ1K3BReHBDKy9RZEgyUHlKOUg3MXczRTRORW5E?=
 =?utf-8?B?di9CSTNyR25aYVAxSlRqNCtyWDg5amwvUW9kaW9iOTBmL2M4UzJOcXh5ajAv?=
 =?utf-8?B?MEdiZHVWR1BTS09ndGwxYlVJVWZiYnRXdlJkMnliNVEwOS9RdVdPYVdYbHRM?=
 =?utf-8?B?dEtROEdNbGtESVVZT0p4aW9keGx0azIzTTh2UjRHbW40clZZNFZ4aFV3b3Nw?=
 =?utf-8?B?UUxTVW4vcDJBNDdqYlRoZ0xUc2djZTlrWVdROG1QVUo0Szg2R2QxcWV2ZU5y?=
 =?utf-8?B?RVBnY0o2UFF6dm03RnJXTk9BWFFMa3lWVitpcEhpZCtCMFZoNnk5OHAyaWk2?=
 =?utf-8?B?V1gxUVVLY2ZDSXRkNEEva1dMUDNuTWVFMzEvbWpKcUZBOEZJUk14OVpIM2hV?=
 =?utf-8?B?MDIvaEdtVm5adnBSczZ3d3dKeVJHSmJGbGc2aFJoZS9iVlU3WjlqMStTWlhS?=
 =?utf-8?B?VHhWdU1wby9kNUl3bENyYm1MNjVaMXpSeUdkZml3R0RhKzl4T0U2eGVlQzhM?=
 =?utf-8?B?NlhPY21tSTdLQ2JhUVEyZERXejE0RlpESng4NHJaSEg0d1AyTHVaNUxYTGlE?=
 =?utf-8?B?UXQ4cEppYk9rcEpJTUpaREcyYng0ckI0QUxtblp1MzE2b3hQcDRMKy9RekxD?=
 =?utf-8?B?RTJIU3h0ZlpXKzk3dXR0N1JlZHRwc3JGK0RuREpFTVVvODdhV0dTMHBPZWJL?=
 =?utf-8?B?VXV6N0dqZzZncmFSdHVXMzZMZEt4c3Q0ZldRdkNVODhWcTNRYm9XVTlpRkpZ?=
 =?utf-8?B?eFBLTWJKd1B1RTZUQkliamJxNGlPanJIcFdBMmZMYUczTTZMNkFjT3A0VlJY?=
 =?utf-8?B?T2h3RXQ5R0kwR0RvYlB0c3o2bDFUaFpVSnl4YkZPMVNuZ1NzUnJEQzc2ZEtp?=
 =?utf-8?B?eVdXYTRoRnNpMWJ3bnl5VFBCOTR1T2hCY0poNUFLR2JVQ0RZekdzYXZBZDgr?=
 =?utf-8?B?ZUpnUHE1cFRseWpiUFNNYjJURk1JNG1Vd3NDYTdXWFUydDk1c2JZTFFjbVhI?=
 =?utf-8?B?OU1DbEpteGJkZWNHa25IM1ErVlpCSlBSSnpzaS83MVlZYWx0b0JocEh1TUo3?=
 =?utf-8?B?Q21UdHNrVjMvcCs2dktYSDFmUFdJTzg3UkM2Y0lIWmpoU0JNK0trankxVEJ6?=
 =?utf-8?B?WGtIUVRGR1BDWTltSkxaVU1WRFdmZFJ6Q0R3eHhDVmhEcnRrYUQ3MVNXSm5M?=
 =?utf-8?Q?GnccYhImwEWaT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 697a8868-ee23-4251-cce8-08d8e25b3488
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 17:54:22.7515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: omZ44ObaBrDJle3ZPjy+fY84ezSDOlrrLqtbwQCpmX4G7KFjemzY/R8KxSlB2vLW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4191
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am 08.03.21 um 18:06 schrieb Kalesh Singh:
> Android captures per-process system memory state when certain low memory
> events (e.g a foreground app kill) occur, to identify potential memory
> hoggers. In order to measure how much memory a process actually consumes,
> it is necessary to include the DMA buffer sizes for that process in the
> memory accounting. Since the handle to DMA buffers are raw FDs, it is
> important to be able to identify which processes have FD references to
> a DMA buffer.
>
> Currently, DMA buffer FDs can be accounted using /proc/<pid>/fd/* and
> /proc/<pid>/fdinfo -- both are only readable by the process owner,
> as follows:
>    1. Do a readlink on each FD.
>    2. If the target path begins with "/dmabuf", then the FD is a dmabuf FD.
>    3. stat the file to get the dmabuf inode number.
>    4. Read/ proc/<pid>/fdinfo/<fd>, to get the DMA buffer size.
>
> Accessing other processes' fdinfo requires root privileges. This limits
> the use of the interface to debugging environments and is not suitable
> for production builds.  Granting root privileges even to a system process
> increases the attack surface and is highly undesirable.
>
> Since fdinfo doesn't permit reading process memory and manipulating
> process state, allow accessing fdinfo under PTRACE_MODE_READ_FSCRED.
>
> Suggested-by: Jann Horn <jannh@google.com>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>

Both patches are Acked-by: Christian König <christian.koenig@amd.com>

> ---
> Hi everyone,
>
> The initial posting of this patch can be found at [1].
> I didn't receive any feedback last time, so resending here.
> Would really appreciate any constructive comments/suggestions.
>
> Thanks,
> Kalesh
>
> [1] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fr%2F20210208155315.1367371-1-kaleshsingh%40google.com%2F&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C38c98420f0564e15117f08d8e2549ff5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637508200431130855%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=deJBlAk6%2BEQkfAC8iRK95xhV1%2FiO9Si%2Bylc5Z0QzzrM%3D&amp;reserved=0
>
> Changes in v2:
>    - Update patch description
>   fs/proc/base.c |  4 ++--
>   fs/proc/fd.c   | 15 ++++++++++++++-
>   2 files changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 3851bfcdba56..fd46d8dd0cf4 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -3159,7 +3159,7 @@ static const struct pid_entry tgid_base_stuff[] = {
>   	DIR("task",       S_IRUGO|S_IXUGO, proc_task_inode_operations, proc_task_operations),
>   	DIR("fd",         S_IRUSR|S_IXUSR, proc_fd_inode_operations, proc_fd_operations),
>   	DIR("map_files",  S_IRUSR|S_IXUSR, proc_map_files_inode_operations, proc_map_files_operations),
> -	DIR("fdinfo",     S_IRUSR|S_IXUSR, proc_fdinfo_inode_operations, proc_fdinfo_operations),
> +	DIR("fdinfo",     S_IRUGO|S_IXUGO, proc_fdinfo_inode_operations, proc_fdinfo_operations),
>   	DIR("ns",	  S_IRUSR|S_IXUGO, proc_ns_dir_inode_operations, proc_ns_dir_operations),
>   #ifdef CONFIG_NET
>   	DIR("net",        S_IRUGO|S_IXUGO, proc_net_inode_operations, proc_net_operations),
> @@ -3504,7 +3504,7 @@ static const struct inode_operations proc_tid_comm_inode_operations = {
>    */
>   static const struct pid_entry tid_base_stuff[] = {
>   	DIR("fd",        S_IRUSR|S_IXUSR, proc_fd_inode_operations, proc_fd_operations),
> -	DIR("fdinfo",    S_IRUSR|S_IXUSR, proc_fdinfo_inode_operations, proc_fdinfo_operations),
> +	DIR("fdinfo",    S_IRUGO|S_IXUGO, proc_fdinfo_inode_operations, proc_fdinfo_operations),
>   	DIR("ns",	 S_IRUSR|S_IXUGO, proc_ns_dir_inode_operations, proc_ns_dir_operations),
>   #ifdef CONFIG_NET
>   	DIR("net",        S_IRUGO|S_IXUGO, proc_net_inode_operations, proc_net_operations),
> diff --git a/fs/proc/fd.c b/fs/proc/fd.c
> index 07fc4fad2602..6a80b40fd2fe 100644
> --- a/fs/proc/fd.c
> +++ b/fs/proc/fd.c
> @@ -6,6 +6,7 @@
>   #include <linux/fdtable.h>
>   #include <linux/namei.h>
>   #include <linux/pid.h>
> +#include <linux/ptrace.h>
>   #include <linux/security.h>
>   #include <linux/file.h>
>   #include <linux/seq_file.h>
> @@ -72,6 +73,18 @@ static int seq_show(struct seq_file *m, void *v)
>   
>   static int seq_fdinfo_open(struct inode *inode, struct file *file)
>   {
> +	bool allowed = false;
> +	struct task_struct *task = get_proc_task(inode);
> +
> +	if (!task)
> +		return -ESRCH;
> +
> +	allowed = ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS);
> +	put_task_struct(task);
> +
> +	if (!allowed)
> +		return -EACCES;
> +
>   	return single_open(file, seq_show, inode);
>   }
>   
> @@ -308,7 +321,7 @@ static struct dentry *proc_fdinfo_instantiate(struct dentry *dentry,
>   	struct proc_inode *ei;
>   	struct inode *inode;
>   
> -	inode = proc_pid_make_inode(dentry->d_sb, task, S_IFREG | S_IRUSR);
> +	inode = proc_pid_make_inode(dentry->d_sb, task, S_IFREG | S_IRUGO);
>   	if (!inode)
>   		return ERR_PTR(-ENOENT);
>   

