Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19075A880E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Aug 2022 23:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbiHaVZ1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 17:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbiHaVZX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 17:25:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AB654C87
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Aug 2022 14:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661981120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bk+OPu/NawbDQQta/l48V8vREhMx8JycdlrQ1DTyT80=;
        b=fvTrvhRfw+XcjNFEAKWMbWRd7mF8zHvolxJcoDtutgoC0pb5P4MBqK+2CvrNRw+GA1wflM
        MAzqpQ4tsX0BYOK7Gtu2Dd5xcyOfcdUjH6JT1OCWjjsGgCFMWGtqAGAazjBkX4QxG6+znX
        /OJpJ3AEvNxG/M4cpmziel7sIpFK7uo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-216-sTGYnmzPOG6-e8ra5mqDsw-1; Wed, 31 Aug 2022 17:25:17 -0400
X-MC-Unique: sTGYnmzPOG6-e8ra5mqDsw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C102985A585;
        Wed, 31 Aug 2022 21:25:16 +0000 (UTC)
Received: from x2.localnet (unknown [10.22.33.226])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A3232026D4C;
        Wed, 31 Aug 2022 21:25:16 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v4 3/4] fanotify,audit: Allow audit to use the full permission event response
Date:   Wed, 31 Aug 2022 17:25:15 -0400
Message-ID: <12063373.O9o76ZdvQC@x2>
Organization: Red Hat
In-Reply-To: <Yw/NjYytoMUdbxuR@madcap2.tricolour.ca>
References: <cover.1659996830.git.rgb@redhat.com> <CAHC9VhT0D=qtaYR-Ve1hRTtQXspuC09qQZyFdESj-tQstyvMFg@mail.gmail.com> <Yw/NjYytoMUdbxuR@madcap2.tricolour.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wednesday, August 31, 2022 5:07:25 PM EDT Richard Guy Briggs wrote:
> > > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > > index 433418d73584..f000fec52360 100644
> > > --- a/kernel/auditsc.c
> > > +++ b/kernel/auditsc.c
> > > @@ -64,6 +64,7 @@
> > > #include <uapi/linux/limits.h>
> > > #include <uapi/linux/netfilter/nf_tables.h>
> > > #include <uapi/linux/openat2.h> // struct open_how
> > > +#include <uapi/linux/fanotify.h>
> > > 
> > > #include "audit.h"
> > > 
> > > @@ -2899,10 +2900,34 @@ void __audit_log_kern_module(char *name)
> > > context->type = AUDIT_KERN_MODULE;
> > > }
> > > 
> > > -void __audit_fanotify(u32 response)
> > > +void __audit_fanotify(u32 response, size_t len, char *buf)
> > > {
> > > -       audit_log(audit_context(), GFP_KERNEL,
> > > -               AUDIT_FANOTIFY, "resp=%u", response);
> > > +       struct fanotify_response_info_audit_rule *friar;
> > > +       size_t c = len;
> > > +       char *ib = buf;
> > > +
> > > +       if (!(len && buf)) {
> > > +               audit_log(audit_context(), GFP_KERNEL, AUDIT_FANOTIFY,
> > > +                         "resp=%u fan_type=0 fan_info=?", response);
> > > +               return;
> > > +       }
> > > +       while (c >= sizeof(struct fanotify_response_info_header)) {
> > > +               friar = (struct fanotify_response_info_audit_rule
> > > *)buf;
> > 
> > Since the only use of this at the moment is the
> > fanotify_response_info_rule, why not pass the
> > fanotify_response_info_rule struct directly into this function?  We
> > can always change it if we need to in the future without affecting
> > userspace, and it would simplify the code.
> 
> Steve, would it make any sense for there to be more than one
> FAN_RESPONSE_INFO_AUDIT_RULE header in a message?  Could there be more
> than one rule that contributes to a notify reason?  If not, would it be
> reasonable to return -EINVAL if there is more than one?

I don't see a reason for sending more than one header. What is more probable 
is the need to send additional data in that header. I was thinking of maybe 
bit mapping it in the rule number. But I'd suggest padding the struct just in 
case it needs expanding some day.

-Steev



