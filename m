Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B439346BBA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 23:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbhCWWHC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 18:07:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30764 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233820AbhCWWGY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 18:06:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616537176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pRq3eZVbRV0oWPAPcRDv0Y/ExsjTvRldW+ZwtCTRY5g=;
        b=bMrzLOiZz3NlLrLm/cQOwK99hlD2jlUeUP7xiOdcFmgn8f11RAwYIZtY6kuC4VMesH+7hQ
        IQ3ViBQVU2KzjtABCIss6cWBI1OFKZIamOZfqmfqTGKNo5e6M9sA1hg6Z99yi2bInfixp+
        4CoLjmBEBp4wTkJ8pD0722stjCavkXQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-kYdx-kK4MaCmJMrG8tZ3eA-1; Tue, 23 Mar 2021 18:06:15 -0400
X-MC-Unique: kYdx-kK4MaCmJMrG8tZ3eA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0FF7800D53;
        Tue, 23 Mar 2021 22:06:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-58.rdu2.redhat.com [10.10.112.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 28FFB50C0E;
        Tue, 23 Mar 2021 22:06:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <2503810.1616508988@warthog.procyon.org.uk>
References: <2503810.1616508988@warthog.procyon.org.uk> <20210323135116.GF1719932@casper.infradead.org> <1885296.1616410586@warthog.procyon.org.uk> <20210321105309.GG3420@casper.infradead.org> <161539526152.286939.8589700175877370401.stgit@warthog.procyon.org.uk> <161539528910.286939.1252328699383291173.stgit@warthog.procyon.org.uk> <2499407.1616505440@warthog.procyon.org.uk>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/28] mm: Add an unlock function for PG_private_2/PG_fscache
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2769313.1616537164.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 23 Mar 2021 22:06:04 +0000
Message-ID: <2769314.1616537164@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> > > -	wait_on_page_writeback(page);
> > > +	if (wait_on_page_writeback_killable(page) < 0)
> > > +		return VM_FAULT_RETRY | VM_FAULT_LOCKED;
> > =

> > You forgot to unlock the page.
> =

> Do I need to?  Doesn't VM_FAULT_LOCKED indicate that to the caller?  Or =
is it
> impermissible to do it like that?

Looks like, yes, I do need to.  VM_FAULT_LOCKED is ignored if RETRY is giv=
en.

David

