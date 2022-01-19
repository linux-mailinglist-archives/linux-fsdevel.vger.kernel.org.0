Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E57E493496
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jan 2022 06:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351587AbiASFoW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jan 2022 00:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346424AbiASFoV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jan 2022 00:44:21 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A41C061574;
        Tue, 18 Jan 2022 21:44:20 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id b14so4823826lff.3;
        Tue, 18 Jan 2022 21:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fKT5IUp9NrA5wa9jlFvo3eYiNctyyeAtPY6VH4amkiY=;
        b=Nhj0jasom08MpknA6guQclVWTX+3foQGnbz0yz/UawSn2I7/ThAVu8gtAz7njtT5xq
         FBmsJGEYNZU/Sxb4Mf1OPHOlEtPspDAVGLaIxapTioPh1HNiYoIRAxK5uEcBia3rn9aS
         zRQs5QhaaTRwIe5G5DNO0Bol8nVojr2KyTLoIY5qytgpDxYImU7+84KH4Ve8pc2BWuCb
         /SA/t7S7M4kZ/QVGESpuuXLiGCWubW76Hgniv5fQieF1HdnxUdCTVF1tgPWe00jJzLMd
         9SNv7MF242aGvpmPwte6XUyPYpNE5+NwZu8i5dWfONiNGB+EOvghzEXFfpur3aRmcX4h
         rU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fKT5IUp9NrA5wa9jlFvo3eYiNctyyeAtPY6VH4amkiY=;
        b=TvzQzwMU8jkIY0+v/iu7+JB1Bnv2BbyTrrvcyu8MhQtdjtEF48/u0ZdzyjoBivUYG3
         ngcUHT9PKiMi8khlVvpCnqT5y/MRZe/oLRJXrOokjBVJw0UeA/vC/9yfxImxMd78dI/S
         nSdHb6U8elGRsDbg9PJ/ZnmoGe9Q+d2Hrlsj3GziHvsUpOyHLUkibKjHIK3Nhmdtrqh9
         N6LDxAz8YIeXMkU5sNEFBaH0kaTONElVMCTPEUJ03RkMcLzUHDsXspVMf+rtghDQC+/H
         QJw8ukq7Z5m8lOM8+gg6hq2V13oakYzqudXqlEapFfMpx2wXF2H+isMQjkhik1zQRoTM
         Faow==
X-Gm-Message-State: AOAM533LrRwj62O18hCOh9obaBHSggfjxbXS2+x+NOOCjlsaLxsZIJwk
        bMlB6kHBLA20gCopqSfTSooSwzDUVCI8EmQUymc=
X-Google-Smtp-Source: ABdhPJz/etfFju9g10/VkH4rkxWexgKf1nw+Q9SzigKBoOQrWRfpoOrvmgafik/AZoW0ZRq8WJlHWiSwTyKXk4fm2z0=
X-Received: by 2002:a2e:b894:: with SMTP id r20mr7912307ljp.314.1642571058098;
 Tue, 18 Jan 2022 21:44:18 -0800 (PST)
MIME-Version: 1.0
References: <164251396932.3435901.344517748027321142.stgit@warthog.procyon.org.uk>
 <164251411336.3435901.17077059669994001060.stgit@warthog.procyon.org.uk>
In-Reply-To: <164251411336.3435901.17077059669994001060.stgit@warthog.procyon.org.uk>
From:   Steve French <smfrench@gmail.com>
Date:   Tue, 18 Jan 2022 23:44:06 -0600
Message-ID: <CAH2r5mvKcoS0EiKM_KDmerRUK83c7w3gR8=NWhNtD4tSPAHsQg@mail.gmail.com>
Subject: Re: [PATCH 11/11] cifs: Support fscache indexing rewrite
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, Jeff Layton <jlayton@kernel.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org,
        linux-nfs <linux-nfs@vger.kernel.org>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000006fd60f05d5e8e043"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--0000000000006fd60f05d5e8e043
Content-Type: text/plain; charset="UTF-8"

smb3-Am running some tests on this now (various cifs.ko xfstest
regression tests)
Lightly updated to remove checkpatch warnings (see attached)

