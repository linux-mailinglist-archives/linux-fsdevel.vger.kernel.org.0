Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21325A9141
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 09:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbiIAHxF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 03:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234151AbiIAHwn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:52:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F261267CB9;
        Thu,  1 Sep 2022 00:52:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 45CF81FB6B;
        Thu,  1 Sep 2022 07:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662018722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z91wuXCFrsBOMQUt2qaRkpJ41f+MP9CEbGjWPtUri3E=;
        b=19qjTaWuK3qc7WFpw99UQF+Td49TCGHEMJWv7+jqjLgoRcmHkoRpSfeY+6LkEEW2XAj2B1
        OBXflpXnckh2mZ/DeEyfmn0UOsPnbz+21v6DPff7GlLrWb7meQEgbbHMkMj8u/cx6PVAf2
        vYMaSAWqUCCjyRcLf49L1i02ECMA1HI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662018722;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z91wuXCFrsBOMQUt2qaRkpJ41f+MP9CEbGjWPtUri3E=;
        b=n6ZhA9oYQmcsxxgoFj2HNza01CMS9fmw83q9+Dc/7yrrtIsfmjn1+emrfG449blSZB5DCJ
        UQuga+sJ4I5KDQBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ED85313A89;
        Thu,  1 Sep 2022 07:52:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7XhzOaFkEGMQGQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 01 Sep 2022 07:52:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7BD91A067C; Thu,  1 Sep 2022 09:51:58 +0200 (CEST)
Date:   Thu, 1 Sep 2022 09:51:58 +0200
From:   Jan Kara <jack@suse.cz>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Steve Grubb <sgrubb@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v4 3/4] fanotify,audit: Allow audit to use the full
 permission event response
Message-ID: <20220901075158.jqwaz3pklf3rqc6q@quack3>
References: <cover.1659996830.git.rgb@redhat.com>
 <12063373.O9o76ZdvQC@x2>
 <Yw/efLafvmimtCDq@madcap2.tricolour.ca>
 <5600292.DvuYhMxLoT@x2>
 <CAHC9VhSPS7dRXLU9eV3Ne6Q7q=GPpak+=QRYLa_8Z4i-fESz8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhSPS7dRXLU9eV3Ne6Q7q=GPpak+=QRYLa_8Z4i-fESz8w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 31-08-22 21:47:09, Paul Moore wrote:
