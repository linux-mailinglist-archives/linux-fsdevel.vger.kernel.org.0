Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C570346BD91
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Dec 2021 15:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237759AbhLGO2p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 09:28:45 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:43330 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237755AbhLGO2p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 09:28:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A29C9CE1B1A
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Dec 2021 14:25:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 516FFC341CF;
        Tue,  7 Dec 2021 14:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638887111;
        bh=Z1dGNOGRxCczXmBbjHV87FNscMlbPgEVYufPzMRT2aE=;
        h=From:To:Cc:Subject:Date:From;
        b=DioTiWUUF/irPMznN1ry//tpnHb9qX57YIN0Go4fK3McplQHN6sgcAicmjF2n2ddk
         zM+qFEVpHjzLSAicv1alqGWQ5Nc1rul/9C+KeO6bCnny9flaSGZ1Jh7IdcXBVjjzmV
         kIQjJOsauLswXPYDBQW6AG8mzUMriiMt3fLGX/+AGMTs96CxdFLA5YN7m4Y5M29d+f
         SdTP4lDNZB/bzfX/DEx+D8H0Wv5+gx6OpRvmWsQlwwPzIK+aIgbN1lZ2Sj4bATBUxu
         Bzc9nWtA8v542PAyxPp4LWI5037BiMR73pwArCSkNUMf3bU9EWFqNRvFmtVN+A65NC
         nNU+t7vIFaW0w==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Pull trivial helper to preempt fscache merge conflict?
Date:   Tue,  7 Dec 2021 15:24:07 +0100
Message-Id: <20211207142405.179428-1-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey Linus,

Stephen informed David and me that there's a merge conflict in next between
David's fscache tree and my idmapping tree due to him deleting a file I'm
modifying. I talked to David yesterday and he asked me to check whether you
want to pull the commit that causes the merge conflict now.

Since the patch has extremely low regression potential I did agree to at
least ask you. But no problem if you'd rather fix it yourself during the
next merge window should you decide to pull.

(Technically David did just ask whether you'd pull the static inline
function itself to add back the bit that he deletes in a later patch but
that seems almost not worth it then so I decided to ask you about the whole
patch.)

This adds a simple helper to determine whether a mnt is idmapped and
replaces all current six instances that open-code this check now.

The patch has been in next for a few days now without build warnings or
regressions and fstests pass.

Christian

The following changes since commit d58071a8a76d779eedab38033ae4c821c30295a5:

  Linux 5.16-rc3 (2021-11-28 14:09:19 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.idmapped.fixes.v5.16-rc5

for you to fetch changes up to bb49e9e730c2906a958eee273a7819f401543d6c:

  fs: add is_idmapped_mnt() helper (2021-12-03 18:44:06 +0100)

----------------------------------------------------------------
fs.idmapped.fixes.v5.16-rc5

----------------------------------------------------------------
Christian Brauner (1):
      fs: add is_idmapped_mnt() helper

 fs/cachefiles/bind.c |  2 +-
 fs/ecryptfs/main.c   |  2 +-
 fs/namespace.c       |  2 +-
 fs/nfsd/export.c     |  2 +-
 fs/overlayfs/super.c |  2 +-
 fs/proc_namespace.c  |  2 +-
 include/linux/fs.h   | 14 ++++++++++++++
 7 files changed, 20 insertions(+), 6 deletions(-)
