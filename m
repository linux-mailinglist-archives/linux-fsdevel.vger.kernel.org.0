Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638BC5B287C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Sep 2022 23:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiIHVWa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 17:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiIHVW2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 17:22:28 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2165A1079FE
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Sep 2022 14:22:27 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1274ec87ad5so32966497fac.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Sep 2022 14:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=xePKdUHPsf4upeyYZ51sX7aStCsuTX+3DuKXGbieyQw=;
        b=Lj8WjuWf9DDGY9mvU1OdHIaHs5A4zEnBdc7SN1cf+V2ALsGGzCSXfq+28WJO1Al1sf
         WqcWk0JDF2NUY00xUDcOM2CCHZ2SemS1LDrarOBqNt/uldoLvVZG/xmJ9lOAnj/xuokM
         YOwgCQz5DiiZoN18IA5gWVw5Q5ssWx7EVwJvJr4yDsrqLTHtSrqDcGUycf43p3oOUpdu
         wMxijzxxj1+pLaXPAW/KTDqLdx2Cr3w1K5YByW9xNxtgY3bAnb/dDnlolU7cQcpWVCgb
         6p+Hz4+PgycZGuiI9k/FuOdyi9m2An5MeYdOeEwBLFKD1BrMLMaJ7EIasnI7csJqefCM
         wVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=xePKdUHPsf4upeyYZ51sX7aStCsuTX+3DuKXGbieyQw=;
        b=Px0+Og+4t0w6ZYM+CR2lPjOh7zkpFEFlKOzUseLXu7BOGA4kED7Ze9qEXjWVvquCP9
         b4wTMYAC8E307piSWFubOCy8PW93Fl1T/HV6yVP4oKHdPriv1LbEYK/HJyBLcJqlywoi
         EsWQtAVt2ksaPADIm5PWCWrTZI6O6W8ajql7ijeMcDa6BpUe3fcYHqxUSVxroCPt9TZO
         BtWAfwgyicqp8cRLyfU0tCuv27cSPipnE3i/Wl9XHpMDpZEqmUMoX9lessHEoTVawoHw
         lNDUA1S5pd8Pp08KmrQ2gy5AQjlQm73ITn5n+7D6wzNbsCP5ciJCelXNy5JnSjlH0gPE
         r73A==
X-Gm-Message-State: ACgBeo31sRXXAiOZrT45p6SsKzAxn7NY6Tt3sYJp+xCmmp2VG3eXtSOx
        y8wjJowXqbdUtG89NHtP72trHRyCkxAh1Afebk4z
X-Google-Smtp-Source: AA6agR7TzAiP8Ou3ZE6EAL/p35eIUZFLoy/bEd4o72geLJhXFa7G8AAKGUP+MA4TOLYB2KuXfFnTuwWKWxvWLO74c30=
X-Received: by 2002:a05:6870:5808:b0:128:afd5:491f with SMTP id
 r8-20020a056870580800b00128afd5491fmr3189028oap.136.1662672146444; Thu, 08
 Sep 2022 14:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1659996830.git.rgb@redhat.com> <4753948.GXAFRqVoOG@x2>
 <CAHC9VhRLwL6cBSXsZF09HWspeREf_tKxh0QdX1Hki=DPvHv7Vg@mail.gmail.com> <2603742.X9hSmTKtgW@x2>
In-Reply-To: <2603742.X9hSmTKtgW@x2>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 8 Sep 2022 17:22:15 -0400
Message-ID: <CAHC9VhRKHXzEwNRwPU_+BtrYb+7sYL+r8GBk60zurzi9wz4HTg@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] fanotify,audit: Allow audit to use the full
 permission event response
To:     Steve Grubb <sgrubb@redhat.com>
Cc:     Richard Guy Briggs <rgb@redhat.com>, Jan Kara <jack@suse.cz>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Amir Goldstein <amir73il@gmail.com>
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

On Thu, Sep 8, 2022 at 5:14 PM Steve Grubb <sgrubb@redhat.com> wrote:
> On Wednesday, September 7, 2022 4:23:49 PM EDT Paul Moore wrote:
> > On Wed, Sep 7, 2022 at 4:11 PM Steve Grubb <sgrubb@redhat.com> wrote:
> > > On Wednesday, September 7, 2022 2:43:54 PM EDT Richard Guy Briggs wrote:
> > > > > > Ultimately I guess I'll leave it upto audit subsystem what it wants
> > > > > > to
> > > > > > have in its struct fanotify_response_info_audit_rule because for
> > > > > > fanotify subsystem, it is just an opaque blob it is passing.
> > > > >
> > > > > In that case, let's stick with leveraging the type/len fields in the
> > > > > fanotify_response_info_header struct, that should give us all the
> > > > > flexibility we need.
> > > > >
> > > > > Richard and Steve, it sounds like Steve is already aware of
> > > > > additional
> > > > > information that he wants to send via the
> > > > > fanotify_response_info_audit_rule struct, please include that in the
> > > > > next revision of this patchset.  I don't want to get this merged and
> > > > > then soon after have to hack in additional info.
> > > >
> > > > Steve, please define the type and name of this additional field.
> > >
> > > Maybe extra_data, app_data, or extra_info. Something generic that can be
> > > reused by any application. Default to 0 if not present.
> >
> > I think the point is being missed ... The idea is to not speculate on
> > additional fields, as discussed we have ways to handle that, the issue
> > was that Steve implied that he already had ideas for "things" he
> > wanted to add.  If there are "things" that need to be added, let's do
> > that now, however if there is just speculation that maybe someday we
> > might need to add something else we can leave that until later.
>
> This is not speculation. I know what I want to put there. I know you want to
> pin it down to exactly what it is. However, when this started a couple years
> back, one of the concerns was that we're building something specific to 1 user
> of fanotify. And that it would be better for all future users to have a
> generic facility that everyone could use if they wanted to. That's why I'm
> suggesting something generic, its so this is not special purpose that doesn't
> fit any other use case.

Well, we are talking specifically about fanotify in this thread and
dealing with data structures that are specific to fanotify.  I can
understand wanting to future proof things, but based on what we've
seen in this thread I think we are all set in this regard.

You mention that you know what you want to put in the struct, why not
share the details with all of us so we are all on the same page and
can have a proper discussion.

-- 
paul-moore.com
