Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5441C19FA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 17:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbgEAPq7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 11:46:59 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58979 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728495AbgEAPq7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 11:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588348018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=adGxmA8SUDKNs/1lSs2G3k6FTJH59kmGClkxE8d1FrQ=;
        b=PFbKJBdszRheq5ewXl0deMBonsHHqposLGMvF/G3CCyREHfEa1KOAohb9SI0eAX33fIh0h
        0jz7yXxlc69JzvCyHnE7CNgyDm2ptKAmdIw656AmZTzPY7QH0xSazMdfJJ7P5MPV4sBfPy
        uMk/LyiFmlmvGL78bqU+DfKxMXC2gAU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-Q_KY00XmNDumo7wyp6vtkQ-1; Fri, 01 May 2020 11:46:54 -0400
X-MC-Unique: Q_KY00XmNDumo7wyp6vtkQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7376835B43;
        Fri,  1 May 2020 15:46:52 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-230.rdu2.redhat.com [10.10.115.230])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BFC956A94A;
        Fri,  1 May 2020 15:46:52 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 4E18C223620; Fri,  1 May 2020 11:46:52 -0400 (EDT)
Date:   Fri, 1 May 2020 11:46:52 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Chirantan Ekbote <chirantan@chromium.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        fuse-devel@lists.sourceforge.net,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: fuse doesn't use security_inode_init_security?
Message-ID: <20200501154652.GA285331@redhat.com>
References: <CAJFHJroyC8SAFJZuQxcwHqph5EQRg=MqFdvfnwbK35Cv-A-neA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJFHJroyC8SAFJZuQxcwHqph5EQRg=MqFdvfnwbK35Cv-A-neA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 01, 2020 at 03:55:20PM +0900, Chirantan Ekbote wrote:
> Hello,
> 
> I noticed that the fuse module doesn't currently call
> security_inode_init_security and I was wondering if there is a
> specific reason for that.  I found a patch from 2013[1] that would
> change fuse so that it would call that function but it doesn't appear
> that the patch was merged.
> 
> For background: I currently have a virtio-fs server with a guest VM
> that wants to use selinux.  I was able to enable selinux support
> without much issue by adding
> 
>     fs_use_xattr virtiofs u:object_r:labeledfs:s0;
> 
> to the selinux policy in the guest.  This works for the most part
> except that `setfscreatecon` doesn't appear to work.  From what I can
> tell, this ends up writing to `/proc/[pid]/attr/fscreate` and the
> attributes actually get set via the `inode_init_security` lsm hook in
> selinux.  However, since fuse doesn't call
> `security_inode_init_security` the hook never runs so the
> file/directory doesn't have the right attributes.
> 
> Is it safe to just call `security_inode_init_security` whenever fuse
> creates a new inode?  How does this affect non-virtiofs fuse servers?
> Would we need a new flag so that servers could opt-in to this behavior
> like in the patch from [1]?

I am wondering how would fuse initialize the security context of newly
created file. One way seems to be that it passes that information
as part of FUSE_CREATE/FUSE_MKNOD calls to server and server sets
its "fscreate" accordingly and then creates new file. This is similar
to virtiofsd changing its effective uid/gid to the fuse client so that
file is created with caller's uid/gid. Seems to be selinux context for
file creation probably should be handled similiarly.

Other method could be to first create new file and then new fuse
commands to do setxattrs. But that will be racy as file will have
some default label for sometime between creation and setxattr.

Having said that, I have a question. How do you reconcile host selinux
policy and guest selinux labels. I am assuming host selinux policy
will have to know about guest labels so that it allows virtiofsd do
set those labels? Dan, you might have more thoughts on this.

Thanks
Vivek

