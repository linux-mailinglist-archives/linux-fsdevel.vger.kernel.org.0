Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3333A7368E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 12:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbjFTKLW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 06:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbjFTKLU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 06:11:20 -0400
X-Greylist: delayed 538 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 20 Jun 2023 03:11:19 PDT
Received: from forward200a.mail.yandex.net (forward200a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC12A2;
        Tue, 20 Jun 2023 03:11:19 -0700 (PDT)
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d103])
        by forward200a.mail.yandex.net (Yandex) with ESMTP id 2DCC64A0D8;
        Tue, 20 Jun 2023 12:55:42 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:5e51:0:640:23ee:0])
        by forward103a.mail.yandex.net (Yandex) with ESMTP id EE78C46C91;
        Tue, 20 Jun 2023 12:55:32 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id Utd7jIuDca60-FHm4Ipak;
        Tue, 20 Jun 2023 12:55:32 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1687254932;
        bh=hY46ZClPP9+NLwarO4tWKAup6MP0se1suvHpVvDPsAU=;
        h=Message-Id:Date:Cc:Subject:To:From;
        b=qoqaIRpV3bFWmt1BFyIn7vZbg/hftQx1uYO+qvw/KxsKHbW5ZWMtnm5QW+g/+jeEq
         4GY5kmtRUAZD7fo+3M/qrIiPzJ17r7P+ge4ysmKdPswEUHKTYwtYqvsY17Gnigo4PL
         Mk97FVN2y6v+meBriWpBDi5fgO9/0QGEPdCA3owk=
Authentication-Results: mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Stas Sergeev <stsp2@yandex.ru>
To:     linux-kernel@vger.kernel.org
Cc:     Stas Sergeev <stsp2@yandex.ru>, Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH 0/3] RFC: F_OFD_GETLK should provide more info
Date:   Tue, 20 Jun 2023 14:55:04 +0500
Message-Id: <20230620095507.2677463-1-stsp2@yandex.ru>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch-set implements 2 small extensions to the current F_OFD_GETLK,
allowing it to gather more information than it currently returns.

First extension allows to use F_UNLCK on query, which currently returns
EINVAL. Instead it can be used to query the locks on a particular fd -
something that is not currently possible. The basic idea is that on
F_OFD_GETLK, F_UNLCK would "conflict" with (or query) any types of the
lock on the same fd, and ignore any locks on other fds.

Use-cases:

1. CRIU-alike scenario when you want to read the locking info from an
fd for the later reconstruction. This can now be done by setting
l_start and l_len to 0 to cover entire file range, and do F_OFD_GETLK.
In the loop you need to advance l_start past the returned lock ranges,
to eventually collect all locked ranges.

2. Implementing the lock checking/enforcing policy.
Say you want to implement an "auditor" module in your program,
that checks that the I/O is done only after the proper locking is
applied on a file region. In this case you need to know if the
particular region is locked on that fd, and if so - with what type
of the lock. If you would do that currently (without this extension)
then you can only check for the write locks, and for that you need to
probe the lock on your fd and then open the same file via nother fd and
probe there. That way you can identify the write lock on a particular
fd, but such trick is non-atomic and complex. As for finding out the
read lock on a particular fd - impossible.
This extension allows to do such queries without any extra efforts.

3. Implementing the mandatory locking policy.
Suppose you want to make a policy where the write lock inhibits any
unlocked readers and writers. Currently you need to check if the
write lock is present on some other fd, and if it is not there - allow
the I/O operation. But because the write lock can appear at any moment,
you need to do that under some global lock, which can be released only
when the I/O operation is finished.
With the proposed extension you can instead just check the write lock
on your own fd first, and if it is there - allow the I/O operation on
that fd without using any global lock. Only if there is no write lock
on this fd, then you need to take global lock and check for a write
lock on other fds.


The second patch implements another extension.
Currently F_OFD_GETLK returns -1 in the l_pid member.
This patch removes the code that writes -1 there, so that the proper
pid is returned. I am not sure why it was decided to deliberately hide
the owner's pid. It may be needed in case you want to send some
message to the offending locker, like eg SIGKILL.


The third patch adds a test-case for OFD locks.
It tests both the generic things and the proposed extensions.

Stas Sergeev (3):
  fs/locks: F_UNLCK extension for F_OFD_GETLK
  fd/locks: allow get the lock owner by F_OFD_GETLK
  selftests: add OFD lock tests

 fs/locks.c                                 |  25 +++-
 tools/testing/selftests/locking/Makefile   |   2 +
 tools/testing/selftests/locking/ofdlocks.c | 135 +++++++++++++++++++++
 3 files changed, 157 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/locking/ofdlocks.c

CC: Jeff Layton <jlayton@kernel.org>
CC: Chuck Lever <chuck.lever@oracle.com>
CC: Alexander Viro <viro@zeniv.linux.org.uk>
CC: Christian Brauner <brauner@kernel.org>
CC: linux-fsdevel@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: Shuah Khan <shuah@kernel.org>
CC: linux-kselftest@vger.kernel.org

-- 
2.39.2

