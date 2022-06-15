Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5396954C306
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jun 2022 10:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239848AbiFOICE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jun 2022 04:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiFOICD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jun 2022 04:02:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B2A4578B;
        Wed, 15 Jun 2022 01:02:01 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EB64B21B27;
        Wed, 15 Jun 2022 08:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655280119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DaM9M2rnjrvdQGQ7RvZB3kRvN0KL8OK3uY7jsfFlhwM=;
        b=qRtiw/EwzIsZzY7D7oh0BeOfU6iIQ38xDbUtfQXTtdaPPWK3B2vJeEb6IIHEt7MxZ3zKcC
        dfyx4Mc4tIb/eF0FliF28q8hNk+hU2TEYFUekYuM8cDMqgo0Awx7lmNgOzPGeK/9Q2qhBN
        CjKBFgcYgu+XVY7XBl81AW22w0F/oCg=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E39D82C142;
        Wed, 15 Jun 2022 08:01:57 +0000 (UTC)
Date:   Wed, 15 Jun 2022 10:01:57 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Maninder Singh <maninder1.s@samsung.com>, bcain@quicinc.com,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, satishkh@cisco.com,
        sebaddel@cisco.com, kartilak@cisco.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, mcgrof@kernel.org,
        jason.wessel@windriver.com, daniel.thompson@linaro.org,
        dianders@chromium.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        mhiramat@kernel.org, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        rostedt@goodmis.org, senozhatsky@chromium.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        akpm@linux-foundation.org, arnd@arndb.de,
        linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-modules@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net, v.narang@samsung.com,
        onkarnath.1@samsung.com
Subject: Re: [PATCH 0/5] kallsyms: make kallsym APIs more safe with scnprintf
Message-ID: <YqmR9ZeiwMQLyKDu@alley>
References: <CGME20220520083715epcas5p400b11adef4d540756c985feb20ba29bc@epcas5p4.samsung.com>
 <20220520083701.2610975-1-maninder1.s@samsung.com>
 <YonTOL4zC4CytVrn@infradead.org>
 <202205231238.FAF6D28@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202205231238.FAF6D28@keescook>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 2022-05-23 12:39:12, Kees Cook wrote:
> On Sat, May 21, 2022 at 11:07:52PM -0700, Christoph Hellwig wrote:
> > On Fri, May 20, 2022 at 02:06:56PM +0530, Maninder Singh wrote:
> > > kallsyms functionality depends on KSYM_NAME_LEN directly.
> > > but if user passed array length lesser than it, sprintf
> > > can cause issues of buffer overflow attack.
> > > 
> > > So changing *sprint* and *lookup* APIs in this patch set
> > > to have buffer size as an argument and replacing sprintf with
> > > scnprintf.
> > 
> > This is still a pretty horrible API.  Passing something like
> > a struct seq_buf seems like the much better API here.  Also with
> > the amount of arguments and by reference passing it might be worth
> > to pass them as a structure while you're at it.
> 
> Yeah, I agree. It really seems like seq_buf would be nicer.

There is a new patchset that is trying to use this kind of buffer
in vsprintf.

It introduces another buffer struct because vsprintf() needs a bit
different semantic than the one used in seq_buf. But it actually
replaces seq_buf() in the end. I am not sure if this is the right
approach.

Anyway, the initial API is very simple, see
https://lore.kernel.org/r/20220604193042.1674951-2-kent.overstreet@gmail.com

And it makes the internal vsprintf() API more sane, see
https://lore.kernel.org/r/20220604193042.1674951-4-kent.overstreet@gmail.com

It would eventually solve also concerns about the kallsysms API.
Any comments on the new printbuf API are much appreaciated.

Best Regards,
Petr
