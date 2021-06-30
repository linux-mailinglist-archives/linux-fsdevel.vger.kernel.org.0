Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4023B850B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jun 2021 16:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235162AbhF3OaA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Jun 2021 10:30:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28140 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234913AbhF3O37 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Jun 2021 10:29:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625063250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1d2Jt0MNjAao88bTvZMUVLETujlEaYGrDFgnkx5mKjs=;
        b=XsZySUiHrOdq/3U0aUKyL9byqUdWqDCuKda3m7MzqANSFOIzzOKo5xtNX6f+7ntsfOSPgU
        xxg7sIRQRH/sZ6x3ortWbVea19X21pgW/Dcp9q0P4fiU5g0T0Sf3gQ36UJH4+Ze8gypurc
        Xr7NvyuItMnAypOlPx88uWkspuecTvk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-Pi9JRAE1PY6TXLuC1uOyNw-1; Wed, 30 Jun 2021 10:27:22 -0400
X-MC-Unique: Pi9JRAE1PY6TXLuC1uOyNw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE3D110C1ADC;
        Wed, 30 Jun 2021 14:27:19 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-222.rdu2.redhat.com [10.10.115.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 398F660854;
        Wed, 30 Jun 2021 14:27:16 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id B0B8222054F; Wed, 30 Jun 2021 10:27:15 -0400 (EDT)
Date:   Wed, 30 Jun 2021 10:27:15 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Daniel Walsh <dwalsh@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "virtio-fs@redhat.com" <virtio-fs@redhat.com>,
        "berrange@redhat.com" <berrange@redhat.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Subject: Re: [RFC PATCH 0/1] xattr: Allow user.* xattr on symlink/special
 files if caller has CAP_SYS_RESOURCE
Message-ID: <20210630142715.GB75386@redhat.com>
References: <5d8f033c-eba2-7a8b-f19a-1005bbb615ea@schaufler-ca.com>
 <YNn4p+Zn444Sc4V+@work-vm>
 <a13f2861-7786-09f4-99a8-f0a5216d0fb1@schaufler-ca.com>
 <YNrhQ9XfcHTtM6QA@work-vm>
 <e6f9ed0d-c101-01df-3dff-85c1b38f9714@schaufler-ca.com>
 <20210629152007.GC5231@redhat.com>
 <78663f5c-d2fd-747a-48e3-0c5fd8b40332@schaufler-ca.com>
 <20210629173530.GD5231@redhat.com>
 <f4992b3a-a939-5bc4-a5da-0ce8913bd569@redhat.com>
 <YNvvLIv16jY8mfP8@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNvvLIv16jY8mfP8@mit.edu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 30, 2021 at 12:12:28AM -0400, Theodore Ts'o wrote:
> On Tue, Jun 29, 2021 at 04:28:24PM -0400, Daniel Walsh wrote:
> > All this conversation is great, and I look forward to a better solution, but
> > if we go back to the patch, it was to fix an issue where the kernel is
> > requiring CAP_SYS_ADMIN for writing user Xattrs on link files and other
> > special files.
> > 
> > The documented reason for this is to prevent the users from using XATTRS to
> > avoid quota.
> 
> Huh?  Where is it so documented?

Its in "man xattr". David already copied pasted the relevant section in
another email, so I am not doing it.

> How file systems store and account
> for space used by extended attributes is a file-system specific
> question,

> but presumably any way that xattr's on regular files are
> accounted could also be used for xattr's on special files.

That will be nice. I don't know enough about quota, but I am wondering
why quota limits can't be enforced (if needed) for symlinks and special
file xattrs.

Thanks
Vivek
> 
> Also, xattr's are limited to 32k, so it's not like users can evade
> _that_ much quota space, at least not without it being pretty painful.
> (Assuming that quota is even enabled, which most of the time, it
> isn't.)
> 
> 						- Ted
> 
> P.S.  I'll note that if ext4's ea_in_inode is enabled, for large
> xattr's, if you have 2 million files that all have the same 12k
> windows SID stored as an xattr, ext4 will store that xattr only once.
> Those two million files might be owned by different uids, so we made
> an explicit design choice not to worry about accounting for the quota
> for said 12k xattr value.  After all, if you can save the space and
> access cost of 2M * 12k if each file had to store its own copy of that
> xattr, perhaps not including it in the quota calculation isn't that
> bad.  :-)
> 
> We also don't account for the disk space used by symbolic links (since
> sometimes they can be stored in the inode as fast symlinks, and
> sometimes they might consume a data block).  But again, that's a file
> system specific implementation question.
> 

