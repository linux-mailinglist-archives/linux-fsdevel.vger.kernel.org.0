Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 495C9356B91
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 13:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233814AbhDGLy7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 07:54:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:37682 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230280AbhDGLy7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 07:54:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617796489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ddpRdKT9wYCe24wptl48nZTWB76xl1PPFUiBI9ZFlHc=;
        b=QFoOzYFZ0klurN8wSeF86h+RI9rN+UuqSPcBbyy8RJng6XIlHnfWMeTHox7cZfeZt+C5up
        IdTrJTby1hXTKYzqoM9y5QoZmFJlJcg+lUTdDJxia8mjFwD9liJruBWN6bdZk+jFuCcG3f
        0eAeBs4xLCWH7V9RTPR8x4Ev4k5H4Ik=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E116FB12B;
        Wed,  7 Apr 2021 11:54:48 +0000 (UTC)
Date:   Wed, 7 Apr 2021 13:54:48 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Bharata B Rao <bharata@linux.ibm.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        aneesh.kumar@linux.ibm.com
Subject: Re: High kmalloc-32 slab cache consumption with 10k containers
Message-ID: <YG2diKMPNSK2cMyG@dhcp22.suse.cz>
References: <20210405054848.GA1077931@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210405054848.GA1077931@in.ibm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 05-04-21 11:18:48, Bharata B Rao wrote:
> Hi,
> 
> When running 10000 (more-or-less-empty-)containers on a bare-metal Power9
> server(160 CPUs, 2 NUMA nodes, 256G memory), it is seen that memory
> consumption increases quite a lot (around 172G) when the containers are
> running. Most of it comes from slab (149G) and within slab, the majority of
> it comes from kmalloc-32 cache (102G)

Is this 10k cgroups a testing enviroment or does anybody really use that
in production? I would be really curious to hear how that behaves when
those containers are not idle. E.g. global memory reclaim iterating over
10k memcgs will likely be very visible. I do remember playing with
similar setups few years back and the overhead was very high.
-- 
Michal Hocko
SUSE Labs
