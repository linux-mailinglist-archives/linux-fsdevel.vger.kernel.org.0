Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 993013F1A08
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 15:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239440AbhHSNJZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Aug 2021 09:09:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33638 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239300AbhHSNJY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Aug 2021 09:09:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629378528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cbUbOPKdaOv0H6GJNKk7luvurk7xDCBvY4WXdh7nI3c=;
        b=bzkcJasRnZri4nGm3R6yhv5DU7zeTO66uN1pVq3fc40ZebscZ+Pf+69zpsH3j4YW9Ik+i4
        pMT4QX96QYqTl32XT2ULVulOG2tM8dBzhlNEW5TLLeWaU07GRexwVVQWXN1BCN2DyTWVqM
        TRRWt9Y6Ez3c+8Y7B1dpGa3BU1f1/TM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-JVmMAfpVPZGONN-1J4n6Cw-1; Thu, 19 Aug 2021 09:08:46 -0400
X-MC-Unique: JVmMAfpVPZGONN-1J4n6Cw-1
Received: by mail-wr1-f72.google.com with SMTP id a13-20020adfed0d000000b00156fd70137aso1561756wro.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Aug 2021 06:08:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cbUbOPKdaOv0H6GJNKk7luvurk7xDCBvY4WXdh7nI3c=;
        b=nuaI9egrfIBu7EoQz66m55KyAN9YxKAVDvz5OZFsKPcXxCr5uh3qM6oaxQgdgnTBXp
         wrczr8bZWd9PjTMoAtBducdjzXqFyym8DB4SGUiqRk+ikqgk9r020j+MO4e92GguFgZQ
         8VmcKvONexJrY/PekpOxLmjyu5bNkLzsfVmadAehOzk7y2Lgb/kuNMFGX0sIO0XSXAqp
         Bouupn47E1ZIcKjoYMEkPWu9fg6VRreGN72Y/IdE+z9PpvIuxWSVXxwm9z32AFJxw1Bq
         yb+L2eF0AXvUTv7qkiHQx3U2r7ARNAwXklajEjPOikF+iVGTb3k7uUmgJJkAG+Y8vjiY
         aSdQ==
X-Gm-Message-State: AOAM530ZpZfM72WVKwFQHPWKauL95jMcRkzFNRXeKaqeEnewKvZGIxZY
        jQTsXXDaiDlrYaVb4tjE7RlDE2famoKzwSf/E5gXqgK8Wp6tNwauDuSSHZvLl2aDKg26Ju56tOu
        vHQ27JfInZ+DRWLNbUUgOZ8oEvw==
X-Received: by 2002:a1c:7e8a:: with SMTP id z132mr5323502wmc.75.1629378524476;
        Thu, 19 Aug 2021 06:08:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJza67HWrGxP2aUgu3rckgOAHvNq7+jdQQoJn1HcsGEdV1L59q0EUqs3+sIOE01BsDUVL5TJDQ==
X-Received: by 2002:a1c:9a42:: with SMTP id c63mr13975147wme.184.1629378513422;
        Thu, 19 Aug 2021 06:08:33 -0700 (PDT)
Received: from work-vm (cpc109021-salf6-2-0-cust453.10-2.cable.virginm.net. [82.29.237.198])
        by smtp.gmail.com with ESMTPSA id d4sm2942475wrp.57.2021.08.19.06.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 06:08:32 -0700 (PDT)
Date:   Thu, 19 Aug 2021 14:08:31 +0100
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        joseph.qi@linux.alibaba.com,
        virtualization@lists.linux-foundation.org
Subject: Re: [Virtio-fs] [virtiofsd PATCH v4 4/4] virtiofsd: support per-file
 DAX in FUSE_LOOKUP
Message-ID: <YR5Xzw02IuVAN94b@work-vm>
References: <20210817022220.17574-1-jefflexu@linux.alibaba.com>
 <20210817022347.18098-1-jefflexu@linux.alibaba.com>
 <20210817022347.18098-5-jefflexu@linux.alibaba.com>
 <YRwHRmL/jUSqgkIU@work-vm>
 <29627110-e4bf-836f-2343-1faeb36ad4d3@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29627110-e4bf-836f-2343-1faeb36ad4d3@linux.alibaba.com>
