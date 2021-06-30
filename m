Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 993753B7C77
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jun 2021 06:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbhF3EPJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Jun 2021 00:15:09 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:49810 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229446AbhF3EPI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Jun 2021 00:15:08 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 15U4CT7S009691
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Jun 2021 00:12:29 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0BBE815C3C8E; Wed, 30 Jun 2021 00:12:28 -0400 (EDT)
Date:   Wed, 30 Jun 2021 00:12:28 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Daniel Walsh <dwalsh@redhat.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
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
Message-ID: <YNvvLIv16jY8mfP8@mit.edu>
References: <1b446468-dcf8-9e21-58d3-c032686eeee5@redhat.com>
 <5d8f033c-eba2-7a8b-f19a-1005bbb615ea@schaufler-ca.com>
 <YNn4p+Zn444Sc4V+@work-vm>
 <a13f2861-7786-09f4-99a8-f0a5216d0fb1@schaufler-ca.com>
 <YNrhQ9XfcHTtM6QA@work-vm>
 <e6f9ed0d-c101-01df-3dff-85c1b38f9714@schaufler-ca.com>
 <20210629152007.GC5231@redhat.com>
 <78663f5c-d2fd-747a-48e3-0c5fd8b40332@schaufler-ca.com>
 <20210629173530.GD5231@redhat.com>
 <f4992b3a-a939-5bc4-a5da-0ce8913bd569@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4992b3a-a939-5bc4-a5da-0ce8913bd569@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 29, 2021 at 04:28:24PM -0400, Daniel Walsh wrote:
> All this conversation is great, and I look forward to a better solution, but
> if we go back to the patch, it was to fix an issue where the kernel is
> requiring CAP_SYS_ADMIN for writing user Xattrs on link files and other
> special files.
> 
> The documented reason for this is to prevent the users from using XATTRS to
> avoid quota.

Huh?  Where is it so documented?  How file systems store and account
for space used by extended attributes is a file-system specific
question, but presumably any way that xattr's on regular files are
accounted could also be used for xattr's on special files.

Also, xattr's are limited to 32k, so it's not like users can evade
_that_ much quota space, at least not without it being pretty painful.
(Assuming that quota is even enabled, which most of the time, it
isn't.)

						- Ted

P.S.  I'll note that if ext4's ea_in_inode is enabled, for large
xattr's, if you have 2 million files that all have the same 12k
windows SID stored as an xattr, ext4 will store that xattr only once.
Those two million files might be owned by different uids, so we made
an explicit design choice not to worry about accounting for the quota
for said 12k xattr value.  After all, if you can save the space and
access cost of 2M * 12k if each file had to store its own copy of that
xattr, perhaps not including it in the quota calculation isn't that
bad.  :-)

We also don't account for the disk space used by symbolic links (since
sometimes they can be stored in the inode as fast symlinks, and
sometimes they might consume a data block).  But again, that's a file
system specific implementation question.
