Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2485A164D0D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 18:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgBSRzp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 12:55:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20539 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726593AbgBSRzo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 12:55:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582134943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=woJrYBQ5G1rIzUoBIxisrRt/fHuFNb6jWX81Ut30+Bc=;
        b=bQ4DxGFxg1A7YiKcGR88c3RQiykmsIBuMSrlzuFu3+BQuCIboiD8pPeW/gYIHeywwUvbhL
        TScYN/1cNvNyyf04ffrAMT8XNhiScpTt0iiu+AwKlau6D+wqsLBZ8E2NxPOP8n0kuhdFTm
        oLKJERLQD67L8Shiv2K9EAy3dM0+Kpw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-c4VgchpyOW2sfzE38trctg-1; Wed, 19 Feb 2020 12:55:36 -0500
X-MC-Unique: c4VgchpyOW2sfzE38trctg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DBF413F9;
        Wed, 19 Feb 2020 17:55:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-122-163.rdu2.redhat.com [10.10.122.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 64AC21001920;
        Wed, 19 Feb 2020 17:55:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wjFwT-fRw0kH-dYS9M5eBz3Jg0FeUfhf6VnGrPMVDDCBg@mail.gmail.com>
References: <CAHk-=wjFwT-fRw0kH-dYS9M5eBz3Jg0FeUfhf6VnGrPMVDDCBg@mail.gmail.com> <158212290024.224464.862376690360037918.stgit@warthog.procyon.org.uk> <CAMuHMdV+H0p3qFV=gDz0dssXVhzd+L_eEn6s0jzrU5M79_50HQ@mail.gmail.com> <227117.1582124888@warthog.procyon.org.uk>
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
Content-ID: <241567.1582134931.1@warthog.procyon.org.uk>
Date:   Wed, 19 Feb 2020 17:55:31 +0000
Message-ID: <241568.1582134931@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> What are the insane pioctl semantics you want?

There's a file type beyond file, dir and symlink that AFS supports:
mountpoint.  It appears as a directory with no lookup op in Linux - though it
does support readlink.  When a client walks over it, it causes an automount of
the volume named by the content of the mountpoint "file" on that point.  NFS
and CIFS have similar things.

AFS allows the user to create them and remove them:

	http://docs.openafs.org/Reference/1/fs_mkmount.html
	http://docs.openafs.org/Reference/1/fs_rmmount.html

provided the server grants permission to do so.

OpenAFS, Coda, etc. do this by means of a pair of pioctl() functions (at
least, I think Coda does - it ships the pioctl parameters off to userspace to
handle, so the handling is not actually in the kernel).

> If you can't even open a file on the filesystem, you damn well
> shouldn't be able to to "pioctl" on it.
> 
> And if you *can* open a file on the filesystem, why can't you just use
> ioctl on it?

Directory, not file.  You can do mkdir (requiring write and execute), for
example, in a directory you cannot open (which would require read).  If you
cannot open it, you cannot do ioctl on it.

open(O_PATH) doesn't help because that doesn't let you do ioctl.

David

