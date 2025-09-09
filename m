Return-Path: <linux-fsdevel+bounces-60622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 032D9B4A510
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 10:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBA69541513
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 08:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94911255240;
	Tue,  9 Sep 2025 08:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="okPdENHF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059342522B6
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Sep 2025 08:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757405994; cv=none; b=XnBnUKnkCw+x8ZQyFuodeovw4RkncMpBylgEKAExOyZfZozX7Jos9jlopBeiysA6ZY8llltQYuH9FAY4yaWz9lqNP/96vvU3HgFXTsEyX6Uh208e+ghghHTmP/hq+ILQgj9YRziDxewYS3LbZhJxJxYSOi/WRta5mqaTTVr98AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757405994; c=relaxed/simple;
	bh=M/5W11Zi/MdAFGoW/qQRiFrw9o1+4l1dl2rqGHWTk0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYpq4yE9wpSA5JYEs2HhpFtgxh/u4iWWbcUMwERuwopt4bYRjcqdl04G3XT025qZPJcuuPakgwTf4Y1qgivjZiMh3ALpeNeG89ty4OP9LOYcf3hk6YKBmhdwCPcyWF5+ablVNTvsk2eJqXBGT+nVSCplLuu+EE0bxDGNugzUfa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=okPdENHF; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qwgqDRwq2WIULhlpNOrqUpu3cKGe2+56eELAS6XVsJo=; b=okPdENHFvfv1KO88Am2D1E1ur+
	2RmqtY0e0xyohf/z0W2+3kSBcScb/CMLZVFvt1/BsCixTieHhjKKv2JH5lnRkWxtu3qb5Da5mUYnf
	dUW+emreFj6AzT9Eq0Luv8qLuRCV4V9pEyjBEqatnxTulEd8cBpg5uQV33iY0BskVdkYbfc2ByfVY
	nyC67r/LZ8/qq1E3fYQSSOlG84TIki5/YYgejif6Td+0Iafn4CUckgFYP+Yb9r6hQAj5UpzIuBl3x
	uDrFGAWyI1yBNJq9XISND0GufkxENAOsEjL+iYvdAQz/GEwtJ61h0va1IawsapztbsKK5MQ2BOoRO
	lcF1msJQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvtZt-0000000GldW-1jip;
	Tue, 09 Sep 2025 08:19:49 +0000
Date: Tue, 9 Sep 2025 09:19:49 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: neil@brown.name
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] Use simple_start_creating() in various places.
Message-ID: <20250909081949.GM31600@ZenIV>
References: <20250909044637.705116-1-neilb@ownmail.net>
 <20250909044637.705116-8-neilb@ownmail.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909044637.705116-8-neilb@ownmail.net>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Sep 09, 2025 at 02:43:21PM +1000, NeilBrown wrote:

>  	d_instantiate(dentry, inode);
> -	dget(dentry);
> -fail:
> -	inode_unlock(d_inode(parent));
> -	return dentry;
> +	return simple_end_creating(dentry);

No.  This is the wrong model - dget() belongs with d_instantiate()
here; your simple_end_creating() calling conventions are wrong.

What really happens is a controlled leak.  simple_start_creating()
in the beginning is correct, but the right model here is to have
identical refcounting logics on the exits - the only difference
should be in having done that combination on success.

Please, leave those alone for now.

