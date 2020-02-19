Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83DD7164D1D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 18:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgBSR5H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 12:57:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54091 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726514AbgBSR5H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 12:57:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582135026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yh7d95RBmkGqSBihXJVD+MVFXbFbQjtM5PxfVFGUNSo=;
        b=Ri2GUfZpwIuZjrsOpYo2Ep9MV9z8stbkoMVNQ5Xotn11SMmblcqV9GLjHmXNm5zGUh3mNc
        WYELViYnKCuVrGt7w9bD9LsjZHA/KY1M7PCcAURNkeikjG3pOhcI46ESlLDJVV/JZss5oY
        fctt3BLEY542xL+xPIv5ljSGCMyk0rU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-7A4Y6uYuMfq8pYG_9LQTLg-1; Wed, 19 Feb 2020 12:57:00 -0500
X-MC-Unique: 7A4Y6uYuMfq8pYG_9LQTLg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73CCC100550E;
        Wed, 19 Feb 2020 17:56:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-122-163.rdu2.redhat.com [10.10.122.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 14251196AE;
        Wed, 19 Feb 2020 17:56:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
In-Reply-To: <SH0PR01MB045873AEEA42B84D442F09028A1B0@SH0PR01MB0458.CHNPR01.prod.partner.outlook.cn>
References: <SH0PR01MB045873AEEA42B84D442F09028A1B0@SH0PR01MB0458.CHNPR01.prod.partner.outlook.cn>
To:     "Yang, Lifeng" <lifeng.yang@lenovonetapp.com>
Cc:     dhowells@redhat.com,
        "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [Linux-cachefs] About the ceph persistent caching with fscache
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <232278.1582128509.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
From:   David Howells <dhowells@redhat.com>
Date:   Wed, 19 Feb 2020 17:56:55 +0000
Message-ID: <241684.1582135015@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Yang, Lifeng <lifeng.yang@lenovonetapp.com> wrote:

> I have a question need the consult from the ceph experts. I am the user =
of
> CephFS, and would like to use the persist memory to accelerate file IO a=
nd I
> found long times ago, the FSCache supports the CephFS:
>
> https://lwn.net/Articles/564294/
> =

> I wonder if the FSCache support the user mode CephFS accessing? Because =
I
> just see there is only kernel code update, this is might the easy questi=
on
> for you.

Note that fscache is being heavily rewritten at the moment:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log=
/?h=3Dfscache-iter

Interfaces now exist that allow it to use direct I/O to the backing filesy=
stem
and avoid the need to try to snoop the waitqueues for backing pages to com=
e
available (which doesn't always appear to work).

David

