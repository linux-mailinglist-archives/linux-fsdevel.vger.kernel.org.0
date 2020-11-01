Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7152A1EC7
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Nov 2020 15:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgKAOsM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Nov 2020 09:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbgKAOsM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Nov 2020 09:48:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C547C0617A6;
        Sun,  1 Nov 2020 06:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wOeDmyzsiaD9d4vQIUmd2QRH3McGyUDmsoqxKEoWZww=; b=u4A9GPinHUcyv/GuBI9CUkuCA3
        cGrepLQETbEhTnlzMKHcI/xVbGsuLVVjpOnXqaLJ2xM7aA/e4IeUFFy4pl/XhoOMxIO1NWJO77hgs
        TxcTs1U4UkGlh3HmXIDyBvl+HqeLCfTcMG40+Ccb4S+3Imr6e1DI9LpMSvnmIZteEo3+cLZ0CEl2w
        tj4uibh+Bk02kRbkODztXDTTPL39VWuytSTYPqpY5MxoGALTRxEIEhWnPEw/Rw1KLJoB/5uYztCZJ
        fulyNsYFTfQC6hY8dEMmCU6IdqK6FVgpc52QqtBY3sR+nY0H3cNgFYjE7VIBfLeRPcfH1ZvPU3WAk
        tdVc5nDA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZEeP-0006fC-Iw; Sun, 01 Nov 2020 14:48:09 +0000
Date:   Sun, 1 Nov 2020 14:48:09 +0000
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
Subject: Re: [PATCH 07/34] capability: handle idmapped mounts
Message-ID: <20201101144809.GE23378@infradead.org>
References: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
 <20201029003252.2128653-8-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029003252.2128653-8-christian.brauner@ubuntu.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>  /**
>   * capable_wrt_inode_uidgid - Check nsown_capable and uid and gid mapped
>   * @inode: The inode in question
> @@ -501,9 +513,7 @@ bool privileged_wrt_inode_uidgid(struct user_namespace *ns, const struct inode *
>   */
>  bool capable_wrt_inode_uidgid(const struct inode *inode, int cap)
>  {
> +	return capable_wrt_mapped_inode_uidgid(&init_user_ns, inode, cap);
>  }
>  EXPORT_SYMBOL(capable_wrt_inode_uidgid);

Please avoid these silly wrappers and just switch all callers to pass
the namespaces instead of creating boilerplate code.  Same for the other
functions where you do this even even worse the method calls.
