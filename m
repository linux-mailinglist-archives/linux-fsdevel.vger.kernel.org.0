Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C10CE2E94E7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jan 2021 13:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbhADMeP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 07:34:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46769 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725921AbhADMeP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 07:34:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609763568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PfXqInqm33cRUNjuA/gZ2uyf+NPRmgOZS4ZWMKwHtVo=;
        b=B2aRK5retMBEJnJ4PsxNAKnCI2Fv6kgpJ9p6ULUH9HxgzFyFrG++QDViOWfNPatmsGJL6T
        F1W8PDG1zHiW6PCb+KnAphdO4ehHDEjvJxdgjgIQfKSesdbAj/ffgJj+ypCOr1cpieQsbl
        HfNTOelJSGrGLHmkF2FbOM0zaTitjmc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-o4KyHx2jMiC6ody5qiL7FA-1; Mon, 04 Jan 2021 07:32:46 -0500
X-MC-Unique: o4KyHx2jMiC6ody5qiL7FA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CC121005504;
        Mon,  4 Jan 2021 12:32:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-8.rdu2.redhat.com [10.10.112.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 22A8360853;
        Mon,  4 Jan 2021 12:32:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=whRD1YakfPKE72htDBzTKA73x3aEwi44ngYFf4WCk+1kQ@mail.gmail.com>
References: <CAHk-=whRD1YakfPKE72htDBzTKA73x3aEwi44ngYFf4WCk+1kQ@mail.gmail.com> <365031.1608567254@warthog.procyon.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>
Cc:     dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] afs: Work around strnlen() oops with CONFIG_FORTIFIED_SOURCE=y
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <257073.1609763562.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 04 Jan 2021 12:32:42 +0000
Message-ID: <257074.1609763562@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> I htink the right fix would be to try to create a type that actually
> describes that.

How about the attached, then?  It's basically what you suggested.

I realised whilst doing this that I'm not quite getting the extended-name
handling correct, but I'll deal with that in a separate patch.

David
---
commit 26982a89cad77c0efc1c0c79bee0e3d75e9281d4
Author: David Howells <dhowells@redhat.com>
Date:   Mon Dec 21 22:37:58 2020 +0000

    afs: Work around strnlen() oops with CONFIG_FORTIFIED_SOURCE=3Dy
    =

    AFS has a structured layout in its directory contents (AFS dirs are
    downloaded as files and parsed locally by the client for lookup/readdi=
r).
    The slots in the directory are defined by union afs_xdr_dirent.  This,
    however, only directly allows a name of a length that will fit into th=
at
    union.  To support a longer name, the next 1-8 contiguous entries are
    annexed to the first one and the name flows across these.
    =

    afs_dir_iterate_block() uses strnlen(), limited to the space to the en=
d of
    the page, to find out how long the name is.  This worked fine until
    6a39e62abbaf.  With that commit, the compiler determines the size of t=
he
    array and asserts that the string fits inside that array.  This is a
    problem for AFS because we *expect* it to overflow one or more arrays.
    =

    A similar problem also occurs in afs_dir_scan_block() when a directory=
 file
    is being locally edited to avoid the need to redownload it.  There str=
len()
    was being used safely because each page has the last byte set to 0 whe=
n the
    file is downloaded and validated (in afs_dir_check_page()).
    =

    Fix this by changing the afs_xdr_dirent union name field to an
    indeterminate-length array and dropping the overflow field.
    =

    (Note that whilst looking at this, I realised that the calculation of =
the
    number of slots a dirent used is non-standard and not quite right, but=
 I'll
    address that in a separate patch.)
    =

    The issue can be triggered by something like:
    =

            touch /afs/example.com/thisisaveryveryverylongname
    =

    and it generates a report that looks like:
    =

            detected buffer overflow in strnlen
            ------------[ cut here ]------------
            kernel BUG at lib/string.c:1149!
            ...
            RIP: 0010:fortify_panic+0xf/0x11
            ...
            Call Trace:
             afs_dir_iterate_block+0x12b/0x35b
             afs_dir_iterate+0x14e/0x1ce
             afs_do_lookup+0x131/0x417
             afs_lookup+0x24f/0x344
             lookup_open.isra.0+0x1bb/0x27d
             open_last_lookups+0x166/0x237
             path_openat+0xe0/0x159
             do_filp_open+0x48/0xa4
             ? kmem_cache_alloc+0xf5/0x16e
             ? __clear_close_on_exec+0x13/0x22
             ? _raw_spin_unlock+0xa/0xb
             do_sys_openat2+0x72/0xde
             do_sys_open+0x3b/0x58
             do_syscall_64+0x2d/0x3a
             entry_SYSCALL_64_after_hwframe+0x44/0xa9
    =

    Fixes: 6a39e62abbaf ("lib: string.h: detect intra-object overflow in f=
ortified string functions")
    Reported-by: Marc Dionne <marc.dionne@auristor.com>
    Signed-off-by: David Howells <dhowells@redhat.com>
    Tested-by: Marc Dionne <marc.dionne@auristor.com>
    cc: Daniel Axtens <dja@axtens.net>

diff --git a/fs/afs/xdr_fs.h b/fs/afs/xdr_fs.h
index 94f1f398eefa..c926430fd08a 100644
--- a/fs/afs/xdr_fs.h
+++ b/fs/afs/xdr_fs.h
@@ -54,10 +54,15 @@ union afs_xdr_dirent {
 		__be16		hash_next;
 		__be32		vnode;
 		__be32		unique;
-		u8		name[16];
-		u8		overflow[4];	/* if any char of the name (inc
-						 * NUL) reaches here, consume
-						 * the next dirent too */
+		u8		name[];
+		/* When determining the number of dirent slots needed to
+		 * represent a directory entry, name should be assumed to be 16
+		 * bytes, due to a now-standardised (mis)calculation, but it is
+		 * in fact 20 bytes in size.
+		 *
+		 * For names longer than (16 or) 20 bytes, extra slots should
+		 * be annexed to this one using the extended_name format.
+		 */
 	} u;
 	u8			extended_name[32];
 } __packed;

