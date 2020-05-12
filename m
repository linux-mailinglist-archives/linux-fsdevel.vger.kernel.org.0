Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 917341CE98C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 02:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgELARG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 May 2020 20:17:06 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:36434 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgELARG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 May 2020 20:17:06 -0400
Received: by mail-pj1-f68.google.com with SMTP id q24so8544109pjd.1;
        Mon, 11 May 2020 17:17:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=picn1x3gPFHZt1GE3SbWrOjaNrLu9kmjRnRGCx89OGA=;
        b=hRxPjmMqYXM/GCatJOttwEa+PGPDruvRsHUmZ2FQwwMdxO0wLLr2jk1n08lXd4w7p6
         nm3gLXQo+2E4ByTz2/68uXg1s+96vrz2b/skL3BL3TAwl/sF8ZKPr0mJwXRIIytydmSt
         Ce9xhkWjm/zBB6efkOs1a14Xaj7ft3VdwPPHleDKiumWQ6/ENCrfrNRaCEFVaOHnbnEN
         VuCz2YJZ8zoVryrnukxKRRAjJtbA/M3uvFm0gKJ5ETTEWNZYWPi/Ryjk5TDPdZeElTkV
         3KUofbQQ7oHbETgjiVLokerwoT8OeBlOgfgPPcJKNsXmDjAfXaGgJBReVFQrgVr87PYb
         UdWg==
X-Gm-Message-State: AGi0PuZ2Yk3ge9yVt0QlV/MLqhLmgwdvRLtsQZlHTglxsF68oqYoB1SY
        feKMLMUvp1lgY5ywAoGQWSw=
X-Google-Smtp-Source: APiQypK3/MmgB/38T+zj6P5GKJBercO86vwrP/6vbdQbNQ94quNaQbp82oMztuLmA+W6ugTyboiWNg==
X-Received: by 2002:a17:90a:2004:: with SMTP id n4mr26897179pjc.190.1589242625277;
        Mon, 11 May 2020 17:17:05 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id fu12sm11110748pjb.20.2020.05.11.17.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 17:17:03 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 1579B40E88; Tue, 12 May 2020 00:17:03 +0000 (UTC)
Date:   Tue, 12 May 2020 00:17:03 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     Tso Ted <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, keescook@chromium.org,
        yzaikin@google.com
Subject: Re: [PATCH] kernel: sysctl: ignore invalid taint bits introduced via
 kernel.tainted and taint the kernel with TAINT_USER on writes
Message-ID: <20200512001702.GW11244@42.do-not-panic.com>
References: <20200511215904.719257-1-aquini@redhat.com>
 <20200511231045.GV11244@42.do-not-panic.com>
 <20200511235914.GF367616@optiplex-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511235914.GF367616@optiplex-lnx>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 11, 2020 at 07:59:14PM -0400, Rafael Aquini wrote:
> On Mon, May 11, 2020 at 11:10:45PM +0000, Luis Chamberlain wrote:
> > On Mon, May 11, 2020 at 05:59:04PM -0400, Rafael Aquini wrote:
> > > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > > index 8a176d8727a3..f0a4fb38ac62 100644
> > > --- a/kernel/sysctl.c
> > > +++ b/kernel/sysctl.c
> > > @@ -2623,17 +2623,32 @@ static int proc_taint(struct ctl_table *table, int write,
> > >  		return err;
> > >  
> > >  	if (write) {
> > > +		int i;
> > > +
> > > +		/*
> > > +		 * Ignore user input that would make us committing
> > > +		 * arbitrary invalid TAINT flags in the loop below.
> > > +		 */
> > > +		tmptaint &= (1UL << TAINT_FLAGS_COUNT) - 1;
> > 
> > This looks good but we don't pr_warn() of information lost on intention.
> >
> 
> Are you thinking in sth like:
> 
> +               if (tmptaint > TAINT_FLAGS_MAX) {
> +                       tmptaint &= TAINT_FLAGS_MAX;
> +                       pr_warn("proc_taint: out-of-range invalid input ignored"
> +                               " tainted_mask adjusted to 0x%x\n", tmptaint);
> +               }
> ?

Sure that would clarify this.

> > > +
> > >  		/*
> > >  		 * Poor man's atomic or. Not worth adding a primitive
> > >  		 * to everyone's atomic.h for this
> > >  		 */
> > > -		int i;
> > >  		for (i = 0; i < BITS_PER_LONG && tmptaint >> i; i++) {
> > >  			if ((tmptaint >> i) & 1)
> > >  				add_taint(i, LOCKDEP_STILL_OK);
> > >  		}
> > > +
> > > +		/*
> > > +		 * Users with SYS_ADMIN capability can include any arbitrary
> > > +		 * taint flag by writing to this interface. If that's the case,
> > > +		 * we also need to mark the kernel "tainted by user".
> > > +		 */
> > > +		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
> > 
> > I'm in favor of this however I'd like to hear from Ted on if it meets
> > the original intention. I would think he had a good reason not to add
> > it here.
> >
> 
> Fair enough. The impression I got by reading Ted's original commit
> message is that the intent was to have TAINT_USER as the flag set 
> via this interface, even though the code was allowing for any 
> arbitrary value.

That wasn't my reading, it was that the user did something very odd
with user input which we don't like as kernel developers, and it gives
us a way to prove: hey you did something stupid, sorry but I cannot
support your kernel panic.

> I think it's OK to let the user fiddle with
> the flags, as it's been allowed since the introduction of
> this interface, but we need to reflect that fact in the
> tainting itself. Since TAINT_USER is not used anywhere,

I see users of TAINT_USER sprinkled around

> this change perfectly communicates that fact without
> the need for introducing yet another taint flag.

I'd be happy if we don't have introduce yet-anothe flag as well.
But since Ted introduced it, without using the flag on the proc_taint()
I'd like confirmation we won't screw things up with existing test cases
which assume proc_taint() won't set this up. We'd therefore regress
userspace.

This is why I'd like for us to be careful with this flag.

  Luis
