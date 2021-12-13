Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9300847386C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Dec 2021 00:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241523AbhLMX1l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Dec 2021 18:27:41 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:46192 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237209AbhLMX1l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Dec 2021 18:27:41 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0360E1F3C3;
        Mon, 13 Dec 2021 23:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639438060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=yXGAIJDcBrpLlQZmZ+vpSnO35IvDxYZesIrbPNh3cSA=;
        b=TUZVCJiw2ClRDPFwFJMkfGQ5wnRnwvFFuIk4LUbO7M89fa3AQLC3Odf7knAEV59oLZMVpG
        tFEU8kh2pV4EtnQVA//AlaR39zfwtYYp+iU+vR3Q6mgk9ZOapyaGXL4/mHvH+wJjhGHdVE
        6mKbt/R7SiYwl8B9htM1Xh3mN/fRsMU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639438060;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=yXGAIJDcBrpLlQZmZ+vpSnO35IvDxYZesIrbPNh3cSA=;
        b=Okj/6qyH3s2XlqcBGxTqESjMmiQ1o2EMu7EGxS7b+hdZrKne6krlXBn7ezP28U8ZeALg2K
        PEdThKzN5WvSYiAQ==
Received: from echidna.suse.de (unknown [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D1E86A3B83;
        Mon, 13 Dec 2021 23:27:39 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     Martin Wilck <mwilck@suse.com>, viro@zeniv.linux.org.uk,
        willy@infradead.org
Subject: initramfs: "crc" cpio format and INITRAMFS_PRESERVE_MTIME
Date:   Tue, 14 Dec 2021 00:20:03 +0100
Message-Id: <20211213232007.26851-1-ddiss@suse.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset does some minor initramfs refactoring and allows cpio
entry mtime preservation to be disabled via a new Kconfig
INITRAMFS_PRESERVE_MTIME option.
Patches 3/5 to 5/5 implement support for creation and extraction of
"crc" cpio archives, which carry file data checksums. Basic tests for
this functionality can be found at
Link: https://github.com/rapido-linux/rapido/pull/163

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
 init/initramfs_mtime.h | 50 +++++++++++++++++++++++
 usr/gen_init_cpio.c    | 92 ++++++++++++++++++++++++++++++------------
 4 files changed, 159 insertions(+), 82 deletions(-)

