Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56F24F4D51
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 03:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581897AbiDEXlV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Apr 2022 19:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1452408AbiDEPyx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:54:53 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83891177;
        Tue,  5 Apr 2022 07:55:03 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 235EsMot006873
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 5 Apr 2022 10:54:23 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 9237D15C3EB6; Tue,  5 Apr 2022 10:54:22 -0400 (EDT)
Date:   Tue, 5 Apr 2022 10:54:22 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Heimes <christian@python.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Morris <jmorris@namei.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Paul Moore <paul@paul-moore.com>,
        Philippe =?iso-8859-1?Q?Tr=E9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Steve Dower <steve.dower@python.org>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [GIT PULL] Add trusted_for(2) (was O_MAYEXEC)
Message-ID: <YkxYHqLqTEKFrCeg@mit.edu>
References: <20220321161557.495388-1-mic@digikod.net>
 <202204041130.F649632@keescook>
 <CAHk-=wgoC76v-4s0xVr1Xvnx-8xZ8M+LWgyq5qGLA5UBimEXtQ@mail.gmail.com>
 <816667d8-2a6c-6334-94a4-6127699d4144@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <816667d8-2a6c-6334-94a4-6127699d4144@digikod.net>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 04, 2022 at 10:30:13PM +0200, Mickaël Salaün wrote:
> > If you add a new X_OK variant to access(), maybe that could fly.
> 
> As answered in private, that was the approach I took for one of the early
> versions but a dedicated syscall was requested by Al Viro:
> https://lore.kernel.org/r/2ed377c4-3500-3ddc-7181-a5bc114ddf94@digikod.net
> The main reason behind this request was that it doesn't have the exact same
> semantic as faccessat(2). The changes for this syscall are documented here:
> https://lore.kernel.org/all/20220104155024.48023-3-mic@digikod.net/
> The whole history is linked in the cover letter:
> https://lore.kernel.org/all/2ed377c4-3500-3ddc-7181-a5bc114ddf94@digikod.net/

As a suggestion, something that can be helpful for something which has
been as heavily bike-sheded as this concept might be to write a
"legislative history", or perhaps, a "bike shed history".

And not just with links to mailing list discussions, but a short
summary of why, for example, we moved from the open flag O_MAYEXEC to
the faccessat(2) approach.  I looked, but I couldn't find the
reasoning while diving into the mail archives.  And there was some
kind of request for some new functionality for IMA and other LSM's
that I couldn't follow that is why the new AT_INTERETED flag, but at
this point my time quantuum for mailing list archeology most
definitely expired.  :-)

It might be that when all of this is laid out, we can either revisit
prior design decisions as "that bike-shed request to support this
corner case was unreasonable", or "oh, OK, this is why we need as
fully general a solution as this".

Also, some of examples of potential future use cases such as "magic
links" that were linked in the cover letter, it's not clear to me
actually make sense in the context of a "trusted for" system call
(although might make more sense in the context of an open flag).  So
revisiting some of those other cases to see whether they actually
*could* be implemented as new "TRUSTED_FOR" flags might be
instructive.

Personally, I'm a bit skeptical about the prospct of additional use
cases, since trusted_for(2) is essentially a mother_should_I(2)
request where userspace is asking the kernel whether they should go
ahead and do some particular policy thing.  And it's not clear to me
how many of these policy questions exist where (a) the kernel is in
the past position to answer that question, and (b) there isn't some
additional information that the kernel doesn't have that might be
needed to answer that question.

For example, "Mother should I use that private key file" might require
information about whether the SRE is currently on pager duty or not,
at least for some policies, and the kernel isn't going to have that
information.

Other examples of TRUSTED_FOR flags that really make sense and would
be useful might help alleviate my skepticsm.  And the "bike shed
history" would help with my question about why some folks didn't like
the original O_MAYEXEC flag?

Cheers,

					- Ted
