Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC566EB3B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2019 16:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbfJaPQH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Oct 2019 11:16:07 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54092 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726566AbfJaPQE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Oct 2019 11:16:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572534963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zC2mY0mLUqkQzl10meI2dQTcqCAQks3OLoAJrTsT3pg=;
        b=adzTcULULFJy8UcTe4yayYjVO6GidCQ7OQbxa57ibWr9JLlEP+ePDMRYzUW3mi3+VgISKy
        /xFnGeLG/yFKZ5F9958e/V7wD7sZLOvjx+GP5o/Nsi824j+5D1eciBNAFRU32OAruv9vEr
        0XeQU3e10feMJ4Vi8Y61HcBqAZGfR+o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-FXImFqDnP-q7fXpZhf4T8w-1; Thu, 31 Oct 2019 11:16:00 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E87491800D6B;
        Thu, 31 Oct 2019 15:15:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-40.rdu2.redhat.com [10.10.121.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA8681001920;
        Thu, 31 Oct 2019 15:15:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <c6e044cc-5596-90b7-4418-6ad7009d6d79@yandex-team.ru>
References: <c6e044cc-5596-90b7-4418-6ad7009d6d79@yandex-team.ru> <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk> <30394.1571936252@warthog.procyon.org.uk>
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
Subject: Re: [RFC PATCH 11/10] pipe: Add fsync() support [ver #2]
MIME-Version: 1.0
Content-ID: <17310.1572534953.1@warthog.procyon.org.uk>
Date:   Thu, 31 Oct 2019 15:15:53 +0000
Message-ID: <17311.1572534953@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: FXImFqDnP-q7fXpZhf4T8w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Konstantin Khlebnikov <khlebnikov@yandex-team.ru> wrote:

> Similar synchronization is required for reusing memory after vmsplice()?
> I don't see other way how sender could safely change these pages.

Sounds like a point - if you have multiple parallel contributors to the pip=
e
via vmsplice(), then FIONREAD is of no use.  To use use FIONREAD, you have =
to
let the pipe become empty before you can be sure.

David

