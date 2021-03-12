Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC11339019
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Mar 2021 15:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhCLOdb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Mar 2021 09:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbhCLOdN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Mar 2021 09:33:13 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A79C061574;
        Fri, 12 Mar 2021 06:33:13 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lKiqc-00FE4K-N4; Fri, 12 Mar 2021 15:33:02 +0100
Message-ID: <d36ea54d8c0a8dd706826ba844a6f27691f45d55.camel@sipsolutions.net>
Subject: Re: [PATCH 0/6] um: fix up CONFIG_GCOV support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
Cc:     Jessica Yu <jeyu@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Date:   Fri, 12 Mar 2021 15:33:01 +0100
In-Reply-To: <20210312095526.197739-1-johannes@sipsolutions.net>
References: <20210312095526.197739-1-johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2021-03-12 at 10:55 +0100, Johannes Berg wrote:
> CONFIG_GCOV is fairly useful for ARCH=um (e.g. with kunit, though
> my main use case is a bit different) since it writes coverage data
> directly out like a normal userspace binary. Theoretically, that
> is.
> 
> Unfortunately, it's broken in multiple ways today:
> 
>  1) it doesn't like, due to 'mangle_path' in seq_file, and the only
>     solution to that seems to be to rename our symbol, but that's
>     not so bad, and "mangle_path" sounds very generic anyway, which
>     it isn't quite
> 
>  2) gcov requires exit handlers to write out the data, and those are
>     never called for modules, config CONSTRUCTORS exists for init
>     handlers, so add CONFIG_MODULE_DESTRUCTORS here that we can then
>     select in ARCH=um

Yeah, I wish.

None of this can really work. Thing is, __gcov_init(), called from the
constructors, will add the local data structure for the object file into
the global list (__gcov_root). So far, so good.

However, __gcov_exit(), which is called from the destructors (fini_array
which I added support for here) never gets passed the local data
structure pointer. It dumps __gcov_root, and that's it.

That basically means each executable/shared object should have its own
instance of __gcov_root and the functions. But the code in UML was set
up to export __gcov_exit(), which obviously then dumps the kernel's gcov
data.

So to make this really work we should treat modules like shared objects,
and link libgcov.a into each one of them. That might even work, but we
get

ERROR: modpost: "free" [module.ko] undefined!
ERROR: modpost: "vfprintf" [module.ko] undefined!
ERROR: modpost: "fcntl" [module.ko] undefined!
ERROR: modpost: "setbuf" [module.ko] undefined!
ERROR: modpost: "exit" [module.ko] undefined!
ERROR: modpost: "fwrite" [module.ko] undefined!
ERROR: modpost: "stderr" [module.ko] undefined!
ERROR: modpost: "fclose" [module.ko] undefined!
ERROR: modpost: "ftell" [module.ko] undefined!
ERROR: modpost: "fopen" [module.ko] undefined!
ERROR: modpost: "fread" [module.ko] undefined!
ERROR: modpost: "fdopen" [module.ko] undefined!
ERROR: modpost: "fseek" [module.ko] undefined!
ERROR: modpost: "fprintf" [module.ko] undefined!
ERROR: modpost: "strtol" [module.ko] undefined!
ERROR: modpost: "malloc" [module.ko] undefined!
ERROR: modpost: "getpid" [module.ko] undefined!
ERROR: modpost: "getenv" [module.ko] undefined!

We could of course export those, but that makes me nervous, e.g.
printf() is known to use a LOT of stack, far more than we have in the
kernel.

Also, we see:

WARNING: modpost: "__gcov_var" [module] is COMMON symbol
WARNING: modpost: "__gcov_root" [module] is COMMON symbol

which means the module cannot be loaded.

I think I'll just make CONFIG_GCOV depend on !MODULE instead, and for my
use case use CONFIG_GCOV_KERNEL.

Or maybe just kill CONFIG_GCOV entirely, since obviously nobody has ever
tried to use it with modules or with recent toolchains (gcc 9 or newer,
the mangle_path conflict).

johannes

