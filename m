Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D3D2F8300
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 18:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbhAORxM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 12:53:12 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:33202 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726402AbhAORxL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:53:11 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 10FHpKnV022119
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jan 2021 12:51:21 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3494715C399F; Fri, 15 Jan 2021 12:51:20 -0500 (EST)
Date:   Fri, 15 Jan 2021 12:51:20 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
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
Message-ID: <YAHWGMb9rTehRsRz@mit.edu>
References: <20210112220124.837960-1-christian.brauner@ubuntu.com>
 <20210114171241.GA1164240@magnolia>
 <20210114204334.GK331610@dread.disaster.area>
 <20210115162423.GB2179337@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115162423.GB2179337@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 15, 2021 at 04:24:23PM +0000, Christoph Hellwig wrote:
> 
> That is what the capabilities are designed for and we already check
> for them.

So perhaps I'm confused, but my understanding is that in the
containers world, capabilities are a lot more complicated.  There is:

1) The initial namespace capability set

2) The container's user-namespace capability set

3) The namespace in which the file system is mounted --- which is
      "usually, but not necessarily the initial namespace" and
      presumably could potentially not necessarily be the current
      container's user name space, is namespaces can be hierarchically
      arranged.

Is that correct?  If so, how does this patch set change things (if
any), and and how does this interact with quota administration
operations?

On a related note, ext4 specifies a "reserved user" or "reserved
group" which can access the reserved blocks.  If we have a file system
which is mounted in a namespace running a container which is running
RHEL or SLES, and in that container, we have a file system mounted (so
it was not mounted in the initial namespace), with id-mapping --- and
then there is a further sub-container created with its own user
sub-namespace further mapping uids/gids --- will the right thing
happen?  For that matter, how *is* the "right thing" defined?

Sorry if this is a potentially stupid question, but I find user
namespaces and id and capability mapping to be hopefully confusing for
my tiny brain.  :-)

						- Ted
