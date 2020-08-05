Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B153723CBCB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Aug 2020 17:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgHEPpv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Aug 2020 11:45:51 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24256 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726660AbgHEPkx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Aug 2020 11:40:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596641785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tg1NaN73CW0LtnEK10fe+dApSmqLG8nxdGa4rhiVRvI=;
        b=XbLe8kAnlsqrG4q/HLi1Fl1jCaiDEIimVOGc1ZWyJy3mS9uYkSgxvQcqjPJJnd84JNTw8l
        esHz0LElwzZE8ZIHOErYnLFwHPr0oEVQzfUUstMiGFxU3pVnGKhaoG4njdgICi1JRohU/9
        fL+D1h35nPaYO+lCegxBLdvD7cYZ4GM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-K9dMuQccOZWetAzznd3kwg-1; Wed, 05 Aug 2020 11:30:16 -0400
X-MC-Unique: K9dMuQccOZWetAzznd3kwg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCFCE107B83C;
        Wed,  5 Aug 2020 15:30:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 710C660BF3;
        Wed,  5 Aug 2020 15:30:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAJfpegtOguKOGWxv-sA_C9eSWG_3Srnj_k=oW-wSHNprCipFVg@mail.gmail.com>
References: <CAJfpegtOguKOGWxv-sA_C9eSWG_3Srnj_k=oW-wSHNprCipFVg@mail.gmail.com> <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk> <159646183662.1784947.5709738540440380373.stgit@warthog.procyon.org.uk> <20200804104108.GC32719@miu.piliscsaba.redhat.com> <2306029.1596636828@warthog.procyon.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ian Kent <raven@themaw.net>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Karel Zak <kzak@redhat.com>, Jeff Layton <jlayton@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/18] fsinfo: Add a uniquifier ID to struct mount [ver #21]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2315924.1596641410.1@warthog.procyon.org.uk>
Date:   Wed, 05 Aug 2020 16:30:10 +0100
Message-ID: <2315925.1596641410@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:

> idr_alloc_cyclic() seems to be a good template for doing the lower
> 32bit allocation, and we can add code to increment the high 32bit on
> wraparound.
> 
> Lots of code uses idr_alloc_cyclic() so I guess it shouldn't be too
> bad in terms of memory use or performance.

It's optimised for shortness of path and trades memory for performance.  It's
currently implemented using an xarray, so memory usage is dependent on the
sparseness of the tree.  Each node in the tree is 576 bytes and in the worst
case, each one node will contain one mount - and then you have to backfill the
ancestry, though for lower memory costs.

Systemd makes life more interesting since it sets up a whole load of
propagations.  Each mount you make may cause several others to be created, but
that would likely make the tree more efficient.

David

