Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39E553BE1A8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 05:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhGGD4T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jul 2021 23:56:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28410 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230019AbhGGD4T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jul 2021 23:56:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625630019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aW5zpXaFmNpnV5x7Sfss91jfyOF2qazIxL6RE+5ePV4=;
        b=Wpt0DnPKGaKfVuC+wMmrpS+2hwHzdfLAcNq4JYJPr/kkviymV3M1eQB9WW3AMQVTusnZA3
        XyDfO6Jnn41UlbcumI4qWn/bg/MSrAWhHw1ZmVQGTc0D4+dp7ijjm3N3MKB+V+jECM2GGQ
        zGxGsezEpoEOvgTagwwCpHddNXY9HgQ=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-4q3lU2XjOCCBT1KxqkgfDQ-1; Tue, 06 Jul 2021 23:53:37 -0400
X-MC-Unique: 4q3lU2XjOCCBT1KxqkgfDQ-1
Received: by mail-pl1-f200.google.com with SMTP id x15-20020a170902e04fb02900f5295925dbso324787plx.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jul 2021 20:53:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=aW5zpXaFmNpnV5x7Sfss91jfyOF2qazIxL6RE+5ePV4=;
        b=TZ0DJP4ICsna2rzPoUaDOoWUO96HMBzHearCsBngTMc5B33cwqkRa/KKBfko8CiPRp
         fSo1puaaK0gf+grD6JdirWsAaPMjYyeKe03VfbEfbmn1RkfIcL/lsnrVExxr473KNW95
         ANcxrD1lG8lMkH19H8mnYFONj1UJkU0DemO3SSg/8oNkN9np/YyM2T5R5FBXBRJG6FYK
         2bsrUBhdCBQObBESZlmEb988kjtCea2MX2lv2VzTDd6pVhpmhjym2lKaLKoj2WX93R/A
         RobwJMAh8XWhwEHTsBZ+x4SMYKhFWs5gTgdtkpKltuxW8+WaQK12b5tcQiSVeHLzphZH
         70dw==
X-Gm-Message-State: AOAM532d94VCUUW47z8pvVc+s6Kv/o5GpGTxJBm/3mWS6KIUB0WvTdV6
        eI6u7cao8ZleRrLChF8yOCFseUB/QmQxwxh6hOjIR4gkuhoy5FHGwYVKVo8x3v8Uhako+ZjdmDa
        un+0jkENsD6/jobvYHQ/Y2fE5dw==
X-Received: by 2002:aa7:959d:0:b029:31a:8c2c:e91d with SMTP id z29-20020aa7959d0000b029031a8c2ce91dmr20335764pfj.64.1625630016513;
        Tue, 06 Jul 2021 20:53:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwd5uGuLGXkPUtLvYJ78IiWsaRrR1/WuNAJQcD4sCmCQ2iF1ZWyCT1k/EMpWh8RWm5nvC5o/w==
X-Received: by 2002:aa7:959d:0:b029:31a:8c2c:e91d with SMTP id z29-20020aa7959d0000b029031a8c2ce91dmr20335750pfj.64.1625630016285;
        Tue, 06 Jul 2021 20:53:36 -0700 (PDT)
Received: from [10.72.13.191] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id k10sm3915932pfc.169.2021.07.06.20.53.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 20:53:35 -0700 (PDT)
Subject: Re: [RFC PATCH v7 06/24] ceph: parse new fscrypt_auth and
 fscrypt_file fields in inode traces
To:     Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org
Cc:     lhenriques@suse.de, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, dhowells@redhat.com
References: <20210625135834.12934-1-jlayton@kernel.org>
 <20210625135834.12934-7-jlayton@kernel.org>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <fbf80709-e87a-9334-45d7-9cca5726b037@redhat.com>
