Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A566722C46F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 13:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgGXLgQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 07:36:16 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22527 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726952AbgGXLgP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 07:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595590573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I68fbRd6bZ95LK9+jolwOQBVPAxfW2jV01rcWnCSNp0=;
        b=QiUxsE5hiBwr1+j9+9A4zI7TPuUTuM2MYnn90e7OYV5jLh3QfxzurpmL60vc6A3ms52vre
        j+UHnijDh5I2fbv/M7PFXw/GhI8YQIWkR+W8GbBqnuGIgXCB66AMoYdThyeNxV1KhN2wYD
        DYGnf68Iwt82eYr9qVbQZBthoTuur4M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-PexwN0WVOwWbFOVy0tM0dg-1; Fri, 24 Jul 2020 07:36:10 -0400
X-MC-Unique: PexwN0WVOwWbFOVy0tM0dg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 507C6107ACCA;
        Fri, 24 Jul 2020 11:36:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EDB2919723;
        Fri, 24 Jul 2020 11:36:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <865566fb800a014868a9a7e36a00a14430efb11e.camel@themaw.net>
References: <865566fb800a014868a9a7e36a00a14430efb11e.camel@themaw.net> <1293241.1595501326@warthog.procyon.org.uk> <CAJfpegspWA6oUtdcYvYF=3fij=Bnq03b8VMbU9RNMKc+zzjbag@mail.gmail.com> <158454378820.2863966.10496767254293183123.stgit@warthog.procyon.org.uk> <158454391302.2863966.1884682840541676280.stgit@warthog.procyon.org.uk> <2003787.1595585999@warthog.procyon.org.uk>
To:     Ian Kent <raven@themaw.net>
Cc:     dhowells@redhat.com, Miklos Szeredi <miklos@szeredi.hu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, nicolas.dichtel@6wind.com,
        Christian Brauner <christian@brauner.io>, andres@anarazel.de,
        Jeff Layton <jlayton@redhat.com>, dray@redhat.com,
        Karel Zak <kzak@redhat.com>, keyrings@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/17] watch_queue: Implement mount topology and attribute change notifications [ver #5]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2023285.1595590563.1@warthog.procyon.org.uk>
Date:   Fri, 24 Jul 2020 12:36:03 +0100
Message-ID: <2023286.1595590563@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ian Kent <raven@themaw.net> wrote:

> I was wondering about id re-use.
> 
> Assuming that ids that are returned to the idr db are re-used
> what would the chance that a recently used id would end up
> being used?
> 
> Would that chance increase as ids are consumed and freed over
> time?

I've added something to deal with that in the fsinfo branch.  I've given each
mount object and superblock a supplementary 64-bit unique ID that's not likely
to repeat before we're no longer around to have to worry about it.

fsinfo() then allows you to retrieve them by path or by mount ID.

So, yes, mnt_id and s_dev are not unique and may be reused very quickly, but
I'm also providing uniquifiers that you can check.

David

