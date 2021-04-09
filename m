Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF98A35A290
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 18:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbhDIQEK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 12:04:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24193 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233883AbhDIQEI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 12:04:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617984234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l/YtRHbaNxAvJJBbIoYtFy0sDOmcZWRbIs4MjOEQB/k=;
        b=MbrfZzL3UIdk1KlQ+svyyTKMeUegGG/KBL3rYz3j2jDCKEa/nqOQnTHQfWVmflzacwsbJY
        Wbc1fIs9mFrmSUafO5ymi07fjJpkclY0YgF7xPO/TjBiFPhpKXkHtMPsyWHAWbYx3cV/5S
        cvZ5dIlEG4XYKCNxKQLrj9jvJnoObFE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-VKd9VOlPMEOH6PW381t7Pg-1; Fri, 09 Apr 2021 12:03:50 -0400
X-MC-Unique: VKd9VOlPMEOH6PW381t7Pg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54C20801814;
        Fri,  9 Apr 2021 16:03:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-119-35.rdu2.redhat.com [10.10.119.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E36435C1D5;
        Fri,  9 Apr 2021 16:03:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <625171.1617971734@warthog.procyon.org.uk>
References: <625171.1617971734@warthog.procyon.org.uk> <20210409111636.GR2531743@casper.infradead.org> <CAHk-=wi_XrtTanTwoKs0jwnjhSvwpMYVDJ477VtjvvTXRjm5wQ@mail.gmail.com> <161796595714.350846.1547688999823745763.stgit@warthog.procyon.org.uk>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        torvalds@linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, jlayton@kernel.org, hch@lst.de,
        linux-cachefs@redhat.com, v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] mm: Return bool from pagebit test functions
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <838189.1617984218.1@warthog.procyon.org.uk>
Date:   Fri, 09 Apr 2021 17:03:38 +0100
Message-ID: <838190.1617984218@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> add/remove: 2/2 grow/shrink: 15/16 up/down: 408/-599 (-191)
> Function                                     old     new   delta
> iomap_write_end_inline                         -     128    +128

I can get rid of the iomap_write_end_inline() increase for my config by
marking it __always_inline, thereby getting:

add/remove: 1/2 grow/shrink: 15/15 up/down: 280/-530 (-250)

It seems that the decision whether or not to inline iomap_write_end_inline()
is affected by the switch to bool.

David

