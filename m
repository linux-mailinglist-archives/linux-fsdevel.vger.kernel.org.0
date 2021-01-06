Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5362EB736
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jan 2021 01:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbhAFA6M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jan 2021 19:58:12 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:54098 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbhAFA6M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jan 2021 19:58:12 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1060mtUB090362;
        Wed, 6 Jan 2021 00:57:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=rAuak8kVb/qU6rDh2HORTXHKYLS7nio8NbGlGy+us6A=;
 b=yrP4+n6f0sFMWYis8OeOX2R0zaZ5DpdvVtTQYPTnXYgbPIn+cUaD/XtLjRg4WpDUnyX1
 ngO0YZ8XYhaCI5700ziNdyLW4GI/+Agn8X1MWN1ys+AROTFZR5VV/lazomijkB6jPkQY
 8SnNEP+yEew3PibnqUChqXxZ01AjPRYA56sUxlFkHQR569hcYtl5Wjngs38W411Tbskq
 92qbQZujP5vKOSKVXhjTL0lts1YdJAm+PZXoLQ2ebJRrWHXYiMX3oQmjWq5WklbP78t7
 qEhhOMjdUjyzCWMZHTXcLc+OBXz1YwPtASaeEhSBIFg1i9p4rGnw0Q8JCnxrFv+54A30 Ag== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 35tgskub7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 06 Jan 2021 00:57:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1060pLNc183892;
        Wed, 6 Jan 2021 00:57:07 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 35vct6m75s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jan 2021 00:57:07 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 1060uvLX015901;
        Wed, 6 Jan 2021 00:57:00 GMT
Received: from localhost (/10.159.141.245)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 Jan 2021 00:56:57 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
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
In-Reply-To: <20210105055935.GT3579531@ZenIV.linux.org.uk>
References: <20210104232123.31378-1-stephen.s.brennan@oracle.com>
 <20210105055935.GT3579531@ZenIV.linux.org.uk>
Date:   Tue, 05 Jan 2021 16:56:56 -0800
Message-ID: <877doqhoh3.fsf@stepbren-lnx.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9855 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 mlxlogscore=921 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101060001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9855 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 adultscore=0 suspectscore=0 mlxlogscore=943
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101060001
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Mon, Jan 04, 2021 at 03:21:22PM -0800, Stephen Brennan wrote:
>> The pid_revalidate() function drops from RCU into REF lookup mode. When
>> many threads are resolving paths within /proc in parallel, this can
>> result in heavy spinlock contention on d_lockref as each thread tries to
>> grab a reference to the /proc dentry (and drop it shortly thereafter).
>> 
>> Investigation indicates that it is not necessary to drop RCU in
>> pid_revalidate(), as no RCU data is modified and the function never
>> sleeps. So, remove the LOOKUP_RCU check.
>
> Umm...  I'm rather worried about the side effect you are removing here -
> you are suddenly exposing a bunch of methods in there to RCU mode.
> E.g. is proc_pid_permission() safe with MAY_NOT_BLOCK in the mask?
> generic_permission() call in there is fine, but has_pid_permission()
> doesn't even see the mask.  Is that thing safe in RCU mode?  AFAICS,
> this
> static int selinux_ptrace_access_check(struct task_struct *child,
>                                      unsigned int mode)
> {
>         u32 sid = current_sid();
>         u32 csid = task_sid(child);
>
>         if (mode & PTRACE_MODE_READ)
>                 return avc_has_perm(&selinux_state,
>                                     sid, csid, SECCLASS_FILE, FILE__READ, NULL);
>
>         return avc_has_perm(&selinux_state,
>                             sid, csid, SECCLASS_PROCESS, PROCESS__PTRACE, NULL);
> }
> is reachable and IIRC avc_has_perm() should *NOT* be called in RCU mode.
> If nothing else, audit handling needs care...
>
> And LSM-related stuff is only a part of possible issues here.  It does need
> a careful code audit - you are taking a bunch of methods into the conditions
> they'd never been tested in.  ->permission(), ->get_link(), ->d_revalidate(),
> ->d_hash() and ->d_compare() instances for objects that subtree.  The last
> two are not there in case of anything in /proc/<pid>, but the first 3 very
> much are.

You're right, this was a major oversight on my part. The main motivation
of this patch is to reduce contention on the /proc dentry, which occurs
directly after d_revalidate() returns -ECHILD the first time in
lookup_fast(). To drop into ref mode, we call unlazy_child(), while
nd->path still refers to /proc and dentry refers to /proc/PID. Grabbing
a reference to /proc is the heart of the contention issue.

But directly after a successful d_revalidate() in lookup_fast(), we
return and go to step_into(), which assigns the /proc/PID dentry to
nd->path. After this point, any unlazy operation will not try to grab
the /proc dentry, resulting in significantly less contention.

So it would already be a significant improvement if we kept this change
to pid_revalidate(), and simply added checks to bail out of each of the
other procfs methods if we're in LOOKUP_RCU. Would that be an acceptable
change for you?
