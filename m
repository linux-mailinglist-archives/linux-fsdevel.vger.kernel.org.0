Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D361929A7DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Oct 2020 10:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895590AbgJ0J3z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Oct 2020 05:29:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60032 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2895588AbgJ0J3y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Oct 2020 05:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603790993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=feIJOART/ZjbjgTvLv37NEKK+uAf07iUjckzKK2mLvo=;
        b=SljjII7eLt3VvPPy7LrOzyhNOMvKwfDe39zTJQeFjFv6DAvjMXXWeNFSBL/jJlhW7dgAhp
        rdB7xXDhGlPBthd/sIqprsUXB892cotkW/QF8dlEX7Y5ujh70dz+mddPE36jbnxul92x2j
        TT0bI44lVn8WAcyZMLbuhOQq+l9cm50=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-8oJbH0wQNXae1a0bKDAYWw-1; Tue, 27 Oct 2020 05:29:49 -0400
X-MC-Unique: 8oJbH0wQNXae1a0bKDAYWw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DC62186DD25;
        Tue, 27 Oct 2020 09:29:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-70.rdu2.redhat.com [10.10.120.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 89DA75C1BD;
        Tue, 27 Oct 2020 09:29:45 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200827150030.282762-3-hch@lst.de>
References: <20200827150030.282762-3-hch@lst.de> <20200827150030.282762-1-hch@lst.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 02/10] fs: don't allow splice read/write without explicit ops
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3088367.1603790984.1@warthog.procyon.org.uk>
Date:   Tue, 27 Oct 2020 09:29:44 +0000
Message-ID: <3088368.1603790984@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote:

> default_file_splice_write is the last piece of generic code that uses
> set_fs to make the uaccess routines operate on kernel pointers.  It
> implements a "fallback loop" for splicing from files that do not actually
> provide a proper splice_read method.  The usual file systems and other
> high bandwith instances all provide a ->splice_read, so this just removes
> support for various device drivers and procfs/debugfs files.  If splice
> support for any of those turns out to be important it can be added back
> by switching them to the iter ops and using generic_file_splice_read.

Hmmm...  this causes the copy_file_range() syscall to fail with EINVAL in some
places where before it used to work.

For my part, it causes the generic/112 xfstest to fail with afs, but there may
be other places.

Is this a regression we need to fix in the VFS core?  Or is it something we
need to fix in xfstests and assume userspace will fallback to doing it itself?

David

