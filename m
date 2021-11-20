Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78B3C457BA1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Nov 2021 06:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhKTFKa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Nov 2021 00:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhKTFK3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Nov 2021 00:10:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7961C061574;
        Fri, 19 Nov 2021 21:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wEdJcEBDOS+GDmIXrr71fbDgTyZK1MYWQaHlEXJLZ+U=; b=RoCqii8SlnkIZCDsu35QUFgqso
        PITjNmL1dwlGuPu8CjvRwOJcy2m/hYeBGQfdpPfwnOqBiM2CswkijqY7kAw/lXx66QDDMKiFTAA88
        rdsZLxB0mnvU12IFq8dBzAZORSXWHwrgiIjX51ttJCkU9CfVxobWCFpWhqWUsfY4KredcvAvSnoBF
        tyQpEFdr/VabIfumYydXb3HHwsX1YzZRrGI36hvu8UjsOfEJ5Qhux0kZt22bAigzQUCZffDPTr2gl
        jryvet5ScyXeiNvk5C/OI4Xd1Jctu42+rwS4xxvuDYwTw6iQD02X1Utxx/E2/FSFl5aTisiwnSBT0
        Oj7d9Sug==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1moIao-00AF7t-6g; Sat, 20 Nov 2021 05:07:14 +0000
Date:   Sat, 20 Nov 2021 05:07:14 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Hugh Dickins <hughd@google.com>, Shuah Khan <shuah@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Roman Gushchin <guro@fb.com>, Theodore Ts'o <tytso@mit.edu>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v4 2/4] mm/oom: handle remote ooms
Message-ID: <YZiCgrTzcl/QQC+N@casper.infradead.org>
References: <20211120045011.3074840-1-almasrymina@google.com>
 <20211120045011.3074840-3-almasrymina@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211120045011.3074840-3-almasrymina@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 19, 2021 at 08:50:08PM -0800, Mina Almasry wrote:
> On remote ooms (OOMs due to remote charging), the oom-killer will attempt
> to find a task to kill in the memcg under oom. The oom-killer may be
> unable to find a process to kill if there are no killable processes in
> the remote memcg. In this case, the oom-killer (out_of_memory()) will return
> false, and depending on the gfp, that will generally get bubbled up to
> mem_cgroup_charge_mapping() as an ENOMEM.

Why doesn't it try to run the shrinkers to get back some page cache /
slab cache memory from this memcg?  I understand it might not be able
to (eg if the memory is mlocked), but surely that's rare.

