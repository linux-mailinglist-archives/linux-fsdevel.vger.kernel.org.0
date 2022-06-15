Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8B454C98B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jun 2022 15:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348703AbiFONP2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jun 2022 09:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348422AbiFONP1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jun 2022 09:15:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2312A27B;
        Wed, 15 Jun 2022 06:15:26 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BF13A21BB9;
        Wed, 15 Jun 2022 13:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655298924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=17VEqNPV/TBk73G7tKfWD0AkIggznFYMqcz7zsD4S9c=;
        b=c5CplPzuxQh5gnp4bD34uWkKLEOaOc1Tpwslt5ARBi5fVdHjWZ4prxmWoQqcdCpqAG1Yor
        xmQuGVnUEOpCEt1XYqn7LUtFrFvMKUMl0YDT2F/jRq/vq+FW+bBxji/zHIwKJ8jaI2QMZs
        rqLOKCpvqZTZhxAjHRYVGQZVY5XNs10=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 66BBD2C141;
        Wed, 15 Jun 2022 13:15:24 +0000 (UTC)
Date:   Wed, 15 Jun 2022 15:15:23 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-tegra@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, alexander.deucher@amd.com, daniel@ffwll.ch,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        hughd@google.com, andrey.grodzovsky@amd.com
Subject: Re: [PATCH 03/13] mm: shmem: provide oom badness for shmem files
Message-ID: <Yqnba1E2FSRVUATY@dhcp22.suse.cz>
References: <YqMuq/ZrV8loC3jE@dhcp22.suse.cz>
 <2e7e050e-04eb-0c0a-0675-d7f1c3ae7aed@amd.com>
 <YqNSSFQELx/LeEHR@dhcp22.suse.cz>
 <288528c3-411e-fb25-2f08-92d4bb9f1f13@gmail.com>
 <Yqbq/Q5jz2ou87Jx@dhcp22.suse.cz>
 <b8b9aba5-575e-8a34-e627-79bef4ed7f97@amd.com>
 <YqcpZY3Xx7Mk2ROH@dhcp22.suse.cz>
 <34daa8ab-a9f4-8f7b-0ea7-821bc36b9497@gmail.com>
 <YqdFkfLVFUD5K6EK@dhcp22.suse.cz>
 <9e170201-35df-cfcc-8d07-2f9693278829@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e170201-35df-cfcc-8d07-2f9693278829@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 15-06-22 14:35:22, Christian König wrote:
[...]
> Even the classic mm_struct based accounting includes MM_SHMEMPAGES into the
> badness. So accounting shared resources as badness to make a decision is
> nothing new here.

Yeah, it is nothing really new but it also doesn't mean it is an example
worth following as this doesn't really work currently. Also please note
that MM_SHMEMPAGES is counting at least something process specific as
those pages are mapped in to the process (and with enough of wishful
thinking unmapping can drop the last reference and free something up
actually) . With generic per-file memory this is even more detached from
process.

> The difference is that this time the badness doesn't come from the memory
> management subsystem, but rather from the I/O subsystem.
> 
> > This is also the reason why I am not really fan of the per file
> > badness because it adds a notion of resource that is not process bound
> > in general so it will add all sorts of weird runtime corner cases which
> > are impossible to anticipate [*]. Maybe that will work in some scenarios
> > but definitely not something to be done by default without users opting
> > into that and being aware of consequences.
> 
> Would a kernel command line option to control the behavior be helpful here?

I am not sure what would be the proper way to control that that would be
future extensible. Kernel command line is certainly and option but if we
want to extend that to module like or eBPF interface then it wouldn't
stand a future test very quickly.

-- 
Michal Hocko
SUSE Labs
