Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E86352FF433
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 20:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbhAUTTr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 14:19:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45131 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726482AbhAUTI1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 14:08:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611256021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8cQVBtElgHkrZu0TCW+Tp+86juePWkkpr+KAAgOabXU=;
        b=AxZpqlQJb1pHt5uGjm8luNMnTQZTydxW6KIwP9Ong4xVAVsXwJ3CE5sbgI+V689RuOhQoH
        HKKT0sV4SMuzK38w8tI3LpI7/epeaBOQwkrquCX/Z3MTL+1KI0m6WnF6tnnGem70hppMcn
        KAicaTNawAi9iD42dY+QSnQuEVjKl1s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-ogR02f57MSGANxw_NhZwKQ-1; Thu, 21 Jan 2021 13:55:23 -0500
X-MC-Unique: ogR02f57MSGANxw_NhZwKQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 570368066F2;
        Thu, 21 Jan 2021 18:55:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-23.rdu2.redhat.com [10.10.115.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 810576EF42;
        Thu, 21 Jan 2021 18:55:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210121174306.GB20964@fieldses.org>
References: <20210121174306.GB20964@fieldses.org> <20210121164645.GA20964@fieldses.org> <161118128472.1232039.11746799833066425131.stgit@warthog.procyon.org.uk> <1794286.1611248577@warthog.procyon.org.uk>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Takashi Iwai <tiwai@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        linux-afs@lists.infradead.org, Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 00/25] Network fs helper library & fscache kiocb API
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1851803.1611255313.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 21 Jan 2021 18:55:13 +0000
Message-ID: <1851804.1611255313@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

J. Bruce Fields <bfields@fieldses.org> wrote:

> > Fixing this requires a much bigger overhaul of cachefiles than this pa=
tchset
> > performs.
> =

> That sounds like "sometimes you may get file corruption and there's
> nothing you can do about it".  But I know people actually use fscache,
> so it must be reliable at least for some use cases.

Yes.  That's true for the upstream code because that uses bmap.  I'm switc=
hing
to use SEEK_HOLE/SEEK_DATA to get rid of the bmap usage, but it doesn't ch=
ange
the issue.

> Is it that those "bridging" blocks only show up in certain corner cases
> that users can arrange to avoid?  Or that it's OK as long as you use
> certain specific file systems whose behavior goes beyond what's
> technically required by the bamp or seek interfaces?

That's a question for the xfs, ext4 and btrfs maintainers, and may vary
between kernel versions and fsck or filesystem packing utility versions.

David

