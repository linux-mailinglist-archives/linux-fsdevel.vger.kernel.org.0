Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4835251AD38
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 May 2022 20:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377274AbiEDStn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 May 2022 14:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377241AbiEDStl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 May 2022 14:49:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3B4101DC;
        Wed,  4 May 2022 11:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Dn3HTp6KUp78ZFzWlHBYdXj5KOE/G4agBHq21Rs9ZcU=; b=q8P31BgeHM8LksWa1g6pVQGEev
        8H/7gSHdSIGf4hnUZNG6k+NP/eyDVuhEa+E/bIHsjVXN5T1EKYCJy7/bIZ2gwofMBVL0m04h906iy
        O3m6WyGqfypCYPOeFlE0zbL6KzH75Dt6yQynZ2YQb+tjQcvc8h0DNJLxPlj13yCZ/0fHhfWFYko29
        +mbPlaxqsXq8iB7o++eo7wHDCeL+pv7RLP4uld2Owm2FwNjROt2Nbdn7jgEo1D8SAnfFhVijf+4Ah
        2gPgRMk9OnlAr8zlq0l5QdnCMe8bwU9AhVy3E7SmAac3O5pVOrjuKc62H1lx2a7NKVVOWSVVV3BVX
        R0OH7blQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmK0f-00CBsb-2f; Wed, 04 May 2022 18:46:01 +0000
Date:   Wed, 4 May 2022 11:46:01 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
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
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v2] kunit: Taint kernel if any tests run
Message-ID: <YnLJ6dJQBTYjBRHZ@bombadil.infradead.org>
References: <20220429043913.626647-1-davidgow@google.com>
 <20220430030019.803481-1-davidgow@google.com>
 <Ym7P7mCoMiQq99EM@bombadil.infradead.org>
 <Ym7QXOMK3fLQ+b6t@bombadil.infradead.org>
 <CABVgOSmXyN3SrDkUt4y_TaKPvEGVJgbuE3ycrVDa-Kt1NFGH7g@mail.gmail.com>
 <YnKS3MwNxvEi73OP@bombadil.infradead.org>
 <CAGS_qxrz1WoUd5oGa7p1-H2mQVbkRxSTEbqnCG=aBj=xnMu1zQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGS_qxrz1WoUd5oGa7p1-H2mQVbkRxSTEbqnCG=aBj=xnMu1zQ@mail.gmail.com>
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

On Wed, May 04, 2022 at 11:25:14AM -0500, Daniel Latypov wrote:
> On Wed, May 4, 2022 at 9:51 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > selftests has modules, although I am not sure if there are selftests
> > which do not load modules. Shuah?
> 
> I'm not Shuah, but there are indeed selftests that don't load modules.
> 
> I went looking for an example and found
> tools/testing/selftests/bpf/test_doc_build.sh, which runs entirely in
> userspace (basically just `make docs`).

OK so, we can just skip tainting considerations for selftests which
don't use modules for now. There may be selftests which do wonky
things in userspace but indeed I agree the userspace taint would
be better for those but I don't think it may be worth bother
worrying about those at this point in time.

But my point in that sharing a taint between kunit / selftests modules
does make sense and is easily possible. The unfortunate aspect is just
that selftests don't have a centralized runner, because I can just
run tools/testing/selftests/sysctl/sysctl.sh for example and that's it.
So I think we have no other option but to just add the module info
manually for selftests at this time.

  Luis
