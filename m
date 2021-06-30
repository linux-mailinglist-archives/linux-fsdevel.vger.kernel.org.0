Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1593B8963
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jun 2021 21:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbhF3UCV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Jun 2021 16:02:21 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35779 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233693AbhF3UCU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Jun 2021 16:02:20 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 15UJxfAp014915
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Jun 2021 15:59:42 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7001C15C3C8E; Wed, 30 Jun 2021 15:59:41 -0400 (EDT)
Date:   Wed, 30 Jun 2021 15:59:41 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc:     Daniel Walsh <dwalsh@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
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
Message-ID: <YNzNLTxflKbDi8W2@mit.edu>
References: <YNrhQ9XfcHTtM6QA@work-vm>
 <e6f9ed0d-c101-01df-3dff-85c1b38f9714@schaufler-ca.com>
 <20210629152007.GC5231@redhat.com>
 <78663f5c-d2fd-747a-48e3-0c5fd8b40332@schaufler-ca.com>
 <20210629173530.GD5231@redhat.com>
 <f4992b3a-a939-5bc4-a5da-0ce8913bd569@redhat.com>
 <YNvvLIv16jY8mfP8@mit.edu>
 <YNwmXOqT7LgbeVPn@work-vm>
 <YNyECw/1FzDCW3G8@mit.edu>
 <YNyHVhGPe1bFAt+C@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNyHVhGPe1bFAt+C@work-vm>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 30, 2021 at 04:01:42PM +0100, Dr. David Alan Gilbert wrote:
> 
> Even if you fix symlinks, I don't think it fixes device nodes or
> anything else where the permissions bitmap isn't purely used as the
> permissions on the inode.

I think we're making a mountain out of a molehill.  Again, very few
people are using quota these days.  And if you give someone write
access to a 8TB disk, do you really care if they can "steal" 32k worth
of space (which is the maximum size of an xattr, enforced by the VFS).

OK, but what about character mode devices?  First of all, most users
don't have access to huge number of devices, but let's assume
something absurd.  Let's say that a user has write access to *1024*
devices.  (My /dev has 233 character mode devices, and I have write
access to well under a dozen.)

An 8TB disk costs about $200.  So how much of the "stolen" quota space
are we talking about, assuming the user has access to 1024 devices,
and the file system actually supports a 32k xattr.

    32k * 1024 * $200 / 8TB / (1024*1024*1024) = $0.000763 = 0.0763 cents

A 2TB SSD is less around $180, so even if we calculate the prices
based on SSD space, we're still talking about a quarter of a penny.

Why are we worrying about this?

						- Ted
