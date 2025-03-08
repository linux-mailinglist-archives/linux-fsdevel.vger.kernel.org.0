Return-Path: <linux-fsdevel+bounces-43526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 620D4A57DAC
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 20:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B85E218933BA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 19:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C371F5823;
	Sat,  8 Mar 2025 19:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="oo1KqDGW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch [83.166.143.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459B71A7AF7;
	Sat,  8 Mar 2025 19:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741460874; cv=none; b=I/8cl+zZ/g+s8MvX7dvYUYkyrXt0PCHe1Ew7eS7ULsQ7ZNumzw5cZiPu+gG+Et4pSTptJebAsYww7LlHJOY5k00gL89QcMA16+oypOaKzXciNZrUXeFaRG7ubWT6yc7Hx1mf0XPj66q9Jt8WnPKlmOIFBrIGn/Ailyv1bKqjTxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741460874; c=relaxed/simple;
	bh=THc5PjFSh26dJztWketOIiTRbPaphYyQuraCE/AUSuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lz4VujO62C8ysQ/AjfDmWv5ihqWATlwn1ji8imGo2NiTOysmH8gnISDRU7uZI52DwwxrmlT5vISJaRd5nEI8XOXUZ7fzsDlt2wzK7u9rKZP1Xu9goKKegE6KjYK1IZdeHA8yvlB55S/J6LmZhn3dJf4PT+kFcgxE0D2TmBmb0wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=oo1KqDGW; arc=none smtp.client-ip=83.166.143.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Z9CN54dFFzX08;
	Sat,  8 Mar 2025 20:07:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1741460869;
	bh=sISBkW3X76z2jrfrrXF7V/EAtXAqZupD5pfeuVfxY7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oo1KqDGWtL5HWRmhUE9eBt1oRJ+Ga1KJAU5v9B6gWi/Q93uQgI3CCKTNDooIgmMFT
	 /zL8GDBTjTqA/TKJb6q21MwBScX2h/6heZ4PtqjrxUJCrav+RsSzBlkTwZRKCFBjvu
	 3H1XJ/6QZ0sLu5A6bjaN6GIlMpIvHPYPqysPBuKY=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Z9CN46QVwzxHd;
	Sat,  8 Mar 2025 20:07:48 +0100 (CET)
Date: Sat, 8 Mar 2025 20:07:48 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Jan Kara <jack@suse.cz>, linux-security-module@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, Tycho Andersen <tycho@tycho.pizza>, 
	Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>, Jann Horn <jannh@google.com>, 
	Andy Lutomirski <luto@amacapital.net>, Paul Moore <paul@paul-moore.com>, linux-api@vger.kernel.org
Subject: Re: [RFC PATCH 5/9] Define user structure for events and responses.
Message-ID: <20250306.aej5ieg1Hi6j@digikod.net>
References: <cover.1741047969.git.m@maowtm.org>
 <cde6bbf0b52710b33170f2787fdcb11538e40813.1741047969.git.m@maowtm.org>
 <20250304.eichiDu9iu4r@digikod.net>
 <fbb8e557-0b63-4bbe-b8ac-3f7ba2983146@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fbb8e557-0b63-4bbe-b8ac-3f7ba2983146@maowtm.org>
X-Infomaniak-Routing: alpha

On Thu, Mar 06, 2025 at 03:05:10AM +0000, Tingmao Wang wrote:
> On 3/4/25 19:49, Mickaël Salaün wrote:
> > On Tue, Mar 04, 2025 at 01:13:01AM +0000, Tingmao Wang wrote:
> [...]
> > > +	/**
> > > +	 * @cookie: Opaque identifier to be included in the response.
> > > +	 */
> > > +	__u32 cookie;
> > 
> > I guess we could use a __u64 index counter per layer instead.  That
> > would also help to order requests if they are treated by different
> > supervisor threads.
> 
> I don't immediately see a use for ordering requests (if we get more than one
> event at once, they are coming from different threads anyway so there can't
> be any dependencies between them, and the supervisor threads can use
> timestamps), but I think making it a __u64 is probably a good idea
> regardless, as it means we don't have to do some sort of ID allocation, and
> can just increment an atomic.

Indeed, we should follow the seccomp unotify approach with a random u64
incremented per request.

