Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2552D9EBA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Dec 2020 19:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440686AbgLNSQq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Dec 2020 13:16:46 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:37598 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439948AbgLNSQc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Dec 2020 13:16:32 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BEIEDCI034754;
        Mon, 14 Dec 2020 18:15:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=ZaSEriH/etd6gavTjqmBnMgdg9IepI1ZheaObdqlGiI=;
 b=cJ2Sha+ltYGzoTHA12hggpi/bgadXCRyNBJL8YwE4ndhbX+PxqpXW5r7Obad/SQV2AyL
 aOFDUxT1PQJvP17banc9fT7SZ16/eDq4bV2PpRE2XciAalqaWGWkyml6bjalzEa4Y5b6
 GhS3Vec5dIGEHAfMT8CTNVsctSOflUev/6yO/dX37RG2yEwZSgGiI4d1BIZFzzREy3BH
 ogCVKoO+WhAbSWJKYbNxq8FSbUjErmkgfGxQbc1okfqi89AuCStusgQujCp2xp15ilUp
 YgjoKdqvYGuMAHdFTxdcX8Wsw6whOSApi8mluhDimq1xwiZer0z5fO57eX4XR4fqdAfW bw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 35cn9r6qas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Dec 2020 18:15:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BEIEn3g065836;
        Mon, 14 Dec 2020 18:15:35 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 35e6ep9ck7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Dec 2020 18:15:35 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BEIFUs6025547;
        Mon, 14 Dec 2020 18:15:31 GMT
Received: from localhost (/10.159.237.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 14 Dec 2020 10:15:29 -0800
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] proc: Allow pid_revalidate() during LOOKUP_RCU
In-Reply-To: <877dpln5uf.fsf@x220.int.ebiederm.org>
References: <20201204000212.773032-1-stephen.s.brennan@oracle.com>
 <20201212205522.GF2443@casper.infradead.org>
 <877dpln5uf.fsf@x220.int.ebiederm.org>
Date:   Mon, 14 Dec 2020 10:15:27 -0800
Message-ID: <8736082r0g.fsf@stepbren-lnx.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9834 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=956 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012140121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9834 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=973
 impostorscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012140121
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> Matthew Wilcox <willy@infradead.org> writes:
>
>> On Thu, Dec 03, 2020 at 04:02:12PM -0800, Stephen Brennan wrote:
>>> -void pid_update_inode(struct task_struct *task, struct inode *inode)
>>> +static int do_pid_update_inode(struct task_struct *task, struct inode *inode,
>>> +			       unsigned int flags)
>>
>> I'm really nitpicking here, but this function only _updates_ the inode
>> if flags says it should.  So I was thinking something like this
>> (compile tested only).
>>
>> I'd really appreocate feedback from someone like Casey or Stephen on
>> what they need for their security modules.
>
> Just so we don't have security module questions confusing things
> can we please make this a 2 patch series?  With the first
> patch removing security_task_to_inode?
>
> The justification for the removal is that all security_task_to_inode
> appears to care about is the file type bits in inode->i_mode.  Something
> that never changes.  Having this in a separate patch would make that
> logical change easier to verify.
>

I'll gladly split that out in v3 so we can continue the discussion
there.

I'll also include some changes with Matthew's suggestion of
inode_needs_pid_update(). This in combination with your suggestion to do
fewer flag checks in pid_revalidate() should cleanup the code a fair bit.

Stephen

> Eric
>
>>
>> diff --git a/fs/proc/base.c b/fs/proc/base.c
>> index b362523a9829..771f330bfce7 100644
>> --- a/fs/proc/base.c
>> +++ b/fs/proc/base.c
>> @@ -1968,6 +1968,25 @@ void pid_update_inode(struct task_struct *task, struct inode *inode)
>>  	security_task_to_inode(task, inode);
>>  }
>>  
>> +/* See if we can avoid the above call.  Assumes RCU lock held */
>> +static bool inode_needs_pid_update(struct task_struct *task,
>> +		const struct inode *inode)
>> +{
>> +	kuid_t uid;
>> +	kgid_t gid;
>> +
>> +	if (inode->i_mode & (S_ISUID | S_ISGID))
>> +		return true;
>> +	task_dump_owner(task, inode->i_mode, &uid, &gid);
>> +	if (!uid_eq(uid, inode->i_uid) || !gid_eq(gid, inode->i_gid))
>> +		return true;
>> +	/*
>> +	 * XXX: Do we need to call the security system here to see if
>> +	 * there's a pending update?
>> +	 */
>> +	return false;
>> +}
>> +
>>  /*
>>   * Rewrite the inode's ownerships here because the owning task may have
>>   * performed a setuid(), etc.
>> @@ -1978,8 +1997,15 @@ static int pid_revalidate(struct dentry *dentry, unsigned int flags)
>>  	struct inode *inode;
>>  	struct task_struct *task;
>>  
>> -	if (flags & LOOKUP_RCU)
>> +	if (flags & LOOKUP_RCU) {
>> +		inode = d_inode_rcu(dentry);
>> +		task = pid_task(proc_pid(inode), PIDTYPE_PID);
>> +		if (!task)
>> +			return 0;
>> +		if (!inode_needs_pid_update(task, inode))
>> +			return 1;
>>  		return -ECHILD;
>> +	}
>>  
>>  	inode = d_inode(dentry);
>>  	task = get_proc_task(inode);
