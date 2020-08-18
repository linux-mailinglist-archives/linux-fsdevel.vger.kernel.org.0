Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478F3248661
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 15:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgHRNtH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Aug 2020 09:49:07 -0400
Received: from linux.microsoft.com ([13.77.154.182]:45002 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgHRNtF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Aug 2020 09:49:05 -0400
Received: from localhost.localdomain (c-73-172-233-15.hsd1.md.comcast.net [73.172.233.15])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6490A20B4908;
        Tue, 18 Aug 2020 06:49:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6490A20B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1597758544;
        bh=T2yh8CragD5gAZKWGzebieZXoBoIin/2BZRLU0ijlIo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LndWXVZIYo5XrYYjcrule3QfyoWXcUitgMffPd72YDLVS++P1KZSoLC3qOTEg78v0
         x+JFY2DflE1w8R1uEaxRh2glMOmClPVmv5J787yQuCf2Deek0pJnNpcFbipSeI1Fto
         6Ql2Oiv0rE+5PXDTEaBtkP1shPJfbEk80+gJfrP4=
Subject: Re: [PATCH v2 4/4] selinux: Create new booleans and class dirs out of
 tree
To:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org
Cc:     omosnace@redhat.com, paul@paul-moore.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
References: <20200812191525.1120850-1-dburgener@linux.microsoft.com>
 <20200812191525.1120850-5-dburgener@linux.microsoft.com>
 <8540e665-1722-35f9-ec39-f4038e1f90ca@gmail.com>
From:   Daniel Burgener <dburgener@linux.microsoft.com>
Message-ID: <bd7031f8-e4c5-a013-3a00-c89d603be152@linux.microsoft.com>
Date:   Tue, 18 Aug 2020 09:49:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <8540e665-1722-35f9-ec39-f4038e1f90ca@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/13/20 12:25 PM, Stephen Smalley wrote:
> On 8/12/20 3:15 PM, Daniel Burgener wrote:
>
>> In order to avoid concurrency issues around selinuxfs resource 
>> availability
>> during policy load, we first create new directories out of tree for
>> reloaded resources, then swap them in, and finally delete the old 
>> versions.
>>
>> This fix focuses on concurrency in each of the three subtrees 
>> swapped, and
>> not concurrency across the three trees.  This means that it is still 
>> possible
>> that subsequent reads to eg the booleans directory and the class 
>> directory
>> during a policy load could see the old state for one and the new for 
>> the other.
>> The problem of ensuring that policy loads are fully atomic from the 
>> perspective
>> of userspace is larger than what is dealt with here.  This commit 
>> focuses on
>> ensuring that the directories contents always match either the new or 
>> the old
>> policy state from the perspective of userspace.
>>
>> In the previous implementation, on policy load /sys/fs/selinux is 
>> updated
>> by deleting the previous contents of
>> /sys/fs/selinux/{class,booleans} and then recreating them.  This means
>> that there is a period of time when the contents of these directories 
>> do not
>> exist which can cause race conditions as userspace relies on them for
>> information about the policy.  In addition, it means that error 
>> recovery in
>> the event of failure is challenging.
>>
>> In order to demonstrate the race condition that this series fixes, you
>> can use the following commands:
>>
>> while true; do cat /sys/fs/selinux/class/service/perms/status
>>> /dev/null; done &
>> while true; do load_policy; done;
>>
>> In the existing code, this will display errors fairly often as the class
>> lookup fails.  (In normal operation from systemd, this would result in a
>> permission check which would be allowed or denied based on policy 
>> settings
>> around unknown object classes.) After applying this patch series you
>> should expect to no longer see such error messages.
>>
>> Signed-off-by: Daniel Burgener <dburgener@linux.microsoft.com>
>> ---
>>   security/selinux/selinuxfs.c | 145 +++++++++++++++++++++++++++++------
>>   1 file changed, 120 insertions(+), 25 deletions(-)
>>
>> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
>> index f09afdb90ddd..d3a19170210a 100644
>> --- a/security/selinux/selinuxfs.c
>> +++ b/security/selinux/selinuxfs.c
>> +    tmp_policycap_dir = sel_make_dir(tmp_parent, POLICYCAP_DIR_NAME, 
>> &fsi->last_ino);
>> +    if (IS_ERR(tmp_policycap_dir)) {
>> +        ret = PTR_ERR(tmp_policycap_dir);
>> +        goto out;
>> +    }
>
> No need to re-create this one.
>
>> -    return 0;
>> +    // booleans
>> +    old_dentry = fsi->bool_dir;
>> +    lock_rename(tmp_bool_dir, old_dentry);
>> +    ret = vfs_rename(tmp_parent->d_inode, tmp_bool_dir, 
>> fsi->sb->s_root->d_inode,
>> +             fsi->bool_dir, NULL, RENAME_EXCHANGE);
>
> One issue with using vfs_rename() is that it will trigger all of the 
> permission checks associated with renaming, and previously this was 
> never required for selinuxfs and therefore might not be allowed in 
> some policies even to a process allowed to reload policy.  So if you 
> need to do this, you may want to override creds around this call to 
> use the init cred (which will still require allowing it to the kernel 
> domain but not necessarily to the process that is performing the 
> policy load).  The other issue is that you then have to implement a 
> rename inode operation and thus technically it is possible for 
> userspace to also attempt renames on selinuxfs to the extent allowed 
> by policy.  I see that debugfs has a debugfs_rename() that internally 
> uses simple_rename() but I guess that doesn't cover the 
> RENAME_EXCHANGE case.

Those are good points.  Do you see any problems with just calling 
d_exchange() directly?  It seems to work fine in very limited initial 
testing on my end. That should hopefully address all the problems you 
mentioned here.

-Daniel

>
>> +    // Since the other temporary dirs are children of tmp_parent
>> +    // this will handle all the cleanup in the case of a failure before
>> +    // the swapover
>
> Don't use // style comments please, especially not for multi-line 
> comments.  I think they are only used in selinux for the 
> script-generated license lines.
>
>> +static struct dentry *sel_make_disconnected_dir(struct super_block *sb,
>> +                        unsigned long *ino)
>> +{
>> +    struct inode *inode = sel_make_inode(sb, S_IFDIR | S_IRUGO | 
>> S_IXUGO);
>> +
>> +    if (!inode)
>> +        return ERR_PTR(-ENOMEM);
>> +
>> +    inode->i_op = &sel_dir_inode_operations;
>> +    inode->i_fop = &simple_dir_operations;
>> +    inode->i_ino = ++(*ino);
>> +    /* directory inodes start off with i_nlink == 2 (for "." entry) */
>> +    inc_nlink(inode);
>> +    return d_obtain_alias(inode);
>> +}
>> +
>
> Since you are always incrementing the last_ino counter and never 
> reusing the ones for the removed inodes, you could technically 
> eventually end up with one of these directories have the same inode 
> number as one of the inodes whose inode numbers are generated in 
> specific ranges (i.e. for initial_contexts, booleans, classes, and 
> policy capabilities). Optimally we'd just reuse the inode number for 
> the inode we are replacing?
>
