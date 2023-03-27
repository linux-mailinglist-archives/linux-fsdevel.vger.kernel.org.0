Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FF46CACEB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 20:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbjC0SXD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 14:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjC0SXC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 14:23:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65A42D4F;
        Mon, 27 Mar 2023 11:23:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83B22B816D6;
        Mon, 27 Mar 2023 18:23:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A61C433EF;
        Mon, 27 Mar 2023 18:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679941379;
        bh=OqeOKOE1wERV1W7qLi4nymfleT0u4Hl2VHEg6Hh+1/0=;
        h=From:Subject:Date:To:Cc:From;
        b=BQRGKboNv6ZIi2V2OtSnsz3oHYDGIjuT117tRJJTAsNK73Q5WKlxMfDjJzA9rHDZZ
         +tjVwMp6CAHHj7QrFbusmkLhD5xGETpfYC3hPN5xiunwx4+YE1bczghD8677ChtxJF
         U9Dilalz9H3b0lgEAqKAhndC0jyq4eTkYEQRB2SDUDxQC4YCkyy7eHKBP/bsxOOU+B
         /SbRZg/HuCpq42tbxs4+bNhwLJxy3VIs7YuUCO7MaYctY8NfU1qNJAg3NGS4JuXnq3
         ouY0pnpV+0uxwPNVFCd4SvIi4DoObtnLFZ9vG0NHHYoxtv5ekDjoP7WZmFGrtMG7U7
         IAvRmUsPjyuxw==
From:   Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/3] pidfd: add pidfd_prepare()
Date:   Mon, 27 Mar 2023 20:22:50 +0200
Message-Id: <20230327-pidfd-file-api-v1-0-5c0e9a3158e4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPreIWQC/x2NQQrCMBAAv1L27JaYSI1+RTxsko1d0Bg2UoTSv
 5t6HJhhVmiswg2uwwrKizR5lw7HwwBxpvJglNQZrLHOOHvGKiknzPJkpCrog/Vp8jEbukCPAjX
 GoFTivGcvah/WcZlGhxpPu1GVs3z/y9t9237oUI/4ggAAAA==
To:     linux-fsdevel@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Matthew Bobrowski <repnop@google.com>,
        linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-00303
X-Developer-Signature: v=1; a=openpgp-sha256; l=1220; i=brauner@kernel.org;
 h=from:subject:message-id; bh=OqeOKOE1wERV1W7qLi4nymfleT0u4Hl2VHEg6Hh+1/0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQo3me4qf7wrMVXPy/RsrPtrPp50ZKre3LeJaWXmvRpquwv
 Lb/YUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMBGODQz/FK1Ld8zy+n+95nnEY7fvDy
 pysi/YSD3SWSZkH5guVCQmw8jwYwu79bT5l91unjqYu2ra2b8Xt8mVHemYdb7X+NqE5lMXuAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds the pidfd_prepare() helper which allows the caller to reserve
a pidfd number and allocates a new pidfd file that stashes the provided
struct pid.

This will allow us to remove places that either open code this
functionality e.g., during copy_process() or that currently call
pidfd_create() but then have to call close_fd() because there are still
failure points after pidfd_create() has been called.

Other functionality wants to make use of pidfd's as well and they need a
pidfd_prepare() internal api as well.

I've tested the fanotify and fork changes via LTP which provides
coverage for all the affected codepaths.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (3):
      pid: add pidfd_prepare()
      fork: use pidfd_prepare()
      fanotify: use pidfd_prepare()

 fs/notify/fanotify/fanotify_user.c | 13 ++++---
 include/linux/pid.h                |  1 +
 kernel/fork.c                      | 12 +------
 kernel/pid.c                       | 69 +++++++++++++++++++++++++++++++-------
 4 files changed, 68 insertions(+), 27 deletions(-)
---
base-commit: 197b6b60ae7bc51dd0814953c562833143b292aa
change-id: 20230327-pidfd-file-api-8b28d68cf0a9

