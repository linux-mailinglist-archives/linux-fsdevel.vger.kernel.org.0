Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D37121C9980
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 20:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgEGSnY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 14:43:24 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33451 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726320AbgEGSnX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 14:43:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588877002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jh97DkO75QGZr6UViEI6oioQHzU0u8jFEO5QZXD5xsY=;
        b=MXC2AagNZJ2Sr2nah3oaYT+KfF1GJIsEJoVRDknesLkdp0yBMohg/A9lPx7MkHs14GiXai
        mg+8P2Vf9CwLB8I3UTOuStQhJMgLIYy+i6wUmanJUKh53NPFUApbpquyIOPYY/qbboGSHz
        qNou6sRDinJQOHTZ7SHPGyrgDKuIfkI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-hOsW7xkTMlefJxkiXvcjgg-1; Thu, 07 May 2020 14:43:18 -0400
X-MC-Unique: hOsW7xkTMlefJxkiXvcjgg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7101319200C1;
        Thu,  7 May 2020 18:43:16 +0000 (UTC)
Received: from optiplex-lnx (unknown [10.3.128.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E61AE70559;
        Thu,  7 May 2020 18:43:10 +0000 (UTC)
Date:   Thu, 7 May 2020 14:43:07 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        dyoung@redhat.com, bhe@redhat.com, corbet@lwn.net,
        keescook@chromium.org, akpm@linux-foundation.org, cai@lca.pw,
        rdunlap@infradead.org
Subject: Re: [PATCH v2] kernel: add panic_on_taint
Message-ID: <20200507184307.GF205881@optiplex-lnx>
References: <20200507180631.308441-1-aquini@redhat.com>
 <20200507182257.GX11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507182257.GX11244@42.do-not-panic.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 07, 2020 at 06:22:57PM +0000, Luis Chamberlain wrote:
> On Thu, May 07, 2020 at 02:06:31PM -0400, Rafael Aquini wrote:
> > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > index 8a176d8727a3..b80ab660d727 100644
> > --- a/kernel/sysctl.c
> > +++ b/kernel/sysctl.c
> > @@ -1217,6 +1217,13 @@ static struct ctl_table kern_table[] = {
> >  		.extra1		= SYSCTL_ZERO,
> >  		.extra2		= SYSCTL_ONE,
> >  	},
> > +	{
> > +		.procname	= "panic_on_taint",
> > +		.data		= &panic_on_taint,
> > +		.maxlen		= sizeof(unsigned long),
> > +		.mode		= 0644,
> > +		.proc_handler	= proc_doulongvec_minmax,
> > +	},
> 
> You sent this out before I could reply to the other thread on v1.
> My thoughts on the min / max values, or lack here:
>                                                                                 
> Valid range doesn't mean "currently allowed defined" masks.                     
> 
> For example, if you expect to panic due to a taint, but a new taint type
> you want was not added on an older kernel you would be under a very
> *false* sense of security that your kernel may not have hit such a
> taint, but the reality of the situation was that the kernel didn't
> support that taint flag only added in future kernels.                           
> 
> You may need to define a new flag (MAX_TAINT) which should be the last
> value + 1, the allowed max values would be                                      
> 
> (2^MAX_TAINT)-1                                                                 
> 
> or                                                                              
> 
> (1<<MAX_TAINT)-1  
> 
> Since this is to *PANIC* I think we do want to test ranges and ensure
> only valid ones are allowed.
>

Ok. I'm thinking in:

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 8a176d8727a3..ee492431e7b0 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1217,6 +1217,15 @@ static struct ctl_table kern_table[] = {
                .extra1         = SYSCTL_ZERO,
                .extra2         = SYSCTL_ONE,
        },
+       {
+               .procname       = "panic_on_taint",
+               .data           = &panic_on_taint,
+               .maxlen         = sizeof(unsigned long),
+               .mode           = 0644,
+               .proc_handler   = proc_doulongvec_minmax,
+               .extra1         = SYSCTL_ZERO,
+               .extra2         = (1 << TAINT_FLAGS_COUNT << 1) - 1,
+       },


Would that address your concerns wrt this one?

Cheers!
-- Rafael

