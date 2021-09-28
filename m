Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0301141B58E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 20:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242103AbhI1SDW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Sep 2021 14:03:22 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:33572 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242139AbhI1SDV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Sep 2021 14:03:21 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 2D5DE82156;
        Tue, 28 Sep 2021 21:01:40 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1632852100;
        bh=qY3fyImBzSHuyEURvksncUEzAUF8i72Li2tfjGn8KBg=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=l77m+WLPNDvftSY1Ou2ysosltu0/ZL9Viob214rG5yvfxoA4B1YrnR54w0HDbepjQ
         YrmrsV9lT0oGO2m+K8wlw2KIdyfjPGeHg99yYpwSJI4iF1UkecqLG2uIkiVT+p7oLj
         1mk3a/3d4lzBRFRC7pzzTRhymKa6wT7FrJeTuDJU=
Received: from [192.168.211.85] (192.168.211.85) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 28 Sep 2021 21:01:39 +0300
Message-ID: <e843605d-4ef4-520d-6cc2-a6ceb50b6ee5@paragon-software.com>
Date:   Tue, 28 Sep 2021 21:01:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH 2/3] fs/ntfs3: Remove locked argument in ntfs_set_ea
Content-Language: en-US
To:     Kari Argillander <kari.argillander@gmail.com>
CC:     <ntfs3@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <eb131ee0-3e89-da58-650c-5b84dd792a49@paragon-software.com>
 <b988b38f-ccca-df01-d90d-10f83dd3ad2e@paragon-software.com>
 <20210925084901.mvlxt442jvy2et7u@kari-VirtualBox>
 <816442f2-a79f-68cf-f107-9770a66f3acc@paragon-software.com>
 <20210927191005.zcebctlxfsqutgkh@kari-VirtualBox>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20210927191005.zcebctlxfsqutgkh@kari-VirtualBox>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.85]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 27.09.2021 22:10, Kari Argillander wrote:
