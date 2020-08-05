Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1E423CFA8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Aug 2020 21:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgHETXd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Aug 2020 15:23:33 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26831 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728877AbgHERbX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:31:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596648682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e2gumUE5A/5ojzMFKs9UdfuL6+IZWqdj2OsZcZsTEkI=;
        b=eI7VMI+Ic8nifMSLQzQsI5duOrcCcqDS9M2fITOl4U+oVELqIG28XSA202IlbRXWPbEcHJ
        cNDMuguvFcY2NVb04+PzG1L1QcCxsRAVsMRqPUJJw6HL6gJB3jHQGKTdLPLMd7CZtrL+Lt
        i+4OqzvCJrXJLy0Ewsz/DjeKrKq8DC0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-8_Z_ROD0MgGQYCnHoTmj4w-1; Wed, 05 Aug 2020 10:14:03 -0400
X-MC-Unique: 8_Z_ROD0MgGQYCnHoTmj4w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2EC371DF7;
        Wed,  5 Aug 2020 14:13:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DE65D5C1BD;
        Wed,  5 Aug 2020 14:13:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200804104108.GC32719@miu.piliscsaba.redhat.com>
References: <20200804104108.GC32719@miu.piliscsaba.redhat.com> <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk> <159646183662.1784947.5709738540440380373.stgit@warthog.procyon.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, raven@themaw.net,
        mszeredi@redhat.com, christian@brauner.io, jannh@google.com,
        darrick.wong@oracle.com, kzak@redhat.com, jlayton@redhat.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/18] fsinfo: Add a uniquifier ID to struct mount [ver #21]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2306028.1596636828.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 05 Aug 2020 15:13:48 +0100
Message-ID: <2306029.1596636828@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:

> > +#ifdef CONFIG_FSINFO
> > +	u64	mnt_unique_id;		/* ID unique over lifetime of kernel */
> > +#endif
>
> Not sure if it's worth making conditional.

You can't get at it without CONFIG_FSINFO=3Dy as it stands, but making it
unconditional might be reasonable.

> > -		n.auxiliary_mount	=3D aux->mnt_id;
> > +		n.auxiliary_mount =3D aux->mnt_unique_id;
>
> Hmm, so we now have two ID's:
>
>  - one can be used to look up the mount
>  - one is guaranteed to be unique
>
> With this change the mount cannot be looked up with FSINFO_FLAGS_QUERY_M=
OUNT,
> right?
>
> Should we be merging the two ID's into a single one which has both prope=
rties?

Ideally, yes... but...  The 31-bit mnt_id is currently exposed to userspac=
e in
various places, e.g. /proc, sys_name_to_handle_at().  So we have to keep t=
hat
as is and we can't expand it.

For fsinfo(), however, it might make sense to only use the 64-bit uniquifi=
er
as the identifier to use for direct look up.

However, looking up that identifier requires some sort of structure for do=
ing
this and it's kind of worst case for the IDR tree as the keys are graduall=
y
going to spread out, causing it to eat more memory.  It may be a tradeoff
worth making, and the memory consumption might not be that bad - or we cou=
ld
use some other data structure such as an rbtree.

That's why I was going for the 31-bit identifier + uniquifier so that you =
can at
least tell if the identifier got recycled reasonably quickly.

David

