Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 177A0FDEEA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 14:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbfKON3D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Nov 2019 08:29:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22855 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727406AbfKON3D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Nov 2019 08:29:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573824542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mks2DjWdpnukmwwEXVk82toAm3agWoayoydTXhkFsfg=;
        b=flnZk33ocQ28HZ4XDL3qAGJ72dDwRt496HveaZUWJ6MUYUP9sUPhz179yxFxQbmbQNeVYp
        xXi7UNXLrDxpeRYujxgpvPsrmM5ZWGXkajdGa4kqUD8Adg1tZnG9ADspoSMW6Zx5Hsxl0P
        MQHD5J9aVF5k7wWhBqGeDTNswLMR79Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-HPOfJgVkOrK1lyjxuhbP-w-1; Fri, 15 Nov 2019 08:28:58 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E6BA18B5F8A;
        Fri, 15 Nov 2019 13:28:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-161.rdu2.redhat.com [10.10.120.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E61D95F900;
        Fri, 15 Nov 2019 13:28:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20191110031348.GE29418@shao2-debian>
References: <20191110031348.GE29418@shao2-debian>
To:     kernel test robot <lkp@intel.com>
Cc:     dhowells@redhat.com, torvalds@linux-foundation.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkp@lists.01.org
Subject: Re: [pipe] d60337eff1: BUG:kernel_NULL_pointer_dereference,address
MIME-Version: 1.0
Content-ID: <9278.1573824532.1@warthog.procyon.org.uk>
Date:   Fri, 15 Nov 2019 13:28:52 +0000
Message-ID: <9279.1573824532@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: HPOfJgVkOrK1lyjxuhbP-w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

kernel test robot <lkp@intel.com> wrote:

> [    9.423019] BUG: kernel NULL pointer dereference, address: 00000000000=
00008
> [    9.425646] #PF: supervisor read access in kernel mode
> [    9.427714] #PF: error_code(0x0000) - not-present page
> [    9.429851] PGD 80000001fb937067 P4D 80000001fb937067 PUD 1739e1067 PM=
D 0=20
> [    9.432468] Oops: 0000 [#1] SMP PTI
> [    9.434064] CPU: 0 PID: 178 Comm: cat Not tainted 5.4.0-rc5-00353-gd60=
337eff18a3 #1
> [    9.437139] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S 1.10.2-1 04/01/2014
> [    9.440439] RIP: 0010:iov_iter_get_pages_alloc+0x2a8/0x400

Can you tell me if the following change fixes it for you?

--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -404,7 +404,7 @@ static size_t copy_page_to_iter_pipe(struct page *page,=
 size_t offset, size_t by
 =09buf->offset =3D offset;
 =09buf->len =3D bytes;
=20
-=09pipe->head =3D i_head;
+=09pipe->head =3D i_head + 1;
 =09i->iov_offset =3D offset + bytes;
 =09i->head =3D i_head;
 out:

Attached is a test program that can induce some a bug in
copy_page_to_iter_pipe() where I forgot to increment the new head when
assigning it to pipe->head.

David
---
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <err.h>
#include <sys/wait.h>

static char buf[256 * 1024] __attribute__((aligned(512)));
static char *filename;
static int pipe_wfd =3D -1;

static void cleanup(void)
{
=09close(pipe_wfd);
}

static void cleanup_child(void)
{
=09int w;
=09wait(&w);
}

int child(int fd)
{
=09ssize_t r;

=09do {
=09=09r =3D read(fd, buf, 256 * 1024);
=09=09if (r =3D=3D -1)
=09=09=09err(1, "read");
=09} while (r !=3D 0);

=09if (close(fd) =3D=3D -1)
=09=09err(1, "close");

=09return 0;
}

int main(int argc, char **argv)
{
=09ssize_t n;
=09loff_t offset;
=09size_t len;
=09pid_t pid;
=09int fd, pfd[2];

=09if (argc !=3D 2) {
=09=09fprintf(stderr, "Format: %s <file>\n", argv[1]);
=09=09exit(2);
=09}

=09filename =3D argv[1];

=09if (pipe(pfd) =3D=3D -1)
=09=09err(1, "pipe");
=09pipe_wfd =3D pfd[1];

=09pid =3D fork();
=09switch (pid) {
=09case -1:
=09=09err(1, "fork");
=09case 0:
=09=09close(pfd[1]);
=09=09return child(pfd[0]);
=09default:
=09=09close(pfd[0]);
=09=09atexit(cleanup_child);
=09=09break;
=09}

=09fd =3D open(filename, O_RDONLY);
=09if (fd =3D=3D -1)
=09=09err(1, "%s", filename);

=09atexit(cleanup);

=09len =3D 256 * 1024;
=09offset =3D 0;
=09do {
=09=09n =3D splice(fd, &offset, pfd[1], NULL, 256 * 1024, 0);
=09=09if (n =3D=3D -1)
=09=09=09err(1, "splice");
=09} while (len -=3D n, len > 0);

=09if (close(pfd[1]) =3D=3D -1)
=09=09err(1, "close/p");
=09if (close(fd) =3D=3D -1)
=09=09err(1, "close/f");
=09return 0;
}

