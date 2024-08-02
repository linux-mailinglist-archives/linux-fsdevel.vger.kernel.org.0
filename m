Return-Path: <linux-fsdevel+bounces-24872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78336945EE4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 15:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FB01B22813
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 13:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8251E4861;
	Fri,  2 Aug 2024 13:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="p84W7NXy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B44481AA;
	Fri,  2 Aug 2024 13:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722606741; cv=none; b=f6kB3l3oFdnMkSurOpY7Cq7NySiS2jC7pwRV8EzK5phwJ2+EyjbxpMKSbG+8TIk5DaQRzzHhjKfpGGLtRu3NhbsM64HJguo9NmarUeA0bJR+1iUopWmb+uwRG1++pVcFi+lL2fOxQeSNk6SM3Ok9D7IkBr3LlYoZ/jpFzBqNDPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722606741; c=relaxed/simple;
	bh=SiWVKwE1xW8X9EtDGjyX1Wg1kUH1l1z2I6jgWdtmsBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fNJQuY2NLaIl9+Q0O61FE/R3qdBjY3imuW69JGKL9dpFccq+RzDfnmPRWLVpludtnESDJ8uQ8E3wrtAIsgevUmwX2znFXFolFfhTFVU8bjL6UBLt7fPsrvq8mYP53WvwGXzGE188wcXtfQsqFZD8Nos52B7nuzDkoal3A74y/BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=p84W7NXy; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3UUWojAQerjSYG73lA+68aXbCwJ0MbwYWPMNazDfW7g=; b=p84W7NXy7yy+d2fP3j/Htgsl53
	VPChprfk53CtjSAhQ/7C46Y+5x9n55V/FZGtQqLNu25EEA9V1aDPfJ1o2qU7gY6L9VOKSb4n0i6CY
	F1DIfRPg5wmKg4mYFGZHPOadLGHucFYRU0yxHzx8Sobbg/MnKsGFy9/cad5o+gxSVEhYo5Wly5iRr
	OQPiEoZ6cgDrC9GromozqY7iK+gB9aEIO2rEa0fMiHNTQYCALkhbxipaogT+uRXOTnJcGiXtg4NuZ
	qSAb4pv+/kEq5LmiQx1pJaHmZtjjWaKp3jP8yG2AMR3sHOoeuXK0TXYXmMJqbQ7dkS1x+heKN5qAd
	8ZSbUf+g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sZsha-000000017UD-3Ri6;
	Fri, 02 Aug 2024 13:52:14 +0000
Date: Fri, 2 Aug 2024 14:52:14 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: jack@suse.cz, brauner@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, phillip@squashfs.org.uk,
	squashfs-devel@lists.sourceforge.net,
	syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V5] squashfs: Add i_size check in squash_read_inode
Message-ID: <20240802135214.GU5334@ZenIV>
References: <20240802093310.twbwdi5hpgpth63z@quack3>
 <20240802111640.2762325-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802111640.2762325-1-lizhi.xu@windriver.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Aug 02, 2024 at 07:16:40PM +0800, Lizhi Xu wrote:
> syzbot report KMSAN: uninit-value in pick_link, the root cause is that
> squashfs_symlink_read_folio did not check the length, resulting in folio
> not being initialized and did not return the corresponding error code.
> 
> The length is calculated from i_size, so it is necessary to add a check
> when i_size is initialized to confirm that its value is correct, otherwise
> an error -EINVAL will be returned. Strictly, the check only applies to the
> symlink type. Add larger symlink check.
> 
> Reported-and-tested-by: syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=24ac24ff58dc5b0d26b9
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> ---
>  fs/squashfs/inode.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/squashfs/inode.c b/fs/squashfs/inode.c
> index 16bd693d0b3a..6c5dd225482f 100644
> --- a/fs/squashfs/inode.c
> +++ b/fs/squashfs/inode.c
> @@ -287,6 +287,11 @@ int squashfs_read_inode(struct inode *inode, long long ino)
>  		inode->i_mode |= S_IFLNK;
>  		squashfs_i(inode)->start = block;
>  		squashfs_i(inode)->offset = offset;
> +		if ((int)inode->i_size < 0 || inode->i_size > PAGE_SIZE) {
> +			ERROR("Wrong i_size %d!\n", inode->i_size);
> +			return -EINVAL;
> +		}

ITYM something like
		if (le32_to_cpu(sqsh_ino->symlink_size) > PAGE_SIZE) {
			ERROR("Corrupted symlink\n");
			return -EINVAL;
		}

