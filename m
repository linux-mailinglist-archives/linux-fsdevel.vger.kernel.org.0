Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B622A1EB7
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Nov 2020 15:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgKAOpr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Nov 2020 09:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbgKAOpr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Nov 2020 09:45:47 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126A6C0617A6;
        Sun,  1 Nov 2020 06:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nVK1pkiziQ92kaQ/g40iRxNnuEGCqnYOXHidgZ1R1Sw=; b=TXCoiwu2LqeUACFNts/RtI1sNW
        AL3/iF3Fr92m5DK6yU59krsIzhlhvGU7WbruotfIWfVcCX9v9+eh0ewIy0MuYWUSA1pUjoHsM6UBa
        j7uutfCrr9Tr+r/GDt4Ug74KoxS5mAef22Yya/Fj4vg6YgJf/E/UEFPF/BlX/Jvy9xLPOK5ATkBB2
        C/PkZYggOKQKIJGaVcnwY1WLgrcNW/vrVsKWXvte84lE6NZORjZd/hKVufdtiGryZ+Ks8yb16iik+
        LQbI90fVQmt3eNgP583eFcHO3rYz2MkTxwhnEULzH/qY2/LT2RUFWQdQgdOriWrA701EA00Ks4GDQ
        2EqUMtDg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZEc4-0006Y5-Kp; Sun, 01 Nov 2020 14:45:44 +0000
Date:   Sun, 1 Nov 2020 14:45:44 +0000
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
        Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Theodore Tso <tytso@mit.edu>, Alban Crequy <alban@kinvolk.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jann Horn <jannh@google.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        St??phane Graber <stgraber@ubuntu.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>, smbarber@chromium.org,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-audit@redhat.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org
Subject: Re: [PATCH 05/34] fs: introduce MOUNT_ATTR_IDMAP
Message-ID: <20201101144544.GC23378@infradead.org>
References: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
 <20201029003252.2128653-6-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029003252.2128653-6-christian.brauner@ubuntu.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 29, 2020 at 01:32:23AM +0100, Christian Brauner wrote:
> Introduce a new mount bind mount property to allow idmapping mounts. The
> MOUNT_ATTR_IDMAP flag can be set via the new mount_setattr() syscall
> together with a file descriptor referring to a user namespace.

Shouldn't this go to the end of the series once all the infrastructure
is in place?

> +config IDMAP_MOUNTS
> +	bool "Support id mappings per mount"
> +	default n

n is the default default.

But why do we need a config option here anyway?

> +#ifdef CONFIG_IDMAP_MOUNTS
> +		if (kattr->attr_set & MNT_IDMAPPED) {
> +			struct user_namespace *user_ns;
> +			struct vfsmount *vmnt;

All the code here looks like it should go into a helper.

> +				struct user_namespace *user_ns = READ_ONCE(m->mnt.mnt_user_ns);
> +				WRITE_ONCE(m->mnt.mnt_user_ns, get_user_ns(kattr->userns));

More unreadable long lines.

> +	if (attr->attr_set & MOUNT_ATTR_IDMAP) {
> +		struct ns_common *ns;
> +		struct user_namespace *user_ns;
> +		struct file *file;
> +
> +		file = fget(attr->userns);

The code here looks like another candidate for a self contained helper.

> +
> +static inline struct user_namespace *mnt_user_ns(const struct vfsmount *mnt)
> +{
> +#ifdef CONFIG_IDMAP_MOUNTS
> +	return READ_ONCE(mnt->mnt_user_ns);
> +#else
> +	return &init_user_ns;
> +#endif

How is the READ_ONCE on a pointer going to work?
