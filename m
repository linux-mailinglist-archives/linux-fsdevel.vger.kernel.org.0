Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE694E5B31
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 23:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345209AbiCWWVw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Mar 2022 18:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241279AbiCWWVv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Mar 2022 18:21:51 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423B36A032;
        Wed, 23 Mar 2022 15:20:21 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 22NMJqTT003315
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Mar 2022 18:19:52 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id DEF6F15C0038; Wed, 23 Mar 2022 18:19:51 -0400 (EDT)
Date:   Wed, 23 Mar 2022 18:19:51 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [RFC PATCH] getvalues(2) prototype
Message-ID: <YjudB7XARLlRtBiR@mit.edu>
References: <20220322192712.709170-1-mszeredi@redhat.com>
 <20220323114215.pfrxy2b6vsvqig6a@wittgenstein>
 <CAJfpegsCKEx41KA1S2QJ9gX9BEBG4_d8igA0DT66GFH2ZanspA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsCKEx41KA1S2QJ9gX9BEBG4_d8igA0DT66GFH2ZanspA@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 23, 2022 at 02:24:40PM +0100, Miklos Szeredi wrote:
> The reason I stated thinking about this is that Amir wanted a per-sb
> iostat interface and dumped it into /proc/PID/mountstats.  And that is
> definitely not the right way to go about this.
> 
> So we could add a statfsx() and start filling in new stuff, and that's
> what Linus suggested.  But then we might need to add stuff that is not
> representable in a flat structure (like for example the stuff that
> nfs_show_stats does) and that again needs new infrastructure.
> 
> Another example is task info in /proc.  Utilities are doing a crazy
> number of syscalls to get trivial information.  Why don't we have a
> procx(2) syscall?  I guess because lots of that is difficult to
> represent in a flat structure.  Just take the lsof example: tt's doing
> hundreds of thousands of syscalls on a desktop computer with just a
> few hundred processes.

I'm still a bit puzzled about the reason for getvalues(2) beyond,
"reduce the number of system calls".  Is this a performance argument?
If so, have you benchmarked lsof using this new interface?

I did a quickie run on my laptop, which currently had 444 process.
"lsof /home/tytso > /tmp/foo" didn't take long:

% time lsof /home/tytso >& /tmp/foo
real    0m0.144s
user    0m0.039s
sys     0m0.087s

And an strace of that same lsof command indicated had 67,889 lines.
So yeah, lots of system calls.  But is this new system call really
going to speed up things by all that much?

If the argument is "make it easier to use", what's wrong the solution
of creating userspace libraries which abstract away calls to
open/read/close a whole bunch of procfs files to make life easier for
application programmers?

In short, what problem is this new system call going to solve?  Each
new system call, especially with all of the parsing that this one is
going to use, is going to be an additional attack surface, and an
additional new system call that we have to maintain --- and for the
first 7-10 years, userspace programs are going to have to use the
existing open/read/close interface since enterprise kernels stick a
wrong for a L-O-N-G time, so any kind of ease-of-use argument isn't
really going to help application programs until RHEL 10 becomes
obsolete.  (Unless you plan to backport this into RHEL 9 beta, but
still, waiting for RHEL 9 to become completely EOL is going to be... a
while.)  So whatever the benefits of this new interface is going to
be, I suggest we should be sure that it's really worth it.

Cheers,

					- Ted
