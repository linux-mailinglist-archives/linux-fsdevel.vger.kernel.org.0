Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079FF49F85E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jan 2022 12:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235556AbiA1LgI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jan 2022 06:36:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:35026 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233888AbiA1LgI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jan 2022 06:36:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643369767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/CVVmOo6bqPNMUWhv3lZL5OSdXdWuhtjBkekxnbtZx4=;
        b=SRWaS4AdL2cQlYx+3umbqXjCI9RZdgYNWOlT41iwGydt4a2zV9lAUgQ0je2TGwl0Qz9s4Z
        mHQcfjxuZjYk75yFFgF1n8/mUDrAeQ3ZMu+O6sJru1qah8Aat+166EcR7lEvW9C/cIIPZ/
        6a//cVvJghgfUB5loN11MNvucJSPN9Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-9VLdvSs6OGyUhthgrzXNVA-1; Fri, 28 Jan 2022 06:36:04 -0500
X-MC-Unique: 9VLdvSs6OGyUhthgrzXNVA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB50D1091DA3;
        Fri, 28 Jan 2022 11:36:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6A99166E3B;
        Fri, 28 Jan 2022 11:36:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAOQ4uxhRS3MGEnCUDcsB1RL0d1Oy0g0Rzm75hVFAJw2dJ7uKSA@mail.gmail.com>
References: <CAOQ4uxhRS3MGEnCUDcsB1RL0d1Oy0g0Rzm75hVFAJw2dJ7uKSA@mail.gmail.com> <20220128074731.1623738-1-hch@lst.de> <918225.1643364739@warthog.procyon.org.uk>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     dhowells@redhat.com, Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH v2] fs: rename S_KERNEL_FILE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <922908.1643369759.1@warthog.procyon.org.uk>
Date:   Fri, 28 Jan 2022 11:35:59 +0000
Message-ID: <922909.1643369759@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Amir Goldstein <amir73il@gmail.com> wrote:

> Good idea, but then the helpers to set the flag should not be internal
> to cachefiles and the locking semantics should be clear.

I could move them out, at least partially.  They do log some information
that's private to cachefiles through the tracepoint, but it's just one number
and could be passed in as a parameter.  I could move the tracepoint to
somewhere more generic.

> FYI, overlayfs already takes an "exclusive lock" on upper/work dir
> among all ovl instances.
> 
> How do you feel about hoisting ovl_inuse_* helpers to fs.h
> and rename s/I_OVL_INUSE/I_EXCL_INUSE?

Fine by me.  Sharing a cache with or through an overlay would make for very
fun coherency management.

> Whether deny rmdir should have its own flag or not I don't know,
> but from ovl POV I *think* it should not be a problem to deny rmdir
> for the ovl upper/work dirs as long as ovl is mounted(?).

What's the consequence of someone rearranging the directories directly in the
contributing dirs whilst there's an overlay over them?

> Another problem with generic deny of rmdir is that users getting
> EBUSY have no way to figure out the reason.
> At least for a specific subsystem (i.e. cachefiles) users should be able
> to check if the denied dir is in the subsystem's inventory(?)

I could add a tracepoint for that.  It could form a set with the cachefiles
tracepoints if I move those out too.

David

