Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E741F4F121D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Apr 2022 11:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354239AbiDDJhd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Apr 2022 05:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343889AbiDDJhd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Apr 2022 05:37:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D721275D4
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 Apr 2022 02:35:37 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5E3D11F380;
        Mon,  4 Apr 2022 09:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649064936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=DUqCKIVyvXzig95a3m4ghbuUxYxsnEX2rSsDSToLg2M=;
        b=oqNrgFe+DNqDR4sgChaM1MOM7b/7bZj1GKGJ8nQg8vGHgxr2eWu0UTxZRWhPvYiRXlWw5A
        kO4DONiRWVjKb4A+WXUm5LYhar0GIYg4mFEezeJwZsl1v2wQ+CidxtCAdQl0NqWwRw1UbI
        0Wq46xSS+EQbmuCI3PA5YwWlxmrCbK4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649064936;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=DUqCKIVyvXzig95a3m4ghbuUxYxsnEX2rSsDSToLg2M=;
        b=QLiVAGM/gqZ+Cw+powWywVM9NSgpPH9pDgdXPTP/PixdD+2LQWkVY8hAoyyt8OPKqO3pZ+
        0UF+JoFRbmuJ9dBA==
Received: from echidna.suse.de (unknown [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3936AA3B82;
        Mon,  4 Apr 2022 09:35:36 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     viro@zeniv.linux.org.uk, willy@infradead.org
Subject: [PATCH v7 0/6] initramfs: "crc" cpio format and INITRAMFS_PRESERVE_MTIME
Date:   Mon,  4 Apr 2022 11:34:24 +0200
Message-Id: <20220404093429.27570-1-ddiss@suse.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

Changes since v6 following feedback from Andrew Morton:
- 3/6: improve commit message and don't split out initramfs_mtime.h
- add extra acks and sob tags for 1/6, 2/6 and 4/6

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


 init/Kconfig        | 10 +++++
 init/initramfs.c    | 76 ++++++++++++++++++++++++-------------
 usr/gen_init_cpio.c | 92 +++++++++++++++++++++++++++++++++------------
 3 files changed, 127 insertions(+), 51 deletions(-)
