Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D20323EF0AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 19:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhHQRQi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 13:16:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36144 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230311AbhHQRQh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 13:16:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629220563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nz1DefVYXb14ejAGMQ8caeloEv9rcLRXdmHRFjQVHUU=;
        b=BTWlI8YOuJGIthQqpkRGC7cAv77IF+kYcXv6lFNbTUfOzBASQrkeDsHefU4B6Z4dmN3fHw
        iCK/w/wpCkMYM2bwBHCn30zbDdT9pYT9Kq0m0W+/5HszQ4yfqmfQE0Vk/69OcK9KHsXIGX
        LKZ+0TSsnCdyIZdQvwv63EZ2erkeL5c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-5RW3ClF7MZSNcO4EW8aNMw-1; Tue, 17 Aug 2021 13:16:02 -0400
X-MC-Unique: 5RW3ClF7MZSNcO4EW8aNMw-1
Received: by mail-wm1-f72.google.com with SMTP id r21-20020a05600c35d5b02902e685ef1f76so984428wmq.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Aug 2021 10:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nz1DefVYXb14ejAGMQ8caeloEv9rcLRXdmHRFjQVHUU=;
        b=rmoLXnrkd/WAuG+IHljDBQfq30IkHb/5LVZ19bYePOJAsTBc2TtEdwG4QndY640zT4
         8GEKMwZIfe+bj/p7iHsPZg0H8gXfiJJEeLX+NtVKYaeA00J4WfV4tW7YcoiMmj77D8nQ
         4iNAV415JkRxFaCnDW6Z1NhQ64ReN+PpeUroUtiNd7N6Z7q+/8Jccd5LC02ORCFQw41w
         GdXvLPPdsoAYMxE+Xs7rVxN65DegZ1oeP4wgrY2fWu1voUur5FdMsfZOoB5+b9bR/b2K
         nGyqbjyulQENuriZzFV9C4wsJ2XUfumTUZfu7s1vrdkUEopb8gitmEIb6Ee3/OmA+MKo
         qAxw==
X-Gm-Message-State: AOAM531EXT2d9z7RpoDlD/jIH01VgUQHKkik0qsbWdUt39LixWkuhfBh
        Ks0LgO6sR4er1g1lAM1xwJJSUNtSjqXtaEDzfpwaF7fF+ria9hs9piJGBKwbzIDFOCRlLRo+HCc
        9BIjbpE+Eh/0WaNJtSkfAxE3eoA==
X-Received: by 2002:adf:f4cf:: with SMTP id h15mr5556400wrp.67.1629220561105;
        Tue, 17 Aug 2021 10:16:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJySesPRN0UqpjCI6zOUoQ5bAn/K7jKlA90ASfbcrA6aNwVUT4jNsLOmFqEzkLJ65wu3Get/Pg==
X-Received: by 2002:adf:f4cf:: with SMTP id h15mr5556373wrp.67.1629220560909;
        Tue, 17 Aug 2021 10:16:00 -0700 (PDT)
Received: from work-vm (cpc109021-salf6-2-0-cust453.10-2.cable.virginm.net. [82.29.237.198])
        by smtp.gmail.com with ESMTPSA id w1sm2618942wmc.19.2021.08.17.10.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 10:16:00 -0700 (PDT)
Date:   Tue, 17 Aug 2021 18:15:58 +0100
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        joseph.qi@linux.alibaba.com,
        virtualization@lists.linux-foundation.org
Subject: Re: [Virtio-fs] [virtiofsd PATCH v4 3/4] virtiofsd: support per-file
 DAX negotiation in FUSE_INIT
Message-ID: <YRvuzrRo2t2SyQk/@work-vm>
References: <20210817022220.17574-1-jefflexu@linux.alibaba.com>
 <20210817022347.18098-1-jefflexu@linux.alibaba.com>
 <20210817022347.18098-4-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817022347.18098-4-jefflexu@linux.alibaba.com>
User-Agent: Mutt/2.0.7 (2021-05-04)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Jeffle Xu (jefflexu@linux.alibaba.com) wrote:
> In FUSE_INIT negotiating phase, server/client should advertise if it
> supports per-file DAX.
> 
> Once advertising support for per-file DAX feature, virtiofsd should
> support storing FS_DAX_FL flag persistently passed by
> FS_IOC_SETFLAGS/FS_IOC_FSSETXATTR ioctl, and set FUSE_ATTR_DAX in
> FUSE_LOOKUP accordingly if the file is capable of per-file DAX.
> 
> Currently only ext4/xfs since linux kernel v5.8 support storing
> FS_DAX_FL flag persistently, and thus advertise support for per-file
> DAX feature only when the backend fs type is ext4 and xfs.

I'm a little worried about the meaning of the flags we're storing and
the fact we're storing them in the normal host DAX flags.

Doesn't this mean that we're using a single host flag to mean:
  a) It can be mapped as DAX on the host if it was a real DAX device
  b) We can map it as DAX inside the guest with virtiofs?

what happens when we're using usernamespaces for the guest?

Dave


> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  tools/virtiofsd/fuse_common.h    |  5 +++++
>  tools/virtiofsd/fuse_lowlevel.c  |  6 ++++++
>  tools/virtiofsd/passthrough_ll.c | 29 +++++++++++++++++++++++++++++
>  3 files changed, 40 insertions(+)
> 
> diff --git a/tools/virtiofsd/fuse_common.h b/tools/virtiofsd/fuse_common.h
> index 8a75729be9..ee6fc64c23 100644
> --- a/tools/virtiofsd/fuse_common.h
> +++ b/tools/virtiofsd/fuse_common.h
> @@ -372,6 +372,11 @@ struct fuse_file_info {
>   */
>  #define FUSE_CAP_HANDLE_KILLPRIV_V2 (1 << 28)
>  
> +/**
> + * Indicates support for per-file DAX.
> + */
> +#define FUSE_CAP_PERFILE_DAX (1 << 29)
> +
>  /**
>   * Ioctl flags
>   *
> diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowlevel.c
> index 50fc5c8d5a..04a4f17423 100644
> --- a/tools/virtiofsd/fuse_lowlevel.c
> +++ b/tools/virtiofsd/fuse_lowlevel.c
> @@ -2065,6 +2065,9 @@ static void do_init(fuse_req_t req, fuse_ino_t nodeid,
>      if (arg->flags & FUSE_HANDLE_KILLPRIV_V2) {
>          se->conn.capable |= FUSE_CAP_HANDLE_KILLPRIV_V2;
>      }
> +    if (arg->flags & FUSE_PERFILE_DAX) {
> +        se->conn.capable |= FUSE_CAP_PERFILE_DAX;
> +    }
>  #ifdef HAVE_SPLICE
>  #ifdef HAVE_VMSPLICE
>      se->conn.capable |= FUSE_CAP_SPLICE_WRITE | FUSE_CAP_SPLICE_MOVE;
> @@ -2180,6 +2183,9 @@ static void do_init(fuse_req_t req, fuse_ino_t nodeid,
>      if (se->conn.want & FUSE_CAP_POSIX_ACL) {
>          outarg.flags |= FUSE_POSIX_ACL;
>      }
> +    if (se->op.ioctl && (se->conn.want & FUSE_CAP_PERFILE_DAX)) {
> +        outarg.flags |= FUSE_PERFILE_DAX;
> +    }
>      outarg.max_readahead = se->conn.max_readahead;
>      outarg.max_write = se->conn.max_write;
>      if (se->conn.max_background >= (1 << 16)) {
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
> index e170b17adb..5b6228210f 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -53,8 +53,10 @@
>  #include <sys/syscall.h>
>  #include <sys/wait.h>
>  #include <sys/xattr.h>
> +#include <sys/vfs.h>
>  #include <syslog.h>
>  #include <linux/fs.h>
> +#include <linux/magic.h>
>  
>  #include "qemu/cutils.h"
>  #include "passthrough_helpers.h"
> @@ -136,6 +138,13 @@ enum {
>      SANDBOX_CHROOT,
>  };
>  
> +/* capability of storing DAX flag persistently */
> +enum {
> +    DAX_CAP_NONE,  /* not supported */
> +    DAX_CAP_FLAGS, /* stored in flags (FS_IOC_GETFLAGS/FS_IOC_SETFLAGS) */
> +    DAX_CAP_XATTR, /* stored in xflags (FS_IOC_FSGETXATTR/FS_IOC_FSSETXATTR) */
> +};
> +
>  typedef struct xattr_map_entry {
>      char *key;
>      char *prepend;
> @@ -161,6 +170,7 @@ struct lo_data {
>      int readdirplus_clear;
>      int allow_direct_io;
>      int announce_submounts;
> +    int perfile_dax_cap; /* capability of backend fs */
>      bool use_statx;
>      struct lo_inode root;
>      GHashTable *inodes; /* protected by lo->mutex */
> @@ -703,6 +713,10 @@ static void lo_init(void *userdata, struct fuse_conn_info *conn)
>          conn->want &= ~FUSE_CAP_HANDLE_KILLPRIV_V2;
>          lo->killpriv_v2 = 0;
>      }
> +
> +    if (conn->capable & FUSE_CAP_PERFILE_DAX && lo->perfile_dax_cap ) {
> +        conn->want |= FUSE_CAP_PERFILE_DAX;
> +    }
>  }
>  
>  static void lo_getattr(fuse_req_t req, fuse_ino_t ino,
> @@ -3800,6 +3814,7 @@ static void setup_root(struct lo_data *lo, struct lo_inode *root)
>      int fd, res;
>      struct stat stat;
>      uint64_t mnt_id;
> +    struct statfs statfs;
>  
>      fd = open("/", O_PATH);
>      if (fd == -1) {
> @@ -3826,6 +3841,20 @@ static void setup_root(struct lo_data *lo, struct lo_inode *root)
>          root->posix_locks = g_hash_table_new_full(
>              g_direct_hash, g_direct_equal, NULL, posix_locks_value_destroy);
>      }
> +
> +    /*
> +     * Currently only ext4/xfs since linux kernel v5.8 support storing
> +     * FS_DAX_FL flag persistently. Ext4 accesses this flag through
> +     * FS_IOC_G[S]ETFLAGS ioctl, while xfs accesses this flag through
> +     * FS_IOC_FSG[S]ETXATTR ioctl.
> +     */
> +    res = fstatfs(fd, &statfs);
> +    if (!res) {
> +	if (statfs.f_type == EXT4_SUPER_MAGIC)
> +	    lo->perfile_dax_cap = DAX_CAP_FLAGS;
> +	else if (statfs.f_type == XFS_SUPER_MAGIC)
> +	    lo->perfile_dax_cap = DAX_CAP_XATTR;
> +    }
>  }
>  
>  static guint lo_key_hash(gconstpointer key)
> -- 
> 2.27.0
> 
> _______________________________________________
> Virtio-fs mailing list
> Virtio-fs@redhat.com
> https://listman.redhat.com/mailman/listinfo/virtio-fs
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

