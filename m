Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D708F1CEC45
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 07:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgELFEK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 01:04:10 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34031 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgELFEJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 01:04:09 -0400
Received: by mail-pg1-f195.google.com with SMTP id f6so5609916pgm.1;
        Mon, 11 May 2020 22:04:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cz5uJvmf44/0ZOLjV3CMvvxnEdKl05Nmr0md8L6llSk=;
        b=iMasxPHYRmMaAURLuuX5IQxpVYJuztw8Z/5voFhj3nzGTk7kKQrmRXut6Arx2NcL3X
         YdgyVhPybcS8ejkvMErj6FpCerxIJBcpW22K9lCwTl+dK88GVtut20gf5McLsiyYQPLX
         Pw7ULT2OynGyd2T9wvS9P9HEvPh0PKsYEpdfTKir8NIdGm5Ql8yN1WFLS5e9dXL5wcrn
         NXzTwsSalC6I2BFkg4QAhqa5bOU3yXQko75ZX6X5vJL9oQntJt0y43cXZumgyJMlQcYo
         aSj68xANHKojxUFapdVXMH/3uTvDVOMYYQP2mB6bm+fy/ELyjKGn5mcYjqkYnaV4JF87
         fZpg==
X-Gm-Message-State: AGi0PubUA/NcFi2q3USv0/TnWR7t6Rvrl28xwUlz7jDHyhVI5Cix22QX
        iDP60ga7wGa2b8rAV1FM6tY=
X-Google-Smtp-Source: APiQypKM8AZUFXrolneHuvBY2Ff6Mgy4pOXL3DP2Q0nbnOPHZElOLuzNFzthXFSSXqVbvBukSvJxbg==
X-Received: by 2002:a63:e809:: with SMTP id s9mr17773796pgh.191.1589259847387;
        Mon, 11 May 2020 22:04:07 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id y29sm11054188pfq.162.2020.05.11.22.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 22:04:06 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 5DB2340E88; Tue, 12 May 2020 05:04:05 +0000 (UTC)
Date:   Tue, 12 May 2020 05:04:05 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     Tso Ted <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, keescook@chromium.org,
        yzaikin@google.com
Subject: Re: [PATCH] kernel: sysctl: ignore invalid taint bits introduced via
 kernel.tainted and taint the kernel with TAINT_USER on writes
Message-ID: <20200512050405.GY11244@42.do-not-panic.com>
References: <20200511215904.719257-1-aquini@redhat.com>
 <20200511231045.GV11244@42.do-not-panic.com>
 <20200511235914.GF367616@optiplex-lnx>
 <20200512001702.GW11244@42.do-not-panic.com>
 <20200512010313.GA725253@optiplex-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512010313.GA725253@optiplex-lnx>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 11, 2020 at 09:03:13PM -0400, Rafael Aquini wrote:
> On Tue, May 12, 2020 at 12:17:03AM +0000, Luis Chamberlain wrote:
> > On Mon, May 11, 2020 at 07:59:14PM -0400, Rafael Aquini wrote:
> > > On Mon, May 11, 2020 at 11:10:45PM +0000, Luis Chamberlain wrote:
> > > > On Mon, May 11, 2020 at 05:59:04PM -0400, Rafael Aquini wrote:
> > > > > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > > > > index 8a176d8727a3..f0a4fb38ac62 100644
> > > > > --- a/kernel/sysctl.c
> > > > > +++ b/kernel/sysctl.c
> > > > > @@ -2623,17 +2623,32 @@ static int proc_taint(struct ctl_table *table, int write,
> > > > >  		return err;
> > > > >  
> > > > >  	if (write) {
> > > > > +		int i;
> > > > > +
> > > > > +		/*
> > > > > +		 * Ignore user input that would make us committing
> > > > > +		 * arbitrary invalid TAINT flags in the loop below.
> > > > > +		 */
> > > > > +		tmptaint &= (1UL << TAINT_FLAGS_COUNT) - 1;
> > > > 
> > > > This looks good but we don't pr_warn() of information lost on intention.
> > > >
> > > 
> > > Are you thinking in sth like:
> > > 
> > > +               if (tmptaint > TAINT_FLAGS_MAX) {
> > > +                       tmptaint &= TAINT_FLAGS_MAX;
> > > +                       pr_warn("proc_taint: out-of-range invalid input ignored"
> > > +                               " tainted_mask adjusted to 0x%x\n", tmptaint);
> > > +               }
> > > ?
> > 
> > Sure that would clarify this.
> > 
> > > > > +
> > > > >  		/*
> > > > >  		 * Poor man's atomic or. Not worth adding a primitive
> > > > >  		 * to everyone's atomic.h for this
> > > > >  		 */
> > > > > -		int i;
> > > > >  		for (i = 0; i < BITS_PER_LONG && tmptaint >> i; i++) {
> > > > >  			if ((tmptaint >> i) & 1)
> > > > >  				add_taint(i, LOCKDEP_STILL_OK);
> > > > >  		}
> > > > > +
> > > > > +		/*
> > > > > +		 * Users with SYS_ADMIN capability can include any arbitrary
> > > > > +		 * taint flag by writing to this interface. If that's the case,
> > > > > +		 * we also need to mark the kernel "tainted by user".
> > > > > +		 */
> > > > > +		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
> > > > 
> > > > I'm in favor of this however I'd like to hear from Ted on if it meets
> > > > the original intention. I would think he had a good reason not to add
> > > > it here.
> > > >
> > > 
> > > Fair enough. The impression I got by reading Ted's original commit
> > > message is that the intent was to have TAINT_USER as the flag set 
> > > via this interface, even though the code was allowing for any 
> > > arbitrary value.
> > 
> > That wasn't my reading, it was that the user did something very odd
> > with user input which we don't like as kernel developers, and it gives
> > us a way to prove: hey you did something stupid, sorry but I cannot
> > support your kernel panic.
> > 
> > > I think it's OK to let the user fiddle with
> > > the flags, as it's been allowed since the introduction of
> > > this interface, but we need to reflect that fact in the
> > > tainting itself. Since TAINT_USER is not used anywhere,
> > 
> > I see users of TAINT_USER sprinkled around
> >
> 
> I meant in the original commit that introduced it
> (commit 34f5a39899f3f3e815da64f48ddb72942d86c366). Sorry I
> miscomunicated that.
> 
> In its current usage, it seems that the other places adding TAINT_USER
> match with what is being proposed here: To signal when we have user 
> fiddling with kernel / module parameters.

drivers/base/regmap/regmap-debugfs.c requires *manual* code changes
to compile / enable some knob. i915 complains about unsafe module
params such as module_param_cb_unsafe() core_param_unsafe(). Then
drivers/soundwire/cadence_master.c is for when a debugfs dangerous
param was used.

This still doesn't rule out the use of proc_taint() for testing taint,
and that adding it may break some tests. So even though this would
only affect some tests scripts, I can't say that adding this taint won't
cause some headaches to someone. I wouldn't encourage its use on
proc_taint() from what I can see so far.

  Luis