> 
> > > +};
> > > +
> > > +struct landlock_supervise_event {
> > > +	struct landlock_supervise_event_hdr hdr;
> > > +	__u64 access_request;
> > > +	__kernel_pid_t accessor;
> > > +	union {
> > > +		struct {
> > > +			/**
> > > +			 * @fd1: An open file descriptor for the file (open,
> > > +			 * delete, execute, link, readdir, rename, truncate),
> > > +			 * or the parent directory (for create operations
> > > +			 * targeting its child) being accessed.  Must be
> > > +			 * closed by the reader.
> > > +			 *
> > > +			 * If this points to a parent directory, @destname
> > > +			 * will contain the target filename. If @destname is
> > > +			 * empty, this points to the target file.
> > > +			 */
> > > +			int fd1;
> > > +			/**
> > > +			 * @fd2: For link or rename requests, a second file
> > > +			 * descriptor for the target parent directory.  Must
> > > +			 * be closed by the reader.  @destname contains the
> > > +			 * destination filename.  This field is -1 if not
> > > +			 * used.
> > > +			 */
> > > +			int fd2;
> > 
> > Can we just use one FD but identify the requested access instead and
> > send one event for each, like for the audit patch series?
> 
> I haven't managed to read or test out the audit patch yet (I will do), but I
> think having the ability to specifically tell whether the child is trying to
> move / rename / create a hard link of an existing file, and what it's trying
> to use as destination, might be useful (either for security, or purely for
> UX)?
> 
> For example, imagine something trying to link or move ~/.ssh/id_ecdsa to
> /tmp/innocent-tmp-file then read the latter. The supervisor can warn the
> user on the initial link attempt, and the shenanigan will probably be
> stopped there (although still, being able to say "[program] wants to link
> ~/.ssh/id_ecdsa to /tmp/innocent-tmp-file" seems better than just "[program]
> wants to create a link for ~/.ssh/id_ecdsa"), but even if somehow this ends
> up allowed, later on for the read request it could say something like
> 
> 	[program] wants to read /tmp/innocent-tmp-file
> 	    (previously moved from ~/.ssh/id_ecdsa)
> 
> Maybe this is a bit silly, but there might be other use cases for knowing
> the exact details of a rename/link request, either for at-the-time decision
> making, or tracking stuff for future requests?

This pattern looks like datagram packets.  I think we should use the
netlink attributes.  There were concern about using a netlink socket for
the seccomp unotification though:
https://lore.kernel.org/all/CALCETrXeZZfVzXh7SwKhyB=+ySDk5fhrrdrXrcABsQ=JpQT7Tg@mail.gmail.com/

There are two main differences with seccomp unotify:
- the supervisor should be able to receive arbitrary-sized data (e.g.
  file name, not path);
- the supervisor should be able to receive file descriptors (instead of
  path).

Sockets are created with socket(2) whereas in our case we should only
get a supervisor FD (indirectly) through landlock_restrict_self(2),
which clearly identifies a kernel object.  Another issue would be to
deal with network namespaces, probably by creating a private one.
Sockets are powerful but we don't needs all the routing complexity.
Moreover, we should only need a blocking communication channel to avoid
issues managing in-flight object references (transformed to FDs when
received).  That makes me think that a socket might not be the right
construct, but we can still rely on the NLA macros to define a proper
protocol with dynamically-sized events, received and send with dedicated
IOCTL commands.

Netlink already provides a way to send a cookie, and
netlink_attribute_type defines the types we'll need, including string.

For instance, a link request/event could include 3 packets, one for each
of these properties:
1. the source file FD;
2. the destination directory FD;
3. the destination filename string.

This way we would avoid the union defined in this patch.

There is still the question about receiving FDs though. It would be nice
to have a (set of?) dedicated IOCTL(s) to receive an FD, but I'm not
sure how this could be properly handled wrt NLA.

> 
> I will try out the audit patch to see how things like these appears in the
> log before commenting further on this. Maybe there is a way to achieve this
> while still simplifying the event structure?
> 
> > 
> > > +			/**
> > > +			 * @destname: A filename for a file creation target.
> > > +			 *
> > > +			 * If either of fd1 or fd2 points to a parent
> > > +			 * directory rather than the target file, this is the
> > > +			 * NULL-terminated name of the file that will be
> > > +			 * newly created.
> > > +			 *
> > > +			 * Counting the NULL terminator, this field will
> > > +			 * contain one or more NULL padding at the end so
> > > +			 * that the length of the whole struct
> > > +			 * landlock_supervise_event is a multiple of 8 bytes.
> > > +			 *
> > > +			 * This is a variable length member, and the length
> > > +			 * including the terminating NULL(s) can be derived
> > > +			 * from hdr.length - offsetof(struct
> > > +			 * landlock_supervise_event, destname).
> > > +			 */
> > > +			char destname[];
> > 
> > I'd prefer to avoid sending file names for now.  I don't think it's
> > necessary, and that could encourage supervisors to filter access
> > according to names.
> > 
> 
> This is also motivated by the potential UX I'm thinking of. For example, if
> a newly installed application tries to create ~/.app-name, it will be much
> more reassuring and convenient to the user if we can show something like
> 
> 	[program] wants to mkdir ~/.app-name. Allow this and future
> 	access to the new directory?
> 
> rather than just "[program] wants to mkdir under ~". (The "Allow this and
> future access to the new directory" bit is made possible by the supervisor
> knowing the name of the file/directory being created, and can remember them
> / write them out to a persistent profile etc)
> 
> Note that this is just the filename under the dir represented by fd - this
> isn't a path or anything that can be subject to symlink-related attacks,
> etc.  If a program calls e.g.
> mkdirat or openat (dfd -> "/some/", pathname="dir/stuff", O_CREAT)
> my understanding is that fd1 will point to /some/dir, and destname would be
> "stuff"

Right, this file name information would be useful.  In the case of
audit, the goal is to efficiently and asynchronously log security events
(and align with other LSM logs and related limitations), not primarily
to debug sandboxed apps nor to enrich this information for decision
making, but the supervisor feature would help here.  The patch message
should include this rationale.


> 
> Actually, in case your question is "why not send a fd to represent the newly
> created file, instead of sending the name" -- I'm not sure whether you can
> open even an O_PATH fd to a non-existent file.

That would not be possible because it would not exist yet, a file name
(not file path) is OK for this case.

> 
> > > +		};
> > > +		struct {
> > > +			__u16 port;
> > > +		};
> > > +	};
> > > +};
> > > +
> > 
> > [...]
> 
> 

