Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C03BFEB3C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2019 16:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbfJaPVb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Oct 2019 11:21:31 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55931 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727721AbfJaPVb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Oct 2019 11:21:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572535290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KB0w+J47Vm67r8tjhUMxa0RlzCeaXYS337IcG/e9RSQ=;
        b=IGC9i1xWgEWL3wophjL5XzI1h0CDS9d7wQYuQJoWC1pPcMEfk60dPS8M3lfFB7u7Ezbjvl
        Auo5Dd6q/nTq2jG/gD+APR7h4hOVM9+pTX2qU0vZrcsH5dpYVfOqB3WPXqWmzaBQUxZeI2
        lHe/RRGZWf/xQ2rzLQ7K6CAyaVJr2uA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-MUMIyamRN_mM4zAREXjqFg-1; Thu, 31 Oct 2019 11:21:28 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 976B3107ACC0;
        Thu, 31 Oct 2019 15:21:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-40.rdu2.redhat.com [10.10.121.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9F00F60BEC;
        Thu, 31 Oct 2019 15:21:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <fe167a90-1503-7ca2-4150-eeffd5cb1378@yandex-team.ru>
References: <fe167a90-1503-7ca2-4150-eeffd5cb1378@yandex-team.ru> <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk> <157186189069.3995.10292601951655075484.stgit@warthog.procyon.org.uk>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
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
Subject: Re: [RFC PATCH 07/10] pipe: Conditionalise wakeup in pipe_read() [ver #2]
MIME-Version: 1.0
Content-ID: <18021.1572535282.1@warthog.procyon.org.uk>
Date:   Thu, 31 Oct 2019 15:21:22 +0000
Message-ID: <18022.1572535282@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: MUMIyamRN_mM4zAREXjqFg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Konstantin Khlebnikov <khlebnikov@yandex-team.ru> wrote:

> > Only do a wakeup in pipe_read() if we made space in a completely full
> > buffer.  The producer shouldn't be waiting on pipe->wait otherwise.
>=20
> We could go further and wakeup writer only when at least half of buffer i=
s
> empty.  This gives better batching and reduces rate of context switches.
>=20
> https://lore.kernel.org/lkml/157219118016.7078.16223055699799396042.stgit=
@buzz/T/#u

Yeah, I saw that.  I suspect that where you put the slider may depend on th=
e
context.

David

