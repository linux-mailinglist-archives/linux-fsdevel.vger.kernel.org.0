Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3356A529700
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 May 2022 03:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237737AbiEQB5P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 21:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbiEQB5M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 21:57:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7397D13EA3
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 18:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652752630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kOeeafra3Std2p8b6Lh4l6E2dF3DStmhC/ihedS5gIA=;
        b=e36uDj7Iagba3gWfmJKoUrvmqQ2H1QppLtm2JllqDH6pwcmaVAuYM89FOLf4hMi231WgTp
        IT7gON8ThWkO3ZkOOMqPevR+E57q9O3jCm8VV30FdWhJ7IRJ7NKO6Xe9QpGrJUC93TC5CZ
        P1UHbRqRPZ0c8WRCYeOvlOBAylDKVBc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-319-ZE2MvQIxPled__dIHmo2qw-1; Mon, 16 May 2022 21:57:09 -0400
X-MC-Unique: ZE2MvQIxPled__dIHmo2qw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CDDB58032EA;
        Tue, 17 May 2022 01:57:08 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.22.50.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 82BB5569787;
        Tue, 17 May 2022 01:57:07 +0000 (UTC)
Date:   Mon, 16 May 2022 21:57:05 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v3 3/3] fanotify: Allow audit to use the full permission
 event response
Message-ID: <YoMA8YtkNrx1YNlw@madcap2.tricolour.ca>
References: <cover.1652730821.git.rgb@redhat.com>
 <81264e038b7b1e0d8fd8bafb25452fb777cd664a.1652730821.git.rgb@redhat.com>
 <CAHC9VhSZNbQoFfStWp96G18_pdEtV1orKRvQ0reXfD7L4TiUHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhSZNbQoFfStWp96G18_pdEtV1orKRvQ0reXfD7L4TiUHA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022-05-16 21:42, Paul Moore wrote:
> On Mon, May 16, 2022 at 4:22 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> >
> > This patch passes the full value so that the audit function can use all
> > of it. The audit function was updated to log the additional information in
> > the AUDIT_FANOTIFY record. The following is an example of the new record
> > format:
> >
> > type=FANOTIFY msg=audit(1600385147.372:590): resp=2 fan_type=1 fan_ctx=17
> >
> > Suggested-by: Steve Grubb <sgrubb@redhat.com>
> > Link: https://lore.kernel.org/r/3075502.aeNJFYEL58@x2
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> >  fs/notify/fanotify/fanotify.c |  4 +++-
> >  include/linux/audit.h         |  9 +++++----
> >  kernel/auditsc.c              | 18 +++++++++++++++---
> >  3 files changed, 23 insertions(+), 8 deletions(-)
> 
> ...
> 
> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > index 6973be0bf6c9..cb93c6ed07cd 100644
> > --- a/kernel/auditsc.c
> > +++ b/kernel/auditsc.c
> > @@ -2893,10 +2894,21 @@ void __audit_log_kern_module(char *name)
> >         context->type = AUDIT_KERN_MODULE;
> >  }
> >
> > -void __audit_fanotify(u32 response)
> > +void __audit_fanotify(u32 response, u32 type, union fanotify_response_extra *info)
> >  {
> > -       audit_log(audit_context(), GFP_KERNEL,
> > -               AUDIT_FANOTIFY, "resp=%u", response);
> > +       switch (type) {
> > +       case FAN_RESPONSE_INFO_AUDIT_RULE:
> > +               audit_log(audit_context(), GFP_KERNEL, AUDIT_FANOTIFY,
> > +                         "resp=%u fan_type=%u fan_ctx=%u",
> > +                         response, type, info->audit_rule);
> > +               break;
> > +       case FAN_RESPONSE_INFO_NONE:
> > +       default:
> > +               audit_log(audit_context(), GFP_KERNEL, AUDIT_FANOTIFY,
> > +                         "resp=%u fan_type=%u fan_ctx=?",
> > +                         response, type);
> > +               break;
> > +       }
> >  }
> 
> Two things:
> 
> * Instead of "fan_ctx=", would it make sense to call it "fan_extra="
> to better match the UAPI struct?  I don't feel strongly either way,
> but it did occur to me just now while looking at the code so I thought
> I would mention it.

Yes, this is a good point.  This is the reason I changed from
FAN_RESPONSE_INFO_AUDIT_NONE to FAN_RESPONSE_INFO_NONE, anticipating
that the extra information could have nothing to do with audit.

> * I'm also wondering if there is a way to be a bit proactive about
> future proofing this field.  Since we already hex encode some fields
> with "bad" characters, would it make sense to hex encode this field
> too?  Not for the "bad" character reason, but more as a way of
> marshalling the fanotify_response_extra union into an audit record.  I
> can't see far enough into the future to know if this would be a good
> idea or not, but like the other point above, it popped into my head
> while looking at the code so I thought I would put it in the email :)

I resisted that idea because it adds overhead and makes it more complex
than currently necessary.  I'm open to it, but would like to hear
Steve's input on this.

Thanks for the quick response.

> paul-moore.com

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

