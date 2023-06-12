Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA8472C14C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 12:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237130AbjFLK5x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 06:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236857AbjFLK5d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:57:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3676E8F;
        Mon, 12 Jun 2023 03:45:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C57762440;
        Mon, 12 Jun 2023 10:45:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C95ECC433D2;
        Mon, 12 Jun 2023 10:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686566728;
        bh=gJ8OBMKp8a//Ju9x8kyPOKR1y9jleYMRtZlvKB2haqY=;
        h=From:To:Subject:Date:From;
        b=ajv43haiuJi4XPe/D7BlbV0d5Dfbz9Cvp3DS2g5UhWuVJbeHzWPJbD2tBEmIQv46y
         95VJd3njR2OYSMyYgff7Fg9K4B3yGgm0b3QUT6CPhPinqffou45tgfMkNvnlcGdctq
         IjMSVM3qFyKJF/wsJnqRzQpZzf4uPYT59IsXnYcVxT2sjEHkRs/Y5k7oya095he0P9
         wkpoSwiJHvhclSQFCxkLrYjL6/DW5YSIVuOqcblvOkrHlUFDDobgLRsjCb6BCiNuJK
         /wqfEqxBnDnbW8JjK/MATIKrKrqFTxQ415+OSVHUhZ9GfW508KlcGXnS52pAQbnxlV
         oLPD9erhPDPMA==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Brad Warrum <bwarrum@linux.ibm.com>,
        Ritu Agarwal <rituagar@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Kent <raven@themaw.net>,
        "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
        Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Ruihan Li <lrh2000@pku.edu.cn>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Suren Baghdasaryan <surenb@google.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        autofs@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2 0/8] fs: add some missing ctime updates
Date:   Mon, 12 Jun 2023 06:45:16 -0400
Message-Id: <20230612104524.17058-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

v2:
- drop gfs2 patch as it involved (hidden) quota inode
- clarify patch descriptions to satisfy checkpatch.pl

While working on a patch series to change how we handle the ctime, I
found a number of places that update the mtime without a corresponding
ctime update.

While it's not spelled out explicitly in the POSIX spec, all of the
operations that update the mtime must also update the ctime. I've not
been able to find any counterexamples, in any case. Some of these
patches involve operations not covered by POSIX, but it's still a good
idea to update the ctime when updating the mtime.

Note that these are largely untested other than for compilation, so
please review carefully. These are a preliminary set for the upcoming
rework of how we handle the ctime.

None of these seem to be very crucial, but it would be nice if various
maintainers could pick these up for v6.5. Please let me know if you do,
or would rather I shepherd the patch upstream.

Jeff Layton (8):
  ibmvmc: update ctime in conjunction with mtime on write
  usb: update the ctime as well when updating mtime after an ioctl
  autofs: set ctime as well when mtime changes on a dir
  bfs: update ctime in addition to mtime when adding entries
  efivarfs: update ctime when mtime changes on a write
  exfat: ensure that ctime is updated whenever the mtime is
  apparmor: update ctime whenever the mtime changes on an inode
  cifs: update the ctime on a partial page write

 drivers/misc/ibmvmc.c             |  2 +-
 drivers/usb/core/devio.c          | 16 ++++++++--------
 fs/autofs/root.c                  |  6 +++---
 fs/bfs/dir.c                      |  2 +-
 fs/efivarfs/file.c                |  2 +-
 fs/exfat/namei.c                  |  8 ++++----
 fs/smb/client/file.c              |  2 +-
 security/apparmor/apparmorfs.c    |  7 +++++--
 security/apparmor/policy_unpack.c | 11 +++++++----
 9 files changed, 31 insertions(+), 25 deletions(-)

-- 
2.40.1

