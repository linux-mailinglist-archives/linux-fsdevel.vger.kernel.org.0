Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72301361179
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Apr 2021 19:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbhDORyB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Apr 2021 13:54:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:58942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234221AbhDORyB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Apr 2021 13:54:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE22861139;
        Thu, 15 Apr 2021 17:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618509217;
        bh=uykpJSftt6neycgE9UZPf5383PYs5+NZsn9IZWyvBls=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a+DebjSlUjLnchww5EDoaY79Eih/5pj2kts+TQDF8lOdiutpciCSifK84L9QXoGuh
         RCrGzfgzSNpAZ+NeG3MPAjLysjOVnRJMGXPlybpG7DvUYF4HxZiT+w8dAvEnTGUaPJ
         Y2z8tdI/HAbu3xJLZYccCvRAUO68z4aLYKUl/YLmkNnH9m7PgY4nC1If0iPVp8YDTE
         Wpj8JPULx8hDrlo9gKeofoliQud3+SpsRZWTNtHVTutFntOa6vxqcbvKcEm6nbBQlS
         QdfX23MKqQi9ELJvJTvpkY/vQbqMyywLTBW19pURWr2FehLnGfiruE3FynmCcrGFyQ
         i1D9GkCI9fkcQ==
Received: by mail-qk1-f169.google.com with SMTP id f19so8408061qka.8;
        Thu, 15 Apr 2021 10:53:37 -0700 (PDT)
X-Gm-Message-State: AOAM533wzFPjdCO4bqrDrc4+1n+BERT99soGLx3wwjII9mbB950Sjbh0
        /jEfvOZR7HhZMPIUK3A0q0w00gikEhWVmGE+s1I=
X-Google-Smtp-Source: ABdhPJzCNzm0W0XgockPjRIWCggyQJP/PdeRn4VzfFy2hYp7ghpXaixWJjKfmj+WztuDXoPxjQPb2UXr/6ySmNnlD6w=
X-Received: by 2002:a37:d202:: with SMTP id f2mr4665987qkj.273.1618509217042;
 Thu, 15 Apr 2021 10:53:37 -0700 (PDT)
MIME-Version: 1.0
References: <1408071538-14354-1-git-send-email-mcgrof@do-not-panic.com>
 <20140815092950.GZ18016@ZenIV.linux.org.uk> <c3b0feac-327c-15db-02c1-4a25639540e4@suse.com>
In-Reply-To: <c3b0feac-327c-15db-02c1-4a25639540e4@suse.com>
From:   Luis Chamberlain <mcgrof@kernel.org>
Date:   Thu, 15 Apr 2021 10:53:25 -0700
X-Gmail-Original-Message-ID: <CAB=NE6X2-mbZwVFnKUwjRmTGp3auZFHQXJ1h_YTJ2driUeoR+A@mail.gmail.com>
Message-ID: <CAB=NE6X2-mbZwVFnKUwjRmTGp3auZFHQXJ1h_YTJ2driUeoR+A@mail.gmail.com>
Subject: Re: [RFC v3 0/2] vfs / btrfs: add support for ustat()
To:     Filipe Manana <fdmanana@suse.com>, David Sterba <dsterba@suse.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Chris Mason <clm@fb.com>,
        Josef Bacik <jbacik@fb.com>,
        Christoph Hellwig <hch@infradead.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jeff Mahoney <jeffm@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 23, 2017 at 3:31 PM Jeff Mahoney <jeffm@suse.com> wrote:
>
> On 8/15/14 5:29 AM, Al Viro wrote:
> > On Thu, Aug 14, 2014 at 07:58:56PM -0700, Luis R. Rodriguez wrote:
> >
> >> Christoph had noted that this seemed associated to the problem
> >> that the btrfs uses different assignments for st_dev than s_dev,
> >> but much as I'd like to see that changed based on discussions so
> >> far its unclear if this is going to be possible unless strong
> >> commitment is reached.
>
> Resurrecting a dead thread since we've been carrying this patch anyway
> since then.
>
> > Explain, please.  Whose commitment and commitment to what, exactly?
> > Having different ->st_dev values for different files on the same
> > fs is a bloody bad idea; why does btrfs do that at all?  If nothing else,
> > it breaks the usual "are those two files on the same fs?" tests...
>
> It's because btrfs snapshots would have inode number collisions.
> Changing the inode numbers for snapshots would negate a big benefit of
> btrfs snapshots: the quick creation and lightweight on-disk
> representation due to metadata sharing.
>
> The thing is that ustat() used to work.  Your commit 0ee5dc676a5f8
> (btrfs: kill magical embedded struct superblock) had a regression:
> Since it replaced the superblock with a simple dev_t, it rendered the
> device no longer discoverable by user_get_super.  We need a list_head to
> attach for searching.
>
> There's an argument that this is hacky.  It's valid.  The only other
> feedback I've heard is to use a real superblock for subvolumes to do
> this instead.  That doesn't work either, due to things like freeze/thaw
> and inode writeback.  Ultimately, what we need is a single file system
> with multiple namespaces.  Years ago we just needed different inode
> namespaces, but as people have started adopting btrfs for containers, we
> need more than that.  I've heard requests for per-subvolume security
> contexts.  I'd imagine user namespaces are on someone's wish list.  A
> working df can be done with ->d_automount, but the way btrfs handles
> having a "canonical" subvolume location has always been a way to avoid
> directory loops.  I'd like to just automount subvolumes everywhere
> they're referenced.  One solution, for which I have no code yet, is to
> have something like a superblock-light that we can hang things like a
> security context, a user namespace, and an anonymous dev.  Most file
> systems would have just one.  Btrfs would have one per subvolume.
>
> That's a big project with a bunch of discussion.

4 years have gone by and this patch is still being carried around for
btrfs. Other than resolving this ustat() issue for btrfs are there new
reasons to support this effort done to be done properly? Are there
other filesystems that would benefit? I'd like to get an idea of the
stakeholder here before considering taking this on or not.

 Luis
