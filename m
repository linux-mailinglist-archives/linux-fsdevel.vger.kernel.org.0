Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C24D5A4C76
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Aug 2022 14:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbiH2Mww (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Aug 2022 08:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiH2Mwf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Aug 2022 08:52:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8541D2DC5
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Aug 2022 05:41:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E474B80EF3
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Aug 2022 12:41:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C95C433D6;
        Mon, 29 Aug 2022 12:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661776894;
        bh=aPOCQn/Z9eAVL31nTurejlO+9xnlT4ps6FZzeY5zOvY=;
        h=From:To:Cc:Subject:Date:From;
        b=QNB8jRE3n4mRsHmXUj06vWWlziLP0ibFTLo14caLPEEn4iJgHqGbfxG8w5xdg14S6
         MiEv3O+EpdwMHdeakQ/grMpKYVQP2p7hDgreU9p0iqaY7/ab30qJtCn43YO9JUFOFI
         aOZoNRMv638u4fCfiDTPhCGa5I4FUauQW0jBU02NgkjqoS0ebjym1KxXsJWEz4cINQ
         srGi5rlhhRp3hkEmC++fPKFddR6n1Xbeyl/ejTirzN4bVedbrWBLsI/5GE45VXJwZC
         cSUPGDc9xg1NStWc/dGn7zZuicPjdVkpiBYfM0iYstrXv+a9BRXFARGwNvkzQuByF4
         waxBOnAAKZuCg==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@digitalocean.com>
Subject: [PATCH 0/6] acl: rework idmap handling when setting posix acls
Date:   Mon, 29 Aug 2022 14:38:39 +0200
Message-Id: <20220829123843.1146874-1-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2356; i=brauner@kernel.org; h=from:subject; bh=lzV8IusXj184Su6J2fvGoccZnGs/Ym+KEp2kIFwJdOI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTzbPp9MvG5ZPz2lpxJ/RGO9+JeLFZ+nnjdeO6SyTucaw5+ Ebgj1VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARhpWMDPvvrU1y+vRUSrAob277pd emvwqWvGLp6GI0Yq450NauNoORYZemgTDnq0OvuhfI9bSt3M2y3CtMqv951g7BLy/YjEP3swIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Christian Brauner (Microsoft)" <brauner@kernel.org>

Hey everyone,

As explained in detail in [1] POSIX ACLs are a bit wonky as they abuse
the uapi POSIX ACL structure to transport the values of k{g,u}id_t as
raw {g,u}id stored in ACL_{GROUP,USER} entries down to the filesystems.

The values stored in the POSIX ACL uapi struct have been mapped into the
caller's idmapping in setxattr_convert(). In addition, the VFS needs to
take idmapped mounts into during vfs_setxattr(). Currently, it uses the
uapi POSIX ACL structure for this as well.

While the handling of idmapped mounts needs to happen in vfs_setxattr()
or deeper in its callchain to guarantee that overlayfs handles POSIX
ACLs correctly on top of idmapped layers it isn't necessary to further
abuse the uapi POSIX ACL structure for this.

Instead of taking idmapped mounts into account and updaing the values in
the POSIX ACL uapi struct directly in vfs_setxattr() we can move it down
into posix_acl_xattr_set() helper. This allows us to make the value
argument of vfs_setxattr() const and gets rid of an additional loop.

Ultimately, we hope to still get rid of the POSIX ACL uapi struct abuse
completely but that requires a little more work.

This series also ports ntfs3 to rely on the standard POSXI ACL xattr
handler instead of rolling its own (currently broken) implementation.

This survives xfstests and LTP.

Thanks!
Christian

[1]: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org

Christian Brauner (6):
  ntfs3: rework xattr handlers and switch to POSIX ACL VFS helpers
  acl: return EOPNOTSUPP in posix_acl_fix_xattr_common()
  acl: add vfs_set_acl_prepare()
  acl: move idmapping handling into posix_acl_xattr_set()
  ovl: use vfs_set_acl_prepare()
  xattr: constify value argument in vfs_setxattr()

 fs/ntfs3/inode.c                  |   2 -
 fs/ntfs3/xattr.c                  | 102 +----------
 fs/overlayfs/overlayfs.h          |   2 +-
 fs/overlayfs/super.c              |  15 +-
 fs/posix_acl.c                    | 288 +++++++++++++++++++++++-------
 fs/xattr.c                        |   8 +-
 include/linux/posix_acl_xattr.h   |   3 +
 include/linux/xattr.h             |   2 +-
 security/integrity/evm/evm_main.c |  17 +-
 9 files changed, 262 insertions(+), 177 deletions(-)


base-commit: b90cb1053190353cc30f0fef0ef1f378ccc063c5
-- 
2.34.1

