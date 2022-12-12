Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F239F649878
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Dec 2022 05:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbiLLEsy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Dec 2022 23:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbiLLEsl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Dec 2022 23:48:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4742663D9;
        Sun, 11 Dec 2022 20:48:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3A79B80B72;
        Mon, 12 Dec 2022 04:48:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B1BC433D2;
        Mon, 12 Dec 2022 04:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670820517;
        bh=P8vfT0mshHozuGK5w2ZRZj2IsGSxzeJ1hYUPDymSUpA=;
        h=Date:From:To:Cc:Subject:From;
        b=oRfLPsbhhzn6jLWFdlSW5/taJKYumF3eyRG6EcL4YW6sqOLFj4LLaHj6VXSSK40pr
         Hv/+9C6Os/u8mW4Ko5Rx8JyzQBryXRoTVcGRN1TyF68EbgPW2fE6j4NG9PfMLQs6Ce
         Fa2RwGYuDTemB8vFMLZdS4aYYJPJKlbvPQaJEOJc/MJvHvlQ0ewBVY5XQg6+7qe9Qr
         39D8WQ2euxHusx0zuZJE52IRL6NtNBwZPc9aQiC2Jb0AeLMaz9KQCvZdrswp07u3ez
         J+jKuIuPrkG8E4cf8B1YiU2uSQP8a23eQ4W2ELRPkHSt8Whx7ilNFj96Ji/7n4kaFF
         UbIBpi6gYmeIA==
Date:   Sun, 11 Dec 2022 20:48:35 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: [GIT PULL] fsverity updates for 6.2
Message-ID: <Y5ayo48TtNrPgU9D@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit f0c4d9fc9cc9462659728d168387191387e903cc:

  Linux 6.1-rc4 (2022-11-06 15:07:11 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fsverity-for-linus

for you to fetch changes up to a4bbf53d88c728da9ff6c316b1e4ded63a8f3940:

  fsverity: simplify fsverity_get_digest() (2022-11-29 21:07:41 -0800)

----------------------------------------------------------------

The main change this cycle is to stop using the PG_error flag to track
verity failures, and instead just track failures at the bio level.  This
follows a similar fscrypt change that went into 6.1, and it is a step
towards freeing up PG_error for other uses.

There's also one other small cleanup.

----------------------------------------------------------------
Eric Biggers (2):
      fsverity: stop using PG_error to track error status
      fsverity: simplify fsverity_get_digest()

 fs/ext4/readpage.c           |  8 ++----
 fs/f2fs/compress.c           | 64 +++++++++++++++++++++-----------------------
 fs/f2fs/data.c               | 53 ++++++++++++++++++++++--------------
 fs/verity/fsverity_private.h |  5 ++++
 fs/verity/hash_algs.c        |  6 +++++
 fs/verity/measure.c          | 19 ++-----------
 fs/verity/verify.c           | 12 ++++-----
 7 files changed, 85 insertions(+), 82 deletions(-)
