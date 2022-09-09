Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F28F5B3898
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 15:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiIINBi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Sep 2022 09:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbiIINBg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Sep 2022 09:01:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A43CCE3B
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Sep 2022 06:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662728494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7roVqgiLTtD9K+hJlFUdG9Wb1smDN31yGHEloDLRN0o=;
        b=XEI+d3aUR0AGJqNOUabQrlNewTMTJ+ur/rtxnK2ryO7mDosTCsX4Y9IA+WtCI6P/IVVJVI
        dtAowrkXSn5LTGqguoE+t+nMGQ3B+mB0NQj1UI5SfX+J6SSFwh7D0m6LGCVGvorxHSKE2s
        AGesnOFBeVNkTfrvMgV/XSPAD7qhUcU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-492-pJ2bdfs7PlmK0xAzBepaMQ-1; Fri, 09 Sep 2022 09:01:30 -0400
X-MC-Unique: pJ2bdfs7PlmK0xAzBepaMQ-1
Received: by mail-qt1-f200.google.com with SMTP id s2-20020ac85cc2000000b00342f8ad1f40so1430474qta.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Sep 2022 06:01:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=7roVqgiLTtD9K+hJlFUdG9Wb1smDN31yGHEloDLRN0o=;
        b=z5zjA8VpDC0vNUc1ej/UYmkx9SqWoSSyGJo1pEqRVArFxJuXW2HkoWmp7PV6Y4yLSw
         8QqGCAQc0lQISeGDrlBDeCoGPJYp7Li9pbJ1Sml6/pgZ6I4hf/KR6B7FfedfiBXl7rSV
         yRVw/icQlkfnc9E+evhVxWxVhR7qXpv/pzZG4CN+c7IJKKl3F5nMEFDePLpm0T9SG7EF
         cEpDmeC8tcQPYe+A4qKMU58WiRTcxpoQASOPghttXfMHyXRoYuCVEMdFLgvwaliDZJVw
         rTsyZi1nYSRBZC4zED2XrAvJIhmeUMZAN9ApqViPzYBi0siexiJInOn0yiBW3W6IL+As
         mgUQ==
X-Gm-Message-State: ACgBeo057qEkmw94xDf+1A71E+xSW156dI0M1D59pmSjjgeWiDq2gX+w
        q9SDQP+Z35/l4/hsd67WRlAP3uFfMre6duLGVFXd57yXiO0AM3cG+2Rtfsbt8DYv02yGpBk0ggb
        rLl/6fBE2Swcr4FtrJe9eti03RQ==
X-Received: by 2002:a0c:e103:0:b0:4aa:b54b:e396 with SMTP id w3-20020a0ce103000000b004aab54be396mr11039017qvk.42.1662728490188;
        Fri, 09 Sep 2022 06:01:30 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7A0i1+JhxQx9EsIr4UP9K7Sqz06e67+5wJ5s4maBLPeuImTnuNnbKxlFxyWzpKAPruI184vg==
X-Received: by 2002:a0c:e103:0:b0:4aa:b54b:e396 with SMTP id w3-20020a0ce103000000b004aab54be396mr11038913qvk.42.1662728489147;
        Fri, 09 Sep 2022 06:01:29 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id r8-20020ac87ee8000000b0034355a352d1sm306127qtc.92.2022.09.09.06.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 06:01:28 -0700 (PDT)
Date:   Fri, 9 Sep 2022 09:01:25 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@infradead.org" <hch@infradead.org>,
        =?utf-8?B?WWFuZywgWGlhby/mnagg5pmT?= <yangx.jy@fujitsu.com>
Subject: Re: [PATCH] xfs: fail dax mount if reflink is enabled on a partition
Message-ID: <Yxs5Jb7Yt2c6R6eW@bfoster>
References: <20220609143435.393724-1-ruansy.fnst@fujitsu.com>
 <Yr5AV5HaleJXMmUm@magnolia>
 <74b0a034-8c77-5136-3fbd-4affb841edcb@fujitsu.com>
 <Ytl7yJJL1fdC006S@magnolia>
 <7fde89dc-2e8f-967b-d342-eb334e80255c@fujitsu.com>
 <YuNn9NkUFofmrXRG@magnolia>
 <0ea1cbe1-79d7-c22b-58bf-5860a961b680@fujitsu.com>
 <YusYDMXLYxzqMENY@magnolia>
 <dd363bd8-2dbd-5d9c-0406-380b60c5f510@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd363bd8-2dbd-5d9c-0406-380b60c5f510@fujitsu.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 08, 2022 at 09:46:04PM +0800, Shiyang Ruan wrote:
