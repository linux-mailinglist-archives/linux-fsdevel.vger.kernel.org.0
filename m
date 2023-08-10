Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95947777C30
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 17:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236150AbjHJP2x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 11:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236144AbjHJP2w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:28:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658E210C7;
        Thu, 10 Aug 2023 08:28:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F174B66023;
        Thu, 10 Aug 2023 15:28:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF83C433C9;
        Thu, 10 Aug 2023 15:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691681331;
        bh=tWJLv3Tq2hwgxWt3KPp6sB8ABoshY+fdR+XTRU60v7g=;
        h=Date:From:To:Cc:Subject:From;
        b=LB9Deb725GkPaZ/rYEbtkRdEmA49QY2tIlsHeX4/OidsckJuYR8dWAd2spwOsnoQV
         pxcWtaDsKx5TxGkN576icFbmMQu2nTrE0a5EZZW65jc/Lms+lilxA3pRYRzqNdu7S6
         od6z6UPW70NzAxY970rUSZ4RtH2w5Wb0k4XxSgYd0ATIzszeRVQAkQaqFq0/OWJmOM
         6v0+kWbfE8gwb3I8+QuDxB08Czx3xPVcmkR40HGTb9lDZhnMHsuMCFzTpVuAjtU+zM
         6cPNnM24JRhtXRZ5Ic1hRk6UlmfYVBynJEoycjsm+v0ZG99+Vf9jNz6K7wiWGIgoJ6
         XYzAQc9KFXLxg==
Date:   Thu, 10 Aug 2023 08:28:51 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     chandan.babu@oracle.com, djwong@kernel.org
Cc:     dchinner@redhat.com, kent.overstreet@linux.dev,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        willy@infradead.org
Subject: [GIT PULL 3/9] xfs: stage repair information in pageable memory
Message-ID: <169168056068.1060601.568454110317783572.stg-ugh@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Chandan,

Please pull this branch with changes for xfs for 6.6-rc1.

As usual, I did a test-merge with the main upstream branch as of a few
minutes ago, and didn't see any conflicts.  Please let me know if you
encounter any problems.

--D

The following changes since commit 014ad53732d2bac34d21a251f3622a4da516e21b:

xfs: use per-AG bitmaps to reap unused AG metadata blocks during repair (2023-08-10 07:48:04 -0700)

are available in the Git repository at:

https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git tags/big-array-6.6_2023-08-10

for you to fetch changes up to 764018caa99f7629cefc92257a26b83289a674f3:

xfs: improve xfarray quicksort pivot (2023-08-10 07:48:07 -0700)

----------------------------------------------------------------
xfs: stage repair information in pageable memory [v26.1]

In general, online repair of an indexed record set walks the filesystem
looking for records.  These records are sorted and bulk-loaded into a
new btree.  To make this happen without pinning gigabytes of metadata in
memory, first create an abstraction ('xfile') of memfd files so that
kernel code can access paged memory, and then an array abstraction
('xfarray') based on xfiles so that online repair can create an array of
new records without pinning memory.

These two data storage abstractions are critical for repair of space
metadata -- the memory used is pageable, which helps us avoid pinning
kernel memory and driving OOM problems; and they are byte-accessible
enough that we can use them like (very slow and programmatic) memory
buffers.

Later patchsets will build on this functionality to provide blob storage
and btrees.

This has been running on the djcloud for years with no problems.  Enjoy!

Signed-off-by: Darrick J. Wong <djwong@kernel.org>

----------------------------------------------------------------
Darrick J. Wong (7):
xfs: create a big array data structure
xfs: enable sorting of xfile-backed arrays
xfs: convert xfarray insertion sort to heapsort using scratchpad memory
xfs: teach xfile to pass back direct-map pages to caller
xfs: speed up xfarray sort by sorting xfile page contents directly
xfs: cache pages used for xfarray quicksort convergence
xfs: improve xfarray quicksort pivot

fs/xfs/Kconfig         |    1 +
fs/xfs/Makefile        |    2 +
fs/xfs/scrub/trace.c   |    4 +-
fs/xfs/scrub/trace.h   |  260 ++++++++++++
fs/xfs/scrub/xfarray.c | 1083 ++++++++++++++++++++++++++++++++++++++++++++++++
fs/xfs/scrub/xfarray.h |  141 +++++++
fs/xfs/scrub/xfile.c   |  420 +++++++++++++++++++
fs/xfs/scrub/xfile.h   |   77 ++++
8 files changed, 1987 insertions(+), 1 deletion(-)
create mode 100644 fs/xfs/scrub/xfarray.c
create mode 100644 fs/xfs/scrub/xfarray.h
create mode 100644 fs/xfs/scrub/xfile.c
create mode 100644 fs/xfs/scrub/xfile.h
