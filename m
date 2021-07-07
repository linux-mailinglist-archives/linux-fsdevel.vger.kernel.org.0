Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC9F33BE695
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 12:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbhGGKuJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jul 2021 06:50:09 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:46912 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbhGGKuI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jul 2021 06:50:08 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CF20D22676;
        Wed,  7 Jul 2021 10:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625654847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b+ZNpyW3mTm4xb7QWvEqYi4VYBkrRejmyJLY7SNou9w=;
        b=vrgwdtWAeSf/v3CyToGNNcNhPX1skFWjxMo/TCPUXxFnzHKEeo5CHhghwN4ZtL34Coaj8P
        lTLBbNKn7m7+zRr13dYXtytw1R1Ld4L87v9chcecGMh80KM+CqNvp0gziGwXvL4PfMg+fO
        w0r0SOCRma3r6OiK7ApoOhelwl845Vo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625654847;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b+ZNpyW3mTm4xb7QWvEqYi4VYBkrRejmyJLY7SNou9w=;
        b=XobARY9+TvJ8LYcHKubAbJ5L5wyelEZsSFzfBSVqmDwfLdYUx4Z+S0PkCRPmdVsAFwUGwl
        EsNS6EKTkEawKUAA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 687F613966;
        Wed,  7 Jul 2021 10:47:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id m7BvFj+G5WBlWQAAGKfGzw
        (envelope-from <lhenriques@suse.de>); Wed, 07 Jul 2021 10:47:27 +0000
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id 8db1c0ce;
        Wed, 7 Jul 2021 10:47:26 +0000 (UTC)
Date:   Wed, 7 Jul 2021 11:47:26 +0100
From:   Luis Henriques <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, xiubli@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        dhowells@redhat.com
Subject: Re: [RFC PATCH v7 06/24] ceph: parse new fscrypt_auth and
 fscrypt_file fields in inode traces
Message-ID: <YOWGPv099N7EsMVA@suse.de>
References: <20210625135834.12934-1-jlayton@kernel.org>
 <20210625135834.12934-7-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210625135834.12934-7-jlayton@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 25, 2021 at 09:58:16AM -0400, Jeff Layton wrote:
> ...and store them in the ceph_inode_info.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/ceph/file.c       |  2 ++
>  fs/ceph/inode.c      | 18 ++++++++++++++++++
>  fs/ceph/mds_client.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  fs/ceph/mds_client.h |  4 ++++
>  fs/ceph/super.h      |  6 ++++++
>  5 files changed, 74 insertions(+)
> 
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 2cda398ba64d..ea0e85075b7b 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -592,6 +592,8 @@ static int ceph_finish_async_create(struct inode *dir, struct inode *inode,
>  	iinfo.xattr_data = xattr_buf;
>  	memset(iinfo.xattr_data, 0, iinfo.xattr_len);
>  
> +	/* FIXME: set fscrypt_auth and fscrypt_file */
> +
>  	in.ino = cpu_to_le64(vino.ino);
>  	in.snapid = cpu_to_le64(CEPH_NOSNAP);
>  	in.version = cpu_to_le64(1);	// ???
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index f62785e4dbcb..b620281ea65b 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -611,6 +611,13 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
>  
>  	ci->i_meta_err = 0;
>  
> +#ifdef CONFIG_FS_ENCRYPTION
> +	ci->fscrypt_auth = NULL;
> +	ci->fscrypt_auth_len = 0;
> +	ci->fscrypt_file = NULL;
> +	ci->fscrypt_file_len = 0;
> +#endif
> +
>  	return &ci->vfs_inode;
>  }
>  
> @@ -619,6 +626,9 @@ void ceph_free_inode(struct inode *inode)
>  	struct ceph_inode_info *ci = ceph_inode(inode);
>  
>  	kfree(ci->i_symlink);
> +#ifdef CONFIG_FS_ENCRYPTION
> +	kfree(ci->fscrypt_auth);
> +#endif
>  	kmem_cache_free(ceph_inode_cachep, ci);
>  }
>  
> @@ -1021,6 +1031,14 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
>  		xattr_blob = NULL;
>  	}
>  
> +	if (iinfo->fscrypt_auth_len && !ci->fscrypt_auth) {
> +		ci->fscrypt_auth_len = iinfo->fscrypt_auth_len;
> +		ci->fscrypt_auth = iinfo->fscrypt_auth;
> +		iinfo->fscrypt_auth = NULL;
> +		iinfo->fscrypt_auth_len = 0;
> +		inode_set_flags(inode, S_ENCRYPTED, S_ENCRYPTED);
> +	}

I think we also need to free iinfo->fscrypt_auth here if ci->fscrypt_auth
is already set.  Something like:

	if (iinfo->fscrypt_auth_len) {
		if (!ci->fscrypt_auth) {
			...
		} else {
			kfree(iinfo->fscrypt_auth);
			iinfo->fscrypt_auth = NULL;
		}
	}

> +
>  	/* finally update i_version */
>  	if (le64_to_cpu(info->version) > ci->i_version)
>  		ci->i_version = le64_to_cpu(info->version);
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 3b3a14024ca0..9c994effc51d 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -183,8 +183,48 @@ static int parse_reply_info_in(void **p, void *end,
>  			info->rsnaps = 0;
>  		}
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

As Xiubo already pointed out, there's a kfree(info->fscrypt_auth) missing
in this error path.

Cheers,
--
Luís

> +				ceph_decode_copy_safe(p, end, info->fscrypt_file,
> +						      info->fscrypt_file_len, bad);
> +			}
> +		}
>  		*p = end;
>  	} else {
> +		/* legacy (unversioned) struct */
>  		if (features & CEPH_FEATURE_MDS_INLINE_DATA) {
>  			ceph_decode_64_safe(p, end, info->inline_version, bad);
>  			ceph_decode_32_safe(p, end, info->inline_len, bad);
> @@ -625,6 +665,10 @@ static int parse_reply_info(struct ceph_mds_session *s, struct ceph_msg *msg,
>  
>  static void destroy_reply_info(struct ceph_mds_reply_info_parsed *info)
>  {
> +	kfree(info->diri.fscrypt_auth);
> +	kfree(info->diri.fscrypt_file);
> +	kfree(info->targeti.fscrypt_auth);
> +	kfree(info->targeti.fscrypt_file);
>  	if (!info->dir_entries)
>  		return;
>  	free_pages((unsigned long)info->dir_entries, get_order(info->dir_buf_size));
> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> index 64ea9d853b8d..0c3cc61fd038 100644
> --- a/fs/ceph/mds_client.h
> +++ b/fs/ceph/mds_client.h
> @@ -88,6 +88,10 @@ struct ceph_mds_reply_info_in {
>  	s32 dir_pin;
>  	struct ceph_timespec btime;
>  	struct ceph_timespec snap_btime;
> +	u8 *fscrypt_auth;
> +	u8 *fscrypt_file;
> +	u32 fscrypt_auth_len;
> +	u32 fscrypt_file_len;
>  	u64 rsnaps;
>  	u64 change_attr;
>  };
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index 0cd94b296f5f..e032737fe472 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -429,6 +429,12 @@ struct ceph_inode_info {
>  
>  #ifdef CONFIG_CEPH_FSCACHE
>  	struct fscache_cookie *fscache;
> +#endif
> +#ifdef CONFIG_FS_ENCRYPTION
> +	u32 fscrypt_auth_len;
> +	u32 fscrypt_file_len;
> +	u8 *fscrypt_auth;
> +	u8 *fscrypt_file;
>  #endif
>  	errseq_t i_meta_err;
>  
> -- 
> 2.31.1
> 
