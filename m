Return-Path: <linux-fsdevel+bounces-55743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D67ADB0E48B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 22:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DADE77AAD2C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 20:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9CF283FE6;
	Tue, 22 Jul 2025 20:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLKeV47y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D500623B61D;
	Tue, 22 Jul 2025 20:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753214880; cv=none; b=uKmsLpGMOySBuFCNzx/EI4J7ZyLBze7lWu01IevcoS+nthvxr48HmG2ceyLmH9vV+8f3QjJESIO3pH7sGYhFvnYTadQf4xbHvNX2NOWjw9IbcoSwrfiU6knRTlYF5bhfk0cU/7elRG+KMHDIPQGQ4GoZD1U01X72rse4i0RsfUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753214880; c=relaxed/simple;
	bh=iaEEa49vrl691HjN7Mt89qt9cDri84fXV8lAJ8/mQ/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T60mQE771W7MlmaChJlg3cMXKbpj6k2de1MdjF9+PRbHdhnXPwd4kmMqGmcKO9JnpxB3n34M1U+3TJ37QryqTqJLKKEO4+4fJ52zNRG++KVggO+alCanFDN3TnyV1To6MqjbgyGJUuO9pna7obc8EaQqjGhZbeAUNohzemW6fmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLKeV47y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90ABCC4CEEB;
	Tue, 22 Jul 2025 20:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753214879;
	bh=iaEEa49vrl691HjN7Mt89qt9cDri84fXV8lAJ8/mQ/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nLKeV47ybBUHxDGr94Z30Tik1RRK1I7EOTKcDHBiiNHYOQze1ZEF0iHsZaVyDCrTc
	 GSKNqKoPGk+ME7Rnx+o4DADjUrIMKChSOwjmvJ6B6JTmMHFdrTnHVKPtRVKp3i6FTT
	 B8IfJsh2oASeUNUvoFau1BEDYeIdE/+SX6R4sFquGtxgDDtYmmyD6YRAFa5bTa/5dI
	 BXQgTiutLNmn68vDYJe/zbIysG/9YV9fhLVX9SdMQD3Nod4KQm6b82jyhgzleKtXuE
	 E5vFCKCG663q670tJyQ1UUIr6ucK6uFsOHYfmhfIyFVvnesev39j607FHf0dhDpiX9
	 q1PRQDkDY68/w==
Date: Tue, 22 Jul 2025 13:07:51 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>,
	"Theodore Y. Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH v3 03/13] ext4: move fscrypt to filesystem inode
Message-ID: <20250722200751.GB111676@quark>
References: <20250722-work-inode-fscrypt-v3-0-bdc1033420a0@kernel.org>
 <20250722-work-inode-fscrypt-v3-3-bdc1033420a0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722-work-inode-fscrypt-v3-3-bdc1033420a0@kernel.org>

On Tue, Jul 22, 2025 at 09:27:21PM +0200, Christian Brauner wrote:
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 18373de980f2..f27d57aea316 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1197,6 +1197,10 @@ struct ext4_inode_info {
>  	__u32 i_csum_seed;
>  
>  	kprojid_t i_projid;
> +
> +#ifdef CONFIG_FS_ENCRYPTION
> +	struct fscrypt_inode_info	*i_fscrypt_info;
> +#endif

Did you consider keeping the name as i_crypt_info instead of changing it
to i_fscrypt_info?  The rationale for i_crypt_info in the first place is
that it's filesystem code, so fs is implied.

I see you also had to replace i_crypt_info with i_fscrypt_info in a
bunch of comments.  It might make more sense to rephrase those to not
refer to the exact field name.  E.g. instead of "Set up
->i_fscrypt_info", we could write "Set up the inode's fscrypt info".

- Eric

