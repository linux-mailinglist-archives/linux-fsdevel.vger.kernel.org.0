Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B343E54681F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jun 2022 16:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245530AbiFJOQs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jun 2022 10:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237558AbiFJOQr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jun 2022 10:16:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD42328EFF;
        Fri, 10 Jun 2022 07:16:45 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5C5FC22145;
        Fri, 10 Jun 2022 14:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654870604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5V1brKH3JxuGnK163MHstZIpkveguOsr+QIbT4bxCoY=;
        b=NyQNSqMm7QuDHvrEU7zuZC0pzUg2RGEV/QNqY2FnmYqan0ThFcYQF/yJNBDlgKMUs+JA5d
        0hIV8Eu1swzN5Qwl5Xkh9vy9jDc+jPIi1n9iq/2DomdScT+6hntA5YYLmINM3Q6MEVANUE
        rn3CgbId4neVU+zayaDyRfjkmdDG7pg=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id F0BE42C141;
        Fri, 10 Jun 2022 14:16:43 +0000 (UTC)
Date:   Fri, 10 Jun 2022 16:16:40 +0200
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
Message-ID: <YqNSSFQELx/LeEHR@dhcp22.suse.cz>
References: <YqG67sox6L64E6wV@dhcp22.suse.cz>
 <77b99722-fc13-e5c5-c9be-7d4f3830859c@amd.com>
 <YqHuH5brYFQUfW8l@dhcp22.suse.cz>
 <26d3e1c7-d73c-cc95-54ef-58b2c9055f0c@gmail.com>
 <YqIB0bavUeU8Abwl@dhcp22.suse.cz>
 <d4a19481-7a9f-19bf-c270-d89baa0970fc@amd.com>
 <YqIMmK18mb/+s5de@dhcp22.suse.cz>
 <3f7d3d96-0858-fb6d-07a3-4c18964f888e@gmail.com>
 <YqMuq/ZrV8loC3jE@dhcp22.suse.cz>
 <2e7e050e-04eb-0c0a-0675-d7f1c3ae7aed@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e7e050e-04eb-0c0a-0675-d7f1c3ae7aed@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 10-06-22 14:17:27, Christian König wrote:
> Am 10.06.22 um 13:44 schrieb Michal Hocko:
> > On Fri 10-06-22 12:58:53, Christian König wrote:
> > [SNIP]
> > > > I do realize this is a long term problem and there is a demand for some
> > > > solution at least. I am not sure how to deal with shared resources
> > > > myself. The best approximation I can come up with is to limit the scope
> > > > of the damage into a memcg context. One idea I was playing with (but
> > > > never convinced myself it is really a worth) is to allow a new mode of
> > > > the oom victim selection for the global oom event.
> > And just for the clarity. I have mentioned global oom event here but the
> > concept could be extended to per-memcg oom killer as well.
> 
> Then what exactly do you mean with "limiting the scope of the damage"? Cause
> that doesn't make sense without memcg.

What I meant to say is to use the scheme of the damage control
not only to the global oom situation (on the global shortage of memory)
but also to the memcg oom situation (when the hard limit on a hierarchy
is reached).

[...]
> > The primary question is whether it actually helps much or what kind of
> > scenarios it can help with and whether we can actually do better for
> > those.
> 
> Well, it does help massively with a standard Linux desktop and GPU workloads
> (e.g. games).
> 
> See what currently happens is that when games allocate for example textures
> the memory for that is not accounted against that game. Instead it's usually
> the display server (X or Wayland) which most of the shared resources
> accounts to because it needs to compose a desktop from it and usually also
> mmaps it for fallback CPU operations.

Let me try to understand some more. So the game (or the entity to be
responsible for the resource) doesn't really allocate the memory but it
relies on somebody else (from memcg perspective living in a different
resource domain - i.e. a different memcg) to do that on its behalf.
Correct? If that is the case then that is certainly not fitting into the
memcg model then.
I am not really sure there is any reasonable model where you cannot
really tell who is responsible for the resource.

> So what happens when a games over allocates texture resources is that your
> whole desktop restarts because the compositor is killed. This obviously also
> kills the game, but it would be much nice if we would be more selective
> here.
> 
> For hardware rendering DMA-buf and GPU drivers are used, but for the
> software fallback shmem files is what is used under the hood as far as I
> know. And the underlying problem is the same for both.

For shmem files the end user of the buffer can preallocate and so own
the buffer and be accounted for it.
> 
> > Also do not forget that shared file memory is not the only thing
> > to care about. What about the kernel memory used on behalf of processes?
> 
> Yeah, I'm aware of that as well. But at least inside the GPU drivers we try
> to keep that in a reasonable ratio.
> 
> > Just consider the above mentioned memcg driven model. It doesn't really
> > require to chase specific files and do some arbitrary math to share the
> > responsibility. It has a clear accounting and responsibility model.
> 
> Ok, how does that work then?

The memory is accounted to whoever faults that memory in or to the
allocating context if that is a kernel memory (in most situations).
-- 
Michal Hocko
SUSE Labs
