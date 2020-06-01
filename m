Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA871EAE43
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jun 2020 20:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730827AbgFASwR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jun 2020 14:52:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44249 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728474AbgFASwQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:52:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591037535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/HxsSLMMOoIzHyiVBdHfhWx2bWQGLvDQcR+hbKBfl/Y=;
        b=EFmhjcU38HzOYZN+GT73mwOIBIOjMYx6fV8dm1LKszZg3zS4R7RjN/quSj9eiuSm81PLqG
        +jIefUyTCVjE5n2L3Dq3/EzT5rlgQteN+yPFroqni+p/5xDDbFPN7BENalA8MwdvwDsdZ/
        rs6vcrUnfGaM1Ulmn2jGNvCDd+FsNFQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-7rYCDDOfOHuUOq293DmUsg-1; Mon, 01 Jun 2020 14:52:13 -0400
X-MC-Unique: 7rYCDDOfOHuUOq293DmUsg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8DFA19057B7;
        Mon,  1 Jun 2020 18:52:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-138.rdu2.redhat.com [10.10.112.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 328795D9E2;
        Mon,  1 Jun 2020 18:52:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <a28fd20e-1f9e-d070-4d2e-2bee89f39154@web.de>
References: <a28fd20e-1f9e-d070-4d2e-2bee89f39154@web.de> <779b327f-b0fa-e21f-cbf6-5cadeca58581@web.de> <1346217.1591031323@warthog.procyon.org.uk>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org,
        Zhihao Cheng <chengzhihao1@huawei.com>,
        Yi Zhang <yi.zhang@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [v2] afs: Fix memory leak in afs_put_sysnames()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1358844.1591037529.1@warthog.procyon.org.uk>
Date:   Mon, 01 Jun 2020 19:52:09 +0100
Message-ID: <1358845.1591037529@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Markus Elfring <Markus.Elfring@web.de> wrote:

> > 	Fix afs_put_sysnames() to actually free the specified afs_sysnames
> > 	object after its reference count has been decreased to zero and its
> > 	contents have been released.
> 
> * How do you think about to omit the word "Fix" because of the provided tag?

Quite often I might put introductory paragraphs before that, so I prefer to
begin the paragraph that states a fix with that verb.  There may also be
auxiliary changes associated with it that aren't directly fixes but need to be
made because of the fix change.

> * Is freeing and releasing an item a duplicate operation anyhow?

You're missing the point.  afs_put_sysnames() does release the things the
object points to (ie. the content), but not the object itself.

> >> Will it matter to mention the size of the data structure "afs_sysnames"?
> >
> > Why is it necessary to do so?
> 
> I suggest to express the impact of the missed function call "kfree".

I would hope that anyone reading the patch could work the impact out for
themselves.  Just specifying the size of a struct isn't all that useful - it
may be wildly variable by arch (eg. 32/64) and config option (eg. lockdep)
anyway.  Add to that rounding and packing details from the memory subsys,
along with the pinning effect of something you can't get rid of.

Of more use would be specifying the frequency or likelyhood of such a leak but
unless it's especially high, it's probably not worth mentioning.

David

