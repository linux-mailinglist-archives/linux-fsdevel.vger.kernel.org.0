Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7286C232688
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jul 2020 22:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgG2U6y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jul 2020 16:58:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30781 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726496AbgG2U6x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jul 2020 16:58:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596056331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vLUygYYzd++JIlYknve101yWy4mcR2ip0YkY0hzcOSk=;
        b=eWnYfwndaFYmuN2qlswuP1KiYpXfpvfL7HkBHLcCf1RZzBCfexG+XirRwgJgjTXQjMB6W8
        HCFVtVGC1ep1bUYWM2ac7jJC6kWeWVOUwqtFFx8vLMS+tVU2s7lbfvafj+zXj+WbWs6aEr
        iYEYty53JBKltl0Q/FkXY34t+zUMs5U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-Q_tBaD1HMNSuLNq5odNeeA-1; Wed, 29 Jul 2020 16:58:47 -0400
X-MC-Unique: Q_tBaD1HMNSuLNq5odNeeA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 827E918C63C0;
        Wed, 29 Jul 2020 20:58:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E7C8A19C71;
        Wed, 29 Jul 2020 20:58:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <4007797.1596055016@warthog.procyon.org.uk>
References: <4007797.1596055016@warthog.procyon.org.uk> <0b154b9b-728f-7d57-d4c5-ec25fc9dfdf3@toxicpanda.com>
Cc:     dhowells@redhat.com, Josef Bacik <josef@toxicpanda.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Sandeen <sandeen@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Subject: Re: Inverted mount options completely broken (iversion,relatime)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4056339.1596056321.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 29 Jul 2020 21:58:41 +0100
Message-ID: <4056340.1596056321@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> > So my question is, what do we do here?
> =

> Hmmm...  As the code stands, MS_RDONLY, MS_SYNCHRONOUS, MS_MANDLOCK,
> MS_I_VERSION and MS_LAZYTIME should all be masked off before the new fla=
gs are
> set if called from mount(2) rather than fsconfig(2).
> =

> do_remount() gives MS_RMT_MASK to fs_context_for_reconfigure() to load i=
nto
> fc->sb_flags_mask, which should achieve the desired effect in
> reconfigure_super() on this line:
> =

> 	WRITE_ONCE(sb->s_flags, ((sb->s_flags & ~fc->sb_flags_mask) |
> 				 (fc->sb_flags & fc->sb_flags_mask)));

So applying the attached patch and then doing:

mount -t tmpfs none /mnt
mount -o remount,iversion /mnt
mount -o remount,noiversion /mnt
mount -o remount,norelatime /mnt
mount -o remount,relatime /mnt

prints:

sb=3D70010000 set=3D800000 mask=3D2800051
sb=3D70810000 set=3D0 mask=3D2800051
sb=3D70010000 set=3D0 mask=3D2800051
sb=3D70010000 set=3D0 mask=3D2800051

MS_RELATIME isn't included in MS_RMT_MASK, so remount shouldn't be able to
change it.

David
---
diff --git a/fs/super.c b/fs/super.c
index 904459b35119..540cb37c11e7 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -964,6 +964,7 @@ int reconfigure_super(struct fs_context *fc)
 		}
 	}
 =

+	printk("sb=3D%lx set=3D%x mask=3D%x\n", sb->s_flags, fc->sb_flags, fc->s=
b_flags_mask);
 	WRITE_ONCE(sb->s_flags, ((sb->s_flags & ~fc->sb_flags_mask) |
 				 (fc->sb_flags & fc->sb_flags_mask)));
 	/* Needs to be ordered wrt mnt_is_readonly() */

