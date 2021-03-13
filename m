Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDDAF339A46
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Mar 2021 01:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235917AbhCMAF6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Mar 2021 19:05:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39869 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229968AbhCMAFm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Mar 2021 19:05:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615593941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mVXvmcYP1sSR9GWfD7PGzVWbpYUCA5Ac+5UF3mw/8Ks=;
        b=en25UQwrJkeJku5zlYHghg+cRQDUgKlT1EQkPYv59oW0lRnGkTBYPO1lZ3gRyLAzfLRi+Y
        TEVLWuy5mZh/vAgjSD8xBHPycXYa1eN/2EFxKpUmEXOazpYI8Gu0V/T+uOJfw3LVcsEEiB
        dbsTJ7+c2MT61fH/gnBqBNHNeUtxGfQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-GopGBo6-M_m5rNeEHuJOdg-1; Fri, 12 Mar 2021 19:05:39 -0500
X-MC-Unique: GopGBo6-M_m5rNeEHuJOdg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1783939382;
        Sat, 13 Mar 2021 00:05:34 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-2.rdu2.redhat.com [10.10.114.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B94811F065;
        Sat, 13 Mar 2021 00:05:29 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 49B3622054F; Fri, 12 Mar 2021 19:05:29 -0500 (EST)
Date:   Fri, 12 Mar 2021 19:05:29 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
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
        =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@ubuntu.com>,
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
Subject: Re: [PATCH v6 02/40] fs: add id translation helpers
Message-ID: <20210313000529.GA181317@redhat.com>
References: <20210121131959.646623-1-christian.brauner@ubuntu.com>
 <20210121131959.646623-3-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121131959.646623-3-christian.brauner@ubuntu.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 21, 2021 at 02:19:21PM +0100, Christian Brauner wrote:
> Add simple helpers to make it easy to map kuids into and from idmapped
> mounts. We provide simple wrappers that filesystems can use to e.g.
> initialize inodes similar to i_{uid,gid}_read() and i_{uid,gid}_write().
> Accessing an inode through an idmapped mount maps the i_uid and i_gid of
> the inode to the mount's user namespace. If the fsids are used to
> initialize inodes they are unmapped according to the mount's user
> namespace. Passing the initial user namespace to these helpers makes
> them a nop and so any non-idmapped paths will not be impacted.
> 
> Link: https://lore.kernel.org/r/20210112220124.837960-9-christian.brauner@ubuntu.com
> Cc: David Howells <dhowells@redhat.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: linux-fsdevel@vger.kernel.org
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
> /* v2 */
> - Christoph Hellwig <hch@lst.de>:
>   - Get rid of the ifdefs and the config option that hid idmapped mounts.
> 
> /* v3 */
> unchanged
> 
> /* v4 */
> - Serge Hallyn <serge@hallyn.com>:
>   - Use "mnt_userns" to refer to a vfsmount's userns everywhere to make
>     terminology consistent.
> 
> /* v5 */
> unchanged
> base-commit: 7c53f6b671f4aba70ff15e1b05148b10d58c2837
> 
> /* v6 */
> unchanged
> base-commit: 19c329f6808995b142b3966301f217c831e7cf31
> ---
>  include/linux/fs.h | 47 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index fd0b80e6361d..3165998e2294 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -40,6 +40,7 @@
>  #include <linux/build_bug.h>
>  #include <linux/stddef.h>
>  #include <linux/mount.h>
> +#include <linux/cred.h>
>  
>  #include <asm/byteorder.h>
>  #include <uapi/linux/fs.h>
> @@ -1573,6 +1574,52 @@ static inline void i_gid_write(struct inode *inode, gid_t gid)
>  	inode->i_gid = make_kgid(inode->i_sb->s_user_ns, gid);
>  }
>  
> +static inline kuid_t kuid_into_mnt(struct user_namespace *mnt_userns,
> +				   kuid_t kuid)
> +{
> +	return make_kuid(mnt_userns, __kuid_val(kuid));
> +}
> +

Hi Christian,

I am having little trouble w.r.t function names and trying to figure
out whether they are mapping id down or up.

For example, kuid_into_mnt() ultimately calls map_id_down(). That is,
id visible inside user namespace is mapped to host
(if observer is in init_user_ns, IIUC).

But fsuid_into_mnt() ultimately calls map_id_up(). That's take a kuid
and map it into the user_namespace.

So both the helpers end with into_mnt() but one maps id down and
other maps id up. I found this confusing and was wondering how
should I visualize it. So thought of asking you.

Is this intentional or can naming be improved so that *_into_mnt()
means one thing (Either map_id_up() or map_id_down()). And vice-a-versa
for *_from_mnt().

Thanks
Vivek

> +static inline kgid_t kgid_into_mnt(struct user_namespace *mnt_userns,
> +				   kgid_t kgid)
> +{
> +	return make_kgid(mnt_userns, __kgid_val(kgid));
> +}
> +
> +static inline kuid_t i_uid_into_mnt(struct user_namespace *mnt_userns,
> +				    const struct inode *inode)
> +{
> +	return kuid_into_mnt(mnt_userns, inode->i_uid);
> +}
> +
> +static inline kgid_t i_gid_into_mnt(struct user_namespace *mnt_userns,
> +				    const struct inode *inode)
> +{
> +	return kgid_into_mnt(mnt_userns, inode->i_gid);
> +}
> +
> +static inline kuid_t kuid_from_mnt(struct user_namespace *mnt_userns,
> +				   kuid_t kuid)
> +{
> +	return KUIDT_INIT(from_kuid(mnt_userns, kuid));
> +}
> +
> +static inline kgid_t kgid_from_mnt(struct user_namespace *mnt_userns,
> +				   kgid_t kgid)
> +{
> +	return KGIDT_INIT(from_kgid(mnt_userns, kgid));
> +}
> +
> +static inline kuid_t fsuid_into_mnt(struct user_namespace *mnt_userns)
> +{
> +	return kuid_from_mnt(mnt_userns, current_fsuid());
> +}
> +
> +static inline kgid_t fsgid_into_mnt(struct user_namespace *mnt_userns)
> +{
> +	return kgid_from_mnt(mnt_userns, current_fsgid());
> +}
> +
>  extern struct timespec64 current_time(struct inode *inode);
>  
>  /*
> -- 
> 2.30.0
> 

