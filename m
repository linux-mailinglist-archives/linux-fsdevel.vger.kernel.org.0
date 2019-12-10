Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6597119CBB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 23:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbfLJWdM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 17:33:12 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39880 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729394AbfLJWcV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 17:32:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576017140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DIEGxaEoEqnxv3W7KxXHjyimH36onDwUaRqX3wb5gSo=;
        b=LFKPWlTe7u6TnMA7crp/fd/4aiJ6lABRNz3CfHQO7vGoSvMHROXZaTlt7fUCFNRIJWQBnl
        kTX0p9cvoKpn0QvzUotLrYME9LN5OTUrYPnHoq6Y/RcLT6d57rZjAScvJtBBRs9aOREd//
        /+GIhzqx3RljqJKr8FZrajFGZWE/6AQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-CRXAWaLROYCkocpE2NuCbA-1; Tue, 10 Dec 2019 17:32:16 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 426DD800D41;
        Tue, 10 Dec 2019 22:32:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-250.rdu2.redhat.com [10.10.120.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 818A45D9C5;
        Tue, 10 Dec 2019 22:32:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20191210220523.28540-1-dave@stgolabs.net>
References: <20191210220523.28540-1-dave@stgolabs.net> <20191210193011.GA11802@worktop.programming.kicks-ass.net>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     dhowells@redhat.com, peterz@infradead.org,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        will@kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] Revert "locking/mutex: Complain upon mutex API misuse in IRQ contexts"
MIME-Version: 1.0
Content-ID: <24324.1576017132.1@warthog.procyon.org.uk>
Date:   Tue, 10 Dec 2019 22:32:12 +0000
Message-ID: <24325.1576017132@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: CRXAWaLROYCkocpE2NuCbA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Davidlohr Bueso <dave@stgolabs.net> wrote:

> This ended up causing some noise in places such as rxrpc running in softi=
rq.
>=20
> The warning is misleading in this case as the mutex trylock and unlock
> operations are done within the same context; and therefore we need not
> worry about the PI-boosting issues that comes along with no single-owner
> lock guarantees.
>=20
> While we don't want to support this in mutexes, there is no way out of
> this yet; so lets get rid of the WARNs for now, as it is only fair to
> code that has historically relied on non-preemptible softirq guarantees.
> In addition, changing the lock type is also unviable: exclusive rwsems
> have the same issue (just not the WARN_ON) and counting semaphores
> would introduce a performance hit as mutexes are a lot more optimized.
>=20
> This reverts commit 5d4ebaa87329ef226e74e52c80ac1c62e4948987.
>=20
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>

Tested-by: David Howells <dhowells@redhat.com>

