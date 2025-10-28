Return-Path: <linux-fsdevel+bounces-65871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D34FEC129AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 02:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D2A4502EF2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 01:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775B62741A0;
	Tue, 28 Oct 2025 01:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Le8KjsBu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E8C263F28;
	Tue, 28 Oct 2025 01:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761616559; cv=none; b=YYMqFgRVxjerorRHujz+rrsKOADHPiFpTdJ52D0sIU6sw9V2rU0Q9GX7Z9YMqRlOsNt1+FaB+mz4CnHUpHrxuZKCrt9X9QiKYkxmkwU0bjQUMvl5vOMvWKNpXVlKlnLMnykN5zX4AnEpG9PqhmUECu0k0zrhUCgx+FBQMdGnM5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761616559; c=relaxed/simple;
	bh=2nWzQD7+/4f80rBQ1UVL9YpxO6XOr6j9T92xF5dMgPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVF0bAGizVRJgw1bpkqJgMneY37pDUlDlfQGRZZk0L2FMPxXvWvPnmDTcCHN2GxIyOonWnh57tzBdS7F/ppfi9lkaVcwlt9o6t6LbFfN4k0R8vtqPjcRkvXNStVgOweyrSQYkMeMj62ZrJ848cqaEfEF3IAzlyYdgSbe7XaSfqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Le8KjsBu; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NMWzOpxOLp7djj4rryockFPgtDMeGtwU0HcuCp9Qs50=; b=Le8KjsBu+85kzt1t4BL8YLSUCP
	aF48vXMeS/zemSMpkY8HqTGBwm0ZU5YrRhYzEC5oZEVC+l3smpfNXn666wRG/uExh/x7oN9MB9XOj
	zpeS72wOY36FmbBVPzYMMCQUKinAbkmV3tCxRZIrNthIThSX5espx/xsim9TTv3BqSJ5A3D6OV7Yi
	rK1NreXBBAvHNZiQc7rChyFRYtgOIkKQZt1TysBJYZfVG3/4CyNNL7QgtACAKJ466GTZWdbgE7ac4
	BJAPN7UfUYSWmql2NJztc1/1b1yzIJ4W5eLGvarO+t66RFki8ovME3q7knigxC7p/U+4mPtzoxn5X
	iyn+VxuQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDYwD-000000039xT-37LE;
	Tue, 28 Oct 2025 01:55:53 +0000
Date: Tue, 28 Oct 2025 01:55:53 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: torvalds@linux-foundation.org, brauner@kernel.org, jack@suse.cz,
	raven@themaw.net, miklos@szeredi.hu, neil@brown.name,
	a.hindborg@kernel.org, linux-mm@kvack.org,
	linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev,
	kees@kernel.org, rostedt@goodmis.org, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, paul@paul-moore.com,
	casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org,
	john.johansen@canonical.com, selinux@vger.kernel.org,
	borntraeger@linux.ibm.com, bpf@vger.kernel.org
Subject: Re: [PATCH v2 31/50] convert autofs
Message-ID: <20251028015553.GM2441659@ZenIV>
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
 <20251028004614.393374-32-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028004614.393374-32-viro@zeniv.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Oct 28, 2025 at 12:45:50AM +0000, Al Viro wrote:

> @@ -627,7 +626,7 @@ static int autofs_dir_unlink(struct inode *dir, struct dentry *dentry)
>  
>  	p_ino = autofs_dentry_ino(dentry->d_parent);
>  	p_ino->count--;
> -	dput(dentry);
> +	d_make_discardable(dentry);
>  
>  	d_inode(dentry)->i_size = 0;
>  	clear_nlink(d_inode(dentry));

BTW, is there any reason why autofs_dir_unlink() does not update
ctime of the parent directory?  Try it on a normal filesystem:

; mkdir foo
; touch foo/bar
; stat --printf='%z\n' foo
2025-10-27 21:40:03.489427380 -0400
; rm foo/bar
; stat --printf='%z\n' foo
2025-10-27 21:40:16.853470607 -0400

and note the change of ctime of directory reported after removing
an entry in it.   All Unices since v7 had been that way...

Why does autofs unlink() need to be different in that respect?
Some userland reasons?