On Tue, Jan 18, 2022 at 7:55 AM David Howells <dhowells@redhat.com> wrote:
>
> Change the cifs filesystem to take account of the changes to fscache's
> indexing rewrite and reenable caching in cifs.
>
> The following changes have been made:
>
>  (1) The fscache_netfs struct is no more, and there's no need to register
>      the filesystem as a whole.
>
>  (2) The session cookie is now an fscache_volume cookie, allocated with
>      fscache_acquire_volume().  That takes three parameters: a string
>      representing the "volume" in the index, a string naming the cache to
>      use (or NULL) and a u64 that conveys coherency metadata for the
>      volume.
>
>      For cifs, I've made it render the volume name string as:
>
>         "cifs,<ipaddress>,<sharename>"
>
>      where the sharename has '/' characters replaced with ';'.
>
>      This probably needs rethinking a bit as the total name could exceed
>      the maximum filename component length.
>
>      Further, the coherency data is currently just set to 0.  It needs
>      something else doing with it - I wonder if it would suffice simply to
>      sum the resource_id, vol_create_time and vol_serial_number or maybe
>      hash them.
>
>  (3) The fscache_cookie_def is no more and needed information is passed
>      directly to fscache_acquire_cookie().  The cache no longer calls back
>      into the filesystem, but rather metadata changes are indicated at
>      other times.
>
>      fscache_acquire_cookie() is passed the same keying and coherency
>      information as before.
>
>  (4) The functions to set/reset cookies are removed and
>      fscache_use_cookie() and fscache_unuse_cookie() are used instead.
>
>      fscache_use_cookie() is passed a flag to indicate if the cookie is
>      opened for writing.  fscache_unuse_cookie() is passed updates for the
>      metadata if we changed it (ie. if the file was opened for writing).
>
>      These are called when the file is opened or closed.
>
>  (5) cifs_setattr_*() are made to call fscache_resize() to change the size
>      of the cache object.
>
>  (6) The functions to read and write data are stubbed out pending a
>      conversion to use netfslib.
>
> Changes
> =======
> ver #7:
>  - Removed the accidentally added-back call to get the super cookie in
>    cifs_root_iget().
>  - Fixed the right call to cifs_fscache_get_super_cookie() to take account
>    of the "-o fsc" mount flag.
>
> ver #6:
>  - Moved the change of gfpflags_allow_blocking() to current_is_kswapd() for
>    cifs here.
>  - Fixed one of the error paths in cifs_atomic_open() to jump around the
>    call to use the cookie.
>  - Fixed an additional successful return in the middle of cifs_open() to
>    use the cookie on the way out.
>  - Only get a volume cookie (and thus inode cookies) when "-o fsc" is
>    supplied to mount.
>
> ver #5:
>  - Fixed a couple of bits of cookie handling[2]:
>    - The cookie should be released in cifs_evict_inode(), not
>      cifsFileInfo_put_final().  The cookie needs to persist beyond file
>      closure so that writepages will be able to write to it.
>    - fscache_use_cookie() needs to be called in cifs_atomic_open() as it is
>      for cifs_open().
>
> ver #4:
>  - Fixed the use of sizeof with memset.
>  - tcon->vol_create_time is __le64 so doesn't need cpu_to_le64().
>
> ver #3:
>  - Canonicalise the cifs coherency data to make the cache portable.
>  - Set volume coherency data.
>
> ver #2:
>  - Use gfpflags_allow_blocking() rather than using flag directly.
>  - Upgraded to -rc4 to allow for upstream changes[1].
>  - fscache_acquire_volume() now returns errors.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> cc: Steve French <smfrench@gmail.com>
> cc: Shyam Prasad N <nspmangalore@gmail.com>
> cc: linux-cifs@vger.kernel.org
> cc: linux-cachefs@redhat.com
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=23b55d673d7527b093cd97b7c217c82e70cd1af0 [1]
> Link: https://lore.kernel.org/r/3419813.1641592362@warthog.procyon.org.uk/ [2]
> Link: https://lore.kernel.org/r/163819671009.215744.11230627184193298714.stgit@warthog.procyon.org.uk/ # v1
> Link: https://lore.kernel.org/r/163906982979.143852.10672081929614953210.stgit@warthog.procyon.org.uk/ # v2
> Link: https://lore.kernel.org/r/163967187187.1823006.247415138444991444.stgit@warthog.procyon.org.uk/ # v3
> Link: https://lore.kernel.org/r/164021579335.640689.2681324337038770579.stgit@warthog.procyon.org.uk/ # v4
> Link: https://lore.kernel.org/r/3462849.1641593783@warthog.procyon.org.uk/ # v5
> Link: https://lore.kernel.org/r/1318953.1642024578@warthog.procyon.org.uk/ # v6
> ---
>
>  fs/cifs/Kconfig    |    2
>  fs/cifs/Makefile   |    2
>  fs/cifs/cache.c    |  105 ----------------
>  fs/cifs/cifsfs.c   |   19 ++-
>  fs/cifs/cifsglob.h |    5 -
>  fs/cifs/connect.c  |   15 --
>  fs/cifs/dir.c      |    5 +
>  fs/cifs/file.c     |   70 +++++++----
>  fs/cifs/fscache.c  |  333 ++++++++++++----------------------------------------
>  fs/cifs/fscache.h  |  126 ++++++--------------
>  fs/cifs/inode.c    |   19 ++-
>  11 files changed, 197 insertions(+), 504 deletions(-)
>  delete mode 100644 fs/cifs/cache.c
>
> diff --git a/fs/cifs/Kconfig b/fs/cifs/Kconfig
> index 346ae8716deb..3b7e3b9e4fd2 100644
> --- a/fs/cifs/Kconfig
> +++ b/fs/cifs/Kconfig
> @@ -188,7 +188,7 @@ config CIFS_SMB_DIRECT
>
>  config CIFS_FSCACHE
>         bool "Provide CIFS client caching support"
> -       depends on CIFS=m && FSCACHE_OLD_API || CIFS=y && FSCACHE_OLD_API=y
> +       depends on CIFS=m && FSCACHE || CIFS=y && FSCACHE=y
>         help
>           Makes CIFS FS-Cache capable. Say Y here if you want your CIFS data
>           to be cached locally on disk through the general filesystem cache
> diff --git a/fs/cifs/Makefile b/fs/cifs/Makefile
> index 87fcacdf3de7..cc8fdcb35b71 100644
> --- a/fs/cifs/Makefile
> +++ b/fs/cifs/Makefile
> @@ -25,7 +25,7 @@ cifs-$(CONFIG_CIFS_DFS_UPCALL) += cifs_dfs_ref.o dfs_cache.o
>
>  cifs-$(CONFIG_CIFS_SWN_UPCALL) += netlink.o cifs_swn.o
>
> -cifs-$(CONFIG_CIFS_FSCACHE) += fscache.o cache.o
> +cifs-$(CONFIG_CIFS_FSCACHE) += fscache.o
>
>  cifs-$(CONFIG_CIFS_SMB_DIRECT) += smbdirect.o
>
> diff --git a/fs/cifs/cache.c b/fs/cifs/cache.c
> deleted file mode 100644
> index 8be57aaedab6..000000000000
> --- a/fs/cifs/cache.c
> +++ /dev/null
> @@ -1,105 +0,0 @@
> -// SPDX-License-Identifier: LGPL-2.1
> -/*
> - *   CIFS filesystem cache index structure definitions
> - *
> - *   Copyright (c) 2010 Novell, Inc.
> - *   Authors(s): Suresh Jayaraman (sjayaraman@suse.de>
> - *
> - */
> -#include "fscache.h"
> -#include "cifs_debug.h"
> -
> -/*
> - * CIFS filesystem definition for FS-Cache
> - */
> -struct fscache_netfs cifs_fscache_netfs = {
> -       .name = "cifs",
> -       .version = 0,
> -};
> -
> -/*
> - * Register CIFS for caching with FS-Cache
> - */
> -int cifs_fscache_register(void)
> -{
> -       return fscache_register_netfs(&cifs_fscache_netfs);
> -}
> -
> -/*
> - * Unregister CIFS for caching
> - */
> -void cifs_fscache_unregister(void)
> -{
> -       fscache_unregister_netfs(&cifs_fscache_netfs);
> -}
> -
> -/*
> - * Server object for FS-Cache
> - */
> -const struct fscache_cookie_def cifs_fscache_server_index_def = {
> -       .name = "CIFS.server",
> -       .type = FSCACHE_COOKIE_TYPE_INDEX,
> -};
> -
> -static enum
> -fscache_checkaux cifs_fscache_super_check_aux(void *cookie_netfs_data,
> -                                             const void *data,
> -                                             uint16_t datalen,
> -                                             loff_t object_size)
> -{
> -       struct cifs_fscache_super_auxdata auxdata;
> -       const struct cifs_tcon *tcon = cookie_netfs_data;
> -
> -       if (datalen != sizeof(auxdata))
> -               return FSCACHE_CHECKAUX_OBSOLETE;
> -
> -       memset(&auxdata, 0, sizeof(auxdata));
> -       auxdata.resource_id = tcon->resource_id;
> -       auxdata.vol_create_time = tcon->vol_create_time;
> -       auxdata.vol_serial_number = tcon->vol_serial_number;
> -
> -       if (memcmp(data, &auxdata, datalen) != 0)
> -               return FSCACHE_CHECKAUX_OBSOLETE;
> -
> -       return FSCACHE_CHECKAUX_OKAY;
> -}
> -
> -/*
> - * Superblock object for FS-Cache
> - */
> -const struct fscache_cookie_def cifs_fscache_super_index_def = {
> -       .name = "CIFS.super",
> -       .type = FSCACHE_COOKIE_TYPE_INDEX,
> -       .check_aux = cifs_fscache_super_check_aux,
> -};
> -
> -static enum
> -fscache_checkaux cifs_fscache_inode_check_aux(void *cookie_netfs_data,
> -                                             const void *data,
> -                                             uint16_t datalen,
> -                                             loff_t object_size)
> -{
> -       struct cifs_fscache_inode_auxdata auxdata;
> -       struct cifsInodeInfo *cifsi = cookie_netfs_data;
> -
> -       if (datalen != sizeof(auxdata))
> -               return FSCACHE_CHECKAUX_OBSOLETE;
> -
> -       memset(&auxdata, 0, sizeof(auxdata));
> -       auxdata.eof = cifsi->server_eof;
> -       auxdata.last_write_time_sec = cifsi->vfs_inode.i_mtime.tv_sec;
> -       auxdata.last_change_time_sec = cifsi->vfs_inode.i_ctime.tv_sec;
> -       auxdata.last_write_time_nsec = cifsi->vfs_inode.i_mtime.tv_nsec;
> -       auxdata.last_change_time_nsec = cifsi->vfs_inode.i_ctime.tv_nsec;
> -
> -       if (memcmp(data, &auxdata, datalen) != 0)
> -               return FSCACHE_CHECKAUX_OBSOLETE;
> -
> -       return FSCACHE_CHECKAUX_OKAY;
> -}
> -
> -const struct fscache_cookie_def cifs_fscache_inode_object_def = {
> -       .name           = "CIFS.uniqueid",
> -       .type           = FSCACHE_COOKIE_TYPE_DATAFILE,
> -       .check_aux      = cifs_fscache_inode_check_aux,
> -};
> diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
> index dca42aa87d30..26cf2193c9a2 100644
> --- a/fs/cifs/cifsfs.c
> +++ b/fs/cifs/cifsfs.c
> @@ -396,6 +396,9 @@ static void
>  cifs_evict_inode(struct inode *inode)
>  {
>         truncate_inode_pages_final(&inode->i_data);
> +       if (inode->i_state & I_PINNING_FSCACHE_WB)
> +               cifs_fscache_unuse_inode_cookie(inode, true);
> +       cifs_fscache_release_inode_cookie(inode);
>         clear_inode(inode);
>  }
>
> @@ -720,6 +723,12 @@ static int cifs_show_stats(struct seq_file *s, struct dentry *root)
>  }
>  #endif
>
> +static int cifs_write_inode(struct inode *inode, struct writeback_control *wbc)
> +{
> +       fscache_unpin_writeback(wbc, cifs_inode_cookie(inode));
> +       return 0;
> +}
> +
>  static int cifs_drop_inode(struct inode *inode)
>  {
>         struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
> @@ -732,6 +741,7 @@ static int cifs_drop_inode(struct inode *inode)
>  static const struct super_operations cifs_super_ops = {
>         .statfs = cifs_statfs,
>         .alloc_inode = cifs_alloc_inode,
> +       .write_inode    = cifs_write_inode,
>         .free_inode = cifs_free_inode,
>         .drop_inode     = cifs_drop_inode,
>         .evict_inode    = cifs_evict_inode,
> @@ -1624,13 +1634,9 @@ init_cifs(void)
>                 goto out_destroy_cifsoplockd_wq;
>         }
>
> -       rc = cifs_fscache_register();
> -       if (rc)
> -               goto out_destroy_deferredclose_wq;
> -
>         rc = cifs_init_inodecache();
>         if (rc)
> -               goto out_unreg_fscache;
> +               goto out_destroy_deferredclose_wq;
>
>         rc = cifs_init_mids();
>         if (rc)
> @@ -1692,8 +1698,6 @@ init_cifs(void)
>         cifs_destroy_mids();
>  out_destroy_inodecache:
>         cifs_destroy_inodecache();
> -out_unreg_fscache:
> -       cifs_fscache_unregister();
>  out_destroy_deferredclose_wq:
>         destroy_workqueue(deferredclose_wq);
>  out_destroy_cifsoplockd_wq:
> @@ -1729,7 +1733,6 @@ exit_cifs(void)
>         cifs_destroy_request_bufs();
>         cifs_destroy_mids();
>         cifs_destroy_inodecache();
> -       cifs_fscache_unregister();
>         destroy_workqueue(deferredclose_wq);
>         destroy_workqueue(cifsoplockd_wq);
>         destroy_workqueue(decrypt_wq);
> diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
> index be74606724c7..ba6fbb1ad8f3 100644
> --- a/fs/cifs/cifsglob.h
> +++ b/fs/cifs/cifsglob.h
> @@ -659,9 +659,6 @@ struct TCP_Server_Info {
>         unsigned int total_read; /* total amount of data read in this pass */
>         atomic_t in_send; /* requests trying to send */
>         atomic_t num_waiters;   /* blocked waiting to get in sendrecv */
> -#ifdef CONFIG_CIFS_FSCACHE
> -       struct fscache_cookie   *fscache; /* client index cache cookie */
> -#endif
>  #ifdef CONFIG_CIFS_STATS2
>         atomic_t num_cmds[NUMBER_OF_SMB2_COMMANDS]; /* total requests by cmd */
>         atomic_t smb2slowcmd[NUMBER_OF_SMB2_COMMANDS]; /* count resps > 1 sec */
> @@ -1117,7 +1114,7 @@ struct cifs_tcon {
>         __u32 max_bytes_copy;
>  #ifdef CONFIG_CIFS_FSCACHE
>         u64 resource_id;                /* server resource id */
> -       struct fscache_cookie *fscache; /* cookie for share */
> +       struct fscache_volume *fscache; /* cookie for share */
>  #endif
>         struct list_head pending_opens; /* list of incomplete opens */
>         struct cached_fid crfid; /* Cached root fid */
> diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
> index 1060164b984a..598be9890f2a 100644
> --- a/fs/cifs/connect.c
> +++ b/fs/cifs/connect.c
> @@ -1396,10 +1396,6 @@ cifs_put_tcp_session(struct TCP_Server_Info *server, int from_reconnect)
>
>         cifs_crypto_secmech_release(server);
>
> -       /* fscache server cookies are based on primary channel only */
> -       if (!CIFS_SERVER_IS_CHAN(server))
> -               cifs_fscache_release_client_cookie(server);
> -
>         kfree(server->session_key.response);
>         server->session_key.response = NULL;
>         server->session_key.len = 0;
> @@ -1559,14 +1555,6 @@ cifs_get_tcp_session(struct smb3_fs_context *ctx,
>         list_add(&tcp_ses->tcp_ses_list, &cifs_tcp_ses_list);
>         spin_unlock(&cifs_tcp_ses_lock);
>
> -       /* fscache server cookies are based on primary channel only */
> -       if (!CIFS_SERVER_IS_CHAN(tcp_ses))
> -               cifs_fscache_get_client_cookie(tcp_ses);
> -#ifdef CONFIG_CIFS_FSCACHE
> -       else
> -               tcp_ses->fscache = tcp_ses->primary_server->fscache;
> -#endif /* CONFIG_CIFS_FSCACHE */
> -
>         /* queue echo request delayed work */
>         queue_delayed_work(cifsiod_wq, &tcp_ses->echo, tcp_ses->echo_interval);
>
> @@ -3069,7 +3057,8 @@ static int mount_get_conns(struct mount_ctx *mnt_ctx)
>          * Inside cifs_fscache_get_super_cookie it checks
>          * that we do not get super cookie twice.
>          */
> -       cifs_fscache_get_super_cookie(tcon);
> +       if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_FSCACHE)
> +               cifs_fscache_get_super_cookie(tcon);
>
>  out:
>         mnt_ctx->server = server;
> diff --git a/fs/cifs/dir.c b/fs/cifs/dir.c
> index 6e8e7cc26ae2..ce9b22aecfba 100644
> --- a/fs/cifs/dir.c
> +++ b/fs/cifs/dir.c
> @@ -22,6 +22,7 @@
>  #include "cifs_unicode.h"
>  #include "fs_context.h"
>  #include "cifs_ioctl.h"
> +#include "fscache.h"
>
>  static void
>  renew_parental_timestamps(struct dentry *direntry)
> @@ -507,8 +508,12 @@ cifs_atomic_open(struct inode *inode, struct dentry *direntry,
>                         server->ops->close(xid, tcon, &fid);
>                 cifs_del_pending_open(&open);
>                 rc = -ENOMEM;
> +               goto out;
>         }
>
> +       fscache_use_cookie(cifs_inode_cookie(file_inode(file)),
> +                          file->f_mode & FMODE_WRITE);
> +
>  out:
>         cifs_put_tlink(tlink);
>  out_free_xid:
> diff --git a/fs/cifs/file.c b/fs/cifs/file.c
> index 9fee3af83a73..fb77ca1a15d8 100644
> --- a/fs/cifs/file.c
> +++ b/fs/cifs/file.c
> @@ -376,8 +376,6 @@ static void cifsFileInfo_put_final(struct cifsFileInfo *cifs_file)
>         struct cifsLockInfo *li, *tmp;
>         struct super_block *sb = inode->i_sb;
>
> -       cifs_fscache_release_inode_cookie(inode);
> -
>         /*
>          * Delete any outstanding lock records. We'll lose them when the file
>          * is closed anyway.
> @@ -570,7 +568,7 @@ int cifs_open(struct inode *inode, struct file *file)
>                         spin_lock(&CIFS_I(inode)->deferred_lock);
>                         cifs_del_deferred_close(cfile);
>                         spin_unlock(&CIFS_I(inode)->deferred_lock);
> -                       goto out;
> +                       goto use_cache;
>                 } else {
>                         _cifsFileInfo_put(cfile, true, false);
>                 }
> @@ -632,8 +630,6 @@ int cifs_open(struct inode *inode, struct file *file)
>                 goto out;
>         }
>
> -       cifs_fscache_set_inode_cookie(inode, file);
> -
>         if ((oplock & CIFS_CREATE_ACTION) && !posix_open_ok && tcon->unix_ext) {
>                 /*
>                  * Time to set mode which we can not set earlier due to
> @@ -652,6 +648,19 @@ int cifs_open(struct inode *inode, struct file *file)
>                                        cfile->pid);
>         }
>
> +use_cache:
> +       fscache_use_cookie(cifs_inode_cookie(file_inode(file)),
> +                          file->f_mode & FMODE_WRITE);
> +       if (file->f_flags & O_DIRECT &&
> +           (!((file->f_flags & O_ACCMODE) != O_RDONLY) ||
> +            file->f_flags & O_APPEND)) {
> +               struct cifs_fscache_inode_coherency_data cd;
> +               cifs_fscache_fill_coherency(file_inode(file), &cd);
> +               fscache_invalidate(cifs_inode_cookie(file_inode(file)),
> +                                  &cd, i_size_read(file_inode(file)),
> +                                  FSCACHE_INVAL_DIO_WRITE);
> +       }
> +
>  out:
>         free_dentry_path(page);
>         free_xid(xid);
> @@ -876,6 +885,8 @@ int cifs_close(struct inode *inode, struct file *file)
>         struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
>         struct cifs_deferred_close *dclose;
>
> +       cifs_fscache_unuse_inode_cookie(inode, file->f_mode & FMODE_WRITE);
> +
>         if (file->private_data != NULL) {
>                 cfile = file->private_data;
>                 file->private_data = NULL;
> @@ -886,7 +897,6 @@ int cifs_close(struct inode *inode, struct file *file)
>                     dclose) {
>                         if (test_and_clear_bit(CIFS_INO_MODIFIED_ATTR, &cinode->flags)) {
>                                 inode->i_ctime = inode->i_mtime = current_time(inode);
> -                               cifs_fscache_update_inode_cookie(inode);
>                         }
>                         spin_lock(&cinode->deferred_lock);
>                         cifs_add_deferred_close(cfile, dclose);
> @@ -4198,10 +4208,12 @@ static vm_fault_t
>  cifs_page_mkwrite(struct vm_fault *vmf)
>  {
>         struct page *page = vmf->page;
> -       struct file *file = vmf->vma->vm_file;
> -       struct inode *inode = file_inode(file);
>
> -       cifs_fscache_wait_on_page_write(inode, page);
> +#ifdef CONFIG_CIFS_FSCACHE
> +       if (PageFsCache(page) &&
> +           wait_on_page_fscache_killable(page) < 0)
> +               return VM_FAULT_RETRY;
> +#endif
>
>         lock_page(page);
>         return VM_FAULT_LOCKED;
> @@ -4275,8 +4287,6 @@ cifs_readv_complete(struct work_struct *work)
>                 if (rdata->result == 0 ||
>                     (rdata->result == -EAGAIN && got_bytes))
>                         cifs_readpage_to_fscache(rdata->mapping->host, page);
> -               else
> -                       cifs_fscache_uncache_page(rdata->mapping->host, page);
>
>                 got_bytes -= min_t(unsigned int, PAGE_SIZE, got_bytes);
>
> @@ -4593,11 +4603,6 @@ static int cifs_readpages(struct file *file, struct address_space *mapping,
>                 kref_put(&rdata->refcount, cifs_readdata_release);
>         }
>
> -       /* Any pages that have been shown to fscache but didn't get added to
> -        * the pagecache must be uncached before they get returned to the
> -        * allocator.
> -        */
> -       cifs_fscache_readpages_cancel(mapping->host, page_list);
>         free_xid(xid);
>         return rc;
>  }
> @@ -4801,17 +4806,19 @@ static int cifs_release_page(struct page *page, gfp_t gfp)
>  {
>         if (PagePrivate(page))
>                 return 0;
> -
> -       return cifs_fscache_release_page(page, gfp);
> +       if (PageFsCache(page)) {
> +               if (current_is_kswapd() || !(gfp & __GFP_FS))
> +                       return false;
> +               wait_on_page_fscache(page);
> +       }
> +       fscache_note_page_release(cifs_inode_cookie(page->mapping->host));
> +       return true;
>  }
>
>  static void cifs_invalidate_page(struct page *page, unsigned int offset,
>                                  unsigned int length)
>  {
> -       struct cifsInodeInfo *cifsi = CIFS_I(page->mapping->host);
> -
> -       if (offset == 0 && length == PAGE_SIZE)
> -               cifs_fscache_invalidate_page(page, &cifsi->vfs_inode);
> +       wait_on_page_fscache(page);
>  }
>
>  static int cifs_launder_page(struct page *page)
> @@ -4831,7 +4838,7 @@ static int cifs_launder_page(struct page *page)
>         if (clear_page_dirty_for_io(page))
>                 rc = cifs_writepage_locked(page, &wbc);
>
> -       cifs_fscache_invalidate_page(page, page->mapping->host);
> +       wait_on_page_fscache(page);
>         return rc;
>  }
>
> @@ -4988,6 +4995,19 @@ static void cifs_swap_deactivate(struct file *file)
>         /* do we need to unpin (or unlock) the file */
>  }
>
> +/*
> + * Mark a page as having been made dirty and thus needing writeback.  We also
> + * need to pin the cache object to write back to.
> + */
> +#ifdef CONFIG_CIFS_FSCACHE
> +static int cifs_set_page_dirty(struct page *page)
> +{
> +       return fscache_set_page_dirty(page, cifs_inode_cookie(page->mapping->host));
> +}
> +#else
> +#define cifs_set_page_dirty __set_page_dirty_nobuffers
> +#endif
> +
>  const struct address_space_operations cifs_addr_ops = {
>         .readpage = cifs_readpage,
>         .readpages = cifs_readpages,
> @@ -4995,7 +5015,7 @@ const struct address_space_operations cifs_addr_ops = {
>         .writepages = cifs_writepages,
>         .write_begin = cifs_write_begin,
>         .write_end = cifs_write_end,
> -       .set_page_dirty = __set_page_dirty_nobuffers,
> +       .set_page_dirty = cifs_set_page_dirty,
>         .releasepage = cifs_release_page,
>         .direct_IO = cifs_direct_io,
>         .invalidatepage = cifs_invalidate_page,
> @@ -5020,7 +5040,7 @@ const struct address_space_operations cifs_addr_ops_smallbuf = {
>         .writepages = cifs_writepages,
>         .write_begin = cifs_write_begin,
>         .write_end = cifs_write_end,
> -       .set_page_dirty = __set_page_dirty_nobuffers,
> +       .set_page_dirty = cifs_set_page_dirty,
>         .releasepage = cifs_release_page,
>         .invalidatepage = cifs_invalidate_page,
>         .launder_page = cifs_launder_page,
> diff --git a/fs/cifs/fscache.c b/fs/cifs/fscache.c
> index 003c5f1f4dfb..efaac4d5ff55 100644
> --- a/fs/cifs/fscache.c
> +++ b/fs/cifs/fscache.c
> @@ -12,250 +12,136 @@
>  #include "cifs_fs_sb.h"
>  #include "cifsproto.h"
>
> -/*
> - * Key layout of CIFS server cache index object
> - */
> -struct cifs_server_key {
> -       __u64 conn_id;
> -} __packed;
> -
> -/*
> - * Get a cookie for a server object keyed by {IPaddress,port,family} tuple
> - */
> -void cifs_fscache_get_client_cookie(struct TCP_Server_Info *server)
> -{
> -       struct cifs_server_key key;
> -
> -       /*
> -        * Check if cookie was already initialized so don't reinitialize it.
> -        * In the future, as we integrate with newer fscache features,
> -        * we may want to instead add a check if cookie has changed
> -        */
> -       if (server->fscache)
> -               return;
> -
> -       memset(&key, 0, sizeof(key));
> -       key.conn_id = server->conn_id;
> -
> -       server->fscache =
> -               fscache_acquire_cookie(cifs_fscache_netfs.primary_index,
> -                                      &cifs_fscache_server_index_def,
> -                                      &key, sizeof(key),
> -                                      NULL, 0,
> -                                      server, 0, true);
> -       cifs_dbg(FYI, "%s: (0x%p/0x%p)\n",
> -                __func__, server, server->fscache);
> -}
> -
> -void cifs_fscache_release_client_cookie(struct TCP_Server_Info *server)
> +static void cifs_fscache_fill_volume_coherency(
> +       struct cifs_tcon *tcon,
> +       struct cifs_fscache_volume_coherency_data *cd)
>  {
> -       cifs_dbg(FYI, "%s: (0x%p/0x%p)\n",
> -                __func__, server, server->fscache);
> -       fscache_relinquish_cookie(server->fscache, NULL, false);
> -       server->fscache = NULL;
> +       memset(cd, 0, sizeof(*cd));
> +       cd->resource_id         = cpu_to_le64(tcon->resource_id);
> +       cd->vol_create_time     = tcon->vol_create_time;
> +       cd->vol_serial_number   = cpu_to_le32(tcon->vol_serial_number);
>  }
>
> -void cifs_fscache_get_super_cookie(struct cifs_tcon *tcon)
> +int cifs_fscache_get_super_cookie(struct cifs_tcon *tcon)
>  {
> +       struct cifs_fscache_volume_coherency_data cd;
>         struct TCP_Server_Info *server = tcon->ses->server;
> +       struct fscache_volume *vcookie;
> +       const struct sockaddr *sa = (struct sockaddr *)&server->dstaddr;
> +       size_t slen, i;
>         char *sharename;
> -       struct cifs_fscache_super_auxdata auxdata;
> +       char *key;
> +       int ret = -ENOMEM;
>
> -       /*
> -        * Check if cookie was already initialized so don't reinitialize it.
> -        * In the future, as we integrate with newer fscache features,
> -        * we may want to instead add a check if cookie has changed
> -        */
> -       if (tcon->fscache)
> -               return;
> +       tcon->fscache = NULL;
> +       switch (sa->sa_family) {
> +       case AF_INET:
> +       case AF_INET6:
> +               break;
> +       default:
> +               cifs_dbg(VFS, "Unknown network family '%d'\n", sa->sa_family);
> +               return -EINVAL;
> +       }
> +
> +       memset(&key, 0, sizeof(key));
>
>         sharename = extract_sharename(tcon->treeName);
>         if (IS_ERR(sharename)) {
>                 cifs_dbg(FYI, "%s: couldn't extract sharename\n", __func__);
> -               tcon->fscache = NULL;
> -               return;
> +               return -EINVAL;
>         }
>
> -       memset(&auxdata, 0, sizeof(auxdata));
> -       auxdata.resource_id = tcon->resource_id;
> -       auxdata.vol_create_time = tcon->vol_create_time;
> -       auxdata.vol_serial_number = tcon->vol_serial_number;
> +       slen = strlen(sharename);
> +       for (i = 0; i < slen; i++)
> +               if (sharename[i] == '/')
> +                       sharename[i] = ';';
> +
> +       key = kasprintf(GFP_KERNEL, "cifs,%pISpc,%s", sa, sharename);
> +       if (!key)
> +               goto out;
> +
> +       cifs_fscache_fill_volume_coherency(tcon, &cd);
> +       vcookie = fscache_acquire_volume(key,
> +                                        NULL, /* preferred_cache */
> +                                        &cd, sizeof(cd));
> +       cifs_dbg(FYI, "%s: (%s/0x%p)\n", __func__, key, vcookie);
> +       if (IS_ERR(vcookie)) {
> +               if (vcookie != ERR_PTR(-EBUSY)) {
> +                       ret = PTR_ERR(vcookie);
> +                       goto out_2;
> +               }
> +               pr_err("Cache volume key already in use (%s)\n", key);
> +               vcookie = NULL;
> +       }
>
> -       tcon->fscache =
> -               fscache_acquire_cookie(server->fscache,
> -                                      &cifs_fscache_super_index_def,
> -                                      sharename, strlen(sharename),
> -                                      &auxdata, sizeof(auxdata),
> -                                      tcon, 0, true);
> +       tcon->fscache = vcookie;
> +       ret = 0;
> +out_2:
> +       kfree(key);
> +out:
>         kfree(sharename);
> -       cifs_dbg(FYI, "%s: (0x%p/0x%p)\n",
> -                __func__, server->fscache, tcon->fscache);
> +       return ret;
>  }
>
>  void cifs_fscache_release_super_cookie(struct cifs_tcon *tcon)
>  {
> -       struct cifs_fscache_super_auxdata auxdata;
> -
> -       memset(&auxdata, 0, sizeof(auxdata));
> -       auxdata.resource_id = tcon->resource_id;
> -       auxdata.vol_create_time = tcon->vol_create_time;
> -       auxdata.vol_serial_number = tcon->vol_serial_number;
> +       struct cifs_fscache_volume_coherency_data cd;
>
>         cifs_dbg(FYI, "%s: (0x%p)\n", __func__, tcon->fscache);
> -       fscache_relinquish_cookie(tcon->fscache, &auxdata, false);
> -       tcon->fscache = NULL;
> -}
> -
> -static void cifs_fscache_acquire_inode_cookie(struct cifsInodeInfo *cifsi,
> -                                             struct cifs_tcon *tcon)
> -{
> -       struct cifs_fscache_inode_auxdata auxdata;
>
> -       memset(&auxdata, 0, sizeof(auxdata));
> -       auxdata.eof = cifsi->server_eof;
> -       auxdata.last_write_time_sec = cifsi->vfs_inode.i_mtime.tv_sec;
> -       auxdata.last_change_time_sec = cifsi->vfs_inode.i_ctime.tv_sec;
> -       auxdata.last_write_time_nsec = cifsi->vfs_inode.i_mtime.tv_nsec;
> -       auxdata.last_change_time_nsec = cifsi->vfs_inode.i_ctime.tv_nsec;
> -
> -       cifsi->fscache =
> -               fscache_acquire_cookie(tcon->fscache,
> -                                      &cifs_fscache_inode_object_def,
> -                                      &cifsi->uniqueid, sizeof(cifsi->uniqueid),
> -                                      &auxdata, sizeof(auxdata),
> -                                      cifsi, cifsi->vfs_inode.i_size, true);
> +       cifs_fscache_fill_volume_coherency(tcon, &cd);
> +       fscache_relinquish_volume(tcon->fscache, &cd, false);
> +       tcon->fscache = NULL;
>  }
>
> -static void cifs_fscache_enable_inode_cookie(struct inode *inode)
> +void cifs_fscache_get_inode_cookie(struct inode *inode)
>  {
> +       struct cifs_fscache_inode_coherency_data cd;
>         struct cifsInodeInfo *cifsi = CIFS_I(inode);
>         struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
>         struct cifs_tcon *tcon = cifs_sb_master_tcon(cifs_sb);
>
> -       if (cifsi->fscache)
> -               return;
> -
> -       if (!(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_FSCACHE))
> -               return;
> -
> -       cifs_fscache_acquire_inode_cookie(cifsi, tcon);
> +       cifs_fscache_fill_coherency(&cifsi->vfs_inode, &cd);
>
> -       cifs_dbg(FYI, "%s: got FH cookie (0x%p/0x%p)\n",
> -                __func__, tcon->fscache, cifsi->fscache);
> +       cifsi->fscache =
> +               fscache_acquire_cookie(tcon->fscache, 0,
> +                                      &cifsi->uniqueid, sizeof(cifsi->uniqueid),
> +                                      &cd, sizeof(cd),
> +                                      i_size_read(&cifsi->vfs_inode));
>  }
>
> -void cifs_fscache_release_inode_cookie(struct inode *inode)
> +void cifs_fscache_unuse_inode_cookie(struct inode *inode, bool update)
>  {
> -       struct cifs_fscache_inode_auxdata auxdata;
> -       struct cifsInodeInfo *cifsi = CIFS_I(inode);
> -
> -       if (cifsi->fscache) {
> -               memset(&auxdata, 0, sizeof(auxdata));
> -               auxdata.eof = cifsi->server_eof;
> -               auxdata.last_write_time_sec = cifsi->vfs_inode.i_mtime.tv_sec;
> -               auxdata.last_change_time_sec = cifsi->vfs_inode.i_ctime.tv_sec;
> -               auxdata.last_write_time_nsec = cifsi->vfs_inode.i_mtime.tv_nsec;
> -               auxdata.last_change_time_nsec = cifsi->vfs_inode.i_ctime.tv_nsec;
> +       if (update) {
> +               struct cifs_fscache_inode_coherency_data cd;
> +               loff_t i_size = i_size_read(inode);
>
> -               cifs_dbg(FYI, "%s: (0x%p)\n", __func__, cifsi->fscache);
> -               /* fscache_relinquish_cookie does not seem to update auxdata */
> -               fscache_update_cookie(cifsi->fscache, &auxdata);
> -               fscache_relinquish_cookie(cifsi->fscache, &auxdata, false);
> -               cifsi->fscache = NULL;
> +               cifs_fscache_fill_coherency(inode, &cd);
> +               fscache_unuse_cookie(cifs_inode_cookie(inode), &cd, &i_size);
> +       } else {
> +               fscache_unuse_cookie(cifs_inode_cookie(inode), NULL, NULL);
>         }
>  }
>
> -void cifs_fscache_update_inode_cookie(struct inode *inode)
> +void cifs_fscache_release_inode_cookie(struct inode *inode)
>  {
> -       struct cifs_fscache_inode_auxdata auxdata;
>         struct cifsInodeInfo *cifsi = CIFS_I(inode);
>
>         if (cifsi->fscache) {
> -               memset(&auxdata, 0, sizeof(auxdata));
> -               auxdata.eof = cifsi->server_eof;
> -               auxdata.last_write_time_sec = cifsi->vfs_inode.i_mtime.tv_sec;
> -               auxdata.last_change_time_sec = cifsi->vfs_inode.i_ctime.tv_sec;
> -               auxdata.last_write_time_nsec = cifsi->vfs_inode.i_mtime.tv_nsec;
> -               auxdata.last_change_time_nsec = cifsi->vfs_inode.i_ctime.tv_nsec;
> -
>                 cifs_dbg(FYI, "%s: (0x%p)\n", __func__, cifsi->fscache);
> -               fscache_update_cookie(cifsi->fscache, &auxdata);
> -       }
> -}
> -
> -void cifs_fscache_set_inode_cookie(struct inode *inode, struct file *filp)
> -{
> -       cifs_fscache_enable_inode_cookie(inode);
> -}
> -
> -void cifs_fscache_reset_inode_cookie(struct inode *inode)
> -{
> -       struct cifsInodeInfo *cifsi = CIFS_I(inode);
> -       struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
> -       struct cifs_tcon *tcon = cifs_sb_master_tcon(cifs_sb);
> -       struct fscache_cookie *old = cifsi->fscache;
> -
> -       if (cifsi->fscache) {
> -               /* retire the current fscache cache and get a new one */
> -               fscache_relinquish_cookie(cifsi->fscache, NULL, true);
> -
> -               cifs_fscache_acquire_inode_cookie(cifsi, tcon);
> -               cifs_dbg(FYI, "%s: new cookie 0x%p oldcookie 0x%p\n",
> -                        __func__, cifsi->fscache, old);
> +               fscache_relinquish_cookie(cifsi->fscache, false);
> +               cifsi->fscache = NULL;
>         }
>  }
>
> -int cifs_fscache_release_page(struct page *page, gfp_t gfp)
> -{
> -       if (PageFsCache(page)) {
> -               struct inode *inode = page->mapping->host;
> -               struct cifsInodeInfo *cifsi = CIFS_I(inode);
> -
> -               cifs_dbg(FYI, "%s: (0x%p/0x%p)\n",
> -                        __func__, page, cifsi->fscache);
> -               if (!fscache_maybe_release_page(cifsi->fscache, page, gfp))
> -                       return 0;
> -       }
> -
> -       return 1;
> -}
> -
> -static void cifs_readpage_from_fscache_complete(struct page *page, void *ctx,
> -                                               int error)
> -{
> -       cifs_dbg(FYI, "%s: (0x%p/%d)\n", __func__, page, error);
> -       if (!error)
> -               SetPageUptodate(page);
> -       unlock_page(page);
> -}
> -
>  /*
>   * Retrieve a page from FS-Cache
>   */
>  int __cifs_readpage_from_fscache(struct inode *inode, struct page *page)
>  {
> -       int ret;
> -
>         cifs_dbg(FYI, "%s: (fsc:%p, p:%p, i:0x%p\n",
>                  __func__, CIFS_I(inode)->fscache, page, inode);
> -       ret = fscache_read_or_alloc_page(CIFS_I(inode)->fscache, page,
> -                                        cifs_readpage_from_fscache_complete,
> -                                        NULL,
> -                                        GFP_KERNEL);
> -       switch (ret) {
> -
> -       case 0: /* page found in fscache, read submitted */
> -               cifs_dbg(FYI, "%s: submitted\n", __func__);
> -               return ret;
> -       case -ENOBUFS:  /* page won't be cached */
> -       case -ENODATA:  /* page not in cache */
> -               cifs_dbg(FYI, "%s: %d\n", __func__, ret);
> -               return 1;
> -
> -       default:
> -               cifs_dbg(VFS, "unknown error ret = %d\n", ret);
> -       }
> -       return ret;
> +       return -ENOBUFS; // Needs conversion to using netfslib
>  }
>
>  /*
> @@ -266,78 +152,19 @@ int __cifs_readpages_from_fscache(struct inode *inode,
>                                 struct list_head *pages,
>                                 unsigned *nr_pages)
>  {
> -       int ret;
> -
>         cifs_dbg(FYI, "%s: (0x%p/%u/0x%p)\n",
>                  __func__, CIFS_I(inode)->fscache, *nr_pages, inode);
> -       ret = fscache_read_or_alloc_pages(CIFS_I(inode)->fscache, mapping,
> -                                         pages, nr_pages,
> -                                         cifs_readpage_from_fscache_complete,
> -                                         NULL,
> -                                         mapping_gfp_mask(mapping));
> -       switch (ret) {
> -       case 0: /* read submitted to the cache for all pages */
> -               cifs_dbg(FYI, "%s: submitted\n", __func__);
> -               return ret;
> -
> -       case -ENOBUFS:  /* some pages are not cached and can't be */
> -       case -ENODATA:  /* some pages are not cached */
> -               cifs_dbg(FYI, "%s: no page\n", __func__);
> -               return 1;
> -
> -       default:
> -               cifs_dbg(FYI, "unknown error ret = %d\n", ret);
> -       }
> -
> -       return ret;
> +       return -ENOBUFS; // Needs conversion to using netfslib
>  }
>
>  void __cifs_readpage_to_fscache(struct inode *inode, struct page *page)
>  {
>         struct cifsInodeInfo *cifsi = CIFS_I(inode);
> -       int ret;
>
>         WARN_ON(!cifsi->fscache);
>
>         cifs_dbg(FYI, "%s: (fsc: %p, p: %p, i: %p)\n",
>                  __func__, cifsi->fscache, page, inode);
> -       ret = fscache_write_page(cifsi->fscache, page,
> -                                cifsi->vfs_inode.i_size, GFP_KERNEL);
> -       if (ret != 0)
> -               fscache_uncache_page(cifsi->fscache, page);
> -}
> -
> -void __cifs_fscache_readpages_cancel(struct inode *inode, struct list_head *pages)
> -{
> -       cifs_dbg(FYI, "%s: (fsc: %p, i: %p)\n",
> -                __func__, CIFS_I(inode)->fscache, inode);
> -       fscache_readpages_cancel(CIFS_I(inode)->fscache, pages);
> -}
> -
> -void __cifs_fscache_invalidate_page(struct page *page, struct inode *inode)
> -{
> -       struct cifsInodeInfo *cifsi = CIFS_I(inode);
> -       struct fscache_cookie *cookie = cifsi->fscache;
> -
> -       cifs_dbg(FYI, "%s: (0x%p/0x%p)\n", __func__, page, cookie);
> -       fscache_wait_on_page_write(cookie, page);
> -       fscache_uncache_page(cookie, page);
> -}
> -
> -void __cifs_fscache_wait_on_page_write(struct inode *inode, struct page *page)
> -{
> -       struct cifsInodeInfo *cifsi = CIFS_I(inode);
> -       struct fscache_cookie *cookie = cifsi->fscache;
> -
> -       cifs_dbg(FYI, "%s: (0x%p/0x%p)\n", __func__, page, cookie);
> -       fscache_wait_on_page_write(cookie, page);
> -}
> -
> -void __cifs_fscache_uncache_page(struct inode *inode, struct page *page)
> -{
> -       struct cifsInodeInfo *cifsi = CIFS_I(inode);
> -       struct fscache_cookie *cookie = cifsi->fscache;
>
> -       cifs_dbg(FYI, "%s: (0x%p/0x%p)\n", __func__, page, cookie);
> -       fscache_uncache_page(cookie, page);
> +       // Needs conversion to using netfslib
>  }
> diff --git a/fs/cifs/fscache.h b/fs/cifs/fscache.h
> index 9baa1d0f22bd..0fc3f9252c84 100644
> --- a/fs/cifs/fscache.h
> +++ b/fs/cifs/fscache.h
> @@ -13,84 +13,62 @@
>
>  #include "cifsglob.h"
>
> -#ifdef CONFIG_CIFS_FSCACHE
> -
>  /*
> - * Auxiliary data attached to CIFS superblock within the cache
> + * Coherency data attached to CIFS volume within the cache
>   */
> -struct cifs_fscache_super_auxdata {
> -       u64     resource_id;            /* unique server resource id */
> +struct cifs_fscache_volume_coherency_data {
> +       __le64  resource_id;            /* unique server resource id */
>         __le64  vol_create_time;
> -       u32     vol_serial_number;
> +       __le32  vol_serial_number;
>  } __packed;
>
>  /*
> - * Auxiliary data attached to CIFS inode within the cache
> + * Coherency data attached to CIFS inode within the cache.
>   */
> -struct cifs_fscache_inode_auxdata {
> -       u64 last_write_time_sec;
> -       u64 last_change_time_sec;
> -       u32 last_write_time_nsec;
> -       u32 last_change_time_nsec;
> -       u64 eof;
> +struct cifs_fscache_inode_coherency_data {
> +       __le64 last_write_time_sec;
> +       __le64 last_change_time_sec;
> +       __le32 last_write_time_nsec;
> +       __le32 last_change_time_nsec;
>  };
>
> -/*
> - * cache.c
> - */
> -extern struct fscache_netfs cifs_fscache_netfs;
> -extern const struct fscache_cookie_def cifs_fscache_server_index_def;
> -extern const struct fscache_cookie_def cifs_fscache_super_index_def;
> -extern const struct fscache_cookie_def cifs_fscache_inode_object_def;
> -
> -extern int cifs_fscache_register(void);
> -extern void cifs_fscache_unregister(void);
> +#ifdef CONFIG_CIFS_FSCACHE
>
>  /*
>   * fscache.c
>   */
> -extern void cifs_fscache_get_client_cookie(struct TCP_Server_Info *);
> -extern void cifs_fscache_release_client_cookie(struct TCP_Server_Info *);
> -extern void cifs_fscache_get_super_cookie(struct cifs_tcon *);
> +extern int cifs_fscache_get_super_cookie(struct cifs_tcon *);
>  extern void cifs_fscache_release_super_cookie(struct cifs_tcon *);
>
> +extern void cifs_fscache_get_inode_cookie(struct inode *);
>  extern void cifs_fscache_release_inode_cookie(struct inode *);
> -extern void cifs_fscache_update_inode_cookie(struct inode *inode);
> -extern void cifs_fscache_set_inode_cookie(struct inode *, struct file *);
> -extern void cifs_fscache_reset_inode_cookie(struct inode *);
> +extern void cifs_fscache_unuse_inode_cookie(struct inode *, bool);
> +
> +static inline
> +void cifs_fscache_fill_coherency(struct inode *inode,
> +                                struct cifs_fscache_inode_coherency_data *cd)
> +{
> +       struct cifsInodeInfo *cifsi = CIFS_I(inode);
> +
> +       memset(cd, 0, sizeof(*cd));
> +       cd->last_write_time_sec   = cpu_to_le64(cifsi->vfs_inode.i_mtime.tv_sec);
> +       cd->last_write_time_nsec  = cpu_to_le32(cifsi->vfs_inode.i_mtime.tv_nsec);
> +       cd->last_change_time_sec  = cpu_to_le64(cifsi->vfs_inode.i_ctime.tv_sec);
> +       cd->last_change_time_nsec = cpu_to_le32(cifsi->vfs_inode.i_ctime.tv_nsec);
> +}
> +
>
> -extern void __cifs_fscache_invalidate_page(struct page *, struct inode *);
> -extern void __cifs_fscache_wait_on_page_write(struct inode *inode, struct page *page);
> -extern void __cifs_fscache_uncache_page(struct inode *inode, struct page *page);
>  extern int cifs_fscache_release_page(struct page *page, gfp_t gfp);
>  extern int __cifs_readpage_from_fscache(struct inode *, struct page *);
>  extern int __cifs_readpages_from_fscache(struct inode *,
>                                          struct address_space *,
>                                          struct list_head *,
>                                          unsigned *);
> -extern void __cifs_fscache_readpages_cancel(struct inode *, struct list_head *);
> -
>  extern void __cifs_readpage_to_fscache(struct inode *, struct page *);
>
> -static inline void cifs_fscache_invalidate_page(struct page *page,
> -                                              struct inode *inode)
> +static inline struct fscache_cookie *cifs_inode_cookie(struct inode *inode)
>  {
> -       if (PageFsCache(page))
> -               __cifs_fscache_invalidate_page(page, inode);
> -}
> -
> -static inline void cifs_fscache_wait_on_page_write(struct inode *inode,
> -                                                  struct page *page)
> -{
> -       if (PageFsCache(page))
> -               __cifs_fscache_wait_on_page_write(inode, page);
> -}
> -
> -static inline void cifs_fscache_uncache_page(struct inode *inode,
> -                                                  struct page *page)
> -{
> -       if (PageFsCache(page))
> -               __cifs_fscache_uncache_page(inode, page);
> +       return CIFS_I(inode)->fscache;
>  }
>
>  static inline int cifs_readpage_from_fscache(struct inode *inode,
> @@ -120,41 +98,20 @@ static inline void cifs_readpage_to_fscache(struct inode *inode,
>                 __cifs_readpage_to_fscache(inode, page);
>  }
>
> -static inline void cifs_fscache_readpages_cancel(struct inode *inode,
> -                                                struct list_head *pages)
> +#else /* CONFIG_CIFS_FSCACHE */
> +static inline
> +void cifs_fscache_fill_coherency(struct inode *inode,
> +                                struct cifs_fscache_inode_coherency_data *cd)
>  {
> -       if (CIFS_I(inode)->fscache)
> -               return __cifs_fscache_readpages_cancel(inode, pages);
>  }
>
> -#else /* CONFIG_CIFS_FSCACHE */
> -static inline int cifs_fscache_register(void) { return 0; }
> -static inline void cifs_fscache_unregister(void) {}
> -
> -static inline void
> -cifs_fscache_get_client_cookie(struct TCP_Server_Info *server) {}
> -static inline void
> -cifs_fscache_release_client_cookie(struct TCP_Server_Info *server) {}
> -static inline void cifs_fscache_get_super_cookie(struct cifs_tcon *tcon) {}
> -static inline void
> -cifs_fscache_release_super_cookie(struct cifs_tcon *tcon) {}
> +static inline int cifs_fscache_get_super_cookie(struct cifs_tcon *tcon) { return 0; }
> +static inline void cifs_fscache_release_super_cookie(struct cifs_tcon *tcon) {}
>
> +static inline void cifs_fscache_get_inode_cookie(struct inode *inode) {}
>  static inline void cifs_fscache_release_inode_cookie(struct inode *inode) {}
> -static inline void cifs_fscache_update_inode_cookie(struct inode *inode) {}
> -static inline void cifs_fscache_set_inode_cookie(struct inode *inode,
> -                                                struct file *filp) {}
> -static inline void cifs_fscache_reset_inode_cookie(struct inode *inode) {}
> -static inline int cifs_fscache_release_page(struct page *page, gfp_t gfp)
> -{
> -       return 1; /* May release page */
> -}
> -
> -static inline void cifs_fscache_invalidate_page(struct page *page,
> -                       struct inode *inode) {}
> -static inline void cifs_fscache_wait_on_page_write(struct inode *inode,
> -                                                  struct page *page) {}
> -static inline void cifs_fscache_uncache_page(struct inode *inode,
> -                                                  struct page *page) {}
> +static inline void cifs_fscache_unuse_inode_cookie(struct inode *inode, bool update) {}
> +static inline struct fscache_cookie *cifs_inode_cookie(struct inode *inode) { return NULL; }
>
>  static inline int
>  cifs_readpage_from_fscache(struct inode *inode, struct page *page)
> @@ -173,11 +130,6 @@ static inline int cifs_readpages_from_fscache(struct inode *inode,
>  static inline void cifs_readpage_to_fscache(struct inode *inode,
>                         struct page *page) {}
>
> -static inline void cifs_fscache_readpages_cancel(struct inode *inode,
> -                                                struct list_head *pages)
> -{
> -}
> -
>  #endif /* CONFIG_CIFS_FSCACHE */
>
>  #endif /* _CIFS_FSCACHE_H */
> diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
> index 279622e4eb1c..9b93e7d3e0e1 100644
> --- a/fs/cifs/inode.c
> +++ b/fs/cifs/inode.c
> @@ -1298,10 +1298,7 @@ cifs_iget(struct super_block *sb, struct cifs_fattr *fattr)
>                         inode->i_flags |= S_NOATIME | S_NOCMTIME;
>                 if (inode->i_state & I_NEW) {
>                         inode->i_ino = hash;
> -#ifdef CONFIG_CIFS_FSCACHE
> -                       /* initialize per-inode cache cookie pointer */
> -                       CIFS_I(inode)->fscache = NULL;
> -#endif
> +                       cifs_fscache_get_inode_cookie(inode);
>                         unlock_new_inode(inode);
>                 }
>         }
> @@ -1370,6 +1367,7 @@ struct inode *cifs_root_iget(struct super_block *sb)
>                 iget_failed(inode);
>                 inode = ERR_PTR(rc);
>         }
> +
>  out:
>         kfree(path);
>         free_xid(xid);
> @@ -2257,6 +2255,8 @@ cifs_dentry_needs_reval(struct dentry *dentry)
>  int
>  cifs_invalidate_mapping(struct inode *inode)
>  {
> +       struct cifs_fscache_inode_coherency_data cd;
> +       struct cifsInodeInfo *cifsi = CIFS_I(inode);
>         int rc = 0;
>
>         if (inode->i_mapping && inode->i_mapping->nrpages != 0) {
> @@ -2266,7 +2266,8 @@ cifs_invalidate_mapping(struct inode *inode)
>                                  __func__, inode);
>         }
>
> -       cifs_fscache_reset_inode_cookie(inode);
> +       cifs_fscache_fill_coherency(&cifsi->vfs_inode, &cd);
> +       fscache_invalidate(cifs_inode_cookie(inode), &cd, i_size_read(inode), 0);
>         return rc;
>  }
>
> @@ -2771,8 +2772,10 @@ cifs_setattr_unix(struct dentry *direntry, struct iattr *attrs)
>                 goto out;
>
>         if ((attrs->ia_valid & ATTR_SIZE) &&
> -           attrs->ia_size != i_size_read(inode))
> +           attrs->ia_size != i_size_read(inode)) {
>                 truncate_setsize(inode, attrs->ia_size);
> +               fscache_resize_cookie(cifs_inode_cookie(inode), attrs->ia_size);
> +       }
>
>         setattr_copy(&init_user_ns, inode, attrs);
>         mark_inode_dirty(inode);
> @@ -2967,8 +2970,10 @@ cifs_setattr_nounix(struct dentry *direntry, struct iattr *attrs)
>                 goto cifs_setattr_exit;
>
>         if ((attrs->ia_valid & ATTR_SIZE) &&
> -           attrs->ia_size != i_size_read(inode))
> +           attrs->ia_size != i_size_read(inode)) {
>                 truncate_setsize(inode, attrs->ia_size);
> +               fscache_resize_cookie(cifs_inode_cookie(inode), attrs->ia_size);
> +       }
>
>         setattr_copy(&init_user_ns, inode, attrs);
>         mark_inode_dirty(inode);
>
>


-- 
Thanks,

Steve

--0000000000006fd60f05d5e8e043
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-cifs-Support-fscache-indexing-rewrite.patch"
Content-Disposition: attachment; 
	filename="0001-cifs-Support-fscache-indexing-rewrite.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kyl4dx0w0>
X-Attachment-Id: f_kyl4dx0w0

RnJvbSBjYjcwNTcxNThiM2Q3MDMzZGE3M2IzMDI2MDFhYzM2MjNhMmI1ODEwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYXZpZCBIb3dlbGxzIDxkaG93ZWxsc0ByZWRoYXQuY29tPgpE
YXRlOiBUdWUsIDE4IEphbiAyMDIyIDEzOjU1OjEzICswMDAwClN1YmplY3Q6IFtQQVRDSF0gY2lm
czogU3VwcG9ydCBmc2NhY2hlIGluZGV4aW5nIHJld3JpdGUKCkNoYW5nZSB0aGUgY2lmcyBmaWxl
c3lzdGVtIHRvIHRha2UgYWNjb3VudCBvZiB0aGUgY2hhbmdlcyB0byBmc2NhY2hlJ3MKaW5kZXhp
bmcgcmV3cml0ZSBhbmQgcmVlbmFibGUgY2FjaGluZyBpbiBjaWZzLgoKVGhlIGZvbGxvd2luZyBj
aGFuZ2VzIGhhdmUgYmVlbiBtYWRlOgoKICgxKSBUaGUgZnNjYWNoZV9uZXRmcyBzdHJ1Y3QgaXMg
bm8gbW9yZSwgYW5kIHRoZXJlJ3Mgbm8gbmVlZCB0byByZWdpc3RlcgogICAgIHRoZSBmaWxlc3lz
dGVtIGFzIGEgd2hvbGUuCgogKDIpIFRoZSBzZXNzaW9uIGNvb2tpZSBpcyBub3cgYW4gZnNjYWNo
ZV92b2x1bWUgY29va2llLCBhbGxvY2F0ZWQgd2l0aAogICAgIGZzY2FjaGVfYWNxdWlyZV92b2x1
bWUoKS4gIFRoYXQgdGFrZXMgdGhyZWUgcGFyYW1ldGVyczogYSBzdHJpbmcKICAgICByZXByZXNl
bnRpbmcgdGhlICJ2b2x1bWUiIGluIHRoZSBpbmRleCwgYSBzdHJpbmcgbmFtaW5nIHRoZSBjYWNo
ZSB0bwogICAgIHVzZSAob3IgTlVMTCkgYW5kIGEgdTY0IHRoYXQgY29udmV5cyBjb2hlcmVuY3kg
bWV0YWRhdGEgZm9yIHRoZQogICAgIHZvbHVtZS4KCiAgICAgRm9yIGNpZnMsIEkndmUgbWFkZSBp
dCByZW5kZXIgdGhlIHZvbHVtZSBuYW1lIHN0cmluZyBhczoKCgkiY2lmcyw8aXBhZGRyZXNzPiw8
c2hhcmVuYW1lPiIKCiAgICAgd2hlcmUgdGhlIHNoYXJlbmFtZSBoYXMgJy8nIGNoYXJhY3RlcnMg
cmVwbGFjZWQgd2l0aCAnOycuCgogICAgIFRoaXMgcHJvYmFibHkgbmVlZHMgcmV0aGlua2luZyBh
IGJpdCBhcyB0aGUgdG90YWwgbmFtZSBjb3VsZCBleGNlZWQKICAgICB0aGUgbWF4aW11bSBmaWxl
bmFtZSBjb21wb25lbnQgbGVuZ3RoLgoKICAgICBGdXJ0aGVyLCB0aGUgY29oZXJlbmN5IGRhdGEg
aXMgY3VycmVudGx5IGp1c3Qgc2V0IHRvIDAuICBJdCBuZWVkcwogICAgIHNvbWV0aGluZyBlbHNl
IGRvaW5nIHdpdGggaXQgLSBJIHdvbmRlciBpZiBpdCB3b3VsZCBzdWZmaWNlIHNpbXBseSB0bwog
ICAgIHN1bSB0aGUgcmVzb3VyY2VfaWQsIHZvbF9jcmVhdGVfdGltZSBhbmQgdm9sX3NlcmlhbF9u
dW1iZXIgb3IgbWF5YmUKICAgICBoYXNoIHRoZW0uCgogKDMpIFRoZSBmc2NhY2hlX2Nvb2tpZV9k
ZWYgaXMgbm8gbW9yZSBhbmQgbmVlZGVkIGluZm9ybWF0aW9uIGlzIHBhc3NlZAogICAgIGRpcmVj
dGx5IHRvIGZzY2FjaGVfYWNxdWlyZV9jb29raWUoKS4gIFRoZSBjYWNoZSBubyBsb25nZXIgY2Fs
bHMgYmFjawogICAgIGludG8gdGhlIGZpbGVzeXN0ZW0sIGJ1dCByYXRoZXIgbWV0YWRhdGEgY2hh
bmdlcyBhcmUgaW5kaWNhdGVkIGF0CiAgICAgb3RoZXIgdGltZXMuCgogICAgIGZzY2FjaGVfYWNx
dWlyZV9jb29raWUoKSBpcyBwYXNzZWQgdGhlIHNhbWUga2V5aW5nIGFuZCBjb2hlcmVuY3kKICAg
ICBpbmZvcm1hdGlvbiBhcyBiZWZvcmUuCgogKDQpIFRoZSBmdW5jdGlvbnMgdG8gc2V0L3Jlc2V0
IGNvb2tpZXMgYXJlIHJlbW92ZWQgYW5kCiAgICAgZnNjYWNoZV91c2VfY29va2llKCkgYW5kIGZz
Y2FjaGVfdW51c2VfY29va2llKCkgYXJlIHVzZWQgaW5zdGVhZC4KCiAgICAgZnNjYWNoZV91c2Vf
Y29va2llKCkgaXMgcGFzc2VkIGEgZmxhZyB0byBpbmRpY2F0ZSBpZiB0aGUgY29va2llIGlzCiAg
ICAgb3BlbmVkIGZvciB3cml0aW5nLiAgZnNjYWNoZV91bnVzZV9jb29raWUoKSBpcyBwYXNzZWQg
dXBkYXRlcyBmb3IgdGhlCiAgICAgbWV0YWRhdGEgaWYgd2UgY2hhbmdlZCBpdCAoaWUuIGlmIHRo
ZSBmaWxlIHdhcyBvcGVuZWQgZm9yIHdyaXRpbmcpLgoKICAgICBUaGVzZSBhcmUgY2FsbGVkIHdo
ZW4gdGhlIGZpbGUgaXMgb3BlbmVkIG9yIGNsb3NlZC4KCiAoNSkgY2lmc19zZXRhdHRyXyooKSBh
cmUgbWFkZSB0byBjYWxsIGZzY2FjaGVfcmVzaXplKCkgdG8gY2hhbmdlIHRoZSBzaXplCiAgICAg
b2YgdGhlIGNhY2hlIG9iamVjdC4KCiAoNikgVGhlIGZ1bmN0aW9ucyB0byByZWFkIGFuZCB3cml0
ZSBkYXRhIGFyZSBzdHViYmVkIG91dCBwZW5kaW5nIGEKICAgICBjb252ZXJzaW9uIHRvIHVzZSBu
ZXRmc2xpYi4KCkNoYW5nZXMKPT09PT09PQp2ZXIgIzc6CiAtIFJlbW92ZWQgdGhlIGFjY2lkZW50
YWxseSBhZGRlZC1iYWNrIGNhbGwgdG8gZ2V0IHRoZSBzdXBlciBjb29raWUgaW4KICAgY2lmc19y
b290X2lnZXQoKS4KIC0gRml4ZWQgdGhlIHJpZ2h0IGNhbGwgdG8gY2lmc19mc2NhY2hlX2dldF9z
dXBlcl9jb29raWUoKSB0byB0YWtlIGFjY291bnQKICAgb2YgdGhlICItbyBmc2MiIG1vdW50IGZs
YWcuCgp2ZXIgIzY6CiAtIE1vdmVkIHRoZSBjaGFuZ2Ugb2YgZ2ZwZmxhZ3NfYWxsb3dfYmxvY2tp
bmcoKSB0byBjdXJyZW50X2lzX2tzd2FwZCgpIGZvcgogICBjaWZzIGhlcmUuCiAtIEZpeGVkIG9u
ZSBvZiB0aGUgZXJyb3IgcGF0aHMgaW4gY2lmc19hdG9taWNfb3BlbigpIHRvIGp1bXAgYXJvdW5k
IHRoZQogICBjYWxsIHRvIHVzZSB0aGUgY29va2llLgogLSBGaXhlZCBhbiBhZGRpdGlvbmFsIHN1
Y2Nlc3NmdWwgcmV0dXJuIGluIHRoZSBtaWRkbGUgb2YgY2lmc19vcGVuKCkgdG8KICAgdXNlIHRo
ZSBjb29raWUgb24gdGhlIHdheSBvdXQuCiAtIE9ubHkgZ2V0IGEgdm9sdW1lIGNvb2tpZSAoYW5k
IHRodXMgaW5vZGUgY29va2llcykgd2hlbiAiLW8gZnNjIiBpcwogICBzdXBwbGllZCB0byBtb3Vu
dC4KCnZlciAjNToKIC0gRml4ZWQgYSBjb3VwbGUgb2YgYml0cyBvZiBjb29raWUgaGFuZGxpbmdb
Ml06CiAgIC0gVGhlIGNvb2tpZSBzaG91bGQgYmUgcmVsZWFzZWQgaW4gY2lmc19ldmljdF9pbm9k
ZSgpLCBub3QKICAgICBjaWZzRmlsZUluZm9fcHV0X2ZpbmFsKCkuICBUaGUgY29va2llIG5lZWRz
IHRvIHBlcnNpc3QgYmV5b25kIGZpbGUKICAgICBjbG9zdXJlIHNvIHRoYXQgd3JpdGVwYWdlcyB3
aWxsIGJlIGFibGUgdG8gd3JpdGUgdG8gaXQuCiAgIC0gZnNjYWNoZV91c2VfY29va2llKCkgbmVl
ZHMgdG8gYmUgY2FsbGVkIGluIGNpZnNfYXRvbWljX29wZW4oKSBhcyBpdCBpcwogICAgIGZvciBj
aWZzX29wZW4oKS4KCnZlciAjNDoKIC0gRml4ZWQgdGhlIHVzZSBvZiBzaXplb2Ygd2l0aCBtZW1z
ZXQuCiAtIHRjb24tPnZvbF9jcmVhdGVfdGltZSBpcyBfX2xlNjQgc28gZG9lc24ndCBuZWVkIGNw
dV90b19sZTY0KCkuCgp2ZXIgIzM6CiAtIENhbm9uaWNhbGlzZSB0aGUgY2lmcyBjb2hlcmVuY3kg
ZGF0YSB0byBtYWtlIHRoZSBjYWNoZSBwb3J0YWJsZS4KIC0gU2V0IHZvbHVtZSBjb2hlcmVuY3kg
ZGF0YS4KCnZlciAjMjoKIC0gVXNlIGdmcGZsYWdzX2FsbG93X2Jsb2NraW5nKCkgcmF0aGVyIHRo
YW4gdXNpbmcgZmxhZyBkaXJlY3RseS4KIC0gVXBncmFkZWQgdG8gLXJjNCB0byBhbGxvdyBmb3Ig
dXBzdHJlYW0gY2hhbmdlc1sxXS4KIC0gZnNjYWNoZV9hY3F1aXJlX3ZvbHVtZSgpIG5vdyByZXR1
cm5zIGVycm9ycy4KClNpZ25lZC1vZmYtYnk6IERhdmlkIEhvd2VsbHMgPGRob3dlbGxzQHJlZGhh
dC5jb20+CkFja2VkLWJ5OiBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPgpjYzogU3Rl
dmUgRnJlbmNoIDxzbWZyZW5jaEBnbWFpbC5jb20+CmNjOiBTaHlhbSBQcmFzYWQgTiA8bnNwbWFu
Z2Fsb3JlQGdtYWlsLmNvbT4KY2M6IGxpbnV4LWNpZnNAdmdlci5rZXJuZWwub3JnCmNjOiBsaW51
eC1jYWNoZWZzQHJlZGhhdC5jb20KTGluazogaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2Nt
L2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L2NvbW1pdC8/aWQ9MjNiNTVkNjcz
ZDc1MjdiMDkzY2Q5N2I3YzIxN2M4MmU3MGNkMWFmMCBbMV0KTGluazogaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvci8zNDE5ODEzLjE2NDE1OTIzNjJAd2FydGhvZy5wcm9jeW9uLm9yZy51ay8gWzJd
Ckxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMTYzODE5NjcxMDA5LjIxNTc0NC4xMTIz
MDYyNzE4NDE5MzI5ODcxNC5zdGdpdEB3YXJ0aG9nLnByb2N5b24ub3JnLnVrLyAjIHYxCkxpbms6
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMTYzOTA2OTgyOTc5LjE0Mzg1Mi4xMDY3MjA4MTky
OTYxNDk1MzIxMC5zdGdpdEB3YXJ0aG9nLnByb2N5b24ub3JnLnVrLyAjIHYyCkxpbms6IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL3IvMTYzOTY3MTg3MTg3LjE4MjMwMDYuMjQ3NDE1MTM4NDQ0OTkx
NDQ0LnN0Z2l0QHdhcnRob2cucHJvY3lvbi5vcmcudWsvICMgdjMKTGluazogaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvci8xNjQwMjE1NzkzMzUuNjQwNjg5LjI2ODEzMjQzMzcwMzg3NzA1Nzkuc3Rn
aXRAd2FydGhvZy5wcm9jeW9uLm9yZy51ay8gIyB2NApMaW5rOiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9yLzM0NjI4NDkuMTY0MTU5Mzc4M0B3YXJ0aG9nLnByb2N5b24ub3JnLnVrLyAjIHY1Ckxp
bms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMTMxODk1My4xNjQyMDI0NTc4QHdhcnRob2cu
cHJvY3lvbi5vcmcudWsvICMgdjYKU2lnbmVkLW9mZi1ieTogU3RldmUgRnJlbmNoIDxzdGZyZW5j
aEBtaWNyb3NvZnQuY29tPgotLS0KIGZzL2NpZnMvS2NvbmZpZyAgICB8ICAgMiArLQogZnMvY2lm
cy9NYWtlZmlsZSAgIHwgICAyICstCiBmcy9jaWZzL2NhY2hlLmMgICAgfCAxMDUgLS0tLS0tLS0t
LS0tLS0KIGZzL2NpZnMvY2lmc2ZzLmMgICB8ICAxOSArLS0KIGZzL2NpZnMvY2lmc2dsb2IuaCB8
ICAgNSArLQogZnMvY2lmcy9jb25uZWN0LmMgIHwgIDE1ICstCiBmcy9jaWZzL2Rpci5jICAgICAg
fCAgIDUgKwogZnMvY2lmcy9maWxlLmMgICAgIHwgIDcwICsrKysrKy0tLS0KIGZzL2NpZnMvZnNj
YWNoZS5jICB8IDMzMyArKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0KIGZzL2NpZnMvZnNjYWNoZS5oICB8IDEyNiArKysrKystLS0tLS0tLS0tLQogZnMvY2lmcy9p
bm9kZS5jICAgIHwgIDE5ICsrLQogMTEgZmlsZXMgY2hhbmdlZCwgMTk3IGluc2VydGlvbnMoKyks
IDUwNCBkZWxldGlvbnMoLSkKIGRlbGV0ZSBtb2RlIDEwMDY0NCBmcy9jaWZzL2NhY2hlLmMKCmRp
ZmYgLS1naXQgYS9mcy9jaWZzL0tjb25maWcgYi9mcy9jaWZzL0tjb25maWcKaW5kZXggMzQ2YWU4
NzE2ZGViLi4zYjdlM2I5ZTRmZDIgMTAwNjQ0Ci0tLSBhL2ZzL2NpZnMvS2NvbmZpZworKysgYi9m
cy9jaWZzL0tjb25maWcKQEAgLTE4OCw3ICsxODgsNyBAQCBjb25maWcgQ0lGU19TTUJfRElSRUNU
CiAKIGNvbmZpZyBDSUZTX0ZTQ0FDSEUKIAlib29sICJQcm92aWRlIENJRlMgY2xpZW50IGNhY2hp
bmcgc3VwcG9ydCIKLQlkZXBlbmRzIG9uIENJRlM9bSAmJiBGU0NBQ0hFX09MRF9BUEkgfHwgQ0lG
Uz15ICYmIEZTQ0FDSEVfT0xEX0FQST15CisJZGVwZW5kcyBvbiBDSUZTPW0gJiYgRlNDQUNIRSB8
fCBDSUZTPXkgJiYgRlNDQUNIRT15CiAJaGVscAogCSAgTWFrZXMgQ0lGUyBGUy1DYWNoZSBjYXBh
YmxlLiBTYXkgWSBoZXJlIGlmIHlvdSB3YW50IHlvdXIgQ0lGUyBkYXRhCiAJICB0byBiZSBjYWNo
ZWQgbG9jYWxseSBvbiBkaXNrIHRocm91Z2ggdGhlIGdlbmVyYWwgZmlsZXN5c3RlbSBjYWNoZQpk
aWZmIC0tZ2l0IGEvZnMvY2lmcy9NYWtlZmlsZSBiL2ZzL2NpZnMvTWFrZWZpbGUKaW5kZXggODdm
Y2FjZGYzZGU3Li5jYzhmZGNiMzViNzEgMTAwNjQ0Ci0tLSBhL2ZzL2NpZnMvTWFrZWZpbGUKKysr
IGIvZnMvY2lmcy9NYWtlZmlsZQpAQCAtMjUsNyArMjUsNyBAQCBjaWZzLSQoQ09ORklHX0NJRlNf
REZTX1VQQ0FMTCkgKz0gY2lmc19kZnNfcmVmLm8gZGZzX2NhY2hlLm8KIAogY2lmcy0kKENPTkZJ
R19DSUZTX1NXTl9VUENBTEwpICs9IG5ldGxpbmsubyBjaWZzX3N3bi5vCiAKLWNpZnMtJChDT05G
SUdfQ0lGU19GU0NBQ0hFKSArPSBmc2NhY2hlLm8gY2FjaGUubworY2lmcy0kKENPTkZJR19DSUZT
X0ZTQ0FDSEUpICs9IGZzY2FjaGUubwogCiBjaWZzLSQoQ09ORklHX0NJRlNfU01CX0RJUkVDVCkg
Kz0gc21iZGlyZWN0Lm8KIApkaWZmIC0tZ2l0IGEvZnMvY2lmcy9jYWNoZS5jIGIvZnMvY2lmcy9j
YWNoZS5jCmRlbGV0ZWQgZmlsZSBtb2RlIDEwMDY0NAppbmRleCA4YmU1N2FhZWRhYjYuLjAwMDAw
MDAwMDAwMAotLS0gYS9mcy9jaWZzL2NhY2hlLmMKKysrIC9kZXYvbnVsbApAQCAtMSwxMDUgKzAs
MCBAQAotLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IExHUEwtMi4xCi0vKgotICogICBDSUZT
IGZpbGVzeXN0ZW0gY2FjaGUgaW5kZXggc3RydWN0dXJlIGRlZmluaXRpb25zCi0gKgotICogICBD
b3B5cmlnaHQgKGMpIDIwMTAgTm92ZWxsLCBJbmMuCi0gKiAgIEF1dGhvcnMocyk6IFN1cmVzaCBK
YXlhcmFtYW4gKHNqYXlhcmFtYW5Ac3VzZS5kZT4KLSAqCi0gKi8KLSNpbmNsdWRlICJmc2NhY2hl
LmgiCi0jaW5jbHVkZSAiY2lmc19kZWJ1Zy5oIgotCi0vKgotICogQ0lGUyBmaWxlc3lzdGVtIGRl
ZmluaXRpb24gZm9yIEZTLUNhY2hlCi0gKi8KLXN0cnVjdCBmc2NhY2hlX25ldGZzIGNpZnNfZnNj
YWNoZV9uZXRmcyA9IHsKLQkubmFtZSA9ICJjaWZzIiwKLQkudmVyc2lvbiA9IDAsCi19OwotCi0v
KgotICogUmVnaXN0ZXIgQ0lGUyBmb3IgY2FjaGluZyB3aXRoIEZTLUNhY2hlCi0gKi8KLWludCBj
aWZzX2ZzY2FjaGVfcmVnaXN0ZXIodm9pZCkKLXsKLQlyZXR1cm4gZnNjYWNoZV9yZWdpc3Rlcl9u
ZXRmcygmY2lmc19mc2NhY2hlX25ldGZzKTsKLX0KLQotLyoKLSAqIFVucmVnaXN0ZXIgQ0lGUyBm
b3IgY2FjaGluZwotICovCi12b2lkIGNpZnNfZnNjYWNoZV91bnJlZ2lzdGVyKHZvaWQpCi17Ci0J
ZnNjYWNoZV91bnJlZ2lzdGVyX25ldGZzKCZjaWZzX2ZzY2FjaGVfbmV0ZnMpOwotfQotCi0vKgot
ICogU2VydmVyIG9iamVjdCBmb3IgRlMtQ2FjaGUKLSAqLwotY29uc3Qgc3RydWN0IGZzY2FjaGVf
Y29va2llX2RlZiBjaWZzX2ZzY2FjaGVfc2VydmVyX2luZGV4X2RlZiA9IHsKLQkubmFtZSA9ICJD
SUZTLnNlcnZlciIsCi0JLnR5cGUgPSBGU0NBQ0hFX0NPT0tJRV9UWVBFX0lOREVYLAotfTsKLQot
c3RhdGljIGVudW0KLWZzY2FjaGVfY2hlY2thdXggY2lmc19mc2NhY2hlX3N1cGVyX2NoZWNrX2F1
eCh2b2lkICpjb29raWVfbmV0ZnNfZGF0YSwKLQkJCQkJICAgICAgY29uc3Qgdm9pZCAqZGF0YSwK
LQkJCQkJICAgICAgdWludDE2X3QgZGF0YWxlbiwKLQkJCQkJICAgICAgbG9mZl90IG9iamVjdF9z
aXplKQotewotCXN0cnVjdCBjaWZzX2ZzY2FjaGVfc3VwZXJfYXV4ZGF0YSBhdXhkYXRhOwotCWNv
bnN0IHN0cnVjdCBjaWZzX3Rjb24gKnRjb24gPSBjb29raWVfbmV0ZnNfZGF0YTsKLQotCWlmIChk
YXRhbGVuICE9IHNpemVvZihhdXhkYXRhKSkKLQkJcmV0dXJuIEZTQ0FDSEVfQ0hFQ0tBVVhfT0JT
T0xFVEU7Ci0KLQltZW1zZXQoJmF1eGRhdGEsIDAsIHNpemVvZihhdXhkYXRhKSk7Ci0JYXV4ZGF0
YS5yZXNvdXJjZV9pZCA9IHRjb24tPnJlc291cmNlX2lkOwotCWF1eGRhdGEudm9sX2NyZWF0ZV90
aW1lID0gdGNvbi0+dm9sX2NyZWF0ZV90aW1lOwotCWF1eGRhdGEudm9sX3NlcmlhbF9udW1iZXIg
PSB0Y29uLT52b2xfc2VyaWFsX251bWJlcjsKLQotCWlmIChtZW1jbXAoZGF0YSwgJmF1eGRhdGEs
IGRhdGFsZW4pICE9IDApCi0JCXJldHVybiBGU0NBQ0hFX0NIRUNLQVVYX09CU09MRVRFOwotCi0J
cmV0dXJuIEZTQ0FDSEVfQ0hFQ0tBVVhfT0tBWTsKLX0KLQotLyoKLSAqIFN1cGVyYmxvY2sgb2Jq
ZWN0IGZvciBGUy1DYWNoZQotICovCi1jb25zdCBzdHJ1Y3QgZnNjYWNoZV9jb29raWVfZGVmIGNp
ZnNfZnNjYWNoZV9zdXBlcl9pbmRleF9kZWYgPSB7Ci0JLm5hbWUgPSAiQ0lGUy5zdXBlciIsCi0J
LnR5cGUgPSBGU0NBQ0hFX0NPT0tJRV9UWVBFX0lOREVYLAotCS5jaGVja19hdXggPSBjaWZzX2Zz
Y2FjaGVfc3VwZXJfY2hlY2tfYXV4LAotfTsKLQotc3RhdGljIGVudW0KLWZzY2FjaGVfY2hlY2th
dXggY2lmc19mc2NhY2hlX2lub2RlX2NoZWNrX2F1eCh2b2lkICpjb29raWVfbmV0ZnNfZGF0YSwK
LQkJCQkJICAgICAgY29uc3Qgdm9pZCAqZGF0YSwKLQkJCQkJICAgICAgdWludDE2X3QgZGF0YWxl
biwKLQkJCQkJICAgICAgbG9mZl90IG9iamVjdF9zaXplKQotewotCXN0cnVjdCBjaWZzX2ZzY2Fj
aGVfaW5vZGVfYXV4ZGF0YSBhdXhkYXRhOwotCXN0cnVjdCBjaWZzSW5vZGVJbmZvICpjaWZzaSA9
IGNvb2tpZV9uZXRmc19kYXRhOwotCi0JaWYgKGRhdGFsZW4gIT0gc2l6ZW9mKGF1eGRhdGEpKQot
CQlyZXR1cm4gRlNDQUNIRV9DSEVDS0FVWF9PQlNPTEVURTsKLQotCW1lbXNldCgmYXV4ZGF0YSwg
MCwgc2l6ZW9mKGF1eGRhdGEpKTsKLQlhdXhkYXRhLmVvZiA9IGNpZnNpLT5zZXJ2ZXJfZW9mOwot
CWF1eGRhdGEubGFzdF93cml0ZV90aW1lX3NlYyA9IGNpZnNpLT52ZnNfaW5vZGUuaV9tdGltZS50
dl9zZWM7Ci0JYXV4ZGF0YS5sYXN0X2NoYW5nZV90aW1lX3NlYyA9IGNpZnNpLT52ZnNfaW5vZGUu
aV9jdGltZS50dl9zZWM7Ci0JYXV4ZGF0YS5sYXN0X3dyaXRlX3RpbWVfbnNlYyA9IGNpZnNpLT52
ZnNfaW5vZGUuaV9tdGltZS50dl9uc2VjOwotCWF1eGRhdGEubGFzdF9jaGFuZ2VfdGltZV9uc2Vj
ID0gY2lmc2ktPnZmc19pbm9kZS5pX2N0aW1lLnR2X25zZWM7Ci0KLQlpZiAobWVtY21wKGRhdGEs
ICZhdXhkYXRhLCBkYXRhbGVuKSAhPSAwKQotCQlyZXR1cm4gRlNDQUNIRV9DSEVDS0FVWF9PQlNP
TEVURTsKLQotCXJldHVybiBGU0NBQ0hFX0NIRUNLQVVYX09LQVk7Ci19Ci0KLWNvbnN0IHN0cnVj
dCBmc2NhY2hlX2Nvb2tpZV9kZWYgY2lmc19mc2NhY2hlX2lub2RlX29iamVjdF9kZWYgPSB7Ci0J
Lm5hbWUJCT0gIkNJRlMudW5pcXVlaWQiLAotCS50eXBlCQk9IEZTQ0FDSEVfQ09PS0lFX1RZUEVf
REFUQUZJTEUsCi0JLmNoZWNrX2F1eAk9IGNpZnNfZnNjYWNoZV9pbm9kZV9jaGVja19hdXgsCi19
OwpkaWZmIC0tZ2l0IGEvZnMvY2lmcy9jaWZzZnMuYyBiL2ZzL2NpZnMvY2lmc2ZzLmMKaW5kZXgg
MzZiMmUwY2I5NzM2Li4xOTllZGFjMGNiNTkgMTAwNjQ0Ci0tLSBhL2ZzL2NpZnMvY2lmc2ZzLmMK
KysrIGIvZnMvY2lmcy9jaWZzZnMuYwpAQCAtMzk3LDYgKzM5Nyw5IEBAIHN0YXRpYyB2b2lkCiBj
aWZzX2V2aWN0X2lub2RlKHN0cnVjdCBpbm9kZSAqaW5vZGUpCiB7CiAJdHJ1bmNhdGVfaW5vZGVf
cGFnZXNfZmluYWwoJmlub2RlLT5pX2RhdGEpOworCWlmIChpbm9kZS0+aV9zdGF0ZSAmIElfUElO
TklOR19GU0NBQ0hFX1dCKQorCQljaWZzX2ZzY2FjaGVfdW51c2VfaW5vZGVfY29va2llKGlub2Rl
LCB0cnVlKTsKKwljaWZzX2ZzY2FjaGVfcmVsZWFzZV9pbm9kZV9jb29raWUoaW5vZGUpOwogCWNs
ZWFyX2lub2RlKGlub2RlKTsKIH0KIApAQCAtNzIxLDYgKzcyNCwxMiBAQCBzdGF0aWMgaW50IGNp
ZnNfc2hvd19zdGF0cyhzdHJ1Y3Qgc2VxX2ZpbGUgKnMsIHN0cnVjdCBkZW50cnkgKnJvb3QpCiB9
CiAjZW5kaWYKIAorc3RhdGljIGludCBjaWZzX3dyaXRlX2lub2RlKHN0cnVjdCBpbm9kZSAqaW5v
ZGUsIHN0cnVjdCB3cml0ZWJhY2tfY29udHJvbCAqd2JjKQoreworCWZzY2FjaGVfdW5waW5fd3Jp
dGViYWNrKHdiYywgY2lmc19pbm9kZV9jb29raWUoaW5vZGUpKTsKKwlyZXR1cm4gMDsKK30KKwog
c3RhdGljIGludCBjaWZzX2Ryb3BfaW5vZGUoc3RydWN0IGlub2RlICppbm9kZSkKIHsKIAlzdHJ1
Y3QgY2lmc19zYl9pbmZvICpjaWZzX3NiID0gQ0lGU19TQihpbm9kZS0+aV9zYik7CkBAIC03MzMs
NiArNzQyLDcgQEAgc3RhdGljIGludCBjaWZzX2Ryb3BfaW5vZGUoc3RydWN0IGlub2RlICppbm9k
ZSkKIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc3VwZXJfb3BlcmF0aW9ucyBjaWZzX3N1cGVyX29wcyA9
IHsKIAkuc3RhdGZzID0gY2lmc19zdGF0ZnMsCiAJLmFsbG9jX2lub2RlID0gY2lmc19hbGxvY19p
bm9kZSwKKwkud3JpdGVfaW5vZGUJPSBjaWZzX3dyaXRlX2lub2RlLAogCS5mcmVlX2lub2RlID0g
Y2lmc19mcmVlX2lub2RlLAogCS5kcm9wX2lub2RlCT0gY2lmc19kcm9wX2lub2RlLAogCS5ldmlj
dF9pbm9kZQk9IGNpZnNfZXZpY3RfaW5vZGUsCkBAIC0xNjI1LDEzICsxNjM1LDkgQEAgaW5pdF9j
aWZzKHZvaWQpCiAJCWdvdG8gb3V0X2Rlc3Ryb3lfY2lmc29wbG9ja2Rfd3E7CiAJfQogCi0JcmMg
PSBjaWZzX2ZzY2FjaGVfcmVnaXN0ZXIoKTsKLQlpZiAocmMpCi0JCWdvdG8gb3V0X2Rlc3Ryb3lf
ZGVmZXJyZWRjbG9zZV93cTsKLQogCXJjID0gY2lmc19pbml0X2lub2RlY2FjaGUoKTsKIAlpZiAo
cmMpCi0JCWdvdG8gb3V0X3VucmVnX2ZzY2FjaGU7CisJCWdvdG8gb3V0X2Rlc3Ryb3lfZGVmZXJy
ZWRjbG9zZV93cTsKIAogCXJjID0gY2lmc19pbml0X21pZHMoKTsKIAlpZiAocmMpCkBAIC0xNjkz
LDggKzE2OTksNiBAQCBpbml0X2NpZnModm9pZCkKIAljaWZzX2Rlc3Ryb3lfbWlkcygpOwogb3V0
X2Rlc3Ryb3lfaW5vZGVjYWNoZToKIAljaWZzX2Rlc3Ryb3lfaW5vZGVjYWNoZSgpOwotb3V0X3Vu
cmVnX2ZzY2FjaGU6Ci0JY2lmc19mc2NhY2hlX3VucmVnaXN0ZXIoKTsKIG91dF9kZXN0cm95X2Rl
ZmVycmVkY2xvc2Vfd3E6CiAJZGVzdHJveV93b3JrcXVldWUoZGVmZXJyZWRjbG9zZV93cSk7CiBv
dXRfZGVzdHJveV9jaWZzb3Bsb2NrZF93cToKQEAgLTE3MzAsNyArMTczNCw2IEBAIGV4aXRfY2lm
cyh2b2lkKQogCWNpZnNfZGVzdHJveV9yZXF1ZXN0X2J1ZnMoKTsKIAljaWZzX2Rlc3Ryb3lfbWlk
cygpOwogCWNpZnNfZGVzdHJveV9pbm9kZWNhY2hlKCk7Ci0JY2lmc19mc2NhY2hlX3VucmVnaXN0
ZXIoKTsKIAlkZXN0cm95X3dvcmtxdWV1ZShkZWZlcnJlZGNsb3NlX3dxKTsKIAlkZXN0cm95X3dv
cmtxdWV1ZShjaWZzb3Bsb2NrZF93cSk7CiAJZGVzdHJveV93b3JrcXVldWUoZGVjcnlwdF93cSk7
CmRpZmYgLS1naXQgYS9mcy9jaWZzL2NpZnNnbG9iLmggYi9mcy9jaWZzL2NpZnNnbG9iLmgKaW5k
ZXggY2FjZTA4MThkNTEwLi40OGIzNDNkMDM0MzAgMTAwNjQ0Ci0tLSBhL2ZzL2NpZnMvY2lmc2ds
b2IuaAorKysgYi9mcy9jaWZzL2NpZnNnbG9iLmgKQEAgLTY2OCw5ICs2NjgsNiBAQCBzdHJ1Y3Qg
VENQX1NlcnZlcl9JbmZvIHsKIAl1bnNpZ25lZCBpbnQgdG90YWxfcmVhZDsgLyogdG90YWwgYW1v
dW50IG9mIGRhdGEgcmVhZCBpbiB0aGlzIHBhc3MgKi8KIAlhdG9taWNfdCBpbl9zZW5kOyAvKiBy
ZXF1ZXN0cyB0cnlpbmcgdG8gc2VuZCAqLwogCWF0b21pY190IG51bV93YWl0ZXJzOyAgIC8qIGJs
b2NrZWQgd2FpdGluZyB0byBnZXQgaW4gc2VuZHJlY3YgKi8KLSNpZmRlZiBDT05GSUdfQ0lGU19G
U0NBQ0hFCi0Jc3RydWN0IGZzY2FjaGVfY29va2llICAgKmZzY2FjaGU7IC8qIGNsaWVudCBpbmRl
eCBjYWNoZSBjb29raWUgKi8KLSNlbmRpZgogI2lmZGVmIENPTkZJR19DSUZTX1NUQVRTMgogCWF0
b21pY190IG51bV9jbWRzW05VTUJFUl9PRl9TTUIyX0NPTU1BTkRTXTsgLyogdG90YWwgcmVxdWVz
dHMgYnkgY21kICovCiAJYXRvbWljX3Qgc21iMnNsb3djbWRbTlVNQkVSX09GX1NNQjJfQ09NTUFO
RFNdOyAvKiBjb3VudCByZXNwcyA+IDEgc2VjICovCkBAIC0xMTEyLDcgKzExMDksNyBAQCBzdHJ1
Y3QgY2lmc190Y29uIHsKIAlfX3UzMiBtYXhfYnl0ZXNfY29weTsKICNpZmRlZiBDT05GSUdfQ0lG
U19GU0NBQ0hFCiAJdTY0IHJlc291cmNlX2lkOwkJLyogc2VydmVyIHJlc291cmNlIGlkICovCi0J
c3RydWN0IGZzY2FjaGVfY29va2llICpmc2NhY2hlOwkvKiBjb29raWUgZm9yIHNoYXJlICovCisJ
c3RydWN0IGZzY2FjaGVfdm9sdW1lICpmc2NhY2hlOwkvKiBjb29raWUgZm9yIHNoYXJlICovCiAj
ZW5kaWYKIAlzdHJ1Y3QgbGlzdF9oZWFkIHBlbmRpbmdfb3BlbnM7CS8qIGxpc3Qgb2YgaW5jb21w
bGV0ZSBvcGVucyAqLwogCXN0cnVjdCBjYWNoZWRfZmlkIGNyZmlkOyAvKiBDYWNoZWQgcm9vdCBm
aWQgKi8KZGlmZiAtLWdpdCBhL2ZzL2NpZnMvY29ubmVjdC5jIGIvZnMvY2lmcy9jb25uZWN0LmMK
aW5kZXggNDUzYWJhM2MyYWQ2Li4xMWEyMmEzMGVlMTQgMTAwNjQ0Ci0tLSBhL2ZzL2NpZnMvY29u
bmVjdC5jCisrKyBiL2ZzL2NpZnMvY29ubmVjdC5jCkBAIC0xNDQ0LDEwICsxNDQ0LDYgQEAgY2lm
c19wdXRfdGNwX3Nlc3Npb24oc3RydWN0IFRDUF9TZXJ2ZXJfSW5mbyAqc2VydmVyLCBpbnQgZnJv
bV9yZWNvbm5lY3QpCiAKIAljaWZzX2NyeXB0b19zZWNtZWNoX3JlbGVhc2Uoc2VydmVyKTsKIAot
CS8qIGZzY2FjaGUgc2VydmVyIGNvb2tpZXMgYXJlIGJhc2VkIG9uIHByaW1hcnkgY2hhbm5lbCBv
bmx5ICovCi0JaWYgKCFDSUZTX1NFUlZFUl9JU19DSEFOKHNlcnZlcikpCi0JCWNpZnNfZnNjYWNo
ZV9yZWxlYXNlX2NsaWVudF9jb29raWUoc2VydmVyKTsKLQogCWtmcmVlKHNlcnZlci0+c2Vzc2lv
bl9rZXkucmVzcG9uc2UpOwogCXNlcnZlci0+c2Vzc2lvbl9rZXkucmVzcG9uc2UgPSBOVUxMOwog
CXNlcnZlci0+c2Vzc2lvbl9rZXkubGVuID0gMDsKQEAgLTE2MDksMTQgKzE2MDUsNiBAQCBjaWZz
X2dldF90Y3Bfc2Vzc2lvbihzdHJ1Y3Qgc21iM19mc19jb250ZXh0ICpjdHgsCiAJbGlzdF9hZGQo
JnRjcF9zZXMtPnRjcF9zZXNfbGlzdCwgJmNpZnNfdGNwX3Nlc19saXN0KTsKIAlzcGluX3VubG9j
aygmY2lmc190Y3Bfc2VzX2xvY2spOwogCi0JLyogZnNjYWNoZSBzZXJ2ZXIgY29va2llcyBhcmUg
YmFzZWQgb24gcHJpbWFyeSBjaGFubmVsIG9ubHkgKi8KLQlpZiAoIUNJRlNfU0VSVkVSX0lTX0NI
QU4odGNwX3NlcykpCi0JCWNpZnNfZnNjYWNoZV9nZXRfY2xpZW50X2Nvb2tpZSh0Y3Bfc2VzKTsK
LSNpZmRlZiBDT05GSUdfQ0lGU19GU0NBQ0hFCi0JZWxzZQotCQl0Y3Bfc2VzLT5mc2NhY2hlID0g
dGNwX3Nlcy0+cHJpbWFyeV9zZXJ2ZXItPmZzY2FjaGU7Ci0jZW5kaWYgLyogQ09ORklHX0NJRlNf
RlNDQUNIRSAqLwotCiAJLyogcXVldWUgZWNobyByZXF1ZXN0IGRlbGF5ZWQgd29yayAqLwogCXF1
ZXVlX2RlbGF5ZWRfd29yayhjaWZzaW9kX3dxLCAmdGNwX3Nlcy0+ZWNobywgdGNwX3Nlcy0+ZWNo
b19pbnRlcnZhbCk7CiAKQEAgLTMxMjgsNyArMzExNiw4IEBAIHN0YXRpYyBpbnQgbW91bnRfZ2V0
X2Nvbm5zKHN0cnVjdCBtb3VudF9jdHggKm1udF9jdHgpCiAJICogSW5zaWRlIGNpZnNfZnNjYWNo
ZV9nZXRfc3VwZXJfY29va2llIGl0IGNoZWNrcwogCSAqIHRoYXQgd2UgZG8gbm90IGdldCBzdXBl
ciBjb29raWUgdHdpY2UuCiAJICovCi0JY2lmc19mc2NhY2hlX2dldF9zdXBlcl9jb29raWUodGNv
bik7CisJaWYgKGNpZnNfc2ItPm1udF9jaWZzX2ZsYWdzICYgQ0lGU19NT1VOVF9GU0NBQ0hFKQor
CQljaWZzX2ZzY2FjaGVfZ2V0X3N1cGVyX2Nvb2tpZSh0Y29uKTsKIAogb3V0OgogCW1udF9jdHgt
PnNlcnZlciA9IHNlcnZlcjsKZGlmZiAtLWdpdCBhL2ZzL2NpZnMvZGlyLmMgYi9mcy9jaWZzL2Rp
ci5jCmluZGV4IDZlOGU3Y2MyNmFlMi4uY2U5YjIyYWVjZmJhIDEwMDY0NAotLS0gYS9mcy9jaWZz
L2Rpci5jCisrKyBiL2ZzL2NpZnMvZGlyLmMKQEAgLTIyLDYgKzIyLDcgQEAKICNpbmNsdWRlICJj
aWZzX3VuaWNvZGUuaCIKICNpbmNsdWRlICJmc19jb250ZXh0LmgiCiAjaW5jbHVkZSAiY2lmc19p
b2N0bC5oIgorI2luY2x1ZGUgImZzY2FjaGUuaCIKIAogc3RhdGljIHZvaWQKIHJlbmV3X3BhcmVu
dGFsX3RpbWVzdGFtcHMoc3RydWN0IGRlbnRyeSAqZGlyZW50cnkpCkBAIC01MDcsOCArNTA4LDEy
IEBAIGNpZnNfYXRvbWljX29wZW4oc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGRlbnRyeSAq
ZGlyZW50cnksCiAJCQlzZXJ2ZXItPm9wcy0+Y2xvc2UoeGlkLCB0Y29uLCAmZmlkKTsKIAkJY2lm
c19kZWxfcGVuZGluZ19vcGVuKCZvcGVuKTsKIAkJcmMgPSAtRU5PTUVNOworCQlnb3RvIG91dDsK
IAl9CiAKKwlmc2NhY2hlX3VzZV9jb29raWUoY2lmc19pbm9kZV9jb29raWUoZmlsZV9pbm9kZShm
aWxlKSksCisJCQkgICBmaWxlLT5mX21vZGUgJiBGTU9ERV9XUklURSk7CisKIG91dDoKIAljaWZz
X3B1dF90bGluayh0bGluayk7CiBvdXRfZnJlZV94aWQ6CmRpZmYgLS1naXQgYS9mcy9jaWZzL2Zp
bGUuYyBiL2ZzL2NpZnMvZmlsZS5jCmluZGV4IDlmZWUzYWY4M2E3My4uZmI3N2NhMWExNWQ4IDEw
MDY0NAotLS0gYS9mcy9jaWZzL2ZpbGUuYworKysgYi9mcy9jaWZzL2ZpbGUuYwpAQCAtMzc2LDgg
KzM3Niw2IEBAIHN0YXRpYyB2b2lkIGNpZnNGaWxlSW5mb19wdXRfZmluYWwoc3RydWN0IGNpZnNG
aWxlSW5mbyAqY2lmc19maWxlKQogCXN0cnVjdCBjaWZzTG9ja0luZm8gKmxpLCAqdG1wOwogCXN0
cnVjdCBzdXBlcl9ibG9jayAqc2IgPSBpbm9kZS0+aV9zYjsKIAotCWNpZnNfZnNjYWNoZV9yZWxl
YXNlX2lub2RlX2Nvb2tpZShpbm9kZSk7Ci0KIAkvKgogCSAqIERlbGV0ZSBhbnkgb3V0c3RhbmRp
bmcgbG9jayByZWNvcmRzLiBXZSdsbCBsb3NlIHRoZW0gd2hlbiB0aGUgZmlsZQogCSAqIGlzIGNs
b3NlZCBhbnl3YXkuCkBAIC01NzAsNyArNTY4LDcgQEAgaW50IGNpZnNfb3BlbihzdHJ1Y3QgaW5v
ZGUgKmlub2RlLCBzdHJ1Y3QgZmlsZSAqZmlsZSkKIAkJCXNwaW5fbG9jaygmQ0lGU19JKGlub2Rl
KS0+ZGVmZXJyZWRfbG9jayk7CiAJCQljaWZzX2RlbF9kZWZlcnJlZF9jbG9zZShjZmlsZSk7CiAJ
CQlzcGluX3VubG9jaygmQ0lGU19JKGlub2RlKS0+ZGVmZXJyZWRfbG9jayk7Ci0JCQlnb3RvIG91
dDsKKwkJCWdvdG8gdXNlX2NhY2hlOwogCQl9IGVsc2UgewogCQkJX2NpZnNGaWxlSW5mb19wdXQo
Y2ZpbGUsIHRydWUsIGZhbHNlKTsKIAkJfQpAQCAtNjMyLDggKzYzMCw2IEBAIGludCBjaWZzX29w
ZW4oc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGZpbGUgKmZpbGUpCiAJCWdvdG8gb3V0Owog
CX0KIAotCWNpZnNfZnNjYWNoZV9zZXRfaW5vZGVfY29va2llKGlub2RlLCBmaWxlKTsKLQogCWlm
ICgob3Bsb2NrICYgQ0lGU19DUkVBVEVfQUNUSU9OKSAmJiAhcG9zaXhfb3Blbl9vayAmJiB0Y29u
LT51bml4X2V4dCkgewogCQkvKgogCQkgKiBUaW1lIHRvIHNldCBtb2RlIHdoaWNoIHdlIGNhbiBu
b3Qgc2V0IGVhcmxpZXIgZHVlIHRvCkBAIC02NTIsNiArNjQ4LDE5IEBAIGludCBjaWZzX29wZW4o
c3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGZpbGUgKmZpbGUpCiAJCQkJICAgICAgIGNmaWxl
LT5waWQpOwogCX0KIAordXNlX2NhY2hlOgorCWZzY2FjaGVfdXNlX2Nvb2tpZShjaWZzX2lub2Rl
X2Nvb2tpZShmaWxlX2lub2RlKGZpbGUpKSwKKwkJCSAgIGZpbGUtPmZfbW9kZSAmIEZNT0RFX1dS
SVRFKTsKKwlpZiAoZmlsZS0+Zl9mbGFncyAmIE9fRElSRUNUICYmCisJICAgICghKChmaWxlLT5m
X2ZsYWdzICYgT19BQ0NNT0RFKSAhPSBPX1JET05MWSkgfHwKKwkgICAgIGZpbGUtPmZfZmxhZ3Mg
JiBPX0FQUEVORCkpIHsKKwkJc3RydWN0IGNpZnNfZnNjYWNoZV9pbm9kZV9jb2hlcmVuY3lfZGF0
YSBjZDsKKworCQljaWZzX2ZzY2FjaGVfZmlsbF9jb2hlcmVuY3koZmlsZV9pbm9kZShmaWxlKSwg
JmNkKTsKKwkJZnNjYWNoZV9pbnZhbGlkYXRlKGNpZnNfaW5vZGVfY29va2llKGZpbGVfaW5vZGUo
ZmlsZSkpLAorCQkJCSAgICZjZCwgaV9zaXplX3JlYWQoZmlsZV9pbm9kZShmaWxlKSksCisJCQkJ
ICAgRlNDQUNIRV9JTlZBTF9ESU9fV1JJVEUpOworCX0KIG91dDoKIAlmcmVlX2RlbnRyeV9wYXRo
KHBhZ2UpOwogCWZyZWVfeGlkKHhpZCk7CkBAIC04NzYsNiArODg1LDggQEAgaW50IGNpZnNfY2xv
c2Uoc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGZpbGUgKmZpbGUpCiAJc3RydWN0IGNpZnNf
c2JfaW5mbyAqY2lmc19zYiA9IENJRlNfU0IoaW5vZGUtPmlfc2IpOwogCXN0cnVjdCBjaWZzX2Rl
ZmVycmVkX2Nsb3NlICpkY2xvc2U7CiAKKwljaWZzX2ZzY2FjaGVfdW51c2VfaW5vZGVfY29va2ll
KGlub2RlLCBmaWxlLT5mX21vZGUgJiBGTU9ERV9XUklURSk7CisKIAlpZiAoZmlsZS0+cHJpdmF0
ZV9kYXRhICE9IE5VTEwpIHsKIAkJY2ZpbGUgPSBmaWxlLT5wcml2YXRlX2RhdGE7CiAJCWZpbGUt
PnByaXZhdGVfZGF0YSA9IE5VTEw7CkBAIC04ODYsNyArODk3LDYgQEAgaW50IGNpZnNfY2xvc2Uo
c3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGZpbGUgKmZpbGUpCiAJCSAgICBkY2xvc2UpIHsK
IAkJCWlmICh0ZXN0X2FuZF9jbGVhcl9iaXQoQ0lGU19JTk9fTU9ESUZJRURfQVRUUiwgJmNpbm9k
ZS0+ZmxhZ3MpKSB7CiAJCQkJaW5vZGUtPmlfY3RpbWUgPSBpbm9kZS0+aV9tdGltZSA9IGN1cnJl
bnRfdGltZShpbm9kZSk7Ci0JCQkJY2lmc19mc2NhY2hlX3VwZGF0ZV9pbm9kZV9jb29raWUoaW5v
ZGUpOwogCQkJfQogCQkJc3Bpbl9sb2NrKCZjaW5vZGUtPmRlZmVycmVkX2xvY2spOwogCQkJY2lm
c19hZGRfZGVmZXJyZWRfY2xvc2UoY2ZpbGUsIGRjbG9zZSk7CkBAIC00MTk4LDEwICs0MjA4LDEy
IEBAIHN0YXRpYyB2bV9mYXVsdF90CiBjaWZzX3BhZ2VfbWt3cml0ZShzdHJ1Y3Qgdm1fZmF1bHQg
KnZtZikKIHsKIAlzdHJ1Y3QgcGFnZSAqcGFnZSA9IHZtZi0+cGFnZTsKLQlzdHJ1Y3QgZmlsZSAq
ZmlsZSA9IHZtZi0+dm1hLT52bV9maWxlOwotCXN0cnVjdCBpbm9kZSAqaW5vZGUgPSBmaWxlX2lu
b2RlKGZpbGUpOwogCi0JY2lmc19mc2NhY2hlX3dhaXRfb25fcGFnZV93cml0ZShpbm9kZSwgcGFn
ZSk7CisjaWZkZWYgQ09ORklHX0NJRlNfRlNDQUNIRQorCWlmIChQYWdlRnNDYWNoZShwYWdlKSAm
JgorCSAgICB3YWl0X29uX3BhZ2VfZnNjYWNoZV9raWxsYWJsZShwYWdlKSA8IDApCisJCXJldHVy
biBWTV9GQVVMVF9SRVRSWTsKKyNlbmRpZgogCiAJbG9ja19wYWdlKHBhZ2UpOwogCXJldHVybiBW
TV9GQVVMVF9MT0NLRUQ7CkBAIC00Mjc1LDggKzQyODcsNiBAQCBjaWZzX3JlYWR2X2NvbXBsZXRl
KHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykKIAkJaWYgKHJkYXRhLT5yZXN1bHQgPT0gMCB8fAog
CQkgICAgKHJkYXRhLT5yZXN1bHQgPT0gLUVBR0FJTiAmJiBnb3RfYnl0ZXMpKQogCQkJY2lmc19y
ZWFkcGFnZV90b19mc2NhY2hlKHJkYXRhLT5tYXBwaW5nLT5ob3N0LCBwYWdlKTsKLQkJZWxzZQot
CQkJY2lmc19mc2NhY2hlX3VuY2FjaGVfcGFnZShyZGF0YS0+bWFwcGluZy0+aG9zdCwgcGFnZSk7
CiAKIAkJZ290X2J5dGVzIC09IG1pbl90KHVuc2lnbmVkIGludCwgUEFHRV9TSVpFLCBnb3RfYnl0
ZXMpOwogCkBAIC00NTkzLDExICs0NjAzLDYgQEAgc3RhdGljIGludCBjaWZzX3JlYWRwYWdlcyhz
dHJ1Y3QgZmlsZSAqZmlsZSwgc3RydWN0IGFkZHJlc3Nfc3BhY2UgKm1hcHBpbmcsCiAJCWtyZWZf
cHV0KCZyZGF0YS0+cmVmY291bnQsIGNpZnNfcmVhZGRhdGFfcmVsZWFzZSk7CiAJfQogCi0JLyog
QW55IHBhZ2VzIHRoYXQgaGF2ZSBiZWVuIHNob3duIHRvIGZzY2FjaGUgYnV0IGRpZG4ndCBnZXQg
YWRkZWQgdG8KLQkgKiB0aGUgcGFnZWNhY2hlIG11c3QgYmUgdW5jYWNoZWQgYmVmb3JlIHRoZXkg
Z2V0IHJldHVybmVkIHRvIHRoZQotCSAqIGFsbG9jYXRvci4KLQkgKi8KLQljaWZzX2ZzY2FjaGVf
cmVhZHBhZ2VzX2NhbmNlbChtYXBwaW5nLT5ob3N0LCBwYWdlX2xpc3QpOwogCWZyZWVfeGlkKHhp
ZCk7CiAJcmV0dXJuIHJjOwogfQpAQCAtNDgwMSwxNyArNDgwNiwxOSBAQCBzdGF0aWMgaW50IGNp
ZnNfcmVsZWFzZV9wYWdlKHN0cnVjdCBwYWdlICpwYWdlLCBnZnBfdCBnZnApCiB7CiAJaWYgKFBh
Z2VQcml2YXRlKHBhZ2UpKQogCQlyZXR1cm4gMDsKLQotCXJldHVybiBjaWZzX2ZzY2FjaGVfcmVs
ZWFzZV9wYWdlKHBhZ2UsIGdmcCk7CisJaWYgKFBhZ2VGc0NhY2hlKHBhZ2UpKSB7CisJCWlmIChj
dXJyZW50X2lzX2tzd2FwZCgpIHx8ICEoZ2ZwICYgX19HRlBfRlMpKQorCQkJcmV0dXJuIGZhbHNl
OworCQl3YWl0X29uX3BhZ2VfZnNjYWNoZShwYWdlKTsKKwl9CisJZnNjYWNoZV9ub3RlX3BhZ2Vf
cmVsZWFzZShjaWZzX2lub2RlX2Nvb2tpZShwYWdlLT5tYXBwaW5nLT5ob3N0KSk7CisJcmV0dXJu
IHRydWU7CiB9CiAKIHN0YXRpYyB2b2lkIGNpZnNfaW52YWxpZGF0ZV9wYWdlKHN0cnVjdCBwYWdl
ICpwYWdlLCB1bnNpZ25lZCBpbnQgb2Zmc2V0LAogCQkJCSB1bnNpZ25lZCBpbnQgbGVuZ3RoKQog
ewotCXN0cnVjdCBjaWZzSW5vZGVJbmZvICpjaWZzaSA9IENJRlNfSShwYWdlLT5tYXBwaW5nLT5o
b3N0KTsKLQotCWlmIChvZmZzZXQgPT0gMCAmJiBsZW5ndGggPT0gUEFHRV9TSVpFKQotCQljaWZz
X2ZzY2FjaGVfaW52YWxpZGF0ZV9wYWdlKHBhZ2UsICZjaWZzaS0+dmZzX2lub2RlKTsKKwl3YWl0
X29uX3BhZ2VfZnNjYWNoZShwYWdlKTsKIH0KIAogc3RhdGljIGludCBjaWZzX2xhdW5kZXJfcGFn
ZShzdHJ1Y3QgcGFnZSAqcGFnZSkKQEAgLTQ4MzEsNyArNDgzOCw3IEBAIHN0YXRpYyBpbnQgY2lm
c19sYXVuZGVyX3BhZ2Uoc3RydWN0IHBhZ2UgKnBhZ2UpCiAJaWYgKGNsZWFyX3BhZ2VfZGlydHlf
Zm9yX2lvKHBhZ2UpKQogCQlyYyA9IGNpZnNfd3JpdGVwYWdlX2xvY2tlZChwYWdlLCAmd2JjKTsK
IAotCWNpZnNfZnNjYWNoZV9pbnZhbGlkYXRlX3BhZ2UocGFnZSwgcGFnZS0+bWFwcGluZy0+aG9z
dCk7CisJd2FpdF9vbl9wYWdlX2ZzY2FjaGUocGFnZSk7CiAJcmV0dXJuIHJjOwogfQogCkBAIC00
OTg4LDYgKzQ5OTUsMTkgQEAgc3RhdGljIHZvaWQgY2lmc19zd2FwX2RlYWN0aXZhdGUoc3RydWN0
IGZpbGUgKmZpbGUpCiAJLyogZG8gd2UgbmVlZCB0byB1bnBpbiAob3IgdW5sb2NrKSB0aGUgZmls
ZSAqLwogfQogCisvKgorICogTWFyayBhIHBhZ2UgYXMgaGF2aW5nIGJlZW4gbWFkZSBkaXJ0eSBh
bmQgdGh1cyBuZWVkaW5nIHdyaXRlYmFjay4gIFdlIGFsc28KKyAqIG5lZWQgdG8gcGluIHRoZSBj
YWNoZSBvYmplY3QgdG8gd3JpdGUgYmFjayB0by4KKyAqLworI2lmZGVmIENPTkZJR19DSUZTX0ZT
Q0FDSEUKK3N0YXRpYyBpbnQgY2lmc19zZXRfcGFnZV9kaXJ0eShzdHJ1Y3QgcGFnZSAqcGFnZSkK
K3sKKwlyZXR1cm4gZnNjYWNoZV9zZXRfcGFnZV9kaXJ0eShwYWdlLCBjaWZzX2lub2RlX2Nvb2tp
ZShwYWdlLT5tYXBwaW5nLT5ob3N0KSk7Cit9CisjZWxzZQorI2RlZmluZSBjaWZzX3NldF9wYWdl
X2RpcnR5IF9fc2V0X3BhZ2VfZGlydHlfbm9idWZmZXJzCisjZW5kaWYKKwogY29uc3Qgc3RydWN0
IGFkZHJlc3Nfc3BhY2Vfb3BlcmF0aW9ucyBjaWZzX2FkZHJfb3BzID0gewogCS5yZWFkcGFnZSA9
IGNpZnNfcmVhZHBhZ2UsCiAJLnJlYWRwYWdlcyA9IGNpZnNfcmVhZHBhZ2VzLApAQCAtNDk5NSw3
ICs1MDE1LDcgQEAgY29uc3Qgc3RydWN0IGFkZHJlc3Nfc3BhY2Vfb3BlcmF0aW9ucyBjaWZzX2Fk
ZHJfb3BzID0gewogCS53cml0ZXBhZ2VzID0gY2lmc193cml0ZXBhZ2VzLAogCS53cml0ZV9iZWdp
biA9IGNpZnNfd3JpdGVfYmVnaW4sCiAJLndyaXRlX2VuZCA9IGNpZnNfd3JpdGVfZW5kLAotCS5z
ZXRfcGFnZV9kaXJ0eSA9IF9fc2V0X3BhZ2VfZGlydHlfbm9idWZmZXJzLAorCS5zZXRfcGFnZV9k
aXJ0eSA9IGNpZnNfc2V0X3BhZ2VfZGlydHksCiAJLnJlbGVhc2VwYWdlID0gY2lmc19yZWxlYXNl
X3BhZ2UsCiAJLmRpcmVjdF9JTyA9IGNpZnNfZGlyZWN0X2lvLAogCS5pbnZhbGlkYXRlcGFnZSA9
IGNpZnNfaW52YWxpZGF0ZV9wYWdlLApAQCAtNTAyMCw3ICs1MDQwLDcgQEAgY29uc3Qgc3RydWN0
IGFkZHJlc3Nfc3BhY2Vfb3BlcmF0aW9ucyBjaWZzX2FkZHJfb3BzX3NtYWxsYnVmID0gewogCS53
cml0ZXBhZ2VzID0gY2lmc193cml0ZXBhZ2VzLAogCS53cml0ZV9iZWdpbiA9IGNpZnNfd3JpdGVf
YmVnaW4sCiAJLndyaXRlX2VuZCA9IGNpZnNfd3JpdGVfZW5kLAotCS5zZXRfcGFnZV9kaXJ0eSA9
IF9fc2V0X3BhZ2VfZGlydHlfbm9idWZmZXJzLAorCS5zZXRfcGFnZV9kaXJ0eSA9IGNpZnNfc2V0
X3BhZ2VfZGlydHksCiAJLnJlbGVhc2VwYWdlID0gY2lmc19yZWxlYXNlX3BhZ2UsCiAJLmludmFs
aWRhdGVwYWdlID0gY2lmc19pbnZhbGlkYXRlX3BhZ2UsCiAJLmxhdW5kZXJfcGFnZSA9IGNpZnNf
bGF1bmRlcl9wYWdlLApkaWZmIC0tZ2l0IGEvZnMvY2lmcy9mc2NhY2hlLmMgYi9mcy9jaWZzL2Zz
Y2FjaGUuYwppbmRleCAwMDNjNWYxZjRkZmIuLmVmYWFjNGQ1ZmY1NSAxMDA2NDQKLS0tIGEvZnMv
Y2lmcy9mc2NhY2hlLmMKKysrIGIvZnMvY2lmcy9mc2NhY2hlLmMKQEAgLTEyLDI1MCArMTIsMTM2
IEBACiAjaW5jbHVkZSAiY2lmc19mc19zYi5oIgogI2luY2x1ZGUgImNpZnNwcm90by5oIgogCi0v
KgotICogS2V5IGxheW91dCBvZiBDSUZTIHNlcnZlciBjYWNoZSBpbmRleCBvYmplY3QKLSAqLwot
c3RydWN0IGNpZnNfc2VydmVyX2tleSB7Ci0JX191NjQgY29ubl9pZDsKLX0gX19wYWNrZWQ7Ci0K
LS8qCi0gKiBHZXQgYSBjb29raWUgZm9yIGEgc2VydmVyIG9iamVjdCBrZXllZCBieSB7SVBhZGRy
ZXNzLHBvcnQsZmFtaWx5fSB0dXBsZQotICovCi12b2lkIGNpZnNfZnNjYWNoZV9nZXRfY2xpZW50
X2Nvb2tpZShzdHJ1Y3QgVENQX1NlcnZlcl9JbmZvICpzZXJ2ZXIpCi17Ci0Jc3RydWN0IGNpZnNf
c2VydmVyX2tleSBrZXk7Ci0KLQkvKgotCSAqIENoZWNrIGlmIGNvb2tpZSB3YXMgYWxyZWFkeSBp
bml0aWFsaXplZCBzbyBkb24ndCByZWluaXRpYWxpemUgaXQuCi0JICogSW4gdGhlIGZ1dHVyZSwg
YXMgd2UgaW50ZWdyYXRlIHdpdGggbmV3ZXIgZnNjYWNoZSBmZWF0dXJlcywKLQkgKiB3ZSBtYXkg
d2FudCB0byBpbnN0ZWFkIGFkZCBhIGNoZWNrIGlmIGNvb2tpZSBoYXMgY2hhbmdlZAotCSAqLwot
CWlmIChzZXJ2ZXItPmZzY2FjaGUpCi0JCXJldHVybjsKLQotCW1lbXNldCgma2V5LCAwLCBzaXpl
b2Yoa2V5KSk7Ci0Ja2V5LmNvbm5faWQgPSBzZXJ2ZXItPmNvbm5faWQ7Ci0KLQlzZXJ2ZXItPmZz
Y2FjaGUgPQotCQlmc2NhY2hlX2FjcXVpcmVfY29va2llKGNpZnNfZnNjYWNoZV9uZXRmcy5wcmlt
YXJ5X2luZGV4LAotCQkJCSAgICAgICAmY2lmc19mc2NhY2hlX3NlcnZlcl9pbmRleF9kZWYsCi0J
CQkJICAgICAgICZrZXksIHNpemVvZihrZXkpLAotCQkJCSAgICAgICBOVUxMLCAwLAotCQkJCSAg
ICAgICBzZXJ2ZXIsIDAsIHRydWUpOwotCWNpZnNfZGJnKEZZSSwgIiVzOiAoMHglcC8weCVwKVxu
IiwKLQkJIF9fZnVuY19fLCBzZXJ2ZXIsIHNlcnZlci0+ZnNjYWNoZSk7Ci19Ci0KLXZvaWQgY2lm
c19mc2NhY2hlX3JlbGVhc2VfY2xpZW50X2Nvb2tpZShzdHJ1Y3QgVENQX1NlcnZlcl9JbmZvICpz
ZXJ2ZXIpCitzdGF0aWMgdm9pZCBjaWZzX2ZzY2FjaGVfZmlsbF92b2x1bWVfY29oZXJlbmN5KAor
CXN0cnVjdCBjaWZzX3Rjb24gKnRjb24sCisJc3RydWN0IGNpZnNfZnNjYWNoZV92b2x1bWVfY29o
ZXJlbmN5X2RhdGEgKmNkKQogewotCWNpZnNfZGJnKEZZSSwgIiVzOiAoMHglcC8weCVwKVxuIiwK
LQkJIF9fZnVuY19fLCBzZXJ2ZXIsIHNlcnZlci0+ZnNjYWNoZSk7Ci0JZnNjYWNoZV9yZWxpbnF1
aXNoX2Nvb2tpZShzZXJ2ZXItPmZzY2FjaGUsIE5VTEwsIGZhbHNlKTsKLQlzZXJ2ZXItPmZzY2Fj
aGUgPSBOVUxMOworCW1lbXNldChjZCwgMCwgc2l6ZW9mKCpjZCkpOworCWNkLT5yZXNvdXJjZV9p
ZAkJPSBjcHVfdG9fbGU2NCh0Y29uLT5yZXNvdXJjZV9pZCk7CisJY2QtPnZvbF9jcmVhdGVfdGlt
ZQk9IHRjb24tPnZvbF9jcmVhdGVfdGltZTsKKwljZC0+dm9sX3NlcmlhbF9udW1iZXIJPSBjcHVf
dG9fbGUzMih0Y29uLT52b2xfc2VyaWFsX251bWJlcik7CiB9CiAKLXZvaWQgY2lmc19mc2NhY2hl
X2dldF9zdXBlcl9jb29raWUoc3RydWN0IGNpZnNfdGNvbiAqdGNvbikKK2ludCBjaWZzX2ZzY2Fj
aGVfZ2V0X3N1cGVyX2Nvb2tpZShzdHJ1Y3QgY2lmc190Y29uICp0Y29uKQogeworCXN0cnVjdCBj
aWZzX2ZzY2FjaGVfdm9sdW1lX2NvaGVyZW5jeV9kYXRhIGNkOwogCXN0cnVjdCBUQ1BfU2VydmVy
X0luZm8gKnNlcnZlciA9IHRjb24tPnNlcy0+c2VydmVyOworCXN0cnVjdCBmc2NhY2hlX3ZvbHVt
ZSAqdmNvb2tpZTsKKwljb25zdCBzdHJ1Y3Qgc29ja2FkZHIgKnNhID0gKHN0cnVjdCBzb2NrYWRk
ciAqKSZzZXJ2ZXItPmRzdGFkZHI7CisJc2l6ZV90IHNsZW4sIGk7CiAJY2hhciAqc2hhcmVuYW1l
OwotCXN0cnVjdCBjaWZzX2ZzY2FjaGVfc3VwZXJfYXV4ZGF0YSBhdXhkYXRhOworCWNoYXIgKmtl
eTsKKwlpbnQgcmV0ID0gLUVOT01FTTsKIAotCS8qCi0JICogQ2hlY2sgaWYgY29va2llIHdhcyBh
bHJlYWR5IGluaXRpYWxpemVkIHNvIGRvbid0IHJlaW5pdGlhbGl6ZSBpdC4KLQkgKiBJbiB0aGUg
ZnV0dXJlLCBhcyB3ZSBpbnRlZ3JhdGUgd2l0aCBuZXdlciBmc2NhY2hlIGZlYXR1cmVzLAotCSAq
IHdlIG1heSB3YW50IHRvIGluc3RlYWQgYWRkIGEgY2hlY2sgaWYgY29va2llIGhhcyBjaGFuZ2Vk
Ci0JICovCi0JaWYgKHRjb24tPmZzY2FjaGUpCi0JCXJldHVybjsKKwl0Y29uLT5mc2NhY2hlID0g
TlVMTDsKKwlzd2l0Y2ggKHNhLT5zYV9mYW1pbHkpIHsKKwljYXNlIEFGX0lORVQ6CisJY2FzZSBB
Rl9JTkVUNjoKKwkJYnJlYWs7CisJZGVmYXVsdDoKKwkJY2lmc19kYmcoVkZTLCAiVW5rbm93biBu
ZXR3b3JrIGZhbWlseSAnJWQnXG4iLCBzYS0+c2FfZmFtaWx5KTsKKwkJcmV0dXJuIC1FSU5WQUw7
CisJfQorCisJbWVtc2V0KCZrZXksIDAsIHNpemVvZihrZXkpKTsKIAogCXNoYXJlbmFtZSA9IGV4
dHJhY3Rfc2hhcmVuYW1lKHRjb24tPnRyZWVOYW1lKTsKIAlpZiAoSVNfRVJSKHNoYXJlbmFtZSkp
IHsKIAkJY2lmc19kYmcoRllJLCAiJXM6IGNvdWxkbid0IGV4dHJhY3Qgc2hhcmVuYW1lXG4iLCBf
X2Z1bmNfXyk7Ci0JCXRjb24tPmZzY2FjaGUgPSBOVUxMOwotCQlyZXR1cm47CisJCXJldHVybiAt
RUlOVkFMOwogCX0KIAotCW1lbXNldCgmYXV4ZGF0YSwgMCwgc2l6ZW9mKGF1eGRhdGEpKTsKLQlh
dXhkYXRhLnJlc291cmNlX2lkID0gdGNvbi0+cmVzb3VyY2VfaWQ7Ci0JYXV4ZGF0YS52b2xfY3Jl
YXRlX3RpbWUgPSB0Y29uLT52b2xfY3JlYXRlX3RpbWU7Ci0JYXV4ZGF0YS52b2xfc2VyaWFsX251
bWJlciA9IHRjb24tPnZvbF9zZXJpYWxfbnVtYmVyOworCXNsZW4gPSBzdHJsZW4oc2hhcmVuYW1l
KTsKKwlmb3IgKGkgPSAwOyBpIDwgc2xlbjsgaSsrKQorCQlpZiAoc2hhcmVuYW1lW2ldID09ICcv
JykKKwkJCXNoYXJlbmFtZVtpXSA9ICc7JzsKKworCWtleSA9IGthc3ByaW50ZihHRlBfS0VSTkVM
LCAiY2lmcywlcElTcGMsJXMiLCBzYSwgc2hhcmVuYW1lKTsKKwlpZiAoIWtleSkKKwkJZ290byBv
dXQ7CisKKwljaWZzX2ZzY2FjaGVfZmlsbF92b2x1bWVfY29oZXJlbmN5KHRjb24sICZjZCk7CisJ
dmNvb2tpZSA9IGZzY2FjaGVfYWNxdWlyZV92b2x1bWUoa2V5LAorCQkJCQkgTlVMTCwgLyogcHJl
ZmVycmVkX2NhY2hlICovCisJCQkJCSAmY2QsIHNpemVvZihjZCkpOworCWNpZnNfZGJnKEZZSSwg
IiVzOiAoJXMvMHglcClcbiIsIF9fZnVuY19fLCBrZXksIHZjb29raWUpOworCWlmIChJU19FUlIo
dmNvb2tpZSkpIHsKKwkJaWYgKHZjb29raWUgIT0gRVJSX1BUUigtRUJVU1kpKSB7CisJCQlyZXQg
PSBQVFJfRVJSKHZjb29raWUpOworCQkJZ290byBvdXRfMjsKKwkJfQorCQlwcl9lcnIoIkNhY2hl
IHZvbHVtZSBrZXkgYWxyZWFkeSBpbiB1c2UgKCVzKVxuIiwga2V5KTsKKwkJdmNvb2tpZSA9IE5V
TEw7CisJfQogCi0JdGNvbi0+ZnNjYWNoZSA9Ci0JCWZzY2FjaGVfYWNxdWlyZV9jb29raWUoc2Vy
dmVyLT5mc2NhY2hlLAotCQkJCSAgICAgICAmY2lmc19mc2NhY2hlX3N1cGVyX2luZGV4X2RlZiwK
LQkJCQkgICAgICAgc2hhcmVuYW1lLCBzdHJsZW4oc2hhcmVuYW1lKSwKLQkJCQkgICAgICAgJmF1
eGRhdGEsIHNpemVvZihhdXhkYXRhKSwKLQkJCQkgICAgICAgdGNvbiwgMCwgdHJ1ZSk7CisJdGNv
bi0+ZnNjYWNoZSA9IHZjb29raWU7CisJcmV0ID0gMDsKK291dF8yOgorCWtmcmVlKGtleSk7Citv
dXQ6CiAJa2ZyZWUoc2hhcmVuYW1lKTsKLQljaWZzX2RiZyhGWUksICIlczogKDB4JXAvMHglcClc
biIsCi0JCSBfX2Z1bmNfXywgc2VydmVyLT5mc2NhY2hlLCB0Y29uLT5mc2NhY2hlKTsKKwlyZXR1
cm4gcmV0OwogfQogCiB2b2lkIGNpZnNfZnNjYWNoZV9yZWxlYXNlX3N1cGVyX2Nvb2tpZShzdHJ1
Y3QgY2lmc190Y29uICp0Y29uKQogewotCXN0cnVjdCBjaWZzX2ZzY2FjaGVfc3VwZXJfYXV4ZGF0
YSBhdXhkYXRhOwotCi0JbWVtc2V0KCZhdXhkYXRhLCAwLCBzaXplb2YoYXV4ZGF0YSkpOwotCWF1
eGRhdGEucmVzb3VyY2VfaWQgPSB0Y29uLT5yZXNvdXJjZV9pZDsKLQlhdXhkYXRhLnZvbF9jcmVh
dGVfdGltZSA9IHRjb24tPnZvbF9jcmVhdGVfdGltZTsKLQlhdXhkYXRhLnZvbF9zZXJpYWxfbnVt
YmVyID0gdGNvbi0+dm9sX3NlcmlhbF9udW1iZXI7CisJc3RydWN0IGNpZnNfZnNjYWNoZV92b2x1
bWVfY29oZXJlbmN5X2RhdGEgY2Q7CiAKIAljaWZzX2RiZyhGWUksICIlczogKDB4JXApXG4iLCBf
X2Z1bmNfXywgdGNvbi0+ZnNjYWNoZSk7Ci0JZnNjYWNoZV9yZWxpbnF1aXNoX2Nvb2tpZSh0Y29u
LT5mc2NhY2hlLCAmYXV4ZGF0YSwgZmFsc2UpOwotCXRjb24tPmZzY2FjaGUgPSBOVUxMOwotfQot
Ci1zdGF0aWMgdm9pZCBjaWZzX2ZzY2FjaGVfYWNxdWlyZV9pbm9kZV9jb29raWUoc3RydWN0IGNp
ZnNJbm9kZUluZm8gKmNpZnNpLAotCQkJCQkgICAgICBzdHJ1Y3QgY2lmc190Y29uICp0Y29uKQot
ewotCXN0cnVjdCBjaWZzX2ZzY2FjaGVfaW5vZGVfYXV4ZGF0YSBhdXhkYXRhOwogCi0JbWVtc2V0
KCZhdXhkYXRhLCAwLCBzaXplb2YoYXV4ZGF0YSkpOwotCWF1eGRhdGEuZW9mID0gY2lmc2ktPnNl
cnZlcl9lb2Y7Ci0JYXV4ZGF0YS5sYXN0X3dyaXRlX3RpbWVfc2VjID0gY2lmc2ktPnZmc19pbm9k
ZS5pX210aW1lLnR2X3NlYzsKLQlhdXhkYXRhLmxhc3RfY2hhbmdlX3RpbWVfc2VjID0gY2lmc2kt
PnZmc19pbm9kZS5pX2N0aW1lLnR2X3NlYzsKLQlhdXhkYXRhLmxhc3Rfd3JpdGVfdGltZV9uc2Vj
ID0gY2lmc2ktPnZmc19pbm9kZS5pX210aW1lLnR2X25zZWM7Ci0JYXV4ZGF0YS5sYXN0X2NoYW5n
ZV90aW1lX25zZWMgPSBjaWZzaS0+dmZzX2lub2RlLmlfY3RpbWUudHZfbnNlYzsKLQotCWNpZnNp
LT5mc2NhY2hlID0KLQkJZnNjYWNoZV9hY3F1aXJlX2Nvb2tpZSh0Y29uLT5mc2NhY2hlLAotCQkJ
CSAgICAgICAmY2lmc19mc2NhY2hlX2lub2RlX29iamVjdF9kZWYsCi0JCQkJICAgICAgICZjaWZz
aS0+dW5pcXVlaWQsIHNpemVvZihjaWZzaS0+dW5pcXVlaWQpLAotCQkJCSAgICAgICAmYXV4ZGF0
YSwgc2l6ZW9mKGF1eGRhdGEpLAotCQkJCSAgICAgICBjaWZzaSwgY2lmc2ktPnZmc19pbm9kZS5p
X3NpemUsIHRydWUpOworCWNpZnNfZnNjYWNoZV9maWxsX3ZvbHVtZV9jb2hlcmVuY3kodGNvbiwg
JmNkKTsKKwlmc2NhY2hlX3JlbGlucXVpc2hfdm9sdW1lKHRjb24tPmZzY2FjaGUsICZjZCwgZmFs
c2UpOworCXRjb24tPmZzY2FjaGUgPSBOVUxMOwogfQogCi1zdGF0aWMgdm9pZCBjaWZzX2ZzY2Fj
aGVfZW5hYmxlX2lub2RlX2Nvb2tpZShzdHJ1Y3QgaW5vZGUgKmlub2RlKQordm9pZCBjaWZzX2Zz
Y2FjaGVfZ2V0X2lub2RlX2Nvb2tpZShzdHJ1Y3QgaW5vZGUgKmlub2RlKQogeworCXN0cnVjdCBj
aWZzX2ZzY2FjaGVfaW5vZGVfY29oZXJlbmN5X2RhdGEgY2Q7CiAJc3RydWN0IGNpZnNJbm9kZUlu
Zm8gKmNpZnNpID0gQ0lGU19JKGlub2RlKTsKIAlzdHJ1Y3QgY2lmc19zYl9pbmZvICpjaWZzX3Ni
ID0gQ0lGU19TQihpbm9kZS0+aV9zYik7CiAJc3RydWN0IGNpZnNfdGNvbiAqdGNvbiA9IGNpZnNf
c2JfbWFzdGVyX3Rjb24oY2lmc19zYik7CiAKLQlpZiAoY2lmc2ktPmZzY2FjaGUpCi0JCXJldHVy
bjsKLQotCWlmICghKGNpZnNfc2ItPm1udF9jaWZzX2ZsYWdzICYgQ0lGU19NT1VOVF9GU0NBQ0hF
KSkKLQkJcmV0dXJuOwotCi0JY2lmc19mc2NhY2hlX2FjcXVpcmVfaW5vZGVfY29va2llKGNpZnNp
LCB0Y29uKTsKKwljaWZzX2ZzY2FjaGVfZmlsbF9jb2hlcmVuY3koJmNpZnNpLT52ZnNfaW5vZGUs
ICZjZCk7CiAKLQljaWZzX2RiZyhGWUksICIlczogZ290IEZIIGNvb2tpZSAoMHglcC8weCVwKVxu
IiwKLQkJIF9fZnVuY19fLCB0Y29uLT5mc2NhY2hlLCBjaWZzaS0+ZnNjYWNoZSk7CisJY2lmc2kt
PmZzY2FjaGUgPQorCQlmc2NhY2hlX2FjcXVpcmVfY29va2llKHRjb24tPmZzY2FjaGUsIDAsCisJ
CQkJICAgICAgICZjaWZzaS0+dW5pcXVlaWQsIHNpemVvZihjaWZzaS0+dW5pcXVlaWQpLAorCQkJ
CSAgICAgICAmY2QsIHNpemVvZihjZCksCisJCQkJICAgICAgIGlfc2l6ZV9yZWFkKCZjaWZzaS0+
dmZzX2lub2RlKSk7CiB9CiAKLXZvaWQgY2lmc19mc2NhY2hlX3JlbGVhc2VfaW5vZGVfY29va2ll
KHN0cnVjdCBpbm9kZSAqaW5vZGUpCit2b2lkIGNpZnNfZnNjYWNoZV91bnVzZV9pbm9kZV9jb29r
aWUoc3RydWN0IGlub2RlICppbm9kZSwgYm9vbCB1cGRhdGUpCiB7Ci0Jc3RydWN0IGNpZnNfZnNj
YWNoZV9pbm9kZV9hdXhkYXRhIGF1eGRhdGE7Ci0Jc3RydWN0IGNpZnNJbm9kZUluZm8gKmNpZnNp
ID0gQ0lGU19JKGlub2RlKTsKLQotCWlmIChjaWZzaS0+ZnNjYWNoZSkgewotCQltZW1zZXQoJmF1
eGRhdGEsIDAsIHNpemVvZihhdXhkYXRhKSk7Ci0JCWF1eGRhdGEuZW9mID0gY2lmc2ktPnNlcnZl
cl9lb2Y7Ci0JCWF1eGRhdGEubGFzdF93cml0ZV90aW1lX3NlYyA9IGNpZnNpLT52ZnNfaW5vZGUu
aV9tdGltZS50dl9zZWM7Ci0JCWF1eGRhdGEubGFzdF9jaGFuZ2VfdGltZV9zZWMgPSBjaWZzaS0+
dmZzX2lub2RlLmlfY3RpbWUudHZfc2VjOwotCQlhdXhkYXRhLmxhc3Rfd3JpdGVfdGltZV9uc2Vj
ID0gY2lmc2ktPnZmc19pbm9kZS5pX210aW1lLnR2X25zZWM7Ci0JCWF1eGRhdGEubGFzdF9jaGFu
Z2VfdGltZV9uc2VjID0gY2lmc2ktPnZmc19pbm9kZS5pX2N0aW1lLnR2X25zZWM7CisJaWYgKHVw
ZGF0ZSkgeworCQlzdHJ1Y3QgY2lmc19mc2NhY2hlX2lub2RlX2NvaGVyZW5jeV9kYXRhIGNkOwor
CQlsb2ZmX3QgaV9zaXplID0gaV9zaXplX3JlYWQoaW5vZGUpOwogCi0JCWNpZnNfZGJnKEZZSSwg
IiVzOiAoMHglcClcbiIsIF9fZnVuY19fLCBjaWZzaS0+ZnNjYWNoZSk7Ci0JCS8qIGZzY2FjaGVf
cmVsaW5xdWlzaF9jb29raWUgZG9lcyBub3Qgc2VlbSB0byB1cGRhdGUgYXV4ZGF0YSAqLwotCQlm
c2NhY2hlX3VwZGF0ZV9jb29raWUoY2lmc2ktPmZzY2FjaGUsICZhdXhkYXRhKTsKLQkJZnNjYWNo
ZV9yZWxpbnF1aXNoX2Nvb2tpZShjaWZzaS0+ZnNjYWNoZSwgJmF1eGRhdGEsIGZhbHNlKTsKLQkJ
Y2lmc2ktPmZzY2FjaGUgPSBOVUxMOworCQljaWZzX2ZzY2FjaGVfZmlsbF9jb2hlcmVuY3koaW5v
ZGUsICZjZCk7CisJCWZzY2FjaGVfdW51c2VfY29va2llKGNpZnNfaW5vZGVfY29va2llKGlub2Rl
KSwgJmNkLCAmaV9zaXplKTsKKwl9IGVsc2UgeworCQlmc2NhY2hlX3VudXNlX2Nvb2tpZShjaWZz
X2lub2RlX2Nvb2tpZShpbm9kZSksIE5VTEwsIE5VTEwpOwogCX0KIH0KIAotdm9pZCBjaWZzX2Zz
Y2FjaGVfdXBkYXRlX2lub2RlX2Nvb2tpZShzdHJ1Y3QgaW5vZGUgKmlub2RlKQordm9pZCBjaWZz
X2ZzY2FjaGVfcmVsZWFzZV9pbm9kZV9jb29raWUoc3RydWN0IGlub2RlICppbm9kZSkKIHsKLQlz
dHJ1Y3QgY2lmc19mc2NhY2hlX2lub2RlX2F1eGRhdGEgYXV4ZGF0YTsKIAlzdHJ1Y3QgY2lmc0lu
b2RlSW5mbyAqY2lmc2kgPSBDSUZTX0koaW5vZGUpOwogCiAJaWYgKGNpZnNpLT5mc2NhY2hlKSB7
Ci0JCW1lbXNldCgmYXV4ZGF0YSwgMCwgc2l6ZW9mKGF1eGRhdGEpKTsKLQkJYXV4ZGF0YS5lb2Yg
PSBjaWZzaS0+c2VydmVyX2VvZjsKLQkJYXV4ZGF0YS5sYXN0X3dyaXRlX3RpbWVfc2VjID0gY2lm
c2ktPnZmc19pbm9kZS5pX210aW1lLnR2X3NlYzsKLQkJYXV4ZGF0YS5sYXN0X2NoYW5nZV90aW1l
X3NlYyA9IGNpZnNpLT52ZnNfaW5vZGUuaV9jdGltZS50dl9zZWM7Ci0JCWF1eGRhdGEubGFzdF93
cml0ZV90aW1lX25zZWMgPSBjaWZzaS0+dmZzX2lub2RlLmlfbXRpbWUudHZfbnNlYzsKLQkJYXV4
ZGF0YS5sYXN0X2NoYW5nZV90aW1lX25zZWMgPSBjaWZzaS0+dmZzX2lub2RlLmlfY3RpbWUudHZf
bnNlYzsKLQogCQljaWZzX2RiZyhGWUksICIlczogKDB4JXApXG4iLCBfX2Z1bmNfXywgY2lmc2kt
PmZzY2FjaGUpOwotCQlmc2NhY2hlX3VwZGF0ZV9jb29raWUoY2lmc2ktPmZzY2FjaGUsICZhdXhk
YXRhKTsKLQl9Ci19Ci0KLXZvaWQgY2lmc19mc2NhY2hlX3NldF9pbm9kZV9jb29raWUoc3RydWN0
IGlub2RlICppbm9kZSwgc3RydWN0IGZpbGUgKmZpbHApCi17Ci0JY2lmc19mc2NhY2hlX2VuYWJs
ZV9pbm9kZV9jb29raWUoaW5vZGUpOwotfQotCi12b2lkIGNpZnNfZnNjYWNoZV9yZXNldF9pbm9k
ZV9jb29raWUoc3RydWN0IGlub2RlICppbm9kZSkKLXsKLQlzdHJ1Y3QgY2lmc0lub2RlSW5mbyAq
Y2lmc2kgPSBDSUZTX0koaW5vZGUpOwotCXN0cnVjdCBjaWZzX3NiX2luZm8gKmNpZnNfc2IgPSBD
SUZTX1NCKGlub2RlLT5pX3NiKTsKLQlzdHJ1Y3QgY2lmc190Y29uICp0Y29uID0gY2lmc19zYl9t
YXN0ZXJfdGNvbihjaWZzX3NiKTsKLQlzdHJ1Y3QgZnNjYWNoZV9jb29raWUgKm9sZCA9IGNpZnNp
LT5mc2NhY2hlOwotCi0JaWYgKGNpZnNpLT5mc2NhY2hlKSB7Ci0JCS8qIHJldGlyZSB0aGUgY3Vy
cmVudCBmc2NhY2hlIGNhY2hlIGFuZCBnZXQgYSBuZXcgb25lICovCi0JCWZzY2FjaGVfcmVsaW5x
dWlzaF9jb29raWUoY2lmc2ktPmZzY2FjaGUsIE5VTEwsIHRydWUpOwotCi0JCWNpZnNfZnNjYWNo
ZV9hY3F1aXJlX2lub2RlX2Nvb2tpZShjaWZzaSwgdGNvbik7Ci0JCWNpZnNfZGJnKEZZSSwgIiVz
OiBuZXcgY29va2llIDB4JXAgb2xkY29va2llIDB4JXBcbiIsCi0JCQkgX19mdW5jX18sIGNpZnNp
LT5mc2NhY2hlLCBvbGQpOworCQlmc2NhY2hlX3JlbGlucXVpc2hfY29va2llKGNpZnNpLT5mc2Nh
Y2hlLCBmYWxzZSk7CisJCWNpZnNpLT5mc2NhY2hlID0gTlVMTDsKIAl9CiB9CiAKLWludCBjaWZz
X2ZzY2FjaGVfcmVsZWFzZV9wYWdlKHN0cnVjdCBwYWdlICpwYWdlLCBnZnBfdCBnZnApCi17Ci0J
aWYgKFBhZ2VGc0NhY2hlKHBhZ2UpKSB7Ci0JCXN0cnVjdCBpbm9kZSAqaW5vZGUgPSBwYWdlLT5t
YXBwaW5nLT5ob3N0OwotCQlzdHJ1Y3QgY2lmc0lub2RlSW5mbyAqY2lmc2kgPSBDSUZTX0koaW5v
ZGUpOwotCi0JCWNpZnNfZGJnKEZZSSwgIiVzOiAoMHglcC8weCVwKVxuIiwKLQkJCSBfX2Z1bmNf
XywgcGFnZSwgY2lmc2ktPmZzY2FjaGUpOwotCQlpZiAoIWZzY2FjaGVfbWF5YmVfcmVsZWFzZV9w
YWdlKGNpZnNpLT5mc2NhY2hlLCBwYWdlLCBnZnApKQotCQkJcmV0dXJuIDA7Ci0JfQotCi0JcmV0
dXJuIDE7Ci19Ci0KLXN0YXRpYyB2b2lkIGNpZnNfcmVhZHBhZ2VfZnJvbV9mc2NhY2hlX2NvbXBs
ZXRlKHN0cnVjdCBwYWdlICpwYWdlLCB2b2lkICpjdHgsCi0JCQkJCQlpbnQgZXJyb3IpCi17Ci0J
Y2lmc19kYmcoRllJLCAiJXM6ICgweCVwLyVkKVxuIiwgX19mdW5jX18sIHBhZ2UsIGVycm9yKTsK
LQlpZiAoIWVycm9yKQotCQlTZXRQYWdlVXB0b2RhdGUocGFnZSk7Ci0JdW5sb2NrX3BhZ2UocGFn
ZSk7Ci19Ci0KIC8qCiAgKiBSZXRyaWV2ZSBhIHBhZ2UgZnJvbSBGUy1DYWNoZQogICovCiBpbnQg
X19jaWZzX3JlYWRwYWdlX2Zyb21fZnNjYWNoZShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3Qg
cGFnZSAqcGFnZSkKIHsKLQlpbnQgcmV0OwotCiAJY2lmc19kYmcoRllJLCAiJXM6IChmc2M6JXAs
IHA6JXAsIGk6MHglcFxuIiwKIAkJIF9fZnVuY19fLCBDSUZTX0koaW5vZGUpLT5mc2NhY2hlLCBw
YWdlLCBpbm9kZSk7Ci0JcmV0ID0gZnNjYWNoZV9yZWFkX29yX2FsbG9jX3BhZ2UoQ0lGU19JKGlu
b2RlKS0+ZnNjYWNoZSwgcGFnZSwKLQkJCQkJIGNpZnNfcmVhZHBhZ2VfZnJvbV9mc2NhY2hlX2Nv
bXBsZXRlLAotCQkJCQkgTlVMTCwKLQkJCQkJIEdGUF9LRVJORUwpOwotCXN3aXRjaCAocmV0KSB7
Ci0KLQljYXNlIDA6IC8qIHBhZ2UgZm91bmQgaW4gZnNjYWNoZSwgcmVhZCBzdWJtaXR0ZWQgKi8K
LQkJY2lmc19kYmcoRllJLCAiJXM6IHN1Ym1pdHRlZFxuIiwgX19mdW5jX18pOwotCQlyZXR1cm4g
cmV0OwotCWNhc2UgLUVOT0JVRlM6CS8qIHBhZ2Ugd29uJ3QgYmUgY2FjaGVkICovCi0JY2FzZSAt
RU5PREFUQToJLyogcGFnZSBub3QgaW4gY2FjaGUgKi8KLQkJY2lmc19kYmcoRllJLCAiJXM6ICVk
XG4iLCBfX2Z1bmNfXywgcmV0KTsKLQkJcmV0dXJuIDE7Ci0KLQlkZWZhdWx0OgotCQljaWZzX2Ri
ZyhWRlMsICJ1bmtub3duIGVycm9yIHJldCA9ICVkXG4iLCByZXQpOwotCX0KLQlyZXR1cm4gcmV0
OworCXJldHVybiAtRU5PQlVGUzsgLy8gTmVlZHMgY29udmVyc2lvbiB0byB1c2luZyBuZXRmc2xp
YgogfQogCiAvKgpAQCAtMjY2LDc4ICsxNTIsMTkgQEAgaW50IF9fY2lmc19yZWFkcGFnZXNfZnJv
bV9mc2NhY2hlKHN0cnVjdCBpbm9kZSAqaW5vZGUsCiAJCQkJc3RydWN0IGxpc3RfaGVhZCAqcGFn
ZXMsCiAJCQkJdW5zaWduZWQgKm5yX3BhZ2VzKQogewotCWludCByZXQ7Ci0KIAljaWZzX2RiZyhG
WUksICIlczogKDB4JXAvJXUvMHglcClcbiIsCiAJCSBfX2Z1bmNfXywgQ0lGU19JKGlub2RlKS0+
ZnNjYWNoZSwgKm5yX3BhZ2VzLCBpbm9kZSk7Ci0JcmV0ID0gZnNjYWNoZV9yZWFkX29yX2FsbG9j
X3BhZ2VzKENJRlNfSShpbm9kZSktPmZzY2FjaGUsIG1hcHBpbmcsCi0JCQkJCSAgcGFnZXMsIG5y
X3BhZ2VzLAotCQkJCQkgIGNpZnNfcmVhZHBhZ2VfZnJvbV9mc2NhY2hlX2NvbXBsZXRlLAotCQkJ
CQkgIE5VTEwsCi0JCQkJCSAgbWFwcGluZ19nZnBfbWFzayhtYXBwaW5nKSk7Ci0Jc3dpdGNoIChy
ZXQpIHsKLQljYXNlIDA6CS8qIHJlYWQgc3VibWl0dGVkIHRvIHRoZSBjYWNoZSBmb3IgYWxsIHBh
Z2VzICovCi0JCWNpZnNfZGJnKEZZSSwgIiVzOiBzdWJtaXR0ZWRcbiIsIF9fZnVuY19fKTsKLQkJ
cmV0dXJuIHJldDsKLQotCWNhc2UgLUVOT0JVRlM6CS8qIHNvbWUgcGFnZXMgYXJlIG5vdCBjYWNo
ZWQgYW5kIGNhbid0IGJlICovCi0JY2FzZSAtRU5PREFUQToJLyogc29tZSBwYWdlcyBhcmUgbm90
IGNhY2hlZCAqLwotCQljaWZzX2RiZyhGWUksICIlczogbm8gcGFnZVxuIiwgX19mdW5jX18pOwot
CQlyZXR1cm4gMTsKLQotCWRlZmF1bHQ6Ci0JCWNpZnNfZGJnKEZZSSwgInVua25vd24gZXJyb3Ig
cmV0ID0gJWRcbiIsIHJldCk7Ci0JfQotCi0JcmV0dXJuIHJldDsKKwlyZXR1cm4gLUVOT0JVRlM7
IC8vIE5lZWRzIGNvbnZlcnNpb24gdG8gdXNpbmcgbmV0ZnNsaWIKIH0KIAogdm9pZCBfX2NpZnNf
cmVhZHBhZ2VfdG9fZnNjYWNoZShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgcGFnZSAqcGFn
ZSkKIHsKIAlzdHJ1Y3QgY2lmc0lub2RlSW5mbyAqY2lmc2kgPSBDSUZTX0koaW5vZGUpOwotCWlu
dCByZXQ7CiAKIAlXQVJOX09OKCFjaWZzaS0+ZnNjYWNoZSk7CiAKIAljaWZzX2RiZyhGWUksICIl
czogKGZzYzogJXAsIHA6ICVwLCBpOiAlcClcbiIsCiAJCSBfX2Z1bmNfXywgY2lmc2ktPmZzY2Fj
aGUsIHBhZ2UsIGlub2RlKTsKLQlyZXQgPSBmc2NhY2hlX3dyaXRlX3BhZ2UoY2lmc2ktPmZzY2Fj
aGUsIHBhZ2UsCi0JCQkJIGNpZnNpLT52ZnNfaW5vZGUuaV9zaXplLCBHRlBfS0VSTkVMKTsKLQlp
ZiAocmV0ICE9IDApCi0JCWZzY2FjaGVfdW5jYWNoZV9wYWdlKGNpZnNpLT5mc2NhY2hlLCBwYWdl
KTsKLX0KLQotdm9pZCBfX2NpZnNfZnNjYWNoZV9yZWFkcGFnZXNfY2FuY2VsKHN0cnVjdCBpbm9k
ZSAqaW5vZGUsIHN0cnVjdCBsaXN0X2hlYWQgKnBhZ2VzKQotewotCWNpZnNfZGJnKEZZSSwgIiVz
OiAoZnNjOiAlcCwgaTogJXApXG4iLAotCQkgX19mdW5jX18sIENJRlNfSShpbm9kZSktPmZzY2Fj
aGUsIGlub2RlKTsKLQlmc2NhY2hlX3JlYWRwYWdlc19jYW5jZWwoQ0lGU19JKGlub2RlKS0+ZnNj
YWNoZSwgcGFnZXMpOwotfQotCi12b2lkIF9fY2lmc19mc2NhY2hlX2ludmFsaWRhdGVfcGFnZShz
dHJ1Y3QgcGFnZSAqcGFnZSwgc3RydWN0IGlub2RlICppbm9kZSkKLXsKLQlzdHJ1Y3QgY2lmc0lu
b2RlSW5mbyAqY2lmc2kgPSBDSUZTX0koaW5vZGUpOwotCXN0cnVjdCBmc2NhY2hlX2Nvb2tpZSAq
Y29va2llID0gY2lmc2ktPmZzY2FjaGU7Ci0KLQljaWZzX2RiZyhGWUksICIlczogKDB4JXAvMHgl
cClcbiIsIF9fZnVuY19fLCBwYWdlLCBjb29raWUpOwotCWZzY2FjaGVfd2FpdF9vbl9wYWdlX3dy
aXRlKGNvb2tpZSwgcGFnZSk7Ci0JZnNjYWNoZV91bmNhY2hlX3BhZ2UoY29va2llLCBwYWdlKTsK
LX0KLQotdm9pZCBfX2NpZnNfZnNjYWNoZV93YWl0X29uX3BhZ2Vfd3JpdGUoc3RydWN0IGlub2Rl
ICppbm9kZSwgc3RydWN0IHBhZ2UgKnBhZ2UpCi17Ci0Jc3RydWN0IGNpZnNJbm9kZUluZm8gKmNp
ZnNpID0gQ0lGU19JKGlub2RlKTsKLQlzdHJ1Y3QgZnNjYWNoZV9jb29raWUgKmNvb2tpZSA9IGNp
ZnNpLT5mc2NhY2hlOwotCi0JY2lmc19kYmcoRllJLCAiJXM6ICgweCVwLzB4JXApXG4iLCBfX2Z1
bmNfXywgcGFnZSwgY29va2llKTsKLQlmc2NhY2hlX3dhaXRfb25fcGFnZV93cml0ZShjb29raWUs
IHBhZ2UpOwotfQotCi12b2lkIF9fY2lmc19mc2NhY2hlX3VuY2FjaGVfcGFnZShzdHJ1Y3QgaW5v
ZGUgKmlub2RlLCBzdHJ1Y3QgcGFnZSAqcGFnZSkKLXsKLQlzdHJ1Y3QgY2lmc0lub2RlSW5mbyAq
Y2lmc2kgPSBDSUZTX0koaW5vZGUpOwotCXN0cnVjdCBmc2NhY2hlX2Nvb2tpZSAqY29va2llID0g
Y2lmc2ktPmZzY2FjaGU7CiAKLQljaWZzX2RiZyhGWUksICIlczogKDB4JXAvMHglcClcbiIsIF9f
ZnVuY19fLCBwYWdlLCBjb29raWUpOwotCWZzY2FjaGVfdW5jYWNoZV9wYWdlKGNvb2tpZSwgcGFn
ZSk7CisJLy8gTmVlZHMgY29udmVyc2lvbiB0byB1c2luZyBuZXRmc2xpYgogfQpkaWZmIC0tZ2l0
IGEvZnMvY2lmcy9mc2NhY2hlLmggYi9mcy9jaWZzL2ZzY2FjaGUuaAppbmRleCA5YmFhMWQwZjIy
YmQuLjBmYzNmOTI1MmM4NCAxMDA2NDQKLS0tIGEvZnMvY2lmcy9mc2NhY2hlLmgKKysrIGIvZnMv
Y2lmcy9mc2NhY2hlLmgKQEAgLTEzLDg0ICsxMyw2MiBAQAogCiAjaW5jbHVkZSAiY2lmc2dsb2Iu
aCIKIAotI2lmZGVmIENPTkZJR19DSUZTX0ZTQ0FDSEUKLQogLyoKLSAqIEF1eGlsaWFyeSBkYXRh
IGF0dGFjaGVkIHRvIENJRlMgc3VwZXJibG9jayB3aXRoaW4gdGhlIGNhY2hlCisgKiBDb2hlcmVu
Y3kgZGF0YSBhdHRhY2hlZCB0byBDSUZTIHZvbHVtZSB3aXRoaW4gdGhlIGNhY2hlCiAgKi8KLXN0
cnVjdCBjaWZzX2ZzY2FjaGVfc3VwZXJfYXV4ZGF0YSB7Ci0JdTY0CXJlc291cmNlX2lkOwkJLyog
dW5pcXVlIHNlcnZlciByZXNvdXJjZSBpZCAqLworc3RydWN0IGNpZnNfZnNjYWNoZV92b2x1bWVf
Y29oZXJlbmN5X2RhdGEgeworCV9fbGU2NAlyZXNvdXJjZV9pZDsJCS8qIHVuaXF1ZSBzZXJ2ZXIg
cmVzb3VyY2UgaWQgKi8KIAlfX2xlNjQJdm9sX2NyZWF0ZV90aW1lOwotCXUzMgl2b2xfc2VyaWFs
X251bWJlcjsKKwlfX2xlMzIJdm9sX3NlcmlhbF9udW1iZXI7CiB9IF9fcGFja2VkOwogCiAvKgot
ICogQXV4aWxpYXJ5IGRhdGEgYXR0YWNoZWQgdG8gQ0lGUyBpbm9kZSB3aXRoaW4gdGhlIGNhY2hl
CisgKiBDb2hlcmVuY3kgZGF0YSBhdHRhY2hlZCB0byBDSUZTIGlub2RlIHdpdGhpbiB0aGUgY2Fj
aGUuCiAgKi8KLXN0cnVjdCBjaWZzX2ZzY2FjaGVfaW5vZGVfYXV4ZGF0YSB7Ci0JdTY0IGxhc3Rf
d3JpdGVfdGltZV9zZWM7Ci0JdTY0IGxhc3RfY2hhbmdlX3RpbWVfc2VjOwotCXUzMiBsYXN0X3dy
aXRlX3RpbWVfbnNlYzsKLQl1MzIgbGFzdF9jaGFuZ2VfdGltZV9uc2VjOwotCXU2NCBlb2Y7Citz
dHJ1Y3QgY2lmc19mc2NhY2hlX2lub2RlX2NvaGVyZW5jeV9kYXRhIHsKKwlfX2xlNjQgbGFzdF93
cml0ZV90aW1lX3NlYzsKKwlfX2xlNjQgbGFzdF9jaGFuZ2VfdGltZV9zZWM7CisJX19sZTMyIGxh
c3Rfd3JpdGVfdGltZV9uc2VjOworCV9fbGUzMiBsYXN0X2NoYW5nZV90aW1lX25zZWM7CiB9Owog
Ci0vKgotICogY2FjaGUuYwotICovCi1leHRlcm4gc3RydWN0IGZzY2FjaGVfbmV0ZnMgY2lmc19m
c2NhY2hlX25ldGZzOwotZXh0ZXJuIGNvbnN0IHN0cnVjdCBmc2NhY2hlX2Nvb2tpZV9kZWYgY2lm
c19mc2NhY2hlX3NlcnZlcl9pbmRleF9kZWY7Ci1leHRlcm4gY29uc3Qgc3RydWN0IGZzY2FjaGVf
Y29va2llX2RlZiBjaWZzX2ZzY2FjaGVfc3VwZXJfaW5kZXhfZGVmOwotZXh0ZXJuIGNvbnN0IHN0
cnVjdCBmc2NhY2hlX2Nvb2tpZV9kZWYgY2lmc19mc2NhY2hlX2lub2RlX29iamVjdF9kZWY7Ci0K
LWV4dGVybiBpbnQgY2lmc19mc2NhY2hlX3JlZ2lzdGVyKHZvaWQpOwotZXh0ZXJuIHZvaWQgY2lm
c19mc2NhY2hlX3VucmVnaXN0ZXIodm9pZCk7CisjaWZkZWYgQ09ORklHX0NJRlNfRlNDQUNIRQog
CiAvKgogICogZnNjYWNoZS5jCiAgKi8KLWV4dGVybiB2b2lkIGNpZnNfZnNjYWNoZV9nZXRfY2xp
ZW50X2Nvb2tpZShzdHJ1Y3QgVENQX1NlcnZlcl9JbmZvICopOwotZXh0ZXJuIHZvaWQgY2lmc19m
c2NhY2hlX3JlbGVhc2VfY2xpZW50X2Nvb2tpZShzdHJ1Y3QgVENQX1NlcnZlcl9JbmZvICopOwot
ZXh0ZXJuIHZvaWQgY2lmc19mc2NhY2hlX2dldF9zdXBlcl9jb29raWUoc3RydWN0IGNpZnNfdGNv
biAqKTsKK2V4dGVybiBpbnQgY2lmc19mc2NhY2hlX2dldF9zdXBlcl9jb29raWUoc3RydWN0IGNp
ZnNfdGNvbiAqKTsKIGV4dGVybiB2b2lkIGNpZnNfZnNjYWNoZV9yZWxlYXNlX3N1cGVyX2Nvb2tp
ZShzdHJ1Y3QgY2lmc190Y29uICopOwogCitleHRlcm4gdm9pZCBjaWZzX2ZzY2FjaGVfZ2V0X2lu
b2RlX2Nvb2tpZShzdHJ1Y3QgaW5vZGUgKnBpbm9kZSk7CiBleHRlcm4gdm9pZCBjaWZzX2ZzY2Fj
aGVfcmVsZWFzZV9pbm9kZV9jb29raWUoc3RydWN0IGlub2RlICopOwotZXh0ZXJuIHZvaWQgY2lm
c19mc2NhY2hlX3VwZGF0ZV9pbm9kZV9jb29raWUoc3RydWN0IGlub2RlICppbm9kZSk7Ci1leHRl
cm4gdm9pZCBjaWZzX2ZzY2FjaGVfc2V0X2lub2RlX2Nvb2tpZShzdHJ1Y3QgaW5vZGUgKiwgc3Ry
dWN0IGZpbGUgKik7Ci1leHRlcm4gdm9pZCBjaWZzX2ZzY2FjaGVfcmVzZXRfaW5vZGVfY29va2ll
KHN0cnVjdCBpbm9kZSAqKTsKK2V4dGVybiB2b2lkIGNpZnNfZnNjYWNoZV91bnVzZV9pbm9kZV9j
b29raWUoc3RydWN0IGlub2RlICpwaW5vZGUsIGJvb2wgdXBkYXRlKTsKKworc3RhdGljIGlubGlu
ZQordm9pZCBjaWZzX2ZzY2FjaGVfZmlsbF9jb2hlcmVuY3koc3RydWN0IGlub2RlICppbm9kZSwK
KwkJCQkgc3RydWN0IGNpZnNfZnNjYWNoZV9pbm9kZV9jb2hlcmVuY3lfZGF0YSAqY2QpCit7CisJ
c3RydWN0IGNpZnNJbm9kZUluZm8gKmNpZnNpID0gQ0lGU19JKGlub2RlKTsKKworCW1lbXNldChj
ZCwgMCwgc2l6ZW9mKCpjZCkpOworCWNkLT5sYXN0X3dyaXRlX3RpbWVfc2VjICAgPSBjcHVfdG9f
bGU2NChjaWZzaS0+dmZzX2lub2RlLmlfbXRpbWUudHZfc2VjKTsKKwljZC0+bGFzdF93cml0ZV90
aW1lX25zZWMgID0gY3B1X3RvX2xlMzIoY2lmc2ktPnZmc19pbm9kZS5pX210aW1lLnR2X25zZWMp
OworCWNkLT5sYXN0X2NoYW5nZV90aW1lX3NlYyAgPSBjcHVfdG9fbGU2NChjaWZzaS0+dmZzX2lu
b2RlLmlfY3RpbWUudHZfc2VjKTsKKwljZC0+bGFzdF9jaGFuZ2VfdGltZV9uc2VjID0gY3B1X3Rv
X2xlMzIoY2lmc2ktPnZmc19pbm9kZS5pX2N0aW1lLnR2X25zZWMpOworfQorCiAKLWV4dGVybiB2
b2lkIF9fY2lmc19mc2NhY2hlX2ludmFsaWRhdGVfcGFnZShzdHJ1Y3QgcGFnZSAqLCBzdHJ1Y3Qg
aW5vZGUgKik7Ci1leHRlcm4gdm9pZCBfX2NpZnNfZnNjYWNoZV93YWl0X29uX3BhZ2Vfd3JpdGUo
c3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IHBhZ2UgKnBhZ2UpOwotZXh0ZXJuIHZvaWQgX19j
aWZzX2ZzY2FjaGVfdW5jYWNoZV9wYWdlKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBwYWdl
ICpwYWdlKTsKIGV4dGVybiBpbnQgY2lmc19mc2NhY2hlX3JlbGVhc2VfcGFnZShzdHJ1Y3QgcGFn
ZSAqcGFnZSwgZ2ZwX3QgZ2ZwKTsKIGV4dGVybiBpbnQgX19jaWZzX3JlYWRwYWdlX2Zyb21fZnNj
YWNoZShzdHJ1Y3QgaW5vZGUgKiwgc3RydWN0IHBhZ2UgKik7CiBleHRlcm4gaW50IF9fY2lmc19y
ZWFkcGFnZXNfZnJvbV9mc2NhY2hlKHN0cnVjdCBpbm9kZSAqLAogCQkJCQkgc3RydWN0IGFkZHJl
c3Nfc3BhY2UgKiwKIAkJCQkJIHN0cnVjdCBsaXN0X2hlYWQgKiwKIAkJCQkJIHVuc2lnbmVkICop
OwotZXh0ZXJuIHZvaWQgX19jaWZzX2ZzY2FjaGVfcmVhZHBhZ2VzX2NhbmNlbChzdHJ1Y3QgaW5v
ZGUgKiwgc3RydWN0IGxpc3RfaGVhZCAqKTsKLQogZXh0ZXJuIHZvaWQgX19jaWZzX3JlYWRwYWdl
X3RvX2ZzY2FjaGUoc3RydWN0IGlub2RlICosIHN0cnVjdCBwYWdlICopOwogCi1zdGF0aWMgaW5s
aW5lIHZvaWQgY2lmc19mc2NhY2hlX2ludmFsaWRhdGVfcGFnZShzdHJ1Y3QgcGFnZSAqcGFnZSwK
LQkJCQkJICAgICAgIHN0cnVjdCBpbm9kZSAqaW5vZGUpCitzdGF0aWMgaW5saW5lIHN0cnVjdCBm
c2NhY2hlX2Nvb2tpZSAqY2lmc19pbm9kZV9jb29raWUoc3RydWN0IGlub2RlICppbm9kZSkKIHsK
LQlpZiAoUGFnZUZzQ2FjaGUocGFnZSkpCi0JCV9fY2lmc19mc2NhY2hlX2ludmFsaWRhdGVfcGFn
ZShwYWdlLCBpbm9kZSk7Ci19Ci0KLXN0YXRpYyBpbmxpbmUgdm9pZCBjaWZzX2ZzY2FjaGVfd2Fp
dF9vbl9wYWdlX3dyaXRlKHN0cnVjdCBpbm9kZSAqaW5vZGUsCi0JCQkJCQkgICBzdHJ1Y3QgcGFn
ZSAqcGFnZSkKLXsKLQlpZiAoUGFnZUZzQ2FjaGUocGFnZSkpCi0JCV9fY2lmc19mc2NhY2hlX3dh
aXRfb25fcGFnZV93cml0ZShpbm9kZSwgcGFnZSk7Ci19Ci0KLXN0YXRpYyBpbmxpbmUgdm9pZCBj
aWZzX2ZzY2FjaGVfdW5jYWNoZV9wYWdlKHN0cnVjdCBpbm9kZSAqaW5vZGUsCi0JCQkJCQkgICBz
dHJ1Y3QgcGFnZSAqcGFnZSkKLXsKLQlpZiAoUGFnZUZzQ2FjaGUocGFnZSkpCi0JCV9fY2lmc19m
c2NhY2hlX3VuY2FjaGVfcGFnZShpbm9kZSwgcGFnZSk7CisJcmV0dXJuIENJRlNfSShpbm9kZSkt
PmZzY2FjaGU7CiB9CiAKIHN0YXRpYyBpbmxpbmUgaW50IGNpZnNfcmVhZHBhZ2VfZnJvbV9mc2Nh
Y2hlKHN0cnVjdCBpbm9kZSAqaW5vZGUsCkBAIC0xMjAsNDEgKzk4LDIwIEBAIHN0YXRpYyBpbmxp
bmUgdm9pZCBjaWZzX3JlYWRwYWdlX3RvX2ZzY2FjaGUoc3RydWN0IGlub2RlICppbm9kZSwKIAkJ
X19jaWZzX3JlYWRwYWdlX3RvX2ZzY2FjaGUoaW5vZGUsIHBhZ2UpOwogfQogCi1zdGF0aWMgaW5s
aW5lIHZvaWQgY2lmc19mc2NhY2hlX3JlYWRwYWdlc19jYW5jZWwoc3RydWN0IGlub2RlICppbm9k
ZSwKLQkJCQkJCSBzdHJ1Y3QgbGlzdF9oZWFkICpwYWdlcykKKyNlbHNlIC8qIENPTkZJR19DSUZT
X0ZTQ0FDSEUgKi8KK3N0YXRpYyBpbmxpbmUKK3ZvaWQgY2lmc19mc2NhY2hlX2ZpbGxfY29oZXJl
bmN5KHN0cnVjdCBpbm9kZSAqaW5vZGUsCisJCQkJIHN0cnVjdCBjaWZzX2ZzY2FjaGVfaW5vZGVf
Y29oZXJlbmN5X2RhdGEgKmNkKQogewotCWlmIChDSUZTX0koaW5vZGUpLT5mc2NhY2hlKQotCQly
ZXR1cm4gX19jaWZzX2ZzY2FjaGVfcmVhZHBhZ2VzX2NhbmNlbChpbm9kZSwgcGFnZXMpOwogfQog
Ci0jZWxzZSAvKiBDT05GSUdfQ0lGU19GU0NBQ0hFICovCi1zdGF0aWMgaW5saW5lIGludCBjaWZz
X2ZzY2FjaGVfcmVnaXN0ZXIodm9pZCkgeyByZXR1cm4gMDsgfQotc3RhdGljIGlubGluZSB2b2lk
IGNpZnNfZnNjYWNoZV91bnJlZ2lzdGVyKHZvaWQpIHt9Ci0KLXN0YXRpYyBpbmxpbmUgdm9pZAot
Y2lmc19mc2NhY2hlX2dldF9jbGllbnRfY29va2llKHN0cnVjdCBUQ1BfU2VydmVyX0luZm8gKnNl
cnZlcikge30KLXN0YXRpYyBpbmxpbmUgdm9pZAotY2lmc19mc2NhY2hlX3JlbGVhc2VfY2xpZW50
X2Nvb2tpZShzdHJ1Y3QgVENQX1NlcnZlcl9JbmZvICpzZXJ2ZXIpIHt9Ci1zdGF0aWMgaW5saW5l
IHZvaWQgY2lmc19mc2NhY2hlX2dldF9zdXBlcl9jb29raWUoc3RydWN0IGNpZnNfdGNvbiAqdGNv
bikge30KLXN0YXRpYyBpbmxpbmUgdm9pZAotY2lmc19mc2NhY2hlX3JlbGVhc2Vfc3VwZXJfY29v
a2llKHN0cnVjdCBjaWZzX3Rjb24gKnRjb24pIHt9CitzdGF0aWMgaW5saW5lIGludCBjaWZzX2Zz
Y2FjaGVfZ2V0X3N1cGVyX2Nvb2tpZShzdHJ1Y3QgY2lmc190Y29uICp0Y29uKSB7IHJldHVybiAw
OyB9CitzdGF0aWMgaW5saW5lIHZvaWQgY2lmc19mc2NhY2hlX3JlbGVhc2Vfc3VwZXJfY29va2ll
KHN0cnVjdCBjaWZzX3Rjb24gKnRjb24pIHt9CiAKK3N0YXRpYyBpbmxpbmUgdm9pZCBjaWZzX2Zz
Y2FjaGVfZ2V0X2lub2RlX2Nvb2tpZShzdHJ1Y3QgaW5vZGUgKmlub2RlKSB7fQogc3RhdGljIGlu
bGluZSB2b2lkIGNpZnNfZnNjYWNoZV9yZWxlYXNlX2lub2RlX2Nvb2tpZShzdHJ1Y3QgaW5vZGUg
Kmlub2RlKSB7fQotc3RhdGljIGlubGluZSB2b2lkIGNpZnNfZnNjYWNoZV91cGRhdGVfaW5vZGVf
Y29va2llKHN0cnVjdCBpbm9kZSAqaW5vZGUpIHt9Ci1zdGF0aWMgaW5saW5lIHZvaWQgY2lmc19m
c2NhY2hlX3NldF9pbm9kZV9jb29raWUoc3RydWN0IGlub2RlICppbm9kZSwKLQkJCQkJCSBzdHJ1
Y3QgZmlsZSAqZmlscCkge30KLXN0YXRpYyBpbmxpbmUgdm9pZCBjaWZzX2ZzY2FjaGVfcmVzZXRf
aW5vZGVfY29va2llKHN0cnVjdCBpbm9kZSAqaW5vZGUpIHt9Ci1zdGF0aWMgaW5saW5lIGludCBj
aWZzX2ZzY2FjaGVfcmVsZWFzZV9wYWdlKHN0cnVjdCBwYWdlICpwYWdlLCBnZnBfdCBnZnApCi17
Ci0JcmV0dXJuIDE7IC8qIE1heSByZWxlYXNlIHBhZ2UgKi8KLX0KLQotc3RhdGljIGlubGluZSB2
b2lkIGNpZnNfZnNjYWNoZV9pbnZhbGlkYXRlX3BhZ2Uoc3RydWN0IHBhZ2UgKnBhZ2UsCi0JCQlz
dHJ1Y3QgaW5vZGUgKmlub2RlKSB7fQotc3RhdGljIGlubGluZSB2b2lkIGNpZnNfZnNjYWNoZV93
YWl0X29uX3BhZ2Vfd3JpdGUoc3RydWN0IGlub2RlICppbm9kZSwKLQkJCQkJCSAgIHN0cnVjdCBw
YWdlICpwYWdlKSB7fQotc3RhdGljIGlubGluZSB2b2lkIGNpZnNfZnNjYWNoZV91bmNhY2hlX3Bh
Z2Uoc3RydWN0IGlub2RlICppbm9kZSwKLQkJCQkJCSAgIHN0cnVjdCBwYWdlICpwYWdlKSB7fQor
c3RhdGljIGlubGluZSB2b2lkIGNpZnNfZnNjYWNoZV91bnVzZV9pbm9kZV9jb29raWUoc3RydWN0
IGlub2RlICppbm9kZSwgYm9vbCB1cGRhdGUpIHt9CitzdGF0aWMgaW5saW5lIHN0cnVjdCBmc2Nh
Y2hlX2Nvb2tpZSAqY2lmc19pbm9kZV9jb29raWUoc3RydWN0IGlub2RlICppbm9kZSkgeyByZXR1
cm4gTlVMTDsgfQogCiBzdGF0aWMgaW5saW5lIGludAogY2lmc19yZWFkcGFnZV9mcm9tX2ZzY2Fj
aGUoc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IHBhZ2UgKnBhZ2UpCkBAIC0xNzMsMTEgKzEz
MCw2IEBAIHN0YXRpYyBpbmxpbmUgaW50IGNpZnNfcmVhZHBhZ2VzX2Zyb21fZnNjYWNoZShzdHJ1
Y3QgaW5vZGUgKmlub2RlLAogc3RhdGljIGlubGluZSB2b2lkIGNpZnNfcmVhZHBhZ2VfdG9fZnNj
YWNoZShzdHJ1Y3QgaW5vZGUgKmlub2RlLAogCQkJc3RydWN0IHBhZ2UgKnBhZ2UpIHt9CiAKLXN0
YXRpYyBpbmxpbmUgdm9pZCBjaWZzX2ZzY2FjaGVfcmVhZHBhZ2VzX2NhbmNlbChzdHJ1Y3QgaW5v
ZGUgKmlub2RlLAotCQkJCQkJIHN0cnVjdCBsaXN0X2hlYWQgKnBhZ2VzKQotewotfQotCiAjZW5k
aWYgLyogQ09ORklHX0NJRlNfRlNDQUNIRSAqLwogCiAjZW5kaWYgLyogX0NJRlNfRlNDQUNIRV9I
ICovCmRpZmYgLS1naXQgYS9mcy9jaWZzL2lub2RlLmMgYi9mcy9jaWZzL2lub2RlLmMKaW5kZXgg
YmFhMTk3ZWRkOGM1Li43ZDhiM2NlYjJhZjMgMTAwNjQ0Ci0tLSBhL2ZzL2NpZnMvaW5vZGUuYwor
KysgYi9mcy9jaWZzL2lub2RlLmMKQEAgLTEzMDQsMTAgKzEzMDQsNyBAQCBjaWZzX2lnZXQoc3Ry
dWN0IHN1cGVyX2Jsb2NrICpzYiwgc3RydWN0IGNpZnNfZmF0dHIgKmZhdHRyKQogCQkJaW5vZGUt
PmlfZmxhZ3MgfD0gU19OT0FUSU1FIHwgU19OT0NNVElNRTsKIAkJaWYgKGlub2RlLT5pX3N0YXRl
ICYgSV9ORVcpIHsKIAkJCWlub2RlLT5pX2lubyA9IGhhc2g7Ci0jaWZkZWYgQ09ORklHX0NJRlNf
RlNDQUNIRQotCQkJLyogaW5pdGlhbGl6ZSBwZXItaW5vZGUgY2FjaGUgY29va2llIHBvaW50ZXIg
Ki8KLQkJCUNJRlNfSShpbm9kZSktPmZzY2FjaGUgPSBOVUxMOwotI2VuZGlmCisJCQljaWZzX2Zz
Y2FjaGVfZ2V0X2lub2RlX2Nvb2tpZShpbm9kZSk7CiAJCQl1bmxvY2tfbmV3X2lub2RlKGlub2Rl
KTsKIAkJfQogCX0KQEAgLTEzNzYsNiArMTM3Myw3IEBAIHN0cnVjdCBpbm9kZSAqY2lmc19yb290
X2lnZXQoc3RydWN0IHN1cGVyX2Jsb2NrICpzYikKIAkJaWdldF9mYWlsZWQoaW5vZGUpOwogCQlp
bm9kZSA9IEVSUl9QVFIocmMpOwogCX0KKwogb3V0OgogCWtmcmVlKHBhdGgpOwogCWZyZWVfeGlk
KHhpZCk7CkBAIC0yMjYzLDYgKzIyNjEsOCBAQCBjaWZzX2RlbnRyeV9uZWVkc19yZXZhbChzdHJ1
Y3QgZGVudHJ5ICpkZW50cnkpCiBpbnQKIGNpZnNfaW52YWxpZGF0ZV9tYXBwaW5nKHN0cnVjdCBp
bm9kZSAqaW5vZGUpCiB7CisJc3RydWN0IGNpZnNfZnNjYWNoZV9pbm9kZV9jb2hlcmVuY3lfZGF0
YSBjZDsKKwlzdHJ1Y3QgY2lmc0lub2RlSW5mbyAqY2lmc2kgPSBDSUZTX0koaW5vZGUpOwogCWlu
dCByYyA9IDA7CiAKIAlpZiAoaW5vZGUtPmlfbWFwcGluZyAmJiBpbm9kZS0+aV9tYXBwaW5nLT5u
cnBhZ2VzICE9IDApIHsKQEAgLTIyNzIsNyArMjI3Miw4IEBAIGNpZnNfaW52YWxpZGF0ZV9tYXBw
aW5nKHN0cnVjdCBpbm9kZSAqaW5vZGUpCiAJCQkJIF9fZnVuY19fLCBpbm9kZSk7CiAJfQogCi0J
Y2lmc19mc2NhY2hlX3Jlc2V0X2lub2RlX2Nvb2tpZShpbm9kZSk7CisJY2lmc19mc2NhY2hlX2Zp
bGxfY29oZXJlbmN5KCZjaWZzaS0+dmZzX2lub2RlLCAmY2QpOworCWZzY2FjaGVfaW52YWxpZGF0
ZShjaWZzX2lub2RlX2Nvb2tpZShpbm9kZSksICZjZCwgaV9zaXplX3JlYWQoaW5vZGUpLCAwKTsK
IAlyZXR1cm4gcmM7CiB9CiAKQEAgLTI3NzcsOCArMjc3OCwxMCBAQCBjaWZzX3NldGF0dHJfdW5p
eChzdHJ1Y3QgZGVudHJ5ICpkaXJlbnRyeSwgc3RydWN0IGlhdHRyICphdHRycykKIAkJZ290byBv
dXQ7CiAKIAlpZiAoKGF0dHJzLT5pYV92YWxpZCAmIEFUVFJfU0laRSkgJiYKLQkgICAgYXR0cnMt
PmlhX3NpemUgIT0gaV9zaXplX3JlYWQoaW5vZGUpKQorCSAgICBhdHRycy0+aWFfc2l6ZSAhPSBp
X3NpemVfcmVhZChpbm9kZSkpIHsKIAkJdHJ1bmNhdGVfc2V0c2l6ZShpbm9kZSwgYXR0cnMtPmlh
X3NpemUpOworCQlmc2NhY2hlX3Jlc2l6ZV9jb29raWUoY2lmc19pbm9kZV9jb29raWUoaW5vZGUp
LCBhdHRycy0+aWFfc2l6ZSk7CisJfQogCiAJc2V0YXR0cl9jb3B5KCZpbml0X3VzZXJfbnMsIGlu
b2RlLCBhdHRycyk7CiAJbWFya19pbm9kZV9kaXJ0eShpbm9kZSk7CkBAIC0yOTczLDggKzI5NzYs
MTAgQEAgY2lmc19zZXRhdHRyX25vdW5peChzdHJ1Y3QgZGVudHJ5ICpkaXJlbnRyeSwgc3RydWN0
IGlhdHRyICphdHRycykKIAkJZ290byBjaWZzX3NldGF0dHJfZXhpdDsKIAogCWlmICgoYXR0cnMt
PmlhX3ZhbGlkICYgQVRUUl9TSVpFKSAmJgotCSAgICBhdHRycy0+aWFfc2l6ZSAhPSBpX3NpemVf
cmVhZChpbm9kZSkpCisJICAgIGF0dHJzLT5pYV9zaXplICE9IGlfc2l6ZV9yZWFkKGlub2RlKSkg
ewogCQl0cnVuY2F0ZV9zZXRzaXplKGlub2RlLCBhdHRycy0+aWFfc2l6ZSk7CisJCWZzY2FjaGVf
cmVzaXplX2Nvb2tpZShjaWZzX2lub2RlX2Nvb2tpZShpbm9kZSksIGF0dHJzLT5pYV9zaXplKTsK
Kwl9CiAKIAlzZXRhdHRyX2NvcHkoJmluaXRfdXNlcl9ucywgaW5vZGUsIGF0dHJzKTsKIAltYXJr
X2lub2RlX2RpcnR5KGlub2RlKTsKLS0gCjIuMzIuMAoK
--0000000000006fd60f05d5e8e043--
