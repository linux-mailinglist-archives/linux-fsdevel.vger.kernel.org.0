Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0717350B592
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 12:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446882AbiDVKyG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 06:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446657AbiDVKyF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:54:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D9C53A76;
        Fri, 22 Apr 2022 03:51:12 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EBE4221117;
        Fri, 22 Apr 2022 10:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650624670; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fv37HN/IG+2L97s4FB5ttyXca0ZiVPK46/Rpu1Qgni4=;
        b=q7Lkt4GhhESuKQ4uT9G4GtLC+qxyCW9i7CpwIlBxIT/kjQ1cuuE6Ps9M0OYUCgUkKCBfuM
        M9zka9w+hOZy72mZsRSZ4BOWroNAOraJP7+TZTnh7szAI1UUk+ddEYS0rYGzxC5spZARTO
        0KJetR3dB9IIheo2NvH31eMCrBBH9eY=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A0A682C149;
        Fri, 22 Apr 2022 10:51:10 +0000 (UTC)
Date:   Fri, 22 Apr 2022 12:51:09 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, roman.gushchin@linux.dev,
        hannes@cmpxchg.org
Subject: Re: [PATCH 3/4] mm: Centralize & improve oom reporting in show_mem.c
Message-ID: <YmKInWEihG+7mkU6@dhcp22.suse.cz>
References: <20220419203202.2670193-1-kent.overstreet@gmail.com>
 <20220419203202.2670193-4-kent.overstreet@gmail.com>
 <Yl+vHJ3lSLn5ZkWN@dhcp22.suse.cz>
 <20220420165805.lg4k2iipnpyt4nuu@moria.home.lan>
 <YmEhXG8C7msGvhqL@dhcp22.suse.cz>
 <20220421184213.tbglkeze22xrcmlq@moria.home.lan>
 <YmJhWNIcd5GcmKeo@dhcp22.suse.cz>
 <20220422083037.3pjdrusrn54fmfdf@moria.home.lan>
 <YmJ06cEyX2u4DGtD@dhcp22.suse.cz>
 <20220422094413.2i6dygfpul3toyqr@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422094413.2i6dygfpul3toyqr@moria.home.lan>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 22-04-22 05:44:13, Kent Overstreet wrote:
> On Fri, Apr 22, 2022 at 11:27:05AM +0200, Michal Hocko wrote:
> > We already do that in some form. We dump unreclaimable slabs if they
> > consume more memory than user pages on LRUs. We also dump all slab
> > caches with some objects. Why is this approach not good? Should we tweak
> > the condition to dump or should we limit the dump? These are reasonable 
> > questions to ask. Your patch has dropped those without explaining any
> > of the motivation.
> > 
> > I am perfectly OK to modify should_dump_unreclaim_slab to dump even if
> > the slab memory consumption is lower. Also dumping small caches with
> > handful of objects can be excessive.
> > 
> > Wrt to shrinkers I really do not know what kind of shrinkers data would
> > be useful to dump and when. Therefore I am asking about examples.
> 
> Look, I've given you the sample

That sample is of no use as it doesn't really show how the additional
information is useful to analyze the allocation failure. I thought we
have agreed on that. You still haven't given any example where the
information is useful. So I do not really see any reason to change the
existing output.

> output you asked for and explained repeatedly my
> rationale and you haven't directly responded;

Your rationale is that we need more data and I do agree but it is not
clear which data and under which conditions.

> if you have a reason you're
> against the patches please say so, but please give your reasoning.

I have expressed that already, I believe, but let me repeat. I do not
like altering the oom report without a justification on how this new
output is useful. You have failed to explained that so far.
-- 
Michal Hocko
SUSE Labs
