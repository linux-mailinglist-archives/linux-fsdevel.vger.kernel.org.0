Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31F62F89EB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Jan 2021 01:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbhAPA2N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 19:28:13 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:60998 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbhAPA2N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 19:28:13 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1l0ZR2-0002Mr-95; Sat, 16 Jan 2021 00:27:20 +0000
Date:   Sat, 16 Jan 2021 01:27:18 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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
        Alban Crequy <alban@kinvolk.io>,
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
Message-ID: <20210116002718.jjs6eov65cvwrata@wittgenstein>
References: <20210112220124.837960-1-christian.brauner@ubuntu.com>
 <20210114171241.GA1164240@magnolia>
 <20210114204334.GK331610@dread.disaster.area>
 <20210115162423.GB2179337@infradead.org>
 <YAHWGMb9rTehRsRz@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YAHWGMb9rTehRsRz@mit.edu>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 15, 2021 at 12:51:20PM -0500, Theodore Ts'o wrote:
> On Fri, Jan 15, 2021 at 04:24:23PM +0000, Christoph Hellwig wrote:
> > 
> > That is what the capabilities are designed for and we already check
> > for them.
> 
> So perhaps I'm confused, but my understanding is that in the
> containers world, capabilities are a lot more complicated.  There is:
> 
> 1) The initial namespace capability set
> 
> 2) The container's user-namespace capability set
> 
> 3) The namespace in which the file system is mounted --- which is
>       "usually, but not necessarily the initial namespace" and
>       presumably could potentially not necessarily be the current
>       container's user name space, is namespaces can be hierarchically
>       arranged.
> 
> Is that correct?  If so, how does this patch set change things (if
> any), and and how does this interact with quota administration
> operations?

The cases you listed are correct. The patchset doesn't change them.
Simply put, the patchset doesn't alter capability checking in any way.

> 
> On a related note, ext4 specifies a "reserved user" or "reserved
> group" which can access the reserved blocks.  If we have a file system
> which is mounted in a namespace running a container which is running
> RHEL or SLES, and in that container, we have a file system mounted (so
> it was not mounted in the initial namespace), with id-mapping --- and
> then there is a further sub-container created with its own user
> sub-namespace further mapping uids/gids --- will the right thing
> happen?  For that matter, how *is* the "right thing" defined?

In short, nothing changes. Whatever happened before happens now.

Specifically s_resuid/s_resgid are superblock mount options and so never
change on a per-mount basis and thus also aren't affected by idmapped
mounts.

> 
> Sorry if this is a potentially stupid question, but I find user
> namespaces and id and capability mapping to be hopefully confusing for
> my tiny brain.  :-)

No, I really appreciate the questions. :) My brain can most likely
handle less. :)

Christian
