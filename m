Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDB13174DFB
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2020 16:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgCAPOB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Mar 2020 10:14:01 -0500
Received: from mout-p-102.mailbox.org ([80.241.56.152]:45516 "EHLO
        mout-p-102.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgCAPOB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Mar 2020 10:14:01 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 48VmyF5F3XzKm9t;
        Sun,  1 Mar 2020 16:13:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id Rk-9Jz51Rj94; Sun,  1 Mar 2020 16:13:52 +0100 (CET)
Date:   Mon, 2 Mar 2020 02:13:33 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Yuyang Du <duyuyang@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        David Howells <dhowells@redhat.com>,
        Jann Horn <jannh@google.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christian Kellner <christian@kellner.me>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH] exec: Fix a deadlock in ptrace
Message-ID: <20200301151333.bsjfdjcjddsza2vn@yavin>
References: <AM6PR03MB5170B06F3A2B75EFB98D071AE4E60@AM6PR03MB5170.eurprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vg5uvlw455hqb7u3"
Content-Disposition: inline
In-Reply-To: <AM6PR03MB5170B06F3A2B75EFB98D071AE4E60@AM6PR03MB5170.eurprd03.prod.outlook.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--vg5uvlw455hqb7u3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-03-01, Bernd Edlinger <bernd.edlinger@hotmail.de> wrote:
> This fixes a deadlock in the tracer when tracing a multi-threaded
> application that calls execve while more than one thread are running.
>=20
> I observed that when running strace on the gcc test suite, it always
> blocks after a while, when expect calls execve, because other threads
> have to be terminated.  They send ptrace events, but the strace is no
> longer able to respond, since it is blocked in vm_access.
>=20
> The deadlock is always happening when strace needs to access the
> tracees process mmap, while another thread in the tracee starts to
> execve a child process, but that cannot continue until the
> PTRACE_EVENT_EXIT is handled and the WIFEXITED event is received:
>=20
> strace          D    0 30614  30584 0x00000000
> Call Trace:
> __schedule+0x3ce/0x6e0
> schedule+0x5c/0xd0
> schedule_preempt_disabled+0x15/0x20
> __mutex_lock.isra.13+0x1ec/0x520
> __mutex_lock_killable_slowpath+0x13/0x20
> mutex_lock_killable+0x28/0x30
> mm_access+0x27/0xa0
> process_vm_rw_core.isra.3+0xff/0x550
> process_vm_rw+0xdd/0xf0
> __x64_sys_process_vm_readv+0x31/0x40
> do_syscall_64+0x64/0x220
> entry_SYSCALL_64_after_hwframe+0x44/0xa9
>=20
> expect          D    0 31933  30876 0x80004003
> Call Trace:
> __schedule+0x3ce/0x6e0
> schedule+0x5c/0xd0
> flush_old_exec+0xc4/0x770
> load_elf_binary+0x35a/0x16c0
> search_binary_handler+0x97/0x1d0
> __do_execve_file.isra.40+0x5d4/0x8a0
> __x64_sys_execve+0x49/0x60
> do_syscall_64+0x64/0x220
> entry_SYSCALL_64_after_hwframe+0x44/0xa9
>=20
> The proposed solution is to have a second mutex that is
> used in mm_access, so it is allowed to continue while the
> dying threads are not yet terminated.
>=20
> I also took the opportunity to improve the documentation
> of prepare_creds, which is obviously out of sync.
>
> Signed-off-by: Bernd Edlinger <bernd.edlinger@hotmail.de>

I can't comment on the validity of the patch, but I also found and
reported this issue in 2016[1] and the discussion quickly veered into
the problem being more complicated (and uglier) than it seems at first
glance.

You should probably also Cc stable, given this has been a long-standing
issue and your patch doesn't look (too) invasive.

[1]: https://lore.kernel.org/lkml/20160921152946.GA24210@dhcp22.suse.cz/

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--vg5uvlw455hqb7u3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXlvRGgAKCRCdlLljIbnQ
EjRbAPwOWy8usv2Qm9fpwRZDJoGAGVji8JaOgbWjcOY+L7Oi0wEAqx+Ima9ZqQxy
8D24v6MY2GXoi53rQW5HdUcLes0joQo=
=LnSE
-----END PGP SIGNATURE-----

--vg5uvlw455hqb7u3--
