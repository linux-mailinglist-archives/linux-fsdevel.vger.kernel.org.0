Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D981CF991
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 17:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgELPq6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 11:46:58 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34082 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgELPq6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 11:46:58 -0400
Received: by mail-pf1-f194.google.com with SMTP id x15so5951681pfa.1;
        Tue, 12 May 2020 08:46:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MtYywY2K25Oxq0Q4HERqyfecqjUp660Gxl2wjqqJEco=;
        b=K9KDijmUF4wLBIeOBTxCTkJgQNWeajH6Hd3ouungWOexP5d/4FZnuYDGIwFKWypMXU
         wugts2knPsap/6bvexDzME+YoJ3B/pVAboYRlriXLmsU+TeFOEkce5zUyvLOUjUapqan
         s7N9ZlLxihcWTkmq3Y6jhRZ6WRLNafAvgCahBEqAhn6Zb8pskqOnC/qYJ7OTtkWZ8UX+
         iYl4P+LoLw82V5LGb4G/R5/3g+/8nyhfevNwPwjbpcxHfYGPMvc9N7mMUXWx4pYNyeuw
         kPqulKWM2K/+6O2GiGolSj4MnFTs4cbMQrbCsLZ/98UJ8Uw4CpmFYQdihvSOp6lXCn8W
         +y3g==
X-Gm-Message-State: AGi0PuYrqDwsS5dnzxVehuBc4HWau52wGicxFcySf5XommnamyNtuLSp
        bTmIFw2FdiiE+nbiQhV91ejnsxJWWNA=
X-Google-Smtp-Source: APiQypKJGsnCdzJstpku2315Yntqu27dW6PJlc3/S/r5xTdjKrCftQi2kBJztLOOnGqcDiT5iJZ+0w==
X-Received: by 2002:a63:de49:: with SMTP id y9mr19730658pgi.435.1589298416999;
        Tue, 12 May 2020 08:46:56 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id p3sm2104413pjh.22.2020.05.12.08.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 08:46:55 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id C8C9B4063E; Tue, 12 May 2020 15:46:54 +0000 (UTC)
Date:   Tue, 12 May 2020 15:46:54 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     Tso Ted <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, keescook@chromium.org,
        yzaikin@google.com
Subject: Re: [PATCH] kernel: sysctl: ignore invalid taint bits introduced via
 kernel.tainted and taint the kernel with TAINT_USER on writes
Message-ID: <20200512154654.GA11244@42.do-not-panic.com>
References: <20200511215904.719257-1-aquini@redhat.com>
 <20200511231045.GV11244@42.do-not-panic.com>
 <20200511235914.GF367616@optiplex-lnx>
 <20200512001702.GW11244@42.do-not-panic.com>
 <20200512010313.GA725253@optiplex-lnx>
 <20200512050405.GY11244@42.do-not-panic.com>
 <20200512144906.GG367616@optiplex-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200512144906.GG367616@optiplex-lnx>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 12, 2020 at 10:49:06AM -0400, Rafael Aquini wrote:
