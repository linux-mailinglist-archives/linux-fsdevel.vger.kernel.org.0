Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEC75480C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jun 2022 09:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237225AbiFMHpH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 03:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbiFMHpG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 03:45:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74079BC03;
        Mon, 13 Jun 2022 00:45:05 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2E50D21A93;
        Mon, 13 Jun 2022 07:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655106304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5WMle8KoXV0j63rwJ5QZ4pysRjmykK+gll6/m96aiCQ=;
        b=FuLo+VOBBkI+oWNStM4seHkoiyK0Hr+aHMOvDiwt9GGELjWedVV4eVmmgJbe872jPvORqJ
        Vc5aqY4498GBGJEsynJOBtP7uacBYTxS6Qceg9YAfnVQkKLxppmCRYRI6VnRd0Ehidw6e7
        VkwY4jb2uXaKjgqii9bZJVgtGLmxSos=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B0E0C2C141;
        Mon, 13 Jun 2022 07:45:03 +0000 (UTC)
Date:   Mon, 13 Jun 2022 09:45:01 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>
Cc:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        alexander.deucher@amd.com, daniel@ffwll.ch,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        hughd@google.com, andrey.grodzovsky@amd.com
Subject: Re: [PATCH 03/13] mm: shmem: provide oom badness for shmem files
Message-ID: <Yqbq/Q5jz2ou87Jx@dhcp22.suse.cz>
References: <YqHuH5brYFQUfW8l@dhcp22.suse.cz>
 <26d3e1c7-d73c-cc95-54ef-58b2c9055f0c@gmail.com>
 <YqIB0bavUeU8Abwl@dhcp22.suse.cz>
 <d4a19481-7a9f-19bf-c270-d89baa0970fc@amd.com>
 <YqIMmK18mb/+s5de@dhcp22.suse.cz>
 <3f7d3d96-0858-fb6d-07a3-4c18964f888e@gmail.com>
 <YqMuq/ZrV8loC3jE@dhcp22.suse.cz>
 <2e7e050e-04eb-0c0a-0675-d7f1c3ae7aed@amd.com>
 <YqNSSFQELx/LeEHR@dhcp22.suse.cz>
 <288528c3-411e-fb25-2f08-92d4bb9f1f13@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <288528c3-411e-fb25-2f08-92d4bb9f1f13@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 11-06-22 10:06:18, Christian König wrote:
> Am 10.06.22 um 16:16 schrieb Michal Hocko:
[...]
> > > So what happens when a games over allocates texture resources is that your
> > > whole desktop restarts because the compositor is killed. This obviously also
> > > kills the game, but it would be much nice if we would be more selective
> > > here.
> > > 
> > > For hardware rendering DMA-buf and GPU drivers are used, but for the
> > > software fallback shmem files is what is used under the hood as far as I
> > > know. And the underlying problem is the same for both.
> > For shmem files the end user of the buffer can preallocate and so own
> > the buffer and be accounted for it.
> 
> The problem is just that it can easily happen that one process is allocating
> the resource and a different one freeing it.
> 
> So just imaging the following example: Process opens X window, get reference
> to the handle of the buffer backing this window for drawing, tells X to
> close the window again and then a bit later closes the buffer handle.
> 
> In this example the X server would be charged allocating the buffer and the
> client (which is most likely in a different memcg group) is charged freeing
> it.

Thanks for the clarification.

> I could of course add something to struct page to track which memcg (or
> process) it was charged against, but extending struct page is most likely a
> no-go.

Struct page already maintains is memcg. The one which has charged it and
it will stay constatnt throughout of the allocation lifetime (cgroup v1
has a concept of the charge migration but this hasn't been adopted in
v2).

We have a concept of active_memcg which allows to charge against a
different memcg than the allocating context. From your example above I
do not think this is really usable for the described usecase as the X is
not aware where the request comes from?

> Alternative I could try to track the "owner" of a buffer (e.g. a shmem
> file), but then it can happen that one processes creates the object and
> another one is writing to it and actually allocating the memory.

If you can enforce that the owner is really responsible for the
allocation then all should be fine. That would require MAP_POPULATE like
semantic and I suspect this is not really feasible with the existing
userspace. It would be certainly hard to enforce for bad players.
-- 
Michal Hocko
SUSE Labs
