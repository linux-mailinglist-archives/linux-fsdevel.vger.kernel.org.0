Return-Path: <linux-fsdevel+bounces-59027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E79B33F76
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 14:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4DAC3BACCA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 12:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E28347DD;
	Mon, 25 Aug 2025 12:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asnTvS4p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B940F1DA21
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 12:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756125161; cv=none; b=j2mV1TslAinUvjfKDU2L7JT3Iy9ipY5s6nROPVFIvT8s0gQxvHcXQnDoLmnxD6u5OfIaftwmc/+fwbDfttvG9Qbi7hvdkhv833xlRwRQZXDz/+sO+69wLFz+XSQrEuk6iQ7EQNBPYwOwMH2TyuljZfyjAUXQXpIMw4SHxkU38qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756125161; c=relaxed/simple;
	bh=L2RwcPdyUajxTheANUY/nHcCljHJGEFxuKskgIreWWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QsiwJ3ZdZY0RJw+tb2Qzn5pAlvCpgcVwdh8CMKo7+WFQOget+axI1ydv0Mz0MBQyfbs/wYB75AZAALiGUu8s8d9Q+jfC+ZADCpUNFz1ipcBairUqxRvI4JHFCXIPRC4tbL2OKoxnPZlCo5YCRXwusol6R8xmDrGhGz4N2mTJyuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asnTvS4p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 293ABC4CEED;
	Mon, 25 Aug 2025 12:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756125161;
	bh=L2RwcPdyUajxTheANUY/nHcCljHJGEFxuKskgIreWWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=asnTvS4pfBYnp12LE2oZWvbyiGCzXMW8vQDM9p7ckyV9qNw/4EEsbx46Lybj1cbu/
	 qdpJ5H25SmDsv2C18cCBDUKFKfel36USgNXX7BVZH0V8QSq1SSyU/fc/0h5P+UZ2Zz
	 HHdA5e3o1wwiBBVMSRT+v2fk9HBE8eqlKkSQePExgy5YHNqnmEHYfejK8jynomJgNw
	 2cova5QeqdcstwfreP9Nsyacc2zPHCexQE/uazPr1/ptn7j9ovhxgTD1i0rec43vNo
	 wIhQnnAcePcJLnleN2Fkp2abL8dSLDcnofNYmUZsAJhMtJmAaB8TRcTGLru+mrhAZi
	 k5xiIfw0PgVqQ==
Date: Mon, 25 Aug 2025 14:32:38 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 02/52] introduced guards for mount_lock
Message-ID: <20250825-repressiv-selektiert-7496db0b38aa@brauner>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-2-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825044355.1541941-2-viro@zeniv.linux.org.uk>

On Mon, Aug 25, 2025 at 05:43:05AM +0100, Al Viro wrote:
> mount_writer: write_seqlock; that's an equivalent of {un,}lock_mount_hash()
> mount_locked_reader: read_seqlock_excl; these tend to be open-coded.

Do we really need the "locked" midfix in there? Doesn't seem to buy any
clarity. I'd drop it so the naming is nicely consistent.

> 
> No bulk conversions, please - if nothing else, quite a few places take
> use mount_writer form when mount_locked_reader is sufficent.  It needs
> to be dealt with carefully.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/mount.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/mount.h b/fs/mount.h
> index 97737051a8b9..ed8c83ba836a 100644
> --- a/fs/mount.h
> +++ b/fs/mount.h
> @@ -154,6 +154,11 @@ static inline void get_mnt_ns(struct mnt_namespace *ns)
>  
>  extern seqlock_t mount_lock;
>  
> +DEFINE_LOCK_GUARD_0(mount_writer, write_seqlock(&mount_lock),
> +		    write_sequnlock(&mount_lock))
> +DEFINE_LOCK_GUARD_0(mount_locked_reader, read_seqlock_excl(&mount_lock),
> +		    read_sequnlock_excl(&mount_lock))
> +
>  struct proc_mounts {
>  	struct mnt_namespace *ns;
>  	struct path root;
> -- 
> 2.47.2
> 

