Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5437F1CC53B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 May 2020 01:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbgEIXlp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 May 2020 19:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728817AbgEIXl3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 May 2020 19:41:29 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2F3C061A0C;
        Sat,  9 May 2020 16:41:29 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jXZ5w-004iAv-Sd; Sat, 09 May 2020 23:41:24 +0000
Date:   Sun, 10 May 2020 00:41:24 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCHES] uaccess simple access_ok() removals
Message-ID: <20200509234124.GM23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	One of the uaccess-related branches; this one is just the
cases when access_ok() calls are trivially pointless - the address
in question gets fed only to primitives that do access_ok() checks
themselves.  This stuff sits in
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #uaccess.access_ok
and it's on top of #fixes (which is already merged into mainline on
Apr 28).
	Individual patches in followups; if nobody screams - into #for-next
it goes...

	There are other uaccess-related branches; I'll be posting them
for review over the next few days.  My apologies if this one comes with
a buggered Cc - this is the first time I have to deal with a series with
Cc lists varying that much; I hope I manage to get git-send-email do
the right thing, but...

Shortlog:
Al Viro (20):
      dlmfs_file_write(): get rid of pointless access_ok()
      fat_dir_ioctl(): hadn't needed that access_ok() for more than a decade...
      btrfs_ioctl_send(): don't bother with access_ok()
      FIEMAP: don't bother with access_ok()
      tomoyo_write_control(): get rid of pointless access_ok()
      n_hdlc_tty_read(): remove pointless access_ok()
      nvram: drop useless access_ok()
      cm4000_cs.c cmm_ioctl(): get rid of pointless access_ok()
      drivers/fpga/dfl-fme-pr.c: get rid of pointless access_ok()
      drivers/fpga/dfl-afu-dma-region.c: get rid of pointless access_ok()
      amifb: get rid of pointless access_ok() calls
      omapfb: get rid of pointless access_ok() calls
      drivers/crypto/ccp/sev-dev.c: get rid of pointless access_ok()
      via-pmu: don't bother with access_ok()
      drm_read(): get rid of pointless access_ok()
      efi_test: get rid of pointless access_ok()
      lpfc_debugfs: get rid of pointless access_ok()
      usb: get rid of pointless access_ok() calls
      hfi1: get rid of pointless access_ok()
      vmci_host: get rid of pointless access_ok()
Diffstat:
 drivers/char/nvram.c                            |  4 ----
 drivers/char/pcmcia/cm4000_cs.c                 | 14 --------------
 drivers/crypto/ccp/sev-dev.c                    | 15 +++------------
 drivers/firmware/efi/test/efi_test.c            | 12 ------------
 drivers/fpga/dfl-afu-dma-region.c               |  4 ----
 drivers/fpga/dfl-fme-pr.c                       |  4 ----
 drivers/gpu/drm/drm_file.c                      |  3 ---
 drivers/infiniband/hw/hfi1/user_exp_rcv.c       |  7 -------
 drivers/macintosh/via-pmu.c                     |  2 --
 drivers/misc/vmw_vmci/vmci_host.c               |  2 --
 drivers/scsi/lpfc/lpfc_debugfs.c                | 12 ------------
 drivers/tty/n_hdlc.c                            |  7 -------
 drivers/usb/core/devices.c                      |  2 --
 drivers/usb/core/devio.c                        |  9 ---------
 drivers/usb/gadget/function/f_hid.c             |  6 ------
 drivers/video/fbdev/amifb.c                     |  4 ----
 drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c |  3 ---
 fs/btrfs/send.c                                 |  7 -------
 fs/ext4/ioctl.c                                 |  5 -----
 fs/fat/dir.c                                    |  4 ----
 fs/ioctl.c                                      |  5 -----
 fs/ocfs2/dlmfs/dlmfs.c                          |  3 ---
 security/tomoyo/common.c                        |  2 --
 23 files changed, 3 insertions(+), 133 deletions(-)

