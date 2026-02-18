Return-Path: <linux-fsdevel+bounces-77626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GBkGhsylmktcAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 22:41:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCC515A520
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 22:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C1A9F301D4C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 21:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089DC2F39AB;
	Wed, 18 Feb 2026 21:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4Of8Yqh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9EE2ECEA3;
	Wed, 18 Feb 2026 21:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771450899; cv=none; b=WHPwQ7Ilq0sygjhtSJUYVGga/cXMGn7JVKzOHya60TTULl8yANtnj34uqYJvCd9vlwI9txVB5Uo3uFJDw3xz0Fc6znANfsLXPQA4KC3VVUYOnVxOL8N118t/ClnHGX+bsFkxOIU+KIrVpRkBNIWxolwBPuAOfBCsFyNrtEnZpjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771450899; c=relaxed/simple;
	bh=RFNByzUvaO7u/JH30zuOuIX6qfJNT+tkJE4Yzso8fZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vyk1HYVHNYVTesHh2JZfwJtgL6eISjQICUWyNDbMdj1FjWYAVkOqbrGgD6SSuCMBYNYl+V3T+wNSORuGqe87ZLfSZXkFj5ryf9v0X9UejrkVVEH4pJUIHv2em3ZhaRfEBzvOwrp2BCuPKoINWSCOxRZoByW76Y9Yz+5An8MZyFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4Of8Yqh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C704C116D0;
	Wed, 18 Feb 2026 21:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771450899;
	bh=RFNByzUvaO7u/JH30zuOuIX6qfJNT+tkJE4Yzso8fZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m4Of8YqhzIVyWXNu6Hwkb5MEEgEcCMgafizlvxIB3AJDAkQifU6GyUCV/Mg9leJCU
	 SmG+YK3+ri51vIUo9GtpOiBdXMca/kXqIr2jsDHCYeEQ9o5S87jveALWqXtfM9zV7o
	 u+nQCnB7P6Zp0b1CSTNMPe5gC8nYbO62VRsA/ktouhUwOpbNZQq2IvZ8diD9K/NA+w
	 bdkTkW7G6HRSD/nyXx5dGcDyd/PiZtZ2GU/ttb5xxyf6LNxc/rABJhLfqyPb6ZlBUQ
	 EJig6T4tOvJ3B1T23GYBIiKaOC/Oz9gs2tXQ0KRiF+YijViCB8CvtYrsf874DU20Di
	 uXyKaLnlTlX8A==
Date: Wed, 18 Feb 2026 13:41:38 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, ebiggers@kernel.org, hch@lst.de
Subject: Re: [PATCH v3 02/35] fsverity: expose ensure_fsverity_info()
Message-ID: <20260218214138.GB6467@frogsfrogsfrogs>
References: <20260217231937.1183679-1-aalbersh@kernel.org>
 <20260217231937.1183679-3-aalbersh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217231937.1183679-3-aalbersh@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77626-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 2CCC515A520
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 12:19:02AM +0100, Andrey Albershteyn wrote:
> This function will be used by XFS's scrub to force fsverity activation,
> therefore, to read fsverity context.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>

Looks fine to me
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/verity/open.c         | 5 +++--
>  include/linux/fsverity.h | 7 +++++++
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/verity/open.c b/fs/verity/open.c
> index dfa0d1afe0fe..0483db672526 100644
> --- a/fs/verity/open.c
> +++ b/fs/verity/open.c
> @@ -344,7 +344,7 @@ int fsverity_get_descriptor(struct inode *inode,
>  	return 0;
>  }
>  
> -static int ensure_verity_info(struct inode *inode)
> +int fsverity_ensure_verity_info(struct inode *inode)
>  {
>  	struct fsverity_info *vi = fsverity_get_info(inode), *found;
>  	struct fsverity_descriptor *desc;
> @@ -380,12 +380,13 @@ static int ensure_verity_info(struct inode *inode)
>  	kfree(desc);
>  	return err;
>  }
> +EXPORT_SYMBOL_GPL(fsverity_ensure_verity_info);
>  
>  int __fsverity_file_open(struct inode *inode, struct file *filp)
>  {
>  	if (filp->f_mode & FMODE_WRITE)
>  		return -EPERM;
> -	return ensure_verity_info(inode);
> +	return fsverity_ensure_verity_info(inode);
>  }
>  EXPORT_SYMBOL_GPL(__fsverity_file_open);
>  
> diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
> index d8b581e3ce48..16740a331020 100644
> --- a/include/linux/fsverity.h
> +++ b/include/linux/fsverity.h
> @@ -202,6 +202,7 @@ int fsverity_get_digest(struct inode *inode,
>  /* open.c */
>  
>  int __fsverity_file_open(struct inode *inode, struct file *filp);
> +int fsverity_ensure_verity_info(struct inode *inode);
>  
>  /* read_metadata.c */
>  
> @@ -288,6 +289,12 @@ static inline void fsverity_enqueue_verify_work(struct work_struct *work)
>  	WARN_ON_ONCE(1);
>  }
>  
> +static inline int fsverity_ensure_verity_info(struct inode *inode)
> +{
> +	WARN_ON_ONCE(1);
> +	return -EOPNOTSUPP;
> +}
> +
>  #endif	/* !CONFIG_FS_VERITY */
>  
>  static inline bool fsverity_verify_folio(struct fsverity_info *vi,
> -- 
> 2.51.2
> 
> 

