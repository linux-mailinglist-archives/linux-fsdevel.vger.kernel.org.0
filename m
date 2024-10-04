Return-Path: <linux-fsdevel+bounces-31040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B251199124B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 00:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D39BB2138C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 22:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40D11C8315;
	Fri,  4 Oct 2024 22:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="jlZ/6Epo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764341B4F1E;
	Fri,  4 Oct 2024 22:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728080712; cv=none; b=L+A1IRW7cFhj3N6xoZzPnHKBdS8f44APYjzzxsRsoStuAOCWmhNRXiVQvmDnzHJiK3uwDlgec9VzTGIVYwiDpg+NqB0olScShgMXqEva0taKWTaXMu96k6w9tB97mf5KQESlLhQCgbvJKhFPyY3vmrCpk2IF1ifor+VCGUc73dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728080712; c=relaxed/simple;
	bh=718nFn0lgDfUQ1ZMFTn33BbAvnCpsSDpVgkDJQJ0HKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HifiFRJbBY05iMQEaklE9QJpn8/FEBTbUpWa8PLsKrcaQOiXkKeozSA9kOSMl/udqSB13ODOppCs1ws7DBHy9h7ZvLPmuv3yDdUPdLhFTAweAb6/Qz7eEDOdel6gcurogZt6poGnO/dPrkU7GGMeQyEAPB3tolYCcNqPBwlK4oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=jlZ/6Epo; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DfYWmJxdWSL+JD7Z+9Szrtb4zLyvzXAqCc1exC92JrU=; b=jlZ/6Epo3tbfqxllT3xfD/UmId
	mJSm+UjBGL9uZEbGh3c7rDCvFLmGaklfrqB9Ym/hPWDs5z0CNv7sT401iqz/Yebzw2vD6JDyJ4siD
	11xCSW6hiruEh7o9vvLJBNbsSGdSpWK+mx1WGWKHHYSuCK26T20yxVwHqMCusEvymHlyf3wxFdtr4
	bBH2LPwodEfBUkjhjA8f3x1/BFuEhZpBiEQ403BAffDtCrE21auYBtJBDDXOG3qpBF7+38tbB+bkU
	X1RYiwRCn+FR0/QWNVSF0YA/TSgdzJas+1UbgYr1nhZ+7O5j/FgJoQ5oDFd9FZdoRb4dP2KFYbiFr
	hr61dqXQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1swqjU-00000000thV-42yA;
	Fri, 04 Oct 2024 22:25:09 +0000
Date: Fri, 4 Oct 2024 23:25:08 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH 4/4] ovl: convert ovl_real_fdget() callers to
 ovl_real_file()
Message-ID: <20241004222508.GT4017910@ZenIV>
References: <20241004102342.179434-1-amir73il@gmail.com>
 <20241004102342.179434-5-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004102342.179434-5-amir73il@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Oct 04, 2024 at 12:23:42PM +0200, Amir Goldstein wrote:
> -	ret = ovl_real_fdget(file, &real);
> -	if (ret)
> -		return ret;
> +	realfile = ovl_real_file(file);
> +	if (IS_ERR(realfile))
> +		return PTR_ERR(realfile);

> -	fd_file(real)->f_pos = file->f_pos;
> +	realfile->f_pos = file->f_pos;

Still an oops, unless I'm misreading that.

> +	realfile = ovl_real_file(file);
> +	if (IS_ERR(realfile))
> +		return PTR_ERR(realfile);
>  
> -	return ret;

so's this

> +	return backing_file_read_iter(realfile, iter, iocb, iocb->ki_flags,
> +				      &ctx);
>  }

... and all the way through the rest of this commit.

