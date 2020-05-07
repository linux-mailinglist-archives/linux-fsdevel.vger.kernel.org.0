Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF931C9C79
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 22:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgEGUdn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 16:33:43 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41346 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbgEGUdn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 16:33:43 -0400
Received: by mail-pl1-f195.google.com with SMTP id u10so2538987pls.8;
        Thu, 07 May 2020 13:33:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MoMjwxwKEdXavhFslG5lFIMwK7mcqNgr2NAM0IYCo+k=;
        b=ckTDDHaH3Aynu08VgrCmfgszHwqWSVElPfZ8mXAjcU4fnHiXvrOH7iqI7/4WB4et1A
         X63XvHhl+VY0/2Sg1wrifnA8oWCw8sQqaddzlJaClciYr2grvMm8REik8gkbq/vlh3SD
         KqkoNf5f5WiGl12NSQnqIPV6sJSxmbb1vlXSIE1QEh971vty5QW/+m1NXzMeRUzFSTEw
         JeCEhc2y88rjxcvwK86DO0Cew0d2FPx5cN8eLh6S1rT6clFI6G+Ps97DEN9IVedRL9Tl
         rghbiY+P4IBgGhLR3BumUk9h0+4DIVkufkCBWP/fmLOCfEjorxzMXd/CgKNF1L8v28/w
         PVhg==
X-Gm-Message-State: AGi0PuY/03iHl5AulhyPrVUzEKHOqRCuNLjBiK7cxJ+EfsOYRoJaEhKB
        XONPNNwST8Nf1qdOY42tlx8=
X-Google-Smtp-Source: APiQypKzOvsOb6uSbzYE/OPlbOBeyhXMRjRDiozG0ygWaqabRTDqfi9zOl/zJSiRsBKGN2PJSdrMRw==
X-Received: by 2002:a17:902:7281:: with SMTP id d1mr15673761pll.78.1588883623569;
        Thu, 07 May 2020 13:33:43 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id e12sm4414343pgv.16.2020.05.07.13.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 13:33:41 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id B7609403EA; Thu,  7 May 2020 20:33:40 +0000 (UTC)
Date:   Thu, 7 May 2020 20:33:40 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Rafael Aquini <aquini@redhat.com>, Tso Ted <tytso@mit.edu>,
        Adrian Bunk <bunk@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laura Abbott <labbott@redhat.com>,
        Jeff Mahoney <jeffm@suse.com>, Jiri Kosina <jikos@kernel.org>,
        Jessica Yu <jeyu@suse.de>, Takashi Iwai <tiwai@suse.de>,
        Ann Davis <AnDavis@suse.com>,
        Richard Palethorpe <rpalethorpe@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        dyoung@redhat.com, bhe@redhat.com, corbet@lwn.net,
        keescook@chromium.org, akpm@linux-foundation.org, cai@lca.pw,
        rdunlap@infradead.org
Subject: Re: [PATCH v2] kernel: add panic_on_taint
Message-ID: <20200507203340.GZ11244@42.do-not-panic.com>
References: <20200507180631.308441-1-aquini@redhat.com>
 <20200507182257.GX11244@42.do-not-panic.com>
 <20200507184307.GF205881@optiplex-lnx>
 <20200507184705.GG205881@optiplex-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507184705.GG205881@optiplex-lnx>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 07, 2020 at 02:47:05PM -0400, Rafael Aquini wrote:
