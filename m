Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B82588224
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Aug 2022 21:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiHBTA6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Aug 2022 15:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiHBTA4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Aug 2022 15:00:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BCA1C100;
        Tue,  2 Aug 2022 12:00:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3B8A5209A3;
        Tue,  2 Aug 2022 19:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659466853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=69KthPBg3CmMTGDfPXNe4Bzzx/67TDMmh8exFp3TKgw=;
        b=ktz5zYsU4dActqd3yl9y/Zhy4TSH2qDND2TJnXtzd5LCNdm+nwEQKi4m2JTjdo/WkACpe6
        ygLBv5sRcbCSffFWbk0JgUI8NBSlF0u0s65v4lEOQGlEsaN7rhyWcG0zNg4rbWiCApHzxu
        pRt9W9nVrL1mJuY0GIeuKKHZmeIRO7o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659466853;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=69KthPBg3CmMTGDfPXNe4Bzzx/67TDMmh8exFp3TKgw=;
        b=0RPNzg2/x213QCJrpRwnIxI0dJh0zDUuTdRH+XrpReBGqw7kLuR9hx6BbDtrQfmOW9n+VM
        NuPtgd9BJwQnT1Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B40B313A8E;
        Tue,  2 Aug 2022 19:00:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UIAhHmR06WLWXwAAMHmgww
        (envelope-from <ematsumiya@suse.de>); Tue, 02 Aug 2022 19:00:52 +0000
From:   Enzo Matsumiya <ematsumiya@suse.de>
To:     linux-cifs@vger.kernel.org
Cc:     smfrench@gmail.com, pc@cjr.nz, ronniesahlberg@gmail.com,
        nspmangalore@gmail.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tom@talpey.com,
        samba-technical@lists.samba.org, pshilovsky@samba.org,
        jlayton@kernel.org, rpenny@samba.org
Subject: [RFC PATCH v2 0/5] Rename "cifs" module to "smbfs"
Date:   Tue,  2 Aug 2022 16:00:43 -0300
Message-Id: <20220802190048.19881-1-ematsumiya@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

As part of the ongoing effort to remove the "cifs" nomenclature from the
Linux SMB client, I'm proposing the rename of the module to "smbfs".

As it's widely known, CIFS is associated to SMB1.0, which, in turn, is
associated with the security issues it presented in the past. Using
"SMBFS" makes clear what's the protocol in use for outsiders, but also
unties it from any particular protocol version. It also fits in the
already existing "fs/smbfs_common" and "fs/ksmbd" naming scheme.

This short patch series only changes directory names and includes/ifdefs in
headers and source code, and updates docs to reflect the rename. Other
than that, no source code/functionality is modified (WIP though).

Patch 1/5: effectively changes the module name to "smbfs" and create a
	   "cifs" module alias to maintain compatibility (a warning
	   should be added to indicate the complete removal/isolation of
	   CIFS/SMB1.0 code).
Patch 2/5: rename source-code directory to "fs/smb"
Patch 3/5: update documentation references to "fs/cifs" or "cifs.ko" or
	   "cifs module" to use "fs/smb" or "smbfs" where appropriate
Patch 4/5: updates the module description to something more concise
Patch 5/5: show a warning on module load indicating that the current
	   existing module aliases might be removed in the future

Reviews, feedback, suggestions all welcome.


Cheers,

