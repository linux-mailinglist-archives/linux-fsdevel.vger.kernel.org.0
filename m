Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB48E2FB966
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 15:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389041AbhASOaJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 09:30:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387582AbhASJeW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 04:34:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D082C061574;
        Tue, 19 Jan 2021 01:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1acN46MpaPD0Uo/eaBisBkwf/+vpr3p34PmGVNKLyj4=; b=KxUOlItbLKC0Avomi+19Gi2mcV
        gmWIZesVp04Vx271TV9b12XH2uIVL4VVV+bLwXEwvpVa+rJzPrNT0nHJhRYqIYGgwv9CtShnFhybV
        vqjmZOZPQr8XuVGUTKyPw1JBpMikjjY8GUzwj3sGB0H4dPdwLCC70zMRdWdSTED2xkchcQhXyfqPB
        AfcImiORPYISXJfLt8J2JIAdaMcaJK/Qc+dlv3Jnyu6CP+oVkJ3k/6iHn+N4D7s2ryGs0vpixWCDF
        UXeDZ17iiJ8GPw1BHIsY66OMlUpie2S7mvML6r33SJXdD0zMc6Ya/tOubD5xLSxmpKc+Nbx8PUSIK
        ZGweAYaQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l1nO8-00E7YL-MF; Tue, 19 Jan 2021 09:33:28 +0000
Date:   Tue, 19 Jan 2021 09:33:24 +0000
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
Subject: Re: [PATCH v5 19/42] namei: handle idmapped mounts in may_*() helpers
Message-ID: <20210119093324.GD3364550@infradead.org>
References: <20210112220124.837960-1-christian.brauner@ubuntu.com>
 <20210112220124.837960-20-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112220124.837960-20-christian.brauner@ubuntu.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 12, 2021 at 11:01:01PM +0100, Christian Brauner wrote:
> The may_follow_link(), may_linkat(), may_lookup(), may_open(),
> may_o_create(), may_create_in_sticky(), may_delete(), and may_create()
> helpers determine whether the caller is privileged enough to perform the
> associated operations. Let them handle idmapped mounts by mapping the
> inode or fsids according to the mount's user namespace. Afterwards the
> checks are identical to non-idmapped inodes. The patch takes care to
> retrieve the mount's user namespace right before performing permission
> checks and passing it down into the fileystem so the user namespace
> can't change in between by someone idmapping a mount that is currently
> not idmapped. If the initial user namespace is passed nothing changes so
> non-idmapped mounts will see identical behavior as before.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
