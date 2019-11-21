Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDC18104EC4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 10:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfKUJLT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 04:11:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36205 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726165AbfKUJLT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 04:11:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574327478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w+2VeTDW39t7F83wwHYaxqmce+U8i0UFmJnVyrwvtLk=;
        b=ivbSTCibLGqq78slzQXZhH3QyFdEEDkMkosk0xd/FA6dW+8vspnW73Su6sGZDKiampe6SV
        tT/wGB2lzeOiw7WQ3dUs5/adkzDhi51ozFdSpgkeCHlaO3bSD1MHBAhoAUDUqcIywY9ota
        LwRsw4zZMr5nfiBdcqc5rz38wLJbSzw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-SZzEslkLP-OOQDXvgHQCaw-1; Thu, 21 Nov 2019 04:11:14 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B41CB801FCF;
        Thu, 21 Nov 2019 09:11:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-161.rdu2.redhat.com [10.10.120.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B462F60BC9;
        Thu, 21 Nov 2019 09:11:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20191121081923.GA19366@infradead.org>
References: <20191121081923.GA19366@infradead.org> <157432403818.17624.9300948341879954830.stgit@warthog.procyon.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dhowells@redhat.com, sfrench@samba.org, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] cifs: Don't use iov_iter::type directly
MIME-Version: 1.0
Content-ID: <30991.1574327471.1@warthog.procyon.org.uk>
Date:   Thu, 21 Nov 2019 09:11:11 +0000
Message-ID: <30992.1574327471@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: SZzEslkLP-OOQDXvgHQCaw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:

> I'd rather get rid of the accessor and access the fields directly, as
> that is much easier to follow.

The problem is that the type is arranged as a bunch of bits:

=09ITER_IOVEC =3D 4,
=09ITER_KVEC =3D 8,
=09ITER_BVEC =3D 16,
=09ITER_PIPE =3D 32,
=09ITER_DISCARD =3D 64,

and we end up doing a lot of:

=09if (type & TYPE1) {
=09} else if (type & TYPE2) {
=09} else if (type & TYPE3) {
=09} else if (type & TYPE4) {
=09} else {
=09=09/* Do ITER_IOVEC */
=09}

constructs - which isn't necessarily the most efficient for the CPU,
particularly if we get more iterator types.  Note that ITER_IOVEC (which I
think is the common case) is usually coming last - and the CPU has to do al=
l
the other checks first since the compiler can't know that it might be able =
to
take a shortcut (ie. rule out all the other types in one check first).

What I've been exploring is moving to:

=09ITER_IOVEC =3D 0
=09ITER_KVEC =3D 1,
=09ITER_BVEC =3D 2,
=09ITER_PIPE =3D 3,
=09ITER_DISCARD =3D 4,

and using switch statements - and then leaving it to the compiler to decide
how best to do things.  In some ways, it might be nice to let the compiler
decide what constants it might use for this so as to best optimise the use
cases, but there's no way to do that at the moment.

However, all the code that is doing direct accesses using '&' has to change=
 to
make that work - so I've converted it all to using accessors so that I only
have to change the header file, except that the patch to do that crossed wi=
th
a cifs patch that added more direct accesses, IIRC.

David

