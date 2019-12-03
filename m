Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04C5F1101DF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 17:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfLCQJC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Dec 2019 11:09:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:56552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbfLCQJB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Dec 2019 11:09:01 -0500
Received: from localhost (c-67-169-218-210.hsd1.or.comcast.net [67.169.218.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1298720803;
        Tue,  3 Dec 2019 16:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575389341;
        bh=II2Re7DbLEzmE5QGm8g7+xtzJhss5SFBy59u/YHHGbc=;
        h=Date:From:To:Cc:Subject:From;
        b=U6o2veH80qspdetmd7FL+MAWqRv1jcItsZq6pQ+y6CaccFHqW0ZQTThF3vv7/wIQV
         MlFsXQLWTU/6iLL8SSIm1O9clf1JFoiTAibzkbCDXkCmpcsXuadjqlvyBf8dBRrhPR
         yB2vpNhBXZ5lsXc7xFGUPSEHrJ/Drn/9RmGuJDY0=
Date:   Tue, 3 Dec 2019 08:08:56 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de, agruenba@redhat.com,
        rpeterso@redhat.com, cluster-devel@redhat.com,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [GIT PULL] iomap: small cleanups for 5.5
Message-ID: <20191203160856.GC7323@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this series containing some more new iomap code for 5.5.
There's not much this time -- just removing some local variables that
don't need to exist in the iomap directio code.

The branch merges cleanly against this morning's HEAD and survived a few
days' worth of xfstests.  The merge was completely straightforward, so
please let me know if you run into anything weird(er than my dorky tag
message).

--D

The following changes since commit 419e9c38aa075ed0cd3c13d47e15954b686bcdb6:

  iomap: Fix pipe page leakage during splicing (2019-11-22 08:36:02 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-5.5-merge-13

for you to fetch changes up to 88cfd30e188fcf6fd8304586c936a6f22fb665e5:

  iomap: remove unneeded variable in iomap_dio_rw() (2019-11-26 09:28:47 -0800)

----------------------------------------------------------------
New code for 5.5:
- Make iomap_dio_rw callers explicitly tell us if they want us to wait
- Port the xfs writeback code to iomap to complete the buffered io
  library functions
- Refactor the unshare code to share common pieces
- Add support for performing copy on write with buffered writes
- Other minor fixes
- Fix unchecked return in iomap_bmap
- Fix a type casting bug in a ternary statement in iomap_dio_bio_actor
- Improve tracepoints for easier diagnostic ability
- Fix pipe page leakage in directio reads
- Clean up iter usage in directio paths

----------------------------------------------------------------
Jan Kara (1):
      iomap: Do not create fake iter in iomap_dio_bio_actor()

Johannes Thumshirn (1):
      iomap: remove unneeded variable in iomap_dio_rw()

 fs/iomap/direct-io.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)
