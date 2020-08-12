Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA54242A6A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 15:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgHLNdY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 09:33:24 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23303 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728150AbgHLNdX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 09:33:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597239202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NWN81718k5D1jMF9UtCdbu9hqX0kFHSaNB7Aldah82c=;
        b=RNwsrih5wis+3U7hRb2hkjtmaAaNvusYWl5dGsw7DEalVZ6Hg8TlL5iUNqnVP6UKbC6XBr
        RVn+Zn67yWVhfurUlzFWlI/TnV99bXhiKfN6E3l31FGeL+8jxRvmqG8iXcLXXhlfJjQkVj
        Ml+dIH/KP7FnPdfJsHn5iPnEZ3WWyyk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-ig7PBHqSNSKE-wAwBjuKtw-1; Wed, 12 Aug 2020 09:33:18 -0400
X-MC-Unique: ig7PBHqSNSKE-wAwBjuKtw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8D0380183C;
        Wed, 12 Aug 2020 13:33:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-127.rdu2.redhat.com [10.10.120.127])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D88E45D73A;
        Wed, 12 Aug 2020 13:33:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAJfpegs4gzvJMBz=su8KgXXxX41tv8tVhO88Eap9pDeHRaSDPA@mail.gmail.com>
References: <CAJfpegs4gzvJMBz=su8KgXXxX41tv8tVhO88Eap9pDeHRaSDPA@mail.gmail.com> <1842689.1596468469@warthog.procyon.org.uk> <1845353.1596469795@warthog.procyon.org.uk> <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com> <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net> <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com> <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com> <20200811135419.GA1263716@miu.piliscsaba.redhat.com> <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com> <20200812101405.brquf7xxt2q22dd3@ws.net.home>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     dhowells@redhat.com, Karel Zak <kzak@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <133507.1597239193.1@warthog.procyon.org.uk>
Date:   Wed, 12 Aug 2020 14:33:13 +0100
Message-ID: <133508.1597239193@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:

> You said yourself, that what's really needed is e.g. consistent
> snapshot of a complete mount tree topology.  And to get the complete
> topology FSINFO_ATTR_MOUNT_TOPOLOGY and FSINFO_ATTR_MOUNT_CHILDREN are
> needed for *each* individual mount.

That's not entirely true.

FSINFO_ATTR_MOUNT_ALL can be used instead of FSINFO_ATTR_MOUNT_CHILDREN if you
want to scan an entire subtree in one go.  It returns the same record type.

The result from ALL/CHILDREN includes sufficient information to build the
tree.  That only requires the parent ID.  All the rest of the information
TOPOLOGY exposes is to do with propagation.

Now, granted, I didn't include all of the topology info in the records
returned by ALL/CHILDREN because I don't expect it to change very often.  But
you can check the event counter supplied with each record to see if it might
have changed - and then call TOPOLOGY on the ones that changed.

If it simplifies life, I could add the propagation info into ALL/CHILDREN so
that you only need to call ALL to scan everything.  It requires larger
buffers, however.

> Adding a few generic binary interfaces is okay.   Adding many
> specialized binary interfaces is a PITA.

Text interfaces are also a PITA, especially when you may get multiple pieces
of information returned in one buffer and especially when you throw in
character escaping.  Of course, we can do it - and we do do it all over - but
that doesn't make it efficient.

David

