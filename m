Return-Path: <linux-fsdevel+bounces-66353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E72EC1CA1E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 18:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 26D564E3C9B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 17:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4A5354AD3;
	Wed, 29 Oct 2025 17:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ZqaowaHD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA923491F4;
	Wed, 29 Oct 2025 17:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761760514; cv=none; b=D6H4Gyp264daYZtZZ9tYtzyOb2iSnASToyWV1fHwveccQDJKZlcR7CntElKmHMV58n+OvTJak+xEqlEO3CzqxUBKG/BfCVqljiQAF8GxAeQ+efEYGtHO6dsRUUxbcSUYFNeFLw1PcHnN7rOhAMS5w38sVNrDr5xCsOBWvROeSOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761760514; c=relaxed/simple;
	bh=Giqyu8AnZs8eC9Lv6DdMItTT9K2cqweT89MM0MXC6us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6HQz5v5m901vXzkOOOJKi6+I/JjF5WwUkTA8qkP+It1ZvSpJyPpWs5G6KKLIIF+t8/03MfGiUoTPJiVBNn9jndI0mmqcJry+6xdBRjPgmMTySCrhLzbrvDrX1J9VwNz+ZRordNM08FLFqf4acVXsvmztm/AB8fdl23V7i+47MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ZqaowaHD; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hxMUsVatKbWhonDVOdoqCw+QvpkWu6d9zu8seRb9LV0=; b=ZqaowaHDIWj01NIds+0TIejsHt
	XNcqF3EBDGWDHrewmjlpyIq2j0AgqblkrtlOkNOTt0EWqIzLaIERrwPKq5f9eNXMv1aTIGZLrQ1HH
	rg+ZORmt81RyG2qU67dv5WXr9ri4iBeQWNdeCGFu2fJJBw6MQcvPU6Grbx5t8CCUE+O3sDZ3z4Rll
	aINFtyxUrztNEHbgUWxk5lOkAAe1TpMz3bbiONo/ap2hMi1ciYOvoU4Vv8C738OFzygsdk1MinKCa
	dWoo2gHYZrrQJ6fr+RoKVyeWfb/xKGz1vuqhGzuDHVmJn/TDzmK0rUjeCaSxWOI8aYuDR7FgWfWEr
	uT4IVvCQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEANx-0000000D7rD-0xCn;
	Wed, 29 Oct 2025 17:55:01 +0000
Date: Wed, 29 Oct 2025 17:55:01 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mark Tinguely <mark.tinguely@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
	brauner@kernel.org, jack@suse.cz, raven@themaw.net,
	miklos@szeredi.hu, neil@brown.name, a.hindborg@kernel.org,
	linux-mm@kvack.org, linux-efi@vger.kernel.org,
	ocfs2-devel@lists.linux.dev, kees@kernel.org, rostedt@goodmis.org,
	gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	paul@paul-moore.com, casey@schaufler-ca.com,
	linuxppc-dev@lists.ozlabs.org, john.johansen@canonical.com,
	selinux@vger.kernel.org, borntraeger@linux.ibm.com,
	bpf@vger.kernel.org
Subject: Re: [External] : [PATCH v2 07/50] convert
 simple_{link,unlink,rmdir,rename,fill_super}() to new primitives
Message-ID: <20251029175501.GS2441659@ZenIV>
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
 <20251028004614.393374-8-viro@zeniv.linux.org.uk>
 <3ec6f671-c490-42f2-b38b-f1fa20c60da2@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ec6f671-c490-42f2-b38b-f1fa20c60da2@oracle.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Oct 29, 2025 at 09:02:33AM -0500, Mark Tinguely wrote:
> On 10/27/25 7:45 PM, Al Viro wrote:
> > Note that simple_unlink() et.al. are used by many filesystems; for now
> > they can not assume that persistency mark will have been set back
> > when the object got created.  Once all conversions are done we'll
> > have them complain if called for something that had not been marked
> > persistent.
> > 
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > ---
> >   fs/libfs.c | 10 +++++-----
> >   1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/libfs.c b/fs/libfs.c
> > index a033f35493d0..80f288a771e3 100644
> > --- a/fs/libfs.c
> > +++ b/fs/libfs.c
> 
> ...
> 
> >   EXPORT_SYMBOL(simple_unlink);
> > @@ -1078,7 +1077,8 @@ int simple_fill_super(struct super_block *s, unsigned long magic,
> >   		simple_inode_init_ts(inode);
> >   		inode->i_fop = files->ops;
> >   		inode->i_ino = i;
> > -		d_add(dentry, inode);
> > +		d_make_persistent(dentry, inode);
> > +		dput(dentry);
> >   	}
> >   	return 0;
> >   }
> 
> Putting on the dunce hat for the rest of us:
> 
> I think I understand the dput() for d_add() changes, but it is non-obvious.
> Thinking of future maintenance, you may want to make a comment.

As in
		dput(dentry);	// paired with d_alloc_name()
or
		dput(dentry);	// that would've been simple_done_creating(),
				// if we bothered with directory lock here
or...?

The thing is, d_alloc_name()/dput() instead of simple_start_creating()/
simple_done_creating() is a bit of a shortcut, possible since we
	* know that in this case nobody else could access that fs
(we are in the middle of setting it up)
	* know that directory we are populating started empty (we'd just
created it) and nobody else had a chance to mess with it (see above)
	* trust the caller to have all names in files[] array valid and
unique

And for simple_fill_super() that's pretty straightforward, but in other 
cases...  Rationale for taking that shortcut needs to be good.

