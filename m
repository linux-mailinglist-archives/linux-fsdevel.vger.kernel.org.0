Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4745D115931
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2019 23:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfLFWPk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Dec 2019 17:15:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44250 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726608AbfLFWPj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Dec 2019 17:15:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575670539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g9gOFA8Uzj5LOu2YACenivVW4TbKyjqFDtKfEMeTYTE=;
        b=AqbnNNeUxbQdifHBryi8cPZOIvWW31yuoy+7aQp89SnAb/eFavxkk3s69XsIw6MyYT8+jm
        TqwOKKiGl7bNCpQmBBsqaUrdoXGO1gA3rSIbkopwFpqIi5hDfHb4gcuD6Bq5SbhOHdB1F2
        nEYkE+GNiobAaOQBkEdNfT3XiL3ztb8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-k99QZ4kvNTaM6BA1lmAp5g-1; Fri, 06 Dec 2019 17:15:33 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2937A800EB5;
        Fri,  6 Dec 2019 22:15:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-250.rdu2.redhat.com [10.10.120.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D7E221001902;
        Fri,  6 Dec 2019 22:15:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20191206214725.GA2108@latitude>
References: <20191206214725.GA2108@latitude> <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk> <157186186167.3995.7568100174393739543.stgit@warthog.procyon.org.uk>
To:     Johannes Hirte <johannes.hirte@datenkhaos.de>
Cc:     dhowells@redhat.com, torvalds@linux-foundation.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 04/10] pipe: Use head and tail pointers for the ring, not cursor and length [ver #2]
MIME-Version: 1.0
Content-ID: <21299.1575670527.1@warthog.procyon.org.uk>
Date:   Fri, 06 Dec 2019 22:15:27 +0000
Message-ID: <21300.1575670527@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: k99QZ4kvNTaM6BA1lmAp5g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Johannes Hirte <johannes.hirte@datenkhaos.de> wrote:

> > Convert pipes to use head and tail pointers for the buffer ring rather =
than
> > pointer and length as the latter requires two atomic ops to update (or =
a
> > combined op) whereas the former only requires one.
>=20
> This change breaks firefox on my system. I've noticed that some pages
> doesn't load correctly anymore (e.g. facebook, spiegel.de). The pages
> start loading and than stop. Looks like firefox is waiting for some
> dynamic loading content. I've bisected to this commit, but can't revert
> because of conflicts.

There are a number of patches committed to upstream in the last couple of d=
ays
that might fix your problem.  See:

=09https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/

and look for:

=09pipe: Fix iteration end check in fuse_dev_splice_write()
=09pipe: fix incorrect caching of pipe state over pipe_wait()
=09pipe: Fix missing mask update after pipe_wait()
=09pipe: Remove assertion from pipe_poll()

David

