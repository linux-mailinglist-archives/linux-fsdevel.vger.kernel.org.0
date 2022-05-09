Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD26952061C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 22:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiEIUrn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 16:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiEIUrl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 16:47:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36153B1D3;
        Mon,  9 May 2022 13:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zxtHEZB7FJXcLD4uWhqlrNQfKLg4uYSZS3iQcpPv3Q8=; b=Um4T745eraA4H0ZgNxS0pk18PZ
        Xq97mepNxGxMSUjCP+wxeGnaWEH5/cdZnQBcwwp/nYhhVo0LZ0izp4JI5JLx/tuGEZhpgwmnCpwbf
        2txDSDfzQXZuX51PS3ujK++12T6SuqFqyX9iHBdzrIXBEwXzKGUPjXBHtkEGWls89KE/8klzoNmKc
        OtRsmT+7lqC9xf9aTPvk9a7bUeFPBORXhMxzsTl8lnLlgwKsSrZfIa7TmD/4zQ2C9RPd7NtoZqmth
        dF3gybOaVG6RP99mI4FvocGXiSQrwuUY58gBdt2p0lR6Ir2l99ABzRmYO+DKAJ8vfOhqZfu0Trp+2
        2ega45ZQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1noAEG-00GCg8-KP; Mon, 09 May 2022 20:43:40 +0000
Date:   Mon, 9 May 2022 13:43:40 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     David Gow <davidgow@google.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
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
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v2] kunit: Taint kernel if any tests run
Message-ID: <Ynl8/MqmDZzpbh5y@bombadil.infradead.org>
References: <Ym7P7mCoMiQq99EM@bombadil.infradead.org>
 <Ym7QXOMK3fLQ+b6t@bombadil.infradead.org>
 <CABVgOSmXyN3SrDkUt4y_TaKPvEGVJgbuE3ycrVDa-Kt1NFGH7g@mail.gmail.com>
 <YnKS3MwNxvEi73OP@bombadil.infradead.org>
 <CAGS_qxrz1WoUd5oGa7p1-H2mQVbkRxSTEbqnCG=aBj=xnMu1zQ@mail.gmail.com>
 <YnLJ6dJQBTYjBRHZ@bombadil.infradead.org>
 <CAGS_qxoFECVJD3Jby1eTWG741hBWuotuEM78PU-qfyvp-nLV7Q@mail.gmail.com>
 <YnLsPgbQ7CHiannN@bombadil.infradead.org>
 <YnNnLIZDxkNwECv+@bombadil.infradead.org>
 <CABVgOS=8=41KgVEgRAGcDZ_JrZpsVaK24ca0jR5J74XY9GCmDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOS=8=41KgVEgRAGcDZ_JrZpsVaK24ca0jR5J74XY9GCmDA@mail.gmail.com>
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

On Fri, May 06, 2022 at 03:01:34PM +0800, David Gow wrote:
> On Thu, May 5, 2022 at 1:57 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Wed, May 04, 2022 at 02:12:30PM -0700, Luis Chamberlain wrote:
> > > On Wed, May 04, 2022 at 02:19:59PM -0500, Daniel Latypov wrote:
> > > > On Wed, May 4, 2022 at 1:46 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > > > > OK so, we can just skip tainting considerations for selftests which
> > > > > don't use modules for now. There may be selftests which do wonky
> > > > > things in userspace but indeed I agree the userspace taint would
> > > > > be better for those but I don't think it may be worth bother
> > > > > worrying about those at this point in time.
> > > > >
> > > > > But my point in that sharing a taint between kunit / selftests modules
> > > > > does make sense and is easily possible. The unfortunate aspect is just
> > > >
> > > > Yes, I 100% agree that we should share a taint for kernelspace testing
> > > > from both kunit/kselftest.
> > > > Someone running the system won't care what framework was used.
> > >
> > > OK do you mind doing the nasty work of manually adding the new
> > > MODULE_TAINT() to the selftests as part of your effort?
> > >
> > > *Alternatively*, if we *moved* all sefltests modules to a new
> > > lib/debug/selftests/ directory or something like that then t would
> > > seem modpost *could* add the taint flag automagically for us without
> > > having to edit or require it on new drivers. We have similar type of
> > > taint for staging, see add_staging_flag().
> > >
> > > I would *highly* prefer this approach, event though it is more work,
> > > because I think this is a step we should take anyway.
> > >
> > > However, I just checked modules on lib/ and well, some of them are
> > > already in their own directory, like lib/math/test_div64.c. So not
> > > sure, maybe just move a few modules which are just in lib/*.c for now
> > > and then just sprinkle the MODULE_TAINT() to the others?
> >
> > I *think* we could just pull this off with a much easier approach,
> > simply looking for the substrings in the module name in modpost.c:
> >
> >   * "_test." || "-test."
> >   * ^"test_" || ^"test-"
> >
> > An issue with this of course is a vendor $FOO with an out of tree
> > test driver may end up with the taint. Perhaps we don't care.
> >
> > That means moving selftests to its own directory is not needed at this
> > point in time.
> 
> I can't say I'm thrilled with the idea of just doing name comparisons,
> particularly since not all of them match this pattern, for example:
> bpf_testmod.ko. (Though, frankly, more of them do than I'd've
> guessed.)
> 
> Maybe adding a taint call to the selftest helper module framework in
> kselftest_module.h, though again, there are several tests which don't
> use it.

Right, I can't think of a generic way to peg this. I think long term
we do stand to gain to move all selftests under a lib/debug/selftests/
or something like that, but for now what I suggested is the only thing
I can come up with.

> I _suspect_ we'd be able to hit most of them by tainting in frameworks
> like the above, and patch the remaining modules manually.

Works with me.

> There's also
> definitely a grey area with things like netdevsim, which are used a
> lot as helper modules by selftests, but may have other uses as well.

They can peg the module if they want the taint.

> (The advantage of the KUnit tainting is that, due to KUnit's
> centralised executor, we can be sure all KUnit tests will correctly
> trigger the taint. But maybe it doesn't matter as much if one or two
> selftests miss out.)

That is what I was thinking.

I'm convinced we *should* move selftests to a one directory. The
amount of stuff in lib/ is getting out of hand.

  Luis
