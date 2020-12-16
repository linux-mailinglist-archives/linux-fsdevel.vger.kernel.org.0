Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F982DB839
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 02:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgLPBGq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 20:06:46 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:51988 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgLPBGo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 20:06:44 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BG15f8R117535;
        Wed, 16 Dec 2020 01:05:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=peEJcocPSC8/5icjzSk+r0KDBKw5By7uoMvvhoSS5Tk=;
 b=BTLO0D+2EdIfKPP8LnZSmwtIzUjB13BrBzs950K3eWv0yEylpKeXR2/cEx/t+8CcGPY8
 204Lu2L9d7x2v2nJdihZlBMCApNtZLAANq0ic6VoYfWh3FLRD44I3KBd5DYpbLFlPrPF
 hY8JUzsu8NccM0U04Uc6Sv/Okw5KOsgrDsIDHlSJLr5w3Ki6+5ta4MNjiJbPICk+Ppb/
 p8Nefs+TB0db/ZmXT1EC9c50Zi84qASknE9WvD1OlUjdEZRL+XXOhQCGhziPMl+KwOqW
 J6Kl7i1YEvz2lW68dVVQkEYyhXXpCBJJTifthtfB33pqFgYNyo1LWnnrGjzASwBKPRhr Hg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 35ckcbdrq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Dec 2020 01:05:41 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BG10SCa154468;
        Wed, 16 Dec 2020 01:05:38 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 35d7sx22x2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Dec 2020 01:05:38 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BG15UdI008716;
        Wed, 16 Dec 2020 01:05:33 GMT
Received: from localhost (/136.24.53.113)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Dec 2020 17:05:29 -0800
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Matthew Wilcox <willy@infradead.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH v2] proc: Allow pid_revalidate() during LOOKUP_RCU
In-Reply-To: <ee27cf98-5636-33e8-5c2e-019529848617@schaufler-ca.com>
References: <20201204000212.773032-1-stephen.s.brennan@oracle.com>
 <20201212205522.GF2443@casper.infradead.org>
 <877dpln5uf.fsf@x220.int.ebiederm.org>
 <20201213162941.GG2443@casper.infradead.org>
 <CAHC9VhSytjTGPhaKFC7Cq1qotps7oyFjU7vN4oLYSxXrruTfAQ@mail.gmail.com>
 <3504e55a-e429-8f51-1b23-b346434086d8@schaufler-ca.com>
 <87im92d8tw.fsf@x220.int.ebiederm.org>
 <ee27cf98-5636-33e8-5c2e-019529848617@schaufler-ca.com>
Date:   Tue, 15 Dec 2020 17:05:27 -0800
Message-ID: <87y2hy1rxk.fsf@stepbren-lnx.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9836 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012160002
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9836 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012160003
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Casey Schaufler <casey@schaufler-ca.com> writes:

