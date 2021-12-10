Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5AC4708DB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Dec 2021 19:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242557AbhLJSgf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Dec 2021 13:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbhLJSgf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Dec 2021 13:36:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D62C061746;
        Fri, 10 Dec 2021 10:33:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB70DB8294A;
        Fri, 10 Dec 2021 18:32:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02CBAC00446;
        Fri, 10 Dec 2021 18:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639161177;
        bh=Vzh7ORIEUg2oZxQm0F1iYv4bF6hVsSAECGqMhzkf6FA=;
        h=Date:From:To:Cc:Subject:From;
        b=kdaEcVAErUVuwbQQWgzM4yE3po43DBr0eEvli2lkNydaeCKWf+nl0zEcjoCPPJLzl
         CuqBBdKUMcbOqG+7nU9/qKA6xNSmVWgqE6JLO/b82+prZk9GxKzLjhGP9FWffy6fDz
         4GJWMuvI+HnlWudNBzmYaoMxh86dkY3gj8OyiL0twcFaoA7tCZrQVMd/kwlWw3bfC2
         Wyd+HdZwJLMS4w0PIikM7FR1AfK7A6aznT1KMygIdaZKTF+9CuPEYq9C26czA8v14L
         wGbDofcBwee6x4Z9Tq7sbBYwqezjlXZeTAC7f/gAYsYi/JemVo7rXxlt1S7GQVxKAm
         dT+al9pL8IqTA==
Date:   Fri, 10 Dec 2021 10:32:55 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ramji Jiyani <ramjiyani@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Xie Yongji <xieyongji@bytedance.com>
Subject: [GIT PULL] aio poll fixes for 5.16-rc5
Message-ID: <YbOdV8CPbyPAF234@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1:

  Linux 5.16-rc4 (2021-12-05 14:08:22 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git tags/aio-poll-for-linus

for you to fetch changes up to 4b3749865374899e115aa8c48681709b086fe6d3:

  aio: Fix incorrect usage of eventfd_signal_allowed() (2021-12-09 10:52:55 -0800)

----------------------------------------------------------------

Fix three bugs in aio poll, and one issue with POLLFREE more broadly:

  - aio poll didn't handle POLLFREE, causing a use-after-free.
  - aio poll could block while the file is ready.
  - aio poll called eventfd_signal() when it isn't allowed.
  - POLLFREE didn't handle multiple exclusive waiters correctly.

This has been tested with the libaio test suite, as well as with test
programs I wrote that reproduce the first two bugs.  I am sending this
pull request myself as no one seems to be maintaining this code.

----------------------------------------------------------------
Eric Biggers (5):
      wait: add wake_up_pollfree()
      binder: use wake_up_pollfree()
      signalfd: use wake_up_pollfree()
      aio: keep poll requests on waitqueue until completed
      aio: fix use-after-free due to missing POLLFREE handling

Xie Yongji (1):
      aio: Fix incorrect usage of eventfd_signal_allowed()

 drivers/android/binder.c        |  21 ++---
 fs/aio.c                        | 186 ++++++++++++++++++++++++++++++++--------
 fs/signalfd.c                   |  12 +--
 include/linux/wait.h            |  26 ++++++
 include/uapi/asm-generic/poll.h |   2 +-
 kernel/sched/wait.c             |   7 ++
 6 files changed, 196 insertions(+), 58 deletions(-)
