Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F010E1CE6FA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 May 2020 23:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732554AbgEKVFU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 May 2020 17:05:20 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40844 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732559AbgEKVFR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 May 2020 17:05:17 -0400
Received: by mail-pf1-f195.google.com with SMTP id x2so5300612pfx.7;
        Mon, 11 May 2020 14:05:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t75vcHrGDSnK85bf5vWlaxNV98NfbPo5RXTgDatbL1Y=;
        b=HsdVMKiDoumTkY2XsGzvllSC8ymXW9YgK2KnNfm0PRsjXI50nl0KKiJ4bwwrfA2WIj
         tb3vY+88E/nCY7wRfNYMs5qSbf9HLXW0tGCqYc6rFoiAZBgNkjay742Rsh5AKjXMEvwp
         lpgyEelAQVH39B7iHRDkMtLJhFI7U/qwuoqviugzlXzx73AXkc6+Jw7PRUa4sAknoLeq
         plquygjQgZW15mEC7AJvzLTyDce/bSAm5XR5rqimKfQtu+xWWJNczKT2eHdfkrWOsu+j
         UbMDQZxJ0jkFR/lL0Uh7oXz6Pm2jBnP0GSiHcitU7S2Xzyq6IozC9gVAHjk9wZxih9kD
         ti+w==
X-Gm-Message-State: AGi0PubED1jzW73VFJHiUwP/lseJ68r7vUs54mqj+/yL92l6hVSy0WOc
        V7akPGEZsEZP9fzOTp1LEvx2sj+1hdYaVA==
X-Google-Smtp-Source: APiQypLR9L4ljsK/1jNhGMDg4kZpQacuA0w6REvupxynKl/3lP68buLEUEk7PY9ibjXqDydibHJprA==
X-Received: by 2002:a62:34c1:: with SMTP id b184mr17463057pfa.73.1589231116431;
        Mon, 11 May 2020 14:05:16 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id t74sm10232698pfc.64.2020.05.11.14.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 14:05:14 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id E54B140605; Mon, 11 May 2020 21:05:13 +0000 (UTC)
Date:   Mon, 11 May 2020 21:05:13 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        dyoung@redhat.com, bhe@redhat.com, corbet@lwn.net,
        keescook@chromium.org, akpm@linux-foundation.org, cai@lca.pw,
        rdunlap@infradead.org, tytso@mit.edu, bunk@kernel.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        labbott@redhat.com, jeffm@suse.com, jikos@kernel.org, jeyu@suse.de,
        tiwai@suse.de, AnDavis@suse.com, rpalethorpe@suse.de
Subject: Re: [PATCH v3] kernel: add panic_on_taint
Message-ID: <20200511210513.GU11244@42.do-not-panic.com>
References: <20200509135737.622299-1-aquini@redhat.com>
 <20200511182455.GR11244@42.do-not-panic.com>
 <20200511200325.GE367616@optiplex-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511200325.GE367616@optiplex-lnx>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 11, 2020 at 04:03:25PM -0400, Rafael Aquini wrote:
