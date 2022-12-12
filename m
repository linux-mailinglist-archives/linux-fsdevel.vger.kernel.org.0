Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60716649762
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Dec 2022 01:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbiLLAfJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Dec 2022 19:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiLLAfI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Dec 2022 19:35:08 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7029BC84;
        Sun, 11 Dec 2022 16:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=lXQVO+HzUiEDtpmJjo1le4xFkMrZkqsuu8+0BugeNt8=; b=b4LLAdTSNX9EpSpC6s2NpfYhTj
        qxPC1iHG+psVna3hVMs59SlzHZVLGTyAEjtnpmoHSLAN3SAIGVwsYTW9brDXrS2x8lPksTfDkdVB9
        Ub/gDEube3/ckeUc045KRGl+Ps2nPxY+bw2MmhgZjMOONtU5bDpxlRBIPUuaSuQNaQcVIftdIQTRa
        AjXJySblVKanJObMp0tfCd3Jl2dwvrw1olo/ZOa5A5EjXmgfnPm4ozJdF6eTHM+Hx2iRicO68ClzG
        G0zRZakSXpVCgTPMxbvySzCDHZ1EMpkEZ0INjQESvGvXNg+wHTQR1C5QIM5N7dQwxwpPECeqmncz+
        cgbUquOA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1p4Wme-00B872-2U;
        Mon, 12 Dec 2022 00:35:04 +0000
Date:   Mon, 12 Dec 2022 00:35:04 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs.git iov_iter pile
Message-ID: <Y5Z3OMYJOMxQqXQf@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Minor conflicts with erofs branch; conflicting changes in this one
are all of form s/READ/ITER_DEST/ in iov_iter_xarray() calls.

