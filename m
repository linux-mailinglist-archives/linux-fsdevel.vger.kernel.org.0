Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF5B51651C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 22:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbgBSVkE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 16:40:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48586 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727274AbgBSVkE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 16:40:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582148403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Akm5nZ5Nk5RDJvPlHXdmc1pTXqzcrHwStmylDtS4kdo=;
        b=Q7FEeBlmVUh0HfH0GHlPoGXauLp7DnFB6j6lWOhAMobuz6Bvil01pYOrKCVXZ5j+ALZb/6
        LTf2FDXpJx8MyQCpCZ2xsY8CHR+BzRQ7WRv8ZvriohhuqX/gmjvWSTqAruI+K0vJ8/gueG
        jIRGGzP2zMHrQa2QbkAMqZVZdGyQhWY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-lYV3sqb5NxSus3qboGNwYQ-1; Wed, 19 Feb 2020 16:39:58 -0500
X-MC-Unique: lYV3sqb5NxSus3qboGNwYQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF399800D50;
        Wed, 19 Feb 2020 21:39:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-122-163.rdu2.redhat.com [10.10.122.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A04215C1B0;
        Wed, 19 Feb 2020 21:39:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wgtAEvD6J_zVPKXHDjZ7rNe3piRzD_bX2HcVgY3AMGhjw@mail.gmail.com>
References: <CAHk-=wgtAEvD6J_zVPKXHDjZ7rNe3piRzD_bX2HcVgY3AMGhjw@mail.gmail.com> <158212290024.224464.862376690360037918.stgit@warthog.procyon.org.uk> <CAMuHMdV+H0p3qFV=gDz0dssXVhzd+L_eEn6s0jzrU5M79_50HQ@mail.gmail.com> <227117.1582124888@warthog.procyon.org.uk> <CAHk-=wjFwT-fRw0kH-dYS9M5eBz3Jg0FeUfhf6VnGrPMVDDCBg@mail.gmail.com> <241568.1582134931@warthog.procyon.org.uk> <CAHk-=wi=UbOwm8PMQUB1xaXRWEhhoVFdsKDSz=bX++rMQOUj0w@mail.gmail.com> <CAHk-=whfoWHvL29PPXncxV6iprC4e_m6CQWQJ1G4-JtR+uGVUA@mail.gmail.com> <252465.1582142281@warthog.procyon.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, jaltman@auristor.com,
        Al Viro <viro@zeniv.linux.org.uk>, coda@cs.cmu.edu,
        linux-afs@lists.infradead.org, CIFS <linux-cifs@vger.kernel.org>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] vfs: syscalls: Add create_automount() and remove_automount()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <260917.1582148393.1@warthog.procyon.org.uk>
Date:   Wed, 19 Feb 2020 21:39:53 +0000
Message-ID: <260918.1582148393@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> so you _could_ actually just make the rule be something simple like
> 
>    symlink(target, "//datagoeshere")
> 
> being the "create magic autolink directory using "datagoeshere".

Interesting.  I'll ask around to see if this is feasible.  Some applications
(emacs being one maybe) sometimes appear to store information in symlink
bodies - I'm not sure if any of those could be a problem.

Since the mountpoint body is formulaic:

	[%#](<cellname>:)?<volumename>(.readonly|.backup)?.

maybe I can use that pattern.

symlink() would be returning a dentry that appears to be a directory, but it
doesn't look like that should be a problem.

> So then you could again script things with
> 
>    mknod dirname c X Y
>    echo "datagoeshere" > dirname

This would be tricky to get right as it's not atomic and the second part could
fail to happen.  For extra fun, another client could interfere between the
steps (setxattr would be safer than write here).

David

