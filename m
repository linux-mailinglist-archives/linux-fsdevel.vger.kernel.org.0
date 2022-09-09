Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83C95B2C0F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 04:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiIICUY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 22:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiIICUX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 22:20:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5BD93232
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Sep 2022 19:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662690021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i8oCJIQ+FpBtHf/IlhXTh4IHCwTHuXi80ZP7njx9WBg=;
        b=TSR3HQjSlKAYXv3iwap8qxJWC5bLtFHw2AtzTCDqLckqOJFQiLI3cJnA7nSayUQoQyzqo8
        jtdOvTwrckzMwClgDeEUdnv41SDk7s+yZ8lmFUKnIzWACA19mYzM62v+gs1levVwLpC38h
        D2/8olcQN9dFtNnQn5/TftorNbq3j08=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-142-jguoCVc2O62VkV6PbOfZhA-1; Thu, 08 Sep 2022 22:20:16 -0400
X-MC-Unique: jguoCVc2O62VkV6PbOfZhA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C995085A585;
        Fri,  9 Sep 2022 02:20:15 +0000 (UTC)
Received: from x2.localnet (unknown [10.22.8.167])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 41C59909FF;
        Fri,  9 Sep 2022 02:20:15 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Richard Guy Briggs <rgb@redhat.com>, Jan Kara <jack@suse.cz>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v4 3/4] fanotify,audit: Allow audit to use the full permission event response
Date:   Thu, 08 Sep 2022 22:20:14 -0400
Message-ID: <2254258.ElGaqSPkdT@x2>
Organization: Red Hat
In-Reply-To: <CAHC9VhRKHXzEwNRwPU_+BtrYb+7sYL+r8GBk60zurzi9wz4HTg@mail.gmail.com>
References: <cover.1659996830.git.rgb@redhat.com> <2603742.X9hSmTKtgW@x2> <CAHC9VhRKHXzEwNRwPU_+BtrYb+7sYL+r8GBk60zurzi9wz4HTg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thursday, September 8, 2022 5:22:15 PM EDT Paul Moore wrote:
> On Thu, Sep 8, 2022 at 5:14 PM Steve Grubb <sgrubb@redhat.com> wrote:
> > On Wednesday, September 7, 2022 4:23:49 PM EDT Paul Moore wrote:
> > > On Wed, Sep 7, 2022 at 4:11 PM Steve Grubb <sgrubb@redhat.com> wrote:
> > > > On Wednesday, September 7, 2022 2:43:54 PM EDT Richard Guy Briggs 
wrote:
> > > > > > > Ultimately I guess I'll leave it upto audit subsystem what it
> > > > > > > wants
> > > > > > > to
> > > > > > > have in its struct fanotify_response_info_audit_rule because
> > > > > > > for
> > > > > > > fanotify subsystem, it is just an opaque blob it is passing.
> > > > > > 
> > > > > > In that case, let's stick with leveraging the type/len fields in
> > > > > > the
> > > > > > fanotify_response_info_header struct, that should give us all the
> > > > > > flexibility we need.
> > > > > > 
> > > > > > Richard and Steve, it sounds like Steve is already aware of
> > > > > > additional
> > > > > > information that he wants to send via the
> > > > > > fanotify_response_info_audit_rule struct, please include that in
> > > > > > the
> > > > > > next revision of this patchset.  I don't want to get this merged
> > > > > > and
> > > > > > then soon after have to hack in additional info.
> > > > > 
> > > > > Steve, please define the type and name of this additional field.
> > > > 
> > > > Maybe extra_data, app_data, or extra_info. Something generic that can
> > > > be
> > > > reused by any application. Default to 0 if not present.
> > > 
> > > I think the point is being missed ... The idea is to not speculate on
> > > additional fields, as discussed we have ways to handle that, the issue
> > > was that Steve implied that he already had ideas for "things" he
> > > wanted to add.  If there are "things" that need to be added, let's do
> > > that now, however if there is just speculation that maybe someday we
> > > might need to add something else we can leave that until later.
> > 
> > This is not speculation. I know what I want to put there. I know you want
> > to pin it down to exactly what it is. However, when this started a
> > couple years back, one of the concerns was that we're building something
> > specific to 1 user of fanotify. And that it would be better for all
> > future users to have a generic facility that everyone could use if they
> > wanted to. That's why I'm suggesting something generic, its so this is
> > not special purpose that doesn't fit any other use case.
> 
> Well, we are talking specifically about fanotify in this thread and
> dealing with data structures that are specific to fanotify.  I can
> understand wanting to future proof things, but based on what we've
> seen in this thread I think we are all set in this regard.

I'm trying to abide by what was suggested by the fs-devel folks. I can live 
with it. But if you want to make something non-generic for all users of 
fanotify, call the new field "trusted". This would decern when a decision was 
made because the file was untrusted or access denied for another reason.

> You mention that you know what you want to put in the struct, why not
> share the details with all of us so we are all on the same page and
> can have a proper discussion.

Because I want to abide by the original agreement and not impose opinionated 
requirements that serve no one else. I'd rather have something anyone can 
use. I want to play nice.

-Steve



