Return-Path: <linux-fsdevel+bounces-31141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE00992322
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 05:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B689CB2229E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 03:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEA514A96;
	Mon,  7 Oct 2024 03:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Ro7bIEA/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167B1FC11;
	Mon,  7 Oct 2024 03:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728272527; cv=none; b=A5tfJijXUVjKNVWeYhaobal5cZDrWW/UC3BKpQMnLIhuZ2VvsLjW5NytwDrPeN70b5FqwG9gslb2vjIWYEQpEEG9Yi206aX17v6G8OWhUQuCm6VMjERga88wmyn6TwZuBnJEnGSUFRH4zrfPDtxOhwDnCgWcRUu2qGxLfPEXk5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728272527; c=relaxed/simple;
	bh=bxsKrLhpeDGylPcF2ZYaLm38eOHy3zaKnGY3q16hXO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/ZnWCXVgnNnWHFTJOx5pP29ndnXOZyxTmHjjVpJuh+hFczSk2DpS0W5bfUJCip/HqkSlCXpuRAs2yOpXVBRJ7aqYLrSEMeJ0qdHNCZqtrXNEbDZeyGyZnSffPOjsf639s/I5X1B17X/k65k7M7AQ4fEqMOxkIXP7UVCybYgpvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Ro7bIEA/; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VKmfv3dETOs05yeVlO4FeyoMO6M00+hY0xYfVZ+DuFQ=; b=Ro7bIEA/2aSQdNPfmEzOtuqesA
	amx5MjtjrliGtlJ4Cacq4nx+EysGw9gTA9vQnZPzoAveptzgoIK6axWKmkrb1H/CI2jhfqoTftdU9
	VgXlc3sx310+s/b2iwWXpv7XbXBtf+czB35E32so41PbzlHOuqJWUZNkBExvL/+NFeVQD5QiP4Fkm
	crXHB/I2pR7V44AHHIBAz62hcnXsdH1C7/dg8WFQqUvt9qL6345V6SmN45F736zZZjqwziP+IdrGA
	1fEaNVzn4jNKd0rRRWMJB7vxv5mYtgDruZs5fIQzHn/IFsOfUT4vKOqizGt+NWhbSxl1kxi1LP7Qf
	b9LrFk/A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sxedG-00000001UVP-2gfr;
	Mon, 07 Oct 2024 03:42:02 +0000
Date: Mon, 7 Oct 2024 04:42:02 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v2 2/4] ovl: stash upper real file in backing_file struct
Message-ID: <20241007034202.GJ4017910@ZenIV>
References: <20241006082359.263755-1-amir73il@gmail.com>
 <20241006082359.263755-3-amir73il@gmail.com>
 <20241006210426.GG4017910@ZenIV>
 <20241007030313.GH4017910@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007030313.GH4017910@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Oct 07, 2024 at 04:03:13AM +0100, Al Viro wrote:

> > Hmm...  That still feels awkward.  Question: can we reach that code with
> > 	* non-NULL upperfile
> > 	* false ovl_is_real_file(upperfile, realpath)
> > 	* true ovl_is_real_file(realfile, realpath)
> > Is that really possible?
> 
> read() from metacopied file after fsync(), with the data still in lower
> layer?  Or am I misreading that?

Unless I'm misreading that thing, the logics would be

	If what we are asked for is where the data used to be at open time
		just use what we'd opened back then and be done with that.

	Either we'd been copied up since open, or it's a metadata fsync of
	a metacopied file; it doesn't matter which, since the upper layer
	file will be the same either way.

	If it hadn't been opened and stashed into the backing_file, do so.

	If we end up using the reference stashed by somebody else (either
	by finding it there in the first place, or by having cmpxchg tell
	us we'd lost the race), verify that it _is_ in the right place;
	it really should be, short of an equivalent of fs corruption
	(== somebody fucking around with the upper layer under us).

Is that what's going on there?  If so, I think your current version is
correct, but I'd probably put it in a different way:

        if (!ovl_is_real_file(realfile, realpath) {
		/*
		 * the place we want is not where the data used to be at
		 * open time; either we'd been copied up, or it's an fsync
		 * of metacopied file.  Should be the same location either
		 * way...
		 */
	        struct file *upperfile = backing_file_private(realfile);
		struct file *old;

		if (!upperfile) { /* nobody opened it yet */
			upperfile = ovl_open_realfile(file, realpath);
			if (IS_ERR(upperfile))
				return upperfile;
			old = cmpxchg_release(backing_file_private_ptr(realfile),
					      NULL, upperfile);
			if (old) { /* but they did while we were opening it */
				fput(upperfile);
				upperfile = old;
			}
		}
		/*
		 * stashed file must have been from the right place, unless
		 * someone's been corrupting the upper layer.
		 */
		if (WARN_ON_ONCE(!ovl_is_real_file(upperfile, realpath)))
			return ERR_PTR(-EIO);
		realfile = upperfile;
	}

