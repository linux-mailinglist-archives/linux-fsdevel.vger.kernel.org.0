Return-Path: <linux-fsdevel+bounces-31081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BC6991A15
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 21:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D74C1C216C3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 19:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA1315ADAF;
	Sat,  5 Oct 2024 19:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="F+ZvCh88"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51BC154BEC;
	Sat,  5 Oct 2024 19:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728157771; cv=none; b=GOL2Kg5JZv3RtkaLJUHm83sTJy5t53OVRoO3oynRwpWr0sPwLM7JzX6MGeaXkIU7DMWSPNqIZHAKP9Kdre2WXkF6PFPlxSs6w3AnE5JpK3U4QnV3acbNuxBKcxL6EuK1NCJ3kof12TcJ8veY5J3dd+jfJaSXIezEMnUmDp23I4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728157771; c=relaxed/simple;
	bh=yIr0xOKm6eHHbooc909aNZdensRvy/iimZ/M6pm4RLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M56uvvF+4gj8rzPdk3HRNsv0O6XdgkLyxktKWdNN8GsGsmqXvY/iWenDFW+J4JJv3JNQGyCNenqcOENBBk+JSWv10idroJLDbgxn7qffMGAQejfENim4+UDFv+sOlhbFDiwCfXQr45cGVkWoGTRtm/m8yjjswKtjbmc1xsjxsBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=F+ZvCh88; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qXcw2jkEIsxh8qtqTXed13qhg8/gEKd15RW2PbHm1oI=; b=F+ZvCh88UANqOtoXGciuJ1hiR2
	58/rAfFBHGCR83JXs/oIdOHW5wdrxXLhhRfpO9r9NuvJG65/DTqSa7dTi2waytt6jpgZySIvTr+ep
	ubvBH0N6OaNqYbkgh3ruCmx975fNkKiBokm7kVs+E878DWuhIBCgsr0D/f1d/cR+x7yez5VrAvXoD
	vH0/x72r43GiKJICpkYzEUulbNkDe6Uwofo9DNRXvxcBhGnIoQylwN2GeiyaNMuWM38X14xyHlmnQ
	8IZ6m1bl+wMctilNmxJw2iLz4jvozixYrJcmwwcYdccuTKCIaFtelZKd3Pf9altlE02gaXu8ZU8CV
	xuPDh/Ww==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sxAmM-000000018a6-3v0n;
	Sat, 05 Oct 2024 19:49:26 +0000
Date: Sat, 5 Oct 2024 20:49:26 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH 1/4] ovl: do not open non-data lower file for fsync
Message-ID: <20241005194926.GY4017910@ZenIV>
References: <20241004102342.179434-1-amir73il@gmail.com>
 <20241004102342.179434-2-amir73il@gmail.com>
 <20241004221625.GR4017910@ZenIV>
 <20241004222811.GU4017910@ZenIV>
 <20241005013521.GV4017910@ZenIV>
 <CAOQ4uxiqrHeBbF49C0OkoyQm=BqQjvUYEd7k8oinCMwCSOuP3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiqrHeBbF49C0OkoyQm=BqQjvUYEd7k8oinCMwCSOuP3w@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Oct 05, 2024 at 08:30:23AM +0200, Amir Goldstein wrote:

> I understand your concern, but honestly, I am not sure that returning
> struct fderr is fundamentally different from checking IS_ERR_OR_NULL.
> 
> What I can do is refactor the helpers differently so that ovl_fsync() will
> call ovl_file_upper() to clarify that it may return NULL, just like

ovl_dentry_upper(), you mean?

> ovl_{dentry,inode,path}_upper() and all the other callers will
> call ovl_file_real() which cannot return NULL, because it returns
> either lower or upper file, just like ovl_{inode,path}_real{,data}().

OK...  One thing I'm not happy about is the control (and data) flow in there:
stashed_upper:
        if (upperfile && file_inode(upperfile) == d_inode(realpath.dentry))
                realfile = upperfile;

        /*
         * If realfile is lower and has been copied up since we'd opened it,
         * open the real upper file and stash it in backing_file_private().
         */
        if (unlikely(file_inode(realfile) != d_inode(realpath.dentry))) {
                struct file *old;

                /* Stashed upperfile has a mismatched inode */
                if (unlikely(upperfile))
                        return ERR_PTR(-EIO);

                upperfile = ovl_open_realfile(file, &realpath);
                if (IS_ERR(upperfile))
                        return upperfile;

                old = cmpxchg_release(backing_file_private_ptr(realfile), NULL,
                                      upperfile);
                if (old) {
                        fput(upperfile);
                        upperfile = old;
                }

                goto stashed_upper;
        }
Unless I'm misreading that, the value of realfile seen inside the second
if is always the original; reassignment in the first if might as well had
been followed by goto past the second one.  What's more, if you win the
race in the second if, you'll have upperfile != NULL and its file_inode()
matching realpath.dentry->d_inode (you'd better, or you have a real problem
in backing_file_open()).  So that branch to stashed_upper in case old == NULL
might as well had been "realfile = upperfile;".  Correct?  In case old != NULL
we go there with upperfile != NULL.  If it (i.e. old) has the right file_inode(),
we are done; otherwise it's going to hit ERR_PTR(-EIO) in the second if.

So it seems to be equivalent to this:
        if (unlikely(file_inode(realfile) != d_inode(realpath.dentry))) {
	        /*
		 * If realfile is lower and has been copied up since we'd
		 * opened it, we need the real upper file opened.  Whoever gets
		 * there first stashes the result in backing_file_private().
		 */
		struct file *upperfile = backing_file_private(realfile);
		if (unlikely(!upperfile)) {
			struct file *old;

			upperfile = ovl_open_realfile(file, &realpath);
			if (IS_ERR(upperfile))
				return upperfile;

			old = cmpxchg_release(backing_file_private_ptr(realfile), NULL,
					      upperfile);
			if (old) {
				fput(upperfile);
				upperfile = old;
			}
		}
		// upperfile reference is owned by realfile at that point
		if (unlikely(file_inode(upperfile) != d_inode(realpath.dentry)))
			/* Stashed upperfile has a mismatched inode */
			return ERR_PTR(-EIO);
		realfile = upperfile;
	}
Or am I misreading it?  Seems to be more straightforward that way...