User-Agent: Mutt/2.0.7 (2021-05-04)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* JeffleXu (jefflexu@linux.alibaba.com) wrote:
> 
> 
> On 8/18/21 3:00 AM, Dr. David Alan Gilbert wrote:
> > * Jeffle Xu (jefflexu@linux.alibaba.com) wrote:
> >> For passthrough, when the corresponding virtiofs in guest is mounted
> >> with '-o dax=inode', advertise that the file is capable of per-file
> >> DAX if the inode in the backend fs is marked with FS_DAX_FL flag.
> >>
> >> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> >> ---
> >>  tools/virtiofsd/passthrough_ll.c | 43 ++++++++++++++++++++++++++++++++
> >>  1 file changed, 43 insertions(+)
> >>
> >> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
> >> index 5b6228210f..4cbd904248 100644
> >> --- a/tools/virtiofsd/passthrough_ll.c
> >> +++ b/tools/virtiofsd/passthrough_ll.c
> >> @@ -171,6 +171,7 @@ struct lo_data {
> >>      int allow_direct_io;
> >>      int announce_submounts;
> >>      int perfile_dax_cap; /* capability of backend fs */
> >> +    bool perfile_dax; /* enable per-file DAX or not */
> >>      bool use_statx;
> >>      struct lo_inode root;
> >>      GHashTable *inodes; /* protected by lo->mutex */
> >> @@ -716,6 +717,10 @@ static void lo_init(void *userdata, struct fuse_conn_info *conn)
> >>  
> >>      if (conn->capable & FUSE_CAP_PERFILE_DAX && lo->perfile_dax_cap ) {
> >>          conn->want |= FUSE_CAP_PERFILE_DAX;
> >> +	lo->perfile_dax = 1;
> >> +    }
> >> +    else {
> >> +	lo->perfile_dax = 0;
> >>      }
> >>  }
> >>  
> >> @@ -983,6 +988,41 @@ static int do_statx(struct lo_data *lo, int dirfd, const char *pathname,
> >>      return 0;
> >>  }
> >>  
> >> +/*
> >> + * If the file is marked with FS_DAX_FL or FS_XFLAG_DAX, then DAX should be
> >> + * enabled for this file.
> >> + */
> >> +static bool lo_should_enable_dax(struct lo_data *lo, struct lo_inode *dir,
> >> +				 const char *name)
> >> +{
> >> +    int res, fd;
> >> +    int ret = false;;
> >> +    unsigned int attr;
> >> +    struct fsxattr xattr;
> >> +
> >> +    if (!lo->perfile_dax)
> >> +	return false;
> >> +
> >> +    /* Open file without O_PATH, so that ioctl can be called. */
> >> +    fd = openat(dir->fd, name, O_NOFOLLOW);
> >> +    if (fd == -1)
> >> +        return false;
> > 
> > Doesn't that defeat the whole benefit of using O_PATH - i.e. that we
> > might stumble into a /dev node or something else we're not allowed to
> > open?
> 
> As far as I know, virtiofsd will pivot_root/chroot to the source
> directory, and can only access files inside the source directory
> specified by "-o source=". Then where do these unexpected files come
> from? Besides, fd opened without O_PATH here is temporary and used for
> FS_IOC_GETFLAGS/FS_IOC_FSGETXATTR ioctl only. It's closed when the
> function returns.

The guest is still allowed to mknod.
See:
   https://lists.gnu.org/archive/html/qemu-devel/2021-01/msg05461.html

also it's legal to expose a root filesystem for a guest; the virtiofsd
should *never* open a device other than O_PATH - and it's really tricky
to do a check to see if it is a device in a race-free way.


> > 
> >> +    if (lo->perfile_dax_cap == DAX_CAP_FLAGS) {
> >> +        res = ioctl(fd, FS_IOC_GETFLAGS, &attr);
> >> +        if (!res && (attr & FS_DAX_FL))
> >> +	    ret = true;
> >> +    }
> >> +    else if (lo->perfile_dax_cap == DAX_CAP_XATTR) {
> >> +	res = ioctl(fd, FS_IOC_FSGETXATTR, &xattr);
> >> +	if (!res && (xattr.fsx_xflags & FS_XFLAG_DAX))
> >> +	    ret = true;
> >> +    }
> > 
> > This all looks pretty expensive for each lookup.
> 
> Yes. it can be somehow optimized if we can agree on the way of storing
> the dax flag persistently.

Dave

> -- 
> Thanks,
> Jeffle
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

