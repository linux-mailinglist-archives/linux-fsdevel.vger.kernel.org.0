Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092A862F4D5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Nov 2022 13:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241739AbiKRMdZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Nov 2022 07:33:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241362AbiKRMdA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Nov 2022 07:33:00 -0500
Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch [IPv6:2001:1600:3:17::bc0f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41987723C;
        Fri, 18 Nov 2022 04:32:46 -0800 (PST)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4NDGQN2vG4zMqM8h;
        Fri, 18 Nov 2022 13:32:44 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4NDGQL2k6mzMpnPk;
        Fri, 18 Nov 2022 13:32:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1668774764;
        bh=q+l2A0Y+/3vkoZVMJeR/sMllFYiAblnviFFjBspLJnM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=sHwc7IJwL+shudEiBsEl5h/xSYd6az9IZ0+gYlJV267n8jGHz/xxUDq/hfwiHx/Ex
         YYGMFQww+zJKois1PBO/4VKqvbxHziBJa1oZVhX3gd9bCVmQkY2VV6eG3tFbkypydf
         cHr2uBWEGsqcVolmn61jTsEBKaAWedgfGP5hc1GM=
Message-ID: <df99abcc-e7ec-ad34-27fa-25abee28a300@digikod.net>
Date:   Fri, 18 Nov 2022 13:32:41 +0100
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH -next v2 3/6] landlock: add chmod and chown support
Content-Language: en-US
To:     xiujianfeng <xiujianfeng@huawei.com>,
        =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        Christian Brauner <brauner@kernel.org>
Cc:     paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        shuah@kernel.org, corbet@lwn.net,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
References: <20220827111215.131442-1-xiujianfeng@huawei.com>
 <20220827111215.131442-4-xiujianfeng@huawei.com> <Ywpw66EYRDTQIyTx@nuc>
 <de8834b6-0ff2-1a81-f2d3-af33103e9942@huawei.com>
 <de4620d2-3268-b3cc-71dd-acbbd204435e@digikod.net>
 <2f286496-f4f8-76f7-2fb6-cc3dd5ffdeaa@huawei.com>
 <4b69a4ac-28ab-16aa-14b1-04a6f64d5490@digikod.net>
 <9caccd0a-319e-bbc9-084a-65c62d0b1145@huawei.com>
 <abc960a1-e66e-792e-6869-cfd201c29dbe@digikod.net>
 <1373bbe5-16b1-bf0e-5f92-14c31cb94897@huawei.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <1373bbe5-16b1-bf0e-5f92-14c31cb94897@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 18/11/2022 10:03, xiujianfeng wrote:
