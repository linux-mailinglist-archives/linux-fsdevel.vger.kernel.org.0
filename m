Return-Path: <linux-fsdevel+bounces-56850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F22CB1C98C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 18:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4855C3BEABA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 16:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5FB28D85D;
	Wed,  6 Aug 2025 16:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNyVL+Q7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F107D20B7ED
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Aug 2025 16:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754496104; cv=none; b=Bo98WYXro7b/JLtwQrTLw2mKqoVLFYziOA581LYafGncF36F81+MC1Sa0Ny71XiMXYILqxn/R9vRuoL1vzpL/zcalmUa+2vCqmG/tif91LxXuEObN0fHtaGMK1QAM9RBftSIx9+ybDJ6qvkzChVB9BsETd6j4EczibxwfKd3xy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754496104; c=relaxed/simple;
	bh=pA8MqpwRM2yK5hOZ3qnjVZf/Ca/csAoYxhuTbYLC1Jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=magitd/9S4hj3XLLDy7ch3aFad234cKCqAEAJJ9aaapxmxiC3buvGe6tbhPDOfn6f4S3beuJS0aSmpGZeBRj23pB3K0mgV+HPYoNIoS4XXq/xHpMwuyBkRDSAx+thoavmBydy+cuiUgrLQTRFVlfh2maG4Yn1Qy6G/lojls9Wsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNyVL+Q7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D549C4CEE7;
	Wed,  6 Aug 2025 16:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754496103;
	bh=pA8MqpwRM2yK5hOZ3qnjVZf/Ca/csAoYxhuTbYLC1Jw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kNyVL+Q7zMloP2bIXayhMbDzaHBQZge3BoktJ+BP18gSwxo/6GQTvsUnIDyFL6rx6
	 3tiRl0nr71+5HgC4f5vV+LTXHb3zM5oX6L071zDae3TyaVcKpKI5AI1eTETuWoQmUT
	 hu1rrNbPZQUlRMMZazH7M5LW6z81E/ypN3qJZ4jMRGG7GVGrHwh5VAYiaJEPNBVBrx
	 ErbZu7a/3bvODbGJHxw9kFQRtHj5Jce/Jcz3hwqW2Nk7lPhp00UrDNsnbUAVtThZJ1
	 K6ZOtP6xTednKpPJrBzcxQr+tzwZ0r8l54E8HdQCEAbpCvEUNdsInnooAmnwJWB0RZ
	 lWhAwogbI7Fyw==
Date: Wed, 6 Aug 2025 09:01:42 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Luis Henriques <luis@igalia.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org,
	Bernd Schubert <bschubert@ddn.com>,
	Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH 1/2] fuse: fix COPY_FILE_RANGE interface
Message-ID: <20250806160142.GF2672029@frogsfrogsfrogs>
References: <20250805183017.4072973-1-mszeredi@redhat.com>
 <87pld8kdwt.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87pld8kdwt.fsf@wotan.olymp>

On Wed, Aug 06, 2025 at 10:17:06AM +0100, Luis Henriques wrote:
> On Tue, Aug 05 2025, Miklos Szeredi wrote:
> 
> > The FUSE protocol uses struct fuse_write_out to convey the return value of
> > copy_file_range, which is restricted to uint32_t.  But the COPY_FILE_RANGE
> > interface supports a 64-bit size copies.
> >
> > Currently the number of bytes copied is silently truncated to 32-bit, which
> > is unfortunate at best.
> >
> > Introduce a new op COPY_FILE_RANGE_64, which is identical, except the
> > number of bytes copied is returned in a 64-bit value.
> >
> > If the fuse server does not support COPY_FILE_RANGE_64, fall back to
> > COPY_FILE_RANGE and truncate the size to UINT_MAX - 4096.
> 
> I was wondering if it wouldn't make more sense to truncate the size to
> MAX_RW_COUNT instead.  My reasoning is that, if I understand the code
> correctly (which is probably a big 'if'!), the VFS will fallback to
> splice() if the file system does not implement copy_file_range.  And in
> this case splice() seems to limit the operation to MAX_RW_COUNT.

It doesn't, because copy_file_range implementations can do other things
(like remapping/reflinking file blocks) that produce a very small amount
of disk IO for what is effectively a very large change to file contents.
That's why the VFS doesn't cap len at MAX_RW_COUNT bytes.

--D

