Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C8867BFA8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 23:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbjAYWMS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 17:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235078AbjAYWMR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 17:12:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF264709F
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 14:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674684693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iKaw5K66IYLWoQpT7msMlzdao9NdQF8OSPOcAVbHp9o=;
        b=fdxzOT1ovYwQqhF9srUBbgio0dC01NEWap3y7HLnKSA5jdgjlobgU9dUxG+ly7+WuvdiOY
        5sorjHHOp22MsrHtIWw2E1DsJF+gGkaYP92Ar6uo9bTGH166Y3duNVfxiUFE86lzH+1dbo
        aO6BNAFJpdmhNTWB+xcR7USUv5lHfhI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-vEZWpfZ2ON6qGO4ioYqlUg-1; Wed, 25 Jan 2023 17:11:30 -0500
X-MC-Unique: vEZWpfZ2ON6qGO4ioYqlUg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD700811E9C;
        Wed, 25 Jan 2023 22:11:29 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-0-3.rdu2.redhat.com [10.22.0.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6096414171BB;
        Wed, 25 Jan 2023 22:11:28 +0000 (UTC)
Date:   Wed, 25 Jan 2023 17:11:26 -0500
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v6 3/3] fanotify,audit: Allow audit to use the full
 permission event response
Message-ID: <Y9GpDpjlwBr+ZTWm@madcap2.tricolour.ca>
References: <cover.1673989212.git.rgb@redhat.com>
 <82aba376bfbb9927ab7146e8e2dee8d844a31dc2.1673989212.git.rgb@redhat.com>
 <CAHC9VhTgesdmF3-+oP-EYuNZ-8LKXGPYuSffVst_Wca5Oj0EAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhTgesdmF3-+oP-EYuNZ-8LKXGPYuSffVst_Wca5Oj0EAQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-01-20 13:58, Paul Moore wrote:
> On Tue, Jan 17, 2023 at 4:14 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> >
> > This patch passes the full response so that the audit function can use all
> > of it. The audit function was updated to log the additional information in
> > the AUDIT_FANOTIFY record.
> >
> > Currently the only type of fanotify info that is defined is an audit
> > rule number, but convert it to hex encoding to future-proof the field.
> > Hex encoding suggested by Paul Moore <paul@paul-moore.com>.
> >
> > The {subj,obj}_trust values are {0,1,2}, corresponding to no, yes, unknown.
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
> >  kernel/auditsc.c              | 16 +++++++++++++---
> >  3 files changed, 20 insertions(+), 8 deletions(-)
> 
> ...
> 
> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > index d1fb821de104..3133c4175c15 100644
> > --- a/kernel/auditsc.c
> > +++ b/kernel/auditsc.c
> > @@ -2877,10 +2878,19 @@ void __audit_log_kern_module(char *name)
> >         context->type = AUDIT_KERN_MODULE;
> >  }
> >
> > -void __audit_fanotify(u32 response)
> > +void __audit_fanotify(u32 response, struct fanotify_response_info_audit_rule *friar)
> >  {
> > -       audit_log(audit_context(), GFP_KERNEL,
> > -               AUDIT_FANOTIFY, "resp=%u", response);
> > +       /* {subj,obj}_trust values are {0,1,2}: no,yes,unknown */
> > +       if (friar->hdr.type == FAN_RESPONSE_INFO_NONE) {
> > +               audit_log(audit_context(), GFP_KERNEL, AUDIT_FANOTIFY,
> > +                         "resp=%u fan_type=%u fan_info=3F subj_trust=2 obj_trust=2",
> > +                         response, FAN_RESPONSE_INFO_NONE);
> > +               return;
> > +       }
> > +       audit_log(audit_context(), GFP_KERNEL, AUDIT_FANOTIFY,
> > +                 "resp=%u fan_type=%u fan_info=%X subj_trust=%u obj_trust=%u",
> > +                 response, friar->hdr.type, friar->rule_number,
> > +                 friar->subj_trust, friar->obj_trust);
> >  }
> 
> The only thing that comes to mind might be to convert the if-return
> into a switch statement to make it a bit cleaner and easier to patch
> in the future, but that is soooo far removed from any real concern
> that I debated even mentioning it.  I only bring it up in case the
> "3F" discussion results in a respin, and even then I'm not going to
> hold my ACK over something as silly as a if-return vs switch.
> 
> For clarity, this is what I was thinking:
> 
> void __audit_fanontify(...)
> {
>   switch (type) {
>   case FAN_RESPONSE_INFO_NONE:
>     audit_log(...);
>     break;
>   default:
>     audit_log(...);
>   }
> }

I agree that would be cleaner, but FAN_RESPONSE_INFO_NONE and
FAN_RESPONSE_INFO_AUDIT_RULE would be the two, with default being
ignored since they could be other types unrelated to audit.

There were a number of bits of code to future proof it in previous
versions that were questioned as necessary so they were removed...

> paul-moore.com

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

