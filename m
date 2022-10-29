Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1B3612174
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Oct 2022 10:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiJ2Idd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Oct 2022 04:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiJ2Idc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Oct 2022 04:33:32 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F29550B1;
        Sat, 29 Oct 2022 01:33:31 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Mzsxr43K8z15LxB;
        Sat, 29 Oct 2022 16:28:32 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 29 Oct 2022 16:33:29 +0800
Subject: Re: [PATCH -next v2 3/6] landlock: add chmod and chown support
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>
CC:     <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
        <shuah@kernel.org>, <corbet@lwn.net>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>
References: <20220827111215.131442-1-xiujianfeng@huawei.com>
 <20220827111215.131442-4-xiujianfeng@huawei.com> <Ywpw66EYRDTQIyTx@nuc>
 <de8834b6-0ff2-1a81-f2d3-af33103e9942@huawei.com>
 <de4620d2-3268-b3cc-71dd-acbbd204435e@digikod.net>
 <2f286496-f4f8-76f7-2fb6-cc3dd5ffdeaa@huawei.com>
 <4b69a4ac-28ab-16aa-14b1-04a6f64d5490@digikod.net>
From:   xiujianfeng <xiujianfeng@huawei.com>
Message-ID: <9caccd0a-319e-bbc9-084a-65c62d0b1145@huawei.com>
Date:   Sat, 29 Oct 2022 16:33:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <4b69a4ac-28ab-16aa-14b1-04a6f64d5490@digikod.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.112]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

