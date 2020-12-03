Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF372CDACC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 17:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbgLCQGu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 11:06:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48650 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728018AbgLCQGu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 11:06:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607011523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y5sm6NRThydVnqk+H69qW6rgfXg8E7wt7CG2P4pgtqk=;
        b=CGLbRZmWLDWfG5snfu5YiiyvKG3S3OwkpVxsn37WGCClbWSVQfyckHHgAcrbK3MCv6qHJp
        0sVorqvxIF0QgUY0OY9NSp46fCAZ2MVUtYJeSpDI8PDrSV1l108UVhDLjuqyu64q5r4l25
        UAqMwFT4i7KsRkooLmpZzfVURzxvXTU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-hXe1W02XMVmzTtmtk8yocg-1; Thu, 03 Dec 2020 11:05:21 -0500
X-MC-Unique: hXe1W02XMVmzTtmtk8yocg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 77CE487315E;
        Thu,  3 Dec 2020 16:04:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-159.rdu2.redhat.com [10.10.112.159])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 22112189C4;
        Thu,  3 Dec 2020 16:04:09 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20201203155043.GI11935@casper.infradead.org>
References: <20201203155043.GI11935@casper.infradead.org> <914680.1607004656@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, Christoph Hellwig <hch@infradead.org>,
        jlayton@redhat.com, dchinner@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com
Subject: Re: Problems doing DIO to netfs cache on XFS from Ceph
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1022187.1607011449.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 03 Dec 2020 16:04:09 +0000
Message-ID: <1022188.1607011449@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> > Note that I'm only doing async DIO reads and writes, so I was a bit su=
rprised
> > that XFS is doing a writeback at all - but I guess that IOCB_DIRECT is
> > actually just a hint and the filesystem can turn it into buffered I/O =
if it
> > wants.
> =

> That's almost the exact opposite of what is going on.  XFS sees that
> you're going to do an O_DIRECT read, so it writes back the dirty memory
> that's currently in the page cache so that your read doesn't read stale
> data from disk.

In this trace, yes, that's true - but where did the dirty memory in the
pagecache come from?  I'm only doing DIO reads and DIO writes - oh, and as=
 it
turns out, fallocate(FALLOC_FL_ZERO_RANGE) - which, I think, may be the so=
urce
of the dirty data.

David