> On Tue, May 12, 2020 at 05:04:05AM +0000, Luis Chamberlain wrote:
> > On Mon, May 11, 2020 at 09:03:13PM -0400, Rafael Aquini wrote:
> > > On Tue, May 12, 2020 at 12:17:03AM +0000, Luis Chamberlain wrote:
> > > > On Mon, May 11, 2020 at 07:59:14PM -0400, Rafael Aquini wrote:
> > > > > On Mon, May 11, 2020 at 11:10:45PM +0000, Luis Chamberlain wrote:
> > > > > > On Mon, May 11, 2020 at 05:59:04PM -0400, Rafael Aquini wrote:
> > > > > > > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > > > > > > index 8a176d8727a3..f0a4fb38ac62 100644
> > > > > > > --- a/kernel/sysctl.c
> > > > > > > +++ b/kernel/sysctl.c
> > > > > > > @@ -2623,17 +2623,32 @@ static int proc_taint(struct ctl_table *table, int write,
> > > > > > >  		return err;
> > > > > > >  
> > > > > > >  	if (write) {
> > > > > > > +		int i;
> > > > > > > +
> > > > > > > +		/*
> > > > > > > +		 * Ignore user input that would make us committing
> > > > > > > +		 * arbitrary invalid TAINT flags in the loop below.
> > > > > > > +		 */
> > > > > > > +		tmptaint &= (1UL << TAINT_FLAGS_COUNT) - 1;
> > > > > > 
> > > > > > This looks good but we don't pr_warn() of information lost on intention.
> > > > > >
> > > > > 
> > > > > Are you thinking in sth like:
> > > > > 
> > > > > +               if (tmptaint > TAINT_FLAGS_MAX) {
> > > > > +                       tmptaint &= TAINT_FLAGS_MAX;
> > > > > +                       pr_warn("proc_taint: out-of-range invalid input ignored"
> > > > > +                               " tainted_mask adjusted to 0x%x\n", tmptaint);
> > > > > +               }
> > > > > ?
> > > > 
> > > > Sure that would clarify this.
> > > > 
> > > > > > > +
> > > > > > >  		/*
> > > > > > >  		 * Poor man's atomic or. Not worth adding a primitive
> > > > > > >  		 * to everyone's atomic.h for this
> > > > > > >  		 */
> > > > > > > -		int i;
> > > > > > >  		for (i = 0; i < BITS_PER_LONG && tmptaint >> i; i++) {
> > > > > > >  			if ((tmptaint >> i) & 1)
> > > > > > >  				add_taint(i, LOCKDEP_STILL_OK);
> > > > > > >  		}
> > > > > > > +
> > > > > > > +		/*
> > > > > > > +		 * Users with SYS_ADMIN capability can include any arbitrary
> > > > > > > +		 * taint flag by writing to this interface. If that's the case,
> > > > > > > +		 * we also need to mark the kernel "tainted by user".
> > > > > > > +		 */
> > > > > > > +		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
> > > > > > 
> > > > > > I'm in favor of this however I'd like to hear from Ted on if it meets
> > > > > > the original intention. I would think he had a good reason not to add
> > > > > > it here.
> > > > > >
> > > > > 
> > > > > Fair enough. The impression I got by reading Ted's original commit
> > > > > message is that the intent was to have TAINT_USER as the flag set 
> > > > > via this interface, even though the code was allowing for any 
> > > > > arbitrary value.
> > > > 
> > > > That wasn't my reading, it was that the user did something very odd
> > > > with user input which we don't like as kernel developers, and it gives
> > > > us a way to prove: hey you did something stupid, sorry but I cannot
> > > > support your kernel panic.
> > > > 
> > > > > I think it's OK to let the user fiddle with
> > > > > the flags, as it's been allowed since the introduction of
> > > > > this interface, but we need to reflect that fact in the
> > > > > tainting itself. Since TAINT_USER is not used anywhere,
> > > > 
> > > > I see users of TAINT_USER sprinkled around
> > > >
> > > 
> > > I meant in the original commit that introduced it
> > > (commit 34f5a39899f3f3e815da64f48ddb72942d86c366). Sorry I
> > > miscomunicated that.
> > > 
> > > In its current usage, it seems that the other places adding TAINT_USER
> > > match with what is being proposed here: To signal when we have user 
> > > fiddling with kernel / module parameters.
> > 
> > drivers/base/regmap/regmap-debugfs.c requires *manual* code changes
> > to compile / enable some knob. i915 complains about unsafe module
> > params such as module_param_cb_unsafe() core_param_unsafe(). Then
> > drivers/soundwire/cadence_master.c is for when a debugfs dangerous
> > param was used.
> > 
> > This still doesn't rule out the use of proc_taint() for testing taint,
> > and that adding it may break some tests. So even though this would
> > only affect some tests scripts, I can't say that adding this taint won't
> > cause some headaches to someone. I wouldn't encourage its use on
> > proc_taint() from what I can see so far.
> >
> 
> OK, I´ll repost without the hunk forcing the taint. If we eventually
> come to the conclusion that tainting in proc_taint() is the right thing
> to do, we can do that part of the change later.

Just add another taint, we have 64 bits and according to you we won't
ever run out. TAINT_CUSTOM or whatever.

> Do you think we should use printk_ratelimited() in the ignore message,
> instead? 

No, that's for when there are many prints at the same time, you probably
want pr_warn_once().

  Luis
