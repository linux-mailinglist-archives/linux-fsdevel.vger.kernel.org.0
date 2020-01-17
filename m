Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F25E141406
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 23:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgAQWWV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 17:22:21 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:39460 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbgAQWWV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 17:22:21 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1isa0K-00AUY6-CT; Fri, 17 Jan 2020 22:22:12 +0000
Date:   Fri, 17 Jan 2020 22:22:12 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>, "hch@lst.de" <hch@lst.de>,
        "miklos@szeredi.hu" <miklos@szeredi.hu>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] Allowing linkat() to replace the destination
Message-ID: <20200117222212.GP8904@ZenIV.linux.org.uk>
References: <364531.1579265357@warthog.procyon.org.uk>
 <d2730b78cf0eac685c3719909df34d8d1b0bc347.camel@hammerspace.com>
 <20200117154657.GK8904@ZenIV.linux.org.uk>
 <20200117163616.GA282555@vader>
 <20200117165904.GN8904@ZenIV.linux.org.uk>
 <20200117172855.GA295250@vader>
 <20200117181730.GO8904@ZenIV.linux.org.uk>
 <20200117202219.GB295250@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117202219.GB295250@vader>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 17, 2020 at 12:22:19PM -0800, Omar Sandoval wrote:

> Since manpage troff patches aren't particularly nice to read, here is
> what I had in mind in a readable form:
> 
> int linkat(int olddirfd, const char *oldpath, int newdirfd,
> 	   const char *newpath, int flags);
> 
> 	AT_REPLACE
> 		If newpath exists, replace it atomically. There is no
> 		point at which another process attempting to access
> 		newpath will find it missing.
> 	
> 		newpath must not be a directory.
> 	
> 		If oldpath and newpath are existing hard links referring
> 		to the same file, then this does nothing, and returns a
> 		success status. If newpath is a mount point, then this
> 		comparison considers the mount point, not the mounted
> 		file or directory.
> 	
> 		If newpath refers to a symbolic link, the link will be
> 		overwritten.
> 
> ERRORS
> 	EBUSY	AT_REPLACE was specified in flags, newpath is a mount
> 		point, and the mount point does not refer to the same
> 		file as oldpath. Or, AT_REPLACE was specified in flags
> 		and newpath ends with a . or .. component.

> 	EISDIR	AT_REPLACE was specified in flags and newpath is an
> 		existing directory.

So are <existing directory>/. or <existing directory>/.., so I wonder why
bother with -EBUSY there.

As for the gaps...
	1) emptypath for new.  Should be an error; EINVAL, probably.
Avoids arseloads of fun cases ("what if newfd/newpath refers to something
unlinked?", etc., etc.)
	2) mountpoint vs. mountpoint in the local namespace.  See the
rationale in that area for unlink()/rmdir()/rename().
	3) permission checks need to be specified
	4) as for the hardlinks, I would be very careful with the language;
if anything, that's probably "if the link specified by newfd/newpath points
to the object specified by oldfd/oldpath..."  Another thing is, as you
could've seen for rename(), such "permissive" clauses tend to give surprising
results.  For example, put the check for "it's a hardlink" early enough,
and you've suddenly gotten a situation when it *can* succeed for directory.
Or on a filesystem that never allowed hardlinks (the latter is probably
unavoidable).
	5) what _really_ needs to be said is that other links to
newpath are unaffected and so are previously opened files.
	6) "atomically" is bloody vague; the explanation you've put there
is not enough, IMO - in addition to "nobody sees it gone in the middle
of operation" there's also "if the operation fails, the target remains
undisturbed" and something along the lines of "if filesystem makes any
promises about the state after dirty shutdown in the middle of rename(),
the same promises should apply here".
	7) how do users tell if filesystem supports that?  And no,
references to pathconf, Cthulhu and other equally delightful entities
are not really welcome.

There might be be more - like I said, it needs to go through
linux-abi, fsdevel and security lists.  The above is all I see right
now, but I might be missing something subtle (or not so subtle).

As for the implementation... VFS side should be reasonably easy (OK,
it'll bloat do_symlinkat() quite a bit, since we won't be able to use
filename_create() for the target in there, but it's not _that_
terrible).  I'd probably prefer a separate method rather than
overloading ->link(), with the old method called when the target
is negative and new - when it's positive - less boilerplate and
harder for an instance to get confused.  They can easily use common
helpers with ->link() instances, so the code duplication won't
be an issue.
