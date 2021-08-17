Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 863BF3EEF5B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 17:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238264AbhHQPqh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 11:46:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:48008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237624AbhHQPqf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:46:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 25D186023E;
        Tue, 17 Aug 2021 15:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629215162;
        bh=oY8KaPK7qomH0Ez+UUblaaHHh3LKex5oX9nMcYYHmZc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KQFMIDbK6+5oThbt3RB4hxXru1aPVTVo7+LdMAsqMDyuEhSsbr6y1tfpyE/y74cbc
         t6wbS0o6e81yPVD5Yk4ltm4ihFNk4VxwdIpVIWvPdOo1CIZ86EDUU1Iztq4RoKctPc
         EyeRI8jWYYs9BWlPBw9hUSb+DPOk+wqCH/WYELK0Smir7nBwu/bILDtTDR3XA4ufUk
         Pqd2uF8aFfyvuHhRLw+/wxpfzzmv4sMWliwITdVitTc36YSjussZNPHo56nPyTmyjT
         6EUfe9n1z3rQ2+eCQ7R+s5r4nFjuUAWl3pUEVFavrlpqcaTtif3Gt41HlH3vsI0FFm
         D/zI59IS3IvAg==
Date:   Tue, 17 Aug 2021 08:46:01 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-xfs@vger.kernel.org, jane.chu@oracle.com,
        willy@infradead.org, tytso@mit.edu, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, sandeen@sandeen.net
Subject: Re: [PATCHSET 0/2] dax: fix broken pmem poison narrative
Message-ID: <20210817154601.GD12640@magnolia>
References: <162914791879.197065.12619905059952917229.stgit@magnolia>
 <YRtnlPERHfMZ23Tr@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRtnlPERHfMZ23Tr@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 17, 2021 at 08:39:00AM +0100, Christoph Hellwig wrote:
> On Mon, Aug 16, 2021 at 02:05:18PM -0700, Darrick J. Wong wrote:
> > AFAICT, the only reason why the "punch and write" dance works at all is
> > that the XFS and ext4 currently call blkdev_issue_zeroout when
> > allocating pmem as part of a pwrite call.  A pwrite without the punch
> > won't clear the poison, because pwrite on a DAX file calls
> > dax_direct_access to access the memory directly, and dax_direct_access
> > is only smart enough to bail out on poisoned pmem.  It does not know how
> > to clear it.  Userspace could solve the problem by calling FIEMAP and
> > issuing a BLKZEROOUT, but that requires rawio capabilities.
> > 
> > The whole pmem poison recovery story is is wrong and needs to be
> > corrected ASAP before everyone else starts doing this.  Therefore,
> > create a dax_zeroinit_range function that filesystems can call to reset
> > the contents of the pmem to a known value and clear any state associated
> > with the media error.  Then, connect FALLOC_FL_ZERO_RANGE to this new
> > function (for DAX files) so that unprivileged userspace has a safe way
> > to reset the pmem and clear media errors.
> 
> I agree with the problem statement, but I don't think the fix is
> significantly better than what we have, as it still magically overloads
> other behavior.  I'd rather have an explicit operation to clear the
> poison both at the syscall level (maybe another falloc mode), and the
> internal kernel API level (new method in dax_operations).

I've long wondered why we can't just pass a write flag to the
direct_access functions so that pmem_dax_direct_access can clear the
poison.  Then we ought to be able to tell userspace that they can
recover from write errors by pwrite() or triggering a write fault on the
page, I think.  That's how userspace recovers from IO errors on
traditional disks; I've never understood why it has to be any different
now.

> Also for the next iteration please split the iomap changes from the
> usage in xfs.

ok.

--D
