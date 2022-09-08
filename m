Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF4C5B2834
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Sep 2022 23:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiIHVOf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 17:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiIHVOd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 17:14:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EE0B7D0
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Sep 2022 14:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662671669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JQOf08EzUy9tUaK/0jgoSVtQJgsr6vZxAqUh34arFdc=;
        b=VcjQncrQPpfjRB21jQXdZELpOPinGfRfrPbKbjAwZhERmDJlIPCnyYKWIDUsjg7FxDE6DX
        nKYxGidv4xmz+K+dB30xIP5FsiwLBCwbMfa2YxY/GAQQWLfRn23SsiSyFf8gbmCsQB9Oml
        tfZuKt/KahZPjXUQER68Fz4i+6ohmZQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-204-6r98198iNYiIkACZgrPMAQ-1; Thu, 08 Sep 2022 17:14:27 -0400
X-MC-Unique: 6r98198iNYiIkACZgrPMAQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9D1B7188147E;
        Thu,  8 Sep 2022 21:14:11 +0000 (UTC)
Received: from x2.localnet (unknown [10.22.18.133])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 18E9F403351;
        Thu,  8 Sep 2022 21:14:11 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Richard Guy Briggs <rgb@redhat.com>, Jan Kara <jack@suse.cz>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v4 3/4] fanotify,audit: Allow audit to use the full permission event response
Date:   Thu, 08 Sep 2022 17:14:10 -0400
Message-ID: <2603742.X9hSmTKtgW@x2>
Organization: Red Hat
In-Reply-To: <CAHC9VhRLwL6cBSXsZF09HWspeREf_tKxh0QdX1Hki=DPvHv7Vg@mail.gmail.com>
References: <cover.1659996830.git.rgb@redhat.com> <4753948.GXAFRqVoOG@x2> <CAHC9VhRLwL6cBSXsZF09HWspeREf_tKxh0QdX1Hki=DPvHv7Vg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wednesday, September 7, 2022 4:23:49 PM EDT Paul Moore wrote:
> On Wed, Sep 7, 2022 at 4:11 PM Steve Grubb <sgrubb@redhat.com> wrote:
> > On Wednesday, September 7, 2022 2:43:54 PM EDT Richard Guy Briggs wrote:
> > > > > Ultimately I guess I'll leave it upto audit subsystem what it wants
> > > > > to
> > > > > have in its struct fanotify_response_info_audit_rule because for
> > > > > fanotify subsystem, it is just an opaque blob it is passing.
> > > > 
> > > > In that case, let's stick with leveraging the type/len fields in the
> > > > fanotify_response_info_header struct, that should give us all the
> > > > flexibility we need.
> > > > 
> > > > Richard and Steve, it sounds like Steve is already aware of
> > > > additional
> > > > information that he wants to send via the
> > > > fanotify_response_info_audit_rule struct, please include that in the
> > > > next revision of this patchset.  I don't want to get this merged and
> > > > then soon after have to hack in additional info.
> > > 
> > > Steve, please define the type and name of this additional field.
> > 
> > Maybe extra_data, app_data, or extra_info. Something generic that can be
> > reused by any application. Default to 0 if not present.
> 
> I think the point is being missed ... The idea is to not speculate on
> additional fields, as discussed we have ways to handle that, the issue
> was that Steve implied that he already had ideas for "things" he
> wanted to add.  If there are "things" that need to be added, let's do
> that now, however if there is just speculation that maybe someday we
> might need to add something else we can leave that until later.

This is not speculation. I know what I want to put there. I know you want to 
pin it down to exactly what it is. However, when this started a couple years 
back, one of the concerns was that we're building something specific to 1 user 
of fanotify. And that it would be better for all future users to have a 
generic facility that everyone could use if they wanted to. That's why I'm 
suggesting something generic, its so this is not special purpose that doesn't 
fit any other use case.

-Steve


