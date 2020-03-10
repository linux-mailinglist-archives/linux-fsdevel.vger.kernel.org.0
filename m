Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD1317F0FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Mar 2020 08:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgCJHZO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Mar 2020 03:25:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28587 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726199AbgCJHZO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Mar 2020 03:25:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583825113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d8UiZddWXkafFLvP5bz3JJYwq005hZDC3aZQhOodzY0=;
        b=aJVR7XBBUqstZN75UjwCsB9CuhJg7qtKfyVgYUNYD/Hv11KrwhjeoPt3/pkld/V23d78RW
        BmhK8INbjx3sonlR8wd7tGx6y+IosJvSPWYa6ZkTFJvY+pV5x6DoyxOJ9GCMCsyGg/hGrK
        6cetoUxWWd4YNgtOciprP1Wy7fTqDzo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-tBUfClqxMNKyh-Do3iS4ng-1; Tue, 10 Mar 2020 03:25:11 -0400
X-MC-Unique: tBUfClqxMNKyh-Do3iS4ng-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68D09107ACC9;
        Tue, 10 Mar 2020 07:25:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-182.rdu2.redhat.com [10.10.120.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7AB708F35C;
        Tue, 10 Mar 2020 07:25:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wiEBNFJ0_riJnpuUXTO7+_HByVo-R3pGoB_84qv3LzHxA@mail.gmail.com>
References: <CAHk-=wiEBNFJ0_riJnpuUXTO7+_HByVo-R3pGoB_84qv3LzHxA@mail.gmail.com> <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk> <158376245699.344135.7522994074747336376.stgit@warthog.procyon.org.uk> <20200310005549.adrn3yf4mbljc5f6@yavin>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Stefan Metzmacher <metze@samba.org>,
        Ian Kent <raven@themaw.net>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Karel Zak <kzak@redhat.com>, jlayton@redhat.com,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/14] VFS: Add additional RESOLVE_* flags [ver #18]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <580351.1583825105.1@warthog.procyon.org.uk>
Date:   Tue, 10 Mar 2020 07:25:05 +0000
Message-ID: <580352.1583825105@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> > > Also make openat2() handle RESOLVE_NO_TRAILING_SYMLINKS.
> 
> No, please let's not do this.
> 
> We have O_NOFOLLOW, and we can't get rid of it.
> 
> So adding RESOLVE_NO_TRAILING_SYMLINKS isn't a cleanup. It's just
> extra complexity for absolutely zero gain.

Okay.  So what's the equivalent of AT_SYMLINK_NOFOLLOW in RESOLVE_* flag
terms?  RESOLVE_NO_SYMLINKS is not equivalent, though O_NOFOLLOW is.  The
reason I ask is that RESOLVE_* flags can't be easily extended to non-open
syscalls that don't take O_* flags without it.  Would you prefer that new
non-open syscalls continue to take AT_* and ignore RESOLVE_* flags?  That
would be fine by me.

David