> 
> 
> 在 2022/11/14 22:12, Mickaël Salaün 写道:
>>
>> On 29/10/2022 10:33, xiujianfeng wrote:
>>> Hi,
>>>
>>> 在 2022/9/2 1:34, Mickaël Salaün 写道:
>>>> CCing linux-fsdevel@vger.kernel.org
>>>>
>>>>
>>>> On 01/09/2022 15:06, xiujianfeng wrote:
>>>>> Hi,
>>>>>
>>>>> 在 2022/8/30 0:01, Mickaël Salaün 写道:
>>>>>>
>>>>>> On 29/08/2022 03:17, xiujianfeng wrote:
>>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> 在 2022/8/28 3:30, Günther Noack 写道:
>>>>>>>> Hello!
>>>>>>>>
>>>>>>>> the mapping between Landlock rights to LSM hooks is now as
>>>>>>>> follows in
>>>>>>>> your patch set:
>>>>>>>>
>>>>>>>> * LANDLOCK_ACCESS_FS_CHMOD controls hook_path_chmod
>>>>>>>> * LANDLOCK_ACCESS_FS_CHGRP controls hook_path_chown
>>>>>>>>        (this hook can restrict both the chown(2) and chgrp(2)
>>>>>>>> syscalls)
>>>>>>>>
>>>>>>>> Is this the desired mapping?
>>>>>>>>
>>>>>>>> The previous discussion I found on the topic was in
>>>>>>>>
>>>>>>>> [1]
>>>>>>>> https://lore.kernel.org/all/5873455f-fff9-618c-25b1-8b6a4ec94368@digikod.net/
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> [2]
>>>>>>>> https://lore.kernel.org/all/b1d69dfa-6d93-2034-7854-e2bc4017d20e@schaufler-ca.com/
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> [3]
>>>>>>>> https://lore.kernel.org/all/c369c45d-5aa8-3e39-c7d6-b08b165495fd@digikod.net/
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> In my understanding the main arguments were the ones in [2] and [3].
>>>>>>>>
>>>>>>>> There were no further responses to [3], so I was under the
>>>>>>>> impression
>>>>>>>> that we were gravitating towards an approach where the
>>>>>>>> file-metadata-modification operations were grouped more coarsely?
>>>>>>>>
>>>>>>>> For example with the approach suggested in [3], which would be to
>>>>>>>> group the operations coarsely into (a) one Landlock right for
>>>>>>>> modifying file metadata that is used in security contexts, and
>>>>>>>> (b) one
>>>>>>>> Landlock right for modifying metadata that was used in non-security
>>>>>>>> contexts. That would mean that there would be:
>>>>>>>>
>>>>>>>> (a) LANDLOCK_ACCESS_FS_MODIFY_SECURITY_ATTRIBUTES to control the
>>>>>>>> following operations:
>>>>>>>>        * chmod(2)-variants through hook_path_chmod,
>>>>>>>>        * chown(2)-variants and chgrp(2)-variants through
>>>>>>>> hook_path_chown,
>>>>>>>>        * setxattr(2)-variants and removexattr(2)-variants for
>>>>>>>> extended
>>>>>>>>          attributes that are not "user extended attributes" as
>>>>>>>> described in
>>>>>>>>          xattr(7) through hook_inode_setxattr and
>>>>>>>> hook_inode_removexattr
>>>>>>>>
>>>>>>>> (b) LANDLOCK_ACCESS_FS_MODIFY_NON_SECURITY_ATTRIBUTES to control the
>>>>>>>> following operations:
>>>>>>>>        * utimes(2) and other operations for setting other
>>>>>>>> non-security
>>>>>>>>          sensitive attributes, probably through hook_inode_setattr(?)
>>>>>>>>        * xattr modifications like above, but for the "user extended
>>>>>>>>          attributes", though hook_inode_setxattr and
>>>>>>>> hook_inode_removexattr
>>>>>>>>
>>>>>>>> In my mind, this would be a sensible grouping, and it would also
>>>>>>>> help
>>>>>>>> to decouple the userspace-exposed API from the underlying
>>>>>>>> implementation, as Casey suggested to do in [2].
>>>>>>>>
>>>>>>>> Specifically for this patch set, if you want to use this
>>>>>>>> grouping, you
>>>>>>>> would only need to add one new Landlock right
>>>>>>>> (LANDLOCK_ACCESS_FS_MODIFY_SECURITY_ATTRIBUTES) as described above
>>>>>>>> under (a) (and maybe we can find a shorter name for it... :))?
>>>>>>>>
>>>>>>>> Did I miss any operations here that would be necessary to restrict?
>>>>>>>>
>>>>>>>> Would that make sense to you? Xiu, what is your opinion on how this
>>>>>>>> should be grouped? Do you have use cases in mind where a more
>>>>>>>> fine-grained grouping would be required?
>>>>>>>
>>>>>>> I apologize I may missed that discussion when I prepared v2:(
>>>>>>>
>>>>>>> Yes, agreed, this grouping is more sensible and resonnable. so in
>>>>>>> this
>>>>>>> patchset only one right will be added, and I suppose the first commit
>>>>>>> which expand access_mask_t to u32 can be droped.
>>>>>>>
>>>>>>>>
>>>>>>>> —Günther
>>>>>>>>
>>>>>>>> P.S.: Regarding utimes: The hook_inode_setattr hook *also* gets
>>>>>>>> called
>>>>>>>> on a variety on attribute changes including file ownership, file
>>>>>>>> size
>>>>>>>> and file mode, so it might potentially interact with a bunch of
>>>>>>>> other
>>>>>>>> existing Landlock rights. Maybe that is not the right approach.
>>>>>>>> In any
>>>>>>>> case, it seems like it might require more thinking and it might be
>>>>>>>> sensible to do that in a separate patch set IMHO.
>>>>>>>
>>>>>>> Thanks for you reminder, that seems it's more complicated to support
>>>>>>> utimes, so I think we'd better not support it in this patchset.
>>>>>>
>>>>>> The issue with this approach is that it makes it impossible to
>>>>>> properly
>>>>>> group such access rights. Indeed, to avoid inconsistencies and much
>>>>>> more
>>>>>> complexity, we cannot extend a Landlock access right once it is
>>>>>> defined.
>>>>>>
>>>>>> We also need to consider that file ownership and permissions have a
>>>>>> default (e.g. umask), which is also a way to set them. How to
>>>>>> consistently manage that? What if the application wants to protect its
>>>>>> files with chmod 0400?
>>>>>
>>>>> what do you mean by this? do you mean that we should have a set of
>>>>> default permissions for files created by applications within the
>>>>> sandbox, so that it can update metadata of its own file.
>>>>
>>>> I mean that we need a consistent access control system, and for this we
>>>> need to consider all the ways an extended attribute can be set.
>>>>
>>>> We can either extend the meaning of current access rights (controlled
>>>> with a ruleset flag for compatibility reasons), or create new access
>>>> rights. I think it would be better to add new dedicated rights to make
>>>> it more explicit and flexible.
>>>>
>>>> I'm not sure about the right approach to properly control file
>>>> permission. We need to think about it. Do you have some ideas?
>>>>
>>>> BTW, utimes can be controlled with the inode_setattr() LSM hook. Being
>>>> able to control arbitrary file time modification could be part of the
>>>> FS_WRITE_SAFE_METADATA, but modification and access time should always
>>>> be updated according to the file operation.
>>>>
>>>>
>>>>>
>>>>>>
>>>>>> About the naming, I think we can start with:
>>>>>> - LANDLOCK_ACCESS_FS_READ_METADATA (read any file/dir metadata);
>>>>>> - LANDLOCK_ACCESS_FS_WRITE_SAFE_METADATA: change file times, user
>>>>>> xattr;
>>>>>
>>>>> do you mean we should have permission controls on metadata level or
>>>>> operation level? e.g. should we allow update on user xattr but deny
>>>>> update on security xattr? or should we disallow update on any xattr?
>>>>>
>>>>>> - LANDLOCK_ACCESS_FS_WRITE_UNSAFE_METADATA: interpreted by the kernel
>>>>>> (could change non-Landlock DAC or MAC, which could be considered as a
>>>>>> policy bypass; or other various xattr that might be interpreted by
>>>>>> filesystems), this should be denied most of the time.
>>>>>
>>>>> do you mean FS_WRITE_UNSAFE_METADATA is security-related? and
>>>>> FS_WRITE_SAFE_METADATA is non-security-related?
>>>>
>>>> Yes, FS_WRITE_UNSAFE_METADATA would be for security related
>>>> xattr/chmod/chown, and FS_WRITE_SAFE_METADATA for non-security xattr.
>>>> Both are mutually exclusive. This would involve the inode_setattr and
>>>> inode_setxattr LSM hooks. Looking at the calling sites, it seems
>>>> possible to replace all inode arguments with paths.
>>
>> I though about differentiating user xattr, atime/mtime, DAC
>> (chown/chmod, posix ACLs), and other xattr, but it would be too complex
>> to get a consistent approach because of indirect consequences (e.g.
>> controlling umask, setegid, settimeofday…). Let's make it simple for now.
>>
>> Here is an update on my previous proposal:
>>
>> LANDLOCK_ACCESS_FS_READ_METADATA to read any file/dir metadata (i.e.
>> inode attr and xattr). In practice, for most use cases, this access
>> right should be granted whenever LANDLOCK_ACCESS_READ_DIR is allowed.
>>
>> LANDLOCK_ACCESS_FS_WRITE_METADATA to *explicitly* write any inode attr
>> or xattr (i.e. chmod, chown, utime, and all xattr). It should be noted
>> that file modification time and access time should always be updated
>> according to the file operation (e.g. write, truncate) even when this
>> access is not explicitly allowed (according to vfs_utimes(),
>> ATTR_TIMES_SET and ATTR_TOUCH should enable to differentiate from
>> implicit time changes).
>>
> Thanks, I analyzed the relevant functions and the use of lsm hooks.
> so I think what to do will be as follows:
> 
> LANDLOCK_ACCESS_FS_WRITE_METADATA controls the following hooks:
> 1.security_path_chmod
> 2.security_path_chown

These two chmod/chown hooks would be redundant with 
security_inode_setattr(). We then don't need to implement them.


> 3.security_inode_setattr
> 4.security_inode_setxattr
> 5.security_inode_removexattr > 6.security_inode_set_acl

Good catch. This new security_inode_set_acl hook is a good example of 
API refactoring. BTW, the related Cc list should be included in your 
next patch series.

> 
> LANDLOCK_ACCESS_FS_READ_METADATA controls the following hooks:
> 1.security_inode_getattr
> 2.security_inode_get_acl
> 3.security_inode_getxattr

Correct

> 
> and the following 7 hooks are using struct dentry * as parameter, should
> be changed to struct path *, and also their callers.
> 
> security_inode_setattr
> security_inode_setxattr
> security_inode_removexattr
> security_inode_set_acl
> security_inode_getattr
> security_inode_get_acl
> security_inode_getxattr
> 
> Looks like it's a big change.

Your proposed approach looks good, and this will indeed touch a lot of 
files.

Because it interacts a lot with the filesystem subsystem, I propose to 
first write a set of patches that refactor the security_inode_*attr and 
security_inode_*_acl hooks to use struct file (or struct path when it 
makes sense) instead of struct dentry/inode (and to remove struct 
user_namespace as argument because it can be inferred thanks to 
file_mnt_user_ns). As for [1], using struct file only makes sense for a 
specific set of calls, and struct path should be used otherwise (e.g. 
syscalls dealing with file descriptors vs. with file paths).

You need to base this work on Christian's branch to be up-to-date with 
ongoing FS changes. I suggest to create one patch per function API 
change e.g., notify_change (merge the mnt_userns and dentry in a file 
argument), struct inode_operations.setattr (use a file argument instead 
of dentry)…

Once this refactoring will be in -next, the landlock_file_security 
changes [1] will already be merged in master, and you will then be able 
to work on the Landlock specific parts with the new hooks.

[1] https://git.kernel.org/mic/c/b9f5ce27c8f8


> 
>>
>>>
>>> Sorry for the late reply, I have problems with this work, for example,
>>> before:
>>> security_inode_setattr(struct user_namespace *mnt_userns,
>>>                                             struct dentry *dentry,
>>>                                             struct iattr *attr)
>>> after:
>>> security_inode_setattr(struct user_namespace *mnt_userns,
>>>                                             struct path *path,
>>>                                             struct iattr *attr)
>>> then I change the second argument in notify_change() from struct *dentry
>>> to struct path *, that makes this kind of changes in fs/overlayfs/
>>> spread to lots of places because overlayfs basicly uses dentry instead
>>> of path, the worst case may be here:
>>>
>>> ovl_special_inode_operations.set_acl hook calls:
>>> -->
>>> ovl_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
>>> struct posix_acl *acl, int type)
>>> -->
>>> ovl_setattr(struct user_namespace *mnt_userns, struct dentry
>>> *dentry,struct iattr *attr)
>>> -->
>>> ovl_do_notify_change(struct ovl_fs *ofs, struct dentry *upperdentry,
>>> struct iattr *attr)
>>>
>>> from the top of this callchain, I can not find a path to replace dentry,
>>> did I miss something? or do you have better idea?
>>
>> I think this can be solved thanks to the ovl_path_real() helper.
>> .
