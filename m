Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C79B51B02E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 May 2022 23:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378518AbiEDVQO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 May 2022 17:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238438AbiEDVQM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 May 2022 17:16:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA5F4A92C;
        Wed,  4 May 2022 14:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yqErQjmS+bnUS13HloDHpaivj9GT+Qdx14G8nSP6Cog=; b=qd8R7nTQdEKUrp5XQwz8zr0tax
        LPOrH0DhAKEN9lLc/py2/4c+i94bgjTT8Z40U95XqlVChQAHQ9BBmkBrXX+nIUy9NHDlkPINMdAqN
        zq8vsIDGMxMCUOWxdegzbmmIZ26ZPJ6R/iVLKsB/jQ0aDic8qdT+14tNt32smVnbFdiqDxwB2zADN
        3mDOsk0AK4hyt4InvnhTeLItp3d/5nVvbcqNWdKfnSAoyfivSjocwCtsu8M79pIOoW/5oCB5gsnle
        JBCLIoK7rdonK5qoHipzIwFHMv9DC5MJ84zgFNw9Mda0x1SdGcydIzf37GfjwHGKjKUlNvRDlSUE2
        CYabBD0A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmMIQ-00CkOY-PP; Wed, 04 May 2022 21:12:30 +0000
Date:   Wed, 4 May 2022 14:12:30 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
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
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v2] kunit: Taint kernel if any tests run
Message-ID: <YnLsPgbQ7CHiannN@bombadil.infradead.org>
References: <20220429043913.626647-1-davidgow@google.com>
 <20220430030019.803481-1-davidgow@google.com>
 <Ym7P7mCoMiQq99EM@bombadil.infradead.org>
 <Ym7QXOMK3fLQ+b6t@bombadil.infradead.org>
 <CABVgOSmXyN3SrDkUt4y_TaKPvEGVJgbuE3ycrVDa-Kt1NFGH7g@mail.gmail.com>
 <YnKS3MwNxvEi73OP@bombadil.infradead.org>
 <CAGS_qxrz1WoUd5oGa7p1-H2mQVbkRxSTEbqnCG=aBj=xnMu1zQ@mail.gmail.com>
 <YnLJ6dJQBTYjBRHZ@bombadil.infradead.org>
 <CAGS_qxoFECVJD3Jby1eTWG741hBWuotuEM78PU-qfyvp-nLV7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGS_qxoFECVJD3Jby1eTWG741hBWuotuEM78PU-qfyvp-nLV7Q@mail.gmail.com>
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

On Wed, May 04, 2022 at 02:19:59PM -0500, Daniel Latypov wrote:
> On Wed, May 4, 2022 at 1:46 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > OK so, we can just skip tainting considerations for selftests which
> > don't use modules for now. There may be selftests which do wonky
> > things in userspace but indeed I agree the userspace taint would
> > be better for those but I don't think it may be worth bother
> > worrying about those at this point in time.
> >
> > But my point in that sharing a taint between kunit / selftests modules
> > does make sense and is easily possible. The unfortunate aspect is just
> 
> Yes, I 100% agree that we should share a taint for kernelspace testing
> from both kunit/kselftest.
> Someone running the system won't care what framework was used.

OK do you mind doing the nasty work of manually adding the new
MODULE_TAINT() to the selftests as part of your effort?

*Alternatively*, if we *moved* all sefltests modules to a new
lib/debug/selftests/ directory or something like that then t would
seem modpost *could* add the taint flag automagically for us without
having to edit or require it on new drivers. We have similar type of
taint for staging, see add_staging_flag().

I would *highly* prefer this approach, event though it is more work,
because I think this is a step we should take anyway.

However, I just checked modules on lib/ and well, some of them are
already in their own directory, like lib/math/test_div64.c. So not
sure, maybe just move a few modules which are just in lib/*.c for now
and then just sprinkle the MODULE_TAINT() to the others?

> > that selftests don't have a centralized runner, because I can just
> > run tools/testing/selftests/sysctl/sysctl.sh for example and that's it.
> > So I think we have no other option but to just add the module info
> > manually for selftests at this time.
> 
> Somewhat tangential: there's a number of other test modules that
> aren't explicitly part of kselftest.

Oh interesting, like which one?

> Long-term, I think most of them should be converted to kselftest or
> kunit as appropriate, so they'll get taken care of eventually.

Makes sense.

  Luis