The following changes since commit eb7081409f94a9a8608593d0fb63a1aa3d6f95d8:

  Linux 6.1-rc6 (2022-11-20 16:02:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-iov_iter

for you to fetch changes up to de4eda9de2d957ef2d6a8365a01e26a435e958cb:

  use less confusing names for iov_iter direction initializers (2022-11-25 13:01:55 -0500)

----------------------------------------------------------------
iov_iter work; most of that is about getting rid of
direction misannotations and (hopefully) preventing
more of the same for the future.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (12):
      get rid of unlikely() on page_copy_sane() calls
      csum_and_copy_to_iter(): handle ITER_DISCARD
      [s390] copy_oldmem_kernel() - WRITE is "data source", not destination
      [fsi] WRITE is "data source", not destination...
      [infiniband] READ is "data destination", not source...
      [s390] zcore: WRITE is "data source", not destination...
      [s390] memcpy_real(): WRITE is "data source", not destination...
      [target] fix iov_iter_bvec() "direction" argument
      [vhost] fix 'direction' argument of iov_iter_{init,bvec}()
      [xen] fix "direction" argument of iov_iter_kvec()
      iov_iter: saner checks for attempt to copy to/from iterator
      use less confusing names for iov_iter direction initializers

 arch/s390/kernel/crash_dump.c            |  2 +-
 arch/s390/mm/maccess.c                   |  2 +-
 arch/x86/kernel/cpu/microcode/intel.c    |  2 +-
 arch/x86/kernel/crash_dump_64.c          |  2 +-
 crypto/testmgr.c                         |  4 +--
 drivers/acpi/pfr_update.c                |  2 +-
 drivers/block/drbd/drbd_main.c           |  2 +-
 drivers/block/drbd/drbd_receiver.c       |  2 +-
 drivers/block/loop.c                     | 12 ++++----
 drivers/block/nbd.c                      | 10 +++----
 drivers/char/random.c                    |  4 +--
 drivers/fsi/fsi-sbefifo.c                |  6 ++--
 drivers/infiniband/ulp/rtrs/rtrs-clt.c   |  2 +-
 drivers/isdn/mISDN/l1oip_core.c          |  2 +-
 drivers/misc/vmw_vmci/vmci_queue_pair.c  |  6 ++--
 drivers/net/ppp/ppp_generic.c            |  2 +-
 drivers/nvme/host/tcp.c                  |  4 +--
 drivers/nvme/target/io-cmd-file.c        |  4 +--
 drivers/nvme/target/tcp.c                |  2 +-
 drivers/s390/char/zcore.c                |  2 +-
 drivers/scsi/sg.c                        |  2 +-
 drivers/target/iscsi/iscsi_target_util.c |  4 +--
 drivers/target/target_core_file.c        |  4 +--
 drivers/usb/usbip/usbip_common.c         |  2 +-
 drivers/vhost/net.c                      |  6 ++--
 drivers/vhost/scsi.c                     | 10 +++----
 drivers/vhost/vhost.c                    |  6 ++--
 drivers/vhost/vringh.c                   |  4 +--
 drivers/vhost/vsock.c                    |  4 +--
 drivers/xen/pvcalls-back.c               |  8 ++---
 fs/9p/vfs_addr.c                         |  4 +--
 fs/9p/vfs_dir.c                          |  2 +-
 fs/9p/xattr.c                            |  4 +--
 fs/afs/cmservice.c                       |  2 +-
 fs/afs/dir.c                             |  2 +-
 fs/afs/file.c                            |  4 +--
 fs/afs/internal.h                        |  4 +--
 fs/afs/rxrpc.c                           | 10 +++----
 fs/afs/write.c                           |  4 +--
 fs/aio.c                                 |  4 +--
 fs/btrfs/ioctl.c                         |  4 +--
 fs/ceph/addr.c                           |  4 +--
 fs/ceph/file.c                           |  4 +--
 fs/cifs/connect.c                        |  6 ++--
 fs/cifs/file.c                           |  4 +--
 fs/cifs/fscache.c                        |  4 +--
 fs/cifs/smb2ops.c                        |  4 +--
 fs/cifs/transport.c                      |  6 ++--
 fs/coredump.c                            |  2 +-
 fs/erofs/fscache.c                       |  6 ++--
 fs/fscache/io.c                          |  2 +-
 fs/fuse/ioctl.c                          |  4 +--
 fs/netfs/io.c                            |  6 ++--
 fs/nfs/fscache.c                         |  4 +--
 fs/nfsd/vfs.c                            |  4 +--
 fs/ocfs2/cluster/tcp.c                   |  2 +-
 fs/orangefs/inode.c                      |  8 ++---
 fs/proc/vmcore.c                         |  6 ++--
 fs/read_write.c                          | 12 ++++----
 fs/seq_file.c                            |  2 +-
 fs/splice.c                              | 10 +++----
 include/linux/uio.h                      |  3 ++
 io_uring/net.c                           | 14 ++++-----
 io_uring/rw.c                            | 10 +++----
 kernel/trace/trace_events_user.c         |  2 +-
 lib/iov_iter.c                           | 50 ++++++++++++++++++--------------
 mm/madvise.c                             |  2 +-
 mm/page_io.c                             |  4 +--
 mm/process_vm_access.c                   |  2 +-
 net/9p/client.c                          |  2 +-
 net/bluetooth/6lowpan.c                  |  2 +-
 net/bluetooth/a2mp.c                     |  2 +-
 net/bluetooth/smp.c                      |  2 +-
 net/ceph/messenger_v1.c                  |  4 +--
 net/ceph/messenger_v2.c                  | 14 ++++-----
 net/compat.c                             |  3 +-
 net/ipv4/tcp.c                           |  4 +--
 net/netfilter/ipvs/ip_vs_sync.c          |  2 +-
 net/smc/smc_clc.c                        |  6 ++--
 net/smc/smc_tx.c                         |  2 +-
 net/socket.c                             | 12 ++++----
 net/sunrpc/socklib.c                     |  6 ++--
 net/sunrpc/svcsock.c                     |  4 +--
 net/sunrpc/xprtsock.c                    |  6 ++--
 net/tipc/topsrv.c                        |  2 +-
 net/tls/tls_device.c                     |  4 +--
 net/xfrm/espintcp.c                      |  2 +-
 security/keys/keyctl.c                   |  4 +--
 88 files changed, 224 insertions(+), 214 deletions(-)
