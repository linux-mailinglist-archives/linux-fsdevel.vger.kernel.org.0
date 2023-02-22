Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D37D69EDD3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Feb 2023 05:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjBVEOA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Feb 2023 23:14:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjBVEN6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Feb 2023 23:13:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C031C7EF;
        Tue, 21 Feb 2023 20:13:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41998B810FD;
        Wed, 22 Feb 2023 04:13:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1993C433EF;
        Wed, 22 Feb 2023 04:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677039234;
        bh=ZhTPi7pG1DXy3eD5VCDK7zlbSQFwWFjkdJ6pXCwBq/g=;
        h=Date:From:To:Cc:Subject:From;
        b=R0tnW0dA101jXHxO5zPSZPueAE+xtugrGkqNhT1/mjvFShPPdmiICPEouJKhmQvIc
         ttdqq/EGNXYt7Mme89W6tDswFCR5b/XemVGb11m9H3/mJ0o3tB0PXKMcMYL4WZY/Gi
         zmUcSwcV909kcEsNyieiWqyuJJan6HJwYFz8+Dy3VWg3q99AmokoWvSLidgaLD5Z8v
         ih9ze0QBGu6N6gJSw7tJWO2LT69c6UBIHFH+zJvDV9DiIk+Kq0GSN1wMwY+WiD8u3s
         OVLdVPCk4p1odOd7xAmKhIsxHW8Py8UCQIpmI13iZVZMa7wPCk+yFxhqZfHa9MbpoV
         qOlJHspeFM+hg==
Date:   Tue, 21 Feb 2023 20:13:54 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     david@fromorbit.com, djwong@kernel.org, hch@lst.de,
        torvalds@linux-foundation.org
Cc:     agruenba@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: [GIT PULL] iomap: new code for 6.3
Message-ID: <167703901677.1909640.1798642413122202835.stg-ugh@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this branch with changes for iomap for 6.3-rc1.  This is
mostly rearranging things to make life easier for gfs2, nothing all that
mindblowing for this release.

As usual, I did a test-merge with the main upstream branch as of a few
minutes ago, and didn't see any conflicts.  Please let me know if you
encounter any problems.

--D

The following changes since commit 5dc4c995db9eb45f6373a956eb1f69460e69e6d4:

Linux 6.2-rc4 (2023-01-15 09:22:43 -0600)

are available in the Git repository at:

git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-6.3-merge-1

for you to fetch changes up to 471859f57d42537626a56312cfb50cd6acee09ae:

iomap: Rename page_ops to folio_ops (2023-01-18 10:44:05 -0800)

----------------------------------------------------------------
New code for 6.3:

- Change when the iomap page_done function is called so that we still
have a locked folio in the success case.  This fixes a writeback race
in gfs2.
- Change when the iomap page_prepare function is called so that gfs2
can recover from OOM scenarios more gracefully.
- Rename the iomap page_ops to folio_ops, since they operate on folios
now.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>

----------------------------------------------------------------
Andreas Gruenbacher (8):
iomap: Add __iomap_put_folio helper
iomap/gfs2: Unlock and put folio in page_done handler
iomap: Rename page_done handler to put_folio
iomap: Add iomap_get_folio helper
iomap/gfs2: Get page in page_prepare handler
iomap: Add __iomap_get_folio helper
iomap: Rename page_prepare handler to get_folio
iomap: Rename page_ops to folio_ops

fs/gfs2/bmap.c         | 38 ++++++++++++++-------
fs/iomap/buffered-io.c | 91 +++++++++++++++++++++++++++++++++-----------------
fs/xfs/xfs_iomap.c     |  4 +--
include/linux/iomap.h  | 27 ++++++++-------
4 files changed, 103 insertions(+), 57 deletions(-)