Date:   Wed, 7 Jul 2021 11:53:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210625135834.12934-7-jlayton@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 6/25/21 9:58 PM, Jeff Layton wrote:
> ...and store them in the ceph_inode_info.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>   fs/ceph/file.c       |  2 ++
>   fs/ceph/inode.c      | 18 ++++++++++++++++++
>   fs/ceph/mds_client.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>   fs/ceph/mds_client.h |  4 ++++
>   fs/ceph/super.h      |  6 ++++++
>   5 files changed, 74 insertions(+)
>
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 2cda398ba64d..ea0e85075b7b 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -592,6 +592,8 @@ static int ceph_finish_async_create(struct inode *dir, struct inode *inode,
>   	iinfo.xattr_data = xattr_buf;
>   	memset(iinfo.xattr_data, 0, iinfo.xattr_len);
>   
> +	/* FIXME: set fscrypt_auth and fscrypt_file */
> +
>   	in.ino = cpu_to_le64(vino.ino);
>   	in.snapid = cpu_to_le64(CEPH_NOSNAP);
>   	in.version = cpu_to_le64(1);	// ???
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index f62785e4dbcb..b620281ea65b 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -611,6 +611,13 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
>   
>   	ci->i_meta_err = 0;
>   
> +#ifdef CONFIG_FS_ENCRYPTION
> +	ci->fscrypt_auth = NULL;
> +	ci->fscrypt_auth_len = 0;
> +	ci->fscrypt_file = NULL;
> +	ci->fscrypt_file_len = 0;
> +#endif
> +
>   	return &ci->vfs_inode;
>   }
>   
> @@ -619,6 +626,9 @@ void ceph_free_inode(struct inode *inode)
>   	struct ceph_inode_info *ci = ceph_inode(inode);
>   
>   	kfree(ci->i_symlink);
> +#ifdef CONFIG_FS_ENCRYPTION
> +	kfree(ci->fscrypt_auth);
> +#endif
>   	kmem_cache_free(ceph_inode_cachep, ci);
>   }
>   
> @@ -1021,6 +1031,14 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
>   		xattr_blob = NULL;
>   	}
>   
> +	if (iinfo->fscrypt_auth_len && !ci->fscrypt_auth) {
> +		ci->fscrypt_auth_len = iinfo->fscrypt_auth_len;
> +		ci->fscrypt_auth = iinfo->fscrypt_auth;
> +		iinfo->fscrypt_auth = NULL;
> +		iinfo->fscrypt_auth_len = 0;
> +		inode_set_flags(inode, S_ENCRYPTED, S_ENCRYPTED);
> +	}
> +
>   	/* finally update i_version */
>   	if (le64_to_cpu(info->version) > ci->i_version)
>   		ci->i_version = le64_to_cpu(info->version);
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 3b3a14024ca0..9c994effc51d 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -183,8 +183,48 @@ static int parse_reply_info_in(void **p, void *end,
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

Should we kfree(info->fscrypt_auth) before return ?

I didn't anywhere is freeing it.

Thanks.


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
> @@ -625,6 +665,10 @@ static int parse_reply_info(struct ceph_mds_session *s, struct ceph_msg *msg,
>   
>   static void destroy_reply_info(struct ceph_mds_reply_info_parsed *info)
>   {
> +	kfree(info->diri.fscrypt_auth);
> +	kfree(info->diri.fscrypt_file);
> +	kfree(info->targeti.fscrypt_auth);
> +	kfree(info->targeti.fscrypt_file);
>   	if (!info->dir_entries)
>   		return;
>   	free_pages((unsigned long)info->dir_entries, get_order(info->dir_buf_size));
> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> index 64ea9d853b8d..0c3cc61fd038 100644
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
> index 0cd94b296f5f..e032737fe472 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -429,6 +429,12 @@ struct ceph_inode_info {
>   
>   #ifdef CONFIG_CEPH_FSCACHE
>   	struct fscache_cookie *fscache;
> +#endif
> +#ifdef CONFIG_FS_ENCRYPTION
> +	u32 fscrypt_auth_len;
> +	u32 fscrypt_file_len;
> +	u8 *fscrypt_auth;
> +	u8 *fscrypt_file;
>   #endif
>   	errseq_t i_meta_err;
>   

