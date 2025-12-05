Return-Path: <linux-fsdevel+bounces-70819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBACCCA7B92
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 14:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2742325FCE5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 13:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2C031D726;
	Fri,  5 Dec 2025 13:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6blm17K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B12F3148DB;
	Fri,  5 Dec 2025 13:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764940194; cv=none; b=QsfBP2oXtSZEnVdCG0YMIpiA3UAgB2+TZVbuksQwGnAbKC/9HrrrEtGLJ3PemECNC0LrNYiqWHNbC4SDj23TYuN6jojTtXJXBtBIV59SJ+uk1QuCvi0gkkwjiq0lA1Ce2Mi68jUPPKL8kjiC7hf7bxE6dtlgkiujMgTOx/eDmBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764940194; c=relaxed/simple;
	bh=9RNU4p5uFmDusX++mA9qmxru388NNiGnDSKeKxa8cHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9NCZ3LdpuqatC6fKbTGAwg9KmBcquD3z7708KBbL8DGMn+3Hxjdso51MeoxM03HysNXHu3XNCaE7969SRSl28s6g90YG7z70kOaUqdZiplvFxDxvc6+vMTfCSjGQfDKizlJEoLLW3CwXkpfret2Mpc35mp7RBQPAY9MxmDBTjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6blm17K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5E58C4CEF1;
	Fri,  5 Dec 2025 13:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764940192;
	bh=9RNU4p5uFmDusX++mA9qmxru388NNiGnDSKeKxa8cHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M6blm17KY/7Fq4E/y+hGFEVsLYFddZCYcUxIBMzoPfppxfvFklHuno+W5dLVHbLyU
	 w2jwooxrs+UVERpIVLszZHqL8Ehl2H1cjiNIE3120zTvz03YpYRpaTeqOkLaINb/nb
	 zuErmpPjOVfOjq2IQ2/soZP8Vdopaynk4/ICCE3cnwdaEHJy6HejOOPNUOMxSc74Yw
	 ZPD0ECuy7uAqjgJeho3o8qTmC7FN+47xrgd02l8E2C+BxMzHiQf/qgbHuZFjALtAYT
	 pnfnQsV5rOHOvHXwVprjTt2IuqljVra8/M62hXIPRouHbjdqZataGSgGdRwLlo5TtA
	 cbn/WwSlmrBMg==
Date: Fri, 5 Dec 2025 14:09:41 +0100
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Amir Goldstein <amir73il@gmail.com>, 
	NeilBrown <neil@brown.name>, Val Packett <val@packett.cool>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, David Howells <dhowells@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Tyler Hicks <code@tyhicks.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Olga Kornievskaia <okorniev@redhat.com>, 
	Dai Ngo <Dai.Ngo@oracle.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Steve French <smfrench@gmail.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Carlos Maiolino <cem@kernel.org>, John Johansen <john.johansen@canonical.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Mateusz Guzik <mjguzik@gmail.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Stefan Berger <stefanb@linux.ibm.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	ecryptfs@vger.kernel.org, linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-xfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Subject: Re: [PATCH] fuse: fix conversion of fuse_reverse_inval_entry() to
 start_removing()
Message-ID: <20251205-unmoralisch-jahrtausend-cca02ad0e4fa@brauner>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegs+o01jgY76WsGnk9j41LS5V0JQSk--d6xsJJp4VjTh8Q@mail.gmail.com>

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
> 
> Attaching untested patch to remove this cruft.

Should we revert the fuse specific bits of c9ba789dad15 ("VFS: introduce
start_creating_noperm() and start_removing_noperm()") and then apply
your changes afterwards?

