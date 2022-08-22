Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD4A59C534
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Aug 2022 19:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235923AbiHVRlO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Aug 2022 13:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235809AbiHVRkn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Aug 2022 13:40:43 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECCA40E37
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Aug 2022 10:40:35 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 8895A1D17;
        Mon, 22 Aug 2022 17:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1661189931;
        bh=XhlKghQJEH4TVDn/vL6j2f9t4RzK5CUez5pQCQZ+l1c=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=hQ6dh5tuuS9MSCs0YT4GMsofD6nDAWX5Rxx1uXij7u4pMuKnY4MknYmJnnVB0BZnp
         aK98Zu5Q1vQTLmkRGM2Q8nC2Y360kJnPtLpHHMmkqCRKrEoEF/+yyS46dk2oQqjuUh
         a5DBEHy71sFGsAXHuf//mZFC+a/eMOjHQjfxMJWw=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 418C12118;
        Mon, 22 Aug 2022 17:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1661190033;
        bh=XhlKghQJEH4TVDn/vL6j2f9t4RzK5CUez5pQCQZ+l1c=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=TM4xIMXnui3569S5Kwainud6LvJOPbjAzr6Gr53J69Mz+tTNRpZU6my+1uq4V+out
         6ysqLlmtkaE4k238sqTcFsJFwG3H+z15Dp9PYbtFMCMT6OS85PPFOWDn29znq9mHL9
         GyadZM6P+uEla6RmtbonRNKj0CBfvOQADJ7YU7Tw=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 22 Aug 2022 20:40:32 +0300
Message-ID: <86ac0423-5e71-4768-a8f8-1ec2673cae5c@paragon-software.com>
Date:   Mon, 22 Aug 2022 20:40:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ntfs: fix acl handling
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>, <ntfs3@lists.linux.dev>
CC:     <linux-fsdevel@vger.kernel.org>
References: <20220720123252.686466-1-brauner@kernel.org>
 <20220818074729.u45tzc3lq7y6zibd@wittgenstein>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20220818074729.u45tzc3lq7y6zibd@wittgenstein>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/18/22 10:47, Christian Brauner wrote:
> On Wed, Jul 20, 2022 at 02:32:52PM +0200, Christian Brauner wrote:
>> While looking at our current POSIX ACL handling in the context of some
>> overlayfs work I went through a range of other filesystems checking how they
>> handle them currently and encountered ntfs3.
>>
>> The posic_acl_{from,to}_xattr() helpers always need to operate on the
>> filesystem idmapping. Since ntfs3 can only be mounted in the initial user
>> namespace the relevant idmapping is init_user_ns.
>>
>> The posix_acl_{from,to}_xattr() helpers are concerned with translating between
>> the kernel internal struct posix_acl{_entry} and the uapi struct
>> posix_acl_xattr_{header,entry} and the kernel internal data structure is cached
>> filesystem wide.
>>
>> Additional idmappings such as the caller's idmapping or the mount's idmapping
>> are handled higher up in the VFS. Individual filesystems usually do not need to
>> concern themselves with these.
>>
>> The posix_acl_valid() helper is concerned with checking whether the values in
>> the kernel internal struct posix_acl can be represented in the filesystem's
>> idmapping. IOW, if they can be written to disk. So this helper too needs to
>> take the filesystem's idmapping.
>>
>> Fixes: be71b5cba2e6 ("fs/ntfs3: Add attrib operations")
>> Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
>> Cc: ntfs3@lists.linux.dev
>> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
>> ---
> 
> Somehow this patch fell through the cracks and this should really be
> fixed. Do you plan on sending a PR for this soon or should I just send
> it through my tree?
> 

Thanks for catching this, I've missed this patch.
I've run tests - everything seems to be fine.
I've already sent PR for 6.0 and next PR will probably be sometime in September or later.
Can you send it through your tree?

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

>>   fs/ntfs3/xattr.c | 16 +++++++---------
>>   1 file changed, 7 insertions(+), 9 deletions(-)
>>
>> diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
>> index 5e0e0280e70d..3e9118705174 100644
>> --- a/fs/ntfs3/xattr.c
>> +++ b/fs/ntfs3/xattr.c
>> @@ -478,8 +478,7 @@ static noinline int ntfs_set_ea(struct inode *inode, const char *name,
>>   }
>>   
>>   #ifdef CONFIG_NTFS3_FS_POSIX_ACL
>> -static struct posix_acl *ntfs_get_acl_ex(struct user_namespace *mnt_userns,
>> -					 struct inode *inode, int type,
>> +static struct posix_acl *ntfs_get_acl_ex(struct inode *inode, int type,
>>   					 int locked)
>>   {
>>   	struct ntfs_inode *ni = ntfs_i(inode);
>> @@ -514,7 +513,7 @@ static struct posix_acl *ntfs_get_acl_ex(struct user_namespace *mnt_userns,
>>   
>>   	/* Translate extended attribute to acl. */
>>   	if (err >= 0) {
>> -		acl = posix_acl_from_xattr(mnt_userns, buf, err);
>> +		acl = posix_acl_from_xattr(&init_user_ns, buf, err);
>>   	} else if (err == -ENODATA) {
>>   		acl = NULL;
>>   	} else {
>> @@ -537,8 +536,7 @@ struct posix_acl *ntfs_get_acl(struct inode *inode, int type, bool rcu)
>>   	if (rcu)
>>   		return ERR_PTR(-ECHILD);
>>   
>> -	/* TODO: init_user_ns? */
>> -	return ntfs_get_acl_ex(&init_user_ns, inode, type, 0);
>> +	return ntfs_get_acl_ex(inode, type, 0);
>>   }
>>   
>>   static noinline int ntfs_set_acl_ex(struct user_namespace *mnt_userns,
>> @@ -595,7 +593,7 @@ static noinline int ntfs_set_acl_ex(struct user_namespace *mnt_userns,
>>   		value = kmalloc(size, GFP_NOFS);
>>   		if (!value)
>>   			return -ENOMEM;
>> -		err = posix_acl_to_xattr(mnt_userns, acl, value, size);
>> +		err = posix_acl_to_xattr(&init_user_ns, acl, value, size);
>>   		if (err < 0)
>>   			goto out;
>>   		flags = 0;
>> @@ -641,7 +639,7 @@ static int ntfs_xattr_get_acl(struct user_namespace *mnt_userns,
>>   	if (!acl)
>>   		return -ENODATA;
>>   
>> -	err = posix_acl_to_xattr(mnt_userns, acl, buffer, size);
>> +	err = posix_acl_to_xattr(&init_user_ns, acl, buffer, size);
>>   	posix_acl_release(acl);
>>   
>>   	return err;
>> @@ -665,12 +663,12 @@ static int ntfs_xattr_set_acl(struct user_namespace *mnt_userns,
>>   	if (!value) {
>>   		acl = NULL;
>>   	} else {
>> -		acl = posix_acl_from_xattr(mnt_userns, value, size);
>> +		acl = posix_acl_from_xattr(&init_user_ns, value, size);
>>   		if (IS_ERR(acl))
>>   			return PTR_ERR(acl);
>>   
>>   		if (acl) {
>> -			err = posix_acl_valid(mnt_userns, acl);
>> +			err = posix_acl_valid(&init_user_ns, acl);
>>   			if (err)
>>   				goto release_and_out;
>>   		}
>>
>> base-commit: ff6992735ade75aae3e35d16b17da1008d753d28
>> -- 
>> 2.34.1
>>
