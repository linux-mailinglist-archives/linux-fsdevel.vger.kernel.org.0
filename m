Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E6E3A6A9C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 17:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbhFNPke (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 11:40:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31678 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233640AbhFNPkd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:40:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623685109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qKSz/LRN00+0nJv4NZOhjKiU+MuuvkiLXHI2jFvDWTo=;
        b=Mbp0ZwDR2HypBcyB3KticqOkWoNbLZcql6mWE50edenoyH1NEs3my0pBgzGx/sXdN8wgpx
        ek7orpeud9IFM3iWUm7K5YiHOy5+3h6ZkU6wmopWcydTmniHU7JzusMyhWoRp9XzX7NC1C
        9gqoqoAwUm3Rsy1/2+ndq3mb5WhuFN0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-7bpBxVSNPlCeR3mvDSJyDA-1; Mon, 14 Jun 2021 11:38:26 -0400
X-MC-Unique: 7bpBxVSNPlCeR3mvDSJyDA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0652619253C6;
        Mon, 14 Jun 2021 15:38:24 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-65.rdu2.redhat.com [10.10.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B766219C46;
        Mon, 14 Jun 2021 15:38:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YMdpxbYafHnE0F8N@casper.infradead.org>
References: <YMdpxbYafHnE0F8N@casper.infradead.org> <162367681795.460125.11729955608839747375.stgit@warthog.procyon.org.uk> <162367682522.460125.5652091227576721609.stgit@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, jlayton@kernel.org,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] afs: Fix afs_write_end() to handle short writes
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <475130.1623685101.1@warthog.procyon.org.uk>
Date:   Mon, 14 Jun 2021 16:38:21 +0100
Message-ID: <475131.1623685101@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> > -	ASSERT(PageUptodate(page));
> > -
> >  	if (PagePrivate(page)) {
> >  		priv = page_private(page);
> >  		f = afs_page_dirty_from(page, priv);
> 
> Why are you removing this assertion?  Does AFS now support dirty,
> partially-uptodate pages?  If so, a subsequent read() to that
> page is going to need to be careful to only read the parts of the page
> from the server that haven't been written ...

Because the previous hunk in the patch:

	+	if (!PageUptodate(page)) {
	+		if (copied < len) {
	+			copied = 0;
	+			goto out;
	+		}
	+
	+		SetPageUptodate(page);
	+	}

means you can't get there unless PageUptodate() is true by that point.

David

