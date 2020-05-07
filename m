Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 777EF1C9E30
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 00:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgEGWG1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 18:06:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28128 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726470AbgEGWG0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 18:06:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588889184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O0zq6BKZdqRzSQ4IajAdIW2yn8DScQjo8LRrUKBrr9w=;
        b=S2RWrUkyiIswHIP+mNFAdzXCkK/QI2i0CLiAzucBAWOh/WCLTlXfcg8A/kclgfMnU0rEvS
        WxHWOBzRfp8eqIUzHH+5ofw/NDU9Zv2vtjvezVloXqi840+OisW11jVAfy/Qewfaqs2T6Z
        X2zBwRqag6ASLB2OZGdVF6pxu/9x9Sc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-N6yridzlO2exTfgZLy4BXQ-1; Thu, 07 May 2020 18:06:22 -0400
X-MC-Unique: N6yridzlO2exTfgZLy4BXQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B490C800688;
        Thu,  7 May 2020 22:06:19 +0000 (UTC)
Received: from optiplex-lnx (unknown [10.3.128.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B81C5D9C5;
        Thu,  7 May 2020 22:06:09 +0000 (UTC)
Date:   Thu, 7 May 2020 18:06:06 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Tso Ted <tytso@mit.edu>, Adrian Bunk <bunk@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laura Abbott <labbott@redhat.com>,
        Jeff Mahoney <jeffm@suse.com>, Jiri Kosina <jikos@kernel.org>,
        Jessica Yu <jeyu@suse.de>, Takashi Iwai <tiwai@suse.de>,
        Ann Davis <AnDavis@suse.com>,
        Richard Palethorpe <rpalethorpe@suse.de>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        dyoung@redhat.com, bhe@redhat.com, corbet@lwn.net,
        keescook@chromium.org, akpm@linux-foundation.org, cai@lca.pw,
        rdunlap@infradead.org
Subject: Re: [PATCH v2] kernel: add panic_on_taint
Message-ID: <20200507220606.GK205881@optiplex-lnx>
References: <20200507180631.308441-1-aquini@redhat.com>
 <20200507182257.GX11244@42.do-not-panic.com>
 <20200507184307.GF205881@optiplex-lnx>
 <20200507184705.GG205881@optiplex-lnx>
 <20200507203340.GZ11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507203340.GZ11244@42.do-not-panic.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 07, 2020 at 08:33:40PM +0000, Luis Chamberlain wrote:
> On Thu, May 07, 2020 at 02:47:05PM -0400, Rafael Aquini wrote:
> > On Thu, May 07, 2020 at 02:43:16PM -0400, Rafael Aquini wrote:
> > > On Thu, May 07, 2020 at 06:22:57PM +0000, Luis Chamberlain wrote:
> > > > On Thu, May 07, 2020 at 02:06:31PM -0400, Rafael Aquini wrote:
> > > > > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > > > > index 8a176d8727a3..b80ab660d727 100644
> > > > > --- a/kernel/sysctl.c
> > > > > +++ b/kernel/sysctl.c
> > > > > @@ -1217,6 +1217,13 @@ static struct ctl_table kern_table[] = {
> > > > >  		.extra1		= SYSCTL_ZERO,
> > > > >  		.extra2		= SYSCTL_ONE,
> > > > >  	},
> > > > > +	{
> > > > > +		.procname	= "panic_on_taint",
> > > > > +		.data		= &panic_on_taint,
> > > > > +		.maxlen		= sizeof(unsigned long),
> > > > > +		.mode		= 0644,
> > > > > +		.proc_handler	= proc_doulongvec_minmax,
> > > > > +	},
> > > > 
> > > > You sent this out before I could reply to the other thread on v1.
> > > > My thoughts on the min / max values, or lack here:
> > > >                                                                                 
> > > > Valid range doesn't mean "currently allowed defined" masks.                     
> > > > 
> > > > For example, if you expect to panic due to a taint, but a new taint type
> > > > you want was not added on an older kernel you would be under a very
> > > > *false* sense of security that your kernel may not have hit such a
> > > > taint, but the reality of the situation was that the kernel didn't
> > > > support that taint flag only added in future kernels.                           
> > > > 
> > > > You may need to define a new flag (MAX_TAINT) which should be the last
> > > > value + 1, the allowed max values would be                                      
> > > > 
> > > > (2^MAX_TAINT)-1                                                                 
> > > > 
> > > > or                                                                              
> > > > 
> > > > (1<<MAX_TAINT)-1  
> > > > 
> > > > Since this is to *PANIC* I think we do want to test ranges and ensure
> > > > only valid ones are allowed.
> > > >
> > > 
> > > Ok. I'm thinking in:
> > > 
> > > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > > index 8a176d8727a3..ee492431e7b0 100644
> > > --- a/kernel/sysctl.c
> > > +++ b/kernel/sysctl.c
> > > @@ -1217,6 +1217,15 @@ static struct ctl_table kern_table[] = {
> > >                 .extra1         = SYSCTL_ZERO,
> > >                 .extra2         = SYSCTL_ONE,
> > >         },
> > > +       {
> > > +               .procname       = "panic_on_taint",
> > > +               .data           = &panic_on_taint,
> > > +               .maxlen         = sizeof(unsigned long),
> > > +               .mode           = 0644,
> > > +               .proc_handler   = proc_doulongvec_minmax,
> > > +               .extra1         = SYSCTL_ZERO,
> > > +               .extra2         = (1 << TAINT_FLAGS_COUNT << 1) - 1,
> > 							^^^^^^^^
> > Without that crap, obviously. Sorry. That was a screw up on my side,
> > when copyin' and pasting.
> 
> I really think that the implications of this needs a bit further review,
> hence the wider CCs.
> 
> Since this can trivially crash a system, I think we need to be careful
> about this value. First, proc_doulongvec_minmax() will not suffice alone,
> we'll *at least* want to check for capable(CAP_SYS_ADMIN)) as in
> proc_taint().  Second first note that we *always* build proc_taint(), if
> just CONFIG_PROC_SYSCTL is enabled. That has been the way since it got
> merged via commit 34f5a39899f3f ("Add TAINT_USER and ability to set
> taint flags from userspace") since v2.6.21. We need to evaluate if this
> little *new* knob you are introducing merits its own kconfig tucked away
> under debugging first. The ship has already sailed for proc_taint().
> Anyone with CAP_SYS_ADMIN can taint.
> 
> The good thing is that proc_taint() added its own TAINT_USER, *but*, hey
> it didn't use it. A panic-on-taint system would be able to tell if a
> panic was caused by proc_taint() throught the stack trace only. 
> If panic-on-taint proc was used *later* after a custom taint was set
> or happened naturally, no panic would trigger since your panic-on-taint
> check on your patch only happens on add_taint(). This means that for
> those thinking about using this for QA or security purposes, the only
> sensible *reliable* way to use panic-on-taint would be through cmdline,
> from boot. Post-boot means to enable this would either need to check
> existing taint flags, or we'd want to a way to check if this was not
> added post boot. Also, a post-booteed system with panic-on-taint could
> easily allow for reductions of the intended goal, thereby allowing one
> to cheat.
> 
> I think a new TAINT_MODIFIED for use when proc_taint() is used is worth
> considering. Ted? Even though 'M' is taken -- I think its silly to rely
> on the character to be anything of meaning, once we run out of the
> alphabet letters that will be the way anyway, unless we-redo this a bit.
> Note we use value for when this is on and off, typically an empty space
> when a taint is not seen.
> 
> The good thing is that proc_taint() only *increments* taint, it doesn't
> remove taints.
> 
> Are we OK with panic-on-taint only with CAP_SYS_ADMIN?
> 
> I can see this building up to a "testing" solution to ensure / gaurantee
> no bugs have happened during QA, but since QA would want the same binary
> for production it is hard to see this enabled for QA but not production.
> To resolve that last concern, if we do go with moving this under a
> kconfig value, a simple cmdline append would address the concerns. Ie,
> even if you enabled this mechanism through its kconfig you would not be
> able to modify the panic-on-tain unless you passed a cmdline option.
> 
> Note that Vlastimil has some patches which are visible on linux-next,
> but not yet merged on Linus' tree, which enable these params to be set
> on the cmdline too now, so perhaps yet-another cmdline param is not
> needed anymore.
> 
> I *think* that a cmdline route to enable this would likely remove the
> need for the kernel config for this. But even with Vlastimil's work
> merged, I think we'd want yet-another value to enable / disable this
> feature. Do we need yet-another-taint flag to tell us that this feature
> was enabled?
>

I guess it makes sense to get rid of the sysctl interface for
proc_on_taint, and only keep it as a cmdline option. 

But the real issue seems to be, regardless we go with a cmdline-only option
or not, the ability of proc_taint() to set any arbitrary taint flag 
other than just marking the kernel with TAINT_USER. 

-- Rafael

