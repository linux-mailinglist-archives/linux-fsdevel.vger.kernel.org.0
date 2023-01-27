Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5F667EF6D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jan 2023 21:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbjA0USg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Jan 2023 15:18:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjA0USf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Jan 2023 15:18:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C183C2F
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Jan 2023 12:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674850667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oLsww4nMT853aLsRUstJw7Wj+WfXpD2FfDEM08ruJd4=;
        b=Y+s37APEHbhPgIbwv8WYCesKp4vP6DJTwKpeG3osZP5BpifD8pDwDuvL8MoNiWA8Q5ZGkQ
        X3J4eDyOqOzT1wUmphAyKebYyuskGnwyhAT2MBkYMTo4Hkw6AgAnRI1fW101oQ1Ar7Sse/
        Ov6eokWpwgkgwymcszdLEKzxuwGOarI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-231-WmTIcNZyMNiL4Bo4k-7h-g-1; Fri, 27 Jan 2023 15:17:43 -0500
X-MC-Unique: WmTIcNZyMNiL4Bo4k-7h-g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 852063806703;
        Fri, 27 Jan 2023 20:17:42 +0000 (UTC)
Received: from x2.localnet (unknown [10.22.33.250])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 172D214171BE;
        Fri, 27 Jan 2023 20:17:42 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     Richard Guy Briggs <rgb@redhat.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v6 3/3] fanotify,audit: Allow audit to use the full permission
 event response
Date:   Fri, 27 Jan 2023 15:17:41 -0500
Message-ID: <12154220.O9o76ZdvQC@x2>
Organization: Red Hat
In-Reply-To: <CAHC9VhRWDD6Tk6AEmgoobBkcVKRYbVOte7-F0TGJD2dRk7NKxw@mail.gmail.com>
References: <cover.1673989212.git.rgb@redhat.com> <Y9Gn4YmKFBot/R4l@madcap2.tricolour.ca>
 <CAHC9VhRWDD6Tk6AEmgoobBkcVKRYbVOte7-F0TGJD2dRk7NKxw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
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

On Friday, January 27, 2023 3:00:37 PM EST Paul Moore wrote:
> On Wed, Jan 25, 2023 at 5:06 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > On 2023-01-20 13:52, Paul Moore wrote:
> > > On Wed, Jan 18, 2023 at 1:34 PM Steve Grubb <sgrubb@redhat.com> wrote:
> > > > Hello Richard,
> > > > 
> > > > I built a new kernel and tested this with old and new user space. It
> > > > is
> > > > working as advertised. The only thing I'm wondering about is why we
> > > > have 3F as the default value when no additional info was sent? Would
> > > > it be better to just make it 0?
> > > 
> > > ...
> > > 
> > > > On Tuesday, January 17, 2023 4:14:07 PM EST Richard Guy Briggs wrote:
> > > > > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > > > > index d1fb821de104..3133c4175c15 100644
> > > > > --- a/kernel/auditsc.c
> > > > > +++ b/kernel/auditsc.c
> > > > > @@ -2877,10 +2878,19 @@ void __audit_log_kern_module(char *name)
> > > > > 
> > > > >       context->type = AUDIT_KERN_MODULE;
> > > > >  
> > > > >  }
> > > > > 
> > > > > -void __audit_fanotify(u32 response)
> > > > > +void __audit_fanotify(u32 response, struct
> > > > > fanotify_response_info_audit_rule *friar) {
> > > > > -     audit_log(audit_context(), GFP_KERNEL,
> > > > > -             AUDIT_FANOTIFY, "resp=%u", response);
> > > > > +     /* {subj,obj}_trust values are {0,1,2}: no,yes,unknown */
> > > > > +     if (friar->hdr.type == FAN_RESPONSE_INFO_NONE) {
> > > > > +             audit_log(audit_context(), GFP_KERNEL,
> > > > > AUDIT_FANOTIFY,
> > > > > +                       "resp=%u fan_type=%u fan_info=3F
> > > > > subj_trust=2
> > > > 
> > > > obj_trust=2",
> > > > 
> > > > > +                       response, FAN_RESPONSE_INFO_NONE);
> > > > > +             return;
> > > > > +     }
> > > 
> > > (I'm working under the assumption that the "fan_info=3F" in the record
> > > above is what Steve was referring to in his comment.)
> > > 
> > > I vaguely recall Richard commenting on this in the past, although
> > > maybe not ... my thought is that the "3F" is simply the hex encoded
> > > "?" character in ASCII ('man 7 ascii' is your friend).  I suppose the
> > > question is what to do in the FAN_RESPONSE_INFO_NONE case.
> > > 
> > > Historically when we had a missing field we would follow the "field=?"
> > > pattern, but I don't recall doing that for a field which was
> > > potentially hex encoded, is there an existing case where we use "?"
> > > for a field that is hex encoded?  If so, we can swap out the "3F" for
> > > a more obvious "?".
> > 
> > I was presuming encoding the zero: "30"
> 
> I'm sorry, but you've lost me here.
> 
> > > However, another option might be to simply output the current
> > > AUDIT_FANOTIFY record format in the FAN_RESPONSE_INFO_NONE case, e.g.
> > > only "resp=%u".  This is a little against the usual guidance of
> > > "fields should not disappear from a record", but considering that
> > > userspace will always need to support the original resp-only format
> > > for compatibility reasons this may be an option.
> > 
> > I don't have a strong opinion.
> 
> I'm not sure I care too much either.  I will admit that the "3F" seems
> to be bordering on the "bit too clever" side of things, but it's easy
> to argue it is in keeping with the general idea of using "?" to denote
> absent/unknown fields.

The translation will be from %X to %u. In that case, someone might think 63 
has some meaning. It would be better to leave it as 0 so there's less to 
explain.

-Steve

> As Steve was the one who raised the question in this latest round, and
> he knows his userspace tools the best, it seems wise to get his input
> on this.




