Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9F3336AE5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 04:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbhCKDpt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 22:45:49 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:3357 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbhCKDpn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 22:45:43 -0500
Received: from dggeme766-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4DwvtM5X5tz5VhN;
        Thu, 11 Mar 2021 11:43:23 +0800 (CST)
Received: from [10.110.53.113] (10.110.53.113) by
 dggeme766-chm.china.huawei.com (10.3.19.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Thu, 11 Mar 2021 11:45:39 +0800
Subject: Re: [PATCH v3] fs/locks: print full locks information
To:     Jeff Layton <jlayton@kernel.org>, <viro@zeniv.linux.org.uk>,
        <bfields@fieldses.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sangyan@huawei.com>, <luchunhua@huawei.com>
References: <20210221201024.GB15975@fieldses.org>
 <685386c2840b76c49b060bf7dcea1fefacf18176.1614322182.git.luolongjun@huawei.com>
 <f8c7a7fe8ee7fc1f1a36f35f38cc653d167b25a1.camel@kernel.org>
From:   Luo Longjun <luolongjun@huawei.com>
Message-ID: <649fa593-d534-a23d-4442-2462778662df@huawei.com>
Date:   Thu, 11 Mar 2021 11:45:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <f8c7a7fe8ee7fc1f1a36f35f38cc653d167b25a1.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.110.53.113]
X-ClientProxiedBy: dggeme711-chm.china.huawei.com (10.1.199.107) To
 dggeme766-chm.china.huawei.com (10.3.19.112)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


在 2021/3/9 21:37, Jeff Layton 写道:
> On Thu, 2021-02-25 at 22:58 -0500, Luo Longjun wrote:
>> Commit fd7732e033e3 ("fs/locks: create a tree of dependent requests.")
>> has put blocked locks into a tree.
>>
>> So, with a for loop, we can't check all locks information.
>>
>> To solve this problem, we should traverse the tree.
>>
>> Signed-off-by: Luo Longjun <luolongjun@huawei.com>
>> ---
>>   fs/locks.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++--------
>>   1 file changed, 56 insertions(+), 9 deletions(-)
>>
>> diff --git a/fs/locks.c b/fs/locks.c
>> index 99ca97e81b7a..ecaecd1f1b58 100644
>> --- a/fs/locks.c
>> +++ b/fs/locks.c
>> @@ -2828,7 +2828,7 @@ struct locks_iterator {
>>   };
>>   
>>
>>
>>
>>   static void lock_get_status(struct seq_file *f, struct file_lock *fl,
>> -			    loff_t id, char *pfx)
>> +			    loff_t id, char *pfx, int repeat)
>>   {
>>   	struct inode *inode = NULL;
>>   	unsigned int fl_pid;
>> @@ -2844,7 +2844,11 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
>>   	if (fl->fl_file != NULL)
>>   		inode = locks_inode(fl->fl_file);
>>   
>>
>>
>>
>> -	seq_printf(f, "%lld:%s ", id, pfx);
>> +	seq_printf(f, "%lld: ", id);
>> +
>> +	if (repeat)
>> +		seq_printf(f, "%*s", repeat - 1 + (int)strlen(pfx), pfx);
> Shouldn't that be "%.*s" ?
>
> Also, isn't this likely to end up walking past the end of "pfx" (or even
> ending up at an address before the buffer)? You have this below:
>
>      lock_get_status(f, fl, *id, "", 0);
>
> ...so the "length" value you're passing into the format there is going
> to be -1. It also seems like if you get a large "level" value in
> locks_show, then you'll end up with a length that is much longer than
> the actual string.

In my understanding, the difference of "%*s" and "%.*s" is that, "%*s" 
specifies the minimal filed width while "%.*s" specifies the precision 
of the string.

Here, I use "%*s", because I want to print locks information in the 
follwing format:

2: FLOCK  ADVISORY  WRITE 110 00:02:493 0 EOF
2: -> FLOCK  ADVISORY  WRITE 111 00:02:493 0 EOF
2:  -> FLOCK  ADVISORY  WRITE 112 00:02:493 0 EOF
2:   -> FLOCK  ADVISORY  WRITE 113 00:02:493 0 EOF
2:    -> FLOCK  ADVISORY  WRITE 114 00:02:493 0 EOF

And also, there is another way to show there information, in the format 
like:

