Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF155A8B0A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 03:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbiIABrZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 21:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbiIABrW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 21:47:22 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE80AE21D
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Aug 2022 18:47:21 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-11ee4649dfcso21946499fac.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Aug 2022 18:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=TlN3L7u+wXIinFsuYqdK27x2WtBpHcllYjmImCLuHAQ=;
        b=K1OeB1YszbZTqWguTLKSaKYwSr3mt4ww03N3PZsfia1GxvfsN1Vr3pwWf8GoktXXX9
         ozwgxAa2ZfMOrzcUVIVZhdGYMC5BPpCdf0WfGLz/ywPkLp7kp6goP7wt0TDbmv6L/Kka
         L3+hS3CC6sEp3kgIonBvcts8dAPIWeJbM7fmr7qoxpUNeXcs03/ewiiWBknnzftkoHNZ
         lAvbk/LdDbeP8Mm7B+F0SKaaYRE9cKWDdoXHcKhfvM7mmPF/BPyGa+o8SYQgqjf/hRpn
         O2zu+/QyMKgNre9l59JqIxrboEDqP/k9kWl26cd4a8eTjU1tbRf953RGX9S9YViz+mmy
         sN2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=TlN3L7u+wXIinFsuYqdK27x2WtBpHcllYjmImCLuHAQ=;
        b=TqUWjekNG2VFX2kfeh9B6tOAPGISdku3Q6mTcOUB9H1+ek+BrhUjWDZAXu3TEy2tfQ
         JruulQI7CuOVRmDxCi8+NCoJRfAFheoiIbTztOvOn+NpQIA21cJzA8CHsm0J9dy5+Dwl
         pPya4PMi/NfRKLV4BTr6NA9L+fDq0R+1JmAvLjiQO+WaBqx0a1CbrVcxKwJzP5r/A7OB
         yPXgpRi2fZg/H9S8THhU5EhV371ZqIM/lk5ge4BGJ3WZq73fJk8ZUbMzB1FbTanLEJ2O
         SEz6XAjnkp94JzoJOxeXDtNcdY+xrKJAHFn4vvssUhQdWpI7FywJftjyNoRrUsAcoIbh
         vesw==
X-Gm-Message-State: ACgBeo3L91nIBGWbNzNu/jcMY4vjJS/lAQ0kwaNpl/HWqRhm2eyqOpft
        GBeotYo3wr0g1I2syv8ODGv55kYcGnnNwCYPiJ5S
X-Google-Smtp-Source: AA6agR5gFuM289TBrDS25LgdOwxYckt1TdnxQ0qi8OPF99N5aCotlFsRQ/Axj8r2vSdySNWWcR+s751K/eVL4geaf8s=
X-Received: by 2002:a05:6871:796:b0:11e:b92e:731e with SMTP id
 o22-20020a056871079600b0011eb92e731emr2981881oap.41.1661996840312; Wed, 31
 Aug 2022 18:47:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1659996830.git.rgb@redhat.com> <12063373.O9o76ZdvQC@x2>
 <Yw/efLafvmimtCDq@madcap2.tricolour.ca> <5600292.DvuYhMxLoT@x2>
In-Reply-To: <5600292.DvuYhMxLoT@x2>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 31 Aug 2022 21:47:09 -0400
Message-ID: <CAHC9VhSPS7dRXLU9eV3Ne6Q7q=GPpak+=QRYLa_8Z4i-fESz8w@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] fanotify,audit: Allow audit to use the full
 permission event response
