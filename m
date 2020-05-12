Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5973E1CFA05
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 18:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgELQBc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 12:01:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49463 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726287AbgELQBc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 12:01:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589299290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4myntAchWEpin/XtVoBTO15NuL8q/7dRSSUM/RxIEHk=;
        b=iQOxt7CABl01Q5fhwKIAri86mVqbP0ELec2Nj0rInVa37XxRXVVRjI6Xe3py9mZ/2rRGN8
        uNJl5OA/A1JIUvE3++YapMpzyxnlMtHmiSg7jwJhjO9wM508cYRt2VPyDm2nrlVCZcvsib
        2xom/VCzScaWY782qMj0SX5dHjq4AQc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-MWSI24zBNwCNDxlHahR5lA-1; Tue, 12 May 2020 12:01:28 -0400
X-MC-Unique: MWSI24zBNwCNDxlHahR5lA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32943A0C11;
        Tue, 12 May 2020 16:01:27 +0000 (UTC)
Received: from optiplex-lnx (unknown [10.3.128.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E79F578B20;
        Tue, 12 May 2020 16:01:24 +0000 (UTC)
Date:   Tue, 12 May 2020 12:01:21 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Tso Ted <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, keescook@chromium.org,
        yzaikin@google.com
Subject: Re: [PATCH] kernel: sysctl: ignore invalid taint bits introduced via
 kernel.tainted and taint the kernel with TAINT_USER on writes
Message-ID: <20200512160121.GH367616@optiplex-lnx>
References: <20200511215904.719257-1-aquini@redhat.com>
 <20200511231045.GV11244@42.do-not-panic.com>
 <20200511235914.GF367616@optiplex-lnx>
 <20200512001702.GW11244@42.do-not-panic.com>
 <20200512010313.GA725253@optiplex-lnx>
 <20200512050405.GY11244@42.do-not-panic.com>
 <20200512144906.GG367616@optiplex-lnx>
 <20200512154654.GA11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200512154654.GA11244@42.do-not-panic.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 12, 2020 at 03:46:54PM +0000, Luis Chamberlain wrote:
> On Tue, May 12, 2020 at 10:49:06AM -0400, Rafael Aquini wrote:
> > On Tue, May 12, 2020 at 05:04:05AM +0000, Luis Chamberlain wrote:
> > > On Mon, May 11, 2020 at 09:03:13PM -0400, Rafael Aquini wrote:
> > > > On Tue, May 12, 2020 at 12:17:03AM +0000, Luis Chamberlain wrote:
> > > > > On Mon, May 11, 2020 at 07:59:14PM -0400, Rafael Aquini wrote:
> > > > > > On Mon, May 11, 2020 at 11:10:45PM +0000, Luis Chamberlain wrote:
> > > > > > > On Mon, May 11, 2020 at 05:59:04PM -0400, Rafael Aquini wrote:
> > > > > > > > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > > > > > > > index 8a176d8727a3..f0a4fb38ac62 100644
> > > > > > > > --- a/kernel/sysctl.c
> > > > > > > > +++ b/kernel/sysctl.c
> > > > > > > > @@ -2623,17 +2623,32 @@ static int proc_taint(struct ctl_table *table, int write,
> > > > > > > >  		return err;
> > > > > > > >  
> > > > > > > >  	if (write) {
> > > > > > > > +		int i;
> > > > > > > > +
> > > > > > > > +		/*
> > > > > > > > +		 * Ignore user input that would make us committing
> > > > > > > > +		 * arbitrary invalid TAINT flags in the loop below.
> > > > > > > > +		 */
> > > > > > > > +		tmptaint &= (1UL << TAINT_FLAGS_COUNT) - 1;
> > > > > > > 
> > > > > > > This looks good but we don't pr_warn() of information lost on intention.
> > > > > > >
> > > > > > 
> > > > > > Are you thinking in sth like:
> > > > > > 
> > > > > > +               if (tmptaint > TAINT_FLAGS_MAX) {
> > > > > > +                       tmptaint &= TAINT_FLAGS_MAX;
> > > > > > +                       pr_warn("proc_taint: out-of-range invalid input ignored"
> > > > > > +                               " tainted_mask adjusted to 0x%x\n", tmptaint);
> > > > > > +               }
> > > > > > ?
> > > > > 
> > > > > Sure that would clarify this.
> > > > > 
> > > > > > > > +
> > > > > > > >  		/*
> > > > > > > >  		 * Poor man's atomic or. Not worth adding a primitive
> > > > > > > >  		 * to everyone's atomic.h for this
> > > > > > > >  		 */
> > > > > > > > -		int i;
> > > > > > > >  		for (i = 0; i < BITS_PER_LONG && tmptaint >> i; i++) {
> > > > > > > >  			if ((tmptaint >> i) & 1)
> > > > > > > >  				add_taint(i, LOCKDEP_STILL_OK);
> > > > > > > >  		}
> > > > > > > > +
> > > > > > > > +		/*
> > > > > > > > +		 * Users with SYS_ADMIN capability can include any arbitrary
> > > > > > > > +		 * taint flag by writing to this interface. If that's the case,
> > > > > > > > +		 * we also need to mark the kernel "tainted by user".
> > > > > > > > +		 */
> > > > > > > > +		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
> > > > > > > 
> > > > > > > I'm in favor of this however I'd like to hear from Ted on if it meets
> > > > > > > the original intention. I would think he had a good reason not to add
> > > > > > > it here.
> > > > > > >
> > > > > > 
> > > > > > Fair enough. The impression I got by reading Ted's original commit
> > > > > > message is that the intent was to have TAINT_USER as the flag set 
> > > > > > via this interface, even though the code was allowing for any 
> > > > > > arbitrary value.
> > > > > 
> > > > > That wasn't my reading, it was that the user did something very odd
> > > > > with user input which we don't like as kernel developers, and it gives
> > > > > us a way to prove: hey you did something stupid, sorry but I cannot
> > > > > support your kernel panic.
> > > > > 
> > > > > > I think it's OK to let the user fiddle with
> > > > > > the flags, as it's been allowed since the introduction of
> > > > > > this interface, but we need to reflect that fact in the
> > > > > > tainting itself. Since TAINT_USER is not used anywhere,
> > > > > 
> > > > > I see users of TAINT_USER sprinkled around
> > > > >
> > > > 
> > > > I meant in the original commit that introduced it
> > > > (commit 34f5a39899f3f3e815da64f48ddb72942d86c366). Sorry I
> > > > miscomunicated that.
> > > > 
> > > > In its current usage, it seems that the other places adding TAINT_USER
> > > > match with what is being proposed here: To signal when we have user 
> > > > fiddling with kernel / module parameters.
> > > 
> > > drivers/base/regmap/regmap-debugfs.c requires *manual* code changes
> > > to compile / enable some knob. i915 complains about unsafe module
> > > params such as module_param_cb_unsafe() core_param_unsafe(). Then
> > > drivers/soundwire/cadence_master.c is for when a debugfs dangerous
> > > param was used.
> > > 
> > > This still doesn't rule out the use of proc_taint() for testing taint,
> > > and that adding it may break some tests. So even though this would
> > > only affect some tests scripts, I can't say that adding this taint won't
> > > cause some headaches to someone. I wouldn't encourage its use on
> > > proc_taint() from what I can see so far.
> > >
> > 
> > OK, I´ll repost without the hunk forcing the taint. If we eventually
> > come to the conclusion that tainting in proc_taint() is the right thing
> > to do, we can do that part of the change later.
> 
> Just add another taint, we have 64 bits and according to you we won't
> ever run out. TAINT_CUSTOM or whatever.
>

I don't think this deserves a custom taint, and TAINT_USER should be the
one to add here, as it clearly communicates what's being done at this
point. If we cannot compromise on utilizing it, then lets just forget
about forcing any other flag at this point. As per tracking which
taint flags a user has forced via this interface, I do have another
idea that I still have to iron out, but I'll propose it soon enough.
 
> > Do you think we should use printk_ratelimited() in the ignore message,
> > instead? 
> 
> No, that's for when there are many prints at the same time, you probably
> want pr_warn_once().

OK.

