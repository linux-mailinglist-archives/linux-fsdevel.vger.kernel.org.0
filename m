Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969932EB62D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jan 2021 00:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbhAEX2a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jan 2021 18:28:30 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:34942 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbhAEX2a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jan 2021 18:28:30 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 105NF5mt170674;
        Tue, 5 Jan 2021 23:27:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=tyV62G40bD/pUWWd9jFwnRCJ68TPKtBWn9L5iARg8W0=;
 b=D53IVTKPiz3BFnesbpSctdeFdAosPnXlbG3fMixFG9nTKkaBiQXIAM45D4HATcTWLxJT
 SnmpjvXL56kguDEKEQvysfaZi8uAMS/+c7BkXLXYZ8Fe97ASTg8hNyEjIuY+mGHHnJSk
 cdbDdviVdq32Chu/Y/a3FnZv43Z4crxPhvJ21eH8JPU3B+3kr/bkdir9cpJW8W7Q+Eit
 osCVM3XFiz7ScsL/nubict1Vwkwswh0op/xK0N/tddU/I6+TTQillD3HkjU/ZAy/LRKx
 jFU1QR+vYmeb02zgW8htptX6MRsyiB+CBwz0JxRiXWge6JOW+fQx7x//L9wcfLrWrlCy NQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 35tebau93t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 05 Jan 2021 23:27:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 105NGPXj147406;
        Tue, 5 Jan 2021 23:25:22 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 35v4rbyp9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Jan 2021 23:25:22 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 105NPDq2008196;
        Tue, 5 Jan 2021 23:25:15 GMT
Received: from localhost (/10.159.141.245)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 05 Jan 2021 15:25:13 -0800
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v4] proc: Allow pid_revalidate() during LOOKUP_RCU
In-Reply-To: <20210105195937.GX3579531@ZenIV.linux.org.uk>
References: <20210104232123.31378-1-stephen.s.brennan@oracle.com>
 <20210105055935.GT3579531@ZenIV.linux.org.uk>
 <20210105165005.GV3579531@ZenIV.linux.org.uk>
 <20210105195937.GX3579531@ZenIV.linux.org.uk>
Date:   Tue, 05 Jan 2021 15:25:11 -0800
Message-ID: <87a6tnge5k.fsf@stepbren-lnx.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9855 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101050133
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9855 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 clxscore=1011 bulkscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101050133
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Tue, Jan 05, 2021 at 04:50:05PM +0000, Al Viro wrote:
>
>> LSM_AUDIT_DATA_DENTRY is easy to handle - wrap
>>                 audit_log_untrustedstring(ab, a->u.dentry->d_name.name);
>> into grabbing/dropping a->u.dentry->d_lock and we are done.
>
> Incidentally, LSM_AUDIT_DATA_DENTRY in mainline is *not* safe wrt
> rename() - for long-named dentries it is possible to get preempted
> in the middle of
>                 audit_log_untrustedstring(ab, a->u.dentry->d_name.name);
> and have the bugger renamed, with old name ending up freed.  The
> same goes for LSM_AUDIT_DATA_INODE...

In the case of proc_pid_permission(), this preemption doesn't seem
possible. We have task_lock() (a spinlock) held by ptrace_may_access()
during this call, so preemption should be disabled:

proc_pid_permission()
  has_pid_permissions()
    ptrace_may_access()
      task_lock()
      __ptrace_may_access()
      | security_ptrace_access_check()
      |   ptrace_access_check -> selinux_ptrace_access_check()
      |     avc_has_perm()
      |       avc_audit() // note that has_pid_permissions() didn't get a
      |                   // flags field to propagate, so flags will not
      |                   // contain MAY_NOT_BLOCK
      |         slow_avc_audit()
      |           common_lsm_audit()
      |             dump_common_audit_data()
      task_unlock()

I understand the issue of d_name.name being freed across a preemption is
more general than proc_pid_permission() (as other callers may have
preemption enabled). However, it seems like there's another issue here.
avc_audit() seems to imply that slow_avc_audit() would sleep:
 
static inline int avc_audit(struct selinux_state *state,
			    u32 ssid, u32 tsid,
			    u16 tclass, u32 requested,
			    struct av_decision *avd,
			    int result,
			    struct common_audit_data *a,
			    int flags)
{
	u32 audited, denied;
	audited = avc_audit_required(requested, avd, result, 0, &denied);
	if (likely(!audited))
		return 0;
	/* fall back to ref-walk if we have to generate audit */
	if (flags & MAY_NOT_BLOCK)
		return -ECHILD;
	return slow_avc_audit(state, ssid, tsid, tclass,
			      requested, audited, denied, result,
			      a);
} 

If there are other cases in here where we might sleep, it would be a
problem to sleep with the task lock held, correct?
