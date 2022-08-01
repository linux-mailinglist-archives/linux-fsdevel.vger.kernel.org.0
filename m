Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9300A58712D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Aug 2022 21:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234923AbiHATNE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Aug 2022 15:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233913AbiHATMu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Aug 2022 15:12:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68C8E07;
        Mon,  1 Aug 2022 12:09:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 924E534F3A;
        Mon,  1 Aug 2022 19:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659380981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=6+JrXqJEltXUWg9QjhAUhtfwUJNVGIb39jMoxht6RQM=;
        b=g+/T2tb8ECWrIXttXqfIOPuOQ/irhfulZq3n7iOZUWwwRKqBuQjwAzpHXZDuI87dZ9JpL7
        MQ0NFg+feKxIrjvc5VkXOQAropkUm3kMlzJUEZ/yqksYFxadQOabZFsbVR9Kv4Eu6WTIzb
        jxAqRYSA9hybHk7OY8kDiCz/MBRYRaE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659380981;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=6+JrXqJEltXUWg9QjhAUhtfwUJNVGIb39jMoxht6RQM=;
        b=swMNRBGXCXuFqp0p3KYlFXyvgSQS8uGzTGMNcaRFHfexdMFcGZqhO6+UAHLFhOEoJsZ19s
        ie2pavcJ2UiRYiAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0DC4613AAE;
        Mon,  1 Aug 2022 19:09:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AeHtL/Qk6GJ5SgAAMHmgww
        (envelope-from <ematsumiya@suse.de>); Mon, 01 Aug 2022 19:09:40 +0000
From:   Enzo Matsumiya <ematsumiya@suse.de>
To:     linux-cifs@vger.kernel.org
Cc:     smfrench@gmail.com, pc@cjr.nz, ronniesahlberg@gmail.com,
        nspmangalore@gmail.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tom@talpey.com,
        samba-technical@lists.samba.org, pshilovsky@samba.org
Subject: [RFC PATCH 0/3] Rename "cifs" module to "smbfs"
Date:   Mon,  1 Aug 2022 16:09:30 -0300
Message-Id: <20220801190933.27197-1-ematsumiya@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Patch 1/3: effectively changes the module name to "smbfs" and create a
	   "cifs" module alias to maintain compatibility (a warning
	   should be added to indicate the complete removal/isolation of
	   CIFS/SMB1.0 code).
Patch 2/3: rename the source-code directory to align with the new module
	   name
Patch 3/3: update documentation references to "fs/cifs" or "cifs.ko" or
	   "cifs module" to use the new name

