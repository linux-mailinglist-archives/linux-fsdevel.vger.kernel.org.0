Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D264B9AD4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Feb 2022 09:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237495AbiBQIZg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Feb 2022 03:25:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237483AbiBQIZg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Feb 2022 03:25:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A689E298ACE
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Feb 2022 00:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645086320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MNXmWL/SfUW4dVBb5/T3bnYmxC5N+BjlH2+TCW/Y10w=;
        b=N8d9lXubX6xFFXtTmIN7oDV1Lr8rkEOjVEJdFvDzGBaU3z5GflajddNRU774MuESx5/eJi
        ShYXjbIxdQRO/9bFGcrQhFKoez+RKv0xsQdXAq0+PIIEv2y5p1O4bu3MpjJ++kzxRrsFMh
        aRBVmYvJjmg/x10rNGYYU4b7wWOBXXw=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-j42_jEpSM8iSw2_le2Jt4g-1; Thu, 17 Feb 2022 03:25:19 -0500
X-MC-Unique: j42_jEpSM8iSw2_le2Jt4g-1
Received: by mail-pg1-f197.google.com with SMTP id m15-20020a63580f000000b00370dc6cafe9so2609613pgb.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Feb 2022 00:25:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=MNXmWL/SfUW4dVBb5/T3bnYmxC5N+BjlH2+TCW/Y10w=;
        b=DWzCQ+XPC8n70ftxsyE7Svqwyg5uZ23rgs82qN84B8ggWtPWOFcuMfS6bacmszG2dB
         EZpixdHbzqXj1VCAQwckfympmO/dQvSrHKOTtDAnnnyrOhDI4IsMYQ54dCy/1iliiEn/
         b70AzdiLNIjxwxWmngQ9OYr6sMXwZSEzaWjLAJVozzSUByJh6JJkNuCXwGBrsahCa1nk
         XfT5wQgTaQELs0TNsf2v/+kIeXWLd8oaNoyLWAVmHrS5Ei85y+pgqhsVFa76Yh3Ea1/c
         jo/H/O6a08LsHeS70kNxnDjRLS0mRIGJ6SzjwyEqw7Kk1l7GANBK7D9lDGB4vV6TrhBY
         bHWg==
X-Gm-Message-State: AOAM533zk6EPyxYt+fA/1m1SclSftNpDBGSNRVKjFCrW0lLoTb9UPVRK
        3r22i46s3+y5Z8Qd+ibsRqNJM0gl85x3I2pZY6qtXgmkE5DFCe0PA/FVBaKRlLdWk+x/L0vnQW+
        45Dc+0KY0rtkSIwvsXb7V41yrxQ==
X-Received: by 2002:a17:902:c789:b0:14d:ae35:1ac3 with SMTP id w9-20020a170902c78900b0014dae351ac3mr1846590pla.64.1645086317942;
        Thu, 17 Feb 2022 00:25:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwJjVop5oVlB4G5J7rhADXql8UHMMeFrOvqL59GK0Glm51F/el9byJR8fLQTm0LUpfT4aR2Jg==
X-Received: by 2002:a17:902:c789:b0:14d:ae35:1ac3 with SMTP id w9-20020a170902c78900b0014dae351ac3mr1846580pla.64.1645086317633;
        Thu, 17 Feb 2022 00:25:17 -0800 (PST)
Received: from [10.72.12.153] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j15sm49753108pfj.102.2022.02.17.00.25.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 00:25:17 -0800 (PST)
Subject: Re: [RFC PATCH v10 07/48] ceph: parse new fscrypt_auth and
 fscrypt_file fields in inode traces
To:     Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, idryomov@gmail.com
References: <20220111191608.88762-1-jlayton@kernel.org>
 <20220111191608.88762-8-jlayton@kernel.org>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <4faa6b1e-1e64-da2e-f722-0fc75fec51b7@redhat.com>
