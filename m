Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7A743B920C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jul 2021 15:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236589AbhGANNN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jul 2021 09:13:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39072 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236614AbhGANNN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jul 2021 09:13:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625145042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D1mka1MCqXkPMDnOJSpZhf+XXpeG/R7ugnhLphP29nc=;
        b=gyj3jmsY+RIBYFT3yduRG4lqo9MYEcm9EOVIkjAUg9KmBS3PFL9rCWMVWh6W2GnydhZ+Dr
        huHtV5oVvU9smRGPvvDXRpcfcUD8g+zlOjYDkWPhJVZoCuUQ11Xjek07NsI+P+qPi33q7R
        mk9/uSwlRPAM4+jeIoSxCl81c0Q8AF4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-Hdamh4NqM0i13Qq9_7jUYA-1; Thu, 01 Jul 2021 09:10:41 -0400
X-MC-Unique: Hdamh4NqM0i13Qq9_7jUYA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2992A80292A;
        Thu,  1 Jul 2021 13:10:39 +0000 (UTC)
Received: from horse.redhat.com (ovpn-113-118.rdu2.redhat.com [10.10.113.118])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E524F60C13;
        Thu,  1 Jul 2021 13:10:30 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 372C822054F; Thu,  1 Jul 2021 09:10:30 -0400 (EDT)
Date:   Thu, 1 Jul 2021 09:10:30 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Daniel Walsh <dwalsh@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
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
Message-ID: <20210701131030.GB159380@redhat.com>
References: <20210629152007.GC5231@redhat.com>
 <78663f5c-d2fd-747a-48e3-0c5fd8b40332@schaufler-ca.com>
 <20210629173530.GD5231@redhat.com>
 <f4992b3a-a939-5bc4-a5da-0ce8913bd569@redhat.com>
 <YNvvLIv16jY8mfP8@mit.edu>
 <YNwmXOqT7LgbeVPn@work-vm>
 <YNyECw/1FzDCW3G8@mit.edu>
 <YNyHVhGPe1bFAt+C@work-vm>
 <YNzNLTxflKbDi8W2@mit.edu>
 <YN2BYXv79PswrN2E@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YN2BYXv79PswrN2E@work-vm>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 01, 2021 at 09:48:33AM +0100, Dr. David Alan Gilbert wrote:
> * Theodore Ts'o (tytso@mit.edu) wrote:
> > On Wed, Jun 30, 2021 at 04:01:42PM +0100, Dr. David Alan Gilbert wrote:
> > > 
> > > Even if you fix symlinks, I don't think it fixes device nodes or
> > > anything else where the permissions bitmap isn't purely used as the
> > > permissions on the inode.
> > 
> > I think we're making a mountain out of a molehill.  Again, very few
> > people are using quota these days.  And if you give someone write
> > access to a 8TB disk, do you really care if they can "steal" 32k worth
> > of space (which is the maximum size of an xattr, enforced by the VFS).
> > 
> > OK, but what about character mode devices?  First of all, most users
> > don't have access to huge number of devices, but let's assume
> > something absurd.  Let's say that a user has write access to *1024*
> > devices.  (My /dev has 233 character mode devices, and I have write
> > access to well under a dozen.)
> > 
> > An 8TB disk costs about $200.  So how much of the "stolen" quota space
> > are we talking about, assuming the user has access to 1024 devices,
> > and the file system actually supports a 32k xattr.
> > 
> >     32k * 1024 * $200 / 8TB / (1024*1024*1024) = $0.000763 = 0.0763 cents
> > 
> > A 2TB SSD is less around $180, so even if we calculate the prices
> > based on SSD space, we're still talking about a quarter of a penny.
> > 
> > Why are we worrying about this?
> 
> I'm not worrying about storage cost, but we would need to define what
> the rules are on who can write and change a user.* xattr on a device
> node.  It doesn't feel sane to make it anyone who can write to the
> device; then everyone can start leaving droppings on /dev/null.
> 
> The other evilness I can imagine, is if there's a 32k limit on xattrs on
> a node, an evil user could write almost 32k of junk to the node
> and then break the next login that tries to add an acl or breaks the
> next relabel.

I guess 64k is per xattr VFS size limit.

#define XATTR_SIZE_MAX 65536

I just wrote a simple program to write "user.<N>" xattrs of size 1K
each and could easily write 1M xattrs. So that 1G worth data right
there. I did not try to push it further.

So a user can write lot of data in the form of user.* xattrs on
symlinks and device nodes if were to open it unconditionally. Hence
permission semantics will probably will have to defined properly.

I am wondering will it be alright if owner of the file (or CAP_FOWNER),
is allowed to write user.* xattrs on symlinks and special files.

Vivek

