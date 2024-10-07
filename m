Return-Path: <linux-fsdevel+bounces-31140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B24CB9922E8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 05:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77BB8281F70
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 03:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBCA14290;
	Mon,  7 Oct 2024 03:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="JcP1yE2j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD90FC0C;
	Mon,  7 Oct 2024 03:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728270760; cv=none; b=WlZ+cyl0nT3BboTOFlVPw1OI2nKC8Ai8bN028MXHK6tQXoRii3jm+0TieReZi+cOzl4d8igA/pZyGSck271C5lHEOcebldkhBtom3ErTrdcz5bSwZP2L85V6HJ535cVZsZhWj5WNLkP8s1vWdHInk7TQRKXCbrHKgV3PjG5Q6A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728270760; c=relaxed/simple;
	bh=HhSaWido/BF5XhZ7oUzTHU9vod/6iDljzWgQ/IgHmGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKmH0UdAHH+YN3afCcvVHSAWrCSe7BMpj4+C35qEcjzI79q4TST0mb7YlKRGuzSCny2b5wMfs7ZdSqAK15DVmMw4E0vGTouO/PfJk+CzjjRYOGNBHsLoUA8FM5dKXnKHGuB5pz2PsnuvPrHsJqoqsps6HvOWI1btie5FXlSDt60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=JcP1yE2j; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=G9WANNgemjSljHmF5fxsyBI1Tspalvb+P9kzgHNmMAo=; b=JcP1yE2jlb/gZ4sLQdWJSy9/NI
	nYUR73rgTxAtmejjvHkxbVTshLdlvaRCIs1tvihHfMLSvly4qkU/bkbP+crXopT5wF8bQW3PGIHU3
	d2vOoT5AeMAGaaYerLMqqN+v71+FgLtoAOon1fEqmrw3fV+bdt6cL9LUfrxqngKohjp6JvRc4qxlt
	yWZgYRe+nM0AsqcaAwNoxDRwUqTLIHwSdhr7rcGIP2VwAbNXSQebg9yEqs5/1oWVAFHGvcuf+OV11
	Nm1x+a85VPWWnhyjAcx0Bsjc4xhjgkxpquvbDG2o8qIq+o0kO8kxlSJCPvD//puaT8JIogHFmhpvu
	BFecs9xw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sxeAm-00000001U6q-0mP4;
	Mon, 07 Oct 2024 03:12:36 +0000
Date: Mon, 7 Oct 2024 04:12:36 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v2 3/4] ovl: convert ovl_real_fdget_path() callers to
 ovl_real_file_path()
Message-ID: <20241007031236.GI4017910@ZenIV>
References: <20241006082359.263755-1-amir73il@gmail.com>
 <20241006082359.263755-4-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241006082359.263755-4-amir73il@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Oct 06, 2024 at 10:23:58AM +0200, Amir Goldstein wrote:
> Stop using struct fd to return a real file from ovl_real_fdget_path(),
> because we no longer return a temporary file object and the callers
> always get a borrowed file reference.
> 
> Rename the helper to ovl_real_file_path(), return a borrowed reference
> of the real file that is referenced from the overlayfs file or an error.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/overlayfs/file.c | 70 +++++++++++++++++++++++++--------------------
>  1 file changed, 39 insertions(+), 31 deletions(-)
> 
> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> index 42f9bbdd65b4..ead805e9f2d6 100644
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c

> +static struct file *ovl_upper_file(const struct file *file, bool data)
>  {
>  	struct dentry *dentry = file_dentry(file);
>  	struct path realpath;
> @@ -193,12 +204,11 @@ static int ovl_upper_fdget(const struct file *file, struct fd *real, bool data)
>  	else
>  		type = ovl_path_real(dentry, &realpath);
>  
> -	real->word = 0;
>  	/* Not interested in lower nor in upper meta if data was requested */
>  	if (!OVL_TYPE_UPPER(type) || (data && OVL_TYPE_MERGE(type)))
> -		return 0;
> +		return NULL;
>  
> -	return ovl_real_fdget_path(file, real, &realpath);
> +	return ovl_real_file_path(file, &realpath);

AFAICS, we should never get NULL from ovl_real_file_path() now.

>  static int ovl_open(struct inode *inode, struct file *file)
> @@ -455,7 +465,7 @@ static ssize_t ovl_splice_write(struct pipe_inode_info *pipe, struct file *out,
>  
>  static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
>  {
> -	struct fd real;
> +	struct file *realfile;
>  	const struct cred *old_cred;
>  	int ret;
>  
> @@ -463,19 +473,17 @@ static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
>  	if (ret <= 0)
>  		return ret;
>  
> -	ret = ovl_upper_fdget(file, &real, datasync);
> -	if (ret || fd_empty(real))
> -		return ret;
> +	realfile = ovl_upper_file(file, datasync);
> +	if (IS_ERR_OR_NULL(realfile))
> +		return PTR_ERR(realfile);

... if so, the only source of NULL here would be the checks for OVL_TYPE_...
in ovl_upper_file().  Which has no other callers...

>  	/* Don't sync lower file for fear of receiving EROFS error */
> -	if (file_inode(fd_file(real)) == ovl_inode_upper(file_inode(file))) {
> +	if (file_inode(realfile) == ovl_inode_upper(file_inode(file))) {

Can that _not_ be true after the same checks in ovl_upper_file()?

