Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9FE22FC3DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 23:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403986AbhASOcH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 09:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387665AbhASJiH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 04:38:07 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F81C061573;
        Tue, 19 Jan 2021 01:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lkd5BoXRXZXegz0OAW0KP/ZWkeXWrChLRnyeG1Ce6eM=; b=Mh9s8AHw1yhDl8mLTSrmKY92NR
        qApA5C2Sos5Xw/oxVQZ4P5QVp9lEKDefhVdmrQUrH4hnXHygg1L6hlz7MR64dWZ0fsWJrBcgjJat8
        A5SrHVAImT3UUPZBGl78jzF32nOeqYKjCVEZ1wMgFhr3vrU9LvZSW8jcXxQcavpg7ztYyySly00pg
        syGJXrpNCNL+2IkOt4s8RfVfDqcT0PH+xeiBhjJx43VBcL0Sm8DSEFFPDMpoBCr68OnYzR00zBD0/
        0VSK5NkCJvCBzhPLkK/E46VBpO/yV08GyBZYo/yhBPdrQDK4UM4EgtrJTiNuUNzDrJ9vbVDl8ra5x
        PZFa4w3g==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l1nRw-00E7p7-2E; Tue, 19 Jan 2021 09:37:21 +0000
Date:   Tue, 19 Jan 2021 09:37:20 +0000
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
Subject: Re: [PATCH v5 22/42] open: handle idmapped mounts in do_truncate()
Message-ID: <20210119093720.GG3364550@infradead.org>
References: <20210112220124.837960-1-christian.brauner@ubuntu.com>
 <20210112220124.837960-23-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112220124.837960-23-christian.brauner@ubuntu.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 12, 2021 at 11:01:04PM +0100, Christian Brauner wrote:
> @@ -930,8 +932,12 @@ void dump_truncate(struct coredump_params *cprm)
>  
>  	if (file->f_op->llseek && file->f_op->llseek != no_llseek) {
>  		offset = file->f_op->llseek(file, 0, SEEK_CUR);
> -		if (i_size_read(file->f_mapping->host) < offset)
> -			do_truncate(file->f_path.dentry, offset, 0, file);
> +		if (i_size_read(file->f_mapping->host) < offset) {
> +			struct user_namespace *mnt_userns;
> +
> +			mnt_userns = file_user_ns(file);
> +			do_truncate(mnt_userns, file->f_path.dentry, offset, 0, file);
> +		}

I think we can skip the local variable here.  In fact for all callers
of do_truncate except vfs_truncate a little file_truncate helper that
takes a struct file would help readability a lot.
