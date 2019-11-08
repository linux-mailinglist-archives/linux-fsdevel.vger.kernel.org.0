Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAB1F40AD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2019 07:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbfKHGnB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Nov 2019 01:43:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22162 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725372AbfKHGnA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Nov 2019 01:43:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573195379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G8x+s0gT+EQcwDzJx0Qq2QbxI7ZiAY//ltXx+x3jOGg=;
        b=K0Vy1weLhKpp+bOYWw9qkFhoWjt5hAnm5TJDvgl+GMj6vYvO4f8cr3fTcdesvFUfFCgcKy
        ReGybiIDU97z6kY7DmNomlfd+rLZO78KxLyqCFZwh2U/SIFyGLv8PNigXHfLK1tusotyt5
        zRgKfr8mMlnBgxWHfNOqEDD6HSlFqS0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-VLRlQoNXNQOdqlAzq2_FZA-1; Fri, 08 Nov 2019 01:42:56 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67DF6477;
        Fri,  8 Nov 2019 06:42:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-254.rdu2.redhat.com [10.10.120.254])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8307A10016DA;
        Fri,  8 Nov 2019 06:42:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CALCETrWeN9CGJHz0dzG1uH5Qjbr+xG3OKZuEd33eBY_rAzVkqQ@mail.gmail.com>
References: <CALCETrWeN9CGJHz0dzG1uH5Qjbr+xG3OKZuEd33eBY_rAzVkqQ@mail.gmail.com> <157313371694.29677.15388731274912671071.stgit@warthog.procyon.org.uk> <157313375678.29677.15875689548927466028.stgit@warthog.procyon.org.uk> <CALCETrUka9KaOKFbNKUXcA6XvoFxiXPftctSHtN4DL35Cay61w@mail.gmail.com> <6964.1573152517@warthog.procyon.org.uk>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, USB list <linux-usb@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 04/14] pipe: Add O_NOTIFICATION_PIPE [ver #2]
MIME-Version: 1.0
Content-ID: <7771.1573195370.1@warthog.procyon.org.uk>
Date:   Fri, 08 Nov 2019 06:42:50 +0000
Message-ID: <7772.1573195370@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: VLRlQoNXNQOdqlAzq2_FZA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Andy Lutomirski <luto@kernel.org> wrote:

> I can open a normal pipe from userspace (with pipe() or pipe2()), and
> I can have two threads.  One thread writes to the pipe with write().
> The other thread writes with splice().  Everything works fine.

Yes.  Every operation you do on a pipe from userspace is serialised with th=
e
pipe mutex - and both ends share the same pipe.

> What's special about notifications?

The post_notification() cannot take the pipe mutex.  It has to be callable
from softirq context.  Linus's idea is that when you're actually altering t=
he
ring pointers you should hold the wake-queue spinlock, and post_notificatio=
n()
holds the wake queue spinlock for the duration of the operation.

This means that post_notification() can be writing to the pipe whilst a
userspace-invoked operation is holding the pipe mutex and is also doing
something to the ring.

David

