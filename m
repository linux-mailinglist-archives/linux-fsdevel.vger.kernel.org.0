Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C525A4EE7C5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Apr 2022 07:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbiDAFcq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Apr 2022 01:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234998AbiDAFcp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Apr 2022 01:32:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F6633A5D7
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Mar 2022 22:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648791055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7QMXqtrbsC5xFcoJnlfW2A3rDBF4OPWrvizGei7+JWY=;
        b=PMryfqAM2olVNymcCN2h8Mtm9rJ+/33VFY1ANyOK9gL07qjap+keV93vbNnbPU4EwwqMWI
        zvxa7JEhRBMS1NSheBxiN7inzgfJ2RlRFHjknnieORZoaN02Hisgzen7tL0cqRO36MVBYh
        hruXVFS3XyMHHDtqiW80PTv1Q8JnN7M=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-261--b8Lt_TzPPGHrHGuNsQ-mA-1; Fri, 01 Apr 2022 01:30:53 -0400
X-MC-Unique: -b8Lt_TzPPGHrHGuNsQ-mA-1
Received: by mail-pg1-f198.google.com with SMTP id b7-20020a633407000000b0038413d39ca9so1100074pga.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Mar 2022 22:30:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=7QMXqtrbsC5xFcoJnlfW2A3rDBF4OPWrvizGei7+JWY=;
        b=X+HMlO1i3nMJX8vvsZ1N5TkAek6E8jszXcfMrv2qqtyYW7ADYiHug+RsFP4fzU1U7r
         H3msDG5uJdgZ4wnLNRpWQX9+dzxh7BGeWXbRKgLU9Q1yBCOEb3I1i88wJ5icrYzqWgR8
         WhmuwzkJ31dYDWlu6FUKkt/JZQhuaISc2HfZrbSL10WE7uHaNrHC6x+Ny0hZfBVrEZ1x
         10B/VopkKUnYLsLiR0tFvbZxismSnknwBTTv5z0rt1R+R/6tC1eh1NpxJ89q8f4cQz0Y
         p3g1MCBPqUJdCmcVhCC43g9hyzrv0TAZDHDo2iG0xVvgGIJ+mSBup+71ernWF8Bq4f/j
         2qbg==
X-Gm-Message-State: AOAM532UwaqqsePVhd3L6kZUORZrE9UghMn7+t7p9NPg+6emJuW6x/m8
        FeLByWVI0Vis3ATPA16M02kDMzCylJ3OKuoio5ifFJClknu3cb2tIuwwnaR0fiNThlQWY0TOpbZ
        7YswrNr5f/uNndr0aOmV4GI7ejQ==
X-Received: by 2002:a17:902:684e:b0:154:3b94:e30c with SMTP id f14-20020a170902684e00b001543b94e30cmr8829438pln.89.1648791052560;
        Thu, 31 Mar 2022 22:30:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxY7OvK2M1A5AqbXUDoQ2crpDG+2Q85cwgkdCc0FQgN2u2i+IfXl3sL6nrto7SfNk04ngqIng==
X-Received: by 2002:a17:902:684e:b0:154:3b94:e30c with SMTP id f14-20020a170902684e00b001543b94e30cmr8829414pln.89.1648791052218;
        Thu, 31 Mar 2022 22:30:52 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id n4-20020a637204000000b00398522203a2sm1056282pgc.80.2022.03.31.22.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 22:30:51 -0700 (PDT)
Date:   Fri, 1 Apr 2022 13:30:47 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Ritesh Harjani <ritesh.list@gmail.com>,
        "Darrick J . Wong" <djwong@kernel.org>
Cc:     fstests <fstests@vger.kernel.org>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCHv3 0/4] generic: Add some tests around journal
 replay/recoveryloop
Message-ID: <20220401053047.ic4cbsembj6eoibm@zlang-mailbox>
Mail-Followup-To: Ritesh Harjani <ritesh.list@gmail.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        fstests <fstests@vger.kernel.org>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <cover.1648730443.git.ritesh.list@gmail.com>
 <20220331145906.2onnohv2bbg3ye6j@zlang-mailbox>
 <20220331161911.7d5dlqfwm2kngnjk@riteshh-domain>
 <20220331165335.mzx3gfc3uqeeg3sz@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331165335.mzx3gfc3uqeeg3sz@riteshh-domain>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 31, 2022 at 10:23:35PM +0530, Ritesh Harjani wrote:
> On 22/03/31 09:49PM, Ritesh Harjani wrote:
> > On 22/03/31 10:59PM, Zorro Lang wrote:
> > > On Thu, Mar 31, 2022 at 06:24:19PM +0530, Ritesh Harjani wrote:
> > > > Hello,
> > >
> > > Hi,
> > >
> > > Your below patches looks like not pure text format, they might contain
> > > binary character or some special characers, looks like the "^M" [1].
> 
> Sorry to bother you. But here is what I tried.
> 1. Download the mbx file using b4 am. I didn't see any such character ("^M") in
>    the patches.
> 2. Saved the patch using mutt. Again didn't see such character while doing
> 	cat -A /patch/to/patch
> 3. Downloaded the mail using eml format from webmail. Here I do see this
>    character appended. But that happens not just for my patch, but for all
>    other patches too.
> 
> So could this be related to the way you are downloading these patches.
> Please let me know, if I need to resend these patches again? Because, I don't
> see this behavior at my end. But I would happy to correct it, if that's not the
> case.

Hmm... weird, When I tried to open your patch emails, my mutt show me:

  [-- application/octet-stream is unsupported (use 'v' to view this part) --]

Then I have to input 'v' to see the patch content. I'm not sure what's wrong,
this's the 2nd time I hit this "octet-stream is unsupported" issue yesterday.

Hi Darrick, or any other forks, can you open above 4 patches normally? If that's
only my personal issue, I'll check my side.

Thanks,
Zorro

> 
> -ritesh
> 

