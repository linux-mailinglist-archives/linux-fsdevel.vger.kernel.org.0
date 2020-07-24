Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEFC22C2F7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 12:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgGXKUK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 06:20:10 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54640 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726114AbgGXKUJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 06:20:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595586008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iNwJ2cEmHYj+S0Ahc6f50GridTdh2KfTtR3COy4a8r0=;
        b=FeW10BPJhm8IiKcp/ifw7qwIb14HJBv8QnxtKn6XNRE9YI6lkN2HmgYaHfqZ91PgYHMlDW
        w/sFtENwfyQeS2TL9tsI2yP3hhg1xnv1A69w+5WlZP9DrjSIDYuybT0EIupABdgNlEKShN
        c7APFcGvJJMn+4xLc/Hs45CPpmVYq74=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-tpfvniXtPBmBGWTxVCEyVQ-1; Fri, 24 Jul 2020 06:20:07 -0400
X-MC-Unique: tpfvniXtPBmBGWTxVCEyVQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26212800597;
        Fri, 24 Jul 2020 10:20:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3EF84872E5;
        Fri, 24 Jul 2020 10:20:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <1293241.1595501326@warthog.procyon.org.uk>
References: <1293241.1595501326@warthog.procyon.org.uk> <CAJfpegspWA6oUtdcYvYF=3fij=Bnq03b8VMbU9RNMKc+zzjbag@mail.gmail.com> <158454378820.2863966.10496767254293183123.stgit@warthog.procyon.org.uk> <158454391302.2863966.1884682840541676280.stgit@warthog.procyon.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, nicolas.dichtel@6wind.com,
        Ian Kent <raven@themaw.net>,
        Christian Brauner <christian@brauner.io>, andres@anarazel.de,
        Jeff Layton <jlayton@redhat.com>, dray@redhat.com,
        Karel Zak <kzak@redhat.com>, keyrings@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/17] watch_queue: Implement mount topology and attribute change notifications [ver #5]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2003786.1595585999.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 24 Jul 2020 11:19:59 +0100
Message-ID: <2003787.1595585999@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> > What guarantees that mount_id is going to remain a 32bit entity?
> =

> You think it likely we'd have >4 billion concurrent mounts on a system? =
 That
> would require >1.2TiB of RAM just for the struct mount allocations.
> =

> But I can expand it to __u64.

That said, sys_name_to_handle_at() assumes it's a 32-bit signed integer, s=
o
we're currently limited to ~2 billion concurrent mounts:-/

David

