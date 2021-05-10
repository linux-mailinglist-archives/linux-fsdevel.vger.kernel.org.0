Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4504B37797F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 May 2021 02:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhEJASy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 May 2021 20:18:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:42956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229853AbhEJASy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 May 2021 20:18:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C262A610CC;
        Mon, 10 May 2021 00:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1620605869;
        bh=i+YJLqFNH50CIrJgOP6blmezF+nf9yUjSX5iWGJKM1c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Cc2LoCTnOfNVzw8V4AFywY6mT9DyhBwsacADhMkAGYrceCN6/6xJcTs4cM7y3O8RQ
         pFtZ72D7/rz7oTpSSWElYfFWY6bnDgtSTBWVULYyVHhArMrK8HbWjm6BRq61V5B0Ad
         tEW8mJ39FHtXFK3vcD4J1ZJTIdC19DfRbHMxi6t0=
Date:   Sun, 9 May 2021 17:17:48 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     chukaiping <chukaiping@baidu.com>
Cc:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        vbabka@suse.cz, nigupta@nvidia.com, bhe@redhat.com,
        khalid.aziz@oracle.com, iamjoonsoo.kim@lge.com,
        mateusznosek0@gmail.com, sh_def@163.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Mel Gorman <mgorman@techsingularity.net>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v4] mm/compaction: let proactive compaction order
 configurable
Message-Id: <20210509171748.8dbc70ceccc5cc1ae61fe41c@linux-foundation.org>
In-Reply-To: <1619576901-9531-1-git-send-email-chukaiping@baidu.com>
References: <1619576901-9531-1-git-send-email-chukaiping@baidu.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 28 Apr 2021 10:28:21 +0800 chukaiping <chukaiping@baidu.com> wrote:

> Currently the proactive compaction order is fixed to
> COMPACTION_HPAGE_ORDER(9), it's OK in most machines with lots of
> normal 4KB memory, but it's too high for the machines with small
> normal memory, for example the machines with most memory configured
> as 1GB hugetlbfs huge pages. In these machines the max order of
> free pages is often below 9, and it's always below 9 even with hard
> compaction. This will lead to proactive compaction be triggered very
> frequently. In these machines we only care about order of 3 or 4.
> This patch export the oder to proc and let it configurable
> by user, and the default value is still COMPACTION_HPAGE_ORDER.

It would be great to do this automatically?  It's quite simple to see
when memory is being handed out to hugetlbfs - so can we tune
proactive_compaction_order in response to this?  That would be far
better than adding a manual tunable.

But from having read Khalid's comments, that does sound quite involved.
Is there some partial solution that we can come up with that will get
most people out of trouble?

That being said, this patch is super-super-simple so perhaps we should
just merge it just to get one person (and hopefully a few more) out of
trouble.  But on the other hand, once we add a /proc tunable we must
maintain that tunable for ever (or at least a very long time) even if
the internal implementations change a lot.
