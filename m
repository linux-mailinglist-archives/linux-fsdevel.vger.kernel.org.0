Return-Path: <linux-fsdevel+bounces-70360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 40073C986A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 18:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 55A4634426C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 17:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C30C335BBE;
	Mon,  1 Dec 2025 17:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="m6tHBhvO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E83733468A;
	Mon,  1 Dec 2025 17:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764608892; cv=none; b=SS83MYQ3XFL0X6sQHYxcuCmb1/FSKkLWrud0Kz2LOtjuP8s2QtxBm8x0EB1iH90ASugqFdoA6dQMf2QnsJqeTMRs/22ygTiEyV6I9a+gmDx/Y/b56W1FFTeUeuB06mkeu/7xJp+ADHl1yvlskToXWpWdcTNrN4QZFytKCMBMP7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764608892; c=relaxed/simple;
	bh=c1hVLffTbOic9SRKj/Vx/1bE1OkZBkKNJY7xX1j8I3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=POLJ7GqLU0xad/kS7ZBYwoaCtaRRMzoPMX64BPxA+oAmnqZ0ArJd8KF/WiRHAGdh9WmWzYzbuXcdGIytRXkS9IJNwvBLhU6wWpsSRAx4WJ31CJtLPlEpMFunyNQBoUAloCFrGF8eRgJ+Te5OBoK/MbwofYifLKwOk5rc+QCldP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=m6tHBhvO; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=chyrhP448TKCA7mjR+pn/4FRynfEGDb/eEOSGrjCi48=; b=m6tHBhvODjORIENDeypTobyuUz
	dAfJPXFwkttmrEIudNiC+eJ++pHJAehlDyTlgb+ujjJWYhGYSpXw0zgCrIZdzySovjHT9cA2lZ7cz
	jzkoihgeSwKZL/QyryX0gMwRMsHu9fIKtRAIcuexFdlw2rHqKpYf1jthXT46t235cSaPO8XhxuaTe
	UAahQWu4SoOIcWhhn/JZl9xBFfE56iKVrlHQOW3w03FPhCGJmpbu8/gQLozFObDI4/H9EJOOIPMa2
	/2Q76hpj/QtV0dHTpaDtoXdZQnJPZ4t9wMlA/K+oYAUz07/WLzmLSKsNCsBoZqTGtGNhzD+M8DpUC
	vLmNTgIw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vQ7Nl-000000041Kz-21Ah;
	Mon, 01 Dec 2025 17:08:13 +0000
Date: Mon, 1 Dec 2025 17:08:13 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>, NeilBrown <neil@brown.name>,
	Christian Brauner <brauner@kernel.org>,
	Val Packett <val@packett.cool>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	David Howells <dhowells@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Tyler Hicks <code@tyhicks.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Carlos Maiolino <cem@kernel.org>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev, ecryptfs@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
	linux-cifs@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH] fuse: fix conversion of fuse_reverse_inval_entry() to
 start_removing()
Message-ID: <20251201170813.GH3538@ZenIV>
References: <20251113002050.676694-1-neilb@ownmail.net>
 <20251113002050.676694-7-neilb@ownmail.net>
 <6713ea38-b583-4c86-b74a-bea55652851d@packett.cool>
 <176454037897.634289.3566631742434963788@noble.neil.brown.name>
 <CAOQ4uxjihcBxJzckbJis8hGcWO61QKhiqeGH+hDkTUkDhu23Ww@mail.gmail.com>
 <20251201083324.GA3538@ZenIV>
 <CAJfpegs+o01jgY76WsGnk9j41LS5V0JQSk--d6xsJJp4VjTh8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegs+o01jgY76WsGnk9j41LS5V0JQSk--d6xsJJp4VjTh8Q@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Dec 01, 2025 at 03:03:08PM +0100, Miklos Szeredi wrote:
> On Mon, 1 Dec 2025 at 09:33, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Mon, Dec 01, 2025 at 09:22:54AM +0100, Amir Goldstein wrote:
> >
> > > I don't think there is a point in optimizing parallel dir operations
> > > with FUSE server cache invalidation, but maybe I am missing
> > > something.
> >
> > The interesting part is the expected semantics of operation;
> > d_invalidate() side definitely doesn't need any of that cruft,
> > but I would really like to understand what that function
> > is supposed to do.
> >
> > Miklos, could you post a brain dump on that?
> 
> This function is supposed to invalidate a dentry due to remote changes
> (FUSE_NOTIFY_INVAL_ENTRY).  Originally it was supplied a parent ID and
> a name and called d_invalidate() on the looked up dentry.
> 
> Then it grew a variant (FUSE_NOTIFY_DELETE) that was also supplied a
> child ID, which was matched against the looked up inode.  This was
> commit 451d0f599934 ("FUSE: Notifying the kernel of deletion."),
> Apparently this worked around the fact that at that time
> d_invalidate() returned -EBUSY if the target was still in use and
> didn't unhash the dentry in that case.
> 
> That was later changed by commit bafc9b754f75 ("vfs: More precise
> tests in d_invalidate") to unconditionally unhash the target, which
> effectively made FUSE_NOTIFY_INVAL_ENTRY and FUSE_NOTIFY_DELETE
> equivalent and the code in question unnecessary.
> 
> For the future, we could also introduce FUSE_NOTIFY_MOVE, that would
> differentiate between a delete and a move, while
> FUSE_NOTIFY_INVAL_ENTRY would continue to be the common (deleted or
> moved) notification.

Then as far as VFS is concerned, it's an equivalent of "we'd done
a dcache lookup and revalidate told us to bugger off", which does
*not* need locking the parent - the same sequence can very well
happen without touching any inode locks.

IOW, from the point of view of locking protocol changes that's not
a removal at all.

Or do you need them serialized for fuse-internal purposes?

