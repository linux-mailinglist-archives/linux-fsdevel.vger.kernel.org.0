Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 754941649AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 17:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgBSQQT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 11:16:19 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49528 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbgBSQQS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 11:16:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582128977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kc32RHpu0LmyGTpAUd3PKfJ5eSwyU/PwzSUYgSvBE5o=;
        b=AkKbLOElWVabtAVMKQxb9QpuE5TLmrNAbVQukpBLeDQK5ZPg97NJg/tx30XPa/sYYATsxe
        OuSN4Raywpec0T+Cauv4JB5ZFmsN5r4oxbSW1nOyg3/CuKqUEcLI75EYtDPK5qMGGyKf9v
        b7UGv8b1O174fgq1Pb7XgZYKLZYTLdI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-c_CiPQdAOZqyhXma7cbl6w-1; Wed, 19 Feb 2020 11:16:14 -0500
X-MC-Unique: c_CiPQdAOZqyhXma7cbl6w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39644800D48;
        Wed, 19 Feb 2020 16:16:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-122-163.rdu2.redhat.com [10.10.122.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9328587B26;
        Wed, 19 Feb 2020 16:16:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200219144613.lc5y2jgzipynas5l@wittgenstein>
References: <20200219144613.lc5y2jgzipynas5l@wittgenstein> <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk, raven@themaw.net,
        mszeredi@redhat.com, christian@brauner.io,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/19] VFS: Filesystem information and notifications [ver #16]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <232828.1582128970.1@warthog.procyon.org.uk>
Date:   Wed, 19 Feb 2020 16:16:10 +0000
Message-ID: <232829.1582128970@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christian Brauner <christian.brauner@ubuntu.com> wrote:

> I mainly have an organizational question. :) This is a huge patchset
> with lots and lots of (good) features. Wouldn't it make sense to make
> the fsinfo() syscall a completely separate patchset from the
> watch_mount() and watch_sb() syscalls? It seems that they don't need to
> depend on each other at all. This would make reviewing this so much
> nicer and likely would mean that fsinfo() could proceed a little faster.

I can split it up again, but it's not quite as independent as it seems.

There's a notification counter added to both the mount struct and the
super_block struct.  This is bumped by notifications and retrieved by
fsinfo().  You need this in the event that there's an overrun and you have to
rescan the whole tree.

So to actually make use of the mount/sb notification facilities, you need
fsinfo() as well.

David

