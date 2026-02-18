Return-Path: <linux-fsdevel+bounces-77651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFeDGYxJlmngdQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 00:21:48 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6B115AE47
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 00:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D77F3035276
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 23:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE60033AD99;
	Wed, 18 Feb 2026 23:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9E7fm7W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3042C0F8E;
	Wed, 18 Feb 2026 23:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771456843; cv=none; b=DeHEaTxfM18JLOZKFyXkdFHQI7j0dGbebGYgFqgLUQ6omh+QSOqvqb2deHL6q18ngyo6kKFTZ4DPU9X32zS4JOG2h5UQFnPKBdPm86qwiE4m50FvRjXvwjiz0pds0+SIZNuV4QJKb+M/OiwNc9QipsqxdN+dNka3QjIQit0efzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771456843; c=relaxed/simple;
	bh=sO52637lZXxDYceUwX8KiN4AT6/Rr4T9XpCWaLK+Zd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iir39VkxW9+oaIRiIKWRUaG+Sj0TbuTF3LQ0Sx+zHIod9U46aTUrr6G2ew4aNhDF7q9kL2ESJ/WzSKMGsMMC5WQkob+AGHGYY6eCV+sfQOy7eQaxFg+yvZ4p3OiPTxNT+/ASIUdIZ6m/wHQcD8amVgwuA7oi1SUxJxYDp/UEKL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9E7fm7W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF16EC116D0;
	Wed, 18 Feb 2026 23:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771456843;
	bh=sO52637lZXxDYceUwX8KiN4AT6/Rr4T9XpCWaLK+Zd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y9E7fm7WSpl9Adm3jnVrW8BXWDIUhmrrbfIZ8nS5C+pXvz8bJdgSFrn6f6L/EGPfw
	 K4b/29QjeAYWuDVeWU5zNn5xYB7acOSQnwEc5VkRlqaenFzh/iGy7wHSdpvul2ef6Y
	 kqPQInsERqm6qBPgHC49r7ZplyNpx6ON5Z2IzOkdsBBne2IuppNYhJHD6z8oRdsIWs
	 3XVucAwM942AFdswnsx/0plaNOb5IQhrauq8Kmrue3ZCcCgDC3EgUJBKwF++WNcqGA
	 B+3bqgyWzY0CAPrfLFbBoTzyxRTuqgxUL2XMFclBb2cfxRoujWaSIsBiuMjOFclSBY
	 oyGjKhKEqN+kA==
Date: Wed, 18 Feb 2026 15:20:42 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, ebiggers@kernel.org, hch@lst.de
Subject: Re: [PATCH v3 25/35] xfs: add helpers to convert between pagecache
 and on-disk offset
Message-ID: <20260218232042.GM6467@frogsfrogsfrogs>
References: <20260217231937.1183679-1-aalbersh@kernel.org>
 <20260217231937.1183679-26-aalbersh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217231937.1183679-26-aalbersh@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77651-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 0F6B115AE47
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 12:19:25AM +0100, Andrey Albershteyn wrote:
> This helpers converts offset which XFS uses to store fsverity metadata
> on disk to the offset in the pagecache.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
>  fs/xfs/xfs_fsverity.c | 14 ++++++++++++++
>  fs/xfs/xfs_fsverity.h | 13 +++++++++++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/fs/xfs/xfs_fsverity.c b/fs/xfs/xfs_fsverity.c
> index 47add19a241e..4b918eb746d7 100644
> --- a/fs/xfs/xfs_fsverity.c
> +++ b/fs/xfs/xfs_fsverity.c
> @@ -8,6 +8,20 @@
>  #include "xfs_fsverity.h"
>  #include <linux/fsverity.h>
>  
> +loff_t
> +xfs_fsverity_offset_to_disk(struct xfs_inode *ip, loff_t offset)
> +{
> +	return (offset - fsverity_metadata_offset(VFS_I(ip))) |
> +	       XFS_FSVERITY_REGION_START;
> +}
> +
> +loff_t
> +xfs_fsverity_offset_from_disk(struct xfs_inode *ip, loff_t offset)

The type signatures here confused me.  The @offset parameter to
_from_disk is the ondisk file offset of fsverity metadata?  And we
return the ...  incore file offset of the fsverity metadata?

It's harder to be helpful when reviewing patches that add helpers
without actually using them.

I don't know if I should suggest that the input parameter should be a
different type altogether (xfs_fileoff_t?) because I can't see here how
the helper is used.

> +{
> +	return (offset ^ XFS_FSVERITY_REGION_START) +
> +	       fsverity_metadata_offset(VFS_I(ip));

This logic is a little obscure here; is this really just:

	offset - XFS_FSVERITY_REGION_START + fsverity_metadata_offset()
?

--D

> +}
> +
>  bool
>  xfs_fsverity_sealed_data(
>  	const struct xfs_inode	*ip,
> diff --git a/fs/xfs/xfs_fsverity.h b/fs/xfs/xfs_fsverity.h
> index 5fc55f42b317..6f3d60f010d8 100644
> --- a/fs/xfs/xfs_fsverity.h
> +++ b/fs/xfs/xfs_fsverity.h
> @@ -10,6 +10,8 @@
>  #ifdef CONFIG_FS_VERITY
>  bool xfs_fsverity_sealed_data(const struct xfs_inode *ip,
>  		loff_t offset);
> +loff_t xfs_fsverity_offset_to_disk(struct xfs_inode *ip, loff_t pos);
> +loff_t xfs_fsverity_offset_from_disk(struct xfs_inode *ip, loff_t offset);
>  #else
>  static inline loff_t xfs_fsverity_offset_to_disk(struct xfs_inode *ip,
>  						 loff_t pos)
> @@ -17,6 +19,17 @@ static inline loff_t xfs_fsverity_offset_to_disk(struct xfs_inode *ip,
>  	WARN_ON_ONCE(1);
>  	return ULLONG_MAX;
>  }
> +static inline loff_t xfs_fsverity_offset_from_disk(struct xfs_inode *ip,
> +						   loff_t offset)
> +{
> +	WARN_ON_ONCE(1);
> +	return ULLONG_MAX;
> +}
> +static inline bool xfs_fsverity_sealed_data(const struct xfs_inode *ip,
> +					    loff_t offset)
> +{
> +	return false;
> +}
>  #endif	/* CONFIG_FS_VERITY */
>  
>  #endif	/* __XFS_FSVERITY_H__ */
> -- 
> 2.51.2
> 
> 

