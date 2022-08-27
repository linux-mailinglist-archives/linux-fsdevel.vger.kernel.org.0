Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132E15A3316
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Aug 2022 02:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344989AbiH0A20 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Aug 2022 20:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiH0A2Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Aug 2022 20:28:25 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB271E9AA4
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Aug 2022 17:28:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 459F2224BB;
        Sat, 27 Aug 2022 00:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661560100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=9ST8LofRZYc1z+00Wxb2byBNzMQnqeGppp7Jwc2HHlg=;
        b=WdJlQzHt862MQ8WvJ/NAIrPi3WNmFJjmOng/DJWSJhd3JGmz9ExyIAoA390uhq0KKWTgJu
        zJmXiRgOGh1MXqFh2kjAyT/OPbRmAVRiuU7bJKW+WtB/1rixXX9qxtDyLX4FpRuW0TFTGS
        czXjPjwTYiNzKhaDCjkcbgfg8inKdxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661560100;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=9ST8LofRZYc1z+00Wxb2byBNzMQnqeGppp7Jwc2HHlg=;
        b=ECDvLpx0ooIMsFFzvuPKJW5XTdEgDFOL1/6yvLsxw8OEJ4OCQYjeDkr7qqDFyf73Erm3ua
        e6uNMuMc4socJGBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DBD0A133A6;
        Sat, 27 Aug 2022 00:28:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id W8KOMyNlCWNQCgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Sat, 27 Aug 2022 00:28:19 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>, Cyril Hrubis <chrubis@suse.cz>,
        Li Wang <liwang@redhat.com>, Martin Doucha <mdoucha@suse.cz>,
        Richard Palethorpe <rpalethorpe@suse.com>,
        Joerg Vehlow <joerg.vehlow@aox-tech.de>,
        automated-testing@lists.yoctoproject.org,
        Tim Bird <tim.bird@sony.com>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/6] Track minimal size per filesystem
Date:   Sat, 27 Aug 2022 02:28:09 +0200
Message-Id: <20220827002815.19116-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

This patchset require to be on the top of:

[RFC,1/1] API: Allow to use xfs filesystems < 300 MB
https://lore.kernel.org/ltp/20220817204015.31420-1-pvorel@suse.cz/
https://patchwork.ozlabs.org/project/ltp/patch/20220817204015.31420-1-pvorel@suse.cz/

It replaces previous effort to just increase loop device size to 300 MB
https://lore.kernel.org/ltp/20220818100945.7935-1-pvorel@suse.cz/
https://patchwork.ozlabs.org/project/ltp/list/?series=314303&state=*

This patchset tracks minimal filesystem requirements as we agreed.
It fixes both C and shell API.

** Please test the patchset in your setup. **

I tried to find all tests with problems, but likely I missed some.

I have no idea why sendfile09 fails:

tst_test.c:1540: TINFO: Timeout per run is 0h 00m 30s
sendfile09.c:88: TPASS: sendfile() with offset at 0
Test timeouted, sending SIGKILL!
tst_test.c:1590: TINFO: If you are running on slow machine, try
exporting LTP_TIMEOUT_MUL > 1
tst_test.c:1591: TBROK: Test killed! (timeout?)

Summary:
passed   1
failed   0
broken   1
skipped  0
warnings 0

df01.sh and mkfs01.sh (except -f exfat) are shell tests which use loop
device. mkfs01.sh -t exfat fails (not yet in the runtest file).

If applied, "v3 shell: nfs: $TST_ALL_FILESYSTEMS (.all_filesystems)"
patchset will need to be rebased (not a problem, I'd just like to get
both into LTP release in September)
https://patchwork.ozlabs.org/project/ltp/list/?series=312567&state=*
https://lore.kernel.org/ltp/20220804121946.19564-1-pvorel@suse.cz/

Kind regards,
Petr

Petr Vorel (6):
  tst_fs_type: Add nsfs, vfat, squashfs to tst_fs_type_name()
  API: tst_device: Track minimal size per filesystem
  tst_test: Use 16 MB also for tmpfs
  tst_device: Use getopts
  tst_device: Add support -f filesystem
  tst_test.sh: Pass used filesystem to tst_device

 include/old/old_device.h                      |  6 +-
 include/tst_fs.h                              | 21 ++++-
 lib/tst_device.c                              | 36 +++++++--
 lib/tst_fs_type.c                             | 34 ++++++++
 lib/tst_test.c                                |  9 ++-
 testcases/kernel/fs/squashfs/squashfs01.c     |  1 +
 .../kernel/syscalls/fanotify/fanotify05.c     |  1 +
 testcases/kernel/syscalls/preadv2/preadv203.c |  1 +
 .../kernel/syscalls/readahead/readahead02.c   |  1 +
 testcases/lib/tst_device.c                    | 81 ++++++++++++-------
 testcases/lib/tst_test.sh                     |  4 +-
 testcases/misc/lvm/cleanup_lvm.sh             |  2 +-
 testcases/misc/lvm/prepare_lvm.sh             |  8 +-
 13 files changed, 157 insertions(+), 48 deletions(-)

-- 
2.37.2

