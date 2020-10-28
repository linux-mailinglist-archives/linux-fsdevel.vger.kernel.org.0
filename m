Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885F429DCC1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 01:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387719AbgJ1Wab (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 18:30:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36267 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387551AbgJ1W3R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:29:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603924156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2SCyw0MgDOHFJTfd5PusUshasNlUpVC0PdQO3C9hYF4=;
        b=dCnwaS0uFF3PTFI5FSSj0XclZ2CTn7ExGOY2InFDq8NWA0BeCONHayMtXnuXK3fIHrwA4y
        QovhWwFwN3Fm9ywPf+UEliLRBirPnsejsF6pxExYR6y1XRKrK/IKplPUjDqNomK/CW/GQx
        Ip9UbEjaL/NiusIRkOTq1MKohPzh7Jg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-8iaP2f06P9aMvLjwi3vFEA-1; Wed, 28 Oct 2020 13:27:55 -0400
X-MC-Unique: 8iaP2f06P9aMvLjwi3vFEA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72A76188C122;
        Wed, 28 Oct 2020 17:27:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-70.rdu2.redhat.com [10.10.120.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 65BA15C1D0;
        Wed, 28 Oct 2020 17:27:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20201028171159.GB20115@casper.infradead.org>
References: <20201028171159.GB20115@casper.infradead.org> <20201028143442.GA20115@casper.infradead.org> <160389418807.300137.8222864749005731859.stgit@warthog.procyon.org.uk> <160389426655.300137.17487677797144804730.stgit@warthog.procyon.org.uk> <548209.1603904708@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        kernel test robot <lkp@intel.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/11] afs: Fix dirty-region encoding on ppc32 with 64K pages
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <550614.1603906072.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 28 Oct 2020 17:27:52 +0000
Message-ID: <550615.1603906072@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> > > > +{
> > > > +	if (PAGE_SIZE - 1 <=3D __AFS_PAGE_PRIV_MASK)
> > > > +		return 1;
> > > > +	else
> > > > +		return PAGE_SIZE / (__AFS_PAGE_PRIV_MASK + 1);
> > > =

> > > Could this be DIV_ROUND_UP(PAGE_SIZE, __AFS_PAGE_PRIV_MASK + 1); avo=
iding
> > > a conditional?  I appreciate it's calculated at compile time today, =
but
> > > it'll be dynamic with THP.
> > =

> > Hmmm - actually, I want a shift size, not a number of bytes as I divid=
e by it
> > twice in afs_page_dirty().
> =

> __AFS_PAGE_PRIV_MASK is a constant though.  If your compiler can't
> optimise a divide-by-a-constant-power-of-two into a shift-by-a-constant =
(*),
> it's time to get yourself a new compiler.
> =

> (*) assuming that's faster on the CPU it's targetting.

I'm dividing by the resolution, which is calculated from the page size - w=
hich
in a THP world is variable:

	static inline unsigned long afs_page_dirty(size_t from, size_t to)
	{
		size_t res =3D afs_page_dirty_resolution();
		from /=3D res; /* Round down */
		to =3D (to - 1) / res; /* Round up */
		return ((unsigned long)to << __AFS_PAGE_PRIV_SHIFT) | from;
	}

David

