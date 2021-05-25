Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F454390C4C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 May 2021 00:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbhEYWdd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 18:33:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38444 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231196AbhEYWdc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 18:33:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621981921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t2QUVz6gnfCaqisemCBpqjC6VD3ID8/L7m//tDjqPVA=;
        b=gJQ+r3BBK1CPH+WTQ+Qk0d986+lmxiFqLVuskbFX7hICjp99LNViKrkpV1x1+V0bcPaAf/
        AVQKL32iQc3eTdzBLZoTnC879x5dhOAZ1ESVz3TgOpabk7N+knqJQObpLaVpiU3/GuBZ2+
        UYCFn2qASMSm9IVvTr45kyJ0/2kgSzE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-PqGiBbc9PpOTULD7UQr0ZQ-1; Tue, 25 May 2021 18:31:57 -0400
X-MC-Unique: PqGiBbc9PpOTULD7UQr0ZQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E5FF107ACC7;
        Tue, 25 May 2021 22:31:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-24.rdu2.redhat.com [10.10.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 794046062F;
        Tue, 25 May 2021 22:31:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <6E4DE257-4220-4B5B-B3D0-B67C7BC69BB5@dilger.ca>
References: <6E4DE257-4220-4B5B-B3D0-B67C7BC69BB5@dilger.ca> <206078.1621264018@warthog.procyon.org.uk>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     dhowells@redhat.com, Theodore Ts'o <tytso@mit.edu>,
        "Darrick J. Wong" <djwong@kernel.org>, Chris Mason <clm@fb.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        linux-cachefs@redhat.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        NeilBrown <neilb@suse.com>
Subject: Re: How capacious and well-indexed are ext4, xfs and btrfs directories?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4169581.1621981910.1@warthog.procyon.org.uk>
Date:   Tue, 25 May 2021 23:31:50 +0100
Message-ID: <4169583.1621981910@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Andreas Dilger <adilger@dilger.ca> wrote:

> As described elsewhere in the thread, allowing concurrent create and unlink
> in a directory (rename probably not needed) would be invaluable for scaling
> multi-threaded workloads.  Neil Brown posted a prototype patch to add this
> to the VFS for NFS:

Actually, one thing I'm looking at is using vfs_tmpfile() to create a new file
(or a replacement file when invalidation is required) and then using
vfs_link() to attach directory entries in the background (possibly using
vfs_link() with AT_LINK_REPLACE[1] instead of unlink+link).

Any thoughts on how that might scale?  vfs_tmpfile() doesn't appear to require
the directory inode lock.  I presume the directory is required for security
purposes in addition to being a way to specify the target filesystem.

David

[1] https://lore.kernel.org/linux-fsdevel/cover.1580251857.git.osandov@fb.com/

