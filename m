Return-Path: <linux-fsdevel+bounces-31195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82450992F90
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 16:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 343841F23EFA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 14:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718681D6DBC;
	Mon,  7 Oct 2024 14:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="bZ51s+af"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45331D5CDB;
	Mon,  7 Oct 2024 14:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728311953; cv=none; b=kGapB8RDMyPsfbmxmVt3wvow0VUsJIuZX/ooEEbPFPOMJq2IgDm0T/hTKIJ+xTIujGKlRMQ1j8UlsmQ2+YsrNuHGLx/I192ZmSNa8EaLpy79P3jyvW7mKdSjF0I3jChANC36ylo9M4sg3r7cAcX+UIzmRxd6mH58Fpj8kwLeT2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728311953; c=relaxed/simple;
	bh=nFdT9QdBeoQDIzvLKB4HIp4MlsYJKM0mZEOf1bSejpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qM89FFfWA3XALv1Qu/L8ieqrJyaSpNPQYv01BMsv6ZJOH6bFtMz4QAkTWjyikVn3u9qRS7bz7O5FbAjDLf5WGiQYUpZZcGA2prrq++SbnKrZv3lFDDijn/6l6hwTFiopEbmVO01hmDsVIx1IiCFtbUd08zCYuJ7POqL3bSAo5w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=bZ51s+af; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mHCms9cJGFSTkAhxbPJ9FZITcyoFIwVEy8jZU5KN6yw=; b=bZ51s+afuP5F01BepGIr3653pP
	WamaAigHNl1iCC9qUfVOPlHfaS4t7DVr7ePmTdWuOAu7Qz9iEqtX8byrcL0t6uyhXp7/+MDVpMpwk
	WLeP6Q7DjEBk7IS5OJp+kr/hs5G/dKWfoqpFGOzpugdnDGgUa9Zc+LcoTX/w5e2BRv5FKwxQzrQSK
	HbcUO7Msn+x7q117I48Zf9JsQu+FFP1k4PtVcBzl7aY1P/7m9C+AcF15BX+pSXdf7HALWdCt5g+wn
	ynXO7zCzqh/H1hXDRtGqhQRFKhszHH0enaz7xThAa+pjHPJ25LYO55rk4At3pAggmtFfmjKvjNUSp
	2C6KatMA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sxotA-00000001c5B-3Be5;
	Mon, 07 Oct 2024 14:39:08 +0000
Date: Mon, 7 Oct 2024 15:39:08 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v3 1/5] ovl: do not open non-data lower file for fsync
Message-ID: <20241007143908.GK4017910@ZenIV>
References: <20241007141925.327055-1-amir73il@gmail.com>
 <20241007141925.327055-2-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007141925.327055-2-amir73il@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Oct 07, 2024 at 04:19:21PM +0200, Amir Goldstein wrote:
> +static int ovl_upper_fdget(const struct file *file, struct fd *real, bool data)
> +{
> +	struct dentry *dentry = file_dentry(file);
> +	struct path realpath;
> +	enum ovl_path_type type;
> +
> +	if (data)
> +		type = ovl_path_realdata(dentry, &realpath);
> +	else
> +		type = ovl_path_real(dentry, &realpath);
> +
> +	real->word = 0;
> +	/* Not interested in lower nor in upper meta if data was requested */
> +	if (!OVL_TYPE_UPPER(type) || (data && OVL_TYPE_MERGE(type)))
> +		return 0;
> +
> +	return ovl_real_fdget_path(file, real, &realpath);
>  }
>  
>  static int ovl_open(struct inode *inode, struct file *file)
> @@ -394,16 +411,14 @@ static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
>  	if (ret <= 0)
>  		return ret;
>  
> -	ret = ovl_real_fdget_meta(file, &real, !datasync);
> -	if (ret)
> +	/* Don't sync lower file for fear of receiving EROFS error */
> +	ret = ovl_upper_fdget(file, &real, datasync);
> +	if (ret || fd_empty(real))
>  		return ret;

Is there any real point in keeping ovl_upper_fdget() separate from the
only caller?  Note that the checks for type make a lot more sense
in ovl_fsync() than buried in a separate helper and this fd_empty()
is a "do we have the wrong type?" check in disguise.

Why not just expand it at the call site?

