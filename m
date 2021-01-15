Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 335BA2F80B5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 17:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731555AbhAOQ0k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 11:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbhAOQ0k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 11:26:40 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620ACC061757;
        Fri, 15 Jan 2021 08:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Er+tBpIbbLuj0OIqdNy2chPN/Ve8hzD1kKT3RJP39d0=; b=rwXZgdKUw066MkReZNwTWvdrDZ
        +O+Z5xhLd7/kx+ppy6ccAkQPteVkBvNBYeFaNHb1vOy5WPgAW8pROAq3ALviE/ofBGb5Z0OIJ5+AX
        3aTO9JYoy07VWConrD3cxcC01n5AJ/XuQifDlQYUD7Zdk9xhYoZlPu08/WVLh1X6pEs1F95ixJXRs
        GvyrkCwwE3486p2RN5bLzW9J4juLcJMEweckdeecRjBTjh/0ItC7SFnldUzVWbPOEdW/VcDQv0rsX
        QN+h7onKLGjZ6CTuzd6MpZCvn+yYvVFCLUl5X+47PEYMBijpxrr/AfP2+Fj9IHKDJgSwUxYKCpsOi
        aoK+IQOA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l0Rtf-0099Fq-85; Fri, 15 Jan 2021 16:24:27 +0000
Date:   Fri, 15 Jan 2021 16:24:23 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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
        St?phane Graber <stgraber@ubuntu.com>,
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
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v5 00/42] idmapped mounts
Message-ID: <20210115162423.GB2179337@infradead.org>
References: <20210112220124.837960-1-christian.brauner@ubuntu.com>
 <20210114171241.GA1164240@magnolia>
 <20210114204334.GK331610@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114204334.GK331610@dread.disaster.area>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 15, 2021 at 07:43:34AM +1100, Dave Chinner wrote:
> > That sounds neat.  AFAICT, the VFS passes the filesystem a mount userns
> > structure, which is then carried down the call stack to whatever
> > functions actually care about mapping kernel [ug]ids to their ondisk
> > versions?
> > 
> > Does quota still work after this patchset is applied?  There isn't any
> > mention of that in the cover letter and I don't see a code patch, so
> > does that mean everything just works?  I'm particularly curious about
> > whether there can exist processes with CAP_SYS_ADMIN and an idmapped
> > mount?  Syscalls like bulkstat and quotactl present file [ug]ids to
> > programs, but afaict there won't be any translating going on?
> 
> bulkstat is not allowed inside user namespaces. It's an init
> namespace only thing because it provides unchecked/unbounded access
> to all inodes in the filesystem, not just those contained within a
> specific mount container.
> 
> Hence I don't think bulkstat output (and other initns+root only
> filesystem introspection APIs) should be subject to or concerned
> about idmapping.

That is what the capabilities are designed for and we already check
for them.
