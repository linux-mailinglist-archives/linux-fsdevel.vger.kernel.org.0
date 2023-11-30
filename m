Return-Path: <linux-fsdevel+bounces-4384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DAA7FF2A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 15:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 909B62826BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EB45100C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvXjG1ub"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5107246422
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 13:18:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841BCC433C7;
	Thu, 30 Nov 2023 13:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701350296;
	bh=dhqm5L2Nb04f+zqmc+m9C5z2Ml0GpyCcj93suUsjYm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pvXjG1ubGFKRqoicQh6PHaZs4YZmIwl8NBzemBlwd2ac0MYw/wX9BM7Um2RXaDgxc
	 ede+c5USgme1B/o8/QTNdKYyVA/eyu3x9+VRpvCfk8AduNu2Q3PYE3jClYWGWKY4yJ
	 5dHGqG1ifm7m0HQOSQSJO1+m4z7GgR9dwcWwMD1wJ/1S2teN62wDwM6jDy73y75Tfy
	 03n91cpqkXUTzoFNm8uMy68I2Ol8pJU9AdpIzEVarF+QFWpA8s2mbg+TOSrNq2vHB+
	 vb0N4S7OqVmA6xGEqphz80hi/tM8RooplE7DrUCnOwJ90es3BTMIpYkg2dk7ZehSHJ
	 fdAhD0Ik6x0Bg==
Date: Thu, 30 Nov 2023 14:18:11 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] fs: fork do_splice_copy_file_range() from
 do_splice_direct()
Message-ID: <20231130-mollig-koproduktion-6c80ebb98b5f@brauner>
References: <20231129200709.3154370-1-amir73il@gmail.com>
 <20231129200709.3154370-2-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231129200709.3154370-2-amir73il@gmail.com>

On Wed, Nov 29, 2023 at 10:07:08PM +0200, Amir Goldstein wrote:
> The new helper is meant to be called from context of ->copy_file_range()
> methods instead of do_splice_direct().
> 
> Currently, the only difference is that do_splice_copy_file_range() does
> not take a splice flags argument and it asserts that file_start_write()
> was called.
> 
> Soon, do_splice_direct() will be called without file_start_write() held.
> 
> Use the new helper from __ceph_copy_file_range(), that was incorrectly
> passing the copy_file_range() flags argument as splice flags argument
> to do_splice_direct(). the value of flags was 0, so no actual bug fix.
> 
> Move the definition of both helpers to linux/splice.h.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/ceph/file.c         |  9 ++---
>  fs/read_write.c        |  6 ++--
>  fs/splice.c            | 82 ++++++++++++++++++++++++++++++------------
>  include/linux/fs.h     |  2 --
>  include/linux/splice.h | 13 ++++---
>  5 files changed, 75 insertions(+), 37 deletions(-)
> 
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 3b5aae29e944..7c2db78e2c6e 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -12,6 +12,7 @@
>  #include <linux/falloc.h>
>  #include <linux/iversion.h>
>  #include <linux/ktime.h>
> +#include <linux/splice.h>
>  
>  #include "super.h"
>  #include "mds_client.h"
> @@ -3010,8 +3011,8 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
>  		 * {read,write}_iter, which will get caps again.
>  		 */
>  		put_rd_wr_caps(src_ci, src_got, dst_ci, dst_got);
> -		ret = do_splice_direct(src_file, &src_off, dst_file,
> -				       &dst_off, src_objlen, flags);
> +		ret = do_splice_copy_file_range(src_file, &src_off, dst_file,
> +						&dst_off, src_objlen);
>  		/* Abort on short copies or on error */
>  		if (ret < (long)src_objlen) {
>  			doutc(cl, "Failed partial copy (%zd)\n", ret);
> @@ -3065,8 +3066,8 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
>  	 */
>  	if (len && (len < src_ci->i_layout.object_size)) {
>  		doutc(cl, "Final partial copy of %zu bytes\n", len);
> -		bytes = do_splice_direct(src_file, &src_off, dst_file,
> -					 &dst_off, len, flags);
> +		bytes = do_splice_copy_file_range(src_file, &src_off, dst_file,
> +						  &dst_off, len);
>  		if (bytes > 0)
>  			ret += bytes;
>  		else
> diff --git a/fs/read_write.c b/fs/read_write.c
> index f791555fa246..555514cdad53 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1423,10 +1423,8 @@ ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
>  				struct file *file_out, loff_t pos_out,
>  				size_t len, unsigned int flags)
>  {

Hm, the low-level helper takes a @flags argument but it's completely
ignored. I think that helper should remove it or it should check:

if (flags)
	return -EINVAL;

in case it's ever called from codepaths where @flags hasn't been
sanitized imho.

> -	lockdep_assert(file_write_started(file_out));
> -
> -	return do_splice_direct(file_in, &pos_in, file_out, &pos_out,
> -				len > MAX_RW_COUNT ? MAX_RW_COUNT : len, 0);
> +	return do_splice_copy_file_range(file_in, &pos_in, file_out, &pos_out,
> +				len > MAX_RW_COUNT ? MAX_RW_COUNT : len);

clamp(len, 0, MAX_RW_COUNT)

?

