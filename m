Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C7D3106A1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 09:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhBEI1V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 03:27:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41133 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229698AbhBEI1I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 03:27:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612513542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LxANOstSwBXrn0OC3M8r/TM5reax6AnMqz1DHOK0g18=;
        b=d9RTDFg7RRBjm4pOOU94WtvZ2CEH1CPazpCXEs7xy0XfACKF9ACcE8Eu+N6ufuX8ui0bO4
        qlqNVnbdIIvYZz12+hTgwWwdGBCaG5lisFBQQLNzvpuknNz/vYMu3xxGd8w4i8/cLx02PD
        iwMSAI7wTkZrUVNe0nUsfEJHgo2pE4g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-Aund-JwENnm_luJEaMImoA-1; Fri, 05 Feb 2021 03:25:40 -0500
X-MC-Unique: Aund-JwENnm_luJEaMImoA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AAAB81800D50;
        Fri,  5 Feb 2021 08:25:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-23.rdu2.redhat.com [10.10.115.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B582D1970A;
        Fri,  5 Feb 2021 08:25:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YByxkDi0Ruhb0AA8@kernel.org>
References: <YByxkDi0Ruhb0AA8@kernel.org> <161246085160.1990927.13137391845549674518.stgit@warthog.procyon.org.uk> <161246085966.1990927.2555272056564793056.stgit@warthog.procyon.org.uk>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     dhowells@redhat.com, sprabhu@redhat.com, christian@brauner.io,
        selinux@vger.kernel.org, keyrings@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, containers@lists.linux-foundation.org
Subject: Re: [PATCH 1/2] Add namespace tags that can be used for matching without pinning a ns
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2094923.1612513535.1@warthog.procyon.org.uk>
Date:   Fri, 05 Feb 2021 08:25:35 +0000
Message-ID: <2094924.1612513535@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jarkko Sakkinen <jarkko@kernel.org> wrote:

> > + * init_ns_common - Initialise the common part of a namespace
> 
> Nit: init_ns_common()

Interesting.  The majority of code doesn't put the brackets in.

> I've used lately (e.g. arch/x86/kernel/cpu/sgx/ioctl.c) along the lines:
> 
> * Return:
> * - 0:          Initialization was successful.
> * - -ENOMEM:    Out of memory.

Actually, looking at kernel-doc.rst, this isn't necessarily the recommended
approach as it will much everything into one line, complete with dashes, and
can't handle splitting over lines.  You probably meant:

      * Return:
      * * 0		- OK to runtime suspend the device
      * * -EBUSY	- Device should not be runtime suspended

> * Return:
> * - 0:          Initialization was successful.
> * - -ENOMEM:    Out of memory.
> 
> Looking at the implementation, I guess this is a complete representation of
> what it can return?

It isn't.  It can return at least -ENOSPC as well, but it's awkward detailing
the errors from functions it calls since they can change and then the
description here is wrong.  I'm not sure there's a perfect answer to that.

David

