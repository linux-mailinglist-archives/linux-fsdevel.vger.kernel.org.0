Return-Path: <linux-fsdevel+bounces-20656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AD98D66E5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 18:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC2C6B2C04D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 16:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6295015AAB6;
	Fri, 31 May 2024 16:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="mmz74Ee8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4C036AF8
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 May 2024 16:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717173051; cv=none; b=dTeJmwVfmY/qHMIGMHVDkzLF6bXL30fPKsy1ebK6o44fC6lVJaRfJcz9+NCM35RXJ0cbsxGpBKbq4jYtSWtG2eNkVxLgYMrnwtue0ai8hTDn3nqAfACqDI24kQldndaVmMScp+TKtz890h/1Iz+fXl1vYVPqkUmPXuFSAQ/ZnvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717173051; c=relaxed/simple;
	bh=AQwweROsGjWFaWDPSGQ2n1edXkYYPrpSvGOwJmuNjpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DrpMCSXLoaktqmQZcGzi9Jb58QH3b5PzXnqAaJjzzsfY4jF8PT7WTFfvnD/QfoTC5NdHl7fg4FDRde+H57r/j3Crf6vHx6DydUK3M+b/9b/sw0UYTT2Io1CcaE/lPdQhrKtUju4Mb213YdXhra3BGeFm6g2QvS5t5VcH+Zbx+ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=mmz74Ee8; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1t9xXWfjekDl+onyBh1ADcHEBq7qJGrw1hTtgPe8RQ8=; b=mmz74Ee8Ro/FIkV279MkJyUl6d
	v9UqkxKf81kkAwAgZb8bCC64nowyjuElQUZ/4Avu+nVV7E6QKcDDwvbiIPz4ulnszIJOP7wYwVHMi
	ieadjiyAvsDkRF4kFCNWbyY73Rbbjt8VodUH8L6ZNu0yLgGGNerXcdz+WZdwKOJcS7ngTxTQtgqXI
	PUAfOxyjngdmctDQTY/LuB5HlcIDzXlyUKq5rrgK8I+yonf4eXxG57YYWYPSxw4OX463sIOhI8RtP
	eBYHacwYG2AZ0Z1t05uEqzbmup2rsFBB2kbLaQnKPOtObsjPLfIEPvRypPrbxn0LQcdgKLBSgty2n
	XT0jro7A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sD59R-0085wG-2s;
	Fri, 31 May 2024 16:30:46 +0000
Date: Fri, 31 May 2024 17:30:45 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] struct fd situation
Message-ID: <20240531163045.GA1916035@ZenIV>
References: <20240531031802.GA1629371@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531031802.GA1629371@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, May 31, 2024 at 04:18:02AM +0100, Al Viro wrote:

> Alternative would be to turn struct fd into a struct-wrapped unsigned long
> and either use a flag for emptiness checks (we can steal more from the
> pointer) or just compare with zero for empitness check.
> 
> The former might allow to represent specific errors, which would give a neat
> solution for ovl_real_fd() calling conventions - instead of "return an error,
> fill user-supplied struct fd" it could just return an error-representing
> struct fd and be done with that.
> 
> Unfortunately, gcc optimizer really stinks when it comes to bitops -
[snip]

> That example is very close to what we'd need if fd_empty() turned
> into checking a flag.  So unless somebody has a clever scheme that
> would avoid that kind of fun, this is probably no-go.
> 
> If we give up on representing errors, we can use 0 for empty.

Hmm...  FWIW, we could do something like this:

fd: 0 for empty, (unsigned long)p | flags, with p being an address of struct file
fd_err: a non-zero value possible for fd or (unsigned long)-E... for an error.

The range of valid values for fd does not overlap with
	(unsigned long)-MAX_ERRNO..(unsigned long)-1
since that would require IS_ERR(p) to be true and if we ever had that for
an address of some object, we would have worse problems.

That would be something along the lines of

#define fd_file(f) (struct file *)((f).word & ~3)

static inline bool fd_empty(struct fd f)
{
	return unlikely(!f.word);
}

static inline void fdput(struct fd f)
{
	if (f.word & FDPUT_FPUT)
		fput(fd_file(f));
}

static inline bool __must_check FD_IS_ERR(struct fd_err f)
{
	return IS_ERR_VALUE(f.word);
}

static inline void fdput_err(struct fd_err f)
{
	if (!FD_IS_ERR(f))
		fdput((struct fd){f.word});
}

static inline long __must_check FD_ERR(struct fd_err f)
{
	return (long)fd.word;
}

That's basically the difference between "pointer to object or NULL" and
"pointer to object or ERR_PTR()", only with distinguishable types for
those...

Interesting...  So we get something like

static inline struct fd_err file_fd_err(struct file *f, bool is_cloned)
{
	if (IS_ERR(f))
		return (struct fd_err){PTR_ERR(f)};
	else
		return (struct fd_err){(unsigned long)f | is_cloned};
}

(or, perhaps, file_fd_cloned and file_fd_borrowed, to get rid of
'is_cloned' argument in public API; need to play around a bit and
see what works better - the interesting part is what the constructor
for struct fd would look like)

with 

static struct fd_err ovl_real_fdget_meta(const struct file *file, bool allow_meta)
{
        struct dentry *dentry = file_dentry(file);
        struct path realpath;
        int err;

        if (allow_meta) {
                ovl_path_real(dentry, &realpath);
        } else {
                /* lazy lookup and verify of lowerdata */
                err = ovl_verify_lowerdata(dentry);
                if (err)
                        return file_fd_err(ERR_PTR(err), false);

                ovl_path_realdata(dentry, &realpath);
        }
        if (!realpath.dentry)
                return file_fd_err(ERR_PTR(-EIO), false);

        /* Has it been copied up since we'd opened it? */
        if (unlikely(file_inode(real->file) != d_inode(realpath.dentry)))
		return file_fd_err(ovl_open_realfile(file, &realpath), true);

        /* Did the flags change since open? */
        if (unlikely((file->f_flags ^ real->file->f_flags) & ~OVL_OPEN_FLAGS)) {
		err = ovl_change_flags(real->file, file->f_flags);
		if (err)
			return file_fd_err(ERR_PTR(err), false);
	}

        return file_fd_err(file->private_data, false);
}

static struct fd_err ovl_real_fdget(const struct file *file)
{
        if (d_is_dir(file_dentry(file)))
		return file_fd_err(ovl_dir_real_file(file, false), false);

        return ovl_real_fdget_meta(file, false);
}

with callers looking like

        real = ovl_real_fdget(file);
        if (FD_IS_ERR(real))
                return FD_ERR(real);
	do stuff, using fd_file(real)
	fdput_err(real);

with possibility of __cleanup() use, since fdput_err() on
early failure exit would be a no-op.

