Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4B402BDD9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2019 05:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbfE1Dnw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 May 2019 23:43:52 -0400
Received: from ozlabs.org ([203.11.71.1]:42453 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727804AbfE1Dnw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 May 2019 23:43:52 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45Cfp83y01z9s9N;
        Tue, 28 May 2019 13:43:43 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christian Brauner <christian@brauner.io>, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        torvalds@linux-foundation.org, fweimer@redhat.com
Cc:     jannh@google.com, oleg@redhat.com, tglx@linutronix.de,
        arnd@arndb.de, shuah@kernel.org, dhowells@redhat.com,
        tkjos@android.com, ldv@altlinux.org, miklos@szeredi.hu,
        Christian Brauner <christian@brauner.io>,
        linux-api@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v3 2/3] arch: wire-up close_range()
In-Reply-To: <20190524111047.6892-3-christian@brauner.io>
References: <20190524111047.6892-1-christian@brauner.io> <20190524111047.6892-3-christian@brauner.io>
Date:   Tue, 28 May 2019 13:43:43 +1000
Message-ID: <87woibp7kg.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christian Brauner <christian@brauner.io> writes:
> diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
> index 103655d84b4b..ba2c1f078cbd 100644
> --- a/arch/powerpc/kernel/syscalls/syscall.tbl
> +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
> @@ -515,3 +515,4 @@
>  431	common	fsconfig			sys_fsconfig
>  432	common	fsmount				sys_fsmount
>  433	common	fspick				sys_fspick
> +435	common	close_range			sys_close_range

With a minor build fix the selftest passes for me on ppc64le:

  # ./close_range_test 
  1..9
  ok 1 do not allow invalid flag values for close_range()
  ok 2 close_range() from 3 to 53
  ok 3 fcntl() verify closed range from 3 to 53
  ok 4 close_range() from 54 to 95
  ok 5 fcntl() verify closed range from 54 to 95
  ok 6 close_range() from 96 to 102
  ok 7 fcntl() verify closed range from 96 to 102
  ok 8 close_range() closed single file descriptor
  ok 9 fcntl() verify closed single file descriptor
  # Pass 9 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0


Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
