Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4EF67BF90
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 23:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjAYWH2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 17:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjAYWH1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 17:07:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305DB46737
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 14:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674684405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L6H4fiW4pc2uG7dEtnDNaEI9oUNyw0Lw4chXMS+HYhk=;
        b=Tvz6WK7zqNDp0vWoC9IfCyWRXn8PFyFNc0GVXQuNLQ5SCVUz26yc1FxaTairQorBw+8yMv
        ZYrXN41C8+GMBAr31B03FlMbnUUs9Gds0Dmse8Ow8HbFRyC5gNHSayUo7XlgvRyiqdKohN
        oZddxiBUd4JYjw9Bn0gxfHRBxLCMuQk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-283-lENLEuVwPKS6vrVZbdlYPA-1; Wed, 25 Jan 2023 17:06:42 -0500
X-MC-Unique: lENLEuVwPKS6vrVZbdlYPA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 93F271C02D3C;
        Wed, 25 Jan 2023 22:06:41 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-0-3.rdu2.redhat.com [10.22.0.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7AA4440C200C;
        Wed, 25 Jan 2023 22:06:27 +0000 (UTC)
Date:   Wed, 25 Jan 2023 17:06:25 -0500
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Steve Grubb <sgrubb@redhat.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v6 3/3] fanotify,audit: Allow audit to use the full
 permission event response
Message-ID: <Y9Gn4YmKFBot/R4l@madcap2.tricolour.ca>
References: <cover.1673989212.git.rgb@redhat.com>
 <82aba376bfbb9927ab7146e8e2dee8d844a31dc2.1673989212.git.rgb@redhat.com>
 <5680172.DvuYhMxLoT@x2>
 <CAHC9VhQbSCxmSbLFJZidAr952uHt-KktfRRJN3Lr+uDSCzHtfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhQbSCxmSbLFJZidAr952uHt-KktfRRJN3Lr+uDSCzHtfQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-01-20 13:52, Paul Moore wrote:
> On Wed, Jan 18, 2023 at 1:34 PM Steve Grubb <sgrubb@redhat.com> wrote:
> > Hello Richard,
> >
> > I built a new kernel and tested this with old and new user space. It is
> > working as advertised. The only thing I'm wondering about is why we have 3F
> > as the default value when no additional info was sent? Would it be better to
> > just make it 0?
> 
> ...
> 
> > On Tuesday, January 17, 2023 4:14:07 PM EST Richard Guy Briggs wrote:
> > > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > > index d1fb821de104..3133c4175c15 100644
> > > --- a/kernel/auditsc.c
> > > +++ b/kernel/auditsc.c
> > > @@ -2877,10 +2878,19 @@ void __audit_log_kern_module(char *name)
> > >       context->type = AUDIT_KERN_MODULE;
> > >  }
> > >
> > > -void __audit_fanotify(u32 response)
> > > +void __audit_fanotify(u32 response, struct
> > > fanotify_response_info_audit_rule *friar) {
> > > -     audit_log(audit_context(), GFP_KERNEL,
> > > -             AUDIT_FANOTIFY, "resp=%u", response);
> > > +     /* {subj,obj}_trust values are {0,1,2}: no,yes,unknown */
> > > +     if (friar->hdr.type == FAN_RESPONSE_INFO_NONE) {
> > > +             audit_log(audit_context(), GFP_KERNEL, AUDIT_FANOTIFY,
> > > +                       "resp=%u fan_type=%u fan_info=3F subj_trust=2
> > obj_trust=2",
> > > +                       response, FAN_RESPONSE_INFO_NONE);
> > > +             return;
> > > +     }
> 
> (I'm working under the assumption that the "fan_info=3F" in the record
> above is what Steve was referring to in his comment.)
> 
> I vaguely recall Richard commenting on this in the past, although
> maybe not ... my thought is that the "3F" is simply the hex encoded
> "?" character in ASCII ('man 7 ascii' is your friend).  I suppose the
> question is what to do in the FAN_RESPONSE_INFO_NONE case.
> 
> Historically when we had a missing field we would follow the "field=?"
> pattern, but I don't recall doing that for a field which was
> potentially hex encoded, is there an existing case where we use "?"
> for a field that is hex encoded?  If so, we can swap out the "3F" for
> a more obvious "?".

I was presuming encoding the zero: "30"

> However, another option might be to simply output the current
> AUDIT_FANOTIFY record format in the FAN_RESPONSE_INFO_NONE case, e.g.
> only "resp=%u".  This is a little against the usual guidance of
> "fields should not disappear from a record", but considering that
> userspace will always need to support the original resp-only format
> for compatibility reasons this may be an option.

I don't have a strong opinion.

> paul-moore.com

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

