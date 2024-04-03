Return-Path: <linux-fsdevel+bounces-15969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 884BD89637B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 06:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B960B1C2242D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 04:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6975544C97;
	Wed,  3 Apr 2024 04:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGYjykf8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DF445BE8;
	Wed,  3 Apr 2024 04:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712118306; cv=none; b=VDr0TSHAaQcayF/yVUbx5Vaxzmppd5QbDEr0YU0nDirnLnNyzpn/tmKwTTi9dZHS7Ns8nvF/+LesnEsdGnolmlS2LFq0BP4a1/oaZIBaARbuDKSAS7ZvillPlYoSfqEjZ/El0KWZbokWkaHtA8WKTvdAjQhkWWLmfWiAqTlf0c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712118306; c=relaxed/simple;
	bh=27PJXlFeNKBe1eRs9ajk0Z8dVhFuZhGUa2ciqtrxJUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KdwcOTmyUQ1ZXSEetz7vaRymd4K8kO+scz37ABv521GTJOVG1ASrym6N17rqXB1lJpCHrpZaRBsIMSz5le8q85H+SEjG5nsnI3+a8pCY7yaLURSSq2h22XXoavqiZtkQg8RsLFBzhLDuk+k64hSbs+VzAC3NceUEmsTzvTyteg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MGYjykf8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF21C433F1;
	Wed,  3 Apr 2024 04:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712118306;
	bh=27PJXlFeNKBe1eRs9ajk0Z8dVhFuZhGUa2ciqtrxJUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MGYjykf8xUP28dLNpzEOeR559qH0dVuXx3jUBB+lk0AIfsJnvkcw1Pf5A/BT202mS
	 acUS5SoH8R4mzo/QFfq6G99rBmCYCQ9F/68YTAglo5QE7bziXd5UvkseOWuVP/Zj5C
	 91UG4Ji4RybN/93qed4vwq5MCONqUjXbS6RrNT+QcStbTU7jtG36+joMPBrXSFbSOm
	 DMZFRm3d6FcZFHLalvIbdG13Ah2Rjk78vIpJAzducPLii76qp0D81wqKKOk2/C3h4k
	 IgxdL3btyLh1ZPZ6XTKhQ2vGy1li5WS6QekZ05HViueYLXjvpRtMW9BDIDQo6Ej794
	 A0e26cckwYECA==
Date: Tue, 2 Apr 2024 21:25:03 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	jaegeuk@kernel.org, chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, krisman@suse.de, brauner@kernel.org,
	jack@suse.cz, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
	kernel@collabora.com
Subject: Re: [f2fs-dev] [PATCH v15 7/9] f2fs: Log error when lookup of
 encoded dentry fails
Message-ID: <20240403042503.GI2576@sol.localdomain>
References: <20240402154842.508032-1-eugen.hristev@collabora.com>
 <20240402154842.508032-8-eugen.hristev@collabora.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402154842.508032-8-eugen.hristev@collabora.com>

On Tue, Apr 02, 2024 at 06:48:40PM +0300, Eugen Hristev via Linux-f2fs-devel wrote:
> If the volume is in strict mode, generi c_ci_compare can report a broken
> encoding name.  This will not trigger on a bad lookup, which is caught
> earlier, only if the actual disk name is bad.
> 
> Suggested-by: Gabriel Krisman Bertazi <krisman@suse.de>
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
> ---
>  fs/f2fs/dir.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index 88b0045d0c4f..64286d80dd30 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -192,11 +192,16 @@ static inline int f2fs_match_name(const struct inode *dir,
>  	struct fscrypt_name f;
>  
>  #if IS_ENABLED(CONFIG_UNICODE)
> -	if (fname->cf_name.name)
> -		return generic_ci_match(dir, fname->usr_fname,
> -					&fname->cf_name,
> -					de_name, de_name_len);
> -
> +	if (fname->cf_name.name) {
> +		int ret = generic_ci_match(dir, fname->usr_fname,
> +					   &fname->cf_name,
> +					   de_name, de_name_len);
> +		if (ret == -EINVAL)
> +			f2fs_warn(F2FS_SB(dir->i_sb),
> +				"Directory contains filename that is invalid UTF-8");
> +

Shouldn't this use f2fs_warn_ratelimited?

- Eric

