Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96D40FE2A5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 17:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfKOQWi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Nov 2019 11:22:38 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25465 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727640AbfKOQWh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Nov 2019 11:22:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573834956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CwUyebu0scckytmwM4Mxi9fLVUlAZpXNEMuEmf6DWjI=;
        b=fEl2ZznSGZxRiETQOpkIOmxSSV5OTbc/GsSUpbQ4QWZTUNuiYjNjOcgWiGhhV7AwHK7bIK
        UVJ6MAlNBQsTjfQiosWu3k3KNpS/kH/yBSiFhR+wQ1atP3331vIFXP3wVszW+m9SEo48IU
        odb8JARv2yr4mE8tJrvOqxSZkIlUlV8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-hGixx7PgMDyNOgdOe7YA3g-1; Fri, 15 Nov 2019 11:22:33 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 860AB8048E3;
        Fri, 15 Nov 2019 16:22:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-161.rdu2.redhat.com [10.10.120.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5459210375C0;
        Fri, 15 Nov 2019 16:22:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <9279.1573824532@warthog.procyon.org.uk>
References: <9279.1573824532@warthog.procyon.org.uk> <20191110031348.GE29418@shao2-debian>
To:     kernel test robot <lkp@intel.com>
Cc:     dhowells@redhat.com, torvalds@linux-foundation.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkp@lists.01.org
Subject: Re: [pipe] d60337eff1: BUG:kernel_NULL_pointer_dereference,address
MIME-Version: 1.0
Content-ID: <6852.1573834946.1@warthog.procyon.org.uk>
Date:   Fri, 15 Nov 2019 16:22:26 +0000
Message-ID: <6853.1573834946@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: hGixx7PgMDyNOgdOe7YA3g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Actually, no, this is the fix:

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 7006b5b2106d..be2fc5793ddd 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -537,7 +537,7 @@ static size_t push_pipe(struct iov_iter *i, size_t size=
,
 =09=09buf->ops =3D &default_pipe_buf_ops;
 =09=09buf->page =3D page;
 =09=09buf->offset =3D 0;
-=09=09buf->len =3D max_t(ssize_t, left, PAGE_SIZE);
+=09=09buf->len =3D min_t(ssize_t, left, PAGE_SIZE);
 =09=09left -=3D buf->len;
 =09=09iter_head++;
 =09=09pipe->head =3D iter_head;

David

