Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B1E2D36DC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 00:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731734AbgLHXXS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 18:23:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45008 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731628AbgLHXXS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 18:23:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607469712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GqTl8ne3MpfBFToDfCcb9stsXmHRL3JBm8iFVeCCNHU=;
        b=EGdioaUg1e8jHGLaHNXi5jDE6VaweZLjtuCZ8MdqXs40lmR4ZaO9Qtr94C5cHD2daeF85P
        64KPH7u582srp/kiUultwbwbZy7jjmHot4rLY38sxTgGkW08o951W8YBf1ocSBayKc7TXY
        g4r2hsQy1lHtqz0JwI5SdcHE/xrOc4g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-9cVGwTtHOa2d_LPq51-9Nw-1; Tue, 08 Dec 2020 18:21:50 -0500
X-MC-Unique: 9cVGwTtHOa2d_LPq51-9Nw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0E4ECC657;
        Tue,  8 Dec 2020 23:21:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-116-67.rdu2.redhat.com [10.10.116.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 632431042AA6;
        Tue,  8 Dec 2020 23:21:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <e6d9fd7e-ea43-25a6-9f1e-16a605de0f2d@infradead.org>
References: <e6d9fd7e-ea43-25a6-9f1e-16a605de0f2d@infradead.org> <1c752ffe-8118-f9ea-e928-d92783a5c516@infradead.org> <6db2af99-e6e3-7f28-231e-2bdba05ca5fa@infradead.org> <0000000000002a530d05b400349b@google.com> <928043.1607416561@warthog.procyon.org.uk> <1030308.1607468099@warthog.procyon.org.uk>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     dhowells@redhat.com,
        syzbot <syzbot+86dc6632faaca40133ab@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: memory leak in generic_parse_monolithic [+PATCH]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1093803.1607469696.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 08 Dec 2020 23:21:36 +0000
Message-ID: <1093804.1607469696@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> wrote:

> Here's the syzbot reproducer:
> https://syzkaller.appspot.com/x/repro.c?x=3D129ca3d6500000
> =

> The "interesting" mount params are:
> 	source=3D%^]$[+%](${:\017k[)-:,source=3D%^]$[+.](%{:\017\200[)-:,\000
> =

> There is no other AFS activity: nothing mounted, no cells known (or
> whatever that is), etc.
> =

> I don't recall if the mount was successful and I can't test it just now.
> My laptop is mucked up.
> =

> =

> Be aware that this report could just be a false positive: it waits
> for 5 seconds then looks for a memleak. AFAIK, it's possible that the "l=
eaked"
> memory is still in valid use and will be freed some day.

Bah.  Multiple source=3D parameters.  I don't reject the second one, but j=
ust
overwrite fc->source.

David