在 2022/9/2 1:34, Mickaël Salaün 写道:
> CCing linux-fsdevel@vger.kernel.org
> 
> 
> On 01/09/2022 15:06, xiujianfeng wrote:
>> Hi,
>>
>> 在 2022/8/30 0:01, Mickaël Salaün 写道:
>>>
>>> On 29/08/2022 03:17, xiujianfeng wrote:
>>>>
>>>> Hi,
>>>>
>>>> 在 2022/8/28 3:30, Günther Noack 写道:
>>>>> Hello!
>>>>>
>>>>> the mapping between Landlock rights to LSM hooks is now as follows in
>>>>> your patch set:
>>>>>
>>>>> * LANDLOCK_ACCESS_FS_CHMOD controls hook_path_chmod
>>>>> * LANDLOCK_ACCESS_FS_CHGRP controls hook_path_chown
>>>>>      (this hook can restrict both the chown(2) and chgrp(2) syscalls)
>>>>>
>>>>> Is this the desired mapping?
>>>>>
>>>>> The previous discussion I found on the topic was in
>>>>>
>>>>> [1]
>>>>> https://lore.kernel.org/all/5873455f-fff9-618c-25b1-8b6a4ec94368@digikod.net/ 
>>>>>
>>>>>
>>>>> [2]
>>>>> https://lore.kernel.org/all/b1d69dfa-6d93-2034-7854-e2bc4017d20e@schaufler-ca.com/ 
>>>>>
>>>>>
>>>>> [3]
>>>>> https://lore.kernel.org/all/c369c45d-5aa8-3e39-c7d6-b08b165495fd@digikod.net/ 
>>>>>
>>>>>
>>>>>
>>>>> In my understanding the main arguments were the ones in [2] and [3].
>>>>>
>>>>> There were no further responses to [3], so I was under the impression
>>>>> that we were gravitating towards an approach where the
>>>>> file-metadata-modification operations were grouped more coarsely?
>>>>>
>>>>> For example with the approach suggested in [3], which would be to
>>>>> group the operations coarsely into (a) one Landlock right for
>>>>> modifying file metadata that is used in security contexts, and (b) one
>>>>> Landlock right for modifying metadata that was used in non-security
>>>>> contexts. That would mean that there would be:
>>>>>
>>>>> (a) LANDLOCK_ACCESS_FS_MODIFY_SECURITY_ATTRIBUTES to control the
>>>>> following operations:
>>>>>      * chmod(2)-variants through hook_path_chmod,
>>>>>      * chown(2)-variants and chgrp(2)-variants through 
>>>>> hook_path_chown,
>>>>>      * setxattr(2)-variants and removexattr(2)-variants for extended
>>>>>        attributes that are not "user extended attributes" as 
>>>>> described in
>>>>>        xattr(7) through hook_inode_setxattr and hook_inode_removexattr
>>>>>
>>>>> (b) LANDLOCK_ACCESS_FS_MODIFY_NON_SECURITY_ATTRIBUTES to control the
>>>>> following operations:
>>>>>      * utimes(2) and other operations for setting other non-security
>>>>>        sensitive attributes, probably through hook_inode_setattr(?)
>>>>>      * xattr modifications like above, but for the "user extended
>>>>>        attributes", though hook_inode_setxattr and 
>>>>> hook_inode_removexattr
>>>>>
>>>>> In my mind, this would be a sensible grouping, and it would also help
>>>>> to decouple the userspace-exposed API from the underlying
>>>>> implementation, as Casey suggested to do in [2].
>>>>>
>>>>> Specifically for this patch set, if you want to use this grouping, you
>>>>> would only need to add one new Landlock right
>>>>> (LANDLOCK_ACCESS_FS_MODIFY_SECURITY_ATTRIBUTES) as described above
>>>>> under (a) (and maybe we can find a shorter name for it... :))?
>>>>>
>>>>> Did I miss any operations here that would be necessary to restrict?
>>>>>
>>>>> Would that make sense to you? Xiu, what is your opinion on how this
>>>>> should be grouped? Do you have use cases in mind where a more
>>>>> fine-grained grouping would be required?
>>>>
>>>> I apologize I may missed that discussion when I prepared v2:(
>>>>
>>>> Yes, agreed, this grouping is more sensible and resonnable. so in this
>>>> patchset only one right will be added, and I suppose the first commit
>>>> which expand access_mask_t to u32 can be droped.
>>>>
>>>>>
>>>>> —Günther
>>>>>
>>>>> P.S.: Regarding utimes: The hook_inode_setattr hook *also* gets called
>>>>> on a variety on attribute changes including file ownership, file size
>>>>> and file mode, so it might potentially interact with a bunch of other
>>>>> existing Landlock rights. Maybe that is not the right approach. In any
>>>>> case, it seems like it might require more thinking and it might be
>>>>> sensible to do that in a separate patch set IMHO.
>>>>
>>>> Thanks for you reminder, that seems it's more complicated to support
>>>> utimes, so I think we'd better not support it in this patchset.
>>>
>>> The issue with this approach is that it makes it impossible to properly
>>> group such access rights. Indeed, to avoid inconsistencies and much more
>>> complexity, we cannot extend a Landlock access right once it is defined.
>>>
>>> We also need to consider that file ownership and permissions have a
>>> default (e.g. umask), which is also a way to set them. How to
>>> consistently manage that? What if the application wants to protect its
>>> files with chmod 0400?
>>
>> what do you mean by this? do you mean that we should have a set of
>> default permissions for files created by applications within the
>> sandbox, so that it can update metadata of its own file.
> 
> I mean that we need a consistent access control system, and for this we 
> need to consider all the ways an extended attribute can be set.
> 
> We can either extend the meaning of current access rights (controlled 
> with a ruleset flag for compatibility reasons), or create new access 
> rights. I think it would be better to add new dedicated rights to make 
> it more explicit and flexible.
> 
> I'm not sure about the right approach to properly control file 
> permission. We need to think about it. Do you have some ideas?
> 
> BTW, utimes can be controlled with the inode_setattr() LSM hook. Being 
> able to control arbitrary file time modification could be part of the 
> FS_WRITE_SAFE_METADATA, but modification and access time should always 
> be updated according to the file operation.
> 
> 
>>
>>>
>>> About the naming, I think we can start with:
>>> - LANDLOCK_ACCESS_FS_READ_METADATA (read any file/dir metadata);
>>> - LANDLOCK_ACCESS_FS_WRITE_SAFE_METADATA: change file times, user xattr;
>>
>> do you mean we should have permission controls on metadata level or
>> operation level? e.g. should we allow update on user xattr but deny
>> update on security xattr? or should we disallow update on any xattr?
>>
>>> - LANDLOCK_ACCESS_FS_WRITE_UNSAFE_METADATA: interpreted by the kernel
>>> (could change non-Landlock DAC or MAC, which could be considered as a
>>> policy bypass; or other various xattr that might be interpreted by
>>> filesystems), this should be denied most of the time.
>>
>> do you mean FS_WRITE_UNSAFE_METADATA is security-related? and
>> FS_WRITE_SAFE_METADATA is non-security-related?
> 
> Yes, FS_WRITE_UNSAFE_METADATA would be for security related 
> xattr/chmod/chown, and FS_WRITE_SAFE_METADATA for non-security xattr. 
> Both are mutually exclusive. This would involve the inode_setattr and 
> inode_setxattr LSM hooks. Looking at the calling sites, it seems 
> possible to replace all inode arguments with paths.
> .

Sorry for the late reply, I have problems with this work, for example,
before:
security_inode_setattr(struct user_namespace *mnt_userns,
                                          struct dentry *dentry,
                                          struct iattr *attr)
after:
security_inode_setattr(struct user_namespace *mnt_userns,
                                          struct path *path,
                                          struct iattr *attr)
then I change the second argument in notify_change() from struct *dentry 
to struct path *, that makes this kind of changes in fs/overlayfs/ 
spread to lots of places because overlayfs basicly uses dentry instead 
of path, the worst case may be here:

ovl_special_inode_operations.set_acl hook calls:
-->
ovl_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry, 
struct posix_acl *acl, int type)
-->
ovl_setattr(struct user_namespace *mnt_userns, struct dentry 
*dentry,struct iattr *attr)
-->
ovl_do_notify_change(struct ovl_fs *ofs, struct dentry *upperdentry, 
struct iattr *attr)

from the top of this callchain, I can not find a path to replace dentry, 
did I miss something? or do you have better idea?
