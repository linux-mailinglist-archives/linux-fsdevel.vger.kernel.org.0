Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB5223B99B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Aug 2020 13:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730208AbgHDLey (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 07:34:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40438 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726400AbgHDLev (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 07:34:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596540888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=etjlVeN4UH1qO9OU1bYP1CrExEJDSItCGo2UFGYinfY=;
        b=ZySsi+t7LQe8pn3C4JPSzc0CimRZKRNhht5dpsc6IF+U9CQ7uRWhyPoQMES5tAjcuCHV42
        esJ8LCZmFiP56t0fHJeBewYQroKvdc3okzyKfJvORDbdB8IgEfMp/rDkOSz7nU45G53ArM
        hxh7gkxv6wwZuMikliuYXMI4EPXt5uM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362--PWjaPm2NvK-pYOXQjXF9w-1; Tue, 04 Aug 2020 07:34:47 -0400
X-MC-Unique: -PWjaPm2NvK-pYOXQjXF9w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7591D10059A9;
        Tue,  4 Aug 2020 11:34:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D2C771764;
        Tue,  4 Aug 2020 11:34:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200804101659.GA32719@miu.piliscsaba.redhat.com>
References: <20200804101659.GA32719@miu.piliscsaba.redhat.com> <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk> <159646180259.1784947.223853053048725752.stgit@warthog.procyon.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-api@vger.kernel.org, torvalds@linux-foundation.org,
        raven@themaw.net, mszeredi@redhat.com, christian@brauner.io,
        jannh@google.com, darrick.wong@oracle.com, kzak@redhat.com,
        jlayton@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/18] fsinfo: Add fsinfo() syscall to query filesystem information [ver #21]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2041167.1596540881.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 04 Aug 2020 12:34:41 +0100
Message-ID: <2041168.1596540881@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:

> > 		__u32	Mth;
> =

> The Mth field seems to be unused in this patchset.  Since the struct is
> extensible, I guess there's no point in adding it now.

Yeah - I was using it to index through the server address lists for networ=
k
filesystems (ie. the Mth address of the Nth server), but I've dropped the =
nfs
patch and made afs return an array of addresses for the Nth server since t=
he
address list can get reordered.

Ordinarily, I'd just take it out, but I don't want to cause the patchset t=
o
get dropped for yet another merge cycle :-/

> > +#define FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO 0x100	/* Information about =
attr N (for path) */
> > +#define FSINFO_ATTR_FSINFO_ATTRIBUTES	0x101	/* List of supported attr=
s (for path) */
> =

> I think it would make sense to move the actual attributes to a separate =
patch
> and leave this just being the infrastructure.

Maybe.  If there are no attributes, then it makes it a bit hard to test.

> > +struct fsinfo_u128 {
> ...
> =

> Shouldn't this belong in <linux/types.h>?

Maybe.  Ideally, I'd use a proper C type rather than a struct.

> Is there a reason these are 128 wide fields?  Are we approaching the lim=
its of
> 64bits?

Dave Chinner was talking at LSF a couple of years ago, IIRC, about looking
beyond the 16 Exa limit in XFS.  I've occasionally talked to people who ha=
ve
multi-Peta data sets in AFS or whatever they were using, streamed from sci=
ence
experiments, so the limit isn't necessarily all *that* far off.

> > +struct fsinfo_limits {
> > +	struct fsinfo_u128 max_file_size;	/* Maximum file size */
> > +	struct fsinfo_u128 max_ino;		/* Maximum inode number */
> =

> Again, what's the reason.  AFACT we are not yet worried about overflowin=
g 64
> bits.  Future proofing is good, but there has to be some rules and reaso=
ns
> behind the decisions.

This is cheap to do.  This information is expected to be static for the
lifetime a superblock and, for most filesystems, of the running kernel, so
simply copying it with memcpy() from rodata is going to suffice most of th=
e
time.

But don't worry - 640K is sufficient for everyone ;-)

David

