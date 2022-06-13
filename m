Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF71548F7D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jun 2022 18:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386415AbiFMPF5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 11:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386392AbiFMPFg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 11:05:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4ACF7499;
        Mon, 13 Jun 2022 05:11:25 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id ED1C71F38A;
        Mon, 13 Jun 2022 12:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655122279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cWi4yPYQYuWcLCZhlzRL/FUwfVjRk7PfFZtsphXFstQ=;
        b=fWc9Ypl2KcwfmmeUMR5vxJsHU3nImiAo3Pbtm/FripjpX/mp8Fjs3Rh1gZ6Tn3ex0cZ3W+
        0OvfKRLBxncV3yGLDHAgrGqvdZlefo3rLxodVymu5Y4osdFhZqLOhmsWXnI11DWNlx/VZ0
        h9lRYJlBhcSh3hyTWiqlBbym/yTUmaw=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 66AB32C141;
        Mon, 13 Jun 2022 12:11:18 +0000 (UTC)
Date:   Mon, 13 Jun 2022 14:11:17 +0200
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
Message-ID: <YqcpZY3Xx7Mk2ROH@dhcp22.suse.cz>
References: <YqIB0bavUeU8Abwl@dhcp22.suse.cz>
 <d4a19481-7a9f-19bf-c270-d89baa0970fc@amd.com>
 <YqIMmK18mb/+s5de@dhcp22.suse.cz>
 <3f7d3d96-0858-fb6d-07a3-4c18964f888e@gmail.com>
 <YqMuq/ZrV8loC3jE@dhcp22.suse.cz>
 <2e7e050e-04eb-0c0a-0675-d7f1c3ae7aed@amd.com>
 <YqNSSFQELx/LeEHR@dhcp22.suse.cz>
 <288528c3-411e-fb25-2f08-92d4bb9f1f13@gmail.com>
 <Yqbq/Q5jz2ou87Jx@dhcp22.suse.cz>
 <b8b9aba5-575e-8a34-e627-79bef4ed7f97@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b8b9aba5-575e-8a34-e627-79bef4ed7f97@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 13-06-22 13:50:28, Christian König wrote:
> Am 13.06.22 um 09:45 schrieb Michal Hocko:
> > On Sat 11-06-22 10:06:18, Christian König wrote:
> > > Am 10.06.22 um 16:16 schrieb Michal Hocko:
[...]
> > > Alternative I could try to track the "owner" of a buffer (e.g. a shmem
> > > file), but then it can happen that one processes creates the object and
> > > another one is writing to it and actually allocating the memory.
> > If you can enforce that the owner is really responsible for the
> > allocation then all should be fine. That would require MAP_POPULATE like
> > semantic and I suspect this is not really feasible with the existing
> > userspace. It would be certainly hard to enforce for bad players.
> 
> I've tried this today and the result was: "BUG: Bad rss-counter state
> mm:000000008751d9ff type:MM_FILEPAGES val:-571286".
> 
> The problem is once more that files are not informed when the process
> clones. So what happened is that somebody called fork() with an mm_struct
> I've accounted my pages to. The result is just that we messed up the
> rss_stats and  the the "BUG..." above.
> 
> The key difference between normal allocated pages and the resources here is
> just that we are not bound to an mm_struct in any way.

It is not really clear to me what exactly you have tried.
-- 
Michal Hocko
SUSE Labs
