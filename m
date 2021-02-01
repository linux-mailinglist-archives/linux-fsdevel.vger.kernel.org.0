Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA0830AB43
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Feb 2021 16:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbhBAP22 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Feb 2021 10:28:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29608 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231651AbhBAP1W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Feb 2021 10:27:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612193156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BEb2rLftFspGJmXbmXNZKP/pR0mJXCcoYLxWcopTgkE=;
        b=CUQJ080EoCYth5wLtQnHk4oNuS87FKoZCSZy0gEpsmeccNa0hEoeuzNzlDeoIa9J/SpkYI
        5BC3nfL74B/7p5YSmIF3+Tx1MFH3kgLUHgmV49NEy/OfqnWg0mZk1PuVGhT4PhEFfVy7Ak
        L3Gp992bs30yYr0GOUaTqEeOQp+Imls=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-537-4FQFVO3JPaSRNa_zDuxQ_w-1; Mon, 01 Feb 2021 10:25:50 -0500
X-MC-Unique: 4FQFVO3JPaSRNa_zDuxQ_w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0CD6100C661;
        Mon,  1 Feb 2021 15:25:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-23.rdu2.redhat.com [10.10.115.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4D2425D749;
        Mon,  1 Feb 2021 15:25:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAOi1vP_7dfuKgQxFpyeUDMJBGm=cnQSvYHDnU=6YPTzbB9+d6w@mail.gmail.com>
References: <CAOi1vP_7dfuKgQxFpyeUDMJBGm=cnQSvYHDnU=6YPTzbB9+d6w@mail.gmail.com> <20210126134103.240031-1-jlayton@kernel.org> <CAOi1vP-3Ma4LdCcu6sPpwVbmrto5HnOAsJ6r9_973hYY3ODBUQ@mail.gmail.com> <2301cde67ae7aa54d860fc3962aeb8ed85744c75.camel@kernel.org>
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-cachefs@redhat.com
Subject: Re: [PATCH 0/6] ceph: convert to new netfs read helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4171609.1612193143.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 01 Feb 2021 15:25:43 +0000
Message-ID: <4171610.1612193143@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ilya Dryomov <idryomov@gmail.com> wrote:

> > David has a fscache-netfs-lib branch that has all of the infrastructur=
e
> > changes. See:
> >
> >     https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.=
git/log/?h=3Dfscache-netfs-lib
> =

> I saw that, but AFAICS it hasn't been declared public (as in suitable
> for other people to base their work on, with the promise that history
> won't get rewritten.

My intention to avoid modifying it further, except for extra fix patches
stacked on the end if necessary, as I want to try to avoid jinxing it from
getting pulled in the next merge window.

> It is branched off of what looks like a random snapshot of Linus' tree
> instead of a release point, etc.

Yeah, sorry about that.  I took what was current linus/master at the time =
I
cut the branch with the intention of trying to get it into linux-next befo=
re
-rc5 was tagged (ie. >3 weeks before the merge window), but including the
X.509 crash fix.

David

