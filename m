Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 813482F6EA5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jan 2021 23:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730994AbhANWwe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Jan 2021 17:52:34 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:39220 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730988AbhANWwe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Jan 2021 17:52:34 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10EMoD9f047144;
        Thu, 14 Jan 2021 22:51:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=1GIYbQk4Gp7v6M1E5BZJYVNgEi14/UhOP10cB+FUS7U=;
 b=knIQ32GTS4wk9eBHaer7lidjtvEI5JRPAFIVQS7OREkAa0MPJvCA1WTYbJbuJqYrAoyf
 wR3mJzDynMFEPn+/kYt+PbVZf1N1kIz/D8gjIKkc+wSOLOvxaaqZVt0SeOuBHR3c6FXp
 kCsuEvbrWtckScgxbpnpw0wb3jgIFrWbzNx9pn6QFSeZ9uqIbjllR5ZfgQG7Kp4jrWJv
 /NNKFEuBJkV6UJpQrGEr/sRuPscJHS1P5D5ZzMqVxtZrNlLzHIxNIjugYFqOZtRizSTb
 tPBCHcsBlnYmEVdqIYnHlfWr0A9cFCeaY67Al0/NKL96AzhkDzFe6QViRvJ1yACYbwVv EQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 360kd02j9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jan 2021 22:51:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10EMoeUa044319;
        Thu, 14 Jan 2021 22:51:29 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 360kfa695g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jan 2021 22:51:29 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10EMpK1v016566;
        Thu, 14 Jan 2021 22:51:21 GMT
Received: from localhost (/10.159.145.187)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Jan 2021 14:51:20 -0800
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Al Viro <viro@zeniv.linux.org.uk>, Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v4] proc: Allow pid_revalidate() during LOOKUP_RCU
In-Reply-To: <20210106003803.GA3579531@ZenIV.linux.org.uk>
References: <20210104232123.31378-1-stephen.s.brennan@oracle.com>
 <20210105055935.GT3579531@ZenIV.linux.org.uk>
 <20210105165005.GV3579531@ZenIV.linux.org.uk>
 <20210105195937.GX3579531@ZenIV.linux.org.uk>
 <87a6tnge5k.fsf@stepbren-lnx.us.oracle.com>
 <CAHC9VhQnQW8RvTzyb4MTAvGZ7b=AHJXS8PzD=egTcpdDz73Yzg@mail.gmail.com>
 <20210106003803.GA3579531@ZenIV.linux.org.uk>
Date:   Thu, 14 Jan 2021 14:51:17 -0800
Message-ID: <87k0sfyvx6.fsf@stepbren-lnx.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9864 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101140132
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9864 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101140132
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:
> OTTH, it's not really needed there - see vfs.git #work.audit
> for (untested) turning that sucker non-blocking.  I hadn't tried
> a followup that would get rid of the entire AVC_NONBLOCKING thing yet,
> but I suspect that it should simplify the things in there nicely...

I went ahead and pulled down this branch and combined it with my
pid_revalidate change. Further, I audited all the inode get_link and
permission() implementations, as well as dentry d_revalidate()
implementations, in fs/proc (more on that below). Together, all these
patches have run stable under a steady high load of concurrent PS
processes on a 104CPU machine for over an hour, and greatly reduced the
%sys utilization which the patch originally addressed. How would you
like to proceed with the #work.audit changes? I could include them in a
v5 of this patch series.

Regarding my audit (ha) of dentry and inode functions in the fs/proc/
directory:

* get_link() receives a NULL dentry pointer when called in RCU mode.
* permission() receives MAY_NOT_BLOCK in the mode parameter when called
  from RCU.
* d_revalidate() receives LOOKUP_RCU in flags.

There were generally three groups I found. Group (1) are functions which
contain a check at the top of the function and return -ECHILD, and so
appear to be trivially RCU safe (although this is by dropping out of RCU
completely). Group (2) are functions which have no explicit check, but
on my audit, I was confident that there were no sleeping function calls,
and thus were RCU safe as is. Group (3) are functions which appeared to
be unsafe for some reason or another.

Group (1):
 proc_ns_get_link()
 proc_pid_get_link()
 map_files_d_revalidate()
 proc_misc_d_revalidate()
 tid_fd_revalidate()

Group (2):
 proc_get_link()
 proc_self_get_link()
 proc_thread_self_get_link()
 proc_fd_permission()

Group (3):
 pid_revalidate()            -- addressed by my patch
 proc_map_files_get_link()
 proc_pid_permission()       -- addressed by Al's work.audit branch

proc_map_files_get_link() calls capable() which ends up calling a
security hook, which can get into the audit guts, and so I marked it as
potentially unsafe, and added a patch to bail out of this function
before the capable() check. However, I doubt this is really necessary.

So to conclude, depending on how Al wants to move forward with the
work.audit branch, I could send a full series with the proposed changes.

Stephen
