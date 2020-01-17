Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAD8E14109B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 19:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgAQSRk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 13:17:40 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:36616 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbgAQSRk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 13:17:40 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1isWBW-00AOYO-GI; Fri, 17 Jan 2020 18:17:30 +0000
Date:   Fri, 17 Jan 2020 18:17:30 +0000
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
Message-ID: <20200117181730.GO8904@ZenIV.linux.org.uk>
References: <364531.1579265357@warthog.procyon.org.uk>
 <d2730b78cf0eac685c3719909df34d8d1b0bc347.camel@hammerspace.com>
 <20200117154657.GK8904@ZenIV.linux.org.uk>
 <20200117163616.GA282555@vader>
 <20200117165904.GN8904@ZenIV.linux.org.uk>
 <20200117172855.GA295250@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117172855.GA295250@vader>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 17, 2020 at 09:28:55AM -0800, Omar Sandoval wrote:
> On Fri, Jan 17, 2020 at 04:59:04PM +0000, Al Viro wrote:
> > On Fri, Jan 17, 2020 at 08:36:16AM -0800, Omar Sandoval wrote:
> > 
> > > The semantics I implemented in my series were basically "linkat with
> > > AT_REPLACE replaces the target iff rename would replace the target".
> > > Therefore, symlinks are replaced, not followed, and mountpoints get
> > > EXDEV. In my opinion that's both sane and unsurprising.
> > 
> > Umm...  EXDEV in rename() comes when _parents_ are on different mounts.
> > rename() over a mountpoint is EBUSY if it has mounts in caller's
> > namespace, but it succeeds (and detaches all mounts on the victim
> > in any namespaces) otherwise.
> > 
> > When are you returning EXDEV?
> 
> EXDEV was a thinko, the patch does what rename does:
> 
> 
> +	if (is_local_mountpoint(new_dentry)) {
> +		error = -EBUSY;
> +		goto out;
> +	}
> 
> ...
> 
> +	if (target) {
> +		dont_mount(new_dentry);
> +		detach_mounts(new_dentry);
> +	}
> 
> Anyways, my point is that the rename semantics cover 90% of AT_REPLACE.
> Before I resend the patches, I'll write up the documentation and we can
> see what other corner cases I missed.

OK... rename() has a major difference from linkat(), though, in not
following links (or allowing fd + empty path).  link() is deeply
asymmetric in treatment of pathnames - the first argument is
"pathname describes a filesystem object" and the second - "pathname
descripes an entry in a directory" (the link to be).  rename() is
not - both arguments are pathnames-as-link-specifiers.  And that
affects what is and what is not allowed there, so that'll need
a careful look into.

FWIW, currently linkat() semantics can be described simply enough
	* oldfd/oldname specifies an fs object; symlink traversal is
optional.
	* newfd/newname specifies an entry in some directory.  Directory
must be on the same mount as the object specified by oldname.
Entry must be a normal component (no empty paths allowed, no . or ..
either).  Trailing slashes are not allowed.  There must be no
entry with that name (which automatically implies that trailing
symlinks are not to be followed and there can't be anything
mounted on it).
	* the object specified by oldname must be a non-directory.
	* if the object is not a never-linked-yet anonymous,
it must still have some links.
	* caller must have permission to create links in the
affected directory.
	* append-only and immutables are not allowed (rationale:
they can't be unlinked)
	* filesystem is allowed to fail for any reasons, as with
any operation; a linkat()-specific one is having the link count
overflow, but any generic error is possible (out of memory, IO
error, EPERM-because-I-feel-like-that, etc.)

All checks related to object in question are atomic wrt operations
that add or remove links to that object.  Checks on parent are
atomic wrt operations modifying the parent.  Neither group is
atomic wrt operations modifying the _old_ parent (if there's
any, in the first place).
