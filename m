Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 577AF2DA327
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Dec 2020 23:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440111AbgLNWPs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Dec 2020 17:15:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:59454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408362AbgLNWPE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Dec 2020 17:15:04 -0500
From:   Jeff Layton <jlayton@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Amir Goldstein <amir73il@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Vivek Goyal <vgoyal@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        NeilBrown <neilb@suse.com>, Jan Kara <jack@suse.cz>
Subject: [RFC PATCH v2 0/2] errseq+overlayfs: accomodate the volatile upper layer use-case
Date:   Mon, 14 Dec 2020 17:14:19 -0500
Message-Id: <20201214221421.1127423-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Here's a second pass at working in the overlayfs volatile use case.
Some differences since the first RFC set:

- use the BIT() macro for the flags and counter, also add some new
  mask constants
- fix bug in errseq_sample (we don't want to set the SEEN bit there)
- fix handling in errseq_check_and_advance. We now need to reattempt
  the cmpxchg in one case, but we should only need to do it once.
- comment and documentation fixes and cleanup
- initialize upper_sb pointer before dereferencing it
- only call errseq_set when there is an error

I think this is getting closer to merge. It seems to do the right thing
on xfs (and I assume other filesystems). I've also sorted out a number
of bugs.

What I haven't actually tested is the overlayfs part. Sargun, would you
or someone else (Vivek?) be able to verify that it does the right thing?

This is in the errseq-mustinc branch in my kernel.org tree:

    https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git/log/?h=errseq-mustinc

-------------[ Original cover letter follows ]--------------

What about this as an alternate approach to the problem that Sargun has
been working on? I have some minor concerns about the complexity of
managing a stateful object across two different words. That can be
done, but I think this may be simpler.

This set steals an extra flag bit from the errseq_t counter so that we
have two flags: one indicating whether to increment the counter at set
time, and another to indicate whether the error has been reported to
userland.

This should give you the semantics you want in the syncfs case, no?  If
this does look like it's a suitable approach, then I'll plan to clean up
the comments and docs.

I have a vague feeling that this might help us eventually kill the
AS_EIO and AS_ENOSPC bits too, but that would require a bit more work to
plumb in "since" samples at appropriate places.


Jeff Layton (2):
  errseq: split the SEEN flag into two new flags
  overlayfs: propagate errors from upper to overlay sb in sync_fs

 Documentation/core-api/errseq.rst |  22 +++--
 fs/overlayfs/ovl_entry.h          |   1 +
 fs/overlayfs/super.c              |  19 +++--
 include/linux/errseq.h            |   2 +
 lib/errseq.c                      | 136 ++++++++++++++++++++++--------
 5 files changed, 132 insertions(+), 48 deletions(-)

-- 
2.29.2

