Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B09D9259F5B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Sep 2020 21:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgIAToU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Sep 2020 15:44:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28450 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726107AbgIAToT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Sep 2020 15:44:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598989458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nTHlq3Kl2GCIO7zccVhN6JeQ5RlCQEu/xPuuaep77Qk=;
        b=K+VeHmUMuGySv/GBtZ5hngff1skKlnluIGzkGzbgyLtQf7aBO8rcLqvPPRjSvFMczFB2hC
        EBg45NCQ/gsXuVtQLuGRV54M3PORZjHwnfUnAdRgvlqltQX1ZCL+lSGbeut8Lcal9rioxM
        H5Cf12h4yzLtsaqjQHCeyWrNEHz7lx8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-j-YWKZGfMaSROuVIV8aAKg-1; Tue, 01 Sep 2020 15:44:17 -0400
X-MC-Unique: j-YWKZGfMaSROuVIV8aAKg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 247FE425D1;
        Tue,  1 Sep 2020 19:44:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-231.rdu2.redhat.com [10.10.113.231])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 25FEC78B29;
        Tue,  1 Sep 2020 19:44:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200901164827.GQ14765@casper.infradead.org>
References: <20200901164827.GQ14765@casper.infradead.org> <159897769535.405783.17587409235571100774.stgit@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/7] mm: Make more use of readahead_control
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <423538.1598989454.1@warthog.procyon.org.uk>
Date:   Tue, 01 Sep 2020 20:44:14 +0100
Message-ID: <423539.1598989454@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> > Note that I've been
> > passing the number of pages to read in rac->_nr_pages, and then saving it
> > and changing it certain points, e.g. page_cache_readahead_unbounded().
> 
> I do not like this.  You're essentially mutating the meaning of _nr_pages
> as the ractl moves down the stack, and that's going to lead to bugs.
> I'd keep it as a separate argument.

The meaning isn't specified in linux/pagemap.h.  Can you adjust the comments
on the struct and on readahead_count() to make it more clear what the value
represents?

Thanks,
David

