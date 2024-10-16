Return-Path: <linux-fsdevel+bounces-32062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B1F9A0070
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 07:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 610AA1C2307A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 05:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E90A18A95D;
	Wed, 16 Oct 2024 05:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="CsD/4fPV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC422187855
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 05:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729055352; cv=none; b=XfCCY7mBAJgfzGxdjNuqRjK+Px0LmsPTW2qg5yfVjhSfBBK7jzchZmwVMUoWWdd0bhcCiEFwwoGfltnPEgB+tKG0PyMiise5nwqkLv3gkIYGHrcr68JfvLdCaD2D3Y8crONx2gECCwcq/8V992n3HQfSXwObLdnqUHKcwtrPJkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729055352; c=relaxed/simple;
	bh=Ca1PLv6gsGbV378QkvKlsft+PU5a4D9E4W8ippclxv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QkesDdR+cqRS5UCysR+HhUvPVdIs1UtjGH7Lm/65Y4CNv+4TFoDS/viRHGQ2W8VFpmH0HiZ/Ju7K1v4gzD08dtIZAwSb+t8+AWYmhFqha3Q+cAvAR3Kg5pUStyR+IO14ZoERlz1wJk+Ja2zfiuwY+LMculZyjbOlIDjTEUYPLhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=CsD/4fPV; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=71RbzMvJcXhsBKNkNw8iSn8spbx9YCQnF7Zg8jOeE5g=; b=CsD/4fPVMMkmGfR0Wrc2sDmlqC
	FlfKubNN+0B/UhvwEi6s3jYQeMYH+pKLBUrhTBmYcC+ELdNLt27onurY8wCuDr+z0lANNmmWFVsnV
	Y7SotnvkRfxrsZbkCGCnHvTfLqaEje+BdGck1NalKnBNBcaM4nQM7bpYaV+dzfSpwtU3/Q2gdQNA+
	uaEH9tstNaQk/HfAq/j+Ft2u2fEQaKZFf8LqFtxUbjwjJhb18Trxn82McALyukSLcnlzDmmzlps+K
	94BINE2yZCLji+JBC8Mkjm8UGfz+4Zl/MnnxVSh5WwRPdsl4IFYCjIc+B/bd1uvWOd4vIgB65lUQP
	ilW7a2pw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t0wHU-00000004HZI-0qxH;
	Wed, 16 Oct 2024 05:09:08 +0000
Date: Wed, 16 Oct 2024 06:09:08 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH] getname_maybe_null() - the third variant of
 pathname copy-in
Message-ID: <20241016050908.GH4017910@ZenIV>
References: <20241009040316.GY4017910@ZenIV>
 <20241015-falter-zuziehen-30594fd1e1c0@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015-falter-zuziehen-30594fd1e1c0@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Oct 15, 2024 at 04:05:15PM +0200, Christian Brauner wrote:
> Looks good.
> 
> Fyi, I'm using your #base.getname as a base for some other work that I'm
> currently doing. So please don't rebase #base.getname anymore. ;)
> 
> Since you have your #work.xattr and #work.stat using it as base it seems
> pretty unlikely anyway but I just thought I mention explicitly that I'm
> relying on that #base.getname branch.

FWIW, I see a problem with that sucker.  The trouble is in the
combination AT_FDCWD, "", AT_EMPTY_PATH.  vfs_empty_path() returns
false on that, so fstatat() in mainline falls back to vfs_statx() and
does the right thing.  This variant does _not_.

Note that your variant of xattr series also ended up failing on e.g.
getxattrat() with such combination:
        if (at_flags & AT_EMPTY_PATH && vfs_empty_path(dfd, pathname)) {
                CLASS(fd, f)(dfd);
                if (!f.file)
                        return -EBADF;
                audit_file(f.file);
                return getxattr(file_mnt_idmap(f.file), file_dentry(f.file),
                                name, value, size);
        }

        lookup_flags = (at_flags & AT_SYMLINK_NOFOLLOW) ? 0 : LOOKUP_FOLLOW;

retry:
        error = user_path_at(dfd, pathname, lookup_flags, &path);

ended up calling user_path_at() with empty pathname and nothing like LOOKUP_EMPTY
in lookup_flags.  Which bails out with -ENOENT, since getname() in there does
so.  My variant bails out with -EBADF and I'd argue that neither is correct.

Not sure what's the sane solution here, need to think for a while...