Enzo Matsumiya (5):
  cifs: change module name to "smbfs.ko"
  smbfs: rename directory "fs/cifs" -> "fs/smb"
  smbfs: update doc references
  smbfs: update module description
  smbfs: show a warning about new name

 Documentation/admin-guide/index.rst           |   2 +-
 .../admin-guide/{cifs => smbfs}/authors.rst   |   0
 .../admin-guide/{cifs => smbfs}/changes.rst   |   4 +-
 .../admin-guide/{cifs => smbfs}/index.rst     |   0
 .../{cifs => smbfs}/introduction.rst          |   0
 .../admin-guide/{cifs => smbfs}/todo.rst      |   8 +-
 .../admin-guide/{cifs => smbfs}/usage.rst     | 154 +++++++++---------
 .../{cifs => smbfs}/winucase_convert.pl       |   0
 Documentation/filesystems/index.rst           |   2 +-
 .../filesystems/{cifs => smbfs}/cifsroot.rst  |  14 +-
 .../filesystems/{cifs => smbfs}/index.rst     |   0
 .../filesystems/{cifs => smbfs}/ksmbd.rst     |   2 +-
 Documentation/networking/dns_resolver.rst     |   2 +-
 .../translations/zh_CN/admin-guide/index.rst  |   2 +-
 .../translations/zh_TW/admin-guide/index.rst  |   2 +-
 fs/Kconfig                                    |   6 +-
 fs/Makefile                                   |   2 +-
 fs/cifs/Makefile                              |  34 ----
 fs/{cifs => smb}/Kconfig                      | 108 ++++++------
 fs/smb/Makefile                               |  34 ++++
 fs/{cifs => smb}/asn1.c                       |   0
 fs/{cifs => smb}/cifs_debug.c                 |  72 ++++----
 fs/{cifs => smb}/cifs_debug.h                 |   4 +-
 fs/{cifs => smb}/cifs_dfs_ref.c               |   2 +-
 fs/{cifs => smb}/cifs_fs_sb.h                 |   0
 fs/{cifs => smb}/cifs_ioctl.h                 |   0
 fs/{cifs => smb}/cifs_spnego.c                |   4 +-
 fs/{cifs => smb}/cifs_spnego.h                |   0
 .../cifs_spnego_negtokeninit.asn1             |   0
 fs/{cifs => smb}/cifs_swn.c                   |   0
 fs/{cifs => smb}/cifs_swn.h                   |   4 +-
 fs/{cifs => smb}/cifs_unicode.c               |   0
 fs/{cifs => smb}/cifs_unicode.h               |   0
 fs/{cifs => smb}/cifs_uniupr.h                |   0
 fs/{cifs => smb}/cifsacl.c                    |   6 +-
 fs/{cifs => smb}/cifsacl.h                    |   0
 fs/{cifs => smb}/cifsencrypt.c                |   0
 fs/{cifs => smb}/cifsglob.h                   |  26 +--
 fs/{cifs => smb}/cifspdu.h                    |   6 +-
 fs/{cifs => smb}/cifsproto.h                  |  10 +-
 fs/{cifs => smb}/cifsroot.c                   |   0
 fs/{cifs => smb}/cifssmb.c                    |  14 +-
 fs/{cifs => smb}/connect.c                    |  36 ++--
 fs/{cifs/cifsfs.c => smb/core.c}              |  57 ++++---
 fs/{cifs => smb}/dfs_cache.c                  |   2 +-
 fs/{cifs => smb}/dfs_cache.h                  |   0
 fs/{cifs => smb}/dir.c                        |   2 +-
 fs/{cifs => smb}/dns_resolve.c                |   0
 fs/{cifs => smb}/dns_resolve.h                |   0
 fs/{cifs => smb}/export.c                     |   8 +-
 fs/{cifs => smb}/file.c                       |  16 +-
 fs/{cifs => smb}/fs_context.c                 |  20 +--
 fs/{cifs => smb}/fs_context.h                 |   0
 fs/{cifs => smb}/fscache.c                    |   0
 fs/{cifs => smb}/fscache.h                    |   6 +-
 fs/{cifs => smb}/inode.c                      |  10 +-
 fs/{cifs => smb}/ioctl.c                      |   6 +-
 fs/{cifs => smb}/link.c                       |   2 +-
 fs/{cifs => smb}/misc.c                       |  14 +-
 fs/{cifs => smb}/netlink.c                    |   0
 fs/{cifs => smb}/netlink.h                    |   0
 fs/{cifs => smb}/netmisc.c                    |   2 +-
 fs/{cifs => smb}/nterr.c                      |   0
 fs/{cifs => smb}/nterr.h                      |   0
 fs/{cifs => smb}/ntlmssp.h                    |   2 +-
 fs/{cifs => smb}/readdir.c                    |   4 +-
 fs/{cifs => smb}/rfc1002pdu.h                 |   0
 fs/{cifs => smb}/sess.c                       |  10 +-
 fs/{cifs => smb}/smb1ops.c                    |   4 +-
 fs/{cifs => smb}/smb2file.c                   |   2 +-
 fs/{cifs => smb}/smb2glob.h                   |   0
 fs/{cifs => smb}/smb2inode.c                  |   2 +-
 fs/{cifs => smb}/smb2maperror.c               |   0
 fs/{cifs => smb}/smb2misc.c                   |   0
 fs/{cifs => smb}/smb2ops.c                    |  32 ++--
 fs/{cifs => smb}/smb2pdu.c                    |  22 +--
 fs/{cifs => smb}/smb2pdu.h                    |   0
 fs/{cifs => smb}/smb2proto.h                  |   0
 fs/{cifs => smb}/smb2status.h                 |   0
 fs/{cifs => smb}/smb2transport.c              |   2 +-
 fs/{cifs => smb}/smbdirect.c                  |   0
 fs/{cifs => smb}/smbdirect.h                  |   2 +-
 fs/{cifs => smb}/smbencrypt.c                 |   0
 fs/{cifs => smb}/smberr.h                     |   0
 fs/{cifs/cifsfs.h => smb/smbfs.h}             |  12 +-
 fs/{cifs => smb}/trace.c                      |   0
 fs/{cifs => smb}/trace.h                      |   0
 fs/{cifs => smb}/transport.c                  |   4 +-
 fs/{cifs => smb}/unc.c                        |   0
 fs/{cifs => smb}/winucase.c                   |   0
 fs/{cifs => smb}/xattr.c                      |  18 +-
 91 files changed, 410 insertions(+), 411 deletions(-)
 rename Documentation/admin-guide/{cifs => smbfs}/authors.rst (100%)
 rename Documentation/admin-guide/{cifs => smbfs}/changes.rst (74%)
 rename Documentation/admin-guide/{cifs => smbfs}/index.rst (100%)
 rename Documentation/admin-guide/{cifs => smbfs}/introduction.rst (100%)
 rename Documentation/admin-guide/{cifs => smbfs}/todo.rst (96%)
 rename Documentation/admin-guide/{cifs => smbfs}/usage.rst (88%)
 rename Documentation/admin-guide/{cifs => smbfs}/winucase_convert.pl (100%)
 rename Documentation/filesystems/{cifs => smbfs}/cifsroot.rst (86%)
 rename Documentation/filesystems/{cifs => smbfs}/index.rst (100%)
 rename Documentation/filesystems/{cifs => smbfs}/ksmbd.rst (99%)
 delete mode 100644 fs/cifs/Makefile
 rename fs/{cifs => smb}/Kconfig (72%)
 create mode 100644 fs/smb/Makefile
 rename fs/{cifs => smb}/asn1.c (100%)
 rename fs/{cifs => smb}/cifs_debug.c (96%)
 rename fs/{cifs => smb}/cifs_debug.h (98%)
 rename fs/{cifs => smb}/cifs_dfs_ref.c (99%)
 rename fs/{cifs => smb}/cifs_fs_sb.h (100%)
 rename fs/{cifs => smb}/cifs_ioctl.h (100%)
 rename fs/{cifs => smb}/cifs_spnego.c (98%)
 rename fs/{cifs => smb}/cifs_spnego.h (100%)
 rename fs/{cifs => smb}/cifs_spnego_negtokeninit.asn1 (100%)
 rename fs/{cifs => smb}/cifs_swn.c (100%)
 rename fs/{cifs => smb}/cifs_swn.h (95%)
 rename fs/{cifs => smb}/cifs_unicode.c (100%)
 rename fs/{cifs => smb}/cifs_unicode.h (100%)
 rename fs/{cifs => smb}/cifs_uniupr.h (100%)
 rename fs/{cifs => smb}/cifsacl.c (99%)
 rename fs/{cifs => smb}/cifsacl.h (100%)
 rename fs/{cifs => smb}/cifsencrypt.c (100%)
 rename fs/{cifs => smb}/cifsglob.h (99%)
 rename fs/{cifs => smb}/cifspdu.h (99%)
 rename fs/{cifs => smb}/cifsproto.h (99%)
 rename fs/{cifs => smb}/cifsroot.c (100%)
 rename fs/{cifs => smb}/cifssmb.c (99%)
 rename fs/{cifs => smb}/connect.c (99%)
 rename fs/{cifs/cifsfs.c => smb/core.c} (98%)
 rename fs/{cifs => smb}/dfs_cache.c (99%)
 rename fs/{cifs => smb}/dfs_cache.h (100%)
 rename fs/{cifs => smb}/dir.c (99%)
 rename fs/{cifs => smb}/dns_resolve.c (100%)
 rename fs/{cifs => smb}/dns_resolve.h (100%)
 rename fs/{cifs => smb}/export.c (91%)
 rename fs/{cifs => smb}/file.c (99%)
 rename fs/{cifs => smb}/fs_context.c (99%)
 rename fs/{cifs => smb}/fs_context.h (100%)
 rename fs/{cifs => smb}/fscache.c (100%)
 rename fs/{cifs => smb}/fscache.h (98%)
 rename fs/{cifs => smb}/inode.c (99%)
 rename fs/{cifs => smb}/ioctl.c (99%)
 rename fs/{cifs => smb}/link.c (99%)
 rename fs/{cifs => smb}/misc.c (99%)
 rename fs/{cifs => smb}/netlink.c (100%)
 rename fs/{cifs => smb}/netlink.h (100%)
 rename fs/{cifs => smb}/netmisc.c (99%)
 rename fs/{cifs => smb}/nterr.c (100%)
 rename fs/{cifs => smb}/nterr.h (100%)
 rename fs/{cifs => smb}/ntlmssp.h (98%)
 rename fs/{cifs => smb}/readdir.c (99%)
 rename fs/{cifs => smb}/rfc1002pdu.h (100%)
 rename fs/{cifs => smb}/sess.c (99%)
 rename fs/{cifs => smb}/smb1ops.c (99%)
 rename fs/{cifs => smb}/smb2file.c (99%)
 rename fs/{cifs => smb}/smb2glob.h (100%)
 rename fs/{cifs => smb}/smb2inode.c (99%)
 rename fs/{cifs => smb}/smb2maperror.c (100%)
 rename fs/{cifs => smb}/smb2misc.c (100%)
 rename fs/{cifs => smb}/smb2ops.c (99%)
 rename fs/{cifs => smb}/smb2pdu.c (99%)
 rename fs/{cifs => smb}/smb2pdu.h (100%)
 rename fs/{cifs => smb}/smb2proto.h (100%)
 rename fs/{cifs => smb}/smb2status.h (100%)
 rename fs/{cifs => smb}/smb2transport.c (99%)
 rename fs/{cifs => smb}/smbdirect.c (100%)
 rename fs/{cifs => smb}/smbdirect.h (99%)
 rename fs/{cifs => smb}/smbencrypt.c (100%)
 rename fs/{cifs => smb}/smberr.h (100%)
 rename fs/{cifs/cifsfs.h => smb/smbfs.h} (97%)
 rename fs/{cifs => smb}/trace.c (100%)
 rename fs/{cifs => smb}/trace.h (100%)
 rename fs/{cifs => smb}/transport.c (99%)
 rename fs/{cifs => smb}/unc.c (100%)
 rename fs/{cifs => smb}/winucase.c (100%)
 rename fs/{cifs => smb}/xattr.c (98%)

-- 
2.35.3