> On Mon, May 11, 2020 at 06:24:55PM +0000, Luis Chamberlain wrote:
> > On Sat, May 09, 2020 at 09:57:37AM -0400, Rafael Aquini wrote:
> > > +Trigger Kdump on add_taint()
> > > +============================
> > > +
> > > +The kernel parameter, panic_on_taint, calls panic() from within add_taint(),
> > > +whenever the value set in this bitmask matches with the bit flag being set
> > > +by add_taint(). This will cause a kdump to occur at the panic() call.
> > > +In cases where a user wants to specify this during runtime,
> > > +/proc/sys/kernel/panic_on_taint can be set to a respective bitmask value
> > > +to achieve the same behaviour.
> > > +
> > >  Contact
> > >  =======
> > >  
> > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > index 7bc83f3d9bdf..4a69fe49a70d 100644
> > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > @@ -3404,6 +3404,21 @@
> > >  	panic_on_warn	panic() instead of WARN().  Useful to cause kdump
> > >  			on a WARN().
> > >  
> > > +	panic_on_taint=	[KNL] conditionally panic() in add_taint()
> > > +			Format: <str>
> > > +			Specifies, as a string, the TAINT flag set that will
> > > +			compose a bitmask for calling panic() when the kernel
> > > +			gets tainted.
> > > +			See Documentation/admin-guide/tainted-kernels.rst for
> > > +			details on the taint flags that users can pick to
> > > +			compose the bitmask to assign to panic_on_taint.
> > > +			When the string is prefixed with a '-' the bitmask
> > > +			set in panic_on_taint will be mutually exclusive
> > > +			with the sysctl knob kernel.tainted, and any attempt
> > > +			to write to that sysctl will fail with -EINVAL for
> > > +			any taint value that masks with the flags set for
> > > +			this option.
> > 
> > This talks about using a string, but that it sets a bitmask. Its not
> > very clear that one must use the string representation from each taint
> > flag. Also, I don't think to use the character representation as we
> > limit ourselves to the alphabet and quirky what-should-be-arbitrary
> > characters that represent the taint flags. The taint flag character
> > representation is juse useful for human reading of a panic, but I think
> > because of the limitation of the mask with the alphabet this was not
> > such a great idea long term.
> >
> 
> I respectfully disagree with you on this one, but that might be just
> because I'm a non-native English speaker and the cause of confusion is 
> not very clear to me. Would you mind providing a blurb with a text that
> you think it would be clearer on this regard?

A simple example of what can be used and what it would mean would
suffice.

> Also, making the input of the option to match with something one
> is used to see in taint reports make it easier to use. It would
> be still a human setting the boot option, so it makes sense to
> utilize a known/meaningful representation for panic_on_taint input.

Yes, however I still believe that what we are printing is only doing
a disservice to limiting the size of our bitmask.

> > So, I don't think we should keep on extending the alphabet use case, a
> > simple digit representation would suffice. I think this means we'd need
> > two params one for exclusive and one for the value of the taint.
> > 
> > Using a hex value or number also lets us make the input value shorter.
> >
> 
> Albeit you're right on the limitation of an alphabetical representation, 
> the truth is that taint flags are not introduced that frequently.
> Considering how many times these flags were introduced in the past,
> one could infer we probably will not run out of alphabet in the next 20 
> years (a couple of new flags gets introduced every 2 years, or so, in
> average), and the rate of change in these seems to be slowing down
> considerably, as in the past 5 years, we've seen only 2 new flags.
> 
> I'm not against your suggestion, though, but I think it makes
> clumsier to utilize the feature as you now require 2 kernel
> cmdline options, instead of just one, and a less intuitive
> way of setting it via base16 values. All at the expense of 
> a theoretical shortage of taint flags. 
> 
> If the others that were already OK with the simple string interface 
> don't object your change suggestions in that regard, I'll refactor
> the parser to meet them. 

It is just silly for us to restrict our bitmask to the alphabet. The
alphabetic restrictions were useful for print until we started running
out of meaningful characters, moving forward they'll just be a nuisance.

I don't think its wise to encourage their use now for input, now that
we have realized that their use will be pointless soon.

> > If a kernel boots with panic-on-taint flag not yet supported, we don't
> > complain, therefore getting a false sense of security that we will panic
> > with a not yet supported taint flag. I think we should pr_warn() or
> > fail to boot when that happens.
> >
> 
> Bear in mind that these very early print outs (like the ones eventually
> produced by setting panic_on_taint) to the log buffer might get lost in 
> verbose-logging long-running time systems, but apart from that, I see no 
> problems in being a little bit more verbose in that parser. I'll make
> the changes for a next revision, if no one else objects them.

See mitigations_parse_cmdline(), we pr_crit() there as well if we enter
a wrong value. I think that's the best we can do.

  Luis
