Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 919453B580E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jun 2021 06:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbhF1ERn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Jun 2021 00:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhF1ERn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Jun 2021 00:17:43 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEA9C061574;
        Sun, 27 Jun 2021 21:15:17 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxiep-00D82O-5c; Mon, 28 Jun 2021 04:14:03 +0000
Date:   Mon, 28 Jun 2021 04:14:03 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Justin He <Justin.He@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 13/14] d_path: prepend_path() is unlikely to return
 non-zero
Message-ID: <YNlMi80b8bpY1ZHk@zeniv-ca.linux.org.uk>
References: <YKRfI29BBnC255Vp@zeniv-ca.linux.org.uk>
 <20210519004901.3829541-1-viro@zeniv.linux.org.uk>
 <20210519004901.3829541-13-viro@zeniv.linux.org.uk>
 <AM6PR08MB43762B63D11A43FE84849748F7069@AM6PR08MB4376.eurprd08.prod.outlook.com>
 <YNYZTIP+anazsz/U@zeniv-ca.linux.org.uk>
 <AM6PR08MB43769E57C213CD2C92476F2CF7039@AM6PR08MB4376.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR08MB43769E57C213CD2C92476F2CF7039@AM6PR08MB4376.eurprd08.prod.outlook.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 28, 2021 at 03:28:19AM +0000, Justin He wrote:

> > On which loads?  1 here is "mount/dentry pair is in somebody
> > else's namespace or outside of the subtree we are chrooted
> > into".  IOW, what's calling d_path() on your setup?
> 
> No special loads, merely collecting the results after kernel boots up.
> 
> To narrow down, I tested your branch [1] *without* my '%pD' series:
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/log/?h=work.d_path
> 
> The result is the same after kernel boots up.

IOW, you get 1 in call from d_absolute_path().  And the same commit has
-       if (prepend_path(path, &root, &b) > 1)
+       if (unlikely(prepend_path(path, &root, &b) > 1))
there.  What's the problem?

If you want to check mispredictions, put printks at the statements
under those if (unlikely(...)) and see how often do they trigger...
