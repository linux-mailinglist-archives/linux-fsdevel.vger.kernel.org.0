Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D346A1552
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Feb 2023 04:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjBXD1A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Feb 2023 22:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBXD07 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Feb 2023 22:26:59 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AE94ECF7;
        Thu, 23 Feb 2023 19:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=PyOIrIQ40A989oDPmdzXDCc7yzBUmFmPHD6fjPINY60=; b=mlpgbniti13aApcxkm+llzBkW5
        NuTs4hjCeTIDB4oiIzguaz6NqplNjCVvxjVddf9Zbsx4vb2gt745lMqBr6rirKqMmQAyTEcR+EwZn
        OQWymosDnTRzzdUkmw3rkmSYiEVzTCLlhhVCLD3Zph5ry8fzvgjYEE2REv7XSeOP/upgZZxWVcK9r
        ZybXokMn1pYHh2CyA3tY/cqDHP0tEGhqYJWLr92/lnwstkUqkq+wmQnYAZDN3YajvsSgtz0MizuBy
        DzLBoEe5L0g1P2XK+7K5RpWjaPuBQqCBI/6w/ztPkQ0s0iNhGTJkm84XJ5tio/BO6Pr530YpfolXn
        21nfkfHA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pVOjZ-00Bs5N-0M;
        Fri, 24 Feb 2023 03:26:57 +0000
Date:   Fri, 24 Feb 2023 03:26:57 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs.git sysv pile
Message-ID: <Y/gugbqq858QXJBY@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Fabio's "switch to kmap_local_page()" patchset (originally after the
ext2 counterpart, with a lot of cleaning up done to it; as the matter of
fact, ext2 side is in need of similar cleanups - calling conventions there
are bloody awful).  Plus the equivalents of minix stuff...

The following changes since commit b7bfaa761d760e72a969d116517eaa12e404c262:

  Linux 6.2-rc3 (2023-01-08 11:49:43 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.sysv

for you to fetch changes up to abb7c742397324f8676c5b622effdce911cd52e3:

  sysv: fix handling of delete_entry and set_link failures (2023-01-19 23:24:42 -0500)

----------------------------------------------------------------
Al Viro (1):
      sysv: fix handling of delete_entry and set_link failures

Christoph Hellwig (1):
      sysv: don't flush page immediately for DIRSYNC directories

Fabio M. De Francesco (4):
      fs/sysv: Use the offset_in_page() helper
      fs/sysv: Change the signature of dir_get_page()
      fs/sysv: Use dir_put_page() in sysv_rename()
      fs/sysv: Replace kmap() with kmap_local_page()

 fs/sysv/dir.c   | 154 ++++++++++++++++++++++++++++++++------------------------
 fs/sysv/namei.c |  42 ++++++++--------
 fs/sysv/sysv.h  |   3 +-
 3 files changed, 111 insertions(+), 88 deletions(-)
