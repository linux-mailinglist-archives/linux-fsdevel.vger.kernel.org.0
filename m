Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94DC5A87E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Aug 2022 23:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbiHaVHj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 17:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbiHaVHh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 17:07:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6755FF3252
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Aug 2022 14:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661980054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N5G7tx6XzS2Mm25xM7iRQx+nrJ0/jmqysbh8SULQiRc=;
        b=ZmOJKyM2mG/Sg0ul/sTYSyZNbS1ClQ7LSj4ufY1CX9LHix9SV2KPUtW8LESjraJzFNEE0w
        FKygKsRH9GdKfRtNgi0QuB00LnBAyILq7dNa00uLB+MLz1B8/44PU6mfD1MRedNw/lmc9X
        0u9DDxjlE1GbSidqK2PpkK33G2lffGc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-208-3iRI4zIvNiSrYMFsG6jm1w-1; Wed, 31 Aug 2022 17:07:30 -0400
X-MC-Unique: 3iRI4zIvNiSrYMFsG6jm1w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A813B8039BC;
        Wed, 31 Aug 2022 21:07:28 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.22.48.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 383E31415138;
        Wed, 31 Aug 2022 21:07:27 +0000 (UTC)
Date:   Wed, 31 Aug 2022 17:07:25 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Steve Grubb <sgrubb@redhat.com>, Paul Moore <paul@paul-moore.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v4 3/4] fanotify,audit: Allow audit to use the full
 permission event response
Message-ID: <Yw/NjYytoMUdbxuR@madcap2.tricolour.ca>
References: <cover.1659996830.git.rgb@redhat.com>
 <c4ae9b882c07ea9cac64094294da5edc0756bb50.1659996830.git.rgb@redhat.com>
 <CAHC9VhT0D=qtaYR-Ve1hRTtQXspuC09qQZyFdESj-tQstyvMFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhT0D=qtaYR-Ve1hRTtQXspuC09qQZyFdESj-tQstyvMFg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022-08-15 20:22, Paul Moore wrote:
> On Tue, Aug 9, 2022 at 1:23 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> >
> > This patch passes the full value so that the audit function can use all
> > of it. The audit function was updated to log the additional information in
> > the AUDIT_FANOTIFY record. The following is an example of the new record
> > format:
> >
> > type=FANOTIFY msg=audit(1600385147.372:590): resp=2 fan_type=1 fan_info=17
> >
> > Suggested-by: Steve Grubb <sgrubb@redhat.com>
> > Link: https://lore.kernel.org/r/3075502.aeNJFYEL58@x2
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> >  fs/notify/fanotify/fanotify.c |  3 ++-
> >  include/linux/audit.h         |  9 +++++----
> >  kernel/auditsc.c              | 31 ++++++++++++++++++++++++++++---
> >  3 files changed, 35 insertions(+), 8 deletions(-)
> 
> You've hopefully already seen the kernel test robot build warning, so
> I won't bring that up again, but a few comments below ...

Yes, dealt with...

...

> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > index 433418d73584..f000fec52360 100644
> > --- a/kernel/auditsc.c
> > +++ b/kernel/auditsc.c
> > @@ -64,6 +64,7 @@
> >  #include <uapi/linux/limits.h>
> >  #include <uapi/linux/netfilter/nf_tables.h>
> >  #include <uapi/linux/openat2.h> // struct open_how
> > +#include <uapi/linux/fanotify.h>
> >
> >  #include "audit.h"
> >
> > @@ -2899,10 +2900,34 @@ void __audit_log_kern_module(char *name)
> >         context->type = AUDIT_KERN_MODULE;
> >  }
> >
> > -void __audit_fanotify(u32 response)
> > +void __audit_fanotify(u32 response, size_t len, char *buf)
> >  {
> > -       audit_log(audit_context(), GFP_KERNEL,
> > -               AUDIT_FANOTIFY, "resp=%u", response);
> > +       struct fanotify_response_info_audit_rule *friar;
> > +       size_t c = len;
> > +       char *ib = buf;
> > +
> > +       if (!(len && buf)) {
> > +               audit_log(audit_context(), GFP_KERNEL, AUDIT_FANOTIFY,
> > +                         "resp=%u fan_type=0 fan_info=?", response);
> > +               return;
> > +       }
> > +       while (c >= sizeof(struct fanotify_response_info_header)) {
> > +               friar = (struct fanotify_response_info_audit_rule *)buf;
> 
> Since the only use of this at the moment is the
> fanotify_response_info_rule, why not pass the
> fanotify_response_info_rule struct directly into this function?  We
> can always change it if we need to in the future without affecting
> userspace, and it would simplify the code.

Steve, would it make any sense for there to be more than one
FAN_RESPONSE_INFO_AUDIT_RULE header in a message?  Could there be more
than one rule that contributes to a notify reason?  If not, would it be
reasonable to return -EINVAL if there is more than one?

> > +               switch (friar->hdr.type) {
> > +               case FAN_RESPONSE_INFO_AUDIT_RULE:
> > +                       if (friar->hdr.len < sizeof(*friar)) {
> > +                               audit_log(audit_context(), GFP_KERNEL, AUDIT_FANOTIFY,
> > +                                         "resp=%u fan_type=%u fan_info=(incomplete)",
> > +                                         response, friar->hdr.type);
> > +                               return;
> > +                       }
> > +                       audit_log(audit_context(), GFP_KERNEL, AUDIT_FANOTIFY,
> > +                                 "resp=%u fan_type=%u fan_info=%u",
> > +                                 response, friar->hdr.type, friar->audit_rule);
> > +               }
> > +               c -= friar->hdr.len;
> > +               ib += friar->hdr.len;
> > +       }
> >  }
> >
> >  void __audit_tk_injoffset(struct timespec64 offset)
> 
> paul-moore.com

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