Date:   Thu, 17 Feb 2022 16:25:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220111191608.88762-8-jlayton@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 1/12/22 3:15 AM, Jeff Layton wrote:
> ...and store them in the ceph_inode_info.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>   fs/ceph/file.c       |  2 ++
>   fs/ceph/inode.c      | 18 ++++++++++++++-
>   fs/ceph/mds_client.c | 55 ++++++++++++++++++++++++++++++++++++++++++++
>   fs/ceph/mds_client.h |  4 ++++
>   fs/ceph/super.h      |  6 +++++
>   5 files changed, 84 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index ace72a052254..5937a25ddddd 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -597,6 +597,8 @@ static int ceph_finish_async_create(struct inode *dir, struct inode *inode,
>   	iinfo.xattr_data = xattr_buf;
>   	memset(iinfo.xattr_data, 0, iinfo.xattr_len);
>   
> +	/* FIXME: set fscrypt_auth and fscrypt_file */
> +
>   	in.ino = cpu_to_le64(vino.ino);
>   	in.snapid = cpu_to_le64(CEPH_NOSNAP);
>   	in.version = cpu_to_le64(1);	// ???
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 649d7a059d7b..d090fe081093 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -609,7 +609,10 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
>   	INIT_WORK(&ci->i_work, ceph_inode_work);
>   	ci->i_work_mask = 0;
>   	memset(&ci->i_btime, '\0', sizeof(ci->i_btime));
> -
> +#ifdef CONFIG_FS_ENCRYPTION
> +	ci->fscrypt_auth = NULL;
> +	ci->fscrypt_auth_len = 0;
> +#endif
>   	ceph_fscache_inode_init(ci);
>   
>   	return &ci->vfs_inode;
> @@ -620,6 +623,9 @@ void ceph_free_inode(struct inode *inode)
>   	struct ceph_inode_info *ci = ceph_inode(inode);
>   
>   	kfree(ci->i_symlink);
> +#ifdef CONFIG_FS_ENCRYPTION
> +	kfree(ci->fscrypt_auth);
> +#endif
>   	kmem_cache_free(ceph_inode_cachep, ci);
>   }
>   
> @@ -1020,6 +1026,16 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
>   		xattr_blob = NULL;
>   	}
>   
> +#ifdef CONFIG_FS_ENCRYPTION
> +	if (iinfo->fscrypt_auth_len && !ci->fscrypt_auth) {
> +		ci->fscrypt_auth_len = iinfo->fscrypt_auth_len;
> +		ci->fscrypt_auth = iinfo->fscrypt_auth;
> +		iinfo->fscrypt_auth = NULL;
> +		iinfo->fscrypt_auth_len = 0;
> +		inode_set_flags(inode, S_ENCRYPTED, S_ENCRYPTED);
> +	}
> +#endif
> +
>   	/* finally update i_version */
>   	if (le64_to_cpu(info->version) > ci->i_version)
>   		ci->i_version = le64_to_cpu(info->version);
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 57cf21c9199f..bd824e989449 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -184,8 +184,50 @@ static int parse_reply_info_in(void **p, void *end,
>   			info->rsnaps = 0;
>   		}
>   
> +		if (struct_v >= 5) {
> +			u32 alen;
> +
> +			ceph_decode_32_safe(p, end, alen, bad);
> +
> +			while (alen--) {
> +				u32 len;
> +
> +				/* key */
> +				ceph_decode_32_safe(p, end, len, bad);
> +				ceph_decode_skip_n(p, end, len, bad);
> +				/* value */
> +				ceph_decode_32_safe(p, end, len, bad);
> +				ceph_decode_skip_n(p, end, len, bad);
> +			}
> +		}
> +
> +		/* fscrypt flag -- ignore */
> +		if (struct_v >= 6)
> +			ceph_decode_skip_8(p, end, bad);
> +
> +		info->fscrypt_auth = NULL;
> +		info->fscrypt_file = NULL;

The 'fscrypt_auth_len' and 'fscrypt_file_len' should also be reset here. 
Or we will hit the issue I mentioned as bellow:


cp: cannot access './dir___683': No buffer space available
cp: cannot access './dir___686': No buffer space available

The dmesg logs:

