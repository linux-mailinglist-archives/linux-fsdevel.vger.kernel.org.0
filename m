Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B964C168465
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 18:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgBURGb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 12:06:31 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28837 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727329AbgBURGb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 12:06:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582304789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d+gE6bobfHvUgEPpbnKCxsxKvbbzJfwCBMRpBF3lPck=;
        b=L7LkB1ecgtPwJku+KKKSKenK31Jq4WtCnfcmSVK4BBvNy2UJmq5kyC5+eGAF3rC/k2Xdz1
        oenaR5QwhaWiSExP/m1981oDHl5RPKOGml6HBiDtJ7fqDvx9vF1zCOoqXJwiSNvP3ZkaXe
        px5+TGihgbXipxMEMpv9gd46OtGEgbI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-0uMjhGtxP-6dmQbVqLoaRw-1; Fri, 21 Feb 2020 12:06:26 -0500
X-MC-Unique: 0uMjhGtxP-6dmQbVqLoaRw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50889800EB4;
        Fri, 21 Feb 2020 17:06:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-122-163.rdu2.redhat.com [10.10.122.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 652A519E9C;
        Fri, 21 Feb 2020 17:06:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAG48ez0+_kO_YL6iO9uA+HjjnHRVHVD-bFq0C=ZLeaGtTMss5A@mail.gmail.com>
References: <CAG48ez0+_kO_YL6iO9uA+HjjnHRVHVD-bFq0C=ZLeaGtTMss5A@mail.gmail.com> <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk> <158204559631.3299825.5358385352169781990.stgit@warthog.procyon.org.uk> <CAG48ez3ZMg4O5US3n=p1CYK-2AAgLRY+pjnUXp2p5hdwbjCRSA@mail.gmail.com> <1808070.1582287889@warthog.procyon.org.uk>
To:     Jann Horn <jannh@google.com>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        raven@themaw.net, Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 13/19] vfs: Add a mount-notification facility [ver #16]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2113717.1582304782.1@warthog.procyon.org.uk>
Date:   Fri, 21 Feb 2020 17:06:22 +0000
Message-ID: <2113718.1582304782@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jann Horn <jannh@google.com> wrote:

> > What's the best way to write a lockdep assertion?
> >
> >         BUG_ON(!lockdep_is_held(lock));
> 
> lockdep_assert_held(lock) is the normal way, I think - that will
> WARN() if lockdep is enabled and the lock is not held.

Okay.  But what's the best way with a seqlock_t?  It has two dep maps in it.
Do I just ignore the one attached to the spinlock?

David