> On Mon, Sep 27, 2021 at 06:10:00PM +0300, Konstantin Komarov wrote:
>>
>>
>> On 25.09.2021 11:49, Kari Argillander wrote:
>>> On Fri, Sep 24, 2021 at 07:15:50PM +0300, Konstantin Komarov wrote:
>>>> We always need to lock now, because locks became smaller
>>>> (see "Move ni_lock_dir and ni_unlock into ntfs_create_inode").
>>>
>>> So basically this actually fixes that commit?
>>>
>>> Fixes: d562e901f25d ("fs/ntfs3: Move ni_lock_dir and ni_unlock into ntfs_create_inode")
>>>
>>> Or if you do not use fixes atleast use
>>>
>>> d562e901f25d ("fs/ntfs3: Move ni_lock_dir and ni_unlock into ntfs_create_inode")
>>>
>>> You can add these to your gitconfig
>>>
>>> 	[core]
>>> 		abbrev = 12
>>> 	[pretty]
>>> 	        fixes = Fixes: %h (\"%s\")
>>> 		fixed = Fixes: %h (\"%s\")
>>>
>>> And get this annotation with
>>> 	git show --pretty=fixes <sha>
>>>
>>> Have some comments below also.
>>>
>>>>
>>>> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
>>>> ---
>>>>  fs/ntfs3/xattr.c | 28 +++++++++++++---------------
>>>>  1 file changed, 13 insertions(+), 15 deletions(-)
>>>>
>>>> diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
>>>> index 253a07d9aa7b..1ab109723b10 100644
>>>> --- a/fs/ntfs3/xattr.c
>>>> +++ b/fs/ntfs3/xattr.c
>>>> @@ -257,7 +257,7 @@ static int ntfs_get_ea(struct inode *inode, const char *name, size_t name_len,
>>>>  
>>>>  static noinline int ntfs_set_ea(struct inode *inode, const char *name,
>>>>  				size_t name_len, const void *value,
>>>> -				size_t val_size, int flags, int locked)
> 
> Maybe we should leave int locked and ...
> 
>>>> +				size_t val_size, int flags)
>>>>  {
>>>>  	struct ntfs_inode *ni = ntfs_i(inode);
>>>>  	struct ntfs_sb_info *sbi = ni->mi.sbi;
>>>> @@ -276,8 +276,7 @@ static noinline int ntfs_set_ea(struct inode *inode, const char *name,
>>>>  	u64 new_sz;
>>>>  	void *p;
>>>>  
>>>> -	if (!locked)
>>>> -		ni_lock(ni);
>>>> +	ni_lock(ni);
>>>>  
>>>>  	run_init(&ea_run);
>>>>  
>>>> @@ -465,8 +464,7 @@ static noinline int ntfs_set_ea(struct inode *inode, const char *name,
>>>>  	mark_inode_dirty(&ni->vfs_inode);
>>>>  
>>>>  out:
>>>> -	if (!locked)
>>>> -		ni_unlock(ni);
>>>> +	ni_unlock(ni);
>>>>  
>>>>  	run_close(&ea_run);
>>>>  	kfree(ea_all);
>>>> @@ -537,7 +535,7 @@ struct posix_acl *ntfs_get_acl(struct inode *inode, int type)
>>>>  
>>>>  static noinline int ntfs_set_acl_ex(struct user_namespace *mnt_userns,
>>>>  				    struct inode *inode, struct posix_acl *acl,
>>>> -				    int type, int locked)
>>>> +				    int type)
>>>>  {
>>>>  	const char *name;
>>>>  	size_t size, name_len;
>>>> @@ -594,7 +592,7 @@ static noinline int ntfs_set_acl_ex(struct user_namespace *mnt_userns,
>>>>  		flags = 0;
>>>>  	}
>>>>  
>>>> -	err = ntfs_set_ea(inode, name, name_len, value, size, flags, locked);
>>>> +	err = ntfs_set_ea(inode, name, name_len, value, size, flags);
>>>>  	if (err == -ENODATA && !size)
>>>>  		err = 0; /* Removing non existed xattr. */
>>>>  	if (!err)
>>>> @@ -612,7 +610,7 @@ static noinline int ntfs_set_acl_ex(struct user_namespace *mnt_userns,
>>>>  int ntfs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
>>>>  		 struct posix_acl *acl, int type)
>>>>  {
>>>> -	return ntfs_set_acl_ex(mnt_userns, inode, acl, type, 0);
>>>> +	return ntfs_set_acl_ex(mnt_userns, inode, acl, type);
>>>>  }
>>>>  
>>>>  static int ntfs_xattr_get_acl(struct user_namespace *mnt_userns,
>>>> @@ -693,7 +691,7 @@ int ntfs_init_acl(struct user_namespace *mnt_userns, struct inode *inode,
>>>>  
>>>>  	if (default_acl) {
>>>>  		err = ntfs_set_acl_ex(mnt_userns, inode, default_acl,
>>>> -				      ACL_TYPE_DEFAULT, 1);
>>>> +				      ACL_TYPE_DEFAULT);
>>>>  		posix_acl_release(default_acl);
>>>>  	} else {
>>>>  		inode->i_default_acl = NULL;
>>>> @@ -704,7 +702,7 @@ int ntfs_init_acl(struct user_namespace *mnt_userns, struct inode *inode,
>>>>  	else {
>>>>  		if (!err)
>>>>  			err = ntfs_set_acl_ex(mnt_userns, inode, acl,
>>>> -					      ACL_TYPE_ACCESS, 1);
>>>> +					      ACL_TYPE_ACCESS);
>>>>  		posix_acl_release(acl);
>>>>  	}
>>>>  
>>>> @@ -988,7 +986,7 @@ static noinline int ntfs_setxattr(const struct xattr_handler *handler,
>>>>  	}
>>>>  #endif
>>>>  	/* Deal with NTFS extended attribute. */
>>>> -	err = ntfs_set_ea(inode, name, name_len, value, size, flags, 0);
>>>> +	err = ntfs_set_ea(inode, name, name_len, value, size, flags);
>>>>  
>>>>  out:
>>>>  	return err;
>>>> @@ -1006,26 +1004,26 @@ int ntfs_save_wsl_perm(struct inode *inode)
>>>>  
> 
> do lock here and ...
> 
>>>>  	value = cpu_to_le32(i_uid_read(inode));
>>>>  	err = ntfs_set_ea(inode, "$LXUID", sizeof("$LXUID") - 1, &value,
>>>> -			  sizeof(value), 0, 0);
>>>> +			  sizeof(value), 0);
>>>>  	if (err)
>>>>  		goto out;
>>>>  
>>>>  	value = cpu_to_le32(i_gid_read(inode));
>>>>  	err = ntfs_set_ea(inode, "$LXGID", sizeof("$LXGID") - 1, &value,
>>>> -			  sizeof(value), 0, 0);
>>>> +			  sizeof(value), 0);
>>>>  	if (err)
>>>>  		goto out;
>>>>  
>>>>  	value = cpu_to_le32(inode->i_mode);
>>>>  	err = ntfs_set_ea(inode, "$LXMOD", sizeof("$LXMOD") - 1, &value,
>>>> -			  sizeof(value), 0, 0);
>>>> +			  sizeof(value), 0);
>>>>  	if (err)
>>>>  		goto out;
>>>>  
>>>>  	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode)) {
>>>>  		value = cpu_to_le32(inode->i_rdev);
>>>>  		err = ntfs_set_ea(inode, "$LXDEV", sizeof("$LXDEV") - 1, &value,
>>>> -				  sizeof(value), 0, 0);
>>>> +				  sizeof(value), 0);
> 
> unlock here. Of course unlock also in error path.
> 
>>>
>>> Is this really that we can lock/unlock same lock 4 times in a row in a
>>> ntfs_set_ea? This does not feel correct. 
>>>
>>>   Argillander
>>>
>>
>> How it was working before d562e901f25d 
>> "fs/ntfs3: Move ni_lock_dir and ni_unlock into ntfs_create_inode":
>>
>> ntfs_create (lock mutex) =>
>> ntfs_create_inode =>
>> ntfs_save_wsl_perm (we are under lock here) =>
>> return to ntfs_create and unlock
>>
>> How it works with d562e901f25d:
>>
>> ntfs_create => 
>> ntfs_create_inode (lock in line 1201 file fs/ntfs3/inode.c 
>> and unlock in line 1557) => 
>> ntfs_save_wsl_perm (we aren't under lock here in line 1605)
>>
>> So we need to lock 4 times because there are 4 ntfs_set_ea calls.
>> But now there can be done more work between those calls
>> in other threads, locks became more granular.
> 
> Yeah but locking and locking 4 times when we can do it just ones is
> quite waste. Please consider my suggestion above or tell what is wrong
> with it. 
> 
>   Argillander
> 

If I've understood correctly, you want to lock once in start of function 
ntfs_save_wsl_perm and unlock at the end of it.
It takes care of locks for those 4 calls to ntfs_set_ea.

But there are still other calls to ntfs_set_ea, that aren't protected
in this case:
function ntfs_set_acl_ex (line 603 file fs/ntfs3/xattr.c)
err = ntfs_set_ea(inode, name, name_len, value, size, flags, locked);

This function called there:
- function ntfs_set_acl  (line 621 file fs/ntfs3/xattr.c)
return ntfs_set_acl_ex(mnt_userns, inode, acl, type);
- function ntfs_init_acl (line 701 file fs/ntfs3/xattr.c)
err = ntfs_set_acl_ex(mnt_userns, inode, default_acl,
- function ntfs_init_acl (line 712 file fs/ntfs3/xattr.c)
err = ntfs_set_acl_ex(mnt_userns, inode, acl,

So there are many entry points to ntfs_set_ea (and can be added more).
Of course we can let int locked remain for these situations,
but in my opinion it makes code a lot less readable
(that was the reason to start looking into locking).
I'm not sure, that winning some lock/unlocking
in one specific scenario is worth it.

>>
>>>>  		if (err)
>>>>  			goto out;
>>>>  	}
>>>> -- 
>>>> 2.33.0
>>>>
>>>>
