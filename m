Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1F345E0F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Nov 2021 20:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349818AbhKYT3S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Nov 2021 14:29:18 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:49406 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349959AbhKYT1R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Nov 2021 14:27:17 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 059F221891;
        Thu, 25 Nov 2021 19:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637868245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zeEh+Mnsqm3keavvrhJXx22I1VEL7us1czf+Y+aaH7I=;
        b=OrPZ9cXgr+eP5+r1Hg6nneERBtX3GXPaHmqDh8O4Sx1tert8at9JAoXCKg4qAumtSxKFjL
        NRQdqU/et+BzzZ2FvhNWOpLZDpmpu3xRhPcUHrmgOMzzdHF5Bf47WU8r0Aee125c/84etf
        A4rb0kBzALs1hgTa3KrpWoA59sR2Oi4=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C6A20A3B81;
        Thu, 25 Nov 2021 19:24:04 +0000 (UTC)
Date:   Thu, 25 Nov 2021 20:24:04 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>, Neil Brown <neilb@suse.de>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v2 2/4] mm/vmalloc: add support for __GFP_NOFAIL
Message-ID: <YZ/i1Dww6rUTyIdD@dhcp22.suse.cz>
References: <20211122153233.9924-1-mhocko@kernel.org>
 <20211122153233.9924-3-mhocko@kernel.org>
 <YZ06nna7RirAI+vJ@pc638.lan>
 <20211123170238.f0f780ddb800f1316397f97c@linux-foundation.org>
 <YZ6cfoQah8Wo1eSZ@pc638.lan>
 <YZ9Nb2XA/OGWL1zz@dhcp22.suse.cz>
 <CA+KHdyUFjqdhkZdTH=4k=ZQdKWs8MauN1NjXXwDH6J=YDuFOPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+KHdyUFjqdhkZdTH=4k=ZQdKWs8MauN1NjXXwDH6J=YDuFOPA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 25-11-21 19:02:09, Uladzislau Rezki wrote:
[...]
> Therefore i root for simplification and OOM related concerns :) But
> maybe there will be other opinions.

I have to say that I disagree with your view. I am not sure we have
other precedence where an allocator would throw away the primary
allocation just because a metadata allocation failure.

In any case, if there is a wider consensus that we really want to do
that I can rework. I would prefer to keep the patch as is though.
-- 
Michal Hocko
SUSE Labs
