Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B95A846F648
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 22:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbhLIWBU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 17:01:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27552 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232968AbhLIWBT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 17:01:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639087065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nq1sf+kzjWsZVde2j+/s8Puw8BjH1Oy3rw3I3uvxMHo=;
        b=KIpH8bqufDGwARWWONckb30XpM0WL+UW8Vw/minAEGe+ZNuDi4n/+zEfnKEG2OQbmGVbHH
        AeXEhTgYFXNY9pL+ms+r3aPKABum2ek3pt+24iGGkZc7FxKWLWw3Fuww3nKu1Hl5qYJqjc
        8LQz1pru+92mgbRA3RvGlunWVeNKHnU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-goLxjqsmOXuXZtknWwaRCA-1; Thu, 09 Dec 2021 16:57:42 -0500
X-MC-Unique: goLxjqsmOXuXZtknWwaRCA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A8D3760C0;
        Thu,  9 Dec 2021 21:57:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DB9EB1017E27;
        Thu,  9 Dec 2021 21:57:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wiTquFUu-b5ME=rbGEF8r2Vh1TXGfaZZuXyOutVrgRzfw@mail.gmail.com>
References: <CAHk-=wiTquFUu-b5ME=rbGEF8r2Vh1TXGfaZZuXyOutVrgRzfw@mail.gmail.com> <163906878733.143852.5604115678965006622.stgit@warthog.procyon.org.uk> <163906888735.143852.10944614318596881429.stgit@warthog.procyon.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        linux-afs@lists.infradead.org,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 07/67] fscache: Implement a hash function
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <159179.1639087053.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 09 Dec 2021 21:57:33 +0000
Message-ID: <159180.1639087053@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> > Implement a function to generate hashes.  It needs to be stable over t=
ime
> > and endianness-independent as the hashes will appear on disk in future
> > patches.
> =

> I'm not actually seeing this being endianness-independent.
> =

> Is the input just regular 32-bit data in native word order? Because
> then it's not endianness-independent, it's purely that there *is* no
> endianness to the data at all and it is purely native data.
>
> So the code may be correct, but the explanation is confusing. There is
> absolutely nothing here that is about endianness.

What I'm trying to get at is that the hash needs to be consistent, no matt=
er
the endianness of the cpu, for any particular input blob.  The hashing
function shouldn't need to know the structure of the input blob.  In the c=
ase
of the volume key, it's a padded printable string; in the case of the cook=
ie
key, it's probably some sort of structured blob, quite possibly an actual
array of be32.

The reason it needs to be consistent is that people seem to like seeding t=
he
cache by tarring up the cache from one machine and untarring it on another=
.

And looking again at my code:

unsigned int fscache_hash(unsigned int salt, unsigned int *data, unsigned =
int n)
{
	unsigned int a, x =3D 0, y =3D salt;

	for (; n; n--) {
		a =3D *data++;   <<<<<<<
		HASH_MIX(x, y, a);
	}
	return fold_hash(x, y);
}

The marked line should probably use something like le/be32_to_cpu().

I also need to fix 9p to canonicalise its cookie key.

Thanks for catching that,
David

