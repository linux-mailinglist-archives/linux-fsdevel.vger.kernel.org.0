Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEDBD587258
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Aug 2022 22:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbiHAUbg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Aug 2022 16:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbiHAUbf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Aug 2022 16:31:35 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10132A421;
        Mon,  1 Aug 2022 13:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=4jh4kQGu6gukhOtDtPB04ygoxMJ+tn6uaTTsSiR87xU=; b=SMf4twsT/3bAVdIcT3GE4tLGZc
        F0AxTDgsRuH22VqZC6FpeSA5v6iRaY1LRrF0BII8tSmMbjngg/RebUyCsWpjeQnMDbtriF6Nt+Ju7
        Ppf+bFKQZ/JQPho8XPlqHnCy2JGcUtYtrFLflIpzCJAVnRjnLHAs/a7+ZXXGiv9SCzJMLt2Zr/IjM
        bnfTkuFhaepMTg3tJ7Vrt+s6hBJMUHNnvwraXTySI5ig4QMix/7rwGc0KxUBEA2kxvEQP+0rPNy8n
        +SuK/HjXjFbcTue4BAKAIZT98Ax8vLqkS9GwudoRpaKlekWIfKz4YcFdEdZ/EVuSzPmGhyJ4Fm7Mm
        xzz7of1Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oIc4Y-000PF5-Mf;
        Mon, 01 Aug 2022 20:31:30 +0000
Date:   Mon, 1 Aug 2022 21:31:30 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git pull] vfs.git pile 2 - lseek stuff
Message-ID: <Yug4Is18ZrZ3fEAy@ZenIV>
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

	Jason's lseek series.  One note: after that no_llseek is defined
to NULL; boilerplate initializers ought to be removed, but that's better
done at the end of merge window - fewer conflicts that way.  Could you run

git grep -l -w no_llseek | grep -v porting.rst | while read i; do
	sed -i '/\<no_llseek\>/d' $i
done

just before -rc1 to take that boilerplate out?

The following changes since commit b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3:

  Linux 5.19-rc2 (2022-06-12 16:11:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-work.lseek

for you to fetch changes up to 868941b14441282ba08761b770fc6cad69d5bdb7:

  fs: remove no_llseek (2022-07-16 09:19:47 -0400)

----------------------------------------------------------------
	Saner handling of "lseek should fail with ESPIPE" - gets rid of
magical no_llseek thing and makes checks consistent.  In particular,
ad-hoc "can we do splice via internal pipe" checks got saner (and
somewhat more permissive, which is what Jason had been after, AFAICT)

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Jason A. Donenfeld (6):
      fs: clear or set FMODE_LSEEK based on llseek function
      fs: do not compare against ->llseek
      dma-buf: remove useless FMODE_LSEEK flag
      vfio: do not set FMODE_LSEEK flag
      fs: check FMODE_LSEEK to control internal pipe splicing
      fs: remove no_llseek

 Documentation/filesystems/porting.rst |  8 ++++++++
 drivers/dma-buf/dma-buf.c             |  1 -
 drivers/gpu/drm/drm_file.c            |  3 +--
 drivers/vfio/vfio.c                   |  2 +-
 fs/coredump.c                         |  4 ++--
 fs/file_table.c                       |  2 ++
 fs/open.c                             |  2 ++
 fs/overlayfs/copy_up.c                |  3 +--
 fs/read_write.c                       | 17 +++--------------
 fs/splice.c                           | 10 ++++------
 include/linux/fs.h                    |  2 +-
 kernel/bpf/bpf_iter.c                 |  3 +--
 12 files changed, 26 insertions(+), 31 deletions(-)