> On Wed, Aug 31, 2022 at 7:55 PM Steve Grubb <sgrubb@redhat.com> wrote:
> > On Wednesday, August 31, 2022 6:19:40 PM EDT Richard Guy Briggs wrote:
> > > On 2022-08-31 17:25, Steve Grubb wrote:
> > > > On Wednesday, August 31, 2022 5:07:25 PM EDT Richard Guy Briggs wrote:
> > > > > > > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > > > > > > index 433418d73584..f000fec52360 100644
> > > > > > > --- a/kernel/auditsc.c
> > > > > > > +++ b/kernel/auditsc.c
> > > > > > > @@ -64,6 +64,7 @@
> > > > > > > #include <uapi/linux/limits.h>
> > > > > > > #include <uapi/linux/netfilter/nf_tables.h>
> > > > > > > #include <uapi/linux/openat2.h> // struct open_how
> > > > > > > +#include <uapi/linux/fanotify.h>
> > > > > > >
> > > > > > > #include "audit.h"
> > > > > > >
> > > > > > > @@ -2899,10 +2900,34 @@ void __audit_log_kern_module(char *name)
> > > > > > > context->type = AUDIT_KERN_MODULE;
> > > > > > > }
> > > > > > >
> > > > > > > -void __audit_fanotify(u32 response)
> > > > > > > +void __audit_fanotify(u32 response, size_t len, char *buf)
> > > > > > > {
> > > > > > > -       audit_log(audit_context(), GFP_KERNEL,
> > > > > > > -               AUDIT_FANOTIFY, "resp=%u", response);
> > > > > > > +       struct fanotify_response_info_audit_rule *friar;
> > > > > > > +       size_t c = len;
> > > > > > > +       char *ib = buf;
> > > > > > > +
> > > > > > > +       if (!(len && buf)) {
> > > > > > > +               audit_log(audit_context(), GFP_KERNEL,
> > > > > > > AUDIT_FANOTIFY,
> > > > > > > +                         "resp=%u fan_type=0 fan_info=?",
> > > > > > > response);
> > > > > > > +               return;
> > > > > > > +       }
> > > > > > > +       while (c >= sizeof(struct fanotify_response_info_header)) {
> > > > > > > +               friar = (struct fanotify_response_info_audit_rule
> > > > > > > *)buf;
> > > > > >
> > > > > > Since the only use of this at the moment is the
> > > > > > fanotify_response_info_rule, why not pass the
> > > > > > fanotify_response_info_rule struct directly into this function?  We
> > > > > > can always change it if we need to in the future without affecting
> > > > > > userspace, and it would simplify the code.
> > > > >
> > > > > Steve, would it make any sense for there to be more than one
> > > > > FAN_RESPONSE_INFO_AUDIT_RULE header in a message?  Could there be more
> > > > > than one rule that contributes to a notify reason?  If not, would it be
> > > > > reasonable to return -EINVAL if there is more than one?
> > > >
> > > > I don't see a reason for sending more than one header. What is more
> > > > probable is the need to send additional data in that header. I was
> > > > thinking of maybe bit mapping it in the rule number. But I'd suggest
> > > > padding the struct just in case it needs expanding some day.
> > >
> > > This doesn't exactly answer my question about multiple rules
> > > contributing to one decision.
> >
> > I don't forsee that.
> >
> > > The need for more as yet undefined information sounds like a good reason
> > > to define a new header if that happens.
> >
> > It's much better to pad the struct so that the size doesn't change.
> >
> > > At this point, is it reasonable to throw an error if more than one RULE
> > > header appears in a message?
> >
> > It is a write syscall. I'd silently discard everything else and document that
> > in the man pages. But the fanotify maintainers should really weigh in on
> > this.
> >
> > > The way I had coded this last patchset was to allow for more than one RULE
> > > header and each one would get its own record in the event.
> >
> > I do not forsee a need for this.
> >
> > > How many rules total are likely to exist?
> >
> > Could be a thousand. But I already know some missing information we'd like to
> > return to user space in an audit event, so the bit mapping on the rule number
> > might happen. I'd suggest padding one u32 for future use.
> 
> A better way to handle an expansion like that would be to have a
> length/version field at the top of the struct that could be used to
> determine the size and layout of the struct.

We already do have the 'type' and 'len' fields in
struct fanotify_response_info_header. So if audit needs to pass more
information, we can define a new 'type' and either make it replace the
current struct fanotify_response_info_audit_rule or make it expand the
information in it. At least this is how we handle similar situation when
fanotify wants to report some new bits of information to userspace.

That being said if audit wants to have u32 pad in its struct
fanotify_response_info_audit_rule for future "optional" expansion I'm not
strictly opposed to that but I don't think it is a good idea. It is tricky
to safely start using the new field. Audit subsystem can define that the
kernel currently just ignores the field. And new kernel could start using
the passed information in the additional field but that is somewhat risky
because until that moment userspace can be passing random garbage in that
unused field and thus break when running on new kernel that tries to make
sense of it. Sure you can say it is broken userspace that does not properly
initialize the padding field but history has shown us multiple times that
events like these do happen and the breakage was unpleasant enough for
users that the kernel just had to revert back to ignoring the field.

Alternatively the kernel could bail with error if the new field is non-zero
but that would block new userspace using that field from running on old
kernel. But presumably the new userspace could be handling the error and
writing another response with new field zeroed out. That would be a safe
option although not very different from defining a new response type.

Ultimately I guess I'll leave it upto audit subsystem what it wants to have
in its struct fanotify_response_info_audit_rule because for fanotify
subsystem, it is just an opaque blob it is passing.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
