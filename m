Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35F7A29A87D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Oct 2020 10:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896486AbgJ0J4T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Oct 2020 05:56:19 -0400
Received: from verein.lst.de ([213.95.11.211]:38228 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409904AbgJ0Jy6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Oct 2020 05:54:58 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 98EC068AFE; Tue, 27 Oct 2020 10:54:55 +0100 (CET)
Date:   Tue, 27 Oct 2020 10:54:55 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 02/10] fs: don't allow splice read/write without
 explicit ops
Message-ID: <20201027095455.GA30298@lst.de>
References: <3088368.1603790984@warthog.procyon.org.uk> <20200827150030.282762-3-hch@lst.de> <20200827150030.282762-1-hch@lst.de> <3155818.1603792294@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3155818.1603792294@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 27, 2020 at 09:51:34AM +0000, David Howells wrote:
> David Howells <dhowells@redhat.com> wrote:
> 
> > > default_file_splice_write is the last piece of generic code that uses
> > > set_fs to make the uaccess routines operate on kernel pointers.  It
> > > implements a "fallback loop" for splicing from files that do not actually
> > > provide a proper splice_read method.  The usual file systems and other
> > > high bandwith instances all provide a ->splice_read, so this just removes
> > > support for various device drivers and procfs/debugfs files.  If splice
> > > support for any of those turns out to be important it can be added back
> > > by switching them to the iter ops and using generic_file_splice_read.
> > 
> > Hmmm...  this causes the copy_file_range() syscall to fail with EINVAL in some
> > places where before it used to work.
> > 
> > For my part, it causes the generic/112 xfstest to fail with afs, but there may
> > be other places.
> > 
> > Is this a regression we need to fix in the VFS core?  Or is it something we
> > need to fix in xfstests and assume userspace will fallback to doing it itself?
> 
> That said, for afs at least, the fix seems to be just this:

And that is the correct fix, I was about to send it to you.

We can't have a "generic" splice using ->read/->write without set_fs,
in addition to the iter_file_splice_write based version being a lot
more efficient than what you had before.
