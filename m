Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756D55B2C37
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 04:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiIIClx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 22:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiIIClw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 22:41:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4B5103044
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Sep 2022 19:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662691310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YGIe/WchtTjeaQkmut/pp7gUU33urnk5jTM85S8dT9E=;
        b=VEs+V4KWod/WOfi+g/mUXl0rg4HmfaOlngkch0M6OX72HdYoEG88qArDyXTjajbAXlfz3j
        4wKV1LvdxPGoru5SdVW4s61IjVgqjWtbsx5qe2cie9Hts8uHbQpmQdPa6jFbUJXEu50Xxo
        fmRmnjnMvxGF67dh9Vjh7jn7/U40V40=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-4qCtdkEgM66uKLeR1hNVMA-1; Thu, 08 Sep 2022 22:41:48 -0400
X-MC-Unique: 4qCtdkEgM66uKLeR1hNVMA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 25F2380231E;
        Fri,  9 Sep 2022 02:41:48 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.22.48.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A7A12026D4C;
        Fri,  9 Sep 2022 02:41:46 +0000 (UTC)
Date:   Thu, 8 Sep 2022 22:41:44 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Steve Grubb <sgrubb@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>, Jan Kara <jack@suse.cz>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v4 3/4] fanotify,audit: Allow audit to use the full
 permission event response
Message-ID: <Yxqn6NVQr0jTQHiu@madcap2.tricolour.ca>
References: <cover.1659996830.git.rgb@redhat.com>
 <2603742.X9hSmTKtgW@x2>
 <CAHC9VhRKHXzEwNRwPU_+BtrYb+7sYL+r8GBk60zurzi9wz4HTg@mail.gmail.com>
 <2254258.ElGaqSPkdT@x2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2254258.ElGaqSPkdT@x2>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022-09-08 22:20, Steve Grubb wrote:
> On Thursday, September 8, 2022 5:22:15 PM EDT Paul Moore wrote:
> > On Thu, Sep 8, 2022 at 5:14 PM Steve Grubb <sgrubb@redhat.com> wrote:
> > > On Wednesday, September 7, 2022 4:23:49 PM EDT Paul Moore wrote:
> > > > On Wed, Sep 7, 2022 at 4:11 PM Steve Grubb <sgrubb@redhat.com> wrote:
> > > > > On Wednesday, September 7, 2022 2:43:54 PM EDT Richard Guy Briggs 
> wrote:
> > > > > > > > Ultimately I guess I'll leave it upto audit subsystem what it
> > > > > > > > wants
> > > > > > > > to
> > > > > > > > have in its struct fanotify_response_info_audit_rule because
> > > > > > > > for
> > > > > > > > fanotify subsystem, it is just an opaque blob it is passing.
> > > > > > > 
> > > > > > > In that case, let's stick with leveraging the type/len fields in
> > > > > > > the
> > > > > > > fanotify_response_info_header struct, that should give us all the
> > > > > > > flexibility we need.
> > > > > > > 
> > > > > > > Richard and Steve, it sounds like Steve is already aware of
> > > > > > > additional
> > > > > > > information that he wants to send via the
> > > > > > > fanotify_response_info_audit_rule struct, please include that in
> > > > > > > the
> > > > > > > next revision of this patchset.  I don't want to get this merged
> > > > > > > and
> > > > > > > then soon after have to hack in additional info.
> > > > > > 
> > > > > > Steve, please define the type and name of this additional field.
> > > > > 
> > > > > Maybe extra_data, app_data, or extra_info. Something generic that can
> > > > > be
> > > > > reused by any application. Default to 0 if not present.
> > > > 
> > > > I think the point is being missed ... The idea is to not speculate on
> > > > additional fields, as discussed we have ways to handle that, the issue
> > > > was that Steve implied that he already had ideas for "things" he
> > > > wanted to add.  If there are "things" that need to be added, let's do
> > > > that now, however if there is just speculation that maybe someday we
> > > > might need to add something else we can leave that until later.
> > > 
> > > This is not speculation. I know what I want to put there. I know you want
> > > to pin it down to exactly what it is. However, when this started a
> > > couple years back, one of the concerns was that we're building something
> > > specific to 1 user of fanotify. And that it would be better for all
> > > future users to have a generic facility that everyone could use if they
> > > wanted to. That's why I'm suggesting something generic, its so this is
> > > not special purpose that doesn't fit any other use case.
> > 
> > Well, we are talking specifically about fanotify in this thread and
> > dealing with data structures that are specific to fanotify.  I can
> > understand wanting to future proof things, but based on what we've
> > seen in this thread I think we are all set in this regard.
> 
> I'm trying to abide by what was suggested by the fs-devel folks. I can live 
> with it. But if you want to make something non-generic for all users of 
> fanotify, call the new field "trusted". This would decern when a decision was 
> made because the file was untrusted or access denied for another reason.

So, "u32 trusted;" ?  How would you like that formatted?
"fan_trust={0|1}"

> > You mention that you know what you want to put in the struct, why not
> > share the details with all of us so we are all on the same page and
> > can have a proper discussion.
> 
> Because I want to abide by the original agreement and not impose opinionated 
> requirements that serve no one else. I'd rather have something anyone can 
> use. I want to play nice.

If someone else wants to use something, why not give them a type of
their own other than FAN_RESPONSE_INFO_AUDIT_RULE that they can shape
however they like?

> -Steve

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

