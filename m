Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E12EC1C550
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2019 10:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfENIsm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 May 2019 04:48:42 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35050 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfENIsm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 May 2019 04:48:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6D6XPiWXHxqHbgGlzUb4e9FTkb9mj+8eXq8zwFhMaYI=; b=gQyJ4Bn+wwRdSW9t/2bWSVmyc
        AwkGokt1sRtEs0MFOzfvXdxNauIujIkO6DiCAA3SOTN0UFbrDi+SLIZripyW+aGfpCexFCP0BzvAH
        IlYP9j/H30eFgvgo9ZkFb3AKPBLsupHh7y68WZsbeVhh54K9lwJtSLIvcIDJS1VEaRQGKi/fVSfGS
        48zJdBoc3DzvL/pKKac0qDcALZBmcyi0ZeXu7FkhM4YyodyeuMGqq3ZAdBYQrpl3nrJxsVTrtSutJ
        0YkFNQHEEV1TPeoT3CoGRRj7cYr67v35O8QkZL1uGCglGPoJ5gpayGhWwv0+XlAiPH89k4GZ/Z81C
        usWzVhhCw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQT5N-0006we-E6; Tue, 14 May 2019 08:46:57 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 662E32029FD7A; Tue, 14 May 2019 10:46:55 +0200 (CEST)
Date:   Tue, 14 May 2019 10:46:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     frowand.list@gmail.com, gregkh@linuxfoundation.org,
        keescook@google.com, kieran.bingham@ideasonboard.com,
        mcgrof@kernel.org, robh@kernel.org, sboyd@kernel.org,
        shuah@kernel.org, tytso@mit.edu, yamada.masahiro@socionext.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com,
        dan.j.williams@intel.com, daniel@ffwll.ch, jdike@addtoit.com,
        joel@jms.id.au, julia.lawall@lip6.fr, khilman@baylibre.com,
        knut.omang@oracle.com, logang@deltatee.com, mpe@ellerman.id.au,
        pmladek@suse.com, rdunlap@infradead.org, richard@nod.at,
        rientjes@google.com, rostedt@goodmis.org, wfg@linux.intel.com,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v3 08/18] objtool: add kunit_try_catch_throw to the
 noreturn list
Message-ID: <20190514084655.GK2589@hirez.programming.kicks-ass.net>
References: <20190514054251.186196-1-brendanhiggins@google.com>
 <20190514054251.186196-9-brendanhiggins@google.com>
 <20190514065643.GC2589@hirez.programming.kicks-ass.net>
 <20190514081223.GA230665@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514081223.GA230665@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 14, 2019 at 01:12:23AM -0700, Brendan Higgins wrote:
> On Tue, May 14, 2019 at 08:56:43AM +0200, Peter Zijlstra wrote:
> > On Mon, May 13, 2019 at 10:42:42PM -0700, Brendan Higgins wrote:
> > > This fixes the following warning seen on GCC 7.3:
> > >   kunit/test-test.o: warning: objtool: kunit_test_unsuccessful_try() falls through to next function kunit_test_catch()
> > > 
> > 
> > What is that file and function; no kernel tree near me seems to have
> > that.
> 
> Oh, sorry about that. The function is added in the following patch,
> "[PATCH v3 09/18] kunit: test: add support for test abort"[1].
> 
> My apologies if this patch is supposed to come after it in sequence, but
> I assumed it should come before otherwise objtool would complain about
> the symbol when it is introduced.

Or send me all patches such that I have context, or have a sane
Changelog that gives me context. Just don't give me one patch with a
crappy changelog.
