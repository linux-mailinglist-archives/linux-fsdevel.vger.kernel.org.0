Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C81878751B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 18:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242128AbjHXQTt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Aug 2023 12:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242508AbjHXQTb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:19:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF291FD5
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Aug 2023 09:19:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A8F467047
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Aug 2023 16:19:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 032ABC433C9;
        Thu, 24 Aug 2023 16:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692893942;
        bh=fgODWolnoqq5zpODMmlsDVxxmhdPUbz6B19iTv8hL0Q=;
        h=Subject:From:To:Cc:Date:From;
        b=AWARVuBSgYkFc8IznXFuI2iwTVhXZCcByKabdEr1LtXWCgGlC2eGLl3ozx1BS7v9J
         Gssm3SObDo5IqbfZr3d/ucJ6la7NMlWCvHp6KXHKyjHY4kSB1jmiSG1bG3n/0tJi8X
         C2TsSSO4j3A8b+lHao2EewlDRNT112XapL49wCbs4TANYyOCncvVT0Q9bOXcb6tJeo
         3JJrLK1uf6341ndhSSu5CXO03pPB3Id++8Z9V7dz5ECaPUlVrgdXVJNTtuzZ5A7Qjo
         GCZ00zG4j1WHkPOmp4e6P2OmxHIZ49kvpgUFw7qhZrvrKuTUh88gvcUDR++zslbtl7
         M59dk+JT1ObLQ==
Message-ID: <be49e494a64fc983e87fd96a441a4f13a62d4362.camel@kernel.org>
Subject: [GIT PULL] file locking updates for v6.6
From:   Jeff Layton <jlayton@kernel.org>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Will Shiu <Will.Shiu@mediatek.com>, jwilk@jwilk.net,
        Stas Sergeev <stsp2@yandex.ru>,
        Chuck Lever <chuck.lever@oracle.com>
Date:   Thu, 24 Aug 2023 12:19:00 -0400
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[jlayton@tleilax linux]$ git request-pull 1ef6663a587b git://git.kernel.org=
/pub/scm/linux/kernel/git/jlayton/linux.git filelock-v6.6
The following changes since commit 1ef6663a587ba3e57dc5065a477db1c64481eedd=
:

  Merge tag 'tag-chrome-platform-for-v6.5' of git://git.kernel.org/pub/scm/=
linux/kernel/git/chrome-platform/linux (2023-06-26 20:12:07 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git tags/file=
lock-v6.6

for you to fetch changes up to 74f6f5912693ce454384eaeec48705646a21c74f:

  locks: fix KASAN: use-after-free in trace_event_raw_event_filelock_lock (=
2023-08-24 10:42:19 -0400)

----------------------------------------------------------------
Just a few patches in this cycle:

- new functionality for F_OFD_GETLK: requesting a type of F_UNLCK will find=
 info about whatever lock happens to be first in the given range, regardles=
s of type.
- an OFD lock selftest
- bugfix involving a UAF in a tracepoint
- comment typo fix

----------------------------------------------------------------
Jakub Wilk (1):
      fs/locks: Fix typo

Stas Sergeev (2):
      fs/locks: F_UNLCK extension for F_OFD_GETLK
      selftests: add OFD lock tests

Will Shiu (1):
      locks: fix KASAN: use-after-free in trace_event_raw_event_filelock_lo=
ck

 fs/locks.c                                  |  27 ++++++++--
 tools/testing/selftests/filelock/Makefile   |   5 ++
 tools/testing/selftests/filelock/ofdlocks.c | 132 ++++++++++++++++++++++++=
++++++++++++++++++++++++
 3 files changed, 159 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/filelock/Makefile
 create mode 100644 tools/testing/selftests/filelock/ofdlocks.c

--=20
Jeff Layton <jlayton@kernel.org>
