Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4D63C63C8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 21:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236440AbhGLTeb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 15:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236190AbhGLTe2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 15:34:28 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C29C0613DD;
        Mon, 12 Jul 2021 12:31:40 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 485F269D6; Mon, 12 Jul 2021 15:31:39 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 485F269D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1626118299;
        bh=Zn3SvcMF3FFO49+WTI8pt7ML3V5uhGmeYXXeqsXQrcY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v8DlyIayyg8yDjwJfuxsFYTJvh+t9cDW+Uz+VYzSDSXEbEke0mosrcMLlzmpjVmDX
         06wu4GYGB/ZF34UAZkd7LRQK1LLMfmlqQkWptRk7aDVwFxxNO8dF2uGtyK7jm+7Tbu
         RIR8atVX3reEl7AA0HxjsvEmxSoIIB5kZMNxDEwg=
Date:   Mon, 12 Jul 2021 15:31:39 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Bruce Fields <bfields@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, virtio-fs@redhat.com, dwalsh@redhat.com,
        dgilbert@redhat.com, casey.schaufler@intel.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        tytso@mit.edu, miklos@szeredi.hu, gscrivan@redhat.com,
        jack@suse.cz, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 1/1] xattr: Allow user.* xattr on symlink and special
 files
Message-ID: <20210712193139.GA22997@fieldses.org>
References: <20210708175738.360757-1-vgoyal@redhat.com>
 <20210708175738.360757-2-vgoyal@redhat.com>
 <20210709091915.2bd4snyfjndexw2b@wittgenstein>
 <20210709152737.GA398382@redhat.com>
 <710d1c6f-d477-384f-0cc1-8914258f1fb1@schaufler-ca.com>
 <20210709175947.GB398382@redhat.com>
 <CAPL3RVGKg4G5qiiHo7KYPcsWWgeoW=qNPOSQpd3Sv329jrWrLQ@mail.gmail.com>
 <20210712140247.GA486376@redhat.com>
 <20210712154106.GB18679@fieldses.org>
 <20210712174759.GA502004@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712174759.GA502004@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 12, 2021 at 01:47:59PM -0400, Vivek Goyal wrote:
> On Mon, Jul 12, 2021 at 11:41:06AM -0400, J. Bruce Fields wrote:
> > Looks like 0xd is what the server returns to access on a device node
> > with mode bits rw- for the caller.
> > 
> > Commit c11d7fd1b317 "nfsd: take xattr bits into account for permission
> > checks" added the ACCESS_X* bits for regular files and directories but
> > not others.
> > 
> > But you don't want to determine permission from the mode bits anyway,
> > you want it to depend on the owner,
> 
> Thinking more about this part. Current implementation of my patch is
> effectively doing both the checks. It checks that you are owner or
> have CAP_FOWNER in xattr_permission() and then goes on to call
> inode_permission(). And that means file mode bits will also play a
> role. If caller does not have write permission on the file, it will
> be denied setxattr().
> 
> If I don't call inode_permission(), and just return 0 right away for
> file owner (for symlinks and special files), then just being owner
> is enough to write user.* xattr. And then even security modules will
> not get a chance to block that operation. IOW, if you are owner of
> a symlink or special file, you can write as many user.* xattr as you
> like and except quota does not look like anything else can block
> it. I am wondering if this approach is ok?

Yeah, I'd expect security modules to get a say, and I wouldn't expect
mode bits on device nodes to be useful for deciding whether it makes
sense for xattrs to be readable or writeable.

But, I don't really know.

Do we have any other use cases besides this case of storing security
labels in user xattrs?

--b.
