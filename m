Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED2F2E9B89
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jan 2021 18:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbhADRAy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 12:00:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33016 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727525AbhADRAy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 12:00:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609779567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hnWpyzaa+3BkwI6qgtfvvLYUKPIP+O6CaC4kfzPWIhM=;
        b=DYMMuuib4T1YLOlCQRuQ5biy4OaK0f5apYG91KqrwaqC+eRHReFFrPDOchihKlH5FdBITm
        DvnCyu7VRbBmO1KbYHARRSnSn16ONW2XQITLo6zTSxm7lVF4aoCVCH2psxNAagiLe9vlpI
        byrBat5Hyc+C9eKnetEMlFOxpKO0rYw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-q12-ymt6PU6WSViBwJWOCw-1; Mon, 04 Jan 2021 11:59:25 -0500
X-MC-Unique: q12-ymt6PU6WSViBwJWOCw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F017100C605;
        Mon,  4 Jan 2021 16:59:22 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-2.rdu2.redhat.com [10.10.115.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA67C60BE5;
        Mon,  4 Jan 2021 16:59:21 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 43460220BCF; Mon,  4 Jan 2021 11:59:21 -0500 (EST)
Date:   Mon, 4 Jan 2021 11:59:21 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>,
        NeilBrown <neilb@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Chengguang Xu <cgxu519@mykernel.net>
Subject: Re: [PATCH 3/3] overlayfs: Report writeback errors on upper
Message-ID: <20210104165921.GB73873@redhat.com>
References: <20201223185044.GQ874@casper.infradead.org>
 <20201223192940.GA11012@ircssh-2.c.rugged-nimbus-611.internal>
 <20201223200746.GR874@casper.infradead.org>
 <20201223202140.GB11012@ircssh-2.c.rugged-nimbus-611.internal>
 <20201223204428.GS874@casper.infradead.org>
 <CAOQ4uxjAeGv8x2hBBzHz5PjSDq0Q+RN-ikgqEvAA+XE_U-U5Nw@mail.gmail.com>
 <20201224121352.GT874@casper.infradead.org>
 <CAOQ4uxj5YS9LSPoBZ3uakb6NeBG7g-Zeu+8Vt57tizEH6xu0cw@mail.gmail.com>
 <1334bba9cefa81f80005f8416680afb29044379c.camel@kernel.org>
 <20201228155618.GA6211@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201228155618.GA6211@casper.infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 28, 2020 at 03:56:18PM +0000, Matthew Wilcox wrote:
> On Mon, Dec 28, 2020 at 08:25:50AM -0500, Jeff Layton wrote:
> > To be clear, the main thing you'll lose with the method above is the
> > ability to see an unseen error on a newly opened fd, if there was an
> > overlayfs mount using the same upper sb before your open occurred.
> > 
> > IOW, consider two overlayfs mounts using the same upper layer sb:
> > 
> > ovlfs1				ovlfs2
> > ----------------------------------------------------------------------
> > mount
> > open fd1
> > write to fd1
> > <writeback fails>
> > 				mount (upper errseq_t SEEN flag marked)
> > open fd2
> > syncfs(fd2)
> > syncfs(fd1)
> > 
> > 
> > On a "normal" (non-overlay) fs, you'd get an error back on both syncfs
> > calls. The first one has a sample from before the error occurred, and
> > the second one has a sample of 0, due to the fact that the error was
> > unseen at open time.
> > 
> > On overlayfs, with the intervening mount of ovlfs2, syncfs(fd1) will
> > return an error and syncfs(fd2) will not. If we split the SEEN flag into
> > two, then we can ensure that they both still get an error in this
> > situation.
> 
> But do we need to?  If the inode has been evicted we also lose the errno.

That's for the case of fsync(), right? For the case of syncfs() we will
not lose error as its stored in super_block.

Even for the case of fsync(), inode can be evicted only if no other
fd is opened for the file. So in above example, fd1 is opened so
inode can't be evicted, that means we will see error on syncfs(fd2)
and not lose it.

So if we start consuming upper fs on overlay mount(), it will be a
change of behavior for applications using same upper fs. So far
overlay mount() does not consume unseen error and even if an fd
is opened after the error, application will see error on super
block. If we consume error on mount(), we change behavior.

I am not saying that's necessarily bad, I am just trying to point
out that its a user space visible behavior change and worried
if somebody starts calling it a regression.

Anyway, I looks like two problems got mixed into same thread. One
problem we need to solve is that syncfs() on overlayfs should
report back writeback errors (as well as other errors) to applications.
And that's what this patch series is solving.

And then second issue is detecting writeback errors over remount
for volatile mounts. And that's where this question comes whether
we should split seen flag or we should simply consume error on
mount. So this can be further discussed when patches for this
changes are posted again.

For now, I will focus on trying to fix first issue and post patches
for that again after more testing.

Vivek


> The guarantee we provide is that a fd that was open before the error
> occurred will see the error.  An fd that's opened after the error occurred
> may or may not see the error.

