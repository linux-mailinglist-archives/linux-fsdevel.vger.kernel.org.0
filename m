Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E057A2A1E9B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Nov 2020 15:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgKAOlY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Nov 2020 09:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbgKAOlY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Nov 2020 09:41:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6378C0617A6;
        Sun,  1 Nov 2020 06:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JLQ1tQXc9bAL3Tc10fp3l/hgY8fF0ZkXSA4m3zd3IYM=; b=RTKMydVtbSPCwZGEemrV2Qaq7t
        ZlkjBevTM42JrP+u77IXmMh8iPEGF6aqpVgKyc6AUjmGP+mqol7anlD9ldBfIgYJAhRuSrV0new+H
        YSIqTXP3bAuELZ527GOXoMFavVhV0IJzIkBfzs2KQzeEn0ZQWDkrPH6UapYvgzp7rsxp0bksTKGBj
        vvTUjJaB6biygJluyLveCHr/mpIsrKXfJBrAaQoMTYuPQzq9DY8anRXKCMpkKGnpJ2UOskRcAQWLn
        sRKALkArBQDn9PfEAPB7vrAnaUbFoETA7stMPHzH3xyjePWgxRox5oXiVfyZUrT/lheIvlD97cB9p
        g6+8nZfA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZEXc-0006Hp-5O; Sun, 01 Nov 2020 14:41:08 +0000
Date:   Sun, 1 Nov 2020 14:41:08 +0000
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
Subject: Re: [PATCH 01/34] namespace: take lock_mount_hash() directly when
 changing flags
Message-ID: <20201101144108.GA23378@infradead.org>
References: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
 <20201029003252.2128653-2-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029003252.2128653-2-christian.brauner@ubuntu.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> index cebaa3e81794..20ee291a7af4 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -463,7 +463,6 @@ static int mnt_make_readonly(struct mount *mnt)
>  {
>  	int ret = 0;
>  
> -	lock_mount_hash();

What about adding a lockdep_assert_lock_held in all the functions
that used to take the lock to document the assumptions?

>  static int __mnt_unmake_readonly(struct mount *mnt)
>  {
> -	lock_mount_hash();
>  	mnt->mnt.mnt_flags &= ~MNT_READONLY;
> -	unlock_mount_hash();
>  	return 0;

This helper is rather pointless now.

>  static void set_mount_attributes(struct mount *mnt, unsigned int mnt_flags)
>  {
> -	lock_mount_hash();
>  	mnt_flags |= mnt->mnt.mnt_flags & ~MNT_USER_SETTABLE_MASK;
>  	mnt->mnt.mnt_flags = mnt_flags;
>  	touch_mnt_namespace(mnt->mnt_ns);
> -	unlock_mount_hash();

In linux-next there is an additional notify_mount after the unlock here.

Also while you touch this lock_mount_hash/unlock_mount_hash could be
moved to namespace.c and maked static now.
