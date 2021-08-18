Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7243F0A54
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Aug 2021 19:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhHRRec (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 13:34:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56147 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229522AbhHRReb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 13:34:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629308036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I2YmipCDl8vwbAwu1PzrQO5U8OiwrNEdg94kk0PE0Ak=;
        b=hPPYwiCLIVlMhsXF9j+Cg7nPPaDnuOtVAx1ThRsKdWNUe9tGMTKgOYLdV0R9B5uxU92PdJ
        pdLK3FGgtzAACnukLc4HguoRANGDw2v5KtNlGsHbFkpsy2oSJuIzNlBogcRjPVJs7K2xrR
        eKkbkMrQEpddflNNkD8DvhYcMQMiGCU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-HQCEE9nkPfiAXF8hX_7zlw-1; Wed, 18 Aug 2021 13:33:54 -0400
X-MC-Unique: HQCEE9nkPfiAXF8hX_7zlw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D570824F8C;
        Wed, 18 Aug 2021 17:33:53 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.33.235])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DF1025C1A3;
        Wed, 18 Aug 2021 17:33:45 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 72573223863; Wed, 18 Aug 2021 13:33:45 -0400 (EDT)
Date:   Wed, 18 Aug 2021 13:33:45 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     stefanha@redhat.com, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, virtio-fs@redhat.com,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com
Subject: Re: [virtiofsd PATCH v4 1/4] virtiofsd: add .ioctl() support
Message-ID: <YR1EeX/yD4V2cSOq@redhat.com>
References: <20210817022220.17574-1-jefflexu@linux.alibaba.com>
 <20210817022347.18098-1-jefflexu@linux.alibaba.com>
 <20210817022347.18098-2-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817022347.18098-2-jefflexu@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 17, 2021 at 10:23:44AM +0800, Jeffle Xu wrote:
> Add .ioctl() support for passthrough, in prep for the following support
> for following per-file DAX feature.
> 
> Once advertising support for per-file DAX feature, virtiofsd should
> support storing FS_DAX_FL flag persistently passed by
> FS_IOC_SETFLAGS/FS_IOC_FSSETXATTR ioctl, and set FUSE_ATTR_DAX in
> FUSE_LOOKUP accordingly if the file is capable of per-file DAX.
> 
> When it comes to passthrough, it passes corresponding ioctls to host
> directly. Currently only these ioctls that are needed for per-file DAX
> feature, i.e., FS_IOC_GETFLAGS/FS_IOC_SETFLAGS and
> FS_IOC_FSGETXATTR/FS_IOC_FSSETXATTR are supported. Later we can restrict
> the flags/attributes allowed to be set to reinforce the security, or
> extend the scope of allowed ioctls if it is really needed later.

Dave had concerns about which attrs should be allowed to be set by
guest. And we were also wondering why virtiofs is not supporting
ioctl yet.

It think that it probably will make sense that supporting ioctls,
is a separate patch series for virtiofs. Anyway, we probably will
need to add it. 

Vivek
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  tools/virtiofsd/passthrough_ll.c      | 53 +++++++++++++++++++++++++++
>  tools/virtiofsd/passthrough_seccomp.c |  1 +
>  2 files changed, 54 insertions(+)
> 
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
> index b76d878509..e170b17adb 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -54,6 +54,7 @@
>  #include <sys/wait.h>
>  #include <sys/xattr.h>
>  #include <syslog.h>
> +#include <linux/fs.h>
>  
>  #include "qemu/cutils.h"
>  #include "passthrough_helpers.h"
> @@ -2105,6 +2106,57 @@ out:
>      fuse_reply_err(req, saverr);
>  }
>  
> +static void lo_ioctl(fuse_req_t req, fuse_ino_t ino, unsigned int cmd, void *arg,
> +                  struct fuse_file_info *fi, unsigned flags, const void *in_buf,
> +                  size_t in_bufsz, size_t out_bufsz)
> +{
> +    int fd = lo_fi_fd(req, fi);
> +    int res;
> +    int saverr = ENOSYS;
> +
> +    fuse_log(FUSE_LOG_DEBUG, "lo_ioctl(ino=%" PRIu64 ", cmd=0x%x, flags=0x%x, "
> +	     "in_bufsz = %lu, out_bufsz = %lu)\n",
> +	     ino, cmd, flags, in_bufsz, out_bufsz);
> +
> +    /* unrestricted ioctl is not supported yet */
> +    if (flags & FUSE_IOCTL_UNRESTRICTED)
> +        goto out;
> +
> +    /*
> +     * Currently only those ioctls needed to support per-file DAX feature,
> +     * i.e., FS_IOC_GETFLAGS/FS_IOC_SETFLAGS and
> +     * FS_IOC_FSGETXATTR/FS_IOC_FSSETXATTR are supported.
> +     */
> +    if (cmd == FS_IOC_SETFLAGS || cmd == FS_IOC_FSSETXATTR) {
> +        res = ioctl(fd, cmd, in_buf);
> +        if (res < 0)
> +            goto out_err;
> +
> +	fuse_reply_ioctl(req, 0, NULL, 0);
> +    }
> +    else if (cmd == FS_IOC_GETFLAGS || cmd == FS_IOC_FSGETXATTR) {
> +	/* reused for 'unsigned int' for FS_IOC_GETFLAGS */
> +	struct fsxattr attr;
> +
> +        res = ioctl(fd, cmd, &attr);
> +        if (res < 0)
> +            goto out_err;
> +
> +        fuse_reply_ioctl(req, 0, &attr, out_bufsz);
> +    }
> +    else {
> +	fuse_log(FUSE_LOG_DEBUG, "Unsupported ioctl 0x%x\n", cmd);
> +	goto out;
> +    }
> +
> +    return;
> +
> +out_err:
> +	saverr = errno;
> +out:
> +	fuse_reply_err(req, saverr);
> +}
> +
>  static void lo_fsyncdir(fuse_req_t req, fuse_ino_t ino, int datasync,
>                          struct fuse_file_info *fi)
>  {
> @@ -3279,6 +3331,7 @@ static struct fuse_lowlevel_ops lo_oper = {
>      .create = lo_create,
>      .getlk = lo_getlk,
>      .setlk = lo_setlk,
> +    .ioctl = lo_ioctl,
>      .open = lo_open,
>      .release = lo_release,
>      .flush = lo_flush,
> diff --git a/tools/virtiofsd/passthrough_seccomp.c b/tools/virtiofsd/passthrough_seccomp.c
> index 62441cfcdb..2a5f7614fc 100644
> --- a/tools/virtiofsd/passthrough_seccomp.c
> +++ b/tools/virtiofsd/passthrough_seccomp.c
> @@ -62,6 +62,7 @@ static const int syscall_allowlist[] = {
>      SCMP_SYS(gettid),
>      SCMP_SYS(gettimeofday),
>      SCMP_SYS(getxattr),
> +    SCMP_SYS(ioctl),
>      SCMP_SYS(linkat),
>      SCMP_SYS(listxattr),
>      SCMP_SYS(lseek),
> -- 
> 2.27.0
> 

