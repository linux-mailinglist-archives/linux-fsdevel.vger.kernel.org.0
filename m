Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54DD03C5DE8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 16:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbhGLOFz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 10:05:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41632 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230181AbhGLOFy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 10:05:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626098586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6QZTkpToWndbC/JY1O8MzhhwkItgB1oCt3LUvlhk+js=;
        b=NbB31piU9rOSePeduFeIQGvFXqcotfXDHwagXe2Icf4/S4MDF7/vBs7cIbSYnmmys1aFUg
        5B9loNMyP/jlUMxyO/OjZknhYg0S52Nu+mqp2OkBbnJ+eDcClVeS01Y65s1ZLB4zIk0N9p
        uMuTC9OxIPp/9SEVNDma3JRSA1C65j4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-9z529XwbMaij_RCHZvvi3A-1; Mon, 12 Jul 2021 10:03:02 -0400
X-MC-Unique: 9z529XwbMaij_RCHZvvi3A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99D93101F7C4;
        Mon, 12 Jul 2021 14:03:00 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-176.rdu2.redhat.com [10.10.114.176])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C6C005DF56;
        Mon, 12 Jul 2021 14:02:47 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 5751522054F; Mon, 12 Jul 2021 10:02:47 -0400 (EDT)
Date:   Mon, 12 Jul 2021 10:02:47 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Bruce Fields <bfields@redhat.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, virtio-fs@redhat.com, dwalsh@redhat.com,
        dgilbert@redhat.com, casey.schaufler@intel.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        tytso@mit.edu, miklos@szeredi.hu, gscrivan@redhat.com,
        jack@suse.cz, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 1/1] xattr: Allow user.* xattr on symlink and special
 files
Message-ID: <20210712140247.GA486376@redhat.com>
References: <20210708175738.360757-1-vgoyal@redhat.com>
 <20210708175738.360757-2-vgoyal@redhat.com>
 <20210709091915.2bd4snyfjndexw2b@wittgenstein>
 <20210709152737.GA398382@redhat.com>
 <710d1c6f-d477-384f-0cc1-8914258f1fb1@schaufler-ca.com>
 <20210709175947.GB398382@redhat.com>
 <CAPL3RVGKg4G5qiiHo7KYPcsWWgeoW=qNPOSQpd3Sv329jrWrLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPL3RVGKg4G5qiiHo7KYPcsWWgeoW=qNPOSQpd3Sv329jrWrLQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 09, 2021 at 04:10:16PM -0400, Bruce Fields wrote:
> On Fri, Jul 9, 2021 at 1:59 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > nfs seems to have some issues.
> 
> I'm not sure what the expected behavior is for nfs.  All I have for
> now is some generic troubleshooting ideas, sorry:
> 
> > - I can set user.foo xattr on symlink and query it back using xattr name.
> >
> >   getfattr -h -n user.foo foo-link.txt
> >
> >   But when I try to dump all xattrs on this file, user.foo is being
> >   filtered out it looks like. Not sure why.
> 
> Logging into the server and seeing what's set there could help confirm
> whether it's the client or server that's at fault.  (Or watching the
> traffic in wireshark; there are GET/SET/LISTXATTR ops that should be
> easy to spot.)
> 
> > - I can't set "user.foo" xattr on a device node on nfs and I get
> >   "Permission denied". I am assuming nfs server is returning this.
> 
> Wireshark should tell you whether it's the server or client doing that.
> 
> The RFC is https://datatracker.ietf.org/doc/html/rfc8276, and I don't
> see any explicit statement about what the server should do in the case
> of symlinks or device nodes, but I do see "Any regular file or
> directory may have a set of extended attributes", so that was clearly
> the assumption.  Also, NFS4ERR_WRONG_TYPE is listed as a possible
> error return for the xattr ops.  But on a quick skim I don't see any
> explicit checks in the nfsd code, so I *think* it's just relying on
> the vfs for any file type checks.

Hi Bruce,

Thanks for the response. I am just trying to do set a user.foo xattr on
a device node on nfs.

setfattr -n "user.foo" -v "bar" /mnt/nfs/test-dev

and I get -EACCESS.

I put some printk() statements and EACCESS is being returned from here.

nfs4_xattr_set_nfs4_user() {
        if (!nfs_access_get_cached(inode, current_cred(), &cache, true)) {
                if (!(cache.mask & NFS_ACCESS_XAWRITE)) {
                        return -EACCES;
                }
        }
}

Value of cache.mask=0xd at the time of error.

Thanks
Vivek

