Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 925802E21AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Dec 2020 21:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgLWUpM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Dec 2020 15:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbgLWUpL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Dec 2020 15:45:11 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743C9C061794;
        Wed, 23 Dec 2020 12:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QGI1zaRzLH7OjqhLVtBefIeJ3lFzVBVBxUXhU6Kpg2Q=; b=ZGG3c7jOGeOmrWqRW8tX376I6/
        xZuLgCrqoih3ISyFJoO1MC0eQkVReoeZ4h3NtcNnG291yamhYdOWUcLVxiWfjTCfZFC/SMdt+iDBi
        sA/GcjhindrIKT0dehSRaMpy0XqvBQVynN6d7JtGqwWje4+gAt0DPdxSO3lJBkyS1dFn+cqmtsRdn
        u2gOpCTF+awOEHd7SuQLLsMj+l1rpf6MaySltkyKCYZAifi8MAXVri0NOnaJdpCsharsiPLl14dsg
        8bpJOoCENzMIiwxBcmywCPssPwP1XU29J7SPitt/CI2tEXteTy0wwC3ZPq8C2n98N2v/fuXU8OsV3
        TJiDj/vw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ksAzk-0002MC-Q4; Wed, 23 Dec 2020 20:44:28 +0000
Date:   Wed, 23 Dec 2020 20:44:28 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        jlayton@kernel.org, amir73il@gmail.com, miklos@szeredi.hu,
        jack@suse.cz, neilb@suse.com, viro@zeniv.linux.org.uk, hch@lst.de
Subject: Re: [PATCH 3/3] overlayfs: Report writeback errors on upper
Message-ID: <20201223204428.GS874@casper.infradead.org>
References: <20201221195055.35295-1-vgoyal@redhat.com>
 <20201221195055.35295-4-vgoyal@redhat.com>
 <20201223182026.GA9935@ircssh-2.c.rugged-nimbus-611.internal>
 <20201223185044.GQ874@casper.infradead.org>
 <20201223192940.GA11012@ircssh-2.c.rugged-nimbus-611.internal>
 <20201223200746.GR874@casper.infradead.org>
 <20201223202140.GB11012@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201223202140.GB11012@ircssh-2.c.rugged-nimbus-611.internal>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 23, 2020 at 08:21:41PM +0000, Sargun Dhillon wrote:
> On Wed, Dec 23, 2020 at 08:07:46PM +0000, Matthew Wilcox wrote:
> > On Wed, Dec 23, 2020 at 07:29:41PM +0000, Sargun Dhillon wrote:
> > > On Wed, Dec 23, 2020 at 06:50:44PM +0000, Matthew Wilcox wrote:
> > > > On Wed, Dec 23, 2020 at 06:20:27PM +0000, Sargun Dhillon wrote:
> > > > > I fail to see why this is neccessary if you incorporate error reporting into the 
> > > > > sync_fs callback. Why is this separate from that callback? If you pickup Jeff's
> > > > > patch that adds the 2nd flag to errseq for "observed", you should be able to
> > > > > stash the first errseq seen in the ovl_fs struct, and do the check-and-return
> > > > > in there instead instead of adding this new infrastructure.
> > > > 
> > > > You still haven't explained why you want to add the "observed" flag.
> > > 
> > > 
> > > In the overlayfs model, many users may be using the same filesystem (super block)
> > > for their upperdir. Let's say you have something like this:
> > > 
> > > /workdir [Mounted FS]
> > > /workdir/upperdir1 [overlayfs upperdir]
> > > /workdir/upperdir2 [overlayfs upperdir]
> > > /workdir/userscratchspace
> > > 
> > > The user needs to be able to do something like:
> > > sync -f ${overlayfs1}/file
> > > 
> > > which in turn will call sync on the the underlying filesystem (the one mounted 
> > > on /workdir), and can check if the errseq has changed since the overlayfs was
> > > mounted, and use that to return an error to the user.
> > 
> > OK, but I don't see why the current scheme doesn't work for this.  If
> > (each instance of) overlayfs samples the errseq at mount time and then
> > check_and_advances it at sync time, it will see any error that has occurred
> > since the mount happened (and possibly also an error which occurred before
> > the mount happened, but hadn't been reported to anybody before).
> > 
> 
> If there is an outstanding error at mount time, and the SEEN flag is unset, 
> subsequent errors will not increment the counter, until the user calls sync on
> the upperdir's filesystem. If overlayfs calls check_and_advance on the upperdir's
> super block at any point, it will then set the seen block, and if the user calls
> syncfs on the upperdir, it will not return that there is an outstanding error,
> since overlayfs just cleared it.

Your concern is this case:

fs is mounted on /workdir
/workdir/A is written to and then closed.
writeback happens and -EIO happens, but there's nobody around to care.
/workdir/upperdir1 becomes part of an overlayfs mount
overlayfs samples the error
a user writes to /workdir/B, another -EIO occurs, but nothing happens
someone calls syncfs on /workdir/upperdir/A, gets the EIO.
a user opens /workdir/B and calls syncfs, but sees no error

do i have that right?  or is it something else?

> > > If we do not advance the errseq on the upperdir to "mark it as seen", that means 
> > > future errors will not be reported if the user calls sync -f ${overlayfs1}/file,
> > > because errseq will not increment the value if the seen bit is unset.
> > > 
> > > On the other hand, if we mark it as seen, then if the user calls sync on 
> > > /workdir/userscratchspace/file, they wont see the error since we just set the 
> > > SEEN flag.
> > 
> > While we set the SEEN flag, if the file were opened before the error
> > occurred, we would still report the error because the sequence is higher
> > than it was when we sampled the error.
> > 
> 
> Right, this isn't a problem for people calling f(data)sync on a particular file, 
> because it takes its own snapshot of errseq. This is only problematic for folks 
> calling syncfs. In Jeff's other messages, it sounded like this behaviour is
> pretty important, and the likes of postgresql depend on it.

i would suggest that in the example above, the error _didn't_ occur
while calling syncfs(), it occurred before we synced the filesystem,
and we don't have to report it in that case.
