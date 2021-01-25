Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7981F30499C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 21:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732022AbhAZFZ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:25:59 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:52059 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728867AbhAYRHd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 12:07:33 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1l45K7-0006lj-0h; Mon, 25 Jan 2021 17:06:43 +0000
Date:   Mon, 25 Jan 2021 18:06:40 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
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
        =?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        smbarber@chromium.org, Phil Estes <estesp@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Paul Moore <paul@paul-moore.com>,
        Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v6 23/40] exec: handle idmapped mounts
Message-ID: <20210125170640.6ycsyod2ftxnzjzy@wittgenstein>
References: <20210121131959.646623-1-christian.brauner@ubuntu.com>
 <20210121131959.646623-24-christian.brauner@ubuntu.com>
 <875z3l0y56.fsf@x220.int.ebiederm.org>
 <20210125164404.aullgl3vlajgkef3@wittgenstein>
 <20210125170316.GA8345@mail.hallyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210125170316.GA8345@mail.hallyn.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 25, 2021 at 11:03:16AM -0600, Serge Hallyn wrote:
> On Mon, Jan 25, 2021 at 05:44:04PM +0100, Christian Brauner wrote:
> > On Mon, Jan 25, 2021 at 10:39:01AM -0600, Eric W. Biederman wrote:
> > > Christian Brauner <christian.brauner@ubuntu.com> writes:
> > > 
> > > > When executing a setuid binary the kernel will verify in bprm_fill_uid()
> > > > that the inode has a mapping in the caller's user namespace before
> > > > setting the callers uid and gid. Let bprm_fill_uid() handle idmapped
> > > > mounts. If the inode is accessed through an idmapped mount it is mapped
> > > > according to the mount's user namespace. Afterwards the checks are
> > > > identical to non-idmapped mounts. If the initial user namespace is
> > > > passed nothing changes so non-idmapped mounts will see identical
> > > > behavior as before.
> > > 
> > > This does not handle the v3 capabilites xattr with embeds a uid.
> > > So at least at that level you are missing some critical conversions.
> > 
> > Thanks for looking. Vfs v3 caps are handled earlier in the series. I'm
> > not sure what you're referring to here. There are tests in xfstests that
> > verify vfs3 capability behavior.
> 
> *just* to make sure i'm not misunderstanding - s/vfs3/v3/ right?

Yes, in my mind it's always as "vfs v3 caps -> vfs3 caps". Sorry for the
confusion.
