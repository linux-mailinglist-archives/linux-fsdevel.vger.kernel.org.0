Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3771E62C7BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 19:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239237AbiKPShi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 13:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239190AbiKPShg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 13:37:36 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806B959FD5;
        Wed, 16 Nov 2022 10:37:35 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AGH4GYn021494;
        Wed, 16 Nov 2022 18:37:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2022-7-12;
 bh=KES6PSmYxKnBrqetXzk1HXlRI7ZhMpcTn9pDKyEBR2Y=;
 b=rAv/Uz+yNJ/F4Ksz+fCdEP2XkXF6R8W/Haiq5oe7w5p7T2hNVCnZuPtXCfH+Fo6OkcyK
 uuvWJvHI5A+wk3E4T/JPasBOOwkh+v/JLRpPVB0JpQJL7VblXzJUdBFIXVrLavGI8xK+
 FE5xEPhL+EgnQy/ldJaoUEpYag+b8rlNk7YGrcgLy6nOPmSG8ADIy9Ese6QhEY6PiPvQ
 O1rTtLOO74P3o8pHQUciTAG/cRGCgLluAERYvO+vGHBD5hF1rTsmZxhpXXzegaNUK9f5
 m1UvaAcsGDas4StNY9C0CdSzyu65/zYyIohyz1TwTib/hsl5lJikaTHnMV1DDqnVcMW3 Cw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv3hdwr0e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Nov 2022 18:37:34 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AGHvESB012506;
        Wed, 16 Nov 2022 18:37:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1xe6534-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Nov 2022 18:37:33 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AGIbXlS032760;
        Wed, 16 Nov 2022 18:37:33 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3kt1xe652e-1;
        Wed, 16 Nov 2022 18:37:33 +0000
From:   Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     anjali.k.kulkarni@oracle.com
Subject: [RFC] Add a new generic system call which has better performance, to get /proc data, than existing mechanisms
Date:   Wed, 16 Nov 2022 10:37:24 -0800
Message-Id: <1668623844-9114-1-git-send-email-anjali.k.kulkarni@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-16_03,2022-11-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=855 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211160127
X-Proofpoint-ORIG-GUID: dQkTLucPRJUZexAAp7sf7ETvmhpLTRRt
X-Proofpoint-GUID: dQkTLucPRJUZexAAp7sf7ETvmhpLTRRt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently, reading from /proc is an expensive operation, for a performance sensitive application – that is because the /proc files are in ascii and you need to convert from binary to ascii & vice versa. Add to that, if the application needs to read a huge number of files from /proc in a short amount of time, the time taken is very high and performance is affected for the application. We want to address this issue by creating a generic system call, which can be used to read any of the data in /proc, without going through /proc, but fetching the data from the kernel directly. Additionally, a vectored list of /proc items can be fetched in one system call to further save multiple system calls.
 
As an example of such an application at Oracle, Oracle Database is a multi-process/multi threaded architecture. The database maintains process state in the shared memory. One of the states it maintains and needs to get an update on periodically is the start time of multiple process(obtained by reading start time entry in /proc/pid/stat). However, reading start time from /proc of 1000s of pids is slow and consumes a lot of cpu time. We need a faster way to get the data we want, without going through /proc. For oracle DB, it needs this information every 1-3 seconds, with an average of 10K-64K processes per system, so over time, the savings in performance is very large if we use a vectored system call.
 
Another example of an application which can benefit from this is Performance Co-Pilot (PCP). The benefit can be obtained by optimizing the process related metrics code path. PCP does an opendir and readdir on /proc each time it wants to refresh the pid list. Then for each pid, it reads various files under /proc/pid to get metrics for the process, e.g the following proc files are read:

/proc/pid/status
/proc/pid/stat
/proc/pid/wchan
/proc/pid/smaps
/proc/pid/maps
/proc/pid/io

So the more number of processes are running on the system, this operation would be more costly because that many files have to be opened, etc.  If this information can be obtained using one (or fewer) system call(s) from the kernel, it will improve the performance.

Considering the above 2 applications, we will initially support the fields under /proc/pid/stat. Eventually, we will expand to the above listed /proc/pid values (needed for PCP). If other applications come into our view which need more fields, we can add those as cases arise.

Considering the granularity of the item to be requested from the kernel, we can fetch either the entire /proc/pid/<item> for eg. /proc/pid/stat from the kernel as a vectored list for multiple PIDs, or fetch each individual item from /proc/pid/stat like start time, as is useful for Oracle database. For this, we are thinking over and will eventually come up with an efficient mapping mechanism to map the /proc fields to numeric constants.

To be able to return values which are of different formats, we have returned a void pointer, which can point to an array of any type, for eg, an array of integers for start times, and could be an array of structs for something else which needs to return an array of multiple values. Both kernel and user can interpret the right structure based on the mapping between /proc and item being returned from the kernel.

To get some performance numbers, we have done a prototype of a system call to handle the database case, which is of immediate need to Oracle. The system call takes as input an array of PIDs and returns an array of start times. As a micro benchmark, compared the retrieval of 8000 PIDs with /proc directly, as compared to fetching from system call. Fetching from /proc directly, takes about 100ms for 8000 PIDs, and using system call approach we reduce this time to about 1ms for 8000 PIDs. The more the no. of PIDS, the more will be the savings.
 
This system call not only fetches data directly from the kernel (and not /proc), but also allows us to get a vectored list of the data items requested via one system call. Hence an array of requested /proc item is input to the system call, and an array of the value of that item is output from the system call.

