Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873F52FC43D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 23:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391080AbhASOZp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 09:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732622AbhASJXP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 04:23:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FF9C061573;
        Tue, 19 Jan 2021 01:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8CnqJfggo7kaSxEGLE1dXWml/p5HVDe2QcHu8G5xzpE=; b=B/SF+oWpDEp4Ow/6qcRj1Pjtuc
        ZTgPRyBXj6uvJk2kKGr1zBt+JZJx3z/Ge42kzCCxBwj24xTNtoscGGc8tBtyTWazzdta2HMlw2rxX
        GBqbhVRzbwxIbrObTT5WMZL/+bEHg4a7SpO6xwoijVGm9hlDxYcVFxT4RwlU4nqM8xZxyzScZISk3
        VCXLak/ZtbHGP+jNdjz9dqXFHrMWmmXZHfzHAdLnIquDP0kLPFjkHlVLKeFGqwpKVTHj+m6UwvADV
        qrwMy1bfJkq7V7gHv7Ej0mYvbwwatOwTL22s0adqKcO3VN4V5pG1ioZ7deJCA9RINgyNMj+FTYPJd
        2C3UBbrg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l1nDF-00E6mf-Sl; Tue, 19 Jan 2021 09:22:11 +0000
Date:   Tue, 19 Jan 2021 09:22:09 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Mrunal Patel <mpatel@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Andy Lutomirski <luto@kernel.org>,
        Theodore Tso <tytso@mit.edu>, Alban Crequy <alban@kinvolk.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        St??phane Graber <stgraber@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>, smbarber@chromium.org,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Paul Moore <paul@paul-moore.com>,
        Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v5 10/42] capability: handle idmapped mounts
Message-ID: <20210119092209.GB3361757@infradead.org>
References: <20210112220124.837960-1-christian.brauner@ubuntu.com>
 <20210112220124.837960-11-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112220124.837960-11-christian.brauner@ubuntu.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 12, 2021 at 11:00:52PM +0100, Christian Brauner wrote:
> In order to determine whether a caller holds privilege over a given
> inode the capability framework exposes the two helpers
> privileged_wrt_inode_uidgid() and capable_wrt_inode_uidgid(). The former
> verifies that the inode has a mapping in the caller's user namespace and
> the latter additionally verifies that the caller has the requested
> capability in their current user namespace.
> If the inode is accessed through an idmapped mount we simply need to map
> it according to the mount's user namespace. Afterwards the checks are
> identical to non-idmapped inodes. If the initial user namespace is
> passed all operations are a nop so non-idmapped mounts will not see a
> change in behavior and will also not see any performance impact.

This adds a bunch of pointless > 80 char lines, that would be nice to
fix up.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
