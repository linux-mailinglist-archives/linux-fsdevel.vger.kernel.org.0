Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6898E2CED7F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Dec 2020 12:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbgLDLwM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Dec 2020 06:52:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31110 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726618AbgLDLwM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Dec 2020 06:52:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607082646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GzGm9FLoIdgD7158tKHO7AwFPJgMNOe/jG6ldiSBZjg=;
        b=Er3m+06habVTsmjtOUIl6IdGMr/oflRFfOJwE/H/i1+OT1UzrZdWWrtqEdR/QcPbt2kMzn
        IpHayRYcybk47S7xQ7g3ulS4cuoYTguyJOPnop9Z4hkz1y8b4ZfJamA4vqNgaEGJac1pe2
        /EeisqT5+k0E0yJgpKnUr5MuH89/q8U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-p8Q3snq-Oo-ITMhIPmR8nQ-1; Fri, 04 Dec 2020 06:50:42 -0500
X-MC-Unique: p8Q3snq-Oo-ITMhIPmR8nQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3059E612A3;
        Fri,  4 Dec 2020 11:50:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-116-67.rdu2.redhat.com [10.10.116.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BF9C65D6A1;
        Fri,  4 Dec 2020 11:50:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wif1iGLiqcsx1YdLS4tN01JuH-MV_oem0duHqskhDTY9A@mail.gmail.com>
References: <CAHk-=wif1iGLiqcsx1YdLS4tN01JuH-MV_oem0duHqskhDTY9A@mail.gmail.com> <160596801020.154728.15935034745159191564.stgit@warthog.procyon.org.uk> <20201203064536.GE27350@xsang-OptiPlex-9020>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, kernel test robot <oliver.sang@intel.com>,
        lkp@lists.01.org, kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>, zhengjun.xing@intel.com,
        Pavel Begunkov <asml.silence@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [iov_iter] 9bd0e337c6: will-it-scale.per_process_ops -4.8% regression
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <98236.1607082636.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 04 Dec 2020 11:50:36 +0000
Message-ID: <98237.1607082636@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> > FYI, we noticed a -4.8% regression of will-it-scale.per_process_ops du=
e to commit:
> =

> Ok, I guess that's bigger than expected, =


Note that it appears to be testing just the first patch and not the whole
series:

| commit: 9bd0e337c633aed3e8ec3c7397b7ae0b8436f163 ("[PATCH 01/29] iov_ite=
r: Switch to using a table of operations")

that just adds an indirection table without taking away any of the conditi=
onal
branching.  It seems quite likely, though, that even if you add all the ot=
her
patches, you won't get back enough to make it worth it.

David