<7>[ 1256.918250] ceph:  readdir 0000000089964a71 file 00000000065cb689
pos 0
<7>[ 1256.918254] ceph:  readdir off 0 -> '.'
<7>[ 1256.918258] ceph:  readdir off 1 -> '..'
<4>[ 1256.918262] fscrypt (ceph, inode 1099511630270): Error -105
getting encryption context
<7>[ 1256.918269] ceph:  readdir 0000000089964a71 file 00000000065cb689
pos 2
<4>[ 1256.918273] fscrypt (ceph, inode 1099511630270): Error -105
getting encryption context


This can be reproduced when using an old ceph cluster without fscrypt 
support.

And also I have sent out one fix to zero the memory when allocating it 
in ceph_readdir() to fix the potential bug like this.

Thanks

BRs

-- Xiubo


> +		if (struct_v >= 7) {
> +			ceph_decode_32_safe(p, end, info->fscrypt_auth_len, bad);
> +			if (info->fscrypt_auth_len) {
> +				info->fscrypt_auth = kmalloc(info->fscrypt_auth_len, GFP_KERNEL);
> +				if (!info->fscrypt_auth)
> +					return -ENOMEM;
> +				ceph_decode_copy_safe(p, end, info->fscrypt_auth,
> +						      info->fscrypt_auth_len, bad);
> +			}
> +			ceph_decode_32_safe(p, end, info->fscrypt_file_len, bad);
> +			if (info->fscrypt_file_len) {
> +				info->fscrypt_file = kmalloc(info->fscrypt_file_len, GFP_KERNEL);
> +				if (!info->fscrypt_file)
> +					return -ENOMEM;
> +				ceph_decode_copy_safe(p, end, info->fscrypt_file,
> +						      info->fscrypt_file_len, bad);
> +			}
> +		}
>   		*p = end;
>   	} else {
> +		/* legacy (unversioned) struct */
>   		if (features & CEPH_FEATURE_MDS_INLINE_DATA) {
>   			ceph_decode_64_safe(p, end, info->inline_version, bad);
>   			ceph_decode_32_safe(p, end, info->inline_len, bad);
> @@ -626,8 +668,21 @@ static int parse_reply_info(struct ceph_mds_session *s, struct ceph_msg *msg,
>   
>   static void destroy_reply_info(struct ceph_mds_reply_info_parsed *info)
>   {
> +	int i;
> +
> +	kfree(info->diri.fscrypt_auth);
> +	kfree(info->diri.fscrypt_file);
> +	kfree(info->targeti.fscrypt_auth);
> +	kfree(info->targeti.fscrypt_file);
>   	if (!info->dir_entries)
>   		return;
> +
> +	for (i = 0; i < info->dir_nr; i++) {
> +		struct ceph_mds_reply_dir_entry *rde = info->dir_entries + i;
> +
> +		kfree(rde->inode.fscrypt_auth);
> +		kfree(rde->inode.fscrypt_file);
> +	}
>   	free_pages((unsigned long)info->dir_entries, get_order(info->dir_buf_size));
>   }
>   
> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> index c3986a412fb5..98a8710807d1 100644
> --- a/fs/ceph/mds_client.h
> +++ b/fs/ceph/mds_client.h
> @@ -88,6 +88,10 @@ struct ceph_mds_reply_info_in {
>   	s32 dir_pin;
>   	struct ceph_timespec btime;
>   	struct ceph_timespec snap_btime;
> +	u8 *fscrypt_auth;
> +	u8 *fscrypt_file;
> +	u32 fscrypt_auth_len;
> +	u32 fscrypt_file_len;
>   	u64 rsnaps;
>   	u64 change_attr;
>   };
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index 532ee9fca878..5b4092e5f291 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -433,6 +433,12 @@ struct ceph_inode_info {
>   	struct work_struct i_work;
>   	unsigned long  i_work_mask;
>   
> +#ifdef CONFIG_FS_ENCRYPTION
> +	u32 fscrypt_auth_len;
> +	u32 fscrypt_file_len;
> +	u8 *fscrypt_auth;
> +	u8 *fscrypt_file;
> +#endif
>   #ifdef CONFIG_CEPH_FSCACHE
>   	struct fscache_cookie *fscache;
>   #endif

