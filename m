Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 587AB3B7988
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 22:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235565AbhF2Uxc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 16:53:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29790 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235559AbhF2Uxb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 16:53:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624999864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZNMHSA+ZWLZojxWjQM9XZzp7706ukOncSULPMo52dwg=;
        b=Dswm09j7BvV8h/cg0T+989F5Znu3Mk2VSAXWbkmiAQpKiDpfm5Udo9kK5MOhZEwOBW7qNn
        n0kvjq06RtA0YaZJfNwy/psJQDLCpGb7ZXUFY/piOgV8aCJJHIVaGi7jv2GuyFRIeGVKGI
        KrOoZYAlszS5GAjjmQoJrZ7cPeOaPBc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-iY8ibxv_MMCzx-qFC43ySw-1; Tue, 29 Jun 2021 16:51:02 -0400
X-MC-Unique: iY8ibxv_MMCzx-qFC43ySw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 799C2100CA8A;
        Tue, 29 Jun 2021 20:51:01 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-194.rdu2.redhat.com [10.10.116.194])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1B6B960875;
        Tue, 29 Jun 2021 20:50:49 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id A45B622054F; Tue, 29 Jun 2021 16:50:48 -0400 (EDT)
Date:   Tue, 29 Jun 2021 16:50:48 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [Virtio-fs] [PATCH 3/2] fs: simplify get_filesystem_list /
 get_all_fs_names
Message-ID: <20210629205048.GE5231@redhat.com>
References: <20210621062657.3641879-1-hch@lst.de>
 <20210622081217.GA2975@lst.de>
 <YNGhERcnLuzjn8j9@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNGhERcnLuzjn8j9@stefanha-x1.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 09:36:33AM +0100, Stefan Hajnoczi wrote:
> On Tue, Jun 22, 2021 at 10:12:17AM +0200, Christoph Hellwig wrote:
> > Just output the '\0' separate list of supported file systems for block
> > devices directly rather than going through a pointless round of string
> > manipulation.
> > 
> > Based on an earlier patch from Al Viro <viro@zeniv.linux.org.uk>.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  fs/filesystems.c   | 24 ++++++++++++++----------
> >  include/linux/fs.h |  2 +-
> >  init/do_mounts.c   | 20 +-------------------
> >  3 files changed, 16 insertions(+), 30 deletions(-)
> > 
> > diff --git a/fs/filesystems.c b/fs/filesystems.c
> > index 90b8d879fbaf..7c136251607a 100644
> > --- a/fs/filesystems.c
> > +++ b/fs/filesystems.c
> > @@ -209,21 +209,25 @@ SYSCALL_DEFINE3(sysfs, int, option, unsigned long, arg1, unsigned long, arg2)
> >  }
> >  #endif
> >  
> > -int __init get_filesystem_list(char *buf)
> > +void __init list_bdev_fs_names(char *buf, size_t size)
> >  {
> > -	int len = 0;
> > -	struct file_system_type * tmp;
> > +	struct file_system_type *p;
> > +	size_t len;
> >  
> >  	read_lock(&file_systems_lock);
> > -	tmp = file_systems;
> > -	while (tmp && len < PAGE_SIZE - 80) {
> > -		len += sprintf(buf+len, "%s\t%s\n",
> > -			(tmp->fs_flags & FS_REQUIRES_DEV) ? "" : "nodev",
> > -			tmp->name);
> > -		tmp = tmp->next;
> > +	for (p = file_systems; p; p = p->next) {
> > +		if (!(p->fs_flags & FS_REQUIRES_DEV))
> > +			continue;
> > +		len = strlen(p->name) + 1;
> > +		if (len > size) {
> > +			pr_warn("%s: truncating file system list\n", __func__);
> > +			break;
> > +		}
> > +		memcpy(buf, p->name, len);
> > +		buf += len;
> > +		size -= len;
> >  	}
> >  	read_unlock(&file_systems_lock);
> > -	return len;
> >  }
> 
> I don't see the extra NUL terminator byte being added that's required by
> the loop in mount_block_root()?

May be we should modify mount_block_root() code so that it does not
require that extra "\0". Possibly zero initialize page and that should
make sure list_bdev_fs_names() does not have to worry about it.

It is possible that a page gets full from the list of filesystems, and
last byte on page is terminating null. In that case just zeroing page
will not help. We can keep track of some sort of end pointer and make
sure we are not searching beyond that for valid filesystem types.

end = page + PAGE_SIZE - 1;

mount_block_root()
{
	for (p = fs_names; p < end && *p; p += strlen(p)+1) {
	}
}

Thanks
Vivek

