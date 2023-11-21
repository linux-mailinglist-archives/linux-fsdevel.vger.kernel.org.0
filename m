Return-Path: <linux-fsdevel+bounces-3313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 320D47F3201
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 16:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7114B2190F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 15:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A7C56744;
	Tue, 21 Nov 2023 15:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgGtR0Gm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C6C49F9C
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Nov 2023 15:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 816FDC433C9;
	Tue, 21 Nov 2023 15:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700579414;
	bh=5QacUn33WbqerEPGrr9bvE2K+EHuN5/Fg03k/5sNxsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MgGtR0GmC+PsT/0+4EB+CcI8fKVhe5T8Ay6qCeW+BCcxqYBxlQpWywEnDg/Z0HB6X
	 cn+PNw4J+TTyQsFA+AWyLng1IAHeYbMA+gvp1hJmYajw/iaZ9i6rPc6qC67gFLecp1
	 hKTGWIk2PcE6f2UH/blmn/jftB/Md6Qw5s9Irs/rL/a07Cp4TxPTJc/9qlKQwLDGil
	 1f+qOQRxWRLuxvpwugIwaqE5OSopSfdpLYolPGITwxjvPaa+y5EPqs50NyLH++LASl
	 iv3KgHRD2VQYtduIlgas65OOhsSWu+fcO1vngewWWFB7IQBXVCpAhy4l77GLuzAuA6
	 uhvt2g4M8R4CA==
Date: Tue, 21 Nov 2023 16:10:10 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>,
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 07/15] remap_range: move file_start_write() to after
 permission hook
Message-ID: <20231121-datum-computer-93e188fe5469@brauner>
References: <20231114153321.1716028-1-amir73il@gmail.com>
 <20231114153321.1716028-8-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231114153321.1716028-8-amir73il@gmail.com>

On Tue, Nov 14, 2023 at 05:33:13PM +0200, Amir Goldstein wrote:
> In vfs code, file_start_write() is usually called after the permission
> hook in rw_verify_area().  vfs_dedupe_file_range_one() is an exception
> to this rule.
> 
> In vfs_dedupe_file_range_one(), move file_start_write() to after the
> the rw_verify_area() checks to make them "start-write-safe".
> 
> This is needed for fanotify "pre content" events.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/remap_range.c | 32 +++++++++++++-------------------
>  1 file changed, 13 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/remap_range.c b/fs/remap_range.c
> index 42f79cb2b1b1..de4b09d0ba1d 100644
> --- a/fs/remap_range.c
> +++ b/fs/remap_range.c
> @@ -445,46 +445,40 @@ loff_t vfs_dedupe_file_range_one(struct file *src_file, loff_t src_pos,
>  	WARN_ON_ONCE(remap_flags & ~(REMAP_FILE_DEDUP |
>  				     REMAP_FILE_CAN_SHORTEN));
>  
> -	ret = mnt_want_write_file(dst_file);
> -	if (ret)
> -		return ret;
> -
>  	/*
>  	 * This is redundant if called from vfs_dedupe_file_range(), but other
>  	 * callers need it and it's not performance sesitive...
>  	 */
>  	ret = remap_verify_area(src_file, src_pos, len, false);
>  	if (ret)
> -		goto out_drop_write;
> +		return ret;
>  
>  	ret = remap_verify_area(dst_file, dst_pos, len, true);
>  	if (ret)
> -		goto out_drop_write;
> +		return ret;
>  
> -	ret = -EPERM;
>  	if (!allow_file_dedupe(dst_file))
> -		goto out_drop_write;
> +		return -EPERM;

So that check specifically should come after mnt_want_write_file()
because it calls inode_permission() which takes the mount's idmapping
into account. And before you hold mnt_want_write_file() the idmapping of
the mount can still change. Once you've gotten write access though we
tell the anyone trying to change the mount's write-relevant properties
to go away.

With your changes that check might succeed now but fail later. So please
move that check below mnt_want_write_file(). That shouldn't be a
problem.

Fwiw, for security_file_permission() it doesn't matter because the LSMs
don't care about DAC permission - at least not the ones that currently
implement the hook. I verified that years ago and just rechecked. If
they start caring - which I sincerely hope they don't - then we have to
do a bunch of rework anyway to make that work reliably. But I doubt
that'll happen or we'll let that happen.

While at it, please rename allow_file_dedupe() to may_dedupe_file() so
it mirrors our helpers in fs/namei.c.

