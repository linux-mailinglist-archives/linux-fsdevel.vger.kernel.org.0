Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722E74F90FD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Apr 2022 10:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbiDHIlP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Apr 2022 04:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiDHIlO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Apr 2022 04:41:14 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D35589CC8
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Apr 2022 01:39:11 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id e10so2633433qka.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Apr 2022 01:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NKVMzxlAs1qZoOgRsJr7tIRfzwAvoAMF4B55kJAk49g=;
        b=K84+XgK5mk4WpxBwe9tiM8QauNsCfusRchZMzlJzylAtl/0OKCj7dGeRCkYcoIUurC
         ddFTHdcPlsQzFkrW6SrmikXMx8zzxwf4tNGkhpr4YG9bylKyYGciGXiSQK8QPg8ssVwW
         030IjfD1xKWY1FMAuDhtW8O28sucXACqFhadny5zjFN47Uhhk650SZaGupdaJuio5qi1
         9U3s4xZaH7T/aYEDOdEyfv5/K/6O/Vni+3YclQAmwqePmqFnwjeh/nLsjLNTgPWwEBhg
         k+558y9+4HqeXYrsI29GBSqf59/VYsH/0LaTVB3Ns0vZwyJCNnrSIQPEC+2vSZ0ER9p+
         0mvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NKVMzxlAs1qZoOgRsJr7tIRfzwAvoAMF4B55kJAk49g=;
        b=gJpQLQgyZTfCV5eJqvDVOsR1jaBCBC+w3AmCKEaqjZQTxgkJBGcG+Q26JAnlot0Oxo
         uBTmOCfsxXiLIy0D8A3vRQQZv6iQbC7FOrKGMvVT+echIORjBOAlFhXDUgeg0uNd+U0j
         uFmLCd8BM/Bvj2T9ueUd8dRlLCgx5TDBE/FOgeUML786x113VDOFX84RjrC92DUPYsgt
         lp/EAtNBUubJBom9Ahn7ckaRRE9RvU3yIfRKrhBINeXynWOniyscF/41yo2VUUWteKvR
         4nJFtRCKvLfqwQNvPaaeG0Niu04lXjVP8pxFFHxOCHveM0csNNLwcrwOrk2RAM9ajZVN
         aw4g==
X-Gm-Message-State: AOAM531wH1smOklL7UB49CFfpNnnZ1GoI9ISzcz3aatHq5hxqRfbLpqG
        n5BWshZ2sYcfRDDuFtb3axgat9CFJIE9OVIF9/u2g9QlW2U=
X-Google-Smtp-Source: ABdhPJy+VAjKPOxVkHtmrUYDB8zfLNp16JBzxQsbvoBnfDy3NaC9nfjikHr1QcyGMxDZ+o0zg7AsFKwKUv4xbA0/MPE=
X-Received: by 2002:a37:6143:0:b0:69a:11e6:a974 with SMTP id
 v64-20020a376143000000b0069a11e6a974mr3604005qkb.722.1649407150450; Fri, 08
 Apr 2022 01:39:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220329074904.2980320-1-amir73il@gmail.com> <20220329074904.2980320-7-amir73il@gmail.com>
 <20220407143552.c6cddwtus6eaut2j@quack3.lan> <CAOQ4uxi1MFjyGT84RCfgjyanuLCKq+G630ufx1J69RQXCygPbg@mail.gmail.com>
In-Reply-To: <CAOQ4uxi1MFjyGT84RCfgjyanuLCKq+G630ufx1J69RQXCygPbg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 8 Apr 2022 11:38:59 +0300
Message-ID: <CAOQ4uxgxgoPaT_Gk3CA+i+6+EDiSmrV45F+AQ133tAakYOG0qQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/16] fsnotify: create helpers for group mark_mutex lock
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 7, 2022 at 5:53 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Thu, Apr 7, 2022 at 5:35 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Tue 29-03-22 10:48:54, Amir Goldstein wrote:
> > > Create helpers to take and release the group mark_mutex lock.
> > >
> > > Define a flag FSNOTIFY_GROUP_NOFS in fsnotify backend operations struct
> > > that determines if the mark_mutex lock is fs reclaim safe or not.
> > > If not safe, the nofs lock helpers should be used to take the lock and
> > > disable direct fs reclaim.
> > >
> > > In that case we annotate the mutex with different lockdep class to
> > > express to lockdep that an allocation of mark of an fs reclaim safe group
> > > may take the group lock of another "NOFS" group to evict inodes.
> > >
> > > For now, converted only the callers in common code and no backend
> > > defines the NOFS flag.  It is intended to be set by fanotify for
> > > evictable marks support.
> > >
> > > Suggested-by: Jan Kara <jack@suse.cz>
> > > Link: https://lore.kernel.org/r/20220321112310.vpr7oxro2xkz5llh@quack3.lan/
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >
> > A few design question here:
> >
> > 1) Why do you store the FSNOTIFY_GROUP_NOFS flag in ops? Sure, this
> > particular flag is probably going to be the same per backend type but it
> > seems a bit strange to have it in ops instead of in the group itself...
>
> I followed the pattern of struct file_system_type.
> I didn't think per-group NOFS made much sense,
> so it was easier this way.
>
> >
> > 2) Why do we have fsnotify_group_nofs_lock() as well as
> > fsnotify_group_lock()? We could detect whether we should set nofs based on
> > group flag anyway. Is that so that callers don't have to bother with passing
> > around the 'nofs'? Is it too bad? We could also store the old value of
> > 'nofs' inside the group itself after locking it and then unlock can restore
> > it without the caller needing to care about anything...
>
> Yes because it created unneeded code.
> storing the local thread state in the group seems odd...
>

I followed your suggestions and the result looks much better.
Pushed result to fan_evictable branch.

Thanks,
Amir.
