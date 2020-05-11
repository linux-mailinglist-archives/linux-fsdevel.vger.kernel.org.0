Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E571CE4F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 May 2020 22:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731428AbgEKUDs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 May 2020 16:03:48 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42020 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729523AbgEKUDr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 May 2020 16:03:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589227425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RqLIghAl9FOHJnp1Y7T66opswWD9eKr/smCA1mzy8mo=;
        b=IWn2kc67uovlc5USmhuLhJb2g4H7VAfjiEj8Gt4Q4Ur4IR2FBe09C4M2eNDXPYSzxomfPS
        UrUwZUTr7UWq8p0/szv1bycgdzEYB6R48Wk3PA9YGxUNRqJ9ujVdytC59eXL0Rgtcet0qq
        nxrT3izwCd20PpayIObcVTUO3+u/BDs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-YucPpVjoP92YT5hhrLVOIQ-1; Mon, 11 May 2020 16:03:41 -0400
X-MC-Unique: YucPpVjoP92YT5hhrLVOIQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0EC2480B70B;
        Mon, 11 May 2020 20:03:39 +0000 (UTC)
Received: from optiplex-lnx (unknown [10.3.128.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BD7EE2B056;
        Mon, 11 May 2020 20:03:28 +0000 (UTC)
Date:   Mon, 11 May 2020 16:03:25 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        dyoung@redhat.com, bhe@redhat.com, corbet@lwn.net,
        keescook@chromium.org, akpm@linux-foundation.org, cai@lca.pw,
        rdunlap@infradead.org, tytso@mit.edu, bunk@kernel.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        labbott@redhat.com, jeffm@suse.com, jikos@kernel.org, jeyu@suse.de,
        tiwai@suse.de, AnDavis@suse.com, rpalethorpe@suse.de
Subject: Re: [PATCH v3] kernel: add panic_on_taint
Message-ID: <20200511200325.GE367616@optiplex-lnx>
References: <20200509135737.622299-1-aquini@redhat.com>
 <20200511182455.GR11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511182455.GR11244@42.do-not-panic.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 11, 2020 at 06:24:55PM +0000, Luis Chamberlain wrote:
> On Sat, May 09, 2020 at 09:57:37AM -0400, Rafael Aquini wrote:
> > +Trigger Kdump on add_taint()
> > +============================
> > +
> > +The kernel parameter, panic_on_taint, calls panic() from within add_taint(),
> > +whenever the value set in this bitmask matches with the bit flag being set
> > +by add_taint(). This will cause a kdump to occur at the panic() call.
> > +In cases where a user wants to specify this during runtime,
> > +/proc/sys/kernel/panic_on_taint can be set to a respective bitmask value
> > +to achieve the same behaviour.
> > +
> >  Contact
> >  =======
> >  
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 7bc83f3d9bdf..4a69fe49a70d 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -3404,6 +3404,21 @@
> >  	panic_on_warn	panic() instead of WARN().  Useful to cause kdump
> >  			on a WARN().
> >  
> > +	panic_on_taint=	[KNL] conditionally panic() in add_taint()
> > +			Format: <str>
> > +			Specifies, as a string, the TAINT flag set that will
> > +			compose a bitmask for calling panic() when the kernel
> > +			gets tainted.
> > +			See Documentation/admin-guide/tainted-kernels.rst for
> > +			details on the taint flags that users can pick to
> > +			compose the bitmask to assign to panic_on_taint.
> > +			When the string is prefixed with a '-' the bitmask
> > +			set in panic_on_taint will be mutually exclusive
> > +			with the sysctl knob kernel.tainted, and any attempt
> > +			to write to that sysctl will fail with -EINVAL for
> > +			any taint value that masks with the flags set for
> > +			this option.
> 
> This talks about using a string, but that it sets a bitmask. Its not
> very clear that one must use the string representation from each taint
> flag. Also, I don't think to use the character representation as we
> limit ourselves to the alphabet and quirky what-should-be-arbitrary
> characters that represent the taint flags. The taint flag character
> representation is juse useful for human reading of a panic, but I think
> because of the limitation of the mask with the alphabet this was not
> such a great idea long term.
>

I respectfully disagree with you on this one, but that might be just
because I'm a non-native English speaker and the cause of confusion is 
not very clear to me. Would you mind providing a blurb with a text that
you think it would be clearer on this regard?

Also, making the input of the option to match with something one
is used to see in taint reports make it easier to use. It would
be still a human setting the boot option, so it makes sense to
utilize a known/meaningful representation for panic_on_taint input.

 
> So, I don't think we should keep on extending the alphabet use case, a
> simple digit representation would suffice. I think this means we'd need
> two params one for exclusive and one for the value of the taint.
> 
> Using a hex value or number also lets us make the input value shorter.
>

Albeit you're right on the limitation of an alphabetical representation, 
the truth is that taint flags are not introduced that frequently.
Considering how many times these flags were introduced in the past,
one could infer we probably will not run out of alphabet in the next 20 
years (a couple of new flags gets introduced every 2 years, or so, in
average), and the rate of change in these seems to be slowing down
considerably, as in the past 5 years, we've seen only 2 new flags.

I'm not against your suggestion, though, but I think it makes
clumsier to utilize the feature as you now require 2 kernel
cmdline options, instead of just one, and a less intuitive
way of setting it via base16 values. All at the expense of 
a theoretical shortage of taint flags. 

If the others that were already OK with the simple string interface 
don't object your change suggestions in that regard, I'll refactor
the parser to meet them. 


> If a kernel boots with panic-on-taint flag not yet supported, we don't
> complain, therefore getting a false sense of security that we will panic
> with a not yet supported taint flag. I think we should pr_warn() or
> fail to boot when that happens.
>

Bear in mind that these very early print outs (like the ones eventually
produced by setting panic_on_taint) to the log buffer might get lost in 
verbose-logging long-running time systems, but apart from that, I see no 
problems in being a little bit more verbose in that parser. I'll make
the changes for a next revision, if no one else objects them.

Cheers!
-- Rafael

