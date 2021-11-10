Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3D144C172
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Nov 2021 13:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbhKJMmJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Nov 2021 07:42:09 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:40962 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbhKJMl5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:41:57 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8FC3321B13;
        Wed, 10 Nov 2021 12:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1636547948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=QFVquFNmjtS6Kd0kT19pCOICxw6yidmCrze14XLo0Pg=;
        b=fwcG8XGor//2IHoVBX3dcKMpsFG7rfMlf0tElubUekEATrpLyQ+E2e5CmF01ve9ZQZAi3h
        o4MRXNC82EACOkrEcSaPMDLWiJWqEZLNS+EEjdm3MIQH4ntNfvyT61x9SAuAxXF9i5grVK
        jF0MnLlSA8+ljKA5ygnwB9MpyY2RbNQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1636547948;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=QFVquFNmjtS6Kd0kT19pCOICxw6yidmCrze14XLo0Pg=;
        b=+b2cxao9uBTj3X/kLBZ5dwQyj7UmlYPJm2hVQbkcRQj5bxTCCKdz7rAUFiSnyQVyDq017V
        9/RP1KyoiVdXVjCA==
Received: from echidna.suse.de (ddiss.udp.ovpn2.nue.suse.de [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5DDD4A3B81;
        Wed, 10 Nov 2021 12:39:08 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Martin Wilck <mwilck@suse.com>, viro@zeniv.linux.org.uk,
        willy@infradead.org
Subject: [PATCH v4 0/4] initramfs: "crc" cpio format and INITRAMFS_PRESERVE_MTIME
Date:   Wed, 10 Nov 2021 13:38:46 +0100
Message-Id: <20211110123850.24956-1-ddiss@suse.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset does some minor refactoring of cpio header magic checking
and corrects documentation.
Patch 4/4 allows cpio entry mtime preservation to be disabled via a new
INITRAMFS_PRESERVE_MTIME Kconfig option.

Changes since v3, following feedback from Martin Wilck:
- 4/4: keep vfs_utimes() call in do_copy() path
  + drop [PATCH v3 4/5] initramfs: use do_utime() wrapper consistently
  + add do_utime_path() helper
  + clean up timespec64 initialisation
- 4/4: move all mtime preservation logic to initramfs_mtime.h and drop
  separate .c
- 4/4: improve commit message

 .../early-userspace/buffer-format.rst         | 24 +++-----
 init/Kconfig                                  | 10 ++++
 init/initramfs.c                              | 57 +++----------------
 init/initramfs_mtime.h                        | 50 ++++++++++++++++
 4 files changed, 75 insertions(+), 66 deletions(-)

