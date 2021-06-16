Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8743A9C49
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 15:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbhFPNnu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 09:43:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20400 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233065AbhFPNnt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 09:43:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623850902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p8GK50I3KBKc8B6YusjGKlCOchxcM/TeXaVsgxynpE4=;
        b=g17r4MvaA/NhJ6yc+z6f493nMv9J3Ge6Ez93xeqkBYUEyAa6LL98+tgwm002CJQ3Rhzd+1
        3X7Fod07l1aICDQgMxCRDyeZ0+AJKJHJWI0JjJM0O3EyajqsmFfFpcRiXCyi9a28sGi//0
        86tIWLNlSzi99s0Mg7TqAg+5KgCQNlU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-PT56Y0xWN_GyKRNQvyK7Zg-1; Wed, 16 Jun 2021 09:41:39 -0400
X-MC-Unique: PT56Y0xWN_GyKRNQvyK7Zg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D78319251AD;
        Wed, 16 Jun 2021 13:41:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-65.rdu2.redhat.com [10.10.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1FCBF10016F4;
        Wed, 16 Jun 2021 13:41:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <200ea6f7-0182-9da1-734c-c49102663ccc@redhat.com>
References: <200ea6f7-0182-9da1-734c-c49102663ccc@redhat.com> <162375813191.653958.11993495571264748407.stgit@warthog.procyon.org.uk> <CAHk-=whARK9gtk0BPo8Y0EQqASNG9SfpF1MRqjxf43OO9F0vag@mail.gmail.com> <f2764b10-dd0d-cabf-0264-131ea5829fed@infradead.org> <CAHk-=whPPWYXKQv6YjaPQgQCf+78S+0HmAtyzO1cFMdcqQp5-A@mail.gmail.com> <c2002123-795c-20ae-677c-a35ba0e361af@infradead.org> <051421e0-afe8-c6ca-95cd-4dc8cd20a43e@huawei.com>
To:     Tom Rix <trix@redhat.com>
Cc:     dhowells@redhat.com, Zheng Zengkai <zhengzengkai@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hulk Robot <hulkci@huawei.com>, linux-afs@lists.infradead.org,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] afs: fix no return statement in function returning non-void
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <929459.1623850895.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 16 Jun 2021 14:41:35 +0100
Message-ID: <929460.1623850895@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Tom Rix <trix@redhat.com> wrote:

> A fix is to use the __noreturn attribute on this function and not add a =
return
> like this
> =

> -static int afs_dir_set_page_dirty(struct page *page)
> +static int __noreturn afs_dir_set_page_dirty(struct page *page)
> =

> and to the set of ~300 similar functions in these files.

BUG() really ought to handle it.  Do you have CONFIG_BUG=3Dy?

David

