Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6910463F52
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2019 04:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfGJCbg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jul 2019 22:31:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55040 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbfGJCbg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jul 2019 22:31:36 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4796E5AFE9;
        Wed, 10 Jul 2019 02:31:34 +0000 (UTC)
Received: from treble (ovpn-112-43.rdu2.redhat.com [10.10.112.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A90BE5F9D8;
        Wed, 10 Jul 2019 02:31:25 +0000 (UTC)
Date:   Tue, 9 Jul 2019 21:31:23 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     frowand.list@gmail.com, gregkh@linuxfoundation.org,
        keescook@google.com, kieran.bingham@ideasonboard.com,
        mcgrof@kernel.org, peterz@infradead.org, robh@kernel.org,
        sboyd@kernel.org, shuah@kernel.org, tytso@mit.edu,
        yamada.masahiro@socionext.com, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-um@lists.infradead.org, Alexander.Levin@microsoft.com,
        Tim.Bird@sony.com, amir73il@gmail.com, dan.carpenter@oracle.com,
        daniel@ffwll.ch, jdike@addtoit.com, joel@jms.id.au,
        julia.lawall@lip6.fr, khilman@baylibre.com, knut.omang@oracle.com,
        logang@deltatee.com, mpe@ellerman.id.au, pmladek@suse.com,
        rdunlap@infradead.org, richard@nod.at, rientjes@google.com,
        rostedt@goodmis.org, wfg@linux.intel.com,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v7 08/18] objtool: add kunit_try_catch_throw to the
 noreturn list
Message-ID: <20190710023123.ifnt5osimvzoe5hf@treble>
References: <20190709063023.251446-1-brendanhiggins@google.com>
 <20190709063023.251446-9-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190709063023.251446-9-brendanhiggins@google.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 10 Jul 2019 02:31:35 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 08, 2019 at 11:30:13PM -0700, Brendan Higgins wrote:
> Fix the following warning seen on GCC 7.3:
>   kunit/test-test.o: warning: objtool: kunit_test_unsuccessful_try() falls through to next function kunit_test_catch()
> 
> kunit_try_catch_throw is a function added in the following patch in this
> series; it allows KUnit, a unit testing framework for the kernel, to
> bail out of a broken test. As a consequence, it is a new __noreturn
> function that objtool thinks is broken (as seen above). So fix this
> warning by adding kunit_try_catch_throw to objtool's noreturn list.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Link: https://www.spinics.net/lists/linux-kbuild/msg21708.html
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> ---
>  tools/objtool/check.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 172f991957269..98db5fe85c797 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -134,6 +134,7 @@ static int __dead_end_function(struct objtool_file *file, struct symbol *func,
>  		"usercopy_abort",
>  		"machine_real_restart",
>  		"rewind_stack_do_exit",
> +		"kunit_try_catch_throw",
>  	};
>  
>  	if (func->bind == STB_WEAK)
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh
