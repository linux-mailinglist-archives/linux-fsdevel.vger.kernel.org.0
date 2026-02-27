Return-Path: <linux-fsdevel+bounces-78800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDtBIDMYomnFzAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 23:18:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F35871BE9E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 23:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B52E30F4DE9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 22:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C2F47AF4B;
	Fri, 27 Feb 2026 22:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tyqKuMvr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0816F47885E;
	Fri, 27 Feb 2026 22:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772230457; cv=none; b=okBboY9CmpEdCJXYYsnLDMUJyBAFiTh3La4GW6T1SYOUzz3Klp2tYMdLANIoUbM1RHotl1LeaflOTR0UVlZllIwQfQA/ggTbYzhSIRTNINhwKew0vEo9iJc8uhsiKZ4tL+IaowvDDJFOvA51J4r+JUP2ZpPOJQe/fJuuVMUJZ48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772230457; c=relaxed/simple;
	bh=OD9oM6xqU6NcK9zlUrfSd+7wx83iqogpQIBAUAduYSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VySx2KLJayCBjdCdkhshLFvyPwMjhXYFyf2giahy62vuat4SbQI7XC8TcKp7eAJQDUXqUUphq0TjAN8LWhmn4BLXg0t4c8n8b+jjOPt8YvgXjybwx7J5Vjj7KPqpJneCIzMCBkcVcRQkvYpuZDbWu//iJxFymblvifVxT7faRDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tyqKuMvr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFCE9C116C6;
	Fri, 27 Feb 2026 22:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772230456;
	bh=OD9oM6xqU6NcK9zlUrfSd+7wx83iqogpQIBAUAduYSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tyqKuMvr51Qkoml64Qyp4F8Ma7FFI+z8svHFeouAYinZsgE5PNzQTA3y28z18H28f
	 d8+JB9T0Fxcbn1+HYY5/xeHIFunPegfIRfOoA04ofFGMGci6HrwF5gaPfHMubj0jeO
	 3xC72d40oRLht6Bwd1h/Gbw99LA3Dw6Rq2MTtvshe9Yoxkkc3XDJefW6XjWZR3k10T
	 bwW3gjN5X0CnvimEKtB/wtWXQMsL+jJ6N4QhiMoDRHhP3zEaoPd9RLAqb+InSM0OFl
	 r8zEwF2jDDfgW5Lux5bhA4s9kNHAMg9KUDG+T8vKuatb+780bP0tjCqJ+2lP7DZO5e
	 x88q/wjbE/B+A==
Date: Fri, 27 Feb 2026 14:14:09 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Chao Yu <chao@kernel.org>, Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 12/14] fscrypt: pass a byte length to
 fscrypt_zeroout_range
Message-ID: <20260227221409.GB5357@quark>
References: <20260226144954.142278-1-hch@lst.de>
 <20260226144954.142278-13-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226144954.142278-13-hch@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78800-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F35871BE9E9
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 06:49:32AM -0800, Christoph Hellwig wrote:
>  static int fscrypt_zeroout_range_inline_crypt(const struct inode *inode,
>  					      loff_t pos, sector_t sector,
> -					      unsigned int len)
> +					      u64 len)

This hunk should go in the "pass a byte length to
fscrypt_zeroout_range_inline_crypt" patch.

>   * @inode: the file's inode
>   * @pos: the first file position (in bytes) to zero out
>   * @pblk: the first filesystem physical block to zero out
> - * @len: number of blocks to zero out
> + * @len: bytes to zero out

Should document that 'len' must be a multiple of the filesystem block
size

> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 945613c95ffa..675ef741cb30 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -406,7 +406,8 @@ int ext4_issue_zeroout(struct inode *inode, ext4_lblk_t lblk, ext4_fsblk_t pblk,
>  
>  	if (IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode))
>  		return fscrypt_zeroout_range(inode,
> -				(loff_t)lblk << inode->i_blkbits, pblk, len);
> +				(loff_t)lblk << inode->i_blkbits, pblk,
> +				len << inode->i_blkbits);
>  
>  	ret = sb_issue_zeroout(inode->i_sb, pblk, len, GFP_NOFS);
>  	if (ret > 0)
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 239c2666ceb5..5b7013f7f6a1 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -4164,7 +4164,7 @@ static int f2fs_secure_erase(struct block_device *bdev, struct inode *inode,
>  		if (IS_ENCRYPTED(inode))
>  			ret = fscrypt_zeroout_range(inode,
>  					(loff_t)off << inode->i_blkbits, block,
> -					len);
> +					len << inode->i_blkbits);

The two callers should cast len to u64 before shifting it by i_blkbits.

- Eric

