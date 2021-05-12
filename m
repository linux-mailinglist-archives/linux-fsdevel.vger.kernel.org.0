Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCBE637BF77
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 16:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhELON1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 10:13:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43098 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230197AbhELON0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 10:13:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620828737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KK1RK63cTihxwj29DLvKTN+9ElMIALQrC9nlHIXIqqQ=;
        b=ZrFQXq6TO3AYxEQmf7m9QtM6MMPiK6ZbCv/GPnsbRJ+DwqXojmuT3OjZmB8sZ3pmSmnAzI
        Biw2Utp/uaov1ZAhizF9VMwOLZOqTthiUn3GjO7CdL75jR9ZLvUJYtDmJec1oswA654R5z
        SOdxBBhLnr6/DBCHXYmusa9w2GNr8A0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-oRiIFmxSNSeonLQjVFPA6Q-1; Wed, 12 May 2021 10:12:15 -0400
X-MC-Unique: oRiIFmxSNSeonLQjVFPA6Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1BFC800D55;
        Wed, 12 May 2021 14:12:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5522D6091A;
        Wed, 12 May 2021 14:12:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YJvb9S8uxV2X45Cu@zeniv-ca.linux.org.uk>
References: <YJvb9S8uxV2X45Cu@zeniv-ca.linux.org.uk> <YJvJWj/CEyEUWeIu@codewreck.org> <87tun8z2nd.fsf@suse.de> <87czu45gcs.fsf@suse.de> <2507722.1620736734@warthog.procyon.org.uk> <2882181.1620817453@warthog.procyon.org.uk> <87fsysyxh9.fsf@suse.de> <2891612.1620824231@warthog.procyon.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com, Dominique Martinet <asmadeus@codewreck.org>,
        Luis Henriques <lhenriques@suse.de>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: Re: What sort of inode state does ->evict_inode() expect to see? [was Re: 9p: fscache duplicate cookie]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2919957.1620828730.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 12 May 2021 15:12:10 +0100
Message-ID: <2919958.1620828730@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> wrote:

> > We're seeing cases where fscache is reporting cookie collisions that a=
ppears
> > to be due to ->evict_inode() running parallel with a new inode for the=
 same
> > filesystem object getting set up.
> =

> Huh?  Details, please.  What we are guaranteed is that iget{,5}_locked()=
 et.al.
> on the same object will either prevent the call of ->evict_inode() (if t=
hey
> manage to grab the sucker before I_FREEING is set) or will wait until af=
ter
> ->evict_inode() returns.

See the trace from Luis in:

	https://lore.kernel.org/linux-fsdevel/87fsysyxh9.fsf@suse.de/

It appears that process 20591 manages to set up a new inode that has the s=
ame
key parameters as the one process 20585 is tearing down.

0000000097476aaa is the cookie pointer used by the old inode.
0000000011fa06b1 is the cookie pointer used by the new inode.
000000003080d900 is the cookie pointer for the parent superblock.

The fscache_acquire traceline emission is caused by one of:

 (*) v9fs_qid_iget() or v9fs_qid_iget_dotl() calling
     v9fs_cache_inode_get_cookie().

 (*) v9fs_file_open*(O_RDONLY) or v9fs_vfs_atomic_open*(O_RDONLY) calling
     v9fs_cache_inode_set_cookie().

 (*) v9fs_cache_inode_reset_cookie(), which appears unused.

The fscache_relinquish traceline emission is caused by one of:

 (*) v9fs_file_open(O_RDWR/O_WRONLY) or v9fs_vfs_atomic_open(O_RDWR/O_WRON=
LY)
     calling v9fs_cache_inode_set_cookie().

 (*) v9fs_evict_inode() calling v9fs_cache_inode_put_cookie().

 (*) v9fs_cache_inode_reset_cookie(), which appears unused.

=46rom the backtrace in:

	https://lore.kernel.org/linux-fsdevel/87czu45gcs.fsf@suse.de/

the acquisition is being triggered in v9fs_vfs_atomic_open_dotl(), so it s=
eems
v9fs_qid_iget_dotl() already happened - which *should* have created the
cookie.

So it seems more complicated than I thought.

David

