Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8B3E2EB4BF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jan 2021 22:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbhAEVNs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jan 2021 16:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbhAEVNr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jan 2021 16:13:47 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A492C061574;
        Tue,  5 Jan 2021 13:13:07 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kwtdF-007AYs-Vb; Tue, 05 Jan 2021 21:12:46 +0000
Date:   Tue, 5 Jan 2021 21:12:45 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        SElinux list <selinux@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: Re: [PATCH v4] proc: Allow pid_revalidate() during LOOKUP_RCU
Message-ID: <20210105211245.GY3579531@ZenIV.linux.org.uk>
References: <20210104232123.31378-1-stephen.s.brennan@oracle.com>
 <20210105055935.GT3579531@ZenIV.linux.org.uk>
 <20210105165005.GV3579531@ZenIV.linux.org.uk>
 <20210105195937.GX3579531@ZenIV.linux.org.uk>
 <CAHk-=wiP9EAP=JHGKG5LUCusVjVzTQoPVyweJkrX5dP=T_NxXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiP9EAP=JHGKG5LUCusVjVzTQoPVyweJkrX5dP=T_NxXw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 05, 2021 at 12:38:31PM -0800, Linus Torvalds wrote:

> This whole thing isn't important enough to get the dentry lock. It's
> more of a hint than anything else.
> 
> Why isn't the fix to just use READ_ONCE() of the name pointer, and do
> it under RCU?

Umm...  Take a look at audit_log_untrustedstring() - it really assumes
that string is not changing under it.  It could be massaged to be
resilent to such changes, and it's not even all that hard (copy the sucker
byte-by-byte, checking them for prohibited characters, with fallback
to hex dump if it finds one), but I really don't want to mess with
that for -stable and TBH I don't see the point - if the system is
spending enough time in spewing into audit for contention and/or
cacheline pingpong to matter, you are FUBAR anyway.

In this case dumber is better; sure, if it was just a string copy
with the accuracy in face of concurrent renames not guaranteed,
I'd be all for "let's see if we can just use %pd printf, or
go for open-coded analogue of such".  But here the lack of
whitespaces and quotes in the output is expected by userland
tools and that's more sensitive than the accuracy...

Again, if there's anybody seriously interested in analogue of
%pd with that (or some other) form of quoting, it could be done.
But I don't think it's a good idea for -stable and it obviously
can be done on top of the minimal race fix.
