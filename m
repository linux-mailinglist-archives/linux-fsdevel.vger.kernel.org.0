Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537D754F091
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jun 2022 07:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbiFQFf2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jun 2022 01:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiFQFf1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jun 2022 01:35:27 -0400
Received: from smtp03.aussiebb.com.au (smtp03.aussiebb.com.au [121.200.0.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A37527CEC;
        Thu, 16 Jun 2022 22:35:26 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp03.aussiebb.com.au (Postfix) with ESMTP id B607D1A0089;
        Fri, 17 Jun 2022 15:35:24 +1000 (AEST)
X-Virus-Scanned: Debian amavisd-new at smtp03.aussiebb.com.au
Received: from smtp03.aussiebb.com.au ([127.0.0.1])
        by localhost (smtp03.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CcQxztOSE9xy; Fri, 17 Jun 2022 15:35:24 +1000 (AEST)
Received: by smtp03.aussiebb.com.au (Postfix, from userid 119)
        id ACD071A0082; Fri, 17 Jun 2022 15:35:24 +1000 (AEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
Received: from donald.themaw.net (180-150-90-198.b4965a.per.nbn.aussiebb.net [180.150.90.198])
        by smtp03.aussiebb.com.au (Postfix) with ESMTP id 2FF621A0080;
        Fri, 17 Jun 2022 15:35:24 +1000 (AEST)
Subject: [PATCH 0/6] autofs: misc patches
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 17 Jun 2022 13:35:23 +0800
Message-ID: <165544393032.250070.3426550720222448062.stgit@donald.themaw.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series contains several patches that resulted mostly from comments
made by Al Viro (quite a long time ago now).

They are:
- make use of the .permission() method for access checks.
- use dentry info count instead of simple_empty() to avoid
  taking a spinlock.
- add a use cases comment to autofs_mountpoint_changed().
- make better use of mount trigger flags (I think this was
  actually mentioned by me at the time).

Others:
- fix usage consistency problem with dentry info count.
- remove unused inode field from info struct.

Signed-off-by: Ian Kent <raven@themaw.net>
---

Ian Kent (6):
      autofs: use inode permission method for write access
      autofs: make dentry info count consistent
      autofs: use dentry info count instead of simple_empty()
      autofs: add comment about autofs_mountpoint_changed()
      autofs: remove unused ino field inode
      autofs: manage dentry info mount trigger flags better


 fs/autofs/autofs_i.h |   7 +-
 fs/autofs/expire.c   |   2 +-
 fs/autofs/inode.c    |   1 +
 fs/autofs/root.c     | 203 +++++++++++++++++++------------------------
 4 files changed, 98 insertions(+), 115 deletions(-)

--
Ian Kent

