Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42E3C167DCB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 13:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgBUM5T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 07:57:19 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32379 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727312AbgBUM5T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 07:57:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582289838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KXkHguo6Cb/akwiySJVNHOrD9uh19oPKE3eQvfUPf3A=;
        b=KHlGxNqXSocknz/69j/IOCl94tjLc3aeuhcS8CEuSLyEKSKd8SW0POd3wP4wZ/OTg6nne9
        oXtICcX8N8l9f+3Vi/25UwIRTrNkL8DGVh+tcgw+0ChCMdhNKjKbeCvkgv48eytWieJkHj
        jh5vAujkGPTgOxDSNETlmF/k4v/B8Ek=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-kUjBGaNpMyaL8JTxUJ0ePQ-1; Fri, 21 Feb 2020 07:57:16 -0500
X-MC-Unique: kUjBGaNpMyaL8JTxUJ0ePQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A33C8017CC;
        Fri, 21 Feb 2020 12:57:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-122-163.rdu2.redhat.com [10.10.122.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8843B5D9C5;
        Fri, 21 Feb 2020 12:57:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <ba89cc20-ac0c-cf13-9953-5d5546aab6de@samba.org>
References: <ba89cc20-ac0c-cf13-9953-5d5546aab6de@samba.org> <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk>
To:     Stefan Metzmacher <metze@samba.org>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk, raven@themaw.net,
        mszeredi@redhat.com, christian@brauner.io,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/19] VFS: Filesystem information and notifications [ver #16]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1811032.1582289832.1@warthog.procyon.org.uk>
Date:   Fri, 21 Feb 2020 12:57:12 +0000
Message-ID: <1811033.1582289832@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Stefan Metzmacher <metze@samba.org> wrote:

> > fsinfo() may be called like the following, for example:
> > 
> > 	struct fsinfo_params params = {
> > 		.at_flags	= AT_SYMLINK_NOFOLLOW,
> 
> Shouldn't all new syscalls be able to provide the RESOLVE_ flags
> supported in openat2?

If that's the rule, then fine.  I presume these are a replacement for AT_*.
But the set of RESOLVE_* flags does not appear to be complete - and why's it
not in linux/fs.h if it's meant to be used by everything?

Anyway, it lacks a RESOLVE_NO_AUTOMOUNT flag.  This is not quite the same as
the documented behaviour of RESOLVE_NO_XDEV.

> > 	len = fsinfo(AT_FDCWD, "/afs/grand.central.org/doc", &params,
> > 		     &address, sizeof(address));
> 
> Also passing sizeof(params) would allow future updates of fsinfo_params,
> also similar to openat2(), clone3()...

I can put that at the beginning of the params block or put dirfd in there.  If
I remember rightly, 6-arg syscalls are discouraged because they may need
special handling on some arches.

David

