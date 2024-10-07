Return-Path: <linux-fsdevel+bounces-31219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0DA99342A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 18:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F12A1C20434
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 16:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54DA1DD54D;
	Mon,  7 Oct 2024 16:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="DH7kfAZG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815831DD540;
	Mon,  7 Oct 2024 16:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728320145; cv=none; b=GKa2aeITeO0+cE+nJ0BkpsIiLjdrBLrpPUbhzIXBmACyz+INitnK9n9etjWkWXb1M7eg1xc1JMVmhpTucHobGi3JJ38yUCj3Jlu3uB2Eih96qUpF7UwkZo4Ep4ueSyZP40p3FRP4Cu3sPatuA7EsQ5rcUyhUU242lMvzXoCXBzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728320145; c=relaxed/simple;
	bh=rEoRj54Zi2vbI08YVZ5dfNVwuRg26U3vrODGYxYWpzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nc/jxFo9tPFWXaCgq8Se+5YRfYBRJ2awn0SjgrDjwkxrHNF7cjs3HBD5IR/MsfVOsRggkItrY6UQncGhHSmeoSwHSWHlLnWMnbTlDxaH17IzNtv6VXOZEZkPj0aqC6ag7tLo9MxuJDqtpbNuk7VdXV3jXnmJVNIRnnN2MDff33I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=DH7kfAZG; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=P7ah67g70yHoJ5IWW6Bl5ziDa5azCVHQ/VHlRqt0q1Y=; b=DH7kfAZGsaPzLptOMKxrTAdPPW
	NIfnz5LtDlK8XWftGDZskPAP+fyU22Y5yWvryKSpVFx/ctDQkrdafnHrhl01nsAMV1x0GpodJ3P2Y
	dyNGj2aCOUwxDLbyPfQOqoA5p7ClCJux03+LwUlHHYGX2mTzAsPcDSkM4CXukllPxxCO/s0sjgarN
	fe5lvKaConEu1+j4P7TBYKhmJ2xzeiA6XK8SWJVm5kC+gEXH1tP1ZIa6pufe/KXNn2y+oU2we4Ajt
	tflhOD/mM0xLXH2k5IhMrbSLXkAUEEmKKiacd8O+9xLJ55DYxp0kJOfqqqJ50d/DblLKGZLyhpKj9
	KzA7q9Pg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sxr1I-00000001eDs-1Cag;
	Mon, 07 Oct 2024 16:55:40 +0000
Date: Mon, 7 Oct 2024 17:55:40 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v3 1/5] ovl: do not open non-data lower file for fsync
Message-ID: <20241007165540.GN4017910@ZenIV>
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
> +static int ovl_real_fdget_path(const struct file *file, struct fd *real,
> +			       struct path *realpath)

> -	if (allow_meta) {
> -		ovl_path_real(dentry, &realpath);
> -	} else {
> -		/* lazy lookup and verify of lowerdata */
> -		err = ovl_verify_lowerdata(dentry);
This check went
> -		if (err)
> -			return err;
> -
> -		ovl_path_realdata(dentry, &realpath);
> -	}

> @@ -138,7 +129,33 @@ static int ovl_real_fdget(const struct file *file, struct fd *real)
>  		return 0;
>  	}
>  
> -	return ovl_real_fdget_meta(file, real, false);
> +	/* lazy lookup and verify of lowerdata */
> +	err = ovl_verify_lowerdata(dentry);

... here

> +	if (err)
> +		return err;
> +
> +	ovl_path_realdata(dentry, &realpath);

> +static int ovl_upper_fdget(const struct file *file, struct fd *real, bool data)
> +{
> +	struct dentry *dentry = file_dentry(file);
> +	struct path realpath;
> +	enum ovl_path_type type;
> +
> +	if (data)
> +		type = ovl_path_realdata(dentry, &realpath);

... but not here.

I can see the point of not doing that in ->fsync() after we'd already
done ovl_verify_lowerdata() at open time, but what's different about
->read_iter() and friends that also come only after ->open()?
IOW, why is fdatasync() different from other data-access cases?

