Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E16A6E4421
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 11:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjDQJkV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 05:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjDQJjr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 05:39:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 145B9EE;
        Mon, 17 Apr 2023 02:39:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87E7FFEC;
        Mon, 17 Apr 2023 02:39:11 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.19.253])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D13D83F6C4;
        Mon, 17 Apr 2023 02:38:24 -0700 (PDT)
Date:   Mon, 17 Apr 2023 10:38:22 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Luca Vizzarro <Luca.Vizzarro@arm.com>,
        linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Theodore Ts'o <tytso@mit.edu>,
        David Laight <David.Laight@aculab.com>,
        linux-fsdevel@vger.kernel.org, linux-morello@op-lists.linaro.org
Subject: Re: [PATCH v2 1/5] fcntl: Cast commands with int args explicitly
Message-ID: <ZD0Tjk2oO8Ewj1nc@FVFF77S0Q05N>
References: <20230414152459.816046-1-Luca.Vizzarro@arm.com>
 <20230414152459.816046-2-Luca.Vizzarro@arm.com>
 <20230414154631.GK3390869@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414154631.GK3390869@ZenIV>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 14, 2023 at 04:46:31PM +0100, Al Viro wrote:
> On Fri, Apr 14, 2023 at 04:24:55PM +0100, Luca Vizzarro wrote:
> >  	void __user *argp = (void __user *)arg;
> > +	int argi = (int)arg;
> 
> Strictly speaking, conversion from unsigned long to int is
> an undefined behaviour, unless the value fits into the
> range representable by int ;-)
> 
> >  	case F_SETFD:
> >  		err = 0;
> > -		set_close_on_exec(fd, arg & FD_CLOEXEC);
> > +		set_close_on_exec(fd, argi & FD_CLOEXEC);
> 
> Why?
> 
> >  	case F_SETSIG:
> >  		/* arg == 0 restores default behaviour. */
> > -		if (!valid_signal(arg)) {
> > +		if (!valid_signal(argi)) {
> 
> Why???
> 
> >  			break;
> >  		}
> >  		err = 0;
> > -		filp->f_owner.signum = arg;
> > +		filp->f_owner.signum = argi;
> >  		break;
> 
> These two are clearly bogus and I'd like to see more details
> on the series rationale, please.

I agree the first isn't necessary, but I don't think the second is bogus, since
valid_signal() takes an unsigned long and the man page for F_SETSIG says that
the argument is an int:

  https://man7.org/linux/man-pages/man2/fcntl.2.html

... though arguably that could be a bug in the man page.

The cover letter really should have quoted the description that Szabolcs wote
at:

  https://lore.kernel.org/linux-api/Y1%2FDS6uoWP7OSkmd@arm.com/

The gist being that where the calling convention leaves narrowing to callees
(as is the case on arm64 with our "AAPCS64" calling convention), if the caller
passes a type which is narrower than a register, the upper bits of that
register may contain junk.

So e.g. for F_SETSIG, if the userspace will try to pass some 32-bit value,
leaving bits 63:32 of the argument register containing arbitrary junk. Then
here we interprert the value as an unsigned long, considering that junk as part
of the argument. Then valid_signal(arg) may end up rejecting the argument due
to the junk uper bits, which is surprising to the caller as from its PoV it
passed a 32-bit value in the correct way.

So either:

* That's a documentation bug, and userspce needs to treat the agument to
  F_SETSIG as an unsigned long.

* The kernel needs to narrow the argument to an int (if required by the calling
  convention) to prevent that.

Does that make sense, or have I missed the point you were making?

Thanks,
Mark.
