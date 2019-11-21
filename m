Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B18C104D76
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 09:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfKUIKs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 03:10:48 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40637 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726343AbfKUIKr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 03:10:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574323846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UTGfLpHLVQj6rfsHQU768KhiCjRcdVYmV+JB5Ady93s=;
        b=E/+hQeNwDtEFtoPH3p4T+eOMF0xOagIU2lCc1ua6XTAxXKvAXJIiS638Jqls3m+0lO7WoT
        AqyQBi4Jzzb3rjpX6SD7OBJeNlSegCSQ0l77E8xm/Qp0uALs54LOpf9HnGiiLHB1IAyvqQ
        93/1ZU0dGvCJm5qpRWHxhelj+K41NbE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-Zz3B_4G_Pk-que01Y4zS8Q-1; Thu, 21 Nov 2019 03:10:43 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF0CC107ACCA;
        Thu, 21 Nov 2019 08:10:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-161.rdu2.redhat.com [10.10.120.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 46FBBF6D0;
        Thu, 21 Nov 2019 08:10:40 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <1574295100.17153.25.camel@HansenPartnership.com>
References: <1574295100.17153.25.camel@HansenPartnership.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Christian Brauner <christian@brauner.io>
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: Feature bug with the new mount API: no way of doing read only bind mounts
MIME-Version: 1.0
Content-ID: <17267.1574323839.1@warthog.procyon.org.uk>
Date:   Thu, 21 Nov 2019 08:10:39 +0000
Message-ID: <17268.1574323839@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: Zz3B_4G_Pk-que01Y4zS8Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

James Bottomley <James.Bottomley@HansenPartnership.com> wrote:

> I was looking to use the read only bind mount as a template for
> reimplementing shiftfs when I discovered that you can't actually create a
> read only bind mount with the new API.  The problem is that fspick() will
> only reconfigure the underlying superblock, which you don't want because =
you
> only want the bound subtree to become read only and open_tree()/move_moun=
t()
> doesn't give you any facility to add or change options on the bind.

You'd use open_tree() with OPEN_TREE_CLONE and possibly AT_RECURSIVE rather
than fspick().  fspick() is, as you observed, more for reconfiguring the
superblock.

What is missing is a mount_setattr() syscall - something like:

=09mount_setattr(int dfd, const char *path, unsigned int at_flags,
=09=09      unsigned int attr_change_mask, unsigned int attrs);

which would allow what you want to be done like:

=09fd =3D open_tree(AT_FDCWD, "/my/source/", OPEN_TREE_CLONE);
=09mount_setattr(fd, "", AT_EMPTY_PATH | AT_RECURSIVE,
=09=09      MOUNT_ATTR_RDONLY, MOUNT_ATTR_RDONLY);
=09move_mount(fd, "", AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);

Christian: you said you wanted to have a look at doing this - is that still
your intention?

Al: Is it too late to change OPEN_TREE_CLONE to be a definite value rather
than tying it to O_CLOEXEC?  OPEN_TREE_CLONE shares its space with the
AT_flags, but O_CLOEXEC has one of three different values, depending on arc=
h.
Perhaps we can nail it to 02000000 (0x80000), which is what's used on
everything but alpha, mips, parisc and sparc.

David

