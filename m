Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA10B1647CF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 16:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgBSPIV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 10:08:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42512 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726856AbgBSPIS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 10:08:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582124897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QZq1IwUFsVXgnf+MjVG5on9QRs42gTJtH2m4Vh+19iU=;
        b=hh57ry5FF6d7yWVwnc1UdjtwLUbBQtVQXSbiBs1xjqoy5e2Z/T9626rObNYwN9sGH0cM1s
        HF1TCrvzJNvCUV/x3PElnXHZNBtgicdsinfcXl1YlysKhpYhq26aaSMFm2ewhQgZh+ffs9
        fP/uXKXN9IZc26sZofqiEhJdl16qulU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185--OMtL3rXM2C--KYVuUt_yg-1; Wed, 19 Feb 2020 10:08:13 -0500
X-MC-Unique: -OMtL3rXM2C--KYVuUt_yg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB7338024ED;
        Wed, 19 Feb 2020 15:08:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-122-163.rdu2.redhat.com [10.10.122.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AF7F127061;
        Wed, 19 Feb 2020 15:08:09 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAMuHMdV+H0p3qFV=gDz0dssXVhzd+L_eEn6s0jzrU5M79_50HQ@mail.gmail.com>
References: <CAMuHMdV+H0p3qFV=gDz0dssXVhzd+L_eEn6s0jzrU5M79_50HQ@mail.gmail.com> <158212290024.224464.862376690360037918.stgit@warthog.procyon.org.uk>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        coda@cs.cmu.edu, linux-afs@vger.kernel.org,
        linux-cifs@vger.kernel.org,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] vfs: syscalls: Add create_automount() and remove_automount()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <227116.1582124888.1@warthog.procyon.org.uk>
Date:   Wed, 19 Feb 2020 15:08:08 +0000
Message-ID: <227117.1582124888@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Oops... I've just realised that the function names in the subject line don't
match those in the patch.

Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> The above nicely explains what the patch does.
> However, unless I'm missing something, this fails to explain the "why"
> (except for the vague "[...] is something that AFS needs ...".

I'm not allowed to implement pioctl() for Linux, so I have to find some other
'structured' (to quote Linus) way to implement the extra functions for the
in-kernel AFS client.

OpenAFS and maybe Coda, for example, create a magic file, I think, and then
ioctl is done on that - ie. direct pioctl emulation.  All the path lookup and
security is done inside the filesystem.

Another way to do this, at least for these two operations, would be to issue
an ioctl on the parent directory.  This requires you to be able to open said
directory in order to perform the ioctl on it - which requires you to have
read permission, something not required to alter a directory.  This also
pushes the path lookup and security into the filesystem

So I'm proposing this way.  It's something that can be used by other
filesystems too, if they support it.  Coda and OpenAFS, for example, might be
able to make use of it as they want to be able to do the same sort of things.

David

