Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB295B0CA4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Sep 2022 20:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiIGSoG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Sep 2022 14:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiIGSoE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Sep 2022 14:44:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63657AE863
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Sep 2022 11:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662576241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bzUHKn9EqgfjZrfCj3UDBes0js5XMsK3DwFm/HMfd6M=;
        b=JR+bZv5ReC4XewrLnAn1e0CIUY3Z2zm5uHLGZSUN6WWLI328rWaPkonS/mRlLSdryO3mZX
        Jed16XGtW2JxHqM+NwmF03QMn+SwXV9tkneQ16P7PFvancBgCiaO1wEWqTJB2gVbszKkn4
        xDrqaG2k4+sVho0baYD0KQbSZS0ixOs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-18-8nrCJvoiPW-8sKx9JbvzBg-1; Wed, 07 Sep 2022 14:43:58 -0400
X-MC-Unique: 8nrCJvoiPW-8sKx9JbvzBg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD94929AA389;
        Wed,  7 Sep 2022 18:43:57 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.22.48.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C7EA2026D4C;
        Wed,  7 Sep 2022 18:43:56 +0000 (UTC)
Date:   Wed, 7 Sep 2022 14:43:54 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Jan Kara <jack@suse.cz>, Steve Grubb <sgrubb@redhat.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v4 3/4] fanotify,audit: Allow audit to use the full
 permission event response
Message-ID: <YxjmassY2yXOYtgo@madcap2.tricolour.ca>
References: <cover.1659996830.git.rgb@redhat.com>
 <12063373.O9o76ZdvQC@x2>
 <Yw/efLafvmimtCDq@madcap2.tricolour.ca>
 <5600292.DvuYhMxLoT@x2>
 <CAHC9VhSPS7dRXLU9eV3Ne6Q7q=GPpak+=QRYLa_8Z4i-fESz8w@mail.gmail.com>
 <20220901075158.jqwaz3pklf3rqc6q@quack3>
 <CAHC9VhStnE9vGu9h5tHnS58eyb8vm8rMN4miXpLAG6fFnidD=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhStnE9vGu9h5tHnS58eyb8vm8rMN4miXpLAG6fFnidD=w@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022-09-01 14:31, Paul Moore wrote:
