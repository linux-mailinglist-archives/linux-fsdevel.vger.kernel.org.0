Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E184F54D8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 07:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiDFFO3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 01:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1585626AbiDFAAG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Apr 2022 20:00:06 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB4B5DE40;
        Tue,  5 Apr 2022 15:22:11 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 235MLeah002791
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 5 Apr 2022 18:21:40 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id DFA5915C3EB6; Tue,  5 Apr 2022 18:21:39 -0400 (EDT)
Date:   Tue, 5 Apr 2022 18:21:39 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
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
Message-ID: <YkzA8/3sl86W5oCX@mit.edu>
References: <20220321161557.495388-1-mic@digikod.net>
 <202204041130.F649632@keescook>
 <CAHk-=wgoC76v-4s0xVr1Xvnx-8xZ8M+LWgyq5qGLA5UBimEXtQ@mail.gmail.com>
 <816667d8-2a6c-6334-94a4-6127699d4144@digikod.net>
 <CAHk-=wjPuRi5uYs9SuQ2Xn+8+RnhoKgjPEwNm42+AGKDrjTU5g@mail.gmail.com>
 <202204041451.CC4F6BF@keescook>
 <CAHk-=whb=XuU=LGKnJWaa7LOYQz9VwHs8SLfgLbT5sf2VAbX1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whb=XuU=LGKnJWaa7LOYQz9VwHs8SLfgLbT5sf2VAbX1A@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 04, 2022 at 04:26:44PM -0700, Linus Torvalds wrote:
> > >     (a) "what about suid bits that user space cannot react to"
> >
> > What do you mean here? Do you mean setid bits on the file itself?
> 
> Right.
> 
> Maybe we don't care.
> 
> Maybe we do.
> 
> Is the user-space loader going to honor them? Is it going to ignore
> them? I don't know. And it actually interacts with things like
> 'nosuid', which the kernel does know about, and user space has a hard
> time figuring out.

So there *used* to be suidperl which was a setuid version of perl with
some extra security checks.  (See [1] for more details.)  The suidperl
binary would be used by #!/usr/bin/perl so it could honor setuid bits
on perl scripts, but it was deprecated in Perl 5.8 and removed in Perl
5.12 in 2010[2].

[1] https://mattmccutchen.net/suidperl.html
[2] https://metacpan.org/release/SHAY/perl-5.20.2/view/pod/perl5120delta.pod#Deprecations

So it's possible that the user-space loader might try to honor them,
and if there was such an example "in the field", it might be nice if
there was a way for the kernel to advise userspace about the nosuid.
But I'm not aware of any other shell script interpreter that tried do
what perl did with suidperl.

> So if the point is "give me an interface so that I can do the same
> thing a kernel execve() loader would do", then those sgid/suid bits
> actually may be exactly the kind of thing that user space wants the
> kernel to react to - should it ignore them, or should it do something
> special when it sees that they are set?
> 
> I'm not saying that they *should* be something we care about. All I'm
> saying is that I want that *discussion* to happen.

I'm not convinced we should.  I suppose *if* the shell script was
suid, *and* the file system was mounted nosuid, then the check could
return false, and that would be mostly harmless even if the script
interpreter didn't support setuid.  But it's extra complexity, and in
theory it could break a setuid script, where the setuid bit was
previously a no-op, and it now might cause a problem for that user.

	     	    	       	     	   - Ted
