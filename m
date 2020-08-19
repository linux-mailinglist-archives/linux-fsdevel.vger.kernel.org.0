Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F8D24A74E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Aug 2020 21:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgHST6T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Aug 2020 15:58:19 -0400
Received: from linux.microsoft.com ([13.77.154.182]:39150 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbgHST6S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Aug 2020 15:58:18 -0400
Received: from localhost.localdomain (c-73-172-233-15.hsd1.md.comcast.net [73.172.233.15])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9B8B420B4908;
        Wed, 19 Aug 2020 12:58:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9B8B420B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1597867098;
        bh=d2hYGlkdC8eRyfscyaduIWPc+nYyjgVi08Toa2/GEu8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ny8hW2/9yr0/iNlqZgmyqllUzwWs6QFzAI9BQMzHJULptl5+eKMXYt484lCzgf+zj
         agrqsbWGLCd8Ta9TwkenWu0Ivcxrl3tBCeBOEMa7snWcZQe588FArd8+sQDxqEcWQA
         ZuD5yfy3cD0fma0E37kc1Q326/17/acAJqVASKso=
Subject: Re: [PATCH v2 4/4] selinux: Create new booleans and class dirs out of
 tree
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20200812191525.1120850-1-dburgener@linux.microsoft.com>
 <20200812191525.1120850-5-dburgener@linux.microsoft.com>
 <8540e665-1722-35f9-ec39-f4038e1f90ca@gmail.com>
 <bd7031f8-e4c5-a013-3a00-c89d603be152@linux.microsoft.com>
 <CAEjxPJ7pT5NSkVc8gnVoGj=JT-PkrQcGDmPARBU6cs7W+u05TA@mail.gmail.com>
From:   Daniel Burgener <dburgener@linux.microsoft.com>
Message-ID: <ab8a3403-75c1-a952-75be-dfe023f23bd2@linux.microsoft.com>
Date:   Wed, 19 Aug 2020 15:58:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ7pT5NSkVc8gnVoGj=JT-PkrQcGDmPARBU6cs7W+u05TA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/18/20 9:55 AM, Stephen Smalley wrote:
> On Tue, Aug 18, 2020 at 9:49 AM Daniel Burgener
> <dburgener@linux.microsoft.com> wrote:
>> On 8/13/20 12:25 PM, Stephen Smalley wrote:
>>> On 8/12/20 3:15 PM, Daniel Burgener wrote:
>>>
>>>> In order to avoid concurrency issues around selinuxfs resource
>>>> availability
>>>> during policy load, we first create new directories out of tree for
>>>> reloaded resources, then swap them in, and finally delete the old
>>>> versions.
>>>>
>>>> This fix focuses on concurrency in each of the three subtrees
>>>> swapped, and
>>>> not concurrency across the three trees.  This means that it is still
>>>> possible
>>>> that subsequent reads to eg the booleans directory and the class
>>>> directory
>>>> during a policy load could see the old state for one and the new for
>>>> the other.
>>>> The problem of ensuring that policy loads are fully atomic from the
>>>> perspective
>>>> of userspace is larger than what is dealt with here.  This commit
>>>> focuses on
>>>> ensuring that the directories contents always match either the new or
>>>> the old
>>>> policy state from the perspective of userspace.
>>>>
>>>> In the previous implementation, on policy load /sys/fs/selinux is
>>>> updated
>>>> by deleting the previous contents of
>>>> /sys/fs/selinux/{class,booleans} and then recreating them.  This means
>>>> that there is a period of time when the contents of these directories
>>>> do not
>>>> exist which can cause race conditions as userspace relies on them for
>>>> information about the policy.  In addition, it means that error
>>>> recovery in
>>>> the event of failure is challenging.
>>>>
>>>> In order to demonstrate the race condition that this series fixes, you
>>>> can use the following commands:
>>>>
>>>> while true; do cat /sys/fs/selinux/class/service/perms/status
>>>>> /dev/null; done &
>>>> while true; do load_policy; done;
>>>>
>>>> In the existing code, this will display errors fairly often as the class
>>>> lookup fails.  (In normal operation from systemd, this would result in a
>>>> permission check which would be allowed or denied based on policy
>>>> settings
>>>> around unknown object classes.) After applying this patch series you
>>>> should expect to no longer see such error messages.
>>>>
>>>> Signed-off-by: Daniel Burgener <dburgener@linux.microsoft.com>
>>>> ---
>>>>    security/selinux/selinuxfs.c | 145 +++++++++++++++++++++++++++++------
>>>>    1 file changed, 120 insertions(+), 25 deletions(-)
>>>>
>>>> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
>>>> index f09afdb90ddd..d3a19170210a 100644
>>>> --- a/security/selinux/selinuxfs.c
>>>> +++ b/security/selinux/selinuxfs.c
>>>> +    tmp_policycap_dir = sel_make_dir(tmp_parent, POLICYCAP_DIR_NAME,
>>>> &fsi->last_ino);
>>>> +    if (IS_ERR(tmp_policycap_dir)) {
>>>> +        ret = PTR_ERR(tmp_policycap_dir);
>>>> +        goto out;
>>>> +    }
>>> No need to re-create this one.
>>>
>>>> -    return 0;
>>>> +    // booleans
>>>> +    old_dentry = fsi->bool_dir;
>>>> +    lock_rename(tmp_bool_dir, old_dentry);
>>>> +    ret = vfs_rename(tmp_parent->d_inode, tmp_bool_dir,
>>>> fsi->sb->s_root->d_inode,
>>>> +             fsi->bool_dir, NULL, RENAME_EXCHANGE);
>>> One issue with using vfs_rename() is that it will trigger all of the
>>> permission checks associated with renaming, and previously this was
>>> never required for selinuxfs and therefore might not be allowed in
>>> some policies even to a process allowed to reload policy.  So if you
>>> need to do this, you may want to override creds around this call to
>>> use the init cred (which will still require allowing it to the kernel
>>> domain but not necessarily to the process that is performing the
>>> policy load).  The other issue is that you then have to implement a
>>> rename inode operation and thus technically it is possible for
>>> userspace to also attempt renames on selinuxfs to the extent allowed
>>> by policy.  I see that debugfs has a debugfs_rename() that internally
>>> uses simple_rename() but I guess that doesn't cover the
>>> RENAME_EXCHANGE case.
>> Those are good points.  Do you see any problems with just calling
>> d_exchange() directly?  It seems to work fine in very limited initial
>> testing on my end. That should hopefully address all the problems you
>> mentioned here.
> I was hoping the vfs folks would chime in but you may have to pose a
> more direct question to viro and linux-fsdevel to get a response.
> Possibly there should be a lower-level vfs helper that could be used
> internally by vfs_rename() and by things like debugfs_rename and a
> potential selinuxfs_rename.

I'll send a v3 with this switched to d_exchange() and the other issues 
you mentioned fixed first.  That way they can at least look at the 
latest version of things to help focus any conversation and save people 
time.

-Daniel

