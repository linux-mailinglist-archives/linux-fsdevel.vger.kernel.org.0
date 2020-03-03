Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C83F177B1F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 16:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbgCCPyE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 10:54:04 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36910 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729819AbgCCPyE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 10:54:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583250842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AOExeUOyNDqAFm6mopMdpHTa+bOM1g1XII8yprReEI8=;
        b=XO76EkJ8o9YtmCty2py+KB23MwLDUnITSUSbDn/oY0ld2/MDh/vo2cO87M13xLwvlt0P6G
        iziCd51oEi1QvhDJwf5Q3+kMUm7QN6RHDRkJE0c6/QPLFjZDq23BzOtKOnNkBC4RBguBrY
        jmRNMxnyCv4Z7FQq9tcq45XyCbhl3DU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-EDcCpvkjO_-vX5ams9tUzA-1; Tue, 03 Mar 2020 10:53:59 -0500
X-MC-Unique: EDcCpvkjO_-vX5ams9tUzA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC33710CE78A;
        Tue,  3 Mar 2020 15:53:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-182.rdu2.redhat.com [10.10.120.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 76EF8100EBA4;
        Tue,  3 Mar 2020 15:53:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200303152352.GA221026@kroah.com>
References: <20200303152352.GA221026@kroah.com> <CAJfpegu0qHBZ7iK=R4ajmmHC4g=Yz56otpKMy5w-y0UxJ1zO+Q@mail.gmail.com> <0403cda7345e34c800eec8e2870a1917a8c07e5c.camel@themaw.net> <CAJfpegtu6VqhPdcudu79TX3e=_NZaJ+Md3harBGV7Bg_-+fR8Q@mail.gmail.com> <1509948.1583226773@warthog.procyon.org.uk> <CAJfpegtOwyaWpNfjomRVOt8NKqT94O5n4-LOHTR7YZT9fadVHA@mail.gmail.com> <20200303113814.rsqhljkch6tgorpu@ws.net.home> <20200303130347.GA2302029@kroah.com> <20200303131434.GA2373427@kroah.com> <CAJfpegt0aQVvoDeBXOu2xZh+atZQ+q5uQ_JRxe46E8cZ7sHRwg@mail.gmail.com> <20200303142351.vtc2ldqltev5jo4h@wittgenstein>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     dhowells@redhat.com,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver #17]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1842202.1583250829.1@warthog.procyon.org.uk>
Date:   Tue, 03 Mar 2020 15:53:49 +0000
Message-ID: <1842203.1583250829@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> If you look at the patch I posted in this thread, I think it properly
> supports open_how and RESOLVE_* flags.  But remember it's opening a file
> that is already present, in RO mode, no creation allowed, so most of the
> open_how interactions are limited.

Something we should consider adding to openat2() at some point is the ability
to lock on open/create.  Various network filesystems support it.

David

