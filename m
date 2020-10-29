Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C62D29F0FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 17:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgJ2QPT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 12:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbgJ2QPS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 12:15:18 -0400
X-Greylist: delayed 611 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 29 Oct 2020 09:15:18 PDT
Received: from gardel.0pointer.net (gardel.0pointer.net [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BF6C0613CF;
        Thu, 29 Oct 2020 09:15:18 -0700 (PDT)
Received: from gardel-login.0pointer.net (gardel.0pointer.net [85.214.157.71])
        by gardel.0pointer.net (Postfix) with ESMTP id 8D3CAE80409;
        Thu, 29 Oct 2020 17:05:05 +0100 (CET)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id E22A4160834; Thu, 29 Oct 2020 17:05:03 +0100 (CET)
Date:   Thu, 29 Oct 2020 17:05:02 +0100
From:   Lennart Poettering <lennart@poettering.net>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
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
        Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Theodore Tso <tytso@mit.edu>, Alban Crequy <alban@kinvolk.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jann Horn <jannh@google.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@ubuntu.com>,
        Aleksa Sarai <cyphar@cyphar.com>, smbarber@chromium.org,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-audit@redhat.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org
Subject: Re: [PATCH 00/34] fs: idmapped mounts
Message-ID: <20201029160502.GA333141@gardel-login>
References: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
 <87pn51ghju.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pn51ghju.fsf@x220.int.ebiederm.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Do, 29.10.20 10:47, Eric W. Biederman (ebiederm@xmission.com) wrote:

> Is that the use case you are looking at removing the need for
> systemd-homed to avoid chowning after lugging encrypted home directories
> from one system to another?  Why would it be desirable to avoid the
> chown?

Yes, I am very interested in seeing Christian's work succeed, for the
usecase in systemd-homed. In systemd-homed each user gets their own
private file system, and these fs shall be owned by the user's local
UID, regardless in which system it is used. The UID should be an
artifact of the local, individual system in this model, and thus
the UID on of the same user/home on system A might be picked as 1010
and on another as 1543, and on a third as 1323, and it shouldn't
matter. This way, home directories become migratable without having to
universially sync UID assignments: it doesn't matter anymore what the
local UID is.

Right now we do a recursive chown() at login time to ensure the home
dir is properly owned. This has two disadvantages:

1. It's slow. In particular on large home dirs, it takes a while to go
   through the whole user's homedir tree and chown/adjust ACLs for
   everything.

2. Because it is so slow we take a shortcut right now: if the
   top-level home dir inode itself is owned by the correct user, we
   skip the recursive chowning. This means in the typical case where a
   user uses the same system most of the time, and thus the UID is
   stable we can avoid the slowness. But this comes at a drawback: if
   the user for some reason ends up with files in their homedir owned
   by an unrelated user, then we'll never notice or readjust.

> If the goal is to solve fragmented administration of uid assignment I
> suggest that it might be better to solve the administration problem so
> that all of the uids of interest get assigned the same way on all of the
> systems of interest.

Well, the goal is to make things simple and be able to use the home
dir everywhere without any prior preparation, without central UID
assignment authority.

The goal is to have a scheme that requires no administration, by
making the UID management problem go away. Hence, if you suggest
solving this by having a central administrative authority: this is
exactly what the model wants to get away from.

Or to say this differently: just because I personally use three
different computers, I certainly don't want to set up LDAP or sync
UIDs manually.

Lennart

--
Lennart Poettering, Berlin
