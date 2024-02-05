Return-Path: <linux-fsdevel+bounces-10268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E9A849953
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 12:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBE371F22A52
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 11:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCC11A29A;
	Mon,  5 Feb 2024 11:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c777OkkO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2DF18EB9;
	Mon,  5 Feb 2024 11:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134288; cv=none; b=RenZqMSYNP99ssWllrUHxxQo9WaK5gdC2tyo1YsVyfIDNCJK7g0L5rVrLNoyi1w9vU+kdhPonN9HQbiRh84S6NmhQP+NoiM8Gfly/MRWBuEOvSctFz8h0ejw7gPDAx5weQqvSAV47zTojfyJN+aoeGwEIVTPT7mNi/3JJ2AzhR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134288; c=relaxed/simple;
	bh=7TVjhZRcGSDBg8WholubRtQ/4dPPkNOismsM1iFeAmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvFuoEt79SM4D091AO0+g5UFalRZR57LPx5BFCBnS0KrD9uAciSFZUmGBUAG+2/ZAN7J7S4wCR2k/8kQv7E0ldcxYiA7i0Hh50h2q8selBQVn6tAfL2LOmDU+yy6+y433fl8p1SIDu5MUmjwYSECCByQT6mYmuv6uxBtLhkp65k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c777OkkO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB73C433C7;
	Mon,  5 Feb 2024 11:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707134288;
	bh=7TVjhZRcGSDBg8WholubRtQ/4dPPkNOismsM1iFeAmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c777OkkONkvw4s74UzHN4N9E09qBlbCf/qa18onl7cGFB3rUbkLqV0y5Gbzqf4s01
	 batHHR5A0KNO6yguYJy3UUB0wRyXmLUbmFz29OHRiL9fuK9JMvlXQGTX/ZCGIjyJsR
	 cv6DlVpraqRU5gWCQL4vddCV/FtaCevyi5jSzTaR8O0CIp0dteeVByB/l2SLhFZr0z
	 S9+Kv0zAcRq9nt2/vJH4nrBzUtPx63VWQ1pOGmAin7/jPT99W+q/cWiEZPU68e9NXR
	 +RTrTIut8cOPsZM4N0yZX99cX0OQU3ichNbIYOdcXkOvt4NNkTmBD3E2XgnADKBc6r
	 fqn6LF2Ug8Kwg==
Date: Mon, 5 Feb 2024 12:57:55 +0100
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
Message-ID: <20240205-laufen-hosen-38578e076df5@brauner>
References: <20240131-flsplit-v3-0-c6129007ee8d@kernel.org>
 <20240131-flsplit-v3-4-c6129007ee8d@kernel.org>
 <20240205-wegschauen-unappetitlich-2b0926023605@brauner>
 <de77ec5ade7fac7e72445cb2d10d95efe8bf9c92.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <de77ec5ade7fac7e72445cb2d10d95efe8bf9c92.camel@kernel.org>

On Mon, Feb 05, 2024 at 06:55:44AM -0500, Jeff Layton wrote:
> On Mon, 2024-02-05 at 12:36 +0100, Christian Brauner wrote:
> > > diff --git a/include/linux/filelock.h b/include/linux/filelock.h
> > > index 085ff6ba0653..a814664b1053 100644
> > > --- a/include/linux/filelock.h
> > > +++ b/include/linux/filelock.h
> > > @@ -147,6 +147,29 @@ int fcntl_setlk64(unsigned int, struct file *, unsigned int,
> > >  int fcntl_setlease(unsigned int fd, struct file *filp, int arg);
> > >  int fcntl_getlease(struct file *filp);
> > >  
> > > 
> > > 
> > > 
> > > 
> > > 
> > > 
> > > 
> > > +static inline bool lock_is_unlock(struct file_lock *fl)
> > > +{
> > > +	return fl->fl_type == F_UNLCK;
> > > +}
> > > +
> > > +static inline bool lock_is_read(struct file_lock *fl)
> > > +{
> > > +	return fl->fl_type == F_RDLCK;
> > > +}
> > > +
> > > +static inline bool lock_is_write(struct file_lock *fl)
> > > +{
> > > +	return fl->fl_type == F_WRLCK;
> > > +}
> > > +
> > > +static inline void locks_wake_up(struct file_lock *fl)
> > > +{
> > > +	wake_up(&fl->fl_wait);
> > > +}
> > > +
> > > +/* for walking lists of file_locks linked by fl_list */
> > > +#define for_each_file_lock(_fl, _head)	list_for_each_entry(_fl, _head, fl_list)
> > > +
> > 
> > This causes a build warning for fs/ceph/ and fs/afs when
> > !CONFIG_FILE_LOCKING. I'm about to fold the following diff into this
> > patch. The diff looks a bit wonky but essentially I've moved
> > lock_is_unlock(), lock_is_{read,write}(), locks_wake_up() and
> > for_each_file_lock() out of the ifdef CONFIG_FILE_LOCKING:
> > 
> 
> I sent a patch for this problem yesterday. Did you not get it?

Whoops, probably missed it on the trip back from fosdem.
I'll double check now.

