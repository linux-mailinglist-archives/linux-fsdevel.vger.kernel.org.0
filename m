Return-Path: <linux-fsdevel+bounces-41339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54174A2E06E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 21:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3153164AB5
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 20:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF7B1E32C5;
	Sun,  9 Feb 2025 20:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="MeaJwEwy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52F6250F8;
	Sun,  9 Feb 2025 20:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739132609; cv=none; b=P+yL1k4eEwSkeOCFiB7fHIimyzETuwGXU6hcFu7dRVK5I609sgNeO+2O+HEp/MUxo9g4B5VkHArNaNE9ahudMQqrY9jvVu00jwwLwR7kgg83GP/j1fBFHlNvKy8j2Du3zN3pI1mfF6ZkKl+gpBLaYjhahUrIyccwHZ2wAoIUW2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739132609; c=relaxed/simple;
	bh=jO605okd1tfzhgBAEcDZydSvOpx8sTMNaAcrLZNRYtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jx8dP8pSqi8sg1Ox1QbEgBJGNpEzSQQ5mYqeGMhnc/S18CNK2RzSjxm0sM6rp2UeTgOOyj5lHDa2TCqsXBsrRUs5KrBiKD6ANkt1MyZWftInMnMHwD6bB3lxOA4YEGabjlhT4uWqBulP/kEpFTmU1O6+G4dBI/cmD7Hfsn9Odzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=MeaJwEwy; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hSHUOfmSurRP+UkGl/1d8MMhlREGrFzs3VJBi34Rai0=; b=MeaJwEwyj7G5OKjTtn83B+8b+K
	VRZz5O+CDzh2O/Rb60TUINPbDgleDMx7Y3zl5Qxv+4jk3kt/iqQLp5vFCC+g5j3tZHu8twfGa6Lof
	5HUNZoAKSVAKxUYjqRcswO0CcKFGrZTXns+WtrFwMfK7TpnmrZCIqJ3nerElrLIcReeNEykbmNeoI
	dQkHc8kD76w8wKfyUaq3Q6yL4R/636Si5TJEezD363oaJvXcuzKjrlaLlK0nQXHGsOoCHkbuJirMd
	6wY72XpLSElGxPyGy5G3qJSV2/NOh5REJiGp2pqqV3ErrVS9FkmXqNKlpvmW+h4dDwiISP5ZhoDvI
	zXHvSdxA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1thDpr-00000008iPs-2cBD;
	Sun, 09 Feb 2025 20:23:23 +0000
Date: Sun, 9 Feb 2025 20:23:23 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/19] VFS: add common error checks to lookup_one_qstr()
Message-ID: <20250209202323.GW1977892@ZenIV>
References: <20250206054504.2950516-1-neilb@suse.de>
 <20250206054504.2950516-6-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206054504.2950516-6-neilb@suse.de>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Feb 06, 2025 at 04:42:42PM +1100, NeilBrown wrote:

> @@ -1700,6 +1702,15 @@ struct dentry *lookup_one_qstr(const struct qstr *name,
>  	if ((flags & LOOKUP_INTENT_FLAGS) == 0)
>  		/* ->lookup must have given final answer */
>  		d_lookup_done(dentry);
> +found:
> +	if (d_is_negative(dentry) && !(flags & LOOKUP_CREATE)) {
> +		dput(dentry);
> +		return ERR_PTR(-ENOENT);
> +	}
> +	if (d_is_positive(dentry) && (flags & LOOKUP_EXCL)) {
> +		dput(dentry);
> +		return ERR_PTR(-EEXIST);
> +	}

Final dput() on an in-lookup dentry would blow up.  What happens if we get
there without LOOKUP_CREATE, but with something else from LOOKUP_INTENT_FLAGS?

That, BTW, is another lovely example of the reasons why making state (in-lookup
in this case, locking elsewhere) transitions dependent upon the function arguments
is a bad idea.