> On Thu, May 07, 2020 at 02:43:16PM -0400, Rafael Aquini wrote:
> > On Thu, May 07, 2020 at 06:22:57PM +0000, Luis Chamberlain wrote:
> > > On Thu, May 07, 2020 at 02:06:31PM -0400, Rafael Aquini wrote:
> > > > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > > > index 8a176d8727a3..b80ab660d727 100644
> > > > --- a/kernel/sysctl.c
> > > > +++ b/kernel/sysctl.c
> > > > @@ -1217,6 +1217,13 @@ static struct ctl_table kern_table[] = {
> > > >  		.extra1		= SYSCTL_ZERO,
> > > >  		.extra2		= SYSCTL_ONE,
> > > >  	},
> > > > +	{
> > > > +		.procname	= "panic_on_taint",
> > > > +		.data		= &panic_on_taint,
> > > > +		.maxlen		= sizeof(unsigned long),
> > > > +		.mode		= 0644,
> > > > +		.proc_handler	= proc_doulongvec_minmax,
> > > > +	},
> > > 
> > > You sent this out before I could reply to the other thread on v1.
> > > My thoughts on the min / max values, or lack here:
> > >                                                                                 
> > > Valid range doesn't mean "currently allowed defined" masks.                     
> > > 
> > > For example, if you expect to panic due to a taint, but a new taint type
> > > you want was not added on an older kernel you would be under a very
> > > *false* sense of security that your kernel may not have hit such a
> > > taint, but the reality of the situation was that the kernel didn't
> > > support that taint flag only added in future kernels.                           
> > > 
> > > You may need to define a new flag (MAX_TAINT) which should be the last
> > > value + 1, the allowed max values would be                                      
> > > 
> > > (2^MAX_TAINT)-1                                                                 
> > > 
> > > or                                                                              
> > > 
> > > (1<<MAX_TAINT)-1  
> > > 
> > > Since this is to *PANIC* I think we do want to test ranges and ensure
> > > only valid ones are allowed.
> > >
> > 
> > Ok. I'm thinking in:
> > 
> > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > index 8a176d8727a3..ee492431e7b0 100644
> > --- a/kernel/sysctl.c
> > +++ b/kernel/sysctl.c
> > @@ -1217,6 +1217,15 @@ static struct ctl_table kern_table[] = {
> >                 .extra1         = SYSCTL_ZERO,
> >                 .extra2         = SYSCTL_ONE,
> >         },
> > +       {
> > +               .procname       = "panic_on_taint",
> > +               .data           = &panic_on_taint,
> > +               .maxlen         = sizeof(unsigned long),
> > +               .mode           = 0644,
> > +               .proc_handler   = proc_doulongvec_minmax,
> > +               .extra1         = SYSCTL_ZERO,
> > +               .extra2         = (1 << TAINT_FLAGS_COUNT << 1) - 1,
> 							^^^^^^^^
> Without that crap, obviously. Sorry. That was a screw up on my side,
> when copyin' and pasting.

I really think that the implications of this needs a bit further review,
hence the wider CCs.

Since this can trivially crash a system, I think we need to be careful
about this value. First, proc_doulongvec_minmax() will not suffice alone,
we'll *at least* want to check for capable(CAP_SYS_ADMIN)) as in
proc_taint().  Second first note that we *always* build proc_taint(), if
just CONFIG_PROC_SYSCTL is enabled. That has been the way since it got
merged via commit 34f5a39899f3f ("Add TAINT_USER and ability to set
taint flags from userspace") since v2.6.21. We need to evaluate if this
little *new* knob you are introducing merits its own kconfig tucked away
under debugging first. The ship has already sailed for proc_taint().
Anyone with CAP_SYS_ADMIN can taint.

The good thing is that proc_taint() added its own TAINT_USER, *but*, hey
it didn't use it. A panic-on-taint system would be able to tell if a
panic was caused by proc_taint() throught the stack trace only. 
If panic-on-taint proc was used *later* after a custom taint was set
or happened naturally, no panic would trigger since your panic-on-taint
check on your patch only happens on add_taint(). This means that for
those thinking about using this for QA or security purposes, the only
sensible *reliable* way to use panic-on-taint would be through cmdline,
from boot. Post-boot means to enable this would either need to check
existing taint flags, or we'd want to a way to check if this was not
added post boot. Also, a post-booteed system with panic-on-taint could
easily allow for reductions of the intended goal, thereby allowing one
to cheat.

I think a new TAINT_MODIFIED for use when proc_taint() is used is worth
considering. Ted? Even though 'M' is taken -- I think its silly to rely
on the character to be anything of meaning, once we run out of the
alphabet letters that will be the way anyway, unless we-redo this a bit.
Note we use value for when this is on and off, typically an empty space
when a taint is not seen.

The good thing is that proc_taint() only *increments* taint, it doesn't
remove taints.

Are we OK with panic-on-taint only with CAP_SYS_ADMIN?

I can see this building up to a "testing" solution to ensure / gaurantee
no bugs have happened during QA, but since QA would want the same binary
for production it is hard to see this enabled for QA but not production.
To resolve that last concern, if we do go with moving this under a
kconfig value, a simple cmdline append would address the concerns. Ie,
even if you enabled this mechanism through its kconfig you would not be
able to modify the panic-on-tain unless you passed a cmdline option.

Note that Vlastimil has some patches which are visible on linux-next,
but not yet merged on Linus' tree, which enable these params to be set
on the cmdline too now, so perhaps yet-another cmdline param is not
needed anymore.

I *think* that a cmdline route to enable this would likely remove the
need for the kernel config for this. But even with Vlastimil's work
merged, I think we'd want yet-another value to enable / disable this
feature. Do we need yet-another-taint flag to tell us that this feature
was enabled?

  Luis
