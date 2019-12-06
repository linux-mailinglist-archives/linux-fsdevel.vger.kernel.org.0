Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A058A11589B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2019 22:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfLFV0U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Dec 2019 16:26:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60380 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726330AbfLFV0U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Dec 2019 16:26:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575667579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+ro7bTB1Lb1Dw2x6kGNQy3f1bBvltzngF6vogTIyx+E=;
        b=V6bi4UQ9100Y5AwtmBKKRsx6zxbRZKXV6/MP+LvgQOHWjb+aDE9E/c39srr32GdiFIvETv
        uQQnPeFMeSXqYJ4/yAoiblxEzxGQX23uqiMPS0t+MfQA9/G1vDtWAJxbEXFqkQE/iEGe2J
        JV1ggrKo+yB53GHaz5AjqEBmQQETH60=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-ZJ8EjDzDPOCgzxfMJ7PhWg-1; Fri, 06 Dec 2019 16:26:17 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 149758F808A;
        Fri,  6 Dec 2019 21:26:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-250.rdu2.redhat.com [10.10.120.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8D3E85C1D4;
        Fri,  6 Dec 2019 21:26:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wiN_pWbcRaw5L-J2EFUyCn49Due0McwETKwmFFPp88K8Q@mail.gmail.com>
References: <CAHk-=wiN_pWbcRaw5L-J2EFUyCn49Due0McwETKwmFFPp88K8Q@mail.gmail.com> <157558502272.10278.8718685637610645781.stgit@warthog.procyon.org.uk> <20191206135604.GB2734@twin.jikos.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, David Sterba <dsterba@suse.cz>,
        Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] pipe: Fixes [ver #2]
MIME-Version: 1.0
Content-ID: <15057.1575667572.1@warthog.procyon.org.uk>
Date:   Fri, 06 Dec 2019 21:26:12 +0000
Message-ID: <15058.1575667572@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: ZJ8EjDzDPOCgzxfMJ7PhWg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> I think I found it.
>=20
> TOTALLY UNTESTED patch appended. It's whitespace-damaged and may be
> completely wrong. And might not fix it.
>=20
> The first hunk is purely syntactic sugar - use the normal head/tail
> order. The second/third hunk is what I think fixes the problem:
> iter_file_splice_write() had the same buggy "let's cache
> head/tail/mask" pattern as pipe_write() had.
>=20
> You can't cache them over  a 'pipe_wait()' that drops the pipe lock,
> and there's one in splice_from_pipe_next().

That seems to fix it.

Tested-by: David Howells <dhowells@redhat.com>

