Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E052FC428
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 23:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395076AbhASO0U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 09:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732735AbhASJYB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 04:24:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F39C061574;
        Tue, 19 Jan 2021 01:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kxnpvdEioqW2SL/zS2zHQR8JutL4B883AHpsl2zQebg=; b=it9Hptg7/g4IK+bZS7OVTPBwvu
        uEJwSofsw371xci3PeKBU/FjZML7V0mhZqDGM/lGkG2sEfj+XX/v3+r6ucKos47mtHBGfRbdfMl7S
        mkKi8Qz9aZJcYyRsKs3CCkAXK63lVddcXS3y+EWvEwVQDRWIIC6QPa9t3tWIdAHTiHQYwDv9eLGWR
        1R5YiOHnEr/nZ/SA58AW5jMykRQpkhcbJSWRZTR9AwuJy05gz+2oKe4MpWZyRaKOG5Xyg2lLZ2iQG
        o80tSyIExjTsT8UaNxFm8eZuQOOzWCnxZ6GCz3SWZtCIlSZ2x15M2bHcfBr5kdAwznSdV2VpZUcXh
        yDnrc9Fg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l1nEK-00E6t0-Rv; Tue, 19 Jan 2021 09:23:17 +0000
Date:   Tue, 19 Jan 2021 09:23:16 +0000
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
Subject: Re: [PATCH v5 11/42] namei: make permission helpers idmapped mount
 aware
Message-ID: <20210119092316.GC3361757@infradead.org>
References: <20210112220124.837960-1-christian.brauner@ubuntu.com>
 <20210112220124.837960-12-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112220124.837960-12-christian.brauner@ubuntu.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 12, 2021 at 11:00:53PM +0100, Christian Brauner wrote:
> The two helpers inode_permission() and generic_permission() are used by
> the vfs to perform basic permission checking by verifying that the
> caller is privileged over an inode. In order to handle idmapped mounts
> we extend the two helpers with an additional user namespace argument.
> On idmapped mounts the two helpers will make sure to map the inode
> according to the mount's user namespace and then peform identical
> permission checks to inode_permission() and generic_permission(). If the
> initial user namespace is passed nothing changes so non-idmapped mounts
> will see identical behavior as before.

More long lines in here.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
