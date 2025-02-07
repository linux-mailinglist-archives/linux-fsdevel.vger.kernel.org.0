Return-Path: <linux-fsdevel+bounces-41262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4807DA2CEF4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 22:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D594216CCA4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 21:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC571B415B;
	Fri,  7 Feb 2025 21:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="sRirHqLu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D22D194C6A;
	Fri,  7 Feb 2025 21:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738963300; cv=none; b=ThShfdl143m+5RJWOpoTSxMi0AaTR8d8P95Zhwcyly8G2lIBPsXCCQBxw9CrC/1Kp0sEcYh3OplF9EpLpmumHSqSCUBSEZ7QKrhd+sKaglSIuU+4D+yLLW5O97R583p3z4Jf67Y9O0oDOtmlbTKP6RXw9mCCC+IebOq1BpbBas4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738963300; c=relaxed/simple;
	bh=BontzDLjJ15h+ze4L5vRIqhgs689fkecvFqrORFNUmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OfIao5msGjqNdZF8dOS3/2ZucaiTtqeQJ8ZwRxy+HVmbitPLB0uM1GTogogD9TcbXOaPERqEgd1yqbvDqXVDnVJwWDl3io1e8DquBNcnlfQEHimx+IEIpcuvhAk8zPWHFVTQiA9On+RYpRjog3OwBBEEQRyFupLDko0wImf7TME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=sRirHqLu; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EEjc3DEsH7APDdwZngZG2EOIvCVOnKqAX59Ln7CAbd0=; b=sRirHqLu97WmK9iC9PRJOVr1TK
	473TN4H81011xT6522lJmfI4J9Gie7L025SpWri6JGZ5DilSp4KSq8xXu4EdVA5ijIW+yjugAszqU
	D9nL8Yo2NLVgzRG3L8iivkWYb2fP39k44uVZGVLC25UtFRHzWMp529KdtDsLkum5Cw0gPZmwheCCk
	xJcBW/mKWbYircQOZQKrb+PRg9pRs6ygPRgdnBVVpPkrL9z0jB0HWq2cNLARlZtbALB0cB8LQ/0jC
	TgfLQwuzE3quWkA29LYtEuGUpMOND2fKYSSL1PVrBjQhOBCrsBXvTbrnl52zuVApNWK5RkrtuQkHL
	YioaMVcQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tgVn5-00000006bhw-0rNI;
	Fri, 07 Feb 2025 21:21:35 +0000
Date: Fri, 7 Feb 2025 21:21:35 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/19] VFS: add lookup_and_lock_rename()
Message-ID: <20250207212135.GL1977892@ZenIV>
References: <20250206054504.2950516-1-neilb@suse.de>
 <20250206054504.2950516-17-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206054504.2950516-17-neilb@suse.de>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Feb 06, 2025 at 04:42:53PM +1100, NeilBrown wrote:
> @@ -3451,8 +3451,14 @@ static struct dentry *lock_two_directories(struct dentry *p1, struct dentry *p2)
>  {
>  	struct dentry *p = p1, *q = p2, *r;
>  
> -	while ((r = p->d_parent) != p2 && r != p)
> +	/* Ensure d_update_wait() tests are safe - one barrier for all */
> +	smp_mb();
> +
> +	d_update_wait(p, I_MUTEX_NORMAL);
> +	while ((r = p->d_parent) != p2 && r != p) {
>  		p = r;
> +		d_update_wait(p, I_MUTEX_NORMAL);
> +	}
>  	if (r == p2) {
>  		// p is a child of p2 and an ancestor of p1 or p1 itself
>  		inode_lock_nested(p2->d_inode, I_MUTEX_PARENT);
> @@ -3461,8 +3467,11 @@ static struct dentry *lock_two_directories(struct dentry *p1, struct dentry *p2)
>  	}
>  	// p is the root of connected component that contains p1
>  	// p2 does not occur on the path from p to p1
> -	while ((r = q->d_parent) != p1 && r != p && r != q)
> +	d_update_wait(q, I_MUTEX_NORMAL);
> +	while ((r = q->d_parent) != p1 && r != p && r != q) {
>  		q = r;
> +		d_update_wait(q, I_MUTEX_NORMAL);
> +	}

That makes no sense whatsoever.  What are you waiting on here and _why_
are you waiting on those sucker?  Especially since there's nothing
to prevent the condition for which you wait from arising immediately
afterwards.

