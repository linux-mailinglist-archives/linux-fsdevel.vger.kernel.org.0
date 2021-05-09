Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A1737758F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 May 2021 06:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbhEIFAR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 May 2021 01:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhEIFAQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 May 2021 01:00:16 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F458C061573;
        Sat,  8 May 2021 21:59:13 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lfbWM-00CsoW-7J; Sun, 09 May 2021 04:58:26 +0000
Date:   Sun, 9 May 2021 04:58:26 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jia He <justin.he@arm.com>, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@ftp.linux.org.uk>,
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
Subject: Re: [PATCH RFC 1/3] fs: introduce helper d_path_fast()
Message-ID: <YJdr8g9j5XdW+Swl@zeniv-ca.linux.org.uk>
References: <20210508122530.1971-1-justin.he@arm.com>
 <20210508122530.1971-2-justin.he@arm.com>
 <CAHk-=wgSFUUWJKW1DXa67A0DXVzQ+OATwnC3FCwhqfTJZsvj1A@mail.gmail.com>
 <YJbivrA4Awp4FXo8@zeniv-ca.linux.org.uk>
 <CAHk-=whZhNXiOGgw8mXG+PTpGvxnRG1v5_GjtjHpoYXd2Fn_Ow@mail.gmail.com>
 <YJdG8LhKBoFayOc+@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJdG8LhKBoFayOc+@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 09, 2021 at 02:20:32AM +0000, Al Viro wrote:
> Umm...  Interesting, especially considering the way dyname_dname() looks like.
                                                      dynamic_dname(), obviously.

> Looks like there's a piece of prepend() open-coded in it.  And
> since all ->d_dname() instances are either simple_dname() or end up
> with call of dynamic_dname()...
> 
> Might make sense to turn that method into
> 	int (*d_dname)(struct dentry *, struct prepend_buffer *);
> 
> Followup patch, obviously, but it might be worth looking into.
> 
> Another thing that keeps bugging me about prepend_path() is the
> set of return values.  I mean, 0/1/2/3/-ENAMETOOLONG, and all
> except 0 are unlikely?  Might as well make that 0/1/2/3/-1, if
> not an outright 0/1/2/3/4.  And prepend() could return bool, while
> we are at it (true - success, false - overflow)...

OK...  I think I see how to carve it up sanely, will post after I
get some sleep.
