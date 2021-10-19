Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 302A3433D16
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 19:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbhJSRNm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 13:13:42 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:41526 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232613AbhJSRNm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 13:13:42 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 402461D2E;
        Tue, 19 Oct 2021 20:11:27 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1634663487;
        bh=rJZBCzj6lfZaYCwFdreaBYuWTvpigDJUzTf1ZhgWeas=;
        h=Date:From:Subject:To:CC:References:In-Reply-To;
        b=Lvgm6u5liG4yqYIHf35Nt4i9wkSCqJTSL3YFiSe6JoX2mHSClDjRpTbo60h/JqUfS
         gQjKzRF1rUK19sYB4L00t+I/tGUSb5zWwAkQUe6Xhd9qfTbtYcpa5payYV0A3IjkGM
         8KBBfvXJx0RUTX7O3PxD4nU6yFAzQqzNRD1NXKXs=
Received: from [192.168.211.54] (192.168.211.54) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 19 Oct 2021 20:11:26 +0300
Message-ID: <3bd566c0-6d4b-11ab-1402-a8ee63502dec@paragon-software.com>
Date:   Tue, 19 Oct 2021 20:11:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: Re: [PATCH 1/2] fs/ntfs3: Remove unnecessary functions
To:     Kari Argillander <kari.argillander@gmail.com>
CC:     <ntfs3@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <992eee8f-bed8-4019-a966-1988bd4dd5de@paragon-software.com>
 <2ce78ab6-453d-d7bf-9969-eb47b7347098@paragon-software.com>
 <20211016104209.r6mgz2ote4jcmgcj@kari-VirtualBox>
Content-Language: en-US
In-Reply-To: <20211016104209.r6mgz2ote4jcmgcj@kari-VirtualBox>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.54]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 16.10.2021 13:42, Kari Argillander wrote:
> On Fri, Oct 01, 2021 at 07:02:12PM +0300, Konstantin Komarov wrote:
>> We don't need ntfs_xattr_get_acl and ntfs_xattr_set_acl.
>> There are ntfs_get_acl_ex and ntfs_set_acl_ex.
> 
> I just bisect this commit after tests
> 
> "generic/099,generic/105,generic/307,generic/318,generic/319,generic/375,generic/444"
> 
> fails for me. Fails happends because mount option acl was not defined.
> Before they where skipped, but now fail occurs. Also generic/099 was
> passing if acl mount option was defined, but after this patch it also
> fail. Every other test fail for me as well, but that is not related to
> this patch.
> 
> So should we revert or do you make new patch to fix the issue or do you
> think we won't have any issue here?
> 
>   Argillander
> 

We skipped these tests(muted them in beginning and forgot to unmute).
Thanks for pointing this out. There will be patch to fix them.

>> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
>> ---
>>  fs/ntfs3/xattr.c | 94 ------------------------------------------------
>>  1 file changed, 94 deletions(-)
>>
>> diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
>> index 83bbee277e12..111355692163 100644
>> --- a/fs/ntfs3/xattr.c
>> +++ b/fs/ntfs3/xattr.c
>> @@ -621,67 +621,6 @@ int ntfs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
>>  	return ntfs_set_acl_ex(mnt_userns, inode, acl, type, 0);
>>  }
>>  
>> -static int ntfs_xattr_get_acl(struct user_namespace *mnt_userns,
>> -			      struct inode *inode, int type, void *buffer,
>> -			      size_t size)
>> -{
>> -	struct posix_acl *acl;
>> -	int err;
>> -
>> -	if (!(inode->i_sb->s_flags & SB_POSIXACL)) {
>> -		ntfs_inode_warn(inode, "add mount option \"acl\" to use acl");
>> -		return -EOPNOTSUPP;
>> -	}
>> -
>> -	acl = ntfs_get_acl(inode, type);
>> -	if (IS_ERR(acl))
>> -		return PTR_ERR(acl);
>> -
>> -	if (!acl)
>> -		return -ENODATA;
>> -
>> -	err = posix_acl_to_xattr(mnt_userns, acl, buffer, size);
>> -	ntfs_posix_acl_release(acl);
>> -
>> -	return err;
>> -}
>> -
>> -static int ntfs_xattr_set_acl(struct user_namespace *mnt_userns,
>> -			      struct inode *inode, int type, const void *value,
>> -			      size_t size)
>> -{
>> -	struct posix_acl *acl;
>> -	int err;
>> -
>> -	if (!(inode->i_sb->s_flags & SB_POSIXACL)) {
>> -		ntfs_inode_warn(inode, "add mount option \"acl\" to use acl");
>> -		return -EOPNOTSUPP;
>> -	}
>> -
>> -	if (!inode_owner_or_capable(mnt_userns, inode))
>> -		return -EPERM;
>> -
>> -	if (!value) {
>> -		acl = NULL;
>> -	} else {
>> -		acl = posix_acl_from_xattr(mnt_userns, value, size);
>> -		if (IS_ERR(acl))
>> -			return PTR_ERR(acl);
>> -
>> -		if (acl) {
>> -			err = posix_acl_valid(mnt_userns, acl);
>> -			if (err)
>> -				goto release_and_out;
>> -		}
>> -	}
>> -
>> -	err = ntfs_set_acl(mnt_userns, inode, acl, type);
>> -
>> -release_and_out:
>> -	ntfs_posix_acl_release(acl);
>> -	return err;
>> -}
>> -
>>  /*
>>   * ntfs_init_acl - Initialize the ACLs of a new inode.
>>   *
>> @@ -848,23 +787,6 @@ static int ntfs_getxattr(const struct xattr_handler *handler, struct dentry *de,
>>  		goto out;
>>  	}
>>  
>> -#ifdef CONFIG_NTFS3_FS_POSIX_ACL
>> -	if ((name_len == sizeof(XATTR_NAME_POSIX_ACL_ACCESS) - 1 &&
>> -	     !memcmp(name, XATTR_NAME_POSIX_ACL_ACCESS,
>> -		     sizeof(XATTR_NAME_POSIX_ACL_ACCESS))) ||
>> -	    (name_len == sizeof(XATTR_NAME_POSIX_ACL_DEFAULT) - 1 &&
>> -	     !memcmp(name, XATTR_NAME_POSIX_ACL_DEFAULT,
>> -		     sizeof(XATTR_NAME_POSIX_ACL_DEFAULT)))) {
>> -		/* TODO: init_user_ns? */
>> -		err = ntfs_xattr_get_acl(
>> -			&init_user_ns, inode,
>> -			name_len == sizeof(XATTR_NAME_POSIX_ACL_ACCESS) - 1
>> -				? ACL_TYPE_ACCESS
>> -				: ACL_TYPE_DEFAULT,
>> -			buffer, size);
>> -		goto out;
>> -	}
>> -#endif
>>  	/* Deal with NTFS extended attribute. */
>>  	err = ntfs_get_ea(inode, name, name_len, buffer, size, NULL);
>>  
>> @@ -977,22 +899,6 @@ static noinline int ntfs_setxattr(const struct xattr_handler *handler,
>>  		goto out;
>>  	}
>>  
>> -#ifdef CONFIG_NTFS3_FS_POSIX_ACL
>> -	if ((name_len == sizeof(XATTR_NAME_POSIX_ACL_ACCESS) - 1 &&
>> -	     !memcmp(name, XATTR_NAME_POSIX_ACL_ACCESS,
>> -		     sizeof(XATTR_NAME_POSIX_ACL_ACCESS))) ||
>> -	    (name_len == sizeof(XATTR_NAME_POSIX_ACL_DEFAULT) - 1 &&
>> -	     !memcmp(name, XATTR_NAME_POSIX_ACL_DEFAULT,
>> -		     sizeof(XATTR_NAME_POSIX_ACL_DEFAULT)))) {
>> -		err = ntfs_xattr_set_acl(
>> -			mnt_userns, inode,
>> -			name_len == sizeof(XATTR_NAME_POSIX_ACL_ACCESS) - 1
>> -				? ACL_TYPE_ACCESS
>> -				: ACL_TYPE_DEFAULT,
>> -			value, size);
>> -		goto out;
>> -	}
>> -#endif
>>  	/* Deal with NTFS extended attribute. */
>>  	err = ntfs_set_ea(inode, name, name_len, value, size, flags, 0);
>>  
>> -- 
>> 2.33.0
>>
