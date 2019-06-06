Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBF637F77
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 23:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbfFFVVx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jun 2019 17:21:53 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:34561 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbfFFVVx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jun 2019 17:21:53 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id CDCD23C00DD;
        Thu,  6 Jun 2019 23:21:49 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id F4M8mMrwGFmg; Thu,  6 Jun 2019 23:21:43 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id C54483C00D1;
        Thu,  6 Jun 2019 23:21:43 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 6 Jun 2019
 23:21:43 +0200
Date:   Thu, 6 Jun 2019 23:21:40 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     David Howells <dhowells@redhat.com>
CC:     <viro@zeniv.linux.org.uk>, <raven@themaw.net>,
        <linux-fsdevel@vger.kernel.org>, <linux-api@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <keyrings@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH 10/10] Add sample notification program [ver #3]
Message-ID: <20190606212140.GA25664@vmlxhi-102.adit-jv.com>
References: <155981411940.17513.7137844619951358374.stgit@warthog.procyon.org.uk>
 <155981421379.17513.13158528501056454772.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <155981421379.17513.13158528501056454772.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.72.93.184]
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David,

On Thu, Jun 06, 2019 at 10:43:33AM +0100, David Howells wrote:
[..]
> diff --git a/samples/watch_queue/Makefile b/samples/watch_queue/Makefile
> new file mode 100644
> index 000000000000..42b694430d0f
> --- /dev/null
> +++ b/samples/watch_queue/Makefile
> @@ -0,0 +1,9 @@
> +# List of programs to build
> +hostprogs-y := watch_test
> +
> +# Tell kbuild to always build the programs
> +always := $(hostprogs-y)
> +
> +HOSTCFLAGS_watch_test.o += -I$(objtree)/usr/include

How about arm64? Do you intend to enable cross-compilation?

> +
> +HOSTLOADLIBES_watch_test += -lkeyutils
> diff --git a/samples/watch_queue/watch_test.c b/samples/watch_queue/watch_test.c
> new file mode 100644
> index 000000000000..893a5380f792
> --- /dev/null
> +++ b/samples/watch_queue/watch_test.c
[..]

> +			asm ("lfence" : : : "memory" );
[..]
> +			asm("mfence" ::: "memory");

FWIW, trying to cross-compile it returned:

aarch64-linux-gnu-gcc -I../../usr/include -I../../include  watch_test.c   -o watch_test
/tmp/ccDXYynm.s: Assembler messages:
/tmp/ccDXYynm.s:471: Error: unknown mnemonic `lfence' -- `lfence'
/tmp/ccDXYynm.s:568: Error: unknown mnemonic `mfence' -- `mfence'
<builtin>: recipe for target 'watch_test' failed
make: *** [watch_test] Error 1

-- 
Best Regards,
Eugeniu.
