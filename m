Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90726992FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Feb 2023 12:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbjBPLT2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Feb 2023 06:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjBPLT1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Feb 2023 06:19:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764AC38B66;
        Thu, 16 Feb 2023 03:19:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F05E61F9F;
        Thu, 16 Feb 2023 11:19:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C89C4339B;
        Thu, 16 Feb 2023 11:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676546359;
        bh=Ej2M6nJkj83iw+yplLuLgotcuN1y8Zg1nv+7T1VM/Iw=;
        h=Subject:From:To:Cc:Date:From;
        b=qitB8TwIBKkSpIzc+3c4XbH+xyEXoU1mdnr8kqB4fEt/KRi0y2vv7ewSTBNPLDJAw
         67oZmaW7eZiLnoN8T2uoKUIaKWuMHe5pmCSwnXvOJM5BdtP+JQqUx8cn8N61Pi63eP
         /NvufzDwSu19ydWcH9c6oxc1HF5/4xm1RruYW0R1f9QprsZdzx8MeQmFLy5lPtCM6y
         yViv0eTZGOMMT2/nwUZnhKRatkbevtH/2BBNfJi0iIlPqkPXKrFZHwqkHYEsLW/tXJ
         FvsT3/t3xLcvu1AnCWBej5aeWL60XzvusYUo55CiIzqbYRovBond7MdOhU9mI72Yj+
         XE98R7sXLAfkQ==
Message-ID: <0d67a8a252ef22c6506f45761c2f7d1185a44190.camel@kernel.org>
Subject: [GIT PULL] i_version handling changes for v6.3
From:   Jeff Layton <jlayton@kernel.org>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Thu, 16 Feb 2023 06:19:17 -0500
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 948ef7bb70c4acaf74d87420ea3a1190862d4548=
:

  Merge tag 'modules-6.2-rc6' of git://git.kernel.org/pub/scm/linux/kernel/=
git/mcgrof/linux (2023-01-24 18:19:44 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git tags/iv=
ersion-v6.3

for you to fetch changes up to 58a033c9a3e003e048a0431a296e58c6b363b02b:

  nfsd: remove fetch_iversion export operation (2023-01-26 07:00:06 -0500)

----------------------------------------------------------------
I meant to send this for v6.2, but dropped the ball, so this has been in
linux-next for quite some time now.

This overhauls how we handle i_version queries from nfsd. Instead of
having special routines and grabbing the i_version field directly out of
the inode in some cases, we've moved most of the handling into the
various filesystems' getattr operations. As a bonus, this makes ceph's
change attribute usable by knfsd as well.

This should pave the way for future work to make this value queryable by
userland, and to make it more resilient against rolling back on a crash.

Note that Stephen Rothwell reported a minor merge conflict with this
series and vfs-idmapping tree:

https://lore.kernel.org/linux-next/20230119101423.547b48b7@canb.auug.org.au=
/T/#u
----------------------------------------------------------------
Jeff Layton (8):
      fs: uninline inode_query_iversion
      fs: clarify when the i_version counter must be updated
      vfs: plumb i_version handling into struct kstat
      nfs: report the inode version in getattr if requested
      ceph: report the inode version in getattr if requested
      nfsd: move nfsd4_change_attribute to nfsfh.c
      nfsd: use the getattr operation to fetch i_version
      nfsd: remove fetch_iversion export operation

 fs/ceph/inode.c          | 16 +++++++++++-----
 fs/libfs.c               | 36 ++++++++++++++++++++++++++++++++++++
 fs/nfs/export.c          |  7 -------
 fs/nfs/inode.c           | 16 ++++++++++++----
 fs/nfsd/nfs4xdr.c        |  4 +++-
 fs/nfsd/nfsfh.c          | 42 ++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/nfsfh.h          | 29 +----------------------------
 fs/nfsd/vfs.h            |  7 ++++++-
 fs/stat.c                | 17 +++++++++++++++--
 include/linux/exportfs.h |  1 -
 include/linux/iversion.h | 60 ++++++++++++++++++++++----------------------=
----------------
 include/linux/stat.h     |  9 +++++++++
 12 files changed, 157 insertions(+), 87 deletions(-)

--=20
Jeff Layton <jlayton@kernel.org>
