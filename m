Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF6965476F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Dec 2022 21:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbiLVUnS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Dec 2022 15:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbiLVUnQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Dec 2022 15:43:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF3D389
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Dec 2022 12:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671741751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ltDpmYqCGhbOq/yrPkshjRh5qr1TMsJK7Tg/zkPd44k=;
        b=Ip7aZHcaK8qJNNwB0EJbJ44YW/LwJxHPMpJWAQkZ1IAhhGE1MDQE3P1Dl4t1ZJCDckEp4K
        ZyrnswMswhkeG+emV8XPiI5bE/Z3umZG/XkH0WChPZi329TRamT3lDzSwpYIYurd7y17MX
        0zlPXEIxfxRAwHDOo6SS7Bnk34NLKh4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-18-HPGPMRxlOoWd85n9TnjEdg-1; Thu, 22 Dec 2022 15:42:27 -0500
X-MC-Unique: HPGPMRxlOoWd85n9TnjEdg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F13AC3815D21;
        Thu, 22 Dec 2022 20:42:26 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-0-3.rdu2.redhat.com [10.22.0.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 681EC2166B26;
        Thu, 22 Dec 2022 20:42:25 +0000 (UTC)
Date:   Thu, 22 Dec 2022 15:42:23 -0500
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Jan Kara <jack@suse.cz>, linux-api@vger.kernel.org,
        Amir Goldstein <amir73il@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>
Subject: Re: [PATCH v5 3/3] fanotify,audit: Allow audit to use the full
 permission event response
Message-ID: <Y6TBL7+W7Q1lYc9Q@madcap2.tricolour.ca>
References: <cover.1670606054.git.rgb@redhat.com>
 <79fcf72ea442eeede53ed5e6de567f8df8ef7d83.1670606054.git.rgb@redhat.com>
 <CAHC9VhQont7=S9pvTpLUmxVSj-g-j2ZhVCLiUki69vtp8rf-9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhQont7=S9pvTpLUmxVSj-g-j2ZhVCLiUki69vtp8rf-9A@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022-12-20 18:31, Paul Moore wrote:
> On Mon, Dec 12, 2022 at 9:06 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> >
> > This patch passes the full response so that the audit function can use all
> > of it. The audit function was updated to log the additional information in
> > the AUDIT_FANOTIFY record.
> >
> > Currently the only type of fanotify info that is defined is an audit
> > rule number, but convert it to hex encoding to future-proof the field.
> > Hex encoding suggested by Paul Moore <paul@paul-moore.com>.
> >
> > Sample records:
> >   type=FANOTIFY msg=audit(1600385147.372:590): resp=2 fan_type=1 fan_info=3137 subj_trust=3 obj_trust=5
> >   type=FANOTIFY msg=audit(1659730979.839:284): resp=1 fan_type=0 fan_info=3F subj_trust=2 obj_trust=2
> >
> > Suggested-by: Steve Grubb <sgrubb@redhat.com>
> > Link: https://lore.kernel.org/r/3075502.aeNJFYEL58@x2
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> >  fs/notify/fanotify/fanotify.c |  3 ++-
> >  include/linux/audit.h         |  9 +++++----
> >  kernel/auditsc.c              | 25 ++++++++++++++++++++++---
> >  3 files changed, 29 insertions(+), 8 deletions(-)
> 
> ...
> 
> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > index d1fb821de104..8d523066d81f 100644
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
> > @@ -2877,10 +2878,28 @@ void __audit_log_kern_module(char *name)
> >         context->type = AUDIT_KERN_MODULE;
> >  }
> >
> > -void __audit_fanotify(u32 response)
> > +void __audit_fanotify(u32 response, struct fanotify_response_info_audit_rule *friar)
> >  {
> > -       audit_log(audit_context(), GFP_KERNEL,
> > -               AUDIT_FANOTIFY, "resp=%u", response);
> > +       struct audit_context *ctx = audit_context();
> > +       struct audit_buffer *ab;
> > +       char numbuf[12];
> > +
> > +       if (friar->hdr.type == FAN_RESPONSE_INFO_NONE) {
> > +               audit_log(audit_context(), GFP_KERNEL, AUDIT_FANOTIFY,
> > +                         "resp=%u fan_type=%u fan_info=3F subj_trust=2 obj_trust=2",
> > +                         response, FAN_RESPONSE_INFO_NONE);
> 
> The fan_info, subj_trust, and obj_trust constant values used here are
> awfully magic-numbery and not the usual sentinel values one might
> expect for a "none" operation, e.g. zeros/INT_MAX/etc. I believe a
> comment here explaining the values would be a good idea.

Ack.  I'll add a comment.  I would have preferred zero for default of
unset, but Steve requested 0/1/2 no/yes/unknown.

> > +               return;
> > +       }
> > +       ab = audit_log_start(ctx, GFP_KERNEL, AUDIT_FANOTIFY);
> > +       if (ab) {
> > +               audit_log_format(ab, "resp=%u fan_type=%u fan_info=",
> > +                                response, friar->hdr.type);
> > +               snprintf(numbuf, sizeof(numbuf), "%u", friar->rule_number);
> > +               audit_log_n_hex(ab, numbuf, sizeof(numbuf));
> 
> It looks like the kernel's printf format string parsing supports %X so
> why not just use that for now, we can always complicate it later if
> needed.  It would probably also remove the need for the @ab, @numbuf,
> and @ctx variables.  For example:
> 
> audit_log(audit_context(), GFP_KERNEL, AUDIT_FANOTIFY,
>   "resp=%u fan_type=%u fan_info=%X subj_trust=%u obj_trust=%u",
>   response, friar->hdr.type, friar->rule_number,
>   friar->subj_trust, friar->obj_trust);
> 
> Am I missing something?

No, I am.  Thank you, that's much cleaner.

> > +               audit_log_format(ab, " subj_trust=%u obj_trust=%u",
> > +                                friar->subj_trust, friar->obj_trust);
> > +               audit_log_end(ab);
> > +       }
> >  }
> >
> >  void __audit_tk_injoffset(struct timespec64 offset)
> > --
> > 2.27.0
> 
> -- 
> paul-moore.com
> 
> --
> Linux-audit mailing list
> Linux-audit@redhat.com
> https://listman.redhat.com/mailman/listinfo/linux-audit
> 

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

