Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE27F618B9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2019 03:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbfGHBPo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Jul 2019 21:15:44 -0400
Received: from ozlabs.org ([203.11.71.1]:46577 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727949AbfGHBPn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Jul 2019 21:15:43 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45hnZJ0R8Jz9sN4;
        Mon,  8 Jul 2019 11:15:35 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        containers@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v9 10/10] selftests: add openat2(2) selftests
In-Reply-To: <20190706145737.5299-11-cyphar@cyphar.com>
References: <20190706145737.5299-1-cyphar@cyphar.com> <20190706145737.5299-11-cyphar@cyphar.com>
Date:   Mon, 08 Jul 2019 11:15:35 +1000
Message-ID: <878st9iax4.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Aleksa,

A few minor comments below.

Aleksa Sarai <cyphar@cyphar.com> writes:
> diff --git a/tools/testing/selftests/openat2/Makefile b/tools/testing/selftests/openat2/Makefile
> new file mode 100644
> index 000000000000..8235a49928f6
> --- /dev/null
> +++ b/tools/testing/selftests/openat2/Makefile
> @@ -0,0 +1,12 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +CFLAGS += -Wall -O2 -g
> +TEST_GEN_PROGS := linkmode_test resolve_test rename_attack_test
> +
> +include ../lib.mk
> +
> +$(OUTPUT)/linkmode_test: linkmode_test.c helpers.o
> +$(OUTPUT)/rename_attack_test: rename_attack_test.c helpers.o
> +$(OUTPUT)/resolve_test: resolve_test.c helpers.o

You don't need to tell make that foo depends on foo.c.

Also if you make the dependency be on helpers.c then you won't get an
intermediate helpers.o, and then you don't need to clean it.

So the above three lines could just be:

$(TEST_GEN_PROGS): helpers.c

> +EXTRA_CLEAN = helpers.o $(wildcard /tmp/ksft-openat2-*)

If you follow my advice above you don't need helpers.o in there.

Deleting things from /tmp is also a bit fishy on shared machines, ie. it
will error if those files happen to be owned by another user.

cheers
