Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51F03F378A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2019 19:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfKGSsy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Nov 2019 13:48:54 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24588 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727031AbfKGSsv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Nov 2019 13:48:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573152530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UHB0JrKl2/lgoy546a6o5x0iXWhc257PTYUJn/4Bje0=;
        b=IzWCw6Joj6xY0pxmrt8uf+HitdTf1u5HxPuCNhyPwd+atj0HVEEvvcfqnXDHJq5Q3iMUs1
        mYP8gP15+qfCHcfUawOYCNJ0A6HvzQWv3FpQSZZ40HpBK69B913VawjCUjhMl+9oEoazo5
        wcoHY8T3eYEVFyOIQYvdO6F58R4aLKc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-B9RjU769P3eP409e546QHA-1; Thu, 07 Nov 2019 13:48:44 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70429800C61;
        Thu,  7 Nov 2019 18:48:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-254.rdu2.redhat.com [10.10.120.254])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 54380600D3;
        Thu,  7 Nov 2019 18:48:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CALCETrUka9KaOKFbNKUXcA6XvoFxiXPftctSHtN4DL35Cay61w@mail.gmail.com>
References: <CALCETrUka9KaOKFbNKUXcA6XvoFxiXPftctSHtN4DL35Cay61w@mail.gmail.com> <157313371694.29677.15388731274912671071.stgit@warthog.procyon.org.uk> <157313375678.29677.15875689548927466028.stgit@warthog.procyon.org.uk>
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
Content-ID: <6963.1573152517.1@warthog.procyon.org.uk>
Date:   Thu, 07 Nov 2019 18:48:37 +0000
Message-ID: <6964.1573152517@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: B9RjU769P3eP409e546QHA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Andy Lutomirski <luto@kernel.org> wrote:

> > Add an O_NOTIFICATION_PIPE flag that can be passed to pipe2() to indica=
te
> > that the pipe being created is going to be used for notifications.  Thi=
s
> > suppresses the use of splice(), vmsplice(), tee() and sendfile() on the
> > pipe as calling iov_iter_revert() on a pipe when a kernel notification
> > message has been inserted into the middle of a multi-buffer splice will=
 be
> > messy.
>
> How messy?

Well, iov_iter_revert() on a pipe iterator simply walks backwards along the
ring discarding the last N contiguous slots (where N is normally the number=
 of
slots that were filled by whatever operation is being reverted).

However, unless the code that transfers stuff into the pipe takes the spinl=
ock
spinlock and disables softirqs for the duration of its ring filling, what w=
ere
N contiguous slots may now have kernel notifications interspersed - even if=
 it
has been holding the pipe mutex.

So, now what do you do?  You have to free up just the buffers relevant to t=
he
iterator and then you can either compact down the ring to free up the space=
 or
you can leave null slots and let the read side clean them up, thereby
reducing the capacity of the pipe temporarily.

Either way, iov_iter_revert() gets more complex and has to hold the spinloc=
k.

And if you don't take the spinlock whilst you're reverting, more notificati=
ons
can come in to make your life more interesting.

There's also a problem with splicing out from a notification pipe that the
messages are scribed onto preallocated buffers, but now the buffers need
refcounts and, in any case, are of limited quantity.

> And is there some way to make it impossible for this to happen?

Yes.  That's what I'm doing by declaring the pipe to be unspliceable up fro=
nt.

> Adding a new flag to pipe2() to avoid messy kernel code seems
> like a poor tradeoff.

By far the easiest place to check whether a pipe can be spliced to is in
get_pipe_info().  That's checking the file anyway.  After that, you can't m=
ake
the check until the pipe is locked.

Furthermore, if it's not done upfront, the change to the pipe might happen
during a splicing operation that's residing in pipe_wait()... which drops t=
he
pipe mutex.

David

