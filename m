Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB663316FB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Mar 2021 20:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhCHTJc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Mar 2021 14:09:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22799 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229701AbhCHTJE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Mar 2021 14:09:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615230543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pBhajOJHrx3P1bFfpTnaW+JD8S792IZZwlNpIQC5Q0g=;
        b=Wa4JJmEsSW657KZboi0NuNYCQXrcQKQCtgdmsY34DNdoKDodEQNsFhO+K82qcz6gnXw3Am
        bYFm5nlw2LlXa7zv3+yRNJKop2+0AW3SkmncBdXUTIvmnY6QEqvJD0OH5QYAXX3wWi5faE
        px3MGm5oi5ZdKAjrcO5E9eXxvseaqnQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-mfpi1OsCPjKSNXMW3mY4Qw-1; Mon, 08 Mar 2021 14:09:02 -0500
X-MC-Unique: mfpi1OsCPjKSNXMW3mY4Qw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8114801814;
        Mon,  8 Mar 2021 19:08:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-152.rdu2.redhat.com [10.10.118.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9B45F19C79;
        Mon,  8 Mar 2021 19:08:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210308185410.GE7284@fieldses.org>
References: <20210308185410.GE7284@fieldses.org> <CAOQ4uxhxwKHLT559f8v5aFTheKgPUndzGufg0E58rkEqa9oQ3Q@mail.gmail.com> <2653261.1614813611@warthog.procyon.org.uk> <517184.1615194835@warthog.procyon.org.uk>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     dhowells@redhat.com, Amir Goldstein <amir73il@gmail.com>,
        linux-cachefs@redhat.com, Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <dchinner@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-afs@lists.infradead.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: fscache: Redesigning the on-disk cache
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <19638.1615230532.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 08 Mar 2021 19:08:52 +0000
Message-ID: <19639.1615230532@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

J. Bruce Fields <bfields@fieldses.org> wrote:

> On Mon, Mar 08, 2021 at 09:13:55AM +0000, David Howells wrote:
> > Amir Goldstein <amir73il@gmail.com> wrote:
> > > With ->fiemap() you can at least make the distinction between a non =
existing
> > > and an UNWRITTEN extent.
> > =

> > I can't use that for XFS, Ext4 or btrfs, I suspect.  Christoph and Dav=
e's
> > assertion is that the cache can't rely on the backing filesystem's met=
adata
> > because these can arbitrarily insert or remove blocks of zeros to brid=
ge or
> > split extents.
> =

> Could you instead make some sort of explicit contract with the
> filesystem?  Maybe you'd flag it at mkfs time and query for it before
> allowing a filesystem to be used for fscache.  You don't need every
> filesystem to support fscache, right, just one acceptable one?

I've asked about that, but the filesystem maintainers are reluctant to do
that.

Something might be possible in ext4 using direct access to jbd2, though I
don't know exactly what facilities that offers.

David

