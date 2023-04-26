Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D076EF5E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Apr 2023 15:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241214AbjDZN6m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Apr 2023 09:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241045AbjDZN6l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Apr 2023 09:58:41 -0400
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [IPv6:2001:1600:3:17::bc0b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1DD6596
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Apr 2023 06:58:39 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Q60p31RkfzMqKm8;
        Wed, 26 Apr 2023 15:58:35 +0200 (CEST)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Q60p10S6VzMpnPs;
        Wed, 26 Apr 2023 15:58:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1682517515;
        bh=q7YipNjqfn/z8kn3IJil8RM+axjuqfK/m4XxAXBUf+Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=W3ugWyQJtbD1oliKhX2Yzdcz480Vu9ygX9tFHZIoWk3rLpcrlhe0J0wGmRPKueSKw
         3RvQkqQa2k9xP8f2ipclUpzNvmCuv6awzTMTl9zgXLWrce99hInBlJuFELbhM9S+66
         ZTIfZHvu2s/84MMyRA7LTcejVHUjMyRZebV9J06g=
Message-ID: <99c0648d-deec-c7e2-a54f-94a7f6a3a50f@digikod.net>
Date:   Wed, 26 Apr 2023 15:58:31 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH -next v2 0/6] landlock: add chmod and chown support
Content-Language: en-US
To:     xiujianfeng <xiujianfeng@huawei.com>, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, shuah@kernel.org,
        corbet@lwn.net
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, roberto.sassu@huawei.com,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>
References: <20220827111215.131442-1-xiujianfeng@huawei.com>
 <d55baf4d-01d3-e4d7-e07f-9658d1606a8c@huawei.com>
 <a4dc7c12-b485-2eb2-add5-4f7a387a50fa@digikod.net>
 <5fc97b5b-e76f-99c7-7314-6bb16851f66e@huawei.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <5fc97b5b-e76f-99c7-7314-6bb16851f66e@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 24/04/2023 10:52, xiujianfeng wrote:
