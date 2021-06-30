Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 226953B89C2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jun 2021 22:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbhF3Ufh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Jun 2021 16:35:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59302 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234292AbhF3Ufg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Jun 2021 16:35:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625085186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1BKKapww4d5wegIAyWjvMjJRL130mUGbMRABPEvALVk=;
        b=Et5T/mL8ytpdekf7obTngcnbN7LFbysRQgG0X0OJNxFvTFbR0UEJYm5IxodUnPyPLG45mU
        h+YNSt62FGc5pfX41nJJMITjeIlrgaQiwRNzbI+Xhz8EnQGDotAOJA0pExpGUeQEf02hs7
        gEY9dZ09SRiFW4w6vpKoyD5Jz1kY1yM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-3HmKpcuZNr2C0JrClYUolw-1; Wed, 30 Jun 2021 16:33:04 -0400
X-MC-Unique: 3HmKpcuZNr2C0JrClYUolw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51B45100CCC0;
        Wed, 30 Jun 2021 20:33:03 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-222.rdu2.redhat.com [10.10.115.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7088B10027A5;
        Wed, 30 Jun 2021 20:32:59 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 9E1AE22054F; Wed, 30 Jun 2021 16:32:58 -0400 (EDT)
Date:   Wed, 30 Jun 2021 16:32:58 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Daniel Walsh <dwalsh@redhat.com>,
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
Message-ID: <20210630203258.GE75386@redhat.com>
References: <e6f9ed0d-c101-01df-3dff-85c1b38f9714@schaufler-ca.com>
 <20210629152007.GC5231@redhat.com>
 <78663f5c-d2fd-747a-48e3-0c5fd8b40332@schaufler-ca.com>
 <20210629173530.GD5231@redhat.com>
 <f4992b3a-a939-5bc4-a5da-0ce8913bd569@redhat.com>
 <YNvvLIv16jY8mfP8@mit.edu>
 <YNwmXOqT7LgbeVPn@work-vm>
 <YNyECw/1FzDCW3G8@mit.edu>
 <YNyHVhGPe1bFAt+C@work-vm>
 <YNzNLTxflKbDi8W2@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNzNLTxflKbDi8W2@mit.edu>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 30, 2021 at 03:59:41PM -0400, Theodore Ts'o wrote:
> On Wed, Jun 30, 2021 at 04:01:42PM +0100, Dr. David Alan Gilbert wrote:
> > 
> > Even if you fix symlinks, I don't think it fixes device nodes or
> > anything else where the permissions bitmap isn't purely used as the
> > permissions on the inode.
> 
> I think we're making a mountain out of a molehill.  Again, very few
> people are using quota these days.  And if you give someone write
> access to a 8TB disk, do you really care if they can "steal" 32k worth
> of space (which is the maximum size of an xattr, enforced by the VFS).

So that should be N * 32K per inode, where N is number of user xattrs
one can write on the inode. (user.1, user.2, user.3, .., user.N)?

Vivek

> 
> OK, but what about character mode devices?  First of all, most users
> don't have access to huge number of devices, but let's assume
> something absurd.  Let's say that a user has write access to *1024*
> devices.  (My /dev has 233 character mode devices, and I have write
> access to well under a dozen.)
> 
> An 8TB disk costs about $200.  So how much of the "stolen" quota space
> are we talking about, assuming the user has access to 1024 devices,
> and the file system actually supports a 32k xattr.
> 
>     32k * 1024 * $200 / 8TB / (1024*1024*1024) = $0.000763 = 0.0763 cents
> 
> A 2TB SSD is less around $180, so even if we calculate the prices
> based on SSD space, we're still talking about a quarter of a penny.
> 
> Why are we worrying about this?
> 
> 						- Ted
> 

