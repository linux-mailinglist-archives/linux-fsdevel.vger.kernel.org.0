Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 375DD300FF5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 23:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbhAVW2H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 17:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728339AbhAVW1P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 17:27:15 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28C6C0613D6;
        Fri, 22 Jan 2021 14:26:33 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 7A21F6E97; Fri, 22 Jan 2021 17:26:32 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 7A21F6E97
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1611354392;
        bh=tn+w8soQQzYWtoSEcV96aJkWCYx83kxrSGAkTTiabXA=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=X95z07vjZOjjzvjgzPtwDISRZ7bvRExOKROMoiBfzTUzhunQZq5I6fG0Ld2Gva7Mh
         uhaRbZ9MkPgDEawpF8wGyueWVNQbXPl+6a+P6MAo2vQtm02J9ggMsib5nOD7Na/V0s
         n9s4jAoDv+n/KWmXQQLflLSFjjV3dqCb/wYkVXv0=
Date:   Fri, 22 Jan 2021 17:26:32 -0500
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
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
        "Eric W. Biederman" <ebiederm@xmission.com>, smbarber@chromium.org,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Paul Moore <paul@paul-moore.com>,
        Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v6 05/39] namei: make permission helpers idmapped mount
 aware
Message-ID: <20210122222632.GB25405@fieldses.org>
References: <20210121131959.646623-1-christian.brauner@ubuntu.com>
 <20210121131959.646623-6-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121131959.646623-6-christian.brauner@ubuntu.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If I NFS-exported an idmapped mount, I think I'd expect idmapped clients
to see the mapped IDs.

Looks like that means taking the user namespace from the struct
svc_export everwhere, for example:

On Thu, Jan 21, 2021 at 02:19:24PM +0100, Christian Brauner wrote:
> index 66f2ef67792a..8d90796e236a 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -40,7 +40,8 @@ static int nfsd_acceptable(void *expv, struct dentry *dentry)
>  		/* make sure parents give x permission to user */
>  		int err;
>  		parent = dget_parent(tdentry);
> -		err = inode_permission(d_inode(parent), MAY_EXEC);
> +		err = inode_permission(&init_user_ns,
> +				       d_inode(parent), MAY_EXEC);

		err = inode_permission(exp->ex_path.mnt->mnt_userns,
				      d_inode(parent, MAY_EXEC);

?

--b.
