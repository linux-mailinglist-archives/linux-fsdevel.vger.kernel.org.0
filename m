Return-Path: <linux-fsdevel+bounces-31039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 941C2991242
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 00:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2F761C22F83
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 22:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A7E1AE01F;
	Fri,  4 Oct 2024 22:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="qRB8lSft"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249ED140E34;
	Fri,  4 Oct 2024 22:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728080612; cv=none; b=C96HN31AZt4w2CXH7Zn1mBwPX/oOQ92BKgrX/qtowJE+xG4LZyMlXepp9UfvrNKbxrK076eBXD/S99wGpnOqO9CKAAZ1z00VyM2qSxOyta/MvOF4tc1G+k/zByuNRTWC0OIiSsX4X2npo0tGIMd4jiYvEcNZWAOJl/XujPhggbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728080612; c=relaxed/simple;
	bh=+5Grnwuu8udR7xaCl37ZHVxjNiRp5hclXpp5z9DGLbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QlI5exCiKIVVi2179W/YxQ30EzZ6r233hh8eaPx5VC3mScs1uav6Fpo+fnIpty6DFFmyYIhqpLT/e6qcBdHsev5iVBA92zH2L4jTLoNP+VUnQyqYmEEwRss5VHq783hRDbkaxGhcsYvicg9UADggCOIGCk4jw3QZCmUZtSB30T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=qRB8lSft; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=q7xQKrCq2CyZwF9Mcl51AHzWmPJiQIIOGZ904YfPVEI=; b=qRB8lSftbmT1YgxGEbixZklK39
	g8QW8a0tbrV9Qe6m4MD9gKcNfgrdT1EeeiEZ39jDekgr6YmGMTONAItacGIYshoPmeA1o5peWR3M3
	MSATxnAbSuWUXDci3EpyL1i3e/eejL5DAH2X/+VLTdbfLtsNsGQ7WZ8t4yYhYBB/CgKeFjULP4hZa
	JT1aKQzO1jF4H0yOLqn0YvZ2j2T6FfGtitiTfN+7u+hH0BK9ENSQHp1UZDgmCDqrBu9XdjWo3csE4
	EbycnJuk8HNnQXugDEkRc76xyqUviRHzQAyTSO4m69ZESuJjsN4b/i5h6tiQy3Wld6JLyAnvd/+r8
	E5u+Fmgw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1swqhn-00000000tgM-44gJ;
	Fri, 04 Oct 2024 22:23:24 +0000
Date: Fri, 4 Oct 2024 23:23:23 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH 3/4] ovl: convert ovl_real_fdget_meta() callers to
 ovl_real_file_meta()
Message-ID: <20241004222323.GS4017910@ZenIV>
References: <20241004102342.179434-1-amir73il@gmail.com>
 <20241004102342.179434-4-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004102342.179434-4-amir73il@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Oct 04, 2024 at 12:23:41PM +0200, Amir Goldstein wrote:

>  	if (upper_meta) {
>  		ovl_path_upper(dentry, &realpath);
>  		if (!realpath.dentry)
> -			return 0;
> +			return NULL;
>  	} else {
>  		/* lazy lookup and verify of lowerdata */
>  		err = ovl_verify_lowerdata(dentry);
>  		if (err)
> -			return err;
> +			return ERR_PTR(err);

Ugh...  That kind of calling conventions is generally a bad idea.

> +	return realfile;

... especially since it's NULL/ERR_PTR()/pointer to object.


> +	realfile = ovl_real_file_meta(file, !datasync);
> +	if (IS_ERR_OR_NULL(realfile))
> +		return PTR_ERR(realfile);

Please, don't.  IS_ERR_OR_NULL is bogus 9 times out of 10 (at least).
And you still have breakage in llseek et.al.

