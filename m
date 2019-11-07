Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C924F36FA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2019 19:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfKGSYS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Nov 2019 13:24:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25354 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727618AbfKGSYR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Nov 2019 13:24:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573151056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rq286i/rn9P6qBg6Lj1S41KuQGmj4Rym9Rza+pzwTUU=;
        b=gxccqK4SlQB7fbgoLZbNR17gvVHcFYwcWo9ZYqgYukcWr1lfjURrpiKP1rbzVawzJWNkX3
        JdAujPtINmJRpIEKN+Bztp1l3bbrb5Cyrbtxt44wDtrFRm8HoyBIhvpqlFbKMcjYS1xRyS
        2Idj1FpLMXe8iFUvqySM3RpEPHTSWjk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-pb7rxykWNYyYpdYIKUe7Iw-1; Thu, 07 Nov 2019 13:23:10 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D6421005500;
        Thu,  7 Nov 2019 18:23:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-254.rdu2.redhat.com [10.10.120.254])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD28A60BEC;
        Thu,  7 Nov 2019 18:23:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CALCETrWszYm9=-WEgSbhmGc3DYCvY6q3W4Lezm6YtKnGtRs_5g@mail.gmail.com>
References: <CALCETrWszYm9=-WEgSbhmGc3DYCvY6q3W4Lezm6YtKnGtRs_5g@mail.gmail.com> <157313371694.29677.15388731274912671071.stgit@warthog.procyon.org.uk> <157313379331.29677.5209561321495531328.stgit@warthog.procyon.org.uk>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, USB list <linux-usb@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 08/14] pipe: Allow buffers to be marked read-whole-or-error for notifications [ver #2]
MIME-Version: 1.0
Content-ID: <4648.1573150984.1@warthog.procyon.org.uk>
Date:   Thu, 07 Nov 2019 18:23:04 +0000
Message-ID: <4649.1573150984@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: pb7rxykWNYyYpdYIKUe7Iw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Andy Lutomirski <luto@kernel.org> wrote:

> > Allow a buffer to be marked such that read() must return the entire buf=
fer
> > in one go or return ENOBUFS.  Multiple buffers can be amalgamated into =
a
> > single read, but a short read will occur if the next "whole" buffer won=
't
> > fit.
> >
> > This is useful for watch queue notifications to make sure we don't spli=
t a
> > notification across multiple reads, especially given that we need to
> > fabricate an overrun record under some circumstances - and that isn't i=
n
> > the buffers.
>=20
> Hmm.  I'm not totally in love with introducing a new error code like
> this for read(), especially if it could affect the kind of pipe that
> is bound to a file in a filesystem.  But maybe it's not a problem.

EMSGSIZE might be better?

David

