Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B106D2D9D7F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Dec 2020 18:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389052AbgLNRUQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Dec 2020 12:20:16 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:37928 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732189AbgLNRUQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Dec 2020 12:20:16 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BEH4DrF115864;
        Mon, 14 Dec 2020 17:19:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=qa4SGN263GnWMH6gR/1PcYHczDLDbrHuMDP6ih5XBwY=;
 b=CAlYT3ZgbqlFlxScgD+LTjBBReB04hq6L18khCgUX8hl+ZA+pi9jceoU/+473vAJIz2I
 64ojxLeTJuoJx0IfIYyIQmq3+jh/iZP6E2UNbNnPeFd2xqZNMHAJ5jwQi+FQXqURsUnt
 P4gM2QbmKVdLrVfE3V+nTPO6gK6B/4EcvCtovho+PBD2W5okp77Y+h5oZkmWhFhfP56T
 hJCeW1mp5gEaPu9P0wq36ADC0KWyD5OAL//ZOXw6PPgeld6JU6W23WwrAEbbZdbw139O
 KT8xboR7xO33QQ/70bBOySb3eaJomt8woCe8lqeZQBt94HY42QEgg5bTU6SWJsDBaExF fw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 35cn9r6edm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Dec 2020 17:19:11 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BEH4oqc051522;
        Mon, 14 Dec 2020 17:19:10 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 35e6ep7mmw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Dec 2020 17:19:10 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BEHJ35c007597;
        Mon, 14 Dec 2020 17:19:05 GMT
Received: from localhost (/10.159.237.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 14 Dec 2020 09:19:03 -0800
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2] proc: Allow pid_revalidate() during LOOKUP_RCU
In-Reply-To: <87tusplqwf.fsf@x220.int.ebiederm.org>
References: <20201204000212.773032-1-stephen.s.brennan@oracle.com>
 <87tusplqwf.fsf@x220.int.ebiederm.org>
Date:   Mon, 14 Dec 2020 09:19:02 -0800
Message-ID: <87sg88tiex.fsf@stepbren-lnx.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9834 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=754 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012140117
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9834 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=768
 impostorscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012140117
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> Stephen Brennan <stephen.s.brennan@oracle.com> writes:
>
>> The pid_revalidate() function requires dropping from RCU into REF lookup
>> mode. When many threads are resolving paths within /proc in parallel,
>> this can result in heavy spinlock contention as each thread tries to
>> grab a reference to the /proc dentry lock (and drop it shortly
>> thereafter).
>
> I am feeling dense at the moment.  Which lock specifically are you
> referring to?  The only locks I can thinking of are sleeping locks,
> not spinlocks.

The lock in question is the d_lockref field (aliased as d_lock) of
struct dentry. It is contended in this code path while processing the
"/proc" dentry, switching from RCU to REF mode.

    walk_component()
      lookup_fast()
        d_revalidate()
          pid_revalidate() // returns -ECHILD
        unlazy_child()
          lockref_get_not_dead(&nd->path.dentry->d_lockref)

>
>> diff --git a/fs/proc/base.c b/fs/proc/base.c
>> index ebea9501afb8..833d55a59e20 100644
>> --- a/fs/proc/base.c
>> +++ b/fs/proc/base.c
>> @@ -1830,19 +1846,22 @@ static int pid_revalidate(struct dentry *dentry, unsigned int flags)
>>  {
>>  	struct inode *inode;
>>  	struct task_struct *task;
>> +	int rv = 0;
>>  
>> -	if (flags & LOOKUP_RCU)
>> -		return -ECHILD;
>> -
>> -	inode = d_inode(dentry);
>> -	task = get_proc_task(inode);
>> -
>> -	if (task) {
>> -		pid_update_inode(task, inode);
>> -		put_task_struct(task);
>> -		return 1;
>> +	if (flags & LOOKUP_RCU) {
>
> Why do we need to test flags here at all?
> Why can't the code simply take an rcu_read_lock unconditionally and just
> pass flags into do_pid_update_inode?
>

I don't have any good reason. If it is safe to update the inode without
holding a reference to the task struct (or holding any other lock) then
I can consolidate the whole conditional.

>
>> +		inode = d_inode_rcu(dentry);
>> +		task = pid_task(proc_pid(inode), PIDTYPE_PID);
>> +		if (task)
>> +			rv = do_pid_update_inode(task, inode, flags);
>> +	} else {
>> +		inode = d_inode(dentry);
>> +		task = get_proc_task(inode);
>> +		if (task) {
>> +			rv = do_pid_update_inode(task, inode, flags);
>> +			put_task_struct(task);
>> +		}
>
>>  	}
>> -	return 0;
>> +	return rv;
>>  }
>>  
>>  static inline bool proc_inode_is_dead(struct inode *inode)
>
> Eric
