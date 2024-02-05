Return-Path: <linux-fsdevel+bounces-10294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0723A8499F4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 13:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C97B1F288FB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 12:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A11D1BDDF;
	Mon,  5 Feb 2024 12:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NI3CgvHq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0871BC3A;
	Mon,  5 Feb 2024 12:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707135609; cv=none; b=M32jxlRBK1Bi6wxXjgj0BBINnZRF+0XWhCWaPp07HLb/BetPSDkJOdLJmkcIX7VlL4f220jhISRmeH8R/FLdg6b9419pi7nlunMMpombtN0j2qbXUEK/d0e3+/yX0lKqLBXB5cyDoR5flBKYLy7aNXijhr7YuKqVUjboV68h8mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707135609; c=relaxed/simple;
	bh=7//g9J4D+ZXpm9UU4QExrEcw6hVi83+PWFQfkzUzwQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umu2cF5gD4dIt1c6IXxfxrL2lFRXkhDJf4rB+/onymC6e20b4ahpfIMNUpr5g3Q7WkAYNyTFtOQYuUMfUE6BOjITaSf91ZfIMovJJEPpDwdp8fYIgFPylIW4u3e6r3G0mXkaWakEFpuxdOtDDSZgz/E0iM0JaKHoCQ6AGdDhn/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NI3CgvHq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6DC7C433F1;
	Mon,  5 Feb 2024 12:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707135609;
	bh=7//g9J4D+ZXpm9UU4QExrEcw6hVi83+PWFQfkzUzwQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NI3CgvHqbCduKOUG55PcantMhEuO6cn+Q82WktDz/McB8+xXuzAr9oWfxBNRDlJIq
	 EUGGrhAl14I7YROetxKLGMcqGt8Ru+AmVB9bfDoQy4MxBuJTscGI6an5jXX1a1UxlY
	 iH0tINjNfz+a+kl3LaOWdJAlnwQq7npi5RyjBS1soNm/JRgw9c+6hBFsGgc/vYpFgs
	 dev0mLv7LL+uzC+/lrHORqWInlmNXxUEGlfF+z82l0aWpZ8rLwcWppSKbu1HoVVCxo
	 MqPT8nFMBRA5HdSKbdJcN8lFf+Y1tStm+kUjtpb43bBeSysyW23YnK908iHBQqL4uI
	 oEI2OhqzX3GkA==
Date: Mon, 5 Feb 2024 13:19:57 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, David Howells <dhowells@redhat.com>, 
	Marc Dionne <marc.dionne@auristor.com>, Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
	Alexander Aring <aahringo@redhat.com>, David Teigland <teigland@redhat.com>, 
	Andreas Gruenbacher <agruenba@redhat.com>, Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, 
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Trond Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, Mark Fasheh <mark@fasheh.com>, 
	Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Namjae Jeon <linkinjeon@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, v9fs@lists.linux.dev, linux-afs@lists.infradead.org, 
	ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, linux-cifs@vger.kernel.org
Subject: Re: [PATCH v3 04/47] filelock: add some new helper functions
Message-ID: <20240205-fragil-begraben-4b78fd1b5981@brauner>
References: <20240131-flsplit-v3-0-c6129007ee8d@kernel.org>
 <20240131-flsplit-v3-4-c6129007ee8d@kernel.org>
 <20240205-wegschauen-unappetitlich-2b0926023605@brauner>
 <de77ec5ade7fac7e72445cb2d10d95efe8bf9c92.camel@kernel.org>
 <20240205-laufen-hosen-38578e076df5@brauner>
 <f7ec5cfe94ff1472e309e8c4d92f24f2fc6cd618.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f7ec5cfe94ff1472e309e8c4d92f24f2fc6cd618.camel@kernel.org>

On Mon, Feb 05, 2024 at 07:06:00AM -0500, Jeff Layton wrote:
> On Mon, 2024-02-05 at 12:57 +0100, Christian Brauner wrote:
> > On Mon, Feb 05, 2024 at 06:55:44AM -0500, Jeff Layton wrote:
> > > On Mon, 2024-02-05 at 12:36 +0100, Christian Brauner wrote:
> > > > > diff --git a/include/linux/filelock.h b/include/linux/filelock.h
> > > > > index 085ff6ba0653..a814664b1053 100644
> > > > > --- a/include/linux/filelock.h
> > > > > +++ b/include/linux/filelock.h
> > > > > @@ -147,6 +147,29 @@ int fcntl_setlk64(unsigned int, struct file *, unsigned int,
> > > > >  int fcntl_setlease(unsigned int fd, struct file *filp, int arg);
> > > > >  int fcntl_getlease(struct file *filp);
> > > > >  
> > > > > 
> > > > > 
> > > > > 
> > > > > 
> > > > > 
> > > > > 
> > > > > 
> > > > > +static inline bool lock_is_unlock(struct file_lock *fl)
> > > > > +{
> > > > > +	return fl->fl_type == F_UNLCK;
> > > > > +}
> > > > > +
> > > > > +static inline bool lock_is_read(struct file_lock *fl)
> > > > > +{
> > > > > +	return fl->fl_type == F_RDLCK;
> > > > > +}
> > > > > +
> > > > > +static inline bool lock_is_write(struct file_lock *fl)
> > > > > +{
> > > > > +	return fl->fl_type == F_WRLCK;
> > > > > +}
> > > > > +
> > > > > +static inline void locks_wake_up(struct file_lock *fl)
> > > > > +{
> > > > > +	wake_up(&fl->fl_wait);
> > > > > +}
> > > > > +
> > > > > +/* for walking lists of file_locks linked by fl_list */
> > > > > +#define for_each_file_lock(_fl, _head)	list_for_each_entry(_fl, _head, fl_list)
> > > > > +
> > > > 
> > > > This causes a build warning for fs/ceph/ and fs/afs when
> > > > !CONFIG_FILE_LOCKING. I'm about to fold the following diff into this
> > > > patch. The diff looks a bit wonky but essentially I've moved
> > > > lock_is_unlock(), lock_is_{read,write}(), locks_wake_up() and
> > > > for_each_file_lock() out of the ifdef CONFIG_FILE_LOCKING:
> > > > 
> > > 
> > > I sent a patch for this problem yesterday. Did you not get it?
> > 
> > Whoops, probably missed it on the trip back from fosdem.
> > I'll double check now.
> 
> No worries. If you choose to go with your version, you can add:

No, I took yours. :)

