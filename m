Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3AD2E9E57
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jan 2021 20:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbhADTw0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 14:52:26 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:43326 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbhADTw0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 14:52:26 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 104JhsRt035793;
        Mon, 4 Jan 2021 19:51:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=aR5E33ngmM7rA62zOVK1kNDHyQ1ZhIMHNofceRK43oY=;
 b=tZ6PDIrmrYEHFS6MJkkZg39L4P9UbJPfi96nsJzOXI7+dwovQUhsLnxFeQo+B9Uvq+6m
 dHovtt15YZRSJL1tCLKJOj/FIa0oBOERJDWL+yD6xe7a8cOTbS/YfKi3XouEcMxrsJJO
 rgd3Ttio6mVEagOCaIcNLq56zQIy2669/WrkV8XgJIy0oGXg+qEgraSGVxASAsByRRvs
 7JaYIQ/kzXpZTP+FH1NNk3zHrCcRjAWJn6yWThEk8uuHvaRvFx6NoVcJz26WMdhDUrSe
 CRgzS+5Vz0kySVly0+wSrJf8vi8gztS5QM4Tg3gnxlUnX+h2qgg39glbKJ27Ki7rShUB 6w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 35tg8qwyfj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 04 Jan 2021 19:51:22 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 104JihXY093653;
        Mon, 4 Jan 2021 19:51:21 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 35v1f7rp4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Jan 2021 19:51:21 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 104Jp8Xv017494;
        Mon, 4 Jan 2021 19:51:08 GMT
Received: from localhost (/10.159.240.116)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Jan 2021 11:51:07 -0800
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        SElinux list <selinux@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 2/2] proc: ensure security hook is called after exec
In-Reply-To: <CAEjxPJ4bUxSp3hMV9k5Z5Zpev=ravd6EJheC1Rdg+_72eUiNLA@mail.gmail.com>
References: <20201219000616.197585-1-stephen.s.brennan@oracle.com>
 <20201219000616.197585-2-stephen.s.brennan@oracle.com>
 <CAEjxPJ4bUxSp3hMV9k5Z5Zpev=ravd6EJheC1Rdg+_72eUiNLA@mail.gmail.com>
Date:   Mon, 04 Jan 2021 11:51:07 -0800
Message-ID: <87pn2k5vmc.fsf@stepbren-lnx.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9854 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101040124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9854 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 phishscore=0 bulkscore=0
 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101040124
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Stephen Smalley <stephen.smalley.work@gmail.com> writes:

> On Fri, Dec 18, 2020 at 7:06 PM Stephen Brennan
> <stephen.s.brennan@oracle.com> wrote:
>>
>> Smack needs its security_task_to_inode() hook to be called when a task
>> execs a new executable. Store the self_exec_id of the task and call the
>> hook via pid_update_inode() whenever the exec_id changes.
>>
>> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
>
> Sorry to be late in responding, but the proc inode security structure
> needs to be updated not only upon a context-changing exec but also
> upon a setcon(3) aka write to /proc/self/attr/current just like the
> uid/gid needs to be updated not only upon a setuid exec but also upon
> a setuid(2).  I'm also unclear as to why you can't call
> security_task_to_inode during RCU lookup; it doesn't block/sleep
> AFAICT.
> All it does is take a spinlock and update a few fields.

The reason I assumed that we need to drop out of RCU mode to update the
inode and call the security hooks was simply because that is how the
code worked originally. I wanted to be conservative in my changes, by
only leaving RCU mode "when necessary", but this assumed that it was
necessary to leave RCU mode at all!

None of the data in a proc inode (at least, i_mode, i_uid, i_gid) seems
to be "RCU protected" in the sense that they could not be modified
during an RCU read critical section. If this were the case, then there
would have to be some sort of copying and a synchronize_rcu() used
somewhere.  So it seems that running pid_update_inode() (which does not
sleep and simply takes some spinlocks) should be safe during RCU mode.

My assumption had originally been that the security_pid_to_inode() calls
could be liable to sleep. But during this review we've seen that both
the selinux and smack security_pid_to_inode() implementations are also
"RCU safe" in that they do not sleep.

So rather than trying to guess when this security hook would like to be
called, it seems that it would be safe to take the easiest option: just
execute pid_revalidate() in RCU mode always, for instance with the
example changes below. Is there anything obviously wrong with this
approach that I'm missing?

diff --git a/fs/proc/base.c b/fs/proc/base.c
index ebea9501afb8..105581e51032 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1830,19 +1830,18 @@ static int pid_revalidate(struct dentry *dentry, unsigned int flags)
 {
 	struct inode *inode;
 	struct task_struct *task;
+	int rv = 0;
 
-	if (flags & LOOKUP_RCU)
-		return -ECHILD;
-
-	inode = d_inode(dentry);
-	task = get_proc_task(inode);
+	rcu_read_lock();
+	inode = d_inode_rcu(dentry);
+	task = pid_task(proc_pid(inode), PIDTYPE_PID);
 
 	if (task) {
 		pid_update_inode(task, inode);
-		put_task_struct(task);
-		return 1;
+		rv = 1;
 	}
-	return 0;
+	rcu_read_unlock();
+	return rv;
 }
 
 static inline bool proc_inode_is_dead(struct inode *inode)
