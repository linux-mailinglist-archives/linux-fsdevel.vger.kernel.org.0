Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39B732E69B5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Dec 2020 18:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgL1R1O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Dec 2020 12:27:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:53480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728120AbgL1R1M (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Dec 2020 12:27:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC428229C4;
        Mon, 28 Dec 2020 17:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609176392;
        bh=hgBA1LfyhrKRoWwDF0Wxcneeez8y0WSHLlLztvnSU4E=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=mz9odLtQLrpwiYgV4LHUA1Ze47rZ0owsDAH7FAqumJpbrMKvLyF3BvO18L/yejtmN
         76u8xXbFpSSaj6N6YDEiMqXVqf6Jyel/FVDoF4in/XqGtNpNzsyM5x+DefkyIs1Xbd
         jL8B1iEY4r9DPID6dTIdhCc0oPmGCik9CUo0dbOFzb6p8cdV3VOcWALu9VFttqDexN
         UYxH5Idz0Hv7AB2NWoTYwf6GbWDF97dj4JiUCYtnwSDt8sRhzKY7UofJQ2qRU65O+m
         6rbTb0we5clViYqCCqd+PvnaQzS7pH0jrf6zPOFmfhfeFWbJrKVDEmq1kbXLAssbuE
         ZSvfYoYAfpLNA==
Message-ID: <5bc11eb2e02893e7976f89a888221c902c11a2b4.camel@kernel.org>
Subject: Re: [PATCH 3/3] overlayfs: Report writeback errors on upper
From:   Jeff Layton <jlayton@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Vivek Goyal <vgoyal@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>,
        NeilBrown <neilb@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Chengguang Xu <cgxu519@mykernel.net>
Date:   Mon, 28 Dec 2020 12:26:29 -0500
In-Reply-To: <20201228155618.GA6211@casper.infradead.org>
References: <20201223182026.GA9935@ircssh-2.c.rugged-nimbus-611.internal>
         <20201223185044.GQ874@casper.infradead.org>
         <20201223192940.GA11012@ircssh-2.c.rugged-nimbus-611.internal>
         <20201223200746.GR874@casper.infradead.org>
         <20201223202140.GB11012@ircssh-2.c.rugged-nimbus-611.internal>
         <20201223204428.GS874@casper.infradead.org>
         <CAOQ4uxjAeGv8x2hBBzHz5PjSDq0Q+RN-ikgqEvAA+XE_U-U5Nw@mail.gmail.com>
         <20201224121352.GT874@casper.infradead.org>
         <CAOQ4uxj5YS9LSPoBZ3uakb6NeBG7g-Zeu+8Vt57tizEH6xu0cw@mail.gmail.com>
         <1334bba9cefa81f80005f8416680afb29044379c.camel@kernel.org>
         <20201228155618.GA6211@casper.infradead.org>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.2 (3.38.2-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-12-28 at 15:56 +0000, Matthew Wilcox wrote:
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
> The guarantee we provide is that a fd that was open before the error
> occurred will see the error.  An fd that's opened after the error occurred
> may or may not see the error.
> 

In principle, you can lose errors this way (which was the justification
for making errseq_sample return 0 when there are unseen errors). E.g.,
if you close fd1 instead of doing a syncfs on it, that error will be
lost forever.

As to whether that's OK, it's hard to say. It is a deviation from how
this works in a non-containerized situation, and I'd argue that it's
less than ideal. You may or may not see the error on fd2, but it's
dependent on events that take place outside the container and that
aren't observable from within it. That effectively makes the results
non-deterministic, which is usually a bad thing in computing...

--
Jeff Layton <jlayton@kernel.org>

