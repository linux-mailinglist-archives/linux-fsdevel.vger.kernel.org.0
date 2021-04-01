Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7DE350F95
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 08:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbhDAGy6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 02:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233518AbhDAGym (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 02:54:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF31AC0613E6;
        Wed, 31 Mar 2021 23:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+rqD+8Ns9XS4d9FAw5iGCGFF40fFVJKrKKANRCPHP0o=; b=ihNbaoxnPM7sRbYjVMAyci454u
        RLoWWyCxHieZwdASJXGveeL+T4zBSWzf1+/rwUOcY/aJkEdMhmLPzKYJogJKbMvKQum+SR2yQ/g5k
        zh/KnuRqAT9UMvH/lmH9yJ/i18lq27gw/4xHlH3FCu6NapT3MnKxBORA/9JYJGPsTWg5PmXieJrOa
        8gzSbHWVb8M2wohf5s6cESHkuCdWtVUV+CHyayJ6pnJzo5w8xEf3ZdZJj1aTN4DjAVUVIXAKx3WsP
        a2l1uJKUJ6gYbIUSxcw9gEmBD35leKFqgwdpKY7TZBJiChqA3jgfkK7E+dTdj6jgp5f7dCcpvbREq
        X78grfig==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lRrDP-005jvt-25; Thu, 01 Apr 2021 06:54:12 +0000
Date:   Thu, 1 Apr 2021 07:54:03 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Paul Moore <paul@paul-moore.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: [PATCH v2] vfs: fix fsconfig(2) LSM mount option handling for
 btrfs
Message-ID: <20210401065403.GA1363493@infradead.org>
References: <20210316144823.2188946-1-omosnace@redhat.com>
 <CAHC9VhRoTjimpKrrQ5f04SE7AOcGv6p5iBgSnoSRgtiUP47rRg@mail.gmail.com>
 <YFEAD9UClhwxErgj@zeniv-ca.linux.org.uk>
 <CAFqZXNukusUPp+kO7vxPZBt5ehkpH6EUZ5e8XwUq9adOQHdMkQ@mail.gmail.com>
 <CAFqZXNtBrGVrjXAbrn30QSMFP4Gc99fRK23hMujxYu_otzu0yA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqZXNtBrGVrjXAbrn30QSMFP4Gc99fRK23hMujxYu_otzu0yA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 29, 2021 at 11:00:39AM +0200, Ondrej Mosnacek wrote:
> After taking a closer look, it seems this won't actually work... The
> problem is that since btrfs still uses the legacy mount API, it has no
> way to get to fs_context in btrfs_mount() and thus both of your
> suggestions aren't really workable (again, without converting btrfs at
> least partially to the new API)...

.. and that conversion is long overdue anyway ..