> On 12/15/2020 2:04 PM, Eric W. Biederman wrote:
>> Casey Schaufler <casey@schaufler-ca.com> writes:
>>
>>> On 12/13/2020 3:00 PM, Paul Moore wrote:
>>>> On Sun, Dec 13, 2020 at 11:30 AM Matthew Wilcox <willy@infradead.org> wrote:
>>>>> On Sun, Dec 13, 2020 at 08:22:32AM -0600, Eric W. Biederman wrote:
>>>>>> Matthew Wilcox <willy@infradead.org> writes:
>>>>>>
>>>>>>> On Thu, Dec 03, 2020 at 04:02:12PM -0800, Stephen Brennan wrote:
>>>>>>>> -void pid_update_inode(struct task_struct *task, struct inode *inode)
>>>>>>>> +static int do_pid_update_inode(struct task_struct *task, struct inode *inode,
>>>>>>>> +                         unsigned int flags)
>>>>>>> I'm really nitpicking here, but this function only _updates_ the inode
>>>>>>> if flags says it should.  So I was thinking something like this
>>>>>>> (compile tested only).
>>>>>>>
>>>>>>> I'd really appreocate feedback from someone like Casey or Stephen on
>>>>>>> what they need for their security modules.
>>>>>> Just so we don't have security module questions confusing things
>>>>>> can we please make this a 2 patch series?  With the first
>>>>>> patch removing security_task_to_inode?
>>>>>>
>>>>>> The justification for the removal is that all security_task_to_inode
>>>>>> appears to care about is the file type bits in inode->i_mode.  Something
>>>>>> that never changes.  Having this in a separate patch would make that
>>>>>> logical change easier to verify.
>>>>> I don't think that's right, which is why I keep asking Stephen & Casey
>>>>> for their thoughts.
>>>> The SELinux security_task_to_inode() implementation only cares about
>>>> inode->i_mode S_IFMT bits from the inode so that we can set the object
>>>> class correctly.  The inode's SELinux label is taken from the
>>>> associated task.
>>>>
>>>> Casey would need to comment on Smack's needs.
>>> SELinux uses different "class"es on subjects and objects.
>>> Smack does not differentiate, so knows the label it wants
>>> the inode to have when smack_task_to_inode() is called,
>>> and sets it accordingly. Nothing is allocated in the process,
>>> and the new value is coming from the Smack master label list.
>>> It isn't going to go away. It appears that this is the point
>>> of the hook. Am I missing something?
>> security_task_to_inode (strangely named as this is proc specific) is
>> currently called both when the inode is initialized in proc and when
>> pid_revalidate is called and the uid and gid of the proc inode
>> are updated to match the traced task.
>>
>> I am suggesting that the call of security_task_to_inode in
>> pid_revalidate be removed as neither of the two implementations of this
>> security hook smack nor selinux care of the uid or gid changes.
>
> If you're sure that the only case where pid_revalidate() would matter
> is for the uid/gid cases that would be OK.
>
>>
>> Removal of the security check will allow proc to be accessed in rcu look
>> mode.  AKA give proc go faster stripes.
>>
>> The two implementations are:
>>
>> static void selinux_task_to_inode(struct task_struct *p,
>> 				  struct inode *inode)
>> {
>> 	struct inode_security_struct *isec = selinux_inode(inode);
>> 	u32 sid = task_sid(p);
>>
>> 	spin_lock(&isec->lock);
>> 	isec->sclass = inode_mode_to_security_class(inode->i_mode);
>> 	isec->sid = sid;
>> 	isec->initialized = LABEL_INITIALIZED;
>> 	spin_unlock(&isec->lock);
>> }
>>
>>
>> static void smack_task_to_inode(struct task_struct *p, struct inode *inode)
>> {
>> 	struct inode_smack *isp = smack_inode(inode);
>> 	struct smack_known *skp = smk_of_task_struct(p);
>>
>> 	isp->smk_inode = skp;
>> 	isp->smk_flags |= SMK_INODE_INSTANT;
>> }
>>
>> I see two questions gating the safe removal of the call of
>> security_task_to_inode from pid_revalidate.
>>
>> 1) Does any of this code care about uids or gids.
>>    It appears the answer is no from a quick inspection of the code.
>
> It looks that way.
>
>>
>> 2) Does smack_task_to_inode need to be called after exec?
>>    - Exec especially suid exec changes the the cred on a task.
>>    - Execing of a non-leader thread changes the thread_pid of a task
>>      so that it is the pid of the entire thread group.
>
> I think so. If SMACK64EXEC is set on a binary the label will
> be changed on exec. The /proc inode Smack label would need to
> be changed.
>
>>
>>    If either of those are significant perhaps we can limit calling
>>    security_task_to_inode if task->self_exec_id is different.

Given these answers then, it seems like a proper implementation would
leave the security_task_to_inode() call in pid_update_inode(). Then,
pid_revalidate() would drop out of RCU mode whenever some function like
this (drawing on Matthew's idea above) returns true:

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 449204e9f749..02805076c42b 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1820,6 +1820,26 @@ void pid_update_inode(struct task_struct *task, struct inode *inode)
 	inode->i_mode &= ~(S_ISUID | S_ISGID);
 }
 
+/* See if we can avoid the above call. Assumes RCU lock held */
+static bool pid_inode_needs_update(struct task_struct *task, struct inode *inode)
+{
+	kuid_t uid;
+	kgid_t gid;
+	u32 exec_id, last_exec_id;
+
+	if (inode->i_mode & (S_ISUID | S_ISGID))
+		return true;
+	task_dump_owner(task, inode->i_mode, &uid, &gid);
+	if (!uid_eq(uid, inode->i_uid) || !gid_eq(gid, inode->i_gid))
+		return true;
+
+	last_exec_id = /* find this stored somewhere? */;
+	task_lock(task);
+	exec_id = task->self_exec_id;
+	task_unlock(task);
+	return exec_id != last_exec_id;
+}
+
 /*
  * Rewrite the inode's ownerships here because the owning task may have
  * performed a setuid(), etc.


Does this make sense?

Stephen

>>
>>    I haven't yet take the time to trace through and see if
>>    task_sid(p) or smk_of_task_struct(p) could change based on
>>    the security hooks called during exec.  Or how bad the races are if
>>    such a change can happen.
>>
>> Does that clarify the question that is being asked?
>>
>> Eric
