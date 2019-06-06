Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 649F137D6E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 21:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfFFTnr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jun 2019 15:43:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:57052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726830AbfFFTnr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jun 2019 15:43:47 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBD36206BB;
        Thu,  6 Jun 2019 19:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559850226;
        bh=Fege0efxE/bsHjarKcgO1NRvY4phBlvmuwpR58JTZgk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HgJAtXXa+H7X3BCggX8tzS8k3dpOhCm7dRBrPabKkhiRglFoiu/8HtgJPlN9xmnyy
         Gp2M1DQt0DA1J57r+n0aOjWprz5ItKFbCPegohLbpQoEr+QpGd1CCtY6w6aBC2nbsx
         rEupwgxDdkpH8akd0Ifm9wSECTgZZq2LBh8a8N1M=
Date:   Thu, 6 Jun 2019 12:43:44 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-integrity@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Victor Hsieh <victorhsieh@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v4 00/16] fs-verity: read-only file-based authenticity
 protection
Message-ID: <20190606194343.GA84833@gmail.com>
References: <20190606155205.2872-1-ebiggers@kernel.org>
 <CAHk-=wgSzRzoro8ATO5xb6OFxN1A0fjUCQSAHfGuEPbEu+zWvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgSzRzoro8ATO5xb6OFxN1A0fjUCQSAHfGuEPbEu+zWvA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 06, 2019 at 10:21:12AM -0700, Linus Torvalds wrote:
> On Thu, Jun 6, 2019 at 8:54 AM Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > This is a redesigned version of the fs-verity patchset, implementing
> > Ted's suggestion to build the Merkle tree in the kernel
> > (https://lore.kernel.org/linux-fsdevel/20190207031101.GA7387@mit.edu/).
> > This greatly simplifies the UAPI, since the verity metadata no longer
> > needs to be transferred to the kernel.
> 
> Interfaces look sane to me. My only real concern is whether it would
> make sense to make the FS_IOC_ENABLE_VERITY ioctl be something that
> could be done incrementally, since the way it is done now it looks
> like any random user could create a big file and then do the
> FS_IOC_ENABLE_VERITY to make the kernel do a _very_ expensive
> operation.
> 
> Yes, I see the
> 
> +               if (fatal_signal_pending(current))
> +                       return -EINTR;
> +               cond_resched();
> 
> in there, so it's not like it's some entirely unkillable thing, and
> maybe we don't care as a result. But maybe the ioctl interface could
> be fundamentally restartable?
> 
> If that was already considered and people just went "too complex", never mind.
> 
>                Linus

Making it incremental would be complex.  We could make FS_IOC_ENABLE_VERITY
write checkpoints periodically, and make it resume from the checkpoint if
present.  But then we'd have to worry about sync'ing the Merkle tree before
writing each checkpoint, and storing the Merkle tree parameters in each
checkpoint so that if the second call to FS_IOC_ENABLE_VERITY is made with
different parameters it knows to delete everything and restart from scratch.

Or we could make it explicit in the UAPI, where userspace calls ioctls to build
blocks 0 through 9999, then 10000 through 19999, etc.  But that would make the
UAPI much more complex, and the kernel would need to do lots of extra validation
of the parameters passed in.  This approach would also not be crash-safe unless
userspace did its own checkpointing, whereas the all-or-nothing API naturally
avoids inconsistent states.

And either way of making it incremental, the "partial Merkle tree" would also
become a valid on-disk state.  Conceptually that adds a lot of complexity, and
probably people would want fsck to support removing all the partial trees,
similar to how e2fsck supports optimizing directories and extent trees.

So in the end, it's not something I decided to add.

- Eric
