Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C692D8D3E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Dec 2020 14:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406832AbgLMN14 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Dec 2020 08:27:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:53024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgLMN14 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Dec 2020 08:27:56 -0500
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
Subject: [RFC PATCH 0/2] errseq+overlayfs: accomodate the volatile upper layer use-case
Date:   Sun, 13 Dec 2020 08:27:11 -0500
Message-Id: <20201213132713.66864-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

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

 fs/overlayfs/ovl_entry.h |  1 +
 fs/overlayfs/super.c     | 14 +++++++--
 include/linux/errseq.h   |  2 ++
 lib/errseq.c             | 64 +++++++++++++++++++++++++++++++++-------
 4 files changed, 67 insertions(+), 14 deletions(-)

-- 
2.29.2

