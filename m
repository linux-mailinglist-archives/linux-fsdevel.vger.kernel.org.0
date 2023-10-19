Return-Path: <linux-fsdevel+bounces-763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D0A7CFD13
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 16:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A9C2282210
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 14:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42472FE1B;
	Thu, 19 Oct 2023 14:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="s3/NkTWM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="F1DHfkkM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D732FE09
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 14:41:18 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9E710D3;
	Thu, 19 Oct 2023 07:41:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 45DEF21A60;
	Thu, 19 Oct 2023 14:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1697726473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=giUtDebGC6NH2VxVmcfSKNOmZ8T50HmB+uU52TrCw5s=;
	b=s3/NkTWMWcdC2YaKJScEK9z2CwoGs+34LvlukdkIbgzgmhJOypbE1F5tQu1CgN+e/SODY+
	yVM1R8TakTBTpd8Kfu2OTLsyN9BAX1DSvHWkTxLaygzz1TlA58landeXMwKmdDwBVUfQ+z
	+SOND7nf19WVZHBtjO0mIIyC6qnAt2k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1697726473;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=giUtDebGC6NH2VxVmcfSKNOmZ8T50HmB+uU52TrCw5s=;
	b=F1DHfkkMuiKq0YZfVvVhiGNdbjG3MziNMFeVI2cSYkIflSvXsylQXbT11Hg7y2BdnUJC+S
	cr2n8RuwMwCA3zCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 36F5E1357F;
	Thu, 19 Oct 2023 14:41:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 6ZJjDQlAMWXcCQAAMHmgww
	(envelope-from <jack@suse.cz>); Thu, 19 Oct 2023 14:41:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BA13FA06B0; Thu, 19 Oct 2023 16:41:12 +0200 (CEST)
Date: Thu, 19 Oct 2023 16:41:12 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 4/5] exportfs: define FILEID_INO64_GEN* file handle types
Message-ID: <20231019144112.anbgoixxe2aol5s6@quack3>
References: <20231018100000.2453965-1-amir73il@gmail.com>
 <20231018100000.2453965-5-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018100000.2453965-5-amir73il@gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -6.60
X-Spamd-Result: default: False [-6.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

On Wed 18-10-23 12:59:59, Amir Goldstein wrote:
> Similar to the common FILEID_INO32* file handle types, define common
> FILEID_INO64* file handle types.
> 
> The type values of FILEID_INO64_GEN and FILEID_INO64_GEN_PARENT are the
> values returned by fuse and xfs for 64bit ino encoded file handle types.
> 
> Note that these type value are filesystem specific and they do not define
> a universal file handle format, for example:
> fuse encodes FILEID_INO64_GEN as [ino-hi32,ino-lo32,gen] and xfs encodes
> FILEID_INO64_GEN as [hostr-order-ino64,gen] (a.k.a xfs_fid64).
> 
> The FILEID_INO64_GEN fhandle type is going to be used for file ids for
> fanotify from filesystems that do not support NFS export.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Yeah, better than the plain numbers. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fuse/inode.c          |  7 ++++---
>  include/linux/exportfs.h | 11 +++++++++++
>  2 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 2e4eb7cf26fb..e63f966698a5 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1002,7 +1002,7 @@ static int fuse_encode_fh(struct inode *inode, u32 *fh, int *max_len,
>  	}
>  
>  	*max_len = len;
> -	return parent ? 0x82 : 0x81;
> +	return parent ? FILEID_INO64_GEN_PARENT : FILEID_INO64_GEN;
>  }
>  
>  static struct dentry *fuse_fh_to_dentry(struct super_block *sb,
> @@ -1010,7 +1010,8 @@ static struct dentry *fuse_fh_to_dentry(struct super_block *sb,
>  {
>  	struct fuse_inode_handle handle;
>  
> -	if ((fh_type != 0x81 && fh_type != 0x82) || fh_len < 3)
> +	if ((fh_type != FILEID_INO64_GEN &&
> +	     fh_type != FILEID_INO64_GEN_PARENT) || fh_len < 3)
>  		return NULL;
>  
>  	handle.nodeid = (u64) fid->raw[0] << 32;
> @@ -1024,7 +1025,7 @@ static struct dentry *fuse_fh_to_parent(struct super_block *sb,
>  {
>  	struct fuse_inode_handle parent;
>  
> -	if (fh_type != 0x82 || fh_len < 6)
> +	if (fh_type != FILEID_INO64_GEN_PARENT || fh_len < 6)
>  		return NULL;
>  
>  	parent.nodeid = (u64) fid->raw[3] << 32;
> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index 6b6e01321405..21eeb9f6bdbd 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -98,6 +98,17 @@ enum fid_type {
>  	 */
>  	FILEID_FAT_WITH_PARENT = 0x72,
>  
> +	/*
> +	 * 64 bit inode number, 32 bit generation number.
> +	 */
> +	FILEID_INO64_GEN = 0x81,
> +
> +	/*
> +	 * 64 bit inode number, 32 bit generation number,
> +	 * 64 bit parent inode number, 32 bit parent generation.
> +	 */
> +	FILEID_INO64_GEN_PARENT = 0x82,
> +
>  	/*
>  	 * 128 bit child FID (struct lu_fid)
>  	 * 128 bit parent FID (struct lu_fid)
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

