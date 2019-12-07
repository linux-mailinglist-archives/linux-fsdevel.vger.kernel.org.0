Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D297115DBC
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Dec 2019 18:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfLGRSd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Dec 2019 12:18:33 -0500
Received: from fieldses.org ([173.255.197.46]:55114 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbfLGRSc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Dec 2019 12:18:32 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id 0A7DC1C95; Sat,  7 Dec 2019 12:18:32 -0500 (EST)
Date:   Sat, 7 Dec 2019 12:18:32 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [GIT PULL] nfsd change for 5.5
Message-ID: <20191207171832.GB24017@fieldses.org>
References: <20191207171402.GA24017@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191207171402.GA24017@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 07, 2019 at 12:14:02PM -0500, bfields wrote:
> Please pull
> 
>   git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.5
> 
> for nfsd changes for 5.5.
> 
> This is a relatively quiet cycle for nfsd, mainly various bugfixes.
> 
> Possibly most interesting is Trond's fixes for some callback races that
> were due to my incomplete understanding of rpc client shutdown.
> Unfortunately at the last minute I've started noticing a new
> intermittent failure to send callbacks.  As the logic seems basically
> correct, I'm leaving Trond's patches in for now, and hope to find a fix
> in the next week so I don't have to revert those patches.

Oh, also, not included: server-to-server copy offload.  I think it's
more or less ready, but due to some miscommunication (at least partly my
fault), I didn't get them in my nfsd-next branch till this week.  And
the client side (which it builds on) isn't merged yet last I checked.
So, it seemed more prudent to back them out and wait till next time.

--b.

> 
> --b.
> 
> Al Viro (1):
>       race in exportfs_decode_fh()
> 
> Andy Shevchenko (1):
>       nfsd: remove private bin2hex implementation
> 
> Christoph Hellwig (2):
>       sunrpc: remove __KERNEL__ ifdefs
>       lockd: remove __KERNEL__ ifdefs
> 
> Chuck Lever (4):
>       svcrdma: Improve DMA mapping trace points
>       SUNRPC: Trace gssproxy upcall results
>       SUNRPC: Fix svcauth_gss_proxy_init()
>       SUNRPC: Fix backchannel latency metrics
> 
> J. Bruce Fields (4):
>       nfsd: "\%s" should be "%s"
>       nfsd: mark cb path down on unknown errors
>       nfsd: document callback_wq serialization of callback code
>       nfsd: restore NFSv3 ACL support
> 
> Mao Wenan (1):
>       nfsd: Drop LIST_HEAD where the variable it declares is never used.
> 
> NeilBrown (1):
>       nfsd: check for EBUSY from vfs_rmdir/vfs_unink.
> 
> Olga Kornievskaia (1):
>       NFSD fixing possible null pointer derefering in copy offload
> 
> Patrick Steinhardt (1):
>       nfsd: depend on CRYPTO_MD5 for legacy client tracking
> 
> Pavel Tikhomirov (1):
>       sunrpc: fix crash when cache_head become valid before update
> 
> Scott Mayhew (3):
>       nfsd4: fix up replay_matches_cache()
>       nfsd: Fix cld_net->cn_tfm initialization
>       nfsd: v4 support requires CRYPTO_SHA256
> 
> Trond Myklebust (3):
>       nfsd: minor 4.1 callback cleanup
>       nfsd: Fix races between nfsd4_cb_release() and nfsd4_shutdown_callback()
>       nfsd: Ensure CLONE persists data and metadata changes to the target file
> 
> YueHaibing (1):
>       nfsd: remove set but not used variable 'len'
> 
>  fs/exportfs/expfs.c                        |  31 +++++----
>  fs/nfsd/Kconfig                            |   3 +-
>  fs/nfsd/filecache.c                        |   2 -
>  fs/nfsd/nfs4callback.c                     | 104 +++++++++++++++++++++++------
>  fs/nfsd/nfs4proc.c                         |   6 +-
>  fs/nfsd/nfs4recover.c                      |  23 +++----
>  fs/nfsd/nfs4state.c                        |  19 ++++--
>  fs/nfsd/nfs4xdr.c                          |   2 -
>  fs/nfsd/nfsd.h                             |   3 +-
>  fs/nfsd/nfssvc.c                           |   3 +-
>  fs/nfsd/state.h                            |   1 +
>  fs/nfsd/vfs.c                              |  20 +++++-
>  fs/nfsd/vfs.h                              |   2 +-
>  include/linux/lockd/debug.h                |   4 --
>  include/linux/lockd/lockd.h                |   4 --
>  include/linux/sunrpc/auth.h                |   3 -
>  include/linux/sunrpc/auth_gss.h            |   2 -
>  include/linux/sunrpc/clnt.h                |   3 -
>  include/linux/sunrpc/gss_api.h             |   2 -
>  include/linux/sunrpc/gss_err.h             |   3 -
>  include/linux/sunrpc/msg_prot.h            |   3 -
>  include/linux/sunrpc/rpc_pipe_fs.h         |   3 -
>  include/linux/sunrpc/svcauth.h             |   4 --
>  include/linux/sunrpc/svcauth_gss.h         |   2 -
>  include/linux/sunrpc/xdr.h                 |   3 -
>  include/linux/sunrpc/xprt.h                |   4 --
>  include/linux/sunrpc/xprtsock.h            |   4 --
>  include/trace/events/rpcgss.h              |  45 +++++++++++++
>  include/trace/events/rpcrdma.h             |  30 +++++++--
>  include/trace/events/sunrpc.h              |  55 +++++++++++++++
>  net/sunrpc/auth_gss/gss_mech_switch.c      |   4 +-
>  net/sunrpc/auth_gss/svcauth_gss.c          |  92 ++++++++++++++++++-------
>  net/sunrpc/cache.c                         |   6 --
>  net/sunrpc/svc.c                           |   2 +
>  net/sunrpc/svcauth.c                       |   2 +
>  net/sunrpc/xprtrdma/svc_rdma_backchannel.c |   1 +
>  net/sunrpc/xprtrdma/svc_rdma_sendto.c      |   8 ++-
>  net/sunrpc/xprtsock.c                      |   3 +-
>  38 files changed, 362 insertions(+), 149 deletions(-)