> 
> 
> On 2023/4/21 1:40, Mickaël Salaün wrote:
>>
>> On 18/04/2023 12:53, xiujianfeng wrote:
>>> Hi Mickael,
>>>
>>> Sorry about the long silence on this work, As we known this work depends
>>> on another work about changing argument from struct dentry to struct
>>> path for some attr/xattr related lsm hooks, I'm stuck with this thing,
>>> because IMA/EVM is a special security module which is not LSM-based
>>> currently, and severely coupled with the file system. so I am waiting
>>> for Roberto Sassu' work (Move IMA and EVM to the LSM infrastructure) to
>>> be ready, I think it can make my work more easy. you can find
>>> Roberto'work here,
>>> https://lwn.net/ml/linux-kernel/20230303181842.1087717-1-roberto.sassu@huaweicloud.com/
>>>
>>> Any good idea are welcome, thanks.
>>
>> Thanks for the update Xiu.
>>
>> Which part would be needed from Roberto's patch series?
>>
> As we discussed before, the two access rights that need to be added and
> their usage is as below:
> LANDLOCK_ACCESS_FS_WRITE_METADATA controls
> 1.inode_setattr
> 2.inode_setxattr
> 3.inode_removexattr
> 4.inode_set_acl
> 5.inode_remove_acl
> LANDLOCK_ACCESS_FS_READ_METADATA controls
> 1.inode_getattr
> 2.inode_get_acl
> 3.inode_getxattr
> 4.inode_listxattr
> 
> all these APIs should be changed to use struct path instead of dentry,
> and then several vfs APIs as follows are invovled:
> notify_change,
> __vfs_setxattr_locked,
> __vfs_removexattr_locked,
> __vfs_setxattr_noperm
> vfs_set_acl
> vfs_remove_acl
> vfs_getxattr
> vfs_listxattr
> vfs_get_acl
> and also include some LSM hooks such as inode_post_setxattr and
> inode_setsecctx.
> 
> Since the original places where pass dentry to security_inode_xxx may
> not have any struct path, we have to pass it from the top caller, so
> this also touches lots of filesystems(e.g. cachefiles, ecryptfs, ksmbd,
> nfsd, overlayfs...).
> 
> Other LSMs such as selinux, smack can be easy to refator because they
> are LSM-based, and if VFS passes path to security_inode_xxx and they can
> just use path->dentry instead inside they own modules.
> 
> AS for IMA/EVM, unfortunately they are not LSM-based and coupled with
> the file system. To make things worse, there is a recursive dependency
> situation during the update of extended attribute which happen as follows:
> 
> __vfs_setxattr_noperm
>    => security_inode_post_setxattr
>      => evm_inode_post_setxattr
>        => evm_update_evmxattr
> => __vfs_setxattr_noperm
> 
> To change the argument of __vfs_setxattr_noperm from a dentry to the
> path structure, the two EVM functions would have to be altered as well.
> However, evm_update_evmxattr is called by 3 other EVM functions who
> lives in the very heart of the complicated EVM framework. Any change to
> them would cause a nasty chain reaction in EVM and, as IMA would trigger
> EVM directly, in IMA as well.
> 
> There is another callchain as follow:
> ima_appraise_measurement
>    =>evm_verifyxattr
>      =>evm_verifyxattr
>        =>evm_verify_hmac
> 	=>evm_calc_hash
> 	   =>evm_calc_hmac_or_hash
> 	     =>vfs_getxattr
> Passing struct path into vfs_getxattr() would also affect this
> callchain. Currently ima_appraise_measurment accepts a struct file, and
> dentry is generated from file_dentry(file) in order to mitigate a
> deadlock issue involving overlayfs(commit e71b9dff0634ed). Once
> &file->f_path is passed through this callchain, and someone wants the
> dentry, it will be using file->f_path.dentry, which is different from
> file_dentry(file). In the overlayfs scenario, may this cause an issue?

I might be OK, but this need to be tested.

> 
> The patchset of moving IMA and EVM into the LSM infrastructe would be
> helpfull but still can not completely resolve this situation. more
> refactor would be needed in EVM. That's all that's happening right now.

OK, thanks for the detailed explanation!

I guess you could start with easier hooks (e.g. inode_getattr and 
inode_setattr) to see if there is potentially other implications, and 
incrementally build on that.


> 
>>
>>>
>>>
>>> On 2022/8/27 19:12, Xiu Jianfeng wrote:
>>>> v2:
>>>>    * abstract walk_to_visible_parent() helper
>>>>    * chmod and chown rights only take affect on directory's context
>>>>    * add testcase for fchmodat/lchown/fchownat
>>>>    * fix other review issues
>>>>
>>>> Xiu Jianfeng (6):
>>>>     landlock: expand access_mask_t to u32 type
>>>>     landlock: abstract walk_to_visible_parent() helper
>>>>     landlock: add chmod and chown support
>>>>     landlock/selftests: add selftests for chmod and chown
>>>>     landlock/samples: add chmod and chown support
>>>>     landlock: update chmod and chown support in document
>>>>
>>>>    Documentation/userspace-api/landlock.rst     |   9 +-
>>>>    include/uapi/linux/landlock.h                |  10 +-
>>>>    samples/landlock/sandboxer.c                 |  13 +-
>>>>    security/landlock/fs.c                       | 110 ++++++--
>>>>    security/landlock/limits.h                   |   2 +-
>>>>    security/landlock/ruleset.h                  |   2 +-
>>>>    security/landlock/syscalls.c                 |   2 +-
>>>>    tools/testing/selftests/landlock/base_test.c |   2 +-
>>>>    tools/testing/selftests/landlock/fs_test.c   | 267 ++++++++++++++++++-
>>>>    9 files changed, 386 insertions(+), 31 deletions(-)
>>>>
