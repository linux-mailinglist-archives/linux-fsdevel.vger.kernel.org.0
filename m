Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36BF13A7108
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 23:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234765AbhFNVNg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 17:13:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34248 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233356AbhFNVNf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 17:13:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623705091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0Mn8+GlgrQdOA/I1bTqxQYRGsb/yRw3f+Z55lqaAtNs=;
        b=aI7rarQHEkwR3LlFDC/VfLKp3WR+jVEuN5XsfZFEaS5KQxbHDO54/9Tty+dObtRaHoiKA/
        5wScdsCwqB618zZADH/gdhy8/IpDdz/fwWahEWZp1SQGD3VkuDR4wKVP7RMszPOs617TXi
        nNtiXuqJwzPw3Rc6qZ8uYCilhfNTPqc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-3bfqkI24OYSv0GZSCObOOQ-1; Mon, 14 Jun 2021 17:11:30 -0400
X-MC-Unique: 3bfqkI24OYSv0GZSCObOOQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7B7C1084F42;
        Mon, 14 Jun 2021 21:11:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-65.rdu2.redhat.com [10.10.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8A5445D9CA;
        Mon, 14 Jun 2021 21:11:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YMd5BqIKucO6rW4R@casper.infradead.org>
References: <YMd5BqIKucO6rW4R@casper.infradead.org> <YMdpxbYafHnE0F8N@casper.infradead.org> <162367681795.460125.11729955608839747375.stgit@warthog.procyon.org.uk> <162367682522.460125.5652091227576721609.stgit@warthog.procyon.org.uk> <475131.1623685101@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, jlayton@kernel.org,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] afs: Fix afs_write_end() to handle short writes
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <501526.1623705086.1@warthog.procyon.org.uk>
Date:   Mon, 14 Jun 2021 22:11:26 +0100
Message-ID: <501527.1623705086@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> > means you can't get there unless PageUptodate() is true by that point.
> 
> Isn't the point of an assertion to check that this is true?

The assertion was meant to check that that it was true given that the page was
set uptodate somewhere else before this function was even called.  With this
patch, however, it's now set in this function if it wasn't already right at
the top - so the assertion should now be redundant.  I can put it back if you
really insist.

David