> 
> 
> 在 2022/8/4 8:51, Darrick J. Wong 写道:
> > On Wed, Aug 03, 2022 at 06:47:24AM +0000, ruansy.fnst@fujitsu.com wrote:
> 
> ...
> 
> > > > > > > 
> > > > > > > BTW, since these patches (dax&reflink&rmap + THIS + pmem-unbind) are
> > > > > > > waiting to be merged, is it time to think about "removing the
> > > > > > > experimental tag" again?  :)
> > > > > > 
> > > > > > It's probably time to take up that question again.
> > > > > > 
> > > > > > Yesterday I tried running generic/470 (aka the MAP_SYNC test) and it
> > > > > > didn't succeed because it sets up dmlogwrites atop dmthinp atop pmem,
> > > > > > and at least one of those dm layers no longer allows fsdax pass-through,
> > > > > > so XFS silently turned mount -o dax into -o dax=never. :(
> > > > > 
> > > > > Hi Darrick,
> > > > > 
> > > > > I tried generic/470 but it didn't run:
> > > > >      [not run] Cannot use thin-pool devices on DAX capable block devices.
> > > > > 
> > > > > Did you modify the _require_dm_target() in common/rc?  I added thin-pool
> > > > > to not to check dax capability:
> > > > > 
> > > > >            case $target in
> > > > >            stripe|linear|log-writes|thin-pool)  # add thin-pool here
> > > > >                    ;;
> > > > > 
> > > > > then the case finally ran and it silently turned off dax as you said.
> > > > > 
> > > > > Are the steps for reproduction correct? If so, I will continue to
> > > > > investigate this problem.
> > > > 
> > > > Ah, yes, I did add thin-pool to that case statement.  Sorry I forgot to
> > > > mention that.  I suspect that the removal of dm support for pmem is
> > > > going to force us to completely redesign this test.  I can't really
> > > > think of how, though, since there's no good way that I know of to gain a
> > > > point-in-time snapshot of a pmem device.
> > > 
> > > Hi Darrick,
> > > 
> > >   > removal of dm support for pmem
> > > I think here we are saying about xfstest who removed the support, not
> > > kernel?
> > > 
> > > I found some xfstests commits:
> > > fc7b3903894a6213c765d64df91847f4460336a2  # common/rc: add the restriction.
> > > fc5870da485aec0f9196a0f2bed32f73f6b2c664  # generic/470: use thin-pool
> > > 
> > > So, this case was never able to run since the second commit?  (I didn't
> > > notice the not run case.  I thought it was expected to be not run.)
> > > 
> > > And according to the first commit, the restriction was added because
> > > some of dm devices don't support dax.  So my understanding is: we should
> > > redesign the case to make the it work, and firstly, we should add dax
> > > support for dm devices in kernel.
> > 
> > dm devices used to have fsdax support; I think Christoph is actively
> > removing (or already has removed) all that support.
> > 
> > > In addition, is there any other testcase has the same problem?  so that
> > > we can deal with them together.
> > 
> > The last I checked, there aren't any that require MAP_SYNC or pmem aside
> > from g/470 and the three poison notification tests that you sent a few
> > days ago.
> > 
> > --D
> > 
> 
> Hi Darrick, Brian
> 
> I made a little investigation on generic/470.
> 
> This case was able to run before introducing thin-pool[1], but since that,
> it became 'Failed'/'Not Run' because thin-pool does not support DAX.  I have
> checked the log of thin-pool, it never supports DAX.  And, it's not someone
> has removed the fsdax support.  So, I think it's not correct to bypass the
> requirement conditions by adding 'thin-pool' to _require_dm_target().
> 
> As far as I known, to prevent out-of-order replay of dm-log-write, thin-pool
> was introduced (to provide discard zeroing).  Should we solve the
> 'out-of-order replay' issue instead of avoiding it by thin-pool? @Brian
> 

Yes.. I don't recall all the internals of the tools and test, but IIRC
it relied on discard to perform zeroing between checkpoints or some such
and avoid spurious failures. The purpose of running on dm-thin was
merely to provide reliable discard zeroing behavior on the target device
and thus to allow the test to run reliably.

Brian

> Besides, since it's not a fsdax problem, I think there is nothing need to be
> fixed in fsdax.  I'd like to help it solved, but I'm still wondering if we
> could back to the original topic("Remove Experimental Tag") firstly? :)
> 
> 
> [1] fc5870da485aec0f9196a0f2bed32f73f6b2c664 generic/470: use thin volume
> for dmlogwrites target device
> 
> 
> --
> Thanks,
> Ruan.
> 
> 

