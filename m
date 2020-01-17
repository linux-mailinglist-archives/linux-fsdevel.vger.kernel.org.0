Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6F4140E35
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 16:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbgAQPrI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 10:47:08 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:34442 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728816AbgAQPrI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 10:47:08 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1isTpp-00AKy8-Aa; Fri, 17 Jan 2020 15:46:57 +0000
Date:   Fri, 17 Jan 2020 15:46:57 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "osandov@osandov.com" <osandov@osandov.com>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>, "hch@lst.de" <hch@lst.de>,
        "miklos@szeredi.hu" <miklos@szeredi.hu>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] Allowing linkat() to replace the destination
Message-ID: <20200117154657.GK8904@ZenIV.linux.org.uk>
References: <364531.1579265357@warthog.procyon.org.uk>
 <d2730b78cf0eac685c3719909df34d8d1b0bc347.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2730b78cf0eac685c3719909df34d8d1b0bc347.camel@hammerspace.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 17, 2020 at 02:33:01PM +0000, Trond Myklebust wrote:
> On Fri, 2020-01-17 at 12:49 +0000, David Howells wrote:
> > It may be worth a discussion of whether linkat() could be given a
> > flag to
> > allow the destination to be replaced or if a new syscall should be
> > made for
> > this - or whether it should be disallowed entirely.
> > 
> > A set of patches has been posted by Omar Sandoval that makes this
> > possible:
> > 
> >     
> > https://lore.kernel.org/linux-fsdevel/cover.1524549513.git.osandov@fb.com/
> > 
> > though it only includes filesystem support for btrfs.
> > 
> > This could be useful for cachefiles:
> > 
> > 	
> > https://lore.kernel.org/linux-fsdevel/3326.1579019665@warthog.procyon.org.uk/
> > 
> > and overlayfs.
> > 
> 
> That seems to me like a "just go ahead and do it if you can justify it"
> kind of thing. It has plenty of precedent, and fits easily into the
> existing syscall, so why do we need a face-to-face discussion?

Unfortunately, it does *not* fit easily.  And IMO that's linux-abi fodder more
than anything else.  The problem is in coming up with sane semantics - there's
a plenty of corner cases with that one.  What to do when destination is
a dangling symlink, for example?  Or has something mounted on it (no, saying
"we'll just reject directories" is not enough).  What should happen when
destination is already a hardlink to the same object?

It's less of a horror than rename() would've been, but that's not saying
much.
