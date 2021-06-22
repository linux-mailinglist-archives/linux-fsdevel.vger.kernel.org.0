Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12E383B0A51
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 18:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhFVQ30 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 12:29:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32335 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229718AbhFVQ30 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 12:29:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624379229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hrhx/d0n+ruCXAaNUiGvt1DI7m7Wkz8aq+QQEOhzPsQ=;
        b=bw/OEVu8FaWunGXt/cJf7r3ZnjxT4ccG16LfRqY87B8Tgf8esVVhR1iER0cOd7ECzvc1it
        pD7fUhbRqDIPmDIm5Z8nVxZVePKNq2i8z/eW7q/7w7OA3C06Yb9EQsD+Dqz9Px82IF1tJ1
        Ppj/vJW0kiSQhJNa3aMWT9lpZBvzdWs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-qOaYXXfCMN2sdaBNmGU9jw-1; Tue, 22 Jun 2021 12:27:06 -0400
X-MC-Unique: qOaYXXfCMN2sdaBNmGU9jw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 494929F92E;
        Tue, 22 Jun 2021 16:27:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-65.rdu2.redhat.com [10.10.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0BFBA100760F;
        Tue, 22 Jun 2021 16:27:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YNIBb5WPrk8nnKKn@zeniv-ca.linux.org.uk>
References: <YNIBb5WPrk8nnKKn@zeniv-ca.linux.org.uk> <3221175.1624375240@warthog.procyon.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com, torvalds@linux-foundation.org,
        Ted Ts'o <tytso@mit.edu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org,
        linux-mm@kvack.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Do we need to unrevert "fs: do not prefault sys_write() user buffer pages"?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3225321.1624379221.1@warthog.procyon.org.uk>
Date:   Tue, 22 Jun 2021 17:27:01 +0100
Message-ID: <3225322.1624379221@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> wrote:

> On Tue, Jun 22, 2021 at 04:20:40PM +0100, David Howells wrote:
> 
> > and wondering if the iov_iter_fault_in_readable() is actually effective.
> > Yes, it can make sure that the page we're intending to modify is dragged
> > into the pagecache and marked uptodate so that it can be read from, but is
> > it possible for the page to then get reclaimed before we get to
> > iov_iter_copy_from_user_atomic()?  a_ops->write_begin() could potentially
> > take a long time, say if it has to go and get a lock/lease from a server.
> 
> Yes, it is.  So what?  We'll just retry.  You *can't* take faults while
> holding some pages locked; not without shitloads of deadlocks.

In that case, can we amend the comment immediately above
iov_iter_fault_in_readable()?

	/*
	 * Bring in the user page that we will copy from _first_.
	 * Otherwise there's a nasty deadlock on copying from the
	 * same page as we're writing to, without it being marked
	 * up-to-date.
	 *
	 * Not only is this an optimisation, but it is also required
	 * to check that the address is actually valid, when atomic
	 * usercopies are used, below.
	 */
	if (unlikely(iov_iter_fault_in_readable(i, bytes))) {

The first part suggests this is for deadlock avoidance.  If that's not true,
then this should perhaps be changed.

David

