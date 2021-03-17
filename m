Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A1733F290
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 15:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbhCQO2S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Mar 2021 10:28:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:46876 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231828AbhCQO1u (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Mar 2021 10:27:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 50083AD74;
        Wed, 17 Mar 2021 14:27:49 +0000 (UTC)
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id 0c713175;
        Wed, 17 Mar 2021 14:29:03 +0000 (UTC)
Date:   Wed, 17 Mar 2021 14:29:03 +0000
From:   Luis Henriques <lhenriques@suse.de>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        miklos@szeredi.hu, dgilbert@redhat.com, seth.forshee@canonical.com
Subject: Re: [PATCH 0/1] fuse: acl: Send file mode updates using SETATTR
Message-ID: <YFISL+dvR/qy6P+1@suse.de>
References: <20210316160147.289193-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210316160147.289193-1-vgoyal@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 16, 2021 at 12:01:46PM -0400, Vivek Goyal wrote:
> Hi Miklos,
> 
> Please find attached a patch to fix the SGID clearing issue upon 
> ACL change. 
> 
> Luis reported that currently fstests generic/375 fails on virtiofs. And
> reason being that we don't clear SGID when it should be.
> 
> Setting ACL can lead to file mode change. And this in-turn also can
> lead to clearing SGID bit if.
> 
> - None of caller's groups match file owner group.
> AND
> - Caller does not have CAP_FSETID.
> 
> Current implementation relies on server updating the mode. But file
> server does not have enough information to do so. 
> 
> Initially I thought of sending CAP_FSETID information to server but
> then I realized, it is just one of the pieces. What about all the
> groups caller is a member of. If this has to work correctly, then
> all the information will have to be sent to virtiofsd somehow. Just
> sending CAP_FSETID information required adding V2 of fuse_setxattr_in
> because we don't have any space for sending extra information.
> 
> https://github.com/rhvgoyal/linux/commit/681cf5bdbba9c965c3dbd4337c16e9b17f27debe
> 
> Also this approach will not work with idmapped mounts because server
> does not have information about idmapped mappings.
> 
> So I started to look at the approach of sending file mode updates
> using SETATTR. As filesystems like 9pfs and ceph are doing. This
> seems simpler approach. Though it has its issues too.
> 
> - File mode update and setxattr(system.posix_acl_access) are not atomic.

After reviewing (and testing) the patch, the only comment I have is that
we should at least pr_warn() an eventual failure in setxattr().  But f
that operation fails at that point, probably something went wrong on the
other side and the kernel is unlikely to be able to revert the mode
changes anyway.

(And a nit: your patch seems to require some whitespaces clean-up.)

Cheers,
--
Lu�s


> None of the approaches seem very clean to me. But sending SETATTR
> explicitly seems to be lesser of two evils to me at this point of time.
> Hence I am proposing this patch. 
> 
> I have run fstests acl tests and they pass. (./check -g acl).
> 
> Corresponding virtiofsd patches are here.
> 
> https://github.com/rhvgoyal/qemu/commits/acl-sgid-setattr
> 
> What do you think.
> 
> Vivek Goyal (1):
>   fuse: Add a mode where fuse client sends mode changes on ACL change
> 
>  fs/fuse/acl.c             | 54 ++++++++++++++++++++++++++++++++++++---
>  fs/fuse/dir.c             | 11 ++++----
>  fs/fuse/fuse_i.h          |  9 ++++++-
>  fs/fuse/inode.c           |  4 ++-
>  include/uapi/linux/fuse.h |  5 ++++
>  5 files changed, 71 insertions(+), 12 deletions(-)
> 
> -- 
> 2.25.4
> 
