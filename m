Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5731031D02D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 19:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbhBPSYM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 13:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhBPSYL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 13:24:11 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882E9C061574;
        Tue, 16 Feb 2021 10:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=v7reJc7owJgByy7BxY9foagf56Geahv9BK/jtA7FcW4=; b=T1w0z1MtJ3DTQt+fih9hSXxI2q
        lBlwnq22TihAW9jnXLU8eVOczWZTOv9CFjZ3j7Nb2cnzHR8ULzF3+6kCMq+vMhm8hAJbl0Cuu0uiL
        uqzdEGhbHLMTCxuzLxWlLXTzVoRYUhIvGI1GgfFFKb4n9p3WWy9Dhk8CC7vkj+uWWzWUs2PA6YumQ
        o6n5h6TkbmIoni0v+S1gaSupvP23+bV2JWBTb4FPDbTLmDQfGgCc1FFs6RWIunvhp7/jxkiGTcFJ5
        d+oBUbDFXxLnMXGHa3UH/LLIGUTpmaEWLN4U1q+NdbIToJ9MQim3zz4UdA9cMhAUsCbsIRsppuflf
        WUwgHZ+w==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lC4zi-00H9aV-GT; Tue, 16 Feb 2021 18:22:49 +0000
Date:   Tue, 16 Feb 2021 18:22:42 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, cgoldswo@codeaurora.org,
        linux-fsdevel@vger.kernel.org, mhocko@suse.com, david@redhat.com,
        vbabka@suse.cz, viro@zeniv.linux.org.uk, joaodias@google.com
Subject: Re: [RFC 1/2] mm: disable LRU pagevec during the migration
 temporarily
Message-ID: <20210216182242.GJ2858050@casper.infradead.org>
References: <20210216170348.1513483-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210216170348.1513483-1-minchan@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 16, 2021 at 09:03:47AM -0800, Minchan Kim wrote:
> LRU pagevec holds refcount of pages until the pagevec are drained.
> It could prevent migration since the refcount of the page is greater
> than the expection in migration logic. To mitigate the issue,
> callers of migrate_pages drains LRU pagevec via migrate_prep or
> lru_add_drain_all before migrate_pages call.
> 
> However, it's not enough because pages coming into pagevec after the
> draining call still could stay at the pagevec so it could keep
> preventing page migration. Since some callers of migrate_pages have
> retrial logic with LRU draining, the page would migrate at next trail
> but it is still fragile in that it doesn't close the fundamental race
> between upcoming LRU pages into pagvec and migration so the migration
> failure could cause contiguous memory allocation failure in the end.

Have you been able to gather any numbers on this?  eg does migration
now succeed 5% more often?
