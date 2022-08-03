Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F09C589256
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Aug 2022 20:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237679AbiHCSjb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Aug 2022 14:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbiHCSjb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Aug 2022 14:39:31 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD0513F86;
        Wed,  3 Aug 2022 11:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=C3T2/yuorBjTVnc3eTSeUwnAXXhYy6yFUVo9qtMtnAw=; b=U4iNjG7XzUIMj1uLoxt6pH+CzK
        hHrTccps43Hl/OX1aTPvIPJkHHkrtR/wFJjb9Waj7BCFo8BTL3InmFS3aW81gxHTZoPaAjFIkSkBL
        HlH8mtvf8whIISKBCBA9WGbln/gl4/Bgr0t/EgjoYmvLvYjkmo72iLaH9mmBYViI1T3dGXmoh82pe
        2icjlEmj0bhq09Gctyf0rDYHm09eMgHBmI3wyeRhDbMFNNiBmedbuao1rKgy/hzshXy5A1REa3fpX
        Q6MHyqHwPn+kUZqUQNS4mqanHp+pA0eW/rwJH6FvU5ceFC3F325X2NSnwY7wL8BUrbq0341nMTz5C
        smDJVSAw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oJJHB-000urz-Bg;
        Wed, 03 Aug 2022 18:39:25 +0000
Date:   Wed, 3 Aug 2022 19:39:25 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs.git pile 3 - dcache
Message-ID: <YurA3aSb4GRr4wlW@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3:

  Linux 5.19-rc2 (2022-06-12 16:11:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-work.dcache

for you to fetch changes up to 50417d22d0efbb1be76c3cb66b2329f83741c9c7:

  fs/dcache: Move wakeup out of i_seq_dir write held region. (2022-07-30 00:38:16 -0400)

----------------------------------------------------------------
	Main part here is making parallel lookups safe for RT - making
sure preemption is disabled in start_dir_add()/ end_dir_add() sections (on
non-RT it's automatic, on RT it needs to to be done explicitly) and moving
wakeups from __d_lookup_done() inside of such to the end of those sections.
	Wakeups can be safely delayed for as long as ->d_lock on in-lookup
dentry is held; proving that has caught a bug in d_add_ci() that allows
memory corruption when sufficiently bogus ntfs (or case-insensitive xfs)
image is mounted.  Easily fixed, fortunately.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (1):
      d_add_ci(): make sure we don't miss d_lookup_done()

Sebastian Andrzej Siewior (3):
      fs/dcache: Disable preemption on i_dir_seq write side on PREEMPT_RT
      fs/dcache: Move the wakeup from __d_lookup_done() to the caller.
      fs/dcache: Move wakeup out of i_seq_dir write held region.

 fs/dcache.c            | 54 ++++++++++++++++++++++++++++++++++++++++----------
 include/linux/dcache.h |  9 +++------
 2 files changed, 46 insertions(+), 17 deletions(-)
