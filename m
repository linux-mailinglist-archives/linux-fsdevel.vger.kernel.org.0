Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F887115801
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2019 20:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfLFTy5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Dec 2019 14:54:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:60982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbfLFTy5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Dec 2019 14:54:57 -0500
Received: from localhost (c-67-169-218-210.hsd1.or.comcast.net [67.169.218.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FE602464E;
        Fri,  6 Dec 2019 19:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575662096;
        bh=AB1Ig2/Xqpn71+VubvnuzWhRAX5d8Nz/rud1mSkjboQ=;
        h=Date:From:To:Cc:Subject:From;
        b=RNeNrKqHvlyfUcLZig+rXyh5vu3eJXPlpR9GcFOhAWnamqUZaToyUQ8lLxyuGNT1V
         oC1gDNR/bWMbM/xEdpzZ1z3sYkZbMa9hYyHt1VpBdCVodP1vI6s9xz2m2G9oDRqMVN
         +N9488mSj9IkVwjOVlrx+sikPnKW+z3gAWUulRAY=
Date:   Fri, 6 Dec 2019 11:54:56 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de, agruenba@redhat.com,
        rpeterso@redhat.com, cluster-devel@redhat.com,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [GIT PULL] iomap: fixes for 5.5
Message-ID: <20191206195456.GB9464@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull these iomap bug fixes for 5.5-rc1, which fix a race
condition and a use-after-free error.

The branch has survived overnight xfstests runs and merges cleanly with
this morning's master.  Please let me know if anything strange happens.

--D

The following changes since commit 88cfd30e188fcf6fd8304586c936a6f22fb665e5:

  iomap: remove unneeded variable in iomap_dio_rw() (2019-11-26 09:28:47 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-5.5-merge-14

for you to fetch changes up to c275779ff2dd51c96eaae04fac5d766421d6c596:

  iomap: stop using ioend after it's been freed in iomap_finish_ioend() (2019-12-05 07:41:16 -0800)

----------------------------------------------------------------
Fixes for 5.5-rc1:
- Fix a UAF when reporting writeback errors
- Fix a race condition when handling page uptodate on a blocksize <
  pagesize file that is also fragmented

----------------------------------------------------------------
Christoph Hellwig (1):
      iomap: fix sub-page uptodate handling

Zorro Lang (1):
      iomap: stop using ioend after it's been freed in iomap_finish_ioend()

 fs/iomap/buffered-io.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)