As an example of how this call will be made is shown below :
 
ret = syscall(SYSCALL_NUMBER, PID_START_TIME, LEN, pidarr, stimes);
 
where,
PID_START_TIME = start time of any process, fetched from /proc/$pid/stat.
LEN = length of the array of the pids whose start times need to be fetched
pidarr = An input array of length LEN, which has a list of pids, whose start times need to be fetched
stimes = An output array from the system call, listing the start times of the pids.

Diff of prototype is shown below:

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 10c74a2a45bb..ca69f6d38bfc 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -373,6 +373,7 @@
 # This one is a temporary number, designed for no clashes.
 # Nothing but DTrace should use it.
 473	common	waitfd			sys_waitfd
+474	common  get_vector		sys_get_vector
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/fs/proc/array.c b/fs/proc/array.c
index 49be8c8ef555..91f4d73314c9 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -92,6 +92,7 @@
 #include <linux/string_helpers.h>
 #include <linux/user_namespace.h>
 #include <linux/fs_struct.h>
+#include <linux/syscalls.h>
 
 #include <asm/processor.h>
 #include "internal.h"
@@ -449,6 +450,89 @@ int proc_pid_status(struct seq_file *m, struct pid_namespace *ns,
 	return 0;
 }
 
+/*
+ * Get the start times of the array of PIDs given in pidarr
+ * If any PID is not found or there is an error for any one of the PIDs,
+ * indicate an error by returning start time for that PID as 0, and continue
+ * to the next PID
+ */
+void pids_start_time(int *pidarr, size_t len, unsigned long long *stimes)
+{
+	struct task_struct *task = NULL;
+	int i;
+	struct pid *pid = NULL;
+
+	for (i = 0; i < len; i++) {
+		pid = find_get_pid(pidarr[i]);
+		if (!pid) {
+			stimes[i] = 0;
+			continue;
+		}
+
+		task = get_pid_task(pid, PIDTYPE_PID);
+		if (!task) {
+			stimes[i] = 0;
+			continue;
+		}
+
+		if (task->pid == pidarr[i])
+			stimes[i] =
+				nsec_to_clock_t(timens_add_boottime_ns(task->start_boottime));
+		else
+			stimes[i] = 0;
+
+		put_task_struct(task);
+	}
+}
+
+asmlinkage long sys_get_vector(int op, size_t len, const void __user *arg,
+			       void *out_arr)
+{
+	size_t in_tsize, out_tsize;
+	int *in_karr;
+	unsigned long long *out_karr;
+
+	switch (op) {
+	case PID_START_TIME:
+		in_tsize = len * sizeof(int);
+		in_karr = (int *) kmalloc(in_tsize, GFP_KERNEL);
+		if (!in_karr)
+			return -ENOMEM;
+
+		if (copy_from_user(in_karr, arg, in_tsize)) {
+			goto free_in_karr;
+			return -EFAULT;
+		}
+
+		out_tsize = len * sizeof(unsigned long long);
+		out_karr = (unsigned long long *) kmalloc(out_tsize, GFP_KERNEL);
+		if (!out_karr) {
+			goto free_in_karr;
+			return -ENOMEM;
+		}
+
+		pids_start_time(in_karr, len, out_karr);
+		if (copy_to_user(out_arr, out_karr, out_tsize)) {
+			goto free_out_karr;
+			return -EFAULT;
+		}
+free_out_karr:
+		kfree(out_karr);
+free_in_karr:
+		kfree(in_karr);
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+SYSCALL_DEFINE4(get_vector, int, op, size_t, len, const void __user *, arg,
+		void *, out_arr)
+{
+	return sys_get_vector(op, len, arg, out_arr);
+}
+
 static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 			struct pid *pid, struct task_struct *task, int whole)
 {
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 03415f3fb3a8..1220c95b8f9e 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -74,6 +74,8 @@ struct proc_dir_entry {
 	0)
 #define SIZEOF_PDE_INLINE_NAME (SIZEOF_PDE - sizeof(struct proc_dir_entry))
 
+#define PID_START_TIME 1
+
 static inline bool pde_is_permanent(const struct proc_dir_entry *pde)
 {
 	return pde->flags & PROC_ENTRY_PERMANENT;
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index e92af9a8bbf8..abc0b74d2143 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1384,4 +1384,6 @@ int __sys_getsockopt(int fd, int level, int optname, char __user *optval,
 		int __user *optlen);
 int __sys_setsockopt(int fd, int level, int optname, char __user *optval,
 		int optlen);
+asmlinkage long sys_get_vector(int op, size_t len, const void __user *arg, 
+			       void *outp);
 #endif
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index db285633c05b..8964d6326d9c 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -883,8 +883,11 @@ __SYSCALL(__NR_process_mrelease, sys_process_mrelease)
 #define __NR_waitfd 473
 __SYSCALL(__NR_waitfd, sys_waitfd)
 
+#define __NR_get_vector 474
+__SYSCALL(__NR_get_vector, sys_get_vector)
+
 #undef __NR_syscalls
-#define __NR_syscalls 474
+#define __NR_syscalls 475
 
 /*
  * 32 bit systems traditionally used different
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 64eb1931bf2a..80d8ac0144be 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -478,3 +478,4 @@ COND_SYSCALL(setuid16);
 
 /* restartable sequence */
 COND_SYSCALL(rseq);
+COND_SYSCALL(get_vector);
