Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD7A518FB1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 May 2022 23:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242561AbiECVEb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 May 2022 17:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242519AbiECVEa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 May 2022 17:04:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 87290403C1
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 May 2022 14:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651611655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W0guGAldQB5KyhWnZqV+vskGtqofacsrTLuN/TwuX68=;
        b=GyjL8fz8z5/aF4QtFFj2zm/f1N2XvuKnEsEAMdrh0/MExoGjqobqTij2QTh8TN1FJ1VMi2
        WSKAMdu/m/FwkHVXUt82m9GhFKyNWWsjwgZPL9c5LH/W2aHrnMnjcrMkAEPTJpKpeglwST
        UPgMFwM3J2CwlXv4fBbuXiEiQCF4Gno=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-290-4D5vl5MYPfqCnRq-saq1nA-1; Tue, 03 May 2022 17:00:52 -0400
X-MC-Unique: 4D5vl5MYPfqCnRq-saq1nA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E522A29AB3E9;
        Tue,  3 May 2022 21:00:51 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.22.48.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C03135523CA;
        Tue,  3 May 2022 21:00:50 +0000 (UTC)
Date:   Tue, 3 May 2022 17:00:47 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2 0/3] fanotify: Allow user space to pass back
 additional audit info
Message-ID: <YnGX/6BmTV6X5v1q@madcap2.tricolour.ca>
References: <cover.1651174324.git.rgb@redhat.com>
 <Yms3hVYSRD1zT+Rz@madcap2.tricolour.ca>
 <CAHC9VhSGda5NofudLtsKspPjGc9bnZd=DZL9Mo-PJtJbb9RO4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhSGda5NofudLtsKspPjGc9bnZd=DZL9Mo-PJtJbb9RO4w@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022-05-02 20:16, Paul Moore wrote:
> On Thu, Apr 28, 2022 at 8:55 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > On 2022-04-28 20:44, Richard Guy Briggs wrote:
> > > The Fanotify API can be used for access control by requesting permission
> > > event notification. The user space tooling that uses it may have a
> > > complicated policy that inherently contains additional context for the
> > > decision. If this information were available in the audit trail, policy
> > > writers can close the loop on debugging policy. Also, if this additional
> > > information were available, it would enable the creation of tools that
> > > can suggest changes to the policy similar to how audit2allow can help
> > > refine labeled security.
> > >
> > > This patch defines 2 additional fields within the response structure
> > > returned from user space on a permission event. The first field is 16
> > > bits for the context type. The context type will describe what the
> > > meaning is of the second field. The audit system will separate the
> > > pieces and log them individually.
> > >
> > > The audit function was updated to log the additional information in the
> > > AUDIT_FANOTIFY record. The following is an example of the new record
> > > format:
> > >
> > > type=FANOTIFY msg=audit(1600385147.372:590): resp=2 fan_type=1 fan_ctx=17
> >
> > It might have been a good idea to tag this as RFC...  I have a few
> > questions:
> >
> > 1. Where did "resp=" come from?
> 
> According to the git log, it came from Steve Grubb via de8cd83e91bc
> ("audit: Record fanotify access control decisions").  Steve should
> have known what he was doing with respect to field names so I'm
> assuming he had a reason.
> 
> > It isn't in the field dictionary.  It
> > seems like a needless duplication of "res=".  If it isn't, maybe it
> > should have a "fan_" namespace prefix and become "fan_res="?
> 
> Regardless of what it should have been, it is "resp" now and we can't
> really change it.  As far as the field dictionary is concerned, while
> we should document these fields, it is important to note that when the
> dictionary conflicts with the kernel, the kernel wins by definition.

Agree on all counts.  It was an open-ended question.  It is also moot
since it is even expected in the audit-testsuite and would break that if
it were changed.

> > 2. It appears I'm ok changing the "__u32 response" to "__u16" without
> > breaking old userspace.  Is this true on all arches?
> 
> I can't answer that for you, the fanotify folks will need to look at
> that, but you likely already know that.  While I haven't gone through
> the entire patchset yet, if it was me I probably would have left
> response as a u32 and just added the extra fields; you are already
> increasing the size of fanotify_response so why bother with shrinking
> an existing field?

I was thinking of that, but chose to follow the lead of the fanotify
mainainer.

> > 3. What should be the action if response contains unknown flags or
> > types?  Is it reasonable to return -EINVAL?
> 
> Once again, not a fanotify expert, but EINVAL is intended for invalid
> input so it seems like a reasonable choice.

The choice of the error code wasn't in question but rather the need to
fail rather than ignore unknown flags.

> > 4. Currently, struct fanotify_response has a fixed size, but if future
> > types get defined that have variable buffer sizes, how would that be
> > communicated or encoded?
> 
> If that is a concern, you should probably include a length field in
> the structure before the variable length field.  You can't put it
> before fd or response, so it's really a question of before or after
> your new extra_info_type; I might suggest *after* extra_info_type, but
> that's just me.

After extra_info_type is what I was thinking.  The other possibility is
that a type with a variable length field could define its data size as
the first field within the variable field as set out in the format of
that varible length field so that all the fixed length fields would not
need to waste that space or bandwidth.

Thanks for the feedback.

> paul-moore.com

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

