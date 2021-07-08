Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55B2B3BF417
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jul 2021 04:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhGHC7l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jul 2021 22:59:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50439 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230244AbhGHC7k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jul 2021 22:59:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625713018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bTwhpLi/vIUO55WyGqUrYH/trfR5psNmZ2zj2iPipmo=;
        b=EHjTYG4tGiUG/UFudpxv5Ww+6gCubB5EwogKVvs3hFwsUc7e8akcZmY1Duu2EyngYMnxv9
        t5lSOsSN1ANTb5hnM+r5f6x+N1KFzS5z+hLDHnPn/dE3LJ0jd0uKiUim8xlwlspXmgBUh9
        CMY5qpzAM1+yvfsgmgjge/WtZAQU1ls=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-_UkpTLfoOw2_VK3ti7qgtw-1; Wed, 07 Jul 2021 22:56:57 -0400
X-MC-Unique: _UkpTLfoOw2_VK3ti7qgtw-1
Received: by mail-pg1-f199.google.com with SMTP id j17-20020a63cf110000b0290226eb0c27acso3196339pgg.23
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jul 2021 19:56:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=bTwhpLi/vIUO55WyGqUrYH/trfR5psNmZ2zj2iPipmo=;
        b=ay8S6wPnOTs+dwHVb8RrChWkdQWUn4pcL3g3SHqnK0r9rTttQ6LEAa9vYwKc54FaFB
         BWw05u5cUbGEi+54VgtQuT6UUgV297Pm1APrGwrSHbTRjLAV46GbWZ46OOyhcnzuSIzU
         LmXPoDvjf6eZTqsMBydp/J/Bz7q7nS+MC9pPzOEKS9JeXDBhRX8E84CLKNR6MKCWVooV
         cMbENZYxyOXpH3UbO7L51y7AwMLoN0JGR7atv3dci2BbIKIMdpcCJiFAmJvLJWaOF/Uv
         iLZbP+n8OT5hiVUXbSdyRmZ2YUJG0kkvmydgI6ZUm2YmRplzu5gYtPubagoGVjI1Z2xs
         t+Zw==
X-Gm-Message-State: AOAM530PpRA+d05Lo5xw8ieNvjVZxRGtp5FCMAx5krw/oadHe+7Bete4
        t0TNLCZJODA/FJEH+yobMuNN5kSYNRJgR0Iv2yHUYZ2AKMf5rh+0lSrKW8fOE1Lv7s+M5swnVw/
        sv+aLLJCz9sht4/kkYg7UFfjoFQ==
X-Received: by 2002:a17:90a:1d43:: with SMTP id u3mr2313381pju.121.1625713016638;
        Wed, 07 Jul 2021 19:56:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDzbtefmgnEs6gYTiMc6Yil/v90cqF6rRwD4lHqSZVOi/TnLanW2/c9WX1PMwjJBUuF8cWlA==
X-Received: by 2002:a17:90a:1d43:: with SMTP id u3mr2313361pju.121.1625713016382;
        Wed, 07 Jul 2021 19:56:56 -0700 (PDT)
Received: from [10.72.13.124] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id q17sm744222pgd.39.2021.07.07.19.56.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jul 2021 19:56:55 -0700 (PDT)
Subject: Re: [RFC PATCH v7 06/24] ceph: parse new fscrypt_auth and
 fscrypt_file fields in inode traces
To:     Luis Henriques <lhenriques@suse.de>,
        Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, dhowells@redhat.com
References: <20210625135834.12934-1-jlayton@kernel.org>
 <20210625135834.12934-7-jlayton@kernel.org> <YOWGPv099N7EsMVA@suse.de>
 <14d96eb9-c9b5-d854-d87a-65c1ab3be57e@redhat.com>
 <d9a56cc0d568bbf59cc76ad618b4d0f92c021fed.camel@kernel.org>
 <YOW67YA8e6vivdkh@suse.de> <YOXAo8Q0GQoWaAQE@suse.de>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <732d3526-5979-f276-80fa-2bc56ccd946c@redhat.com>
