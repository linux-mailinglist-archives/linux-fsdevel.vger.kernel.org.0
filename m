Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58466167E7E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 14:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgBUN06 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 08:26:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41851 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728395AbgBUN05 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 08:26:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582291616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bophSFpH+AOJeld6gkg+jI6nGrySjeA3VHne0YInX1I=;
        b=TW+yyIm96fL2BK/CMPUdGIMOjE4GI1UlaTtQOayz5eJ76H9uyDCUN1h+D+aJwYvD7e4Wxa
        WbcOA8yIwKM/dEXy5xQYmmpuYI3xhE/9UP2DDD//EDWKw8um2GSTohYbd6nFllvM0mo0x9
        WvhQRgTGXkm1mLO7t3Yd0UvFaQKjE1M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436--AeorJfxMXmuPFpGmrlebQ-1; Fri, 21 Feb 2020 08:26:54 -0500
X-MC-Unique: -AeorJfxMXmuPFpGmrlebQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65EAC800D5C;
        Fri, 21 Feb 2020 13:26:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-122-163.rdu2.redhat.com [10.10.122.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B5D725C1D8;
        Fri, 21 Feb 2020 13:26:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAG48ez03VMKEmJEmViSkxbF9J5dW=6vny9vKGdenBewtjF+nqQ@mail.gmail.com>
References: <CAG48ez03VMKEmJEmViSkxbF9J5dW=6vny9vKGdenBewtjF+nqQ@mail.gmail.com> <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk> <158204558110.3299825.5080605285325995873.stgit@warthog.procyon.org.uk> <CAG48ez0fsB_XTmNfE-2tuabH7JHyQdih8bu7Qwu9HGWJXti7tQ@mail.gmail.com> <628199.1582203532@warthog.procyon.org.uk>
To:     Jann Horn <jannh@google.com>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        raven@themaw.net, Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 11/19] afs: Support fsinfo() [ver #16]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1813543.1582291610.1@warthog.procyon.org.uk>
Date:   Fri, 21 Feb 2020 13:26:51 +0000
Message-ID: <1813544.1582291611@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jann Horn <jannh@google.com> wrote:

> Hm - I guess just returning a list of attributes ought to be fine?
> Then AFS can just return one of its two statically-allocated attribute
> lists there, and a filesystem with more complicated circumstances
> (like FUSE or overlayfs or whatever) can compute a heap-allocated list
> on mount that is freed when the superblock goes away, or something
> like that?

I've changed it so that the core calls into the filesystem with no buffer
allocated first.  If the fs finds an appropriate attribute, it calls a helper
to handle it.  As there's no buffer, this will just return the size.

If the fs doesn't have a handler, it returns -EOPNOTSUPP and the core looks
for a common attribute instead and calls the helper on that if found.

At this point, if a valid length was returned and if userspace didn't specify
a buffer, we just return the proposed size to userspace.

If userspace did specify a buffer, then core will allocate a buffer of the
requested size and call into the filesystem again.  The helper will call the
->get() function to retrieve the value.  The ->get() function returns the
size.

If the returned size exceeds the buffer size, a bigger buffer will be
allocated and it will repeat the last step.

A simple example looks like:

	int ext4_fsinfo(struct path *path, struct fsinfo_context *ctx)
	{
		return fsinfo_get_attribute(path, ctx, ext4_fsinfo_attributes);
	}

where the ext4_fsinfo_attributes is an array of attribute defs.  The helper,
fsinfo_get_attribute() scans the list.  The helper can be called multiple
times if there's more than one list to process.  The caller should stop if one
doesn't return -EOPNOTSUPP.


When the attribute IDs are being listed, the helper will detect that and just
add all the IDs to the list, returning -EOPNOTSUPP when it's done so that all
the attributes get listed.

When the metadata for an attribute is being retrieved, the helper detects that
and searches the given table for that attribute.  If it finds it, it will
return information about that attribute rather than calling the attribute
helper.

David