To:     Steve Grubb <sgrubb@redhat.com>
Cc:     Richard Guy Briggs <rgb@redhat.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 31, 2022 at 7:55 PM Steve Grubb <sgrubb@redhat.com> wrote:
> On Wednesday, August 31, 2022 6:19:40 PM EDT Richard Guy Briggs wrote:
> > On 2022-08-31 17:25, Steve Grubb wrote:
> > > On Wednesday, August 31, 2022 5:07:25 PM EDT Richard Guy Briggs wrote:
> > > > > > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > > > > > index 433418d73584..f000fec52360 100644
> > > > > > --- a/kernel/auditsc.c
> > > > > > +++ b/kernel/auditsc.c
> > > > > > @@ -64,6 +64,7 @@
> > > > > > #include <uapi/linux/limits.h>
> > > > > > #include <uapi/linux/netfilter/nf_tables.h>
> > > > > > #include <uapi/linux/openat2.h> // struct open_how
> > > > > > +#include <uapi/linux/fanotify.h>
> > > > > >
> > > > > > #include "audit.h"
> > > > > >
> > > > > > @@ -2899,10 +2900,34 @@ void __audit_log_kern_module(char *name)
> > > > > > context->type = AUDIT_KERN_MODULE;
> > > > > > }
> > > > > >
> > > > > > -void __audit_fanotify(u32 response)
> > > > > > +void __audit_fanotify(u32 response, size_t len, char *buf)
> > > > > > {
> > > > > > -       audit_log(audit_context(), GFP_KERNEL,
> > > > > > -               AUDIT_FANOTIFY, "resp=%u", response);
> > > > > > +       struct fanotify_response_info_audit_rule *friar;
> > > > > > +       size_t c = len;
> > > > > > +       char *ib = buf;
> > > > > > +
> > > > > > +       if (!(len && buf)) {
> > > > > > +               audit_log(audit_context(), GFP_KERNEL,
> > > > > > AUDIT_FANOTIFY,
> > > > > > +                         "resp=%u fan_type=0 fan_info=?",
> > > > > > response);
> > > > > > +               return;
> > > > > > +       }
> > > > > > +       while (c >= sizeof(struct fanotify_response_info_header)) {
> > > > > > +               friar = (struct fanotify_response_info_audit_rule
> > > > > > *)buf;
> > > > >
> > > > > Since the only use of this at the moment is the
> > > > > fanotify_response_info_rule, why not pass the
> > > > > fanotify_response_info_rule struct directly into this function?  We
> > > > > can always change it if we need to in the future without affecting
> > > > > userspace, and it would simplify the code.
> > > >
> > > > Steve, would it make any sense for there to be more than one
> > > > FAN_RESPONSE_INFO_AUDIT_RULE header in a message?  Could there be more
> > > > than one rule that contributes to a notify reason?  If not, would it be
> > > > reasonable to return -EINVAL if there is more than one?
> > >
> > > I don't see a reason for sending more than one header. What is more
> > > probable is the need to send additional data in that header. I was
> > > thinking of maybe bit mapping it in the rule number. But I'd suggest
> > > padding the struct just in case it needs expanding some day.
> >
> > This doesn't exactly answer my question about multiple rules
> > contributing to one decision.
>
> I don't forsee that.
>
> > The need for more as yet undefined information sounds like a good reason
> > to define a new header if that happens.
>
> It's much better to pad the struct so that the size doesn't change.
>
> > At this point, is it reasonable to throw an error if more than one RULE
> > header appears in a message?
>
> It is a write syscall. I'd silently discard everything else and document that
> in the man pages. But the fanotify maintainers should really weigh in on
> this.
>
> > The way I had coded this last patchset was to allow for more than one RULE
> > header and each one would get its own record in the event.
>
> I do not forsee a need for this.
>
> > How many rules total are likely to exist?
>
> Could be a thousand. But I already know some missing information we'd like to
> return to user space in an audit event, so the bit mapping on the rule number
> might happen. I'd suggest padding one u32 for future use.

A better way to handle an expansion like that would be to have a
length/version field at the top of the struct that could be used to
determine the size and layout of the struct.

However, to be clear, my original suggestion of passing the
fanotify_response_info_rule struct internally didn't require any
additional future proofing as it is an internal implementation detail
and not something that is exposed to userspace; the function arguments
could be changed in the future and not break userspace.  I'm not quite
sure how we ended up on this topic ...

-- 
paul-moore.com
