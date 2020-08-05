Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B25C923D2AD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Aug 2020 22:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgHEUPC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Aug 2020 16:15:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21436 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726547AbgHEQUv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:20:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596644449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DHFlZmfElMYNy0WR9YIOE++ShLmq+Nylm/oekejIBn8=;
        b=eUrfOov91pCGRCux7Vq/UqdrAwLhBzd6Yuht5RSPzxzbK7XLO/SSTpkDGHpjOvBstb4WE+
        RcPdAT3MNQb2DjoKO++incdyOgk5lTEzp4jD3vNCRU7fR8cbyFYpH5AC3e3YqDKQrGOO07
        8048aqyilUVBh5AAu5n5LvDJJ6PZtTM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-oiElo-DiOHyMD5tPH4SYlQ-1; Wed, 05 Aug 2020 12:07:07 -0400
X-MC-Unique: oiElo-DiOHyMD5tPH4SYlQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B20558;
        Wed,  5 Aug 2020 16:07:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 96B4B87E2A;
        Wed,  5 Aug 2020 16:06:59 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200804135641.GE32719@miu.piliscsaba.redhat.com>
References: <20200804135641.GE32719@miu.piliscsaba.redhat.com> <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk> <159646187082.1784947.4293611877413578847.stgit@warthog.procyon.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, raven@themaw.net,
        mszeredi@redhat.com, christian@brauner.io, jannh@google.com,
        darrick.wong@oracle.com, kzak@redhat.com, jlayton@redhat.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/18] fsinfo: Provide notification overrun handling support [ver #21]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2320581.1596643618.1@warthog.procyon.org.uk>
Date:   Wed, 05 Aug 2020 17:06:58 +0100
Message-ID: <2320582.1596643618@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:

> Shoun't we just make sure that the likelyhood of overruns is low

That's not necessarily easy.  To avoid overruns you need a bigger buffer.  The
buffer is preallocated from unswappable kernel space.  Yes, you can increase
the size of the buffer, but it eats out of your pipe bufferage limit.

Further, it's a *general* notifications queue, not just for a specific
purpose, but that means it might get connected to multiple sources, and doing
something like tearing down a container might generate enough notifications to
overrun the queue.

> and if it happens, just reinitialize everthing from scratch (shouldn't be
> *that* expensive).

If you then spend time reinitialising everything, you're increasing the
likelihood of racing with further events.  Further, there multiple expenses:
firstly, you have to tear down and discard all the data that you've spent time
setting up; secondly, it takes time doing all this; thirdly, it takes cpu
cycles away from applications.

The reason I put the event counters in there and made it so that fsinfo()
could read all the mounts in a subtree and their event counters in one go is
to make it faster for the user to find out what changed in the event that a
notification is lost.

I have a patch (not included here as it occasionally induces oopses) that
attempts to make this doable under the RCU read lock so that it doesn't
prevent mounts from taking place during the scan.

David

