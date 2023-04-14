Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1406E26E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 17:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjDNP0P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 11:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjDNP0P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 11:26:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 54A2FC674;
        Fri, 14 Apr 2023 08:25:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 947FE2F4;
        Fri, 14 Apr 2023 08:25:56 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4BAA93F6C4;
        Fri, 14 Apr 2023 08:25:10 -0700 (PDT)
From:   Luca Vizzarro <Luca.Vizzarro@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Luca Vizzarro <Luca.Vizzarro@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        David Laight <David.Laight@ACULAB.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        linux-fsdevel@vger.kernel.org, linux-morello@op-lists.linaro.org
Subject: [PATCH v2 0/5] Alter fcntl to handle int arguments correctly
Date:   Fri, 14 Apr 2023 16:24:54 +0100
Message-Id: <20230414152459.816046-1-Luca.Vizzarro@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

According to the documentation of fcntl, some commands take an int as
argument. In practice not all of them enforce this behaviour, as they
instead accept a more permissive long and in most cases not even a
range check is performed.

An issue could possibly arise from a combination of the handling of the
varargs in user space and the ABI rules of the target, which may result
in the top bits of an int argument being non-zero.

This issue was originally raised and detailed in the following thread:
  https://lore.kernel.org/linux-api/Y1%2FDS6uoWP7OSkmd@arm.com/
And was discovered during the porting of Linux to Morello [1].

This series modifies the interested commands so that they explicitly
take an int argument. It also propagates this change down to helper and
related functions as necessary.

This series is also available on my fork at:
  https://git.morello-project.org/Sevenarth/linux/-/commits/fcntl-int-handling-v2

Best regards,
Luca Vizzarro

[1] https://git.morello-project.org/morello/kernel/linux

Luca Vizzarro (5):
  fcntl: Cast commands with int args explicitly
  fs: Pass argument to fcntl_setlease as int
  pipe: Pass argument of pipe_fcntl as int
  memfd: Pass argument of memfd_fcntl as int
  dnotify: Pass argument of fcntl_dirnotify as int

 fs/cifs/cifsfs.c            |  2 +-
 fs/fcntl.c                  | 29 +++++++++++++++--------------
 fs/libfs.c                  |  2 +-
 fs/locks.c                  | 20 ++++++++++----------
 fs/nfs/nfs4_fs.h            |  2 +-
 fs/nfs/nfs4file.c           |  2 +-
 fs/nfs/nfs4proc.c           |  4 ++--
 fs/notify/dnotify/dnotify.c |  4 ++--
 fs/pipe.c                   |  6 +++---
 include/linux/dnotify.h     |  4 ++--
 include/linux/filelock.h    | 12 ++++++------
 include/linux/fs.h          |  6 +++---
 include/linux/memfd.h       |  4 ++--
 include/linux/pipe_fs_i.h   |  4 ++--
 mm/memfd.c                  |  6 +-----
 15 files changed, 52 insertions(+), 55 deletions(-)

-- 
2.34.1

