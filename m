Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654D569A6A5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Feb 2023 09:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjBQIKj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Feb 2023 03:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjBQIKU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Feb 2023 03:10:20 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF045ECBA;
        Fri, 17 Feb 2023 00:10:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 641A4CE2C73;
        Fri, 17 Feb 2023 08:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C52C433D2;
        Fri, 17 Feb 2023 08:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676621414;
        bh=NI1/kj+6SSROnQAFsZp/dzHzswdLFNUOD3A7hmPPR8o=;
        h=From:To:Cc:Subject:Date:From;
        b=fbZ3GveITZUXUsSii8I3KJR8XCRz4LQUFJM/yCfeueaklno1liMN0jZThWSB0/gEC
         T/z4IUVg+0rkKfkiq5DOpNJ/C1JXV2vxG+glO7zWaOVYun8wf5Uy2FyyW8tw27DaxR
         xmxiD9EluD7A+Gny0DnkDCQ6sJYzL59F7ZtUTevoZKzRMnDOUJZW5m/saVwmT1N/PM
         vkG9PooM50Iz6KLgUuANxt6YUIjUmTfac+QUqv9/jK6yxrFiGuwB8RJzZ1UCw+aSWS
         2Su9VB1XE5koO9GDr+7FW4yH4JelyB1Fey5HRvu2AN3OJpexHoT1cXqemQpC2hYOSP
         F5UeJgynSPgAA==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] acl updates for v6.3
Date:   Fri, 17 Feb 2023 09:10:04 +0100
Message-Id: <20230217081004.1629199-1-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1638; i=brauner@kernel.org; h=from:subject; bh=NI1/kj+6SSROnQAFsZp/dzHzswdLFNUOD3A7hmPPR8o=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSS/N/0q9nhxwcMChoMRuf8fSjS3HxbYc8fpAZMdxwbLhzMC zz+o7ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIrbUM/wNvHdA/WGvVx9R2Rk+/rq D1+25t8fTOEB92m/WJmybUbGL4X6wZdvgLu8aP6HUv2evLtldtLXgxu6WmJE7BZnX/on/CPAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey Linus,

/* Summary */
This contains a single update to the internal get acl method and
replaces an open-coded cmpxchg() comparison with with try_cmpxchg().
It's clearer and also beneficial on some architectures.

/* Testing */
clang: Ubuntu clang version 15.0.2-1
gcc: gcc (Ubuntu 12.2.0-3ubuntu1) 12.2.0

All patches are based on v6.2-rc1 and have been sitting in linux-next.
No build failures or warnings were observed. All old and new tests in
fstests, selftests, and LTP pass without regressions.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with
current mainline.

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.acl.v6.3

for you to fetch changes up to 4e1da8fe031303599e78f88e0dad9f44272e4f99:

  posix_acl: Use try_cmpxchg in get_acl (2023-01-08 12:37:49 +0100)

Please consider pulling these changes from the signed fs.acl.v6.3 tag.

I'm on vacation until v6.2 is released this Sunday but Amir or Seth know
how to reach me quite easily before that in case anything goes wrong.

Thanks!
Christian

----------------------------------------------------------------
fs.acl.v6.3

----------------------------------------------------------------
Uros Bizjak (1):
      posix_acl: Use try_cmpxchg in get_acl

 fs/posix_acl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