60: FLOCK  ADVISORY  WRITE 23350 08:02:4456514 0 EOF
60: -> FLOCK  ADVISORY  WRITE 23356 08:02:4456514 0 EOF
60: -> FLOCK  ADVISORY  WRITE 24217 08:02:4456514 0 EOF
60: -> FLOCK  ADVISORY  WRITE 24239 08:02:4456514 0 EOF

I think both formats are acceptable, but the first format shows 
competition relationships between these locks.

In the following code:

> lock_get_status(f, fl, *id, "", 0);

repeat is 0, and in the function:

+ if (repeat)
+		seq_printf(f, "%*s", repeat - 1 + (int)strlen(pfx), pfx);

The if branch will not take effect, so it could not be -1.

>> +
>>   	if (IS_POSIX(fl)) {
>>   		if (fl->fl_flags & FL_ACCESS)
>>   			seq_puts(f, "ACCESS");
>> @@ -2906,21 +2910,64 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
>>   	}
>>   }
>>   
>>
>>
>>
>> +static struct file_lock *get_next_blocked_member(struct file_lock *node)
>> +{
>> +	struct file_lock *tmp;
>> +
>> +	/* NULL node or root node */
>> +	if (node == NULL || node->fl_blocker == NULL)
>> +		return NULL;
>> +
>> +	/* Next member in the linked list could be itself */
>> +	tmp = list_next_entry(node, fl_blocked_member);
>> +	if (list_entry_is_head(tmp, &node->fl_blocker->fl_blocked_requests, fl_blocked_member)
>> +		|| tmp == node) {
>> +		return NULL;
>> +	}
>> +
>> +	return tmp;
>> +}
>> +
>>   static int locks_show(struct seq_file *f, void *v)
>>   {
>>   	struct locks_iterator *iter = f->private;
>> -	struct file_lock *fl, *bfl;
>> +	struct file_lock *cur, *tmp;
>>   	struct pid_namespace *proc_pidns = proc_pid_ns(file_inode(f->file)->i_sb);
>> +	int level = 0;
>>   
>>
>>
>>
>> -	fl = hlist_entry(v, struct file_lock, fl_link);
>> +	cur = hlist_entry(v, struct file_lock, fl_link);
>>   
>>
>>
>>
>> -	if (locks_translate_pid(fl, proc_pidns) == 0)
>> +	if (locks_translate_pid(cur, proc_pidns) == 0)
>>   		return 0;
>>   
>>
>>
>>
>> -	lock_get_status(f, fl, iter->li_pos, "");
>> +	/* View this crossed linked list as a binary tree, the first member of fl_blocked_requests
>> +	 * is the left child of current node, the next silibing in fl_blocked_member is the
>> +	 * right child, we can alse get the parent of current node from fl_blocker, so this
>> +	 * question becomes traversal of a binary tree
>> +	 */
>> +	while (cur != NULL) {
>> +		if (level)
>> +			lock_get_status(f, cur, iter->li_pos, "-> ", level);
>> +		else
>> +			lock_get_status(f, cur, iter->li_pos, "", level);
>>   
>>
>>
>>
>> -	list_for_each_entry(bfl, &fl->fl_blocked_requests, fl_blocked_member)
>> -		lock_get_status(f, bfl, iter->li_pos, " ->");
>> +		if (!list_empty(&cur->fl_blocked_requests)) {
>> +			/* Turn left */
>> +			cur = list_first_entry_or_null(&cur->fl_blocked_requests,
>> +				struct file_lock, fl_blocked_member);
>> +			level++;
>> +		} else {
>> +			/* Turn right */
>> +			tmp = get_next_blocked_member(cur);
>> +			/* Fall back to parent node */
>> +			while (tmp == NULL && cur->fl_blocker != NULL) {
>> +				cur = cur->fl_blocker;
>> +				level--;
>> +				tmp = get_next_blocked_member(cur);
>> +			}
>> +			cur = tmp;
>> +		}
>> +	}
>>   
>>
>>
>>
>>   	return 0;
>>   }
>> @@ -2941,7 +2988,7 @@ static void __show_fd_locks(struct seq_file *f,
>>   
>>
>>
>>
>>   		(*id)++;
>>   		seq_puts(f, "lock:\t");
>> -		lock_get_status(f, fl, *id, "");
>> +		lock_get_status(f, fl, *id, "", 0);
>>   	}
>>   }
>>   
>>
>>
>>
