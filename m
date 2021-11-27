Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4926446015C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Nov 2021 21:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241765AbhK0UJp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Nov 2021 15:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240308AbhK0UHp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Nov 2021 15:07:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C72C061574;
        Sat, 27 Nov 2021 12:04:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F1EAB80936;
        Sat, 27 Nov 2021 20:04:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19505C53FBF;
        Sat, 27 Nov 2021 20:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638043467;
        bh=N9RYJ/wwzRw1gzQcyVy5cJKJbj9O4itGR0DWGBQCXKA=;
        h=Date:From:To:Cc:Subject:From;
        b=HV8m2tSEHnvsP6Krp+IXT7oIqUCUXe5/oR6NZwFrYwWD9AX1A6SDxCXe9+y7lqUN4
         +DxIwd+dhbJSiUoz2A3j9BEZpK/q6c4oDw4n2JFev/8EQ08oEFpdqCKVVmAsXmcQbh
         eAcWXxXKULZZJbWEEpqA+H+VeUEWDcsLz16b+fEIbJTEST7RJjdX++jZg8ALEVeWLY
         tbqpG1sYnQ3BVt+3GSsgwRArICqnMbPFLkffoAm4iULS/FNI0kuXaHZ70OEHpVz6VU
         CfjJAqP9q9ByQHfCISeu2/oZ8k4W8cry+3C1RlVFDjp+K+I3LmIxQvhNjw1AjFz51o
         thIk7xgPOfLaA==
Date:   Sat, 27 Nov 2021 12:04:26 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de, agruenba@redhat.com
Subject: [GIT PULL] iomap: bug fixes and doc improvements for 5.16-rc2
Message-ID: <20211127200426.GA8467@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this branch containing a single iomap bug fix and a cleanup
for 5.16-rc2.  The bug fix changes how iomap deals with reading from an
inline data region -- whereas the current code (incorrectly) lets the
iomap read iter try for more bytes after reading the inline region
(which zeroes the rest of the page!) and hopes the next iteration
terminates, we surveyed the inlinedata implementations and realized that
all inlinedata implementations also require that the inlinedata region
end at EOF, so we can simply terminate the read.

The second patch documents these assumptions in the code so that they're
not subtle implications anymore, and cleans up some of the grosser parts
of that function.

The branch merges cleanly against upstream as of a few minutes ago.
Please let me know if anything else strange happens during the merge
process.

--D

The following changes since commit 136057256686de39cc3a07c2e39ef6bc43003ff6:

  Linux 5.16-rc2 (2021-11-21 13:47:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-5.16-fixes-1

for you to fetch changes up to 5ad448ce2976f829d95dcae5e6e91f6686b0e4de:

  iomap: iomap_read_inline_data cleanup (2021-11-24 10:15:47 -0800)

----------------------------------------------------------------
Fixes for 5.16-rc2:
 - Fix an accounting problem where unaligned inline data reads can run
   off the end of the read iomap iterator.  iomap has historically
   required that inline data mappings only exist at the end of a file,
   though this wasn't documented anywhere.
 - Document iomap_read_inline_data and change its return type to be
   appropriate for the information that it's actually returning.

----------------------------------------------------------------
Andreas Gruenbacher (2):
      iomap: Fix inline extent handling in iomap_readpage
      iomap: iomap_read_inline_data cleanup

 fs/iomap/buffered-io.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)