Date:   Thu, 8 Jul 2021 10:56:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YOXAo8Q0GQoWaAQE@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 7/7/21 10:56 PM, Luis Henriques wrote:
> On Wed, Jul 07, 2021 at 03:32:13PM +0100, Luis Henriques wrote:
>> On Wed, Jul 07, 2021 at 08:19:25AM -0400, Jeff Layton wrote:
>>> On Wed, 2021-07-07 at 19:19 +0800, Xiubo Li wrote:
>>>> On 7/7/21 6:47 PM, Luis Henriques wrote:
>>>>> On Fri, Jun 25, 2021 at 09:58:16AM -0400, Jeff Layton wrote:
>>>>>> ...and store them in the ceph_inode_info.
>>>>>>
>>>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>>>>> ---
>>>>>>    fs/ceph/file.c       |  2 ++
>>>>>>    fs/ceph/inode.c      | 18 ++++++++++++++++++
>>>>>>    fs/ceph/mds_client.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>>>>>>    fs/ceph/mds_client.h |  4 ++++
>>>>>>    fs/ceph/super.h      |  6 ++++++
>>>>>>    5 files changed, 74 insertions(+)
>>>>>>
>>>>>> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
>>>>>> index 2cda398ba64d..ea0e85075b7b 100644
>>>>>> --- a/fs/ceph/file.c
>>>>>> +++ b/fs/ceph/file.c
>>>>>> @@ -592,6 +592,8 @@ static int ceph_finish_async_create(struct inode *dir, struct inode *inode,
>>>>>>    	iinfo.xattr_data = xattr_buf;
>>>>>>    	memset(iinfo.xattr_data, 0, iinfo.xattr_len);
>>>>>>    
>>>>>> +	/* FIXME: set fscrypt_auth and fscrypt_file */
>>>>>> +
>>>>>>    	in.ino = cpu_to_le64(vino.ino);
>>>>>>    	in.snapid = cpu_to_le64(CEPH_NOSNAP);
>>>>>>    	in.version = cpu_to_le64(1);	// ???
>>>>>> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
>>>>>> index f62785e4dbcb..b620281ea65b 100644
>>>>>> --- a/fs/ceph/inode.c
>>>>>> +++ b/fs/ceph/inode.c
>>>>>> @@ -611,6 +611,13 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
>>>>>>    
>>>>>>    	ci->i_meta_err = 0;
>>>>>>    
>>>>>> +#ifdef CONFIG_FS_ENCRYPTION
>>>>>> +	ci->fscrypt_auth = NULL;
>>>>>> +	ci->fscrypt_auth_len = 0;
>>>>>> +	ci->fscrypt_file = NULL;
>>>>>> +	ci->fscrypt_file_len = 0;
>>>>>> +#endif
>>>>>> +
>>>>>>    	return &ci->vfs_inode;
>>>>>>    }
>>>>>>    
>>>>>> @@ -619,6 +626,9 @@ void ceph_free_inode(struct inode *inode)
>>>>>>    	struct ceph_inode_info *ci = ceph_inode(inode);
>>>>>>    
>>>>>>    	kfree(ci->i_symlink);
>>>>>> +#ifdef CONFIG_FS_ENCRYPTION
>>>>>> +	kfree(ci->fscrypt_auth);
>>>>>> +#endif
>>>>>>    	kmem_cache_free(ceph_inode_cachep, ci);
>>>>>>    }
>>>>>>    
>>>>>> @@ -1021,6 +1031,14 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
>>>>>>    		xattr_blob = NULL;
>>>>>>    	}
>>>>>>    
>>>>>> +	if (iinfo->fscrypt_auth_len && !ci->fscrypt_auth) {
>>>>>> +		ci->fscrypt_auth_len = iinfo->fscrypt_auth_len;
>>>>>> +		ci->fscrypt_auth = iinfo->fscrypt_auth;
>>>>>> +		iinfo->fscrypt_auth = NULL;
>>>>>> +		iinfo->fscrypt_auth_len = 0;
>>>>>> +		inode_set_flags(inode, S_ENCRYPTED, S_ENCRYPTED);
>>>>>> +	}
>>>>> I think we also need to free iinfo->fscrypt_auth here if ci->fscrypt_auth
>>>>> is already set.  Something like:
>>>>>
>>>>> 	if (iinfo->fscrypt_auth_len) {
>>>>> 		if (!ci->fscrypt_auth) {
>>>>> 			...
>>>>> 		} else {
>>>>> 			kfree(iinfo->fscrypt_auth);
>>>>> 			iinfo->fscrypt_auth = NULL;
>>>>> 		}
>>>>> 	}
>>>>>
>>>> IMO, this should be okay because it will be freed in
>>>> destroy_reply_info() when putting the request.
>>>>
>>>>
>>> Yes. All of that should get cleaned up with the request.
>> Hmm... ok, so maybe I missed something because I *did* saw kmemleak
>> complaining.  Maybe it was on the READDIR path.  /me goes look again.
> Ah, that was indeed the problem.  So, here's a quick hack to fix
> destroy_reply_info() so that it also frees the extra memory from READDIR:
>
> @@ -686,12 +686,23 @@ static int parse_reply_info(struct ceph_mds_session *s, struct ceph_msg *msg,
>   
>   static void destroy_reply_info(struct ceph_mds_reply_info_parsed *info)
>   {
> +	int i = 0;
> +
>   	kfree(info->diri.fscrypt_auth);
>   	kfree(info->diri.fscrypt_file);
>   	kfree(info->targeti.fscrypt_auth);
>   	kfree(info->targeti.fscrypt_file);
>   	if (!info->dir_entries)
>   		return;
> +
> +	for (i = 0; i < info->dir_nr; i++) {
> +		struct ceph_mds_reply_dir_entry *rde = info->dir_entries + i;
> +		if (rde->inode.fscrypt_auth_len)
> +			kfree(rde->inode.fscrypt_auth);
> +	}
> +	
>   	free_pages((unsigned long)info->dir_entries, get_order(info->dir_buf_size));
>   }
>   

Yeah, this looks nice.


> Cheers,
> --
> Luís
>

