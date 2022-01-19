Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6620493954
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jan 2022 12:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354060AbiASLQH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jan 2022 06:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353333AbiASLQF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jan 2022 06:16:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7F9C061574;
        Wed, 19 Jan 2022 03:16:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D189061544;
        Wed, 19 Jan 2022 11:16:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07EC8C004E1;
        Wed, 19 Jan 2022 11:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642590964;
        bh=2yjBD4Zacw+5slFq4LLTP2+0CVP0ahv0ykBSsfMZgFY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sWcBQNL3jsVDx8fbC4Tu3Z7AAaVmBxjdgAxC1FcAS8Ufemm9lwqE+FjUw8YobL0g5
         maE0aFh0Blr15dbPkx6ryoeImGeucYTTcsECJx1mt0+jq0oQ6FQ5rulN3uruRj5DR9
         7iDa/u8UQ46Ll1d02g4BzWZus5gttImEBP/RPvToowP4cEwiueV36Qa+mbLXKiKF1P
         TDpAHrbrWHnvi/TfuAgEy+otbPNTxTNLfZLBje9IVSfCKF2Ngao1yFiRVXJhZg4UCw
         U4FwtkiJsQmV/NTjtIL3341Q+Mvi5YeltCuHtB2mLD/ESo335mZI38irwhrXsAf0Se
         tjihvN1DWwviQ==
Date:   Wed, 19 Jan 2022 12:15:57 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-cachefs@redhat.com,
        Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <smfrench@gmail.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/11] vfs, fscache: Add an IS_KERNEL_FILE() macro for
 the S_KERNEL_FILE flag
Message-ID: <20220119111557.gjrjwgib2wgteir6@wittgenstein>
References: <YeefizLOGt1Qf35o@infradead.org>
 <YebpktrcUZOlBHkZ@infradead.org>
 <164251396932.3435901.344517748027321142.stgit@warthog.procyon.org.uk>
 <164251409447.3435901.10092442643336534999.stgit@warthog.procyon.org.uk>
 <3613681.1642527614@warthog.procyon.org.uk>
 <3765724.1642583885@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3765724.1642583885@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 19, 2022 at 09:18:05AM +0000, David Howells wrote:
> Christoph Hellwig <hch@infradead.org> wrote:
> 
> > On Tue, Jan 18, 2022 at 05:40:14PM +0000, David Howells wrote:
> > > Christoph Hellwig <hch@infradead.org> wrote:
> > > 
> > > > On Tue, Jan 18, 2022 at 01:54:54PM +0000, David Howells wrote:
> > > > > Add an IS_KERNEL_FILE() macro to test the S_KERNEL_FILE inode flag as is
> > > > > common practice for the other inode flags[1].
> > > > 
> > > > Please fix the flag to have a sensible name first, as the naming of the
> > > > flag and this new helper is utterly wrong as we already discussed.
> > > 
> > > And I suggested a new name, which you didn't comment on.
> > 
> > Again, look at the semantics of the flag:  The only thing it does in the
> > VFS is to prevent a rmdir.  So you might want to name it after that.
> > 
> > Or in fact drop the flag entirely.  We don't have that kind of
> > protection for other in-kernel file use or important userspace daemons
> > either.  I can't see why cachefiles is the magic snowflake here that
> > suddenly needs semantics no one else has.
> 
> The flag cannot just be dropped - it's an important part of the interaction
> with cachefilesd with regard to culling.  Culling to free up space is
> offloaded to userspace rather than being done within the kernel.
> 
> Previously, cachefiles, the kernel module, had to maintain a huge tree of
> records of every backing inode that it was currently using so that it could
> forbid cachefilesd to cull one when cachefilesd asked.  I've reduced that to a
> single bit flag on the inode struct, thereby saving both memory and time.  You
> can argue whether it's worth sacrificing an inode flag bit for that, but the
> flag can be reused for any other kernel service that wants to similarly mark
> an inode in use.
> 
> Further, it's used as a mark to prevent cachefiles accidentally using an inode
> twice - say someone misconfigures a second cache overlapping the first - and,
> again, this works if some other kernel driver wants to mark inode it is using
> in use.  Cachefiles will refuse to use them if it ever sees them, so no
> problem there.
> 
> And it's not true that we don't have that kind of protection for other
> in-kernel file use.  See S_SWAPFILE.  I did consider using that, but that has
> other side effects.  I mentioned that perhaps I should make swapon set
> S_KERNEL_FILE also.  Also blockdevs have some exclusion also, I think.
> 
> The rmdir thing should really apply to rename and unlink also.  That's to
> prevent someone, cachefilesd included, causing cachefiles to malfunction by
> removing the directories it created.  Possibly this should be a separate bit
> to S_KERNEL_FILE, maybe S_NO_DELETE.
> 
> So I could change S_KERNEL_FILE to S_KERNEL_LOCK, say, or maybe S_EXCLUSIVE.

[ ] S_REMOVE_PROTECTED
[ ] S_UNREMOVABLE
[ ] S_HELD_BUSY
[ ] S_KERNEL_BUSY
[ ] S_BUSY_INTERNAL
[ ] S_BUSY
[ ] S_HELD

?