> Cheers,
> -- 
> Luís
> 
> 
> > Reported-by: Florian Weimer <fweimer@redhat.com>
> > Closes: https://lore.kernel.org/all/lhuh5ynl8z5.fsf@oldenburg.str.redhat.com/
> > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > ---
> >  fs/fuse/file.c            | 34 ++++++++++++++++++++++++++--------
> >  fs/fuse/fuse_i.h          |  3 +++
> >  include/uapi/linux/fuse.h | 12 +++++++++++-
> >  3 files changed, 40 insertions(+), 9 deletions(-)
> >
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index adc4aa6810f5..bd6624885855 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -3017,6 +3017,8 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
> >  		.flags = flags
> >  	};
> >  	struct fuse_write_out outarg;
> > +	struct fuse_copy_file_range_out outarg_64;
> > +	u64 bytes_copied;
> >  	ssize_t err;
> >  	/* mark unstable when write-back is not used, and file_out gets
> >  	 * extended */
> > @@ -3066,30 +3068,46 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
> >  	if (is_unstable)
> >  		set_bit(FUSE_I_SIZE_UNSTABLE, &fi_out->state);
> >  
> > -	args.opcode = FUSE_COPY_FILE_RANGE;
> > +	args.opcode = FUSE_COPY_FILE_RANGE_64;
> >  	args.nodeid = ff_in->nodeid;
> >  	args.in_numargs = 1;
> >  	args.in_args[0].size = sizeof(inarg);
> >  	args.in_args[0].value = &inarg;
> >  	args.out_numargs = 1;
> > -	args.out_args[0].size = sizeof(outarg);
> > -	args.out_args[0].value = &outarg;
> > +	args.out_args[0].size = sizeof(outarg_64);
> > +	args.out_args[0].value = &outarg_64;
> > +	if (fc->no_copy_file_range_64) {
> > +fallback:
> > +		/* Fall back to old op that can't handle large copy length */
> > +		args.opcode = FUSE_COPY_FILE_RANGE;
> > +		args.out_args[0].size = sizeof(outarg);
> > +		args.out_args[0].value = &outarg;
> > +		inarg.len = min_t(size_t, len, 0xfffff000);
> > +	}
> >  	err = fuse_simple_request(fm, &args);
> >  	if (err == -ENOSYS) {
> > -		fc->no_copy_file_range = 1;
> > -		err = -EOPNOTSUPP;
> > +		if (fc->no_copy_file_range_64) {
> > +			fc->no_copy_file_range = 1;
> > +			err = -EOPNOTSUPP;
> > +		} else {
> > +			fc->no_copy_file_range_64 = 1;
> > +			goto fallback;
> > +		}
> >  	}
> >  	if (err)
> >  		goto out;
> >  
> > +	bytes_copied = fc->no_copy_file_range_64 ?
> > +		outarg.size : outarg_64.bytes_copied;
> > +
> >  	truncate_inode_pages_range(inode_out->i_mapping,
> >  				   ALIGN_DOWN(pos_out, PAGE_SIZE),
> > -				   ALIGN(pos_out + outarg.size, PAGE_SIZE) - 1);
> > +				   ALIGN(pos_out + bytes_copied, PAGE_SIZE) - 1);
> >  
> >  	file_update_time(file_out);
> > -	fuse_write_update_attr(inode_out, pos_out + outarg.size, outarg.size);
> > +	fuse_write_update_attr(inode_out, pos_out + bytes_copied, bytes_copied);
> >  
> > -	err = outarg.size;
> > +	err = bytes_copied;
> >  out:
> >  	if (is_unstable)
> >  		clear_bit(FUSE_I_SIZE_UNSTABLE, &fi_out->state);
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index b54f4f57789f..a8be19f686b1 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -850,6 +850,9 @@ struct fuse_conn {
> >  	/** Does the filesystem support copy_file_range? */
> >  	unsigned no_copy_file_range:1;
> >  
> > +	/** Does the filesystem support copy_file_range_64? */
> > +	unsigned no_copy_file_range_64:1;
> > +
> >  	/* Send DESTROY request */
> >  	unsigned int destroy:1;
> >  
> > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > index 122d6586e8d4..94621f68a5cc 100644
> > --- a/include/uapi/linux/fuse.h
> > +++ b/include/uapi/linux/fuse.h
> > @@ -235,6 +235,10 @@
> >   *
> >   *  7.44
> >   *  - add FUSE_NOTIFY_INC_EPOCH
> > + *
> > + *  7.45
> > + *  - add FUSE_COPY_FILE_RANGE_64
> > + *  - add struct fuse_copy_file_range_out
> >   */
> >  
> >  #ifndef _LINUX_FUSE_H
> > @@ -270,7 +274,7 @@
> >  #define FUSE_KERNEL_VERSION 7
> >  
> >  /** Minor version number of this interface */
> > -#define FUSE_KERNEL_MINOR_VERSION 44
> > +#define FUSE_KERNEL_MINOR_VERSION 45
> >  
> >  /** The node ID of the root inode */
> >  #define FUSE_ROOT_ID 1
> > @@ -657,6 +661,7 @@ enum fuse_opcode {
> >  	FUSE_SYNCFS		= 50,
> >  	FUSE_TMPFILE		= 51,
> >  	FUSE_STATX		= 52,
> > +	FUSE_COPY_FILE_RANGE_64	= 53,
> >  
> >  	/* CUSE specific operations */
> >  	CUSE_INIT		= 4096,
> > @@ -1148,6 +1153,11 @@ struct fuse_copy_file_range_in {
> >  	uint64_t	flags;
> >  };
> >  
> > +/* For FUSE_COPY_FILE_RANGE_64 */
> > +struct fuse_copy_file_range_out {
> > +	uint64_t	bytes_copied;
> > +};
> > +
> >  #define FUSE_SETUPMAPPING_FLAG_WRITE (1ull << 0)
> >  #define FUSE_SETUPMAPPING_FLAG_READ (1ull << 1)
> >  struct fuse_setupmapping_in {
> > -- 
> > 2.49.0
> >
> 
> 

