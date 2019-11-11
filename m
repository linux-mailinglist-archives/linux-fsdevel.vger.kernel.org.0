Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1A31F8121
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2019 21:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfKKUV7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 15:21:59 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:40225 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbfKKUV7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 15:21:59 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M8yoa-1iaKeu0fEE-0063PN; Mon, 11 Nov 2019 21:16:46 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-nfs@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     y2038@lists.linaro.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 00/19] nfs, nfsd: avoid 32-bit time_t
Date:   Mon, 11 Nov 2019 21:16:20 +0100
Message-Id: <20191111201639.2240623-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:JN3hpuFv/t2CfnZyt61MtRx0CiB1Qt5nIaW4ZS3du16NUH8dMu4
 YzUQ3f6jQFhZwc/rSf6LciJS668cjuruv6UXtXMppewy+Zn4V39yi0GN92e2VmGblaGAITV
 h0mJEZAO+IcXFKtZhdOWZZp/YUmpSC+HzcKZD6qECC93LLDUy5px+4sV3po6zUxaBuu9Bgm
 yi4t9xYBfPDqzvmY2Uffw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:29bmaPZVYZ4=:3/cSUbtTGBhkrYm1WF+G8n
 DZXhZSzdsRFBvSxzdPySopCDmZLeptnfFbV6F05/lmVN/2nSHbhskeq4HPAONDCZpyx1ucvIw
 q67hshswo1euuPXMNk8a/lD1eBY2EEF5zA1eOvDjl7f89wyC59kem23VtX4w5JWK2YZAO4p7L
 wRxKikw01WJKLcOCPeoRG/RqQF3QEXggeJ2XYhku8rDWm3nUDDNWkaZABw0tlyGWm2NLfrTFs
 v4fAA0CAur7ySQZBbIL/Se4loN1bDsfNvVDINrA/HG94xyJgVcYMckaXqKf7nn/NHqAmtRlYQ
 OuMzjTpEE7GAYCN6FjbyMadO/emufUYeSfD+KSc+ByGJrPDkQC2qjkPYkb7yAedbHceacBlv8
 OEZ/kNI7EYh0MQJhBFELdkiFAjAuudk5HAXOphYeSVzXYyDbhBpha3k+PhpD3PnDuLnymMOhs
 atpU6dvJGJAX8/McGWerLBEU651uZOa565q3tha6iygqnxBk3GSj7ZOuTFLbAVNc/TD6qVIjN
 ++/duQKPiatSbhBpLTqhlA4B8RMjHBUzZSFsAm+henl5rfhWaDckPBDnLi7q31KsC+BwoSEch
 QsnkszmQ8zEHxb6OOu6I3ANhEOLLVQjhMIySxVUg9cLFRLj1vylKHN4kVOGC9FtH380YpcdpS
 JDEkGdIoeMhNwJxAUI7j8tDO7ZH2YC20ETjvUCkEPGBbVAW7Cya4+RnWay5/vEVwOv0F6Mz6p
 ZQZSPfn95sds/UtHAEtaPdLsCDG4xipBm1aLNLd0iasSvW6pG2JTXWvjG0BBKy+vk6CCd+YhV
 e/wXOp3iLyuNA82bcuYvzmsoDXVCn5/ZkyMk2EuMgDRw82JKKCt2XPr8I3WvAPHLP2LgNw7Lh
 ZEzP5nFG3rhJEMOXHpqA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I have finally found the time to convert all of NFS away from
using time_t derived data structures to (mostly) time64_t,
unifying the behavior between 32-bit and 64-bit architectures
and paving the way to removing the old time_t definition from
the kernel.

Please review and test. This may be a little late for linux-5.5,
but I hope to get it all into linux-5.6 once all review comments
are addressed.

     Arnd

Arnd Bergmann (19):
  sunrpc: convert to time64_t for expiry
  nfs: use time64_t internally
  nfs: use timespec64 in nfs_fattr
  nfs: callback: use timespec64 in cb_getattrres
  nfs: fscache: use timespec64 in inode auxdata
  nfs: remove timespec from xdr_encode_nfstime
  nfs: encode nfsv4 timestamps as 64-bit
  nfsd: use ktime_get_seconds() for timestamps
  nfsd: print 64-bit timestamps in client_info_show
  nfsd: handle nfs3 timestamps as unsigned
  nfsd: use timespec64 in encode_time_delta
  nfsd: make 'boot_time' 64-bit wide
  nfsd: pass a 64-bit guardtime to nfsd_setattr()
  nfsd: use time64_t in nfsd_proc_setattr() check
  nfsd: fix delay timer on 32-bit architectures
  nfsd: fix jiffies/time_t mixup in LRU list
  nfsd: use boottime for lease expiry alculation
  nfsd: use ktime_get_real_seconds() in nfs4_verifier
  nfsd: remove nfs4_reset_lease() declarations

 fs/nfs/callback.h                     |  4 +-
 fs/nfs/callback_proc.c                |  4 +-
 fs/nfs/callback_xdr.c                 |  6 +--
 fs/nfs/fscache-index.c                |  6 ++-
 fs/nfs/fscache.c                      | 18 ++++---
 fs/nfs/fscache.h                      |  8 ++--
 fs/nfs/inode.c                        | 54 ++++++++++-----------
 fs/nfs/internal.h                     |  6 +--
 fs/nfs/nfs2xdr.c                      | 33 ++++++-------
 fs/nfs/nfs3xdr.c                      | 14 ++----
 fs/nfs/nfs4xdr.c                      | 35 +++++++-------
 fs/nfsd/netns.h                       |  6 +--
 fs/nfsd/nfs3xdr.c                     | 20 ++++----
 fs/nfsd/nfs4callback.c                |  7 ++-
 fs/nfsd/nfs4layouts.c                 |  2 +-
 fs/nfsd/nfs4proc.c                    |  2 +-
 fs/nfsd/nfs4recover.c                 |  8 ++--
 fs/nfsd/nfs4state.c                   | 68 +++++++++++++--------------
 fs/nfsd/nfs4xdr.c                     |  4 +-
 fs/nfsd/nfsctl.c                      |  6 +--
 fs/nfsd/nfsd.h                        |  2 -
 fs/nfsd/nfsfh.h                       |  4 +-
 fs/nfsd/nfsproc.c                     |  6 +--
 fs/nfsd/state.h                       | 10 ++--
 fs/nfsd/vfs.c                         |  4 +-
 fs/nfsd/vfs.h                         |  2 +-
 fs/nfsd/xdr3.h                        |  2 +-
 include/linux/nfs_fs_sb.h             |  2 +-
 include/linux/nfs_xdr.h               | 14 +++---
 include/linux/sunrpc/cache.h          | 42 +++++++++--------
 include/linux/sunrpc/gss_api.h        |  4 +-
 include/linux/sunrpc/gss_krb5.h       |  2 +-
 net/sunrpc/auth_gss/gss_krb5_mech.c   | 12 +++--
 net/sunrpc/auth_gss/gss_krb5_seal.c   |  8 ++--
 net/sunrpc/auth_gss/gss_krb5_unseal.c |  6 +--
 net/sunrpc/auth_gss/gss_krb5_wrap.c   | 16 +++----
 net/sunrpc/auth_gss/gss_mech_switch.c |  2 +-
 net/sunrpc/auth_gss/svcauth_gss.c     |  6 +--
 net/sunrpc/cache.c                    | 18 +++----
 net/sunrpc/svcauth_unix.c             | 10 ++--
 40 files changed, 243 insertions(+), 240 deletions(-)

-- 
2.20.0