Enzo Matsumiya (3):
  cifs: change module name to "smbfs.ko"
  smbfs: rename directory "fs/cifs" -> "fs/smbfs"
  smbfs: update doc references

 Documentation/admin-guide/index.rst           |   2 +-
 .../admin-guide/{cifs => smbfs}/authors.rst   |   0
 .../admin-guide/{cifs => smbfs}/changes.rst   |   4 +-
 .../admin-guide/{cifs => smbfs}/index.rst     |   0
 .../{cifs => smbfs}/introduction.rst          |   0
 .../admin-guide/{cifs => smbfs}/todo.rst      |  12 +-
 .../admin-guide/{cifs => smbfs}/usage.rst     | 168 +++++++++---------
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
 fs/{cifs => smbfs}/Kconfig                    | 108 +++++------
 fs/smbfs/Makefile                             |  34 ++++
 fs/{cifs => smbfs}/asn1.c                     |   0
 fs/{cifs => smbfs}/cifs_debug.c               |  72 ++++----
 fs/{cifs => smbfs}/cifs_debug.h               |   4 +-
 fs/{cifs => smbfs}/cifs_dfs_ref.c             |   2 +-
 fs/{cifs => smbfs}/cifs_fs_sb.h               |   0
 fs/{cifs => smbfs}/cifs_ioctl.h               |   0
 fs/{cifs => smbfs}/cifs_spnego.c              |   4 +-
 fs/{cifs => smbfs}/cifs_spnego.h              |   0
 .../cifs_spnego_negtokeninit.asn1             |   0
 fs/{cifs => smbfs}/cifs_swn.c                 |   0
 fs/{cifs => smbfs}/cifs_swn.h                 |   4 +-
 fs/{cifs => smbfs}/cifs_unicode.c             |   0
 fs/{cifs => smbfs}/cifs_unicode.h             |   0
 fs/{cifs => smbfs}/cifs_uniupr.h              |   0
 fs/{cifs => smbfs}/cifsacl.c                  |   6 +-
 fs/{cifs => smbfs}/cifsacl.h                  |   0
 fs/{cifs => smbfs}/cifsencrypt.c              |   0
 fs/{cifs => smbfs}/cifsglob.h                 |  26 +--
 fs/{cifs => smbfs}/cifspdu.h                  |   6 +-
 fs/{cifs => smbfs}/cifsproto.h                |  10 +-
 fs/{cifs => smbfs}/cifsroot.c                 |   0
 fs/{cifs => smbfs}/cifssmb.c                  |  14 +-
 fs/{cifs => smbfs}/connect.c                  |  36 ++--
 fs/{cifs/cifsfs.c => smbfs/core.c}            |  49 ++---
 fs/{cifs => smbfs}/dfs_cache.c                |   2 +-
 fs/{cifs => smbfs}/dfs_cache.h                |   0
 fs/{cifs => smbfs}/dir.c                      |   2 +-
 fs/{cifs => smbfs}/dns_resolve.c              |   0
 fs/{cifs => smbfs}/dns_resolve.h              |   0
 fs/{cifs => smbfs}/export.c                   |   8 +-
 fs/{cifs => smbfs}/file.c                     |  16 +-
 fs/{cifs => smbfs}/fs_context.c               |  20 +--
 fs/{cifs => smbfs}/fs_context.h               |   0
 fs/{cifs => smbfs}/fscache.c                  |   0
 fs/{cifs => smbfs}/fscache.h                  |   6 +-
 fs/{cifs => smbfs}/inode.c                    |  10 +-
 fs/{cifs => smbfs}/ioctl.c                    |   6 +-
 fs/{cifs => smbfs}/link.c                     |   2 +-
 fs/{cifs => smbfs}/misc.c                     |  14 +-
 fs/{cifs => smbfs}/netlink.c                  |   0
 fs/{cifs => smbfs}/netlink.h                  |   0
 fs/{cifs => smbfs}/netmisc.c                  |   2 +-
 fs/{cifs => smbfs}/nterr.c                    |   0
 fs/{cifs => smbfs}/nterr.h                    |   0
 fs/{cifs => smbfs}/ntlmssp.h                  |   2 +-
 fs/{cifs => smbfs}/readdir.c                  |   4 +-
 fs/{cifs => smbfs}/rfc1002pdu.h               |   0
 fs/{cifs => smbfs}/sess.c                     |  10 +-
 fs/{cifs => smbfs}/smb1ops.c                  |   4 +-
 fs/{cifs => smbfs}/smb2file.c                 |   2 +-
 fs/{cifs => smbfs}/smb2glob.h                 |   0
 fs/{cifs => smbfs}/smb2inode.c                |   2 +-
 fs/{cifs => smbfs}/smb2maperror.c             |   0
 fs/{cifs => smbfs}/smb2misc.c                 |   0
 fs/{cifs => smbfs}/smb2ops.c                  |  32 ++--
 fs/{cifs => smbfs}/smb2pdu.c                  |  22 +--
 fs/{cifs => smbfs}/smb2pdu.h                  |   0
 fs/{cifs => smbfs}/smb2proto.h                |   0
 fs/{cifs => smbfs}/smb2status.h               |   0
 fs/{cifs => smbfs}/smb2transport.c            |   2 +-
 fs/{cifs => smbfs}/smbdirect.c                |   0
 fs/{cifs => smbfs}/smbdirect.h                |   2 +-
 fs/{cifs => smbfs}/smbencrypt.c               |   0
 fs/{cifs => smbfs}/smberr.h                   |   0
 fs/{cifs/cifsfs.h => smbfs/smbfs.h}           |  12 +-
 fs/{cifs => smbfs}/trace.c                    |   0
 fs/{cifs => smbfs}/trace.h                    |   0
 fs/{cifs => smbfs}/transport.c                |   4 +-
 fs/{cifs => smbfs}/unc.c                      |   0
 fs/{cifs => smbfs}/winucase.c                 |   0
 fs/{cifs => smbfs}/xattr.c                    |  18 +-
 91 files changed, 414 insertions(+), 417 deletions(-)
 rename Documentation/admin-guide/{cifs => smbfs}/authors.rst (100%)
 rename Documentation/admin-guide/{cifs => smbfs}/changes.rst (73%)
 rename Documentation/admin-guide/{cifs => smbfs}/index.rst (100%)
 rename Documentation/admin-guide/{cifs => smbfs}/introduction.rst (100%)
 rename Documentation/admin-guide/{cifs => smbfs}/todo.rst (95%)
 rename Documentation/admin-guide/{cifs => smbfs}/usage.rst (87%)
 rename Documentation/admin-guide/{cifs => smbfs}/winucase_convert.pl (100%)
 rename Documentation/filesystems/{cifs => smbfs}/cifsroot.rst (85%)
 rename Documentation/filesystems/{cifs => smbfs}/index.rst (100%)
 rename Documentation/filesystems/{cifs => smbfs}/ksmbd.rst (99%)
 delete mode 100644 fs/cifs/Makefile
 rename fs/{cifs => smbfs}/Kconfig (72%)
 create mode 100644 fs/smbfs/Makefile
 rename fs/{cifs => smbfs}/asn1.c (100%)
 rename fs/{cifs => smbfs}/cifs_debug.c (96%)
 rename fs/{cifs => smbfs}/cifs_debug.h (98%)
 rename fs/{cifs => smbfs}/cifs_dfs_ref.c (99%)
 rename fs/{cifs => smbfs}/cifs_fs_sb.h (100%)
 rename fs/{cifs => smbfs}/cifs_ioctl.h (100%)
 rename fs/{cifs => smbfs}/cifs_spnego.c (98%)
 rename fs/{cifs => smbfs}/cifs_spnego.h (100%)
 rename fs/{cifs => smbfs}/cifs_spnego_negtokeninit.asn1 (100%)
 rename fs/{cifs => smbfs}/cifs_swn.c (100%)
 rename fs/{cifs => smbfs}/cifs_swn.h (95%)
 rename fs/{cifs => smbfs}/cifs_unicode.c (100%)
 rename fs/{cifs => smbfs}/cifs_unicode.h (100%)
 rename fs/{cifs => smbfs}/cifs_uniupr.h (100%)
 rename fs/{cifs => smbfs}/cifsacl.c (99%)
 rename fs/{cifs => smbfs}/cifsacl.h (100%)
 rename fs/{cifs => smbfs}/cifsencrypt.c (100%)
 rename fs/{cifs => smbfs}/cifsglob.h (99%)
 rename fs/{cifs => smbfs}/cifspdu.h (99%)
 rename fs/{cifs => smbfs}/cifsproto.h (99%)
 rename fs/{cifs => smbfs}/cifsroot.c (100%)
 rename fs/{cifs => smbfs}/cifssmb.c (99%)
 rename fs/{cifs => smbfs}/connect.c (99%)
 rename fs/{cifs/cifsfs.c => smbfs/core.c} (98%)
 rename fs/{cifs => smbfs}/dfs_cache.c (99%)
 rename fs/{cifs => smbfs}/dfs_cache.h (100%)
 rename fs/{cifs => smbfs}/dir.c (99%)
 rename fs/{cifs => smbfs}/dns_resolve.c (100%)
 rename fs/{cifs => smbfs}/dns_resolve.h (100%)
 rename fs/{cifs => smbfs}/export.c (91%)
 rename fs/{cifs => smbfs}/file.c (99%)
 rename fs/{cifs => smbfs}/fs_context.c (99%)
 rename fs/{cifs => smbfs}/fs_context.h (100%)
 rename fs/{cifs => smbfs}/fscache.c (100%)
 rename fs/{cifs => smbfs}/fscache.h (98%)
 rename fs/{cifs => smbfs}/inode.c (99%)
 rename fs/{cifs => smbfs}/ioctl.c (99%)
 rename fs/{cifs => smbfs}/link.c (99%)
 rename fs/{cifs => smbfs}/misc.c (99%)
 rename fs/{cifs => smbfs}/netlink.c (100%)
 rename fs/{cifs => smbfs}/netlink.h (100%)
 rename fs/{cifs => smbfs}/netmisc.c (99%)
 rename fs/{cifs => smbfs}/nterr.c (100%)
 rename fs/{cifs => smbfs}/nterr.h (100%)
 rename fs/{cifs => smbfs}/ntlmssp.h (98%)
 rename fs/{cifs => smbfs}/readdir.c (99%)
 rename fs/{cifs => smbfs}/rfc1002pdu.h (100%)
 rename fs/{cifs => smbfs}/sess.c (99%)
 rename fs/{cifs => smbfs}/smb1ops.c (99%)
 rename fs/{cifs => smbfs}/smb2file.c (99%)
 rename fs/{cifs => smbfs}/smb2glob.h (100%)
 rename fs/{cifs => smbfs}/smb2inode.c (99%)
 rename fs/{cifs => smbfs}/smb2maperror.c (100%)
 rename fs/{cifs => smbfs}/smb2misc.c (100%)
 rename fs/{cifs => smbfs}/smb2ops.c (99%)
 rename fs/{cifs => smbfs}/smb2pdu.c (99%)
 rename fs/{cifs => smbfs}/smb2pdu.h (100%)
 rename fs/{cifs => smbfs}/smb2proto.h (100%)
 rename fs/{cifs => smbfs}/smb2status.h (100%)
 rename fs/{cifs => smbfs}/smb2transport.c (99%)
 rename fs/{cifs => smbfs}/smbdirect.c (100%)
 rename fs/{cifs => smbfs}/smbdirect.h (99%)
 rename fs/{cifs => smbfs}/smbencrypt.c (100%)
 rename fs/{cifs => smbfs}/smberr.h (100%)
 rename fs/{cifs/cifsfs.h => smbfs/smbfs.h} (97%)
 rename fs/{cifs => smbfs}/trace.c (100%)
 rename fs/{cifs => smbfs}/trace.h (100%)
 rename fs/{cifs => smbfs}/transport.c (99%)
 rename fs/{cifs => smbfs}/unc.c (100%)
 rename fs/{cifs => smbfs}/winucase.c (100%)
 rename fs/{cifs => smbfs}/xattr.c (98%)

-- 
2.35.3

