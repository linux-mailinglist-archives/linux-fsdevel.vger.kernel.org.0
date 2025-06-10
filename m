Return-Path: <linux-fsdevel+bounces-51192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F582AD43FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 22:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51E231886432
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 20:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A25265CA6;
	Tue, 10 Jun 2025 20:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="kJ1eWLiF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303A74685
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 20:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749587800; cv=none; b=eIINi0KSu7a2EXOIraq6+Ztz9schUjGcq9hzoi6WNT9MwCM/rhZ9AozhLRR1fFeQsB8efW+40gHGUpGAUVwgaCLEFutccAYAenvLJWnyYFgr+vbkqCdyx5ipuYooxYKXdWYE7UKhLFUCfqs427YeWRd/6JBSqCHsV/AOkux6cws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749587800; c=relaxed/simple;
	bh=QT4WoiJAjxyblAmDTJmo3GQkhyWhTYWexR6eeBZ2O+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ldYfZ7sdyYM7BIhQjm+sv34152LSzVjapnF+7ZHIozv9IHh+lUz1hOnf1Zyq947mdp5YarZfskRkAVUOw5bo7UfJCYY1XcL8WdmdjKvMELRKAbgJ6hE1E6RDkO/E886ywiMjofNEEROz8T6RLfkN2yrtNBa0QJLDcG/8iaC9+X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=kJ1eWLiF; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hB6/6CzVWdheqQegnFxIn5oopL9xhQCPO7pzzPct1jk=; b=kJ1eWLiFRDsKNY7HCupGE9kPrh
	6QypGtOVZaGZ/iuSX6v6TrtRhvKxLKz0oIkG7/xZHVQylvmZkyCIqm504lM7Sker1iNX39GT8otgB
	hbJBGZ+DYXHU9eWziPIOz9zLi7/xbeQaRpMopzT7EnZGQOynTpFslnCuzuUlMc6noeAQ/9oeswi3F
	C8GTMa7xhuVCKHZYhS4a7ujSGfMlbbc+NPnwTURPwQ4B/xts9WxKcsiiwjFy5+jALQIbEUw3aXlhy
	5xFywN7FCScq7S8FU23qkhFzmJs1n+eNkK6TuMjJyPvRVOMq9jkOfk4D2RbYcADBc/Qomhf9PaxHV
	VQrrw00Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uP5hv-0000000BNRT-3lnR;
	Tue, 10 Jun 2025 20:36:31 +0000
Date: Tue, 10 Jun 2025 21:36:31 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 7/8] VFS: use new dentry locking for create/remove/rename
Message-ID: <20250610203631.GF299672@ZenIV>
References: <20250609075950.159417-1-neil@brown.name>
 <20250609075950.159417-8-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609075950.159417-8-neil@brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jun 09, 2025 at 05:34:12PM +1000, NeilBrown wrote:
> After taking the directory lock (or locks) we now lock the target
> dentries.  This is pointless at present but will allow us to remove the
> taking of the directory lock in a future patch.
> 
> MORE WORDS

Such as "why doesn't it deadlock?", presumably, seeing that you have

> @@ -2003,7 +2003,14 @@ struct dentry *lookup_and_lock_hashed(struct qstr *last,
>  
>  	inode_lock_nested(base->d_inode, I_MUTEX_PARENT);
>  
> +retry:
>  	dentry = lookup_one_qstr(last, base, lookup_flags);
> +	if (!IS_ERR(dentry) &&
> +	    !dentry_lock(dentry, base, last, TASK_UNINTERRUPTIBLE)) {

... take dentry lock inside ->i_rwsem on parent and

>  bool lock_and_check_dentry(struct dentry *child, struct dentry *parent)
>  {
> -	inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
> -	if (child->d_parent == parent) {
> -		/* get the child to balance with dentry_unlock which puts it. */
> -		dget(child);
> -		return true;
> +	if (!dentry_lock(child, NULL, NULL, TASK_UNINTERRUPTIBLE))
> +		return false;
> +	if (child->d_parent != parent) {
> +		__dentry_unlock(child);
> +		return false;
>  	}
> -	inode_unlock(d_inode(parent));
> -	return false;
> +	/* get the child to balance with dentry_unlock() which puts it. */
> +	dget(child);
> +	inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);

... do the same in opposite order?

How could that possibly work?

