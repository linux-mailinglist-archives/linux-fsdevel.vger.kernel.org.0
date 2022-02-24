Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665484C2E03
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 15:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235378AbiBXOQ0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 09:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbiBXOQ0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 09:16:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47602294FFF;
        Thu, 24 Feb 2022 06:15:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3D27B82603;
        Thu, 24 Feb 2022 14:15:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46281C340E9;
        Thu, 24 Feb 2022 14:15:52 +0000 (UTC)
Date:   Thu, 24 Feb 2022 09:15:50 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Eric Biederman <ebiederm@xmission.com>,
        David Gow <davidgow@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Magnus =?UTF-8?B?R3Jvw58=?= <magnus.gross@rwth-aachen.de>,
        kunit-dev@googlegroups.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] binfmt_elf: Introduce KUnit test
Message-ID: <20220224091550.2b7e8784@gandalf.local.home>
In-Reply-To: <202202232208.B416701@keescook>
References: <20220224054332.1852813-1-keescook@chromium.org>
        <CAGS_qxp8cjG5jCX-7ziqHcy2gq_MqL8kU01-joFD_W9iPG08EA@mail.gmail.com>
        <202202232208.B416701@keescook>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 23 Feb 2022 22:13:25 -0800
Kees Cook <keescook@chromium.org> wrote:

> Steven, I want to do fancy live-patch kind or things to replace functions,
> but it doesn't need to be particularly fancy because KUnit tests (usually)
> run single-threaded, etc. It looks like kprobes could almost do it, but
> I don't see a way to have it _avoid_ making a function call.


// This is called just before the hijacked function is called
static void notrace my_tramp(unsigned long ip, unsigned long parent_ip,
			     struct ftrace_ops *ops,
			     struct ftrace_regs *fregs)
{
	int bit;

        bit = ftrace_test_recursion_trylock(ip, parent_ip);
        if (WARN_ON_ONCE(bit < 0))
                return;

	/*
	 * This uses the live kernel patching arch code to now return
	 * to new_function() instead of the one that was called.
	 * If you want to do a lookup, you can look at the "ip"
	 * which will give you the function you are about to replace.
	 * Note, it may not be equal to the function address,
	 * but for that, you can have this:
	 *   ip = ftrace_location(function_ip);
	 * which will give the ip that is passed here.
	 */
	klp_arch_set_pc(fregs, new_function);

	ftrace_test_recursion_unlock(bit);	
}

static struct ftrace_ops my_ops = {
	.func		= my_tramp;
	.flags		= FTRACE_OPS_FL_IPMODIFY |
#ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
			  FTRACE_OPS_FL_SAVE_REGS |
#endif
			  FTRACE_OPS_FL_DYNAMIC;
};

// Assuming you know the function ip you want to hijack
register_my_kutest_ip(unsigned long func_ip)
{
	unsigned long ip;
	int ret;

	ip = ftrace_location(func_ip);
	if (!ip) // not a ftrace function?
		return;

	ret = ftrace_set_filter_ip(&my_ops, ip, 0, 0);
	if (ret < 0)
		return;

	// you can register more than one ip if the last parameter
	// is zero (1 means to reset the list)

	ret = register_ftrace_function(&my_ops);
	if (ret < 0)
		return;
}

That's pretty much it. Note, I did not compile nor test the above, so there
may be some mistakes.

For more information about how to use ftrace, see

  Documentation/trace/ftrace-uses.rst

Which should probably get a section on how to do kernel patching.

-- Steve
