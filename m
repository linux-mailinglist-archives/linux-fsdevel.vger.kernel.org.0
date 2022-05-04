Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910DD51A294
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 May 2022 16:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351666AbiEDOy5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 May 2022 10:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351497AbiEDOyz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 May 2022 10:54:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F0A2250C;
        Wed,  4 May 2022 07:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=S2gb7XqGVCua1J4ObYPWqu6oqDz0D+gONZmwmSAT5u0=; b=yohmkVdc1HEiFErskoUX3A88MC
        imI16VZWdSN1NTiGoZm/E0P67fi6koEUXubQBJY5SMenScgAKEU8IhyJ1qXu7PHbs5zZtofExsIYV
        wsfQQ38SL//vc+P8mculJsju6c6L2nxtUL8VD+B51YnznAu5BuIDA82AfmAqHmmAb7nqMvC4YwCZv
        6yGeRvKMURbJ8Sjyr5jiMwPrRxX60f7OUv9gxVdXzm5N6Ee4z6Ip5EhD3bjGdqxz/gujGyNF2cOx+
        07kbDv6ERZSybEInGCSvByWav8AC60xD5LHHHUrDhVcyTIrGpTJuRu7PISjPO5k5yUvd8gMOyobAw
        NZKz4eOw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmGLM-00BIQY-Kf; Wed, 04 May 2022 14:51:08 +0000
Date:   Wed, 4 May 2022 07:51:08 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
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
Message-ID: <YnKS3MwNxvEi73OP@bombadil.infradead.org>
References: <20220429043913.626647-1-davidgow@google.com>
 <20220430030019.803481-1-davidgow@google.com>
 <Ym7P7mCoMiQq99EM@bombadil.infradead.org>
 <Ym7QXOMK3fLQ+b6t@bombadil.infradead.org>
 <CABVgOSmXyN3SrDkUt4y_TaKPvEGVJgbuE3ycrVDa-Kt1NFGH7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOSmXyN3SrDkUt4y_TaKPvEGVJgbuE3ycrVDa-Kt1NFGH7g@mail.gmail.com>
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

On Tue, May 03, 2022 at 02:49:58PM +0800, David Gow wrote:
> On Mon, May 2, 2022 at 2:24 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Sun, May 01, 2022 at 11:22:38AM -0700, Luis Chamberlain wrote:
> > > On Sat, Apr 30, 2022 at 11:00:19AM +0800, David Gow wrote:
> > > > KUnit tests are not supposed to run on production systems: they may do
> > > > deliberately illegal things to trigger errors, and have security
> > > > implications (assertions will often deliberately leak kernel addresses).
> > > >
> > > > Add a new taint type, TAINT_KUNIT to signal that a KUnit test has been
> > > > run. This will be printed as 'N' (for kuNit, as K, U and T were already
> > > > taken).
> > > >
> > > > This should discourage people from running KUnit tests on production
> > > > systems, and to make it easier to tell if tests have been run
> > > > accidentally (by loading the wrong configuration, etc.)
> > > >
> > > > Signed-off-by: David Gow <davidgow@google.com>
> > >
> > > There is no reason to distinguish kunit from selftests if the result is
> > > the same: really make the kernel try really insane stupid things which
> > > may crash it or put it into a bad state.
> > >
> My initial thought is that KUnit is explicitly in-kernel testing,
> whereas kselftest is (at least somewhat) user-space based.

selftests has modules, although I am not sure if there are selftests
which do not load modules. Shuah?

> My personal
> feeling is that "doing weird stuff from userspace" is fundamentally
> different from "doing weird stuff in the kernel".

True.

> That being said, in
> practice many kselftest tests load modules which do strange things,
> and those could be in scope for something like that. I'd still err on
> the side of only having those tests (or specifically those modules)
> add the taint, rather than all selftests, but could be conveniced.

Yeah I think now that this can easily be added by having a special
new module info, MODULE_TAINTS(taint_flag). Then in check_modinfo()
you'd get_modinfo(info, "taints") to then add_taint_module() if set.

We can ignore the userspace thing I mentioned earlier as I thought
at first we could not add the taint to selftest modules easily but
we can.

  Luis
