Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4682BC5D8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Nov 2020 14:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbgKVNdP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Nov 2020 08:33:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34610 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727845AbgKVNdO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Nov 2020 08:33:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606051993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lnPf0qqP5JlhbpeDaQweU3dHG38zjWq/RJM2h9qX9nk=;
        b=GWERhRBH/+dG1OatJBcPmNkGouYC/T7pfwjb2l1LWr6CWIas3uB1uzuD1+h8DRYIw6ob5W
        E7Vn7hwOWhZ9GsffLhDmIHFNjPxkVdDioZBu+tniYOY3mpdnmHHV7cyP1PWUdiuoKMt4K5
        F9RNpa80F1faApglPwcWeD5BOzs5ngE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-Z1FtuahSPYu6b0Cj1_fiog-1; Sun, 22 Nov 2020 08:33:09 -0500
X-MC-Unique: Z1FtuahSPYu6b0Cj1_fiog-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63AB0809DC3;
        Sun, 22 Nov 2020 13:33:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5B97710016F7;
        Sun, 22 Nov 2020 13:33:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wjttbQzVUR-jSW-Q42iOUJtu4zCxYe9HO3ovLGOQ_3jSA@mail.gmail.com>
References: <CAHk-=wjttbQzVUR-jSW-Q42iOUJtu4zCxYe9HO3ovLGOQ_3jSA@mail.gmail.com> <160596800145.154728.7192318545120181269.stgit@warthog.procyon.org.uk> <160596801020.154728.15935034745159191564.stgit@warthog.procyon.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, Pavel Begunkov <asml.silence@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/29] iov_iter: Switch to using a table of operations
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <254317.1606051984.1@warthog.procyon.org.uk>
Date:   Sun, 22 Nov 2020 13:33:04 +0000
Message-ID: <254318.1606051984@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

>  - I worry a bit about the indirect call overhead and spectre v2.

I don't know enough about how spectre v2 works to say if this would be a
problem for the ops-table approach, but wouldn't it also affect the chain of
conditional branches that we currently use, since it's branch-prediction
based?

David

