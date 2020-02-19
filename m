Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 640C1164F5C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 20:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgBST6N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 14:58:13 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34171 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726811AbgBST6N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 14:58:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582142292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t0EjaOj44ktsI0o8dM8MlcrbPgSXHBFyya3QCm27HcQ=;
        b=hrG9+jQfZjSnMaz2iFOP87UP8GLsVCLTSxxe5u2NE2kpJ8TF1sMqf9XjY8ZYxY4AEXrTnF
        un9XKMDOUoD0+vQRVpF6WaOhjMvkhL50UZm3z2rfWszzhHeUvfzzQ+oJ61rl/wbg9Muymj
        Q7XIjT06Cye7IgY3HBG6G8nxzlIzWpI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-rGSX7ZLMP8eOL5O_lYVaJA-1; Wed, 19 Feb 2020 14:58:08 -0500
X-MC-Unique: rGSX7ZLMP8eOL5O_lYVaJA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81DC71800D42;
        Wed, 19 Feb 2020 19:58:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-122-163.rdu2.redhat.com [10.10.122.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4EDC75DA82;
        Wed, 19 Feb 2020 19:58:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=whfoWHvL29PPXncxV6iprC4e_m6CQWQJ1G4-JtR+uGVUA@mail.gmail.com>
References: <CAHk-=whfoWHvL29PPXncxV6iprC4e_m6CQWQJ1G4-JtR+uGVUA@mail.gmail.com> <158212290024.224464.862376690360037918.stgit@warthog.procyon.org.uk> <CAMuHMdV+H0p3qFV=gDz0dssXVhzd+L_eEn6s0jzrU5M79_50HQ@mail.gmail.com> <227117.1582124888@warthog.procyon.org.uk> <CAHk-=wjFwT-fRw0kH-dYS9M5eBz3Jg0FeUfhf6VnGrPMVDDCBg@mail.gmail.com> <241568.1582134931@warthog.procyon.org.uk> <CAHk-=wi=UbOwm8PMQUB1xaXRWEhhoVFdsKDSz=bX++rMQOUj0w@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, Geert Uytterhoeven <geert@linux-m68k.org>,
        Al Viro <viro@zeniv.linux.org.uk>, coda@cs.cmu.edu,
        linux-afs@lists.infradead.org, CIFS <linux-cifs@vger.kernel.org>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] vfs: syscalls: Add create_automount() and remove_automount()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <252464.1582142281.1@warthog.procyon.org.uk>
Date:   Wed, 19 Feb 2020 19:58:01 +0000
Message-ID: <252465.1582142281@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> > Why don't you just use mkdir with S_ISVTX set, or something like that?
> 
> Actually, since this is apparently a different filetype, the _logical_
> thing to do is to use "mknod()".

Actually, in many ways, they're more akin to symlinks (and are implemented as
symlinks with funny attributes).  It's a shame that symlinkat() doesn't have
an at_flags parameter.

mknod() isn't otherwise supported on AFS as there aren't any UNIX special
files.

> You presumably need a new type _anyway_ for stat() and/or the filldir
> d_type field. Or do you always want to make it look exactly like a
> directory to all user space?

That's already dealt with.  They're presented as directories with
STATX_ATTR_AUTOMOUNT showing when you call statx() on them.  You can also use
readlink() to extract the target if they haven't been mounted over yet.

Inside the kernel, they have no ->lookup() op, so DCACHE_AUTODIR_TYPE is set
on the dentry and there's a ->d_automount() op.  The inode has S_AUTOMOUNT
set.  That's all taken care of when the inode is created and the dentry is
instantiated.

Davod

