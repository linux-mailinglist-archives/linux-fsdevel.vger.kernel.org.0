Return-Path: <linux-fsdevel+bounces-73458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F36D1A117
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 17:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBD0130402FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 16:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07FB34B66F;
	Tue, 13 Jan 2026 16:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYMFv/D7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D526221F0A;
	Tue, 13 Jan 2026 16:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768320144; cv=none; b=pXGDzchiuETN91HZQFU656fCVBWu/QLLD6ckEkKkPTbvDY6P3nt4Sb1w0HTvCrKQLx3hh/1Jzil8LFAAdmOahLN/QtzgU61u8O4PdQHDqrMkGnEDg86tkyFvHUHOxJNX7jNmMZbaDW20Vov4I6MeW2pyz8tmDUczvZ3Qv7C66FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768320144; c=relaxed/simple;
	bh=sJ0drImlHmi4eNlw3/9VNDxuss8pVfndyTc8DUdPStU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGMtkQENnWjMLhbcEiOpslNfQZbYBSvsoOfFAE3PQKBG0mDexKpG4Ym0kHrw4cAh6NRPUWfGYlqr2Er7PFdF7gkqEhulvnRs2GwamypDabCRkfhEhlJWYxW/1G4GSzZLtvzJS5QibJogB1oY/CqwzK8jojH8RpC5/wAslbaxKqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYMFv/D7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C84DCC116C6;
	Tue, 13 Jan 2026 16:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768320143;
	bh=sJ0drImlHmi4eNlw3/9VNDxuss8pVfndyTc8DUdPStU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QYMFv/D7kfTqCnOamWRJJWLSuiy/pNTRNJlG7B/24d9mG8L6I49CIapWbCN6Hhr9q
	 uVam4pdO+LwbitPkimVBbCjcS/rlj6tn2RUmPJidX/IIfSOemj1sn1wJffxGd0bsAv
	 KwT0TJM8LrSZjMqaxhZXnfBN+aJjR4cK6fKrZ0wIiqV40Pr4kyxZ12dNNHdJbHMR8e
	 k1BEf2haHaYdPV6G9u4oUH9cRrmNk23GyrRC9vsGwznkxM36BdbsPsdvFpFa80YVi+
	 5G+zUe54ezm5Y0QqVZ4cV4PozoIliY9VUH146N2iJDrC7AlttIRCBcL2cmK2v9QsR3
	 /e6w1GcNo3RKQ==
Date: Tue, 13 Jan 2026 08:02:23 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: vira@web.codeaurora.org, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, hirofumi@mail.parknet.co.jp,
	linkinjeon@kernel.org, sj1557.seo@samsung.com, yuezhang.mo@sony.com,
	almaz.alexandrovich@paragon-software.com, slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com, tytso@mit.edu,
	adilger.kernel@dilger.ca, cem@kernel.org, sfrench@samba.org,
	pc@manguebit.org, ronniesahlberg@gmail.com, sprasad@microsoft.com,
	trondmy@kernel.org, anna@kernel.org, jaegeuk@kernel.org,
	chao@kernel.org, hansg@kernel.org, senozhatsky@chromium.org,
	Chuck Lever <chuck.lever@oracle.com>, Neal Gompa <neal@gompa.dev>
Subject: Re: [PATCH v3 08/16] xfs: Report case sensitivity in fileattr_get
Message-ID: <20260113160223.GA15522@frogsfrogsfrogs>
References: <20260112174629.3729358-1-cel@kernel.org>
 <20260112174629.3729358-9-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112174629.3729358-9-cel@kernel.org>

On Mon, Jan 12, 2026 at 12:46:21PM -0500, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Upper layers such as NFSD need to query whether a filesystem is
> case-sensitive. Populate the case_insensitive and case_preserving
> fields in xfs_fileattr_get(). XFS always preserves case. XFS is
> case-sensitive by default, but supports ASCII case-insensitive
> lookups when formatted with the ASCIICI feature flag.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Well as a pure binary statement of xfs' capabilities, this is correct so:
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

[add ngompa]

But the next obvious question I would have as a userspace programmer is
"case insensitive how, exactly?", which was the topic of the previous
revision.  Somewhere out there there's a program / emulation layer that
will want to know the exact transformation when doing a non-memcmp
lookup.  Probably Winderz casefolding has behaved differently every
release since the start of NTFS, etc.

I don't know how to solve that, other than the fs compiles its
case-flattening code into a bpf program and exports that where someone
can read() it and run/analyze/reverse engineer it.  But ugh, Linus is
right that this area is a mess. :/

--D

> ---
>  fs/xfs/xfs_ioctl.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> index 59eaad774371..97314fcb7732 100644
> --- a/fs/xfs/xfs_ioctl.c
> +++ b/fs/xfs/xfs_ioctl.c
> @@ -516,6 +516,13 @@ xfs_fileattr_get(
>  	xfs_fill_fsxattr(ip, XFS_DATA_FORK, fa);
>  	xfs_iunlock(ip, XFS_ILOCK_SHARED);
>  
> +	/*
> +	 * XFS is case-sensitive by default, but can be formatted with
> +	 * ASCII case-insensitive mode enabled.
> +	 */
> +	fa->case_insensitive = xfs_has_asciici(ip->i_mount);
> +	fa->case_preserving = true;
> +
>  	return 0;
>  }
>  
> -- 
> 2.52.0
> 
> 

