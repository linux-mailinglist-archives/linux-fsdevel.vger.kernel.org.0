Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7263F5BC7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Aug 2021 12:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235952AbhHXKQT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Aug 2021 06:16:19 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:23390 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235367AbhHXKQR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Aug 2021 06:16:17 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513--UwY5AVyOrKyXJaVXm99qQ-1; Tue, 24 Aug 2021 06:15:29 -0400
X-MC-Unique: -UwY5AVyOrKyXJaVXm99qQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB07D8799F7;
        Tue, 24 Aug 2021 10:15:27 +0000 (UTC)
Received: from bahia.lan (unknown [10.39.192.231])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 94BBB60CC9;
        Tue, 24 Aug 2021 10:15:16 +0000 (UTC)
Date:   Tue, 24 Aug 2021 12:15:15 +0200
From:   Greg Kurz <groug@kaod.org>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        <miklos@szeredi.hu>, <virtualization@lists.linux-foundation.org>,
        <virtio-fs@redhat.com>, <joseph.qi@linux.alibaba.com>,
        <stefanha@redhat.com>, <linux-fsdevel@vger.kernel.org>,
        <vgoyal@redhat.com>
Subject: Re: [Virtio-fs] [virtiofsd PATCH v4 4/4] virtiofsd: support
 per-file DAX in FUSE_LOOKUP
Message-ID: <20210824121515.5419d6a7@bahia.lan>
In-Reply-To: <4494052b-aff1-e2e3-e704-c8743168f62e@linux.alibaba.com>
References: <20210817022220.17574-1-jefflexu@linux.alibaba.com>
        <20210817022347.18098-1-jefflexu@linux.alibaba.com>
        <20210817022347.18098-5-jefflexu@linux.alibaba.com>
        <YRwHRmL/jUSqgkIU@work-vm>
        <29627110-e4bf-836f-2343-1faeb36ad4d3@linux.alibaba.com>
        <YR5Xzw02IuVAN94b@work-vm>
        <4494052b-aff1-e2e3-e704-c8743168f62e@linux.alibaba.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=groug@kaod.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 20 Aug 2021 13:03:23 +0800
JeffleXu <jefflexu@linux.alibaba.com> wrote:

> 
> 
> On 8/19/21 9:08 PM, Dr. David Alan Gilbert wrote:
> > * JeffleXu (jefflexu@linux.alibaba.com) wrote:
> >>
> >>
> >> On 8/18/21 3:00 AM, Dr. David Alan Gilbert wrote:
> >>> * Jeffle Xu (jefflexu@linux.alibaba.com) wrote:
> >>>> For passthrough, when the corresponding virtiofs in guest is mounted
> >>>> with '-o dax=inode', advertise that the file is capable of per-file
> >>>> DAX if the inode in the backend fs is marked with FS_DAX_FL flag.
> >>>>
> >>>> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> >>>> ---
> >>>>  tools/virtiofsd/passthrough_ll.c | 43 ++++++++++++++++++++++++++++++++
> >>>>  1 file changed, 43 insertions(+)
> >>>>
> >>>> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
> >>>> index 5b6228210f..4cbd904248 100644
> >>>> --- a/tools/virtiofsd/passthrough_ll.c
> >>>> +++ b/tools/virtiofsd/passthrough_ll.c
> >>>> @@ -171,6 +171,7 @@ struct lo_data {
> >>>>      int allow_direct_io;
> >>>>      int announce_submounts;
> >>>>      int perfile_dax_cap; /* capability of backend fs */
> >>>> +    bool perfile_dax; /* enable per-file DAX or not */
> >>>>      bool use_statx;
> >>>>      struct lo_inode root;
> >>>>      GHashTable *inodes; /* protected by lo->mutex */
> >>>> @@ -716,6 +717,10 @@ static void lo_init(void *userdata, struct fuse_conn_info *conn)
> >>>>  
> >>>>      if (conn->capable & FUSE_CAP_PERFILE_DAX && lo->perfile_dax_cap ) {
> >>>>          conn->want |= FUSE_CAP_PERFILE_DAX;
> >>>> +	lo->perfile_dax = 1;
> >>>> +    }
> >>>> +    else {
> >>>> +	lo->perfile_dax = 0;
> >>>>      }
> >>>>  }
> >>>>  
> >>>> @@ -983,6 +988,41 @@ static int do_statx(struct lo_data *lo, int dirfd, const char *pathname,
> >>>>      return 0;
> >>>>  }
> >>>>  
> >>>> +/*
> >>>> + * If the file is marked with FS_DAX_FL or FS_XFLAG_DAX, then DAX should be
> >>>> + * enabled for this file.
> >>>> + */
> >>>> +static bool lo_should_enable_dax(struct lo_data *lo, struct lo_inode *dir,
> >>>> +				 const char *name)
> >>>> +{
> >>>> +    int res, fd;
> >>>> +    int ret = false;;
> >>>> +    unsigned int attr;
> >>>> +    struct fsxattr xattr;
> >>>> +
> >>>> +    if (!lo->perfile_dax)
> >>>> +	return false;
> >>>> +
> >>>> +    /* Open file without O_PATH, so that ioctl can be called. */
> >>>> +    fd = openat(dir->fd, name, O_NOFOLLOW);
> >>>> +    if (fd == -1)
> >>>> +        return false;
> >>>
> >>> Doesn't that defeat the whole benefit of using O_PATH - i.e. that we
> >>> might stumble into a /dev node or something else we're not allowed to
> >>> open?
> >>
> >> As far as I know, virtiofsd will pivot_root/chroot to the source
> >> directory, and can only access files inside the source directory
> >> specified by "-o source=". Then where do these unexpected files come
> >> from? Besides, fd opened without O_PATH here is temporary and used for
> >> FS_IOC_GETFLAGS/FS_IOC_FSGETXATTR ioctl only. It's closed when the
> >> function returns.
> > 
> > The guest is still allowed to mknod.
> > See:
> >    https://lists.gnu.org/archive/html/qemu-devel/2021-01/msg05461.html
> > 
> > also it's legal to expose a root filesystem for a guest; the virtiofsd
> > should *never* open a device other than O_PATH - and it's really tricky
> > to do a check to see if it is a device in a race-free way.
> > 
> 
> Fine. Got it. However the returned fd (opened without O_PATH) is only
> used for FS_IOC_GETFLAGS/FS_IOC_FSGETXATTR ioctl, while in most cases
> for special device files, these two ioctls should return -ENOTTY.
> 

The actual problem is that a FIFO will cause openat() to block until
the other end of the FIFO is open for writing...

> If it's really a security issue, then lo_inode_open() could be used to

... and cause a DoS on virtiofsd. So yes, this is a security issue and
lo_inode_open() was introduced specifically to handle this.

> get a temporary fd, i.e., check if it's a special file before opening.
> After all, FUSE_OPEN also handles in this way. Besides, I can't
> understand what "race-free way" means.
> 

"race-free way" means a way that guarantees that file type
cannot change between the time you check it and the time
you open it (TOCTOU error). For example, doing a plain stat(),
checking st_mode and proceeding to open() is wrong : nothing
prevents the file to be unlinked and replaced by something
else between stat() and open().

We avoid that by keeping O_PATH fds around and using
lo_inode_open() instead of openat().

In your case, it seems that you should do the checking after
you have an actual lo_inode for the target file, and pass
that to lo_should_enable_dax() instead of the parent lo_inode
and target name.

Cheers,

--
Greg

