Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A084048784A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jan 2022 14:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347537AbiAGNiY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jan 2022 08:38:24 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:44098 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238886AbiAGNiX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jan 2022 08:38:23 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EA32F1F397;
        Fri,  7 Jan 2022 13:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641562702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=6gvf0L+H6Pi82qXTszDAYwKzmaKlw3vu6UPipNLCu2I=;
        b=NLurY9MQEHSyrHh6qV7gEba5MPSlO6eLieyM5Tt5eEJ3M6ZvOed6tOJXexYFopxDmimKw2
        xlozNCtpB2C09QXdXchpXKOCjuHdnZA2oYl28njxmvoGcGDPLje4s2TjJKNyWXxJUUacx9
        Dd66LTKdtJ/cvllXxJpwk3xywXSGZoM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641562702;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=6gvf0L+H6Pi82qXTszDAYwKzmaKlw3vu6UPipNLCu2I=;
        b=kcbl0wvTw4k6Ms0odo0hBrjUIFLWw0qyuxUGzufBRKbE1k0J4+0DRhrCOA8cwQpVnhJvJQ
        Q01Z5Gz6KeFKlPDQ==
Received: from echidna.suse.de (ddiss.udp.ovpn2.nue.suse.de [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C4398A3B87;
        Fri,  7 Jan 2022 13:38:22 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     Martin Wilck <mwilck@suse.com>, viro@zeniv.linux.org.uk,
        willy@infradead.org
Subject: [PATCH v6 0/6] initramfs: "crc" cpio format and INITRAMFS_PRESERVE_MTIME
Date:   Fri,  7 Jan 2022 14:38:08 +0100
Message-Id: <20220107133814.32655-1-ddiss@suse.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset does some minor initramfs refactoring and allows cpio
entry mtime preservation to be disabled via a new Kconfig
INITRAMFS_PRESERVE_MTIME option.
Patches 4/6 to 6/6 implement support for creation and extraction of
"crc" cpio archives, which carry file data checksums. Basic tests for
this functionality can be found at
Link: https://github.com/rapido-linux/rapido/pull/163

Changes since v5:
- add PATCH 2/6 initramfs: make dir_entry.name a flexible array member
- minor commit message rewording

Changes since v4, following feedback from Matthew Wilcox:
- implement cpio "crc" archive creation and extraction
- add patch to fix gen_init_cpio short read handling
- drop now-unnecessary "crc" documentation and error msg changes

Changes since v3, following feedback from Martin Wilck:
- 4/4: keep vfs_utimes() call in do_copy() path
  + drop [PATCH v3 4/5] initramfs: use do_utime() wrapper consistently
  + add do_utime_path() helper
  + clean up timespec64 initialisation
- 4/4: move all mtime preservation logic to initramfs_mtime.h and drop
  separate .c
- 4/4: improve commit message


 init/Kconfig           | 10 +++++
 init/initramfs.c       | 89 +++++++++++++++-------------------------
 init/initramfs_mtime.h | 52 ++++++++++++++++++++++++
 usr/gen_init_cpio.c    | 92 ++++++++++++++++++++++++++++++------------
 4 files changed, 161 insertions(+), 82 deletions(-)