> On Thu, Sep 1, 2022 at 3:52 AM Jan Kara <jack@suse.cz> wrote:
> > On Wed 31-08-22 21:47:09, Paul Moore wrote:
> > > On Wed, Aug 31, 2022 at 7:55 PM Steve Grubb <sgrubb@redhat.com> wrote:
> > > > On Wednesday, August 31, 2022 6:19:40 PM EDT Richard Guy Briggs wrote:
> > > > > On 2022-08-31 17:25, Steve Grubb wrote:
> > > > > > On Wednesday, August 31, 2022 5:07:25 PM EDT Richard Guy Briggs wrote:
> > > > > > > > > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > > > > > > > > index 433418d73584..f000fec52360 100644
> > > > > > > > > --- a/kernel/auditsc.c
> > > > > > > > > +++ b/kernel/auditsc.c
> > > > > > > > > @@ -64,6 +64,7 @@
> > > > > > > > > #include <uapi/linux/limits.h>
> > > > > > > > > #include <uapi/linux/netfilter/nf_tables.h>
> > > > > > > > > #include <uapi/linux/openat2.h> // struct open_how
> > > > > > > > > +#include <uapi/linux/fanotify.h>
> > > > > > > > >
> > > > > > > > > #include "audit.h"
> > > > > > > > >
> > > > > > > > > @@ -2899,10 +2900,34 @@ void __audit_log_kern_module(char *name)
> > > > > > > > > context->type = AUDIT_KERN_MODULE;
> > > > > > > > > }
> > > > > > > > >
> > > > > > > > > -void __audit_fanotify(u32 response)
> > > > > > > > > +void __audit_fanotify(u32 response, size_t len, char *buf)
> > > > > > > > > {
> > > > > > > > > -       audit_log(audit_context(), GFP_KERNEL,
> > > > > > > > > -               AUDIT_FANOTIFY, "resp=%u", response);
> > > > > > > > > +       struct fanotify_response_info_audit_rule *friar;
> > > > > > > > > +       size_t c = len;
> > > > > > > > > +       char *ib = buf;
> > > > > > > > > +
> > > > > > > > > +       if (!(len && buf)) {
> > > > > > > > > +               audit_log(audit_context(), GFP_KERNEL,
> > > > > > > > > AUDIT_FANOTIFY,
> > > > > > > > > +                         "resp=%u fan_type=0 fan_info=?",
> > > > > > > > > response);
> > > > > > > > > +               return;
> > > > > > > > > +       }
> > > > > > > > > +       while (c >= sizeof(struct fanotify_response_info_header)) {
> > > > > > > > > +               friar = (struct fanotify_response_info_audit_rule
> > > > > > > > > *)buf;
> > > > > > > >
> > > > > > > > Since the only use of this at the moment is the
> > > > > > > > fanotify_response_info_rule, why not pass the
> > > > > > > > fanotify_response_info_rule struct directly into this function?  We
> > > > > > > > can always change it if we need to in the future without affecting
> > > > > > > > userspace, and it would simplify the code.
> > > > > > >
> > > > > > > Steve, would it make any sense for there to be more than one
> > > > > > > FAN_RESPONSE_INFO_AUDIT_RULE header in a message?  Could there be more
> > > > > > > than one rule that contributes to a notify reason?  If not, would it be
> > > > > > > reasonable to return -EINVAL if there is more than one?
> > > > > >
> > > > > > I don't see a reason for sending more than one header. What is more
> > > > > > probable is the need to send additional data in that header. I was
> > > > > > thinking of maybe bit mapping it in the rule number. But I'd suggest
> > > > > > padding the struct just in case it needs expanding some day.
> > > > >
> > > > > This doesn't exactly answer my question about multiple rules
> > > > > contributing to one decision.
> > > >
> > > > I don't forsee that.
> > > >
> > > > > The need for more as yet undefined information sounds like a good reason
> > > > > to define a new header if that happens.
> > > >
> > > > It's much better to pad the struct so that the size doesn't change.
> > > >
> > > > > At this point, is it reasonable to throw an error if more than one RULE
> > > > > header appears in a message?
> > > >
> > > > It is a write syscall. I'd silently discard everything else and document that
> > > > in the man pages. But the fanotify maintainers should really weigh in on
> > > > this.
> > > >
> > > > > The way I had coded this last patchset was to allow for more than one RULE
> > > > > header and each one would get its own record in the event.
> > > >
> > > > I do not forsee a need for this.
> > > >
> > > > > How many rules total are likely to exist?
> > > >
> > > > Could be a thousand. But I already know some missing information we'd like to
> > > > return to user space in an audit event, so the bit mapping on the rule number
> > > > might happen. I'd suggest padding one u32 for future use.
> > >
> > > A better way to handle an expansion like that would be to have a
> > > length/version field at the top of the struct that could be used to
> > > determine the size and layout of the struct.
> >
> > We already do have the 'type' and 'len' fields in
> > struct fanotify_response_info_header. So if audit needs to pass more
> > information, we can define a new 'type' and either make it replace the
> > current struct fanotify_response_info_audit_rule or make it expand the
> > information in it. At least this is how we handle similar situation when
> > fanotify wants to report some new bits of information to userspace.
> 
> Perfect, I didn't know that was an option from the fanotify side; I
> agree that's the right approach.

This is what I expected would be the way to manage changing
requirements.

> > That being said if audit wants to have u32 pad in its struct
> > fanotify_response_info_audit_rule for future "optional" expansion I'm not
> > strictly opposed to that but I don't think it is a good idea.
> 
> Yes, I'm not a fan of padding out this way, especially when we have
> better options.

Agreed.

> > Ultimately I guess I'll leave it upto audit subsystem what it wants to have
> > in its struct fanotify_response_info_audit_rule because for fanotify
> > subsystem, it is just an opaque blob it is passing.
> 
> In that case, let's stick with leveraging the type/len fields in the
> fanotify_response_info_header struct, that should give us all the
> flexibility we need.
> 
> Richard and Steve, it sounds like Steve is already aware of additional
> information that he wants to send via the
> fanotify_response_info_audit_rule struct, please include that in the
> next revision of this patchset.  I don't want to get this merged and
> then soon after have to hack in additional info.

Steve, please define the type and name of this additional field.

I'm not particularly enthusiastic of "u32 pad;"

> paul-moore.com

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

