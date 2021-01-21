Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 586892FF587
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 21:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbhAUUKz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 15:10:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36287 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727006AbhAUUKE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 15:10:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611259718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gVx+gkEsYNOgT30sFBYpj+A2NREDHbQJA4mbAzV8q/8=;
        b=P26DjrFA12ail1kIUQd6yGKXkM42Z0jQ+rPrarD9NBXfWqWLduEUfq1tn0YYmjj0CRgSBF
        sgMlNsBmhtNw553IJC90Z+V0rpLL9NmUC23vl0OqgGQt14crpukSY8vFRCnlwq6/8fHLeP
        z/xsCJr6jPW0lARvczie9Btw4Aoe7jM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-4DhkOkagMbGcw0RHcFnQ4g-1; Thu, 21 Jan 2021 15:08:34 -0500
X-MC-Unique: 4DhkOkagMbGcw0RHcFnQ4g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E3B6180A094;
        Thu, 21 Jan 2021 20:08:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-23.rdu2.redhat.com [10.10.115.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D670150DD2;
        Thu, 21 Jan 2021 20:08:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210121190937.GE20964@fieldses.org>
References: <20210121190937.GE20964@fieldses.org> <20210121174306.GB20964@fieldses.org> <20210121164645.GA20964@fieldses.org> <161118128472.1232039.11746799833066425131.stgit@warthog.procyon.org.uk> <1794286.1611248577@warthog.procyon.org.uk> <1851804.1611255313@warthog.procyon.org.uk>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Takashi Iwai <tiwai@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        linux-afs@lists.infradead.org, Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 00/25] Network fs helper library & fscache kiocb API
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1856290.1611259704.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 21 Jan 2021 20:08:24 +0000
Message-ID: <1856291.1611259704@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

J. Bruce Fields <bfields@fieldses.org> wrote:

> > J. Bruce Fields <bfields@fieldses.org> wrote:
> > =

> > > > Fixing this requires a much bigger overhaul of cachefiles than thi=
s patchset
> > > > performs.
> > > =

> > > That sounds like "sometimes you may get file corruption and there's
> > > nothing you can do about it".  But I know people actually use fscach=
e,
> > > so it must be reliable at least for some use cases.
> > =

> > Yes.  That's true for the upstream code because that uses bmap.
> =

> Sorry, when you say "that's true", what part are you referring to?

Sometimes, theoretically, you may get file corruption due to this.

> > I'm switching
> > to use SEEK_HOLE/SEEK_DATA to get rid of the bmap usage, but it doesn'=
t change
> > the issue.
> > =

> > > Is it that those "bridging" blocks only show up in certain corner ca=
ses
> > > that users can arrange to avoid?  Or that it's OK as long as you use
> > > certain specific file systems whose behavior goes beyond what's
> > > technically required by the bamp or seek interfaces?
> > =

> > That's a question for the xfs, ext4 and btrfs maintainers, and may var=
y
> > between kernel versions and fsck or filesystem packing utility version=
s.
> =

> So, I'm still confused: there must be some case where we know fscache
> actually works reliably and doesn't corrupt your data, right?

Using ext2/3, for example.  I don't know under what circumstances xfs, ext=
4
and btrfs might insert/remove blocks of zeros, but I'm told it can happen.

David

