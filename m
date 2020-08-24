Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E19E2506F5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Aug 2020 19:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgHXRyJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 13:54:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40567 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726303AbgHXRyI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 13:54:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598291647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ef4R5O5Cq7LZWsF/vmaYxvTJ7WpiMWWuCBWCNUUsdH0=;
        b=exZhBBQuH9czr5ZykM5TicEW1la/JGCjJMdSCqwioNW1GANGdIudoNWGM8jMWxnVx5SqAf
        U/Y5Sh+XN+gsFvPcVEeaxQofNPBKoZnmChihu8pfhPsjcq84GJcIxmAKRVc9TsZEA/S4RT
        YSJHA/JVNU/xbfl60M3zMNPIP8E6Lqw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-VqlurWbUNcmfBK7sxFhF-Q-1; Mon, 24 Aug 2020 13:54:05 -0400
X-MC-Unique: VqlurWbUNcmfBK7sxFhF-Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D02EA101963C;
        Mon, 24 Aug 2020 17:54:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-127.rdu2.redhat.com [10.10.120.127])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2BD2360BF1;
        Mon, 24 Aug 2020 17:54:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200824165802.GB408760@erythro.dev.benboeckel.internal>
References: <20200824165802.GB408760@erythro.dev.benboeckel.internal> <20200807160531.GA1345000@erythro.dev.benboeckel.internal> <159681277616.35436.11229310534842613599.stgit@warthog.procyon.org.uk> <329586.1598282852@warthog.procyon.org.uk>
To:     me@benboeckel.net
Cc:     dhowells@redhat.com, mtk.manpages@gmail.com,
        torvalds@linux-foundation.org, keyrings@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Add a manpage for watch_queue(7)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <348447.1598291641.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 24 Aug 2020 18:54:01 +0100
Message-ID: <348448.1598291641@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ben Boeckel <me@benboeckel.net> wrote:

> > One loss message.  I set a flag on the last slot in the pipe ring to s=
ay that
> > message loss occurred, but there's insufficient space to store a count=
er
> > without making the slot larger (and I really don't want to do that).
> > =

> > Note that every slot in the pipe ring has such a flag, so you could,
> > theoretically, get a loss message after every normal message that you =
read
> > out.
> =

> Ah, so a "you lost something" is just a flag on the next event that does
> make it into the queue? I read it as a whole message existed indicating
> that data was lost. Not sure of the best wording here.

No.  That flag is internal.  It causes read() to fabricate a message and
insert it into the user buffer after the flagged message has been copied o=
ver.

> > bit 0 is 2^0 in this case.  I'm not sure how better to describe it.
> =

> OK, so the bits are in native-endian order in the enclosing bytes. But C
> just doesn't have a set ABI for bitfields (AFAIK), so I guess it's
> "whatever GCC does" in practice?

Hard to say - powerpc and s390 have bit 0 as the MSB:-/

But "& (1 << 0)" gets you 2^0, whatever the CPU book says.

David

