Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF4EE3B0CCC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 20:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbhFVS0B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 14:26:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31000 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230146AbhFVS0B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 14:26:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624386224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4wcUku5VYFOIqpjq4OYU4JOlXU8CasqeJwQGFJvPLW0=;
        b=RneEJtGJ2LlTcXcG9gnmQmSDJZlIUWqHf23uMU6xCuKbTptEmevba1y3Lxv6UqTzIWByL4
        /jYgvZwAB3J87h/UpBLubhCgKth1rrIRzE3G4gNrdsHOygDEN9uOT7M9gSGguZLoJ9S5NN
        hKEErNPcI/ciTXYw5uAm6RZlCuBXKqI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-ixJxdKnMMziAfh0cKU_bOw-1; Tue, 22 Jun 2021 14:23:28 -0400
X-MC-Unique: ixJxdKnMMziAfh0cKU_bOw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5CA02804142;
        Tue, 22 Jun 2021 18:23:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-65.rdu2.redhat.com [10.10.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9218B69CB4;
        Tue, 22 Jun 2021 18:23:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wicC9ZTNNH1E-oHebcT3+r4Q4Wf1tXBindXrCdotj20Gg@mail.gmail.com>
References: <CAHk-=wicC9ZTNNH1E-oHebcT3+r4Q4Wf1tXBindXrCdotj20Gg@mail.gmail.com> <CAHk-=wh=YxjEtTpYyhgypKmPJQ8eVLJ4qowmwbnG1bOU06_4Bg@mail.gmail.com> <3221175.1624375240@warthog.procyon.org.uk> <YNIBb5WPrk8nnKKn@zeniv-ca.linux.org.uk> <YNIDdgn0m8d2a0P3@zeniv-ca.linux.org.uk> <YNIdJaKrNj5GoT7w@casper.infradead.org> <3231150.1624384533@warthog.procyon.org.uk> <YNImEkqizzuStW72@casper.infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>, "Ted Ts'o" <tytso@mit.edu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Do we need to unrevert "fs: do not prefault sys_write() user buffer pages"?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3233311.1624386204.1@warthog.procyon.org.uk>
Date:   Tue, 22 Jun 2021 19:23:24 +0100
Message-ID: <3233312.1624386204@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> I'm not sure how that would even look. I don't think it would
> necessarily be *impossible* (special marker in the exception table to
> let the fault code know that this is a "prepare" fault), but it would
> be pretty challenging.

Probably the most obvious way would be to set a flag in task_struct saying
what you're doing and have the point that would otherwise wait for the page to
become unlocked skip to the fault fixup code if the page is locked after
->readahead() has been invoked and the flag is set, then use get_user() in
iov_iter_fault_in_readable().

But, as Willy says, there's a reasonable chance that the source page is
present anyway (presumably you want to write out data you've just constructed
or modified), in which case it's probably not worth the complexity.

David

