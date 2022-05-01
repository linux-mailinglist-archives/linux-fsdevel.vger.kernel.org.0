Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5AC516701
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 May 2022 20:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353593AbiEAS2A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 May 2022 14:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234718AbiEAS16 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 May 2022 14:27:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E0B56403;
        Sun,  1 May 2022 11:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=++0tXB8r6fqAoAWO0zn58LBjR0GxZ8Ui8yI9kV7Ql6c=; b=5Bvm25+pkmeLL5rMNrxHfplM7s
        uKg935xXJmaVLLztQS7lAaaumcfTsInHq0U3fp0FT/49AU/iugvoMPp7Ea3qOHNOyCfdpoH3vR0EC
        f2YSrPcQciYHpVw6Ms4xCNFi3SDZg2dGg3No6LR98z+5DajXjeQlFPOpno0chVBe7ChAk0qntgBFB
        6PpCt0ZbB1//y4zNnHabMq4ZeZnWZv29LszwS5klex7qmCWYQJ/hmQULdZRG30COu18Z4lbWo/WIA
        73Dfy97TxkjyMZaJeYaYl0NW0lqSv4ZbGKSERZqAsmCARqz+d+ccDFcYoUcux6UOKFd/KOq7BBh+N
        RJUiABXg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nlEFA-00Gh9I-PL; Sun, 01 May 2022 18:24:28 +0000
Date:   Sun, 1 May 2022 11:24:28 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Sebastian Reichel <sre@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Joe Fradley <joefradley@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v2] kunit: Taint kernel if any tests run
Message-ID: <Ym7QXOMK3fLQ+b6t@bombadil.infradead.org>
References: <20220429043913.626647-1-davidgow@google.com>
 <20220430030019.803481-1-davidgow@google.com>
 <Ym7P7mCoMiQq99EM@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ym7P7mCoMiQq99EM@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 01, 2022 at 11:22:38AM -0700, Luis Chamberlain wrote:
> On Sat, Apr 30, 2022 at 11:00:19AM +0800, David Gow wrote:
> > KUnit tests are not supposed to run on production systems: they may do
> > deliberately illegal things to trigger errors, and have security
> > implications (assertions will often deliberately leak kernel addresses).
> > 
> > Add a new taint type, TAINT_KUNIT to signal that a KUnit test has been
> > run. This will be printed as 'N' (for kuNit, as K, U and T were already
> > taken).
> > 
> > This should discourage people from running KUnit tests on production
> > systems, and to make it easier to tell if tests have been run
> > accidentally (by loading the wrong configuration, etc.)
> > 
> > Signed-off-by: David Gow <davidgow@google.com>
> 
> There is no reason to distinguish kunit from selftests if the result is
> the same: really make the kernel try really insane stupid things which
> may crash it or put it into a bad state.
> 
> So no, this should be renamed to "TEST_BREAK" as I think outside of
> selftest and kunit we may grow the kernel to do stupid things outside
> of that domain and this gives us the flexilibilty to use that in other
> places as well.
> 
> It begs the question if we *should* allow userspace to volunterally say
> "hey, we are doing really insane things, brace yourself." Why ? Well
> because selftest has tons of modules. We either then define a macro
> that adds the taint for them and wrap the module declaration for it,
> or we expose a syctl to let userspace volunteer to opt-in to seggest
> we are about to try something stupid with the kernel including loading
> some dangeerous modules which may not have macros which taint the kernel.
> That would let selftest taint on *any* selftest. Because we can run all
> selftests or run one selftest.
> 
> Then, if such sysctl is exposed, maybe we should then also use this for
> example for blktests, fstests, fio tests, etc.

For got to expand to fsdevel and linux-block.

  Luis
