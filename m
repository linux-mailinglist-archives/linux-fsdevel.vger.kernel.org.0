Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3582A3B2AA9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jun 2021 10:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhFXItT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Jun 2021 04:49:19 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54360 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhFXItS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Jun 2021 04:49:18 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 807FF1FD67;
        Thu, 24 Jun 2021 08:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624524418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wk6ST5cyENRzxS8gwOtJfNeloqq3+v5ssPqG3osnJgE=;
        b=VANKUxcgbmb1ncSSPP+/2xOJkd5PY+9dW6wKnQmIWUC0RGzW5yyczXY1YkMAM3Q23RzWYf
        iO3i2FG2J+6v09Bo74vRWyIHNaokZhEwuh4mCgbjE78ukP9DdBNmbs3IsSGKmRuRFBwCTH
        kf76LaGdYvo8NDRZTla7zw6ZCDSywfg=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C00EEA3BB2;
        Thu, 24 Jun 2021 08:46:57 +0000 (UTC)
Date:   Thu, 24 Jun 2021 10:46:56 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Justin He <Justin.He@arm.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>, nd <nd@arm.com>
Subject: Re: [PATCH v5 2/4] lib/vsprintf.c: make '%pD' print the full path of
 file
Message-ID: <YNRGgNOHUJp2vX0o@alley>
References: <20210622140634.2436-1-justin.he@arm.com>
 <20210622140634.2436-3-justin.he@arm.com>
 <YNH2OsDTokjY1vaa@smile.fi.intel.com>
 <AM6PR08MB4376D0AFBC0A4505280822FFF7089@AM6PR08MB4376.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR08MB4376D0AFBC0A4505280822FFF7089@AM6PR08MB4376.eurprd08.prod.outlook.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 2021-06-23 03:14:33, Justin He wrote:
> Hi Andy
> 
> > -----Original Message-----
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Sent: Tuesday, June 22, 2021 10:40 PM
> > To: Justin He <Justin.He@arm.com>
> > Cc: Petr Mladek <pmladek@suse.com>; Steven Rostedt <rostedt@goodmis.org>;
> > Sergey Senozhatsky <senozhatsky@chromium.org>; Rasmus Villemoes
> > <linux@rasmusvillemoes.dk>; Jonathan Corbet <corbet@lwn.net>; Alexander
> > Viro <viro@zeniv.linux.org.uk>; Linus Torvalds <torvalds@linux-
> > foundation.org>; Peter Zijlstra (Intel) <peterz@infradead.org>; Eric
> > Biggers <ebiggers@google.com>; Ahmed S. Darwish <a.darwish@linutronix.de>;
> > linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> > fsdevel@vger.kernel.org; Matthew Wilcox <willy@infradead.org>; Christoph
> > Hellwig <hch@infradead.org>; nd <nd@arm.com>
> > Subject: Re: [PATCH v5 2/4] lib/vsprintf.c: make '%pD' print the full path
> > of file
> > 
> > On Tue, Jun 22, 2021 at 10:06:32PM +0800, Jia He wrote:
> > > Previously, the specifier '%pD' is for printing dentry name of struct
> > > file. It may not be perfect (by default it only prints one component.)
> > >
> > > As suggested by Linus [1]:
> > 
> > Citing is better looked when you shift right it by two white spaces.
> 
> Okay, I plan to cite it with "> "

My understanding is that Andy suggested to omit '>' and prefix it by
plain two spaces "  ". It would look better to me as well.

Best Regards,
Petr
