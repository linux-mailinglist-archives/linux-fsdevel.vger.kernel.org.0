Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D7D712AB1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 18:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjEZQdW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 12:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbjEZQdU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 12:33:20 -0400
Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch [IPv6:2001:1600:4:17::8fac])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D9B198
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 May 2023 09:33:17 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4QSVpc2hLFzMq9gR;
        Fri, 26 May 2023 18:33:12 +0200 (CEST)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4QSVpV20JTzMskdH;
        Fri, 26 May 2023 18:33:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1685118792;
        bh=HJQhmbmtbBhKQKuJigfXUA3I5dGt5vNd+kwPhAR19ZE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QqUfw9dzLlsE/jUv5i4Jbgo6yOquEH/LNulEp4j1bWACweWhxdKLOxVud95fbWB4E
         npEnxoPtqyuJGwkskhuE2oFCSu10WcSFOgyuW8dZTYuf1lnresczWPQXS0hze8B1ou
         boYfLZK8RC3g7VGc+V2WpOIG30d240jDxiyeRn5Q=
Message-ID: <75b4746d-d41e-7c9f-4bb0-42a46bda7f17@digikod.net>
Date:   Fri, 26 May 2023 18:33:05 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH -next 0/2] lsm: Change inode_setattr() to take struct
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        viro@zeniv.linux.org.uk, dhowells@redhat.com, code@tyhicks.com,
        hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org,
        sfrench@samba.org, senozhatsky@chromium.org, tom@talpey.com,
        chuck.lever@oracle.com, jlayton@kernel.org, miklos@szeredi.hu,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com, dchinner@redhat.com,
        john.johansen@canonical.com, mcgrof@kernel.org,
        mortonm@chromium.org, fred@cloudflare.com, mpe@ellerman.id.au,
        nathanl@linux.ibm.com, gnoack3000@gmail.com,
        roberto.sassu@huawei.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        ecryptfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        wangweiyang2@huawei.com
References: <20230505081200.254449-1-xiujianfeng@huawei.com>
 <20230515-nutzen-umgekehrt-eee629a0101e@brauner>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20230515-nutzen-umgekehrt-eee629a0101e@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 15/05/2023 17:12, Christian Brauner wrote:
> On Fri, May 05, 2023 at 04:11:58PM +0800, Xiu Jianfeng wrote:
>> Hi,
>>
>> I am working on adding xattr/attr support for landlock [1], so we can
>> control fs accesses such as chmod, chown, uptimes, setxattr, etc.. inside
>> landlock sandbox. the LSM hooks as following are invoved:
>> 1.inode_setattr
>> 2.inode_setxattr
>> 3.inode_removexattr
>> 4.inode_set_acl
>> 5.inode_remove_acl
>> which are controlled by LANDLOCK_ACCESS_FS_WRITE_METADATA.
>>
>> and
>> 1.inode_getattr
>> 2.inode_get_acl
>> 3.inode_getxattr
>> 4.inode_listxattr
>> which are controlled by LANDLOCK_ACCESS_FS_READ_METADATA
> 
> It would be helpful to get the complete, full picture.
> 
> Piecemeal extending vfs helpers with struct path arguments is costly,
> will cause a lot of churn and will require a lot of review time from us.
> 
> Please give us the list of all security hooks to which you want to pass
> a struct path (if there are more to come apart from the ones listed
> here). Then please follow all callchains and identify the vfs helpers
> that would need to be updated. Then please figure out where those
> vfs helpers are called from and follow all callchains finding all
> inode_operations that would have to be updated and passed a struct path
> argument. So ultimately we'll end up with a list of vfs helpers and
> inode_operations that would have to be changed.
> 
> I'm very reluctant to see anything merged without knowing _exactly_ what
> you're getting us into.

Ultimately we'd like the path-based LSMs to reach parity with the 
inode-based LSMs. This proposal's goal is to provide users the ability 
to control (in a complete and easy way) file metadata access. For these 
we need to extend the inode_*attr hooks and inode_*acl hooks to handle 
paths. The chown/chmod hooks are already good.

In the future, I'd also like to be able to control directory traversals 
(e.g. chdir), which currently only calls inode_permission().

What would be the best way to reach this goal?
