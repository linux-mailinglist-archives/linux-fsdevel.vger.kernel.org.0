Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD521D9AF6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 17:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbgESPQg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 11:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728847AbgESPQg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 11:16:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1A5C08C5C0;
        Tue, 19 May 2020 08:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AdOEDRxDGCk7juxgiVag4rwDu7GUxBm+spqJHfRFL34=; b=izuWj3PJVtncbaRo/nVgukcTqN
        gJwJsEpWDLAmFjONjk5zY/gtlAJc4LQm9DXzpQJLwO1mCvGwYQxXPWIj8i69WA7sfGGCr+zhJXznT
        O68emi4Dtzi7vm5WPUasi8WHHLxsGFKvU1iNuMrl5kdTerDlBClqUfV2kYbtMbEoXY/ltudMz9tW0
        La/sno1U4DOWwkJ2knHfns+oTvJxC43ChATw0NwycWOynhizKkhqX81z7XcKKWE7wjFse12SncBCT
        FxujU9PUiOCMGureSWUB9xVJ4qxJNyR8XiyBqvEuB7QFKnYBwUy2QS0ZkGqQKsPQ3bSoEKd1aw8ML
        EP05HoPQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jb3yq-0004DD-Ul; Tue, 19 May 2020 15:16:32 +0000
Date:   Tue, 19 May 2020 08:16:32 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Gao Xiang <hsiangkao@gmx.com>
Cc:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, david@fromorbit.com,
        hch@infradead.org
Subject: Re: [PATCH 10/10] mm/migrate.c: call detach_page_private to cleanup
 code
Message-ID: <20200519151632.GX16070@bombadil.infradead.org>
References: <20200517214718.468-1-guoqing.jiang@cloud.ionos.com>
 <20200517214718.468-11-guoqing.jiang@cloud.ionos.com>
 <20200518221235.1fa32c38e5766113f78e3f0d@linux-foundation.org>
 <aade5d75-c9e9-4021-6eb7-174a921a7958@cloud.ionos.com>
 <20200519100612.GA3687@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519100612.GA3687@hsiangkao-HP-ZHAN-66-Pro-G1>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 19, 2020 at 06:06:19PM +0800, Gao Xiang wrote:
> In addition, I found some limitation of new {attach,detach}_page_private
> helper (that is why I was interested in this series at that time [1] [2],
> but I gave up finally) since many patterns (not all) in EROFS are
> 
> io_submit (origin, page locked):
> attach_page_private(page);
> ...
> put_page(page);
> 
> end_io (page locked):
> SetPageUptodate(page);
> unlock_page(page);
> 
> since the page is always locked, so io_submit could be simplified as
> set_page_private(page, ...);
> SetPagePrivate(page);
> , which can save both one temporary get_page(page) and one
> put_page(page) since it could be regarded as safe with page locked.

It's fine to use page private like this without incrementing the refcount,
and I can't find any problematic cases in EROFS like those fixed by commit
8e47a457321ca1a74ad194ab5dcbca764bc70731

So I think the new helpers are not for you, and that's fine.  They'll be
useful for other filesystems which are using page_private differently
from the way that you do.
